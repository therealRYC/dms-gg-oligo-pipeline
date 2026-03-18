# test-pcr-handles.R — Tests for optional PCR handle support
# Tests config parsing (CSV-based), tile size overhead, oligo assembly, and QC

# Helper: write a temp CSV with fwd/rev columns, return the path
write_handles_csv <- function(fwd_seqs, rev_seqs) {
  path <- tempfile(fileext = ".csv")
  readr::write_csv(data.frame(fwd = fwd_seqs, rev = rev_seqs), path)
  path
}

# --- Config Parsing Tests ---

test_that("parse_pcr_handles with NULL returns zero overhead", {
  cfg <- list(max_oligo_length = 300L, pcr_handles = NULL)
  result <- parse_pcr_handles(cfg)
  expect_null(result$pcr_handles)
  expect_equal(result$handle_overhead, 0L)
  expect_equal(result$fwd_handle_length, 0L)
  expect_equal(result$rev_handle_length, 0L)
})

test_that("parse_pcr_handles with empty string returns zero overhead", {
  cfg <- list(max_oligo_length = 300L, pcr_handles = "")
  result <- parse_pcr_handles(cfg)
  expect_null(result$pcr_handles)
  expect_equal(result$handle_overhead, 0L)
})

test_that("parse_pcr_handles loads valid CSV correctly", {
  path <- write_handles_csv(
    c("ACGTACGTACGTACGTACGT", "GCTAGCTAGCTAGCTAGCTA"),
    c("TGCATGCATGCATGCATGCA", "ATCGATCGATCGATCGATCG")
  )
  cfg <- list(max_oligo_length = 300L, pcr_handles = path)
  result <- parse_pcr_handles(cfg)
  expect_equal(length(result$pcr_handles), 2L)
  expect_equal(result$fwd_handle_length, 20L)
  expect_equal(result$rev_handle_length, 20L)
  expect_equal(result$handle_overhead, 40L)
  expect_equal(result$pcr_handles[[1]]$fwd, "ACGTACGTACGTACGTACGT")
})

test_that("parse_pcr_handles uppercases sequences from CSV", {
  path <- write_handles_csv("acgtacgtacgtacgtacgt", "tgcatgcatgcatgcatgca")
  cfg <- list(max_oligo_length = 300L, pcr_handles = path)
  result <- parse_pcr_handles(cfg)
  expect_equal(result$pcr_handles[[1]]$fwd, "ACGTACGTACGTACGTACGT")
  expect_equal(result$pcr_handles[[1]]$rev, "TGCATGCATGCATGCATGCA")
})

test_that("parse_pcr_handles errors on missing file", {
  cfg <- list(max_oligo_length = 300L, pcr_handles = "/nonexistent/handles.csv")
  expect_error(parse_pcr_handles(cfg), "not found")
})

test_that("parse_pcr_handles errors on CSV missing required columns", {
  path <- tempfile(fileext = ".csv")
  readr::write_csv(data.frame(forward = "ACGT", reverse = "TGCA"), path)
  cfg <- list(max_oligo_length = 300L, pcr_handles = path)
  expect_error(parse_pcr_handles(cfg), "fwd.*rev")
})

test_that("parse_pcr_handles errors on empty CSV", {
  path <- tempfile(fileext = ".csv")
  readr::write_csv(data.frame(fwd = character(0), rev = character(0)), path)
  cfg <- list(max_oligo_length = 300L, pcr_handles = path)
  expect_error(parse_pcr_handles(cfg), "empty")
})

test_that("parse_pcr_handles rejects non-ACGT characters", {
  path <- write_handles_csv("ACGTACGTACGTACNNNNN", "TGCATGCATGCATGCATGCA")
  cfg <- list(max_oligo_length = 300L, pcr_handles = path)
  expect_error(parse_pcr_handles(cfg), "non-ACGT")
})

test_that("parse_pcr_handles rejects inconsistent fwd lengths", {
  # Guards against mutable region calculation being ambiguous
  path <- write_handles_csv(
    c("ACGTACGTACGTACGTACGT", "GCTAGCTAGCTA"),
    c("TGCATGCATGCATGCATGCA", "ATCGATCGATCGATCGATCG")
  )
  cfg <- list(max_oligo_length = 300L, pcr_handles = path)
  expect_error(parse_pcr_handles(cfg), "same length")
})

test_that("parse_pcr_handles rejects inconsistent rev lengths", {
  path <- write_handles_csv(
    c("ACGTACGTACGTACGTACGT", "GCTAGCTAGCTAGCTAGCTA"),
    c("TGCATGCATGCATGCATGCA", "ATCGATCGATCG")
  )
  cfg <- list(max_oligo_length = 300L, pcr_handles = path)
  expect_error(parse_pcr_handles(cfg), "same length")
})

test_that("parse_pcr_handles rejects handles shorter than 15 nt", {
  path <- write_handles_csv("ACGTACGTACGTAC", "TGCATGCATGCATG")
  cfg <- list(max_oligo_length = 300L, pcr_handles = path)
  expect_error(parse_pcr_handles(cfg), "below minimum of 15")
})

test_that("parse_pcr_handles rejects handles with BsmBI sites", {
  # BsmBI = CGTCTC — present in fwd handle
  path <- write_handles_csv("ACGTCGTCTCACGTACGT", "TGCATGCATGCATGCATGCA")
  cfg <- list(max_oligo_length = 300L, pcr_handles = path)
  expect_error(parse_pcr_handles(cfg), "BsmBI")
})

test_that("parse_pcr_handles rejects handles with BsaI sites", {
  # BsaI = GGTCTC
  path <- write_handles_csv("ACGTGGTCTCACGTACGT", "TGCATGCATGCATGCATGCA")
  cfg <- list(max_oligo_length = 300L, pcr_handles = path)
  expect_error(parse_pcr_handles(cfg), "BsaI")
})

test_that("parse_pcr_handles warns on duplicate fwd handles", {
  # cli::cli_alert_warning produces a message (not a base R warning)
  path <- write_handles_csv(
    c("ACGTACGTACGTACGTACGT", "ACGTACGTACGTACGTACGT"),
    c("TGCATGCATGCATGCATGCA", "ATCGATCGATCGATCGATCG")
  )
  cfg <- list(max_oligo_length = 300L, pcr_handles = path)
  expect_message(parse_pcr_handles(cfg), "Duplicate fwd")
})

# --- Tiling Tests ---

test_that("compute_max_tile_size with handle_overhead reduces mutable region", {
  size_no_handle <- compute_max_tile_size(300L, 20L, handle_overhead = 0L)
  size_with_handle <- compute_max_tile_size(300L, 20L, handle_overhead = 40L)
  expect_lt(size_with_handle, size_no_handle)
  expect_equal(size_no_handle - size_with_handle, 39L)
  expect_equal(size_no_handle %% 3L, 0L)
  expect_equal(size_with_handle %% 3L, 0L)
})

test_that("compute_max_tile_size with handle_overhead=0 matches no-handle", {
  baseline <- compute_max_tile_size(300L, 12L)
  with_zero <- compute_max_tile_size(300L, 12L, handle_overhead = 0L)
  expect_equal(with_zero, baseline)
})

# --- Assembly Tests ---

test_that("assemble_oligos without pcr_handles produces unchanged oligos", {
  cds <- domesticate_test_gene()
  tiles <- partition_tiles(cds, compute_max_tile_size(300L, 20L))
  variants <- design_mutations(cds, TEST_CODON_USAGE)
  variants <- assign_variants_to_tiles(variants, tiles)
  variants <- variants[is.na(variants$overhang_note) |
    variants$overhang_note != "partial_oh_overlap", ]

  barcodes <- paste0(strrep("A", 10), sprintf("%010d", seq_len(nrow(variants))))
  barcodes <- substring(barcodes, 1, 20)

  oligos_null <- assemble_oligos(variants, cds, barcodes, tiles,
    oh3 = "AATG", oh4 = "GCTA", pcr_handles = NULL)
  oligos_default <- assemble_oligos(variants, cds, barcodes, tiles,
    oh3 = "AATG", oh4 = "GCTA")
  expect_equal(oligos_null$sequence, oligos_default$sequence)
})

test_that("assemble_oligos with pcr_handles prepends fwd and appends rev", {
  cds <- domesticate_test_gene()
  tile_size <- compute_max_tile_size(300L, 20L, handle_overhead = 40L)
  tiles <- partition_tiles(cds, tile_size)

  variants <- design_mutations(cds, TEST_CODON_USAGE)
  variants <- assign_variants_to_tiles(variants, tiles)
  variants <- variants[is.na(variants$overhang_note) |
    variants$overhang_note != "partial_oh_overlap", ]

  barcodes <- paste0(strrep("A", 10), sprintf("%010d", seq_len(nrow(variants))))
  barcodes <- substring(barcodes, 1, 20)

  n_tiles <- nrow(tiles)
  handles <- lapply(seq_len(n_tiles), function(i) {
    list(fwd = paste0(strrep("ACGT", 5)), rev = paste0(strrep("TGCA", 5)))
  })

  oligos_with <- assemble_oligos(variants, cds, barcodes, tiles,
    oh3 = "AATG", oh4 = "GCTA", max_oligo_length = 300L, pcr_handles = handles)

  expect_true(all(startsWith(oligos_with$sequence, "ACGTACGTACGTACGTACGT")))
  expect_true(all(endsWith(oligos_with$sequence, "TGCATGCATGCATGCATGCA")))
  expect_true(all(oligos_with$length <= 300L))
})

test_that("assemble_oligos with handles respects per-tile assignment", {
  cds <- domesticate_test_gene()
  tile_size <- compute_max_tile_size(300L, 20L, handle_overhead = 40L)
  tiles <- partition_tiles(cds, tile_size)
  n_tiles <- nrow(tiles)
  skip_if(n_tiles < 2L, "Need at least 2 tiles for per-tile handle test")

  variants <- design_mutations(cds, TEST_CODON_USAGE)
  variants <- assign_variants_to_tiles(variants, tiles)
  variants <- variants[is.na(variants$overhang_note) |
    variants$overhang_note != "partial_oh_overlap", ]

  barcodes <- paste0(strrep("A", 10), sprintf("%010d", seq_len(nrow(variants))))
  barcodes <- substring(barcodes, 1, 20)

  handles <- list(
    list(fwd = "AAAAAAAAAAAAAAAAAAA", rev = "TTTTTTTTTTTTTTTTTTT"),
    list(fwd = "CCCCCCCCCCCCCCCCCCC", rev = "GGGGGGGGGGGGGGGGGGG")
  )
  if (n_tiles > 2L) {
    for (i in 3:n_tiles) {
      handles[[i]] <- list(
        fwd = paste0(strrep("ACGT", 5)), rev = paste0(strrep("TGCA", 5)))
    }
  }

  oligos <- assemble_oligos(variants, cds, barcodes, tiles,
    oh3 = "AATG", oh4 = "GCTA", max_oligo_length = 300L, pcr_handles = handles)

  tile1_oligos <- oligos$sequence[oligos$tile_id == 1L]
  expect_true(all(startsWith(tile1_oligos, "AAAAAAAAAAAAAAAAAAA")))
  expect_true(all(endsWith(tile1_oligos, "TTTTTTTTTTTTTTTTTTT")))

  tile2_oligos <- oligos$sequence[oligos$tile_id == 2L]
  expect_true(all(startsWith(tile2_oligos, "CCCCCCCCCCCCCCCCCCC")))
  expect_true(all(endsWith(tile2_oligos, "GGGGGGGGGGGGGGGGGGG")))
})

# --- GG Simulator Tests ---

test_that("BsaI digestion strips PCR handles from oligos", {
  oh1 <- "ATCG"
  oh4 <- "GCTA"
  fwd_handle <- "ACGTACGTACGTACGTACGT"
  rev_handle <- "TGCATGCATGCATGCATGCA"
  core_insert <- "AAAAAAGGGGGGTTTTTTTCCCCCC"

  bsai_fwd <- orient_enzyme_site("BsaI", oh1, "forward")
  bsai_rev <- orient_enzyme_site("BsaI", oh4, "reverse")
  oligo_seq <- paste0(fwd_handle, bsai_fwd, core_insert, bsai_rev, rev_handle)

  frags <- digest_linear(oligo_seq, "BsaI", source_label = "oligo")
  frags <- mark_terminal_waste(frags)

  expect_equal(length(frags), 3L)
  expect_equal(frags[[1]]$source, "waste")
  expect_equal(frags[[3]]$source, "waste")
  expect_equal(frags[[2]]$source, "oligo")
  expect_equal(frags[[2]]$oh_5, oh1)
  expect_equal(frags[[2]]$oh_3, oh4)
  expect_true(grepl(core_insert, frags[[2]]$body))
  expect_false(grepl(fwd_handle, frags[[2]]$body))
  expect_false(grepl(rev_handle, frags[[2]]$body))
})

test_that("GG simulator produces identical results with and without handles", {
  cds <- domesticate_test_gene()
  tile_size <- compute_max_tile_size(300L, 20L, handle_overhead = 0L)

  assembly_plan <- plan_assembly(
    cds = cds, polIII = TEST_POLIII,
    max_mutable_nt = tile_size, max_block_length = 1800L,
    config = list(overlap_codons = 6L, boundary_method = "oogga_two_pass",
      oogga_max_identity = 2L, oogga_beam_width = 10L,
      multi_k = FALSE, min_geneblock_length = 300L))
  tiles <- assembly_plan$tiles
  oh3 <- assembly_plan$oh3; oh4 <- assembly_plan$oh4

  variants <- design_mutations(cds, TEST_CODON_USAGE)
  variants <- assign_variants_to_tiles(variants, tiles)
  variants <- variants[is.na(variants$overhang_note) |
    variants$overhang_note != "partial_oh_overlap", ]

  barcode_result <- design_barcodes(n_variants = nrow(variants),
    barcode_length = 20L, min_hamming = 3L, prefix_length = 12L,
    barcodes_per_variant = 1L)
  barcodes <- barcode_result$barcodes
  variants$barcode_idx <- 1L

  oligos_no_handles <- assemble_oligos(variants, cds, barcodes, tiles,
    oh3 = oh3, oh4 = oh4, max_oligo_length = 300L,
    full_seq = assembly_plan$full_seq)

  n_tiles <- nrow(tiles)
  handles <- lapply(seq_len(n_tiles), function(i) {
    list(fwd = paste0(strrep("ACGT", 5)), rev = paste0(strrep("TGCA", 5)))
  })
  oligos_with_handles <- assemble_oligos(variants, cds, barcodes, tiles,
    oh3 = oh3, oh4 = oh4, max_oligo_length = 340L,
    full_seq = assembly_plan$full_seq, pcr_handles = handles)

  geneblock_result <- design_wt_geneblocks(cds = cds, polIII = TEST_POLIII,
    tiles = tiles, oh3 = oh3, oh4 = oh4, paqci_star2 = "AATG",
    paqci_star1 = "GCTA", max_block_length = 1800L, min_block_length = 300L,
    assembly_plan = assembly_plan)

  sim_no_handles <- simulate_pipeline_assembly(
    oligos = oligos_no_handles, geneblock_result = geneblock_result,
    tiles = tiles, variants = variants, barcodes = barcodes,
    cds = cds, polIII = TEST_POLIII,
    assembly_plan = assembly_plan, samples_per_tile = 1L)
  sim_with_handles <- simulate_pipeline_assembly(
    oligos = oligos_with_handles, geneblock_result = geneblock_result,
    tiles = tiles, variants = variants, barcodes = barcodes,
    cds = cds, polIII = TEST_POLIII,
    assembly_plan = assembly_plan, samples_per_tile = 1L)

  expect_equal(sim_with_handles$pass, sim_no_handles$pass,
    info = "Handled vs non-handled oligos should produce identical simulation outcomes")
  expect_equal(sim_with_handles$has_mut_gene, sim_no_handles$has_mut_gene)
  expect_equal(sim_with_handles$has_polIII, sim_no_handles$has_polIII)
  expect_equal(sim_with_handles$has_barcode, sim_no_handles$has_barcode)
})
