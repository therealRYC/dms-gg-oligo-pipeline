# test-gene-input.R — Tests for 01_gene_input.R

test_that("validate_cds passes valid CDS", {
  # Simple valid CDS: ATG + codons + stop
  expect_silent(validate_cds("ATGGCTTAA", "test"))
  expect_silent(validate_cds(TEST_GENE_SEQ, "test_gene"))
})

test_that("validate_cds rejects non-ATG start", {
  expect_error(validate_cds("GCGATTTAA", "test"), "ATG")
})

test_that("validate_cds rejects non-divisible-by-3 length", {
  expect_error(validate_cds("ATGGC", "test"), "divisible by 3")
})

test_that("validate_cds rejects internal stops", {
  # TAA at position 2 (internal)
  expect_error(validate_cds("ATGTAAGCTTAA", "test"), "Internal stop")
})

test_that("validate_cds rejects non-ACGT characters", {
  expect_error(validate_cds("ATGNNN", "test"), "non-ACGT")
})

test_that("read_gene works with a temp FASTA file", {
  tmp <- tempfile(fileext = ".fasta")
  writeLines(c(">test_gene", "ATGGCTGAATAA"), tmp)

  result <- read_gene(tmp)
  expect_equal(result$cds, "ATGGCTGAATAA")
  expect_equal(result$gene_name, "test_gene")
  expect_equal(result$n_codons, 4L)
  expect_equal(result$protein, "MAE")  # M, A, E (stop removed)

  unlink(tmp)
})
