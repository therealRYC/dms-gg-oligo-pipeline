# 04_mutation_design.R — Generate all single-AA substitutions + stops
# DMS Golden Gate Oligo Pipeline

#' Generate all single amino acid substitutions + stop codons for a gene
#'
#' For each position in the protein, generates 19 missense mutations (all AAs
#' except WT) plus 1 nonsense mutation (stop), using the most preferred human
#' codon for each target amino acid.
#'
#' @param cds Character string of coding DNA sequence (domesticated)
#' @param codon_usage Data frame from load_codon_usage()
#' @return Data frame with columns:
#'   variant_id, position, wt_aa, wt_codon, mut_aa, mut_codon
design_mutations <- function(cds, codon_usage) {
  codons <- extract_codons(cds)
  preferred <- get_preferred_codons(codon_usage)
  n_codons <- length(codons)

  # Pre-allocate
  n_variants <- n_codons * 20L  # 19 AA + 1 stop per position
  results <- data.frame(
    variant_id = character(n_variants),
    position   = integer(n_variants),
    wt_aa      = character(n_variants),
    wt_codon   = character(n_variants),
    mut_aa     = character(n_variants),
    mut_codon  = character(n_variants),
    stringsAsFactors = FALSE
  )

  idx <- 1L
  for (pos in seq_len(n_codons)) {
    wt_codon <- codons[pos]
    wt_aa <- translate_codon(wt_codon)

    # Skip if WT is already a stop codon (shouldn't happen in validated CDS interior)
    target_aas <- AA_ALL[AA_ALL != wt_aa]

    for (mut_aa in target_aas) {
      mut_codon <- preferred[mut_aa]

      results$variant_id[idx] <- paste0(wt_aa, pos, mut_aa)
      results$position[idx]   <- pos
      results$wt_aa[idx]      <- wt_aa
      results$wt_codon[idx]   <- wt_codon
      results$mut_aa[idx]     <- mut_aa
      results$mut_codon[idx]  <- mut_codon
      idx <- idx + 1L
    }
  }

  # Trim if we over-allocated (positions with stop as WT have 20 targets)
  results <- results[seq_len(idx - 1L), , drop = FALSE]

  cli::cli_alert_success(paste0(
    "Designed ", nrow(results), " variants across ", n_codons, " positions."
  ))

  results
}

#' Post-check: scan mutant codons in tile context for inadvertent enzyme sites
#'
#' For each variant, check if substituting the mutant codon creates a new
#' BsmBI or PaqCI site spanning the mutation region. If so, swap to the next
#' best codon for that amino acid.
#'
#' @param variants Data frame from design_mutations()
#' @param cds Character string of coding DNA sequence (domesticated)
#' @param codon_usage Data frame from load_codon_usage()
#' @return Modified variants data frame with safe codons
check_and_fix_new_sites <- function(variants, cds, codon_usage) {
  n_fixed <- 0L

  for (i in seq_len(nrow(variants))) {
    pos       <- variants$position[i]
    mut_codon <- variants$mut_codon[i]
    mut_aa    <- variants$mut_aa[i]

    # Create the mutant CDS and check a window around the mutation
    mut_cds <- replace_codon(cds, pos, mut_codon)
    # Check a window of 14 nt on each side (enough for any 7-nt recognition site)
    nt_start <- (pos - 1L) * 3L + 1L
    win_start <- max(1L, nt_start - 14L)
    win_end   <- min(nchar(mut_cds), nt_start + 2L + 14L)
    window    <- substring(mut_cds, win_start, win_end)

    if (has_enzyme_sites(window)) {
      # Try alternative codons
      ranked <- get_ranked_codons(mut_aa, codon_usage)
      ranked <- ranked[ranked != mut_codon]
      fixed <- FALSE

      for (alt_codon in ranked) {
        alt_cds <- replace_codon(cds, pos, alt_codon)
        alt_window <- substring(alt_cds, win_start, win_end)
        if (!has_enzyme_sites(alt_window)) {
          variants$mut_codon[i] <- alt_codon
          n_fixed <- n_fixed + 1L
          fixed <- TRUE
          break
        }
      }

      if (!fixed) {
        cli::cli_warn(paste0(
          "Could not find enzyme-site-free codon for variant ",
          variants$variant_id[i], " at position ", pos
        ))
      }
    }
  }

  if (n_fixed > 0) {
    cli::cli_alert_info(paste0(
      "Fixed ", n_fixed, " variant(s) that would have created enzyme sites."
    ))
  }

  variants
}
