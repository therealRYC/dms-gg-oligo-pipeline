# test-tiling.R — Tests for 05_tiling.R (3-enzyme architecture)

test_that("compute_max_tile_size returns correct value for 3-enzyme overhead", {
  # Overhead: BsaI_5'(7) + oh1(4) + BsmBI_oh2(11) + BsmBI_oh3(11) + barcode(12) + BsaI_oh4(11) = 56
  # 300 - 56 = 244. 244/3 = 81.33 → floor to 81 codons = 243 nt
  tile_size <- compute_max_tile_size(300, 12)
  expect_equal(tile_size %% 3, 0)
  expect_equal(tile_size, 243)  # 81 codons
})

test_that("compute_max_tile_size returns positive multiple of 3", {
  tile_size <- compute_max_tile_size(300, 12)
  expect_true(tile_size > 0)
  expect_equal(tile_size %% 3, 0)
  expect_true(tile_size <= 300)
})

test_that("partition_tiles covers entire gene", {
  # Domesticate test gene first
  cu <- builtin_human_codon_usage()
  scan_result <- scan_enzyme_sites(TEST_GENE_SEQ, "", cu)
  cds <- if (nrow(scan_result$domestication) > 0) {
    apply_domestication(TEST_GENE_SEQ, scan_result$domestication, codon_usage = cu)
  } else {
    TEST_GENE_SEQ
  }

  tile_size <- compute_max_tile_size(300, 12)
  tiles <- partition_tiles(cds, tile_size)

  # First tile starts at nt 1
  expect_equal(tiles$start_nt[1], 1)
  # Last tile ends at gene length
  expect_equal(tiles$end_nt[nrow(tiles)], nchar(cds))
  # No gaps between tiles
  for (i in seq_len(nrow(tiles) - 1)) {
    expect_equal(tiles$end_nt[i] + 1, tiles$start_nt[i + 1])
  }
})

test_that("partition_tiles includes oh1 and oh2 sequences", {
  cds <- TEST_GENE_SEQ
  tiles <- partition_tiles(cds, 150)

  # oh1 and oh2 should be 4-nt sequences
  for (i in seq_len(nrow(tiles))) {
    expect_equal(nchar(tiles$oh1_seq[i]), 4)
    expect_equal(nchar(tiles$oh2_seq[i]), 4)
  }

  # oh1 should be the first 4 nt of the tile region
  expect_equal(tiles$oh1_seq[1], substring(cds, 1, 4))

  # oh2 should be the last 4 nt of the tile region
  for (i in seq_len(nrow(tiles))) {
    expected_oh2 <- substring(cds, tiles$end_nt[i] - 3, tiles$end_nt[i])
    expect_equal(tiles$oh2_seq[i], expected_oh2)
  }
})

test_that("partition_tiles handles single-tile gene", {
  tiles_single <- partition_tiles("ATGGCTTAA", 300)
  expect_equal(nrow(tiles_single), 1)
  expect_equal(tiles_single$start_codon[1], 1)
  expect_equal(tiles_single$end_codon[1], 3)
})

test_that("assign_variants_to_tiles assigns all variants", {
  cds <- "ATGGCTGAATAA"
  cu <- builtin_human_codon_usage()
  variants <- design_mutations(cds, cu)
  tiles <- partition_tiles(cds, 300)
  variants <- assign_variants_to_tiles(variants, tiles)

  expect_false(any(is.na(variants$tile_id)))
})

test_that("compute_superblock_boundaries returns empty for short genes", {
  cds <- TEST_GENE_SEQ  # 300 nt — well under 1800 limit
  tiles <- partition_tiles(cds, 150)

  boundaries <- compute_superblock_boundaries(cds, tiles, polIII_len = 250)
  expect_equal(nrow(boundaries), 0)
})

test_that("compute_superblock_boundaries returns boundaries for long genes", {
  # 2100 nt gene + 250 nt PolIII + 22 overhead = 2372 > 1800
  cds <- TEST_LONG_GENE_SEQ
  tile_size <- compute_max_tile_size(300, 12)
  tiles <- partition_tiles(cds, tile_size)

  boundaries <- compute_superblock_boundaries(
    cds, tiles, polIII_len = 250, max_block_length = 1800
  )

  # Should have at least one boundary

  expect_true(nrow(boundaries) > 0)
  # All boundary positions should be valid
  expect_true(all(boundaries$junction_nt > 0))
  expect_true(all(boundaries$junction_nt < nchar(cds)))
  # Junction overhangs should be 4 nt
  expect_true(all(nchar(boundaries$junction_oh) == 4))
})

test_that("partition_tiles covers long gene completely", {
  cds <- TEST_LONG_GENE_SEQ
  tile_size <- compute_max_tile_size(300, 12)
  tiles <- partition_tiles(cds, tile_size)

  # First tile starts at nt 1
  expect_equal(tiles$start_nt[1], 1)
  # Last tile ends at gene length
  expect_equal(tiles$end_nt[nrow(tiles)], nchar(cds))
  # No gaps
  for (i in seq_len(nrow(tiles) - 1)) {
    expect_equal(tiles$end_nt[i] + 1, tiles$start_nt[i + 1])
  }
  # Should have multiple tiles (2100/243 ~ 8.6)
  expect_true(nrow(tiles) >= 8)
})
