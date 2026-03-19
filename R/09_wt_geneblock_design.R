# Created: 2025-02-01
# Last updated: 2026-03-18 — Flanking pads + oh_L/upstream_cassette for 5'WT blocks
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

#' Find split points within a downstream cassette sequence
#'
#' When the downstream cassette (intergene elements + PolIII) is too large to
#' fit in a single gene block, this function finds positions within the cassette
#' where BsmBI junction overhangs can be placed. Each cassette fragment becomes
#' its own BsmBI-connected sub-block in the same Level 1b reaction.
#'
#' @param cassette_seq Character string of the cassette sequence to split
#' @param max_sub_length Integer, max content length per sub-block (typically 1778)
#' @param existing_ohs Character vector of overhangs already in use (must avoid collisions)
#' @param oh_fidelity Data frame with overhang + fidelity columns
#' @param eff_lookup Named numeric vector (overhang -> efficiency). NULL = 1.0 for all.
#' @return Data frame with columns: split_pos (1-based position in cassette, last nt of
#'   sub-block N), junction_oh (4-nt overhang at that position). Empty if no splits needed.
find_cassette_split_points <- function(cassette_seq, max_sub_length,
                                       existing_ohs, oh_fidelity,
                                       eff_lookup = NULL) {
  cassette_len <- nchar(cassette_seq)

  if (cassette_len <= max_sub_length) {
    return(data.frame(
      split_pos = integer(0), junction_oh = character(0),
      stringsAsFactors = FALSE
    ))
  }

  fid_lookup <- oh_fidelity$fidelity
  names(fid_lookup) <- oh_fidelity$overhang

  if (is.null(eff_lookup)) {
    eff_lookup <- rep(1.0, nrow(oh_fidelity))
    names(eff_lookup) <- oh_fidelity$overhang
  }

  # Each junction adds 22 nt of enzyme overhead (11 nt BsmBI site on each side)
  junction_overhead <- 22L
  n_splits <- ceiling(cassette_len / (max_sub_length - junction_overhead)) - 1L
  if (n_splits < 1L) n_splits <- 1L

  existing_set <- unique(c(existing_ohs, vapply(existing_ohs, reverse_complement, character(1))))

  # Greedy split point search with retry on oversized fragments

  max_retry <- 3L
  search_window <- 50L

  for (retry in seq_len(max_retry)) {
    target_sub_size <- cassette_len / (n_splits + 1L)
    local_existing <- existing_set
    splits <- list()

    for (s in seq_len(n_splits)) {
      center <- as.integer(s * target_sub_size)
      lo <- max(5L, center - search_window)
      hi <- min(cassette_len - 5L, center + search_window)

      best <- list(pos = center, oh = "NNNN", score = -1)

      for (p in lo:hi) {
        # Extract 4-nt overhang ending at position p
        if (p < 4L) next
        junction_oh <- substring(cassette_seq, p - 3L, p)

        if (junction_oh %in% local_existing) next
        if (junction_oh %in% HOMOPOLYMER_4NT) next

        score <- overhang_score(junction_oh, fid_lookup, eff_lookup)
        if (is.na(score)) next # unscorable — skip

        if (score > best$score) {
          best <- list(pos = p, oh = junction_oh, score = score)
        }
      }

      local_existing <- c(local_existing, best$oh, reverse_complement(best$oh))
      splits[[s]] <- data.frame(
        split_pos = best$pos, junction_oh = best$oh,
        stringsAsFactors = FALSE
      )
    }

    result <- do.call(rbind, splits)
    split_positions <- sort(result$split_pos)

    # Validate all fragments fit within max_sub_length
    boundaries <- c(0L, split_positions, cassette_len)
    all_ok <- TRUE
    for (j in seq_len(length(boundaries) - 1L)) {
      frag_len <- boundaries[j + 1L] - boundaries[j]
      if (frag_len > max_sub_length) {
        all_ok <- FALSE
        break
      }
    }

    if (all_ok) break
    n_splits <- n_splits + 1L
  }

  # Sort by position
  result <- result[order(result$split_pos), , drop = FALSE]
  rownames(result) <- NULL

  cli::cli_alert_info(paste0(
    "Cassette split: ", cassette_len, " nt cassette -> ",
    n_splits + 1L, " fragments at positions ",
    paste(result$split_pos, collapse = ", "),
    " (overhangs: ", paste(result$junction_oh, collapse = ", "), ")"
  ))

  result
}

#' Build cassette sub-blocks when the downstream cassette is too large
#'
#' Splits an oversized cassette into multiple BsmBI-connected sub-blocks.
#' Called when the last gene sub-block + cassette exceeds max_block_length,
#' or when the cassette alone (for the last tile) is oversized.
#'
#' @param cassette_seq Full cassette sequence (core_downstream_cassette or core_polIII)
#' @param oh_5 4-nt overhang at 5' end of first cassette fragment
#' @param oh_3_final 4-nt overhang at 3' end of last cassette fragment (oh3)
#' @param oh3_spacer Spacer for the final BsmBI reverse site (or NULL)
#' @param tile_id Integer tile ID (for naming)
#' @param sub_offset Integer, sub-block numbering offset (continue from gene sub-blocks)
#' @param cassette_splits Data frame from find_cassette_split_points()
#' @param max_block_length Max synthesis length
#' @param flanking_pad Flanking DNA added outside enzyme sites (default "")
#' @return List with: blocks (list of data frame rows), part_names (character vector)
build_cassette_subblocks <- function(cassette_seq, oh_5, oh_3_final,
                                     oh3_spacer, tile_id, sub_offset,
                                     cassette_splits, max_block_length,
                                     flanking_pad = "") {
  split_positions <- c(0L, cassette_splits$split_pos, nchar(cassette_seq))
  junction_ohs <- cassette_splits$junction_oh
  n_cass_sub <- length(split_positions) - 1L

  cass_blocks <- list()
  cass_names <- character(0)

  for (cs in seq_len(n_cass_sub)) {
    cass_start <- split_positions[cs] + 1L
    cass_end <- split_positions[cs + 1L]

    if (cs < n_cass_sub) {
      # Trim trailing 4 nt (junction OH) — provided by next fragment's BsmBI_fwd
      cass_content <- substring(cassette_seq, cass_start, cass_end - 4L)
    } else {
      cass_content <- substring(cassette_seq, cass_start, cass_end)
    }

    cs_oh5 <- if (cs == 1L) oh_5 else junction_ohs[cs - 1L]
    cs_oh3 <- if (cs < n_cass_sub) junction_ohs[cs] else oh_3_final
    cs_spacer <- if (cs == n_cass_sub) oh3_spacer else NULL

    block_name <- paste0("bsmbi_cassette_tile", tile_id, "_sub", sub_offset + cs)
    block_seq <- create_bsmbi_block(cass_content, cs_oh5, cs_oh3, oh3_spacer = cs_spacer,
                                    flanking_pad = flanking_pad)

    cass_blocks[[cs]] <- data.frame(
      block_name = block_name, sequence = block_seq,
      length = nchar(block_seq), enzyme_type = "BsmBI",
      gene_region = paste0("cassette_tile", tile_id, "_frag", cs),
      oh_5 = cs_oh5, oh_3 = cs_oh3,
      stringsAsFactors = FALSE
    )
    cass_names <- c(cass_names, block_name)
  }

  list(blocks = cass_blocks, part_names = cass_names)
}

#' Design all WT gene blocks for 3-enzyme assembly
#'
#' @param cds Character string of domesticated CDS
#' @param polIII Character string of PolIII promoter sequence
#' @param tiles Data frame from partition_tiles() or search_tile_boundaries()
#' @param tile_overhangs Unused legacy parameter, kept for backward compatibility
#' @param oh3 Fixed BsmBI overhang (PolIII-barcode junction)
#' @param oh4 Fixed BsaI overhang (barcode-helper junction)
#' @param paqci_star2 PaqCI** overhang (5' end of insert in helper plasmid)
#' @param paqci_star1 PaqCI* overhang (3' end of insert)
#' @param max_block_length Maximum gene block synthesis length (default 1800)
#' @param assembly_plan assembly_plan from plan_assembly(); provides pre-computed
#'   superblock splits (gene-derived, HF-optimized)
#' @param flanking_pad Flanking DNA added outside enzyme sites on gene blocks
#'   for efficient Type IIs cleavage at linear fragment termini (default "")
#' @return List with:
#'   - blocks: data frame of gene blocks to order (deduplicated)
#'   - tile_manifests: data frame describing per-tile reaction contents
#'   - helper_plasmid: data frame describing helper plasmid insert
design_wt_geneblocks <- function(cds, polIII, tiles, tile_overhangs = NULL,
                                 oh3, oh4, paqci_star2, paqci_star1,
                                 max_block_length = MAX_GENEBLOCK_LENGTH,
                                 min_block_length = MIN_GENEBLOCK_LENGTH,
                                 assembly_plan = NULL,
                                 flanking_pad = "") {
  n_tiles <- nrow(tiles)
  gene_len <- nchar(cds)
  blocks <- list()
  manifests <- list()
  # Minimum gene content (nt) for a sub-block to be useful after adding enzyme sites.
  # A sub-block below this threshold would produce a gene fragment too short to synthesize.
  # Pads add 2 * nchar(flanking_pad) nt to each block beyond enzyme overhead.
  pad_overhead <- 2L * nchar(flanking_pad)
  block_overhead <- 22L + pad_overhead # 2 x 11-nt enzyme sites + 2 x pad per block
  min_sub_content <- max(5L, min_block_length - block_overhead)

  # oh_L and upstream_cassette: used to construct 5'WT blocks.
  # oh_L is the user-specified BsaI overhang upstream of ATG.
  # upstream_cassette is the sequence between oh_L and ATG (may be "").
  # 5'WT blocks (tiles 2+) are: BsaI(oh_L) + upstream_cassette + CDS[1..tile_boundary] + BsaI(oh1)
  oh_L <- if (!is.null(assembly_plan)) assembly_plan$oh_L else substring(cds, 1, 4)
  upstream_cassette <- if (!is.null(assembly_plan)) (assembly_plan$upstream_cassette %||% "") else ""

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

  # Extract superblock splits from assembly_plan
  use_precomputed_splits <- !is.null(assembly_plan)

  if (use_precomputed_splits) {
    ap_splits <- assembly_plan$superblock_splits
    sb_5wt <- if (nrow(ap_splits) > 0) {
      ap_splits[ap_splits$block_type == "bsai_5wt", , drop = FALSE]
    } else {
      data.frame(
        split_nt = integer(0), junction_oh = character(0),
        tile_id = integer(0), stringsAsFactors = FALSE
      )
    }
    sb_3wt <- if (nrow(ap_splits) > 0) {
      ap_splits[ap_splits$block_type == "bsmbi_3wt", , drop = FALSE]
    } else {
      data.frame(
        split_nt = integer(0), junction_oh = character(0),
        tile_id = integer(0), stringsAsFactors = FALSE
      )
    }
  }

  # Collect ALL tile oh1/oh2 values for exclusion when computing sub-block split

  # junctions. After deduplication, sub-blocks are shared across tiles, so junction
  # overhangs must avoid colliding with ANY tile's oh1/oh2 (not just the current
  # tile's). This prevents ambiguous ligation in per-tile BsaI/BsmBI reactions.
  all_oh2 <- unique(tiles$oh2_seq)
  all_oh1 <- unique(tiles$oh1_seq)

  for (i in seq_len(n_tiles)) {
    tile <- tiles[i, ]

    # --- BsaI blocks: 5'WT gene segments ---
    bsai_parts <- character(0)

    if (tile$start_nt > 1L) {
      wt_5prime_start <- 1L
      wt_5prime_end <- tile$start_nt - 1L

      # Find superblock splits for this region
      sb_junction_nt <- integer(0)
      sb_junction_oh <- character(0)
      if (use_precomputed_splits) {
        sb_in_region <- sb_5wt[sb_5wt$tile_id == tile$tile_id, , drop = FALSE]
        # Use split_nt as junction_nt
        if (nrow(sb_in_region) > 0) {
          sb_junction_nt <- sb_in_region$split_nt
          sb_junction_oh <- sb_in_region$junction_oh
        }
      }

      if (length(sb_junction_nt) == 0) {
        # Check if single block would exceed max_block_length.
        # Include upstream_cassette in the length check since it's prepended to 5'WT blocks.
        wt_5prime_seq_raw <- substring(cds, wt_5prime_start, wt_5prime_end)
        tentative_len <- nchar(oh_L) + nchar(upstream_cassette) +
                         nchar(wt_5prime_seq_raw) + block_overhead

        if (tentative_len > max_block_length && use_precomputed_splits &&
          !is.null(assembly_plan$oh_fidelity_used)) {
          # No global split available — compute local split
          cli::cli_alert_info(paste0(
            "Tile ", tile$tile_id, ": 5'WT block oversized (",
            tentative_len, " > ", max_block_length,
            " nt). Computing local split."
          ))
          # Exclude ALL tiles' oh1 (not just current tile's) because BsaI
          # sub-blocks are deduplicated and shared across tiles.
          local_exclude <- unique(c(
            all_oh1, oh4, oh_L,
            vapply(c(all_oh1, oh4, oh_L), reverse_complement, character(1))
          ))
          local_splits <- optimize_split_points(
            cds = cds,
            block_start_nt = wt_5prime_start,
            block_end_nt = wt_5prime_end,
            max_sub_length = max_block_length - block_overhead,
            existing_ohs = local_exclude,
            oh_fidelity = assembly_plan$oh_fidelity_used
          )
          sb_junction_nt <- local_splits$split_nt
          sb_junction_oh <- local_splits$junction_oh
        }
      }

      if (length(sb_junction_nt) == 0) {
        # Truly a single 5'WT block.
        # Prepend oh_L + upstream_cassette before CDS content so the assembled
        # product is: oh_L → upstream_cassette → ATG → [5'WT CDS] → oh1
        wt_5prime_seq <- paste0(oh_L, upstream_cassette,
                                substring(cds, wt_5prime_start, wt_5prime_end))
        block_name <- paste0("bsai_5wt_tile", tile$tile_id)

        oh_5 <- oh_L
        oh_3 <- tile$oh1_seq

        block_seq <- create_bsai_block(wt_5prime_seq, oh_5, oh_3,
                                       flanking_pad = flanking_pad)

        blocks[[length(blocks) + 1]] <- data.frame(
          block_name = block_name, sequence = block_seq,
          length = nchar(block_seq), enzyme_type = "BsaI",
          gene_region = paste0("5wt_tile", tile$tile_id),
          oh_5 = oh_5, oh_3 = oh_3,
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
          if (merged > max_sub_content) break # can't merge safely
          internal_nt <- internal_nt[-length(internal_nt)]
          internal_oh_bsai <- internal_oh_bsai[-length(internal_oh_bsai)]
        }

        split_points <- c(wt_5prime_start - 1L, internal_nt, wt_5prime_end)
        n_bsai_sub <- length(split_points) - 1L

        for (s in seq_len(n_bsai_sub)) {
          if (s == 1L) {
            sub_start <- split_points[s] + 1L
            # First sub-block: oh_5 = oh_L, prepend upstream_cassette before CDS
            oh_5 <- oh_L
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
          # First sub-block: prepend oh_L + upstream_cassette before CDS content
          if (s == 1L) {
            sub_seq <- paste0(oh_L, upstream_cassette, sub_seq)
          }
          block_name <- paste0("bsai_5wt_tile", tile$tile_id, "_sub", s)
          oh_3 <- if (s < n_bsai_sub) internal_oh_bsai[s] else tile$oh1_seq

          block_seq <- create_bsai_block(sub_seq, oh_5, oh_3,
                                         flanking_pad = flanking_pad)

          blocks[[length(blocks) + 1]] <- data.frame(
            block_name = block_name, sequence = block_seq,
            length = nchar(block_seq), enzyme_type = "BsaI",
            gene_region = paste0("5wt_tile", tile$tile_id, "_sub", s),
            oh_5 = oh_5, oh_3 = oh_3,
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
        sb_3wt_region <- data.frame(
          split_nt = integer(0), junction_oh = character(0),
          stringsAsFactors = FALSE
        )
      }

      if (nrow(sb_3wt_region) == 0) {
        # Check if single block would exceed max_block_length
        full_content <- paste0(wt_3prime_seq, polIII_for_block)
        tentative_len <- nchar(full_content) + block_overhead

        if (tentative_len > max_block_length && use_precomputed_splits &&
          !is.null(assembly_plan$oh_fidelity_used)) {
          # No global split available for this tile's 3'WT region — compute local split
          cli::cli_alert_info(paste0(
            "Tile ", tile$tile_id, ": 3'WT block oversized (",
            tentative_len, " > ", max_block_length,
            " nt). Computing local split."
          ))
          # Exclude ALL tiles' oh2 (not just current tile's) because BsmBI
          # 3'WT sub-blocks are deduplicated and shared across tiles.
          local_exclude <- unique(c(
            oh3, all_oh2,
            vapply(c(oh3, all_oh2), reverse_complement, character(1))
          ))
          local_splits <- optimize_split_points(
            cds = cds,
            block_start_nt = wt_3prime_start,
            block_end_nt = wt_3prime_end,
            max_sub_length = max_block_length - block_overhead,
            existing_ohs = local_exclude,
            oh_fidelity = assembly_plan$oh_fidelity_used,
            extra_content_length = nchar(polIII_for_block)
          )
          # Use local splits as if they were pre-computed (fall through to superblock loop)
          sb_3wt_region <- local_splits
          sb_3wt_region$tile_id <- tile$tile_id
          sb_3wt_region$block_type <- "bsmbi_3wt"
        }

        if (nrow(sb_3wt_region) == 0) {
          # Check if single block is still oversized due to cassette
          single_block_len <- nchar(wt_3prime_seq) + nchar(polIII_for_block) + block_overhead
          max_sub_content <- max_block_length - block_overhead
          if (single_block_len > max_block_length &&
            use_precomputed_splits &&
            !is.null(assembly_plan$oh_fidelity_used)) {
            # Gene region small, cassette oversized — split cassette
            cli::cli_alert_info(paste0(
              "Tile ", tile$tile_id, ": single 3'WT block oversized (",
              single_block_len, " nt) due to large cassette. Splitting cassette."
            ))
            # Use pre-computed SB DP cassette splits if available, else greedy
            use_sb_dp_cass <- !is.null(assembly_plan$cassette_splits) &&
              nrow(assembly_plan$cassette_splits) > 0
            if (use_sb_dp_cass) {
              cass_splits <- assembly_plan$cassette_splits
              cli::cli_alert_info(paste0(
                "Tile ", tile$tile_id, ": using ", nrow(cass_splits),
                " pre-computed SB DP cassette split(s)."
              ))
            } else {
              # Exclude ALL tiles' oh2 — cassette sub-blocks are shared via dedup
              cass_exclude <- unique(c(
                oh3, all_oh2,
                vapply(c(oh3, all_oh2), reverse_complement, character(1))
              ))
              cass_splits <- find_cassette_split_points(
                cassette_seq = polIII_for_block,
                max_sub_length = max_sub_content,
                existing_ohs = cass_exclude,
                oh_fidelity = assembly_plan$oh_fidelity_used
              )
            }
            if (use_sb_dp_cass && nrow(cass_splits) > 0) {
              # SB DP path: gene sub-block carries gene + cassette prefix up to
              # split_pos, trimmed by 4 nt (junction OH convention for BsmBI blocks).
              # The junction OH bridges gene sub-block and cassette sub-block(s).
              first_split_pos <- as.integer(cass_splits$split_pos[1L])
              oh_3_sub <- cass_splits$junction_oh[1L]
              # Content: gene residual + cassette prefix, minus last 4 nt (junction OH)
              content_len <- nchar(wt_3prime_seq) + first_split_pos - 4L
              if (content_len > nchar(wt_3prime_seq)) {
                sub_seq <- paste0(
                  wt_3prime_seq,
                  substring(polIII_for_block, 1L, content_len - nchar(wt_3prime_seq))
                )
              } else {
                sub_seq <- substring(wt_3prime_seq, 1L, content_len)
              }
              block_name <- paste0("bsmbi_3wt_tile", tile$tile_id)
              block_seq <- create_bsmbi_block(sub_seq, tile$oh2_seq, oh_3_sub,
                                              flanking_pad = flanking_pad)
              blocks[[length(blocks) + 1]] <- data.frame(
                block_name = block_name, sequence = block_seq,
                length = nchar(block_seq), enzyme_type = "BsmBI",
                gene_region = paste0("3wt_tile", tile$tile_id),
                oh_5 = tile$oh2_seq, oh_3 = oh_3_sub,
                stringsAsFactors = FALSE
              )
              bsmbi_parts <- block_name
              # Remaining cassette for separate block(s)
              remaining_cassette <- substring(polIII_for_block, first_split_pos + 1L)
              remaining_splits <- cass_splits[-1L, , drop = FALSE]
              if (nrow(remaining_splits) > 0L) {
                remaining_splits$split_pos <- remaining_splits$split_pos - first_split_pos
              }
              cass_result <- build_cassette_subblocks(
                cassette_seq = remaining_cassette,
                oh_5 = oh_3_sub,
                oh_3_final = oh3,
                oh3_spacer = oh3_spacer,
                tile_id = tile$tile_id,
                sub_offset = 1L,
                cassette_splits = remaining_splits,
                max_block_length = max_block_length,
                flanking_pad = flanking_pad
              )
              for (cb in cass_result$blocks) {
                blocks[[length(blocks) + 1]] <- cb
              }
              bsmbi_parts <- c(bsmbi_parts, cass_result$part_names)
            } else if (nrow(cass_splits) > 0) {
              # Greedy fallback: gene sub-block with gene content only
              gene_cass_oh <- substring(polIII_for_block, 1, 4)
              block_name <- paste0("bsmbi_3wt_tile", tile$tile_id)
              block_seq <- create_bsmbi_block(wt_3prime_seq, tile$oh2_seq, gene_cass_oh,
                                              flanking_pad = flanking_pad)
              blocks[[length(blocks) + 1]] <- data.frame(
                block_name = block_name, sequence = block_seq,
                length = nchar(block_seq), enzyme_type = "BsmBI",
                gene_region = paste0("3wt_tile", tile$tile_id),
                oh_5 = tile$oh2_seq, oh_3 = gene_cass_oh,
                stringsAsFactors = FALSE
              )
              bsmbi_parts <- block_name
              # Cassette fragment sub-blocks
              cass_result <- build_cassette_subblocks(
                cassette_seq = polIII_for_block,
                oh_5 = gene_cass_oh,
                oh_3_final = oh3,
                oh3_spacer = oh3_spacer,
                tile_id = tile$tile_id,
                sub_offset = 1L,
                cassette_splits = cass_splits,
                max_block_length = max_block_length,
                flanking_pad = flanking_pad
              )
              for (cb in cass_result$blocks) {
                blocks[[length(blocks) + 1]] <- cb
              }
              bsmbi_parts <- c(bsmbi_parts, cass_result$part_names)
            } else {
              # Fallback: build oversized single block (QC will flag it)
              block_name <- paste0("bsmbi_3wt_tile", tile$tile_id)
              block_seq <- create_bsmbi_block(paste0(wt_3prime_seq, polIII_for_block),
                tile$oh2_seq, oh3,
                oh3_spacer = oh3_spacer,
                flanking_pad = flanking_pad
              )
              blocks[[length(blocks) + 1]] <- data.frame(
                block_name = block_name, sequence = block_seq,
                length = nchar(block_seq), enzyme_type = "BsmBI",
                gene_region = paste0("3wt_polIII_tile", tile$tile_id),
                oh_5 = tile$oh2_seq, oh_3 = oh3,
                stringsAsFactors = FALSE
              )
              bsmbi_parts <- block_name
            }
          } else {
            # Truly a single block (fits within max)
            block_name <- paste0("bsmbi_3wt_tile", tile$tile_id)
            block_seq <- create_bsmbi_block(paste0(wt_3prime_seq, polIII_for_block),
              tile$oh2_seq, oh3,
              oh3_spacer = oh3_spacer,
              flanking_pad = flanking_pad
            )
            blocks[[length(blocks) + 1]] <- data.frame(
              block_name = block_name, sequence = block_seq,
              length = nchar(block_seq), enzyme_type = "BsmBI",
              gene_region = paste0("3wt_polIII_tile", tile$tile_id),
              oh_5 = tile$oh2_seq, oh_3 = oh3,
              stringsAsFactors = FALSE
            )
            bsmbi_parts <- block_name
          }
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
            # If dropping this split would make the remaining block become the
            # last sub-block, include PolIII length in the overflow check.
            # Without this, merging near-boundary tiles with gene content just
            # under max_sub_content can produce oversized blocks once PolIII
            # is appended.
            remaining_splits_after <- if (j < length(internal_splits)) {
              any(keep_idx[(j + 1L):length(keep_idx)])
            } else {
              FALSE
            }
            if (!remaining_splits_after) {
              merged_gap <- merged_gap + nchar(polIII_for_block)
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
          # If dropping this split produces a single block, include PolIII
          if (length(internal_splits) == 1L) {
            merged <- merged + nchar(polIII_for_block)
          }
          if (merged > max_sub_content) break # can't merge safely
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

        # Check if the last sub-block (gene + cassette) needs cassette splitting.
        # This happens when the cassette is so large that even a small amount of
        # gene content in the last sub-block causes an oversize.
        last_gene_len <- split_points[n_sub + 1L] - split_points[n_sub]
        last_total <- last_gene_len + nchar(polIII_for_block) + block_overhead
        needs_cassette_split <- last_total > max_block_length &&
          use_precomputed_splits &&
          !is.null(assembly_plan$oh_fidelity_used)

        # Pre-compute cassette splits if needed (shared across sub-block loop)
        cassette_splits_df <- NULL
        use_sb_dp_cass_p2 <- FALSE
        if (needs_cassette_split) {
          # Use pre-computed SB DP cassette splits if available, else greedy
          if (!is.null(assembly_plan$cassette_splits) &&
            nrow(assembly_plan$cassette_splits) > 0) {
            cassette_splits_df <- assembly_plan$cassette_splits
            use_sb_dp_cass_p2 <- TRUE
            cli::cli_alert_info(paste0(
              "Tile ", tile$tile_id, ": using ", nrow(cassette_splits_df),
              " pre-computed SB DP cassette split(s)."
            ))
          } else {
            # Exclude ALL tiles' oh2 + internal junctions — blocks shared via dedup
            cass_exclude <- unique(c(
              oh3, all_oh2, internal_oh,
              vapply(c(oh3, all_oh2, internal_oh), reverse_complement, character(1))
            ))
            cassette_splits_df <- find_cassette_split_points(
              cassette_seq = polIII_for_block,
              max_sub_length = max_sub_content,
              existing_ohs = cass_exclude,
              oh_fidelity = assembly_plan$oh_fidelity_used
            )
          }
        }

        for (s in seq_len(n_sub)) {
          sub_start <- split_points[s] + 1L
          sub_end <- split_points[s + 1L]
          if (s < n_sub) {
            # Trim trailing 4 nt (junction OH) — provided by next sub-block's BsmBI_fwd
            sub_seq <- substring(cds, sub_start, sub_end - 4L)
          } else if (needs_cassette_split && use_sb_dp_cass_p2 &&
            nrow(cassette_splits_df) > 0) {
            # SB DP path: last gene sub-block carries gene + cassette prefix,
            # trimmed by 4 nt (junction OH convention for BsmBI blocks).
            first_split_pos_p2 <- as.integer(cassette_splits_df$split_pos[1L])
            gene_residual <- nchar(substring(cds, sub_start, sub_end))
            content_len_p2 <- gene_residual + first_split_pos_p2 - 4L
            if (content_len_p2 > gene_residual) {
              sub_seq <- paste0(
                substring(cds, sub_start, sub_end),
                substring(polIII_for_block, 1L, content_len_p2 - gene_residual)
              )
            } else {
              sub_seq <- substring(cds, sub_start, sub_start + content_len_p2 - 1L)
            }
          } else if (needs_cassette_split && !is.null(cassette_splits_df) &&
            nrow(cassette_splits_df) > 0) {
            # Greedy fallback: gene content only (cassette goes in separate fragments)
            sub_seq <- substring(cds, sub_start, sub_end)
          } else {
            # Last sub-block: no trimming, and append PolIII
            sub_seq <- paste0(substring(cds, sub_start, sub_end), polIII_for_block)
          }

          block_name <- paste0("bsmbi_3wt_tile", tile$tile_id, "_sub", s)
          if (s < n_sub) {
            oh_5_sub <- if (s == 1L) tile$oh2_seq else internal_oh[s - 1L]
            oh_3_sub <- internal_oh[s]
            spacer_for_sub <- NULL
          } else if (needs_cassette_split && use_sb_dp_cass_p2 &&
            nrow(cassette_splits_df) > 0) {
            # SB DP path: junction OH comes from SB DP
            oh_5_sub <- if (s == 1L) tile$oh2_seq else internal_oh[s - 1L]
            oh_3_sub <- cassette_splits_df$junction_oh[1L]
            spacer_for_sub <- NULL
          } else if (needs_cassette_split && !is.null(cassette_splits_df) &&
            nrow(cassette_splits_df) > 0) {
            # Greedy fallback: derive junction from first 4 nt of cassette
            oh_5_sub <- if (s == 1L) tile$oh2_seq else internal_oh[s - 1L]
            first_cass_oh <- substring(polIII_for_block, 1, 4)
            cass_exclude_all <- unique(c(
              oh3, tile$oh2_seq, internal_oh,
              cassette_splits_df$junction_oh,
              vapply(c(
                oh3, tile$oh2_seq, internal_oh,
                cassette_splits_df$junction_oh
              ), reverse_complement, character(1))
            ))
            if (first_cass_oh %in% cass_exclude_all ||
              first_cass_oh %in% HOMOPOLYMER_4NT) {
              first_cass_oh <- substring(polIII_for_block, 2, 5)
            }
            oh_3_sub <- first_cass_oh
            spacer_for_sub <- NULL
          } else {
            oh_5_sub <- if (s == 1L) tile$oh2_seq else internal_oh[s - 1L]
            oh_3_sub <- oh3
            spacer_for_sub <- oh3_spacer
          }

          block_seq <- create_bsmbi_block(sub_seq, oh_5_sub, oh_3_sub,
            oh3_spacer = spacer_for_sub,
            flanking_pad = flanking_pad
          )

          gene_region_prefix <- if (s == n_sub && !(needs_cassette_split &&
            !is.null(cassette_splits_df) && nrow(cassette_splits_df) > 0)) {
            "3wt_polIII_tile"
          } else {
            "3wt_tile"
          }
          blocks[[length(blocks) + 1]] <- data.frame(
            block_name = block_name, sequence = block_seq,
            length = nchar(block_seq), enzyme_type = "BsmBI",
            gene_region = paste0(gene_region_prefix, tile$tile_id, "_sub", s),
            oh_5 = oh_5_sub, oh_3 = oh_3_sub,
            stringsAsFactors = FALSE
          )
          bsmbi_parts <- c(bsmbi_parts, block_name)
        }

        # Build cassette fragment sub-blocks if cassette was split
        if (needs_cassette_split && !is.null(cassette_splits_df) &&
          nrow(cassette_splits_df) > 0) {
          if (use_sb_dp_cass_p2) {
            # SB DP path: remaining cassette starts after first split point
            first_sp <- as.integer(cassette_splits_df$split_pos[1L])
            remaining_cassette_p2 <- substring(polIII_for_block, first_sp + 1L)
            remaining_splits_p2 <- cassette_splits_df[-1L, , drop = FALSE]
            if (nrow(remaining_splits_p2) > 0L) {
              remaining_splits_p2$split_pos <- remaining_splits_p2$split_pos - first_sp
            }
            cass_result <- build_cassette_subblocks(
              cassette_seq = remaining_cassette_p2,
              oh_5 = oh_3_sub, # junction OH from SB DP
              oh_3_final = oh3,
              oh3_spacer = oh3_spacer,
              tile_id = tile$tile_id,
              sub_offset = n_sub,
              cassette_splits = remaining_splits_p2,
              max_block_length = max_block_length,
              flanking_pad = flanking_pad
            )
          } else {
            # Greedy fallback: full cassette with greedy splits
            cass_result <- build_cassette_subblocks(
              cassette_seq = polIII_for_block,
              oh_5 = oh_3_sub, # continues from last gene sub-block's oh_3
              oh_3_final = oh3,
              oh3_spacer = oh3_spacer,
              tile_id = tile$tile_id,
              sub_offset = n_sub,
              cassette_splits = cassette_splits_df,
              max_block_length = max_block_length,
              flanking_pad = flanking_pad
            )
          }
          for (cb in cass_result$blocks) {
            blocks[[length(blocks) + 1]] <- cb
          }
          bsmbi_parts <- c(bsmbi_parts, cass_result$part_names)
        }
      }
    } else {
      # This is the last tile — only PolIII/cassette fragment (no gene content)
      # When oh_R extends the tile into the cassette, the oligo already carries
      # the first cassette_on_oligo nucleotides. The gene block contains only
      # the REMAINING cassette (after the oh_R position).
      cassette_on_oligo <- max(0L, tile$end_nt - gene_len)
      remaining_cassette <- if (cassette_on_oligo > 0L) {
        substring(polIII_for_block, cassette_on_oligo + 1L)
      } else {
        polIII_for_block
      }

      remaining_cass_block_len <- nchar(remaining_cassette) + block_overhead
      if (remaining_cass_block_len > max_block_length && use_precomputed_splits &&
        !is.null(assembly_plan$oh_fidelity_used)) {
        # Cassette alone is oversized — split it
        # Use pre-computed SB DP cassette splits if available, else greedy
        # Adjust pre-computed split positions by the cassette prefix on the oligo
        if (!is.null(assembly_plan$cassette_splits) &&
          nrow(assembly_plan$cassette_splits) > 0) {
          cass_splits <- assembly_plan$cassette_splits
          if (cassette_on_oligo > 0L) {
            cass_splits$split_pos <- cass_splits$split_pos - cassette_on_oligo
            cass_splits <- cass_splits[cass_splits$split_pos > 0L, , drop = FALSE]
          }
          cli::cli_alert_info(paste0(
            "Tile ", tile$tile_id, ": using ", nrow(cass_splits),
            " pre-computed SB DP cassette split(s).",
            if (cassette_on_oligo > 0L) paste0(
              " (adjusted by ", cassette_on_oligo, " nt oligo prefix)"
            ) else ""
          ))
        } else {
          # Exclude ALL tiles' oh2 — cassette sub-blocks are shared via dedup
          cass_exclude <- unique(c(
            oh3, all_oh2,
            vapply(c(oh3, all_oh2), reverse_complement, character(1))
          ))
          cass_splits <- find_cassette_split_points(
            cassette_seq = remaining_cassette,
            max_sub_length = max_sub_content,
            existing_ohs = cass_exclude,
            oh_fidelity = assembly_plan$oh_fidelity_used
          )
        }
        if (nrow(cass_splits) > 0) {
          cass_result <- build_cassette_subblocks(
            cassette_seq = remaining_cassette,
            oh_5 = tile$oh2_seq,
            oh_3_final = oh3,
            oh3_spacer = oh3_spacer,
            tile_id = tile$tile_id,
            sub_offset = 0L,
            cassette_splits = cass_splits,
            max_block_length = max_block_length,
            flanking_pad = flanking_pad
          )
          for (cb in cass_result$blocks) {
            blocks[[length(blocks) + 1]] <- cb
          }
          bsmbi_parts <- cass_result$part_names
        } else {
          # Fallback: couldn't find split points, build as single block (will be flagged by QC)
          block_name <- paste0("bsmbi_polIII_tile", tile$tile_id)
          block_seq <- create_bsmbi_block(remaining_cassette, tile$oh2_seq, oh3,
            oh3_spacer = oh3_spacer,
            flanking_pad = flanking_pad
          )
          blocks[[length(blocks) + 1]] <- data.frame(
            block_name = block_name, sequence = block_seq,
            length = nchar(block_seq), enzyme_type = "BsmBI",
            gene_region = paste0("polIII_tile", tile$tile_id),
            oh_5 = tile$oh2_seq, oh_3 = oh3,
            stringsAsFactors = FALSE
          )
          bsmbi_parts <- block_name
        }
      } else {
        # Cassette fits in one block
        block_name <- paste0("bsmbi_polIII_tile", tile$tile_id)
        block_seq <- create_bsmbi_block(remaining_cassette, tile$oh2_seq, oh3,
          oh3_spacer = oh3_spacer,
          flanking_pad = flanking_pad
        )

        blocks[[length(blocks) + 1]] <- data.frame(
          block_name = block_name, sequence = block_seq,
          length = nchar(block_seq), enzyme_type = "BsmBI",
          gene_region = paste0("polIII_tile", tile$tile_id),
          oh_5 = tile$oh2_seq, oh_3 = oh3,
          stringsAsFactors = FALSE
        )
        bsmbi_parts <- block_name
      }
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

  # Design helper plasmid insert (oh_L already extracted at top of function)
  helper <- design_helper_plasmid(oh_L, oh4, paqci_star2, paqci_star1)

  # Check block lengths
  over_limit <- all_blocks$length > max_block_length
  if (any(over_limit)) {
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
#' @param flanking_pad Flanking DNA added outside enzyme sites for efficient
#'   Type IIs cleavage at linear fragment termini. Default "" (no pad).
#' @return Complete block sequence with flanking BsaI sites
create_bsai_block <- function(gene_seq, oh_5prime, oh_3prime, flanking_pad = "") {
  bsai_fwd <- orient_enzyme_site("BsaI", oh_5prime, "forward")
  bsai_rev <- orient_enzyme_site("BsaI", oh_3prime, "reverse")
  # gene_seq starts with oh_5prime — trim to avoid duplication with bsai_fwd
  gene_interior <- substring(gene_seq, nchar(oh_5prime) + 1L)
  paste0(flanking_pad, bsai_fwd, gene_interior, bsai_rev, flanking_pad)
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
#' @param flanking_pad Flanking DNA added outside enzyme sites for efficient
#'   Type IIs cleavage at linear fragment termini. Default "" (no pad).
#' @return Complete block sequence with flanking BsmBI sites
create_bsmbi_block <- function(gene_seq, oh_5prime, oh_3prime, oh3_spacer = NULL,
                               flanking_pad = "") {
  bsmbi_fwd <- orient_enzyme_site("BsmBI", oh_5prime, "forward")
  bsmbi_rev <- orient_enzyme_site("BsmBI", oh_3prime, "reverse", spacer_seq = oh3_spacer)
  paste0(flanking_pad, bsmbi_fwd, gene_seq, bsmbi_rev, flanking_pad)
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
  stuffer <- "NNNNNNNNNNNNNNNNNNNN" # 20 nt placeholder

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
  if (nrow(blocks) == 0) {
    return(list(blocks = blocks, name_map = list()))
  }

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

#' Recompute per-reaction set fidelity from actual block overhangs
#'
#' After block construction, some split points may have been filtered out
#' (merged sub-blocks). The pre-computed reaction_fidelity in assembly_plan
#' uses ALL junction OHs from all_splits, which may include phantom overhangs
#' that no longer exist in the final blocks. This function recomputes fidelity
#' using only the overhangs present in the actual blocks.
#'
#' @param geneblock_result List from design_wt_geneblocks()
#' @param assembly_plan List from plan_assembly()
#' @return Updated reaction_fidelity data frame with corrected set_fidelity,
#'   overhangs, and n_overhangs columns
recompute_reaction_fidelity <- function(geneblock_result, assembly_plan) {
  blocks <- geneblock_result$blocks
  manifests <- geneblock_result$tile_manifests
  n_tiles <- nrow(manifests)

  bsai_matrix <- load_pairwise_matrix("BsaI")
  bsmbi_matrix <- load_pairwise_matrix("BsmBI")

  oh_L <- assembly_plan$oh_L
  oh3 <- assembly_plan$oh3
  oh4 <- assembly_plan$oh4

  reaction_fidelity <- list()

  for (i in seq_len(n_tiles)) {
    manifest <- manifests[i, ]

    # --- BsaI reaction ---
    # Collect OHs from BsaI blocks + fixed oligo-contributed OHs (oh_L, oh4)
    bsai_ohs <- c(oh_L, oh4)
    if (nzchar(manifest$bsai_parts)) {
      bsai_part_names <- strsplit(manifest$bsai_parts, ";")[[1]]
      for (bp in bsai_part_names) {
        block_row <- blocks[blocks$block_name == bp, ]
        if (nrow(block_row) > 0) {
          bsai_ohs <- c(bsai_ohs, block_row$oh_5[1], block_row$oh_3[1])
        }
      }
    }
    bsai_ohs <- unique(bsai_ohs)
    bsai_result <- compute_set_fidelity(bsai_ohs, bsai_matrix)

    reaction_fidelity[[length(reaction_fidelity) + 1L]] <- data.frame(
      tile_id = manifest$tile_id, reaction_type = "BsaI",
      overhangs = paste(bsai_ohs, collapse = ";"),
      n_overhangs = length(bsai_ohs),
      set_fidelity = bsai_result$set_fidelity,
      stringsAsFactors = FALSE
    )

    # --- BsmBI reaction ---
    # Collect OHs from BsmBI blocks + fixed oh3
    bsmbi_ohs <- c(oh3)
    if (nzchar(manifest$bsmbi_parts)) {
      bsmbi_part_names <- strsplit(manifest$bsmbi_parts, ";")[[1]]
      for (bp in bsmbi_part_names) {
        block_row <- blocks[blocks$block_name == bp, ]
        if (nrow(block_row) > 0) {
          bsmbi_ohs <- c(bsmbi_ohs, block_row$oh_5[1], block_row$oh_3[1])
        }
      }
    }
    bsmbi_ohs <- unique(bsmbi_ohs)
    bsmbi_result <- compute_set_fidelity(bsmbi_ohs, bsmbi_matrix)

    reaction_fidelity[[length(reaction_fidelity) + 1L]] <- data.frame(
      tile_id = manifest$tile_id, reaction_type = "BsmBI",
      overhangs = paste(bsmbi_ohs, collapse = ";"),
      n_overhangs = length(bsmbi_ohs),
      set_fidelity = bsmbi_result$set_fidelity,
      stringsAsFactors = FALSE
    )
  }

  result <- do.call(rbind, reaction_fidelity)
  rownames(result) <- NULL
  result
}

