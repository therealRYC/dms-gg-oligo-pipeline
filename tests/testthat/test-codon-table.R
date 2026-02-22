# Created: 2025-02-01
# Last updated: 2026-02-21 — Update for CoCoPUTs data, add CSV loading and validation tests
# test-codon-table.R — Tests for 03_codon_table.R

test_that("builtin_human_codon_usage returns valid table", {
  cu <- builtin_human_codon_usage()
  expect_equal(nrow(cu), 64)  # 64 codons
  expect_true(all(c("codon", "aa", "frequency") %in% names(cu)))
  expect_true(all(nchar(cu$codon) == 3))
  expect_true(all(cu$frequency > 0))
})

test_that("get_preferred_codons returns one per AA", {
  cu <- builtin_human_codon_usage()
  pref <- get_preferred_codons(cu)

  # Every standard AA + stop should be present
  for (aa in AA_ALL) {
    expect_true(aa %in% names(pref), info = paste("Missing preferred codon for", aa))
  }

  # Preferred codon for Met should be ATG (only codon)
  expect_equal(unname(pref["M"]), "ATG")
  # Preferred codon for Trp should be TGG (only codon)
  expect_equal(unname(pref["W"]), "TGG")
  # Preferred Leu should be CTG (36.06 per thousand in CoCoPUTs, highest)
  expect_equal(unname(pref["L"]), "CTG")
})

test_that("get_ranked_codons returns codons in frequency order", {
  cu <- builtin_human_codon_usage()
  ranked_leu <- get_ranked_codons("L", cu)
  expect_equal(ranked_leu[1], "CTG")  # Most frequent Leu codon
  expect_equal(length(ranked_leu), 6)  # 6 Leu codons
})

# --- CoCoPUTs canary test ---
# Specific frequency value to detect accidental reversion to Kazusa data.
# CoCoPUTs CTG(Leu) = 36.06; Kazusa CTG(Leu) = 39.6
test_that("builtin table uses CoCoPUTs data (canary)", {
  cu <- builtin_human_codon_usage()
  ctg_freq <- cu$frequency[cu$codon == "CTG"]
  # CoCoPUTs value: 36.06 (Kazusa was 39.6)
  expect_equal(ctg_freq, 36.06)
})

# --- CSV loading tests ---
test_that("load_codon_usage reads CSV files", {
  # Write the builtin table as a CSV to a temp file
  cu <- builtin_human_codon_usage()
  tmp <- tempfile(fileext = ".csv")
  on.exit(unlink(tmp), add = TRUE)
  write.csv(cu, tmp, row.names = FALSE)

  loaded <- load_codon_usage(tmp)
  expect_equal(nrow(loaded), 64)
  expect_equal(loaded$frequency, cu$frequency)
})

test_that("load_codon_usage reads RDS files", {
  cu <- builtin_human_codon_usage()
  tmp <- tempfile(fileext = ".rds")
  on.exit(unlink(tmp), add = TRUE)
  saveRDS(cu, tmp)

  loaded <- load_codon_usage(tmp)
  expect_equal(nrow(loaded), 64)
  expect_equal(loaded$frequency, cu$frequency)
})

test_that("load_codon_usage rejects unsupported extensions", {
  tmp <- tempfile(fileext = ".txt")
  on.exit(unlink(tmp), add = TRUE)
  writeLines("dummy", tmp)

  expect_error(load_codon_usage(tmp), "Unsupported codon table format")
})

# --- validate_codon_table tests ---
test_that("validate_codon_table accepts valid table", {
  cu <- builtin_human_codon_usage()
  expect_silent(validate_codon_table(cu))
})

test_that("validate_codon_table rejects missing columns", {
  bad <- data.frame(codon = "ATG", aa = "M")  # missing frequency
  expect_error(validate_codon_table(bad), "Missing required columns.*frequency")
})

test_that("validate_codon_table rejects wrong row count", {
  cu <- builtin_human_codon_usage()
  bad <- cu[1:10, ]  # only 10 rows
  expect_error(validate_codon_table(bad), "Expected 64 rows")
})

test_that("validate_codon_table rejects invalid codons", {
  cu <- builtin_human_codon_usage()
  cu$codon[1] <- "XYZ"
  expect_error(validate_codon_table(cu), "Invalid codons")
})

test_that("validate_codon_table rejects duplicate codons", {
  cu <- builtin_human_codon_usage()
  cu$codon[2] <- cu$codon[1]  # duplicate

  expect_error(validate_codon_table(cu), "Duplicate codons")
})

test_that("validate_codon_table rejects negative frequencies", {
  cu <- builtin_human_codon_usage()
  cu$frequency[1] <- -1
  expect_error(validate_codon_table(cu), "non-negative")
})

test_that("validate_codon_table rejects NA frequencies", {
  cu <- builtin_human_codon_usage()
  cu$frequency[1] <- NA
  expect_error(validate_codon_table(cu), "NA values")
})

test_that("load_codon_usage validates CSV content", {
  # Create a CSV with wrong structure
  bad <- data.frame(x = 1:64, y = letters[1:64], z = runif(64))
  tmp <- tempfile(fileext = ".csv")
  on.exit(unlink(tmp), add = TRUE)
  write.csv(bad, tmp, row.names = FALSE)

  expect_error(load_codon_usage(tmp), "Missing required columns")
})
