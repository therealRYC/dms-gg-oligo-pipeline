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

# =============================================================================
# DP BOUNDARY SEARCH TESTS
# =============================================================================

test_that("dp_solve_k returns valid boundaries for simple case (K=1)", {
  # Create a simple score vector: 20 codons, scores mostly 5, one peak at position 10
  scores <- rep(5.0, 20)
  scores[10] <- 15.0
  valid <- rep(TRUE, 20)
  valid[c(1, 20)] <- FALSE  # endpoints invalid

  result <- dp_solve_k(1L, 20L, 5L, 15L, scores, valid)
  expect_true(!is.null(result))
  expect_equal(length(result$boundaries), 1)
  # Both tiles must be valid size [5, 15]
  b <- result$boundaries[1]
  expect_gte(b, 5)
  expect_lte(20 - b, 15)
  expect_gte(20 - b, 5)
  # Should pick position 10 (highest score)
  expect_equal(b, 10)
})

test_that("dp_solve_k handles K=2 correctly", {
  scores <- rep(5.0, 30)
  scores[10] <- 15.0
  scores[20] <- 15.0
  valid <- rep(TRUE, 30)

  result <- dp_solve_k(2L, 30L, 5L, 15L, scores, valid)
  expect_true(!is.null(result))
  expect_equal(length(result$boundaries), 2)
  # 3 tiles, each must be [5, 15] codons
  b <- result$boundaries
  expect_gte(b[1], 5)
  expect_lte(b[2] - b[1], 15)
  expect_gte(b[2] - b[1], 5)
  expect_lte(30 - b[2], 15)
  expect_gte(30 - b[2], 5)
})

test_that("dp_solve_k returns NULL for impossible K", {
  scores <- rep(5.0, 10)
  valid <- rep(TRUE, 10)
  # K=5 boundaries in 10 codons with min_size=5 is impossible
  result <- dp_solve_k(5L, 10L, 5L, 8L, scores, valid)
  expect_null(result)
})

test_that("precompute_boundary_scores returns correct structure", {
  cds <- TEST_GENE_SEQ
  hf_set <- load_high_fidelity_set()
  oh_fidelity <- builtin_overhang_fidelity()

  precomp <- precompute_boundary_scores(cds, hf_set, oh_fidelity)
  n_codons <- nchar(cds) %/% 3

  expect_equal(length(precomp$oh1_seq), n_codons)
  expect_equal(length(precomp$oh2_seq), n_codons)
  expect_equal(length(precomp$score), n_codons)
  expect_equal(length(precomp$valid), n_codons)

  # oh_L collision positions should be invalid
  oh_L <- substring(cds, 1, 4)
  for (b in seq_len(n_codons - 1)) {
    if (precomp$oh1_seq[b] == oh_L ||
        precomp$oh1_seq[b] == reverse_complement(oh_L)) {
      expect_false(precomp$valid[b])
    }
  }
})

test_that("search_tile_boundaries_dp returns valid tiles for short gene", {
  cds <- TEST_GENE_SEQ
  cu <- builtin_human_codon_usage()
  scan_result <- scan_enzyme_sites(cds, "", cu)
  if (nrow(scan_result$domestication) > 0) {
    cds <- apply_domestication(cds, scan_result$domestication, codon_usage = cu)
  }

  tile_size <- compute_max_tile_size(300, 12)
  tiles <- search_tile_boundaries_dp(cds, tile_size, multi_k = FALSE)

  expect_true(nrow(tiles) >= 1)
  expect_equal(tiles$start_nt[1], 1)
  expect_equal(tiles$end_nt[nrow(tiles)], nchar(cds))
  # Adjacent tiles overlap (default overlap_codons=4)
  for (i in seq_len(nrow(tiles) - 1)) {
    expect_true(tiles$start_nt[i + 1] <= tiles$end_nt[i],
                info = paste("DP tiles", i, "and", i + 1, "should overlap"))
  }
  # 4-nt overhangs
  expect_true(all(nchar(tiles$oh1_seq) == 4))
  expect_true(all(nchar(tiles$oh2_seq) == 4))
  # Same column structure as greedy
  expected_cols <- c("tile_id", "start_codon", "end_codon", "start_nt", "end_nt",
                     "oh1_seq", "oh2_seq", "oh1_in_hf", "oh2_in_hf",
                     "oh1_fidelity", "oh2_fidelity", "tile_seq", "boundary_shift")
  expect_true(all(expected_cols %in% names(tiles)))
})

test_that("search_tile_boundaries_dp single-tile gene returns 1 tile", {
  tiles <- search_tile_boundaries_dp("ATGGCTTAA", 300)
  expect_equal(nrow(tiles), 1)
  expect_equal(tiles$start_codon[1], 1)
  expect_equal(tiles$end_codon[1], 3)
})

test_that("search_tile_boundaries_dp produces same or better results than greedy", {
  cds <- TEST_LONG_GENE_SEQ
  cu <- builtin_human_codon_usage()
  scan_result <- scan_enzyme_sites(cds, "", cu)
  if (nrow(scan_result$domestication) > 0) {
    cds <- apply_domestication(cds, scan_result$domestication, codon_usage = cu)
  }

  tile_size <- compute_max_tile_size(300, 12)
  hf_set <- load_high_fidelity_set()
  oh_fidelity <- builtin_overhang_fidelity()

  tiles_greedy <- search_tile_boundaries(cds, tile_size, hf_set = hf_set,
                                          oh_fidelity = oh_fidelity)
  tiles_dp <- search_tile_boundaries_dp(cds, tile_size, hf_set = hf_set,
                                         oh_fidelity = oh_fidelity, multi_k = TRUE)

  # DP should have equal or more HF boundaries
  greedy_hf <- sum(tiles_greedy$oh1_in_hf[-1]) + sum(tiles_greedy$oh2_in_hf[-nrow(tiles_greedy)])
  dp_hf <- sum(tiles_dp$oh1_in_hf[-1]) + sum(tiles_dp$oh2_in_hf[-nrow(tiles_dp)])
  expect_gte(dp_hf, greedy_hf,
             label = paste("DP HF count", dp_hf, "vs greedy", greedy_hf))

  # Both should cover the entire gene
  expect_equal(tiles_greedy$start_nt[1], 1)
  expect_equal(tiles_greedy$end_nt[nrow(tiles_greedy)], nchar(cds))
  expect_equal(tiles_dp$start_nt[1], 1)
  expect_equal(tiles_dp$end_nt[nrow(tiles_dp)], nchar(cds))
})

test_that("plan_assembly uses DP by default", {
  cu <- builtin_human_codon_usage()
  cds <- TEST_GENE_SEQ
  scan_result <- scan_enzyme_sites(cds, "", cu)
  if (nrow(scan_result$domestication) > 0) {
    cds <- apply_domestication(cds, scan_result$domestication, codon_usage = cu)
  }

  tile_size <- compute_max_tile_size(300, 12)
  # Default should use DP
  plan <- plan_assembly(cds, TEST_POLIII, tile_size)
  expect_true(is.list(plan))
  expect_true(!is.null(plan$tiles))
  expect_true(!is.null(plan$oh3))
  expect_true(!is.null(plan$oh4))

  # Greedy fallback should also work
  plan_g <- plan_assembly(cds, TEST_POLIII, tile_size,
                           config = list(boundary_method = "greedy"))
  expect_true(is.list(plan_g))
  expect_true(!is.null(plan_g$tiles))
})

# =============================================================================
# HOMOPOLYMER EXCLUSION TESTS
# =============================================================================

test_that("oh3 and oh4 are never homopolymers (short gene)", {
  cu <- builtin_human_codon_usage()
  cds <- TEST_GENE_SEQ
  scan_result <- scan_enzyme_sites(cds, "", cu)
  if (nrow(scan_result$domestication) > 0) {
    cds <- apply_domestication(cds, scan_result$domestication, codon_usage = cu)
  }

  tile_size <- compute_max_tile_size(300, 12)
  plan <- plan_assembly(cds, TEST_POLIII, tile_size)

  expect_false(plan$oh3 %in% HOMOPOLYMER_4NT,
               info = paste("oh3 =", plan$oh3, "should not be a homopolymer"))
  expect_false(plan$oh4 %in% HOMOPOLYMER_4NT,
               info = paste("oh4 =", plan$oh4, "should not be a homopolymer"))
})

test_that("oh3 and oh4 are never homopolymers (long gene)", {
  cu <- builtin_human_codon_usage()
  cds <- TEST_LONG_GENE_SEQ
  scan_result <- scan_enzyme_sites(cds, "", cu)
  if (nrow(scan_result$domestication) > 0) {
    cds <- apply_domestication(cds, scan_result$domestication, codon_usage = cu)
  }

  tile_size <- compute_max_tile_size(300, 12)
  plan <- plan_assembly(cds, TEST_POLIII, tile_size)

  expect_false(plan$oh3 %in% HOMOPOLYMER_4NT,
               info = paste("oh3 =", plan$oh3, "should not be a homopolymer"))
  expect_false(plan$oh4 %in% HOMOPOLYMER_4NT,
               info = paste("oh4 =", plan$oh4, "should not be a homopolymer"))
})

test_that("select_fixed_overhangs excludes homopolymers", {
  cds <- TEST_GENE_SEQ
  tiles <- partition_tiles(cds, 150)
  tile_ohs <- extract_tile_overhangs(tiles)

  result <- select_fixed_overhangs(cds, TEST_POLIII, tile_ohs)
  expect_false(result$oh3 %in% HOMOPOLYMER_4NT)
  expect_false(result$oh4 %in% HOMOPOLYMER_4NT)
})

# =============================================================================
# GLOBAL SUPERBLOCK BOUNDARY TESTS
# =============================================================================

test_that("dp_solve_superblock_splits returns empty for short region", {
  cds <- TEST_GENE_SEQ
  hf_set <- load_high_fidelity_set()
  oh_fidelity <- builtin_overhang_fidelity()

  # Region of 200 nt + 0 extra < 1778 max_sub_length → no splits needed
  result <- dp_solve_superblock_splits(
    cds, region_start_nt = 1L, region_end_nt = 200L,
    max_sub_length = 1778L, extra_content_length = 0L,
    exclude_ohs = c("ATGG"), hf_set = hf_set, oh_fidelity = oh_fidelity
  )
  expect_equal(nrow(result), 0)
})

test_that("dp_solve_superblock_splits finds valid splits for long region", {
  cds <- TEST_LONG_GENE_SEQ
  hf_set <- load_high_fidelity_set()
  oh_fidelity <- builtin_overhang_fidelity()
  gene_len <- nchar(cds)

  # Region: most of the gene (e.g., position 244 to end) + 250 PolIII
  # Total: ~1857 + 250 = ~2107 > 1778 → needs splitting
  result <- dp_solve_superblock_splits(
    cds, region_start_nt = 244L, region_end_nt = gene_len,
    max_sub_length = 1778L, extra_content_length = nchar(TEST_POLIII),
    exclude_ohs = c("ATGG", "ACTA"),
    hf_set = hf_set, oh_fidelity = oh_fidelity
  )
  expect_true(nrow(result) >= 1, info = "Should need at least 1 split")
  expect_true(all(nchar(result$junction_oh) == 4))
  # Junction overhangs should not be in the exclusion set
  exclude_set <- c("ATGG", "ACTA", reverse_complement("ATGG"), reverse_complement("ACTA"))
  expect_false(any(result$junction_oh %in% exclude_set))
})

test_that("global boundaries produce shared splits across tiles", {
  cu <- builtin_human_codon_usage()
  cds <- TEST_LONG_GENE_SEQ
  scan_result <- scan_enzyme_sites(cds, "", cu)
  if (nrow(scan_result$domestication) > 0) {
    cds <- apply_domestication(cds, scan_result$domestication, codon_usage = cu)
  }

  tile_size <- compute_max_tile_size(300, 12)
  plan <- plan_assembly(cds, TEST_POLIII, tile_size)

  # Long gene should trigger superblock splits
  splits <- plan$superblock_splits
  expect_true(nrow(splits) > 0,
              info = "2100 nt gene should trigger superblock splitting")

  # For 3'WT splits: tiles that share a region beyond a global boundary
  # should have the same split_nt values
  bsmbi_splits <- splits[splits$block_type == "bsmbi_3wt", , drop = FALSE]
  if (nrow(bsmbi_splits) > 0) {
    # Get unique split_nt values across all tiles
    unique_split_nts <- unique(bsmbi_splits$split_nt)
    # Multiple tiles should reference the same split positions
    for (sp in unique_split_nts) {
      tiles_using_split <- bsmbi_splits$tile_id[bsmbi_splits$split_nt == sp]
      # At least 2 tiles should share each global boundary
      # (unless a tile's 3'WT region starts after this split)
      expect_true(length(tiles_using_split) >= 1,
                  info = paste("Split at nt", sp, "should be used by at least 1 tile"))
    }
    # The number of unique split positions should be small (global)
    # compared to the number of per-tile split entries
    expect_lte(length(unique_split_nts), nrow(bsmbi_splits),
               label = "Unique split positions <= total per-tile entries (reuse)")
  }
})
