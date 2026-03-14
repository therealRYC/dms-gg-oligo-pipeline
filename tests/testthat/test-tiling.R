# test-tiling.R — Tests for 05_tiling.R (3-enzyme architecture)

test_that("compute_max_tile_size returns correct value for 3-enzyme overhead", {
  # Overhead: BsaI_5'(7) + oh1(4) + BsmBI_oh2(11) + BsmBI_oh3(11) + barcode(12) + BsaI_oh4(11) = 56
  # 300 - 56 = 244. 244/3 = 81.33 → floor to 81 codons = 243 nt
  tile_size <- compute_max_tile_size(300, 12)
  expect_equal(tile_size %% 3, 0)
  expect_equal(tile_size, 243)  # 81 codons
})

test_that("compute_max_tile_size returns positive multiple of 3", {
  tile_size <- compute_max_tile_size(300, 12)
  expect_true(tile_size > 0)
  expect_equal(tile_size %% 3, 0)
  expect_true(tile_size <= 300)
})

test_that("partition_tiles covers entire gene with overlap", {
  # Domesticate test gene first
  cu <- builtin_human_codon_usage()
  scan_result <- scan_enzyme_sites(TEST_GENE_SEQ, "", cu)
  cds <- if (nrow(scan_result$domestication) > 0) {
    apply_domestication(TEST_GENE_SEQ, scan_result$domestication, codon_usage = cu)
  } else {
    TEST_GENE_SEQ
  }

  tile_size <- compute_max_tile_size(300, 12)
  tiles <- partition_tiles(cds, tile_size)

  # First tile starts at nt 1
  expect_equal(tiles$start_nt[1], 1)
  # Last tile ends at gene length
  expect_equal(tiles$end_nt[nrow(tiles)], nchar(cds))
  # Adjacent tiles overlap (with default overlap_codons=6, tiles share boundary codons)
  for (i in seq_len(nrow(tiles) - 1)) {
    # Next tile starts before or at current tile's end (overlap region)
    expect_true(tiles$start_nt[i + 1] <= tiles$end_nt[i],
                info = paste("Tiles", i, "and", i + 1, "should overlap"))
  }
  # Every nt is covered by at least one tile
  covered <- rep(FALSE, nchar(cds))
  for (i in seq_len(nrow(tiles))) {
    covered[tiles$start_nt[i]:tiles$end_nt[i]] <- TRUE
  }
  expect_true(all(covered))
})

test_that("partition_tiles includes oh1 and oh2 sequences", {
  cds <- TEST_GENE_SEQ
  tiles <- partition_tiles(cds, 150)

  # oh1 and oh2 should be 4-nt sequences
  for (i in seq_len(nrow(tiles))) {
    expect_equal(nchar(tiles$oh1_seq[i]), 4)
    expect_equal(nchar(tiles$oh2_seq[i]), 4)
  }

  # oh1 should be the first 4 nt of the tile region
  expect_equal(tiles$oh1_seq[1], substring(cds, 1, 4))

  # oh2 should be the last 4 nt of the tile region
  for (i in seq_len(nrow(tiles))) {
    expected_oh2 <- substring(cds, tiles$end_nt[i] - 3, tiles$end_nt[i])
    expect_equal(tiles$oh2_seq[i], expected_oh2)
  }
})

test_that("partition_tiles handles single-tile gene", {
  tiles_single <- partition_tiles("ATGGCTTAA", 300)
  expect_equal(nrow(tiles_single), 1)
  expect_equal(tiles_single$start_codon[1], 1)
  expect_equal(tiles_single$end_codon[1], 3)
})

test_that("assign_variants_to_tiles assigns all variants", {
  cds <- "ATGGCTGAATAA"
  cu <- builtin_human_codon_usage()
  variants <- design_mutations(cds, cu)
  tiles <- partition_tiles(cds, 300)
  variants <- assign_variants_to_tiles(variants, tiles)

  expect_false(any(is.na(variants$tile_id)))
})

test_that("partition_tiles covers long gene completely with overlap", {
  cds <- TEST_LONG_GENE_SEQ
  tile_size <- compute_max_tile_size(300, 12)
  tiles <- partition_tiles(cds, tile_size)

  # First tile starts at nt 1
  expect_equal(tiles$start_nt[1], 1)
  # Last tile ends at gene length
  expect_equal(tiles$end_nt[nrow(tiles)], nchar(cds))
  # Adjacent tiles overlap
  for (i in seq_len(nrow(tiles) - 1)) {
    expect_true(tiles$start_nt[i + 1] <= tiles$end_nt[i],
                info = paste("Tiles", i, "and", i + 1, "should overlap"))
  }
  # Every nt is covered
  covered <- rep(FALSE, nchar(cds))
  for (i in seq_len(nrow(tiles))) {
    covered[tiles$start_nt[i]:tiles$end_nt[i]] <- TRUE
  }
  expect_true(all(covered))
  # Should have multiple tiles (2100 nt / 75 effective codons per step ~ 10 tiles)
  expect_true(nrow(tiles) >= 8)
})

test_that("clearance scoring produces symmetric N/2 split of overlap codons", {
  # Create a gene long enough for 2 tiles with 6-codon overlap.
  # With mutable_size = 30 nt (10 codons) and overlap_codons = 6:
  #   Tile 1: codons 1-10 (nt 1-30)
  #   Tile 2: codons 5-14 (nt 13-42)
  #   Overlap: codons 5-10 (6 codons)
  #
  # For each overlap codon, clearance in each tile:
  #   Codon 5: tile1 local_start=13, tile2 local_start=1
  #     tile1: dist_oh1=13-4=9, dist_oh2=(30-4)-15=11 → clearance=9

  #     tile2: dist_oh1=1-4=-3, dist_oh2=(30-4)-3=23 → clearance=-3
  #     → tile1 (clearance 9 > -3)
  #   Codon 6: tile1: oh1=16-4=12, oh2=26-18=8 → 8
  #     tile2: oh1=4-4=0, oh2=26-6=20 → 0 → tile1
  #   Codon 7: tile1: oh1=19-4=15, oh2=26-21=5 → 5
  #     tile2: oh1=7-4=3, oh2=26-9=17 → 3 → tile1
  #   Codon 8: tile1: oh1=22-4=18, oh2=26-24=2 → 2
  #     tile2: oh1=10-4=6, oh2=26-12=14 → 6 → tile2
  #   Codon 9: tile1: oh1=25-4=21, oh2=26-27=-1 → -1
  #     tile2: oh1=13-4=9, oh2=26-15=11 → 9 → tile2
  #   Codon 10: tile1: oh1=28-4=24, oh2=26-30=-4 → -4
  #     tile2: oh1=16-4=12, oh2=26-18=8 → 8 → tile2
  #
  # Result: codons 5,6,7 → tile1; codons 8,9,10 → tile2 (3/3 split)

  # Build a 42-nt CDS (14 codons): ATG + 12 Ala + stop
  cds <- paste0("ATG", paste0(rep("GCT", 12), collapse = ""), "TAA")
  expect_equal(nchar(cds), 42)

  cu <- builtin_human_codon_usage()
  variants <- design_mutations(cds, cu)

  # partition with 10-codon tiles and 6-codon overlap
  tiles <- partition_tiles(cds, 30L, overlap_codons = 6L)
  expect_equal(nrow(tiles), 2)

  # Assign variants to tiles
  variants <- assign_variants_to_tiles(variants, tiles)

  # Check the overlap codons (5-10) — should split 3/3
  overlap_positions <- 5:10
  for (pos in overlap_positions) {
    assigned_tile <- unique(variants$tile_id[variants$position == pos])
    if (pos <= 7) {
      expect_equal(assigned_tile, 1L,
        info = paste("Overlap codon", pos, "should go to tile 1 (higher clearance)")
      )
    } else {
      expect_equal(assigned_tile, 2L,
        info = paste("Overlap codon", pos, "should go to tile 2 (higher clearance)")
      )
    }
  }
})

test_that("overlap_codons must be even", {
  tmp_config <- tempfile(fileext = ".yaml")
  config_lines <- c(
    'gene_cds: "ATGGCTGAATAA"',
    paste0("polIII_promoter: \"", TEST_POLIII, "\""),
    "paqci_star2: AGTC",
    "paqci_star1: TCGA",
    "overlap_codons: 5"
  )
  writeLines(config_lines, tmp_config)

  expect_error(load_config(tmp_config), "overlap_codons must be even")

  unlink(tmp_config)
})

test_that("overlap_codons must be >= 2", {
  tmp_config <- tempfile(fileext = ".yaml")
  config_lines <- c(
    'gene_cds: "ATGGCTGAATAA"',
    paste0("polIII_promoter: \"", TEST_POLIII, "\""),
    "paqci_star2: AGTC",
    "paqci_star1: TCGA",
    "overlap_codons: 1"
  )
  writeLines(config_lines, tmp_config)

  # Should fail both checks: < 2 and odd
  expect_error(load_config(tmp_config), "overlap_codons must be >= 2")

  unlink(tmp_config)
})
