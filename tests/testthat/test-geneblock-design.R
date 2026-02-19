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
  cu <- builtin_human_codon_usage()
  scan_result <- scan_enzyme_sites(TEST_GENE_SEQ, "", cu)
  cds <- if (nrow(scan_result$domestication) > 0) {
    apply_domestication(TEST_GENE_SEQ, scan_result$domestication, codon_usage = cu)
  } else {
    TEST_GENE_SEQ
  }

  tiles <- partition_tiles(cds, 150)
  tile_ohs <- extract_tile_overhangs(tiles)
  oh3 <- "ACTA"
  oh4 <- "GATA"

  result <- design_wt_geneblocks(
    cds = cds, polIII = TEST_POLIII,
    tiles = tiles, tile_overhangs = tile_ohs,
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
  cu <- builtin_human_codon_usage()
  scan_result <- scan_enzyme_sites(TEST_GENE_SEQ, "", cu)
  cds <- if (nrow(scan_result$domestication) > 0) {
    apply_domestication(TEST_GENE_SEQ, scan_result$domestication, codon_usage = cu)
  } else {
    TEST_GENE_SEQ
  }

  tiles <- partition_tiles(cds, 150)
  tile_ohs <- extract_tile_overhangs(tiles)

  result <- design_wt_geneblocks(
    cds = cds, polIII = TEST_POLIII,
    tiles = tiles, tile_overhangs = tile_ohs,
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
  cu <- builtin_human_codon_usage()
  cds <- TEST_LONG_GENE_SEQ
  scan_result <- scan_enzyme_sites(cds, "", cu)
  if (nrow(scan_result$domestication) > 0) {
    cds <- apply_domestication(cds, scan_result$domestication, codon_usage = cu)
  }

  tile_size <- compute_max_tile_size(300, 12)
  plan <- plan_assembly(cds, TEST_POLIII, tile_size)
  tiles <- plan$tiles
  tile_ohs <- extract_tile_overhangs(tiles)

  result <- design_wt_geneblocks(
    cds = cds, polIII = TEST_POLIII,
    tiles = tiles, tile_overhangs = tile_ohs,
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
  cu <- builtin_human_codon_usage()
  cds <- TEST_LONG_GENE_SEQ
  scan_result <- scan_enzyme_sites(cds, "", cu)
  if (nrow(scan_result$domestication) > 0) {
    cds <- apply_domestication(cds, scan_result$domestication, codon_usage = cu)
  }

  tile_size <- compute_max_tile_size(300, 12)
  plan <- plan_assembly(cds, TEST_POLIII, tile_size)
  tiles <- plan$tiles
  tile_ohs <- extract_tile_overhangs(tiles)

  result <- design_wt_geneblocks(
    cds = cds, polIII = TEST_POLIII,
    tiles = tiles, tile_overhangs = tile_ohs,
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
