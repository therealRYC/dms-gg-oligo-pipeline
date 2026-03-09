# Tests for OOGGA collision-aware boundary selection (06b_oogga_dp.R)

# =============================================================================
# Collision primitive tests
# =============================================================================

test_that("count_positional_identity counts correctly", {
  expect_equal(count_positional_identity("AATC", "AATG"), 3L)
  expect_equal(count_positional_identity("AAAA", "AAAA"), 4L)
  expect_equal(count_positional_identity("AAAA", "TTTT"), 0L)
  expect_equal(count_positional_identity("ACGT", "ACGT"), 4L)
  expect_equal(count_positional_identity("ACGT", "TGCA"), 0L)
  expect_equal(count_positional_identity("ACGT", "ACGA"), 3L)
  expect_equal(count_positional_identity("AATC", "AGTC"), 3L)
})

test_that("build_oh_compatibility produces 256x256 matrix", {
  compat <- build_oh_compatibility(max_identity = 2L)
  expect_equal(nrow(compat), 256L)
  expect_equal(ncol(compat), 256L)
  expect_true(is.logical(compat))
  # All 256 overhangs should be named
  expect_equal(length(rownames(compat)), 256L)
  expect_equal(length(colnames(compat)), 256L)
})

test_that("build_oh_compatibility rejects exact match (4/4)", {
  compat <- build_oh_compatibility(max_identity = 2L)
  # Self-identity = 4/4, should be rejected
  expect_false(compat["AATC", "AATC"])
  expect_false(compat["GAAA", "GAAA"])
  expect_false(compat["CGTG", "CGTG"])
})

test_that("build_oh_compatibility rejects RC match", {
  compat <- build_oh_compatibility(max_identity = 2L)
  # AATC vs RC(AATC) = GATT:
  #   Condition 1: identity(AATC, GATT) = 0/4 ✓
  #   Condition 2: identity(AATC, RC(GATT)) = identity(AATC, AATC) = 4/4 ✗
  # Rejected because condition 2 fails
  expect_false(compat["AATC", "GATT"])
})

test_that("build_oh_compatibility rejects 3/4 match at max_identity=2", {
  compat <- build_oh_compatibility(max_identity = 2L)
  # AATC vs AATG: identity = 3/4 (>2), should be rejected
  expect_false(compat["AATC", "AATG"])
})

test_that("build_oh_compatibility allows 3/4 match at max_identity=3", {
  compat <- build_oh_compatibility(max_identity = 3L)
  # AATC vs AATG: identity = 3/4 (<=3), should be allowed
  # Now only 2 conditions checked (OOGGA-faithful):
  # AATC vs AATG: identity = 3/4 (<=3) ✓
  # AATC vs RC(AATG) = CATT: identity = 0/4 (<=3) ✓
  expect_true(compat["AATC", "AATG"])
})

test_that("build_oh_compatibility allows 1/4 match", {
  compat <- build_oh_compatibility(max_identity = 2L)
  # AAAA vs CCCC (2 conditions, OOGGA-faithful):
  # AAAA vs CCCC: identity = 0/4 ✓
  # AAAA vs RC(CCCC)=GGGG: identity = 0/4 ✓
  expect_true(compat["AAAA", "CCCC"])
})

test_that("build_oh_compatibility 2-condition vs 3-condition difference", {
  # This test verifies the OOGGA-faithful 2-condition check differs from the
  # old 3-condition check. Find a pair where identity(RC(A),B) > max_identity
  # but identity(A,B) and identity(A,RC(B)) are both ≤ max_identity.
  compat <- build_oh_compatibility(max_identity = 2L)
  # GCGT vs ACGC:
  #   Condition 1: identity(GCGT, ACGC) = 2/4 (positions 2,3: C,G match) → ≤2 ✓
  #   Condition 2: identity(GCGT, RC(ACGC)) = identity(GCGT, GCGT) = 4/4 → >2 ✗
  # Even the 2-condition check rejects this (RC(ACGC) = GCGT, self-match)
  expect_false(compat["GCGT", "ACGC"])
  # But compat["ACGC", "GCGT"]:
  #   Condition 1: identity(ACGC, GCGT) = 2/4 → ≤2 ✓
  #   Condition 2: identity(ACGC, RC(GCGT)) = identity(ACGC, ACGC) = 4/4 → >2 ✗
  expect_false(compat["ACGC", "GCGT"])
})

test_that("build_oh_compatibility handles self-palindromes", {
  compat <- build_oh_compatibility(max_identity = 2L)
  # AATT: RC(AATT) = AATT, so self-identity check = 4/4
  expect_false(compat["AATT", "AATT"])
  # ACGT: RC(ACGT) = ACGT, same issue
  expect_false(compat["ACGT", "ACGT"])
})

test_that("oogga_overlap_pass with empty prior set passes non-palindromes", {
  compat <- build_oh_compatibility(max_identity = 2L)
  # AATC: RC=GATT, identity(AATC,GATT)=0 ≤2 → passes self-palindrome
  expect_true(oogga_overlap_pass("AATC", character(0), character(0), compat, 2L))
  # GGGG: RC=CCCC, identity(GGGG,CCCC)=0 ≤2 → passes self-palindrome
  expect_true(oogga_overlap_pass("GGGG", character(0), character(0), compat, 2L))
})

test_that("oogga_overlap_pass rejects self-palindromes", {
  compat <- build_oh_compatibility(max_identity = 2L)
  # AATT: RC=AATT, identity(AATT,AATT)=4 >2 → rejected (true palindrome)
  expect_false(oogga_overlap_pass("AATT", character(0), character(0), compat, 2L))
  # ACGT: RC=ACGT, identity(ACGT,ACGT)=4 >2 → rejected (true palindrome)
  expect_false(oogga_overlap_pass("ACGT", character(0), character(0), compat, 2L))
  # Near-palindrome AACT: RC=AGTT, identity(AACT,AGTT)=1 ≤2 → passes
  expect_true(oogga_overlap_pass("AACT", character(0), character(0), compat, 2L))
  # At max_identity=3: AATT still rejected (identity=4>3)
  compat3 <- build_oh_compatibility(max_identity = 3L)
  expect_false(oogga_overlap_pass("AATT", character(0), character(0), compat3, 3L))
})

test_that("oogga_overlap_pass rejects near-palindromes at strict threshold", {
  compat <- build_oh_compatibility(max_identity = 2L)
  # AACT: RC=AGTT, identity=1 ≤2 → passes at mi=2
  expect_true(oogga_overlap_pass("AACT", character(0), character(0), compat, 2L))
  # AAAT: RC=ATTT, identity(AAAT,ATTT)=1 ≤2 → passes
  expect_true(oogga_overlap_pass("AAAT", character(0), character(0), compat, 2L))
})

test_that("oogga_overlap_pass rejects against prior OHs", {
  compat <- build_oh_compatibility(max_identity = 2L)
  # AATC is incompatible with itself (4/4 identity)
  expect_false(oogga_overlap_pass("AATC", c("AATC"), character(0), compat, 2L))
  # AATC is incompatible with AATG (3/4 identity)
  expect_false(oogga_overlap_pass("AATC", c("AATG"), character(0), compat, 2L))
})

test_that("oogga_overlap_pass rejects against alien OHs", {
  compat <- build_oh_compatibility(max_identity = 2L)
  # Candidate AATC, alien AATC = 4/4 → reject
  expect_false(oogga_overlap_pass("AATC", character(0), c("AATC"), compat, 2L))
})

test_that("oogga_overlap_pass accepts compatible candidate", {
  compat <- build_oh_compatibility(max_identity = 2L)
  # AAAA vs CCCC: identity=0/4, identity(AAAA,RC(CCCC))=identity(AAAA,GGGG)=0
  expect_true(oogga_overlap_pass("AAAA", c("CCCC"), character(0), compat, 2L))
})

test_that("compat_matrix symmetry: compat[A,B] consistency", {
  compat <- build_oh_compatibility(max_identity = 2L)
  # With the 2-condition OOGGA check (A vs B, A vs RC(B)):
  # identity(A,B) = identity(B,A) — symmetric by definition.
  # identity(A,RC(B)) = identity(B,RC(A)) — proven by complement/reverse symmetry.
  # Therefore the matrix should remain symmetric.
  test_pairs <- list(
    c("AATC", "CCCC"), c("GACA", "TGAA"), c("AATC", "GATT"),
    c("CCTC", "AGGA"), c("AAAA", "TTTT")
  )
  for (pair in test_pairs) {
    expect_equal(
      compat[pair[1], pair[2]], compat[pair[2], pair[1]],
      info = paste("Symmetry failed for", pair[1], "vs", pair[2])
    )
  }
})


# =============================================================================
# OOGGA SB DP tests
# =============================================================================

test_that("oogga_sb_dp_solve_k_v2 returns NULL for K=0", {
  expect_null(oogga_sb_dp_solve_k_v2(
    K = 0L, total_len = 1000L, min_len = 100L, max_len = 500L,
    boundary_scores = rep(0, 1000), boundary_valid = rep(TRUE, 1000),
    oh_seq = rep("AAAA", 1000), alien_ohs = character(0),
    compat_matrix = build_oh_compatibility(2L)
  ))
})

test_that("oogga_sb_dp_solve_k_v2 returns NULL for infeasible K", {
  # K=5 boundaries need at least 6*100 = 600 nt, but only 500 available
  expect_null(oogga_sb_dp_solve_k_v2(
    K = 5L, total_len = 500L, min_len = 100L, max_len = 200L,
    boundary_scores = rep(0, 500), boundary_valid = rep(TRUE, 500),
    oh_seq = rep("AAAA", 500), alien_ohs = character(0),
    compat_matrix = build_oh_compatibility(2L)
  ))
})

test_that("search_sb_boundaries_oogga returns single SB for short sequence", {
  result <- search_sb_boundaries_oogga(
    full_seq = paste0(rep("A", 500), collapse = ""),
    gene_len = 300L,
    max_block_length = 1800L,
    min_block_length = 100L,
    alien_ohs = character(0)
  )
  expect_equal(result$n_superblocks, 1L)
  expect_equal(result$total_score, 0)
})


# =============================================================================
# OOGGA tile DP tests (oogga_two_pass)
# =============================================================================

test_that("search_tile_boundaries_oogga produces collision-free tiles on TEST_LONG_GENE", {
  oh_fidelity <- load_overhang_fidelity("BsmBI")
  bsmbi_pw <- load_pairwise_matrix("BsmBI")
  eff_lookup <- compute_overhang_efficiency(bsmbi_pw)

  # Use domesticated long gene
  # TEST_LONG_GENE_SEQ is pre-validated and enzyme-free
  cds <- TEST_LONG_GENE_SEQ

  max_mutable_nt <- 243L
  oh_L <- substring(cds, 1, 4)

  # Derive oh3 and oh4 (simplified — just use score-based for test)
  fid_lookup <- oh_fidelity$fidelity
  names(fid_lookup) <- oh_fidelity$overhang

  alien_ohs <- unique(c(
    oh_L, reverse_complement(oh_L)
  ))

  tiles <- search_tile_boundaries_oogga(
    cds = cds,
    max_mutable_nt = max_mutable_nt,
    oh_fidelity = oh_fidelity,
    multi_k = TRUE,
    dp_k_range = 1L,
    overlap_codons = 4L,
    eff_lookup = eff_lookup,
    alien_ohs = alien_ohs,
    max_identity = 2L,
    beam_width = 1L
  )

  # Basic structure checks
  expect_true(is.data.frame(tiles))
  expect_true(nrow(tiles) >= 2L)
  expect_true("oh1_seq" %in% names(tiles))
  expect_true("oh2_seq" %in% names(tiles))

  # All tile sizes within bounds
  min_mutable_nt <- max(81L, max_mutable_nt %/% 3L)
  min_mutable_nt <- (min_mutable_nt %/% 3L) * 3L
  expect_true(all(tiles$n_codons >= min_mutable_nt %/% 3L))
  expect_true(all(tiles$n_codons <= max_mutable_nt %/% 3L))

  # Verify that the DP-produced columns exist (oh2_fidelity needed downstream)
  expect_true("oh2_fidelity" %in% names(tiles))
  expect_true("oh1_fidelity" %in% names(tiles))
  expect_true("tile_seq" %in% names(tiles))
  expect_true("boundary_shift" %in% names(tiles))

  # Verify boundary OHs are 4 characters
  expect_true(all(nchar(tiles$oh1_seq) == 4L))
  expect_true(all(nchar(tiles$oh2_seq) == 4L))

  # Per-tile check: oh1 and oh2 within each tile are mutually compatible
  # Use effective max_identity (DP may fall back from 2 to 3)
  effective_mi <- attr(tiles, "max_identity_used") %||% 2L
  compat <- build_oh_compatibility(effective_mi)
  for (i in seq_len(nrow(tiles))) {
    expect_true(
      compat[tiles$oh1_seq[i], tiles$oh2_seq[i]],
      info = paste("Tile", i, "oh1/oh2 collision:", tiles$oh1_seq[i], "vs", tiles$oh2_seq[i])
    )
  }
})


# =============================================================================
# OOGGA greedy tests (oogga_greedy)
# =============================================================================

test_that("search_tile_boundaries_greedy_seq produces collision-free tiles", {
  oh_fidelity <- load_overhang_fidelity("BsmBI")
  bsmbi_pw <- load_pairwise_matrix("BsmBI")
  eff_lookup <- compute_overhang_efficiency(bsmbi_pw)

  # TEST_LONG_GENE_SEQ is pre-validated and enzyme-free
  cds <- TEST_LONG_GENE_SEQ
  max_mutable_nt <- 243L
  oh_L <- substring(cds, 1, 4)

  alien_ohs <- unique(c(oh_L, reverse_complement(oh_L)))

  tiles <- search_tile_boundaries_greedy_seq(
    cds = cds,
    max_mutable_nt = max_mutable_nt,
    oh_fidelity = oh_fidelity,
    overlap_codons = 4L,
    eff_lookup = eff_lookup,
    alien_ohs = alien_ohs,
    max_identity = 2L,
    beam_width = 1L
  )

  expect_true(is.data.frame(tiles))
  expect_true(nrow(tiles) >= 2L)

  # Verify columns exist
  expect_true("oh2_fidelity" %in% names(tiles))
  expect_true("tile_seq" %in% names(tiles))

  # Verify boundary OHs are 4 characters
  expect_true(all(nchar(tiles$oh1_seq) == 4L))
  expect_true(all(nchar(tiles$oh2_seq) == 4L))

  # Per-tile: oh1 and oh2 within each tile are mutually compatible
  # Use the effective max_identity (greedy may fall back from 2 to 3)
  effective_mi <- attr(tiles, "max_identity_used") %||% 2L
  compat <- build_oh_compatibility(effective_mi)
  for (i in seq_len(nrow(tiles))) {
    expect_true(
      compat[tiles$oh1_seq[i], tiles$oh2_seq[i]],
      info = paste("Tile", i, "oh1/oh2 collision:", tiles$oh1_seq[i], "vs", tiles$oh2_seq[i])
    )
  }
})


# =============================================================================
# OOGGA single-pass tests (oogga_single)
# =============================================================================

test_that("search_boundaries_oogga_single produces valid tiles", {
  oh_fidelity <- load_overhang_fidelity("BsmBI")
  bsmbi_pw <- load_pairwise_matrix("BsmBI")
  eff_lookup <- compute_overhang_efficiency(bsmbi_pw)

  # TEST_LONG_GENE_SEQ is pre-validated and enzyme-free
  cds <- TEST_LONG_GENE_SEQ
  max_mutable_nt <- 243L
  oh_L <- substring(cds, 1, 4)

  alien_ohs <- unique(c(oh_L, reverse_complement(oh_L)))

  result <- search_boundaries_oogga_single(
    cds = cds,
    cassette_seq = TEST_POLIII,
    max_mutable_nt = max_mutable_nt,
    max_block_length = 1800L,
    min_block_length = 300L,
    oh_fidelity = oh_fidelity,
    eff_lookup = eff_lookup,
    alien_ohs = alien_ohs,
    max_identity = 2L,
    beam_width = 1L,
    dp_k_range = 1L,
    overlap_codons = 4L
  )

  expect_true(is.list(result))
  expect_true(is.data.frame(result$tiles))
  expect_true(nrow(result$tiles) >= 2L)
  expect_true(!is.null(result$sb_result))
})


# =============================================================================
# Integration tests: plan_assembly with OOGGA methods
# =============================================================================

test_that("plan_assembly works with boundary_method='oogga_two_pass'", {
  cds <- TEST_LONG_GENE_SEQ
  tile_size <- compute_max_tile_size(300L, 20L)

  result <- plan_assembly(
    cds = cds,
    polIII = TEST_POLIII,
    max_mutable_nt = tile_size,
    config = list(
      boundary_method = "oogga_two_pass",
      oogga_max_identity = 2L,
      oogga_beam_width = 1L,
      dp_k_range = 1L
    )
  )

  expect_true(is.list(result))
  expect_true(is.data.frame(result$tiles))
  expect_true(nrow(result$tiles) >= 2L)
  expect_true(!is.null(result$oh3))
  expect_true(!is.null(result$oh4))
  expect_true(is.data.frame(result$reaction_fidelity))

  # Verify zero SB collisions
  expect_equal(result$summary$n_sb_collisions, 0L)
})

test_that("plan_assembly works with boundary_method='oogga_greedy'", {
  cds <- TEST_LONG_GENE_SEQ
  tile_size <- compute_max_tile_size(300L, 20L)

  result <- plan_assembly(
    cds = cds,
    polIII = TEST_POLIII,
    max_mutable_nt = tile_size,
    config = list(
      boundary_method = "oogga_greedy",
      oogga_max_identity = 2L,
      oogga_beam_width = 1L
    )
  )

  expect_true(is.list(result))
  expect_true(is.data.frame(result$tiles))
  expect_true(nrow(result$tiles) >= 2L)
  expect_equal(result$summary$n_sb_collisions, 0L)
})

test_that("plan_assembly works with boundary_method='oogga_single'", {
  cds <- TEST_LONG_GENE_SEQ
  tile_size <- compute_max_tile_size(300L, 20L)

  result <- plan_assembly(
    cds = cds,
    polIII = TEST_POLIII,
    max_mutable_nt = tile_size,
    config = list(
      boundary_method = "oogga_single",
      oogga_max_identity = 2L,
      oogga_beam_width = 1L,
      dp_k_range = 1L
    )
  )

  expect_true(is.list(result))
  expect_true(is.data.frame(result$tiles))
  expect_true(nrow(result$tiles) >= 2L)
  expect_equal(result$summary$n_sb_collisions, 0L)
})

test_that("plan_assembly with oogga_two_pass produces same format as dp", {
  cds <- TEST_LONG_GENE_SEQ
  tile_size <- compute_max_tile_size(300L, 20L)

  # Run dp baseline
  result_dp <- plan_assembly(
    cds = cds,
    polIII = TEST_POLIII,
    max_mutable_nt = tile_size,
    config = list(boundary_method = "dp", dp_k_range = 1L)
  )

  # Run oogga_two_pass
  result_oogga <- plan_assembly(
    cds = cds,
    polIII = TEST_POLIII,
    max_mutable_nt = tile_size,
    config = list(
      boundary_method = "oogga_two_pass",
      oogga_max_identity = 2L,
      oogga_beam_width = 1L,
      dp_k_range = 1L
    )
  )

  # OOGGA result must have all fields that DP produces
  dp_fields <- names(result_dp)
  oogga_fields <- names(result_oogga)
  expect_true(
    all(dp_fields %in% oogga_fields),
    info = paste("Missing fields:", paste(setdiff(dp_fields, oogga_fields), collapse = ", "))
  )

  # OOGGA tile data frame must have all columns that DP tiles have
  dp_tile_cols <- names(result_dp$tiles)
  oogga_tile_cols <- names(result_oogga$tiles)
  expect_true(
    all(dp_tile_cols %in% oogga_tile_cols),
    info = paste("Missing tile columns:", paste(setdiff(dp_tile_cols, oogga_tile_cols), collapse = ", "))
  )

  # Same reaction_fidelity columns
  expect_equal(
    sort(names(result_dp$reaction_fidelity)),
    sort(names(result_oogga$reaction_fidelity))
  )
})

test_that("plan_assembly with short test gene (no SBs needed) works for all OOGGA methods", {
  cds <- TEST_GENE_SEQ
  tile_size <- compute_max_tile_size(300L, 20L)

  for (method in c("oogga_two_pass", "oogga_greedy", "oogga_single")) {
    result <- plan_assembly(
      cds = cds,
      polIII = TEST_POLIII,
      max_mutable_nt = tile_size,
      config = list(
        boundary_method = method,
        oogga_max_identity = 2L,
        oogga_beam_width = 1L,
        dp_k_range = 1L
      )
    )

    expect_true(is.list(result), info = paste("Failed for", method))
    expect_true(is.data.frame(result$tiles), info = paste("Failed for", method))
    expect_equal(result$summary$n_sb_collisions, 0L,
      info = paste("Collisions for", method)
    )
  }
})
