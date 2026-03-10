# benchmark_mc_refinement.R — oogga_two_pass vs oogga_two_pass_mc
# Created: 2026-03-10
#
# Analysis 2: Does MC refinement improve tile boundary quality?
#   Compares oogga_two_pass (DP only) vs oogga_two_pass_mc (DP + MC)
#   on GRIN2A, AKAP11, TRIO, GRIN2A + extended cassette.
#
# MC params: 1000 iterations, temperature=1.0, cooling_rate=0.995
#
# Usage: Rscript scripts/benchmark_mc_refinement.R

# --- Setup ---
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

# PolIII promoter
TEST_POLIII <- paste0(
  "GAGGGCCTATTTCCCATGATTCCTTCATATTTGCATATACGATACAAGGCTGTTAGAGAGATAAT",
  "TAGAATTAATTTGACTGTAAACACAAAGATATTAGTACAAAATACGTGACGTAGAAAGTAATAAT",
  "TTCTTGGGTAGTTTGCAGTTTTTAATACGACTCACTATAGGGACTATCATATGCTTACCGTAAC",
  "TTGAAAGTATTTCGATTTCTTGGCTTTATATATCTTGTGGAAAGGACGAAACACCG"
)

# Extended cassette elements
P2A_EGFP <- "GGAAGCGGAGCTACTAACTTCAGCCTGCTGAAGCAGGCTGGAGACGTGGAGGAGAACCCTGGACCTATGGTGAGCAAGGGCGAGGAGCTGTTCACCGGGGTGGTGCCCATCCTGGTCGAGCTGGACGGCGACGTAAACGGCCACAAGTTCAGCGTGTCCGGCGAGGGCGAGGGCGATGCCACCTACGGCAAGCTGACCCTGAAGTTCATCTGCACCACCGGCAAGCTGCCCGTGCCCTGGCCCACCCTCGTGACCACCCTGACCTACGGCGTGCAGTGCTTCAGCCGCTACCCCGACCACATGAAGCAGCACGACTTCTTCAAGTCCGCCATGCCCGAAGGCTACGTCCAGGAGCGCACCATCTTCTTCAAGGACGACGGCAACTACAAGACCCGCGCCGAGGTGAAGTTCGAGGGCGACACCCTGGTGAACCGCATCGAGCTGAAGGGCATCGACTTCAAGGAGGACGGCAACATCCTGGGGCACAAGCTGGAGTACAACTACAACAGCCACAACGTCTATATCATGGCCGACAAGCAGAAGAACGGCATCAAGGTGAACTTCAAGATCCGCCACAACATCGAGGACGGCAGCGTGCAGCTCGCCGACCACTACCAGCAGAACACCCCCATCGGCGACGGCCCCGTGCTGCTGCCCGACAACCACTACCTGAGCACCCAGTCCGCCCTGAGCAAAGACCCCAACGAGAAGCGCGATCACATGGTCCTGCTGGAGTTCGTGACCGCCGCCGGGATCACTCTCGGCATGGACGAGCTGTACAAGTAA"
WPRE <- "AATCAACCTCTGGATTACAAAATTTGTGAAAGATTGACTGGTATTCTTAACTATGTTGCTCCTTTTACGCTATGTGGATACGCTGCTTTAATGCCTTTGTATCATGCTATTGCTTCCCGTATGGCTTTCATTTTCTCCTCCTTGTATAAATCCTGGTTGCTGTCTCTTTATGAGGAGTTGTGGCCCGTTGTCAGGCAACGTGGCGTGGTGTGCACTGTGTTTGCTGACGCAACCCCCACTGGTTGGGGCATTGCCACCACCTGTCAGCTCCTTTCCGGGACTTTCGCTTTCCCCCTCCCTATTGCCACGGCGGAACTCATCGCCGCCTGCCTTGCCCGCTGCTGGACAGGGGCTCGGCTGTTGGGCACTGACAATTCCGTGGTGTTGTCGGGGAAATCATCGTCCTTTCCTTGGCTGCTCGCCTATGTTGCCACCTGGATTCTGCGCGGGACGTCCTTCTGCTACGTCCCTTCGGCCCTCAATCCAGCGGACCTTCCTTCCCGCGGCCTGCTGCCGGCTCTGCGGCCTCTTCCGCGTCTTCGCCTTCGCCCTCAGACGAGTCGGATCTCCCTTTGGGCCGCCTCCCCGC"
SPACER <- "ATCGATACCGAGCGCTGGTCGACAGATCTAC"
BGH_POLYA <- "CTGTGCCTTCTAGTTGCCAGCCATCTGTTGTTTGCCCCTCCCCCGTGCCTTCCTTGACCCTGGAAGGTGCCACTCCCACTGTCCTTTCCTAATAAAATGAGGAAATTGCATCGCATTGTCTGAGTAGGTGTCATTCTATTCTGGGGGGTGGGGTGGGGCAGGACAGCAAGGGGGAGGATTGGGAAGACAATAGCAGGCATGCTGGGGATGCGGTGGGCTCTATGG"

# --- Load and domesticate real genes ---
cat("Loading and domesticating gene sequences...\n")
codon_usage <- load_codon_usage()

load_and_domesticate <- function(fasta_path, polIII = TEST_POLIII) {
  cds <- as.character(Biostrings::readDNAStringSet(fasta_path)[[1]])
  scan_result <- scan_enzyme_sites(cds, polIII, codon_usage)
  if (nrow(scan_result$domestication) > 0) {
    cds <- apply_domestication(cds, scan_result$domestication, codon_usage)
  }
  cds
}

grin2a_cds <- load_and_domesticate(file.path(pipeline_dir, "data", "GRIN2A_NM_000833_CDS.fasta"))
akap11_cds <- load_and_domesticate(file.path(pipeline_dir, "data", "AKAP11_NM_016248_CDS.fasta"))
trio_cds <- load_and_domesticate(file.path(pipeline_dir, "data", "TRIO_NM_007118_CDS.fasta"))

ext_cassette <- paste0(P2A_EGFP, WPRE, SPACER, BGH_POLYA, TEST_POLIII)

cat(sprintf("  GRIN2A: %d nt (%d codons)\n", nchar(grin2a_cds), nchar(grin2a_cds) %/% 3L))
cat(sprintf("  AKAP11: %d nt (%d codons)\n", nchar(akap11_cds), nchar(akap11_cds) %/% 3L))
cat(sprintf("  TRIO:   %d nt (%d codons)\n", nchar(trio_cds), nchar(trio_cds) %/% 3L))
cat(sprintf("  GRIN2A ext cassette: %d nt\n", nchar(ext_cassette)))

genes <- list(
  list(name = "GRIN2A", cds = grin2a_cds, cassette = NULL),
  list(name = "AKAP11", cds = akap11_cds, cassette = NULL),
  list(name = "TRIO", cds = trio_cds, cassette = NULL),
  list(name = "GRIN2A_ext", cds = grin2a_cds, cassette = ext_cassette)
)

# --- Methods to benchmark ---
METHODS <- c("oogga_two_pass", "oogga_two_pass_mc")

# --- Benchmark function ---
benchmark_one <- function(gene_info, method, polIII = TEST_POLIII) {
  tile_size <- compute_max_tile_size(300L, 20L)

  config <- list(
    boundary_method = method,
    oogga_max_identity = 2L,
    oogga_beam_width = 10L,
    dp_k_range = 3L,
    mc_iterations = 1000L,
    mc_temperature = 1.0,
    mc_cooling_rate = 0.995
  )

  label <- if (method == "oogga_two_pass") "DP only" else "DP + MC"
  cat(sprintf("\n=== %s x %s ===\n", gene_info$name, label))
  elapsed <- system.time({
    result <- tryCatch(
      plan_assembly(
        cds = gene_info$cds,
        polIII = polIII,
        max_mutable_nt = tile_size,
        config = config,
        downstream_cassette = gene_info$cassette
      ),
      error = function(e) {
        cat("  ERROR:", conditionMessage(e), "\n")
        NULL
      }
    )
  })[["elapsed"]]

  if (is.null(result)) {
    return(data.frame(
      gene = gene_info$name, method = method,
      n_tiles = NA_integer_, n_superblocks = NA_integer_,
      min_set_fidelity = NA_real_, mean_set_fidelity = NA_real_,
      violations_mi2 = NA_integer_, violations_mi3 = NA_integer_,
      n_exact_violations = NA_integer_,
      runtime_sec = round(elapsed, 2), status = "ERROR",
      stringsAsFactors = FALSE
    ))
  }

  # Count violations
  rf <- result$reaction_fidelity
  compat2 <- build_oh_compatibility(2L)
  compat3 <- build_oh_compatibility(3L)
  n_v2 <- 0L
  n_v3 <- 0L
  n_exact <- 0L

  for (i in seq_len(nrow(rf))) {
    ohs <- strsplit(rf$overhangs[i], ";")[[1]]
    if (length(ohs) < 2L) next
    for (a in seq_len(length(ohs) - 1L)) {
      for (b in (a + 1L):length(ohs)) {
        if (nchar(ohs[a]) != 4L || nchar(ohs[b]) != 4L) next
        if (!compat2[ohs[a], ohs[b]]) n_v2 <- n_v2 + 1L
        if (!compat3[ohs[a], ohs[b]]) n_v3 <- n_v3 + 1L
        if (ohs[a] == ohs[b] || ohs[a] == reverse_complement(ohs[b])) {
          n_exact <- n_exact + 1L
        }
      }
    }
  }

  data.frame(
    gene = gene_info$name, method = method,
    n_tiles = result$summary$n_tiles,
    n_superblocks = result$summary$n_superblocks,
    min_set_fidelity = round(result$summary$overall_min_fidelity, 4),
    mean_set_fidelity = round(mean(rf$set_fidelity), 4),
    violations_mi2 = n_v2,
    violations_mi3 = n_v3,
    n_exact_violations = n_exact,
    runtime_sec = round(elapsed, 2),
    status = "OK",
    stringsAsFactors = FALSE
  )
}

# --- Run benchmarks ---
cat("\n")
separator <- strrep("=", 70)
cat(separator, "\n")
cat("Analysis 2: MC Refinement (oogga_two_pass vs oogga_two_pass_mc)\n")
cat(separator, "\n")
cat("Date:", format(Sys.time(), "%Y-%m-%d %H:%M:%S"), "\n")
cat("MC params: 1000 iterations, temp=1.0, cooling=0.995\n\n")

set.seed(42) # Reproducible MC

results <- list()
for (gene in genes) {
  for (method in METHODS) {
    res <- benchmark_one(gene, method)
    results[[length(results) + 1L]] <- res
  }
}

results_df <- do.call(rbind, results)
rownames(results_df) <- NULL

# --- Print comparison table ---
cat("\n", separator, "\n")
cat("RESULTS\n")
cat(separator, "\n\n")

cat(sprintf(
  "%-12s  %-22s  %5s  %3s  %10s  %10s  %4s  %4s  %7s  %s\n",
  "Gene", "Method", "Tiles", "SBs", "Min Fid", "Mean Fid", "Mi2", "Mi3", "Time(s)", "Status"
))
cat(strrep("-", 95), "\n")
for (i in seq_len(nrow(results_df))) {
  r <- results_df[i, ]
  label <- if (r$method == "oogga_two_pass") "DP only" else "DP + MC (1000 iter)"
  cat(sprintf(
    "%-12s  %-22s  %5s  %3s  %10s  %10s  %4s  %4s  %7s  %s\n",
    r$gene, label,
    ifelse(is.na(r$n_tiles), "?", as.character(r$n_tiles)),
    ifelse(is.na(r$n_superblocks), "?", as.character(r$n_superblocks)),
    ifelse(is.na(r$min_set_fidelity), "?", sprintf("%.4f", r$min_set_fidelity)),
    ifelse(is.na(r$mean_set_fidelity), "?", sprintf("%.4f", r$mean_set_fidelity)),
    ifelse(is.na(r$violations_mi2), "?", as.character(r$violations_mi2)),
    ifelse(is.na(r$violations_mi3), "?", as.character(r$violations_mi3)),
    sprintf("%.1f", r$runtime_sec),
    r$status
  ))
}

# --- Save markdown report ---
md_path <- file.path(pipeline_dir, "benchmarks", "260310_mc_refinement_comparison.md")
dir.create(file.path(pipeline_dir, "benchmarks"), showWarnings = FALSE)

md_lines <- c(
  "# MC Refinement Comparison: oogga_two_pass vs oogga_two_pass_mc",
  "",
  paste0("**Date:** ", format(Sys.time(), "%Y-%m-%d %H:%M:%S")),
  "",
  "## Setup",
  "",
  "- **Methods:** `oogga_two_pass` (DP only) vs `oogga_two_pass_mc` (DP + Metropolis-Hastings refinement)",
  "- **Genes:** GRIN2A (4392 nt), AKAP11 (5706 nt), TRIO (9294 nt), GRIN2A + extended cassette",
  "- **MC params:** 1000 iterations, initial temperature = 1.0, cooling rate = 0.995",
  "- **beam_width:** 10, **max_identity:** 2, **dp_k_range:** 3",
  "- **Seed:** 42 (reproducible MC)",
  "",
  "## Results",
  "",
  "| Gene | Method | Tiles | SBs | Min Fid | Mean Fid | Mi2 Viol | Mi3 Viol | Time (s) | Status |",
  "|------|--------|-------|-----|---------|----------|----------|----------|----------|--------|"
)

for (i in seq_len(nrow(results_df))) {
  r <- results_df[i, ]
  label <- if (r$method == "oogga_two_pass") "DP only" else "DP + MC"
  md_lines <- c(md_lines, sprintf(
    "| %s | %s | %s | %s | %s | %s | %s | %s | %.1f | %s |",
    r$gene, label,
    ifelse(is.na(r$n_tiles), "?", as.character(r$n_tiles)),
    ifelse(is.na(r$n_superblocks), "?", as.character(r$n_superblocks)),
    ifelse(is.na(r$min_set_fidelity), "?", sprintf("%.4f", r$min_set_fidelity)),
    ifelse(is.na(r$mean_set_fidelity), "?", sprintf("%.4f", r$mean_set_fidelity)),
    ifelse(is.na(r$violations_mi2), "?", as.character(r$violations_mi2)),
    ifelse(is.na(r$violations_mi3), "?", as.character(r$violations_mi3)),
    r$runtime_sec,
    r$status
  ))
}

# Per-gene analysis
md_lines <- c(md_lines, "", "## Per-Gene Analysis", "")
for (gene_name in unique(results_df$gene)) {
  gdf <- results_df[results_df$gene == gene_name, ]
  dp <- gdf[gdf$method == "oogga_two_pass", ]
  mc <- gdf[gdf$method == "oogga_two_pass_mc", ]
  md_lines <- c(
    md_lines,
    paste0("### ", gene_name),
    ""
  )
  if (nrow(dp) == 1 && nrow(mc) == 1 && dp$status == "OK" && mc$status == "OK") {
    fid_diff <- mc$min_set_fidelity - dp$min_set_fidelity
    time_diff <- mc$runtime_sec - dp$runtime_sec
    mc_overhead_pct <- (time_diff / max(dp$runtime_sec, 0.01)) * 100
    md_lines <- c(
      md_lines,
      sprintf(
        "- **Fidelity change (MC over DP):** %+.4f (min), %+.4f (mean)",
        fid_diff, mc$mean_set_fidelity - dp$mean_set_fidelity
      ),
      sprintf("- **MC overhead:** +%.1fs (+%.0f%%)", time_diff, mc_overhead_pct),
      sprintf("- **Tiles:** DP=%d, MC=%d", dp$n_tiles, mc$n_tiles),
      sprintf("- **Violations (DP):** mi2=%d, mi3=%d", dp$violations_mi2, dp$violations_mi3),
      sprintf("- **Violations (MC):** mi2=%d, mi3=%d", mc$violations_mi2, mc$violations_mi3),
      ""
    )
  }
}

writeLines(md_lines, md_path)
cat(sprintf("\nMarkdown report saved to: %s\n", md_path))
cat("Done.\n")
