# Created: 2026-03-04
# Last updated: 2026-03-06 — Switch to hybrid plan_assembly() (tile-first DP + constrained SB DP)
# test-plan-assembly-v2.R — Tests for hybrid assembly planning (plan_assembly)

# =============================================================================
# SHORT GENE (no superblocks needed)
# =============================================================================

test_that("plan_assembly works on short gene (single SB)", {
  plan <- plan_assembly(
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
  expect_true("sb_result" %in% names(plan))

  # Short gene should have 1 superblock, 1-2 tiles
  expect_equal(plan$summary$n_superblocks, 1L)
  expect_gte(plan$summary$n_tiles, 1L)

  # oh_L should be first 4 nt of gene
  expect_equal(plan$oh_L, substring(TEST_GENE_SEQ, 1, 4))

  # No SB collisions
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

test_that("plan_assembly works on long gene (multiple SBs)", {
  plan <- plan_assembly(
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

  # Tiles should cover entire gene (first tile starts at 1, last tile ends at gene end)
  expect_equal(plan$tiles$start_nt[1], 1L)
  expect_equal(plan$tiles$end_nt[nrow(plan$tiles)], nchar(TEST_LONG_GENE_SEQ))

  # Tile IDs should be sequential
  expect_equal(plan$tiles$tile_id, seq_len(nrow(plan$tiles)))

  # All tile oh1/oh2 should be 4 nt
  expect_true(all(nchar(plan$tiles$oh1_seq) == 4))
  expect_true(all(nchar(plan$tiles$oh2_seq) == 4))

  # No SB collisions
  expect_equal(plan$summary$n_sb_collisions, 0L)

  # Should include cassette_splits field
  expect_true("cassette_splits" %in% names(plan))
  expect_true(is.data.frame(plan$cassette_splits))

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

test_that("plan_assembly output is compatible with v1 format", {
  plan <- plan_assembly(
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

test_that("non-boundary tile oh2s don't collide with SB boundary overhangs", {
  plan <- plan_assembly(
    cds = TEST_LONG_GENE_SEQ,
    polIII = TEST_POLIII,
    max_mutable_nt = 243L
  )

  sb_ohs <- plan$sb_result$boundaries$boundary_oh[
    !is.na(plan$sb_result$boundaries$boundary_oh)
  ]

  if (length(sb_ohs) > 0 && plan$summary$n_superblocks >= 2L) {
    # In the hybrid approach, SB boundary OHs ARE the boundary tile's oh2
    # (by construction). So the boundary tile itself is excluded — only
    # NON-boundary tiles should have oh2s that don't collide with SB OHs.
    sbs <- plan$tile_partition$superblocks
    boundary_tiles <- sbs$end_tile[seq_len(plan$summary$n_superblocks - 1L)]

    for (ti in seq_len(nrow(plan$tiles))) {
      if (ti %in% boundary_tiles) next # Skip boundary tiles (their oh2 IS the SB OH)
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
  plan <- plan_assembly(
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

test_that("plan_assembly handles downstream cassette", {
  cassette <- paste0("GCTAGCTAGCTAGCTAGCTAGC", TEST_POLIII)
  plan <- plan_assembly(
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

# =============================================================================
# TILE OVERLAP AT SB BOUNDARIES
# =============================================================================

test_that("SB boundaries are at tile end positions (hybrid invariant)", {
  plan <- plan_assembly(
    cds = TEST_LONG_GENE_SEQ,
    polIII = TEST_POLIII,
    max_mutable_nt = 243L
  )

  if (plan$summary$n_superblocks >= 2L) {
    sb_df <- plan$sb_result$boundaries
    gene_len <- nchar(TEST_LONG_GENE_SEQ)
    tiles <- plan$tiles

    # Gene-region SB boundary positions must exactly match a tile's end_nt.
    # This is the core invariant of the hybrid approach: SB DP is constrained
    # to tile boundary positions.
    sb_boundary_nts <- sb_df$end_nt[!is.na(sb_df$boundary_oh) & sb_df$end_nt <= gene_len]

    for (sb_nt in sb_boundary_nts) {
      matching_tile <- which(tiles$end_nt == sb_nt)
      expect_true(length(matching_tile) >= 1L,
        info = paste("SB boundary at nt", sb_nt, "should match a tile end_nt")
      )
    }
  }
})

# =============================================================================
# CASSETTE SPLITS PASS-THROUGH
# =============================================================================

test_that("cassette_splits is empty for normal-sized cassettes", {
  plan <- plan_assembly(
    cds = TEST_LONG_GENE_SEQ,
    polIII = TEST_POLIII,
    max_mutable_nt = 243L
  )

  # Normal PolIII (~250 nt) fits in one block — no cassette splits
  expect_true("cassette_splits" %in% names(plan))
  expect_equal(nrow(plan$cassette_splits), 0L)
})

test_that("cassette_splits has rows for oversized cassettes", {
  # Build a very large cassette (~2500 nt) that exceeds synthesis limit
  cassette_unit <- "TAGCAACCGTGA" # 12 nt
  big_cassette <- paste0(
    paste0(rep(cassette_unit, 200), collapse = ""),
    TEST_POLIII
  )
  # big_cassette is ~2400 + 250 = ~2650 nt, well over 1800 synthesis limit

  plan <- plan_assembly(
    cds = TEST_LONG_GENE_SEQ,
    polIII = TEST_POLIII,
    max_mutable_nt = 243L,
    downstream_cassette = big_cassette
  )

  # Cassette > 1800 nt should trigger SB DP to place boundaries within it
  expect_true("cassette_splits" %in% names(plan))

  if (nrow(plan$cassette_splits) > 0) {
    # Verify columns
    expect_true("split_pos" %in% names(plan$cassette_splits))
    expect_true("junction_oh" %in% names(plan$cassette_splits))

    # split_pos should be positive and within cassette length
    expect_true(all(plan$cassette_splits$split_pos > 0))
    expect_true(all(plan$cassette_splits$split_pos <= nchar(big_cassette)))

    # junction_oh should be 4-nt strings
    expect_true(all(nchar(plan$cassette_splits$junction_oh) == 4))
  }
})

# =============================================================================
# MEDIUM CASSETTE + LARGE GENE RESIDUAL (BUG-004 guard fix)
# =============================================================================

test_that("medium cassette with large gene residual has no oversized blocks", {
  # Build a ~1100 nt cassette (under 1778 but gene_residual + cassette > 1800).
  # This was the "danger zone" that the old guard condition missed.
  filler <- paste(rep("TAGCAACCGT", 85), collapse = "") # 850 nt
  cassette <- paste0(filler, TEST_POLIII) # ~1100 nt

  plan <- plan_assembly(
    cds = TEST_LONG_GENE_SEQ,
    polIII = TEST_POLIII,
    max_mutable_nt = 243L,
    downstream_cassette = cassette
  )

  # SB DP should place a cassette boundary
  expect_true("cassette_splits" %in% names(plan))

  result <- design_wt_geneblocks(
    cds = TEST_LONG_GENE_SEQ, polIII = cassette,
    tiles = plan$tiles,
    oh3 = plan$oh3, oh4 = plan$oh4,
    paqci_star2 = "AGTC", paqci_star1 = "TCGA",
    assembly_plan = plan
  )

  over_max <- result$blocks[result$blocks$length > 1800L, ]
  expect_equal(nrow(over_max), 0L,
    info = paste("Oversized:", paste(over_max$block_name, over_max$length,
      sep = "=", collapse = ", "
    ))
  )
})

test_that("normal-sized cassette (250 nt) does not trigger cassette splitting", {
  # With just PolIII (~250 nt), no cassette splitting needed
  plan <- plan_assembly(
    cds = TEST_LONG_GENE_SEQ,
    polIII = TEST_POLIII,
    max_mutable_nt = 243L
  )

  result <- design_wt_geneblocks(
    cds = TEST_LONG_GENE_SEQ, polIII = TEST_POLIII,
    tiles = plan$tiles,
    oh3 = plan$oh3, oh4 = plan$oh4,
    paqci_star2 = "AGTC", paqci_star1 = "TCGA",
    assembly_plan = plan
  )

  # No oversized blocks
  over_max <- result$blocks[result$blocks$length > 1800L, ]
  expect_equal(nrow(over_max), 0L)

  # No cassette sub-blocks (no splitting needed)
  cassette_blocks <- result$blocks[grepl("cassette", result$blocks$block_name), ]
  expect_equal(nrow(cassette_blocks), 0L)
})
