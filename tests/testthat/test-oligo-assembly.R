# test-oligo-assembly.R — Tests for 08_oligo_assembly.R (3-enzyme architecture)

test_that("build_oligo produces correct universal structure", {
  oh1 <- "ATGG"
  oh2 <- "CTAA"
  oh3 <- "ACTA"
  oh4 <- "GATA"
  barcode <- "ACGTACGTACGT"
  mutable <- "GCTGAACTTAAAGCTGCC"  # 18 nt (6 codons)

  oligo <- build_oligo(mutable, barcode, oh1, oh2, oh3, oh4)

  # Should start with BsaI forward recognition
  expect_true(startsWith(oligo, "GGTCTCA"))  # GGTCTC + A spacer

  # Should contain oh1 right after BsaI
  expect_true(grepl(paste0("GGTCTCA", oh1), oligo))

  # Total length check
  # BsaI_5'(7) + oh1(4) + mutable(18) + BsmBI_rev_oh2(11) + BsmBI_fwd_oh3(11) + barcode(12) + BsaI_rev_oh4(11)
  expected_len <- 7 + 4 + 18 + 11 + 11 + 12 + 11
  expect_equal(nchar(oligo), expected_len)
})

test_that("build_oligo contains correct enzyme sites", {
  oh1 <- "ATGG"
  oh2 <- "CTAA"
  oh3 <- "ACTA"
  oh4 <- "GATA"
  barcode <- "ACGTACGTACGT"
  mutable <- "GCTGAACTTAAAGCTGCC"

  oligo <- build_oligo(mutable, barcode, oh1, oh2, oh3, oh4)

  # Should contain BsaI recognition (forward at 5')
  expect_true(grepl("GGTCTC", oligo))

  # Should contain BsmBI recognition (forward for oh3)
  expect_true(grepl("CGTCTC", oligo))

  # Should end with BsaI reverse site
  bsai_oh4_rev <- orient_enzyme_site("BsaI", oh4, "reverse")
  expect_true(endsWith(oligo, bsai_oh4_rev))
})

test_that("build_mutant_tile returns correct mutant sequence", {
  cds <- "ATGGCTGAATAA"  # 4 codons
  # Mutate codon 2 (GCT -> GGG)
  result <- build_mutant_tile(cds, 2, "GGG", 1, 12)
  expect_equal(result, "ATGGGGGAATAA")
})

test_that("assemble_oligos produces correct number of oligos", {
  cu <- builtin_human_codon_usage()
  cds <- "ATGGCTGAATAA"  # 4 codons
  variants <- design_mutations(cds, cu)
  tiles <- partition_tiles(cds, 300)
  variants <- assign_variants_to_tiles(variants, tiles)
  barcodes <- paste0("ACGTACGT", sprintf("%04d", seq_len(nrow(variants))))
  # Trim barcodes to 12 chars
  barcodes <- substring(barcodes, 1, 12)

  oh3 <- "ACTA"
  oh4 <- "GATA"

  oligos <- assemble_oligos(variants, cds, barcodes, tiles, oh3, oh4)

  expect_equal(nrow(oligos), nrow(variants))
  expect_true(all(nchar(oligos$sequence) > 0))
})

test_that("all oligos have same structure regardless of tile position", {
  cu <- builtin_human_codon_usage()
  scan_result <- scan_enzyme_sites(TEST_GENE_SEQ, "", cu)
  cds <- if (nrow(scan_result$domestication) > 0) {
    apply_domestication(TEST_GENE_SEQ, scan_result$domestication, codon_usage = cu)
  } else {
    TEST_GENE_SEQ
  }

  tile_size <- compute_max_tile_size(300, 12)
  tiles <- partition_tiles(cds, tile_size)
  variants <- design_mutations(cds, cu)
  variants <- assign_variants_to_tiles(variants, tiles)

  n <- nrow(variants)
  barcodes <- paste0(replicate(n, paste(sample(c("A","C","G","T"), 12, replace = TRUE), collapse = "")))

  oh3 <- "ACTA"
  oh4 <- "GATA"

  oligos <- assemble_oligos(variants, cds, barcodes, tiles, oh3, oh4,
                             max_oligo_length = 300)

  # All oligos should start with BsaI recognition
  for (i in seq_len(min(10, nrow(oligos)))) {
    expect_true(startsWith(oligos$sequence[i], "GGTCTCA"),
                info = paste("Oligo", i, "should start with BsaI fwd"))
  }
})
