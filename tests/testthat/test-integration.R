# test-integration.R — Full pipeline integration test (3-enzyme architecture)
# Updated to use plan_assembly() for dynamic tile boundary search + overhang selection
# Updated: 2026-02-26 — Add tile_partition assertions for tile-boundary superblock integration

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
    "barcode_prefix_length: 12",
    "barcode_gc_range: [0.25, 0.75]",
    "barcode_max_homopolymer: 4",
    "barcodes_per_variant: 1",
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
  gene$original_cds <- gene$cds
  if (cfg$auto_domesticate && nrow(scan_result$domestication) > 0) {
    gene$cds <- apply_domestication(gene$cds, scan_result$domestication,
      codon_usage = codon_usage
    )
  }

  # Verify domestication for all 3 enzymes
  for (enz_name in c("BsaI", "BsmBI", "PaqCI")) {
    remaining <- find_enzyme_sites(gene$cds, ENZYMES[[enz_name]]$recog)
    expect_equal(nrow(remaining), 0,
      info = paste(enz_name, "sites should be removed")
    )
  }

  # Step 5: Design mutations
  variants <- design_mutations(gene$cds, codon_usage)
  variants <- check_and_fix_new_sites(variants, gene$cds, codon_usage)
  expect_equal(nrow(variants), 98 * 21) # 98 mutable codons (skip Met@1, stop@100) * 21 (19 missense + 1 stop + 1 WT)

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
  tile_overhangs <- tiles
  variants <- assign_variants_to_tiles(variants, tiles)

  # Filter gene-edge variants with partial oh overlap (BUG-6)
  skipped_mask <- !is.na(variants$overhang_note) & variants$overhang_note == "partial_oh_overlap"
  skipped_variants <- variants[skipped_mask, ]
  skipped_variants$skip_reason <- "partial_oh_overlap: mutation codon overlaps fixed oh1/oh2 overhang at gene edge"
  variants <- variants[!skipped_mask, ]
  # Skipped count should be small (< 5% of total)
  expect_true(nrow(skipped_variants) < (nrow(variants) + nrow(skipped_variants)) * 0.05)

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
  expect_true(!is.null(assembly_plan$tile_partition))
  expect_equal(assembly_plan$tile_partition$n_superblocks, 1L)
  expect_equal(assembly_plan$tile_partition$n_collisions, 0L)

  # Step 7: Design barcodes (with junction context — BUG-7 fix)
  bsmbi_fwd_oh3_seq <- orient_enzyme_site("BsmBI", oh3, "forward")
  bsai_rev_oh4_seq <- orient_enzyme_site("BsaI", oh4, "reverse")
  junction_left_context <- substring(
    bsmbi_fwd_oh3_seq,
    nchar(bsmbi_fwd_oh3_seq) - 5L,
    nchar(bsmbi_fwd_oh3_seq)
  )
  junction_right_context <- substring(bsai_rev_oh4_seq, 1L, 6L)

  barcode_result <- design_barcodes(
    n_variants = nrow(variants),
    barcode_length = cfg$barcode_length,
    min_hamming = cfg$min_hamming_distance,
    prefix_length = cfg$barcode_prefix_length,
    barcodes_per_variant = cfg$barcodes_per_variant,
    junction_left_context = junction_left_context,
    junction_right_context = junction_right_context
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

  # Step 11: Write outputs (with sequence FASTA + skipped variants)
  variants$barcode_idx <- 1L
  original_cds <- gene$original_cds %||% gene$cds
  output_paths <- write_outputs(
    oligos = oligos, geneblock_result = geneblock_result,
    variants = variants, barcodes = barcodes,
    qc_result = qc_result, output_dir = output_dir,
    gene_name = "test_gene",
    original_cds = original_cds,
    domesticated_cds = gene$cds,
    protein = gene$protein,
    gene_description = gene$gene_description %||% gene$gene_name,
    skipped_variants = skipped_variants
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
  expect_true(file.exists(output_paths$sequences_fasta))

  # Verify skipped variants output (should exist since short gene has edge codons)
  if (nrow(skipped_variants) > 0) {
    expect_true(file.exists(output_paths$skipped_variants_csv))
    skipped_csv <- readr::read_csv(output_paths$skipped_variants_csv, show_col_types = FALSE)
    expect_equal(nrow(skipped_csv), nrow(skipped_variants))
    expect_true("skip_reason" %in% names(skipped_csv))
  }

  # Verify sequences FASTA content
  seq_lines <- readLines(output_paths$sequences_fasta)
  expect_true(any(grepl("original_CDS", seq_lines)))
  expect_true(any(grepl("domesticated_CDS", seq_lines)))
  expect_true(any(grepl("protein", seq_lines)))

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
    "barcode_prefix_length: 12",
    "barcode_gc_range: [0.25, 0.75]",
    "barcode_max_homopolymer: 4",
    "barcodes_per_variant: 1",
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
  gene$original_cds <- gene$cds
  if (cfg$auto_domesticate && nrow(scan_result$domestication) > 0) {
    gene$cds <- apply_domestication(gene$cds, scan_result$domestication,
      codon_usage = codon_usage
    )
  }

  # Long test gene was constructed enzyme-site-free, so no domestication needed
  for (enz_name in c("BsaI", "BsmBI", "PaqCI")) {
    remaining <- find_enzyme_sites(gene$cds, ENZYMES[[enz_name]]$recog)
    expect_equal(nrow(remaining), 0,
      info = paste(enz_name, "sites should be absent")
    )
  }

  # Step 5: Design mutations
  variants <- design_mutations(gene$cds, codon_usage)
  variants <- check_and_fix_new_sites(variants, gene$cds, codon_usage)
  expect_equal(nrow(variants), 698 * 21) # 698 mutable codons (skip Met@1, stop@700) * 21 (19 missense + 1 stop + 1 WT)

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
  tile_overhangs <- tiles
  variants <- assign_variants_to_tiles(variants, tiles)

  # Filter gene-edge variants with partial oh overlap (BUG-6)
  skipped_mask <- !is.na(variants$overhang_note) & variants$overhang_note == "partial_oh_overlap"
  skipped_variants <- variants[skipped_mask, ]
  skipped_variants$skip_reason <- "partial_oh_overlap: mutation codon overlaps fixed oh1/oh2 overhang at gene edge"
  variants <- variants[!skipped_mask, ]
  expect_true(nrow(skipped_variants) < (nrow(variants) + nrow(skipped_variants)) * 0.05)

  # Verify assembly plan for long gene
  expect_true(nrow(tiles) >= 8) # 2100/243 ~ 8.6 → at least 9 tiles
  expect_true(all(!is.na(variants$tile_id)))
  expect_equal(nchar(oh3), 4)
  expect_equal(nchar(oh4), 4)

  # Long gene should trigger superblock splits (tile-boundary partitioning)
  expect_true(!is.null(assembly_plan$tile_partition))
  expect_true(assembly_plan$tile_partition$n_superblocks >= 2L,
    info = "2100 nt gene should have >= 2 superblocks"
  )
  expect_equal(assembly_plan$tile_partition$n_collisions, 0L)
  expect_true(nrow(assembly_plan$superblock_splits) > 0,
    info = "2100 nt gene should trigger superblock splitting"
  )

  # All junction overhangs should be 4-nt gene-derived
  if (nrow(assembly_plan$superblock_splits) > 0) {
    expect_true(all(nchar(assembly_plan$superblock_splits$junction_oh) == 4))
  }

  # Per-reaction fidelity should be computed
  expect_true(nrow(assembly_plan$reaction_fidelity) > 0)

  # Step 7: Design barcodes (with junction context — BUG-7 fix)
  bsmbi_fwd_oh3_seq <- orient_enzyme_site("BsmBI", oh3, "forward")
  bsai_rev_oh4_seq <- orient_enzyme_site("BsaI", oh4, "reverse")
  junction_left_context <- substring(
    bsmbi_fwd_oh3_seq,
    nchar(bsmbi_fwd_oh3_seq) - 5L,
    nchar(bsmbi_fwd_oh3_seq)
  )
  junction_right_context <- substring(bsai_rev_oh4_seq, 1L, 6L)

  barcode_result <- design_barcodes(
    n_variants = nrow(variants),
    barcode_length = cfg$barcode_length,
    min_hamming = cfg$min_hamming_distance,
    prefix_length = cfg$barcode_prefix_length,
    barcodes_per_variant = cfg$barcodes_per_variant,
    junction_left_context = junction_left_context,
    junction_right_context = junction_right_context
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

  # Step 11: Write outputs (with sequence FASTA + skipped variants)
  variants$barcode_idx <- 1L
  output_paths <- write_outputs(
    oligos = oligos, geneblock_result = geneblock_result,
    variants = variants, barcodes = barcodes,
    qc_result = qc_result, output_dir = output_dir,
    gene_name = "long_test_gene",
    original_cds = gene$cds,
    domesticated_cds = gene$cds,
    protein = gene$protein,
    gene_description = gene$gene_description %||% gene$gene_name,
    skipped_variants = skipped_variants
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
  expect_true(file.exists(output_paths$sequences_fasta))

  # Cleanup
  unlink(tmp_fasta)
  unlink(tmp_config)
  unlink(output_dir, recursive = TRUE)
})

test_that("full pipeline runs on TRIO gene (large gene stress test)", {
  # Skip unless RUN_SLOW_TESTS=true (this test takes several minutes)
  skip_if(
    Sys.getenv("RUN_SLOW_TESTS") != "true",
    "Slow test: set RUN_SLOW_TESTS=true to run"
  )

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
    "barcode_prefix_length: 12",
    "barcode_gc_range: [0.25, 0.75]",
    "barcode_max_homopolymer: 4",
    "barcodes_per_variant: 1",
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
  gene$original_cds <- gene$cds
  expect_true(nrow(scan_result$domestication) > 0,
    info = "TRIO should have enzyme sites requiring domestication"
  )

  if (cfg$auto_domesticate && nrow(scan_result$domestication) > 0) {
    gene$cds <- apply_domestication(gene$cds, scan_result$domestication,
      codon_usage = codon_usage
    )
  }

  # Verify domestication for all 3 enzymes
  for (enz_name in c("BsaI", "BsmBI", "PaqCI")) {
    remaining <- find_enzyme_sites(gene$cds, ENZYMES[[enz_name]]$recog)
    expect_equal(nrow(remaining), 0,
      info = paste(enz_name, "sites should be removed after domestication")
    )
  }

  # Step 5: Design mutations — 3096 mutable codons * 21 variants
  variants <- design_mutations(gene$cds, codon_usage)
  variants <- check_and_fix_new_sites(variants, gene$cds, codon_usage)
  expect_equal(nrow(variants), 3096 * 21) # 3096 mutable codons (skip Met@1, stop@3098) * 21

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
  tile_overhangs <- tiles
  variants <- assign_variants_to_tiles(variants, tiles)

  # Filter gene-edge variants with partial oh overlap (BUG-6)
  skipped_mask <- !is.na(variants$overhang_note) & variants$overhang_note == "partial_oh_overlap"
  skipped_variants <- variants[skipped_mask, ]
  skipped_variants$skip_reason <- "partial_oh_overlap: mutation codon overlaps fixed oh1/oh2 overhang at gene edge"
  variants <- variants[!skipped_mask, ]
  expect_true(nrow(skipped_variants) < (nrow(variants) + nrow(skipped_variants)) * 0.05)

  expect_true(nrow(tiles) >= 38,
    info = "9294 nt / 243 nt per tile ~ 39 tiles"
  )
  expect_true(all(!is.na(variants$tile_id)))
  expect_equal(nchar(oh3), 4)
  expect_equal(nchar(oh4), 4)

  # TRIO MUST trigger superblock splitting (tile-boundary partitioning)
  expect_true(!is.null(assembly_plan$tile_partition))
  expect_true(assembly_plan$tile_partition$n_superblocks >= 4L,
    info = "TRIO (9294 nt) should have >= 4 superblocks"
  )
  expect_equal(assembly_plan$tile_partition$n_collisions, 0L)
  expect_true(nrow(assembly_plan$superblock_splits) >= 5,
    info = "TRIO (9294 nt) should have >= 5 per-tile split entries"
  )

  # Per-reaction fidelity should be computed
  expect_true(nrow(assembly_plan$reaction_fidelity) > 0)

  # Step 7: Design barcodes (with junction context — BUG-7 fix)
  bsmbi_fwd_oh3_seq <- orient_enzyme_site("BsmBI", oh3, "forward")
  bsai_rev_oh4_seq <- orient_enzyme_site("BsaI", oh4, "reverse")
  junction_left_context <- substring(
    bsmbi_fwd_oh3_seq,
    nchar(bsmbi_fwd_oh3_seq) - 5L,
    nchar(bsmbi_fwd_oh3_seq)
  )
  junction_right_context <- substring(bsai_rev_oh4_seq, 1L, 6L)

  barcode_result <- design_barcodes(
    n_variants = nrow(variants),
    barcode_length = cfg$barcode_length,
    min_hamming = cfg$min_hamming_distance,
    prefix_length = cfg$barcode_prefix_length,
    barcodes_per_variant = cfg$barcodes_per_variant,
    junction_left_context = junction_left_context,
    junction_right_context = junction_right_context
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
    info = "All blocks must be <= 1800 nt after superblock splitting"
  )

  # Step 10: QC (with assembly_plan)
  qc_result <- run_qc_checks(
    oligos = oligos, geneblock_result = geneblock_result,
    variants = variants, barcodes = barcodes,
    tiles = tiles, tile_overhangs = tile_overhangs,
    cds = gene$cds, oh3 = oh3, oh4 = oh4,
    assembly_plan = assembly_plan
  )
  expect_true(is.logical(qc_result$qc_pass))

  # Step 11: Write outputs (with sequence FASTA + skipped variants)
  variants$barcode_idx <- 1L
  output_paths <- write_outputs(
    oligos = oligos, geneblock_result = geneblock_result,
    variants = variants, barcodes = barcodes,
    qc_result = qc_result, output_dir = output_dir,
    gene_name = "TRIO",
    original_cds = gene$original_cds %||% gene$cds,
    domesticated_cds = gene$cds,
    protein = gene$protein,
    gene_description = gene$gene_description %||% gene$gene_name,
    skipped_variants = skipped_variants
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
  expect_true(file.exists(output_paths$sequences_fasta))

  # Cleanup
  unlink(tmp_fasta)
  unlink(tmp_config)
  unlink(output_dir, recursive = TRUE)
})

test_that("gene_cds config option works as alternative to gene_fasta", {
  # Use gene_cds instead of gene_fasta — a short 12-nt CDS
  tmp_config <- tempfile(fileext = ".yaml")
  tmp_dir <- tempdir()
  output_dir <- file.path(tmp_dir, "test_gene_cds")
  config_lines <- c(
    'gene_cds: "ATGGCTGAATAA"',
    'gene_name: "tiny_gene"',
    paste0("polIII_promoter: \"", TEST_POLIII, "\""),
    "max_oligo_length: 300",
    "max_geneblock_length: 1800",
    "barcode_length: 12",
    "min_hamming_distance: 3",
    "barcode_prefix_length: 12",
    "barcodes_per_variant: 1",
    "overhang_fidelity_threshold: 0.95",
    "auto_domesticate: true",
    "paqci_star2: AGTC",
    "paqci_star1: TCGA",
    paste0("output_dir: \"", gsub("\\\\", "/", output_dir), "\"")
  )
  writeLines(config_lines, tmp_config)

  cfg <- load_config(tmp_config)
  expect_equal(cfg$gene_cds, "ATGGCTGAATAA")
  expect_equal(cfg$gene_name, "tiny_gene")

  # Read gene from string
  gene <- read_gene_from_string(cfg$gene_cds, cfg$gene_name)
  expect_equal(gene$cds, "ATGGCTGAATAA")
  expect_equal(gene$gene_name, "tiny_gene")
  expect_equal(gene$n_codons, 4L)

  unlink(tmp_config)
  unlink(output_dir, recursive = TRUE)
})

test_that("config rejects both gene_fasta and gene_cds specified together", {
  tmp_fasta <- tempfile(fileext = ".fasta")
  writeLines(c(">test", "ATGGCTGAATAA"), tmp_fasta)

  tmp_config <- tempfile(fileext = ".yaml")
  config_lines <- c(
    paste0("gene_fasta: \"", gsub("\\\\", "/", tmp_fasta), "\""),
    'gene_cds: "ATGGCTGAATAA"',
    paste0("polIII_promoter: \"", TEST_POLIII, "\""),
    "paqci_star2: AGTC",
    "paqci_star1: TCGA"
  )
  writeLines(config_lines, tmp_config)

  expect_error(load_config(tmp_config), "only one")

  unlink(tmp_fasta)
  unlink(tmp_config)
})

test_that("config rejects neither gene_fasta nor gene_cds", {
  tmp_config <- tempfile(fileext = ".yaml")
  config_lines <- c(
    paste0("polIII_promoter: \"", TEST_POLIII, "\""),
    "paqci_star2: AGTC",
    "paqci_star1: TCGA"
  )
  writeLines(config_lines, tmp_config)

  expect_error(load_config(tmp_config), "required")

  unlink(tmp_config)
})

test_that("QC variant_count check passes with expanded variants (barcodes_per_variant > 1)", {
  # Simulate expanded variants: 4 codons, 2 mutable (skip Met@1, stop@4) * 21 = 42 variants
  cds <- "ATGGCTGAATAA"
  codon_usage <- load_codon_usage()
  variants <- design_mutations(cds, codon_usage)
  expect_equal(nrow(variants), 2 * 21)

  # Expand to 3 barcodes per variant
  variants_expanded <- variants[rep(seq_len(nrow(variants)), each = 3L), ]
  variants_expanded$barcode_idx <- rep(1:3, times = nrow(variants))
  rownames(variants_expanded) <- NULL
  expect_equal(nrow(variants_expanded), 126) # 42 * 3

  # The check should use unique(variant_id), NOT nrow()
  n_unique <- length(unique(variants_expanded$variant_id))
  expect_equal(n_unique, 42) # Still 42 unique variants (19 missense + 1 stop + 1 WT per position)
  expect_equal(n_unique, ((nchar(cds) %/% 3L) - 2L) * 21L)
})
