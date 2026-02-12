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
  # Preferred Leu should be CTG (39.6 per thousand, highest)
  expect_equal(unname(pref["L"]), "CTG")
})

test_that("get_ranked_codons returns codons in frequency order", {
  cu <- builtin_human_codon_usage()
  ranked_leu <- get_ranked_codons("L", cu)
  expect_equal(ranked_leu[1], "CTG")  # Most frequent Leu codon
  expect_equal(length(ranked_leu), 6)  # 6 Leu codons
})
