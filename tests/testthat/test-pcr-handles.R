# test-pcr-handles.R — Tests for optional PCR handle support
# Tests config parsing, tile size overhead, oligo assembly, and QC

# --- Config Parsing Tests ---

test_that("parse_pcr_handles with NULL returns zero overhead", {
  # Backward compatibility: no handles = no change to pipeline
  cfg <- list(max_oligo_length = 300L, pcr_handles = NULL)
  result <- parse_pcr_handles(cfg)
  expect_null(result$pcr_handles)
  expect_equal(result$handle_overhead, 0L)
  expect_equal(result$fwd_handle_length, 0L)
  expect_equal(result$rev_handle_length, 0L)
})

test_that("parse_pcr_handles with empty list returns zero overhead", {
  cfg <- list(max_oligo_length = 300L, pcr_handles = list())
  result <- parse_pcr_handles(cfg)
  expect_null(result$pcr_handles)
  expect_equal(result$handle_overhead, 0L)
})

test_that("parse_pcr_handles with valid pairs parses correctly", {
  # Two pairs of 20 nt handles — typical use case
  cfg <- list(
    max_oligo_length = 300L,
    pcr_handles = list(
      list(fwd = "ACGTACGTACGTACGTACGT", rev = "TGCATGCATGCATGCATGCA"),
      list(fwd = "GCTAGCTAGCTAGCTAGCTA", rev = "ATCGATCGATCGATCGATCG")
    )
  )
  result <- parse_pcr_handles(cfg)
  expect_equal(length(result$pcr_handles), 2L)
  expect_equal(result$fwd_handle_length, 20L)
  expect_equal(result$rev_handle_length, 20L)
  expect_equal(result$handle_overhead, 40L)
  # Sequences should be uppercased
  expect_equal(result$pcr_handles[[1]]$fwd, "ACGTACGTACGTACGTACGT")
})

test_that("parse_pcr_handles uppercases sequences", {
  cfg <- list(
    max_oligo_length = 300L,
    pcr_handles = list(
      list(fwd = "acgtacgtacgtacgtacgt", rev = "tgcatgcatgcatgcatgca")
    )
  )
  result <- parse_pcr_handles(cfg)
  expect_equal(result$pcr_handles[[1]]$fwd, "ACGTACGTACGTACGTACGT")
  expect_equal(result$pcr_handles[[1]]$rev, "TGCATGCATGCATGCATGCA")
})

test_that("parse_pcr_handles rejects non-ACGT characters", {
  cfg <- list(
    max_oligo_length = 300L,
    pcr_handles = list(
      list(fwd = "ACGTACGTACGTACNNNNN", rev = "TGCATGCATGCATGCATGCA")
    )
  )
  expect_error(parse_pcr_handles(cfg), "non-ACGT")
})

test_that("parse_pcr_handles rejects missing fwd field", {
  cfg <- list(
    max_oligo_length = 300L,
    pcr_handles = list(
      list(rev = "TGCATGCATGCATGCATGCA")
    )
  )
  expect_error(parse_pcr_handles(cfg), "fwd")
})

test_that("parse_pcr_handles rejects inconsistent fwd lengths", {
  # Guards against mutable region calculation being ambiguous
  cfg <- list(
    max_oligo_length = 300L,
    pcr_handles = list(
      list(fwd = "ACGTACGTACGTACGTACGT", rev = "TGCATGCATGCATGCATGCA"),
      list(fwd = "GCTAGCTAGCTA",          rev = "ATCGATCGATCGATCGATCG")
    )
  )
  expect_error(parse_pcr_handles(cfg), "same length")
})

test_that("parse_pcr_handles rejects inconsistent rev lengths", {
  cfg <- list(
    max_oligo_length = 300L,
    pcr_handles = list(
      list(fwd = "ACGTACGTACGTACGTACGT", rev = "TGCATGCATGCATGCATGCA"),
      list(fwd = "GCTAGCTAGCTAGCTAGCTA", rev = "ATCGATCGATCG")
    )
  )
  expect_error(parse_pcr_handles(cfg), "same length")
})

test_that("parse_pcr_handles rejects handles shorter than 15 nt", {
  # 14 nt is too short for a PCR primer
  cfg <- list(
    max_oligo_length = 300L,
    pcr_handles = list(
      list(fwd = "ACGTACGTACGTAC", rev = "TGCATGCATGCATG")
    )
  )
  expect_error(parse_pcr_handles(cfg), "below minimum of 15")
})

test_that("parse_pcr_handles rejects handles with BsmBI sites", {
  # BsmBI = CGTCTC — present in fwd handle, should cause off-target digestion
  cfg <- list(
    max_oligo_length = 300L,
    pcr_handles = list(
      list(fwd = "ACGTCGTCTCACGTACGT", rev = "TGCATGCATGCATGCATGCA")
    )
  )
  expect_error(parse_pcr_handles(cfg), "BsmBI")
})

test_that("parse_pcr_handles rejects handles with BsaI sites", {
  # BsaI = GGTCTC
  cfg <- list(
    max_oligo_length = 300L,
    pcr_handles = list(
      list(fwd = "ACGTGGTCTCACGTACGT", rev = "TGCATGCATGCATGCATGCA")
    )
  )
  expect_error(parse_pcr_handles(cfg), "BsaI")
})

test_that("parse_pcr_handles warns on duplicate fwd handles", {
  # Same fwd sequence on both tiles = can't selectively amplify
  # cli::cli_alert_warning produces a message (not a base R warning)
  cfg <- list(
    max_oligo_length = 300L,
    pcr_handles = list(
      list(fwd = "ACGTACGTACGTACGTACGT", rev = "TGCATGCATGCATGCATGCA"),
      list(fwd = "ACGTACGTACGTACGTACGT", rev = "ATCGATCGATCGATCGATCG")
    )
  )
  expect_message(parse_pcr_handles(cfg), "Duplicate fwd")
})

# --- Tiling Tests ---

test_that("compute_max_tile_size with handle_overhead reduces mutable region", {
  # Without handles: overhead = 44 + 20 = 64, mutable = 300 - 64 = 236 -> 234 (codon boundary)
  size_no_handle <- compute_max_tile_size(300L, 20L, handle_overhead = 0L)
  # With 40 nt handles: overhead = 44 + 20 + 40 = 104, mutable = 300 - 104 = 196 -> 195 (codon boundary)
  size_with_handle <- compute_max_tile_size(300L, 20L, handle_overhead = 40L)
  expect_lt(size_with_handle, size_no_handle)
  expect_equal(size_no_handle - size_with_handle, 39L)  # 40 nt - 1 for codon rounding
  # Both should be multiples of 3
  expect_equal(size_no_handle %% 3L, 0L)
  expect_equal(size_with_handle %% 3L, 0L)
})

test_that("compute_max_tile_size with handle_overhead=0 matches no-handle", {
  baseline <- compute_max_tile_size(300L, 12L)
  with_zero <- compute_max_tile_size(300L, 12L, handle_overhead = 0L)
  expect_equal(with_zero, baseline)
})

# --- Assembly Tests ---

test_that("assemble_oligos without pcr_handles produces unchanged oligos", {
  # Backward compat: NULL handles should produce identical output
  cds <- domesticate_test_gene()

  tiles <- partition_tiles(cds, compute_max_tile_size(300L, 20L))
  variants <- design_mutations(cds, TEST_CODON_USAGE)
  variants <- assign_variants_to_tiles(variants, tiles)
  # Remove partial overlap variants
  variants <- variants[is.na(variants$overhang_note) |
    variants$overhang_note != "partial_oh_overlap", ]

  barcodes <- paste0(
    strrep("A", 10), sprintf("%010d", seq_len(nrow(variants)))
  )
  barcodes <- substring(barcodes, 1, 20)

  oligos_null <- assemble_oligos(variants, cds, barcodes, tiles,
    oh3 = "AATG", oh4 = "GCTA", pcr_handles = NULL
  )
  oligos_default <- assemble_oligos(variants, cds, barcodes, tiles,
    oh3 = "AATG", oh4 = "GCTA"
  )
  expect_equal(oligos_null$sequence, oligos_default$sequence)
})

test_that("assemble_oligos with pcr_handles prepends fwd and appends rev", {
  cds <- domesticate_test_gene()
  tile_size <- compute_max_tile_size(300L, 20L, handle_overhead = 40L)
  tiles <- partition_tiles(cds, tile_size)

  variants <- design_mutations(cds, TEST_CODON_USAGE)
  variants <- assign_variants_to_tiles(variants, tiles)
  variants <- variants[is.na(variants$overhang_note) |
    variants$overhang_note != "partial_oh_overlap", ]

  barcodes <- paste0(
    strrep("A", 10), sprintf("%010d", seq_len(nrow(variants)))
  )
  barcodes <- substring(barcodes, 1, 20)

  # Create handle pairs for each tile
  n_tiles <- nrow(tiles)
  handles <- lapply(seq_len(n_tiles), function(i) {
    list(
      fwd = paste0(strrep("ACGT", 5)),
      rev = paste0(strrep("TGCA", 5))
    )
  })

  oligos_with <- assemble_oligos(variants, cds, barcodes, tiles,
    oh3 = "AATG", oh4 = "GCTA",
    max_oligo_length = 300L,
    pcr_handles = handles
  )

  # Every oligo should start with fwd handle
  expect_true(all(startsWith(oligos_with$sequence, "ACGTACGTACGTACGTACGT")))
  # Every oligo should end with rev handle
  expect_true(all(endsWith(oligos_with$sequence, "TGCATGCATGCATGCATGCA")))
  # All oligos should be within 300 nt
  expect_true(all(oligos_with$length <= 300L))
})

test_that("assemble_oligos with handles respects per-tile assignment", {
  # Tile 1 gets handle pair 1, tile 2 gets handle pair 2
  cds <- domesticate_test_gene()
  tile_size <- compute_max_tile_size(300L, 20L, handle_overhead = 40L)
  tiles <- partition_tiles(cds, tile_size)
  n_tiles <- nrow(tiles)
  skip_if(n_tiles < 2L, "Need at least 2 tiles for per-tile handle test")

  variants <- design_mutations(cds, TEST_CODON_USAGE)
  variants <- assign_variants_to_tiles(variants, tiles)
  variants <- variants[is.na(variants$overhang_note) |
    variants$overhang_note != "partial_oh_overlap", ]

  barcodes <- paste0(
    strrep("A", 10), sprintf("%010d", seq_len(nrow(variants)))
  )
  barcodes <- substring(barcodes, 1, 20)

  # Give each tile a distinct handle pair
  handles <- list(
    list(fwd = "AAAAAAAAAAAAAAAAAAA", rev = "TTTTTTTTTTTTTTTTTTT"),
    list(fwd = "CCCCCCCCCCCCCCCCCCC", rev = "GGGGGGGGGGGGGGGGGGG")
  )
  # Extend with generic handles if more tiles exist
  if (n_tiles > 2L) {
    for (i in 3:n_tiles) {
      handles[[i]] <- list(
        fwd = paste0(strrep("ACGT", 5)),
        rev = paste0(strrep("TGCA", 5))
      )
    }
  }

  oligos <- assemble_oligos(variants, cds, barcodes, tiles,
    oh3 = "AATG", oh4 = "GCTA",
    max_oligo_length = 300L,
    pcr_handles = handles
  )

  # Tile 1 oligos should start with A-handle
  tile1_oligos <- oligos$sequence[oligos$tile_id == 1L]
  expect_true(all(startsWith(tile1_oligos, "AAAAAAAAAAAAAAAAAAA")))
  expect_true(all(endsWith(tile1_oligos, "TTTTTTTTTTTTTTTTTTT")))

  # Tile 2 oligos should start with C-handle
  tile2_oligos <- oligos$sequence[oligos$tile_id == 2L]
  expect_true(all(startsWith(tile2_oligos, "CCCCCCCCCCCCCCCCCCC")))
  expect_true(all(endsWith(tile2_oligos, "GGGGGGGGGGGGGGGGGGG")))
})

# --- GG Simulator Tests ---

test_that("BsaI digestion strips PCR handles from oligos", {
  # Build an oligo with handles and verify digest_linear produces
  # the correct internal fragment (handles removed as waste)
  oh1 <- "ATCG"
  oh4 <- "GCTA"
  fwd_handle <- "ACGTACGTACGTACGTACGT"  # 20 nt
  rev_handle <- "TGCATGCATGCATGCATGCA"  # 20 nt
  core_insert <- "AAAAAAGGGGGGTTTTTTTCCCCCC"  # 24 nt

  # Build: fwd_handle + BsaI_fwd + oh1 + core_insert + BsaI_rev_oh4 + rev_handle
  bsai_fwd <- orient_enzyme_site("BsaI", oh1, "forward")
  bsai_rev <- orient_enzyme_site("BsaI", oh4, "reverse")
  oligo_seq <- paste0(fwd_handle, bsai_fwd, core_insert, bsai_rev, rev_handle)

  frags <- digest_linear(oligo_seq, "BsaI", source_label = "oligo")
  frags <- mark_terminal_waste(frags)

  # Should get 3 fragments: waste(handle1) + productive(insert) + waste(handle2)
  expect_equal(length(frags), 3L)

  # Terminal fragments are waste
  expect_equal(frags[[1]]$source, "waste")
  expect_equal(frags[[3]]$source, "waste")

  # Middle fragment is the productive insert
  expect_equal(frags[[2]]$source, "oligo")
  expect_equal(frags[[2]]$oh_5, oh1)
  expect_equal(frags[[2]]$oh_3, oh4)

  # The productive insert should contain the core sequence, NOT the handles
  expect_true(grepl(core_insert, frags[[2]]$body))
  expect_false(grepl(fwd_handle, frags[[2]]$body))
  expect_false(grepl(rev_handle, frags[[2]]$body))
})

test_that("GG simulator produces identical results with and without handles", {
  # The definitive test: assembly with handles must produce the same
  # simulation outcome as without handles. Handles are stripped by BsaI
  # digestion and should not affect the assembled product.
  #
  # Strategy: use the standard tile size (no handle overhead) for assembly
  # planning and gene blocks, then compare simulator results using oligos
  # assembled with vs without handles. The handle overhead is added to
  # max_oligo_length to keep the mutable region identical.
  cds <- domesticate_test_gene()
  tile_size <- compute_max_tile_size(300L, 20L, handle_overhead = 0L)

  assembly_plan <- plan_assembly(
    cds = cds,
    polIII = TEST_POLIII,
    max_mutable_nt = tile_size,
    max_block_length = 1800L,
    config = list(
      overlap_codons = 6L,
      boundary_method = "oogga_two_pass",
      oogga_max_identity = 2L,
      oogga_beam_width = 10L,
      multi_k = FALSE,
      min_geneblock_length = 300L
    )
  )
  tiles <- assembly_plan$tiles
  oh3 <- assembly_plan$oh3
  oh4 <- assembly_plan$oh4

  variants <- design_mutations(cds, TEST_CODON_USAGE)
  variants <- assign_variants_to_tiles(variants, tiles)
  variants <- variants[is.na(variants$overhang_note) |
    variants$overhang_note != "partial_oh_overlap", ]

  barcode_result <- design_barcodes(
    n_variants = nrow(variants),
    barcode_length = 20L,
    min_hamming = 3L,
    prefix_length = 12L,
    barcodes_per_variant = 1L
  )
  barcodes <- barcode_result$barcodes
  variants$barcode_idx <- 1L

  # Assemble oligos WITHOUT handles (baseline)
  oligos_no_handles <- assemble_oligos(variants, cds, barcodes, tiles,
    oh3 = oh3, oh4 = oh4,
    max_oligo_length = 300L,
    full_seq = assembly_plan$full_seq
  )

  # Assemble oligos WITH handles (allow 340 nt to fit handles + same mutable region)
  n_tiles <- nrow(tiles)
  handles <- lapply(seq_len(n_tiles), function(i) {
    list(
      fwd = paste0(strrep("ACGT", 5)),
      rev = paste0(strrep("TGCA", 5))
    )
  })
  oligos_with_handles <- assemble_oligos(variants, cds, barcodes, tiles,
    oh3 = oh3, oh4 = oh4,
    max_oligo_length = 340L,  # 300 + 40 nt handles
    full_seq = assembly_plan$full_seq,
    pcr_handles = handles
  )

  # Gene blocks are the same regardless of handles
  geneblock_result <- design_wt_geneblocks(
    cds = cds,
    polIII = TEST_POLIII,
    tiles = tiles,
    oh3 = oh3,
    oh4 = oh4,
    paqci_star2 = "AATG",
    paqci_star1 = "GCTA",
    max_block_length = 1800L,
    min_block_length = 300L,
    assembly_plan = assembly_plan
  )

  # Run simulator on BOTH oligo sets
  sim_no_handles <- simulate_pipeline_assembly(
    oligos = oligos_no_handles, geneblock_result = geneblock_result,
    tiles = tiles, variants = variants, barcodes = barcodes,
    cds = cds, polIII = TEST_POLIII,
    assembly_plan = assembly_plan, samples_per_tile = 1L
  )
  sim_with_handles <- simulate_pipeline_assembly(
    oligos = oligos_with_handles, geneblock_result = geneblock_result,
    tiles = tiles, variants = variants, barcodes = barcodes,
    cds = cds, polIII = TEST_POLIII,
    assembly_plan = assembly_plan, samples_per_tile = 1L
  )

  # Same pass/fail for every tile — handles don't change assembly outcome
  expect_equal(sim_with_handles$pass, sim_no_handles$pass,
    info = "Handled vs non-handled oligos should produce identical simulation outcomes"
  )
  expect_equal(sim_with_handles$has_mut_gene, sim_no_handles$has_mut_gene)
  expect_equal(sim_with_handles$has_polIII, sim_no_handles$has_polIII)
  expect_equal(sim_with_handles$has_barcode, sim_no_handles$has_barcode)
})
