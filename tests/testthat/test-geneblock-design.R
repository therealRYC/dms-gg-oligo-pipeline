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
