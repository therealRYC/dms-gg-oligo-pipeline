#!/usr/bin/env Rscript
# scripts/bench_k_handling.R
# 2×2 factorial benchmark: K range × K scoring for OOGGA DP
#
# Conditions:
#   A: narrow + geo_mean (current baseline)
#   B: wide   + geo_mean
#   C: narrow + raw
#   D: wide   + raw      (OOGGA-style)
#
# Test gene: AKAP11 (5706 nt / 1902 codons, with WPRE+spacer+bGH polyA cassette)
#
# Usage: Rscript scripts/bench_k_handling.R

# --- Source all modules (same as run_pipeline.R) ---
`%||%` <- function(a, b) if (!is.null(a)) a else b
script_path <- tryCatch(sys.frame(1)$ofile, error = function(e) NULL)
pipeline_dir <- if (!is.null(script_path)) dirname(dirname(script_path)) else getwd()

source(file.path(pipeline_dir, "R", "constants.R"))
source(file.path(pipeline_dir, "R", "utils.R"))
source(file.path(pipeline_dir, "R", "00_config.R"))
source(file.path(pipeline_dir, "R", "01_gene_input.R"))
source(file.path(pipeline_dir, "R", "02_enzyme_site_scan.R"))
source(file.path(pipeline_dir, "R", "03_codon_table.R"))
source(file.path(pipeline_dir, "R", "04_mutation_design.R"))
source(file.path(pipeline_dir, "R", "05_tiling.R"))
source(file.path(pipeline_dir, "R", "06_overhang_selection.R"))
source(file.path(pipeline_dir, "R", "06b_oogga_dp.R"))
source(file.path(pipeline_dir, "R", "07b_linear_codes.R"))
source(file.path(pipeline_dir, "R", "07_barcode_design.R"))

cli::cli_h1("K-Handling Benchmark: 2\u00d72 Factorial (AKAP11)")

# =====================================================================
# Shared setup: Steps 1-5.5 (run once, reuse across conditions)
# =====================================================================
cli::cli_h2("Shared setup")

cfg <- load_config(file.path(pipeline_dir, "configs", "akap11.yaml"))

# Step 2: Gene input
if (!is.null(cfg$gene_cds) && nzchar(cfg$gene_cds)) {
  gene <- read_gene_from_string(cfg$gene_cds, cfg$gene_name %||% "gene")
} else {
  gene <- read_gene(cfg$gene_fasta)
}
if (!is.null(cfg$gene_name) && nzchar(cfg$gene_name)) {
  gene$gene_name <- cfg$gene_name
}
cli::cli_alert_success(paste0(
  "Gene: ", gene$gene_name, " (", nchar(gene$cds), " nt, ", gene$n_codons, " codons)"
))

# Step 3: Codon usage
codon_usage <- load_codon_usage(cfg$codon_table_path)
preferred_codons <- get_preferred_codons(codon_usage)

# Step 4: Domestication
scan_result <- scan_enzyme_sites(gene$cds, cfg$polIII_promoter, codon_usage,
  intergene_elements = cfg$intergene_elements
)
gene$original_cds <- gene$cds
if (cfg$auto_domesticate && nrow(scan_result$domestication) > 0) {
  gene$cds <- apply_domestication(gene$cds, scan_result$domestication,
    codon_usage = codon_usage
  )
  gene$protein <- translate_cds(gene$cds)
  if (endsWith(gene$protein, "*")) {
    gene$protein <- substring(gene$protein, 1, nchar(gene$protein) - 1)
  }
}

# Step 5: Design mutations
variants <- design_mutations(gene$cds, codon_usage,
  include_synonymous = cfg$include_synonymous
)
variants <- check_and_fix_new_sites(variants, gene$cds, codon_usage)

# Step 5.5: Resolve barcode length
if (identical(cfg$barcode_length, "auto")) {
  n_variants_expected <- length(unique(variants$variant_id))
  cfg$barcode_length <- auto_size_barcode_length(
    n_variants = n_variants_expected,
    prefix_length = cfg$barcode_prefix_length,
    barcodes_per_variant = cfg$barcodes_per_variant,
    min_hamming = cfg$min_hamming_distance
  )
}

# Compute tile size (shared across conditions)
tile_size <- compute_max_tile_size(cfg$max_oligo_length, cfg$barcode_length)
cli::cli_alert_success(paste0(
  "Tile size: ", tile_size, " nt (barcode_length=", cfg$barcode_length, ")"
))

# =====================================================================
# Define 4 conditions
# =====================================================================
conditions <- list(
  list(label = "A_narrow_geo", k_range_mode = "narrow", k_scoring = "geo_mean"),
  list(label = "B_wide_geo",   k_range_mode = "wide",   k_scoring = "geo_mean"),
  list(label = "C_narrow_raw", k_range_mode = "narrow", k_scoring = "raw"),
  list(label = "D_wide_raw",   k_range_mode = "wide",   k_scoring = "raw")
)

# =====================================================================
# Run benchmark
# =====================================================================
results <- list()

for (cond in conditions) {
  cli::cli_h2(paste0("Condition ", cond$label))
  cli::cli_alert_info(paste0(
    "K range: ", cond$k_range_mode, ", scoring: ", cond$k_scoring
  ))

  # Build config with overrides
  assembly_config <- list(
    manual_oh3 = cfg$oh3,
    manual_oh4 = cfg$oh4,
    multi_k = cfg$multi_k_search,
    overlap_codons = cfg$overlap_codons,
    min_geneblock_length = cfg$min_geneblock_length,
    boundary_method = cfg$boundary_method,
    oogga_max_identity = cfg$oogga_max_identity,
    oogga_beam_width = cfg$oogga_beam_width,
    k_range_mode = cond$k_range_mode,
    k_scoring = cond$k_scoring
  )

  # Time plan_assembly()
  t_start <- proc.time()
  assembly_plan <- plan_assembly(
    cds = gene$cds,
    polIII = cfg$polIII_promoter,
    max_mutable_nt = tile_size,
    max_block_length = cfg$max_geneblock_length,
    config = assembly_config,
    downstream_cassette = if (nzchar(cfg$intergene_concat)) cfg$downstream_cassette else NULL
  )
  t_elapsed <- (proc.time() - t_start)[["elapsed"]]

  # Extract metrics
  n_tiles <- assembly_plan$summary$n_tiles
  n_sbs <- assembly_plan$summary$n_superblocks
  sb_k <- n_sbs - 1L
  min_fid <- min(assembly_plan$reaction_fidelity$set_fidelity)
  mean_fid <- mean(assembly_plan$reaction_fidelity$set_fidelity)
  sb_raw_score <- assembly_plan$sb_result$total_score

  # Per-segment tile count: assign tiles to SB segments by start_nt overlap
  tiles_df <- assembly_plan$tiles
  sb_df <- assembly_plan$sb_result$boundaries
  gene_len_local <- nchar(gene$cds)
  per_seg_tiles <- integer(0)
  for (si in seq_len(nrow(sb_df))) {
    seg_start <- sb_df$start_nt[si]
    seg_end <- min(sb_df$end_nt[si], gene_len_local)
    if (seg_start > gene_len_local) next
    seg_tile_count <- sum(tiles_df$start_nt >= seg_start & tiles_df$start_nt <= seg_end)
    per_seg_tiles <- c(per_seg_tiles, seg_tile_count)
    names(per_seg_tiles)[length(per_seg_tiles)] <- as.character(si)
  }
  per_seg_k <- per_seg_tiles - 1L  # boundaries = tiles - 1

  results[[cond$label]] <- list(
    label = cond$label,
    k_range_mode = cond$k_range_mode,
    k_scoring = cond$k_scoring,
    sb_k = sb_k,
    n_tiles = n_tiles,
    n_sbs = n_sbs,
    min_fid = min_fid,
    mean_fid = mean_fid,
    sb_raw_score = sb_raw_score,
    time_s = t_elapsed,
    per_seg_k = per_seg_k,
    assembly_plan = assembly_plan
  )

  cli::cli_alert_success(paste0(
    cond$label, ": SB K=", sb_k, ", tiles=", n_tiles, ", SBs=", n_sbs,
    ", min_fid=", round(min_fid, 4), ", mean_fid=", round(mean_fid, 4),
    ", SB_score=", format(sb_raw_score, digits = 6),
    ", time=", round(t_elapsed, 1), "s"
  ))
}

# =====================================================================
# Console summary table
# =====================================================================
cli::cli_h1("Results Summary")

header <- sprintf(
  "%-16s  %-7s  %-9s  %4s  %5s  %3s  %8s  %8s  %12s  %6s",
  "Condition", "K Range", "K Score", "SB K", "Tiles", "SBs",
  "Min Fid", "Mean Fid", "SB Raw Score", "Time"
)
cat(header, "\n")
cat(paste(rep("-", nchar(header)), collapse = ""), "\n")

for (r in results) {
  cat(sprintf(
    "%-16s  %-7s  %-9s  %4d  %5d  %3d  %8.4f  %8.4f  %12s  %5.1fs\n",
    r$label, r$k_range_mode, r$k_scoring, r$sb_k, r$n_tiles, r$n_sbs,
    r$min_fid, r$mean_fid, format(r$sb_raw_score, digits = 6), r$time_s
  ))
}

# =====================================================================
# Key comparisons
# =====================================================================
cli::cli_h2("Key Comparisons")

compare <- function(a_label, b_label, desc) {
  a <- results[[a_label]]
  b <- results[[b_label]]
  cat(sprintf(
    "\n%s vs %s (%s):\n  SB K: %d vs %d | Tiles: %d vs %d | Min Fid: %.4f vs %.4f | Time: %.1fs vs %.1fs\n",
    a_label, b_label, desc,
    a$sb_k, b$sb_k, a$n_tiles, b$n_tiles,
    a$min_fid, b$min_fid, a$time_s, b$time_s
  ))
  # Per-segment tile K comparison
  cat("  Per-segment tile K:\n")
  seg_names <- union(names(a$per_seg_k), names(b$per_seg_k))
  for (seg in sort(seg_names)) {
    ka <- if (seg %in% names(a$per_seg_k)) a$per_seg_k[seg] else NA
    kb <- if (seg %in% names(b$per_seg_k)) b$per_seg_k[seg] else NA
    marker <- if (!is.na(ka) && !is.na(kb) && ka != kb) " <-- DIFFERS" else ""
    cat(sprintf("    Seg %s: %s vs %s%s\n",
      seg, ifelse(is.na(ka), "?", ka), ifelse(is.na(kb), "?", kb), marker
    ))
  }
}

compare("A_narrow_geo", "D_wide_raw", "Practical question: current vs OOGGA-style")
compare("A_narrow_geo", "B_wide_geo", "Does wider K inflate fragment count with geo mean?")
compare("A_narrow_geo", "C_narrow_raw", "Does scoring alone change outcome?")
compare("C_narrow_raw", "D_wide_raw", "Does K range matter with raw scoring?")

# =====================================================================
# Write markdown report
# =====================================================================
report_dir <- file.path(pipeline_dir, "benchmarks", "260313_k_handling")
dir.create(report_dir, recursive = TRUE, showWarnings = FALSE)
report_path <- file.path(report_dir, "k_handling_comparison.md")

lines <- character()
add <- function(...) lines <<- c(lines, paste0(...))

add("# K-Handling Method Comparison: 2\u00d72 Factorial")
add("")
add("**Date:** ", format(Sys.time(), "%Y-%m-%d %H:%M:%S"))
add("")
add("## Setup")
add("")
add("- **Method:** `oogga_two_pass` (SB-first \u2192 per-segment tile DP)")
add("- **Gene:** AKAP11 (", nchar(gene$cds), " nt / ", gene$n_codons, " codons)")
add("- **Downstream cassette:** WPRE + spacer + bGH polyA + PolIII (",
    nchar(cfg$downstream_cassette), " nt)")
add("- **Tile size budget:** ", tile_size, " nt")
add("- **Beam width:** ", cfg$oogga_beam_width %||% 10L)
add("- **max_identity:** ", cfg$oogga_max_identity %||% 2L)
add("")
add("## Factorial Design")
add("")
add("| Condition | K Range | Scoring | What it tests |")
add("|-----------|---------|---------|---------------|")
add("| A (current baseline) | Narrow | Geometric mean | Current behavior |")
add("| B | Wide (all feasible) | Geometric mean | Wider K range with geo mean |")
add("| C | Narrow | Raw product | Scoring method alone |")
add("| D (OOGGA-style) | Wide (all feasible) | Raw product | Full OOGGA approach |")
add("")
add("## Results")
add("")
add("| Condition | K Range | K Score | SB K | Tiles | SBs | Min Fid | Mean Fid | SB Raw Score | Time (s) |")
add("|-----------|---------|---------|------|-------|-----|---------|----------|--------------|----------|")
for (r in results) {
  add(sprintf("| %s | %s | %s | %d | %d | %d | %.4f | %.4f | %s | %.1f |",
    r$label, r$k_range_mode, r$k_scoring, r$sb_k, r$n_tiles, r$n_sbs,
    r$min_fid, r$mean_fid, format(r$sb_raw_score, digits = 6), r$time_s
  ))
}
add("")

# Per-segment tile K table
add("## Per-Segment Tile Boundaries")
add("")
seg_names <- sort(unique(unlist(lapply(results, function(r) names(r$per_seg_k)))))
seg_header <- paste0("| Condition | ", paste(paste0("Seg ", seg_names), collapse = " | "), " |")
seg_sep <- paste0("|-----------|", paste(rep("------|", length(seg_names)), collapse = ""))
add(seg_header)
add(seg_sep)
for (r in results) {
  vals <- vapply(seg_names, function(s) {
    if (s %in% names(r$per_seg_k)) as.character(r$per_seg_k[s]) else "?"
  }, character(1))
  add(paste0("| ", r$label, " | ", paste(vals, collapse = " | "), " |"))
}
add("")

# Key comparisons
add("## Key Comparisons")
add("")

write_comparison <- function(a_label, b_label, desc) {
  a <- results[[a_label]]
  b <- results[[b_label]]
  add(sprintf("### %s vs %s (%s)", a_label, b_label, desc))
  add("")
  same_sb <- a$sb_k == b$sb_k
  same_tiles <- a$n_tiles == b$n_tiles
  fid_diff <- b$min_fid - a$min_fid
  add(sprintf("- **SB K:** %d vs %d %s", a$sb_k, b$sb_k,
    if (same_sb) "(same)" else "(**DIFFERS**)"))
  add(sprintf("- **Tiles:** %d vs %d %s", a$n_tiles, b$n_tiles,
    if (same_tiles) "(same)" else "(**DIFFERS**)"))
  add(sprintf("- **Min fidelity:** %.4f vs %.4f (%+.4f)", a$min_fid, b$min_fid, fid_diff))
  add(sprintf("- **Mean fidelity:** %.4f vs %.4f (%+.4f)", a$mean_fid, b$mean_fid, b$mean_fid - a$mean_fid))
  add(sprintf("- **Runtime:** %.1fs vs %.1fs (%.1fx)", a$time_s, b$time_s, b$time_s / a$time_s))
  add("")
}

write_comparison("A_narrow_geo", "D_wide_raw", "Practical question: current vs OOGGA-style")
write_comparison("A_narrow_geo", "B_wide_geo", "Does wider K inflate fragment count with geo mean?")
write_comparison("A_narrow_geo", "C_narrow_raw", "Does scoring alone change outcome?")
write_comparison("C_narrow_raw", "D_wide_raw", "Does K range matter with raw scoring?")

# Per-reaction fidelity detail for condition A (baseline)
add("## Condition A Detailed Reaction Fidelity (Baseline)")
add("")
a_fid <- results[["A_narrow_geo"]]$assembly_plan$reaction_fidelity
add("| Tile | Reaction | # OHs | # in HF | Set Fidelity |")
add("|------|----------|-------|---------|--------------|")
for (i in seq_len(nrow(a_fid))) {
  add(sprintf("| %s | %s | %d | %d | %.4f |",
    a_fid$tile_id[i], a_fid$reaction_type[i],
    a_fid$n_overhangs[i], a_fid$n_in_hf[i], a_fid$set_fidelity[i]
  ))
}
add("")

writeLines(lines, report_path)
cli::cli_alert_success(paste0("Report written to: ", report_path))
cli::cli_h1("Benchmark complete")
