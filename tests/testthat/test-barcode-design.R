# test-barcode-design.R — Tests for 07_barcode_design.R

# ============================================================================
# Core helpers
# ============================================================================

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

test_that("greedy prefix generation works", {
  prefixes <- generate_prefixes_greedy(6, 3, 5)
  expect_true(length(prefixes) >= 5)

  # All pairs should have Hamming distance >= 3
  for (i in seq_len(length(prefixes) - 1)) {
    for (j in (i + 1):length(prefixes)) {
      expect_gte(hamming_distance(prefixes[i], prefixes[j]), 3)
    }
  }
})

# ============================================================================
# Capacity estimation
# ============================================================================

test_that("hamming_ball_volume computes correctly", {
  # V(n, 0) = 1 (just the sequence itself)
  expect_equal(hamming_ball_volume(8, 0), 1)
  # V(n, 1) = 1 + n*3 (sequence + all single-base changes)
  expect_equal(hamming_ball_volume(8, 1), 1 + 8 * 3)
})

test_that("estimate_barcode_capacity returns sensible values", {
  cap <- estimate_barcode_capacity(8, 4, 3)
  expect_true(cap > 0)
  # More suffix space = more capacity
  cap_bigger <- estimate_barcode_capacity(8, 6, 3)
  expect_gt(cap_bigger, cap)
})

test_that("estimate_ops_capacity returns capacity and violation fraction", {
  est <- estimate_ops_capacity(8, 4, 3)
  expect_true(is.list(est))
  expect_true(est$capacity > 0)
  expect_true(est$expected_violation_fraction >= 0)
  expect_true(est$expected_violation_fraction < 1)

  # OPS capacity should be >= hard-constraint capacity (relaxed suffix)
  hard_cap <- estimate_barcode_capacity(8, 4, 3)
  expect_gte(est$capacity, hard_cap)
})

test_that("estimate_ops_capacity with suffix_length=0 has zero violations", {
  est <- estimate_ops_capacity(8, 0, 3)
  expect_equal(est$expected_violation_fraction, 0)
})

test_that("check_barcode_capacity passes for reasonable requests", {
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

# ============================================================================
# Auto-sizing (OPS mode)
# ============================================================================

test_that("auto_size_barcode_length finds minimum length", {
  len <- auto_size_barcode_length(100, prefix_length = 8, min_hamming = 3)
  expect_true(is.integer(len))
  expect_gte(len, 8)   # at least prefix_length
  expect_lte(len, 30)  # within max bounds
})

test_that("auto_size_barcode_length increases with more variants", {
  len_small <- auto_size_barcode_length(100, prefix_length = 8, min_hamming = 3)
  len_large <- auto_size_barcode_length(10000, prefix_length = 8, min_hamming = 3)
  expect_gte(len_large, len_small)
})

test_that("auto_size_barcode_length errors on impossible request", {
  expect_error(
    auto_size_barcode_length(1e9, prefix_length = 8, min_hamming = 3),
    "Cannot auto-size"
  )
})

test_that("auto_size_barcode_length respects tolerance", {
  # Stricter tolerance might require longer barcodes
  len_strict <- auto_size_barcode_length(5000, prefix_length = 8, min_hamming = 3,
                                          tolerance = 0.999)
  len_relaxed <- auto_size_barcode_length(5000, prefix_length = 8, min_hamming = 3,
                                           tolerance = 0.90)
  expect_gte(len_strict, len_relaxed)
})

# ============================================================================
# design_barcodes — backward compatibility (default = non-OPS)
# ============================================================================

test_that("design_barcodes returns correct structure (backward compat)", {
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
  # New fields
  expect_equal(result$barcode_length, 12)
  expect_false(result$ops_mode)
  expect_null(result$prefix_length)
  expect_equal(result$compliance_fraction, 1.0)
})

test_that("design_barcodes Hamming distance guarantee (non-OPS)", {
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
    "barcodes"
  )
})

# ============================================================================
# design_barcodes — non-OPS mode explicit
# ============================================================================

test_that("design_barcodes non-OPS mode produces correct barcodes", {
  result <- design_barcodes(
    n_variants = 30,
    barcode_length = 12,
    min_hamming = 3,
    ops_mode = FALSE
  )
  expect_equal(length(result$barcodes), 30)
  expect_true(all(nchar(result$barcodes) == 12))
  expect_false(result$ops_mode)
  expect_null(result$prefix_length)
  expect_equal(result$compliance_fraction, 1.0)

  # All pairs must meet hard Hamming constraint
  bcs <- result$barcodes
  for (i in 1:29) {
    for (j in (i + 1):30) {
      expect_gte(hamming_distance(bcs[i], bcs[j]), 3)
    }
  }
})

test_that("design_barcodes non-OPS mode with longer barcodes (random+greedy)", {
  result <- design_barcodes(
    n_variants = 20,
    barcode_length = 20,
    min_hamming = 3,
    ops_mode = FALSE
  )
  expect_equal(length(result$barcodes), 20)
  expect_true(all(nchar(result$barcodes) == 20))
  expect_false(result$ops_mode)

  # All pairs must meet hard Hamming constraint
  bcs <- result$barcodes
  for (i in 1:19) {
    for (j in (i + 1):20) {
      expect_gte(hamming_distance(bcs[i], bcs[j]), 3)
    }
  }
})

# ============================================================================
# design_barcodes — OPS mode
# ============================================================================

test_that("design_barcodes OPS mode with auto barcode_length", {
  result <- design_barcodes(
    n_variants = 50,
    barcode_length = "auto",
    min_hamming = 3,
    prefix_length = 8,
    ops_mode = TRUE,
    capacity_tolerance = 0.99
  )
  expect_equal(length(result$barcodes), 50)
  expect_true(result$ops_mode)
  expect_gte(result$barcode_length, 8)
  expect_equal(result$prefix_length, 8)
  expect_true(result$compliance_fraction >= 0.99)
  expect_true(all(nchar(result$barcodes) == result$barcode_length))
})

test_that("design_barcodes OPS mode with explicit barcode_length", {
  result <- design_barcodes(
    n_variants = 20,
    barcode_length = 14,
    min_hamming = 3,
    prefix_length = 8,
    ops_mode = TRUE,
    capacity_tolerance = 0.99
  )
  expect_equal(length(result$barcodes), 20)
  expect_true(all(nchar(result$barcodes) == 14))
  expect_true(result$ops_mode)
  expect_equal(result$prefix_length, 8)
  expect_equal(result$barcode_length, 14)
})

test_that("design_barcodes OPS mode prefix distances are hard-guaranteed", {
  result <- design_barcodes(
    n_variants = 40,
    barcode_length = 12,
    min_hamming = 3,
    prefix_length = 8,
    ops_mode = TRUE,
    capacity_tolerance = 0.90
  )

  bcs <- result$barcodes
  # Extract prefixes and verify all prefix pairs have distance >= min_hamming
  prefixes <- unique(substring(bcs, 1, 8))
  if (length(prefixes) > 1) {
    for (i in seq_len(length(prefixes) - 1)) {
      for (j in (i + 1):length(prefixes)) {
        d <- hamming_distance(prefixes[i], prefixes[j])
        expect_gte(d, 3,
          label = paste("prefix distance between", prefixes[i], "and", prefixes[j]))
      }
    }
  }
})

# ============================================================================
# Validation functions
# ============================================================================

test_that("validate_barcode_distances errors on violations", {
  bad_barcodes <- c("ACGTACGTACGT", "ACGTACGTACGA", "TTTGGACCAACC")
  expect_error(
    validate_barcode_distances(bad_barcodes, min_hamming = 3),
    "Hamming distance violation"
  )
})

test_that("validate_barcode_distances passes with valid barcodes", {
  good_barcodes <- c("AAAAAAAAAAAA", "TTTGGGCCCCCC", "GGGAAATTTCCC")
  expect_no_error(validate_barcode_distances(good_barcodes, min_hamming = 3))
})

test_that("validate_barcode_distances with prefix-group validation", {
  bad_barcodes <- c("ACGTACGTAAAA", "ACGTACGTAAAT")
  expect_error(
    validate_barcode_distances(bad_barcodes, min_hamming = 3, prefix_length = 8),
    "Hamming distance violation"
  )
})

test_that("validate_barcode_distances_soft returns compliance fraction", {
  # Create barcodes with different prefixes (all will be compliant cross-prefix)
  barcodes <- c("AAAACCCCACGT", "AAAACCCCGTAC",  # same prefix, may violate
                "TTTTGGGGACGT", "TTTTGGGGATCG")   # same prefix, may violate
  result <- validate_barcode_distances_soft(barcodes, min_hamming = 3,
                                             prefix_length = 8, tolerance = 0.50)
  expect_true(is.list(result))
  expect_true(is.numeric(result$compliance_fraction))
  expect_true(result$compliance_fraction >= 0 && result$compliance_fraction <= 1)
  expect_true(!is.null(result$violation_distribution))
  expect_equal(length(result$violation_distribution), 3L)  # d=0, d=1, d=2
  expect_true(!is.null(result$n_violations))
  expect_true(!is.null(result$total_pairs))
})

test_that("validate_barcode_distances_soft errors when below tolerance", {
  # Two barcodes with same prefix and suffix distance = 1 (violation)
  # If these are the only barcodes, compliance is low
  barcodes <- c("ACGTACGTAAAA", "ACGTACGTAAAC")  # d=1 in suffix
  expect_error(
    validate_barcode_distances_soft(barcodes, min_hamming = 3,
                                     prefix_length = 8, tolerance = 0.99),
    "soft Hamming constraint not met"
  )
})
