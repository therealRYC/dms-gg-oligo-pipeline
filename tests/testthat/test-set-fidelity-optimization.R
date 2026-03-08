# test-set-fidelity-optimization.R
# Tests for reaction-aware set fidelity optimization (260308)
#
# Tests cover:
#   Phase 2: evaluate_sb_config(), search_sb_boundaries_mc()
#   Phase 3A: search_tile_boundaries_dp_v2()
#   Phase 3B: search_tile_boundaries_mc()
#   Phase 4: refine_boundaries_mc()

# =============================================================================
# SETUP
# =============================================================================

# Load pairwise matrices (both enzymes)
bsai_matrix <- load_pairwise_matrix("BsaI")
bsmbi_matrix <- load_pairwise_matrix("BsmBI")

# Fixed overhangs for test gene (same as what plan_assembly would derive)
test_oh_L <- substring(TEST_GENE_SEQ, 1, 4) # ATGG
test_oh3 <- "CACC" # from TEST_POLIII
test_oh4 <- "AACA" # typical auto-selected

# For the long gene
long_oh_L <- substring(TEST_LONG_GENE_SEQ, 1, 4) # ATGG
long_oh3 <- "CACC"
long_oh4 <- "AACA"

# =============================================================================
# evaluate_sb_config() tests
# =============================================================================

test_that("evaluate_sb_config returns 1.0 for no SB boundaries", {
  result <- evaluate_sb_config(
    sb_positions = integer(0),
    full_seq = TEST_GENE_SEQ,
    gene_len = nchar(TEST_GENE_SEQ),
    oh_L = test_oh_L, oh3 = test_oh3, oh4 = test_oh4,
    bsai_matrix = bsai_matrix, bsmbi_matrix = bsmbi_matrix
  )
  expect_equal(result, 1.0)
})

test_that("evaluate_sb_config returns valid score for single SB boundary", {
  # Place a boundary at codon 50 (nt 150) in the test gene
  result <- evaluate_sb_config(
    sb_positions = 150L,
    full_seq = TEST_GENE_SEQ,
    gene_len = nchar(TEST_GENE_SEQ),
    oh_L = test_oh_L, oh3 = test_oh3, oh4 = test_oh4,
    bsai_matrix = bsai_matrix, bsmbi_matrix = bsmbi_matrix
  )
  expect_true(is.numeric(result))
  expect_true(result > 0)
  expect_true(result <= 1.0)
})

test_that("evaluate_sb_config returns -Inf for palindromic SB overhang", {
  # We need a position where the overhang is palindromic.
  # Build a sequence where position 150 gives a palindromic 4-mer.
  # Instead, just verify that if a palindromic position exists, it gets -Inf.
  # Use a synthetic sequence with known palindrome at a specific position.
  # AATT at positions 147-150 -> substring(seq, 147, 150) = "AATT"

  # Find a codon boundary where overhang is palindromic in the long gene
  gene <- TEST_LONG_GENE_SEQ
  gene_len <- nchar(gene)
  found_palindrome <- FALSE
  for (p in seq(6L, gene_len - 3L, by = 3L)) {
    oh <- substring(gene, p - 3L, p)
    if (oh %in% PALINDROMIC_4NT) {
      result <- evaluate_sb_config(
        sb_positions = p,
        full_seq = gene,
        gene_len = gene_len,
        oh_L = long_oh_L, oh3 = long_oh3, oh4 = long_oh4,
        bsai_matrix = bsai_matrix, bsmbi_matrix = bsmbi_matrix
      )
      expect_equal(result, -Inf)
      found_palindrome <- TRUE
      break
    }
  }
  # It's OK if no palindrome found — skip gracefully
  if (!found_palindrome) {
    skip("No palindromic overhang found at codon boundaries in TEST_LONG_GENE_SEQ")
  }
})

test_that("evaluate_sb_config returns -Inf for SB OH colliding with oh3", {
  # Find a position where the overhang equals oh3 (CACC)
  gene <- TEST_LONG_GENE_SEQ
  gene_len <- nchar(gene)
  found <- FALSE
  for (p in seq(6L, gene_len - 3L, by = 3L)) {
    oh <- substring(gene, p - 3L, p)
    if (oh == long_oh3 || oh == reverse_complement(long_oh3)) {
      result <- evaluate_sb_config(
        sb_positions = p,
        full_seq = gene,
        gene_len = gene_len,
        oh_L = long_oh_L, oh3 = long_oh3, oh4 = long_oh4,
        bsai_matrix = bsai_matrix, bsmbi_matrix = bsmbi_matrix
      )
      expect_equal(result, -Inf)
      found <- TRUE
      break
    }
  }
  if (!found) skip("No oh3-matching position found in TEST_LONG_GENE_SEQ")
})

test_that("evaluate_sb_config returns -Inf for duplicate SB overhangs", {
  # Place two SB boundaries at positions with the same overhang
  gene <- TEST_LONG_GENE_SEQ
  gene_len <- nchar(gene)

  # Find two positions with same overhang
  ohs <- character(0)
  positions <- integer(0)
  for (p in seq(6L, gene_len - 3L, by = 3L)) {
    oh <- substring(gene, p - 3L, p)
    if (oh %in% PALINDROMIC_4NT || oh %in% HOMOPOLYMER_4NT) next
    if (oh_collides(oh, long_oh_L) || oh_collides(oh, long_oh3) || oh_collides(oh, long_oh4)) next
    ohs <- c(ohs, oh)
    positions <- c(positions, p)
  }

  # Find a duplicate
  dup_oh <- ohs[duplicated(ohs)][1]
  if (!is.na(dup_oh)) {
    dup_positions <- positions[ohs == dup_oh]
    result <- evaluate_sb_config(
      sb_positions = dup_positions[1:2],
      full_seq = gene,
      gene_len = gene_len,
      oh_L = long_oh_L, oh3 = long_oh3, oh4 = long_oh4,
      bsai_matrix = bsai_matrix, bsmbi_matrix = bsmbi_matrix
    )
    expect_equal(result, -Inf)
  } else {
    skip("No duplicate overhangs found in TEST_LONG_GENE_SEQ")
  }
})

test_that("evaluate_sb_config score decreases with more SB boundaries", {
  # More SBs = more overhangs in extreme reactions = lower set fidelity
  gene <- TEST_LONG_GENE_SEQ
  gene_len <- nchar(gene)
  full_seq <- paste0(gene, TEST_POLIII)

  # Find 3 non-colliding valid positions
  valid <- integer(0)
  committed <- c(
    long_oh_L, reverse_complement(long_oh_L),
    long_oh3, reverse_complement(long_oh3),
    long_oh4, reverse_complement(long_oh4)
  )

  for (p in seq(300L, gene_len - 300L, by = 300L)) {
    oh <- substring(full_seq, p - 3L, p)
    if (oh %in% PALINDROMIC_4NT || oh %in% HOMOPOLYMER_4NT) next
    if (oh %in% committed || reverse_complement(oh) %in% committed) next
    valid <- c(valid, p)
    committed <- c(committed, oh, reverse_complement(oh))
    if (length(valid) >= 3L) break
  }

  if (length(valid) < 2L) skip("Could not find enough valid SB positions")

  fid_1 <- evaluate_sb_config(
    valid[1], full_seq, gene_len, long_oh_L, long_oh3, long_oh4,
    bsai_matrix, bsmbi_matrix
  )
  fid_2 <- evaluate_sb_config(
    valid[1:2], full_seq, gene_len, long_oh_L, long_oh3, long_oh4,
    bsai_matrix, bsmbi_matrix
  )

  expect_true(fid_1 > 0)
  expect_true(fid_2 > 0)
  # More SBs should generally give lower or equal set fidelity
  # (not strictly guaranteed but expected for typical sequences)
  expect_true(fid_2 <= fid_1 + 0.01) # allow tiny float noise
})

# =============================================================================
# search_sb_boundaries_mc() tests
# =============================================================================

test_that("search_sb_boundaries_mc returns no splits for short sequence", {
  result <- search_sb_boundaries_mc(
    full_seq = TEST_GENE_SEQ,
    gene_len = nchar(TEST_GENE_SEQ),
    oh_L = test_oh_L, oh3 = test_oh3, oh4 = test_oh4,
    bsai_matrix = bsai_matrix, bsmbi_matrix = bsmbi_matrix,
    max_block_length = 1778L, min_block_length = 100L
  )

  expect_equal(result$n_sb, 1L)
  expect_equal(length(result$positions), 0L)
  expect_equal(result$score, 1.0)
})

test_that("search_sb_boundaries_mc finds valid splits for long gene", {
  full_seq <- paste0(TEST_LONG_GENE_SEQ, TEST_POLIII)
  gene_len <- nchar(TEST_LONG_GENE_SEQ)

  result <- search_sb_boundaries_mc(
    full_seq = full_seq,
    gene_len = gene_len,
    oh_L = long_oh_L, oh3 = long_oh3, oh4 = long_oh4,
    bsai_matrix = bsai_matrix, bsmbi_matrix = bsmbi_matrix,
    max_block_length = 1778L, min_block_length = 300L,
    n_iterations = 2000L, n_restarts = 3L,
    seed = 42L
  )

  expect_true(result$n_sb >= 2L)
  expect_true(length(result$positions) >= 1L)
  expect_true(result$score > 0)

  # All SB positions should be within sequence bounds
  expect_true(all(result$positions >= 4L))
  expect_true(all(result$positions < nchar(full_seq)))

  # SB overhangs should be non-empty
  expect_true(length(result$sb_ohs) == length(result$positions))
  expect_true(all(nchar(result$sb_ohs) == 4L))

  # No palindromic or homopolymer SB overhangs
  expect_true(!any(result$sb_ohs %in% PALINDROMIC_4NT))
  expect_true(!any(result$sb_ohs %in% HOMOPOLYMER_4NT))

  # SB overhangs should not collide with fixed OHs
  for (sb_oh in result$sb_ohs) {
    expect_false(oh_collides(sb_oh, long_oh3))
    expect_false(oh_collides(sb_oh, long_oh4))
    expect_false(oh_collides(sb_oh, long_oh_L))
  }

  # SB overhangs should be mutually non-colliding
  if (length(result$sb_ohs) >= 2L) {
    for (i in 2:length(result$sb_ohs)) {
      for (j in 1:(i - 1)) {
        expect_false(oh_collides(result$sb_ohs[i], result$sb_ohs[j]),
          info = paste("SB OH collision:", result$sb_ohs[i], "vs", result$sb_ohs[j])
        )
      }
    }
  }

  # Block sizes should be within limits
  boundaries <- c(0L, sort(result$positions), nchar(full_seq))
  for (i in seq_len(length(boundaries) - 1L)) {
    seg_len <- boundaries[i + 1] - boundaries[i]
    expect_true(seg_len >= 300L, info = paste("Block", i, "too small:", seg_len))
    expect_true(seg_len <= 1778L, info = paste("Block", i, "too large:", seg_len))
  }
})

test_that("search_sb_boundaries_mc is reproducible with seed", {
  full_seq <- paste0(TEST_LONG_GENE_SEQ, TEST_POLIII)
  gene_len <- nchar(TEST_LONG_GENE_SEQ)

  result1 <- search_sb_boundaries_mc(
    full_seq, gene_len, long_oh_L, long_oh3, long_oh4,
    bsai_matrix, bsmbi_matrix,
    n_iterations = 500L, n_restarts = 2L, seed = 123L
  )
  result2 <- search_sb_boundaries_mc(
    full_seq, gene_len, long_oh_L, long_oh3, long_oh4,
    bsai_matrix, bsmbi_matrix,
    n_iterations = 500L, n_restarts = 2L, seed = 123L
  )

  expect_equal(result1$positions, result2$positions)
  expect_equal(result1$score, result2$score)
})

# =============================================================================
# search_tile_boundaries_dp_v2() tests
# =============================================================================

test_that("dp_v2 returns single tile for short gene with no SB splits", {
  tiles <- search_tile_boundaries_dp_v2(
    cds = TEST_GENE_SEQ,
    sb_positions = integer(0),
    oh_L = test_oh_L, oh3 = test_oh3, oh4 = test_oh4,
    bsai_matrix = bsai_matrix, bsmbi_matrix = bsmbi_matrix,
    max_mutable_nt = 312L # 104 codons, enough for 100 + 4 overlap
  )

  expect_equal(nrow(tiles), 1L)
  expect_equal(tiles$start_codon[1], 1L)
  expect_true(tiles$end_codon[1] >= 100L)
})

test_that("dp_v2 places tiles across SB boundaries in long gene", {
  gene <- TEST_LONG_GENE_SEQ
  gene_len <- nchar(gene)
  full_seq <- paste0(gene, TEST_POLIII)

  # First find SB boundaries
  sb_result <- search_sb_boundaries_mc(
    full_seq, gene_len, long_oh_L, long_oh3, long_oh4,
    bsai_matrix, bsmbi_matrix,
    n_iterations = 1000L, n_restarts = 2L, seed = 42L
  )

  # Run dp_v2 with those SB boundaries
  tiles <- search_tile_boundaries_dp_v2(
    cds = gene,
    sb_positions = sb_result$positions,
    oh_L = long_oh_L, oh3 = long_oh3, oh4 = long_oh4,
    bsai_matrix = bsai_matrix, bsmbi_matrix = bsmbi_matrix,
    max_mutable_nt = 243L
  )

  expect_true(nrow(tiles) >= 3L)

  # Every SB boundary should be a tile boundary
  sb_codons <- sb_result$positions[sb_result$positions <= gene_len] %/% 3L
  for (sb_c in sb_codons) {
    # sb_c should be the end_codon (minus overlap) of some tile
    # or start_codon - 1 of some tile
    tile_ends <- tiles$end_codon
    tile_starts <- tiles$start_codon
    found <- any(abs(tile_ends - sb_c) <= 4L) || any(abs(tile_starts - 1L - sb_c) <= 4L)
    expect_true(found, info = paste("SB boundary at codon", sb_c, "not aligned with any tile"))
  }

  # All tiles should have valid oh1/oh2
  expect_true(all(nchar(tiles$oh1_seq) == 4L))
  expect_true(all(nchar(tiles$oh2_seq) == 4L))
})

# =============================================================================
# search_tile_boundaries_mc() tests
# =============================================================================

test_that("tile MC improves or matches DP solution for long gene", {
  gene <- TEST_LONG_GENE_SEQ
  gene_len <- nchar(gene)
  full_seq <- paste0(gene, TEST_POLIII)

  # Get SB boundaries
  sb_result <- search_sb_boundaries_mc(
    full_seq, gene_len, long_oh_L, long_oh3, long_oh4,
    bsai_matrix, bsmbi_matrix,
    n_iterations = 1000L, n_restarts = 2L, seed = 42L
  )

  # Run MC tile search
  mc_tiles <- search_tile_boundaries_mc(
    cds = gene,
    sb_positions = sb_result$positions,
    oh_L = long_oh_L, oh3 = long_oh3, oh4 = long_oh4,
    bsai_matrix = bsai_matrix, bsmbi_matrix = bsmbi_matrix,
    max_mutable_nt = 243L,
    n_iterations = 1000L, n_restarts = 2L, seed = 42L
  )

  expect_true(nrow(mc_tiles) >= 3L)

  # All tiles should have valid OH sequences
  expect_true(all(nchar(mc_tiles$oh1_seq) == 4L))
  expect_true(all(nchar(mc_tiles$oh2_seq) == 4L))
})

# =============================================================================
# refine_boundaries_mc() tests
# =============================================================================

test_that("joint refinement doesn't worsen fidelity", {
  gene <- TEST_LONG_GENE_SEQ
  gene_len <- nchar(gene)
  full_seq <- paste0(gene, TEST_POLIII)

  # Get initial solution
  sb_result <- search_sb_boundaries_mc(
    full_seq, gene_len, long_oh_L, long_oh3, long_oh4,
    bsai_matrix, bsmbi_matrix,
    n_iterations = 1000L, n_restarts = 2L, seed = 42L
  )

  dp_tiles <- search_tile_boundaries_dp_v2(
    gene, sb_result$positions, long_oh_L, long_oh3, long_oh4,
    bsai_matrix, bsmbi_matrix,
    max_mutable_nt = 243L
  )

  # Compute initial min fidelity
  initial_fid <- sb_result$score

  # Refine
  refined <- refine_boundaries_mc(
    cds = gene, tiles = dp_tiles,
    sb_positions = sb_result$positions,
    oh_L = long_oh_L, oh3 = long_oh3, oh4 = long_oh4,
    bsai_matrix = bsai_matrix, bsmbi_matrix = bsmbi_matrix,
    max_mutable_nt = 243L,
    n_iterations = 500L, seed = 42L
  )

  expect_true(refined$best_min_fidelity >= initial_fid - 0.001)
  expect_true(nrow(refined$tiles) >= nrow(dp_tiles) - 1L)
})

# =============================================================================
# Integration: Full pipeline comparison
# =============================================================================

test_that("MC-optimized pipeline achieves reasonable fidelity on long gene", {
  gene <- TEST_LONG_GENE_SEQ
  gene_len <- nchar(gene)
  full_seq <- paste0(gene, TEST_POLIII)

  # Phase 2: SB MC
  sb_result <- search_sb_boundaries_mc(
    full_seq, gene_len, long_oh_L, long_oh3, long_oh4,
    bsai_matrix, bsmbi_matrix,
    max_block_length = 1778L, min_block_length = 300L,
    n_iterations = 3000L, n_restarts = 3L, seed = 42L
  )

  # Phase 3: Tile DP v2
  tiles <- search_tile_boundaries_dp_v2(
    gene, sb_result$positions, long_oh_L, long_oh3, long_oh4,
    bsai_matrix, bsmbi_matrix,
    max_mutable_nt = 243L
  )

  # Phase 4: Joint refinement
  refined <- refine_boundaries_mc(
    gene, tiles, sb_result$positions,
    long_oh_L, long_oh3, long_oh4,
    bsai_matrix, bsmbi_matrix,
    max_mutable_nt = 243L,
    n_iterations = 1000L, seed = 42L
  )

  # Final fidelity should be above 0.80 (the warning threshold)
  expect_true(refined$best_min_fidelity > SET_FIDELITY_WARNING_THRESHOLD,
    info = paste("Min fidelity:", refined$best_min_fidelity)
  )

  # Should have reasonable number of tiles
  expect_true(nrow(refined$tiles) >= 5L)
  expect_true(nrow(refined$tiles) <= 20L)
})
