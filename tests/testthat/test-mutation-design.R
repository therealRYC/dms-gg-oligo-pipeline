# test-mutation-design.R — Tests for 04_mutation_design.R

test_that("design_mutations generates correct number of variants with WT controls", {
  # Small test: 4-codon CDS (ATG GCT GAA TAA = M A E *)
  cds <- "ATGGCTGAATAA"
  cu <- builtin_human_codon_usage()
  variants <- design_mutations(cds, cu)

  # Mutable positions: codons 2 to (n_codons - 1) = codons 2-3 (skip Met@1, stop@4)
  # 2 mutable codons * 21 variants each (19 missense + 1 stop + 1 WT) = 42 variants
  expect_equal(nrow(variants), 2 * 21)
})

test_that("design_mutations produces correct variant IDs", {
  cds <- "ATGGCTTAA" # M A *
  cu <- builtin_human_codon_usage()
  variants <- design_mutations(cds, cu)

  # Only codon 2 (A) is mutable — codon 1 (Met) and codon 3 (stop) are skipped
  expect_equal(nrow(variants), 1 * 21)
  expect_true("A2G" %in% variants$variant_id)
  # WT control present
  expect_true("A2=" %in% variants$variant_id)
  # Met (codon 1) and stop (codon 3) should NOT be in variants
  expect_false("M1A" %in% variants$variant_id)
  expect_false("M1*" %in% variants$variant_id)
})

test_that("mutations use preferred human codons", {
  cds <- "ATGGCTTAA"
  cu <- builtin_human_codon_usage()
  pref <- get_preferred_codons(cu)
  variants <- design_mutations(cds, cu)

  # Check only missense/nonsense variants (not WT controls)
  coding_variants <- variants[variants$variant_type != "wt_control", ]
  for (i in seq_len(nrow(coding_variants))) {
    expected_codon <- pref[coding_variants$mut_aa[i]]
    expect_equal(coding_variants$mut_codon[i], unname(expected_codon),
      info = paste("Variant:", coding_variants$variant_id[i])
    )
  }
})

test_that("variant_type column is correctly assigned", {
  cds <- "ATGGCTGAATAA" # M A E *
  cu <- builtin_human_codon_usage()
  variants <- design_mutations(cds, cu)

  # Should have variant_type column

  expect_true("variant_type" %in% names(variants))

  # Check types
  expect_true(all(variants$variant_type %in% c("missense", "nonsense", "wt_control")))

  # Each mutable position should have exactly 1 WT control
  wt_ctrls <- variants[variants$variant_type == "wt_control", ]
  expect_equal(nrow(wt_ctrls), 2) # 2 mutable positions

  # Each mutable position should have exactly 1 nonsense variant
  nonsense <- variants[variants$variant_type == "nonsense", ]
  expect_equal(nrow(nonsense), 2)

  # Each mutable position should have 19 missense variants
  missense <- variants[variants$variant_type == "missense", ]
  expect_equal(nrow(missense), 2 * 19)
})

test_that("WT control variants have mut_codon == wt_codon", {
  cds <- "ATGGCTGAATAA"
  cu <- builtin_human_codon_usage()
  variants <- design_mutations(cds, cu)

  wt_ctrls <- variants[variants$variant_type == "wt_control", ]
  for (i in seq_len(nrow(wt_ctrls))) {
    expect_equal(wt_ctrls$mut_codon[i], wt_ctrls$wt_codon[i],
      info = paste("WT control:", wt_ctrls$variant_id[i])
    )
    expect_equal(wt_ctrls$mut_aa[i], wt_ctrls$wt_aa[i],
      info = paste("WT control AA:", wt_ctrls$variant_id[i])
    )
  }
})

test_that("WT control variant IDs follow {AA}{pos}= format", {
  cds <- "ATGGCTGAATAA"
  cu <- builtin_human_codon_usage()
  variants <- design_mutations(cds, cu)

  wt_ctrls <- variants[variants$variant_type == "wt_control", ]
  expect_true(all(grepl("^[A-Z][0-9]+=$", wt_ctrls$variant_id)))
  expect_true("A2=" %in% wt_ctrls$variant_id)
  expect_true("E3=" %in% wt_ctrls$variant_id)
})

test_that("include_synonymous adds synonymous variants at non-Met/Trp positions", {
  # CDS: ATG GCT TGG TAA = M A W *
  # Mutable: A@2 (has synonymous codons), W@3 (only one codon — no synonymous)
  cds <- "ATGGCTTGGTAA"
  cu <- builtin_human_codon_usage()
  variants <- design_mutations(cds, cu, include_synonymous = TRUE)

  # A@2: 20 missense+nonsense + 1 WT + 1 syn = 22
  # W@3: 20 missense+nonsense + 1 WT + 0 syn (Trp has only TGG) = 21
  expect_equal(nrow(variants), 22 + 21)

  # Synonymous variant exists for A@2
  syn_a <- variants[variants$variant_type == "synonymous" & variants$position == 2, ]
  expect_equal(nrow(syn_a), 1)
  expect_equal(syn_a$variant_id, "A2syn")
  expect_equal(syn_a$mut_aa, "A") # same AA
  expect_false(syn_a$mut_codon == syn_a$wt_codon) # different codon

  # No synonymous for Trp@3
  syn_w <- variants[variants$variant_type == "synonymous" & variants$position == 3, ]
  expect_equal(nrow(syn_w), 0)
})

test_that("include_synonymous also skips Met positions", {
  # CDS: ATG ATG GCT TAA = M M A *
  # Mutable: M@2 (Met has only ATG — no synonymous), A@3 (has synonymous)
  cds <- "ATGATGGCTTAA"
  cu <- builtin_human_codon_usage()
  variants <- design_mutations(cds, cu, include_synonymous = TRUE)

  # M@2: 20 + 1 WT + 0 syn = 21
  # A@3: 20 + 1 WT + 1 syn = 22
  expect_equal(nrow(variants), 21 + 22)

  syn_m <- variants[variants$variant_type == "synonymous" & variants$position == 2, ]
  expect_equal(nrow(syn_m), 0)
})

test_that("synonymous codon differs from WT and encodes same amino acid", {
  cds <- "ATGGCTGAATAA" # M A E *
  cu <- builtin_human_codon_usage()
  variants <- design_mutations(cds, cu, include_synonymous = TRUE)

  syn_variants <- variants[variants$variant_type == "synonymous", ]
  for (i in seq_len(nrow(syn_variants))) {
    v <- syn_variants[i, ]
    # Different codon
    expect_false(v$mut_codon == v$wt_codon,
      info = paste("Synonymous should differ:", v$variant_id)
    )
    # Same amino acid
    expect_equal(v$mut_aa, v$wt_aa,
      info = paste("Synonymous should encode same AA:", v$variant_id)
    )
    # Verify the codon actually translates to the claimed AA
    expect_equal(translate_codon(v$mut_codon), v$mut_aa,
      info = paste("Codon translation:", v$variant_id)
    )
  }
})

test_that("default mode (no synonymous) produces 21 variants per position", {
  # Verify the default hasn't changed — should be 21 (20 mutations + 1 WT)
  cds <- "ATGGCTGAATAA"
  cu <- builtin_human_codon_usage()
  variants <- design_mutations(cds, cu) # default include_synonymous = FALSE

  expect_equal(nrow(variants), 2 * 21)
  expect_false("synonymous" %in% variants$variant_type)
})

test_that("check_and_fix_new_sites skips WT control variants", {
  # The WT codon is already domesticated, so check_and_fix_new_sites should skip it
  cds <- "ATGGCTGAATAA"
  cu <- builtin_human_codon_usage()
  variants <- design_mutations(cds, cu)

  # Run check — should not modify WT control codons
  wt_before <- variants[variants$variant_type == "wt_control", "mut_codon"]
  result <- check_and_fix_new_sites(variants, cds, cu)
  wt_after <- result[result$variant_type == "wt_control", "mut_codon"]

  expect_equal(wt_after, wt_before)
})
