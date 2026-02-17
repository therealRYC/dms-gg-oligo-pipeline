#!/usr/bin/env Rscript
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
source(file.path(pipeline_dir, "R", "07_barcode_design.R"))
source(file.path(pipeline_dir, "R", "08_oligo_assembly.R"))
source(file.path(pipeline_dir, "R", "09_wt_geneblock_design.R"))
source(file.path(pipeline_dir, "R", "10_qc_checks.R"))
source(file.path(pipeline_dir, "R", "11_output.R"))

# --- Run Pipeline ---
cli::cli_h1("DMS Golden Gate Oligo Pipeline (3-Enzyme Architecture)")
cli::cli_alert_info(paste("Config:", config_path))

# Step 1: Load configuration
cli::cli_h2("Step 1: Loading configuration")
cfg <- load_config(config_path)
cli::cli_alert_success("Configuration loaded and validated.")

# Step 2: Read and validate gene
cli::cli_h2("Step 2: Reading gene")
gene <- read_gene(cfg$gene_fasta)
cli::cli_alert_success(paste0(
  "Gene '", gene$gene_name, "': ", nchar(gene$cds), " nt, ",
  gene$n_codons, " codons, ", nchar(gene$protein), " aa"
))

# Step 3: Load codon usage
cli::cli_h2("Step 3: Loading codon usage table")
codon_usage <- load_codon_usage()
preferred_codons <- get_preferred_codons(codon_usage)
cli::cli_alert_success("Codon usage table loaded.")

# Step 4: Scan and domesticate enzyme sites (BsaI + BsmBI + PaqCI)
cli::cli_h2("Step 4: Scanning for enzyme sites (BsaI, BsmBI, PaqCI)")
scan_result <- scan_enzyme_sites(gene$cds, cfg$polIII_promoter, codon_usage)

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

# Step 5: Design mutations
cli::cli_h2("Step 5: Designing mutations")
variants <- design_mutations(gene$cds, codon_usage)
variants <- check_and_fix_new_sites(variants, gene$cds, codon_usage)

# Step 5.5: Resolve barcode length (needed before tiling for oligo budget)
if (cfg$ops_mode && identical(cfg$barcode_length, "auto")) {
  cli::cli_h2("Step 5.5: Auto-sizing barcode length (OPS mode)")
  n_variants_expected <- gene$n_codons * 20L
  n_barcodes_needed <- n_variants_expected * cfg$barcodes_per_variant
  cfg$barcode_length <- auto_size_barcode_length(
    n_total          = n_barcodes_needed,
    prefix_length    = cfg$barcode_prefix_length,
    min_hamming      = cfg$min_hamming_distance,
    tolerance        = cfg$barcode_capacity_tolerance
  )
  cli::cli_alert_success(paste0(
    "Auto-sized barcode_length = ", cfg$barcode_length,
    " nt for ", n_barcodes_needed, " barcodes"
  ))
}

# Step 6: Plan assembly (dynamic tile boundary search + overhangs + superblocks)
cli::cli_h2("Step 6: Planning assembly (dynamic tile boundary search)")
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
    multi_k = cfg$multi_k_search
  )
)
tiles <- assembly_plan$tiles
oh3 <- assembly_plan$oh3
oh4 <- assembly_plan$oh4
tile_overhangs <- extract_tile_overhangs(tiles)
variants <- assign_variants_to_tiles(variants, tiles)

cli::cli_alert_success(paste0(
  "Assembly planned: ", assembly_plan$summary$n_tiles, " tiles, ",
  assembly_plan$summary$n_boundaries_both_in_hf, "/",
  assembly_plan$summary$n_boundaries, " boundaries both in HF set"
))

# Step 7: Design barcodes
cli::cli_h2("Step 7: Designing barcodes")
cli::cli_alert_info(paste0(
  "Barcode mode: ", if (cfg$ops_mode) "OPS" else "standard",
  ", barcode_length=", cfg$barcode_length
))
barcode_result <- design_barcodes(
  n_variants          = nrow(variants),
  barcode_length      = cfg$barcode_length,
  min_hamming         = cfg$min_hamming_distance,
  prefix_length       = cfg$barcode_prefix_length,
  gc_range            = cfg$barcode_gc_range,
  max_homopolymer     = cfg$barcode_max_homopolymer,
  barcodes_per_variant = cfg$barcodes_per_variant,
  ops_mode            = cfg$ops_mode,
  capacity_tolerance  = cfg$barcode_capacity_tolerance
)
barcodes <- barcode_result$barcodes

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
oligos <- assemble_oligos(
  variants    = variants_expanded,
  cds         = gene$cds,
  barcodes    = barcodes,
  tiles       = tiles,
  oh3         = oh3,
  oh4         = oh4,
  max_oligo_length = cfg$max_oligo_length
)

# Step 9: Design WT gene blocks + helper plasmid
cli::cli_h2("Step 9: Designing gene blocks and helper plasmid")
geneblock_result <- design_wt_geneblocks(
  cds         = gene$cds,
  polIII      = cfg$polIII_promoter,
  tiles       = tiles,
  oh3         = oh3,
  oh4         = oh4,
  paqci_star2 = cfg$paqci_star2,
  paqci_star1 = cfg$paqci_star1,
  max_block_length    = cfg$max_geneblock_length,
  fidelity_threshold  = cfg$overhang_fidelity_threshold,
  assembly_plan       = assembly_plan
)

# Step 10: QC checks
cli::cli_h2("Step 10: Running QC checks")
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

# Step 11: Write outputs
cli::cli_h2("Step 11: Writing outputs")
output_paths <- write_outputs(
  oligos          = oligos,
  geneblock_result = geneblock_result,
  variants        = variants_expanded,
  barcodes        = barcodes,
  qc_result       = qc_result,
  output_dir      = cfg$output_dir,
  gene_name       = gene$gene_name
)

# --- Summary ---
cli::cli_h1("Pipeline Complete")
cli::cli_alert_success(paste0("Gene: ", gene$gene_name))
cli::cli_alert_success(paste0("Architecture: 3-enzyme (BsaI + BsmBI + PaqCI)"))
cli::cli_alert_success(paste0("Variants: ", nrow(variants)))
cli::cli_alert_success(paste0("Oligos: ", nrow(oligos)))
cli::cli_alert_success(paste0("Gene blocks: ", nrow(geneblock_result$blocks)))
cli::cli_alert_success(paste0("Tiles: ", nrow(tiles)))
cli::cli_alert_success(paste0("Fixed overhangs: oh3=", oh3, ", oh4=", oh4))
cli::cli_alert_success(paste0(
  "Barcodes: mode=", if (cfg$ops_mode) "OPS" else "standard",
  ", length=", barcode_result$barcode_length,
  if (!is.null(barcode_result$compliance_fraction))
    paste0(", compliance=", round(barcode_result$compliance_fraction * 100, 1), "%")
  else ""
))
cli::cli_alert_success(paste0("QC: ", if (qc_result$qc_pass) "ALL PASSED" else "ISSUES FOUND"))
cli::cli_alert_success(paste0("Output directory: ", cfg$output_dir))
