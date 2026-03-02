# test-cassette-splitting.R — Tests for cassette splitting when downstream cassette > 1778 nt

# =============================================================================
# UNIT TESTS: find_cassette_split_points()
# =============================================================================

test_that("find_cassette_split_points returns empty for small cassette", {
  small_cassette <- paste(rep("A", 500), collapse = "")
  oh_fidelity <- builtin_overhang_fidelity()

  result <- find_cassette_split_points(
    cassette_seq = small_cassette,
    max_sub_length = 1778L,
    existing_ohs = c("ACTA", "GATA"),
    oh_fidelity = oh_fidelity
  )
  expect_equal(nrow(result), 0L)
})

test_that("find_cassette_split_points splits a 2200 nt cassette into 2 fragments", {
  # Build a 2200 nt synthetic cassette (ACGT-only, no enzyme sites)
  set.seed(42)
  bases <- c("A", "C", "G", "T")
  cassette <- paste(sample(bases, 2200, replace = TRUE), collapse = "")

  oh_fidelity <- builtin_overhang_fidelity()

  result <- find_cassette_split_points(
    cassette_seq = cassette,
    max_sub_length = 1778L,
    existing_ohs = c("ACTA", "GATA"),
    oh_fidelity = oh_fidelity
  )

  expect_true(nrow(result) >= 1L,
    info = "Should need at least 1 split for 2200 nt cassette"
  )

  # All fragments should be <= 1778 nt
  split_positions <- c(0L, result$split_pos, 2200L)
  for (j in seq_len(length(split_positions) - 1L)) {
    frag_len <- split_positions[j + 1L] - split_positions[j]
    expect_true(frag_len <= 1778L,
      info = paste("Fragment", j, "=", frag_len, "nt, exceeds 1778")
    )
  }

  # Junction overhangs should be 4 nt
  expect_true(all(nchar(result$junction_oh) == 4L))
})

test_that("find_cassette_split_points handles a 4000 nt cassette", {
  set.seed(123)
  bases <- c("A", "C", "G", "T")
  cassette <- paste(sample(bases, 4000, replace = TRUE), collapse = "")

  oh_fidelity <- builtin_overhang_fidelity()

  result <- find_cassette_split_points(
    cassette_seq = cassette,
    max_sub_length = 1778L,
    existing_ohs = c("ACTA", "GATA", "CACC"),
    oh_fidelity = oh_fidelity
  )

  expect_true(nrow(result) >= 2L,
    info = "Should need >= 2 splits for 4000 nt cassette"
  )

  # All fragments within limit
  split_positions <- c(0L, result$split_pos, 4000L)
  for (j in seq_len(length(split_positions) - 1L)) {
    frag_len <- split_positions[j + 1L] - split_positions[j]
    expect_true(frag_len <= 1778L,
      info = paste("Fragment", j, "=", frag_len, "nt, exceeds 1778")
    )
  }
})

# =============================================================================
# UNIT TESTS: build_cassette_subblocks()
# =============================================================================

test_that("build_cassette_subblocks produces valid BsmBI blocks", {
  set.seed(42)
  bases <- c("A", "C", "G", "T")
  cassette <- paste(sample(bases, 2200, replace = TRUE), collapse = "")

  oh_fidelity <- builtin_overhang_fidelity()

  splits <- find_cassette_split_points(
    cassette_seq = cassette,
    max_sub_length = 1778L,
    existing_ohs = c("ACTA", "GATA"),
    oh_fidelity = oh_fidelity
  )

  result <- build_cassette_subblocks(
    cassette_seq = cassette,
    oh_5 = "ACTA",
    oh_3_final = "CACC",
    oh3_spacer = "G",
    tile_id = 5L,
    sub_offset = 2L,
    cassette_splits = splits,
    max_block_length = 1800L
  )

  expect_true(length(result$blocks) >= 2L)
  expect_true(length(result$part_names) >= 2L)

  # All blocks should have BsmBI recognition sites
  for (b in result$blocks) {
    expect_true(grepl("CGTCTC", b$sequence) || grepl("GAGACG", b$sequence),
      info = paste(b$block_name, "should contain BsmBI site")
    )
  }

  # Block names should include "cassette"
  for (nm in result$part_names) {
    expect_true(grepl("cassette", nm))
  }
})

# =============================================================================
# INTEGRATION TEST: partition_tile_superblocks with oversized cassette
# =============================================================================

test_that("partition_tile_superblocks tolerates oversized cassette", {
  cu <- builtin_human_codon_usage()
  cds <- TEST_LONG_GENE_SEQ
  scan_result <- scan_enzyme_sites(cds, "", cu)
  if (nrow(scan_result$domestication) > 0) {
    cds <- apply_domestication(cds, scan_result$domestication, codon_usage = cu)
  }

  tile_size <- compute_max_tile_size(300, 12)
  tiles <- partition_tiles(cds, tile_size)

  # With a 2000 nt "cassette", partition should NOT error
  result <- partition_tile_superblocks(
    tiles = tiles,
    gene_len = nchar(cds),
    polIII_len = 2000L,
    max_sub_length = 1778L,
    oh3 = "CACC"
  )

  expect_true(result$cassette_needs_splitting)
  expect_true(result$n_superblocks >= 1L)
})

# =============================================================================
# INTEGRATION TEST: Full pipeline with oversized cassette
# =============================================================================

test_that("design_wt_geneblocks handles oversized cassette (last tile)", {
  cu <- builtin_human_codon_usage()
  cds <- TEST_GENE_SEQ # Short 300 nt gene
  scan_result <- scan_enzyme_sites(cds, "", cu)
  if (nrow(scan_result$domestication) > 0) {
    cds <- apply_domestication(cds, scan_result$domestication, codon_usage = cu)
  }

  # Build a very large fake downstream cassette (2000 nt)
  set.seed(99)
  bases <- c("A", "C", "G", "T")
  big_cassette <- paste(sample(bases, 2000, replace = TRUE), collapse = "")

  tile_size <- compute_max_tile_size(300, 12)
  # Use plan_assembly with the large downstream cassette
  plan <- plan_assembly(
    cds = cds, polIII = TEST_POLIII,
    max_mutable_nt = tile_size,
    downstream_cassette = big_cassette
  )
  tiles <- plan$tiles
  result <- design_wt_geneblocks(
    cds = cds, polIII = TEST_POLIII,
    tiles = tiles,
    oh3 = plan$oh3, oh4 = plan$oh4,
    paqci_star2 = "AGTC", paqci_star1 = "TCGA",
    assembly_plan = plan
  )

  blocks <- result$blocks

  # Check that cassette fragment blocks exist
  cassette_blocks <- blocks[grepl("cassette", blocks$block_name), , drop = FALSE]
  expect_true(nrow(cassette_blocks) >= 1L,
    info = "Expected at least 1 cassette fragment block"
  )

  # ALL blocks (including cassette fragments) should be <= 1800 nt
  over_max <- blocks[blocks$length > 1800L, ]
  expect_equal(nrow(over_max), 0L,
    info = paste("Oversized blocks:", paste(over_max$block_name, over_max$length, sep = "=", collapse = ", "))
  )

  # Manifests should include cassette blocks
  manifests <- result$tile_manifests
  any_cassette <- any(grepl("cassette", manifests$bsmbi_parts))
  expect_true(any_cassette, info = "Manifests should reference cassette fragment blocks")
})

# =============================================================================
# REGRESSION TEST: Normal cassette is NOT split
# =============================================================================

test_that("normal cassette (1067 nt) is NOT split", {
  cu <- builtin_human_codon_usage()
  cds <- TEST_LONG_GENE_SEQ
  scan_result <- scan_enzyme_sites(cds, "", cu)
  if (nrow(scan_result$domestication) > 0) {
    cds <- apply_domestication(cds, scan_result$domestication, codon_usage = cu)
  }

  tile_size <- compute_max_tile_size(300, 12)
  plan <- plan_assembly(cds, TEST_POLIII, tile_size)

  tiles <- plan$tiles
  result <- design_wt_geneblocks(
    cds = cds, polIII = TEST_POLIII,
    tiles = tiles,
    oh3 = plan$oh3, oh4 = plan$oh4,
    paqci_star2 = "AGTC", paqci_star1 = "TCGA",
    assembly_plan = plan
  )

  blocks <- result$blocks

  # No cassette fragment blocks should exist with normal PolIII (250 nt)
  cassette_blocks <- blocks[grepl("cassette", blocks$block_name), , drop = FALSE]
  expect_equal(nrow(cassette_blocks), 0L,
    info = "Normal cassette should NOT be split"
  )

  # cassette_needs_splitting should be FALSE
  expect_false(plan$cassette_needs_splitting)
})
