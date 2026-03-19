# test-profiling.R — Informational timing tests for pipeline sub-functions
# Created: 2026-03-19
#
# These tests produce timing breakdowns for performance profiling.
# No assertions on speed — purely diagnostic. Run with:
#   testthat::test_file("tests/testthat/test-profiling.R")

# ============================================================================
# Helper: formatted timing printer
# ============================================================================

print_timing_table <- function(labels, times) {
  total <- sum(times)
  cat("\n  ┌──────────────────────────────────────────────────────────┐\n")
  for (i in seq_along(labels)) {
    pct <- if (total > 0) round(times[i] / total * 100, 1) else 0
    bar_len <- round(pct / 2)  # scale to ~50 chars
    bar <- paste0(rep("\u2588", bar_len), collapse = "")
    cat(sprintf("  │ %-30s %7.3fs  %5.1f%%  %s\n",
                labels[i], times[i], pct, bar))
  }
  cat(sprintf("  │ %-30s %7.3fs  100.0%%\n", "TOTAL", total))
  cat("  └──────────────────────────────────────────────────────────┘\n\n")
}

# ============================================================================
# 1. Barcode filter breakdown — times each filter on 50K random 20-mers
# ============================================================================

test_that("[PROFILING] barcode filter breakdown (50K random 20-mers)", {
  set.seed(42)
  n <- 50000L
  bc_len <- 20L
  bases <- c("A", "C", "G", "T")

  # Generate random 20-mers
  mat <- matrix(sample(bases, n * bc_len, replace = TRUE), nrow = n)
  seqs <- apply(mat, 1, paste0, collapse = "")

  labels <- character(0)
  times  <- numeric(0)

  # 1a. Enzyme site filter
  t0 <- proc.time()[["elapsed"]]
  res_enz <- has_enzyme_sites_vec(seqs)
  dt <- proc.time()[["elapsed"]] - t0
  labels <- c(labels, "has_enzyme_sites_vec")
  times  <- c(times, dt)

  # 1b. Homopolymer regex
  t0 <- proc.time()[["elapsed"]]
  homo_pattern <- paste0("([ACGT])\\1{", 4L, ",}")
  res_homo <- grepl(homo_pattern, seqs)
  dt <- proc.time()[["elapsed"]] - t0
  labels <- c(labels, "homopolymer_regex")
  times  <- c(times, dt)

  # 1c. Hairpin filter (the former bottleneck)
  t0 <- proc.time()[["elapsed"]]
  res_hp <- has_hairpin_vec(seqs, max_stem = 3L)
  dt <- proc.time()[["elapsed"]] - t0
  labels <- c(labels, "has_hairpin_vec")
  times  <- c(times, dt)

  # 1d. Dinucleotide repeat filter
  t0 <- proc.time()[["elapsed"]]
  res_dinuc <- has_dinuc_repeat_vec(seqs, max_units = 4L)
  dt <- proc.time()[["elapsed"]] - t0
  labels <- c(labels, "has_dinuc_repeat_vec")
  times  <- c(times, dt)

  # 1e. GGC motif filter
  t0 <- proc.time()[["elapsed"]]
  res_ggc <- has_ggc_motif_vec(seqs)
  dt <- proc.time()[["elapsed"]] - t0
  labels <- c(labels, "has_ggc_motif_vec")
  times  <- c(times, dt)

  # 1f. Poly-G filter
  t0 <- proc.time()[["elapsed"]]
  res_polyg <- has_polyg_vec(seqs, max_g = 2L)
  dt <- proc.time()[["elapsed"]] - t0
  labels <- c(labels, "has_polyg_vec")
  times  <- c(times, dt)

  # 1g. Nearest-neighbor Tm computation
  t0 <- proc.time()[["elapsed"]]
  res_tm <- nn_tm_vec(seqs)
  dt <- proc.time()[["elapsed"]] - t0
  labels <- c(labels, "nn_tm_vec")
  times  <- c(times, dt)

  # 1h. PolIII terminator filter
  t0 <- proc.time()[["elapsed"]]
  res_poliii <- grepl("TTTT", seqs, fixed = TRUE)
  dt <- proc.time()[["elapsed"]] - t0
  labels <- c(labels, "polIII_terminator")
  times  <- c(times, dt)

  # 1i. GC content filter
  t0 <- proc.time()[["elapsed"]]
  gc_counts <- nchar(gsub("[AT]", "", seqs))
  gc_vals <- gc_counts / nchar(seqs)
  res_gc <- gc_vals < 0.35 | gc_vals > 0.65
  dt <- proc.time()[["elapsed"]] - t0
  labels <- c(labels, "gc_content_filter")
  times  <- c(times, dt)

  cat("\n=== Barcode Filter Breakdown (n=", n, " random 20-mers) ===\n")
  print_timing_table(labels, times)

  # Report rejection rates
  cat("  Rejection rates:\n")
  cat(sprintf("    enzyme_sites:  %5.1f%%\n", mean(res_enz) * 100))
  cat(sprintf("    homopolymer:   %5.1f%%\n", mean(res_homo) * 100))
  cat(sprintf("    hairpin:       %5.1f%%\n", mean(res_hp) * 100))
  cat(sprintf("    dinuc_repeat:  %5.1f%%\n", mean(res_dinuc) * 100))
  cat(sprintf("    ggc_motif:     %5.1f%%\n", mean(res_ggc) * 100))
  cat(sprintf("    poly_g:        %5.1f%%\n", mean(res_polyg) * 100))
  cat(sprintf("    polIII_term:   %5.1f%%\n", mean(res_poliii) * 100))
  cat(sprintf("    gc_content:    %5.1f%%\n", mean(res_gc) * 100))

  expect_true(TRUE)  # profiling test always passes
})

# ============================================================================
# 2. Prefix generation at realistic scale
# ============================================================================

test_that("[PROFILING] prefix generation (k=12, d=3, n=1000)", {
  t0 <- proc.time()[["elapsed"]]
  prefix_result <- generate_prefixes(
    k = 12L, min_hamming = 3L, n_needed = 1000L,
    max_homopolymer = 4L,
    junction_left_context = "", junction_right_context = ""
  )
  dt <- proc.time()[["elapsed"]] - t0

  cat(sprintf("\n=== Prefix Generation (k=12, d=3, n=1000) ===\n"))
  cat(sprintf("  Method: %s\n", prefix_result$code_type))
  cat(sprintf("  Prefixes generated: %d\n", length(prefix_result$prefixes)))
  cat(sprintf("  Time: %.3fs\n\n", dt))

  expect_gte(length(prefix_result$prefixes), 1000L)
})

# ============================================================================
# 3. Suffix batch pipeline (matrix gen → paste → filter → split)
# ============================================================================

test_that("[PROFILING] suffix batch pipeline (500 prefixes x 500 candidates)", {
  set.seed(123)
  n_prefixes <- 500L
  n_candidates <- 500L
  suffix_len <- 8L
  bases <- c("A", "C", "G", "T")

  # Generate prefixes
  prefix_result <- generate_prefixes(
    k = 12L, min_hamming = 3L, n_needed = n_prefixes,
    max_homopolymer = 4L,
    junction_left_context = "", junction_right_context = ""
  )
  prefixes <- prefix_result$prefixes[seq_len(n_prefixes)]

  labels <- character(0)
  times  <- numeric(0)

  # 3a. Matrix generation
  t0 <- proc.time()[["elapsed"]]
  total_cands <- n_prefixes * n_candidates
  mat <- matrix(sample(bases, suffix_len * total_cands, replace = TRUE),
                nrow = total_cands, ncol = suffix_len)
  dt <- proc.time()[["elapsed"]] - t0
  labels <- c(labels, "matrix_generation")
  times  <- c(times, dt)

  # 3b. Paste suffixes
  t0 <- proc.time()[["elapsed"]]
  suffixes <- do.call(paste0, as.data.frame(mat, stringsAsFactors = FALSE))
  dt <- proc.time()[["elapsed"]] - t0
  labels <- c(labels, "suffix_paste")
  times  <- c(times, dt)

  # 3c. Paste full barcodes (prefix + suffix)
  t0 <- proc.time()[["elapsed"]]
  prefix_vec <- rep(prefixes, each = n_candidates)
  full_bcs <- paste0(prefix_vec, suffixes)
  dt <- proc.time()[["elapsed"]] - t0
  labels <- c(labels, "full_barcode_paste")
  times  <- c(times, dt)

  # 3d. Filter pipeline
  t0 <- proc.time()[["elapsed"]]
  filtered <- filter_sequences_fast(full_bcs, max_homopolymer = 4L)
  dt <- proc.time()[["elapsed"]] - t0
  labels <- c(labels, "filter_sequences_fast")
  times  <- c(times, dt)

  cat(sprintf(
    "\n=== Suffix Batch Pipeline (%d prefixes x %d candidates = %d total) ===\n",
    n_prefixes, n_candidates, total_cands
  ))
  cat(sprintf("  Barcodes after filtering: %d / %d (%.1f%% pass)\n",
              length(filtered), total_cands,
              length(filtered) / total_cands * 100))
  print_timing_table(labels, times)

  expect_true(TRUE)
})

# ============================================================================
# 4. Mutation design: generation vs site-fix
# ============================================================================

test_that("[PROFILING] mutation design + site-fix (300 nt test gene)", {
  cu <- TEST_CODON_USAGE
  cds <- domesticate_test_gene()

  labels <- character(0)
  times  <- numeric(0)

  # 4a. Mutation generation
  t0 <- proc.time()[["elapsed"]]
  variants <- design_mutations(cds, cu)
  dt <- proc.time()[["elapsed"]] - t0
  labels <- c(labels, "design_mutations")
  times  <- c(times, dt)

  # 4b. Site-fix pass
  t0 <- proc.time()[["elapsed"]]
  variants_fixed <- check_and_fix_new_sites(variants, cds, cu)
  dt <- proc.time()[["elapsed"]] - t0
  labels <- c(labels, "check_and_fix_new_sites")
  times  <- c(times, dt)

  cat(sprintf("\n=== Mutation Design (gene=%d nt, %d codons) ===\n",
              nchar(cds), nchar(cds) %/% 3))
  cat(sprintf("  Variants generated: %d\n", nrow(variants)))
  cat(sprintf("  Site fixes applied: %d\n",
              sum(variants_fixed$mut_codon != variants$mut_codon)))
  print_timing_table(labels, times)

  expect_true(TRUE)
})

# ============================================================================
# 5. QC barcode filter simulation — time the enhanced filters at QC scale
# ============================================================================

test_that("[PROFILING] QC-style barcode filters (10K, 50K, 100K barcodes)", {
  set.seed(77)
  bases <- c("A", "C", "G", "T")
  bc_len <- 20L

  for (n in c(10000L, 50000L, 100000L)) {
    mat <- matrix(sample(bases, n * bc_len, replace = TRUE), nrow = n)
    barcodes <- apply(mat, 1, paste0, collapse = "")

    labels <- character(0)
    times  <- numeric(0)

    # Hairpin check (the former QC bottleneck)
    t0 <- proc.time()[["elapsed"]]
    n_hp <- sum(has_hairpin_vec(barcodes, max_stem = 3L))
    dt <- proc.time()[["elapsed"]] - t0
    labels <- c(labels, "hairpin_check")
    times  <- c(times, dt)

    # Dinuc repeat check
    t0 <- proc.time()[["elapsed"]]
    n_dinuc <- sum(has_dinuc_repeat_vec(barcodes, max_units = 4L))
    dt <- proc.time()[["elapsed"]] - t0
    labels <- c(labels, "dinuc_repeat_check")
    times  <- c(times, dt)

    # Tm computation
    t0 <- proc.time()[["elapsed"]]
    tm_vals <- nn_tm_vec(barcodes)
    dt <- proc.time()[["elapsed"]] - t0
    labels <- c(labels, "tm_computation")
    times  <- c(times, dt)

    # Barcode uniqueness
    t0 <- proc.time()[["elapsed"]]
    n_unique <- length(unique(barcodes))
    dt <- proc.time()[["elapsed"]] - t0
    labels <- c(labels, "uniqueness_check")
    times  <- c(times, dt)

    cat(sprintf("\n=== QC-Style Filters (%dk barcodes) ===\n", n / 1000L))
    print_timing_table(labels, times)
  }

  expect_true(TRUE)
})

# ============================================================================
# 6. Assembly planning — varying gene sizes
# ============================================================================

test_that("[PROFILING] assembly planning (small + large genes)", {
  cu <- TEST_CODON_USAGE
  max_mutable <- compute_max_tile_size(
    max_oligo_length = 300L, barcode_length = 20L,
    handle_overhead = 0L
  )

  labels <- character(0)
  times  <- numeric(0)

  # 6a. Small gene (300 nt = 100 codons)
  cds_small <- domesticate_test_gene()
  t0 <- proc.time()[["elapsed"]]
  plan_small <- plan_assembly(
    cds = cds_small,
    polIII = TEST_POLIII,
    max_mutable_nt = max_mutable,
    max_block_length = 1800L,
    downstream_cassette = TEST_POLIII,
    config = list(overlap_codons = 6L, oh_L = "TGAA", upstream_cassette = "")
  )
  dt <- proc.time()[["elapsed"]] - t0
  labels <- c(labels, sprintf("small_gene (%d nt, %d tiles)",
                               nchar(cds_small), nrow(plan_small$tiles)))
  times  <- c(times, dt)

  # 6b. Large gene (2100 nt = 700 codons)
  cds_large <- domesticate_test_gene(gene_seq = TEST_LONG_GENE_SEQ)
  t0 <- proc.time()[["elapsed"]]
  plan_large <- plan_assembly(
    cds = cds_large,
    polIII = TEST_POLIII,
    max_mutable_nt = max_mutable,
    max_block_length = 1800L,
    downstream_cassette = TEST_POLIII,
    config = list(overlap_codons = 6L, oh_L = "TGAA", upstream_cassette = "")
  )
  dt <- proc.time()[["elapsed"]] - t0
  labels <- c(labels, sprintf("large_gene (%d nt, %d tiles)",
                               nchar(cds_large), nrow(plan_large$tiles)))
  times  <- c(times, dt)

  cat("\n=== Assembly Planning ===\n")
  print_timing_table(labels, times)

  expect_true(TRUE)
})

# ============================================================================
# 7. Hairpin vectorization benchmark — before vs after scale test
# ============================================================================

test_that("[PROFILING] hairpin detection at scale (100K, 250K, 500K seqs)", {
  set.seed(99)
  bases <- c("A", "C", "G", "T")
  bc_len <- 20L

  labels <- character(0)
  times  <- numeric(0)

  for (n in c(100000L, 250000L, 500000L)) {
    mat <- matrix(sample(bases, n * bc_len, replace = TRUE), nrow = n)
    seqs <- apply(mat, 1, paste0, collapse = "")

    t0 <- proc.time()[["elapsed"]]
    result <- has_hairpin_vec(seqs, max_stem = 3L)
    dt <- proc.time()[["elapsed"]] - t0

    labels <- c(labels, sprintf("hairpin_%dk", n / 1000))
    times  <- c(times, dt)
    cat(sprintf("  hairpin %dk: %.3fs (%.1f%% flagged)\n",
                n / 1000, dt, mean(result) * 100))
  }

  cat("\n=== Hairpin Scaling ===\n")
  print_timing_table(labels, times)

  expect_true(TRUE)
})
