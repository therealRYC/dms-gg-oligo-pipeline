# Created: 2025-02-01
# Last updated: 2026-03-03 — Add variant_type column to barcode map and skipped variants outputs
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
#' @param min_hamming_dist Integer vector of per-barcode nearest-neighbor Hamming distances (optional)
#' @param original_cds Original CDS before domestication (optional)
#' @param domesticated_cds Domesticated CDS (optional)
#' @param protein Protein sequence (optional)
#' @param gene_description Full gene description for FASTA headers (optional)
#' @param gene_fasta Path to source FASTA file (optional, for provenance)
#' @param skipped_variants Data frame of variants skipped due to gene-edge overlap (optional)
write_outputs <- function(oligos, geneblock_result, variants, barcodes,
                          qc_result, output_dir, gene_name = "gene",
                          min_hamming_dist = NULL,
                          original_cds = NULL, domesticated_cds = NULL,
                          protein = NULL, gene_description = NULL,
                          gene_fasta = NULL,
                          skipped_variants = NULL) {
  if (!dir.exists(output_dir)) {
    dir.create(output_dir, recursive = TRUE)
  }

  blocks <- geneblock_result$blocks
  manifests <- geneblock_result$tile_manifests
  helper <- geneblock_result$helper_plasmid

  # 1. Oligo pool CSV
  oligo_path <- file.path(output_dir, paste0(gene_name, "_oligo_pool.csv"))
  readr::write_csv(oligos, oligo_path)
  cli::cli_alert_success(paste0(
    "Wrote oligo pool: ", oligo_path,
    " (", nrow(oligos), " oligos)"
  ))

  # 2. Gene block order CSV (deduplicated blocks for synthesis ordering)
  block_path <- file.path(output_dir, paste0(gene_name, "_geneblock_order.csv"))
  readr::write_csv(blocks, block_path)
  cli::cli_alert_success(paste0(
    "Wrote gene block order: ", block_path,
    " (", nrow(blocks), " blocks)"
  ))

  # 3. Variant-barcode map CSV
  barcode_map <- data.frame(
    variant_id       = variants$variant_id,
    position         = variants$position,
    wt_aa            = variants$wt_aa,
    mut_aa           = variants$mut_aa,
    wt_codon         = variants$wt_codon,
    mut_codon        = variants$mut_codon,
    variant_type     = if (!is.null(variants$variant_type)) variants$variant_type else NA_character_,
    barcode          = barcodes,
    min_hamming_dist = if (!is.null(min_hamming_dist)) min_hamming_dist else NA_integer_,
    barcode_idx      = if (!is.null(variants$barcode_idx)) variants$barcode_idx else rep(1L, nrow(variants)),
    tile_id          = variants$tile_id,
    stringsAsFactors = FALSE
  )
  map_path <- file.path(output_dir, paste0(gene_name, "_variant_barcode_map.csv"))
  readr::write_csv(barcode_map, map_path)
  cli::cli_alert_success(paste0(
    "Wrote variant-barcode map: ", map_path,
    " (", nrow(barcode_map), " variants)"
  ))

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

  # 9. Sequences FASTA (original CDS, domesticated CDS, protein)
  seq_fasta_path <- NULL
  if (!is.null(original_cds) && !is.null(domesticated_cds) && !is.null(protein)) {
    seq_fasta_path <- file.path(output_dir, paste0(gene_name, "_sequences.fasta"))
    desc <- gene_description %||% gene_name
    source_info <- if (!is.null(gene_fasta)) paste0("Source: ", gene_fasta) else "Source: user-provided CDS"

    # Count domestication mutations
    n_dom <- if (original_cds != domesticated_cds) {
      sum(utf8ToInt(original_cds) != utf8ToInt(domesticated_cds))
    } else {
      0L
    }

    seq_names <- c(
      paste0(gene_name, "_original_CDS ", desc, " | ", source_info),
      paste0(gene_name, "_domesticated_CDS ", desc, " | ", n_dom, " silent mutations applied"),
      paste0(gene_name, "_protein ", desc, " | ", nchar(protein), " aa")
    )
    seq_seqs <- c(original_cds, domesticated_cds, protein)
    write_fasta(seq_names, seq_seqs, seq_fasta_path)
    cli::cli_alert_success(paste0("Wrote sequences FASTA: ", seq_fasta_path))
  }

  # 10. Skipped variants CSV (gene-edge variants with partial oh overlap)
  skipped_path <- NULL
  if (!is.null(skipped_variants) && nrow(skipped_variants) > 0) {
    skipped_path <- file.path(output_dir, paste0(gene_name, "_skipped_variants.csv"))
    skipped_out <- data.frame(
      variant_id = skipped_variants$variant_id,
      position = skipped_variants$position,
      wt_aa = skipped_variants$wt_aa,
      mut_aa = skipped_variants$mut_aa,
      wt_codon = skipped_variants$wt_codon,
      mut_codon = skipped_variants$mut_codon,
      variant_type = if (!is.null(skipped_variants$variant_type)) skipped_variants$variant_type else NA_character_,
      tile_id = skipped_variants$tile_id,
      skip_reason = skipped_variants$skip_reason,
      stringsAsFactors = FALSE
    )
    readr::write_csv(skipped_out, skipped_path)
    cli::cli_alert_success(paste0(
      "Wrote skipped variants: ", skipped_path,
      " (", nrow(skipped_out), " variants)"
    ))
  }

  invisible(list(
    oligo_pool_csv        = oligo_path,
    geneblock_order_csv   = block_path,
    variant_barcode_map   = map_path,
    tile_manifests_csv    = manifest_path,
    helper_plasmid_csv    = helper_path,
    qc_report_csv         = qc_path,
    oligo_pool_fasta      = fasta_path,
    geneblock_order_fasta = block_fasta_path,
    sequences_fasta       = seq_fasta_path,
    skipped_variants_csv  = skipped_path
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
