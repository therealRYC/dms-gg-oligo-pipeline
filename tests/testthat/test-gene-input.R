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
  expect_equal(result$gene_description, "test_gene")
  expect_equal(result$n_codons, 4L)
  expect_equal(result$protein, "MAE")  # M, A, E (stop removed)

  unlink(tmp)
})

test_that("read_gene extracts short gene_name from multi-word FASTA header", {
  tmp <- tempfile(fileext = ".fasta")
  writeLines(c(">GRIN2A_NM_000833 Human GRIN2A coding sequence (CDS)", "ATGGCTGAATAA"), tmp)

  result <- read_gene(tmp)
  # gene_name = first whitespace-delimited token
 expect_equal(result$gene_name, "GRIN2A_NM_000833")
  # gene_description = full header for traceability
  expect_equal(result$gene_description, "GRIN2A_NM_000833 Human GRIN2A coding sequence (CDS)")

  unlink(tmp)
})

test_that("read_gene_from_string works with valid CDS", {
  result <- read_gene_from_string("ATGGCTGAATAA", "my_gene")
  expect_equal(result$cds, "ATGGCTGAATAA")
  expect_equal(result$gene_name, "my_gene")
  expect_equal(result$gene_description, "my_gene")
  expect_equal(result$n_codons, 4L)
  expect_equal(result$protein, "MAE")
})

test_that("read_gene_from_string handles lowercase and whitespace", {
  result <- read_gene_from_string("  atggctgaataa  ", "trimmed")
  expect_equal(result$cds, "ATGGCTGAATAA")
  expect_equal(result$gene_name, "trimmed")
})

test_that("read_gene_from_string rejects invalid CDS", {
  expect_error(read_gene_from_string("GCGATTTAA", "test"), "ATG")
  expect_error(read_gene_from_string("ATGGC", "test"), "divisible by 3")
})
