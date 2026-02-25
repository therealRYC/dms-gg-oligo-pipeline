# Created: 2025-02-01
# Last updated: 2026-02-25 — Support downstream_cassette (intergene_elements + polIII) for flexible constructs
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
#' @param tiles Data frame from partition_tiles() or search_tile_boundaries()
#' @param tile_overhangs Data frame from extract_tile_overhangs() (optional if assembly_plan given)
#' @param oh3 Fixed BsmBI overhang (PolIII-barcode junction)
#' @param oh4 Fixed BsaI overhang (barcode-helper junction)
#' @param paqci_star2 PaqCI** overhang (5' end of insert in helper plasmid)
#' @param paqci_star1 PaqCI* overhang (3' end of insert)
#' @param superblock_boundaries Data frame from compute_superblock_boundaries() (legacy)
#' @param max_block_length Maximum gene block synthesis length (default 1800)
#' @param fidelity_threshold Overhang fidelity threshold for superblock splitting
#' @param assembly_plan Optional assembly_plan from plan_assembly(); when provided,
#'   uses pre-computed superblock splits (gene-derived, HF-optimized) instead of
#'   legacy apply_superblock_splitting
#' @return List with:
#'   - blocks: data frame of gene blocks to order (deduplicated)
#'   - tile_manifests: data frame describing per-tile reaction contents
#'   - helper_plasmid: data frame describing helper plasmid insert
design_wt_geneblocks <- function(cds, polIII, tiles, tile_overhangs = NULL,
                                  oh3, oh4, paqci_star2, paqci_star1,
                                  superblock_boundaries = NULL,
                                  max_block_length = MAX_GENEBLOCK_LENGTH,
                                  min_block_length = MIN_GENEBLOCK_LENGTH,
                                  fidelity_threshold = DEFAULT_FIDELITY_THRESHOLD,
                                  assembly_plan = NULL) {

  n_tiles <- nrow(tiles)
  gene_len <- nchar(cds)
  blocks <- list()
  manifests <- list()
  # Minimum gene content (nt) for a sub-block to be useful after adding enzyme sites.
  # A sub-block below this threshold would produce a gene fragment too short to synthesize.
  block_overhead <- 22L  # 2 x 11-nt enzyme sites per block
  min_sub_content <- max(5L, min_block_length - block_overhead)

  # Use core cassette (cassette minus last 5 nt) when oh3 is derived from promoter.
  # This avoids duplicating the oh3+spacer sequence that's already encoded in the
  # BsmBI site. After ligation: ...core_cassette + oh3 + barcode (seamless junction).
  # Priority: core_downstream_cassette (intergene+core_polIII) > core_polIII > polIII
  polIII_for_block <- if (!is.null(assembly_plan) && !is.null(assembly_plan$core_downstream_cassette)) {
    assembly_plan$core_downstream_cassette
  } else if (!is.null(assembly_plan) && !is.null(assembly_plan$core_polIII)) {
    assembly_plan$core_polIII
  } else {
    polIII
  }
  # Use the promoter-derived spacer for BsmBI sites with oh3 as 3' overhang
  oh3_spacer <- if (!is.null(assembly_plan)) assembly_plan$oh3_spacer else NULL

  # If assembly_plan is provided, extract superblock splits in old format
  use_precomputed_splits <- !is.null(assembly_plan)

  if (use_precomputed_splits) {
    ap_splits <- assembly_plan$superblock_splits
    # Convert assembly_plan splits to old-format superblock_boundaries
    # for 5'WT blocks: filter by block_type == "bsai_5wt"
    # for 3'WT blocks: filter by block_type == "bsmbi_3wt"
    sb_5wt <- if (nrow(ap_splits) > 0) {
      ap_splits[ap_splits$block_type == "bsai_5wt", , drop = FALSE]
    } else {
      data.frame(split_nt = integer(0), junction_oh = character(0),
                 tile_id = integer(0), stringsAsFactors = FALSE)
    }
    sb_3wt <- if (nrow(ap_splits) > 0) {
      ap_splits[ap_splits$block_type == "bsmbi_3wt", , drop = FALSE]
    } else {
      data.frame(split_nt = integer(0), junction_oh = character(0),
                 tile_id = integer(0), stringsAsFactors = FALSE)
    }
  } else {
    if (is.null(superblock_boundaries)) {
      superblock_boundaries <- data.frame(
        boundary_id = integer(0), after_tile_id = integer(0),
        junction_nt = integer(0), junction_oh = character(0),
        fidelity_score = numeric(0), stringsAsFactors = FALSE
      )
    }
  }

  for (i in seq_len(n_tiles)) {
    tile <- tiles[i, ]

    # --- BsaI blocks: 5'WT gene segments ---
    bsai_parts <- character(0)

    if (tile$start_nt > 1L) {
      wt_5prime_start <- 1L
      wt_5prime_end <- tile$start_nt - 1L

      # Find superblock splits for this region
      if (use_precomputed_splits) {
        sb_in_region <- sb_5wt[sb_5wt$tile_id == tile$tile_id, , drop = FALSE]
        # Use split_nt as junction_nt
        if (nrow(sb_in_region) > 0) {
          sb_junction_nt <- sb_in_region$split_nt
          sb_junction_oh <- sb_in_region$junction_oh
        } else {
          sb_junction_nt <- integer(0)
          sb_junction_oh <- character(0)
        }
      } else {
        sb_in_region <- superblock_boundaries[
          superblock_boundaries$junction_nt >= wt_5prime_start &
          superblock_boundaries$junction_nt <= wt_5prime_end, , drop = FALSE
        ]
        sb_junction_nt <- sb_in_region$junction_nt
        sb_junction_oh <- sb_in_region$junction_oh
      }

      if (length(sb_junction_nt) == 0) {
        # Check if single block would exceed max_block_length
        wt_5prime_seq <- substring(cds, wt_5prime_start, wt_5prime_end)
        tentative_len <- nchar(wt_5prime_seq) + block_overhead

        if (tentative_len > max_block_length && use_precomputed_splits &&
            !is.null(assembly_plan$hf_set_used) && !is.null(assembly_plan$oh_fidelity_used)) {
          # No global split available — compute local split
          cli::cli_alert_info(paste0(
            "Tile ", tile$tile_id, ": 5'WT block oversized (",
            tentative_len, " > ", max_block_length,
            " nt). Computing local split."
          ))
          local_exclude <- unique(c(tile$oh1_seq,
            substring(cds, wt_5prime_start, wt_5prime_start + 3L),
            vapply(c(tile$oh1_seq, substring(cds, wt_5prime_start, wt_5prime_start + 3L)),
                   reverse_complement, character(1))))
          local_splits <- optimize_split_points(
            cds = cds,
            block_start_nt = wt_5prime_start,
            block_end_nt = wt_5prime_end,
            max_sub_length = max_block_length - block_overhead,
            existing_ohs = local_exclude,
            hf_set = assembly_plan$hf_set_used,
            oh_fidelity = assembly_plan$oh_fidelity_used
          )
          sb_junction_nt <- local_splits$split_nt
          sb_junction_oh <- local_splits$junction_oh
        }
      }

      if (length(sb_junction_nt) == 0) {
        # Truly a single 5'WT block
        wt_5prime_seq <- substring(cds, wt_5prime_start, wt_5prime_end)
        block_name <- paste0("bsai_5wt_tile", tile$tile_id)

        oh_5 <- substring(cds, wt_5prime_start, wt_5prime_start + 3L)
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
        # Split into superblocks at boundaries.
        # split_nt is the last nucleotide of sub-block N;
        # junction_oh = cds[split_nt-3 : split_nt] (last 4 nt of that sub-block).
        # create_bsai_block() expects gene_seq to START with oh_5 (and trims it),
        # so sub-blocks after the first must overlap by 4 nt to include the
        # junction overhang that will be trimmed.
        # Non-final sub-blocks must EXCLUDE the trailing junction OH from
        # gene_seq to avoid 4-nt duplication at junctions — the junction OH
        # is already encoded by the next sub-block's oh_5 (which becomes
        # part of the body after digestion).
        # Filter out internal split points that create empty sub-blocks.
        # Same approach as BsmBI: remove problematic split points upfront
        # so adjacent sub-blocks naturally cover the full gene range.
        internal_nt <- sb_junction_nt
        internal_oh_bsai <- sb_junction_oh
        max_sub_content <- max_block_length - block_overhead
        # Forward pass: ensure each gap from previous boundary >= min_sub_content.
        # When a gap is too small, check if skipping would create an oversized
        # merged sub-block. If so, keep the undersized split (lesser evil).
        keep_bsai <- logical(length(internal_nt))
        prev_sp_bsai <- wt_5prime_start - 1L
        for (j in seq_along(internal_nt)) {
          gap <- internal_nt[j] - prev_sp_bsai
          if (gap >= min_sub_content) {
            keep_bsai[j] <- TRUE
            prev_sp_bsai <- internal_nt[j]
          } else {
            # Gap too small — check if skipping would overflow
            next_sp <- if (j < length(internal_nt)) internal_nt[j + 1L] else wt_5prime_end
            merged_gap <- next_sp - prev_sp_bsai
            if (merged_gap > max_sub_content) {
              keep_bsai[j] <- TRUE
              prev_sp_bsai <- internal_nt[j]
            }
          }
        }
        internal_nt <- internal_nt[keep_bsai]
        internal_oh_bsai <- internal_oh_bsai[keep_bsai]
        # Trailing gap check: drop last split(s) if final sub-block too small
        while (length(internal_nt) > 0) {
          trailing_gap <- wt_5prime_end - internal_nt[length(internal_nt)]
          if (trailing_gap >= min_sub_content) break
          prev_boundary <- if (length(internal_nt) >= 2L) {
            internal_nt[length(internal_nt) - 1L]
          } else {
            wt_5prime_start - 1L
          }
          merged <- wt_5prime_end - prev_boundary
          if (merged > max_sub_content) break  # can't merge safely
          internal_nt <- internal_nt[-length(internal_nt)]
          internal_oh_bsai <- internal_oh_bsai[-length(internal_oh_bsai)]
        }

        split_points <- c(wt_5prime_start - 1L, internal_nt, wt_5prime_end)
        n_bsai_sub <- length(split_points) - 1L

        for (s in seq_len(n_bsai_sub)) {
          if (s == 1L) {
            sub_start <- split_points[s] + 1L
            oh_5 <- substring(cds, sub_start, sub_start + 3L)
          } else {
            # Overlap: start 4 nt earlier so gene_seq begins with junction OH
            sub_start <- split_points[s] - 3L
            oh_5 <- internal_oh_bsai[s - 1L]
          }
          sub_end <- split_points[s + 1L]
          if (s < n_bsai_sub) {
            # Trim trailing 4 nt (junction OH) — provided by next sub-block's oh_5
            sub_seq <- substring(cds, sub_start, sub_end - 4L)
          } else {
            sub_seq <- substring(cds, sub_start, sub_end)
          }
          block_name <- paste0("bsai_5wt_tile", tile$tile_id, "_sub", s)
          oh_3 <- if (s < n_bsai_sub) internal_oh_bsai[s] else tile$oh1_seq

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
    bsmbi_parts <- character(0)

    wt_3prime_start <- tile$end_nt + 1L
    wt_3prime_end <- gene_len

    if (wt_3prime_start <= gene_len) {
      wt_3prime_seq <- substring(cds, wt_3prime_start, wt_3prime_end)

      # Check for pre-computed 3'WT splits
      if (use_precomputed_splits) {
        sb_3wt_region <- sb_3wt[sb_3wt$tile_id == tile$tile_id, , drop = FALSE]
      } else {
        sb_3wt_region <- data.frame(split_nt = integer(0), junction_oh = character(0),
                                     stringsAsFactors = FALSE)
      }

      if (nrow(sb_3wt_region) == 0) {
        # Check if single block would exceed max_block_length
        full_content <- paste0(wt_3prime_seq, polIII_for_block)
        tentative_len <- nchar(full_content) + block_overhead

        if (tentative_len > max_block_length && use_precomputed_splits &&
            !is.null(assembly_plan$hf_set_used) && !is.null(assembly_plan$oh_fidelity_used)) {
          # No global split available for this tile's 3'WT region — compute local split
          cli::cli_alert_info(paste0(
            "Tile ", tile$tile_id, ": 3'WT block oversized (",
            tentative_len, " > ", max_block_length,
            " nt). Computing local split."
          ))
          local_exclude <- unique(c(oh3, tile$oh2_seq,
            vapply(c(oh3, tile$oh2_seq), reverse_complement, character(1))))
          local_splits <- optimize_split_points(
            cds = cds,
            block_start_nt = wt_3prime_start,
            block_end_nt = wt_3prime_end,
            max_sub_length = max_block_length - block_overhead,
            existing_ohs = local_exclude,
            hf_set = assembly_plan$hf_set_used,
            oh_fidelity = assembly_plan$oh_fidelity_used,
            extra_content_length = nchar(polIII_for_block)
          )
          # Use local splits as if they were pre-computed (fall through to superblock loop)
          sb_3wt_region <- local_splits
          sb_3wt_region$tile_id <- tile$tile_id
          sb_3wt_region$block_type <- "bsmbi_3wt"
        }

        if (nrow(sb_3wt_region) == 0) {
          # Truly a single block (fits within max or no local split found)
          block_name <- paste0("bsmbi_3wt_tile", tile$tile_id)
          oh_5 <- tile$oh2_seq
          oh_3 <- oh3
          block_seq <- create_bsmbi_block(paste0(wt_3prime_seq, polIII_for_block),
                                           oh_5, oh_3, oh3_spacer = oh3_spacer)

          blocks[[length(blocks) + 1]] <- data.frame(
            block_name = block_name, sequence = block_seq,
            length = nchar(block_seq), enzyme_type = "BsmBI",
            gene_region = paste0("3wt_polIII_tile", tile$tile_id),
            stringsAsFactors = FALSE
          )
          bsmbi_parts <- block_name
        }
      }

      if (nrow(sb_3wt_region) > 0) {
        # Split 3'WT region at pre-computed split points.
        # split_nt is the last nucleotide of sub-block N;
        # junction_oh = cds[split_nt-3 : split_nt] (last 4 nt of that sub-block).
        # create_bsmbi_block() prepends oh_5 via the enzyme site (doesn't trim),
        # so non-final sub-blocks must EXCLUDE the trailing junction OH from
        # gene_seq to avoid 4-nt duplication at junctions — the junction OH
        # is already encoded by the next sub-block's BsmBI_fwd(junction_oh).
        # Filter out internal split points that are too close to the tile
        # boundary (or to each other), which would create sub-blocks with
        # zero gene content after trimming the trailing 4-nt junction OH.
        # Instead of skipping empty sub-blocks (which loses gene content),
        # we remove the problematic split point so the adjacent sub-block
        # naturally covers the full range.
        internal_splits <- sb_3wt_region$split_nt
        internal_oh <- sb_3wt_region$junction_oh
        max_sub_content <- max_block_length - block_overhead
        # Forward pass: ensure each gap from previous boundary >= min_sub_content.
        # When a gap is too small, check if skipping the split would create an
        # oversized merged sub-block. If so, keep the undersized split (lesser evil).
        keep_idx <- logical(length(internal_splits))
        prev_sp <- wt_3prime_start - 1L
        for (j in seq_along(internal_splits)) {
          gap <- internal_splits[j] - prev_sp
          if (gap >= min_sub_content) {
            keep_idx[j] <- TRUE
            prev_sp <- internal_splits[j]
          } else {
            # Gap too small — check if skipping would overflow
            next_sp <- if (j < length(internal_splits)) internal_splits[j + 1L] else wt_3prime_end
            merged_gap <- next_sp - prev_sp
            # For the last sub-block, add PolIII content
            if (j == length(internal_splits) || (j < length(internal_splits) && !any(keep_idx[(j+1):length(internal_splits)]))) {
              # This may become part of the last sub-block — conservative: don't add polIII here
            }
            if (merged_gap > max_sub_content) {
              # Skipping would overflow — keep the undersized split
              keep_idx[j] <- TRUE
              prev_sp <- internal_splits[j]
            }
            # else: safe to skip, sub-block merges with next
          }
        }
        internal_splits <- internal_splits[keep_idx]
        internal_oh <- internal_oh[keep_idx]
        # Leading gap check: drop first split(s) if first sub-block too small
        while (length(internal_splits) > 0) {
          leading_gap <- internal_splits[1L] - (wt_3prime_start - 1L)
          if (leading_gap >= min_sub_content) break
          next_boundary <- if (length(internal_splits) >= 2L) {
            internal_splits[2L]
          } else {
            wt_3prime_end
          }
          merged <- next_boundary - (wt_3prime_start - 1L)
          if (merged > max_sub_content) break  # can't merge safely
          internal_splits <- internal_splits[-1L]
          internal_oh <- internal_oh[-1L]
        }
        # Trailing gap check: last sub-block carries PolIII
        while (length(internal_splits) > 0) {
          trailing_gene <- wt_3prime_end - internal_splits[length(internal_splits)]
          trailing_total <- trailing_gene + nchar(polIII_for_block)
          if (trailing_total >= min_sub_content) break
          prev_boundary <- if (length(internal_splits) >= 2L) {
            internal_splits[length(internal_splits) - 1L]
          } else {
            wt_3prime_start - 1L
          }
          merged_total <- (wt_3prime_end - prev_boundary) + nchar(polIII_for_block)
          if (merged_total > max_sub_content) break
          internal_splits <- internal_splits[-length(internal_splits)]
          internal_oh <- internal_oh[-length(internal_oh)]
        }

        split_points <- c(wt_3prime_start - 1L, internal_splits, wt_3prime_end)
        n_sub <- length(split_points) - 1L

        for (s in seq_len(n_sub)) {
          sub_start <- split_points[s] + 1L
          sub_end <- split_points[s + 1L]
          if (s < n_sub) {
            # Trim trailing 4 nt (junction OH) — provided by next sub-block's BsmBI_fwd
            sub_seq <- substring(cds, sub_start, sub_end - 4L)
          } else {
            # Last sub-block: no trimming, and append PolIII
            sub_seq <- paste0(substring(cds, sub_start, sub_end), polIII_for_block)
          }

          block_name <- paste0("bsmbi_3wt_tile", tile$tile_id, "_sub", s)
          oh_5 <- if (s == 1L) tile$oh2_seq else internal_oh[s - 1L]
          oh_3 <- if (s < n_sub) internal_oh[s] else oh3

          # Use oh3_spacer only when the 3' overhang is oh3 (last sub-block)
          spacer_for_sub <- if (s == n_sub) oh3_spacer else NULL
          block_seq <- create_bsmbi_block(sub_seq, oh_5, oh_3, oh3_spacer = spacer_for_sub)

          # Only the final sub-block contains PolIII — label accordingly
          gene_region_prefix <- if (s == n_sub) "3wt_polIII_tile" else "3wt_tile"
          blocks[[length(blocks) + 1]] <- data.frame(
            block_name = block_name, sequence = block_seq,
            length = nchar(block_seq), enzyme_type = "BsmBI",
            gene_region = paste0(gene_region_prefix, tile$tile_id, "_sub", s),
            stringsAsFactors = FALSE
          )
          bsmbi_parts <- c(bsmbi_parts, block_name)
        }
      }
    } else {
      # This is the last tile — only PolIII fragment
      block_name <- paste0("bsmbi_polIII_tile", tile$tile_id)
      oh_5 <- tile$oh2_seq
      oh_3 <- oh3
      block_seq <- create_bsmbi_block(polIII_for_block, oh_5, oh_3,
                                       oh3_spacer = oh3_spacer)

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
  dedup_result <- deduplicate_blocks(all_blocks)
  all_blocks <- dedup_result$blocks
  name_map <- dedup_result$name_map

  # Combine manifests
  all_manifests <- do.call(rbind, manifests)
  rownames(all_manifests) <- NULL

  # Remap manifest block names to surviving dedup names
  if (length(name_map) > 0) {
    for (i in seq_len(nrow(all_manifests))) {
      if (nzchar(all_manifests$bsai_parts[i])) {
        parts <- strsplit(all_manifests$bsai_parts[i], ";")[[1]]
        parts <- vapply(parts, function(n) {
          if (!is.null(name_map[[n]])) name_map[[n]] else n
        }, character(1), USE.NAMES = FALSE)
        all_manifests$bsai_parts[i] <- paste(parts, collapse = ";")
      }
      if (nzchar(all_manifests$bsmbi_parts[i])) {
        parts <- strsplit(all_manifests$bsmbi_parts[i], ";")[[1]]
        parts <- vapply(parts, function(n) {
          if (!is.null(name_map[[n]])) name_map[[n]] else n
        }, character(1), USE.NAMES = FALSE)
        all_manifests$bsmbi_parts[i] <- paste(parts, collapse = ";")
      }
    }
  }

  # Design helper plasmid insert
  oh_L <- substring(cds, 1, 4)  # First 4 nt of gene
  helper <- design_helper_plasmid(oh_L, oh4, paqci_star2, paqci_star1)

  # Check block lengths — only apply legacy splitting if NOT using assembly_plan
  over_limit <- all_blocks$length > max_block_length
  if (any(over_limit) && !use_precomputed_splits) {
    cli::cli_alert_warning(paste0(
      sum(over_limit), " block(s) exceed ", max_block_length,
      " nt synthesis limit. Applying superblock splitting..."
    ))
    all_blocks <- apply_superblock_splitting(
      all_blocks, cds, polIII, oh3, max_block_length, fidelity_threshold
    )
  } else if (any(over_limit) && use_precomputed_splits) {
    cli::cli_alert_warning(paste0(
      sum(over_limit), " block(s) still exceed ", max_block_length,
      " nt after pre-computed splits. May need additional splitting."
    ))
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
#' Structure: BsaI_fwd(oh_5prime) + gene_interior + BsaI_rev(oh_3prime)
#'
#' gene_seq starts with oh_5prime (first 4 nt), and BsaI_fwd already
#' embeds oh_5prime. Trim the leading overlap to avoid 4-nt duplication.
#' The 3' end has no overlap: oh_3prime is the next tile's boundary,
#' NOT the last 4 nt of gene_seq.
#'
#' @param gene_seq WT gene sequence for this block (starts with oh_5prime)
#' @param oh_5prime 4-nt overhang at 5' end
#' @param oh_3prime 4-nt overhang at 3' end
#' @return Complete block sequence with flanking BsaI sites
create_bsai_block <- function(gene_seq, oh_5prime, oh_3prime) {
  bsai_fwd <- orient_enzyme_site("BsaI", oh_5prime, "forward")
  bsai_rev <- orient_enzyme_site("BsaI", oh_3prime, "reverse")
  # gene_seq starts with oh_5prime — trim to avoid duplication with bsai_fwd
  gene_interior <- substring(gene_seq, nchar(oh_5prime) + 1L)
  paste0(bsai_fwd, gene_interior, bsai_rev)
}

#' Create a BsmBI-flanked gene block
#'
#' Structure: BsmBI_fwd + oh_5prime + [gene_seq] + oh_3prime + BsmBI_rev
#'
#' @param gene_seq WT gene sequence for this block (may include PolIII)
#' @param oh_5prime 4-nt overhang at 5' end
#' @param oh_3prime 4-nt overhang at 3' end
#' @param oh3_spacer Optional spacer for 3' BsmBI reverse site. When oh3 is
#'   derived from the PolIII promoter, this is the promoter's terminal nucleotide
#'   (e.g., "G") instead of the default "A". Only applies to the reverse site.
#' @return Complete block sequence with flanking BsmBI sites
create_bsmbi_block <- function(gene_seq, oh_5prime, oh_3prime, oh3_spacer = NULL) {
  bsmbi_fwd <- orient_enzyme_site("BsmBI", oh_5prime, "forward")
  bsmbi_rev <- orient_enzyme_site("BsmBI", oh_3prime, "reverse", spacer_seq = oh3_spacer)
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
#' to list all associated tiles. Returns a name mapping so callers can
#' update references (e.g., tile manifests) to point to surviving names.
#'
#' @param blocks Data frame of gene blocks
#' @return List with `blocks` (deduplicated data frame) and `name_map`
#'   (named list mapping every original block name to the surviving name)
deduplicate_blocks <- function(blocks) {
  if (nrow(blocks) == 0) return(list(blocks = blocks, name_map = list()))

  # Group by sequence
  unique_seqs <- unique(blocks$sequence)
  deduped <- list()
  name_map <- list()

  for (seq in unique_seqs) {
    matching <- blocks[blocks$sequence == seq, , drop = FALSE]
    first <- matching[1, ]
    surviving_name <- first$block_name
    # Map all original names (including the survivor) to the surviving name
    for (orig_name in matching$block_name) {
      name_map[[orig_name]] <- surviving_name
    }
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

  list(blocks = result, name_map = name_map)
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
