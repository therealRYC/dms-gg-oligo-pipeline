# test-mutation-design.R — Tests for 04_mutation_design.R

test_that("design_mutations generates correct number of variants", {
  # Small test: 4-codon CDS (ATG GCT GAA TAA = M A E *)
  cds <- "ATGGCTGAATAA"
  cu <- builtin_human_codon_usage()
  variants <- design_mutations(cds, cu)

  # Mutable positions: codons 2 to (n_codons - 1) = codons 2-3 (skip Met@1, stop@4)
  # 2 mutable codons * 20 mutations each = 40 variants
  expect_equal(nrow(variants), 2 * 20)
})

test_that("design_mutations produces correct variant IDs", {
  cds <- "ATGGCTTAA"  # M A *
  cu <- builtin_human_codon_usage()
  variants <- design_mutations(cds, cu)

  # Only codon 2 (A) is mutable — codon 1 (Met) and codon 3 (stop) are skipped
  expect_equal(nrow(variants), 1 * 20)
  expect_true("A2G" %in% variants$variant_id)
  # Met (codon 1) and stop (codon 3) should NOT be in variants
  expect_false("M1A" %in% variants$variant_id)
  expect_false("M1*" %in% variants$variant_id)
})

test_that("mutations use preferred human codons", {
  cds <- "ATGGCTTAA"
  cu <- builtin_human_codon_usage()
  pref <- get_preferred_codons(cu)
  variants <- design_mutations(cds, cu)

  # Each mut_codon should be the preferred codon for mut_aa
  for (i in seq_len(nrow(variants))) {
    expected_codon <- pref[variants$mut_aa[i]]
    expect_equal(variants$mut_codon[i], unname(expected_codon),
                 info = paste("Variant:", variants$variant_id[i]))
  }
})
