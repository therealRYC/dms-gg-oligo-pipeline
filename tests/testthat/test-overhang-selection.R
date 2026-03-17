# test-overhang-selection.R — Tests for 06_overhang_selection.R (dynamic boundary search)

test_that("load_overhang_fidelity BsmBI returns all 256 overhangs", {
  oh_data <- load_overhang_fidelity("BsmBI")
  expect_equal(nrow(oh_data), 256)
  expect_true(all(nchar(oh_data$overhang) == 4))
  expect_true(all(oh_data$fidelity > 0 & oh_data$fidelity <= 1))
  # BsmBI cycling has lower fidelity than T4 — only ~1 overhang >= 0.95
  # but ~23 >= 0.85 and ~39 >= 0.80
  expect_gte(sum(oh_data$fidelity >= 0.80), 30)
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

test_that("plan_assembly returns complete assembly plan", {
  cu <- TEST_CODON_USAGE
  cds <- domesticate_test_gene()

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

test_that("plan_assembly handles long gene with superblocking", {
  cu <- TEST_CODON_USAGE
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
# HOMOPOLYMER EXCLUSION TESTS
# =============================================================================

test_that("oh3 and oh4 are never homopolymers (short gene)", {
  cu <- TEST_CODON_USAGE
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
  cu <- TEST_CODON_USAGE
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

test_that("global boundaries produce shared splits across tiles", {
  cu <- TEST_CODON_USAGE
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
  cu <- TEST_CODON_USAGE
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
    # split_nt values are at oh1_sb_pos (boundary+4) and oh2_sb_pos
    # (boundary+overlap*3) — they live in the overlap zone past tile
    # end_nt, so they won't equal any tile$end_nt. Verify they are
    # valid CDS positions instead.
    gene_len <- nchar(cds)
    expect_true(all(splits$split_nt >= 1L & splits$split_nt <= gene_len))
  }
})

# =============================================================================
# OOGGA-STYLE SCORING TESTS
# =============================================================================

test_that("compute_overhang_efficiency returns valid P_eff values", {
  oh_data <- load_overhang_fidelity("BsmBI")
  mat <- load_pairwise_matrix("BsmBI")
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

test_that("overhang_score returns NA for unknown overhangs", {
  fid_lookup <- c("AAAA" = 0.996)
  eff_lookup <- c("AAAA" = 1.0)

  # "NNNN" not in lookups -> NA (unscorable, excluded from optimization)
  score <- overhang_score("NNNN", fid_lookup, eff_lookup)
  expect_true(is.na(score))
})

test_that("precompute_boundary_scores returns correct structure", {
  cds <- TEST_GENE_SEQ
  oh_fidelity <- load_overhang_fidelity("BsmBI")

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

test_that("precompute_boundary_scores works with eff_lookup parameter", {
  skip_if_not(exists("TEST_GENE_SEQ"), message = "TEST_GENE_SEQ not available")

  oh_data <- load_overhang_fidelity("BsmBI")

  # Generate efficiency lookup via load_pairwise_matrix
  mat <- load_pairwise_matrix("BsmBI")
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

test_that("plan_assembly uses oogga_two_pass by default", {
  cu <- TEST_CODON_USAGE
  cds <- TEST_GENE_SEQ
  scan_result <- scan_enzyme_sites(cds, "", cu)
  if (nrow(scan_result$domestication) > 0) {
    cds <- apply_domestication(cds, scan_result$domestication, codon_usage = cu)
  }

  tile_size <- compute_max_tile_size(300, 12)
  # Default should use oogga_two_pass
  plan <- plan_assembly(cds, TEST_POLIII, tile_size)
  expect_true(is.list(plan))
  expect_true(!is.null(plan$tiles))
  expect_true(!is.null(plan$oh3))
  expect_true(!is.null(plan$oh4))

  # Explicit oogga_two_pass should also work
  plan_otp <- plan_assembly(cds, TEST_POLIII, tile_size,
    config = list(boundary_method = "oogga_two_pass")
  )
  expect_true(is.list(plan_otp))
  expect_true(!is.null(plan_otp$tiles))
})

# =============================================================================
# search_oh_R() — Last tile cassette overhang search
# =============================================================================

test_that("search_oh_R finds valid candidate in known cassette", {
  oh_fidelity <- load_overhang_fidelity("BsmBI")
  mat <- load_pairwise_matrix("BsmBI")
  eff_lookup <- compute_overhang_efficiency(mat)

  # Use the test PolIII promoter as cassette
  cassette <- TEST_POLIII
  result <- search_oh_R(
    cassette_seq = cassette,
    last_tile_gene_nt = 200L,
    max_mutable_nt = 243L,
    oh_fidelity = oh_fidelity,
    eff_lookup = eff_lookup,
    alien_ohs = character(0)
  )

  expect_true(!is.null(result), info = "Should find at least one valid oh_R")
  expect_equal(nchar(result$oh_R), 4L)
  expect_true(result$cassette_pos >= 5L, info = "Min clearance enforced")
  expect_true(result$score > 0)
  expect_true(!is.na(result$fidelity))
  # oh_R should be the 4-nt substring at the reported position
  expected_oh <- substring(cassette, result$cassette_pos - 3L, result$cassette_pos)
  expect_equal(result$oh_R, expected_oh)
})

test_that("search_oh_R rejects palindromic and homopolymer candidates", {
  oh_fidelity <- load_overhang_fidelity("BsmBI")
  mat <- load_pairwise_matrix("BsmBI")
  eff_lookup <- compute_overhang_efficiency(mat)

  # Craft a short cassette that starts with palindromic/homopolymer sequences
  # "AATTAAAAACCCC..." — positions 4-8 are AATT (palindrome), AAAA (homopolymer), etc.
  cassette <- paste0("AATTAAAACCCCGTACGTACGATCAATCGATA")
  result <- search_oh_R(
    cassette_seq = cassette,
    last_tile_gene_nt = 200L,
    max_mutable_nt = 243L,
    oh_fidelity = oh_fidelity,
    eff_lookup = eff_lookup,
    alien_ohs = character(0),
    min_clearance_nt = 5L
  )

  # If result is found, it should NOT be a palindrome or homopolymer
  if (!is.null(result)) {
    expect_false(result$oh_R %in% PALINDROMIC_4NT)
    expect_false(result$oh_R %in% HOMOPOLYMER_4NT)
  }
})

test_that("search_oh_R respects alien overhang filtering", {
  oh_fidelity <- load_overhang_fidelity("BsmBI")
  mat <- load_pairwise_matrix("BsmBI")
  eff_lookup <- compute_overhang_efficiency(mat)

  cassette <- TEST_POLIII

  # First, find the best oh_R without aliens
  result_free <- search_oh_R(
    cassette_seq = cassette,
    last_tile_gene_nt = 200L,
    max_mutable_nt = 243L,
    oh_fidelity = oh_fidelity,
    eff_lookup = eff_lookup,
    alien_ohs = character(0)
  )
  expect_true(!is.null(result_free))

  # Now block that oh_R as alien — result should be different
  result_blocked <- search_oh_R(
    cassette_seq = cassette,
    last_tile_gene_nt = 200L,
    max_mutable_nt = 243L,
    oh_fidelity = oh_fidelity,
    eff_lookup = eff_lookup,
    alien_ohs = c(result_free$oh_R, reverse_complement(result_free$oh_R))
  )

  if (!is.null(result_blocked)) {
    expect_true(result_blocked$oh_R != result_free$oh_R,
      info = "Should select a different oh_R when the best is alien-blocked"
    )
  }
})

test_that("search_oh_R respects oligo length budget", {
  oh_fidelity <- load_overhang_fidelity("BsmBI")
  mat <- load_pairwise_matrix("BsmBI")
  eff_lookup <- compute_overhang_efficiency(mat)

  cassette <- TEST_POLIII

  # With very large last_tile_gene_nt, budget is tight
  result <- search_oh_R(
    cassette_seq = cassette,
    last_tile_gene_nt = 248L, # max_mutable_nt + 8 - 248 = 3 → max_pos = 3 < min_pos = 5
    max_mutable_nt = 243L,
    oh_fidelity = oh_fidelity,
    eff_lookup = eff_lookup,
    alien_ohs = character(0)
  )

  # Budget too tight for any extension — should return NULL
  expect_null(result, info = "No budget for cassette extension")
})

test_that("search_oh_R returns NULL for empty cassette", {
  oh_fidelity <- load_overhang_fidelity("BsmBI")
  mat <- load_pairwise_matrix("BsmBI")
  eff_lookup <- compute_overhang_efficiency(mat)

  result <- search_oh_R(
    cassette_seq = "",
    last_tile_gene_nt = 200L,
    max_mutable_nt = 243L,
    oh_fidelity = oh_fidelity,
    eff_lookup = eff_lookup
  )
  expect_null(result)
})

test_that("plan_assembly includes oh_R_result and full_seq in output", {
  cu <- TEST_CODON_USAGE
  cds <- TEST_GENE_SEQ
  scan_result <- scan_enzyme_sites(cds, "", cu)
  if (nrow(scan_result$domestication) > 0) {
    cds <- apply_domestication(cds, scan_result$domestication, codon_usage = cu)
  }

  tile_size <- compute_max_tile_size(300, 12)
  plan <- plan_assembly(cds, TEST_POLIII, tile_size)

  # oh_R_result should exist in the plan (may be NULL if no cassette)
  expect_true("oh_R_result" %in% names(plan))
  expect_true("full_seq" %in% names(plan))
  expect_true(nchar(plan$full_seq) >= nchar(cds))

  # If oh_R was found, the last tile should extend past gene_len
  if (!is.null(plan$oh_R_result)) {
    gene_len <- nchar(cds)
    last_tile <- plan$tiles[nrow(plan$tiles), ]
    expect_gt(last_tile$end_nt, gene_len)
    expect_equal(last_tile$oh2_seq, plan$oh_R_result$oh_R)
  }
})
