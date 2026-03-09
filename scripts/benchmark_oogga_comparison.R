# benchmark_oogga_comparison.R — Compare 4 boundary selection methods
# Created: 2026-03-09
#
# Runs plan_assembly() with each method on test genes and collects:
#   - Number of tiles and superblocks
#   - Min/mean set fidelity across all reactions
#   - Wall-clock runtime
#   - Collision violations (identity >2/4 within any reaction)
#   - Exact-match violations (identity = 4/4 or exact RC)
#
# Usage: Rscript scripts/benchmark_oogga_comparison.R

# --- Setup: source pipeline code ---
# Detect script location: works both via Rscript and source()
if (sys.nframe() > 0L && !is.null(sys.frame(1)$ofile)) {
  pipeline_dir <- normalizePath(file.path(dirname(sys.frame(1)$ofile), ".."))
} else {
  pipeline_dir <- getwd()
}

source(file.path(pipeline_dir, "R", "constants.R"))
source(file.path(pipeline_dir, "R", "utils.R"))
source(file.path(pipeline_dir, "R", "00_config.R"))
source(file.path(pipeline_dir, "R", "01_gene_input.R"))
source(file.path(pipeline_dir, "R", "02_enzyme_site_scan.R"))
source(file.path(pipeline_dir, "R", "03_codon_table.R"))
source(file.path(pipeline_dir, "R", "05_tiling.R"))
source(file.path(pipeline_dir, "R", "06_overhang_selection.R"))
source(file.path(pipeline_dir, "R", "06b_oogga_dp.R"))

# --- Test gene sequences (same as test setup) ---
# Short gene: 300 nt (100 codons), 1 BsmBI site
TEST_GENE_SEQ <- paste0(
  "ATGAGCGTAAGCGTAAGCGTAAGCGTAAGCGTAAGCGTAAGCGTAAGCGTAAGCGTAAGC",
  "GTAAGCGTAAGCGTAAGCGTAAGCGTAAGCGTACGTCTCAGCGTAAGCGTAAGCGTAAGC",
  "GTAAGCGTAAGCGTAAGCGTAAGCGTAAGCGTAAGCGTAAGCGTAAGCGTAAGCGTAAGC",
  "GTAAGCGTAAGCGTAAGCGTAAGCGTAAGCGTAAGCGTAAGCGTAAGCGTAAGCGTAAGC",
  "GTAAGCGTAAGCGTAAGCGTAAGCGTAAGCGTAAGCGTAAGCGTAAGCGTAAGCGTATGA"
)

# Long gene: 2100 nt (700 codons), enzyme-site-free
TEST_LONG_GENE_SEQ <- paste0(
  "ATGACCGTAATCAGCGATCTTACAGGTGAAATCGCTTACCGTAAAGCTGATCATAACGTTG",
  "CTAATGCAGATCTTACTGGCGAAATTGCTTATCGTAAAGCCGATAATAACGTCGCAAATGC",
  "TGATCTTACAGGTGAAATTGCTTATCGCAAAGCCGATAATAATGTCGCCAATGCTGATCTG",
  "ACTGGTGAAATTGCCTATCGCAAAGCCGATAACAATGTCGCCAATGCCGATCTTACTGGTG",
  "AAATCGCTTACCGTAAAGCTGATAATAACGTCGCAAATGCCGATCTTACTGGCGAAATTGC",
  "TTATCGTAAAGCCGATAATAATGTCGCCAATGCTGACCTTACAGGTGAAATTGCTTACCGC",
  "AAAGCCGATAACAATGTCGCCAACGCCGATCTGACTGGCGAAATTGCCTATCGCAAAGCCG",
  "ATAATAATGTCGCCAATGCAGATCTTACTGGTGAAATTGCTTATCGTAAAGCTGATCATAA",
  "CGTCGCAAATGCAGATCTTACTGGTGAAATCGCTTACCGTAAAGCCGATAATAATGTCGCC",
  "AATGCCGATCTTACAGGTGAAATCGCTTACCGTAAAGCCGATAATAATGTCGCCAATGCAG",
  "ATCTTACTGGTGAAATCGCTTATCGCAAAGCCGATAATAATGTCGCCAATGCCGATCTTAC",
  "TGGCGAAATTGCTTACCGTAAAGCTGATCATAACGTCGCAAATGCAGATCTTACTGGTGAA",
  "ATTGCCTATCGCAAAGCCGATAATAATGTCGCCAACGCCGATCTGACTGGCGAAATTGCCT",
  "ATCGCAAAGCCGATAATAATGTCGCCAATGCAGATCTTACTGGCGAAATTGCTTATCGTAA",
  "AGCCGATAATAATGTCGCCAATGCCGATCTTACAGGTGAAATTGCTTACCGCAAAGCCGAT",
  "AATAATGTCGCCAACGCCGATCTGACTGGCGAAATTGCCTATCGCAAAGCCGATAACAATG",
  "TCGCCAATGCAGATCTTACTGGTGAAATTGCTTATCGTAAAGCTGATCATAACGTCGCAAA",
  "TGCCGATCTTACTGGCGAAATTGCTTACCGTAAAGCCGATAATAATGTCGCCAATGCCGAT",
  "CTTACAGGTGAAATCGCTTACCGTAAAGCCGATAATAATGTCGCCAATGCTGATCTTACAG",
  "GTGAAATTGCTTACCGCAAAGCCGATAACAATGTCGCCAACGCCGATCTGACTGGCGAAAT",
  "TGCCTATCGCAAAGCCGATAATAATGTCGCCAATGCAGATCTTACTGGTGAAATTGCTTAT",
  "CGTAAAGCTGATCATAACGTCGCAAATGCAGATCTTACTGGTGAAATCGCTTACCGTAAAG",
  "CTGATCATAACGTCGCAAATGCAGATCTTACTGGCGAAATTGCTTATCGTAAAGCCGATAA",
  "TAATGTCGCCAATGCTGATCTTACAGGTGAAATCGCTTACCGTAAAGCCGATAATAATGTC",
  "GCCAATGCAGATCTTACTGGCGAAATTGCTTATCGTAAAGCCGATAATAATGTCGCCAATG",
  "CCGATCTTACTGGTGAAATTGCTTACCGTAAAGCTGATCATAACGTCGCAAATGCAGATCT",
  "TACTGGTGAAATTGCCTATCGCAAAGCCGATAATAATGTCGCCAACGCCGATCTGACTGGC",
  "GAAATTGCCTATCGCAAAGCCGATAATAATGTCGCCAATGCAGATCTTACTGGCGAAATTG",
  "CTTATCGTAAAGCCGATAATAATGTCGCCAATGCCGATCTTACAGGTGAAATTGCTTACCG",
  "CAAAGCCGATAATAATGTCGCCAACGCCGATCTGACTGGCGAAATTGCCTATCGCAAAGCC",
  "GATAACAATGTCGCCAATGCAGATCTTACTGGTGAAATTGCTTATCGTAAAGCTGATCATA",
  "ACGTCGCAAATGCCGATCTTACTGGCGAAATTGCTTACCGTAAAGCCGATAATAATGTCGC",
  "CAATGCCGATCTTACAGGTGAAATCGCTTACCGTAAAGCCGATAATAATGTCGCCAATGCA",
  "GATCTTACTGGTGAAATCGCTTATCGTAAAGCCGATAATAATGTCGCCAATGCCGATCTTA",
  "CTGGCGAAATTGCTTACCGTAAAGCTGATCATAACGTCGCAAATGCTGATCTTACTGGATG",
  "A"
)

# PolIII promoter
TEST_POLIII <- paste0(
  "GAGGGCCTATTTCCCATGATTCCTTCATATTTGCATATACGATACAAGGCTGTTAGAGAGATAAT",
  "TAGAATTAATTTGACTGTAAACACAAAGATATTAGTACAAAATACGTGACGTAGAAAGTAATAAT",
  "TTCTTGGGTAGTTTGCAGTTTTTAATACGACTCACTATAGGGACTATCATATGCTTACCGTAAC",
  "TTGAAAGTATTTCGATTTCTTGGCTTTATATATCTTGTGGAAAGGACGAAACACCG"
)

# --- Methods to benchmark ---
METHODS <- c("dp", "oogga_two_pass", "oogga_greedy", "oogga_single")

# --- Benchmark function ---
#' Run plan_assembly for one gene x one method, capturing metrics
benchmark_one <- function(gene_name, cds, method, polIII = TEST_POLIII) {
  tile_size <- compute_max_tile_size(300L, 20L)

  config <- list(
    boundary_method = method,
    oogga_max_identity = 2L,
    dp_k_range = 3L
  )

  cat(sprintf("\n=== %s x %s ===\n", gene_name, method))
  elapsed <- system.time({
    result <- tryCatch(
      plan_assembly(
        cds = cds,
        polIII = polIII,
        max_mutable_nt = tile_size,
        config = config
      ),
      error = function(e) {
        cat("  ERROR:", conditionMessage(e), "\n")
        NULL
      }
    )
  })[["elapsed"]]

  if (is.null(result)) {
    return(data.frame(
      gene = gene_name, method = method,
      n_tiles = NA_integer_, n_superblocks = NA_integer_,
      min_set_fidelity = NA_real_, mean_set_fidelity = NA_real_,
      n_collision_violations = NA_integer_, n_exact_violations = NA_integer_,
      runtime_sec = elapsed, status = "ERROR",
      stringsAsFactors = FALSE
    ))
  }

  # Extract metrics
  rf <- result$reaction_fidelity

  # Count OOGGA identity violations within each reaction
  compat2 <- build_oh_compatibility(2L)
  n_violations <- 0L
  n_exact <- 0L

  for (i in seq_len(nrow(rf))) {
    ohs <- strsplit(rf$overhangs[i], ";")[[1]]
    if (length(ohs) < 2L) next
    for (a in seq_len(length(ohs) - 1L)) {
      for (b in (a + 1L):length(ohs)) {
        if (nchar(ohs[a]) != 4L || nchar(ohs[b]) != 4L) next
        # Check identity violation (>2/4)
        if (!compat2[ohs[a], ohs[b]]) {
          n_violations <- n_violations + 1L
        }
        # Check exact match or RC match
        if (ohs[a] == ohs[b] || ohs[a] == reverse_complement(ohs[b])) {
          n_exact <- n_exact + 1L
        }
      }
    }
  }

  data.frame(
    gene = gene_name, method = method,
    n_tiles = result$summary$n_tiles,
    n_superblocks = result$summary$n_superblocks,
    min_set_fidelity = result$summary$overall_min_fidelity,
    mean_set_fidelity = mean(rf$set_fidelity),
    n_collision_violations = n_violations,
    n_exact_violations = n_exact,
    runtime_sec = round(elapsed, 2),
    status = "OK",
    stringsAsFactors = FALSE
  )
}


# --- Main ---
separator <- strrep("=", 70)
cat(separator, "\n")
cat("OOGGA Collision-Aware Boundary Selection -- 4-Way Comparison\n")
cat(separator, "\n")
cat("Date:", format(Sys.time(), "%Y-%m-%d %H:%M:%S"), "\n\n")

# Domesticate the short test gene (has 1 BsmBI site)
cat("Preparing test genes...\n")
codon_usage <- load_codon_usage()
scan_result <- scan_enzyme_sites(TEST_GENE_SEQ, TEST_POLIII, codon_usage)
if (nrow(scan_result$domestication) > 0) {
  gene_short_dom <- apply_domestication(
    TEST_GENE_SEQ, scan_result$domestication, codon_usage
  )
} else {
  gene_short_dom <- TEST_GENE_SEQ
}
gene_long_dom <- TEST_LONG_GENE_SEQ # already enzyme-free

# Define test genes
test_genes <- list(
  list(name = "TEST_GENE (300nt)", cds = gene_short_dom),
  list(name = "TEST_LONG_GENE (2100nt)", cds = gene_long_dom)
)

cat(sprintf("  %d genes prepared\n", length(test_genes)))

# Run benchmarks
results <- list()
for (gene in test_genes) {
  for (method in METHODS) {
    res <- benchmark_one(gene$name, gene$cds, method)
    results[[length(results) + 1L]] <- res
  }
}

# Combine and display
results_df <- do.call(rbind, results)
rownames(results_df) <- NULL

cat("\n", separator, "\n")
cat("RESULTS\n")
cat(separator, "\n\n")

# Print full table
print(results_df, row.names = FALSE)

# Per-gene summary
cat("\n")
for (gene_name in unique(results_df$gene)) {
  cat("\n--- ", gene_name, " ---\n")
  gene_df <- results_df[results_df$gene == gene_name, ]
  for (i in seq_len(nrow(gene_df))) {
    row <- gene_df[i, ]
    cat(sprintf(
      "  %-20s  tiles=%s  SBs=%s  min_fid=%.4f  mean_fid=%.4f  collisions=%s  exact=%s  time=%.1fs  %s\n",
      row$method,
      ifelse(is.na(row$n_tiles), "?", as.character(row$n_tiles)),
      ifelse(is.na(row$n_superblocks), "?", as.character(row$n_superblocks)),
      ifelse(is.na(row$min_set_fidelity), 0, row$min_set_fidelity),
      ifelse(is.na(row$mean_set_fidelity), 0, row$mean_set_fidelity),
      ifelse(is.na(row$n_collision_violations), "?", as.character(row$n_collision_violations)),
      ifelse(is.na(row$n_exact_violations), "?", as.character(row$n_exact_violations)),
      row$runtime_sec,
      row$status
    ))
  }
}

cat("\n", separator, "\n")
cat("ANALYSIS\n")
cat(separator, "\n\n")

# Compare collision violations
baseline <- results_df[results_df$method == "dp", ]
oogga_methods <- results_df[results_df$method != "dp", ]

baseline_violations <- sum(baseline$n_collision_violations, na.rm = TRUE)
if (baseline_violations > 0) {
  cat(sprintf(
    "BUG-009 CONFIRMED: baseline DP has %d collision violations.\n",
    baseline_violations
  ))
} else {
  cat("Note: baseline DP has 0 collision violations on these test genes.\n")
  cat("(BUG-009 may still exist -- longer/more constrained genes may trigger it.)\n")
}

oogga_violations <- sum(oogga_methods$n_collision_violations, na.rm = TRUE)
if (oogga_violations == 0) {
  cat("SUCCESS: All OOGGA methods produce 0 collision violations.\n")
} else {
  cat(sprintf("WARNING: OOGGA methods have %d collision violations:\n", oogga_violations))
  print(oogga_methods[oogga_methods$n_collision_violations > 0, ], row.names = FALSE)
}

cat("\nDone.\n")
