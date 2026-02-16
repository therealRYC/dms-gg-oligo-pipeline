# test-integration.R — Full pipeline integration test (3-enzyme architecture)
# Updated to use plan_assembly() for dynamic tile boundary search + overhang selection

test_that("full pipeline runs on short test gene (3-enzyme)", {
  # Write test FASTA
  tmp_fasta <- tempfile(fileext = ".fasta")
  writeLines(c(">test_gene", TEST_GENE_SEQ), tmp_fasta)
  tmp_dir <- tempdir()
  output_dir <- file.path(tmp_dir, "test_output_3enz")

  # Write test config
  tmp_config <- tempfile(fileext = ".yaml")
  config_lines <- c(
    paste0("gene_fasta: \"", gsub("\\\\", "/", tmp_fasta), "\""),
    paste0("polIII_promoter: \"", TEST_POLIII, "\""),
    "max_oligo_length: 300",
    "max_geneblock_length: 1800",
    "barcode_length: 12",
    "min_hamming_distance: 3",
    "barcode_prefix_length: 8",
    "barcode_gc_range: [0.25, 0.75]",
    "barcode_max_homopolymer: 4",
    "overhang_fidelity_threshold: 0.95",
    "search_window_K: 15",
    "auto_domesticate: true",
    "paqci_star2: AGTC",
    "paqci_star1: TCGA",
    paste0("output_dir: \"", gsub("\\\\", "/", output_dir), "\"")
  )
  writeLines(config_lines, tmp_config)

  # Step 1: Load config
  cfg <- load_config(tmp_config)
  expect_true(is.list(cfg))

  # Step 2: Read gene
  gene <- read_gene(cfg$gene_fasta)
  expect_equal(nchar(gene$cds), 300)

  # Step 3: Load codon usage
  codon_usage <- load_codon_usage()
  preferred_codons <- get_preferred_codons(codon_usage)

  # Step 4: Scan and domesticate (now includes BsaI)
  scan_result <- scan_enzyme_sites(gene$cds, cfg$polIII_promoter, codon_usage)
  if (cfg$auto_domesticate && nrow(scan_result$domestication) > 0) {
    gene$cds <- apply_domestication(gene$cds, scan_result$domestication,
                                     codon_usage = codon_usage)
  }

  # Verify domestication for all 3 enzymes
  for (enz_name in c("BsaI", "BsmBI", "PaqCI")) {
    remaining <- find_enzyme_sites(gene$cds, ENZYMES[[enz_name]]$recog)
    expect_equal(nrow(remaining), 0,
                 info = paste(enz_name, "sites should be removed"))
  }

  # Step 5: Design mutations
  variants <- design_mutations(gene$cds, codon_usage)
  variants <- check_and_fix_new_sites(variants, gene$cds, codon_usage)
  expect_equal(nrow(variants), 100 * 20)  # 100 codons * 20 mutations

  # Step 6: Plan assembly (dynamic tile boundary search + overhang selection)
  tile_size <- compute_max_tile_size(cfg$max_oligo_length, cfg$barcode_length)
  assembly_plan <- plan_assembly(
    cds = gene$cds,
    polIII = cfg$polIII_promoter,
    max_mutable_nt = tile_size,
    max_block_length = cfg$max_geneblock_length,
    config = list(
      fidelity_threshold = cfg$overhang_fidelity_threshold,
      search_window_K = cfg$search_window_K
    )
  )
  tiles <- assembly_plan$tiles
  oh3 <- assembly_plan$oh3
  oh4 <- assembly_plan$oh4
  tile_overhangs <- extract_tile_overhangs(tiles)
  variants <- assign_variants_to_tiles(variants, tiles)

  # Verify assembly plan
  expect_true(is.list(assembly_plan))
  expect_true(!is.null(assembly_plan$tiles))
  expect_equal(nchar(oh3), 4)
  expect_equal(nchar(oh4), 4)
  expect_true(!is.null(assembly_plan$reaction_fidelity))
  expect_true(nrow(assembly_plan$reaction_fidelity) > 0)
  expect_true(all(!is.na(variants$tile_id)))

  # Tiles should have HF membership info
  expect_true("oh1_in_hf" %in% names(tiles))
  expect_true("oh2_in_hf" %in% names(tiles))
  expect_true(all(nchar(tiles$oh1_seq) == 4))
  expect_true(all(nchar(tiles$oh2_seq) == 4))

  # Short gene shouldn't need superblock splits
  expect_equal(nrow(assembly_plan$superblock_splits), 0)

  # Step 7: Design barcodes
  barcode_result <- design_barcodes(
    n_variants = nrow(variants),
    barcode_length = cfg$barcode_length,
    min_hamming = cfg$min_hamming_distance,
    prefix_length = cfg$barcode_prefix_length
  )
  barcodes <- barcode_result$barcodes
  expect_equal(length(barcodes), nrow(variants))

  # Step 8: Assemble oligos (universal structure)
  oligos <- assemble_oligos(
    variants = variants, cds = gene$cds, barcodes = barcodes,
    tiles = tiles, oh3 = oh3, oh4 = oh4,
    max_oligo_length = cfg$max_oligo_length
  )
  expect_equal(nrow(oligos), nrow(variants))
  expect_true(all(oligos$length <= cfg$max_oligo_length))

  # Verify all oligos start with BsaI
  expect_true(all(startsWith(oligos$sequence, "GGTCTCA")))

  # Step 9: Design gene blocks + helper plasmid (with assembly_plan)
  geneblock_result <- design_wt_geneblocks(
    cds = gene$cds, polIII = cfg$polIII_promoter,
    tiles = tiles, oh3 = oh3, oh4 = oh4,
    paqci_star2 = cfg$paqci_star2, paqci_star1 = cfg$paqci_star1,
    max_block_length = cfg$max_geneblock_length,
    assembly_plan = assembly_plan
  )
  expect_true(nrow(geneblock_result$blocks) > 0)
  expect_equal(nrow(geneblock_result$tile_manifests), nrow(tiles))
  expect_equal(nrow(geneblock_result$helper_plasmid), 1)

  # Step 10: QC (with assembly_plan for per-reaction fidelity)
  qc_result <- run_qc_checks(
    oligos = oligos, geneblock_result = geneblock_result,
    variants = variants, barcodes = barcodes,
    tiles = tiles, tile_overhangs = tile_overhangs,
    cds = gene$cds, oh3 = oh3, oh4 = oh4,
    assembly_plan = assembly_plan
  )
  expect_true(is.logical(qc_result$qc_pass))

  # Per-reaction fidelity check should be in the QC report
  expect_true("reaction_fidelity" %in% qc_result$qc_report$check_name)

  # Step 11: Write outputs
  variants$barcode_idx <- 1L
  output_paths <- write_outputs(
    oligos = oligos, geneblock_result = geneblock_result,
    variants = variants, barcodes = barcodes,
    qc_result = qc_result, output_dir = output_dir,
    gene_name = "test_gene"
  )

  # Check all output files exist
  expect_true(file.exists(output_paths$oligo_pool_csv))
  expect_true(file.exists(output_paths$geneblock_order_csv))
  expect_true(file.exists(output_paths$variant_barcode_map))
  expect_true(file.exists(output_paths$tile_manifests_csv))
  expect_true(file.exists(output_paths$helper_plasmid_csv))
  expect_true(file.exists(output_paths$qc_report_csv))
  expect_true(file.exists(output_paths$oligo_pool_fasta))
  expect_true(file.exists(output_paths$geneblock_order_fasta))

  # Cleanup
  unlink(tmp_fasta)
  unlink(tmp_config)
  unlink(output_dir, recursive = TRUE)
})

test_that("full pipeline runs on long test gene with superblocking", {
  # This test uses the 2100-nt gene (700 codons) which exceeds
  # the superblock threshold (gene + PolIII + overhead > 1800 nt)

  # Write test FASTA
  tmp_fasta <- tempfile(fileext = ".fasta")
  writeLines(c(">long_test_gene", TEST_LONG_GENE_SEQ), tmp_fasta)
  tmp_dir <- tempdir()
  output_dir <- file.path(tmp_dir, "test_output_long")

  # Write test config
  tmp_config <- tempfile(fileext = ".yaml")
  config_lines <- c(
    paste0("gene_fasta: \"", gsub("\\\\", "/", tmp_fasta), "\""),
    paste0("polIII_promoter: \"", TEST_POLIII, "\""),
    "max_oligo_length: 300",
    "max_geneblock_length: 1800",
    "barcode_length: 12",
    "min_hamming_distance: 3",
    "barcode_prefix_length: 8",
    "barcode_gc_range: [0.25, 0.75]",
    "barcode_max_homopolymer: 4",
    "overhang_fidelity_threshold: 0.95",
    "search_window_K: 15",
    "auto_domesticate: true",
    "paqci_star2: AGTC",
    "paqci_star1: TCGA",
    paste0("output_dir: \"", gsub("\\\\", "/", output_dir), "\"")
  )
  writeLines(config_lines, tmp_config)

  # Step 1: Load config
  cfg <- load_config(tmp_config)

  # Step 2: Read gene
  gene <- read_gene(cfg$gene_fasta)
  expect_equal(nchar(gene$cds), 2100)

  # Step 3: Load codon usage
  codon_usage <- load_codon_usage()

  # Step 4: Scan and domesticate
  scan_result <- scan_enzyme_sites(gene$cds, cfg$polIII_promoter, codon_usage)
  if (cfg$auto_domesticate && nrow(scan_result$domestication) > 0) {
    gene$cds <- apply_domestication(gene$cds, scan_result$domestication,
                                     codon_usage = codon_usage)
  }

  # Long test gene was constructed enzyme-site-free, so no domestication needed
  for (enz_name in c("BsaI", "BsmBI", "PaqCI")) {
    remaining <- find_enzyme_sites(gene$cds, ENZYMES[[enz_name]]$recog)
    expect_equal(nrow(remaining), 0,
                 info = paste(enz_name, "sites should be absent"))
  }

  # Step 5: Design mutations
  variants <- design_mutations(gene$cds, codon_usage)
  variants <- check_and_fix_new_sites(variants, gene$cds, codon_usage)
  expect_equal(nrow(variants), 700 * 20)  # 700 codons * 20 mutations

  # Step 6: Plan assembly (dynamic tile boundary search + superblocks)
  tile_size <- compute_max_tile_size(cfg$max_oligo_length, cfg$barcode_length)
  assembly_plan <- plan_assembly(
    cds = gene$cds,
    polIII = cfg$polIII_promoter,
    max_mutable_nt = tile_size,
    max_block_length = cfg$max_geneblock_length,
    config = list(
      fidelity_threshold = cfg$overhang_fidelity_threshold,
      search_window_K = cfg$search_window_K
    )
  )
  tiles <- assembly_plan$tiles
  oh3 <- assembly_plan$oh3
  oh4 <- assembly_plan$oh4
  tile_overhangs <- extract_tile_overhangs(tiles)
  variants <- assign_variants_to_tiles(variants, tiles)

  # Verify assembly plan for long gene
  expect_true(nrow(tiles) >= 8)  # 2100/243 ~ 8.6 → at least 9 tiles
  expect_true(all(!is.na(variants$tile_id)))
  expect_equal(nchar(oh3), 4)
  expect_equal(nchar(oh4), 4)

  # Long gene should trigger superblock splits
  expect_true(nrow(assembly_plan$superblock_splits) > 0,
              info = "2100 nt gene should trigger superblock splitting")

  # All junction overhangs should be 4-nt gene-derived
  if (nrow(assembly_plan$superblock_splits) > 0) {
    expect_true(all(nchar(assembly_plan$superblock_splits$junction_oh) == 4))
  }

  # Per-reaction fidelity should be computed
  expect_true(nrow(assembly_plan$reaction_fidelity) > 0)

  # Step 7: Design barcodes
  barcode_result <- design_barcodes(
    n_variants = nrow(variants),
    barcode_length = cfg$barcode_length,
    min_hamming = cfg$min_hamming_distance,
    prefix_length = cfg$barcode_prefix_length
  )
  barcodes <- barcode_result$barcodes
  expect_equal(length(barcodes), nrow(variants))

  # Step 8: Assemble oligos
  oligos <- assemble_oligos(
    variants = variants, cds = gene$cds, barcodes = barcodes,
    tiles = tiles, oh3 = oh3, oh4 = oh4,
    max_oligo_length = cfg$max_oligo_length
  )
  expect_equal(nrow(oligos), nrow(variants))
  expect_true(all(oligos$length <= cfg$max_oligo_length))
  expect_true(all(startsWith(oligos$sequence, "GGTCTCA")))

  # Step 9: Design gene blocks + helper plasmid (with assembly_plan)
  geneblock_result <- design_wt_geneblocks(
    cds = gene$cds, polIII = cfg$polIII_promoter,
    tiles = tiles, oh3 = oh3, oh4 = oh4,
    paqci_star2 = cfg$paqci_star2, paqci_star1 = cfg$paqci_star1,
    max_block_length = cfg$max_geneblock_length,
    assembly_plan = assembly_plan
  )
  expect_true(nrow(geneblock_result$blocks) > 0)
  expect_equal(nrow(geneblock_result$tile_manifests), nrow(tiles))
  expect_equal(nrow(geneblock_result$helper_plasmid), 1)

  # Gene blocks should all fit within synthesis limits
  expect_true(all(geneblock_result$blocks$length <= cfg$max_geneblock_length))

  # Step 10: QC (with assembly_plan)
  qc_result <- run_qc_checks(
    oligos = oligos, geneblock_result = geneblock_result,
    variants = variants, barcodes = barcodes,
    tiles = tiles, tile_overhangs = tile_overhangs,
    cds = gene$cds, oh3 = oh3, oh4 = oh4,
    assembly_plan = assembly_plan
  )
  expect_true(is.logical(qc_result$qc_pass))

  # Step 11: Write outputs
  variants$barcode_idx <- 1L
  output_paths <- write_outputs(
    oligos = oligos, geneblock_result = geneblock_result,
    variants = variants, barcodes = barcodes,
    qc_result = qc_result, output_dir = output_dir,
    gene_name = "long_test_gene"
  )

  # Check all output files exist
  expect_true(file.exists(output_paths$oligo_pool_csv))
  expect_true(file.exists(output_paths$geneblock_order_csv))
  expect_true(file.exists(output_paths$variant_barcode_map))
  expect_true(file.exists(output_paths$tile_manifests_csv))
  expect_true(file.exists(output_paths$helper_plasmid_csv))
  expect_true(file.exists(output_paths$qc_report_csv))
  expect_true(file.exists(output_paths$oligo_pool_fasta))
  expect_true(file.exists(output_paths$geneblock_order_fasta))

  # Cleanup
  unlink(tmp_fasta)
  unlink(tmp_config)
  unlink(output_dir, recursive = TRUE)
})

test_that("full pipeline runs on TRIO gene (large gene stress test)", {
  # Skip unless RUN_SLOW_TESTS=true (this test takes several minutes)
  skip_if(Sys.getenv("RUN_SLOW_TESTS") != "true",
          "Slow test: set RUN_SLOW_TESTS=true to run")

  # TRIO: NM_007118.4, 9294 nt, 3098 codons, 20 enzyme sites
  tmp_fasta <- tempfile(fileext = ".fasta")
  writeLines(c(">TRIO", TEST_TRIO_SEQ), tmp_fasta)
  tmp_dir <- tempdir()
  output_dir <- file.path(tmp_dir, "test_output_trio")

  tmp_config <- tempfile(fileext = ".yaml")
  config_lines <- c(
    paste0("gene_fasta: \"", gsub("\\\\", "/", tmp_fasta), "\""),
    paste0("polIII_promoter: \"", TEST_POLIII, "\""),
    "max_oligo_length: 300",
    "max_geneblock_length: 1800",
    "barcode_length: 12",
    "min_hamming_distance: 3",
    "barcode_prefix_length: 8",
    "barcode_gc_range: [0.25, 0.75]",
    "barcode_max_homopolymer: 4",
    "overhang_fidelity_threshold: 0.95",
    "search_window_K: 15",
    "auto_domesticate: true",
    "paqci_star2: AGTC",
    "paqci_star1: TCGA",
    paste0("output_dir: \"", gsub("\\\\", "/", output_dir), "\"")
  )
  writeLines(config_lines, tmp_config)

  # Step 1: Load config
  cfg <- load_config(tmp_config)

  # Step 2: Read gene
  gene <- read_gene(cfg$gene_fasta)
  expect_equal(nchar(gene$cds), 9294)

  # Step 3: Load codon usage
  codon_usage <- load_codon_usage()

  # Step 4: Scan and domesticate — TRIO has 20 enzyme sites
  scan_result <- scan_enzyme_sites(gene$cds, cfg$polIII_promoter, codon_usage)
  expect_true(nrow(scan_result$domestication) > 0,
              info = "TRIO should have enzyme sites requiring domestication")

  if (cfg$auto_domesticate && nrow(scan_result$domestication) > 0) {
    gene$cds <- apply_domestication(gene$cds, scan_result$domestication,
                                     codon_usage = codon_usage)
  }

  # Verify domestication for all 3 enzymes
  for (enz_name in c("BsaI", "BsmBI", "PaqCI")) {
    remaining <- find_enzyme_sites(gene$cds, ENZYMES[[enz_name]]$recog)
    expect_equal(nrow(remaining), 0,
                 info = paste(enz_name, "sites should be removed after domestication"))
  }

  # Step 5: Design mutations — 3098 codons * 20 mutations
  variants <- design_mutations(gene$cds, codon_usage)
  variants <- check_and_fix_new_sites(variants, gene$cds, codon_usage)
  expect_equal(nrow(variants), 3098 * 20)

  # Step 6: Plan assembly (dynamic tile boundary search + superblocks)
  tile_size <- compute_max_tile_size(cfg$max_oligo_length, cfg$barcode_length)
  assembly_plan <- plan_assembly(
    cds = gene$cds,
    polIII = cfg$polIII_promoter,
    max_mutable_nt = tile_size,
    max_block_length = cfg$max_geneblock_length,
    config = list(
      fidelity_threshold = cfg$overhang_fidelity_threshold,
      search_window_K = cfg$search_window_K
    )
  )
  tiles <- assembly_plan$tiles
  oh3 <- assembly_plan$oh3
  oh4 <- assembly_plan$oh4
  tile_overhangs <- extract_tile_overhangs(tiles)
  variants <- assign_variants_to_tiles(variants, tiles)

  expect_true(nrow(tiles) >= 38,
              info = "9294 nt / 243 nt per tile ~ 39 tiles")
  expect_true(all(!is.na(variants$tile_id)))
  expect_equal(nchar(oh3), 4)
  expect_equal(nchar(oh4), 4)

  # TRIO MUST trigger superblock splitting
  expect_true(nrow(assembly_plan$superblock_splits) >= 5,
              info = "TRIO (9294 nt) should have >= 5 superblock split points")

  # Per-reaction fidelity should be computed
  expect_true(nrow(assembly_plan$reaction_fidelity) > 0)

  # Step 7: Design barcodes
  barcode_result <- design_barcodes(
    n_variants = nrow(variants),
    barcode_length = cfg$barcode_length,
    min_hamming = cfg$min_hamming_distance,
    prefix_length = cfg$barcode_prefix_length
  )
  barcodes <- barcode_result$barcodes
  expect_equal(length(barcodes), nrow(variants))

  # Step 8: Assemble oligos
  oligos <- assemble_oligos(
    variants = variants, cds = gene$cds, barcodes = barcodes,
    tiles = tiles, oh3 = oh3, oh4 = oh4,
    max_oligo_length = cfg$max_oligo_length
  )
  expect_equal(nrow(oligos), nrow(variants))
  expect_true(all(oligos$length <= cfg$max_oligo_length))
  expect_true(all(startsWith(oligos$sequence, "GGTCTCA")))

  # Step 9: Design gene blocks + helper plasmid (with assembly_plan)
  geneblock_result <- design_wt_geneblocks(
    cds = gene$cds, polIII = cfg$polIII_promoter,
    tiles = tiles, oh3 = oh3, oh4 = oh4,
    paqci_star2 = cfg$paqci_star2, paqci_star1 = cfg$paqci_star1,
    max_block_length = cfg$max_geneblock_length,
    assembly_plan = assembly_plan
  )
  expect_true(nrow(geneblock_result$blocks) > 0)
  expect_equal(nrow(geneblock_result$tile_manifests), nrow(tiles))
  expect_equal(nrow(geneblock_result$helper_plasmid), 1)

  # All gene blocks should fit within synthesis limits
  expect_true(all(geneblock_result$blocks$length <= cfg$max_geneblock_length),
              info = "All blocks must be <= 1800 nt after superblock splitting")

  # Step 10: QC (with assembly_plan)
  qc_result <- run_qc_checks(
    oligos = oligos, geneblock_result = geneblock_result,
    variants = variants, barcodes = barcodes,
    tiles = tiles, tile_overhangs = tile_overhangs,
    cds = gene$cds, oh3 = oh3, oh4 = oh4,
    assembly_plan = assembly_plan
  )
  expect_true(is.logical(qc_result$qc_pass))

  # Step 11: Write outputs
  variants$barcode_idx <- 1L
  output_paths <- write_outputs(
    oligos = oligos, geneblock_result = geneblock_result,
    variants = variants, barcodes = barcodes,
    qc_result = qc_result, output_dir = output_dir,
    gene_name = "TRIO"
  )

  # Check all output files exist
  expect_true(file.exists(output_paths$oligo_pool_csv))
  expect_true(file.exists(output_paths$geneblock_order_csv))
  expect_true(file.exists(output_paths$variant_barcode_map))
  expect_true(file.exists(output_paths$tile_manifests_csv))
  expect_true(file.exists(output_paths$helper_plasmid_csv))
  expect_true(file.exists(output_paths$qc_report_csv))
  expect_true(file.exists(output_paths$oligo_pool_fasta))
  expect_true(file.exists(output_paths$geneblock_order_fasta))

  # Cleanup
  unlink(tmp_fasta)
  unlink(tmp_config)
  unlink(output_dir, recursive = TRUE)
})
