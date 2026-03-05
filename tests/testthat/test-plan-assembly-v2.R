# Created: 2026-03-04
# Last updated: 2026-03-04 — Initial tests for plan_assembly_v2
# test-plan-assembly-v2.R — Tests for SB-first two-pass assembly planning

# =============================================================================
# SHORT GENE (no superblocks needed)
# =============================================================================

test_that("plan_assembly_v2 works on short gene (single SB)", {
  plan <- plan_assembly_v2(
    cds = TEST_GENE_SEQ,
    polIII = TEST_POLIII,
    max_mutable_nt = 243L
  )

  # Should produce a valid assembly plan

  expect_type(plan, "list")
  expect_true("tiles" %in% names(plan))
  expect_true("oh3" %in% names(plan))
  expect_true("oh4" %in% names(plan))
  expect_true("oh_L" %in% names(plan))
  expect_true("superblock_splits" %in% names(plan))
  expect_true("tile_partition" %in% names(plan))
  expect_true("reaction_fidelity" %in% names(plan))
  expect_true("summary" %in% names(plan))
  expect_true("sb_result" %in% names(plan)) # v2-specific

  # Short gene should have 1 superblock, 1-2 tiles
  expect_equal(plan$summary$n_superblocks, 1L)
  expect_gte(plan$summary$n_tiles, 1L)

  # oh_L should be first 4 nt of gene
  expect_equal(plan$oh_L, substring(TEST_GENE_SEQ, 1, 4))

  # No SB collisions in v2
  expect_equal(plan$summary$n_sb_collisions, 0L)

  # Tiles should cover entire gene
  expect_equal(plan$tiles$start_nt[1], 1L)
  expect_equal(plan$tiles$end_nt[nrow(plan$tiles)], nchar(TEST_GENE_SEQ))

  # Reaction fidelity should be computed
  expect_gt(nrow(plan$reaction_fidelity), 0)
})

# =============================================================================
# LONG GENE (superblocks needed)
# =============================================================================

test_that("plan_assembly_v2 works on long gene (multiple SBs)", {
  plan <- plan_assembly_v2(
    cds = TEST_LONG_GENE_SEQ,
    polIII = TEST_POLIII,
    max_mutable_nt = 243L
  )

  expect_type(plan, "list")

  # 2100 nt gene + 250 nt promoter = 2350 nt > 1800 → needs SBs
  expect_gte(plan$summary$n_superblocks, 2L)

  # Should have multiple tiles
  n_codons <- nchar(TEST_LONG_GENE_SEQ) %/% 3L
  max_codons <- 243L %/% 3L
  expect_gte(plan$summary$n_tiles, ceiling(n_codons / max_codons))

  # Tiles should cover entire gene
  expect_equal(plan$tiles$start_nt[1], 1L)
  expect_equal(plan$tiles$end_nt[nrow(plan$tiles)], nchar(TEST_LONG_GENE_SEQ))

  # Tile IDs should be sequential
  expect_equal(plan$tiles$tile_id, seq_len(nrow(plan$tiles)))

  # All tile oh1/oh2 should be 4 nt
  expect_true(all(nchar(plan$tiles$oh1_seq) == 4))
  expect_true(all(nchar(plan$tiles$oh2_seq) == 4))

  # No SB collisions
  expect_equal(plan$summary$n_sb_collisions, 0L)

  # SB boundary overhangs should not collide with oh3 or oh4
  sb_result <- plan$sb_result
  sb_ohs <- sb_result$boundaries$boundary_oh[!is.na(sb_result$boundaries$boundary_oh)]
  for (sb_oh in sb_ohs) {
    expect_false(oh_collides(sb_oh, plan$oh3),
      info = paste("SB boundary oh", sb_oh, "collides with oh3", plan$oh3)
    )
    expect_false(oh_collides(sb_oh, plan$oh4),
      info = paste("SB boundary oh", sb_oh, "collides with oh4", plan$oh4)
    )
    expect_false(oh_collides(sb_oh, plan$oh_L),
      info = paste("SB boundary oh", sb_oh, "collides with oh_L", plan$oh_L)
    )
  }

  # Superblock splits should be non-empty for multi-SB genes
  expect_gt(nrow(plan$superblock_splits), 0)
})

# =============================================================================
# OUTPUT FORMAT COMPATIBILITY
# =============================================================================

test_that("plan_assembly_v2 output is compatible with v1 format", {
  plan <- plan_assembly_v2(
    cds = TEST_LONG_GENE_SEQ,
    polIII = TEST_POLIII,
    max_mutable_nt = 243L
  )

  # Check all required fields for downstream consumers
  required_fields <- c(
    "tiles", "oh3", "oh4", "oh_L", "oh3_in_hf", "oh4_in_hf",
    "core_polIII", "oh3_spacer", "superblock_splits",
    "tile_partition", "reaction_fidelity", "strategy_used",
    "hf_set_used", "oh_fidelity_used", "cassette_needs_splitting",
    "summary"
  )
  for (field in required_fields) {
    expect_true(field %in% names(plan), info = paste("Missing field:", field))
  }

  # Tiles should have expected columns
  tile_cols <- c(
    "tile_id", "start_codon", "end_codon", "start_nt", "end_nt",
    "oh1_seq", "oh2_seq", "oh1_in_hf", "oh2_in_hf",
    "oh1_fidelity", "oh2_fidelity", "tile_seq"
  )
  for (col in tile_cols) {
    expect_true(col %in% names(plan$tiles), info = paste("Missing tile column:", col))
  }

  # Superblock splits format
  if (nrow(plan$superblock_splits) > 0) {
    split_cols <- c(
      "split_nt", "junction_oh", "junction_in_hf",
      "junction_fidelity", "block_type", "tile_id"
    )
    for (col in split_cols) {
      expect_true(col %in% names(plan$superblock_splits),
        info = paste("Missing split column:", col)
      )
    }
  }

  # tile_partition format
  expect_true("n_superblocks" %in% names(plan$tile_partition))
  expect_true("superblocks" %in% names(plan$tile_partition))
  expect_true("n_collisions" %in% names(plan$tile_partition))
  expect_equal(plan$tile_partition$n_collisions, 0L)

  # Summary format
  summary_fields <- c(
    "n_tiles", "n_boundaries", "n_superblocks",
    "n_sb_collisions", "overall_min_fidelity"
  )
  for (field in summary_fields) {
    expect_true(field %in% names(plan$summary), info = paste("Missing summary:", field))
  }
})

# =============================================================================
# TILE BOUNDARY OVERHANGS DON'T COLLIDE WITH SB OVERHANGS
# =============================================================================

test_that("tile boundary overhangs don't collide with SB boundary overhangs", {
  plan <- plan_assembly_v2(
    cds = TEST_LONG_GENE_SEQ,
    polIII = TEST_POLIII,
    max_mutable_nt = 243L
  )

  sb_ohs <- plan$sb_result$boundaries$boundary_oh[
    !is.na(plan$sb_result$boundaries$boundary_oh)
  ]

  if (length(sb_ohs) > 0) {
    sb_df <- plan$sb_result$boundaries
    gene_len <- nchar(TEST_LONG_GENE_SEQ)

    # Identify SB boundary nt positions in the gene
    sb_boundary_nts <- sb_df$end_nt[!is.na(sb_df$boundary_oh) & sb_df$end_nt <= gene_len]

    # No INTERNAL tile oh1 should collide with any SB boundary OH
    # (First tile of each SB has oh1 = SB boundary by design — that's the anchor)
    for (ti in seq_len(nrow(plan$tiles))) {
      # Skip tiles whose start_nt is at an SB boundary (oh1 IS the SB junction)
      if ((plan$tiles$start_nt[ti] - 1L) %in% sb_boundary_nts) next
      for (sb_oh in sb_ohs) {
        expect_false(
          oh_collides(plan$tiles$oh1_seq[ti], sb_oh),
          info = paste(
            "Tile", ti, "oh1", plan$tiles$oh1_seq[ti],
            "collides with SB oh", sb_oh
          )
        )
      }
    }
    # INTERNAL tile oh2 should not collide with SB boundary OHs
    # (Last tile of each SB has oh2 AT the SB boundary — that's expected)
    for (ti in seq_len(nrow(plan$tiles))) {
      # Skip tiles whose end_nt is at an SB boundary (oh2 IS the SB junction)
      if (plan$tiles$end_nt[ti] %in% sb_boundary_nts) next
      for (sb_oh in sb_ohs) {
        expect_false(
          oh_collides(plan$tiles$oh2_seq[ti], sb_oh),
          info = paste(
            "Tile", ti, "oh2", plan$tiles$oh2_seq[ti],
            "collides with SB oh", sb_oh
          )
        )
      }
    }
  }
})

# =============================================================================
# REACTION FIDELITY
# =============================================================================

test_that("per-reaction fidelity is reasonable", {
  plan <- plan_assembly_v2(
    cds = TEST_LONG_GENE_SEQ,
    polIII = TEST_POLIII,
    max_mutable_nt = 243L
  )

  rf <- plan$reaction_fidelity

  # Should have 2 rows per tile (BsaI + BsmBI)
  expect_equal(nrow(rf), 2 * nrow(plan$tiles))

  # All fidelities should be positive
  expect_true(all(rf$set_fidelity > 0))

  # Most reactions should have reasonable fidelity (> 0.5)
  expect_gte(mean(rf$set_fidelity > 0.5), 0.8)
})

# =============================================================================
# DOWNSTREAM CASSETTE SUPPORT
# =============================================================================

test_that("plan_assembly_v2 handles downstream cassette", {
  cassette <- paste0("GCTAGCTAGCTAGCTAGCTAGC", TEST_POLIII)
  plan <- plan_assembly_v2(
    cds = TEST_LONG_GENE_SEQ,
    polIII = TEST_POLIII,
    max_mutable_nt = 243L,
    downstream_cassette = cassette
  )

  expect_type(plan, "list")
  expect_gte(plan$summary$n_superblocks, 2L)
  expect_equal(plan$summary$n_sb_collisions, 0L)

  # core_downstream_cassette should be cassette minus last 5 nt
  if (!is.null(plan$core_downstream_cassette)) {
    expect_equal(
      nchar(plan$core_downstream_cassette),
      nchar(cassette) - 5L
    )
  }
})
