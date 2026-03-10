# benchmark_beam_width.R — Beam width 1 vs 10 for oogga_two_pass
# Created: 2026-03-10
#
# Analysis 1: Compare beam_width=1 vs beam_width=10 on 4 gene configs:
#   GRIN2A (4392 nt), AKAP11 (5706 nt), TRIO (9294 nt), GRIN2A+ext cassette
#
# Measures: n_tiles, n_superblocks, min/mean set fidelity, mi2/mi3 violations,
#           runtime, max_identity_used
#
# Usage: Rscript scripts/benchmark_beam_width.R

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

# Extended cassette elements (from grin2a_long_cassette.yaml)
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

# GRIN2A with extended cassette — build downstream_cassette from intergene elements + polIII
ext_cassette <- paste0(P2A_EGFP, WPRE, SPACER, BGH_POLYA, TEST_POLIII)

cat(sprintf("  GRIN2A: %d nt (%d codons)\n", nchar(grin2a_cds), nchar(grin2a_cds) %/% 3L))
cat(sprintf("  AKAP11: %d nt (%d codons)\n", nchar(akap11_cds), nchar(akap11_cds) %/% 3L))
cat(sprintf("  TRIO:   %d nt (%d codons)\n", nchar(trio_cds), nchar(trio_cds) %/% 3L))
cat(sprintf("  GRIN2A ext cassette: %d nt\n", nchar(ext_cassette)))

# --- Gene configs ---
genes <- list(
  list(name = "GRIN2A", cds = grin2a_cds, cassette = NULL),
  list(name = "AKAP11", cds = akap11_cds, cassette = NULL),
  list(name = "TRIO", cds = trio_cds, cassette = NULL),
  list(name = "GRIN2A_ext", cds = grin2a_cds, cassette = ext_cassette)
)

# --- Benchmark function ---
benchmark_one <- function(gene_info, beam_width, polIII = TEST_POLIII) {
  tile_size <- compute_max_tile_size(300L, 20L)

  config <- list(
    boundary_method = "oogga_two_pass",
    oogga_max_identity = 2L,
    oogga_beam_width = beam_width,
    dp_k_range = 3L
  )

  cat(sprintf("\n=== %s x beam=%d ===\n", gene_info$name, beam_width))
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
      gene = gene_info$name, beam_width = beam_width,
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
    gene = gene_info$name, beam_width = beam_width,
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
cat("Analysis 1: Beam Width Comparison (oogga_two_pass, beam=1 vs beam=10)\n")
cat(separator, "\n")
cat("Date:", format(Sys.time(), "%Y-%m-%d %H:%M:%S"), "\n\n")

results <- list()
for (gene in genes) {
  for (bw in c(1L, 10L)) {
    res <- benchmark_one(gene, bw)
    results[[length(results) + 1L]] <- res
  }
}

results_df <- do.call(rbind, results)
rownames(results_df) <- NULL

# --- Print comparison table ---
cat("\n", separator, "\n")
cat("RESULTS\n")
cat(separator, "\n\n")

# Formatted table
cat(sprintf(
  "%-12s  %5s  %5s  %3s  %10s  %10s  %4s  %4s  %7s  %s\n",
  "Gene", "Beam", "Tiles", "SBs", "Min Fid", "Mean Fid", "Mi2", "Mi3", "Time(s)", "Status"
))
cat(strrep("-", 80), "\n")
for (i in seq_len(nrow(results_df))) {
  r <- results_df[i, ]
  cat(sprintf(
    "%-12s  %5d  %5s  %3s  %10s  %10s  %4s  %4s  %7s  %s\n",
    r$gene, r$beam_width,
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
md_path <- file.path(pipeline_dir, "benchmarks", "260310_beam_width_comparison.md")
dir.create(file.path(pipeline_dir, "benchmarks"), showWarnings = FALSE)

md_lines <- c(
  "# Beam Width Comparison: oogga_two_pass (beam=1 vs beam=10)",
  "",
  paste0("**Date:** ", format(Sys.time(), "%Y-%m-%d %H:%M:%S")),
  "",
  "## Setup",
  "",
  "- **Method:** `oogga_two_pass` (SB-first → per-segment tile DP)",
  "- **Genes:** GRIN2A (4392 nt), AKAP11 (5706 nt), TRIO (9294 nt), GRIN2A + extended cassette (P2A-EGFP + WPRE + bGH polyA)",
  "- **Beam widths:** 1 (OOGGA native, no beam pruning) vs 10 (default)",
  paste0("- **max_identity:** 2, **dp_k_range:** 3"),
  "",
  "## Results",
  "",
  "| Gene | Beam | Tiles | SBs | Min Fid | Mean Fid | Mi2 Viol | Mi3 Viol | Time (s) | Status |",
  "|------|------|-------|-----|---------|----------|----------|----------|----------|--------|"
)

for (i in seq_len(nrow(results_df))) {
  r <- results_df[i, ]
  md_lines <- c(md_lines, sprintf(
    "| %s | %d | %s | %s | %s | %s | %s | %s | %.1f | %s |",
    r$gene, r$beam_width,
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
  b1 <- gdf[gdf$beam_width == 1, ]
  b10 <- gdf[gdf$beam_width == 10, ]
  md_lines <- c(
    md_lines,
    paste0("### ", gene_name),
    ""
  )
  if (nrow(b1) == 1 && nrow(b10) == 1 && b1$status == "OK" && b10$status == "OK") {
    fid_diff <- b10$min_set_fidelity - b1$min_set_fidelity
    speed_ratio <- b10$runtime_sec / max(b1$runtime_sec, 0.01)
    md_lines <- c(
      md_lines,
      sprintf(
        "- **Fidelity gain (beam=10 over beam=1):** %+.4f (min), %+.4f (mean)",
        fid_diff, b10$mean_set_fidelity - b1$mean_set_fidelity
      ),
      sprintf(
        "- **Speed ratio:** beam=10 is %.1fx %s than beam=1",
        ifelse(speed_ratio > 1, speed_ratio, 1 / speed_ratio),
        ifelse(speed_ratio > 1, "slower", "faster")
      ),
      sprintf("- **Violations (beam=1):** mi2=%d, mi3=%d", b1$violations_mi2, b1$violations_mi3),
      sprintf("- **Violations (beam=10):** mi2=%d, mi3=%d", b10$violations_mi2, b10$violations_mi3),
      ""
    )
  }
}

writeLines(md_lines, md_path)
cat(sprintf("\nMarkdown report saved to: %s\n", md_path))
cat("Done.\n")
