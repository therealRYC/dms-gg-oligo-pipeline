# Created: 2025-02-01
# Last updated: 2026-03-01 — Remove dead functions build_mutant_tile() and build_oligo()
# 08_oligo_assembly.R — Assemble universal oligo sequences for 3-enzyme architecture
# DMS Golden Gate Oligo Pipeline
#
# Universal oligo structure (ALL tile types — no tile-type-specific logic):
#
#   5'—BsaI_fwd(7)—oh1(4)—[mutable region]—BsmBI_rev_oh2(11)—BsmBI_fwd_oh3(11)—barcode(12)—BsaI_rev_oh4(11)—3'
#
# Where:
#   BsaI_fwd = GGTCTC + A (recognition + 1nt spacer) = 7 nt
#   oh1      = 4 nt WT gene sequence at tile's 5' boundary (BsaI overhang)
#   mutable  = tile interior where mutation occurs
#   BsmBI_rev_oh2 = RC(CGTCTC + A + oh2) = 11 nt (BsmBI reads on complement)
#   BsmBI_fwd_oh3 = CGTCTC + A + oh3 = 11 nt
#   barcode  = 12 nt programmed barcode
#   BsaI_rev_oh4 = RC(GGTCTC + A + oh4) = 11 nt

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
#' @return Data frame with oligo_name, sequence, length, variant_id, tile_id
assemble_oligos <- function(variants, cds, barcodes, tiles,
                            oh3, oh4,
                            max_oligo_length = MAX_OLIGO_LENGTH) {
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

  for (t in seq_len(n_tiles)) {
    wt_tile_seqs[t] <- substring(cds, tiles$start_nt[t], tiles$end_nt[t])
    tile_oh2_rev[t] <- orient_enzyme_site("BsmBI", tiles$oh2_seq[t], "reverse")
    tile_lens[t] <- tiles$end_nt[t] - tiles$start_nt[t] + 1L
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

    # Extract mutable regions (strip oh1=4nt front, oh2=4nt back)
    mutable_regions <- substring(mutant_tiles, 5L, t_len - 4L)

    # (C) Vectorized oligo assembly — single paste0 for all variants in tile
    sequences[idx] <- paste0(
      bsai_5prime,
      tile_oh1[tid],
      mutable_regions,
      tile_oh2_rev[tid],
      bsmbi_oh3_str,
      barcodes[idx],
      bsai_oh4_str
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
