# Created: 2026-03-04
# Last updated: 2026-03-05 — Remove anchor tests (anchors removed); keep blacklist/wrapper tests
# test-tile-dp-anchors.R — Tests for sb_blacklist parameter in
# search_tile_boundaries_dp() and the search_tile_boundaries_within_sb() wrapper.

# =============================================================================
# TEST FIXTURES
# =============================================================================

# A ~600 nt synthetic gene for meaningful tiling (200 codons).
# Starts ATG, ends TAA. No enzyme sites. Designed to produce multiple tiles
# with max_mutable_nt = 243 (81 codons) since 200 > 81.
TEST_600NT_GENE <- paste0(
  "ATG", "GCT", "GAA", "CTT", "AAA", "GCT", "GCC", "AAG", "GAT", "TTC", # 1-10

  "GGT", "ACC", "CTG", "AAC", "GAT", "ATC", "CCA", "GCT", "CAG", "AAG", # 11-20
  "TTC", "ATC", "GCT", "AAC", "CTG", "TGG", "AAG", "AAC", "GGT", "GAC", # 21-30
  "TTC", "GAT", "CTG", "GAT", "CTG", "AAA", "GAA", "CTG", "GCT", "GAC", # 31-40
  "TAC", "ATC", "AAG", "AAC", "CCG", "GCT", "ACC", "GTT", "GCT", "CTG", # 41-50
  "GAA", "GGT", "ATC", "GCT", "AAC", "GGT", "GCT", "CCG", "ATC", "TTC", # 51-60
  "AAA", "GCT", "GCT", "AAA", "GAA", "CTG", "ATC", "GAA", "TCC", "TTC", # 61-70
  "GCT", "TAC", "GTT", "AAA", "GCT", "ACC", "AAA", "GGT", "GAA", "AAC", # 71-80
  "CTG", "ATC", "TCC", "GCT", "ATC", "GAC", "AAA", "GCT", "GTT", "GAC", # 81-90
  "AAA", "CTG", "GCT", "GAA", "TAC", "ATC", "AAA", "GCT", "GAA", "GCT", # 91-100
  "GAA", "CTT", "AAA", "GCT", "GCC", "AAG", "GAT", "TTC", "GGT", "ACC", # 101-110
  "CTG", "AAC", "GAT", "ATC", "CCA", "GCT", "CAG", "AAG", "TTC", "ATC", # 111-120
  "GCT", "AAC", "CTG", "TGG", "AAG", "AAC", "GGT", "GAC", "TTC", "GAT", # 121-130
  "CTG", "GAT", "CTG", "AAA", "GAA", "CTG", "GCT", "GAC", "TAC", "ATC", # 131-140
  "AAG", "AAC", "CCG", "GCT", "ACC", "GTT", "GCT", "CTG", "GAA", "GGT", # 141-150
  "ATC", "GCT", "AAC", "GGT", "GCT", "CCG", "ATC", "TTC", "AAA", "GCT", # 151-160
  "GCT", "AAA", "GAA", "CTG", "ATC", "GAA", "TCC", "TTC", "GCT", "TAC", # 161-170
  "GTT", "AAA", "GCT", "ACC", "AAA", "GGT", "GAA", "AAC", "CTG", "ATC", # 171-180
  "TCC", "GCT", "ATC", "GAC", "AAA", "GCT", "GTT", "GAC", "AAA", "CTG", # 181-190
  "GCT", "GAA", "TAC", "ATC", "AAA", "GCT", "GAA", "GCT", "GAA", "TAA" # 191-200
)

# =============================================================================
# SB BLACKLIST TESTS
# =============================================================================

test_that("sb_blacklist excludes boundaries where oh2 matches", {
  cds <- TEST_600NT_GENE
  oh_fidelity <- builtin_overhang_fidelity()

  # Run without blacklist to find what boundaries are chosen
  suppressMessages({
    tiles_base <- search_tile_boundaries_dp(
      cds,
      max_mutable_nt = 243L,
      oh_fidelity = oh_fidelity,
      multi_k = FALSE
    )
  })

  # Grab an oh2 from an internal boundary (not the last tile's oh2 which is
  # the gene endpoint and can't be avoided)
  n_tiles <- nrow(tiles_base)
  if (n_tiles >= 2) {
    # oh2 of any tile except the last is an internal boundary oh2
    target_oh2 <- tiles_base$oh2_seq[1]

    # Now blacklist that overhang and re-run
    suppressMessages({
      tiles_bl <- search_tile_boundaries_dp(
        cds,
        max_mutable_nt = 243L,
        oh_fidelity = oh_fidelity,
        sb_blacklist = target_oh2,
        multi_k = FALSE
      )
    })

    # The blacklisted oh2 should not appear at any internal boundary
    # (Internal boundaries: oh2 of tiles 1..(n-1), oh1 of tiles 2..n)
    n_bl <- nrow(tiles_bl)
    if (n_bl >= 2) {
      internal_oh2 <- tiles_bl$oh2_seq[1:(n_bl - 1)]
      internal_oh1 <- tiles_bl$oh1_seq[2:n_bl]
      target_rc <- reverse_complement(target_oh2)

      # Neither the target oh2 nor its RC should appear at internal boundaries
      expect_false(
        target_oh2 %in% internal_oh2 || target_rc %in% internal_oh2,
        info = paste("Blacklisted oh2", target_oh2, "should not appear at internal boundary oh2")
      )
    }
  }
})

test_that("sb_blacklist blocks oh1 too (not just oh2)", {
  cds <- TEST_600NT_GENE
  oh_fidelity <- builtin_overhang_fidelity()

  # Run without blacklist first
  suppressMessages({
    tiles_base <- search_tile_boundaries_dp(
      cds,
      max_mutable_nt = 243L,
      oh_fidelity = oh_fidelity,
      multi_k = FALSE
    )
  })

  n_tiles <- nrow(tiles_base)
  if (n_tiles >= 2) {
    # Get oh1 from the second tile (an internal boundary oh1)
    target_oh1 <- tiles_base$oh1_seq[2]

    # Blacklist it — should be excluded from both oh1 AND oh2 at boundaries
    suppressMessages({
      tiles_bl <- search_tile_boundaries_dp(
        cds,
        max_mutable_nt = 243L,
        oh_fidelity = oh_fidelity,
        sb_blacklist = target_oh1,
        multi_k = FALSE
      )
    })

    n_bl <- nrow(tiles_bl)
    if (n_bl >= 2) {
      internal_oh1 <- tiles_bl$oh1_seq[2:n_bl]
      target_rc <- reverse_complement(target_oh1)

      # The blacklisted sequence should not appear at internal oh1 positions
      expect_false(
        target_oh1 %in% internal_oh1 || target_rc %in% internal_oh1,
        info = paste("Blacklisted oh1", target_oh1, "should not appear at internal boundary oh1")
      )
    }
  }
})

test_that("precompute_boundary_scores respects blacklisted_oh1", {
  cds <- TEST_600NT_GENE
  oh_fidelity <- builtin_overhang_fidelity()

  # Pick an oh1 that appears at a known position (codon boundary 50 -> nt 151)
  b <- 50L
  oh1_at_b <- substring(cds, b * 3L + 1L, b * 3L + 4L)

  # Without blacklist: position b should be valid (assuming no oh_L collision)
  suppressMessages({
    precomp_base <- precompute_boundary_scores(cds, oh_fidelity)
  })

  if (precomp_base$valid[b]) {
    # With blacklist containing oh1_at_b: position b should become invalid
    suppressMessages({
      precomp_bl <- precompute_boundary_scores(cds, oh_fidelity,
        blacklisted_oh1 = oh1_at_b
      )
    })
    expect_false(precomp_bl$valid[b],
      info = paste("Position", b, "with oh1 =", oh1_at_b, "should be invalidated by blacklist")
    )
  }
})

# =============================================================================
# WRAPPER COORDINATE ADJUSTMENT TESTS
# =============================================================================

test_that("search_tile_boundaries_within_sb adjusts coordinates to gene level", {
  cds <- TEST_LONG_GENE_SEQ # 2100 nt
  sb_start_nt <- 301L
  sb_end_nt <- 900L

  suppressMessages({
    tiles <- search_tile_boundaries_within_sb(
      cds, sb_start_nt, sb_end_nt,
      max_mutable_nt = 243L,
      multi_k = FALSE
    )
  })

  # All tile coordinates should be in the [sb_start_nt, sb_end_nt] range
  expect_true(all(tiles$start_nt >= sb_start_nt),
    info = paste("Min start_nt:", min(tiles$start_nt), "expected >=", sb_start_nt)
  )
  expect_true(all(tiles$end_nt <= sb_end_nt),
    info = paste("Max end_nt:", max(tiles$end_nt), "expected <=", sb_end_nt)
  )

  # First tile should start at sb_start_nt
  expect_equal(tiles$start_nt[1], sb_start_nt)
  # Last tile should end at sb_end_nt
  expect_equal(tiles$end_nt[nrow(tiles)], sb_end_nt)

  # Codon coordinates should also be offset
  expect_equal(tiles$start_codon[1], (sb_start_nt - 1L) %/% 3L + 1L)
})

test_that("search_tile_boundaries_within_sb with full gene range matches direct DP", {
  cds <- TEST_GENE_SEQ # 300 nt
  gene_len <- nchar(cds)

  # Domesticate first
  cu <- builtin_human_codon_usage()
  scan_result <- scan_enzyme_sites(cds, "", cu)
  if (nrow(scan_result$domestication) > 0) {
    cds <- apply_domestication(cds, scan_result$domestication, codon_usage = cu)
    gene_len <- nchar(cds)
  }

  tile_size <- compute_max_tile_size(300, 12)

  # Wrapper covering full gene should give same result as direct DP call
  suppressMessages({
    tiles_direct <- search_tile_boundaries_dp(cds, tile_size, multi_k = FALSE)
    tiles_wrapper <- search_tile_boundaries_within_sb(
      cds, 1L, gene_len, tile_size,
      multi_k = FALSE
    )
  })

  expect_equal(tiles_wrapper$start_nt, tiles_direct$start_nt)
  expect_equal(tiles_wrapper$end_nt, tiles_direct$end_nt)
  expect_equal(tiles_wrapper$start_codon, tiles_direct$start_codon)
  expect_equal(tiles_wrapper$end_codon, tiles_direct$end_codon)
})

test_that("search_tile_boundaries_within_sb passes sb_blacklist through", {
  cds <- TEST_LONG_GENE_SEQ # 2100 nt
  sb_start_nt <- 1L
  sb_end_nt <- 600L

  # Run without blacklist
  suppressMessages({
    tiles_base <- search_tile_boundaries_within_sb(
      cds, sb_start_nt, sb_end_nt,
      max_mutable_nt = 243L,
      multi_k = FALSE
    )
  })

  # If there are internal boundaries, blacklist one and verify it changes
  n_tiles <- nrow(tiles_base)
  if (n_tiles >= 2) {
    target_oh <- tiles_base$oh1_seq[2]

    suppressMessages({
      tiles_bl <- search_tile_boundaries_within_sb(
        cds, sb_start_nt, sb_end_nt,
        max_mutable_nt = 243L,
        sb_blacklist = target_oh,
        multi_k = FALSE
      )
    })

    # Either the tiles changed or the blacklisted oh is absent from boundaries
    n_bl <- nrow(tiles_bl)
    if (n_bl >= 2) {
      internal_oh1 <- tiles_bl$oh1_seq[2:n_bl]
      target_rc <- reverse_complement(target_oh)
      expect_false(
        target_oh %in% internal_oh1 || target_rc %in% internal_oh1,
        info = paste("Blacklisted oh", target_oh, "should not appear at internal oh1")
      )
    }
  }
})

# =============================================================================
# BACKWARD COMPATIBILITY TESTS
# =============================================================================

test_that("search_tile_boundaries_dp without new params works as before", {
  cds <- TEST_GENE_SEQ
  cu <- builtin_human_codon_usage()
  scan_result <- scan_enzyme_sites(cds, "", cu)
  if (nrow(scan_result$domestication) > 0) {
    cds <- apply_domestication(cds, scan_result$domestication, codon_usage = cu)
  }

  tile_size <- compute_max_tile_size(300, 12)

  # Call with NO new parameters — should work identically to before
  suppressMessages({
    tiles <- search_tile_boundaries_dp(cds, tile_size, multi_k = FALSE)
  })

  expect_true(nrow(tiles) >= 1)
  expect_equal(tiles$start_nt[1], 1)
  expect_equal(tiles$end_nt[nrow(tiles)], nchar(cds))
  expect_true(all(nchar(tiles$oh1_seq) == 4))
  expect_true(all(nchar(tiles$oh2_seq) == 4))

  # Check that all expected columns are present
  expected_cols <- c(
    "tile_id", "start_codon", "end_codon", "start_nt", "end_nt",
    "oh1_seq", "oh2_seq", "oh1_in_hf", "oh2_in_hf",
    "oh1_fidelity", "oh2_fidelity", "tile_seq", "boundary_shift"
  )
  expect_true(all(expected_cols %in% names(tiles)))
})

test_that("precompute_boundary_scores without new params works as before", {
  cds <- TEST_GENE_SEQ
  oh_fidelity <- builtin_overhang_fidelity()

  # Call with NO blacklisted_oh1 — should work identically to before
  suppressMessages({
    precomp <- precompute_boundary_scores(cds, oh_fidelity)
  })

  n_codons <- nchar(cds) %/% 3L
  expect_equal(length(precomp$oh1_seq), n_codons)
  expect_equal(length(precomp$oh2_seq), n_codons)
  expect_equal(length(precomp$score), n_codons)
  expect_equal(length(precomp$valid), n_codons)
})

test_that("plan_assembly still works with modified precompute_boundary_scores", {
  # This is the key backward compatibility test: the main pipeline function
  # should still work without any changes to its call site.
  cu <- builtin_human_codon_usage()
  cds <- TEST_GENE_SEQ
  scan_result <- scan_enzyme_sites(cds, "", cu)
  if (nrow(scan_result$domestication) > 0) {
    cds <- apply_domestication(cds, scan_result$domestication, codon_usage = cu)
  }

  tile_size <- compute_max_tile_size(300, 12)
  suppressMessages({
    plan <- plan_assembly(cds, TEST_POLIII, tile_size)
  })

  expect_true(is.list(plan))
  expect_true(!is.null(plan$tiles))
  expect_true(!is.null(plan$oh3))
  expect_true(!is.null(plan$oh4))
  expect_true(nrow(plan$tiles) >= 1)
})
