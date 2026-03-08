#!/usr/bin/env Rscript
# benchmark_set_fidelity.R — Compare DP v2 vs MC tile approaches on example genes
#
# For each gene (GRIN2A, AKAP11, TRIO):
#   1. Run Phase 1 (fixed OHs) + Phase 2 (SB MC) — shared
#   2. Run dp_v2 alone → record min set fidelity
#   3. Run MC (seeded from dp_v2) → record min set fidelity
#   4. Run joint refinement on MC result → record final min set fidelity
#   5. Run legacy DP (current plan_assembly default) → record min set fidelity
#   6. Report comparison table
#
# Usage: Rscript scripts/benchmark_set_fidelity.R

# --- Setup ---
pipeline_dir <- normalizePath(".", mustWork = TRUE)
for (f in sort(list.files(file.path(pipeline_dir, "R"),
  pattern = "\\.R$",
  full.names = TRUE
))) {
  source(f)
}
library(yaml)

# --- Gene configurations ---
genes <- list(
  GRIN2A = list(
    fasta = "data/GRIN2A_NM_000833_CDS.fasta",
    config = "configs/grin2a.yaml"
  ),
  AKAP11 = list(
    fasta = "data/AKAP11_NM_016248_CDS.fasta",
    config = "configs/akap11.yaml"
  ),
  TRIO = list(
    fasta = "data/TRIO_NM_007118_CDS.fasta",
    config = "configs/trio.yaml"
  )
)

# Load pairwise matrices once
bsai_matrix <- load_pairwise_matrix("BsaI")
bsmbi_matrix <- load_pairwise_matrix("BsmBI")

# --- Helper: compute per-tile reaction fidelity for a tile set ---
compute_tile_fidelities <- function(tiles, cds, oh_L, oh3, oh4,
                                    sb_positions,
                                    bsai_matrix, bsmbi_matrix) {
  gene_len <- nchar(cds)
  n_tiles <- nrow(tiles)

  # SB junction overhangs
  sb_positions_gene <- sb_positions[sb_positions <= gene_len]
  sb_ohs <- if (length(sb_positions_gene) > 0) {
    vapply(sb_positions_gene, function(p) substring(cds, p - 3L, p), character(1))
  } else {
    character(0)
  }

  fidelities <- numeric(0)
  for (i in seq_len(n_tiles)) {
    tile <- tiles[i, ]
    sn <- tile$start_nt
    en_core <- (tile$end_codon * 3L) # approximate core end

    # SB OHs before this tile (in its BsaI reaction)
    sb_before <- if (length(sb_positions_gene) > 0) {
      sb_ohs[sb_positions_gene < sn]
    } else {
      character(0)
    }

    # SB OHs after this tile (in its BsmBI reaction)
    sb_after <- if (length(sb_positions_gene) > 0) {
      sb_ohs[sb_positions_gene > en_core]
    } else {
      character(0)
    }

    # BsaI reaction: oh_L, oh4, oh1, SB_before
    bsai_ohs <- unique(c(oh_L, oh4, tile$oh1_seq, sb_before))
    bsai_fid <- compute_set_fidelity(bsai_ohs, bsai_matrix)$set_fidelity

    # BsmBI reaction: oh3, oh2, SB_after
    bsmbi_ohs <- unique(c(oh3, tile$oh2_seq, sb_after))
    bsmbi_fid <- compute_set_fidelity(bsmbi_ohs, bsmbi_matrix)$set_fidelity

    fidelities <- c(fidelities, bsai_fid, bsmbi_fid)
  }

  list(
    min_fid = min(fidelities),
    n_below_90 = sum(fidelities < 0.90),
    n_below_80 = sum(fidelities < 0.80),
    all_fids = fidelities
  )
}

# --- Main benchmark loop ---
results <- list()

for (gene_name in names(genes)) {
  gene_info <- genes[[gene_name]]
  cfg_raw <- yaml::read_yaml(gene_info$config)

  cli::cli_h1(paste0("Benchmarking: ", gene_name))

  # Load and validate gene
  gene <- read_gene(gene_info$fasta)
  cds <- gene$cds
  gene_len <- nchar(cds)
  n_codons <- gene_len %/% 3L
  cli::cli_alert_info(paste0(gene_name, ": ", n_codons, " codons (", gene_len, " nt)"))

  # Build downstream cassette (same logic as run_pipeline.R)
  polIII <- cfg_raw$polIII_promoter
  if (!is.null(cfg_raw$intergene_elements)) {
    intergene_seqs <- vapply(cfg_raw$intergene_elements, function(el) el$sequence, character(1))
    intergene_concat <- paste0(intergene_seqs, collapse = "")
    downstream_cassette <- paste0(intergene_concat, polIII)
  } else {
    intergene_concat <- ""
    downstream_cassette <- NULL
  }

  # Compute tile size (same as run_pipeline.R)
  barcode_length <- cfg_raw$barcode_length %||% 12L
  tile_size <- compute_max_tile_size(300L, barcode_length)
  max_block_length <- cfg_raw$max_geneblock_length %||% MAX_GENEBLOCK_LENGTH
  block_overhead <- 22L
  overlap_codons <- cfg_raw$overlap_codons %||% 4L
  min_mutable_nt <- NULL # let functions compute default

  # =====================================================================
  # A. Legacy approach: current plan_assembly with boundary_method = "dp"
  # =====================================================================
  cli::cli_h2("A. Legacy DP approach (tile-first)")
  t0 <- proc.time()
  legacy_plan <- plan_assembly(
    cds = cds, polIII = polIII, max_mutable_nt = tile_size,
    max_block_length = max_block_length,
    config = list(
      manual_oh3 = cfg_raw$oh3,
      manual_oh4 = cfg_raw$oh4,
      overlap_codons = overlap_codons,
      min_geneblock_length = cfg_raw$min_geneblock_length
    ),
    downstream_cassette = if (nzchar(intergene_concat)) downstream_cassette else NULL
  )
  legacy_time <- (proc.time() - t0)[["elapsed"]]

  legacy_fids <- legacy_plan$reaction_fidelity
  legacy_min <- min(legacy_fids$set_fidelity)
  legacy_n_below90 <- sum(legacy_fids$set_fidelity < 0.90)
  legacy_n_below80 <- sum(legacy_fids$set_fidelity < 0.80)

  cli::cli_alert_info(sprintf(
    "Legacy: %d tiles, min_fid=%.4f, %d reactions < 0.90, %d < 0.80, %.1fs",
    nrow(legacy_plan$tiles), legacy_min, legacy_n_below90, legacy_n_below80, legacy_time
  ))

  # =====================================================================
  # B. MC Fidelity approach: SB-first → DP v2 → MC → refinement
  # =====================================================================
  # Phase 1: Fixed overhangs (reuse from legacy for fair comparison)
  oh_L <- legacy_plan$oh_L
  oh3 <- legacy_plan$oh3
  oh4 <- legacy_plan$oh4

  # Build full sequence for SB MC
  cassette_seq <- if (!is.null(downstream_cassette) && !is.null(legacy_plan$core_polIII)) {
    substring(downstream_cassette, 1, nchar(downstream_cassette) - 5L)
  } else if (!is.null(legacy_plan$core_polIII)) {
    legacy_plan$core_polIII
  } else {
    ""
  }
  full_seq <- paste0(cds, cassette_seq)

  # Phase 2: SB MC
  cli::cli_h2("B. MC Fidelity approach (SB-first)")
  cli::cli_h3("Phase 2: SB MC")
  t0 <- proc.time()
  sb_mc <- search_sb_boundaries_mc(
    full_seq = full_seq, gene_len = gene_len,
    oh_L = oh_L, oh3 = oh3, oh4 = oh4,
    bsai_matrix = bsai_matrix, bsmbi_matrix = bsmbi_matrix,
    max_block_length = max_block_length - block_overhead,
    min_block_length = cfg_raw$min_geneblock_length %||% MIN_GENEBLOCK_LENGTH,
    n_iterations = 10000L, n_restarts = 5L, seed = 42L
  )
  sb_time <- (proc.time() - t0)[["elapsed"]]
  cli::cli_alert_info(sprintf(
    "SB MC: %d SBs, score=%.4f, %.1fs",
    sb_mc$n_sb - 1L, sb_mc$score, sb_time
  ))

  # Phase 3a: DP v2 only
  cli::cli_h3("Phase 3a: Tile DP v2")
  t0 <- proc.time()
  dp_v2_tiles <- search_tile_boundaries_dp_v2(
    cds = cds, sb_positions = sb_mc$positions,
    oh_L = oh_L, oh3 = oh3, oh4 = oh4,
    bsai_matrix = bsai_matrix, bsmbi_matrix = bsmbi_matrix,
    max_mutable_nt = tile_size,
    min_mutable_nt = min_mutable_nt,
    overlap_codons = overlap_codons
  )
  dp_v2_time <- (proc.time() - t0)[["elapsed"]]

  dp_v2_fids <- compute_tile_fidelities(
    dp_v2_tiles, cds, oh_L, oh3, oh4, sb_mc$positions,
    bsai_matrix, bsmbi_matrix
  )
  cli::cli_alert_info(sprintf(
    "DP v2: %d tiles, min_fid=%.4f, %d < 0.90, %d < 0.80, %.1fs",
    nrow(dp_v2_tiles), dp_v2_fids$min_fid,
    dp_v2_fids$n_below_90, dp_v2_fids$n_below_80, dp_v2_time
  ))

  # Phase 3b: MC tiles (seeded from DP v2)
  cli::cli_h3("Phase 3b: Tile MC")
  t0 <- proc.time()
  mc_tiles <- search_tile_boundaries_mc(
    cds = cds, sb_positions = sb_mc$positions,
    oh_L = oh_L, oh3 = oh3, oh4 = oh4,
    bsai_matrix = bsai_matrix, bsmbi_matrix = bsmbi_matrix,
    max_mutable_nt = tile_size,
    min_mutable_nt = min_mutable_nt,
    overlap_codons = overlap_codons,
    n_iterations = 5000L, n_restarts = 3L, seed = 42L
  )
  mc_time <- (proc.time() - t0)[["elapsed"]]

  mc_fids <- compute_tile_fidelities(
    mc_tiles, cds, oh_L, oh3, oh4, sb_mc$positions,
    bsai_matrix, bsmbi_matrix
  )
  cli::cli_alert_info(sprintf(
    "MC tiles: %d tiles, min_fid=%.4f, %d < 0.90, %d < 0.80, %.1fs",
    nrow(mc_tiles), mc_fids$min_fid,
    mc_fids$n_below_90, mc_fids$n_below_80, mc_time
  ))

  # Phase 3c: Joint refinement
  cli::cli_h3("Phase 3c: Joint refinement")
  t0 <- proc.time()
  refined <- refine_boundaries_mc(
    cds = cds, tiles = mc_tiles, sb_positions = sb_mc$positions,
    oh_L = oh_L, oh3 = oh3, oh4 = oh4,
    bsai_matrix = bsai_matrix, bsmbi_matrix = bsmbi_matrix,
    max_mutable_nt = tile_size,
    min_mutable_nt = min_mutable_nt,
    overlap_codons = overlap_codons,
    max_block_length = max_block_length - block_overhead,
    min_block_length = cfg_raw$min_geneblock_length %||% MIN_GENEBLOCK_LENGTH,
    n_iterations = 2000L, seed = 42L
  )
  refine_time <- (proc.time() - t0)[["elapsed"]]

  refined_fids <- compute_tile_fidelities(
    refined$tiles, cds, oh_L, oh3, oh4, sb_mc$positions,
    bsai_matrix, bsmbi_matrix
  )
  cli::cli_alert_info(sprintf(
    "Refined: %d tiles, min_fid=%.4f, %d < 0.90, %d < 0.80, %.1fs",
    nrow(refined$tiles), refined_fids$min_fid,
    refined_fids$n_below_90, refined_fids$n_below_80, refine_time
  ))

  # =====================================================================
  # Collect results
  # =====================================================================
  mc_total_time <- sb_time + dp_v2_time + mc_time + refine_time

  results[[gene_name]] <- data.frame(
    gene = gene_name,
    n_codons = n_codons,
    approach = c("Legacy DP", "DP v2 only", "MC tiles", "MC + refine"),
    n_tiles = c(
      nrow(legacy_plan$tiles), nrow(dp_v2_tiles),
      nrow(mc_tiles), nrow(refined$tiles)
    ),
    n_sbs = c(
      legacy_plan$summary$n_superblocks - 1L,
      sb_mc$n_sb - 1L, sb_mc$n_sb - 1L, sb_mc$n_sb - 1L
    ),
    min_set_fid = c(
      legacy_min, dp_v2_fids$min_fid,
      mc_fids$min_fid, refined_fids$min_fid
    ),
    n_below_90 = c(
      legacy_n_below90, dp_v2_fids$n_below_90,
      mc_fids$n_below_90, refined_fids$n_below_90
    ),
    n_below_80 = c(
      legacy_n_below80, dp_v2_fids$n_below_80,
      mc_fids$n_below_80, refined_fids$n_below_80
    ),
    time_s = c(legacy_time, dp_v2_time, mc_time, mc_total_time),
    stringsAsFactors = FALSE
  )
}

# --- Print comparison table ---
cli::cli_h1("BENCHMARK RESULTS")
all_results <- do.call(rbind, results)
rownames(all_results) <- NULL

# Format nicely
all_results$min_set_fid <- sprintf("%.4f", all_results$min_set_fid)
all_results$time_s <- sprintf("%.1f", all_results$time_s)

cat("\n")
print(all_results, row.names = FALSE)
cat("\n")

# Improvement summary per gene
for (gene_name in names(results)) {
  r <- results[[gene_name]]
  legacy_fid <- r$min_set_fid[r$approach == "Legacy DP"]
  best_fid <- r$min_set_fid[r$approach == "MC + refine"]
  improvement <- as.numeric(best_fid) - as.numeric(legacy_fid)
  cli::cli_alert_info(sprintf(
    "%s: Legacy min_fid=%.4f -> MC+refine min_fid=%.4f (improvement: %+.4f)",
    gene_name, as.numeric(legacy_fid), as.numeric(best_fid), improvement
  ))
}
