# test-utils.R — Tests for utils.R

test_that("reverse_complement works correctly", {
  expect_equal(reverse_complement("ATCG"), "CGAT")
  expect_equal(reverse_complement("AAAA"), "TTTT")
  expect_equal(reverse_complement("CGTCTC"), "GAGACG")
  expect_equal(reverse_complement("GGTCTC"), "GAGACC")
  expect_equal(reverse_complement("A"), "T")
})

test_that("gc_content calculates correctly", {
  expect_equal(gc_content("ATAT"), 0.0)
  expect_equal(gc_content("GCGC"), 1.0)
  expect_equal(gc_content("ATGC"), 0.5)
  expect_equal(gc_content("ACGT"), 0.5)
})

test_that("find_enzyme_sites finds BsmBI on both strands", {
  # Forward BsmBI: CGTCTC
  sites <- find_enzyme_sites("AAACGTCTCAAA", "CGTCTC")
  expect_equal(nrow(sites), 1)
  expect_equal(sites$start, 4)
  expect_equal(sites$strand, "+")

  # Reverse BsmBI (GAGACG on forward strand)
  sites_rev <- find_enzyme_sites("AAAGAGACGAAA", "CGTCTC")
  expect_equal(nrow(sites_rev), 1)
  expect_equal(sites_rev$strand, "-")

  # No sites
  sites_none <- find_enzyme_sites("AAAAAAAAAAAA", "CGTCTC")
  expect_equal(nrow(sites_none), 0)
})

test_that("find_enzyme_sites finds BsaI on both strands", {
  # Forward BsaI: GGTCTC
  sites <- find_enzyme_sites("AAAGGTCTCAAA", "GGTCTC")
  expect_equal(nrow(sites), 1)
  expect_equal(sites$start, 4)
  expect_equal(sites$strand, "+")

  # Reverse BsaI (GAGACC on forward strand)
  sites_rev <- find_enzyme_sites("AAAGAGACCAAA", "GGTCTC")
  expect_equal(nrow(sites_rev), 1)
  expect_equal(sites_rev$strand, "-")
})

test_that("has_enzyme_sites detects BsaI, BsmBI, and PaqCI", {
  expect_true(has_enzyme_sites("AAACGTCTCAAA"))   # BsmBI
  expect_true(has_enzyme_sites("AAACACCTGCAAA"))  # PaqCI
  expect_true(has_enzyme_sites("AAAGAGACGAAA"))   # BsmBI RC
  expect_true(has_enzyme_sites("AAAGGTCTCAAA"))   # BsaI
  expect_true(has_enzyme_sites("AAAGAGACCAAA"))   # BsaI RC
  expect_false(has_enzyme_sites("AAAAAAAAAAAA"))
})

test_that("has_enzyme_sites with explicit enzyme list", {
  # Only check BsmBI
  expect_true(has_enzyme_sites("AAACGTCTCAAA", enzymes = "BsmBI"))
  expect_false(has_enzyme_sites("AAAGGTCTCAAA", enzymes = "BsmBI"))  # BsaI only

  # Only check BsaI
  expect_true(has_enzyme_sites("AAAGGTCTCAAA", enzymes = "BsaI"))
  expect_false(has_enzyme_sites("AAACGTCTCAAA", enzymes = "BsaI"))  # BsmBI only
})

test_that("has_homopolymer detects runs", {
  expect_true(has_homopolymer("AAAAACGT", 4))
  expect_false(has_homopolymer("AAAACGT", 4))
  expect_true(has_homopolymer("CCCCCCC", 4))
  expect_false(has_homopolymer("ACGTACGT", 4))
})

test_that("extract_codons splits correctly", {
  expect_equal(extract_codons("ATGAAA"), c("ATG", "AAA"))
  expect_equal(extract_codons("ATGGCTTAA"), c("ATG", "GCT", "TAA"))
  expect_error(extract_codons("ATGA"))  # not divisible by 3
})

test_that("replace_codon works correctly", {
  expect_equal(replace_codon("ATGAAATAA", 2, "GGG"), "ATGGGGTAA")
  expect_equal(replace_codon("ATGAAATAA", 1, "TTT"), "TTTAAATAA")
  expect_equal(replace_codon("ATGAAATAA", 3, "CCC"), "ATGAAACCC")
})

test_that("translate_codon works for standard code", {
  expect_equal(translate_codon("ATG"), "M")
  expect_equal(translate_codon("TAA"), "*")
  expect_equal(translate_codon("GCT"), "A")
  expect_error(translate_codon("XXX"))
})

test_that("translate_cds translates full CDS", {
  expect_equal(translate_cds("ATGGCTTAA"), "MA*")
  expect_equal(translate_cds("ATGAAAGGG"), "MKG")
})

test_that("orient_enzyme_site builds correct BsmBI sequences", {
  # BsmBI forward: CGTCTC + A(spacer) + overhang
  fwd <- orient_enzyme_site("BsmBI", "ACTA", "forward")
  expect_true(startsWith(fwd, "CGTCTC"))
  expect_true(endsWith(fwd, "ACTA"))
  expect_equal(nchar(fwd), 11)  # 6 + 1 + 4

  # BsmBI reverse: RC(CGTCTC + spacer + RC(overhang))
  # Result starts with the overhang, ends with RC(recognition)
  rev_site <- orient_enzyme_site("BsmBI", "ACTA", "reverse")
  expect_equal(nchar(rev_site), 11)
  expect_true(startsWith(rev_site, "ACTA"))
  expect_true(endsWith(rev_site, reverse_complement("CGTCTC")))
  # Verify full construction: RC(recog + spacer + RC(overhang))
  expected <- reverse_complement(paste0("CGTCTC", "A", reverse_complement("ACTA")))
  expect_equal(rev_site, expected)
})

test_that("orient_enzyme_site builds correct BsaI sequences", {
  # BsaI forward: GGTCTC + A(spacer) + overhang
  fwd <- orient_enzyme_site("BsaI", "ACTA", "forward")
  expect_true(startsWith(fwd, "GGTCTC"))
  expect_true(endsWith(fwd, "ACTA"))
  expect_equal(nchar(fwd), 11)  # 6 + 1 + 4

  # BsaI reverse: RC(GGTCTC + spacer + RC(overhang))
  # Result starts with the overhang, ends with RC(recognition)
  rev_site <- orient_enzyme_site("BsaI", "ACTA", "reverse")
  expect_equal(nchar(rev_site), 11)
  expect_true(startsWith(rev_site, "ACTA"))
  expect_true(endsWith(rev_site, reverse_complement("GGTCTC")))
  # Verify full construction
  expected <- reverse_complement(paste0("GGTCTC", "A", reverse_complement("ACTA")))
  expect_equal(rev_site, expected)
})

test_that("orient_enzyme_site reverse produces complementary overhangs", {
  # After digestion, forward and reverse sites with the same overhang
  # should produce complementary sticky ends for Golden Gate ligation.
  # Use a non-palindromic overhang so fwd != RC(fwd) tests are meaningful.
  for (enz_name in c("BsaI", "BsmBI")) {
    oh <- "ATGG"  # non-palindromic (RC = CCAT)
    fwd <- orient_enzyme_site(enz_name, oh, "forward")
    rev <- orient_enzyme_site(enz_name, oh, "reverse")

    # Forward site ends with the overhang
    expect_true(endsWith(fwd, oh))
    # Reverse site starts with the overhang (not RC — the top-strand representation)
    expect_true(startsWith(rev, oh))
    # With the fix, reverse = RC(recog + spacer + RC(overhang)).
    # For non-palindromic overhangs, this differs from RC(recog + spacer + overhang) = RC(fwd).
    expect_false(rev == reverse_complement(fwd),
                 info = paste(enz_name, ": rev should differ from RC(fwd) for non-palindromic oh"))
  }
})
