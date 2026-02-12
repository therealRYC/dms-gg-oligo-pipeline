# 02_enzyme_site_scan.R — Find endogenous BsaI/BsmBI/PaqCI sites, suggest silent mutations
# DMS Golden Gate Oligo Pipeline

#' Scan a gene and promoter for endogenous enzyme recognition sites
#'
#' Scans for all three assembly enzymes (BsaI, BsmBI, PaqCI) on both strands.
#' BsaI (GGTCTC) and BsmBI (CGTCTC) differ by only 1 nt, so fixing one can
#' create the other. This function uses iterative domestication to handle
#' such cases.
#'
#' @param cds Character string of coding DNA sequence
#' @param polIII Character string of PolIII promoter sequence
#' @param codon_usage Data frame of codon usage (from load_codon_usage())
#' @return List with components:
#'   - gene_sites: data frame of sites found in the gene
#'   - promoter_sites: data frame of sites found in the promoter
#'   - domestication: data frame of suggested silent mutations for gene sites
scan_enzyme_sites <- function(cds, polIII, codon_usage) {
  gene_sites <- data.frame(
    start = integer(0), end = integer(0), strand = character(0),
    match = character(0), enzyme = character(0),
    stringsAsFactors = FALSE
  )
  promoter_sites <- gene_sites

  for (enz_name in c("BsaI", "BsmBI", "PaqCI")) {
    enz <- ENZYMES[[enz_name]]

    # Scan gene
    gs <- find_enzyme_sites(cds, enz$recog)
    if (nrow(gs) > 0) {
      gs$enzyme <- enz_name
      gene_sites <- rbind(gene_sites, gs)
    }

    # Scan promoter
    ps <- find_enzyme_sites(polIII, enz$recog)
    if (nrow(ps) > 0) {
      ps$enzyme <- enz_name
      promoter_sites <- rbind(promoter_sites, ps)
    }
  }

  # Generate domestication suggestions for gene sites
  domestication <- data.frame(
    site_start = integer(0), site_end = integer(0), enzyme = character(0),
    strand = character(0), codon_pos = integer(0),
    original_codon = character(0), new_codon = character(0),
    aa = character(0), freq_original = numeric(0), freq_new = numeric(0),
    stringsAsFactors = FALSE
  )

  if (nrow(gene_sites) > 0) {
    domestication <- suggest_domestication(cds, gene_sites, codon_usage)
  }

  if (nrow(promoter_sites) > 0) {
    cli::cli_warn(c(
      "!" = "Enzyme recognition sites found in PolIII promoter sequence.",
      "i" = "These cannot be removed by silent mutation. Consider using a different promoter.",
      "i" = paste("Sites found:", nrow(promoter_sites))
    ))
  }

  if (nrow(gene_sites) > 0) {
    cli::cli_alert_warning(
      paste0("Found ", nrow(gene_sites), " enzyme site(s) in gene that need domestication.")
    )
  } else {
    cli::cli_alert_success("No enzyme sites found in gene. No domestication needed.")
  }

  list(
    gene_sites     = gene_sites,
    promoter_sites = promoter_sites,
    domestication  = domestication
  )
}

#' Suggest silent codon changes to remove enzyme sites from a CDS
#'
#' For each site, identifies overlapping codons and finds the minimal
#' silent change (ranked by human codon frequency) that disrupts the site
#' WITHOUT creating new sites for any of the three assembly enzymes
#' (BsaI, BsmBI, PaqCI). This is critical because BsaI (GGTCTC) and
#' BsmBI (CGTCTC) differ by only 1 nt.
#'
#' @param cds Character string of coding DNA sequence
#' @param sites Data frame of enzyme sites (from find_enzyme_sites)
#' @param codon_usage Data frame of codon usage
#' @return Data frame of domestication suggestions
suggest_domestication <- function(cds, sites, codon_usage) {
  codons <- extract_codons(cds)
  results <- list()

  for (i in seq_len(nrow(sites))) {
    site <- sites[i, ]
    site_start <- site$start
    site_end   <- site$end
    enzyme     <- site$enzyme
    enz        <- ENZYMES[[enzyme]]

    # Find codons overlapping this site
    first_codon <- ceiling(site_start / 3)
    last_codon  <- ceiling(site_end / 3)

    best_fix <- NULL

    for (codon_pos in first_codon:last_codon) {
      original_codon <- codons[codon_pos]
      aa <- translate_codon(original_codon)

      if (aa == "*") next  # Skip stop codons

      # Get alternative codons for this amino acid, ranked by frequency
      ranked <- get_ranked_codons(aa, codon_usage)
      ranked <- ranked[ranked != original_codon]  # exclude current

      for (alt_codon in ranked) {
        # Try substituting and check if the target site is disrupted
        test_cds <- replace_codon(cds, codon_pos, alt_codon)
        region_start <- max(1, site_start - 8)
        region_end   <- min(nchar(test_cds), site_end + 8)
        region <- substring(test_cds, region_start, region_end)

        # Check the target enzyme's site is gone
        remaining <- find_enzyme_sites(region, enz$recog)
        if (nrow(remaining) > 0) next

        # Also verify we haven't created a new site for ANY assembly enzyme
        # This is critical: BsaI (GGTCTC) and BsmBI (CGTCTC) differ by 1 nt
        creates_new <- FALSE
        for (check_enz_name in c("BsaI", "BsmBI", "PaqCI")) {
          if (check_enz_name == enzyme) next
          check_enz <- ENZYMES[[check_enz_name]]
          new_sites <- find_enzyme_sites(region, check_enz$recog)
          # Compare against original region to see if we added new sites
          orig_region <- substring(cds, region_start, region_end)
          orig_sites <- find_enzyme_sites(orig_region, check_enz$recog)
          if (nrow(new_sites) > nrow(orig_sites)) {
            creates_new <- TRUE
            break
          }
        }
        if (creates_new) next

        orig_freq <- codon_usage$frequency[codon_usage$codon == original_codon]
        alt_freq  <- codon_usage$frequency[codon_usage$codon == alt_codon]
        best_fix <- data.frame(
          site_start     = site_start,
          site_end       = site_end,
          enzyme         = enzyme,
          strand         = site$strand,
          codon_pos      = codon_pos,
          original_codon = original_codon,
          new_codon      = alt_codon,
          aa             = aa,
          freq_original  = orig_freq,
          freq_new       = alt_freq,
          stringsAsFactors = FALSE
        )
        break
      }
      if (!is.null(best_fix)) break
    }

    if (!is.null(best_fix)) {
      results[[length(results) + 1]] <- best_fix
    } else {
      cli::cli_warn(paste0(
        "Could not find silent mutation to remove ", enzyme,
        " site at position ", site_start, "-", site_end
      ))
    }
  }

  if (length(results) > 0) {
    do.call(rbind, results)
  } else {
    data.frame(
      site_start = integer(0), site_end = integer(0), enzyme = character(0),
      strand = character(0), codon_pos = integer(0),
      original_codon = character(0), new_codon = character(0),
      aa = character(0), freq_original = numeric(0), freq_new = numeric(0),
      stringsAsFactors = FALSE
    )
  }
}

#' Apply domestication changes to a CDS
#'
#' Applies suggested codon changes, then runs iterative re-checking to
#' catch cases where fixing one site creates another (especially BsaI/BsmBI
#' which differ by only 1 nt).
#'
#' @param cds Character string of coding DNA sequence
#' @param domestication Data frame from suggest_domestication()
#' @param codon_usage Optional codon usage table for iterative re-domestication
#' @param max_iterations Maximum iterations for iterative domestication (default 5)
#' @return Modified CDS with enzyme sites removed
apply_domestication <- function(cds, domestication, codon_usage = NULL,
                                max_iterations = 5L) {
  if (nrow(domestication) == 0) return(cds)

  # Sort by position (descending) to avoid index shifting
  domestication <- domestication[order(-domestication$codon_pos), ]

  for (i in seq_len(nrow(domestication))) {
    row <- domestication[i, ]
    cds <- replace_codon(cds, row$codon_pos, row$new_codon)
    cli::cli_alert_info(paste0(
      "Domesticated: ", row$enzyme, " site at nt ", row$site_start, "-", row$site_end,
      " | codon ", row$codon_pos, ": ", row$original_codon, " -> ", row$new_codon,
      " (", row$aa, ", freq: ", row$freq_original, " -> ", row$freq_new, ")"
    ))
  }

  # Iterative re-check: fixing BsaI can create BsmBI and vice versa
  # Re-scan and re-domesticate until clean or max iterations reached
  if (!is.null(codon_usage)) {
    for (iter in seq_len(max_iterations)) {
      all_clear <- TRUE
      for (enz_name in c("BsaI", "BsmBI", "PaqCI")) {
        remaining <- find_enzyme_sites(cds, ENZYMES[[enz_name]]$recog)
        if (nrow(remaining) > 0) {
          all_clear <- FALSE
          remaining$enzyme <- enz_name
          cli::cli_alert_warning(paste0(
            "Iteration ", iter, ": found ", nrow(remaining), " new ", enz_name,
            " site(s) after domestication. Re-fixing..."
          ))
          new_dom <- suggest_domestication(cds, remaining, codon_usage)
          if (nrow(new_dom) > 0) {
            new_dom <- new_dom[order(-new_dom$codon_pos), ]
            for (j in seq_len(nrow(new_dom))) {
              row <- new_dom[j, ]
              cds <- replace_codon(cds, row$codon_pos, row$new_codon)
              cli::cli_alert_info(paste0(
                "Re-domesticated (iter ", iter, "): ", row$enzyme,
                " | codon ", row$codon_pos, ": ", row$original_codon,
                " -> ", row$new_codon
              ))
            }
          }
        }
      }
      if (all_clear) break
    }
  }

  # Final verification for all three enzymes
  for (enz_name in c("BsaI", "BsmBI", "PaqCI")) {
    remaining <- find_enzyme_sites(cds, ENZYMES[[enz_name]]$recog)
    if (nrow(remaining) > 0) {
      cli::cli_warn(paste0(
        "Warning: ", nrow(remaining), " ", enz_name,
        " site(s) remain after domestication. Manual review needed."
      ))
    }
  }

  cds
}
