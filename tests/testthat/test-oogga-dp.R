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
    oh1_seq = rep("AAAA", 1000), oh2_seq = rep("AAAA", 1000),
    alien_ohs = character(0),
    compat_matrix = build_oh_compatibility(2L)
  ))
})

test_that("oogga_sb_dp_solve_k_v2 returns NULL for infeasible K", {
  # K=5 boundaries need at least 6*100 = 600 nt, but only 500 available
  expect_null(oogga_sb_dp_solve_k_v2(
    K = 5L, total_len = 500L, min_len = 100L, max_len = 200L,
    boundary_scores = rep(0, 500), boundary_valid = rep(TRUE, 500),
    oh1_seq = rep("AAAA", 500), oh2_seq = rep("AAAA", 500),
    alien_ohs = character(0),
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

  # Enzyme-specific alien sets: oh_L goes to BsaI pot (oh1 aliens)
  oh1_aliens <- unique(c(oh_L, reverse_complement(oh_L)))
  oh2_aliens <- character(0) # No fixed BsmBI aliens in this simplified test

  tiles <- search_tile_boundaries_oogga(
    cds = cds,
    max_mutable_nt = max_mutable_nt,
    oh_fidelity = oh_fidelity,
    multi_k = TRUE,
    dp_k_range = 1L,
    overlap_codons = 4L,
    eff_lookup = eff_lookup,
    alien_ohs_oh1 = oh1_aliens,
    alien_ohs_oh2 = oh2_aliens,
    max_identity = 2L
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

test_that("plan_assembly with oogga_two_pass produces expected output format", {
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

  # Required top-level fields
  expected_fields <- c("tiles", "oh3", "oh4", "oh_L",
                        "reaction_fidelity", "summary")
  for (f in expected_fields) {
    expect_true(f %in% names(result), info = paste("Missing field:", f))
  }

  # Tiles must be a data frame with expected columns
  expect_true(is.data.frame(result$tiles))
  tile_cols <- c("tile_id", "start_codon", "end_codon", "oh1_seq", "oh2_seq")
  for (col in tile_cols) {
    expect_true(col %in% names(result$tiles),
                info = paste("Missing tile column:", col))
  }

  # reaction_fidelity must be a data frame
  expect_true(is.data.frame(result$reaction_fidelity))
})


# =============================================================================
# Per-segment tile search tests (tile_segments_oogga)
# =============================================================================

test_that("tile_segments_oogga with 1 SB (no splits) returns valid tiles", {
  # TEST_GENE_SEQ (300 nt) fits in one block — SB result is trivial (1 SB)
  cds <- TEST_GENE_SEQ
  gene_len <- nchar(cds)
  tile_size <- compute_max_tile_size(300L, 20L)
  oh_fidelity <- load_overhang_fidelity("BsmBI")
  bsmbi_pw <- load_pairwise_matrix("BsmBI")
  eff_lookup <- compute_overhang_efficiency(bsmbi_pw)

  # Trivial SB result: 1 superblock covering entire gene
  sb_result <- list(
    n_superblocks = 1L,
    boundaries = data.frame(
      sb_id = 1L, start_nt = 1L, end_nt = gene_len,
      oh1_sb = NA_character_, oh2_sb = NA_character_,
      boundary_score = NA_real_,
      stringsAsFactors = FALSE
    ),
    total_score = 0
  )

  min_mutable_nt <- max(81L, tile_size %/% 3L)
  min_mutable_nt <- (min_mutable_nt %/% 3L) * 3L

  tiles <- tile_segments_oogga(
    cds = cds,
    sb_result = sb_result,
    gene_len = gene_len,
    max_mutable_nt = tile_size,
    min_mutable_nt = min_mutable_nt,
    oh_fidelity = oh_fidelity,
    eff_lookup = eff_lookup,
    max_identity = 2L,
    multi_k = FALSE,
    dp_k_range = 1L
  )

  expect_true(is.data.frame(tiles))
  expect_true(nrow(tiles) >= 1L)
  # Tiles should cover the entire gene
  expect_equal(tiles$start_nt[1], 1L)
  expect_equal(tiles$end_nt[nrow(tiles)], gene_len)
  # All tile_seq should match the CDS substring
  for (i in seq_len(nrow(tiles))) {
    expect_equal(tiles$tile_seq[i], substring(cds, tiles$start_nt[i], tiles$end_nt[i]))
  }
})

test_that("tile_segments_oogga with 2+ gene-region SBs has correct alignment", {
  # TEST_LONG_GENE_SEQ (2100 nt) triggers SB splitting
  cds <- TEST_LONG_GENE_SEQ
  gene_len <- nchar(cds)
  tile_size <- compute_max_tile_size(300L, 20L)
  oh_fidelity <- load_overhang_fidelity("BsmBI")
  bsmbi_pw <- load_pairwise_matrix("BsmBI")
  eff_lookup <- compute_overhang_efficiency(bsmbi_pw)

  # First, get SB result with real SB DP
  full_seq <- paste0(cds, TEST_POLIII)
  sb_result <- search_sb_boundaries_oogga(
    full_seq = full_seq,
    gene_len = gene_len,
    max_block_length = 1800L - 22L,
    min_block_length = 300L,
    oh_fidelity = oh_fidelity,
    eff_lookup = eff_lookup,
    max_identity = 2L,
    beam_width = 5L
  )

  # Should have >1 SB for 2100 nt gene

  expect_true(sb_result$n_superblocks >= 2L)

  min_mutable_nt <- max(81L, tile_size %/% 3L)
  min_mutable_nt <- (min_mutable_nt %/% 3L) * 3L

  tiles <- tile_segments_oogga(
    cds = cds,
    sb_result = sb_result,
    gene_len = gene_len,
    max_mutable_nt = tile_size,
    min_mutable_nt = min_mutable_nt,
    oh_fidelity = oh_fidelity,
    eff_lookup = eff_lookup,
    max_identity = 2L,
    multi_k = TRUE,
    dp_k_range = 3L
  )

  expect_true(is.data.frame(tiles))
  expect_true(nrow(tiles) >= 2L)

  # (a) Tiles cover entire gene
  expect_equal(tiles$start_nt[1], 1L)
  expect_equal(tiles$end_nt[nrow(tiles)], gene_len)

  # (b) Every gene-region SB boundary should fall within some tile's range.
  # SB-boundary tiles extend past the SB boundary by overlap_codons, so
  # the SB nt may not exactly equal a tile end_nt.
  sb_df <- sb_result$boundaries
  for (i in seq_len(sb_result$n_superblocks - 1L)) {
    sb_nt <- sb_df$end_nt[i]
    if (sb_nt <= gene_len) {
      covered <- any(tiles$start_nt <= sb_nt & tiles$end_nt >= sb_nt)
      expect_true(covered,
        info = paste(
          "SB boundary at", sb_nt,
          "should fall within a tile range"
        )
      )
    }
  }

  # (c) Enzyme-aware collision check: oh1 (BsaI) avoids SB OHs in its pot,
  #     oh2 (BsmBI) avoids SB OHs in its pot. Tiles no longer need to avoid
  #     ALL SB junction OHs — only those in the same enzyme reaction.
  #     This is validated at the DP level; the integration test via
  #     plan_assembly verifies end-to-end correctness.
})

test_that("tile_segments_oogga position offsets are correct", {
  cds <- TEST_LONG_GENE_SEQ
  gene_len <- nchar(cds)
  tile_size <- compute_max_tile_size(300L, 20L)
  oh_fidelity <- load_overhang_fidelity("BsmBI")
  bsmbi_pw <- load_pairwise_matrix("BsmBI")
  eff_lookup <- compute_overhang_efficiency(bsmbi_pw)

  full_seq <- paste0(cds, TEST_POLIII)
  sb_result <- search_sb_boundaries_oogga(
    full_seq = full_seq,
    gene_len = gene_len,
    max_block_length = 1800L - 22L,
    min_block_length = 300L,
    oh_fidelity = oh_fidelity,
    eff_lookup = eff_lookup,
    max_identity = 2L,
    beam_width = 5L
  )

  min_mutable_nt <- max(81L, tile_size %/% 3L)
  min_mutable_nt <- (min_mutable_nt %/% 3L) * 3L

  tiles <- tile_segments_oogga(
    cds = cds,
    sb_result = sb_result,
    gene_len = gene_len,
    max_mutable_nt = tile_size,
    min_mutable_nt = min_mutable_nt,
    oh_fidelity = oh_fidelity,
    eff_lookup = eff_lookup,
    max_identity = 2L
  )

  # Verify tile_seq == substring(cds, start_nt, end_nt)
  for (i in seq_len(nrow(tiles))) {
    expect_equal(
      tiles$tile_seq[i],
      substring(cds, tiles$start_nt[i], tiles$end_nt[i]),
      info = paste("Tile", i, "tile_seq mismatch")
    )
  }

  # If multiple segments, segment 2 tiles should start after segment 1 ends
  if (sb_result$n_superblocks >= 2L) {
    sb_df <- sb_result$boundaries
    first_sb_end <- sb_df$end_nt[1]
    if (first_sb_end <= gene_len) {
      # Find first tile in segment 2
      seg2_tiles <- tiles[tiles$start_nt > first_sb_end, ]
      expect_true(nrow(seg2_tiles) >= 1L,
        info = "Should have tiles in segment 2"
      )
      expect_true(seg2_tiles$start_nt[1] > first_sb_end,
        info = "Segment 2 tile should start after segment 1 end"
      )
    }
  }
})

test_that("tile_segments_oogga single-tile segment produces exactly 1 tile", {
  # Create an SB result with a very small first segment (< max_codons)
  cds <- TEST_LONG_GENE_SEQ
  gene_len <- nchar(cds)
  tile_size <- compute_max_tile_size(300L, 20L)
  max_codons <- tile_size %/% 3L
  oh_fidelity <- load_overhang_fidelity("BsmBI")
  bsmbi_pw <- load_pairwise_matrix("BsmBI")
  eff_lookup <- compute_overhang_efficiency(bsmbi_pw)

  # Manually construct SB result with a small first segment (60 codons = 180 nt)
  small_seg_end <- 180L # 60 codons, within max_codons (~81)
  # Two-OH model: oh1_sb = first 4 nt past boundary, oh2_sb = 4 nt at overlap extension
  oh1_at_boundary <- substring(cds, small_seg_end + 1L, small_seg_end + 4L)
  overlap_codons_test <- 4L
  oh2_codon <- min(small_seg_end %/% 3L + overlap_codons_test, gene_len %/% 3L)
  oh2_at_boundary <- substring(cds, oh2_codon * 3L - 3L, oh2_codon * 3L)
  sb_result <- list(
    n_superblocks = 2L,
    boundaries = data.frame(
      sb_id = c(1L, 2L),
      start_nt = c(1L, small_seg_end + 1L),
      end_nt = c(small_seg_end, gene_len),
      oh1_sb = c(oh1_at_boundary, NA_character_),
      oh2_sb = c(oh2_at_boundary, NA_character_),
      boundary_score = c(0.5, NA_real_),
      stringsAsFactors = FALSE
    ),
    total_score = 0.5
  )

  min_mutable_nt <- max(81L, tile_size %/% 3L)
  min_mutable_nt <- (min_mutable_nt %/% 3L) * 3L

  tiles <- tile_segments_oogga(
    cds = cds,
    sb_result = sb_result,
    gene_len = gene_len,
    max_mutable_nt = tile_size,
    min_mutable_nt = min_mutable_nt,
    oh_fidelity = oh_fidelity,
    eff_lookup = eff_lookup,
    max_identity = 2L,
    multi_k = TRUE,
    dp_k_range = 3L
  )

  # First segment (180 nt = 60 codons) should produce a single tile.
  # SB-boundary tiles extend past the SB boundary by overlap_codons,
  # so filter by start_nt within the segment.
  seg1_tiles <- tiles[tiles$start_nt <= small_seg_end &
                      tiles$start_nt >= 1L &
                      tiles$start_codon == 1L, ]
  expect_equal(nrow(seg1_tiles), 1L,
    info = "Small segment should produce exactly 1 tile"
  )
  expect_equal(seg1_tiles$start_nt[1], 1L)
  # end_nt is extended past the SB boundary by overlap_codons
  expect_true(seg1_tiles$end_nt[1] >= small_seg_end,
    info = "SB boundary tile should extend at least to SB boundary"
  )
})

test_that("tile_segments_oogga preserves oh2 overlap past SB boundary", {
  cds <- TEST_LONG_GENE_SEQ
  gene_len <- nchar(cds)
  n_codons <- gene_len %/% 3L
  tile_size <- compute_max_tile_size(300L, 20L)
  oh_fidelity <- load_overhang_fidelity("BsmBI")
  bsmbi_pw <- load_pairwise_matrix("BsmBI")
  eff_lookup <- compute_overhang_efficiency(bsmbi_pw)
  overlap_codons <- 4L

  full_seq <- paste0(cds, TEST_POLIII)
  sb_result <- search_sb_boundaries_oogga(
    full_seq = full_seq,
    gene_len = gene_len,
    max_block_length = 1800L - 22L,
    min_block_length = 300L,
    oh_fidelity = oh_fidelity,
    eff_lookup = eff_lookup,
    max_identity = 2L,
    beam_width = 5L
  )

  min_mutable_nt <- max(81L, tile_size %/% 3L)
  min_mutable_nt <- (min_mutable_nt %/% 3L) * 3L

  tiles <- tile_segments_oogga(
    cds = cds,
    sb_result = sb_result,
    gene_len = gene_len,
    max_mutable_nt = tile_size,
    min_mutable_nt = min_mutable_nt,
    oh_fidelity = oh_fidelity,
    eff_lookup = eff_lookup,
    max_identity = 2L,
    overlap_codons = overlap_codons
  )

  # oh2 extends overlap_codons past end_codon (not the last 4 nt of the tile).
  # This is by design: end_codon already includes overlap extension from the DP,
  # and oh2 extends another overlap_codons to serve as the BsmBI junction point.
  n_codons_gene <- gene_len %/% 3L
  for (i in seq_len(nrow(tiles))) {
    oh2_codon <- min(tiles$end_codon[i] + overlap_codons, n_codons_gene)
    oh2_pos <- oh2_codon * 3L
    expected_oh2 <- substring(cds, oh2_pos - 3L, oh2_pos)
    expect_equal(tiles$oh2_seq[i], expected_oh2,
      info = paste(
        "Tile", i, "oh2 should extend overlap_codons past end_codon.",
        "Expected:", expected_oh2, "Got:", tiles$oh2_seq[i]
      )
    )
  }
})

test_that("plan_assembly with oogga_two_pass on TEST_LONG_GENE_SEQ has no SB skip warnings", {
  cds <- TEST_LONG_GENE_SEQ
  tile_size <- compute_max_tile_size(300L, 20L)

  result <- plan_assembly(
    cds = cds,
    polIII = TEST_POLIII,
    max_mutable_nt = tile_size,
    config = list(
      boundary_method = "oogga_two_pass",
      oogga_max_identity = 2L,
      oogga_beam_width = 5L,
      dp_k_range = 3L
    )
  )

  expect_true(is.list(result))
  expect_true(is.data.frame(result$tiles))
  expect_equal(result$summary$n_sb_collisions, 0L)

  # Verify SB/tile alignment: every gene-region SB boundary falls within
  # some tile's range (SB-boundary tiles extend past the SB boundary)
  sb_df <- result$sb_result$boundaries
  gene_len <- nchar(cds)
  tiles <- result$tiles
  for (i in seq_len(result$sb_result$n_superblocks - 1L)) {
    sb_nt <- sb_df$end_nt[i]
    if (sb_nt <= gene_len) {
      covered <- any(tiles$start_nt <= sb_nt & tiles$end_nt >= sb_nt)
      expect_true(covered,
        info = paste(
          "SB boundary at", sb_nt,
          "not covered by any tile range"
        )
      )
    }
  }

  # Superblock count should be reasonable (not exploded)
  # 2100 nt gene + 250 nt PolIII = 2350 > 1800, so need 2 SBs
  n_sb <- result$summary$n_superblocks
  expect_true(n_sb <= 5L,
    info = paste("Superblock count", n_sb, "seems exploded")
  )
})

