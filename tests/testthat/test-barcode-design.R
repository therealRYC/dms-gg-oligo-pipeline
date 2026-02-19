# test-barcode-design.R — Tests for 07_barcode_design.R (unified hierarchical mode)

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

test_that("estimate_prefix_capacity returns sensible values", {
  cap <- estimate_prefix_capacity(8, 3)
  expect_true(cap > 0)
  # Longer prefix = more capacity
  cap_bigger <- estimate_prefix_capacity(12, 3)
  expect_gt(cap_bigger, cap)
})

test_that("check_prefix_feasibility returns valid hamming for feasible request", {
  d <- check_prefix_feasibility(100, prefix_length = 8, min_hamming = 3)
  expect_equal(d, 3L)
})

test_that("check_prefix_feasibility auto-adjusts min_hamming when needed", {
  # Request high hamming for small prefix — should auto-adjust downward
  # cli::cli_alert_warning emits a cli message, not an R warning, so we just
  # verify the returned d is lower than requested
  d <- check_prefix_feasibility(1000, prefix_length = 6, min_hamming = 5,
                                 min_hamming_floor = 2L)
  expect_true(d < 5L)
  expect_gte(d, 2L)
})

test_that("check_prefix_feasibility errors when no d works", {
  # Impossibly many variants for tiny prefix
  expect_error(
    check_prefix_feasibility(1e9, prefix_length = 4, min_hamming = 3,
                              min_hamming_floor = 2L),
    "Cannot generate enough unique prefixes"
  )
})

# ============================================================================
# Auto-sizing
# ============================================================================

test_that("auto_size_barcode_length finds minimum length", {
  len <- auto_size_barcode_length(100, prefix_length = 12, barcodes_per_variant = 1,
                                    min_hamming = 3)
  expect_true(is.integer(len))
  expect_gte(len, 12)  # at least prefix_length
  expect_lte(len, 30)  # within max bounds
})

test_that("auto_size_barcode_length increases with more barcodes_per_variant", {
  len_small <- auto_size_barcode_length(100, prefix_length = 12, barcodes_per_variant = 1,
                                          min_hamming = 3)
  len_large <- auto_size_barcode_length(100, prefix_length = 12, barcodes_per_variant = 10,
                                          min_hamming = 3)
  expect_gte(len_large, len_small)
})

test_that("auto_size_barcode_length errors on impossible request", {
  expect_error(
    auto_size_barcode_length(100, prefix_length = 28, barcodes_per_variant = 100,
                              min_hamming = 3),
    "Cannot auto-size"
  )
})

# ============================================================================
# Random greedy prefix generation (for prefix_length > 10)
# ============================================================================

test_that("generate_prefixes_random_greedy produces valid prefixes for k=12", {
  prefixes <- generate_prefixes_random_greedy(k = 12, min_hamming = 3, n_needed = 50,
                                                n_sample = 10000L)
  expect_gte(length(prefixes), 50)

  # Spot-check: first 20 pairs should have d >= 3
  n_check <- min(length(prefixes), 20)
  for (i in seq_len(n_check - 1)) {
    for (j in (i + 1):n_check) {
      expect_gte(hamming_distance(prefixes[i], prefixes[j]), 3)
    }
  }
})

# ============================================================================
# Per-prefix barcode generation
# ============================================================================

test_that("generate_barcodes_per_prefix produces correct count and structure", {
  prefixes <- c("ACGTACGT", "TGCATGCA", "GGCCTTAA")
  barcodes <- generate_barcodes_per_prefix(
    prefixes, suffix_length = 4, barcodes_per_variant = 3,
    gc_range = c(0.25, 0.75), max_homopolymer = 4
  )
  # 3 prefixes * 3 barcodes per variant = 9 total
  expect_equal(length(barcodes), 9)
  # All should be 12 nt
  expect_true(all(nchar(barcodes) == 12))
  # First 3 barcodes share prefix 1, next 3 share prefix 2, etc.
  expect_true(all(startsWith(barcodes[1:3], "ACGTACGT")))
  expect_true(all(startsWith(barcodes[4:6], "TGCATGCA")))
  expect_true(all(startsWith(barcodes[7:9], "GGCCTTAA")))
})

test_that("generate_barcodes_per_prefix with suffix_length=0 returns prefixes", {
  prefixes <- c("ACGTACGT", "TGCATGCA")
  barcodes <- generate_barcodes_per_prefix(
    prefixes, suffix_length = 0, barcodes_per_variant = 1,
    gc_range = c(0.25, 0.75), max_homopolymer = 4
  )
  expect_equal(barcodes, prefixes)
})

# ============================================================================
# design_barcodes — unified hierarchical mode
# ============================================================================

test_that("design_barcodes returns correct structure", {
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
  expect_equal(result$barcode_length, 12)
  expect_equal(result$prefix_length, 8)
  expect_true(!is.null(result$effective_hamming))
  expect_gte(result$effective_hamming, 2L)
})

test_that("design_barcodes prefix Hamming distance guarantee", {
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
  # Extract unique prefixes and verify all prefix pairs have distance >= effective_hamming
  prefixes <- unique(substring(bcs, 1, 8))
  if (length(prefixes) > 1) {
    for (i in seq_len(length(prefixes) - 1)) {
      for (j in (i + 1):length(prefixes)) {
        d <- hamming_distance(prefixes[i], prefixes[j])
        expect_gte(d, result$effective_hamming,
          label = paste("prefix distance between", prefixes[i], "and", prefixes[j]))
      }
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

test_that("design_barcodes with barcodes_per_variant=10 shares prefixes within variant", {
  result <- design_barcodes(
    n_variants = 5,
    barcode_length = 16,
    min_hamming = 3,
    prefix_length = 8,
    gc_range = c(0.25, 0.75),
    max_homopolymer = 4,
    barcodes_per_variant = 10
  )

  expect_equal(length(result$barcodes), 50)

  # All 10 barcodes for each variant should share a prefix
  for (v in 1:5) {
    v_bcs <- result$barcodes[((v - 1) * 10 + 1):(v * 10)]
    v_prefixes <- unique(substring(v_bcs, 1, 8))
    expect_equal(length(v_prefixes), 1,
                 info = paste("Variant", v, "should have exactly 1 unique prefix"))
  }

  # All variant prefixes should be distinct
  variant_prefixes <- unique(substring(result$barcodes, 1, 8))
  expect_equal(length(variant_prefixes), 5)
})

test_that("design_barcodes with prefix_length=12 produces fast valid results", {
  # This tests the generate_prefixes_random_greedy path
  result <- design_barcodes(
    n_variants = 20,
    barcode_length = 20,
    min_hamming = 3,
    prefix_length = 12,
    gc_range = c(0.25, 0.75),
    max_homopolymer = 4,
    barcodes_per_variant = 1
  )

  expect_equal(length(result$barcodes), 20)
  expect_true(all(nchar(result$barcodes) == 20))
  expect_equal(result$prefix_length, 12)

  # Verify prefix distances
  prefixes <- unique(substring(result$barcodes, 1, 12))
  expect_equal(length(prefixes), 20)
  for (i in seq_len(length(prefixes) - 1)) {
    for (j in (i + 1):length(prefixes)) {
      expect_gte(hamming_distance(prefixes[i], prefixes[j]), result$effective_hamming)
    }
  }
})

test_that("design_barcodes with auto barcode_length", {
  result <- design_barcodes(
    n_variants = 50,
    barcode_length = "auto",
    min_hamming = 3,
    prefix_length = 8,
    gc_range = c(0.25, 0.75),
    max_homopolymer = 4,
    barcodes_per_variant = 1
  )
  expect_equal(length(result$barcodes), 50)
  expect_gte(result$barcode_length, 8)
  expect_true(all(nchar(result$barcodes) == result$barcode_length))
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
    "prefixes|capacity|Cannot"
  )
})

# ============================================================================
# Validation
# ============================================================================

test_that("validate_prefix_distances errors on violations", {
  bad_prefixes <- c("ACGTACGT", "ACGTACGA", "TTTTGGGG")
  expect_error(
    validate_prefix_distances(bad_prefixes, min_hamming = 3),
    "Prefix Hamming distance violation"
  )
})

test_that("validate_prefix_distances passes with valid prefixes", {
  good_prefixes <- c("AAAAAAAA", "TTTGGGCC", "GGGAAATT")
  expect_no_error(validate_prefix_distances(good_prefixes, min_hamming = 3))
})

# ============================================================================
# Per-barcode nearest-neighbor Hamming distance
# ============================================================================

test_that("compute_min_hamming_per_barcode returns correct distances", {
  barcodes <- c("AAAA", "AAAT", "TTTT", "TTTG")
  dists <- compute_min_hamming_per_barcode(barcodes)
  expect_equal(length(dists), 4)
  # AAAA <-> AAAT = 1, AAAA <-> TTTT = 4, AAAA <-> TTTG = 4 => min = 1
  expect_equal(dists[1], 1L)
  # AAAT <-> AAAA = 1 => min = 1
  expect_equal(dists[2], 1L)
  # TTTT <-> TTTG = 1 => min = 1
  expect_equal(dists[3], 1L)
  # TTTG <-> TTTT = 1 => min = 1
  expect_equal(dists[4], 1L)
})

test_that("compute_min_hamming_per_barcode with well-separated barcodes", {
  barcodes <- c("AAAA", "TTTT", "CCCC", "GGGG")
  dists <- compute_min_hamming_per_barcode(barcodes)
  # All pairs have distance 4, so every barcode's min = 4
  expect_true(all(dists == 4L))
})

test_that("compute_min_hamming_per_barcode single barcode returns NA", {
  dists <- compute_min_hamming_per_barcode("ACGT")
  expect_equal(length(dists), 1)
  expect_true(is.na(dists[1]))
})

test_that("design_barcodes includes min_hamming_dist in output", {
  result <- design_barcodes(
    n_variants = 10,
    barcode_length = 12,
    min_hamming = 3,
    prefix_length = 8,
    barcodes_per_variant = 1
  )
  expect_true("min_hamming_dist" %in% names(result))
  expect_equal(length(result$min_hamming_dist), 10)
  # NN distance is at least 1 for any set of distinct barcodes
  expect_true(all(result$min_hamming_dist >= 1))

  # Also in barcode_assignments
  expect_true("min_hamming_dist" %in% names(result$barcode_assignments))
  expect_equal(result$barcode_assignments$min_hamming_dist, result$min_hamming_dist)
})

test_that("compute_min_hamming_per_barcode with prefix_length matches brute force", {
  # Small set: both paths should give same results
  barcodes <- c("AACCGGTTAACC", "AACCGGTTTTGG", "TTGGAACCAACC", "TTGGAACCTTGG")
  dists_standard <- compute_min_hamming_per_barcode(barcodes)
  # With prefix_length, for small sets it uses the standard path (n <= 50000)
  dists_prefix <- compute_min_hamming_per_barcode(barcodes, prefix_length = 8, min_hamming = 3)
  expect_equal(dists_standard, dists_prefix)
})

# ============================================================================
# Updated defaults
# ============================================================================

test_that("DEFAULT_PREFIX_LENGTH is 12", {
  expect_equal(DEFAULT_PREFIX_LENGTH, 12L)
})

test_that("DEFAULT_BARCODE_LENGTH is 20", {
  expect_equal(DEFAULT_BARCODE_LENGTH, 20L)
})

test_that("DEFAULT_BARCODES_PER_VARIANT is 10", {
  expect_equal(DEFAULT_BARCODES_PER_VARIANT, 10L)
})

test_that("DEFAULT_MIN_HAMMING_FLOOR is 2", {
  expect_equal(DEFAULT_MIN_HAMMING_FLOOR, 2L)
})
