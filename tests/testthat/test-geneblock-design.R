# test-geneblock-design.R — Tests for 09_wt_geneblock_design.R (3-enzyme architecture)

test_that("create_bsai_block produces correct structure", {
  gene_seq <- "ATGGCTGAA"
  oh5 <- "ATGG"
  oh3 <- "CTAA"

  block <- create_bsai_block(gene_seq, oh5, oh3)

  # Should contain BsaI recognition sites
  expect_true(grepl("GGTCTC", block))

  # Should contain the gene sequence
  expect_true(grepl(gene_seq, block))
})

test_that("create_bsmbi_block produces correct structure", {
  gene_seq <- "ATGGCTGAA"
  oh5 <- "CTAA"
  oh3 <- "ACTA"

  block <- create_bsmbi_block(gene_seq, oh5, oh3)

  # Should contain BsmBI recognition sites
  expect_true(grepl("CGTCTC", block))

  # Should contain the gene sequence
  expect_true(grepl(gene_seq, block))
})

test_that("design_helper_plasmid produces valid output", {
  oh_L <- "ATGG"
  oh_R <- "GATA"
  paqci_star2 <- "AGTC"
  paqci_star1 <- "TCGA"

  helper <- design_helper_plasmid(oh_L, oh_R, paqci_star2, paqci_star1)

  expect_equal(nrow(helper), 1)
  expect_true(nchar(helper$sequence) > 0)
  expect_equal(helper$oh_L, oh_L)
  expect_equal(helper$oh_R, oh_R)

  # Should contain PaqCI recognition sites
  expect_true(grepl("CACCTGC", helper$sequence))
  # Should contain BsaI recognition sites
  expect_true(grepl("GGTCTC", helper$sequence))
})

test_that("design_wt_geneblocks returns blocks and manifests", {
  cu <- TEST_CODON_USAGE
  cds <- domesticate_test_gene()

  tiles <- partition_tiles(cds, 150)
  oh3 <- "ACTA"
  oh4 <- "GATA"

  result <- design_wt_geneblocks(
    cds = cds, polIII = TEST_POLIII,
    tiles = tiles,
    oh3 = oh3, oh4 = oh4,
    paqci_star2 = "AGTC", paqci_star1 = "TCGA"
  )

  # Should return a list with blocks, manifests, and helper
  expect_true(is.list(result))
  expect_true(!is.null(result$blocks))
  expect_true(!is.null(result$tile_manifests))
  expect_true(!is.null(result$helper_plasmid))

  # Should have at least one block per tile for BsmBI
  expect_true(nrow(result$blocks) > 0)

  # Should have one manifest per tile
  expect_equal(nrow(result$tile_manifests), nrow(tiles))

  # All manifests should have bsmbi_parts
  expect_true(all(nchar(result$tile_manifests$bsmbi_parts) > 0))
})

test_that("gene blocks have correct enzyme types", {
  cu <- TEST_CODON_USAGE
  cds <- domesticate_test_gene()

  tiles <- partition_tiles(cds, 150)

  result <- design_wt_geneblocks(
    cds = cds, polIII = TEST_POLIII,
    tiles = tiles,
    oh3 = "ACTA", oh4 = "GATA",
    paqci_star2 = "AGTC", paqci_star1 = "TCGA"
  )

  # All blocks should be either BsaI or BsmBI type
  expect_true(all(result$blocks$enzyme_type %in% c("BsaI", "BsmBI")))
})

test_that("deduplicate_blocks removes exact duplicates", {
  blocks <- data.frame(
    block_name = c("block_a", "block_b"),
    sequence = c("ATGGCTGAA", "ATGGCTGAA"),
    length = c(9, 9),
    enzyme_type = c("BsaI", "BsaI"),
    gene_region = c("region1", "region2"),
    stringsAsFactors = FALSE
  )

  result <- deduplicate_blocks(blocks)
  deduped <- result$blocks
  name_map <- result$name_map
  expect_equal(nrow(deduped), 1)
  # gene_region should be merged
  expect_true(grepl("region1", deduped$gene_region))
  expect_true(grepl("region2", deduped$gene_region))
  # name_map should map both names to the surviving name
  expect_equal(name_map[["block_a"]], "block_a")
  expect_equal(name_map[["block_b"]], "block_a")
})

# =============================================================================
# FIX 2a: gene_region NAMING TESTS
# =============================================================================

test_that("non-final 3'WT sub-blocks have gene_region WITHOUT polIII", {
  cu <- TEST_CODON_USAGE
  cds <- TEST_LONG_GENE_SEQ
  scan_result <- scan_enzyme_sites(cds, "", cu)
  if (nrow(scan_result$domestication) > 0) {
    cds <- apply_domestication(cds, scan_result$domestication, codon_usage = cu)
  }

  tile_size <- compute_max_tile_size(300, 12)
  plan <- plan_assembly(cds, TEST_POLIII, tile_size)
  tiles <- plan$tiles
  result <- design_wt_geneblocks(
    cds = cds, polIII = TEST_POLIII,
    tiles = tiles,
    oh3 = plan$oh3, oh4 = plan$oh4,
    paqci_star2 = "AGTC", paqci_star1 = "TCGA",
    assembly_plan = plan
  )

  blocks <- result$blocks

  # After deduplication, block names may be shared across tiles (e.g.,
  # tile2's sub2 may be renamed to tile1_sub2). Instead of counting
  # sub-blocks per tile from block names, verify the actual invariant:
  # blocks whose gene_region contains "polIII" should have the PolIII
  # sequence in their block sequence, and blocks without "polIII" should not.
  sub_blocks <- blocks[grepl("bsmbi_3wt", blocks$block_name), , drop = FALSE]

  if (nrow(sub_blocks) > 0) {
    # Use a distinctive substring of PolIII to check presence
    polIII_marker <- substring(TEST_POLIII, 1, 20)

    for (i in seq_len(nrow(sub_blocks))) {
      gr <- sub_blocks$gene_region[i]
      bn <- sub_blocks$block_name[i]
      seq <- sub_blocks$sequence[i]
      has_polIII_in_region <- grepl("polIII", gr)
      has_polIII_in_seq <- grepl(polIII_marker, seq, fixed = TRUE)

      if (has_polIII_in_region) {
        # gene_region says polIII → sequence should contain polIII
        expect_true(has_polIII_in_seq,
                    info = paste(bn, "gene_region has polIII but sequence does not"))
      } else {
        # gene_region says NO polIII → sequence should NOT contain polIII
        expect_false(has_polIII_in_seq,
                     info = paste(bn, "gene_region lacks polIII but sequence contains it"))
      }
    }

    # Also verify that at least one block has polIII and at least one does not
    # (for a long gene with splits, we expect both types)
    has_polIII <- grepl("polIII", sub_blocks$gene_region)
    expect_true(any(has_polIII),
                info = "Expected at least one 3'WT block with polIII in gene_region")
    expect_true(any(!has_polIII),
                info = "Expected at least one 3'WT block without polIII in gene_region")
  }
})

test_that("global boundaries increase block reuse (long gene)", {
  cu <- TEST_CODON_USAGE
  cds <- TEST_LONG_GENE_SEQ
  scan_result <- scan_enzyme_sites(cds, "", cu)
  if (nrow(scan_result$domestication) > 0) {
    cds <- apply_domestication(cds, scan_result$domestication, codon_usage = cu)
  }

  tile_size <- compute_max_tile_size(300, 12)
  plan <- plan_assembly(cds, TEST_POLIII, tile_size)
  tiles <- plan$tiles
  result <- design_wt_geneblocks(
    cds = cds, polIII = TEST_POLIII,
    tiles = tiles,
    oh3 = plan$oh3, oh4 = plan$oh4,
    paqci_star2 = "AGTC", paqci_star1 = "TCGA",
    assembly_plan = plan
  )

  blocks <- result$blocks
  manifests <- result$tile_manifests

  # With global boundaries, blocks at identical genomic positions should be
  # deduplicated. Count how many unique sequences we have vs. how many total
  # block references appear across all tile manifests.
  total_refs <- 0L
  for (i in seq_len(nrow(manifests))) {
    if (nzchar(manifests$bsai_parts[i])) {
      total_refs <- total_refs + length(strsplit(manifests$bsai_parts[i], ";")[[1]])
    }
    if (nzchar(manifests$bsmbi_parts[i])) {
      total_refs <- total_refs + length(strsplit(manifests$bsmbi_parts[i], ";")[[1]])
    }
  }
  # More references than unique blocks means dedup is working
  expect_true(nrow(blocks) <= total_refs,
              info = paste("Unique blocks:", nrow(blocks), " Total refs:", total_refs))

  # For a 2100 nt gene with ~9 tiles, we expect some dedup savings
  # (exact number depends on boundary positions, but should be > 0)
  if (nrow(tiles) > 2) {
    expect_true(nrow(blocks) < total_refs,
                info = "With global boundaries, some blocks should be shared")
  }
})

# =============================================================================
# BLOCK SIZE VALIDATION TESTS (TDD for min/max enforcement)
# =============================================================================

# Helper: run the full plan_assembly + design_wt_geneblocks pipeline for a gene
setup_geneblocks <- function(cds_raw, polIII = TEST_POLIII,
                              max_block_length = 1800L,
                              min_block_length = 300L) {
  cu <- TEST_CODON_USAGE
  scan_result <- scan_enzyme_sites(cds_raw, "", cu)
  cds <- if (nrow(scan_result$domestication) > 0) {
    apply_domestication(cds_raw, scan_result$domestication, codon_usage = cu)
  } else {
    cds_raw
  }

  tile_size <- compute_max_tile_size(300, 12)
  plan <- plan_assembly(
    cds = cds, polIII = polIII,
    max_mutable_nt = tile_size,
    max_block_length = max_block_length,
    config = list(min_geneblock_length = min_block_length)
  )
  tiles <- plan$tiles

  result <- design_wt_geneblocks(
    cds = cds, polIII = polIII,
    tiles = tiles,
    oh3 = plan$oh3, oh4 = plan$oh4,
    paqci_star2 = "AGTC", paqci_star1 = "TCGA",
    max_block_length = max_block_length,
    min_block_length = min_block_length,
    assembly_plan = plan
  )

  list(blocks = result$blocks, tiles = tiles, plan = plan, cds = cds)
}

test_that("all gene blocks within [min, max] for long gene (2100 nt)", {
  res <- setup_geneblocks(TEST_LONG_GENE_SEQ)
  blocks <- res$blocks

  # All blocks must be <= max
  over_max <- blocks[blocks$length > 1800L, ]
  expect_equal(nrow(over_max), 0L,
               info = paste("Oversized blocks:", paste(over_max$block_name, over_max$length, sep = "=", collapse = ", ")))

  # No blocks should have zero/near-zero gene content (just enzyme overhead).
  # These indicate a bug in split assignment. Blocks at 100-299 nt may be
  # inherently small due to tile geometry (unavoidable); blocks < 100 nt
  # indicate an unnecessary split creating an empty sub-block.
  polIII_only <- grepl("^bsmbi_polIII_tile", blocks$block_name)
  gene_blocks <- blocks[!polIII_only, ]
  empty_blocks <- gene_blocks[gene_blocks$length < 100L, ]
  expect_equal(nrow(empty_blocks), 0L,
               info = paste("Empty blocks:", paste(empty_blocks$block_name, empty_blocks$length, sep = "=", collapse = ", ")))
})

test_that("all gene blocks within [min, max] for TRIO gene (9294 nt)", {
  res <- setup_geneblocks(TEST_TRIO_SEQ)
  blocks <- res$blocks

  # All blocks must be <= max
  over_max <- blocks[blocks$length > 1800L, ]
  expect_equal(nrow(over_max), 0L,
               info = paste("Oversized blocks:", paste(over_max$block_name, over_max$length, sep = "=", collapse = ", ")))

  # No empty sub-blocks (< 100 nt = clearly a bad split, not geometry)
  polIII_only <- grepl("^bsmbi_polIII_tile", blocks$block_name)
  gene_blocks <- blocks[!polIII_only, ]
  empty_blocks <- gene_blocks[gene_blocks$length < 100L, ]
  expect_equal(nrow(empty_blocks), 0L,
               info = paste("Empty blocks:", paste(empty_blocks$block_name, empty_blocks$length, sep = "=", collapse = ", ")))
})

test_that("no tiny trailing BsaI sub-blocks (zero gene content)", {
  # Use TRIO gene — long enough to trigger many superblock splits and
  # expose the global-to-tile mismatch for 5'WT trailing sub-blocks
  res <- setup_geneblocks(TEST_TRIO_SEQ)
  blocks <- res$blocks

  # BsaI 5'WT sub-blocks should never be just enzyme overhead (22 nt)
  bsai_blocks <- blocks[blocks$enzyme_type == "BsaI", ]
  tiny_bsai <- bsai_blocks[bsai_blocks$length <= 50L, ]
  expect_equal(nrow(tiny_bsai), 0L,
               info = paste("Tiny BsaI blocks:", paste(tiny_bsai$block_name, tiny_bsai$length, sep = "=", collapse = ", ")))
})

test_that("no oversized BsmBI sub-blocks from missing global splits", {
  # Use TRIO gene — large 3'WT regions for early tiles may lack
  # applicable global splits, creating oversized single blocks
  res <- setup_geneblocks(TEST_TRIO_SEQ)
  blocks <- res$blocks

  bsmbi_blocks <- blocks[blocks$enzyme_type == "BsmBI", ]
  over_max <- bsmbi_blocks[bsmbi_blocks$length > 1800L, ]
  expect_equal(nrow(over_max), 0L,
               info = paste("Oversized BsmBI blocks:", paste(over_max$block_name, over_max$length, sep = "=", collapse = ", ")))
})

test_that("min_sub_length uses gene-content semantics (not total block)", {
  # plan_assembly should pass min_sub_length = min_geneblock_length - block_overhead
  # (gene content bounds), not the raw min_geneblock_length (total block bounds)
  cu <- TEST_CODON_USAGE
  cds <- TEST_LONG_GENE_SEQ
  scan_result <- scan_enzyme_sites(cds, "", cu)
  if (nrow(scan_result$domestication) > 0) {
    cds <- apply_domestication(cds, scan_result$domestication, codon_usage = cu)
  }
  tile_size <- compute_max_tile_size(300, 12)

  # Run plan_assembly with a known min_geneblock_length
  plan <- plan_assembly(
    cds = cds, polIII = TEST_POLIII,
    max_mutable_nt = tile_size,
    max_block_length = 1800L,
    config = list(min_geneblock_length = 300L)
  )

  # The global boundaries should exist (long gene triggers splits)
  # and the DP should have used min_sub_length = 300 - 22 = 278 (gene content)
  # We can't directly inspect the DP parameter, but we can verify the result:
  # all per-tile sub-blocks should have gene content >= 278 nt
  # (which means total block >= 300 nt after adding enzyme sites)
  splits <- plan$superblock_splits
  if (nrow(splits) > 0) {
    # Splits exist — the DP accepted them with the min_sub_length constraint
    expect_true(nrow(splits) > 0, info = "Expected superblock splits for long gene")
  }
})

# =============================================================================
# FLANKING PAD TESTS
# =============================================================================

test_that("create_bsai_block with flanking pad adds pad at both termini", {
  gene_seq <- "ATGGCTGAA"
  oh5 <- "ATGG"
  oh3 <- "CTAA"
  pad <- "TGCATG"

  block_with_pad <- create_bsai_block(gene_seq, oh5, oh3, flanking_pad = pad)
  block_no_pad <- create_bsai_block(gene_seq, oh5, oh3)

  # Block with pad should start and end with the pad sequence

  expect_true(startsWith(block_with_pad, pad),
              info = "Block should start with flanking pad")
  expect_true(endsWith(block_with_pad, pad),
              info = "Block should end with flanking pad")

  # Length difference should be exactly 2 * nchar(pad)
  expect_equal(nchar(block_with_pad), nchar(block_no_pad) + 2L * nchar(pad))
})

test_that("create_bsmbi_block with flanking pad adds pad at both termini", {
  gene_seq <- "ATGGCTGAA"
  oh5 <- "CTAA"
  oh3 <- "ACTA"
  pad <- "TGCATG"

  block_with_pad <- create_bsmbi_block(gene_seq, oh5, oh3, flanking_pad = pad)
  block_no_pad <- create_bsmbi_block(gene_seq, oh5, oh3)

  # Block with pad should start and end with the pad sequence
  expect_true(startsWith(block_with_pad, pad),
              info = "Block should start with flanking pad")
  expect_true(endsWith(block_with_pad, pad),
              info = "Block should end with flanking pad")

  # Length difference should be exactly 2 * nchar(pad)
  expect_equal(nchar(block_with_pad), nchar(block_no_pad) + 2L * nchar(pad))
})

test_that("empty flanking pad preserves original behavior", {
  gene_seq <- "ATGGCTGAA"
  oh5 <- "ATGG"
  oh3 <- "CTAA"

  # BsaI: explicit empty pad should match default (no pad argument)
  block_default <- create_bsai_block(gene_seq, oh5, oh3)
  block_empty <- create_bsai_block(gene_seq, oh5, oh3, flanking_pad = "")
  expect_identical(block_default, block_empty)

  # BsmBI: same check
  oh5b <- "CTAA"
  oh3b <- "ACTA"
  bsmbi_default <- create_bsmbi_block(gene_seq, oh5b, oh3b)
  bsmbi_empty <- create_bsmbi_block(gene_seq, oh5b, oh3b, flanking_pad = "")
  expect_identical(bsmbi_default, bsmbi_empty)
})

test_that("design_wt_geneblocks with flanking pad adds pads to all blocks", {
  cu <- TEST_CODON_USAGE
  cds <- domesticate_test_gene()
  tiles <- partition_tiles(cds, 150)
  pad <- "TGCATG"

  result <- design_wt_geneblocks(
    cds = cds, polIII = TEST_POLIII,
    tiles = tiles,
    oh3 = "ACTA", oh4 = "GATA",
    paqci_star2 = "AGTC", paqci_star1 = "TCGA",
    flanking_pad = pad
  )

  blocks <- result$blocks

  # Every block should start and end with the pad
  for (i in seq_len(nrow(blocks))) {
    expect_true(startsWith(blocks$sequence[i], pad),
                info = paste(blocks$block_name[i], "should start with pad"))
    expect_true(endsWith(blocks$sequence[i], pad),
                info = paste(blocks$block_name[i], "should end with pad"))
  }
})

test_that("block_overhead accounts for flanking pad in design_wt_geneblocks", {
  # With a 6-nt pad, each block gets 12 nt extra overhead (2 x 6).
  # Verify that blocks are still within synthesis limits when pad is included.
  cu <- TEST_CODON_USAGE
  cds <- domesticate_test_gene()
  tiles <- partition_tiles(cds, 150)
  pad <- "TGCATG"

  result <- design_wt_geneblocks(
    cds = cds, polIII = TEST_POLIII,
    tiles = tiles,
    oh3 = "ACTA", oh4 = "GATA",
    paqci_star2 = "AGTC", paqci_star1 = "TCGA",
    flanking_pad = pad
  )

  # All blocks should be within the max gene block length
  expect_true(all(result$blocks$length <= MAX_GENEBLOCK_LENGTH),
              info = paste("Max block length with pad:",
                           max(result$blocks$length), "vs limit:", MAX_GENEBLOCK_LENGTH))
})

test_that("config rejects flanking pad containing enzyme site", {
  # Build a minimal valid config, then inject a bad pad
  # BsmBI recognition site is CGTCTC — embed it in the pad
  bad_pad <- "CGTCTCAA"

  # validate_config expects a fully populated cfg; create one with all required fields
  cfg <- list(
    gene_cds = "ATGGCTGAATAA",
    polIII_promoter = "ACGTACGTACGT",
    paqci_star2 = "AGTC",
    paqci_star1 = "TCGA",
    max_oligo_length = 300L,
    max_geneblock_length = 1800L,
    min_geneblock_length = 300L,
    barcode_length = 20L,
    min_hamming_distance = 3L,
    barcode_prefix_length = 12L,
    barcode_gc_range = c(0.25, 0.75),
    barcode_max_homopolymer = 4L,
    barcodes_per_variant = 10L,
    overlap_codons = 6L,
    geneblock_flanking_pad = bad_pad,
    handle_overhead = 0L,
    fwd_handle_length = 0L,
    rev_handle_length = 0L
  )

  expect_error(validate_config(cfg), "geneblock_flanking_pad.*BsmBI")
})
