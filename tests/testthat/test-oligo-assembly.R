# test-oligo-assembly.R — Tests for 08_oligo_assembly.R (3-enzyme architecture)

test_that("assemble_oligos produces correct number of oligos", {
  cu <- TEST_CODON_USAGE
  cds <- "ATGGCTGAATAA" # 4 codons
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
  cu <- TEST_CODON_USAGE
  cds <- domesticate_test_gene()

  tile_size <- compute_max_tile_size(300, 12)
  tiles <- partition_tiles(cds, tile_size)
  variants <- design_mutations(cds, cu)
  variants <- assign_variants_to_tiles(variants, tiles)

  n <- nrow(variants)
  barcodes <- paste0(replicate(n, paste(sample(c("A", "C", "G", "T"), 12, replace = TRUE), collapse = "")))

  oh3 <- "ACTA"
  oh4 <- "GATA"

  oligos <- assemble_oligos(variants, cds, barcodes, tiles, oh3, oh4,
    max_oligo_length = 300
  )

  # All oligos should start with BsaI recognition
  for (i in seq_len(min(10, nrow(oligos)))) {
    expect_true(startsWith(oligos$sequence[i], "GGTCTCA"),
      info = paste("Oligo", i, "should start with BsaI fwd")
    )
  }
})
