# Created: 2025-02-01
# Last updated: 2026-03-16 — Update stop codon exclusion rationale (experimental, not geometric)
# 04_mutation_design.R — Generate all single-AA substitutions + stops
# DMS Golden Gate Oligo Pipeline

#' Generate all single amino acid substitutions + stop codons + controls for a gene
#'
#' For each mutable position in the protein, generates:
#' - 19 missense mutations (all AAs except WT) using preferred human codons
#' - 1 nonsense (stop) mutation using the preferred stop codon
#' - 1 WT control (identical codon to wild-type, unique barcode for normalization)
#' - Optionally, 1 synonymous control (different codon, same AA) when enabled
#'
#' Each variant gets a `variant_type` column: "missense", "nonsense",
#' "wt_control", or "synonymous".
#'
#' Positions 1 (start Met) and n_codons (stop codon) are EXCLUDED because:
#' - Codon 1 (Met/ATG) always falls in the first tile's oh1 overhang,
#'   so its mutation is silently overridden during assembly.
#' - The last codon (stop) is excluded because read-through mutations
#'   are not of experimental interest in DMS.
#'
#' @param cds Character string of coding DNA sequence (domesticated)
#' @param codon_usage Data frame from load_codon_usage()
#' @param include_synonymous Logical; if TRUE, add one synonymous codon variant
#'   per position (using the highest-frequency alternative codon). Met and Trp
#'   positions are skipped (only one codon each). Default FALSE.
#' @return Data frame with columns:
#'   variant_id, position, wt_aa, wt_codon, mut_aa, mut_codon, variant_type
design_mutations <- function(cds, codon_usage, include_synonymous = FALSE) {
  codons <- extract_codons(cds)
  preferred <- get_preferred_codons(codon_usage)
  n_codons <- length(codons)

  # Skip codon 1 (start Met) and codon n_codons (stop) — see docstring
  mutable_positions <- 2L:(n_codons - 1L)
  n_mutable <- length(mutable_positions)

  # Pre-allocate: 21 base (19 missense + 1 stop + 1 WT) + up to 1 synonymous
  max_per_pos <- if (include_synonymous) 22L else 21L
  n_max <- n_mutable * max_per_pos
  results <- data.frame(
    variant_id = character(n_max),
    position = integer(n_max),
    wt_aa = character(n_max),
    wt_codon = character(n_max),
    mut_aa = character(n_max),
    mut_codon = character(n_max),
    variant_type = character(n_max),
    stringsAsFactors = FALSE
  )

  idx <- 1L
  n_syn_added <- 0L
  for (pos in mutable_positions) {
    wt_codon <- codons[pos]
    wt_aa <- translate_codon(wt_codon)

    # --- Missense + nonsense: all 20 target AAs except WT identity ---
    target_aas <- AA_ALL[AA_ALL != wt_aa]

    for (mut_aa in target_aas) {
      mut_codon <- preferred[mut_aa]
      # Classify: nonsense if stop codon, otherwise missense
      vtype <- if (mut_aa == "*") "nonsense" else "missense"

      results$variant_id[idx] <- paste0(wt_aa, pos, mut_aa)
      results$position[idx] <- pos
      results$wt_aa[idx] <- wt_aa
      results$wt_codon[idx] <- wt_codon
      results$mut_aa[idx] <- mut_aa
      results$mut_codon[idx] <- mut_codon
      results$variant_type[idx] <- vtype
      idx <- idx + 1L
    }

    # --- WT control: same codon as wild-type, unique barcode(s) ---
    results$variant_id[idx] <- paste0(wt_aa, pos, "=")
    results$position[idx] <- pos
    results$wt_aa[idx] <- wt_aa
    results$wt_codon[idx] <- wt_codon
    results$mut_aa[idx] <- wt_aa
    results$mut_codon[idx] <- wt_codon
    results$variant_type[idx] <- "wt_control"
    idx <- idx + 1L

    # --- Synonymous control (optional): different codon, same AA ---
    if (include_synonymous) {
      # Get all codons for this AA ranked by frequency, pick first != wt_codon
      ranked <- get_ranked_codons(wt_aa, codon_usage)
      alt_codons <- ranked[ranked != wt_codon]
      # Met (M) and Trp (W) have only one codon — no synonymous variant possible
      if (length(alt_codons) > 0) {
        syn_codon <- alt_codons[1]
        results$variant_id[idx] <- paste0(wt_aa, pos, "syn")
        results$position[idx] <- pos
        results$wt_aa[idx] <- wt_aa
        results$wt_codon[idx] <- wt_codon
        results$mut_aa[idx] <- wt_aa
        results$mut_codon[idx] <- syn_codon
        results$variant_type[idx] <- "synonymous"
        idx <- idx + 1L
        n_syn_added <- n_syn_added + 1L
      }
    }
  }

  # Trim over-allocation
  results <- results[seq_len(idx - 1L), , drop = FALSE]

  # Build summary message
  n_missense <- sum(results$variant_type == "missense")
  n_nonsense <- sum(results$variant_type == "nonsense")
  n_wt <- sum(results$variant_type == "wt_control")
  type_parts <- paste0(
    n_missense, " missense + ", n_nonsense, " nonsense + ", n_wt, " WT controls"
  )
  if (include_synonymous) {
    type_parts <- paste0(type_parts, " + ", n_syn_added, " synonymous")
  }

  cli::cli_alert_success(paste0(
    "Designed ", nrow(results), " variants across ", n_mutable,
    " mutable positions (codons 2-", n_codons - 1L,
    "; skipped codon 1=Met and codon ", n_codons, "=stop). ",
    "[", type_parts, "]"
  ))

  results
}

#' Post-check: scan mutant codons in tile context for inadvertent enzyme sites
#'
#' For each variant, check if substituting the mutant codon creates a new
#' BsmBI or PaqCI site spanning the mutation region. If so, swap to the next
#' best codon for that amino acid.
#'
#' WT control variants are skipped — their codon is identical to the
#' domesticated CDS, so no new sites can be introduced.
#'
#' @param variants Data frame from design_mutations()
#' @param cds Character string of coding DNA sequence (domesticated)
#' @param codon_usage Data frame from load_codon_usage()
#' @return Modified variants data frame with safe codons
check_and_fix_new_sites <- function(variants, cds, codon_usage) {
  n_fixed <- 0L

  for (i in seq_len(nrow(variants))) {
    # Skip WT controls — their codon is the domesticated WT, already site-free
    if (!is.null(variants$variant_type) &&
      variants$variant_type[i] == "wt_control") {
      next
    }

    pos <- variants$position[i]
    mut_codon <- variants$mut_codon[i]
    mut_aa <- variants$mut_aa[i]

    # Create the mutant CDS and check a window around the mutation
    mut_cds <- replace_codon(cds, pos, mut_codon)
    # Check a window of 14 nt on each side (enough for any 7-nt recognition site)
    nt_start <- (pos - 1L) * 3L + 1L
    win_start <- max(1L, nt_start - 14L)
    win_end <- min(nchar(mut_cds), nt_start + 2L + 14L)
    window <- substring(mut_cds, win_start, win_end)

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
