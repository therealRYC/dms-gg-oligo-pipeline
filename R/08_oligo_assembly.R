# Created: 2025-02-01
# Last updated: 2026-03-18 — PCR handles + upstream_cassette (oh_L architecture)
# 08_oligo_assembly.R — Assemble universal oligo sequences for 3-enzyme architecture
# DMS Golden Gate Oligo Pipeline
#
# Universal oligo structure (ALL tile types — no tile-type-specific logic):
#
#   5'—[fwd_handle]—BsaI_fwd(7)—oh1(4)—[mutable region]—BsmBI_rev_oh2(11)—BsmBI_fwd_oh3(11)—barcode(12)—BsaI_rev_oh4(11)—[rev_handle]—3'
#
# For tile 1 (gene start), oh1 = oh_L (external, upstream of ATG):
#   mutable region = upstream_cassette + ATG + [codons 2+] ... oh2_boundary
# For other tiles, oh1 = gene-derived 4 nt at tile boundary:
#   mutable region = tile interior (strip oh1=4nt front, oh2=4nt back)
#
# Where:
#   fwd_handle = optional PCR handle for tile-specific amplification (0 nt if not used)
#   BsaI_fwd = GGTCTC + A (recognition + 1nt spacer) = 7 nt
#   oh1      = 4 nt overhang (BsaI): oh_L for tile 1, gene-derived for others
#   mutable  = tile interior where mutation occurs
#   BsmBI_rev_oh2 = RC(CGTCTC + A + oh2) = 11 nt (BsmBI reads on complement)
#   BsmBI_fwd_oh3 = CGTCTC + A + oh3 = 11 nt
#   barcode  = 12 nt programmed barcode
#   BsaI_rev_oh4 = RC(GGTCTC + A + oh4) = 11 nt
#   rev_handle = optional PCR handle for tile-specific amplification (0 nt if not used)

#' Assemble complete oligo sequences for all variants
#'
#' Uses the universal 3-enzyme oligo structure — every tile type has the
#' same oligo layout. No tile-type-specific logic needed.
#'
#' Performance: vectorized by tile. Instead of per-oligo full-CDS rebuilds and
#' repeated enzyme site computation, this version:
#'   (A) Pre-extracts WT tile regions and mutates locally within the ~230nt tile
#'   (B) Pre-computes all enzyme site strings (constant across oligos)
#'   (C) Uses vectorized paste0() per tile to build all oligos at once
#'
#' @param variants Data frame with variant info including tile_id
#' @param cds Character string of domesticated CDS
#' @param barcodes Character vector of barcodes (one per variant row)
#' @param tiles Data frame from partition_tiles() (must include oh1_seq, oh2_seq)
#' @param oh3 Fixed BsmBI overhang at PolIII-barcode junction
#' @param oh4 Fixed BsaI overhang at barcode-helper junction
#' @param max_oligo_length Maximum oligo length
#' @param full_seq Full sequence (gene + core cassette) for tiles that extend
#'   past the gene end (oh_R feature). When NULL, uses cds only (backward
#'   compatible). Required when the last tile's end_nt exceeds nchar(cds).
#' @param pcr_handles Optional list of per-tile PCR handle pairs. Each element
#'   has $fwd and $rev character fields. Handles are prepended/appended outside
#'   the BsaI sites for tile-specific amplification from pooled oligos. When
#'   NULL, no handles are added (backward compatible).
#' @param upstream_cassette Sequence between oh_L and ATG (default "")
#' @return Data frame with oligo_name, sequence, length, variant_id, tile_id
assemble_oligos <- function(variants, cds, barcodes, tiles,
                            oh3, oh4,
                            max_oligo_length = MAX_OLIGO_LENGTH,
                            full_seq = NULL,
                            pcr_handles = NULL,
                            upstream_cassette = "") {
  n <- nrow(variants)

  # --- (B) Pre-compute invariant enzyme site strings ---
  # These are constant for ALL oligos — compute once, not n times.
  bsai_5prime <- paste0(
    ENZYMES$BsaI$recog,
    paste(rep("A", ENZYMES$BsaI$spacer_len), collapse = "")
  )
  bsmbi_oh3_str <- orient_enzyme_site("BsmBI", oh3, "forward")
  bsai_oh4_str <- orient_enzyme_site("BsaI", oh4, "reverse")

  # --- (A) Pre-extract WT tile regions and per-tile enzyme sites ---
  n_tiles <- nrow(tiles)
  wt_tile_seqs <- character(n_tiles)
  tile_oh1 <- tiles$oh1_seq
  tile_oh2_rev <- character(n_tiles)
  tile_start_nt <- tiles$start_nt
  tile_lens <- integer(n_tiles)

  gene_len <- nchar(cds)
  for (t in seq_len(n_tiles)) {
    # Use full_seq when tile extends past gene end (oh_R cassette extension)
    source <- if (tiles$end_nt[t] > gene_len && !is.null(full_seq)) full_seq else cds
    wt_tile_seqs[t] <- substring(source, tiles$start_nt[t], tiles$end_nt[t])
    tile_oh2_rev[t] <- orient_enzyme_site("BsmBI", tiles$oh2_seq[t], "reverse")
    tile_lens[t] <- tiles$end_nt[t] - tiles$start_nt[t] + 1L
  }

  # --- Per-tile PCR handles (empty strings when not provided) ---
  fwd_handles <- rep("", n_tiles)
  rev_handles <- rep("", n_tiles)
  if (!is.null(pcr_handles)) {
    for (t in seq_len(min(n_tiles, length(pcr_handles)))) {
      fwd_handles[t] <- pcr_handles[[t]]$fwd
      rev_handles[t] <- pcr_handles[[t]]$rev
    }
  }

  # --- (C) Pre-allocate output vectors ---
  oligo_names <- character(n)
  sequences <- character(n)

  # --- Vectorize by tile: build all oligos for each tile at once ---
  for (tid in seq_len(n_tiles)) {
    idx <- which(variants$tile_id == tid)
    if (length(idx) == 0L) next

    wt_tile <- wt_tile_seqs[tid]
    t_start <- tile_start_nt[tid]
    t_len <- tile_lens[tid]

    # (A) Local mutation: codon start position within tile (1-based)
    # Instead of rebuilding the full CDS per oligo, mutate within the ~230nt tile
    cs <- (variants$position[idx] - 1L) * 3L + 1L - t_start + 1L

    # Build mutant tiles locally — vectorized via substring() recycling
    # substring(scalar_text, vector_first, vector_last) → character vector
    mutant_tiles <- paste0(
      substring(wt_tile, 1L, cs - 1L),
      variants$mut_codon[idx],
      substring(wt_tile, cs + 3L)
    )

    # Extract mutable regions.
    # Tile 1 (start_nt == 1): oh1 is external (oh_L, upstream of CDS), so the
    # entire CDS tile from position 1 is mutable. Prepend upstream_cassette.
    # Other tiles: strip oh1=4nt front, oh2=4nt back.
    if (tile_start_nt[tid] == 1L) {
      mutable_regions <- paste0(upstream_cassette, substring(mutant_tiles, 1L, t_len - 4L))
    } else {
      mutable_regions <- substring(mutant_tiles, 5L, t_len - 4L)
    }

    # (C) Vectorized oligo assembly — single paste0 for all variants in tile
    # fwd/rev handles are "" when pcr_handles is NULL (zero-cost backward compat)
    sequences[idx] <- paste0(
      fwd_handles[tid],
      bsai_5prime,
      tile_oh1[tid],
      mutable_regions,
      tile_oh2_rev[tid],
      bsmbi_oh3_str,
      barcodes[idx],
      bsai_oh4_str,
      rev_handles[tid]
    )
    # Include barcode_idx in name when barcodes_per_variant > 1 to ensure uniqueness
    if ("barcode_idx" %in% names(variants) && max(variants$barcode_idx) > 1L) {
      oligo_names[idx] <- paste0(
        "oligo_", variants$variant_id[idx],
        "_b", variants$barcode_idx[idx]
      )
    } else {
      oligo_names[idx] <- paste0("oligo_", variants$variant_id[idx])
    }
  }

  lengths <- nchar(sequences)

  # Build output data frame once at end (avoids per-row assignment overhead)
  oligos <- data.frame(
    oligo_name = oligo_names,
    sequence = sequences,
    length = lengths,
    variant_id = variants$variant_id,
    tile_id = variants$tile_id,
    stringsAsFactors = FALSE
  )

  # Validate lengths
  over_limit <- lengths > max_oligo_length
  if (any(over_limit)) {
    n_over <- sum(over_limit)
    max_len <- max(lengths)
    cli::cli_warn(paste0(
      n_over, " oligo(s) exceed max length of ", max_oligo_length,
      " nt (max observed: ", max_len, " nt)."
    ))
  } else {
    cli::cli_alert_success(paste0(
      "All ", n, " oligos within length limit. ",
      "Range: ", min(lengths), "-", max(lengths), " nt."
    ))
  }

  oligos
}
