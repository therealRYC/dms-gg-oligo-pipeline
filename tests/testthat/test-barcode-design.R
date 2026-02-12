# test-barcode-design.R — Tests for 07_barcode_design.R

test_that("generate_all_kmers generates correct count", {
  expect_equal(length(generate_all_kmers(1)), 4)
  expect_equal(length(generate_all_kmers(2)), 16)
  expect_equal(length(generate_all_kmers(3)), 64)
})

test_that("hamming_distance calculates correctly", {
  expect_equal(hamming_distance("AAAA", "AAAA"), 0L)
  expect_equal(hamming_distance("AAAA", "TTTT"), 4L)
  expect_equal(hamming_distance("AACG", "ATCG"), 1L)
})

test_that("passes_barcode_filters works", {
  # Good barcode: balanced GC, no homopolymers, no enzyme sites
  expect_true(passes_barcode_filters("ACGTACGTACGT", c(0.25, 0.75), 4))
  # Bad GC
  expect_false(passes_barcode_filters("AAAAAAAAAAAA", c(0.25, 0.75), 4))
  # Homopolymer
  expect_false(passes_barcode_filters("AAAAACGTACGT", c(0.25, 0.75), 4))
})

test_that("design_barcodes returns correct structure", {
  # Small test: 10 barcodes, barcodes_per_variant = 1
  result <- design_barcodes(
    n_variants = 10,
    barcode_length = 12,
    min_hamming = 3,
    prefix_length = 8,
    gc_range = c(0.25, 0.75),
    max_homopolymer = 4,
    barcodes_per_variant = 1
  )

  expect_true(is.list(result))
  expect_equal(length(result$barcodes), 10)
  expect_true(all(nchar(result$barcodes) == 12))
  expect_equal(length(unique(result$barcodes)), 10)
  expect_equal(nrow(result$barcode_assignments), 10)
  expect_equal(result$barcode_assignments$variant_idx, 1:10)
  expect_true(all(result$barcode_assignments$barcode_idx == 1))
})

test_that("design_barcodes Hamming distance guarantee", {
  # Generate barcodes and verify ALL pairs >= min_hamming (exhaustive)
  result <- design_barcodes(
    n_variants = 20,
    barcode_length = 12,
    min_hamming = 3,
    prefix_length = 8,
    gc_range = c(0.25, 0.75),
    max_homopolymer = 4,
    barcodes_per_variant = 1
  )

  bcs <- result$barcodes
  n <- length(bcs)
  for (i in seq_len(n - 1)) {
    for (j in (i + 1):n) {
      d <- hamming_distance(bcs[i], bcs[j])
      expect_gte(d, 3, label = paste("distance between", bcs[i], "and", bcs[j]))
    }
  }
})

test_that("design_barcodes with barcodes_per_variant > 1", {
  result <- design_barcodes(
    n_variants = 5,
    barcode_length = 12,
    min_hamming = 3,
    prefix_length = 8,
    gc_range = c(0.25, 0.75),
    max_homopolymer = 4,
    barcodes_per_variant = 3
  )

  # Should produce 15 barcodes total
  expect_equal(length(result$barcodes), 15)
  expect_equal(length(unique(result$barcodes)), 15)
  expect_equal(nrow(result$barcode_assignments), 15)

  # Each variant should have 3 barcode assignments
  for (v in 1:5) {
    v_rows <- result$barcode_assignments[result$barcode_assignments$variant_idx == v, ]
    expect_equal(nrow(v_rows), 3)
    expect_equal(sort(v_rows$barcode_idx), 1:3)
  }
})

test_that("design_barcodes errors on insufficient capacity", {
  # Request more barcodes than possible: 12-nt barcodes with min_hamming=8
  # should be impossible for large n
  expect_error(
    design_barcodes(
      n_variants = 100000,
      barcode_length = 12,
      min_hamming = 8,
      prefix_length = 8,
      gc_range = c(0.25, 0.75),
      max_homopolymer = 4,
      barcodes_per_variant = 1
    ),
    "Insufficient barcode capacity"
  )
})

test_that("validate_barcode_distances errors on violations", {
  # Inject a pair that violates min_hamming = 3
  bad_barcodes <- c("ACGTACGTACGT", "ACGTACGTACGA", "TTTGGACCAACC")
  expect_error(
    validate_barcode_distances(bad_barcodes, min_hamming = 3),
    "Hamming distance violation"
  )
})

test_that("validate_barcode_distances passes with valid barcodes", {
  # Barcodes that definitely differ by >= 3
  good_barcodes <- c("AAAAAAAAAAAA", "TTTGGGCCCCCC", "GGGAAATTTCCC")
  expect_no_error(validate_barcode_distances(good_barcodes, min_hamming = 3))
})

test_that("validate_barcode_distances with prefix-group validation", {
  # Same prefix, different suffixes that violate min_hamming
  bad_barcodes <- c("ACGTACGTAAAA", "ACGTACGTAAAT")  # differ by 1 in suffix
  expect_error(
    validate_barcode_distances(bad_barcodes, min_hamming = 3, prefix_length = 8),
    "Hamming distance violation"
  )
})

test_that("check_barcode_capacity passes for reasonable requests", {
  # 2000 barcodes with default settings should be fine
  expect_silent(
    check_barcode_capacity(2000, prefix_length = 8, suffix_length = 4,
                            min_hamming = 3, gc_range = c(0.25, 0.75),
                            max_homopolymer = 4, barcodes_per_variant = 1)
  )
})

test_that("check_barcode_capacity errors for impossible requests", {
  expect_error(
    check_barcode_capacity(1000000, prefix_length = 4, suffix_length = 4,
                            min_hamming = 3, gc_range = c(0.25, 0.75),
                            max_homopolymer = 4, barcodes_per_variant = 1),
    "Insufficient barcode capacity"
  )
})

test_that("barcode filters enforce GC range", {
  # All A = 0% GC
  expect_false(passes_barcode_filters("AAAAAAAAAAAA", c(0.25, 0.75), 4))
  # All G = 100% GC
  expect_false(passes_barcode_filters("GGGGGGGGGGGG", c(0.25, 0.75), 4))
  # 50% GC = good
  expect_true(passes_barcode_filters("ACACACACGTGT", c(0.25, 0.75), 4))
})

test_that("barcode filters enforce enzyme site exclusion", {
  # BsaI site (GGTCTC)
  expect_false(passes_barcode_filters("GGTCTCAACAGT", c(0.0, 1.0), 12))
  # BsmBI site (CGTCTC)
  expect_false(passes_barcode_filters("CGTCTCAACAGT", c(0.0, 1.0), 12))
})

test_that("select_suffix_group selects valid suffixes", {
  suffixes <- generate_all_kmers(4)
  group <- select_suffix_group(suffixes, 3)

  # Should have at least 10 suffixes (empirically ~16 for d=3, 4-mers)
  expect_gte(length(group), 10)

  # All pairs should have Hamming distance >= 3
  for (i in seq_len(length(group) - 1)) {
    for (j in (i + 1):length(group)) {
      expect_gte(hamming_distance(group[i], group[j]), 3)
    }
  }
})

test_that("greedy prefix generation works as fallback", {
  prefixes <- generate_prefixes_greedy(6, 3, 5)
  expect_true(length(prefixes) >= 5)

  # All pairs should have Hamming distance >= 3
  for (i in seq_len(length(prefixes) - 1)) {
    for (j in (i + 1):length(prefixes)) {
      expect_gte(hamming_distance(prefixes[i], prefixes[j]), 3)
    }
  }
})
