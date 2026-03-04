# Created: 2025-02-01
# Last updated: 2026-03-03 — Compute expected variant count dynamically (supports WT controls + synonymous)
# 10_qc_checks.R — Comprehensive QC validation for 3-enzyme architecture
# DMS Golden Gate Oligo Pipeline

#' Run all QC checks on pipeline outputs
#'
#' @param oligos Data frame from assemble_oligos()
#' @param geneblock_result List from design_wt_geneblocks() (blocks, tile_manifests, helper_plasmid)
#' @param variants Data frame of variants with barcodes
#' @param barcodes Character vector of barcodes
#' @param tiles Data frame from partition_tiles()
#' @param tile_overhangs Data frame with oh1_fidelity, oh2_fidelity columns (tiles df works directly)
#' @param cds Domesticated CDS
#' @param oh3 Fixed BsmBI overhang
#' @param oh4 Fixed BsaI overhang
#' @param max_oligo_length Max oligo length
#' @param max_block_length Max gene block length
#' @param min_hamming Min Hamming distance for barcodes
#' @param assembly_plan Optional assembly_plan from plan_assembly() for per-reaction fidelity QC
#' @return List with qc_pass (logical) and qc_report (data frame of checks)
run_qc_checks <- function(oligos, geneblock_result, variants, barcodes,
                          tiles, tile_overhangs, cds,
                          oh3, oh4,
                          max_oligo_length = MAX_OLIGO_LENGTH,
                          max_block_length = MAX_GENEBLOCK_LENGTH,
                          min_block_length = MIN_GENEBLOCK_LENGTH,
                          min_hamming = DEFAULT_MIN_HAMMING,
                          assembly_plan = NULL) {
  checks <- list()
  blocks <- geneblock_result$blocks

  # 1. Oligo lengths
  checks[[1]] <- qc_check(
    name = "oligo_lengths",
    desc = "All oligos within synthesis length limit",
    pass = all(oligos$length <= max_oligo_length),
    detail = paste0(
      "Range: ", min(oligos$length), "-", max(oligos$length),
      " nt (limit: ", max_oligo_length, ")"
    )
  )

  # 2. Gene block lengths
  checks[[2]] <- qc_check(
    name = "block_lengths",
    desc = "All gene blocks within synthesis length limit",
    pass = all(blocks$length <= max_block_length),
    detail = paste0(
      "Range: ", min(blocks$length), "-", max(blocks$length),
      " nt (limit: ", max_block_length, ")"
    )
  )

  # 3. Barcode junction enzyme site check (BUG-2 safety net)
  # Oligo structure: ...BsmBI_fwd_oh3 + barcode + BsaI_rev_oh4...
  # Check that no enzyme sites span the barcode-context junctions
  bsmbi_fwd_oh3_seq <- orient_enzyme_site("BsmBI", oh3, "forward")
  bsai_rev_oh4_seq <- orient_enzyme_site("BsaI", oh4, "reverse")
  junc_left <- substring(
    bsmbi_fwd_oh3_seq,
    nchar(bsmbi_fwd_oh3_seq) - 5L, nchar(bsmbi_fwd_oh3_seq)
  )
  junc_right <- substring(bsai_rev_oh4_seq, 1L, 6L)
  junction_seqs <- paste0(junc_left, barcodes, junc_right)
  n_junction_sites <- 0L
  for (enz_name in names(ENZYMES)) {
    enz <- ENZYMES[[enz_name]]
    n_junction_sites <- n_junction_sites +
      sum(grepl(enz$recog, junction_seqs, fixed = TRUE) |
        grepl(enz$recog_rc, junction_seqs, fixed = TRUE))
  }
  checks[[3]] <- qc_check(
    name = "barcode_junction_sites",
    desc = "No enzyme sites at barcode-context junctions",
    pass = n_junction_sites == 0L,
    detail = paste0(
      n_junction_sites, " barcode(s) with junction enzyme sites",
      " (left='", junc_left, "', right='", junc_right, "')"
    )
  )

  # 4. Barcode uniqueness
  checks[[4]] <- qc_check(
    name   = "barcode_uniqueness",
    desc   = "All barcodes are unique",
    pass   = length(unique(barcodes)) == length(barcodes),
    detail = paste0(length(unique(barcodes)), " unique / ", length(barcodes), " total")
  )

  # 5. Tile coverage
  gene_len <- nchar(cds)
  covered <- rep(FALSE, gene_len)
  for (i in seq_len(nrow(tiles))) {
    covered[tiles$start_nt[i]:tiles$end_nt[i]] <- TRUE
  }
  checks[[5]] <- qc_check(
    name   = "tile_coverage",
    desc   = "Tiles cover entire gene without gaps",
    pass   = all(covered),
    detail = paste0(sum(covered), " / ", gene_len, " nt covered")
  )

  # 6. Variant count (use unique variant_id to handle barcodes_per_variant > 1)
  # Compute expected count from actual positions present in the data, not from
  # n_mutable, since gene-edge variants may have been skipped before QC runs.
  n_codons <- gene_len %/% 3L
  n_mutable <- n_codons - 2L # all mutable positions (codons 2 through n-1)
  unique_vars <- variants[!duplicated(variants$variant_id), ]
  n_unique_variants <- nrow(unique_vars)
  n_positions_present <- length(unique(unique_vars$position))
  has_variant_type <- "variant_type" %in% names(variants)
  if (has_variant_type) {
    type_counts <- table(unique_vars$variant_type)
    type_desc <- paste(paste0(type_counts, " ", names(type_counts)), collapse = " + ")
    # Expected: 20 base (missense + nonsense) per present position + controls
    n_wt_ctrl <- sum(type_counts["wt_control"], na.rm = TRUE)
    n_syn <- sum(type_counts["synonymous"], na.rm = TRUE)
    expected_total <- n_positions_present * 20L + n_wt_ctrl + n_syn
  } else {
    expected_total <- n_positions_present * 20L
    type_desc <- paste0(n_positions_present, " x 20")
  }
  n_skipped <- n_mutable - n_positions_present
  skip_note <- if (n_skipped > 0) paste0("; ", n_skipped, " position(s) skipped") else ""
  checks[[6]] <- qc_check(
    name = "variant_count",
    desc = "Expected number of variants generated",
    pass = n_unique_variants == expected_total,
    detail = paste0(
      n_unique_variants, " unique variants (expected: ", expected_total,
      " across ", n_positions_present, "/", n_mutable,
      " mutable positions; ", type_desc, skip_note, ")"
    )
  )

  # 7. Each non-control variant differs by exactly one codon from WT
  # WT controls have mut_codon == wt_codon (by design) — they are excluded
  # from this check since they represent no DNA change.
  n_single_codon <- 0L
  wt_codons <- extract_codons(cds)
  n_checked <- 0L
  for (i in seq_len(nrow(variants))) {
    v <- variants[i, ]
    # Skip WT controls — their codon is identical to WT by design
    if (has_variant_type && v$variant_type == "wt_control") next
    n_checked <- n_checked + 1L
    if (v$wt_codon != v$mut_codon &&
      wt_codons[v$position] == v$wt_codon) {
      n_single_codon <- n_single_codon + 1L
    }
  }
  checks[[7]] <- qc_check(
    name = "single_codon_change",
    desc = "Each non-control variant differs by exactly one codon from WT",
    pass = n_single_codon == n_checked,
    detail = paste0(
      n_single_codon, " / ", n_checked, " variants confirmed",
      if (has_variant_type) " (WT controls excluded)" else ""
    )
  )

  # 8. GC content warnings for oligos
  gc_values <- vapply(oligos$sequence, gc_content, numeric(1))
  gc_extreme <- sum(gc_values < 0.25 | gc_values > 0.75)
  checks[[8]] <- qc_check(
    name = "oligo_gc_content",
    desc = "Oligo GC content within reasonable range (25-75%)",
    pass = gc_extreme == 0,
    detail = paste0(
      "GC range: ", round(min(gc_values) * 100, 1), "-",
      round(max(gc_values) * 100, 1), "% | ",
      gc_extreme, " oligo(s) with extreme GC"
    )
  )

  # 9. Gene domesticated for all 3 enzymes
  all_domestic <- TRUE
  domestic_detail <- character(0)
  for (enz_name in c("BsaI", "BsmBI", "PaqCI")) {
    remaining <- find_enzyme_sites(cds, ENZYMES[[enz_name]]$recog)
    if (nrow(remaining) > 0) {
      all_domestic <- FALSE
      domestic_detail <- c(
        domestic_detail,
        paste0(enz_name, ": ", nrow(remaining), " site(s)")
      )
    }
  }
  checks[[9]] <- qc_check(
    name   = "domestication_complete",
    desc   = "Gene domesticated for all 3 enzymes (BsaI, BsmBI, PaqCI)",
    pass   = all_domestic,
    detail = if (all_domestic) "No enzyme sites in gene" else paste(domestic_detail, collapse = "; ")
  )

  # 10. Tile boundary overhang fidelity
  low_fidelity <- sum(
    (!is.na(tile_overhangs$oh1_fidelity) & tile_overhangs$oh1_fidelity < 0.80) |
      (!is.na(tile_overhangs$oh2_fidelity) & tile_overhangs$oh2_fidelity < 0.80)
  )
  checks[[10]] <- qc_check(
    name   = "overhang_fidelity",
    desc   = "Tile boundary overhangs have adequate fidelity",
    pass   = low_fidelity == 0,
    detail = paste0(low_fidelity, " tile(s) with low-fidelity boundary overhangs (<0.80)")
  )

  # 11. Per-tile manifests complete
  manifests <- geneblock_result$tile_manifests
  manifests_ok <- all(nchar(manifests$bsmbi_parts) > 0)
  checks[[11]] <- qc_check(
    name   = "tile_manifests",
    desc   = "Per-tile assembly manifests complete",
    pass   = manifests_ok,
    detail = paste0(nrow(manifests), " tile manifest(s) generated")
  )

  # 12. Helper plasmid free of unintended enzyme sites
  helper <- geneblock_result$helper_plasmid
  # Helper intentionally contains BsaI and PaqCI sites; check for BsmBI
  helper_has_bsmbi <- FALSE
  if (nrow(helper) > 0) {
    # Remove the Ns from stuffer before checking
    helper_clean <- gsub("N", "", helper$sequence[1])
    if (nchar(helper_clean) > 0) {
      helper_has_bsmbi <- nrow(find_enzyme_sites(helper_clean, ENZYMES$BsmBI$recog)) > 0
    }
  }
  checks[[12]] <- qc_check(
    name   = "helper_plasmid",
    desc   = "Helper plasmid free of unintended BsmBI sites",
    pass   = !helper_has_bsmbi,
    detail = if (helper_has_bsmbi) "BsmBI site found in helper plasmid!" else "OK"
  )

  # 13. Per-reaction fidelity (when assembly_plan is available)
  if (!is.null(assembly_plan) && !is.null(assembly_plan$reaction_fidelity)) {
    rxn_fid <- assembly_plan$reaction_fidelity
    min_fid <- min(rxn_fid$set_fidelity)
    n_low <- sum(rxn_fid$set_fidelity < 0.90)
    checks[[13]] <- qc_check(
      name = "reaction_fidelity",
      desc = "Per-reaction set-level overhang fidelity",
      pass = min_fid >= 0.80,
      detail = paste0(
        "Min set fidelity: ", round(min_fid, 4),
        " across ", nrow(rxn_fid), " reactions | ",
        n_low, " reaction(s) below 0.90"
      )
    )
  }

  # 14. PolIII terminator signal in barcodes (TTTT causes premature termination)
  n_poliii_term <- sum(grepl(POLIII_TERM_SEQ, barcodes, fixed = TRUE))
  checks[[length(checks) + 1L]] <- qc_check(
    name = "barcode_poliii_term",
    desc = "No barcodes contain PolIII terminator signal (TTTT)",
    pass = n_poliii_term == 0L,
    detail = paste0(
      n_poliii_term, " / ", length(barcodes),
      " barcode(s) contain TTTT"
    )
  )

  # 15. Gene block minimum length (synthesis minimum, warning only)
  n_under_min <- sum(blocks$length < min_block_length)
  checks[[length(checks) + 1L]] <- qc_check(
    name = "block_min_length",
    desc = "All gene blocks above synthesis minimum length",
    pass = n_under_min == 0L,
    detail = paste0(
      n_under_min, " block(s) below ", min_block_length,
      " nt minimum. Range: ", min(blocks$length), "-",
      max(blocks$length), " nt"
    )
  )

  # 16. Cassette fragment integrity (when cassette was split)
  cassette_blocks <- blocks[grepl("^bsmbi_cassette_", blocks$block_name), , drop = FALSE]
  if (nrow(cassette_blocks) > 0) {
    # All cassette fragments should be within synthesis limits
    cass_over <- sum(cassette_blocks$length > max_block_length)
    cass_under <- sum(cassette_blocks$length < min_block_length)
    checks[[length(checks) + 1L]] <- qc_check(
      name = "cassette_fragment_lengths",
      desc = "Cassette fragments within synthesis limits",
      pass = cass_over == 0L && cass_under == 0L,
      detail = paste0(
        nrow(cassette_blocks), " cassette fragment(s). ",
        "Range: ", min(cassette_blocks$length), "-",
        max(cassette_blocks$length), " nt. ",
        cass_over, " over max, ", cass_under, " under min."
      )
    )
  }

  # Compile report
  report <- do.call(rbind, checks)
  rownames(report) <- NULL

  all_pass <- all(report$pass)

  # Print summary
  if (all_pass) {
    cli::cli_alert_success("All QC checks passed!")
  } else {
    n_fail <- sum(!report$pass)
    cli::cli_alert_danger(paste0(n_fail, " QC check(s) failed:"))
    for (i in which(!report$pass)) {
      cli::cli_alert_warning(paste0("  FAIL: ", report$desc[i], " | ", report$detail[i]))
    }
  }

  for (i in seq_len(nrow(report))) {
    status <- if (report$pass[i]) "PASS" else "FAIL"
    cli::cli_alert_info(paste0(
      "[", status, "] ", report$desc[i], " — ", report$detail[i]
    ))
  }

  list(qc_pass = all_pass, qc_report = report)
}

#' Create a QC check result row
#' @param name Check name
#' @param desc Description
#' @param pass Logical pass/fail
#' @param detail Detail string
#' @return Single-row data frame
qc_check <- function(name, desc, pass, detail) {
  data.frame(
    check_name = name,
    desc = desc,
    pass = pass,
    detail = detail,
    stringsAsFactors = FALSE
  )
}
