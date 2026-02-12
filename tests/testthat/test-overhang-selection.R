# test-overhang-selection.R — Tests for 06_overhang_selection.R (3-enzyme architecture)

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

test_that("extract_tile_overhangs returns fidelity info", {
  cds <- TEST_GENE_SEQ
  tiles <- partition_tiles(cds, 150)
  tile_ohs <- extract_tile_overhangs(tiles)

  expect_equal(nrow(tile_ohs), nrow(tiles))
  expect_true(all(nchar(tile_ohs$oh1_seq) == 4))
  expect_true(all(nchar(tile_ohs$oh2_seq) == 4))
})

test_that("select_fixed_overhangs returns oh3 and oh4", {
  cu <- builtin_human_codon_usage()
  scan_result <- scan_enzyme_sites(TEST_GENE_SEQ, "", cu)
  cds <- if (nrow(scan_result$domestication) > 0) {
    apply_domestication(TEST_GENE_SEQ, scan_result$domestication, codon_usage = cu)
  } else {
    TEST_GENE_SEQ
  }

  tiles <- partition_tiles(cds, 150)
  tile_ohs <- extract_tile_overhangs(tiles)

  fixed <- select_fixed_overhangs(cds, TEST_POLIII, tile_ohs)

  expect_true(!is.null(fixed$oh3))
  expect_true(!is.null(fixed$oh4))
  expect_equal(nchar(fixed$oh3), 4)
  expect_equal(nchar(fixed$oh4), 4)
  expect_true(fixed$oh3 != fixed$oh4)
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

test_that("manual oh3/oh4 are accepted", {
  cds <- TEST_GENE_SEQ
  tiles <- partition_tiles(cds, 150)
  tile_ohs <- extract_tile_overhangs(tiles)

  result <- select_fixed_overhangs(cds, TEST_POLIII, tile_ohs,
                                    manual_oh3 = "ACTA", manual_oh4 = "GATA")
  expect_equal(result$oh3, "ACTA")
  expect_equal(result$oh4, "GATA")
})
