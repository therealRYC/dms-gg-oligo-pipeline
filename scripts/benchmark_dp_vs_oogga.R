# benchmark_dp_vs_oogga.R — Legacy DP vs OOGGA two-pass head-to-head
# Created: 2026-03-10
#
# Compares the legacy tile-first DP (reactive blacklisting) against
# oogga_two_pass (SB-first → per-segment tile DP, proactive collision checks)
# on GRIN2A, AKAP11, TRIO, GRIN2A + extended cassette.
#
# Usage: Rscript scripts/benchmark_dp_vs_oogga.R

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

# --- Methods ---
METHODS <- list(
  list(name = "dp", label = "Legacy DP", config = list(
    boundary_method = "dp",
    dp_k_range = 5L
  )),
  list(name = "oogga_two_pass", label = "OOGGA two-pass (beam=1)", config = list(
    boundary_method = "oogga_two_pass",
    oogga_max_identity = 2L,
    oogga_beam_width = 1L,
    dp_k_range = 3L
  ))
)

# --- Benchmark function ---
benchmark_one <- function(gene_info, method_info, polIII = TEST_POLIII) {
  tile_size <- compute_max_tile_size(300L, 20L)

  cat(sprintf("\n=== %s x %s ===\n", gene_info$name, method_info$label))
  elapsed <- system.time({
    result <- tryCatch(
      plan_assembly(
        cds = gene_info$cds,
        polIII = polIII,
        max_mutable_nt = tile_size,
        config = method_info$config,
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
      gene = gene_info$name, method = method_info$label,
      n_tiles = NA_integer_, n_superblocks = NA_integer_,
      n_sb_splits = NA_integer_,
      min_set_fidelity = NA_real_, mean_set_fidelity = NA_real_,
      violations_mi2 = NA_integer_, violations_mi3 = NA_integer_,
      n_exact_violations = NA_integer_,
      unresolved_collisions = NA_integer_,
      runtime_sec = round(elapsed, 2), status = "ERROR",
      stringsAsFactors = FALSE
    ))
  }

  # Count OOGGA identity violations within each reaction
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
    gene = gene_info$name, method = method_info$label,
    n_tiles = result$summary$n_tiles,
    n_superblocks = result$summary$n_superblocks,
    n_sb_splits = result$summary$n_superblock_splits,
    min_set_fidelity = round(result$summary$overall_min_fidelity, 4),
    mean_set_fidelity = round(mean(rf$set_fidelity), 4),
    violations_mi2 = n_v2,
    violations_mi3 = n_v3,
    n_exact_violations = n_exact,
    unresolved_collisions = result$summary$n_sb_collisions,
    runtime_sec = round(elapsed, 2),
    status = "OK",
    stringsAsFactors = FALSE
  )
}

# --- Run benchmarks ---
cat("\n")
separator <- strrep("=", 80)
cat(separator, "\n")
cat("Legacy DP vs OOGGA Two-Pass (beam=1) — Head-to-Head Comparison\n")
cat(separator, "\n")
cat("Date:", format(Sys.time(), "%Y-%m-%d %H:%M:%S"), "\n\n")

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
  "%-12s  %-26s  %5s  %3s  %4s  %8s  %8s  %4s  %4s  %5s  %5s  %7s\n",
  "Gene", "Method", "Tiles", "SBs", "Splt", "Min Fid", "Mean Fd", "Mi2", "Mi3", "Exact", "Unres", "Time(s)"
))
cat(strrep("-", 110), "\n")
for (i in seq_len(nrow(results_df))) {
  r <- results_df[i, ]
  cat(sprintf(
    "%-12s  %-26s  %5s  %3s  %4s  %8s  %8s  %4s  %4s  %5s  %5s  %7s\n",
    r$gene, r$method,
    ifelse(is.na(r$n_tiles), "?", as.character(r$n_tiles)),
    ifelse(is.na(r$n_superblocks), "?", as.character(r$n_superblocks)),
    ifelse(is.na(r$n_sb_splits), "?", as.character(r$n_sb_splits)),
    ifelse(is.na(r$min_set_fidelity), "?", sprintf("%.4f", r$min_set_fidelity)),
    ifelse(is.na(r$mean_set_fidelity), "?", sprintf("%.4f", r$mean_set_fidelity)),
    ifelse(is.na(r$violations_mi2), "?", as.character(r$violations_mi2)),
    ifelse(is.na(r$violations_mi3), "?", as.character(r$violations_mi3)),
    ifelse(is.na(r$n_exact_violations), "?", as.character(r$n_exact_violations)),
    ifelse(is.na(r$unresolved_collisions), "?", as.character(r$unresolved_collisions)),
    sprintf("%.1f", r$runtime_sec)
  ))
}

# --- Per-gene comparison ---
cat("\n")
for (gene_name in unique(results_df$gene)) {
  gdf <- results_df[results_df$gene == gene_name, ]
  dp_row <- gdf[gdf$method == "Legacy DP", ]
  oogga_row <- gdf[gdf$method == "OOGGA two-pass (beam=1)", ]
  cat(sprintf("\n--- %s ---\n", gene_name))
  if (nrow(dp_row) == 1 && nrow(oogga_row) == 1 &&
    dp_row$status == "OK" && oogga_row$status == "OK") {
    cat(sprintf("  Tiles:     DP=%d, OOGGA=%d\n", dp_row$n_tiles, oogga_row$n_tiles))
    cat(sprintf("  SBs:       DP=%d, OOGGA=%d\n", dp_row$n_superblocks, oogga_row$n_superblocks))
    cat(sprintf(
      "  Min fid:   DP=%.4f, OOGGA=%.4f (%+.4f)\n",
      dp_row$min_set_fidelity, oogga_row$min_set_fidelity,
      oogga_row$min_set_fidelity - dp_row$min_set_fidelity
    ))
    cat(sprintf(
      "  Mean fid:  DP=%.4f, OOGGA=%.4f (%+.4f)\n",
      dp_row$mean_set_fidelity, oogga_row$mean_set_fidelity,
      oogga_row$mean_set_fidelity - dp_row$mean_set_fidelity
    ))
    cat(sprintf("  Mi2 viol:  DP=%d, OOGGA=%d\n", dp_row$violations_mi2, oogga_row$violations_mi2))
    cat(sprintf("  Mi3 viol:  DP=%d, OOGGA=%d\n", dp_row$violations_mi3, oogga_row$violations_mi3))
    cat(sprintf("  Exact:     DP=%d, OOGGA=%d\n", dp_row$n_exact_violations, oogga_row$n_exact_violations))
    cat(sprintf("  Unresolved:DP=%d, OOGGA=%d\n", dp_row$unresolved_collisions, oogga_row$unresolved_collisions))
    cat(sprintf(
      "  Runtime:   DP=%.1fs, OOGGA=%.1fs (%.1fx)\n",
      dp_row$runtime_sec, oogga_row$runtime_sec,
      oogga_row$runtime_sec / max(dp_row$runtime_sec, 0.01)
    ))
  }
}

# --- Save markdown report ---
md_path <- file.path(pipeline_dir, "benchmarks", "260310_dp_vs_oogga_two_pass.md")
dir.create(file.path(pipeline_dir, "benchmarks"), showWarnings = FALSE)

md_lines <- c(
  "# Legacy DP vs OOGGA Two-Pass (beam=1) — Head-to-Head",
  "",
  paste0("**Date:** ", format(Sys.time(), "%Y-%m-%d %H:%M:%S")),
  "",
  "## Setup",
  "",
  "- **Legacy DP:** Tile-first DP on full CDS → constrained SB DP → reactive blacklisting loop (up to 5 iterations)",
  "- **OOGGA two-pass (beam=1):** SB-first OOGGA DP → per-segment tile OOGGA DP with proactive collision checks",
  "- **Genes:** GRIN2A (4395 nt), AKAP11 (5706 nt), TRIO (9294 nt), GRIN2A + extended cassette (P2A-EGFP + WPRE + bGH polyA)",
  "- **OOGGA params:** max_identity=2, beam_width=1, dp_k_range=3",
  "- **Legacy DP params:** dp_k_range=5",
  "",
  "## Metrics",
  "",
  "- **Tiles / SBs / Splits**: Assembly structure",
  "- **Min/Mean Set Fidelity**: Per-reaction set fidelity (Potapov 2018). Higher = better ligation specificity.",
  "- **Mi2 violations**: Overhang pairs with >2/4 positional identity within a reaction (strict OOGGA threshold)",
  "- **Mi3 violations**: Overhang pairs with >3/4 positional identity (only exact/RC matches — most problematic)",
  "- **Exact violations**: Identical or exact-RC overhang pairs in a reaction (worst case)",
  "- **Unresolved**: SB collisions the reactive blacklisting loop couldn't fix (legacy DP only)",
  "",
  "## Results",
  "",
  "| Gene | Method | Tiles | SBs | Splits | Min Fid | Mean Fid | Mi2 | Mi3 | Exact | Unresolved | Time (s) |",
  "|------|--------|-------|-----|--------|---------|----------|-----|-----|-------|------------|----------|"
)

for (i in seq_len(nrow(results_df))) {
  r <- results_df[i, ]
  md_lines <- c(md_lines, sprintf(
    "| %s | %s | %s | %s | %s | %s | %s | %s | %s | %s | %s | %.1f |",
    r$gene, r$method,
    ifelse(is.na(r$n_tiles), "?", as.character(r$n_tiles)),
    ifelse(is.na(r$n_superblocks), "?", as.character(r$n_superblocks)),
    ifelse(is.na(r$n_sb_splits), "?", as.character(r$n_sb_splits)),
    ifelse(is.na(r$min_set_fidelity), "?", sprintf("%.4f", r$min_set_fidelity)),
    ifelse(is.na(r$mean_set_fidelity), "?", sprintf("%.4f", r$mean_set_fidelity)),
    ifelse(is.na(r$violations_mi2), "?", as.character(r$violations_mi2)),
    ifelse(is.na(r$violations_mi3), "?", as.character(r$violations_mi3)),
    ifelse(is.na(r$n_exact_violations), "?", as.character(r$n_exact_violations)),
    ifelse(is.na(r$unresolved_collisions), "?", as.character(r$unresolved_collisions)),
    r$runtime_sec
  ))
}

# Per-gene analysis
md_lines <- c(md_lines, "", "## Per-Gene Analysis", "")
for (gene_name in unique(results_df$gene)) {
  gdf <- results_df[results_df$gene == gene_name, ]
  dp_row <- gdf[gdf$method == "Legacy DP", ]
  oogga_row <- gdf[gdf$method == "OOGGA two-pass (beam=1)", ]
  md_lines <- c(md_lines, paste0("### ", gene_name), "")
  if (nrow(dp_row) == 1 && nrow(oogga_row) == 1 &&
    dp_row$status == "OK" && oogga_row$status == "OK") {
    fid_diff <- oogga_row$min_set_fidelity - dp_row$min_set_fidelity
    speed_ratio <- oogga_row$runtime_sec / max(dp_row$runtime_sec, 0.01)
    md_lines <- c(
      md_lines,
      sprintf("- **Tiles:** DP=%d, OOGGA=%d", dp_row$n_tiles, oogga_row$n_tiles),
      sprintf("- **Superblocks:** DP=%d, OOGGA=%d", dp_row$n_superblocks, oogga_row$n_superblocks),
      sprintf(
        "- **Min fidelity:** DP=%.4f, OOGGA=%.4f (%+.4f)",
        dp_row$min_set_fidelity, oogga_row$min_set_fidelity, fid_diff
      ),
      sprintf(
        "- **Mean fidelity:** DP=%.4f, OOGGA=%.4f (%+.4f)",
        dp_row$mean_set_fidelity, oogga_row$mean_set_fidelity,
        oogga_row$mean_set_fidelity - dp_row$mean_set_fidelity
      ),
      sprintf("- **Mi2 violations:** DP=%d, OOGGA=%d", dp_row$violations_mi2, oogga_row$violations_mi2),
      sprintf("- **Mi3 violations:** DP=%d, OOGGA=%d", dp_row$violations_mi3, oogga_row$violations_mi3),
      sprintf("- **Exact violations:** DP=%d, OOGGA=%d", dp_row$n_exact_violations, oogga_row$n_exact_violations),
      sprintf("- **Unresolved collisions:** DP=%d, OOGGA=%d", dp_row$unresolved_collisions, oogga_row$unresolved_collisions),
      sprintf("- **Runtime:** DP=%.1fs, OOGGA=%.1fs (%.1fx)", dp_row$runtime_sec, oogga_row$runtime_sec, speed_ratio),
      ""
    )
  }
}

writeLines(md_lines, md_path)
cat(sprintf("\n\nMarkdown report saved to: %s\n", md_path))
cat("Done.\n")
