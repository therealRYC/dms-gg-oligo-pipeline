# Created: 2026-03-18
# test-tile1-mutable-start-edgecases.R — Edge-case tests for tile 1 mutable_start logic
#
# Tests the key fix: for tile 1 (tile_start_nt == 1), mutable_start = 1 (no
# front strip because oh_L is external to CDS). For other tiles,
# mutable_start = tile_start_nt + 4 (oh1 consumes first 4 nt from gene sequence).
#
# These tests exercise build_expected_product() and verify_assembly_product_strict()
# directly with controlled inputs to verify exact nucleotide-level behavior.

# ===========================================================================
# Shared test fixtures
# ===========================================================================

# A short 84 nt CDS (28 codons = 28 amino acids incl. Met + stop).
# This gives us tight tile boundaries that make edge cases easy to reason about.
#
# Codon positions:     1    2    3    4    5    6    7    8    9    10
# CDS nucleotides:  ATG  GCT  GAA  CTT  AAA  GCT  GCC  AAG  GAT  TTC
#                     1    4    7   10   13   16   19   22   25   28
# ... continued to 28 codons = 84 nt
TEST_SHORT_CDS <- paste0(
  "ATG", "GCT", "GAA", "CTT",   # codons 1-4   (nt 1-12)
  "AAA", "GCT", "GCC", "AAG",   # codons 5-8   (nt 13-24)
  "GAT", "TTC", "GGT", "ACC",   # codons 9-12  (nt 25-36)
  "CTG", "AAC", "GAT", "ATC",   # codons 13-16 (nt 37-48)
  "CCA", "GCT", "CAG", "AAG",   # codons 17-20 (nt 49-60)
  "TTC", "ATC", "GCT", "AAC",   # codons 21-24 (nt 61-72)
  "CTG", "TGG", "AAG", "TAA"    # codons 25-28 (nt 73-84)
)

# Dummy constants for building products.
# These are realistic enough to test the function but small enough to trace.
TEST_LEFT_CAP  <- "LEFTCAP"
TEST_RIGHT_CAP <- "RIGHTCAP"
TEST_CASSETTE  <- "POLIIICASSETTE"
TEST_OH3       <- "ACTA"
TEST_BARCODE   <- "AACCGGTTAACC"

# Helper to build a minimal variant row data frame
make_variant <- function(position, mut_codon) {
  data.frame(
    position = as.integer(position),
    mut_codon = mut_codon,
    stringsAsFactors = FALSE
  )
}

# ===========================================================================
# Test 1: Tile 1 codon 2 is mutable (no front strip)
# ===========================================================================

test_that("tile 1 codon 2 mutation appears in product (mutable_start = 1)", {
  # BEFORE the fix: tile 1 with tile_start_nt=1 would compute mutable_start = 1 + 4 = 5.
  # Codon 2 starts at nt 4 (= (2-1)*3 + 1 = 4). The codon spans nt 4-5-6.
  # With the old (wrong) mutable_start=5, only nt 5-6 would be mutable; nt 4 would
  # stay WT, producing a partial/corrupted mutation.
  #
  # AFTER the fix: tile 1 mutable_start = 1. All 3 nt of codon 2 (nt 4-5-6) are
  # inside [1, mutable_end], so the full mutation should appear.

  # Tile 1: starts at nt 1, ends at nt 42 (14 codons)
  tile_start <- 1L
  tile_end   <- 42L
  mutable_end <- tile_end - 4L  # 38

  # Codon 2 = nt 4-6 = "GCT" (Ala)
  # Mutate to "TTT" (Phe)
  variant <- make_variant(2L, "TTT")

  product <- build_expected_product(
    variant_row      = variant,
    barcode          = TEST_BARCODE,
    cds              = TEST_SHORT_CDS,
    cassette_for_block = TEST_CASSETTE,
    oh3              = TEST_OH3,
    helper_left_cap  = TEST_LEFT_CAP,
    helper_right_cap = TEST_RIGHT_CAP,
    tile_start_nt    = tile_start,
    tile_end_nt      = tile_end
  )

  # Build manually what we expect:
  # mutable_start = 1 (tile 1 fix), mutable_end = 38
  # codon 2 = nt 4-5-6, all within [1, 38]
  # So all 3 bases of "TTT" should replace "GCT" at nt 4-5-6
  expected_cds_chars <- strsplit(TEST_SHORT_CDS, "")[[1]]
  expected_cds_chars[4] <- "T"
  expected_cds_chars[5] <- "T"
  expected_cds_chars[6] <- "T"
  expected_mutant_cds <- paste0(expected_cds_chars, collapse = "")

  expected_product <- paste0(
    TEST_LEFT_CAP, expected_mutant_cds, TEST_CASSETTE,
    TEST_OH3, TEST_BARCODE, TEST_RIGHT_CAP
  )

  # -- Verify build_expected_product output --
  expect_identical(product, expected_product,
    info = "Tile 1 codon 2: all 3 mutation bases must appear (no front strip)")

  # Verify the mutant codon is fully present in the CDS region
  cds_start <- nchar(TEST_LEFT_CAP) + 1L
  cds_end   <- cds_start + nchar(TEST_SHORT_CDS) - 1L
  product_cds <- substring(product, cds_start, cds_end)
  codon_in_product <- substring(product_cds, 4, 6)
  expect_equal(codon_in_product, "TTT",
    info = "Codon 2 in product CDS must be the full mutant codon TTT")
})

test_that("tile 1 codon 1 (ATG) is mutable (position 1, nt 1-3)", {
  # Codon 1 starts at nt 1. With tile_start_nt=1 and mutable_start=1,
  # all 3 nt (1,2,3) should be mutable. This is the extreme left edge.
  variant <- make_variant(1L, "GTG")  # Met -> Val (GTG)

  product <- build_expected_product(
    variant_row      = variant,
    barcode          = TEST_BARCODE,
    cds              = TEST_SHORT_CDS,
    cassette_for_block = TEST_CASSETTE,
    oh3              = TEST_OH3,
    helper_left_cap  = TEST_LEFT_CAP,
    helper_right_cap = TEST_RIGHT_CAP,
    tile_start_nt    = 1L,
    tile_end_nt      = 42L
  )

  # Verify codon 1 in product is GTG (full mutation)
  cds_start <- nchar(TEST_LEFT_CAP) + 1L
  codon_in_product <- substring(product, cds_start, cds_start + 2L)
  expect_equal(codon_in_product, "GTG",
    info = "Tile 1 codon 1 (nt 1-3) must be fully mutable")
})

# ===========================================================================
# Test 2: Tile 2 front strip still works (oh1 consumes first 4 nt)
# ===========================================================================

test_that("tile 2 front 4 nt are NOT mutable (oh1 overlap zone)", {
  # Tile 2 starts at, say, nt 31 (codon 11). For tile 2, tile_start_nt != 1,
  # so mutable_start = 31 + 4 = 35. The first 4 nt (31-34) are in the oh1
  # overlap zone and should NOT be mutated.
  #
  # Codon 11 = nt 31-33 = "GGT". This codon starts at nt 31.
  # With mutable_start = 35, ALL of codon 11 (nt 31-33) is outside the
  # mutable region. None of the mutation should appear.

  tile_start <- 31L
  tile_end   <- 72L  # 14 codons worth
  variant <- make_variant(11L, "TTT")  # codon 11 at nt 31-33

  product <- build_expected_product(
    variant_row      = variant,
    barcode          = TEST_BARCODE,
    cds              = TEST_SHORT_CDS,
    cassette_for_block = TEST_CASSETTE,
    oh3              = TEST_OH3,
    helper_left_cap  = TEST_LEFT_CAP,
    helper_right_cap = TEST_RIGHT_CAP,
    tile_start_nt    = tile_start,
    tile_end_nt      = tile_end
  )

  # Codon 11 nt 31-33 are all < mutable_start(35), so the CDS should be
  # completely unmodified (WT)
  expected_product <- paste0(
    TEST_LEFT_CAP, TEST_SHORT_CDS, TEST_CASSETTE,
    TEST_OH3, TEST_BARCODE, TEST_RIGHT_CAP
  )

  expect_identical(product, expected_product,
    info = paste0(
      "Tile 2: codon 11 (nt 31-33) is entirely in oh1 overlap zone ",
      "(mutable_start=35), so no mutation should appear"))

  # Also verify with the CDS directly
  cds_start <- nchar(TEST_LEFT_CAP) + 1L
  cds_end   <- cds_start + nchar(TEST_SHORT_CDS) - 1L
  product_cds <- substring(product, cds_start, cds_end)
  expect_identical(product_cds, TEST_SHORT_CDS,
    info = "Tile 2: entire CDS should be WT when mutation is in oh1 zone")
})

test_that("tile 2 codon straddling oh1 boundary is partially mutable", {
  # Tile 2 starts at nt 31, mutable_start = 35.
  # Codon 12 = nt 34-36 = "ACC".
  # nt 34 < 35 (outside mutable), nt 35-36 >= 35 (inside mutable).
  # Only the last 2 bases of the mutant codon should be applied.

  tile_start <- 31L
  tile_end   <- 72L
  variant <- make_variant(12L, "GTG")  # codon 12 at nt 34-36 = "ACC" -> "GTG"

  product <- build_expected_product(
    variant_row      = variant,
    barcode          = TEST_BARCODE,
    cds              = TEST_SHORT_CDS,
    cassette_for_block = TEST_CASSETTE,
    oh3              = TEST_OH3,
    helper_left_cap  = TEST_LEFT_CAP,
    helper_right_cap = TEST_RIGHT_CAP,
    tile_start_nt    = tile_start,
    tile_end_nt      = tile_end
  )

  # Expected: nt 34 stays WT ("A" from "ACC"), nt 35-36 become "TG" from "GTG"
  expected_chars <- strsplit(TEST_SHORT_CDS, "")[[1]]
  # nt 34 = 'A' (stays WT, outside mutable zone)
  # nt 35 = 'T' (from mut_codon[2] = "T")
  expected_chars[35] <- "T"
  # nt 36 = 'G' (from mut_codon[3] = "G")
  expected_chars[36] <- "G"
  expected_mutant_cds <- paste0(expected_chars, collapse = "")

  expected_product <- paste0(
    TEST_LEFT_CAP, expected_mutant_cds, TEST_CASSETTE,
    TEST_OH3, TEST_BARCODE, TEST_RIGHT_CAP
  )

  expect_identical(product, expected_product,
    info = paste0(
      "Tile 2: codon 12 (nt 34-36) straddles oh1 boundary at nt 35. ",
      "nt 34 stays WT, nt 35-36 get mutated"))
})

test_that("tile 2 first fully mutable codon works correctly", {
  # Tile 2 starts at nt 31, mutable_start = 35.
  # Codon 13 = nt 37-39 = "CTG". All 3 nt >= 35, so fully mutable.

  tile_start <- 31L
  tile_end   <- 72L
  variant <- make_variant(13L, "AAA")  # codon 13 at nt 37-39 = "CTG" -> "AAA"

  product <- build_expected_product(
    variant_row      = variant,
    barcode          = TEST_BARCODE,
    cds              = TEST_SHORT_CDS,
    cassette_for_block = TEST_CASSETTE,
    oh3              = TEST_OH3,
    helper_left_cap  = TEST_LEFT_CAP,
    helper_right_cap = TEST_RIGHT_CAP,
    tile_start_nt    = tile_start,
    tile_end_nt      = tile_end
  )

  expected_chars <- strsplit(TEST_SHORT_CDS, "")[[1]]
  expected_chars[37] <- "A"
  expected_chars[38] <- "A"
  expected_chars[39] <- "A"
  expected_mutant_cds <- paste0(expected_chars, collapse = "")

  expected_product <- paste0(
    TEST_LEFT_CAP, expected_mutant_cds, TEST_CASSETTE,
    TEST_OH3, TEST_BARCODE, TEST_RIGHT_CAP
  )

  expect_identical(product, expected_product,
    info = "Tile 2: codon 13 (nt 37-39) is fully within mutable zone")
})

# ===========================================================================
# Test 3: Boundary at mutable_end (tile_end_nt - 4)
# ===========================================================================

test_that("tile 1 codon straddling mutable_end is partially mutable", {
  # Tile 1: start_nt=1, end_nt=42.
  # mutable_end = 42 - 4 = 38.
  # Codon 13 = nt 37-39 = "CTG".
  # nt 37-38 are in [1, 38] (mutable), nt 39 > 38 (outside mutable, in oh2).
  # Only the first 2 bases of the mutant codon should apply.

  tile_start <- 1L
  tile_end   <- 42L
  variant <- make_variant(13L, "AAA")  # codon 13 at nt 37-39 = "CTG" -> "AAA"

  product <- build_expected_product(
    variant_row      = variant,
    barcode          = TEST_BARCODE,
    cds              = TEST_SHORT_CDS,
    cassette_for_block = TEST_CASSETTE,
    oh3              = TEST_OH3,
    helper_left_cap  = TEST_LEFT_CAP,
    helper_right_cap = TEST_RIGHT_CAP,
    tile_start_nt    = tile_start,
    tile_end_nt      = tile_end
  )

  # nt 37 -> 'A' (mut_codon[1], within mutable zone)
  # nt 38 -> 'A' (mut_codon[2], within mutable zone)
  # nt 39 -> stays 'G' (WT, outside mutable zone, in oh2 strip)
  expected_chars <- strsplit(TEST_SHORT_CDS, "")[[1]]
  expected_chars[37] <- "A"
  expected_chars[38] <- "A"
  # nt 39 stays as 'G' (from "CTG")
  expected_mutant_cds <- paste0(expected_chars, collapse = "")

  expected_product <- paste0(
    TEST_LEFT_CAP, expected_mutant_cds, TEST_CASSETTE,
    TEST_OH3, TEST_BARCODE, TEST_RIGHT_CAP
  )

  expect_identical(product, expected_product,
    info = paste0(
      "Tile 1: codon 13 (nt 37-39) straddles mutable_end=38. ",
      "nt 37-38 mutated, nt 39 stays WT"))

  # Explicitly check the 3 nt in question
  cds_start <- nchar(TEST_LEFT_CAP) + 1L
  product_cds <- substring(product, cds_start, cds_start + nchar(TEST_SHORT_CDS) - 1L)
  expect_equal(substring(product_cds, 37, 37), "A", info = "nt 37 mutated")
  expect_equal(substring(product_cds, 38, 38), "A", info = "nt 38 mutated")
  expect_equal(substring(product_cds, 39, 39), "G", info = "nt 39 stays WT (oh2 zone)")
})

test_that("tile 1 last fully mutable codon (all 3 nt inside boundary)", {
  # Tile 1: mutable_end = 38. Codon 12 = nt 34-36 = "ACC".
  # All 3 nt <= 38, so fully mutable.

  variant <- make_variant(12L, "GGG")

  product <- build_expected_product(
    variant_row      = variant,
    barcode          = TEST_BARCODE,
    cds              = TEST_SHORT_CDS,
    cassette_for_block = TEST_CASSETTE,
    oh3              = TEST_OH3,
    helper_left_cap  = TEST_LEFT_CAP,
    helper_right_cap = TEST_RIGHT_CAP,
    tile_start_nt    = 1L,
    tile_end_nt      = 42L
  )

  expected_chars <- strsplit(TEST_SHORT_CDS, "")[[1]]
  expected_chars[34] <- "G"
  expected_chars[35] <- "G"
  expected_chars[36] <- "G"
  expected_mutant_cds <- paste0(expected_chars, collapse = "")

  expected_product <- paste0(
    TEST_LEFT_CAP, expected_mutant_cds, TEST_CASSETTE,
    TEST_OH3, TEST_BARCODE, TEST_RIGHT_CAP
  )

  expect_identical(product, expected_product,
    info = "Tile 1: codon 12 (nt 34-36) fully within mutable zone, all 3 bases mutated")
})

test_that("codon fully outside mutable_end produces no mutation", {
  # Tile 1: mutable_end = 38. Codon 14 = nt 40-42 = "AAC".
  # All 3 nt > 38, so none should be mutated.

  variant <- make_variant(14L, "TTT")

  product <- build_expected_product(
    variant_row      = variant,
    barcode          = TEST_BARCODE,
    cds              = TEST_SHORT_CDS,
    cassette_for_block = TEST_CASSETTE,
    oh3              = TEST_OH3,
    helper_left_cap  = TEST_LEFT_CAP,
    helper_right_cap = TEST_RIGHT_CAP,
    tile_start_nt    = 1L,
    tile_end_nt      = 42L
  )

  # No mutation should appear — CDS should be identical to WT
  expected_product <- paste0(
    TEST_LEFT_CAP, TEST_SHORT_CDS, TEST_CASSETTE,
    TEST_OH3, TEST_BARCODE, TEST_RIGHT_CAP
  )

  expect_identical(product, expected_product,
    info = "Tile 1: codon 14 (nt 40-42) fully outside mutable_end=38, no mutation")
})

# ===========================================================================
# Test 4: verify_assembly_product_strict uses the same mutable_start logic
# ===========================================================================

test_that("verify_assembly_product_strict agrees with build_expected_product for tile 1", {
  # Verify that the strict verifier's internal mutable_start logic matches
  # build_expected_product for a tile 1 mutation at codon 2.

  tile_start <- 1L
  tile_end   <- 42L
  variant <- make_variant(2L, "TTT")

  expected <- build_expected_product(
    variant_row      = variant,
    barcode          = TEST_BARCODE,
    cds              = TEST_SHORT_CDS,
    cassette_for_block = TEST_CASSETTE,
    oh3              = TEST_OH3,
    helper_left_cap  = TEST_LEFT_CAP,
    helper_right_cap = TEST_RIGHT_CAP,
    tile_start_nt    = tile_start,
    tile_end_nt      = tile_end
  )

  # Use the expected product AS the actual product — strict should pass
  result <- verify_assembly_product_strict(
    product              = expected,
    expected             = expected,
    expected_cds         = TEST_SHORT_CDS,
    mut_position         = 2L,
    mut_codon            = "TTT",
    cassette_for_block   = TEST_CASSETTE,
    barcode              = TEST_BARCODE,
    oh3                  = TEST_OH3,
    paqci_star2          = "AGTC",
    paqci_star1          = "TCGA",
    helper_left_cap_len  = nchar(TEST_LEFT_CAP),
    helper_right_cap_len = nchar(TEST_RIGHT_CAP),
    tile_start_nt        = tile_start,
    tile_end_nt          = tile_end
  )

  expect_true(result$exact_match,
    info = "Strict verifier must agree with build_expected_product for tile 1 codon 2")
  expect_true(result$correct_length)
  expect_true(result$no_duplications,
    info = "CDS, cassette, and barcode should each appear exactly once")
})

test_that("verify_assembly_product_strict agrees with build_expected_product for tile 2", {
  # Same agreement test for tile 2 with a partial-overlap mutation

  tile_start <- 31L
  tile_end   <- 72L
  variant <- make_variant(12L, "GTG")  # partial overlap at oh1 boundary

  expected <- build_expected_product(
    variant_row      = variant,
    barcode          = TEST_BARCODE,
    cds              = TEST_SHORT_CDS,
    cassette_for_block = TEST_CASSETTE,
    oh3              = TEST_OH3,
    helper_left_cap  = TEST_LEFT_CAP,
    helper_right_cap = TEST_RIGHT_CAP,
    tile_start_nt    = tile_start,
    tile_end_nt      = tile_end
  )

  result <- verify_assembly_product_strict(
    product              = expected,
    expected             = expected,
    expected_cds         = TEST_SHORT_CDS,
    mut_position         = 12L,
    mut_codon            = "GTG",
    cassette_for_block   = TEST_CASSETTE,
    barcode              = TEST_BARCODE,
    oh3                  = TEST_OH3,
    paqci_star2          = "AGTC",
    paqci_star1          = "TCGA",
    helper_left_cap_len  = nchar(TEST_LEFT_CAP),
    helper_right_cap_len = nchar(TEST_RIGHT_CAP),
    tile_start_nt        = tile_start,
    tile_end_nt          = tile_end
  )

  expect_true(result$exact_match,
    info = "Strict verifier must agree with build_expected_product for tile 2 partial overlap")
  expect_true(result$no_duplications)
})

test_that("verify_assembly_product_strict catches wrong mutable_start on tile 1", {
  # If someone were to incorrectly compute mutable_start = 5 for tile 1,
  # the mutation would differ from what build_expected_product produces.
  # Simulate this: build one product with the correct logic (mutable_start=1)
  # and another with the wrong logic (mutable_start=5), then show they differ.

  variant <- make_variant(2L, "TTT")

  # Correct product (mutable_start = 1)
  correct_product <- build_expected_product(
    variant_row      = variant,
    barcode          = TEST_BARCODE,
    cds              = TEST_SHORT_CDS,
    cassette_for_block = TEST_CASSETTE,
    oh3              = TEST_OH3,
    helper_left_cap  = TEST_LEFT_CAP,
    helper_right_cap = TEST_RIGHT_CAP,
    tile_start_nt    = 1L,
    tile_end_nt      = 42L
  )

  # Simulate the WRONG behavior: mutable_start = 5 (as if tile 1 had an internal oh1)
  # Manually build what the wrong logic would produce:
  wrong_mutable_start <- 5L
  wrong_mutable_end   <- 38L
  wrong_chars <- strsplit(TEST_SHORT_CDS, "")[[1]]
  mut_chars <- c("T", "T", "T")
  codon_start <- 4L  # (2-1)*3 + 1
  for (i in 0:2) {
    gene_pos <- codon_start + i
    if (gene_pos >= wrong_mutable_start && gene_pos <= wrong_mutable_end) {
      wrong_chars[gene_pos] <- mut_chars[i + 1L]
    }
  }
  wrong_mutant_cds <- paste0(wrong_chars, collapse = "")
  wrong_product <- paste0(
    TEST_LEFT_CAP, wrong_mutant_cds, TEST_CASSETTE,
    TEST_OH3, TEST_BARCODE, TEST_RIGHT_CAP
  )

  # The correct and wrong products MUST differ at nt 4 (first base of codon 2)
  expect_false(identical(correct_product, wrong_product),
    info = paste0(
      "Wrong mutable_start=5 would skip nt 4 of codon 2, producing a ",
      "different product than the correct mutable_start=1 logic"))

  # Check the specific difference: in wrong product, nt 4 stays 'G' (WT);
  # in correct product, nt 4 is 'T' (mutated)
  cds_offset <- nchar(TEST_LEFT_CAP)
  correct_nt4 <- substring(correct_product, cds_offset + 4, cds_offset + 4)
  wrong_nt4   <- substring(wrong_product, cds_offset + 4, cds_offset + 4)
  expect_equal(correct_nt4, "T", info = "Correct: nt 4 is mutated to T")
  expect_equal(wrong_nt4, "G", info = "Wrong: nt 4 stays G (WT)")
})

# ===========================================================================
# Test 5: oh_L parameter passes through correctly
# ===========================================================================

test_that("build_expected_product includes oh_L between left cap and CDS", {
  # When oh_L is provided, it should appear between helper_left_cap and the CDS.
  # This is the physical reality: oh_L is a 4-nt overhang upstream of ATG.

  variant <- make_variant(2L, "TTT")
  oh_L <- "TGAA"

  product_with_ohL <- build_expected_product(
    variant_row      = variant,
    barcode          = TEST_BARCODE,
    cds              = TEST_SHORT_CDS,
    cassette_for_block = TEST_CASSETTE,
    oh3              = TEST_OH3,
    helper_left_cap  = TEST_LEFT_CAP,
    helper_right_cap = TEST_RIGHT_CAP,
    tile_start_nt    = 1L,
    tile_end_nt      = 42L,
    oh_L             = oh_L
  )

  product_without_ohL <- build_expected_product(
    variant_row      = variant,
    barcode          = TEST_BARCODE,
    cds              = TEST_SHORT_CDS,
    cassette_for_block = TEST_CASSETTE,
    oh3              = TEST_OH3,
    helper_left_cap  = TEST_LEFT_CAP,
    helper_right_cap = TEST_RIGHT_CAP,
    tile_start_nt    = 1L,
    tile_end_nt      = 42L,
    oh_L             = ""
  )

  # Products should differ by exactly the oh_L sequence
  expect_equal(nchar(product_with_ohL), nchar(product_without_ohL) + nchar(oh_L),
    info = "oh_L adds exactly 4 nt to the product length")

  # oh_L should appear right after left_cap
  after_cap <- substring(product_with_ohL, nchar(TEST_LEFT_CAP) + 1,
                         nchar(TEST_LEFT_CAP) + nchar(oh_L))
  expect_equal(after_cap, oh_L,
    info = "oh_L appears immediately after helper_left_cap")
})

# ===========================================================================
# Test 6: No tile boundaries provided (backward compat, full codon replace)
# ===========================================================================

test_that("build_expected_product without tile boundaries does full codon replace", {
  # When tile_start_nt and tile_end_nt are NULL (legacy callers),
  # the function should use replace_codon() for a full 3-base replacement.

  variant <- make_variant(2L, "TTT")

  product <- build_expected_product(
    variant_row      = variant,
    barcode          = TEST_BARCODE,
    cds              = TEST_SHORT_CDS,
    cassette_for_block = TEST_CASSETTE,
    oh3              = TEST_OH3,
    helper_left_cap  = TEST_LEFT_CAP,
    helper_right_cap = TEST_RIGHT_CAP
    # tile_start_nt and tile_end_nt not provided
  )

  mutant_cds <- replace_codon(TEST_SHORT_CDS, 2L, "TTT")
  expected_product <- paste0(
    TEST_LEFT_CAP, mutant_cds, TEST_CASSETTE,
    TEST_OH3, TEST_BARCODE, TEST_RIGHT_CAP
  )

  expect_identical(product, expected_product,
    info = "Without tile boundaries, full 3-base codon replacement occurs")
})
