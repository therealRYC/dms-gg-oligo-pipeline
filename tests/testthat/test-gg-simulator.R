# Created: 2026-02-21
# Last updated: 2026-02-21 — Initial simulator tests
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
  cu <- builtin_human_codon_usage()
  scan_result <- scan_enzyme_sites(TEST_GENE_SEQ, TEST_POLIII, cu)
  cds <- if (nrow(scan_result$domestication) > 0) {
    apply_domestication(TEST_GENE_SEQ, scan_result$domestication, codon_usage = cu)
  } else {
    TEST_GENE_SEQ
  }

  tile_size <- compute_max_tile_size(300, 12)
  plan <- plan_assembly(cds, TEST_POLIII, tile_size)
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

  # Simulate assembly for each tile (1 variant per tile)
  sim_results <- simulate_pipeline_assembly(
    oligos = oligos,
    geneblock_result = gb_result,
    tiles = tiles,
    variants = variants,
    barcodes = barcodes,
    cds = cds,
    polIII = TEST_POLIII,
    assembly_plan = plan,
    samples_per_tile = 1L
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
  cu <- builtin_human_codon_usage()
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
    samples_per_tile = 1L
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
