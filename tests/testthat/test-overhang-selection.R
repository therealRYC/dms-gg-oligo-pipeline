# test-overhang-selection.R — Tests for 06_overhang_selection.R (dynamic boundary search)

test_that("builtin overhang fidelity returns all 256 overhangs", {
  oh_data <- builtin_overhang_fidelity()
  expect_equal(nrow(oh_data), 256)
  expect_true(all(nchar(oh_data$overhang) == 4))
  expect_true(all(oh_data$fidelity > 0 & oh_data$fidelity <= 1))
  # At least 60 overhangs should have >= 0.95 fidelity
  expect_gte(sum(oh_data$fidelity >= 0.95), 60)
  # backward compat alias
  oh_data2 <- builtin_high_fidelity_overhangs()
  expect_equal(nrow(oh_data2), 256)
})

test_that("generate_hf_set selects mutually orthogonal overhangs", {
  oh_data <- builtin_overhang_fidelity()
  hf20 <- generate_hf_set(oh_data, 20)

  expect_equal(length(hf20), 20)
  expect_equal(length(unique(hf20)), 20)

  # No identity or RC collisions
  for (i in seq_along(hf20)) {
    for (j in seq_along(hf20)) {
      if (i != j) {
        expect_true(hf20[i] != hf20[j])
        expect_true(hf20[i] != reverse_complement(hf20[j]))
      }
    }
  }

  # All should be high-fidelity
  fid_lookup <- oh_data$fidelity
  names(fid_lookup) <- oh_data$overhang
  fids <- fid_lookup[hf20]
  expect_true(all(fids >= 0.95))
})

test_that("load_high_fidelity_set returns 20 overhangs", {
  hf_set <- load_high_fidelity_set()
  expect_equal(length(hf_set), 20)
  expect_true(all(nchar(hf_set) == 4))
})

test_that("generate_pairwise_from_fidelity produces correct dimensions", {
  oh_data <- builtin_overhang_fidelity()
  mat <- generate_pairwise_from_fidelity(oh_data)

  expect_equal(nrow(mat), 256)
  expect_equal(ncol(mat), 256)
  # Diagonal should be large
  expect_true(all(diag(mat) > 0))
  # Fidelity should approximately match
  for (i in 1:5) {  # spot-check a few
    oh <- oh_data$overhang[i]
    computed_fid <- mat[oh, oh] / sum(mat[oh, ])
    expect_equal(computed_fid, oh_data$fidelity[i], tolerance = 0.001)
  }
})

test_that("compute_set_fidelity works for small sets", {
  oh_data <- builtin_overhang_fidelity()
  mat <- generate_pairwise_from_fidelity(oh_data)

  # Two overhangs
  result <- compute_set_fidelity(c("AACA", "CCAA"), mat)
  expect_true(result$set_fidelity > 0 && result$set_fidelity <= 1)
  expect_equal(nrow(result$per_overhang), 2)

  # Single overhang
  result1 <- compute_set_fidelity("AACA", mat)
  expect_equal(result1$set_fidelity, 1.0)
})

test_that("search_tile_boundaries returns valid tiles for short gene", {
  cds <- TEST_GENE_SEQ
  # Domesticate first
  cu <- builtin_human_codon_usage()
  scan_result <- scan_enzyme_sites(cds, "", cu)
  if (nrow(scan_result$domestication) > 0) {
    cds <- apply_domestication(cds, scan_result$domestication, codon_usage = cu)
  }

  tile_size <- compute_max_tile_size(300, 12)
  tiles <- search_tile_boundaries(cds, tile_size)

  # Short gene should have 2 tiles (300nt / 243nt max = 2)
  expect_true(nrow(tiles) >= 1)
  # First tile starts at nt 1
  expect_equal(tiles$start_nt[1], 1)
  # Last tile ends at gene length
  expect_equal(tiles$end_nt[nrow(tiles)], nchar(cds))
  # No gaps between tiles
  for (i in seq_len(nrow(tiles) - 1)) {
    expect_equal(tiles$end_nt[i] + 1, tiles$start_nt[i + 1])
  }
  # oh1 and oh2 are 4-nt
  expect_true(all(nchar(tiles$oh1_seq) == 4))
  expect_true(all(nchar(tiles$oh2_seq) == 4))
  # Has HF membership columns
  expect_true("oh1_in_hf" %in% names(tiles))
  expect_true("oh2_in_hf" %in% names(tiles))
  expect_true("oh1_fidelity" %in% names(tiles))
  expect_true("oh2_fidelity" %in% names(tiles))
})

test_that("search_tile_boundaries returns single tile for small gene", {
  tiles <- search_tile_boundaries("ATGGCTTAA", 300)
  expect_equal(nrow(tiles), 1)
  expect_equal(tiles$start_codon[1], 1)
  expect_equal(tiles$end_codon[1], 3)
})

test_that("plan_assembly returns complete assembly plan", {
  cu <- builtin_human_codon_usage()
  scan_result <- scan_enzyme_sites(TEST_GENE_SEQ, "", cu)
  cds <- if (nrow(scan_result$domestication) > 0) {
    apply_domestication(TEST_GENE_SEQ, scan_result$domestication, codon_usage = cu)
  } else {
    TEST_GENE_SEQ
  }

  tile_size <- compute_max_tile_size(300, 12)
  plan <- plan_assembly(cds, TEST_POLIII, tile_size)

  expect_true(is.list(plan))
  expect_true(!is.null(plan$tiles))
  expect_true(!is.null(plan$oh3))
  expect_true(!is.null(plan$oh4))
  expect_equal(nchar(plan$oh3), 4)
  expect_equal(nchar(plan$oh4), 4)
  expect_true(!is.null(plan$superblock_splits))
  expect_true(!is.null(plan$reaction_fidelity))
  expect_true(!is.null(plan$summary))

  # Short gene shouldn't need superblock splits
  expect_equal(nrow(plan$superblock_splits), 0)

  # Reaction fidelity should be computed for each tile
  expect_true(nrow(plan$reaction_fidelity) > 0)
})

test_that("select_orthogonal_set picks distinct overhangs", {
  candidates <- c("AAAA", "AATG", "ACAA", "ACTA", "AGGA")
  selected <- select_orthogonal_set(candidates, 3)

  expect_equal(length(selected), 3)
  expect_equal(length(unique(selected)), 3)

  # No RC collisions
  for (i in seq_along(selected)) {
    for (j in seq_along(selected)) {
      if (i != j) {
        expect_true(selected[i] != reverse_complement(selected[j]))
      }
    }
  }
})

test_that("validate_reaction_overhangs detects non-orthogonal pairs", {
  # Same overhang twice
  expect_false(validate_reaction_overhangs(c("AAAA", "AAAA"), "test"))

  # RC collision
  expect_false(validate_reaction_overhangs(c("ACGT", "ACGT"), "test"))

  # Orthogonal
  expect_true(validate_reaction_overhangs(c("AAAA", "CCCC"), "test"))
})

test_that("validate_fixed_overhangs catches invalid inputs", {
  expect_error(validate_fixed_overhangs("AA", "CCCC"))    # too short
  expect_error(validate_fixed_overhangs("AAAA", "AAAA"))  # identical
})

test_that("manual oh3/oh4 are accepted via select_fixed_overhangs", {
  cu <- builtin_human_codon_usage()
  cds <- TEST_GENE_SEQ
  tiles <- partition_tiles(cds, 150)
  tile_ohs <- extract_tile_overhangs(tiles)

  result <- select_fixed_overhangs(cds, TEST_POLIII, tile_ohs,
                                    manual_oh3 = "ACTA", manual_oh4 = "GATA")
  expect_equal(result$oh3, "ACTA")
  expect_equal(result$oh4, "GATA")
})

test_that("extract_tile_overhangs works with search_tile_boundaries output", {
  cds <- TEST_GENE_SEQ
  tiles <- search_tile_boundaries(cds, 150)
  tile_ohs <- extract_tile_overhangs(tiles)

  expect_equal(nrow(tile_ohs), nrow(tiles))
  expect_true(all(nchar(tile_ohs$oh1_seq) == 4))
  expect_true(all(nchar(tile_ohs$oh2_seq) == 4))
  expect_true(all(!is.na(tile_ohs$oh1_fidelity)))
  expect_true(all(!is.na(tile_ohs$oh2_fidelity)))
})

test_that("plan_assembly handles long gene with superblocking", {
  cu <- builtin_human_codon_usage()
  cds <- TEST_LONG_GENE_SEQ
  scan_result <- scan_enzyme_sites(cds, "", cu)
  if (nrow(scan_result$domestication) > 0) {
    cds <- apply_domestication(cds, scan_result$domestication, codon_usage = cu)
  }

  tile_size <- compute_max_tile_size(300, 12)
  plan <- plan_assembly(cds, TEST_POLIII, tile_size)

  expect_true(nrow(plan$tiles) >= 8)  # 2100/243 ~ 9 tiles
  expect_true(!is.null(plan$superblock_splits))
  # Long gene should trigger superblock splits
  expect_true(nrow(plan$superblock_splits) > 0,
              info = "2100 nt gene should trigger superblock splitting")
  # All junction overhangs should be 4-nt gene-derived
  if (nrow(plan$superblock_splits) > 0) {
    expect_true(all(nchar(plan$superblock_splits$junction_oh) == 4))
  }
})
