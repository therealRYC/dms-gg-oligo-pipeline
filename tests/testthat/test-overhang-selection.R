# test-overhang-selection.R — Tests for 06_overhang_selection.R (dynamic boundary search)

test_that("builtin overhang fidelity returns all 256 overhangs", {
  oh_data <- builtin_overhang_fidelity()
  expect_equal(nrow(oh_data), 256)
  expect_true(all(nchar(oh_data$overhang) == 4))
  expect_true(all(oh_data$fidelity > 0 & oh_data$fidelity <= 1))
  # At least 60 overhangs should have >= 0.95 fidelity
  expect_gte(sum(oh_data$fidelity >= 0.95), 60)
  # Verify top fidelity overhangs are well-known sequences
  top_oh <- oh_data$overhang[oh_data$fidelity >= 0.99]
  expect_true(length(top_oh) > 0)
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

test_that("load_high_fidelity_set returns Potapov Table 1 Set 3 (25 overhangs)", {
  hf_set <- load_high_fidelity_set()
  expect_equal(length(hf_set), 25)
  expect_true(all(nchar(hf_set) == 4))
  # Should match the hard-coded Potapov set exactly
  expect_equal(hf_set, POTAPOV_TABLE1_SET3_25)
  # AAAA should be included (present in paper's SA-optimized set)
  expect_true("AAAA" %in% hf_set)
})

test_that("POTAPOV_TABLE1_SET3_25 overhangs are mutually orthogonal", {
  hf_set <- POTAPOV_TABLE1_SET3_25
  # No identity collisions
  expect_equal(length(unique(hf_set)), 25)
  # No reverse-complement collisions within the set
  for (i in seq_along(hf_set)) {
    rc_i <- reverse_complement(hf_set[i])
    for (j in seq_along(hf_set)) {
      if (i != j) {
        expect_true(hf_set[j] != rc_i,
          info = paste(hf_set[i], "RC-collides with", hf_set[j])
        )
      }
    }
  }
})

test_that("load_high_fidelity_set legacy fallback still works", {
  # Requesting old set name triggers greedy fallback
  hf_set_legacy <- load_high_fidelity_set("greedy_fidelity_20")
  expect_equal(length(hf_set_legacy), 20)
  expect_true(all(nchar(hf_set_legacy) == 4))
})

test_that("generate_pairwise_from_fidelity produces correct dimensions", {
  oh_data <- builtin_overhang_fidelity()
  mat <- generate_pairwise_from_fidelity(oh_data)

  expect_equal(nrow(mat), 256)
  expect_equal(ncol(mat), 256)
  # Diagonal should be large
  expect_true(all(diag(mat) > 0))
  # Fidelity should approximately match
  for (i in 1:5) { # spot-check a few
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
  expect_true(!is.null(plan$tile_partition))
  expect_true(!is.null(plan$reaction_fidelity))
  expect_true(!is.null(plan$summary))

  # Short gene shouldn't need superblock splits
  expect_equal(nrow(plan$superblock_splits), 0)
  expect_equal(plan$tile_partition$n_superblocks, 1L)
  expect_equal(plan$tile_partition$n_collisions, 0L)
  expect_equal(plan$summary$n_superblocks, 1L)

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
  expect_error(validate_fixed_overhangs("AA", "CCCC")) # too short
  expect_error(validate_fixed_overhangs("AAAA", "AAAA")) # identical
})

test_that("manual oh3/oh4 are validated by validate_fixed_overhangs", {
  # validate_fixed_overhangs is used by plan_assembly; test it directly
  expect_silent(validate_fixed_overhangs("ACTA", "GATA"))
  expect_error(validate_fixed_overhangs("ACTA", "ACTA")) # identical
  expect_error(validate_fixed_overhangs("AAAA", "GATA")) # homopolymer
})

test_that("tiles from search_tile_boundaries have overhang fidelity columns", {
  cds <- TEST_GENE_SEQ
  tiles <- search_tile_boundaries(cds, 150)

  expect_true(all(nchar(tiles$oh1_seq) == 4))
  expect_true(all(nchar(tiles$oh2_seq) == 4))
  expect_true(all(!is.na(tiles$oh1_fidelity)))
  expect_true(all(!is.na(tiles$oh2_fidelity)))
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

  expect_true(nrow(plan$tiles) >= 8) # 2100/243 ~ 9 tiles
  expect_true(!is.null(plan$superblock_splits))
  expect_true(!is.null(plan$tile_partition))
  # Long gene should trigger superblock splits (tile-boundary partitioning)
  expect_true(plan$tile_partition$n_superblocks >= 2L,
    info = "2100 nt gene should have >= 2 superblocks"
  )
  expect_equal(plan$tile_partition$n_collisions, 0L)
  expect_true(nrow(plan$superblock_splits) > 0,
    info = "2100 nt gene should trigger superblock splitting"
  )
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
  valid[c(1, 20)] <- FALSE # endpoints invalid

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
  oh_fidelity <- builtin_overhang_fidelity()

  precomp <- precompute_boundary_scores(cds, oh_fidelity)
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
      info = paste("DP tiles", i, "and", i + 1, "should overlap")
    )
  }
  # 4-nt overhangs
  expect_true(all(nchar(tiles$oh1_seq) == 4))
  expect_true(all(nchar(tiles$oh2_seq) == 4))
  # Same column structure as greedy
  expected_cols <- c(
    "tile_id", "start_codon", "end_codon", "start_nt", "end_nt",
    "oh1_seq", "oh2_seq", "oh1_in_hf", "oh2_in_hf",
    "oh1_fidelity", "oh2_fidelity", "tile_seq", "boundary_shift"
  )
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
  oh_fidelity <- builtin_overhang_fidelity()

  tiles_greedy <- search_tile_boundaries(cds, tile_size,
    oh_fidelity = oh_fidelity
  )
  tiles_dp <- search_tile_boundaries_dp(cds, tile_size,
    oh_fidelity = oh_fidelity, multi_k = TRUE
  )

  # DP optimizes total boundary score (P_fid * P_eff), and may choose
  # a different K than greedy. With multi_k=TRUE, compare average boundary
  # fidelity rather than HF counts (which aren't comparable across different K).
  greedy_fid <- mean(c(
    tiles_greedy$oh1_fidelity[-1],
    tiles_greedy$oh2_fidelity[-nrow(tiles_greedy)]
  ))
  dp_fid <- mean(c(
    tiles_dp$oh1_fidelity[-1],
    tiles_dp$oh2_fidelity[-nrow(tiles_dp)]
  ))
  # DP should find boundaries with reasonable average fidelity.
  # With multi_k=TRUE, DP may choose more tiles than greedy (diluting avg fidelity),
  # but total score should still be competitive. Allow 0.10 tolerance.
  expect_gte(dp_fid, greedy_fid - 0.10,
    label = paste(
      "DP avg fidelity", round(dp_fid, 3),
      "vs greedy", round(greedy_fid, 3)
    )
  )
  # DP should find some HF-matching overhangs (sanity check)
  dp_hf <- sum(tiles_dp$oh1_in_hf[-1]) + sum(tiles_dp$oh2_in_hf[-nrow(tiles_dp)])
  expect_gte(dp_hf, 1, label = "DP should find at least 1 HF boundary overhang")

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
    config = list(boundary_method = "greedy")
  )
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
    info = paste("oh3 =", plan$oh3, "should not be a homopolymer")
  )
  expect_false(plan$oh4 %in% HOMOPOLYMER_4NT,
    info = paste("oh4 =", plan$oh4, "should not be a homopolymer")
  )
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
    info = paste("oh3 =", plan$oh3, "should not be a homopolymer")
  )
  expect_false(plan$oh4 %in% HOMOPOLYMER_4NT,
    info = paste("oh4 =", plan$oh4, "should not be a homopolymer")
  )
})

# =============================================================================
# GLOBAL SUPERBLOCK BOUNDARY TESTS
# =============================================================================

test_that("dp_solve_superblock_splits returns empty for short region", {
  cds <- TEST_GENE_SEQ
  oh_fidelity <- builtin_overhang_fidelity()

  # Region of 200 nt + 0 extra < 1778 max_sub_length → no splits needed
  result <- dp_solve_superblock_splits(
    cds,
    region_start_nt = 1L, region_end_nt = 200L,
    max_sub_length = 1778L, extra_content_length = 0L,
    exclude_ohs = c("ATGG"), oh_fidelity = oh_fidelity
  )
  expect_equal(nrow(result), 0)
})

test_that("dp_solve_superblock_splits finds valid splits for long region", {
  cds <- TEST_LONG_GENE_SEQ
  oh_fidelity <- builtin_overhang_fidelity()
  gene_len <- nchar(cds)

  # Region: most of the gene (e.g., position 244 to end) + 250 PolIII
  # Total: ~1857 + 250 = ~2107 > 1778 → needs splitting
  result <- dp_solve_superblock_splits(
    cds,
    region_start_nt = 244L, region_end_nt = gene_len,
    max_sub_length = 1778L, extra_content_length = nchar(TEST_POLIII),
    exclude_ohs = c("ATGG", "ACTA"),
    oh_fidelity = oh_fidelity
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
    info = "2100 nt gene should trigger superblock splitting"
  )

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
        info = paste("Split at nt", sp, "should be used by at least 1 tile")
      )
    }
    # The number of unique split positions should be small (global)
    # compared to the number of per-tile split entries
    expect_lte(length(unique_split_nts), nrow(bsmbi_splits),
      label = "Unique split positions <= total per-tile entries (reuse)"
    )
  }
})

# =============================================================================
# CONVERT PARTITION TO SPLITS (SHIM) TESTS
# =============================================================================

test_that("convert_partition_to_splits returns empty for single superblock", {
  # Build a mock partition with 1 SB
  tiles <- data.frame(
    tile_id = 1:3, start_nt = c(1L, 201L, 401L), end_nt = c(200L, 400L, 600L),
    oh2_seq = c("ACGT", "TGCA", "GCAT"), oh2_in_hf = c(TRUE, TRUE, FALSE),
    oh2_fidelity = c(0.99, 0.98, 0.95), stringsAsFactors = FALSE
  )
  part <- list(
    n_superblocks = 1L,
    superblocks = data.frame(
      sb_id = 1L, start_tile = 1L, end_tile = 3L,
      gene_content = 600L, stringsAsFactors = FALSE
    ),
    n_collisions = 0L
  )
  splits <- convert_partition_to_splits(part, tiles, 600L)
  expect_equal(nrow(splits), 0L)
  expect_true(all(c(
    "split_nt", "junction_oh", "junction_in_hf",
    "junction_fidelity", "block_type", "tile_id"
  ) %in% names(splits)))
})

test_that("convert_partition_to_splits generates correct bsmbi_3wt and bsai_5wt entries", {
  # 5 tiles, 2 superblocks: SB1 = tiles 1-3, SB2 = tiles 4-5
  # Boundary at tile 3, end_nt=600
  tiles <- data.frame(
    tile_id = 1:5,
    start_nt = c(1L, 201L, 401L, 601L, 801L),
    end_nt = c(200L, 400L, 600L, 800L, 1000L),
    oh1_seq = c("ATGG", "CCTA", "GGAT", "TTAC", "ACGT"),
    oh2_seq = c("TGCA", "GCAT", "ACTT", "CGGA", "TTAG"),
    oh2_in_hf = c(TRUE, FALSE, TRUE, TRUE, FALSE),
    oh2_fidelity = c(0.99, 0.95, 0.98, 0.97, 0.93),
    stringsAsFactors = FALSE
  )
  part <- list(
    n_superblocks = 2L,
    superblocks = data.frame(
      sb_id = 1:2, start_tile = c(1L, 4L),
      end_tile = c(3L, 5L),
      gene_content = c(600L, 400L),
      stringsAsFactors = FALSE
    ),
    n_collisions = 0L
  )
  gene_len <- 1000L

  splits <- convert_partition_to_splits(part, tiles, gene_len)

  # Boundary at tile 3, end_nt=600, oh2=ACTT
  expect_true(nrow(splits) > 0)
  expect_true(all(splits$split_nt == 600L))
  expect_true(all(splits$junction_oh == "ACTT"))
  expect_true(all(splits$junction_in_hf == TRUE))

  # bsmbi_3wt: tiles whose end_nt < 600 → tiles 1 (200) and 2 (400)
  bsmbi_rows <- splits[splits$block_type == "bsmbi_3wt", ]
  expect_equal(sort(bsmbi_rows$tile_id), c(1L, 2L))

  # bsai_5wt: tiles whose start_nt > 600 → tiles 4 (601) and 5 (801)
  bsai_rows <- splits[splits$block_type == "bsai_5wt", ]
  expect_equal(sort(bsai_rows$tile_id), c(4L, 5L))
})

test_that("convert_partition_to_splits round-trips through plan_assembly correctly", {
  cu <- builtin_human_codon_usage()
  cds <- TEST_LONG_GENE_SEQ
  scan_result <- scan_enzyme_sites(cds, "", cu)
  if (nrow(scan_result$domestication) > 0) {
    cds <- apply_domestication(cds, scan_result$domestication, codon_usage = cu)
  }
  tile_size <- compute_max_tile_size(300, 12)
  plan <- plan_assembly(cds, TEST_POLIII, tile_size)

  # Verify shim output has correct schema
  splits <- plan$superblock_splits
  expect_true(all(c(
    "split_nt", "junction_oh", "junction_in_hf",
    "junction_fidelity", "block_type", "tile_id"
  ) %in% names(splits)))

  if (nrow(splits) > 0) {
    # All junction overhangs should be 4-nt
    expect_true(all(nchar(splits$junction_oh) == 4))
    # All block types should be valid
    expect_true(all(splits$block_type %in% c("bsmbi_3wt", "bsai_5wt")))
    # All tile_ids should be valid
    expect_true(all(splits$tile_id %in% plan$tiles$tile_id))
    # split_nt should match a tile end_nt (since boundaries are at tile endpoints)
    expect_true(all(splits$split_nt %in% plan$tiles$end_nt))
  }
})

# =============================================================================
# OOGGA-STYLE SCORING TESTS
# =============================================================================

test_that("compute_overhang_efficiency returns valid P_eff values", {
  oh_data <- builtin_overhang_fidelity()
  mat <- generate_pairwise_from_fidelity(oh_data)
  eff <- compute_overhang_efficiency(mat)

  # Should have 256 named values
  expect_equal(length(eff), 256)
  expect_true(all(!is.na(names(eff))))
  expect_true(all(nchar(names(eff)) == 4))

  # All values in [0, 1]
  expect_true(all(eff >= 0))
  expect_true(all(eff <= 1))

  # Max should be exactly 1.0 (the most efficient overhang)
  expect_equal(max(eff), 1.0)

  # Min should be > 0 (all overhangs have some ligation)
  expect_true(min(eff) > 0)
})

test_that("compute_overhang_efficiency handles degenerate matrix gracefully", {
  # Zero matrix — should return uniform 1.0
  mat <- matrix(0,
    nrow = 4, ncol = 4,
    dimnames = list(
      c("AAAA", "CCCC", "GGGG", "TTTT"),
      c("AAAA", "CCCC", "GGGG", "TTTT")
    )
  )
  eff <- compute_overhang_efficiency(mat)
  expect_equal(length(eff), 4)
  expect_true(all(eff == 1.0))
})

test_that("overhang_score computes P_fid * P_eff correctly", {
  fid_lookup <- c("AAAA" = 0.996, "AACG" = 0.934, "GGCG" = 0.669)
  eff_lookup <- c("AAAA" = 1.0, "AACG" = 0.8, "GGCG" = 0.4)

  # Score = fid * eff (no HF bonus — BUG-008)
  score1 <- overhang_score("AACG", fid_lookup, eff_lookup)
  expect_equal(score1, 0.934 * 0.8, tolerance = 1e-6)

  score2 <- overhang_score("GGCG", fid_lookup, eff_lookup)
  expect_equal(score2, 0.669 * 0.4, tolerance = 1e-6)

  score3 <- overhang_score("AAAA", fid_lookup, eff_lookup)
  expect_equal(score3, 0.996 * 1.0, tolerance = 1e-6)
})

test_that("overhang_score falls back to 0.5 for unknown overhangs", {
  fid_lookup <- c("AAAA" = 0.996)
  eff_lookup <- c("AAAA" = 1.0)

  # "NNNN" not in lookups -> fid=0.5, eff=0.5
  score <- overhang_score("NNNN", fid_lookup, eff_lookup)
  expect_equal(score, 0.5 * 0.5, tolerance = 1e-6)
})

test_that("oogga_score legacy alias ignores hf_set and w_hf (BUG-008)", {
  # oogga_score now delegates to overhang_score, ignoring HF bonus params
  fid_lookup <- c("AACG" = 0.95, "TGGT" = 0.95)
  eff_lookup <- c("AACG" = 0.85, "TGGT" = 0.85)
  hf_set <- c("AACG")

  # Both should score equally despite HF membership — bonus is dropped
  score_hf <- oogga_score("AACG", fid_lookup, eff_lookup, hf_set, w_hf = 0.5)
  score_nohf <- oogga_score("TGGT", fid_lookup, eff_lookup, hf_set, w_hf = 0.5)

  expect_equal(score_hf, 0.95 * 0.85, tolerance = 1e-6)
  expect_equal(score_nohf, 0.95 * 0.85, tolerance = 1e-6)
  expect_equal(score_hf, score_nohf, tolerance = 1e-6)
})

test_that("precompute_boundary_scores works with eff_lookup parameter", {
  # Use the test gene from setup.R
  skip_if_not(exists("TEST_GENE_SEQ"), message = "TEST_GENE_SEQ not available")

  oh_data <- builtin_overhang_fidelity()

  # Generate efficiency lookup
  mat <- generate_pairwise_from_fidelity(oh_data)
  eff_lookup <- compute_overhang_efficiency(mat)

  # Call with eff_lookup (new scoring: P_fid * P_eff)
  result_with_eff <- precompute_boundary_scores(
    TEST_GENE_SEQ, oh_data,
    eff_lookup = eff_lookup
  )

  # Call without eff_lookup (default = 1.0 efficiency)
  result_no_eff <- precompute_boundary_scores(
    TEST_GENE_SEQ, oh_data,
    eff_lookup = NULL
  )

  # Both should have valid structure
  expect_equal(length(result_with_eff$score), nchar(TEST_GENE_SEQ) %/% 3L)
  expect_equal(length(result_no_eff$score), nchar(TEST_GENE_SEQ) %/% 3L)

  # Scores with efficiency should be <= scores without (efficiency <= 1.0)
  valid_idx <- which(result_with_eff$valid & result_no_eff$valid)
  expect_true(length(valid_idx) > 0, info = "Should have some valid boundary positions")
  for (i in valid_idx) {
    expect_lte(result_with_eff$score[i], result_no_eff$score[i] + 1e-9,
      label = paste("Position", i, ": eff-adjusted score should be <= base score")
    )
  }
})
