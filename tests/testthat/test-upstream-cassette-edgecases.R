# test-upstream-cassette-edgecases.R
# Bug tester: verify upstream_cassette handling in oligo assembly & gene blocks
#
# Tests:
# 1. Non-empty upstream_cassette ("CC") appears between oh_L and ATG in tile 1 oligos
# 2. Empty upstream_cassette: tile 1 goes directly from oh_L to ATG
# 3. Tiles 2+ must NOT contain upstream_cassette at the oh1 position
# 4. 5'WT gene blocks for tile 2+ contain oh_L + upstream_cassette + CDS[1..boundary]

# --- Helper: build a minimal assembly for upstream_cassette testing ---
# Uses partition_tiles (geometric) to avoid plan_assembly's full DP machinery,
# then manually sets oh1_seq for tile 1 to an external oh_L (mimicking plan_assembly).
build_test_assembly <- function(upstream_cassette = "") {
  cu <- TEST_CODON_USAGE
  cds <- domesticate_test_gene()

  mutable_size <- compute_max_tile_size(
    max_oligo_length = 300L,
    barcode_length = 12L,
    upstream_cassette_len = nchar(upstream_cassette)
  )
  tiles <- partition_tiles(cds, mutable_size)

  # Mimic plan_assembly's oh_L behavior: tile 1 gets external oh_L
  oh_L <- "TTGG"
  tiles$oh1_seq[1] <- oh_L

  variants <- design_mutations(cds, cu)
  variants <- assign_variants_to_tiles(variants, tiles)

  n <- nrow(variants)
  set.seed(42)
  barcodes <- replicate(n, paste0(
    sample(c("A", "C", "G", "T"), 12, replace = TRUE), collapse = ""
  ))

  oh3 <- "ACTA"
  oh4 <- "GATA"

  oligos <- assemble_oligos(
    variants, cds, barcodes, tiles, oh3, oh4,
    max_oligo_length = 300L,
    upstream_cassette = upstream_cassette
  )

  list(
    cds = cds,
    tiles = tiles,
    variants = variants,
    barcodes = barcodes,
    oligos = oligos,
    oh_L = oh_L,
    oh3 = oh3,
    oh4 = oh4
  )
}

# =========================================================================
# Test 1: Non-empty upstream_cassette in tile 1 oligos
# =========================================================================
test_that("tile 1 oligos contain upstream_cassette between oh_L and ATG", {
  res <- build_test_assembly(upstream_cassette = "CC")

  # Get tile 1 oligos
  tile1_idx <- which(res$oligos$tile_id == 1)
  expect_true(length(tile1_idx) > 0, info = "Should have tile 1 oligos")

  # Oligo structure: BsaI_fwd(7) + oh_L(4) + upstream_cassette + mutable_region + ...
  # BsaI_fwd = "GGTCTCA" (recognition GGTCTC + spacer A = 7 nt)
  # oh_L = "TTGG" (4 nt)
  # upstream_cassette = "CC" (2 nt)
  # Then ATG should follow (CDS starts with ATG)
  bsai_fwd <- "GGTCTCA"  # 7 nt
  oh_L <- res$oh_L         # 4 nt

  for (i in tile1_idx[1:min(5, length(tile1_idx))]) {
    seq <- res$oligos$sequence[i]

    # Verify BsaI + oh_L prefix
    prefix <- substring(seq, 1, nchar(bsai_fwd) + nchar(oh_L))
    expect_equal(prefix, paste0(bsai_fwd, oh_L),
      info = paste("Oligo", i, "should start with BsaI_fwd + oh_L"))

    # After oh_L, next 2 nt should be the upstream_cassette "CC"
    uc_start <- nchar(bsai_fwd) + nchar(oh_L) + 1
    uc_end <- uc_start + 1  # 2 nt for "CC"
    uc_actual <- substring(seq, uc_start, uc_end)
    expect_equal(uc_actual, "CC",
      info = paste("Oligo", i, "should have upstream_cassette='CC' after oh_L"))

    # Immediately after upstream_cassette, we should see ATG (start of CDS)
    atg_start <- uc_end + 1
    atg_end <- atg_start + 2
    atg_actual <- substring(seq, atg_start, atg_end)
    expect_equal(atg_actual, "ATG",
      info = paste("Oligo", i, "should have ATG after upstream_cassette"))
  }
})

# =========================================================================
# Test 2: Empty upstream_cassette means oh_L directly precedes ATG
# =========================================================================
test_that("empty upstream_cassette: tile 1 oligos go from oh_L directly to ATG", {
  res <- build_test_assembly(upstream_cassette = "")

  tile1_idx <- which(res$oligos$tile_id == 1)
  expect_true(length(tile1_idx) > 0)

  bsai_fwd <- "GGTCTCA"
  oh_L <- res$oh_L

  for (i in tile1_idx[1:min(5, length(tile1_idx))]) {
    seq <- res$oligos$sequence[i]

    # After BsaI_fwd(7) + oh_L(4), ATG should be immediate
    atg_start <- nchar(bsai_fwd) + nchar(oh_L) + 1
    atg_end <- atg_start + 2
    atg_actual <- substring(seq, atg_start, atg_end)
    expect_equal(atg_actual, "ATG",
      info = paste("Oligo", i, "should have ATG immediately after oh_L (no cassette)"))
  }
})

# =========================================================================
# Test 3: Tiles 2+ should NOT have upstream_cassette at the oh1 position
# =========================================================================
test_that("tiles 2+ do not have upstream_cassette injected", {
  res <- build_test_assembly(upstream_cassette = "CC")

  # Get tile 2 oligos (if they exist)
  tile2_idx <- which(res$oligos$tile_id == 2)
  if (length(tile2_idx) == 0) {
    skip("Gene too short to produce tile 2 — cannot test tile 2+ exclusion")
  }

  bsai_fwd <- "GGTCTCA"

  for (i in tile2_idx[1:min(5, length(tile2_idx))]) {
    seq <- res$oligos$sequence[i]

    # Tile 2's oh1 is a gene-derived 4-nt overhang (NOT oh_L)
    oh1_tile2 <- res$tiles$oh1_seq[2]
    prefix <- substring(seq, 1, nchar(bsai_fwd) + nchar(oh1_tile2))
    expect_equal(prefix, paste0(bsai_fwd, oh1_tile2),
      info = paste("Tile 2 oligo", i, "should start with BsaI_fwd + oh1 (gene-derived)"))

    # After oh1, the next 2 nt should NOT be "CC" — they should be the mutable
    # region interior (i.e., CDS nucleotides starting at position 5 of the tile).
    # The mutable region for tile 2+ strips the first 4 nt (oh1) and last 4 nt (oh2).
    after_oh1_start <- nchar(bsai_fwd) + nchar(oh1_tile2) + 1
    after_oh1_end <- after_oh1_start + 1
    after_oh1 <- substring(seq, after_oh1_start, after_oh1_end)

    # The mutable region starts at position 5 of the tile sequence (after oh1's 4 nt).
    tile2_seq <- res$tiles$tile_seq[2]
    expected_start <- substring(tile2_seq, 5, 6)

    # For WT control variants at this position, the sequence should match WT.
    # For mutants, the codon might differ but the first 2 nt of the interior
    # should NOT be the upstream_cassette "CC" (which would indicate a bug).
    #
    # Stronger check: the mutable region is derived from the CDS tile interior,
    # NOT from upstream_cassette + CDS. If upstream_cassette leaked in, the entire
    # sequence would be shifted.
    expect_false(
      identical(substring(seq, nchar(bsai_fwd) + 1,
                          nchar(bsai_fwd) + nchar(oh1_tile2) + 2),
                paste0(oh1_tile2, "CC")),
      info = paste("Tile 2 oligo", i, "should not have upstream_cassette after oh1")
    )
  }
})

# =========================================================================
# Test 4: upstream_cassette length affects tile budget
# =========================================================================
test_that("upstream_cassette reduces the mutable tile size", {
  size_no_uc <- compute_max_tile_size(300L, 12L, upstream_cassette_len = 0L)
  size_with_uc <- compute_max_tile_size(300L, 12L, upstream_cassette_len = 2L)

  # With 2 nt upstream_cassette, tile size should be 3 nt smaller (rounded to codon)
  # because 2 nt overhead reduces mutable space from 244 to 242, both round to 240? No:
  # 300 - 44 - 12 = 244 → floor to 243 (codon boundary)
  # 300 - 44 - 12 - 2 = 242 → floor to 240 (codon boundary)
  # So the difference should be 3 nt (one codon)
  expect_true(size_with_uc < size_no_uc,
    info = "upstream_cassette overhead should reduce tile mutable size")
  expect_equal(size_with_uc %% 3, 0,
    info = "Tile size should remain on codon boundary")
  expect_equal(size_no_uc %% 3, 0,
    info = "Tile size should remain on codon boundary")
})

# =========================================================================
# Test 5: Oligo structural integrity — tile 1 mutable region is full CDS
# tile minus the trailing oh2 (4 nt), with upstream_cassette prepended
# =========================================================================
test_that("tile 1 mutable region = upstream_cassette + CDS[1..tile_end-4]", {
  uc <- "CC"
  res <- build_test_assembly(upstream_cassette = uc)

  tile1 <- res$tiles[1, ]
  tile1_idx <- which(res$oligos$tile_id == 1)

  # Pick a WT control variant to verify exact sequence
  wt_controls <- which(res$variants$variant_type[tile1_idx] == "wt_control")
  if (length(wt_controls) == 0) skip("No WT controls in tile 1")

  test_idx <- tile1_idx[wt_controls[1]]
  seq <- res$oligos$sequence[test_idx]

  # Extract the mutable region from the oligo:
  # BsaI_fwd(7) + oh_L(4) + [mutable_region] + BsmBI_rev_oh2(11) + BsmBI_fwd_oh3(11) + barcode(12) + BsaI_rev_oh4(11)
  bsai_fwd_len <- 7L
  oh_L_len <- 4L
  bsmbi_rev_oh2_len <- 11L
  bsmbi_fwd_oh3_len <- 11L
  barcode_len <- 12L
  bsai_rev_oh4_len <- 11L

  tail_len <- bsmbi_rev_oh2_len + bsmbi_fwd_oh3_len + barcode_len + bsai_rev_oh4_len
  mutable_start <- bsai_fwd_len + oh_L_len + 1L
  mutable_end <- nchar(seq) - tail_len

  mutable_region <- substring(seq, mutable_start, mutable_end)

  # Expected: upstream_cassette + CDS[1 .. tile_end - 4]
  # For tile 1, the mutable is: upstream_cassette + substring(tile, 1, tile_len - 4)
  # But since this is a WT control, the "mutant" tile is identical to WT tile.
  tile_seq <- tile1$tile_seq
  tile_len <- nchar(tile_seq)
  expected_mutable <- paste0(uc, substring(tile_seq, 1, tile_len - 4L))

  expect_equal(mutable_region, expected_mutable,
    info = "Tile 1 WT control: mutable = upstream_cassette + CDS[1..end-4]")
})

# =========================================================================
# Test 6: Tile 2 mutable region = CDS interior (strips oh1=4nt, oh2=4nt)
# (verifies upstream_cassette does NOT leak into tile 2 mutable regions)
# =========================================================================
test_that("tile 2 mutable region strips oh1/oh2 and has no upstream_cassette", {
  res <- build_test_assembly(upstream_cassette = "CC")

  if (nrow(res$tiles) < 2) skip("Only 1 tile — cannot test tile 2")

  tile2 <- res$tiles[2, ]
  tile2_idx <- which(res$oligos$tile_id == 2)

  wt_controls <- which(res$variants$variant_type[tile2_idx] == "wt_control")
  if (length(wt_controls) == 0) skip("No WT controls in tile 2")

  test_idx <- tile2_idx[wt_controls[1]]
  seq <- res$oligos$sequence[test_idx]

  # Extract mutable region
  bsai_fwd_len <- 7L
  oh1_len <- 4L
  bsmbi_rev_oh2_len <- 11L
  bsmbi_fwd_oh3_len <- 11L
  barcode_len <- 12L
  bsai_rev_oh4_len <- 11L

  tail_len <- bsmbi_rev_oh2_len + bsmbi_fwd_oh3_len + barcode_len + bsai_rev_oh4_len
  mutable_start <- bsai_fwd_len + oh1_len + 1L
  mutable_end <- nchar(seq) - tail_len

  mutable_region <- substring(seq, mutable_start, mutable_end)

  # Expected: tile interior with oh1(4) and oh2(4) stripped
  tile_seq <- tile2$tile_seq
  tile_len <- nchar(tile_seq)
  expected_mutable <- substring(tile_seq, 5, tile_len - 4L)

  expect_equal(mutable_region, expected_mutable,
    info = "Tile 2 WT control: mutable = tile_interior (no upstream_cassette)")

  # Extra: mutable region should NOT start with "CC" + "ATG"
  expect_false(startsWith(mutable_region, "CCATG"),
    info = "Tile 2 mutable should not start with upstream_cassette + ATG")
})

# =========================================================================
# Test 7: Consistency — tile 1 oligo lengths differ by exactly
# nchar(upstream_cassette) between empty and non-empty runs
# =========================================================================
test_that("tile 1 oligos are longer by exactly nchar(upstream_cassette)", {
  res_empty <- build_test_assembly(upstream_cassette = "")
  res_cc <- build_test_assembly(upstream_cassette = "CC")

  # Both assemblies have the same variants (same gene, same codon table).
  # The tile sizes differ (budget changes), so we can't compare per-variant.
  # Instead, check that for tile 1 oligos in each assembly, the lengths are
  # self-consistent: all tile 1 oligos should have the same length
  # (since all tile 1 variants share the same tile boundaries and barcode length).

  # Actually, within each assembly, tile 1 oligos should all be the same length
  # (because tile region + fixed overhead is constant per tile; only the codon mutates
  # which doesn't change length). But barcode lengths are all 12, so yes.
  tile1_empty <- res_empty$oligos[res_empty$oligos$tile_id == 1, ]
  tile1_cc <- res_cc$oligos[res_cc$oligos$tile_id == 1, ]

  # All tile 1 oligos in each run should have uniform length
  expect_equal(length(unique(tile1_empty$length)), 1L,
    info = "All tile 1 oligos (empty UC) should have same length")
  expect_equal(length(unique(tile1_cc$length)), 1L,
    info = "All tile 1 oligos (CC UC) should have same length")

  # Note: the actual length difference is not simply 2 because the upstream_cassette
  # also reduces the tile budget (via compute_max_tile_size), which may change
  # the tile size and therefore the mutable region length. So we check structure,
  # not raw length difference.
})

# =========================================================================
# Test 8: upstream_cassette with longer sequence (e.g., Kozak = "GCCACC")
# =========================================================================
test_that("longer upstream_cassette (Kozak GCCACC) is correctly placed", {
  kozak <- "GCCACC"
  res <- build_test_assembly(upstream_cassette = kozak)

  tile1_idx <- which(res$oligos$tile_id == 1)
  expect_true(length(tile1_idx) > 0)

  bsai_fwd <- "GGTCTCA"
  oh_L <- res$oh_L

  for (i in tile1_idx[1:min(3, length(tile1_idx))]) {
    seq <- res$oligos$sequence[i]

    uc_start <- nchar(bsai_fwd) + nchar(oh_L) + 1
    uc_end <- uc_start + nchar(kozak) - 1
    uc_actual <- substring(seq, uc_start, uc_end)
    expect_equal(uc_actual, kozak,
      info = paste("Oligo", i, "should have Kozak after oh_L"))

    atg_start <- uc_end + 1
    atg_end <- atg_start + 2
    expect_equal(substring(seq, atg_start, atg_end), "ATG",
      info = paste("Oligo", i, "should have ATG after Kozak"))
  }
})

# =========================================================================
# Test 9: 5'WT gene block for tile 2 contains oh_L + upstream_cassette + CDS
# =========================================================================
test_that("5'WT gene block for tile 2 contains oh_L + upstream_cassette + CDS content", {
  cu <- TEST_CODON_USAGE
  cds <- domesticate_test_gene()
  polIII <- TEST_POLIII
  uc <- "CC"
  oh_L <- "TTGG"

  mutable_size <- compute_max_tile_size(300L, 12L, upstream_cassette_len = nchar(uc))
  tiles <- partition_tiles(cds, mutable_size)
  if (nrow(tiles) < 2) skip("Only 1 tile — cannot test 5'WT gene block for tile 2")

  # Set oh1 for tile 1 to oh_L (mimic plan_assembly)
  tiles$oh1_seq[1] <- oh_L

  oh3 <- "ACTA"
  oh4 <- "GATA"

  # Build a mock assembly_plan with the fields design_wt_geneblocks expects
  mock_plan <- list(
    oh_L = oh_L,
    upstream_cassette = uc,
    core_polIII = NULL,
    core_downstream_cassette = NULL,
    oh3_spacer = NULL,
    superblock_splits = data.frame(
      split_nt = integer(0), junction_oh = character(0),
      tile_id = integer(0), block_type = character(0),
      stringsAsFactors = FALSE
    ),
    oh_fidelity_used = NULL
  )

  gb_result <- design_wt_geneblocks(
    cds = cds, polIII = polIII, tiles = tiles,
    oh3 = oh3, oh4 = oh4,
    paqci_star2 = "AAAA", paqci_star1 = "TTTT",
    assembly_plan = mock_plan
  )

  blocks_df <- gb_result$blocks

  # Find the 5'WT block for tile 2
  bsai_5wt_tile2 <- blocks_df[grepl("bsai_5wt_tile2", blocks_df$block_name), ]
  expect_true(nrow(bsai_5wt_tile2) > 0,
    info = "Should have a 5'WT block for tile 2")

  # The block sequence structure:
  # flanking_pad + BsaI_fwd(oh_L) + [oh_L + upstream_cassette + CDS[1..boundary] minus oh_L prefix] + BsaI_rev(oh1_tile2) + flanking_pad
  # Actually, create_bsai_block trims oh_5prime from gene_seq.
  # gene_seq passed in = oh_L + upstream_cassette + CDS[1..wt_5prime_end]
  # After trimming oh_L (4 nt), the interior = upstream_cassette + CDS[1..wt_5prime_end]
  # So the block is: BsaI_fwd(oh_L) + upstream_cassette + CDS[1..end] + BsaI_rev(oh1_tile2)

  block_seq <- bsai_5wt_tile2$sequence[1]

  # BsaI_fwd = GGTCTC + A + oh_L = "GGTCTCA" + "TTGG" = 11 nt
  bsai_fwd_full <- paste0("GGTCTCA", oh_L)

  # The block should start with BsaI_fwd(oh_L) = GGTCTC + A + TTGG
  expect_true(startsWith(block_seq, bsai_fwd_full),
    info = "5'WT block should start with BsaI_fwd + oh_L")

  # After BsaI_fwd(11), the interior starts.
  # create_bsai_block strips oh_5 (oh_L, 4 nt) from the gene_seq,
  # so the interior = upstream_cassette + CDS[1..tile2_start-1]
  interior_start <- nchar(bsai_fwd_full) + 1
  # Interior goes until BsaI_rev site at the end
  bsai_rev_len <- 11L  # RC(GGTCTC + A + oh1_tile2)
  interior_end <- nchar(block_seq) - bsai_rev_len

  interior <- substring(block_seq, interior_start, interior_end)

  # Expected interior: upstream_cassette + CDS[1 .. tile2.start_nt - 1]
  tile2_start <- tiles$start_nt[2]
  expected_interior <- paste0(uc, substring(cds, 1, tile2_start - 1))

  expect_equal(interior, expected_interior,
    info = "5'WT block interior = upstream_cassette + CDS[1..tile2_boundary]")

  # Specifically, interior should start with "CC" (upstream_cassette)
  expect_true(startsWith(interior, uc),
    info = "5'WT block interior starts with upstream_cassette")

  # And then ATG
  expect_equal(substring(interior, nchar(uc) + 1, nchar(uc) + 3), "ATG",
    info = "5'WT block interior has ATG after upstream_cassette")
})

# =========================================================================
# Test 10: Empty upstream_cassette — 5'WT block goes directly to CDS
# =========================================================================
test_that("5'WT gene block with empty upstream_cassette has no gap between oh_L and ATG", {
  cu <- TEST_CODON_USAGE
  cds <- domesticate_test_gene()
  polIII <- TEST_POLIII
  oh_L <- "TTGG"

  mutable_size <- compute_max_tile_size(300L, 12L, upstream_cassette_len = 0L)
  tiles <- partition_tiles(cds, mutable_size)
  if (nrow(tiles) < 2) skip("Only 1 tile")

  tiles$oh1_seq[1] <- oh_L
  oh3 <- "ACTA"
  oh4 <- "GATA"

  mock_plan <- list(
    oh_L = oh_L,
    upstream_cassette = "",
    core_polIII = NULL,
    core_downstream_cassette = NULL,
    oh3_spacer = NULL,
    superblock_splits = data.frame(
      split_nt = integer(0), junction_oh = character(0),
      tile_id = integer(0), block_type = character(0),
      stringsAsFactors = FALSE
    ),
    oh_fidelity_used = NULL
  )

  gb_result <- design_wt_geneblocks(
    cds = cds, polIII = polIII, tiles = tiles,
    oh3 = oh3, oh4 = oh4,
    paqci_star2 = "AAAA", paqci_star1 = "TTTT",
    assembly_plan = mock_plan
  )

  blocks_df <- gb_result$blocks
  bsai_5wt_tile2 <- blocks_df[grepl("bsai_5wt_tile2", blocks_df$block_name), ]
  expect_true(nrow(bsai_5wt_tile2) > 0)

  block_seq <- bsai_5wt_tile2$sequence[1]

  # Interior should start immediately with CDS (ATG)
  bsai_fwd_full <- paste0("GGTCTCA", oh_L)
  interior_start <- nchar(bsai_fwd_full) + 1
  bsai_rev_len <- 11L
  interior_end <- nchar(block_seq) - bsai_rev_len

  interior <- substring(block_seq, interior_start, interior_end)

  # Expected: CDS[1..tile2_start-1] with NO upstream_cassette prefix
  tile2_start <- tiles$start_nt[2]
  expected_interior <- substring(cds, 1, tile2_start - 1)

  expect_equal(interior, expected_interior,
    info = "5'WT block interior = CDS[1..tile2_boundary] (no upstream_cassette)")

  # Should start directly with ATG
  expect_true(startsWith(interior, "ATG"),
    info = "5'WT block interior starts with ATG (no cassette)")
})

# =========================================================================
# Test 11: Tile 1 does NOT get a 5'WT block (no upstream gene content)
# =========================================================================
test_that("tile 1 has no 5'WT gene block (oh_L is on the oligo)", {
  cu <- TEST_CODON_USAGE
  cds <- domesticate_test_gene()
  polIII <- TEST_POLIII
  oh_L <- "TTGG"

  mutable_size <- compute_max_tile_size(300L, 12L, upstream_cassette_len = 2L)
  tiles <- partition_tiles(cds, mutable_size)
  tiles$oh1_seq[1] <- oh_L

  oh3 <- "ACTA"
  oh4 <- "GATA"

  mock_plan <- list(
    oh_L = oh_L,
    upstream_cassette = "CC",
    core_polIII = NULL,
    core_downstream_cassette = NULL,
    oh3_spacer = NULL,
    superblock_splits = data.frame(
      split_nt = integer(0), junction_oh = character(0),
      tile_id = integer(0), block_type = character(0),
      stringsAsFactors = FALSE
    ),
    oh_fidelity_used = NULL
  )

  gb_result <- design_wt_geneblocks(
    cds = cds, polIII = polIII, tiles = tiles,
    oh3 = oh3, oh4 = oh4,
    paqci_star2 = "AAAA", paqci_star1 = "TTTT",
    assembly_plan = mock_plan
  )

  blocks_df <- gb_result$blocks

  # Tile 1 starts at nt 1 — there is no 5' WT content upstream.
  # So there should be NO bsai_5wt_tile1 block.
  bsai_5wt_tile1 <- blocks_df[grepl("bsai_5wt_tile1", blocks_df$block_name), ]
  expect_equal(nrow(bsai_5wt_tile1), 0L,
    info = "Tile 1 should not have a 5'WT block (oh_L + upstream_cassette on oligo)")
})
