# 11_output.R — Write CSV/FASTA outputs for 3-enzyme architecture
# DMS Golden Gate Oligo Pipeline

#' Write all pipeline output files
#'
#' @param oligos Data frame from assemble_oligos()
#' @param geneblock_result List from design_wt_geneblocks() (blocks, tile_manifests, helper_plasmid)
#' @param variants Data frame of variants with tile assignments
#' @param barcodes Character vector of barcodes
#' @param qc_result List from run_qc_checks()
#' @param output_dir Output directory path
#' @param gene_name Name of the gene
write_outputs <- function(oligos, geneblock_result, variants, barcodes,
                          qc_result, output_dir, gene_name = "gene") {
  if (!dir.exists(output_dir)) {
    dir.create(output_dir, recursive = TRUE)
  }

  blocks <- geneblock_result$blocks
  manifests <- geneblock_result$tile_manifests
  helper <- geneblock_result$helper_plasmid

  # 1. Oligo pool CSV
  oligo_path <- file.path(output_dir, paste0(gene_name, "_oligo_pool.csv"))
  readr::write_csv(oligos, oligo_path)
  cli::cli_alert_success(paste0("Wrote oligo pool: ", oligo_path,
                                 " (", nrow(oligos), " oligos)"))

  # 2. Gene block order CSV (deduplicated blocks for synthesis ordering)
  block_path <- file.path(output_dir, paste0(gene_name, "_geneblock_order.csv"))
  readr::write_csv(blocks, block_path)
  cli::cli_alert_success(paste0("Wrote gene block order: ", block_path,
                                 " (", nrow(blocks), " blocks)"))

  # 3. Variant-barcode map CSV
  barcode_map <- data.frame(
    variant_id = variants$variant_id,
    position   = variants$position,
    wt_aa      = variants$wt_aa,
    mut_aa     = variants$mut_aa,
    wt_codon   = variants$wt_codon,
    mut_codon  = variants$mut_codon,
    barcode    = barcodes,
    barcode_idx = if (!is.null(variants$barcode_idx)) variants$barcode_idx else rep(1L, nrow(variants)),
    tile_id    = variants$tile_id,
    stringsAsFactors = FALSE
  )
  map_path <- file.path(output_dir, paste0(gene_name, "_variant_barcode_map.csv"))
  readr::write_csv(barcode_map, map_path)
  cli::cli_alert_success(paste0("Wrote variant-barcode map: ", map_path,
                                 " (", nrow(barcode_map), " variants)"))

  # 4. Tile manifests CSV (per-tile BsaI and BsmBI reaction contents)
  manifest_path <- file.path(output_dir, paste0(gene_name, "_tile_manifests.csv"))
  readr::write_csv(manifests, manifest_path)
  cli::cli_alert_success(paste0("Wrote tile manifests: ", manifest_path))

  # 5. Helper plasmid CSV
  helper_path <- file.path(output_dir, paste0(gene_name, "_helper_plasmid.csv"))
  readr::write_csv(helper, helper_path)
  cli::cli_alert_success(paste0("Wrote helper plasmid: ", helper_path))

  # 6. QC report CSV
  qc_path <- file.path(output_dir, paste0(gene_name, "_qc_report.csv"))
  readr::write_csv(qc_result$qc_report, qc_path)
  cli::cli_alert_success(paste0("Wrote QC report: ", qc_path))

  # 7. Oligo pool FASTA
  fasta_path <- file.path(output_dir, paste0(gene_name, "_oligo_pool.fasta"))
  write_fasta(oligos$oligo_name, oligos$sequence, fasta_path)
  cli::cli_alert_success(paste0("Wrote oligo FASTA: ", fasta_path))

  # 8. Gene block FASTA
  block_fasta_path <- file.path(output_dir, paste0(gene_name, "_geneblock_order.fasta"))
  write_fasta(blocks$block_name, blocks$sequence, block_fasta_path)
  cli::cli_alert_success(paste0("Wrote gene block FASTA: ", block_fasta_path))

  invisible(list(
    oligo_pool_csv      = oligo_path,
    geneblock_order_csv = block_path,
    variant_barcode_map = map_path,
    tile_manifests_csv  = manifest_path,
    helper_plasmid_csv  = helper_path,
    qc_report_csv       = qc_path,
    oligo_pool_fasta    = fasta_path,
    geneblock_order_fasta = block_fasta_path
  ))
}

#' Write sequences to FASTA format
#' @param names Character vector of sequence names
#' @param sequences Character vector of sequences
#' @param path Output file path
write_fasta <- function(names, sequences, path) {
  lines <- character(length(names) * 2)
  for (i in seq_along(names)) {
    lines[(i - 1) * 2 + 1] <- paste0(">", names[i])
    lines[(i - 1) * 2 + 2] <- sequences[i]
  }
  writeLines(lines, path)
}
