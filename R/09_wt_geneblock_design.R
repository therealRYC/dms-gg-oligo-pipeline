# 09_wt_geneblock_design.R — Design WT gene blocks for 3-enzyme Golden Gate assembly
# DMS Golden Gate Oligo Pipeline
#
# In the 3-enzyme architecture:
# - BsaI (Level 1): inserts oligo + 5'WT blocks into helper plasmid
# - BsmBI (Level 1b): inserts 3'WT+PolIII blocks between tile and barcode
# - PaqCI (Level 2): moves complete insert to destination backbone
#
# For each tile, the assembly requires:
#   BsaI reaction: oligo + 5'WT gene block(s) → helper plasmid
#   BsmBI reaction: 3'WT+PolIII gene block(s) → between tile and barcode
#
# Gene blocks are categorized as:
#   - bsai_block: 5'WT segment flanked by BsaI sites (for Level 1)
#   - bsmbi_block: 3'WT+PolIII segment flanked by BsmBI sites (for Level 1b)
#   - Interior superblocks at tile boundaries need both BsaI and BsmBI versions

#' Design all WT gene blocks for 3-enzyme assembly
#'
#' @param cds Character string of domesticated CDS
#' @param polIII Character string of PolIII promoter sequence
#' @param tiles Data frame from partition_tiles()
#' @param tile_overhangs Data frame from extract_tile_overhangs()
#' @param oh3 Fixed BsmBI overhang (PolIII-barcode junction)
#' @param oh4 Fixed BsaI overhang (barcode-helper junction)
#' @param paqci_star2 PaqCI** overhang (5' end of insert in helper plasmid)
#' @param paqci_star1 PaqCI* overhang (3' end of insert)
#' @param superblock_boundaries Data frame from compute_superblock_boundaries()
#' @param max_block_length Maximum gene block synthesis length (default 1800)
#' @param fidelity_threshold Overhang fidelity threshold for superblock splitting
#' @return List with:
#'   - blocks: data frame of gene blocks to order (deduplicated)
#'   - tile_manifests: data frame describing per-tile reaction contents
#'   - helper_plasmid: data frame describing helper plasmid insert
design_wt_geneblocks <- function(cds, polIII, tiles, tile_overhangs,
                                  oh3, oh4, paqci_star2, paqci_star1,
                                  superblock_boundaries = NULL,
                                  max_block_length = MAX_GENEBLOCK_LENGTH,
                                  fidelity_threshold = DEFAULT_FIDELITY_THRESHOLD) {

  n_tiles <- nrow(tiles)
  gene_len <- nchar(cds)
  blocks <- list()
  manifests <- list()

  if (is.null(superblock_boundaries)) {
    superblock_boundaries <- data.frame(
      boundary_id = integer(0), after_tile_id = integer(0),
      junction_nt = integer(0), junction_oh = character(0),
      fidelity_score = numeric(0), stringsAsFactors = FALSE
    )
  }

  for (i in seq_len(n_tiles)) {
    tile <- tiles[i, ]
    tile_oh <- tile_overhangs[tile_overhangs$tile_id == tile$tile_id, ]

    # --- BsaI blocks: 5'WT gene segments ---
    # The 5'WT region runs from gene start (or last superblock boundary) to this tile's oh1
    # For the first tile, the 5'WT is empty (oligo carries PaqCI** directly via oh_L)
    bsai_parts <- character(0)

    if (tile$start_nt > 1L) {
      # There is 5'WT sequence before this tile
      wt_5prime_start <- 1L
      wt_5prime_end <- tile$start_nt - 1L

      # Find superblock boundaries within this 5'WT region
      sb_in_region <- superblock_boundaries[
        superblock_boundaries$junction_nt >= wt_5prime_start &
        superblock_boundaries$junction_nt <= wt_5prime_end, , drop = FALSE
      ]

      if (nrow(sb_in_region) == 0) {
        # Single 5'WT block
        wt_5prime_seq <- substring(cds, wt_5prime_start, wt_5prime_end)
        block_name <- paste0("bsai_5wt_tile", tile$tile_id)

        # 5' end: oh_L overhang (first 4nt of gene for first superblock,
        #         or superblock junction oh for subsequent)
        oh_5 <- substring(cds, wt_5prime_start, wt_5prime_start + 3L)
        # 3' end: oh1 of this tile
        oh_3 <- tile$oh1_seq

        block_seq <- create_bsai_block(wt_5prime_seq, oh_5, oh_3)

        blocks[[length(blocks) + 1]] <- data.frame(
          block_name = block_name, sequence = block_seq,
          length = nchar(block_seq), enzyme_type = "BsaI",
          gene_region = paste0("5wt_tile", tile$tile_id),
          stringsAsFactors = FALSE
        )
        bsai_parts <- block_name
      } else {
        # Split into superblocks at boundaries
        split_points <- c(wt_5prime_start - 1L, sb_in_region$junction_nt, wt_5prime_end)
        for (s in seq_len(length(split_points) - 1L)) {
          sub_start <- split_points[s] + 1L
          sub_end <- split_points[s + 1L]
          sub_seq <- substring(cds, sub_start, sub_end)
          block_name <- paste0("bsai_5wt_tile", tile$tile_id, "_sub", s)

          oh_5 <- substring(cds, sub_start, sub_start + 3L)
          oh_3 <- if (s < length(split_points) - 1L) {
            sb_in_region$junction_oh[s]
          } else {
            tile$oh1_seq
          }

          block_seq <- create_bsai_block(sub_seq, oh_5, oh_3)

          blocks[[length(blocks) + 1]] <- data.frame(
            block_name = block_name, sequence = block_seq,
            length = nchar(block_seq), enzyme_type = "BsaI",
            gene_region = paste0("5wt_tile", tile$tile_id, "_sub", s),
            stringsAsFactors = FALSE
          )
          bsai_parts <- c(bsai_parts, block_name)
        }
      }
    }

    # --- BsmBI blocks: 3'WT + PolIII segments ---
    # The 3'WT region runs from this tile's oh2 to gene end (or next superblock boundary)
    # PolIII is appended to the last 3'WT block
    bsmbi_parts <- character(0)

    wt_3prime_start <- tile$end_nt + 1L
    wt_3prime_end <- gene_len

    if (wt_3prime_start <= gene_len) {
      # There is 3'WT sequence after this tile
      wt_3prime_seq <- substring(cds, wt_3prime_start, wt_3prime_end)

      # The last block in the BsmBI reaction carries PolIII appended
      block_name <- paste0("bsmbi_3wt_tile", tile$tile_id)

      oh_5 <- tile$oh2_seq  # BsmBI overhang at tile-3'WT junction
      oh_3 <- oh3           # Fixed BsmBI overhang at PolIII-barcode junction

      block_seq <- create_bsmbi_block(paste0(wt_3prime_seq, polIII), oh_5, oh_3)

      blocks[[length(blocks) + 1]] <- data.frame(
        block_name = block_name, sequence = block_seq,
        length = nchar(block_seq), enzyme_type = "BsmBI",
        gene_region = paste0("3wt_polIII_tile", tile$tile_id),
        stringsAsFactors = FALSE
      )
      bsmbi_parts <- block_name
    } else {
      # This is the last tile — only PolIII fragment
      block_name <- paste0("bsmbi_polIII_tile", tile$tile_id)

      oh_5 <- tile$oh2_seq
      oh_3 <- oh3

      block_seq <- create_bsmbi_block(polIII, oh_5, oh_3)

      blocks[[length(blocks) + 1]] <- data.frame(
        block_name = block_name, sequence = block_seq,
        length = nchar(block_seq), enzyme_type = "BsmBI",
        gene_region = paste0("polIII_tile", tile$tile_id),
        stringsAsFactors = FALSE
      )
      bsmbi_parts <- block_name
    }

    # Record manifest for this tile
    manifests[[length(manifests) + 1]] <- data.frame(
      tile_id = tile$tile_id,
      bsai_parts = paste(bsai_parts, collapse = ";"),
      bsmbi_parts = paste(bsmbi_parts, collapse = ";"),
      stringsAsFactors = FALSE
    )
  }

  # Combine all blocks
  all_blocks <- do.call(rbind, blocks)
  rownames(all_blocks) <- NULL

  # Deduplicate (same sequence used by multiple tiles)
  all_blocks <- deduplicate_blocks(all_blocks)

  # Combine manifests
  all_manifests <- do.call(rbind, manifests)
  rownames(all_manifests) <- NULL

  # Design helper plasmid insert
  oh_L <- substring(cds, 1, 4)  # First 4 nt of gene
  helper <- design_helper_plasmid(oh_L, oh4, paqci_star2, paqci_star1)

  # Check block lengths
  over_limit <- all_blocks$length > max_block_length
  if (any(over_limit)) {
    cli::cli_alert_warning(paste0(
      sum(over_limit), " block(s) exceed ", max_block_length,
      " nt synthesis limit. Applying superblock splitting..."
    ))
    all_blocks <- apply_superblock_splitting(
      all_blocks, cds, polIII, oh3, max_block_length, fidelity_threshold
    )
  } else {
    cli::cli_alert_success(paste0(
      "All ", nrow(all_blocks), " gene blocks within synthesis limit. ",
      "Range: ", min(all_blocks$length), "-", max(all_blocks$length), " nt."
    ))
  }

  list(
    blocks = all_blocks,
    tile_manifests = all_manifests,
    helper_plasmid = helper
  )
}

#' Create a BsaI-flanked gene block
#'
#' Structure: BsaI_fwd + oh_5prime + [gene_seq] + oh_3prime + BsaI_rev
#' The oh_5prime and oh_3prime are already part of gene_seq (first/last 4nt)
#' so we just add the enzyme recognition sites.
#'
#' @param gene_seq WT gene sequence for this block
#' @param oh_5prime 4-nt overhang at 5' end
#' @param oh_3prime 4-nt overhang at 3' end
#' @return Complete block sequence with flanking BsaI sites
create_bsai_block <- function(gene_seq, oh_5prime, oh_3prime) {
  bsai_fwd <- orient_enzyme_site("BsaI", oh_5prime, "forward")
  bsai_rev <- orient_enzyme_site("BsaI", oh_3prime, "reverse")
  paste0(bsai_fwd, gene_seq, bsai_rev)
}

#' Create a BsmBI-flanked gene block
#'
#' Structure: BsmBI_fwd + oh_5prime + [gene_seq] + oh_3prime + BsmBI_rev
#'
#' @param gene_seq WT gene sequence for this block (may include PolIII)
#' @param oh_5prime 4-nt overhang at 5' end
#' @param oh_3prime 4-nt overhang at 3' end
#' @return Complete block sequence with flanking BsmBI sites
create_bsmbi_block <- function(gene_seq, oh_5prime, oh_3prime) {
  bsmbi_fwd <- orient_enzyme_site("BsmBI", oh_5prime, "forward")
  bsmbi_rev <- orient_enzyme_site("BsmBI", oh_3prime, "reverse")
  paste0(bsmbi_fwd, gene_seq, bsmbi_rev)
}

#' Design helper plasmid insert sequence
#'
#' The helper plasmid provides the backbone for the BsaI Level 1 reaction.
#' Structure: PaqCI**(fwd) + BsaI_fwd(oh_L) + [stuffer] + BsaI_rev(oh_R) + PaqCI*(rev)
#'
#' The stuffer is replaced by the oligo + gene block products during BsaI assembly.
#' oh_L = first 4 nt of gene, oh_R = oh4 (fixed barcode-helper junction)
#'
#' @param oh_L 4-nt overhang at gene start (= first 4 nt of gene)
#' @param oh_R 4-nt overhang at barcode-helper junction (= oh4)
#' @param paqci_star2 PaqCI** overhang (5' end of insert)
#' @param paqci_star1 PaqCI* overhang (3' end of insert)
#' @return Data frame with helper plasmid info
design_helper_plasmid <- function(oh_L, oh_R, paqci_star2, paqci_star1) {
  # PaqCI sites flanking the entire insert
  paqci_fwd <- orient_enzyme_site("PaqCI", paqci_star2, "forward")
  paqci_rev <- orient_enzyme_site("PaqCI", paqci_star1, "reverse")

  # BsaI sites for the stuffer/insert boundary
  bsai_fwd <- orient_enzyme_site("BsaI", oh_L, "forward")
  bsai_rev <- orient_enzyme_site("BsaI", oh_R, "reverse")

  # Stuffer = placeholder replaced during assembly (use a short dummy for ordering)
  stuffer <- "NNNNNNNNNNNNNNNNNNNN"  # 20 nt placeholder

  helper_seq <- paste0(paqci_fwd, bsai_fwd, stuffer, bsai_rev, paqci_rev)

  cli::cli_alert_success(paste0(
    "Helper plasmid insert designed: oh_L=", oh_L, ", oh_R=", oh_R,
    " (", nchar(helper_seq), " nt)"
  ))

  data.frame(
    component = "helper_plasmid_insert",
    sequence = helper_seq,
    length = nchar(helper_seq),
    oh_L = oh_L,
    oh_R = oh_R,
    paqci_star2 = paqci_star2,
    paqci_star1 = paqci_star1,
    stringsAsFactors = FALSE
  )
}

#' Deduplicate gene blocks with identical sequences
#'
#' Blocks used by multiple tiles are synthesized once. Updates gene_region
#' to list all associated tiles.
#'
#' @param blocks Data frame of gene blocks
#' @return Deduplicated data frame
deduplicate_blocks <- function(blocks) {
  if (nrow(blocks) == 0) return(blocks)

  # Group by sequence
  unique_seqs <- unique(blocks$sequence)
  deduped <- list()

  for (seq in unique_seqs) {
    matching <- blocks[blocks$sequence == seq, , drop = FALSE]
    first <- matching[1, ]
    if (nrow(matching) > 1) {
      first$gene_region <- paste(matching$gene_region, collapse = ";")
    }
    deduped[[length(deduped) + 1]] <- first
  }

  result <- do.call(rbind, deduped)
  rownames(result) <- NULL

  n_removed <- nrow(blocks) - nrow(result)
  if (n_removed > 0) {
    cli::cli_alert_info(paste0(
      "Deduplicated blocks: ", nrow(blocks), " -> ", nrow(result),
      " (", n_removed, " duplicates removed)"
    ))
  }

  result
}

#' Split oversized gene blocks into superblocks
#'
#' @param blocks Data frame of gene blocks
#' @param cds Domesticated CDS
#' @param polIII PolIII promoter
#' @param oh3 Fixed BsmBI overhang
#' @param max_block_length Max synthesis length
#' @param fidelity_threshold Overhang fidelity threshold
#' @return Updated blocks data frame with oversized blocks split
apply_superblock_splitting <- function(blocks, cds, polIII, oh3,
                                        max_block_length, fidelity_threshold) {
  new_blocks <- list()

  # Collect all existing overhangs for exclusion
  existing_ohs <- character(0)

  for (i in seq_len(nrow(blocks))) {
    block <- blocks[i, ]

    if (block$length <= max_block_length) {
      new_blocks[[length(new_blocks) + 1]] <- block
      next
    }

    # Calculate number of sub-blocks needed
    enzyme_site_len <- 11L  # BsaI or BsmBI site
    n_subblocks <- ceiling(block$length / (max_block_length - 2 * enzyme_site_len))

    # Select junction overhangs
    n_junctions <- n_subblocks - 1L
    junction_ohs <- select_superblock_overhangs(
      cds, polIII,
      c(existing_ohs, oh3),
      n_junctions, fidelity_threshold
    )
    existing_ohs <- c(existing_ohs, junction_ohs)

    # Split the block
    seq_content <- block$sequence
    sub_length <- ceiling(nchar(seq_content) / n_subblocks)
    sub_length <- (sub_length %/% 3L) * 3L

    enzyme_name <- if (block$enzyme_type == "BsaI") "BsaI" else "BsmBI"

    for (j in seq_len(n_subblocks)) {
      start <- (j - 1) * sub_length + 1
      end <- min(j * sub_length, nchar(seq_content))
      if (j == n_subblocks) end <- nchar(seq_content)

      sub_seq <- substring(seq_content, start, end)

      # Add junction enzyme sites
      if (j > 1) {
        sub_seq <- paste0(
          orient_enzyme_site(enzyme_name, junction_ohs[j - 1], "forward"),
          sub_seq
        )
      }
      if (j < n_subblocks) {
        sub_seq <- paste0(
          sub_seq,
          orient_enzyme_site(enzyme_name, junction_ohs[j], "reverse")
        )
      }

      new_blocks[[length(new_blocks) + 1]] <- data.frame(
        block_name = paste0(block$block_name, "_sub", j),
        sequence = sub_seq,
        length = nchar(sub_seq),
        enzyme_type = block$enzyme_type,
        gene_region = paste0(block$gene_region, "_sub", j),
        stringsAsFactors = FALSE
      )
    }

    cli::cli_alert_info(paste0(
      "Split '", block$block_name, "' (", block$length, " nt) into ",
      n_subblocks, " superblock fragments."
    ))
  }

  result <- do.call(rbind, new_blocks)
  rownames(result) <- NULL

  # Verify
  still_over <- result$length > max_block_length
  if (any(still_over)) {
    cli::cli_warn(paste0(
      sum(still_over), " superblock fragment(s) still exceed synthesis limit. ",
      "Manual review needed."
    ))
  }

  result
}
