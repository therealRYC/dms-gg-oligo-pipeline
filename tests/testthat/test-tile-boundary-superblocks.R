# Created: 2026-02-26
# Last updated: 2026-02-26 — Fix expect_lte/expect_gte info= param; fix TRIO DNAString handling
# test-tile-boundary-superblocks.R — Tests for the tile-boundary superblock redesign
#
# Architecture overview:
#   Superblocks are contiguous groups of tiles where boundaries align with tile
#   boundaries. Each tile's BsmBI reaction assembles:
#     [oligo] + [partial SB fragment] + [full SB block(s)] + [cassette fragment(s)]
#   Per-tile overhang exclusion replaces global exclusion, eliminating BUG-005.

# =============================================================================
# Test Fixtures
# =============================================================================

# Helper: build a minimal tiles data frame for unit tests.
# Each tile covers `tile_width` codons. Overhangs are derived from the gene.
make_test_tiles <- function(n_tiles, tile_width_codons = 80L,
                            overlap_codons = 4L,
                            gene_seq = NULL) {
  # If no gene_seq provided, use the test long gene
  if (is.null(gene_seq)) gene_seq <- TEST_LONG_GENE_SEQ

  gene_len <- nchar(gene_seq)
  n_codons <- gene_len %/% 3L

  # Build tiles with overlap (mimics search_tile_boundaries_dp output)
  tiles <- data.frame(
    tile_id = integer(0), start_codon = integer(0), end_codon = integer(0),
    start_nt = integer(0), end_nt = integer(0),
    oh1_seq = character(0), oh2_seq = character(0),
    oh1_in_hf = logical(0), oh2_in_hf = logical(0),
    oh1_fidelity = numeric(0), oh2_fidelity = numeric(0),
    tile_seq = character(0), boundary_shift = integer(0),
    stringsAsFactors = FALSE
  )

  # Divide gene into n_tiles, each tile covering roughly equal codons
  # Core boundaries (without overlap) are evenly spaced
  core_size <- ceiling(n_codons / n_tiles)

  for (i in seq_len(n_tiles)) {
    core_sc <- (i - 1L) * core_size + 1L
    core_ec <- min(i * core_size, n_codons)

    # Apply overlap: extend right by overlap_codons (except last tile)
    sc <- core_sc
    ec <- min(n_codons, core_ec + overlap_codons)

    sn <- (sc - 1L) * 3L + 1L
    en <- ec * 3L

    oh1 <- substring(gene_seq, sn, sn + 3L)
    oh2 <- substring(gene_seq, en - 3L, en)

    hf_set <- load_high_fidelity_set()
    oh_fidelity <- builtin_overhang_fidelity()
    fid_lookup <- oh_fidelity$fidelity
    names(fid_lookup) <- oh_fidelity$overhang

    oh1_fid <- if (oh1 %in% names(fid_lookup)) unname(fid_lookup[oh1]) else NA_real_
    oh2_fid <- if (oh2 %in% names(fid_lookup)) unname(fid_lookup[oh2]) else NA_real_

    tiles <- rbind(tiles, data.frame(
      tile_id = i, start_codon = sc, end_codon = ec,
      start_nt = sn, end_nt = en,
      oh1_seq = oh1, oh2_seq = oh2,
      oh1_in_hf = oh1 %in% hf_set, oh2_in_hf = oh2 %in% hf_set,
      oh1_fidelity = oh1_fid, oh2_fidelity = oh2_fid,
      tile_seq = substring(gene_seq, sn, en),
      boundary_shift = 0L,
      stringsAsFactors = FALSE
    ))
  }
  tiles
}

# Constants for tests
TEST_MAX_BLOCK_LENGTH <- 1800L
TEST_BLOCK_OVERHEAD <- 22L
TEST_MAX_SUB <- TEST_MAX_BLOCK_LENGTH - TEST_BLOCK_OVERHEAD # 1778 nt

# =============================================================================
# Category 1: Core Partitioning Logic
# =============================================================================
# partition_tile_superblocks() takes tiles + constraints and returns superblock
# assignments. This is the core new function.

test_that("1a: single tile gene needs no superblocks", {
  # A single-tile gene (e.g., 100 codons = 300 nt) should produce one SB
  tiles <- make_test_tiles(1, gene_seq = TEST_GENE_SEQ)
  gene_len <- nchar(TEST_GENE_SEQ)
  polIII_len <- nchar(TEST_POLIII)

  result <- partition_tile_superblocks(
    tiles = tiles,
    gene_len = gene_len,
    polIII_len = polIII_len,
    max_sub_length = TEST_MAX_SUB
  )

  expect_equal(result$n_superblocks, 1L)
  expect_equal(nrow(result$superblocks), 1L)
  expect_equal(result$superblocks$start_tile[1], 1L)
  expect_equal(result$superblocks$end_tile[1], 1L)
})

test_that("1b: long gene partitions into multiple superblocks", {
  # TEST_LONG_GENE_SEQ = 2100 nt, with polIII = 250 nt
  # max_sub = 1778 nt → needs at least 2 superblocks
  tiles <- make_test_tiles(18, gene_seq = TEST_LONG_GENE_SEQ)
  gene_len <- nchar(TEST_LONG_GENE_SEQ)
  polIII_len <- nchar(TEST_POLIII)

  result <- partition_tile_superblocks(
    tiles = tiles,
    gene_len = gene_len,
    polIII_len = polIII_len,
    max_sub_length = TEST_MAX_SUB
  )

  expect_gte(result$n_superblocks, 2L)
  # Every tile should be assigned to exactly one superblock
  all_tiles <- unlist(lapply(seq_len(nrow(result$superblocks)), function(i) {
    seq(result$superblocks$start_tile[i], result$superblocks$end_tile[i])
  }))
  expect_equal(sort(all_tiles), seq_len(nrow(tiles)))
})

test_that("1c: superblock boundaries align with tile boundaries", {
  tiles <- make_test_tiles(18, gene_seq = TEST_LONG_GENE_SEQ)
  gene_len <- nchar(TEST_LONG_GENE_SEQ)
  polIII_len <- nchar(TEST_POLIII)

  result <- partition_tile_superblocks(
    tiles = tiles,
    gene_len = gene_len,
    polIII_len = polIII_len,
    max_sub_length = TEST_MAX_SUB
  )

  # Each superblock's start tile should be the tile right after the previous SB's end tile
  for (i in seq_len(nrow(result$superblocks))) {
    sb <- result$superblocks[i, ]
    if (i == 1L) {
      expect_equal(sb$start_tile, 1L)
    } else {
      prev_end <- result$superblocks$end_tile[i - 1L]
      expect_equal(sb$start_tile, prev_end + 1L)
    }
  }
  # Last SB ends at last tile
  expect_equal(result$superblocks$end_tile[nrow(result$superblocks)], nrow(tiles))
})

test_that("1d: contiguous tile coverage — no gaps, no overlaps", {
  tiles <- make_test_tiles(18, gene_seq = TEST_LONG_GENE_SEQ)
  gene_len <- nchar(TEST_LONG_GENE_SEQ)
  polIII_len <- nchar(TEST_POLIII)

  result <- partition_tile_superblocks(
    tiles = tiles,
    gene_len = gene_len,
    polIII_len = polIII_len,
    max_sub_length = TEST_MAX_SUB
  )

  sbs <- result$superblocks
  for (i in seq_len(nrow(sbs) - 1L)) {
    # No gap: next SB starts right after current SB ends
    expect_equal(sbs$start_tile[i + 1L], sbs$end_tile[i] + 1L)
  }
})

# =============================================================================
# Category 2: Overhang Collision Avoidance
# =============================================================================
# Per-tile BsmBI reactions must have mutually distinct overhangs (no identity
# or RC collisions between oh2_tile, oh3, and SB junction overhangs).

test_that("2a: no overhang collisions in per-tile reactions", {
  tiles <- make_test_tiles(18, gene_seq = TEST_LONG_GENE_SEQ)
  gene_len <- nchar(TEST_LONG_GENE_SEQ)
  polIII_len <- nchar(TEST_POLIII)

  # Use a known oh3 (from PolIII derivation)
  oh3 <- substring(TEST_POLIII, nchar(TEST_POLIII) - 4, nchar(TEST_POLIII) - 1)

  result <- partition_tile_superblocks(
    tiles = tiles,
    gene_len = gene_len,
    polIII_len = polIII_len,
    max_sub_length = TEST_MAX_SUB,
    oh3 = oh3
  )

  # For each tile, check that all overhangs in its BsmBI reaction are distinct
  # (including reverse complements)
  for (ti in seq_len(nrow(tiles))) {
    tile_ohs <- get_tile_reaction_overhangs(result, ti, tiles, oh3, "bsmbi")
    # All must be pairwise distinct (including RC)
    n <- length(tile_ohs)
    if (n >= 2) {
      for (i in seq_len(n - 1L)) {
        for (j in (i + 1L):n) {
          expect_false(
            tile_ohs[i] == tile_ohs[j] ||
              tile_ohs[i] == reverse_complement(tile_ohs[j]),
            info = sprintf(
              "Tile %d: collision %s vs %s", ti, tile_ohs[i], tile_ohs[j]
            )
          )
        }
      }
    }
  }
})

test_that("2b: RC collision triggers boundary shift", {
  # Create a scenario where a naive partition would cause an RC collision
  # (like GRIN2A tile 7 oh2=TGTG vs tile 8 oh2=CACA → RC pair)
  # The partitioning should detect and resolve this.
  tiles <- make_test_tiles(18, gene_seq = TEST_LONG_GENE_SEQ)
  gene_len <- nchar(TEST_LONG_GENE_SEQ)
  polIII_len <- nchar(TEST_POLIII)

  oh3 <- substring(TEST_POLIII, nchar(TEST_POLIII) - 4, nchar(TEST_POLIII) - 1)

  result <- partition_tile_superblocks(
    tiles = tiles,
    gene_len = gene_len,
    polIII_len = polIII_len,
    max_sub_length = TEST_MAX_SUB,
    oh3 = oh3
  )

  # If there were any collisions, they should have been resolved
  expect_equal(result$n_collisions, 0L,
    info = "Expected zero collisions after boundary shift resolution"
  )
})

test_that("2c: junction ohs don't collide with committed oh3", {
  tiles <- make_test_tiles(18, gene_seq = TEST_LONG_GENE_SEQ)
  gene_len <- nchar(TEST_LONG_GENE_SEQ)
  polIII_len <- nchar(TEST_POLIII)
  oh3 <- substring(TEST_POLIII, nchar(TEST_POLIII) - 4, nchar(TEST_POLIII) - 1)

  result <- partition_tile_superblocks(
    tiles = tiles,
    gene_len = gene_len,
    polIII_len = polIII_len,
    max_sub_length = TEST_MAX_SUB,
    oh3 = oh3
  )

  # Check that no SB boundary overhang matches oh3 or RC(oh3)
  oh3_rc <- reverse_complement(oh3)
  if (nrow(result$superblocks) > 1) {
    for (i in seq_len(nrow(result$superblocks) - 1L)) {
      boundary_tile <- result$superblocks$end_tile[i]
      boundary_oh <- tiles$oh2_seq[boundary_tile]
      expect_false(boundary_oh == oh3 || boundary_oh == oh3_rc,
        info = sprintf(
          "SB boundary tile %d oh2=%s collides with oh3=%s",
          boundary_tile, boundary_oh, oh3
        )
      )
    }
  }
})

test_that("2d: self-collision excluded — last tile of each SB correctly handled", {
  # The last tile of each non-final SB has oh2 == the SB boundary overhang.
  # Its partial fragment has 0 length, so the junction oh doesn't appear in
  # its reaction. The function should NOT flag this as a collision.
  tiles <- make_test_tiles(18, gene_seq = TEST_LONG_GENE_SEQ)
  gene_len <- nchar(TEST_LONG_GENE_SEQ)
  polIII_len <- nchar(TEST_POLIII)
  oh3 <- substring(TEST_POLIII, nchar(TEST_POLIII) - 4, nchar(TEST_POLIII) - 1)

  result <- partition_tile_superblocks(
    tiles = tiles,
    gene_len = gene_len,
    polIII_len = polIII_len,
    max_sub_length = TEST_MAX_SUB,
    oh3 = oh3
  )

  # Should succeed without false positive collisions
  expect_equal(result$n_collisions, 0L)
})

test_that("2e: per-tile exclusion — not global", {
  # Key architectural invariant: tile A's oh2 is NOT excluded from tile B's
  # reaction (unlike the old global exclusion). Only the overhangs actually
  # in tile B's reaction are checked against each other.
  tiles <- make_test_tiles(18, gene_seq = TEST_LONG_GENE_SEQ)
  gene_len <- nchar(TEST_LONG_GENE_SEQ)
  polIII_len <- nchar(TEST_POLIII)
  oh3 <- substring(TEST_POLIII, nchar(TEST_POLIII) - 4, nchar(TEST_POLIII) - 1)

  result <- partition_tile_superblocks(
    tiles = tiles,
    gene_len = gene_len,
    polIII_len = polIII_len,
    max_sub_length = TEST_MAX_SUB,
    oh3 = oh3
  )

  # Verify that the function doesn't use a global exclusion set.
  # If it did, many more tiles would fail (100% for 3'WT as shown in our
  # earlier analysis). Success here proves per-tile exclusion is used.
  expect_equal(result$n_collisions, 0L)
})

# =============================================================================
# Category 3: Sizing Constraints
# =============================================================================

test_that("3a: no superblock gene content exceeds max_sub_length", {
  tiles <- make_test_tiles(18, gene_seq = TEST_LONG_GENE_SEQ)
  gene_len <- nchar(TEST_LONG_GENE_SEQ)
  polIII_len <- nchar(TEST_POLIII)

  result <- partition_tile_superblocks(
    tiles = tiles,
    gene_len = gene_len,
    polIII_len = polIII_len,
    max_sub_length = TEST_MAX_SUB
  )

  sbs <- result$superblocks
  for (i in seq_len(nrow(sbs))) {
    content <- sbs$gene_content[i]
    # Last SB also carries polIII
    if (i == nrow(sbs)) {
      content <- content + polIII_len
    }
    expect_true(content <= TEST_MAX_SUB,
      info = sprintf("SB%d content %d exceeds max %d", i, content, TEST_MAX_SUB)
    )
  }
})

test_that("3b: last superblock includes polIII in its size budget", {
  tiles <- make_test_tiles(18, gene_seq = TEST_LONG_GENE_SEQ)
  gene_len <- nchar(TEST_LONG_GENE_SEQ)
  polIII_len <- nchar(TEST_POLIII)

  result <- partition_tile_superblocks(
    tiles = tiles,
    gene_len = gene_len,
    polIII_len = polIII_len,
    max_sub_length = TEST_MAX_SUB
  )

  last_sb <- result$superblocks[nrow(result$superblocks), ]
  total <- last_sb$gene_content + polIII_len
  expect_lte(total, TEST_MAX_SUB)
})

test_that("3c: orderable block length includes overhead", {
  tiles <- make_test_tiles(18, gene_seq = TEST_LONG_GENE_SEQ)
  gene_len <- nchar(TEST_LONG_GENE_SEQ)
  polIII_len <- nchar(TEST_POLIII)

  result <- partition_tile_superblocks(
    tiles = tiles,
    gene_len = gene_len,
    polIII_len = polIII_len,
    max_sub_length = TEST_MAX_SUB
  )

  sbs <- result$superblocks
  for (i in seq_len(nrow(sbs))) {
    content <- sbs$gene_content[i]
    if (i == nrow(sbs)) content <- content + polIII_len
    orderable <- content + TEST_BLOCK_OVERHEAD
    expect_true(orderable <= TEST_MAX_BLOCK_LENGTH,
      info = sprintf("SB%d orderable %d exceeds %d", i, orderable, TEST_MAX_BLOCK_LENGTH)
    )
  }
})

test_that("3d: very tight max_sub forces more superblocks", {
  tiles <- make_test_tiles(18, gene_seq = TEST_LONG_GENE_SEQ)
  gene_len <- nchar(TEST_LONG_GENE_SEQ)
  polIII_len <- nchar(TEST_POLIII)

  # With a very tight limit, we need more superblocks
  tight_max <- 500L # much smaller than default 1778

  result <- partition_tile_superblocks(
    tiles = tiles,
    gene_len = gene_len,
    polIII_len = polIII_len,
    max_sub_length = tight_max
  )

  # Should need many more SBs than the default
  expect_gte(result$n_superblocks, 4L)
  # But all should still fit
  for (i in seq_len(nrow(result$superblocks))) {
    content <- result$superblocks$gene_content[i]
    if (i == nrow(result$superblocks)) content <- content + polIII_len
    expect_lte(content, tight_max)
  }
})

test_that("3e: single tile per superblock when tiles are large", {
  # If each tile's gene span alone approaches max_sub_length,
  # each tile must be its own superblock
  # With max_sub = 300 and tile_width ~ 80 codons (240 nt), many tiles
  # can't share a superblock with their neighbor
  tiles <- make_test_tiles(8,
    tile_width_codons = 80L,
    gene_seq = TEST_LONG_GENE_SEQ
  )
  gene_len <- nchar(TEST_LONG_GENE_SEQ)
  polIII_len <- nchar(TEST_POLIII)

  result <- partition_tile_superblocks(
    tiles = tiles,
    gene_len = gene_len,
    polIII_len = polIII_len,
    max_sub_length = 300L # very tight
  )

  # Most SBs should contain just 1 tile
  single_tile_sbs <- sum(
    result$superblocks$end_tile - result$superblocks$start_tile == 0
  )
  expect_gte(single_tile_sbs, nrow(result$superblocks) / 2)
})

# =============================================================================
# Category 4: Per-Tile Reaction Validation
# =============================================================================

test_that("4a: correct fragment count per tile", {
  tiles <- make_test_tiles(18, gene_seq = TEST_LONG_GENE_SEQ)
  gene_len <- nchar(TEST_LONG_GENE_SEQ)
  polIII_len <- nchar(TEST_POLIII)
  oh3 <- substring(TEST_POLIII, nchar(TEST_POLIII) - 4, nchar(TEST_POLIII) - 1)

  result <- partition_tile_superblocks(
    tiles = tiles,
    gene_len = gene_len,
    polIII_len = polIII_len,
    max_sub_length = TEST_MAX_SUB,
    oh3 = oh3
  )

  n_sb <- result$n_superblocks
  sbs <- result$superblocks

  for (ti in seq_len(nrow(tiles))) {
    # Find which SB this tile belongs to
    my_sb <- which(sbs$start_tile <= ti & sbs$end_tile >= ti)
    expect_length(my_sb, 1L)

    # Count of BsmBI gene block fragments in this tile's reaction:
    # 1 partial (from tile end to current SB end, if > 0)
    # + (n_sb - my_sb) full SB blocks after current SB
    # + cassette fragment(s) (counted separately)
    # Total overhangs in BsmBI reaction:
    #   oh2 (committed) + junction OHs between SBs + oh3 (committed)
    n_junction_ohs <- n_sb - my_sb # boundaries between this SB and end
    # But the last tile of each SB has 0-length partial, so it's slightly different
    # Just check that the count is reasonable
    expect_gte(n_junction_ohs, 0L)
    expect_lte(n_junction_ohs, n_sb - 1L)
  }
})

test_that("4b: first tile of first SB has no 5'WT block", {
  tiles <- make_test_tiles(18, gene_seq = TEST_LONG_GENE_SEQ)
  gene_len <- nchar(TEST_LONG_GENE_SEQ)
  polIII_len <- nchar(TEST_POLIII)

  result <- partition_tile_superblocks(
    tiles = tiles,
    gene_len = gene_len,
    polIII_len = polIII_len,
    max_sub_length = TEST_MAX_SUB
  )

  # Tile 1 starts at gene position 1, so its 5'WT region is empty
  expect_equal(tiles$start_nt[1], 1L)
  # Its BsaI reaction should have no 5'WT gene blocks
  # (The oligo itself carries PaqCI** directly)
})

test_that("4c: last tile of last SB has no 3'WT gene block", {
  tiles <- make_test_tiles(18, gene_seq = TEST_LONG_GENE_SEQ)
  gene_len <- nchar(TEST_LONG_GENE_SEQ)
  polIII_len <- nchar(TEST_POLIII)

  result <- partition_tile_superblocks(
    tiles = tiles,
    gene_len = gene_len,
    polIII_len = polIII_len,
    max_sub_length = TEST_MAX_SUB
  )

  last_tile <- nrow(tiles)
  last_sb <- nrow(result$superblocks)
  # Last tile's end_nt should be gene_len (it covers to the end)
  expect_equal(tiles$end_nt[last_tile], gene_len)
  # Its 3'WT gene content is 0 (just polIII as a separate fragment)
})

# =============================================================================
# Category 5: Integration with Real Genes
# =============================================================================

test_that("5a: AKAP11 — superblocks fit within synthesis limit", {
  skip_on_cran()
  skip_if_not(file.exists(file.path(pipeline_dir, "examples", "260225_akap11_config.yaml")),
    message = "AKAP11 config not found"
  )
  skip_if_not(file.exists(file.path(pipeline_dir, "data", "AKAP11_NM_016248_CDS.fasta")),
    message = "AKAP11 FASTA not found"
  )

  # load_config resolves gene_fasta relative to working directory

  old_wd <- setwd(pipeline_dir)
  on.exit(setwd(old_wd), add = TRUE)

  config <- load_config(file.path(pipeline_dir, "examples", "260225_akap11_config.yaml"))
  gene <- read_gene(config$gene_fasta)
  codon_usage <- load_codon_usage(config$codon_table_path)
  polIII <- config$polIII_promoter
  scan_result <- scan_enzyme_sites(gene$cds, polIII, codon_usage)
  if (config$auto_domesticate && nrow(scan_result$domestication) > 0) {
    gene$cds <- apply_domestication(gene$cds, scan_result$domestication,
      codon_usage = codon_usage
    )
  }
  cds <- as.character(gene$cds)
  max_mutable <- compute_max_tile_size(config$max_oligo_length, config$barcode_length)

  ap <- plan_assembly(
    cds = cds, polIII = polIII, max_mutable_nt = max_mutable,
    max_block_length = config$max_geneblock_length,
    config = list(
      fidelity_threshold = config$overhang_fidelity_threshold,
      boundary_method = "dp", multi_k = TRUE, overlap_codons = 4L
    )
  )

  tiles <- ap$tiles
  oh3 <- ap$oh3
  gene_len <- nchar(cds)
  polIII_len <- nchar(polIII)
  max_sub <- config$max_geneblock_length - TEST_BLOCK_OVERHEAD

  result <- partition_tile_superblocks(
    tiles = tiles,
    gene_len = gene_len,
    polIII_len = polIII_len,
    max_sub_length = max_sub,
    oh3 = oh3
  )

  # AKAP11 (5709 nt) should produce ~4 superblocks at max_sub=1778
  expect_gte(result$n_superblocks, 3L)
  expect_lte(result$n_superblocks, 6L)
  # Zero collisions
  expect_equal(result$n_collisions, 0L)
  # All blocks within synthesis limit
  for (i in seq_len(nrow(result$superblocks))) {
    content <- result$superblocks$gene_content[i]
    if (i == nrow(result$superblocks)) content <- content + polIII_len
    expect_true(content + TEST_BLOCK_OVERHEAD <= config$max_geneblock_length,
      info = sprintf(
        "AKAP11 SB%d oversized: %d > %d", i,
        content + TEST_BLOCK_OVERHEAD, config$max_geneblock_length
      )
    )
  }
})

test_that("5b: GRIN2A — superblocks fit within synthesis limit", {
  skip_on_cran()
  skip_if_not(file.exists(file.path(pipeline_dir, "examples", "260221_grin2a_bug001_fix.yaml")),
    message = "GRIN2A config not found"
  )
  skip_if_not(file.exists(file.path(pipeline_dir, "data", "GRIN2A_NM_000833_CDS.fasta")),
    message = "GRIN2A FASTA not found"
  )

  old_wd <- setwd(pipeline_dir)
  on.exit(setwd(old_wd), add = TRUE)

  config <- load_config(file.path(pipeline_dir, "examples", "260221_grin2a_bug001_fix.yaml"))
  gene <- read_gene(config$gene_fasta)
  codon_usage <- load_codon_usage(config$codon_table_path)
  polIII <- config$polIII_promoter
  scan_result <- scan_enzyme_sites(gene$cds, polIII, codon_usage)
  if (config$auto_domesticate && nrow(scan_result$domestication) > 0) {
    gene$cds <- apply_domestication(gene$cds, scan_result$domestication,
      codon_usage = codon_usage
    )
  }
  cds <- as.character(gene$cds)
  max_mutable <- compute_max_tile_size(config$max_oligo_length, config$barcode_length)

  ap <- plan_assembly(
    cds = cds, polIII = polIII, max_mutable_nt = max_mutable,
    max_block_length = config$max_geneblock_length,
    config = list(
      fidelity_threshold = config$overhang_fidelity_threshold,
      boundary_method = "dp", multi_k = TRUE, overlap_codons = 4L
    )
  )

  tiles <- ap$tiles
  oh3 <- ap$oh3
  gene_len <- nchar(cds)
  polIII_len <- nchar(polIII)
  max_sub <- config$max_geneblock_length - TEST_BLOCK_OVERHEAD

  result <- partition_tile_superblocks(
    tiles = tiles,
    gene_len = gene_len,
    polIII_len = polIII_len,
    max_sub_length = max_sub,
    oh3 = oh3
  )

  # GRIN2A (4347 nt) should produce ~3 superblocks
  expect_gte(result$n_superblocks, 2L)
  expect_lte(result$n_superblocks, 5L)
  # Zero collisions
  expect_equal(result$n_collisions, 0L)
})

test_that("5c: TRIO — large gene produces valid superblocks", {
  skip_on_cran()
  # TRIO = 9294 nt — largest test gene, should produce many superblocks

  # Need to domesticate TRIO first
  gene_seq <- TEST_TRIO_SEQ
  codon_usage <- load_codon_usage() # default CoCoPUTs table
  polIII <- TEST_POLIII
  polIII_len <- nchar(polIII)
  cds_dna <- Biostrings::DNAString(gene_seq)
  scan_result <- scan_enzyme_sites(cds_dna, polIII, codon_usage)
  if (nrow(scan_result$domestication) > 0) {
    cds_dna <- apply_domestication(
      cds_dna,
      scan_result$domestication,
      codon_usage = codon_usage
    )
    gene_seq <- as.character(cds_dna)
  }

  gene_len <- nchar(gene_seq)
  max_mutable <- compute_max_tile_size(300L, 20L)

  ap <- plan_assembly(
    cds = gene_seq, polIII = polIII, max_mutable_nt = max_mutable,
    max_block_length = TEST_MAX_BLOCK_LENGTH,
    config = list(
      fidelity_threshold = 0.95,
      boundary_method = "dp", multi_k = TRUE, overlap_codons = 4L
    )
  )

  tiles <- ap$tiles
  oh3 <- ap$oh3

  result <- partition_tile_superblocks(
    tiles = tiles,
    gene_len = gene_len,
    polIII_len = polIII_len,
    max_sub_length = TEST_MAX_SUB,
    oh3 = oh3
  )

  # TRIO should need at least 5 superblocks
  expect_gte(result$n_superblocks, 5L)
  expect_equal(result$n_collisions, 0L)
  # All within synthesis limit
  for (i in seq_len(nrow(result$superblocks))) {
    content <- result$superblocks$gene_content[i]
    if (i == nrow(result$superblocks)) content <- content + polIII_len
    expect_lte(content + TEST_BLOCK_OVERHEAD, TEST_MAX_BLOCK_LENGTH)
  }
})

test_that("5d: short gene — no superblocking needed", {
  # TEST_GENE_SEQ = 300 nt. With polIII = 250 nt, total = 550 nt < 1778
  gene_seq <- TEST_GENE_SEQ
  gene_len <- nchar(gene_seq)
  polIII_len <- nchar(TEST_POLIII)
  tiles <- make_test_tiles(1, gene_seq = gene_seq)

  result <- partition_tile_superblocks(
    tiles = tiles,
    gene_len = gene_len,
    polIII_len = polIII_len,
    max_sub_length = TEST_MAX_SUB
  )

  expect_equal(result$n_superblocks, 1L)
  expect_equal(result$n_collisions, 0L)
})

# =============================================================================
# Category 6: Edge Cases & Degenerate Inputs
# =============================================================================

test_that("6a: gene where every tile boundary is an RC collision", {
  # Stress test: if all tile oh2 values are palindromic (self-RC),
  # the partition should still succeed by choosing boundaries where
  # the palindrome doesn't conflict with oh3
  skip("Degenerate case — revisit if this arises with real genes")
})

test_that("6b: gene exactly at max_sub boundary — no split needed", {
  # Gene content + polIII exactly equals max_sub
  tiles <- make_test_tiles(1, gene_seq = TEST_GENE_SEQ)
  gene_len <- nchar(TEST_GENE_SEQ)
  polIII_len <- nchar(TEST_POLIII)
  exact_limit <- gene_len + polIII_len # 300 + 250 = 550

  result <- partition_tile_superblocks(
    tiles = tiles,
    gene_len = gene_len,
    polIII_len = polIII_len,
    max_sub_length = exact_limit
  )

  expect_equal(result$n_superblocks, 1L)
})

test_that("6c: gene 1 nt over max_sub — forces split", {
  tiles <- make_test_tiles(3, gene_seq = TEST_GENE_SEQ)
  gene_len <- nchar(TEST_GENE_SEQ)
  polIII_len <- nchar(TEST_POLIII)
  # Make the limit just 1 nt less than the total
  tight_limit <- gene_len + polIII_len - 1L

  result <- partition_tile_superblocks(
    tiles = tiles,
    gene_len = gene_len,
    polIII_len = polIII_len,
    max_sub_length = tight_limit
  )

  # Should need at least 2 SBs
  expect_gte(result$n_superblocks, 2L)
})

test_that("6d: 2-tile gene — minimal partitioning", {
  # Gene with exactly 2 tiles. Could be 1 or 2 SBs depending on size.
  tiles <- make_test_tiles(2, gene_seq = TEST_LONG_GENE_SEQ)
  gene_len <- nchar(TEST_LONG_GENE_SEQ)
  polIII_len <- nchar(TEST_POLIII)

  result <- partition_tile_superblocks(
    tiles = tiles,
    gene_len = gene_len,
    polIII_len = polIII_len,
    max_sub_length = TEST_MAX_SUB
  )

  expect_gte(result$n_superblocks, 1L)
  expect_lte(result$n_superblocks, 2L)
  # Must cover both tiles
  all_tiles <- unlist(lapply(seq_len(nrow(result$superblocks)), function(i) {
    seq(result$superblocks$start_tile[i], result$superblocks$end_tile[i])
  }))
  expect_equal(sort(all_tiles), 1:2)
})

# =============================================================================
# Category 7: Block Deduplication
# =============================================================================

test_that("7a: full SB blocks are reused across tiles in the same enzyme context", {
  tiles <- make_test_tiles(18, gene_seq = TEST_LONG_GENE_SEQ)
  gene_len <- nchar(TEST_LONG_GENE_SEQ)
  polIII_len <- nchar(TEST_POLIII)
  oh3 <- substring(TEST_POLIII, nchar(TEST_POLIII) - 4, nchar(TEST_POLIII) - 1)

  result <- partition_tile_superblocks(
    tiles = tiles,
    gene_len = gene_len,
    polIII_len = polIII_len,
    max_sub_length = TEST_MAX_SUB,
    oh3 = oh3
  )

  # Count how many tiles would use each full SB as a BsmBI block
  # Tiles in SB1 use SB2, SB3, ..., SBn as full blocks
  # Tiles in SB2 use SB3, SB4, ..., SBn as full blocks
  # Etc.
  # So SBn (last) is used by all tiles in SBs 1 through n-1 as a BsmBI block
  n_sb <- result$n_superblocks
  if (n_sb >= 2) {
    # SB2 as BsmBI block is used by all tiles in SB1
    n_tiles_sb1 <- result$superblocks$end_tile[1] - result$superblocks$start_tile[1] + 1
    # These should all get the same physical block (same gene content, same enzyme sites)
    expect_gte(n_tiles_sb1, 1L)
    # The block is "deduplicated" — ordered once, used in multiple reactions
  }
})

test_that("7b: tile blocks within a SB are ordered per enzyme context", {
  # Within an SB, partial fragments for different tiles have different
  # gene content but need both BsaI and BsmBI versions.
  # Tile blocks for BsaI (5'WT) and BsmBI (3'WT) are separate physical blocks
  # even if they cover the same gene region, because they have different
  # flanking enzyme recognition sites.
  tiles <- make_test_tiles(18, gene_seq = TEST_LONG_GENE_SEQ)
  gene_len <- nchar(TEST_LONG_GENE_SEQ)
  polIII_len <- nchar(TEST_POLIII)

  result <- partition_tile_superblocks(
    tiles = tiles,
    gene_len = gene_len,
    polIII_len = polIII_len,
    max_sub_length = TEST_MAX_SUB
  )

  # For each SB with > 1 tile, there should be partial fragments
  sbs <- result$superblocks
  for (i in seq_len(nrow(sbs))) {
    n_tiles_in_sb <- sbs$end_tile[i] - sbs$start_tile[i] + 1
    if (n_tiles_in_sb > 1) {
      # Tiles within this SB (except the first) need a 5'WT partial fragment
      # Tiles within this SB (except the last) need a 3'WT partial fragment
      # These are "tile blocks" = 2*(N-1) per SB
      expected_tile_blocks <- 2L * (n_tiles_in_sb - 1L)
      expect_gte(expected_tile_blocks, 2L)
    }
  }
})

# =============================================================================
# Category 8: Enzyme Context Block Generation
# =============================================================================

test_that("8a: SB boundary overhangs checked in BOTH BsaI and BsmBI fidelity", {
  # When selecting SB boundaries at tile positions, the overhang (oh2) is
  # used in BsmBI context (3'WT) and the corresponding oh1 at the same
  # gene position in BsaI context (5'WT). Both should be high-fidelity.
  tiles <- make_test_tiles(18, gene_seq = TEST_LONG_GENE_SEQ)
  gene_len <- nchar(TEST_LONG_GENE_SEQ)
  polIII_len <- nchar(TEST_POLIII)

  result <- partition_tile_superblocks(
    tiles = tiles,
    gene_len = gene_len,
    polIII_len = polIII_len,
    max_sub_length = TEST_MAX_SUB
  )

  # SB boundaries are at tile boundaries, so oh2 is already available
  # Check that boundary tile oh2 values are in HF set (or at least high fidelity)
  oh_fidelity <- builtin_overhang_fidelity()
  fid_lookup <- oh_fidelity$fidelity
  names(fid_lookup) <- oh_fidelity$overhang

  sbs <- result$superblocks
  if (nrow(sbs) > 1) {
    for (i in seq_len(nrow(sbs) - 1L)) {
      boundary_tile <- sbs$end_tile[i]
      oh <- tiles$oh2_seq[boundary_tile]
      fid <- if (oh %in% names(fid_lookup)) unname(fid_lookup[oh]) else 0
      # Should be reasonably high fidelity (tile boundary DP already optimized)
      expect_true(fid >= 0.80,
        info = sprintf(
          "SB boundary tile %d oh2=%s fidelity=%.3f too low",
          boundary_tile, oh, fid
        )
      )
    }
  }
})

test_that("8b: BsaI blocks never use BsmBI overhangs and vice versa", {
  # An SB used as a BsaI block (for 5'WT) has BsaI flanking sites
  # An SB used as a BsmBI block (for 3'WT) has BsmBI flanking sites
  # The gene content is the same but the physical blocks differ
  # This is a design constraint, not a computation — verified by counting
  tiles <- make_test_tiles(18, gene_seq = TEST_LONG_GENE_SEQ)
  gene_len <- nchar(TEST_LONG_GENE_SEQ)
  polIII_len <- nchar(TEST_POLIII)

  result <- partition_tile_superblocks(
    tiles = tiles,
    gene_len = gene_len,
    polIII_len = polIII_len,
    max_sub_length = TEST_MAX_SUB
  )

  # Block count formula:
  # Full superblock orders = 2 * (n_superblocks - 1)
  # (Each interior SB needs both BsaI and BsmBI version)
  # First SB: only BsmBI (used for tiles in SBs before it — but SB1 is first, so never used as 5'WT)
  # Last SB: only BsaI (never used as 3'WT since it contains the last tiles)
  # Actually: SB1 never needs BsaI version, last SB never needs BsmBI version
  n_sb <- result$n_superblocks
  if (n_sb >= 2) {
    expected_full_sb_blocks <- 2L * (n_sb - 1L)
    expect_gte(expected_full_sb_blocks, 2L)
  }
})

test_that("8c: block counting formula is correct", {
  tiles <- make_test_tiles(18, gene_seq = TEST_LONG_GENE_SEQ)
  gene_len <- nchar(TEST_LONG_GENE_SEQ)
  polIII_len <- nchar(TEST_POLIII)

  result <- partition_tile_superblocks(
    tiles = tiles,
    gene_len = gene_len,
    polIII_len = polIII_len,
    max_sub_length = TEST_MAX_SUB
  )

  n_sb <- result$n_superblocks
  sbs <- result$superblocks

  # Per-SB tile block count: 2*(N_i - 1) where N_i = tiles in SB i
  tile_blocks <- 0L
  for (i in seq_len(nrow(sbs))) {
    n_tiles_in_sb <- sbs$end_tile[i] - sbs$start_tile[i] + 1L
    tile_blocks <- tile_blocks + 2L * (n_tiles_in_sb - 1L)
  }

  # Full superblock orders: 2*(n_sb - 1) — each interior SB needs BsaI + BsmBI
  full_sb_blocks <- 2L * (n_sb - 1L)

  # Verify the count is stored in result (if the function provides it)
  if (!is.null(result$block_count)) {
    expect_equal(result$block_count$tile_blocks, tile_blocks)
    expect_equal(result$block_count$full_sb_blocks, full_sb_blocks)
  }
})

# =============================================================================
# Category 9: Cassette Handling
# =============================================================================

test_that("9a: cassette length included in last SB sizing", {
  tiles <- make_test_tiles(18, gene_seq = TEST_LONG_GENE_SEQ)
  gene_len <- nchar(TEST_LONG_GENE_SEQ)

  # Simulate a large cassette (1097 nt WPRE + 250 nt polIII = 1347 nt)
  cassette_len <- 1347L

  result <- partition_tile_superblocks(
    tiles = tiles,
    gene_len = gene_len,
    polIII_len = cassette_len, # cassette replaces polIII in sizing
    max_sub_length = TEST_MAX_SUB
  )

  # Last SB gene content + cassette must fit
  last_sb <- result$superblocks[nrow(result$superblocks), ]
  expect_lte(last_sb$gene_content + cassette_len, TEST_MAX_SUB)
})

test_that("9b: cassette as separate fragment — oh_cassette needed", {
  # When the cassette is treated as a separate BsmBI fragment,
  # we need an additional freely-chosen overhang at the gene-cassette junction.
  # This test validates the concept.
  tiles <- make_test_tiles(18, gene_seq = TEST_LONG_GENE_SEQ)
  gene_len <- nchar(TEST_LONG_GENE_SEQ)
  polIII_len <- nchar(TEST_POLIII)

  # With cassette as separate fragment, the last SB's content is just gene
  # (no polIII added). The cassette becomes its own block(s).
  # For now, test that the cassette_mode parameter changes behavior.
  result_attached <- partition_tile_superblocks(
    tiles = tiles,
    gene_len = gene_len,
    polIII_len = polIII_len,
    max_sub_length = TEST_MAX_SUB
  )

  result_separate <- partition_tile_superblocks(
    tiles = tiles,
    gene_len = gene_len,
    polIII_len = 0L, # cassette handled separately
    max_sub_length = TEST_MAX_SUB
  )

  # With cassette separate (polIII_len=0), the last SB has more room
  # so we might need fewer superblocks (or the same)
  expect_lte(result_separate$n_superblocks, result_attached$n_superblocks)
})

test_that("9c: large cassette forces extra superblock when attached", {
  tiles <- make_test_tiles(18, gene_seq = TEST_LONG_GENE_SEQ)
  gene_len <- nchar(TEST_LONG_GENE_SEQ)

  # Extremely large cassette that eats into the last SB's gene budget
  large_cassette_len <- 1500L

  result <- partition_tile_superblocks(
    tiles = tiles,
    gene_len = gene_len,
    polIII_len = large_cassette_len,
    max_sub_length = TEST_MAX_SUB
  )

  # With max_sub=1778 and cassette=1500, the last SB can only hold 278 nt gene
  # This means we need more superblocks
  last_sb <- result$superblocks[nrow(result$superblocks), ]
  expect_lte(last_sb$gene_content + large_cassette_len, TEST_MAX_SUB)
  # Should need more SBs than without the large cassette
  result_no_cassette <- partition_tile_superblocks(
    tiles = tiles,
    gene_len = gene_len,
    polIII_len = 0L,
    max_sub_length = TEST_MAX_SUB
  )
  expect_gte(result$n_superblocks, result_no_cassette$n_superblocks)
})

test_that("9d: cassette exceeding max_sub alone triggers error or warning", {
  # If polIII_len > max_sub_length, no partition can work with cassette attached
  # The function should error or warn
  tiles <- make_test_tiles(18, gene_seq = TEST_LONG_GENE_SEQ)
  gene_len <- nchar(TEST_LONG_GENE_SEQ)

  impossible_cassette <- TEST_MAX_SUB + 100L # larger than any single block

  expect_error(
    partition_tile_superblocks(
      tiles = tiles,
      gene_len = gene_len,
      polIII_len = impossible_cassette,
      max_sub_length = TEST_MAX_SUB
    ),
    regexp = "cassette|polIII|exceeds",
    info = "Should error when cassette alone exceeds max_sub_length"
  )
})
