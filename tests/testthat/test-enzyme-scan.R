# test-enzyme-scan.R — Tests for 02_enzyme_site_scan.R

test_that("scan_enzyme_sites finds BsmBI in test gene", {
  cu <- TEST_CODON_USAGE
  # TEST_GENE_SEQ has BsmBI site (CGTCTC) embedded at codons 32-33
  result <- scan_enzyme_sites(TEST_GENE_SEQ, "", cu)

  expect_true(nrow(result$gene_sites) > 0)
  expect_true(any(result$gene_sites$enzyme == "BsmBI"))
})

test_that("scan_enzyme_sites scans all 3 enzymes", {
  cu <- TEST_CODON_USAGE
  # Create a test sequence with a BsaI site
  bsai_gene <- paste0(
    "ATG", "GCT", "GAA", "CTT", "AAA", "GCT", "GCC", "AAG", "GAT", "TTC",
    "GGT", "CTG", "AAC", "GAT", "ATC", "CCA", "GCT", "CAG", "AAG", "TTC",
    "ATC", "GCT", "AAC", "CTG", "TGG", "AAG", "AAC", "GGT", "GAC", "TTC",
    "GGT", "CTC", "GAT", "CTG", "AAA", "GAA", "CTG", "GCT", "GAC", "TAC",
    "ATC", "AAG", "AAC", "CCG", "GCT", "ACC", "GTT", "GCT", "GAA", "TAA"
  )
  # "GGTCTC" spans codons 31-32 (GGT + CTC)
  result <- scan_enzyme_sites(bsai_gene, "", cu)
  expect_true(any(result$gene_sites$enzyme == "BsaI"))
})

test_that("suggest_domestication provides valid fixes", {
  cu <- TEST_CODON_USAGE
  sites <- find_enzyme_sites(TEST_GENE_SEQ, "CGTCTC")
  sites$enzyme <- "BsmBI"

  dom <- suggest_domestication(TEST_GENE_SEQ, sites, cu)
  expect_true(nrow(dom) > 0)

  # The suggested fix should be a synonymous mutation
  for (i in seq_len(nrow(dom))) {
    orig_aa <- translate_codon(dom$original_codon[i])
    new_aa <- translate_codon(dom$new_codon[i])
    expect_equal(orig_aa, new_aa)  # synonymous
  }
})

test_that("suggest_domestication doesn't create new enzyme sites", {
  cu <- TEST_CODON_USAGE
  sites <- find_enzyme_sites(TEST_GENE_SEQ, "CGTCTC")
  sites$enzyme <- "BsmBI"

  dom <- suggest_domestication(TEST_GENE_SEQ, sites, cu)

  if (nrow(dom) > 0) {
    # Apply fix and check no new BsaI or PaqCI sites were created
    test_cds <- TEST_GENE_SEQ
    for (i in seq_len(nrow(dom))) {
      test_cds <- replace_codon(test_cds, dom$codon_pos[i], dom$new_codon[i])
    }

    # Should not have created BsaI sites
    bsai_sites <- find_enzyme_sites(test_cds, "GGTCTC")
    # (the original test gene may or may not have BsaI sites, but the fix shouldn't add new ones)
    orig_bsai <- find_enzyme_sites(TEST_GENE_SEQ, "GGTCTC")
    expect_true(nrow(bsai_sites) <= nrow(orig_bsai))
  }
})

test_that("apply_domestication removes BsmBI site", {
  cu <- TEST_CODON_USAGE
  result <- scan_enzyme_sites(TEST_GENE_SEQ, "", cu)

  if (nrow(result$domestication) > 0) {
    domesticated <- apply_domestication(TEST_GENE_SEQ, result$domestication,
                                         codon_usage = cu)
    # Check no BsmBI sites remain
    remaining <- find_enzyme_sites(domesticated, "CGTCTC")
    expect_equal(nrow(remaining), 0)

    # Check protein is identical
    expect_equal(translate_cds(domesticated), translate_cds(TEST_GENE_SEQ))
  }
})

test_that("apply_domestication with iterative re-checking", {
  cu <- TEST_CODON_USAGE
  result <- scan_enzyme_sites(TEST_GENE_SEQ, "", cu)

  if (nrow(result$domestication) > 0) {
    domesticated <- apply_domestication(TEST_GENE_SEQ, result$domestication,
                                         codon_usage = cu)

    # After iterative domestication, all 3 enzymes should be clear
    for (enz_name in c("BsaI", "BsmBI", "PaqCI")) {
      remaining <- find_enzyme_sites(domesticated, ENZYMES[[enz_name]]$recog)
      expect_equal(nrow(remaining), 0,
                   info = paste(enz_name, "sites should be cleared"))
    }
  }
})
