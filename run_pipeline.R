#!/usr/bin/env Rscript
# Created: 2025-02-01
# Last updated: 2026-02-25 — Support intergene_elements for flexible gene constructs
# run_pipeline.R — Master entry point for the DMS Golden Gate Oligo Pipeline
#
# 3-Enzyme Architecture: BsaI (Level 1) + BsmBI (Level 1b) + PaqCI (Level 2)
#
# Usage: Rscript run_pipeline.R config.yaml
#
# This script orchestrates the full pipeline:
#   1. Load config
#   2. Read and validate gene
#   3. Load codon usage
#   4. Scan and domesticate enzyme sites (BsaI + BsmBI + PaqCI)
#   5. Design mutations
#   6. Plan assembly (dynamic tile boundary search + overhang selection + superblocks)
#   7. Design barcodes
#   8. Assemble oligos (universal structure)
#   9. Design gene blocks (BsaI + BsmBI adapted)
#  10. QC checks
#  11. Write outputs
#  12. Generate wetlab assembly report

# --- Parse command line args ---
args <- commandArgs(trailingOnly = TRUE)
if (length(args) < 1) {
  stop("Usage: Rscript run_pipeline.R <config.yaml>")
}
config_path <- args[1]

# --- Source all modules ---
`%||%` <- function(a, b) if (!is.null(a)) a else b
script_path <- tryCatch(sys.frame(1)$ofile, error = function(e) NULL)
pipeline_dir <- if (!is.null(script_path)) dirname(script_path) else getwd()

source(file.path(pipeline_dir, "R", "constants.R"))
source(file.path(pipeline_dir, "R", "utils.R"))
source(file.path(pipeline_dir, "R", "00_config.R"))
source(file.path(pipeline_dir, "R", "01_gene_input.R"))
source(file.path(pipeline_dir, "R", "02_enzyme_site_scan.R"))
source(file.path(pipeline_dir, "R", "03_codon_table.R"))
source(file.path(pipeline_dir, "R", "04_mutation_design.R"))
source(file.path(pipeline_dir, "R", "05_tiling.R"))
source(file.path(pipeline_dir, "R", "06_overhang_selection.R"))
source(file.path(pipeline_dir, "R", "07b_linear_codes.R"))
source(file.path(pipeline_dir, "R", "07_barcode_design.R"))
source(file.path(pipeline_dir, "R", "08_oligo_assembly.R"))
source(file.path(pipeline_dir, "R", "09_wt_geneblock_design.R"))
source(file.path(pipeline_dir, "R", "10_qc_checks.R"))
source(file.path(pipeline_dir, "R", "11_output.R"))
source(file.path(pipeline_dir, "R", "12_report.R"))
source(file.path(pipeline_dir, "R", "13_gg_simulator.R"))

# --- Run Pipeline ---
pipeline_start <- proc.time()
cli::cli_h1("DMS Golden Gate Oligo Pipeline (3-Enzyme Architecture)")
cli::cli_alert_info(paste("Config:", config_path))

# Accumulate step timings for final summary
step_timings <- list()

# Step 1: Load configuration
cli::cli_h2("Step 1: Loading configuration")
step_start <- proc.time()
cfg <- load_config(config_path)
step_elapsed <- (proc.time() - step_start)[["elapsed"]]
step_timings[["1_config"]] <- step_elapsed
cli::cli_alert_success("Configuration loaded and validated. [{round(step_elapsed, 1)}s]")

# Step 2: Read and validate gene
cli::cli_h2("Step 2: Reading gene")
step_start <- proc.time()
if (!is.null(cfg$gene_cds) && nzchar(cfg$gene_cds)) {
  gene <- read_gene_from_string(cfg$gene_cds, cfg$gene_name %||% "gene")
} else {
  gene <- read_gene(cfg$gene_fasta)
}
# Apply gene_name override from config (if provided and gene came from FASTA)
if (!is.null(cfg$gene_name) && nzchar(cfg$gene_name)) {
  gene$gene_name <- cfg$gene_name
}
step_elapsed <- (proc.time() - step_start)[["elapsed"]]
step_timings[["2_gene_input"]] <- step_elapsed
cli::cli_alert_success(paste0(
  "Gene '", gene$gene_name, "': ", nchar(gene$cds), " nt, ",
  gene$n_codons, " codons, ", nchar(gene$protein), " aa",
  " [{round(step_elapsed, 1)}s]"
))

# Step 3: Load codon usage
cli::cli_h2("Step 3: Loading codon usage table")
step_start <- proc.time()
codon_usage <- load_codon_usage(cfg$codon_table_path)
preferred_codons <- get_preferred_codons(codon_usage)
step_elapsed <- (proc.time() - step_start)[["elapsed"]]
step_timings[["3_codon_usage"]] <- step_elapsed
codon_source <- if (!is.null(cfg$codon_table_path) && nzchar(cfg$codon_table_path)) {
  paste0("custom (", cfg$codon_table_path, ")")
} else {
  "built-in CoCoPUTs (Homo sapiens, GRCh38.p13)"
}
cli::cli_alert_success("Codon usage table loaded: {codon_source} [{round(step_elapsed, 1)}s]")

# Step 4: Scan and domesticate enzyme sites (BsaI + BsmBI + PaqCI)
cli::cli_h2("Step 4: Scanning for enzyme sites (BsaI, BsmBI, PaqCI)")
step_start <- proc.time()
scan_result <- scan_enzyme_sites(gene$cds, cfg$polIII_promoter, codon_usage,
                                  intergene_elements = cfg$intergene_elements)

# Check intergene elements for enzyme sites (can't be auto-domesticated)
if (nrow(scan_result$intergene_sites) > 0) {
  n_sites <- nrow(scan_result$intergene_sites)
  elements_affected <- unique(scan_result$intergene_sites$element_name)
  cli::cli_alert_danger(paste0(
    n_sites, " enzyme recognition site(s) found in intergene element(s): ",
    paste(elements_affected, collapse = ", "),
    ". These CANNOT be silently domesticated."
  ))
  cli::cli_alert_danger(
    "The pipeline will continue, but assembly may fail at these sites. ",
    "Consider replacing the affected sequences with site-free alternatives."
  )
}

# Save original CDS before domestication for traceability
gene$original_cds <- gene$cds

if (cfg$auto_domesticate && nrow(scan_result$domestication) > 0) {
  cli::cli_alert("Applying domestication (with iterative BsaI/BsmBI resolution)...")
  gene$cds <- apply_domestication(gene$cds, scan_result$domestication,
                                   codon_usage = codon_usage)
  gene$protein <- translate_cds(gene$cds)
  if (endsWith(gene$protein, "*")) {
    gene$protein <- substring(gene$protein, 1, nchar(gene$protein) - 1)
  }
  cli::cli_alert_success("Gene domesticated for all 3 enzymes.")
}
step_elapsed <- (proc.time() - step_start)[["elapsed"]]
step_timings[["4_enzyme_scan"]] <- step_elapsed
cli::cli_alert_info("Step 4 completed. [{round(step_elapsed, 1)}s]")

# Step 5: Design mutations
cli::cli_h2("Step 5: Designing mutations")
step_start <- proc.time()
variants <- design_mutations(gene$cds, codon_usage)
variants <- check_and_fix_new_sites(variants, gene$cds, codon_usage)
step_elapsed <- (proc.time() - step_start)[["elapsed"]]
step_timings[["5_mutations"]] <- step_elapsed
cli::cli_alert_success(paste0(
  nrow(variants), " variants designed. [{round(step_elapsed, 1)}s]"
))

# Step 5.5: Resolve barcode length (needed before tiling for oligo budget)
if (identical(cfg$barcode_length, "auto")) {
  cli::cli_h2("Step 5.5: Auto-sizing barcode length")
  n_variants_expected <- (gene$n_codons - 2L) * 20L  # exclude Met and stop codons
  cfg$barcode_length <- auto_size_barcode_length(
    n_variants       = n_variants_expected,
    prefix_length    = cfg$barcode_prefix_length,
    barcodes_per_variant = cfg$barcodes_per_variant,
    min_hamming      = cfg$min_hamming_distance
  )
  cli::cli_alert_success(paste0(
    "Auto-sized barcode_length = ", cfg$barcode_length,
    " nt for ", n_variants_expected, " variants x ", cfg$barcodes_per_variant, " barcodes"
  ))
}

# Step 6: Plan assembly (dynamic tile boundary search + overhangs + superblocks)
cli::cli_h2("Step 6: Planning assembly (dynamic tile boundary search)")
step_start <- proc.time()
tile_size <- compute_max_tile_size(cfg$max_oligo_length, cfg$barcode_length)
assembly_plan <- plan_assembly(
  cds = gene$cds,
  polIII = cfg$polIII_promoter,
  max_mutable_nt = tile_size,
  max_block_length = cfg$max_geneblock_length,
  config = list(
    fidelity_threshold = cfg$overhang_fidelity_threshold,
    manual_oh3 = cfg$oh3,
    manual_oh4 = cfg$oh4,
    search_window_K = cfg$search_window_K,
    boundary_method = cfg$boundary_method,
    multi_k = cfg$multi_k_search,
    overlap_codons = cfg$overlap_codons
  ),
  downstream_cassette = if (nzchar(cfg$intergene_concat)) cfg$downstream_cassette else NULL
)
tiles <- assembly_plan$tiles
oh3 <- assembly_plan$oh3
oh4 <- assembly_plan$oh4
tile_overhangs <- extract_tile_overhangs(tiles)
variants <- assign_variants_to_tiles(variants, tiles)

# Filter out gene-edge variants with partial oh1/oh2 overlap (BUG-6)
# These codons partially overlap fixed overhangs and would produce chimeric
# assembled products — neither WT nor the intended mutation.
skipped_mask <- !is.na(variants$overhang_note) & variants$overhang_note == "partial_oh_overlap"
skipped_variants <- variants[skipped_mask, ]
skipped_variants$skip_reason <- "partial_oh_overlap: mutation codon overlaps fixed oh1/oh2 overhang at gene edge"
variants <- variants[!skipped_mask, ]
if (nrow(skipped_variants) > 0) {
  cli::cli_alert_warning(paste0(
    "Skipped ", nrow(skipped_variants), " gene-edge variant(s) with partial oh1/oh2 overlap"
  ))
}

step_elapsed <- (proc.time() - step_start)[["elapsed"]]
step_timings[["6_assembly_plan"]] <- step_elapsed

cli::cli_alert_success(paste0(
  "Assembly planned: ", assembly_plan$summary$n_tiles, " tiles, ",
  assembly_plan$summary$n_boundaries_both_in_hf, "/",
  assembly_plan$summary$n_boundaries, " boundaries both in HF set",
  " [{round(step_elapsed, 1)}s]"
))

# Step 7: Design barcodes
cli::cli_h2("Step 7: Designing barcodes")
step_start <- proc.time()
cli::cli_alert_info(paste0(
  "Barcode mode: unified hierarchical",
  ", barcode_length=", cfg$barcode_length,
  ", prefix_length=", cfg$barcode_prefix_length
))
# Compute junction context for barcode filtering (BUG-2: enzyme sites at barcode boundaries)
# Oligo structure: ...BsmBI_fwd_oh3 + barcode + BsaI_rev_oh4...
# Use last 6 nt of left element and first 6 nt of right element (enough for any 7-nt site)
bsmbi_fwd_oh3_seq <- orient_enzyme_site("BsmBI", oh3, "forward")
bsai_rev_oh4_seq <- orient_enzyme_site("BsaI", oh4, "reverse")
junction_left_context <- substring(bsmbi_fwd_oh3_seq,
                                    nchar(bsmbi_fwd_oh3_seq) - 5L,
                                    nchar(bsmbi_fwd_oh3_seq))
junction_right_context <- substring(bsai_rev_oh4_seq, 1L, 6L)
cli::cli_alert_info(paste0(
  "Junction context for barcode filtering: left='", junction_left_context,
  "', right='", junction_right_context, "'"
))

barcode_result <- design_barcodes(
  n_variants          = nrow(variants),
  barcode_length      = cfg$barcode_length,
  min_hamming         = cfg$min_hamming_distance,
  prefix_length       = cfg$barcode_prefix_length,
  gc_range            = cfg$barcode_gc_range,
  max_homopolymer     = cfg$barcode_max_homopolymer,
  barcodes_per_variant = cfg$barcodes_per_variant,
  junction_left_context = junction_left_context,
  junction_right_context = junction_right_context
)
barcodes <- barcode_result$barcodes
step_elapsed <- (proc.time() - step_start)[["elapsed"]]
step_timings[["7_barcodes"]] <- step_elapsed
cli::cli_alert_info("Step 7 completed. [{round(step_elapsed, 1)}s]")

# Expand variants for multi-barcode support
if (cfg$barcodes_per_variant > 1L) {
  variants_expanded <- variants[rep(seq_len(nrow(variants)), each = cfg$barcodes_per_variant), ]
  variants_expanded$barcode_idx <- rep(seq_len(cfg$barcodes_per_variant), times = nrow(variants))
  rownames(variants_expanded) <- NULL
} else {
  variants_expanded <- variants
  variants_expanded$barcode_idx <- 1L
}

# Step 8: Assemble oligos (universal structure)
cli::cli_h2("Step 8: Assembling oligos (universal 3-enzyme structure)")
step_start <- proc.time()
oligos <- assemble_oligos(
  variants    = variants_expanded,
  cds         = gene$cds,
  barcodes    = barcodes,
  tiles       = tiles,
  oh3         = oh3,
  oh4         = oh4,
  max_oligo_length = cfg$max_oligo_length
)
step_elapsed <- (proc.time() - step_start)[["elapsed"]]
step_timings[["8_oligo_assembly"]] <- step_elapsed
cli::cli_alert_success(paste0(
  nrow(oligos), " oligos assembled. [{round(step_elapsed, 1)}s]"
))

# Step 9: Design WT gene blocks + helper plasmid
cli::cli_h2("Step 9: Designing gene blocks and helper plasmid")
step_start <- proc.time()
geneblock_result <- design_wt_geneblocks(
  cds         = gene$cds,
  polIII      = cfg$downstream_cassette,
  tiles       = tiles,
  oh3         = oh3,
  oh4         = oh4,
  paqci_star2 = cfg$paqci_star2,
  paqci_star1 = cfg$paqci_star1,
  max_block_length    = cfg$max_geneblock_length,
  fidelity_threshold  = cfg$overhang_fidelity_threshold,
  assembly_plan       = assembly_plan
)
step_elapsed <- (proc.time() - step_start)[["elapsed"]]
step_timings[["9_geneblocks"]] <- step_elapsed
cli::cli_alert_success(paste0(
  nrow(geneblock_result$blocks), " gene blocks designed. [{round(step_elapsed, 1)}s]"
))

# Step 10: QC checks
cli::cli_h2("Step 10: Running QC checks")
step_start <- proc.time()
qc_result <- run_qc_checks(
  oligos          = oligos,
  geneblock_result = geneblock_result,
  variants        = variants_expanded,
  barcodes        = barcodes,
  tiles           = tiles,
  tile_overhangs  = tile_overhangs,
  cds             = gene$cds,
  oh3             = oh3,
  oh4             = oh4,
  max_oligo_length = cfg$max_oligo_length,
  max_block_length = cfg$max_geneblock_length,
  min_hamming      = cfg$min_hamming_distance,
  assembly_plan    = assembly_plan
)
step_elapsed <- (proc.time() - step_start)[["elapsed"]]
step_timings[["10_qc"]] <- step_elapsed
cli::cli_alert_success(paste0(
  "QC: ", if (qc_result$qc_pass) "ALL PASSED" else "ISSUES FOUND",
  " [{round(step_elapsed, 1)}s]"
))

# Step 10b: In-silico assembly simulation (optional)
if (isTRUE(cfg$simulate_assembly)) {
  cli::cli_h2("Step 10b: In-silico GG assembly simulation")
  step_start <- proc.time()
  sim_results <- simulate_pipeline_assembly(
    oligos           = oligos,
    geneblock_result = geneblock_result,
    tiles            = tiles,
    variants         = variants_expanded,
    barcodes         = barcodes,
    cds              = gene$cds,
    polIII           = cfg$downstream_cassette,
    assembly_plan    = assembly_plan,
    samples_per_tile = cfg$simulation_samples_per_tile
  )
  n_pass <- sum(sim_results$pass, na.rm = TRUE)
  n_total <- nrow(sim_results)
  step_elapsed <- (proc.time() - step_start)[["elapsed"]]
  step_timings[["10b_simulation"]] <- step_elapsed
  if (n_pass == n_total) {
    cli::cli_alert_success(paste0(
      "Assembly simulation: ", n_pass, "/", n_total, " tiles passed. [{round(step_elapsed, 1)}s]"
    ))
  } else {
    cli::cli_alert_warning(paste0(
      "Assembly simulation: ", n_pass, "/", n_total, " tiles passed (",
      n_total - n_pass, " failures). [{round(step_elapsed, 1)}s]"
    ))
    failed <- sim_results[!sim_results$pass, ]
    for (i in seq_len(nrow(failed))) {
      cli::cli_alert_danger(paste0(
        "  Tile ", failed$tile_id[i], " variant ", failed$variant_id[i],
        ": ", failed$error[i]
      ))
    }
  }
} else {
  cli::cli_alert_info("Step 10b: Assembly simulation skipped (simulate_assembly = false)")
}

# Step 11: Write outputs
cli::cli_h2("Step 11: Writing outputs")
step_start <- proc.time()
output_paths <- write_outputs(
  oligos           = oligos,
  geneblock_result = geneblock_result,
  variants         = variants_expanded,
  barcodes         = barcodes,
  qc_result        = qc_result,
  output_dir       = cfg$output_dir,
  gene_name        = gene$gene_name,
  min_hamming_dist = barcode_result$min_hamming_dist,
  original_cds     = gene$original_cds,
  domesticated_cds = gene$cds,
  protein          = gene$protein,
  gene_description = gene$gene_description,
  gene_fasta       = cfg$gene_fasta,
  skipped_variants = skipped_variants
)
step_elapsed <- (proc.time() - step_start)[["elapsed"]]
step_timings[["11_output"]] <- step_elapsed
cli::cli_alert_success("Outputs written. [{round(step_elapsed, 1)}s]")

# Step 12: Generate wetlab assembly report
cli::cli_h2("Step 12: Generating wetlab assembly report")
step_start <- proc.time()
report_path <- generate_report(
  gene             = gene,
  cfg              = cfg,
  assembly_plan    = assembly_plan,
  geneblock_result = geneblock_result,
  oligos           = oligos,
  variants         = variants_expanded,
  barcodes         = barcodes,
  qc_result        = qc_result,
  scan_result      = scan_result,
  output_dir       = cfg$output_dir,
  barcode_result   = barcode_result
)
step_elapsed <- (proc.time() - step_start)[["elapsed"]]
step_timings[["12_report"]] <- step_elapsed
cli::cli_alert_success("Report generated. [{round(step_elapsed, 1)}s]")

# --- Summary ---
pipeline_elapsed <- (proc.time() - pipeline_start)[["elapsed"]]
cli::cli_h1("Pipeline Complete")
cli::cli_alert_success(paste0("Gene: ", gene$gene_name))
cli::cli_alert_success(paste0("Architecture: 3-enzyme (BsaI + BsmBI + PaqCI)"))
cli::cli_alert_success(paste0("Variants: ", nrow(variants), " (unique mutations)",
  if (nrow(skipped_variants) > 0) paste0(", ", nrow(skipped_variants), " skipped (gene-edge overlap)") else ""))
cli::cli_alert_success(paste0("Oligos: ", nrow(oligos),
  if (cfg$barcodes_per_variant > 1L) paste0(" (", cfg$barcodes_per_variant, " barcodes/variant)") else ""))
cli::cli_alert_success(paste0("Gene blocks: ", nrow(geneblock_result$blocks)))
cli::cli_alert_success(paste0("Tiles: ", nrow(tiles)))
cli::cli_alert_success(paste0("Fixed overhangs: oh3=", oh3, ", oh4=", oh4))
if (length(cfg$intergene_elements) > 0) {
  element_names <- vapply(cfg$intergene_elements, function(e) e$name, character(1))
  cli::cli_alert_success(paste0(
    "Intergene elements: ", paste(element_names, collapse = " + "),
    " (", nchar(cfg$intergene_concat), " nt)"
  ))
  cli::cli_alert_success(paste0(
    "Downstream cassette: ", nchar(cfg$downstream_cassette), " nt ",
    "(intergene + PolIII)"
  ))
}
cli::cli_alert_success(paste0(
  "Barcodes: mode=unified hierarchical",
  ", length=", barcode_result$barcode_length,
  ", prefix=", barcode_result$prefix_length,
  ", effective_hamming=", barcode_result$effective_hamming
))
cli::cli_alert_success(paste0("QC: ", if (qc_result$qc_pass) "ALL PASSED" else "ISSUES FOUND"))
cli::cli_alert_success(paste0("Wetlab report: ", report_path))
cli::cli_alert_success(paste0("Output directory: ", cfg$output_dir))

# --- Timing breakdown ---
cli::cli_h2("Timing Breakdown")
for (step_name in names(step_timings)) {
  cli::cli_alert_info(paste0(
    sprintf("%-20s", step_name), " ", round(step_timings[[step_name]], 1), "s"
  ))
}
cli::cli_alert_success(paste0("Total pipeline time: ", round(pipeline_elapsed, 1), "s"))
