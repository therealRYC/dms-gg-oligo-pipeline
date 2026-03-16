# Created: 2026-02-21
# Last updated: 2026-03-17 — Add targeted sampling + strict verification tests
# test-gg-simulator.R — Tests for 13_gg_simulator.R (Golden Gate Assembly Simulator)

# =============================================================================
# Unit Tests: digest_linear
# =============================================================================

test_that("digest_linear with forward BsaI site produces correct fragments", {
  # BsaI forward: GGTCTC + A(spacer) + overhang
  # Build a sequence with one forward BsaI site
  oh <- "ATGG"
  fwd_site <- orient_enzyme_site("BsaI", oh, "forward")  # "GGTCTCAATGG"
  seq <- paste0("AAA", fwd_site, "CCCCCCC")  # 3 + 11 + 7 = 21 nt

  frags <- digest_linear(seq, "BsaI", source_label = "test")

  # One cut → two fragments

  expect_equal(length(frags), 2L)

  # First fragment: upstream of cut
  expect_true(is.na(frags[[1]]$oh_5))
  expect_equal(frags[[1]]$oh_3, oh)
  expect_equal(frags[[1]]$source, "test")

  # Second fragment: downstream of cut, starts with overhang
  expect_equal(frags[[2]]$oh_5, oh)
  expect_true(is.na(frags[[2]]$oh_3))
  expect_true(startsWith(frags[[2]]$body, oh))

  # Concatenating bodies recovers original
  recovered <- paste0(frags[[1]]$body, frags[[2]]$body)
  expect_equal(recovered, seq)
})

test_that("digest_linear with reverse BsaI site produces correct fragments", {
  # Build a sequence with one reverse BsaI site
  oh <- "ATGG"
  rev_site <- orient_enzyme_site("BsaI", oh, "reverse")
  seq <- paste0("CCCCCCCCC", rev_site, "AAA")  # 9 + 11 + 3 = 23 nt

  frags <- digest_linear(seq, "BsaI", source_label = "test")

  expect_equal(length(frags), 2L)

  # The reverse site cuts to the LEFT of the recognition
  # First fragment: should have oh_3 = oh (the overhang is at the cut junction)
  expect_true(is.na(frags[[1]]$oh_5))
  expect_equal(frags[[1]]$oh_3, oh)

  # Second fragment starts with the overhang
  expect_equal(frags[[2]]$oh_5, oh)
  expect_true(is.na(frags[[2]]$oh_3))
  expect_true(startsWith(frags[[2]]$body, oh))

  # Concatenating bodies recovers original
  recovered <- paste0(frags[[1]]$body, frags[[2]]$body)
  expect_equal(recovered, seq)
})

test_that("digest_linear with BsmBI forward and reverse sites (oligo-like)", {
  # Simulate an oligo-like sequence with both BsmBI orientations
  oh2 <- "CTAA"
  oh3 <- "ACTA"
  fwd_site <- orient_enzyme_site("BsmBI", oh3, "forward")  # CGTCTCAACTA
  rev_site <- orient_enzyme_site("BsmBI", oh2, "reverse")
  # Sequence: prefix + rev_site + middle + fwd_site + suffix
  seq <- paste0("AAAAAAAA", rev_site, "TTTTTTTTTTTT", fwd_site, "GGGGGGGG")

  frags <- digest_linear(seq, "BsmBI", source_label = "oligo")

  # Two cuts → three fragments
  expect_equal(length(frags), 3L)

  # First fragment: no 5' overhang
  expect_true(is.na(frags[[1]]$oh_5))
  expect_equal(frags[[1]]$oh_3, oh2)

  # Middle fragment: both overhangs
  expect_equal(frags[[2]]$oh_5, oh2)
  expect_equal(frags[[2]]$oh_3, oh3)

  # Last fragment: no 3' overhang
  expect_equal(frags[[3]]$oh_5, oh3)
  expect_true(is.na(frags[[3]]$oh_3))

  # Round-trip
  recovered <- paste0(frags[[1]]$body, frags[[2]]$body, frags[[3]]$body)
  expect_equal(recovered, seq)
})

test_that("digest_linear with PaqCI site works correctly", {
  # PaqCI: CACCTGC (7 nt), spacer_len=4, oh_len=4, cut_fwd=4, cut_rev=8
  oh <- "AGTC"
  fwd_site <- orient_enzyme_site("PaqCI", oh, "forward")  # 7 + 4 + 4 = 15 nt
  seq <- paste0("AAAAAA", fwd_site, "TTTTTTTTTT")

  frags <- digest_linear(seq, "PaqCI", source_label = "test")

  expect_equal(length(frags), 2L)
  expect_equal(frags[[1]]$oh_3, oh)
  expect_equal(frags[[2]]$oh_5, oh)

  # Round-trip
  recovered <- paste0(frags[[1]]$body, frags[[2]]$body)
  expect_equal(recovered, seq)
})

test_that("digest_linear with no sites returns single fragment", {
  seq <- "AAAAAAAATTTTTTTT"
  frags <- digest_linear(seq, "BsaI", source_label = "test")

  expect_equal(length(frags), 1L)
  expect_equal(frags[[1]]$body, seq)
  expect_true(is.na(frags[[1]]$oh_5))
  expect_true(is.na(frags[[1]]$oh_3))
})

# =============================================================================
# Unit Tests: mark_terminal_waste, mark_stuffer_waste
# =============================================================================

test_that("mark_terminal_waste marks first and last fragments", {
  frags <- list(
    list(body = "AAA", oh_5 = NA, oh_3 = "ATGG", source = "block"),
    list(body = "ATGGGGG", oh_5 = "ATGG", oh_3 = "CTAA", source = "block"),
    list(body = "CTAATTT", oh_5 = "CTAA", oh_3 = NA, source = "block")
  )

  result <- mark_terminal_waste(frags)

  expect_equal(result[[1]]$source, "waste")
  expect_equal(result[[2]]$source, "block")  # middle unchanged
  expect_equal(result[[3]]$source, "waste")
})

test_that("mark_stuffer_waste marks fragments with both overhangs", {
  frags <- list(
    list(body = "AAA", oh_5 = NA, oh_3 = "ATGG", source = "helper"),
    list(body = "STUFFER", oh_5 = "ATGG", oh_3 = "GATA", source = "helper"),
    list(body = "BBB", oh_5 = "GATA", oh_3 = NA, source = "helper")
  )

  result <- mark_stuffer_waste(frags)

  expect_equal(result[[1]]$source, "helper")  # terminal, not stuffer
  expect_equal(result[[2]]$source, "waste")   # stuffer
  expect_equal(result[[3]]$source, "helper")  # terminal, not stuffer
})

# =============================================================================
# Unit Tests: ligate_fragments
# =============================================================================

test_that("digest then ligate recovers original sequence", {
  # Create a sequence with two BsaI sites and digest
  oh1 <- "ATGG"
  oh2 <- "CTAA"
  fwd1 <- orient_enzyme_site("BsaI", oh1, "forward")
  fwd2 <- orient_enzyme_site("BsaI", oh2, "forward")
  seq <- paste0("AAA", fwd1, "BBBBBBBBBBB", fwd2, "CCC")

  frags <- digest_linear(seq, "BsaI", source_label = "test")

  # All fragments are productive (no waste marking)
  product <- ligate_fragments(frags, exclude_sources = character(0))
  expect_equal(product, seq)
})

test_that("ligate_fragments excludes waste correctly", {
  # Simulate gene block digestion: terminal waste, middle productive
  oh_L <- "ATGG"
  oh_R <- "CTAA"
  fwd <- orient_enzyme_site("BsaI", oh_L, "forward")
  rev <- orient_enzyme_site("BsaI", oh_R, "reverse")
  block <- paste0(fwd, "MYGENESEQUENCE", rev)

  frags <- digest_linear(block, "BsaI", source_label = "block")
  frags <- mark_terminal_waste(frags)

  # Should have 3 fragments: waste, productive, waste
  expect_equal(length(frags), 3L)
  expect_equal(frags[[1]]$source, "waste")
  expect_equal(frags[[2]]$source, "block")
  expect_equal(frags[[3]]$source, "waste")

  # Ligate with another fragment that provides matching overhangs
  # Create start/end fragments to complete the chain
  start_frag <- list(body = "START", oh_5 = NA_character_, oh_3 = oh_L,
                      source = "start")
  end_frag <- list(body = "END", oh_5 = oh_R, oh_3 = NA_character_,
                    source = "end")

  all_frags <- c(list(start_frag), frags, list(end_frag))
  product <- ligate_fragments(all_frags, exclude_sources = "waste")

  # Product should be: START + productive_body + END
  expect_true(startsWith(product, "START"))
  expect_true(endsWith(product, "END"))
  expect_true(grepl("MYGENESEQUENCE", product, fixed = TRUE))
})

test_that("ligate_fragments errors on ambiguous overhangs", {
  # Two fragments with the same oh_5
  frags <- list(
    list(body = "START", oh_5 = NA_character_, oh_3 = "ATGG", source = "a"),
    list(body = "DUP1", oh_5 = "ATGG", oh_3 = NA_character_, source = "b"),
    list(body = "DUP2", oh_5 = "ATGG", oh_3 = NA_character_, source = "c")
  )

  expect_error(ligate_fragments(frags, exclude_sources = character(0)),
               "Ambiguous")
})

test_that("ligate_fragments errors on missing overhang match", {
  frags <- list(
    list(body = "START", oh_5 = NA_character_, oh_3 = "ATGG", source = "a"),
    list(body = "WRONG", oh_5 = "CCCC", oh_3 = NA_character_, source = "b")
  )

  expect_error(ligate_fragments(frags, exclude_sources = character(0)),
               "no fragment found")
})

test_that("ligate_fragments errors when no start fragment", {
  frags <- list(
    list(body = "A", oh_5 = "ATGG", oh_3 = "CCCC", source = "a"),
    list(body = "B", oh_5 = "CCCC", oh_3 = "TTTT", source = "b")
  )

  expect_error(ligate_fragments(frags, exclude_sources = character(0)),
               "No start fragment")
})

# =============================================================================
# Integration Tests: Full assembly simulation
# =============================================================================

test_that("TEST_GENE_SEQ full assembly simulation succeeds", {
  # Run the pipeline up to gene blocks, then simulate assembly
  cu <- TEST_CODON_USAGE
  cds <- domesticate_test_gene(polIII = TEST_POLIII)

  tile_size <- compute_max_tile_size(300, 12)
  plan <- plan_assembly(cds, TEST_POLIII, tile_size,
    config = list(oh_L = "TGAA"))
  tiles <- plan$tiles
  oh3 <- plan$oh3
  oh4 <- plan$oh4

  variants <- design_mutations(cds, cu)
  variants <- check_and_fix_new_sites(variants, cds, cu)
  variants <- assign_variants_to_tiles(variants, tiles)

  # Design barcodes
  barcode_result <- design_barcodes(
    n_variants = nrow(variants),
    barcode_length = 12L,
    min_hamming = 3L,
    prefix_length = 12L,
    barcodes_per_variant = 1L
  )
  barcodes <- barcode_result$barcodes

  # Assemble oligos (pass full_seq for oh_R cassette extension on last tile)
  oligos <- assemble_oligos(variants, cds, barcodes, tiles, oh3, oh4,
    full_seq = plan$full_seq)

  # Design gene blocks
  gb_result <- design_wt_geneblocks(
    cds = cds, polIII = TEST_POLIII, tiles = tiles,
    oh3 = oh3, oh4 = oh4,
    paqci_star2 = "AGTC", paqci_star1 = "TCGA",
    assembly_plan = plan
  )

  # Simulate assembly for each tile (1 random variant per tile, old behavior)
  sim_results <- simulate_pipeline_assembly(
    oligos = oligos,
    geneblock_result = gb_result,
    tiles = tiles,
    variants = variants,
    barcodes = barcodes,
    cds = cds,
    polIII = TEST_POLIII,
    assembly_plan = plan,
    samples_per_tile = 1L,
    targeted_sampling = FALSE,
    strict_verification = FALSE
  )

  # All tiles should assemble correctly
  expect_true(nrow(sim_results) > 0,
              info = "Should have simulation results")
  n_pass <- sum(sim_results$pass, na.rm = TRUE)
  n_total <- nrow(sim_results)
  # Build detailed failure info for diagnostics
  fail_rows <- sim_results[!sim_results$pass | is.na(sim_results$pass), , drop = FALSE]
  fail_detail <- if (nrow(fail_rows) > 0) {
    paste(sprintf("tile=%s variant=%s error=%s mut_gene=%s polIII=%s bc=%s order=%s",
                  fail_rows$tile_id, fail_rows$variant_id,
                  fail_rows$error, fail_rows$has_mut_gene,
                  fail_rows$has_polIII, fail_rows$has_barcode,
                  fail_rows$correct_order),
          collapse = " | ")
  } else { "none" }
  expect_equal(n_pass, n_total,
               info = paste0("All tiles should pass: ", n_pass, "/", n_total,
                             ". Detail: ", fail_detail))
})

test_that("TEST_LONG_GENE_SEQ assembly simulation runs with collision-aware boundaries", {
  # With oogga_two_pass, the collision-aware algorithm avoids overhang identity
  # collisions, so ambiguous ligation errors should not occur. This test verifies
  # the simulator runs and produces results for a long gene with superblocking.
  cu <- TEST_CODON_USAGE
  cds <- TEST_LONG_GENE_SEQ

  tile_size <- compute_max_tile_size(300, 12)
  plan <- plan_assembly(cds, TEST_POLIII, tile_size,
    config = list(oh_L = "TGAA"))
  tiles <- plan$tiles
  oh3 <- plan$oh3
  oh4 <- plan$oh4

  variants <- design_mutations(cds, cu)
  variants <- check_and_fix_new_sites(variants, cds, cu)
  variants <- assign_variants_to_tiles(variants, tiles)

  barcode_result <- design_barcodes(
    n_variants = nrow(variants),
    barcode_length = 12L,
    min_hamming = 3L,
    prefix_length = 12L,
    barcodes_per_variant = 1L
  )
  barcodes <- barcode_result$barcodes

  oligos <- assemble_oligos(variants, cds, barcodes, tiles, oh3, oh4,
    full_seq = plan$full_seq)

  gb_result <- design_wt_geneblocks(
    cds = cds, polIII = TEST_POLIII, tiles = tiles,
    oh3 = oh3, oh4 = oh4,
    paqci_star2 = "AGTC", paqci_star1 = "TCGA",
    assembly_plan = plan
  )

  sim_results <- simulate_pipeline_assembly(
    oligos = oligos,
    geneblock_result = gb_result,
    tiles = tiles,
    variants = variants,
    barcodes = barcodes,
    cds = cds,
    polIII = TEST_POLIII,
    assembly_plan = plan,
    samples_per_tile = 1L,
    targeted_sampling = FALSE,
    strict_verification = FALSE
  )

  # Simulator should produce results for all sampled tiles
  expect_true(nrow(sim_results) > 0)

  # With collision-aware boundaries, no failures should be due to ambiguous overhangs
  if (any(!sim_results$pass, na.rm = TRUE)) {
    errors <- sim_results$error[!sim_results$pass & !is.na(sim_results$error)]
    expect_false(any(grepl("Ambiguous|ambiguous", errors)),
                 info = "OOGGA should prevent ambiguous overhang collisions")
  }
})

# =============================================================================
# Unit Tests: select_junctional_variants
# =============================================================================

test_that("select_junctional_variants picks edge + interior positions", {
  # Create a fake variants data frame with 20 positions across one tile
  n_positions <- 20L
  variants <- data.frame(
    position = rep(seq_len(n_positions), each = 19L),
    tile_id = rep(1L, n_positions * 19L),
    variant_id = paste0("v", seq_len(n_positions * 19L)),
    mut_codon = rep("AAA", n_positions * 19L),
    stringsAsFactors = FALSE
  )
  tile_var_idx <- seq_len(nrow(variants))
  tile <- data.frame(tile_id = 1L)

  set.seed(42)
  selected <- select_junctional_variants(tile_var_idx, variants, tile,
                                          overlap_codons = 6L)

  # Should get 3 oh1-side + 3 oh2-side + 1 interior = 7 variants
  expect_equal(length(selected), 7L)

  # Check that selected positions include first 3 and last 3
  selected_positions <- sort(variants$position[selected])
  expect_equal(selected_positions[1:3], c(1L, 2L, 3L))
  expect_equal(selected_positions[5:7], c(18L, 19L, 20L))
})

test_that("select_junctional_variants returns all when tile is small", {
  # Tile with only 5 unique positions (< 2*3 + 1 = 7)
  variants <- data.frame(
    position = rep(1:5, each = 19L),
    tile_id = rep(1L, 5L * 19L),
    variant_id = paste0("v", seq_len(5L * 19L)),
    mut_codon = rep("AAA", 5L * 19L),
    stringsAsFactors = FALSE
  )
  tile_var_idx <- seq_len(nrow(variants))
  tile <- data.frame(tile_id = 1L)

  selected <- select_junctional_variants(tile_var_idx, variants, tile,
                                          overlap_codons = 6L)

  # Should return one variant per position = 5 variants
  expect_equal(length(selected), 5L)
  expect_equal(length(unique(variants$position[selected])), 5L)
})

test_that("select_junctional_variants picks 1 variant per position", {
  # Multiple variants at same position — should pick only 1
  variants <- data.frame(
    position = rep(c(1, 2, 3, 10, 20, 21, 22), each = 5L),
    tile_id = rep(1L, 35L),
    variant_id = paste0("v", seq_len(35L)),
    mut_codon = rep("AAA", 35L),
    stringsAsFactors = FALSE
  )
  tile_var_idx <- seq_len(nrow(variants))
  tile <- data.frame(tile_id = 1L)

  selected <- select_junctional_variants(tile_var_idx, variants, tile,
                                          overlap_codons = 4L)

  # overlap_codons=4 → 2 oh1-side + 2 oh2-side + 1 interior = 5
  # But only 7 unique positions total. 2+2+1 = 5, and 7 > 5, so subset
  expect_equal(length(selected), 5L)
  # Each selected index maps to a unique position
  expect_equal(length(unique(variants$position[selected])),
               length(selected))
})

# =============================================================================
# Unit Tests: build_expected_product
# =============================================================================

test_that("build_expected_product constructs correct product structure", {
  # Use a minimal example to verify the formula
  cds <- "ATGGCTGAATAA"  # 4 codons
  variant_row <- data.frame(position = 2L, mut_codon = "TTT",
                             stringsAsFactors = FALSE)
  barcode <- "AACCGGTTAACC"
  cassette <- "CASSETTECONTENT"
  oh3 <- "ACTA"
  left_cap <- "LEFTCAP"
  right_cap <- "RIGHTCAP"

  expected <- build_expected_product(variant_row, barcode, cds,
                                      cassette, oh3, left_cap, right_cap)

  # Verify structure: left_cap + mutant_cds + cassette + oh3 + barcode + right_cap
  mutant_cds <- replace_codon(cds, 2L, "TTT")
  expect_equal(expected,
               paste0("LEFTCAP", mutant_cds, "CASSETTECONTENT", "ACTA",
                      "AACCGGTTAACC", "RIGHTCAP"))
})

# =============================================================================
# Key Invariant Test: build_expected_product == simulate_tile_assembly
# =============================================================================

test_that("build_expected_product matches simulate_tile_assembly for TEST_GENE_SEQ", {
  # This is the critical invariant: the first-principles formula must produce
  # the same result as the full digestion+ligation simulation.
  cu <- TEST_CODON_USAGE
  cds <- domesticate_test_gene(polIII = TEST_POLIII)

  tile_size <- compute_max_tile_size(300, 12)
  plan <- plan_assembly(cds, TEST_POLIII, tile_size)
  tiles <- plan$tiles
  oh3 <- plan$oh3
  oh4 <- plan$oh4

  variants <- design_mutations(cds, cu)
  variants <- check_and_fix_new_sites(variants, cds, cu)
  variants <- assign_variants_to_tiles(variants, tiles)

  barcode_result <- design_barcodes(
    n_variants = nrow(variants),
    barcode_length = 12L,
    min_hamming = 3L,
    prefix_length = 12L,
    barcodes_per_variant = 1L
  )
  barcodes <- barcode_result$barcodes

  oligos <- assemble_oligos(variants, cds, barcodes, tiles, oh3, oh4,
    full_seq = plan$full_seq)

  gb_result <- design_wt_geneblocks(
    cds = cds, polIII = TEST_POLIII, tiles = tiles,
    oh3 = oh3, oh4 = oh4,
    paqci_star2 = "AGTC", paqci_star1 = "TCGA",
    assembly_plan = plan
  )

  helper_insert_seq <- gb_result$helper_plasmid$sequence

  # Pre-compute helper caps
  helper_frags <- digest_linear(helper_insert_seq, "BsaI", source_label = "helper")
  helper_left_cap <- helper_frags[[1]]$body
  helper_right_cap <- helper_frags[[length(helper_frags)]]$body

  # Determine cassette_for_block (same logic as simulate_pipeline_assembly)
  cassette_for_block <- if (!is.null(plan$core_downstream_cassette)) {
    plan$core_downstream_cassette
  } else if (!is.null(plan$core_polIII)) {
    plan$core_polIII
  } else {
    TEST_POLIII
  }

  # Test invariant: for every tile, first variant must produce identical product
  for (t in seq_len(nrow(tiles))) {
    tile_id <- tiles$tile_id[t]
    tile_var_idx <- which(variants$tile_id == tile_id)
    if (length(tile_var_idx) == 0) next

    vi <- tile_var_idx[1]

    # Get block sequences
    manifest <- gb_result$tile_manifests[
      gb_result$tile_manifests$tile_id == tile_id, , drop = FALSE]
    bsai_names <- if (nzchar(manifest$bsai_parts)) {
      strsplit(manifest$bsai_parts, ";")[[1]]
    } else {
      character(0)
    }
    bsmbi_names <- strsplit(manifest$bsmbi_parts, ";")[[1]]
    bsai_block_seqs <- gb_result$blocks$sequence[
      match(bsai_names, gb_result$blocks$block_name)]
    bsmbi_block_seqs <- gb_result$blocks$sequence[
      match(bsmbi_names, gb_result$blocks$block_name)]

    # Simulated product (full digestion + ligation)
    sim_product <- simulate_tile_assembly(
      oligo_seq = oligos$sequence[vi],
      helper_insert_seq = helper_insert_seq,
      bsai_block_seqs = bsai_block_seqs,
      bsmbi_block_seqs = bsmbi_block_seqs
    )

    # Expected product (first-principles formula, overlap-aware)
    exp_product <- build_expected_product(
      variant_row = variants[vi, , drop = FALSE],
      barcode = barcodes[vi],
      cds = cds,
      cassette_for_block = cassette_for_block,
      oh3 = oh3,
      helper_left_cap = helper_left_cap,
      helper_right_cap = helper_right_cap,
      tile_start_nt = tiles$start_nt[t],
      tile_end_nt = tiles$end_nt[t]
    )

    expect_identical(sim_product, exp_product,
      info = paste0("Tile ", tile_id, " variant ", variants$variant_id[vi],
                    ": simulated product must match expected product"))
  }
})

# =============================================================================
# Unit Tests: verify_assembly_product_strict
# =============================================================================

test_that("verify_assembly_product_strict passes on correct product", {
  # Build a synthetic correct product
  paqci_star2 <- "AGTC"
  paqci_star1 <- "TCGA"
  paqci_fwd <- orient_enzyme_site("PaqCI", paqci_star2, "forward")
  paqci_rev <- orient_enzyme_site("PaqCI", paqci_star1, "reverse")
  bsai_fwd_tail <- paste0(ENZYMES$BsaI$recog,
    paste(rep("A", ENZYMES$BsaI$spacer_len), collapse = ""))
  # Right cap: oh4 + spacer + RC(recog) + PaqCI_rev
  oh4 <- "GCAT"
  bsai_rev_head <- orient_enzyme_site("BsaI", oh4, "reverse")
  # Compute the actual cap strings from helper structure
  left_cap <- paste0(paqci_fwd, bsai_fwd_tail)
  right_cap <- paste0(bsai_rev_head, paqci_rev)

  cds <- "ATGGCTGAATAA"  # 4 codons
  cassette <- "CASSETTECONTENT"
  oh3 <- "ACTA"
  barcode <- "AACCGGTTAACC"
  mut_position <- 2L
  mut_codon <- "TTT"

  mutant_cds <- replace_codon(cds, mut_position, mut_codon)
  product <- paste0(left_cap, mutant_cds, cassette, oh3, barcode, right_cap)

  result <- verify_assembly_product_strict(
    product = product,
    expected = product,
    expected_cds = cds,
    mut_position = mut_position,
    mut_codon = mut_codon,
    cassette_for_block = cassette,
    barcode = barcode,
    oh3 = oh3,
    paqci_star2 = paqci_star2,
    paqci_star1 = paqci_star1,
    helper_left_cap_len = nchar(left_cap),
    helper_right_cap_len = nchar(right_cap)
  )

  expect_true(result$pass)
  expect_true(result$correct_length)
  expect_true(result$exact_match)
  expect_true(result$no_internal_enzyme_sites)
  expect_true(result$paqci_flanks_present)
  expect_true(result$no_duplications)
  expect_true(is.na(result$first_mismatch_pos))
})

test_that("verify_assembly_product_strict catches length mismatch", {
  product <- "AAAA"
  expected <- "AAAAAA"

  result <- verify_assembly_product_strict(
    product = product,
    expected = expected,
    expected_cds = "ATG",
    mut_position = 1L,
    mut_codon = "ATG",
    cassette_for_block = "",
    barcode = "",
    oh3 = "",
    paqci_star2 = "AGTC",
    paqci_star1 = "TCGA",
    helper_left_cap_len = 0L,
    helper_right_cap_len = 0L
  )

  expect_false(result$pass)
  expect_false(result$correct_length)
  expect_equal(result$product_length, 4L)
  expect_equal(result$expected_length, 6L)
})

test_that("verify_assembly_product_strict catches sequence mismatch", {
  product <- "AACCTT"
  expected <- "AACCGG"

  result <- verify_assembly_product_strict(
    product = product,
    expected = expected,
    expected_cds = "AAC",
    mut_position = 1L,
    mut_codon = "AAC",
    cassette_for_block = "",
    barcode = "",
    oh3 = "",
    paqci_star2 = "AGTC",
    paqci_star1 = "TCGA",
    helper_left_cap_len = 0L,
    helper_right_cap_len = 0L
  )

  expect_false(result$pass)
  expect_true(result$correct_length)
  expect_false(result$exact_match)
  expect_equal(result$first_mismatch_pos, 5L)
})

test_that("verify_assembly_product_strict detects internal enzyme sites", {
  # Build a product with a BsmBI site (CGTCTC) in the payload
  paqci_star2 <- "AGTC"
  paqci_star1 <- "TCGA"
  paqci_fwd <- orient_enzyme_site("PaqCI", paqci_star2, "forward")
  paqci_rev <- orient_enzyme_site("PaqCI", paqci_star1, "reverse")
  bsai_fwd_tail <- paste0(ENZYMES$BsaI$recog,
    paste(rep("A", ENZYMES$BsaI$spacer_len), collapse = ""))
  oh4 <- "GCAT"
  bsai_rev_head <- orient_enzyme_site("BsaI", oh4, "reverse")
  left_cap <- paste0(paqci_fwd, bsai_fwd_tail)
  right_cap <- paste0(bsai_rev_head, paqci_rev)

  # Payload deliberately contains BsmBI site
  payload <- paste0("AAACGTCTCAAA", "CASSETTE", "ACTA", "AACCGGTTAACC")
  product <- paste0(left_cap, payload, right_cap)

  result <- verify_assembly_product_strict(
    product = product,
    expected = product,
    expected_cds = "AAACGTCTCAAA",
    mut_position = 1L,
    mut_codon = "AAA",
    cassette_for_block = "CASSETTE",
    barcode = "AACCGGTTAACC",
    oh3 = "ACTA",
    paqci_star2 = paqci_star2,
    paqci_star1 = paqci_star1,
    helper_left_cap_len = nchar(left_cap),
    helper_right_cap_len = nchar(right_cap)
  )

  expect_false(result$no_internal_enzyme_sites)
  expect_true(grepl("BsmBI", result$internal_sites_found))
})

test_that("verify_assembly_product_strict detects missing PaqCI flanks", {
  product <- "AAAAAATTTTTT"
  expected <- "AAAAAATTTTTT"

  result <- verify_assembly_product_strict(
    product = product,
    expected = expected,
    expected_cds = "AAA",
    mut_position = 1L,
    mut_codon = "AAA",
    cassette_for_block = "",
    barcode = "",
    oh3 = "",
    paqci_star2 = "AGTC",
    paqci_star1 = "TCGA",
    helper_left_cap_len = 0L,
    helper_right_cap_len = 0L
  )

  expect_false(result$paqci_flanks_present)
})

# =============================================================================
# Integration: Targeted sampling + strict verification with TEST_GENE_SEQ
# =============================================================================

test_that("simulate_pipeline_assembly with strict verification passes for TEST_GENE_SEQ", {
  cu <- TEST_CODON_USAGE
  cds <- domesticate_test_gene(polIII = TEST_POLIII)

  tile_size <- compute_max_tile_size(300, 12)
  plan <- plan_assembly(cds, TEST_POLIII, tile_size)
  tiles <- plan$tiles
  oh3 <- plan$oh3
  oh4 <- plan$oh4

  variants <- design_mutations(cds, cu)
  variants <- check_and_fix_new_sites(variants, cds, cu)
  variants <- assign_variants_to_tiles(variants, tiles)

  barcode_result <- design_barcodes(
    n_variants = nrow(variants),
    barcode_length = 12L,
    min_hamming = 3L,
    prefix_length = 12L,
    barcodes_per_variant = 1L
  )
  barcodes <- barcode_result$barcodes

  oligos <- assemble_oligos(variants, cds, barcodes, tiles, oh3, oh4,
    full_seq = plan$full_seq)

  gb_result <- design_wt_geneblocks(
    cds = cds, polIII = TEST_POLIII, tiles = tiles,
    oh3 = oh3, oh4 = oh4,
    paqci_star2 = "AGTC", paqci_star1 = "TCGA",
    assembly_plan = plan
  )

  sim_results <- simulate_pipeline_assembly(
    oligos = oligos,
    geneblock_result = gb_result,
    tiles = tiles,
    variants = variants,
    barcodes = barcodes,
    cds = cds,
    polIII = TEST_POLIII,
    assembly_plan = plan,
    targeted_sampling = TRUE,
    strict_verification = TRUE,
    paqci_star2 = "AGTC",
    paqci_star1 = "TCGA"
  )

  # Should have multiple variants per tile (junctional sampling)
  expect_true(nrow(sim_results) > nrow(tiles),
    info = "Targeted sampling should select multiple variants per tile")

  # Coarse check may fail for boundary-overlap variants (codons straddling
  # oh1/oh2 regions produce partial mutations that grepl can't match).
  # This is expected — strict verification is the authoritative check.
  n_pass <- sum(sim_results$pass, na.rm = TRUE)
  n_total <- nrow(sim_results)
  if (n_pass < n_total) {
    fail_rows <- sim_results[!sim_results$pass | is.na(sim_results$pass), , drop = FALSE]
    # All coarse failures should still pass strict (partial overlap, not real error)
    if (any(!is.na(fail_rows$strict_pass))) {
      expect_true(all(fail_rows$strict_pass[!is.na(fail_rows$strict_pass)]),
        info = "Coarse failures should still pass strict verification (boundary overlap)")
    }
  }

  # All strict checks MUST pass — this is the authoritative verification
  n_strict_pass <- sum(sim_results$strict_pass, na.rm = TRUE)
  n_strict_total <- sum(!is.na(sim_results$strict_pass))
  strict_fail <- sim_results[!is.na(sim_results$strict_pass) & !sim_results$strict_pass, ,
                              drop = FALSE]
  strict_detail <- if (nrow(strict_fail) > 0) {
    paste(sprintf("tile=%s var=%s len=%s exact=%s enz=%s paqci=%s dup=%s mm@%s",
                  strict_fail$tile_id, strict_fail$variant_id,
                  strict_fail$correct_length, strict_fail$exact_match,
                  strict_fail$no_internal_enzyme_sites, strict_fail$paqci_flanks_present,
                  strict_fail$no_duplications, strict_fail$first_mismatch_pos),
          collapse = " | ")
  } else { "none" }
  expect_equal(n_strict_pass, n_strict_total,
    info = paste0("Strict: ", n_strict_pass, "/", n_strict_total,
                  ". Failures: ", strict_detail))
})

test_that("simulate_pipeline_assembly with strict verification passes for TEST_LONG_GENE_SEQ", {
  cu <- TEST_CODON_USAGE
  cds <- TEST_LONG_GENE_SEQ

  tile_size <- compute_max_tile_size(300, 12)
  plan <- plan_assembly(cds, TEST_POLIII, tile_size)
  tiles <- plan$tiles
  oh3 <- plan$oh3
  oh4 <- plan$oh4

  variants <- design_mutations(cds, cu)
  variants <- check_and_fix_new_sites(variants, cds, cu)
  variants <- assign_variants_to_tiles(variants, tiles)

  barcode_result <- design_barcodes(
    n_variants = nrow(variants),
    barcode_length = 12L,
    min_hamming = 3L,
    prefix_length = 12L,
    barcodes_per_variant = 1L
  )
  barcodes <- barcode_result$barcodes

  oligos <- assemble_oligos(variants, cds, barcodes, tiles, oh3, oh4,
    full_seq = plan$full_seq)

  gb_result <- design_wt_geneblocks(
    cds = cds, polIII = TEST_POLIII, tiles = tiles,
    oh3 = oh3, oh4 = oh4,
    paqci_star2 = "AGTC", paqci_star1 = "TCGA",
    assembly_plan = plan
  )

  sim_results <- simulate_pipeline_assembly(
    oligos = oligos,
    geneblock_result = gb_result,
    tiles = tiles,
    variants = variants,
    barcodes = barcodes,
    cds = cds,
    polIII = TEST_POLIII,
    assembly_plan = plan,
    targeted_sampling = TRUE,
    strict_verification = TRUE,
    paqci_star2 = "AGTC",
    paqci_star1 = "TCGA"
  )

  expect_true(nrow(sim_results) > 0)

  # With collision-aware boundaries, no ambiguous overhang errors
  if (any(!sim_results$pass, na.rm = TRUE)) {
    errors <- sim_results$error[!sim_results$pass & !is.na(sim_results$error)]
    expect_false(any(grepl("Ambiguous|ambiguous", errors)),
                 info = "OOGGA should prevent ambiguous overhang collisions")
  }

  # Strict verification should pass for all simulated variants
  n_strict_pass <- sum(sim_results$strict_pass, na.rm = TRUE)
  n_strict_total <- sum(!is.na(sim_results$strict_pass))
  strict_fail <- sim_results[!is.na(sim_results$strict_pass) & !sim_results$strict_pass, ,
                              drop = FALSE]
  strict_detail <- if (nrow(strict_fail) > 0) {
    paste(sprintf("tile=%s var=%s exact=%s mm@%s",
                  strict_fail$tile_id, strict_fail$variant_id,
                  strict_fail$exact_match, strict_fail$first_mismatch_pos),
          collapse = " | ")
  } else { "none" }
  expect_equal(n_strict_pass, n_strict_total,
    info = paste0("Strict: ", n_strict_pass, "/", n_strict_total,
                  ". Failures: ", strict_detail))
})

# =============================================================================
# Backward Compatibility: old callers still work
# =============================================================================

test_that("simulate_pipeline_assembly works with old signature (no new params)", {
  cu <- TEST_CODON_USAGE
  cds <- domesticate_test_gene(polIII = TEST_POLIII)

  tile_size <- compute_max_tile_size(300, 12)
  plan <- plan_assembly(cds, TEST_POLIII, tile_size)
  tiles <- plan$tiles
  oh3 <- plan$oh3
  oh4 <- plan$oh4

  variants <- design_mutations(cds, cu)
  variants <- check_and_fix_new_sites(variants, cds, cu)
  variants <- assign_variants_to_tiles(variants, tiles)

  barcode_result <- design_barcodes(
    n_variants = nrow(variants),
    barcode_length = 12L,
    min_hamming = 3L,
    prefix_length = 12L,
    barcodes_per_variant = 1L
  )
  barcodes <- barcode_result$barcodes

  oligos <- assemble_oligos(variants, cds, barcodes, tiles, oh3, oh4,
    full_seq = plan$full_seq)

  gb_result <- design_wt_geneblocks(
    cds = cds, polIII = TEST_POLIII, tiles = tiles,
    oh3 = oh3, oh4 = oh4,
    paqci_star2 = "AGTC", paqci_star1 = "TCGA",
    assembly_plan = plan
  )

  # Call with ONLY the old parameters — new params use defaults
  sim_results <- simulate_pipeline_assembly(
    oligos = oligos,
    geneblock_result = gb_result,
    tiles = tiles,
    variants = variants,
    barcodes = barcodes,
    cds = cds,
    polIII = TEST_POLIII,
    assembly_plan = plan
  )

  # Should still produce valid results with the new columns
  expect_true(nrow(sim_results) > 0)
  expect_true("strict_pass" %in% names(sim_results))
  expect_true("exact_match" %in% names(sim_results))

  # Default is targeted_sampling=TRUE + strict_verification=TRUE.
  # Strict pass is the authoritative check (coarse may fail for boundary overlap)
  n_strict_pass <- sum(sim_results$strict_pass, na.rm = TRUE)
  n_strict_total <- sum(!is.na(sim_results$strict_pass))
  expect_equal(n_strict_pass, n_strict_total,
    info = "All strict checks should pass with default params")
})
