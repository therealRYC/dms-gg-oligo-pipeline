# Created: 2025-02-01
# Last updated: 2026-02-20 — Add tile overlap and smart variant-to-tile assignment (BUG-1)
# 05_tiling.R — Partition gene into tiles for 3-enzyme Golden Gate assembly
# DMS Golden Gate Oligo Pipeline
#
# In the 3-enzyme architecture, every oligo has the same universal structure:
#   BsaI(7) + oh1(4) + mutable_region + BsmBI_rev_oh2(11) + BsmBI_fwd_oh3(11) + barcode + BsaI_rev_oh4(11)
#
# oh1 and oh2 are WT gene flanks (invariant even on mutant oligos).
# Codons overlapping oh1/oh2 are NOT mutated by that tile — they're covered
# by the adjacent tile's mutable interior (via tile overlap).

#' Compute the maximum mutable region size in nucleotides
#'
#' Universal oligo structure (all tile types):
#'   BsaI_recog+spacer (7nt) + oh1_WT_flank (4nt) + [mutable region] +
#'   BsmBI_rev_oh2 (11nt) + BsmBI_fwd_oh3 (11nt) + barcode + BsaI_rev_oh4 (11nt)
#'
#' Total fixed overhead = 7 + 4 + 11 + 11 + barcode + 11 = 44 + barcode
#'
#' @param max_oligo_length Maximum oligo length (default 300)
#' @param barcode_length Barcode length in nt (default 12)
#' @return Integer max mutable region size in nucleotides (rounded to codon boundary)
compute_max_tile_size <- function(max_oligo_length = 300L,
                                  barcode_length = 12L) {
  # BsaI site = recognition(6) + spacer(1) = 7 nt (5' end, forward)
  bsai_5prime <- nchar(ENZYMES$BsaI$recog) + ENZYMES$BsaI$spacer_len  # 7

  # oh1 WT flank = 4 nt (BsaI overhang length)
  oh1_len <- ENZYMES$BsaI$oh_len  # 4

  # BsmBI reverse site for oh2 = recognition(6) + spacer(1) + overhang(4) = 11 nt
  bsmbi_site_len <- nchar(ENZYMES$BsmBI$recog) + ENZYMES$BsmBI$spacer_len +
                    ENZYMES$BsmBI$oh_len  # 11

  # BsmBI forward site for oh3 = 11 nt
  # BsaI reverse site for oh4 = recognition(6) + spacer(1) + overhang(4) = 11 nt
  bsai_site_len <- nchar(ENZYMES$BsaI$recog) + ENZYMES$BsaI$spacer_len +
                   ENZYMES$BsaI$oh_len  # 11

  # Total fixed overhead: BsaI_5'(7) + oh1(4) + BsmBI_oh2(11) + BsmBI_oh3(11) + barcode + BsaI_oh4(11)
  overhead <- bsai_5prime + oh1_len + bsmbi_site_len + bsmbi_site_len +
              barcode_length + bsai_site_len

  mutable_size <- max_oligo_length - overhead

  # Round down to nearest multiple of 3 (codon boundary)
  mutable_size <- (mutable_size %/% 3L) * 3L

  cli::cli_alert_info(paste0(
    "Max mutable region: ", mutable_size, " nt (",
    mutable_size %/% 3L, " codons) | Fixed overhead: ", overhead, " nt"
  ))

  mutable_size
}

#' Partition gene into tiles with oh1/oh2 invariant flanks (geometric, no HF search)
#'
#' NOTE: For production use, prefer plan_assembly() in 06_overhang_selection.R
#' which uses dynamic boundary search to place tile boundaries at positions where
#' the gene-derived overhangs fall within the high-fidelity set. This function
#' uses simple geometric partitioning (equal-sized tiles).
#'
#' Each tile consists of:
#'   oh1 (4nt WT flank) + mutable_codons + oh2 (4nt WT flank)
#'
#' Adjacent tiles overlap by `overlap_codons` so that codons near tile
#' boundaries (which fall in oh1/oh2 of one tile) are in the mutable interior
#' of the adjacent tile.
#'
#' @param cds Character string of coding DNA sequence
#' @param mutable_size_nt Max mutable region size in nucleotides (from compute_max_tile_size)
#' @param overlap_codons Number of codons to overlap between adjacent tiles (default 4)
#' @return Data frame with columns:
#'   tile_id, start_codon, end_codon (tile boundaries, 1-based),
#'   start_nt, end_nt (tile nt positions),
#'   oh1_seq, oh2_seq (4-nt WT flanking sequences),
#'   tile_seq (full tile = oh1 + mutable + oh2)
partition_tiles <- function(cds, mutable_size_nt, overlap_codons = 4L) {
  gene_len <- nchar(cds)
  n_codons <- gene_len %/% 3L

  mutable_codons <- mutable_size_nt %/% 3L

  # Effective step between tile starts: reduced by overlap so adjacent tiles share codons.
  # Each tile is still mutable_codons wide, but starts are closer together.
  effective_step <- mutable_codons - overlap_codons
  if (effective_step < 1L) effective_step <- 1L

  tile_starts <- seq(1L, n_codons, by = effective_step)
  n_tiles <- length(tile_starts)

  tiles <- data.frame(
    tile_id     = integer(n_tiles),
    start_codon = integer(n_tiles),
    end_codon   = integer(n_tiles),
    start_nt    = integer(n_tiles),
    end_nt      = integer(n_tiles),
    oh1_seq     = character(n_tiles),
    oh2_seq     = character(n_tiles),
    tile_seq    = character(n_tiles),
    stringsAsFactors = FALSE
  )

  for (i in seq_len(n_tiles)) {
    sc <- tile_starts[i]
    ec <- min(sc + mutable_codons - 1L, n_codons)
    sn <- (sc - 1L) * 3L + 1L  # start nt of tile
    en <- ec * 3L              # end nt of tile

    # oh1: first 4 nt of this tile (WT gene at tile's 5' boundary)
    oh1_seq <- substring(cds, sn, sn + 3L)

    # oh2: last 4 nt of this tile (WT gene at tile's 3' boundary)
    oh2_seq <- substring(cds, en - 3L, en)

    # Full tile sequence (for reference, from WT gene)
    tile_seq <- substring(cds, sn, en)

    tiles$tile_id[i]     <- i
    tiles$start_codon[i] <- sc
    tiles$end_codon[i]   <- ec
    tiles$start_nt[i]    <- sn
    tiles$end_nt[i]      <- en
    tiles$oh1_seq[i]     <- oh1_seq
    tiles$oh2_seq[i]     <- oh2_seq
    tiles$tile_seq[i]    <- tile_seq
  }

  cli::cli_alert_success(paste0(
    "Gene partitioned into ", n_tiles, " tile(s) covering ",
    n_codons, " codons (", mutable_codons, " codons/tile, ",
    overlap_codons, " codons overlap)"
  ))

  tiles
}

#' Assign each variant to the best tile for its mutation
#'
#' With overlapping tiles, a codon position may fall in multiple tiles.
#' This function prefers the tile where the codon is fully in the mutable
#' interior (not overlapping with oh1 or oh2). For gene-edge codons that
#' can only be in one tile and partially overlap oh1/oh2, the variant is
#' still assigned but flagged with an `overhang_note`.
#'
#' @param variants Data frame from design_mutations()
#' @param tiles Data frame from partition_tiles() or search_tile_boundaries_dp()
#' @return variants data frame with added tile_id and overhang_note columns
assign_variants_to_tiles <- function(variants, tiles) {
  # Build a lookup: for each codon position, find the best tile
  positions <- sort(unique(variants$position))
  max_pos <- max(positions)
  pos_tile <- integer(max_pos)
  pos_note <- character(max_pos)

  for (pos in positions) {
    codon_start_nt <- (pos - 1L) * 3L + 1L
    codon_end_nt <- pos * 3L

    best_tile <- NA_integer_
    best_quality <- -1L  # 2 = fully interior, 1 = partially in oh region

    for (t in seq_len(nrow(tiles))) {
      tile_start <- tiles$start_nt[t]
      tile_end <- tiles$end_nt[t]

      # Is this codon within this tile?
      if (codon_start_nt >= tile_start && codon_end_nt <= tile_end) {
        # Local positions within the tile
        local_start <- codon_start_nt - tile_start + 1L
        local_end <- codon_end_nt - tile_start + 1L
        tile_len <- tile_end - tile_start + 1L

        # Fully in mutable interior: past oh1 (4 nt) and before oh2 (last 4 nt)
        if (local_start >= 5L && local_end <= tile_len - 4L) {
          quality <- 2L
        } else {
          quality <- 1L
        }

        if (quality > best_quality) {
          best_quality <- quality
          best_tile <- tiles$tile_id[t]
        }
      }
    }

    pos_tile[pos] <- best_tile
    if (!is.na(best_tile) && best_quality == 1L) {
      pos_note[pos] <- "partial_oh_overlap"
    }
  }

  # Apply lookup to all variants (vectorized)
  variants$tile_id <- pos_tile[variants$position]
  variants$overhang_note <- pos_note[variants$position]
  variants$overhang_note[variants$overhang_note == ""] <- NA_character_

  if (any(is.na(variants$tile_id))) {
    unassigned <- unique(variants$position[is.na(variants$tile_id)])
    stop("Some variants were not assigned to any tile! Positions: ",
         paste(unassigned, collapse = ", "))
  }

  n_flagged <- sum(!is.na(variants$overhang_note))
  if (n_flagged > 0) {
    cli::cli_alert_warning(paste0(
      n_flagged, " variant(s) at gene edges have partial oh1/oh2 overlap. ",
      "These mutations may not fully assemble as intended."
    ))
  }

  variants
}

#' Compute superblock boundaries for long genes (geometric, no HF search)
#'
#' NOTE: For production use, prefer plan_assembly() in 06_overhang_selection.R
#' which uses optimize_split_points() to search for split positions where the
#' gene-derived junction overhang falls within the high-fidelity set. This
#' function places boundaries at tile boundaries without HF optimization.
#'
#' Walks tile boundaries left to right, placing superblock boundaries
#' when the accumulated gene length approaches the synthesis limit.
#' Boundaries are placed at tile boundaries where BsaI and BsmBI
#' overhangs have high fidelity.
#'
#' @param cds Character string of domesticated CDS
#' @param tiles Data frame from partition_tiles()
#' @param polIII_len Length of PolIII promoter in nt
#' @param max_block_length Maximum gene block synthesis length (default 1800)
#' @param oh_fidelity_data Data frame of overhang fidelity scores
#' @param fidelity_threshold Minimum fidelity for junction overhangs
#' @return Data frame with columns:
#'   boundary_id, after_tile_id, junction_nt (position in gene),
#'   junction_oh (4-nt overhang at this junction), fidelity_score
compute_superblock_boundaries <- function(cds, tiles, polIII_len = 250L,
                                           max_block_length = MAX_GENEBLOCK_LENGTH,
                                           oh_fidelity_data = NULL,
                                           fidelity_threshold = DEFAULT_FIDELITY_THRESHOLD) {
  n_tiles <- nrow(tiles)

  # If the gene is short enough, no superblocking needed
  # Each tile's WT blocks must fit within synthesis limits
  # Enzyme site overhead per block: ~22 nt (2 x 11-nt enzyme sites)
  block_overhead <- 22L
  gene_len <- nchar(cds)

  # Conservative check: would a single 5'WT or 3'WT block exceed the limit?
  # The longest possible block is the full gene + PolIII + overhead
  if (gene_len + polIII_len + block_overhead <= max_block_length) {
    # No superblocking needed
    return(data.frame(
      boundary_id = integer(0),
      after_tile_id = integer(0),
      junction_nt = integer(0),
      junction_oh = character(0),
      fidelity_score = numeric(0),
      stringsAsFactors = FALSE
    ))
  }

  if (is.null(oh_fidelity_data)) {
    oh_fidelity_data <- builtin_high_fidelity_overhangs()
  }

  # Target block size: leave room for enzyme site overhead and PolIII on last block
  target_size <- max_block_length - block_overhead - 50L  # 50 nt safety margin

  boundaries <- list()
  accumulated_len <- 0L
  boundary_id <- 0L

  for (i in seq_len(n_tiles - 1L)) {
    tile_end_nt <- tiles$end_nt[i]
    accumulated_len <- tile_end_nt  # total gene covered so far

    # Check if we need a boundary before the next tile
    next_tile_end <- tiles$end_nt[min(i + 1L, n_tiles)]
    # How long would the block be if we continued to include the next tile?
    projected_len <- next_tile_end - (if (boundary_id > 0) boundaries[[boundary_id]]$junction_nt else 0L)

    if (projected_len > target_size) {
      # Place boundary at this tile boundary
      junction_nt <- tile_end_nt
      # The overhang is the 4-nt sequence at this junction in the gene
      junction_oh <- substring(cds, junction_nt - 3L, junction_nt)

      # Look up fidelity
      fid <- oh_fidelity_data$fidelity[oh_fidelity_data$overhang == junction_oh]
      if (length(fid) == 0) fid <- 0.5  # unknown overhang

      boundary_id <- boundary_id + 1L
      boundaries[[boundary_id]] <- data.frame(
        boundary_id = boundary_id,
        after_tile_id = i,
        junction_nt = junction_nt,
        junction_oh = junction_oh,
        fidelity_score = fid,
        stringsAsFactors = FALSE
      )
    }
  }

  if (length(boundaries) == 0) {
    return(data.frame(
      boundary_id = integer(0),
      after_tile_id = integer(0),
      junction_nt = integer(0),
      junction_oh = character(0),
      fidelity_score = numeric(0),
      stringsAsFactors = FALSE
    ))
  }

  result <- do.call(rbind, boundaries)
  rownames(result) <- NULL

  cli::cli_alert_info(paste0(
    "Placed ", nrow(result), " superblock boundary(ies) at tile(s): ",
    paste(result$after_tile_id, collapse = ", ")
  ))

  result
}
