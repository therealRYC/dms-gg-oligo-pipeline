# Created: 2026-03-04
# Last updated: 2026-03-05 — Add hard codon constraint tests
# test-sb-dp.R — Tests for the SB-first DP superblock boundary search
#
# Tests cover:
#   1. Short sequence (no split needed)
#   2. Single split (~3000 bp)
#   3. Multiple splits (~5000 bp)
#   4. Blacklist enforcement
#   5. Cassette handling (gene_len < total length)
#   6. Palindrome avoidance
#   7. Edge case: sequence exactly equal to max_block_length

# =============================================================================
# Helpers
# =============================================================================

#' Build a repeating test sequence of specified length from a 12-nt unit.
#' The unit "ATGCGTAACCTG" avoids palindromic 4-nt windows and has decent
#' overhang diversity. Length is trimmed to be divisible by 3 (codon-aligned).
make_test_seq <- function(target_len) {
  unit <- "ATGCGTAACCTG" # 12 nt, repeating
  n_reps <- ceiling(target_len / nchar(unit))
  raw <- paste0(rep(unit, n_reps), collapse = "")
  # Trim to target length, ensure divisible by 3
  trimmed_len <- (min(nchar(raw), target_len) %/% 3L) * 3L
  substring(raw, 1, trimmed_len)
}

# =============================================================================
# Test: Short sequence — no split needed
# =============================================================================

test_that("short sequence (< max_block_length) returns 1 SB, no boundaries", {
  seq_short <- make_test_seq(1200) # well under 1800
  result <- search_superblock_boundaries_dp(
    full_seq = seq_short,
    gene_len = nchar(seq_short),
    max_block_length = 1800L,
    min_block_length = 300L
  )

  expect_equal(result$n_superblocks, 1L)
  expect_equal(nrow(result$boundaries), 1L)
  expect_equal(result$boundaries$sb_id, 1L)
  expect_equal(result$boundaries$start_nt, 1L)
  expect_equal(result$boundaries$end_nt, nchar(seq_short))
  expect_true(is.na(result$boundaries$boundary_oh))
  expect_true(is.na(result$boundaries$boundary_score))
  expect_equal(result$total_score, 0)
})

# =============================================================================
# Test: Sequence exactly at max_block_length — no split needed
# =============================================================================

test_that("sequence exactly equal to max_block_length returns 1 SB", {
  seq_exact <- make_test_seq(1800) # exactly max
  result <- search_superblock_boundaries_dp(
    full_seq = seq_exact,
    gene_len = nchar(seq_exact),
    max_block_length = 1800L,
    min_block_length = 300L
  )

  expect_equal(result$n_superblocks, 1L)
  expect_equal(nrow(result$boundaries), 1L)
  expect_equal(result$total_score, 0)
})

# =============================================================================
# Test: Single split (~3000 bp -> 2 SBs)
# =============================================================================

test_that("~3000 bp sequence produces 2 SBs with 1 valid boundary", {
  seq_3k <- make_test_seq(3000)
  result <- search_superblock_boundaries_dp(
    full_seq = seq_3k,
    gene_len = nchar(seq_3k),
    max_block_length = 1800L,
    min_block_length = 300L
  )

  expect_equal(result$n_superblocks, 2L)
  expect_equal(nrow(result$boundaries), 2L)

  # First SB should have a boundary overhang; second should have NA

  expect_true(!is.na(result$boundaries$boundary_oh[1]))
  expect_true(is.na(result$boundaries$boundary_oh[2]))

  # Boundary overhang should be 4 nt
  expect_equal(nchar(result$boundaries$boundary_oh[1]), 4L)

  # Each SB must be <= max_block_length and >= min_block_length
  for (i in seq_len(result$n_superblocks)) {
    seg_len <- result$boundaries$end_nt[i] - result$boundaries$start_nt[i] + 1L
    expect_lte(seg_len, 1800L)
    expect_gte(seg_len, 300L)
  }

  # SBs should cover the full sequence without gaps or overlaps
  expect_equal(result$boundaries$start_nt[1], 1L)
  expect_equal(result$boundaries$end_nt[2], nchar(seq_3k))
  expect_equal(result$boundaries$start_nt[2], result$boundaries$end_nt[1] + 1L)

  # Total score should be positive (at least one valid boundary)
  expect_gt(result$total_score, 0)
})

# =============================================================================
# Test: Multiple splits (~5400 bp -> 3 SBs)
# =============================================================================

test_that("~5400 bp sequence produces 3 SBs with 2 boundaries", {
  seq_5k <- make_test_seq(5400)
  result <- search_superblock_boundaries_dp(
    full_seq = seq_5k,
    gene_len = nchar(seq_5k),
    max_block_length = 1800L,
    min_block_length = 300L
  )

  # With 5400 bp / 1800 = 3 blocks, we need at least 2 boundaries
  expect_gte(result$n_superblocks, 3L)
  expect_gte(nrow(result$boundaries), 3L)

  # First n-1 SBs should have boundary overhangs, last should have NA
  n_sb <- result$n_superblocks
  for (i in seq_len(n_sb - 1L)) {
    expect_true(!is.na(result$boundaries$boundary_oh[i]),
      info = paste("SB", i, "should have a boundary overhang")
    )
    expect_equal(nchar(result$boundaries$boundary_oh[i]), 4L)
  }
  expect_true(is.na(result$boundaries$boundary_oh[n_sb]))

  # All SBs should be within size limits
  for (i in seq_len(n_sb)) {
    seg_len <- result$boundaries$end_nt[i] - result$boundaries$start_nt[i] + 1L
    expect_lte(seg_len, 1800L)
    expect_gte(seg_len, 300L)
  }

  # Contiguous coverage
  expect_equal(result$boundaries$start_nt[1], 1L)
  expect_equal(result$boundaries$end_nt[n_sb], nchar(seq_5k))
  for (i in 2L:n_sb) {
    expect_equal(result$boundaries$start_nt[i], result$boundaries$end_nt[i - 1L] + 1L)
  }

  # Total score should be positive
  expect_gt(result$total_score, 0)
})

# =============================================================================
# Test: Blacklist enforcement
# =============================================================================

test_that("blacklisted overhangs are excluded from boundary positions", {
  # Use the 2100 nt TEST_LONG_GENE_SEQ which triggers SB splitting
  seq_long <- TEST_LONG_GENE_SEQ
  gene_len <- nchar(seq_long)

  # First, run without blacklist to find what overhangs the DP picks
  result_no_bl <- search_superblock_boundaries_dp(
    full_seq = seq_long,
    gene_len = gene_len,
    max_block_length = 1800L,
    min_block_length = 300L,
    blacklist_ohs = character(0)
  )

  # Get the boundary overhangs from the no-blacklist run
  boundary_ohs <- result_no_bl$boundaries$boundary_oh
  boundary_ohs <- boundary_ohs[!is.na(boundary_ohs)]

  # If there are boundary overhangs, blacklist them and verify they're excluded
  if (length(boundary_ohs) > 0) {
    bl_oh <- boundary_ohs[1]

    result_with_bl <- search_superblock_boundaries_dp(
      full_seq = seq_long,
      gene_len = gene_len,
      max_block_length = 1800L,
      min_block_length = 300L,
      blacklist_ohs = bl_oh
    )

    # The blacklisted overhang (and its RC) should not appear in new boundaries
    new_ohs <- result_with_bl$boundaries$boundary_oh
    new_ohs <- new_ohs[!is.na(new_ohs)]
    bl_rc <- reverse_complement(bl_oh)

    expect_false(bl_oh %in% new_ohs,
      info = paste("Blacklisted overhang", bl_oh, "should not appear in boundaries")
    )
    expect_false(bl_rc %in% new_ohs,
      info = paste("RC of blacklisted overhang", bl_rc, "should not appear in boundaries")
    )
  }
})

# =============================================================================
# Test: Cassette handling — gene_len < total sequence length
# =============================================================================

test_that("cassette region (past gene_len) doesn't require codon boundaries", {
  # Build a sequence: 1800 nt gene + 600 nt cassette = 2400 nt
  # This requires 1 split (2 SBs)
  gene_seq <- make_test_seq(1800)
  cassette_seq <- paste0(rep("ACGT", 150), collapse = "") # 600 nt
  full_seq <- paste0(gene_seq, cassette_seq)
  gene_len <- nchar(gene_seq)

  result <- search_superblock_boundaries_dp(
    full_seq = full_seq,
    gene_len = gene_len,
    max_block_length = 1800L,
    min_block_length = 300L
  )

  # Should produce at least 2 SBs (2400 > 1800)
  expect_gte(result$n_superblocks, 2L)

  # All segments within size limits
  for (i in seq_len(result$n_superblocks)) {
    seg_len <- result$boundaries$end_nt[i] - result$boundaries$start_nt[i] + 1L
    expect_lte(seg_len, 1800L)
    expect_gte(seg_len, 300L)
  }

  # Coverage is complete
  expect_equal(result$boundaries$start_nt[1], 1L)
  expect_equal(result$boundaries$end_nt[result$n_superblocks], nchar(full_seq))
})

test_that("split can occur within cassette region for very long cassettes", {
  # Build: 1500 nt gene + 2400 nt cassette = 3900 nt
  # This might place a split inside the cassette
  gene_seq <- make_test_seq(1500)
  # Use a cassette with good overhang diversity
  cassette_unit <- "TAGCAACCGTGA" # 12 nt
  cassette_seq <- paste0(rep(cassette_unit, 200), collapse = "")
  cassette_seq <- substring(cassette_seq, 1, 2400)
  full_seq <- paste0(gene_seq, cassette_seq)
  gene_len <- nchar(gene_seq)

  result <- search_superblock_boundaries_dp(
    full_seq = full_seq,
    gene_len = gene_len,
    max_block_length = 1800L,
    min_block_length = 300L
  )

  # Should produce at least 3 SBs (3900 / 1800 ~ 2.17, need 3 blocks)
  expect_gte(result$n_superblocks, 2L)

  # Verify all constraints are met
  for (i in seq_len(result$n_superblocks)) {
    seg_len <- result$boundaries$end_nt[i] - result$boundaries$start_nt[i] + 1L
    expect_lte(seg_len, 1800L)
    expect_gte(seg_len, 300L)
  }
})

# =============================================================================
# Test: Palindrome avoidance
# =============================================================================

test_that("palindromic overhangs are excluded from SB boundary positions", {
  # Use TEST_LONG_GENE_SEQ (2100 nt) which triggers splitting
  result <- search_superblock_boundaries_dp(
    full_seq = TEST_LONG_GENE_SEQ,
    gene_len = nchar(TEST_LONG_GENE_SEQ),
    max_block_length = 1800L,
    min_block_length = 300L
  )

  # Check that no boundary overhang is palindromic
  boundary_ohs <- result$boundaries$boundary_oh
  boundary_ohs <- boundary_ohs[!is.na(boundary_ohs)]

  if (length(boundary_ohs) > 0) {
    for (oh in boundary_ohs) {
      expect_false(oh %in% PALINDROMIC_4NT,
        info = paste("Boundary overhang", oh, "should not be palindromic")
      )
    }
  }
})

# =============================================================================
# Test: Boundary overhangs match the actual sequence
# =============================================================================

test_that("boundary overhangs match the sequence at their positions", {
  seq_3k <- make_test_seq(3000)
  result <- search_superblock_boundaries_dp(
    full_seq = seq_3k,
    gene_len = nchar(seq_3k),
    max_block_length = 1800L,
    min_block_length = 300L
  )

  # For each non-final SB, verify the boundary overhang matches the sequence
  for (i in seq_len(result$n_superblocks - 1L)) {
    oh <- result$boundaries$boundary_oh[i]
    end_pos <- result$boundaries$end_nt[i]
    # Overhang should be the 4 nt ending at end_pos
    expected_oh <- substring(seq_3k, end_pos - 3L, end_pos)
    expect_equal(oh, expected_oh,
      info = paste("SB", i, "boundary OH should match sequence at position", end_pos)
    )
  }
})

# =============================================================================
# Test: Return structure validation
# =============================================================================

test_that("return structure has correct types and columns", {
  seq_3k <- make_test_seq(3000)
  result <- search_superblock_boundaries_dp(
    full_seq = seq_3k,
    gene_len = nchar(seq_3k),
    max_block_length = 1800L,
    min_block_length = 300L
  )

  # Top-level structure
  expect_true(is.list(result))
  expect_true("n_superblocks" %in% names(result))
  expect_true("boundaries" %in% names(result))
  expect_true("total_score" %in% names(result))

  # n_superblocks is integer-ish
  expect_true(is.numeric(result$n_superblocks))
  expect_equal(result$n_superblocks, nrow(result$boundaries))

  # boundaries data frame columns
  expect_true(is.data.frame(result$boundaries))
  expected_cols <- c("sb_id", "start_nt", "end_nt", "boundary_oh", "boundary_score")
  expect_true(all(expected_cols %in% names(result$boundaries)))

  # total_score is numeric
  expect_true(is.numeric(result$total_score))
})

# =============================================================================
# Test: Uses real TEST_LONG_GENE_SEQ (2100 nt)
# =============================================================================

test_that("TEST_LONG_GENE_SEQ (2100 nt) produces valid SB split", {
  result <- search_superblock_boundaries_dp(
    full_seq = TEST_LONG_GENE_SEQ,
    gene_len = nchar(TEST_LONG_GENE_SEQ),
    max_block_length = 1800L,
    min_block_length = 300L
  )

  # 2100 / 1800 = 1.17 -> need 2 SBs (1 boundary)
  expect_equal(result$n_superblocks, 2L)
  expect_equal(nrow(result$boundaries), 2L)

  # Each SB within limits
  for (i in seq_len(result$n_superblocks)) {
    seg_len <- result$boundaries$end_nt[i] - result$boundaries$start_nt[i] + 1L
    expect_lte(seg_len, 1800L)
    expect_gte(seg_len, 300L)
  }

  # Contiguous
  expect_equal(result$boundaries$start_nt[1], 1L)
  expect_equal(result$boundaries$end_nt[2], nchar(TEST_LONG_GENE_SEQ))
  expect_equal(result$boundaries$start_nt[2], result$boundaries$end_nt[1] + 1L)

  # Boundary should be at a codon boundary (divisible by 3)
  boundary_pos <- result$boundaries$end_nt[1]
  expect_equal(boundary_pos %% 3L, 0L,
    info = paste("SB boundary at position", boundary_pos, "should be at a codon boundary")
  )
})

# =============================================================================
# Test: sb_dp_solve_k edge cases
# =============================================================================

test_that("sb_dp_solve_k returns NULL for infeasible K", {
  # 1000 nt, min_len = 600, K = 2 -> need 3 segments of 600 = 1800 > 1000
  scores <- rep(0.5, 1000)
  valid <- rep(TRUE, 1000)
  result <- sb_dp_solve_k(2L, 1000L, 600L, 800L, scores, valid)
  expect_null(result)
})

test_that("sb_dp_solve_k returns NULL for K = 0", {
  scores <- rep(0.5, 1000)
  valid <- rep(TRUE, 1000)
  result <- sb_dp_solve_k(0L, 1000L, 300L, 800L, scores, valid)
  expect_null(result)
})

test_that("sb_dp_solve_k finds optimal single boundary", {
  # 2000 nt, K = 1. Plant a high-scoring boundary at position 1000.
  total_len <- 2000L
  scores <- rep(0.1, total_len)
  valid <- rep(TRUE, total_len)
  # Make position 1000 the clear winner
  scores[1000] <- 10.0
  result <- sb_dp_solve_k(1L, total_len, 300L, 1800L, scores, valid)
  expect_false(is.null(result))
  expect_equal(result$boundaries[1], 1000L)
  expect_equal(result$total_score, 10.0)
})

# =============================================================================
# Test: Codon boundary preference within gene
# =============================================================================

test_that("gene-region SB boundaries are always codon-aligned (hard constraint)", {
  # Use a 3600 nt all-gene sequence (no cassette)
  # This needs 2 SBs (1 boundary)
  seq_3600 <- make_test_seq(3600)
  result <- search_superblock_boundaries_dp(
    full_seq = seq_3600,
    gene_len = nchar(seq_3600),
    max_block_length = 2400L,
    min_block_length = 300L
  )

  # All boundaries within the gene must be codon-aligned (p %% 3 == 0)
  gene_len <- nchar(seq_3600)
  for (i in seq_len(result$n_superblocks - 1L)) {
    boundary_pos <- result$boundaries$end_nt[i]
    if (boundary_pos <= gene_len) {
      expect_equal(boundary_pos %% 3L, 0L,
        info = paste("Gene SB boundary at", boundary_pos, "must be codon-aligned")
      )
    }
  }
})

test_that("cassette-region SB boundaries are NOT required to be codon-aligned", {
  # Build: 1500 nt gene + 2400 nt cassette = 3900 nt
  # Forces at least one boundary in the cassette region
  gene_seq <- make_test_seq(1500)
  cassette_unit <- "TAGCAACCGTGA" # 12 nt
  cassette_seq <- paste0(rep(cassette_unit, 200), collapse = "")
  cassette_seq <- substring(cassette_seq, 1, 2400)
  full_seq <- paste0(gene_seq, cassette_seq)
  gene_len <- nchar(gene_seq)

  result <- search_superblock_boundaries_dp(
    full_seq = full_seq,
    gene_len = gene_len,
    max_block_length = 1800L,
    min_block_length = 300L
  )

  # At least 3 SBs needed (3900 / 1800 > 2)
  expect_gte(result$n_superblocks, 2L)

  # Gene-region boundaries: codon-aligned
  # Cassette-region boundaries: any nt position is fine
  for (i in seq_len(result$n_superblocks - 1L)) {
    boundary_pos <- result$boundaries$end_nt[i]
    if (boundary_pos <= gene_len) {
      expect_equal(boundary_pos %% 3L, 0L,
        info = paste("Gene boundary at", boundary_pos, "must be codon-aligned")
      )
    }
    # No constraint on cassette boundaries — they can be at any nt position
  }
})
