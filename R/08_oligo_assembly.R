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
  oligos <- data.frame(
    oligo_name = character(n),
    sequence   = character(n),
    length     = integer(n),
    variant_id = character(n),
    tile_id    = integer(n),
    stringsAsFactors = FALSE
  )

  for (i in seq_len(n)) {
    v <- variants[i, ]
    barcode <- barcodes[i]
    tile <- tiles[tiles$tile_id == v$tile_id, ]

    # Build the mutant tile mutable region
    # The mutable region is the tile interior EXCLUDING oh1 (first 4nt) and oh2 (last 4nt)
    mutant_tile_full <- build_mutant_tile(cds, v$position, v$mut_codon,
                                          tile$start_nt, tile$end_nt)
    # Extract just the mutable region (strip oh1 from front, oh2 from back)
    tile_len <- nchar(mutant_tile_full)
    mutable_region <- substring(mutant_tile_full, 5L, tile_len - 4L)

    # Build the universal oligo
    oligo_seq <- build_oligo(
      mutable_region = mutable_region,
      barcode   = barcode,
      oh1_seq   = tile$oh1_seq,
      oh2_seq   = tile$oh2_seq,
      oh3       = oh3,
      oh4       = oh4
    )

    oligos$oligo_name[i] <- paste0("oligo_", v$variant_id)
    oligos$sequence[i]   <- oligo_seq
    oligos$length[i]     <- nchar(oligo_seq)
    oligos$variant_id[i] <- v$variant_id
    oligos$tile_id[i]    <- v$tile_id
  }

  # Validate lengths
  over_limit <- oligos$length > max_oligo_length
  if (any(over_limit)) {
    n_over <- sum(over_limit)
    max_len <- max(oligos$length)
    cli::cli_warn(paste0(
      n_over, " oligo(s) exceed max length of ", max_oligo_length,
      " nt (max observed: ", max_len, " nt)."
    ))
  } else {
    cli::cli_alert_success(paste0(
      "All ", n, " oligos within length limit. ",
      "Range: ", min(oligos$length), "-", max(oligos$length), " nt."
    ))
  }

  oligos
}

#' Build the mutant tile nucleotide sequence
#'
#' Returns the full tile (including oh1 and oh2 flanks) with the mutation
#' applied. The caller strips oh1/oh2 to get just the mutable region.
#'
#' @param cds Full CDS
#' @param mut_position Codon position (1-based) of mutation
#' @param mut_codon Mutant codon
#' @param tile_start_nt Start nucleotide of tile (1-based)
#' @param tile_end_nt End nucleotide of tile (1-based)
#' @return Character string of mutant tile sequence (includes oh1/oh2 flanks)
build_mutant_tile <- function(cds, mut_position, mut_codon, tile_start_nt, tile_end_nt) {
  mut_cds <- replace_codon(cds, mut_position, mut_codon)
  substring(mut_cds, tile_start_nt, tile_end_nt)
}

#' Build a universal oligo sequence for the 3-enzyme architecture
#'
#' All tile types use the same structure:
#'   BsaI_fwd + oh1 + mutable_region + BsmBI_rev_oh2 + BsmBI_fwd_oh3 + barcode + BsaI_rev_oh4
#'
#' @param mutable_region Mutable portion of the tile (excludes oh1/oh2 flanks)
#' @param barcode Barcode sequence
#' @param oh1_seq 4-nt WT gene sequence at tile's 5' boundary
#' @param oh2_seq 4-nt WT gene sequence at tile's 3' boundary
#' @param oh3 Fixed BsmBI overhang (PolIII-barcode junction)
#' @param oh4 Fixed BsaI overhang (barcode-helper junction)
#' @return Complete oligo sequence
build_oligo <- function(mutable_region, barcode, oh1_seq, oh2_seq, oh3, oh4) {
  # 5' BsaI forward site: recognition + spacer (no overhang needed — oh1 IS the overhang)
  bsai_5prime <- paste0(ENZYMES$BsaI$recog,
                        paste(rep("A", ENZYMES$BsaI$spacer_len), collapse = ""))  # 7 nt

  # BsmBI reverse site embedding oh2: enzyme reads on complement strand
  bsmbi_oh2 <- orient_enzyme_site("BsmBI", oh2_seq, "reverse")  # 11 nt

  # BsmBI forward site embedding oh3
  bsmbi_oh3 <- orient_enzyme_site("BsmBI", oh3, "forward")  # 11 nt

  # 3' BsaI reverse site embedding oh4
  bsai_oh4 <- orient_enzyme_site("BsaI", oh4, "reverse")  # 11 nt

  paste0(bsai_5prime, oh1_seq, mutable_region, bsmbi_oh2, bsmbi_oh3, barcode, bsai_oh4)
}
