# test-mutation-design.R — Tests for 04_mutation_design.R

test_that("design_mutations generates correct number of variants", {
  # Small test: 4-codon CDS (ATG GCT GAA TAA = M A E *)
  cds <- "ATGGCTGAATAA"
  cu <- builtin_human_codon_usage()
  variants <- design_mutations(cds, cu)

  # 4 codons * 20 mutations each = 80 variants
  # Position 4 is * (stop), which has 20 non-* targets (all 20 AA)
  # Positions 1-3 are M, A, E: each gets 19 AA + 1 stop = 20
  expect_equal(nrow(variants), 4 * 20)
})

test_that("design_mutations produces correct variant IDs", {
  cds <- "ATGGCTTAA"  # M A *
  cu <- builtin_human_codon_usage()
  variants <- design_mutations(cds, cu)

  # Check variant IDs follow pattern: wt_aa + position + mut_aa
  expect_true("M1A" %in% variants$variant_id)
  expect_true("M1*" %in% variants$variant_id)
  expect_true("A2G" %in% variants$variant_id)
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
