# test-intergene-elements.R — Tests for flexible downstream construct (intergene_elements)

test_that("build_downstream_cassette with no intergene elements", {
  cfg <- list(
    polIII_promoter = TEST_POLIII,
    intergene_elements = NULL
  )
  result <- build_downstream_cassette(cfg)

  expect_equal(result$intergene_concat, "")
  expect_equal(result$downstream_cassette, TEST_POLIII)
  expect_equal(length(result$intergene_elements), 0)
})

test_that("build_downstream_cassette with one intergene element", {
  fake_element <- "ATGGCTGAACTTAAAGCTGCC"
  cfg <- list(
    polIII_promoter = TEST_POLIII,
    intergene_elements = list(
      list(name = "T2A_GFP", sequence = fake_element)
    )
  )
  result <- build_downstream_cassette(cfg)

  expect_equal(result$intergene_concat, fake_element)
  expect_equal(result$downstream_cassette, paste0(fake_element, TEST_POLIII))
  expect_equal(length(result$intergene_elements), 1)
})

test_that("build_downstream_cassette with multiple intergene elements", {
  elem1 <- "ATGGCTGAACTT"
  elem2 <- "CCCAAAGGTTTCCC"
  cfg <- list(
    polIII_promoter = TEST_POLIII,
    intergene_elements = list(
      list(name = "reporter", sequence = elem1),
      list(name = "linker", sequence = elem2)
    )
  )
  result <- build_downstream_cassette(cfg)

  expect_equal(result$intergene_concat, paste0(elem1, elem2))
  expect_equal(result$downstream_cassette, paste0(elem1, elem2, TEST_POLIII))
  expect_equal(length(result$intergene_elements), 2)
})

test_that("build_downstream_cassette validates element names", {
  cfg <- list(
    polIII_promoter = TEST_POLIII,
    intergene_elements = list(
      list(name = "", sequence = "ATGC")
    )
  )
  expect_error(build_downstream_cassette(cfg), "missing a 'name' field")
})

test_that("build_downstream_cassette validates element sequences", {
  cfg <- list(
    polIII_promoter = TEST_POLIII,
    intergene_elements = list(
      list(name = "bad_elem", sequence = "ATGXYZ")
    )
  )
  expect_error(build_downstream_cassette(cfg), "non-ACGT characters")
})

test_that("build_downstream_cassette uppercases element sequences", {
  cfg <- list(
    polIII_promoter = TEST_POLIII,
    intergene_elements = list(
      list(name = "lower_case", sequence = "atgcatgc")
    )
  )
  result <- build_downstream_cassette(cfg)
  expect_equal(result$intergene_concat, "ATGCATGC")
})

test_that("scan_enzyme_sites detects sites in intergene elements", {
  cu <- builtin_human_codon_usage()
  # Use a sequence containing a BsmBI site (CGTCTC)
  bad_element <- list(
    name = "has_bsmbi",
    sequence = "AAAAACGTCTCAAAAAA"
  )
  result <- scan_enzyme_sites(
    cds = TEST_GENE_SEQ, polIII = TEST_POLIII, codon_usage = cu,
    intergene_elements = list(bad_element)
  )

  expect_true(nrow(result$intergene_sites) > 0)
  expect_true("has_bsmbi" %in% result$intergene_sites$element_name)
  expect_true("BsmBI" %in% result$intergene_sites$enzyme)
})

test_that("scan_enzyme_sites with no intergene elements returns empty intergene_sites", {
  cu <- builtin_human_codon_usage()
  result <- scan_enzyme_sites(
    cds = TEST_GENE_SEQ, polIII = TEST_POLIII, codon_usage = cu
  )

  expect_true("intergene_sites" %in% names(result))
  expect_equal(nrow(result$intergene_sites), 0)
})

test_that("scan_enzyme_sites with clean intergene elements returns empty intergene_sites", {
  cu <- builtin_human_codon_usage()
  clean_element <- list(
    name = "clean",
    sequence = "AAAAATTTTTCCCCC"
  )
  result <- scan_enzyme_sites(
    cds = TEST_GENE_SEQ, polIII = TEST_POLIII, codon_usage = cu,
    intergene_elements = list(clean_element)
  )

  expect_equal(nrow(result$intergene_sites), 0)
})

test_that("gene blocks include intergene elements in downstream cassette", {
  cu <- builtin_human_codon_usage()
  # Use a short clean intergene element
  intergene_seq <- "AAACCCGGGTTTATATATATA"

  # Domesticate the test gene
  scan_result <- scan_enzyme_sites(TEST_GENE_SEQ, "", cu)
  cds <- if (nrow(scan_result$domestication) > 0) {
    apply_domestication(TEST_GENE_SEQ, scan_result$domestication, codon_usage = cu)
  } else {
    TEST_GENE_SEQ
  }

  downstream_cassette <- paste0(intergene_seq, TEST_POLIII)
  tiles <- partition_tiles(cds, 150)
  oh3 <- "ACTA"
  oh4 <- "GATA"

  result <- design_wt_geneblocks(
    cds = cds, polIII = downstream_cassette,
    tiles = tiles, oh3 = oh3, oh4 = oh4,
    paqci_star2 = "AGTC", paqci_star1 = "TCGA"
  )

  # At least one BsmBI block should contain the intergene sequence
  bsmbi_blocks <- result$blocks[result$blocks$enzyme_type == "BsmBI", ]
  has_intergene <- any(grepl(intergene_seq, bsmbi_blocks$sequence, fixed = TRUE))
  expect_true(has_intergene,
              info = "BsmBI gene blocks should contain the intergene element sequence")

  # The intergene element should appear BEFORE the polIII marker
  polIII_marker <- substring(TEST_POLIII, 1, 20)
  for (i in seq_len(nrow(bsmbi_blocks))) {
    seq <- bsmbi_blocks$sequence[i]
    if (grepl(intergene_seq, seq, fixed = TRUE) && grepl(polIII_marker, seq, fixed = TRUE)) {
      ig_pos <- regexpr(intergene_seq, seq, fixed = TRUE)
      polIII_pos <- regexpr(polIII_marker, seq, fixed = TRUE)
      expect_true(ig_pos < polIII_pos,
                  info = "Intergene element should appear before PolIII in the block")
    }
  }
})

test_that("plan_assembly accepts downstream_cassette for block length calculations", {
  cu <- builtin_human_codon_usage()
  scan_result <- scan_enzyme_sites(TEST_GENE_SEQ, "", cu)
  cds <- if (nrow(scan_result$domestication) > 0) {
    apply_domestication(TEST_GENE_SEQ, scan_result$domestication, codon_usage = cu)
  } else {
    TEST_GENE_SEQ
  }

  tile_size <- compute_max_tile_size(300, 12)
  # Without downstream_cassette (backward compat)
  plan_no_intergene <- plan_assembly(
    cds = cds, polIII = TEST_POLIII, max_mutable_nt = tile_size
  )
  expect_null(plan_no_intergene$core_downstream_cassette)

  # With downstream_cassette
  intergene_seq <- "AAACCCGGGTTTATATATATA"
  downstream_cassette <- paste0(intergene_seq, TEST_POLIII)
  plan_with_intergene <- plan_assembly(
    cds = cds, polIII = TEST_POLIII, max_mutable_nt = tile_size,
    downstream_cassette = downstream_cassette
  )

  # core_downstream_cassette should be set when oh3 is promoter-derived
  if (!is.null(plan_with_intergene$core_polIII)) {
    expect_false(is.null(plan_with_intergene$core_downstream_cassette))
    # Should equal downstream_cassette minus last 5 nt
    expected_len <- nchar(downstream_cassette) - 5
    expect_equal(nchar(plan_with_intergene$core_downstream_cassette), expected_len)
  }
})

test_that("load_config with intergene_elements builds downstream_cassette", {
  tmp_fasta <- tempfile(fileext = ".fasta")
  writeLines(c(">test_gene", TEST_GENE_SEQ), tmp_fasta)

  tmp_config <- tempfile(fileext = ".yaml")
  config_lines <- c(
    paste0("gene_fasta: \"", gsub("\\\\", "/", tmp_fasta), "\""),
    paste0("polIII_promoter: \"", TEST_POLIII, "\""),
    "paqci_star2: AGTC",
    "paqci_star1: TCGA",
    "intergene_elements:",
    "  - name: \"T2A_GFP\"",
    "    sequence: \"ATGGCTGAACTTAAAGCTGCC\"",
    "  - name: \"IRES\"",
    "    sequence: \"CCCAAAGGTTTCCC\""
  )
  writeLines(config_lines, tmp_config)

  cfg <- load_config(tmp_config)

  expect_equal(length(cfg$intergene_elements), 2)
  expect_equal(cfg$intergene_elements[[1]]$name, "T2A_GFP")
  expect_equal(cfg$intergene_elements[[2]]$name, "IRES")
  expect_equal(cfg$intergene_concat, "ATGGCTGAACTTAAAGCTGCCCCCAAAGGTTTCCC")
  expect_equal(cfg$downstream_cassette, paste0("ATGGCTGAACTTAAAGCTGCCCCCAAAGGTTTCCC", TEST_POLIII))
})

test_that("load_config without intergene_elements sets downstream_cassette = polIII", {
  tmp_fasta <- tempfile(fileext = ".fasta")
  writeLines(c(">test_gene", TEST_GENE_SEQ), tmp_fasta)

  tmp_config <- tempfile(fileext = ".yaml")
  config_lines <- c(
    paste0("gene_fasta: \"", gsub("\\\\", "/", tmp_fasta), "\""),
    paste0("polIII_promoter: \"", TEST_POLIII, "\""),
    "paqci_star2: AGTC",
    "paqci_star1: TCGA"
  )
  writeLines(config_lines, tmp_config)

  cfg <- load_config(tmp_config)

  expect_equal(length(cfg$intergene_elements), 0)
  expect_equal(cfg$intergene_concat, "")
  expect_equal(cfg$downstream_cassette, TEST_POLIII)
})

test_that("report construct_diagram shows intergene elements", {
  cfg <- list(
    intergene_elements = list(
      list(name = "T2A_GFP"),
      list(name = "IRES_puro")
    )
  )
  diagram <- construct_diagram(cfg)
  expect_true(grepl("T2A_GFP", diagram, fixed = TRUE))
  expect_true(grepl("IRES_puro", diagram, fixed = TRUE))
  expect_true(grepl("PolIII", diagram, fixed = TRUE))
  expect_true(grepl("PaqCI", diagram, fixed = TRUE))
})

test_that("report construct_diagram with no intergene elements", {
  cfg <- list(intergene_elements = list())
  diagram <- construct_diagram(cfg)
  expect_false(grepl("T2A", diagram, fixed = TRUE))
  expect_true(grepl("gene+mutation", diagram, fixed = TRUE))
  expect_true(grepl("PolIII", diagram, fixed = TRUE))
})
