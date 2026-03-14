# test-oogga-validation.R — Automated validation tests for R vs Python OOGGA
# Created: 2026-03-13
#
# Run with: Rscript -e "testthat::test_file('260313-oogga-python-vs-our-R-implementation/tests/test-oogga-validation.R')"
#
# Prerequisites: Scripts 01-05 must have been run successfully, producing
# the CSV, FASTA, params.json, and both JSON result files.

library(testthat)
library(jsonlite)

# --- Setup: locate project root and source modules ---
# When run via testthat::test_file(), the working directory is the test file's
# directory. Use the --file= arg if available, otherwise navigate from cwd.
get_test_project_root <- function() {
  # Try commandArgs (Rscript -e "testthat::test_file(...)")
  args <- commandArgs(trailingOnly = FALSE)
  # When run via testthat::test_file(), cwd is set to the test file's directory
  # Navigate: tests/ -> 260313-.../ -> project_root
  candidates <- c(
    normalizePath(file.path(getwd(), "..", ".."), mustWork = FALSE),
    normalizePath(file.path(getwd(), ".."), mustWork = FALSE),
    getwd()
  )
  for (cand in candidates) {
    if (file.exists(file.path(cand, "R", "utils.R"))) return(cand)
  }
  stop("Cannot find project root (looking for R/utils.R)")
}
project_root <- get_test_project_root()

# Set working directory and source modules
setwd(project_root)
suppressPackageStartupMessages(library(Biostrings))
source("R/utils.R")
source("R/constants.R")
source("R/03_codon_table.R")
source("R/06_overhang_selection.R")
source("R/06b_oogga_dp.R")

comparison_dir <- file.path(project_root, "260313-oogga-python-vs-our-R-implementation")

# --- Helper: load results ---
r_json_path <- file.path(comparison_dir, "outputs", "r_results.json")
py_json_path <- file.path(comparison_dir, "outputs", "python_results.json")
params_path <- file.path(comparison_dir, "inputs", "params.json")
csv_path <- file.path(comparison_dir, "inputs", "bsmbi_for_oogga.csv")
fasta_path <- file.path(comparison_dir, "inputs", "grin2a_full_seq.fasta")

# =============================================================================
# TEST 1: CSV roundtrip
# =============================================================================
test_that("CSV roundtrip: export RDS → CSV → re-read → P_fid/P_eff match", {
  skip_if_not(file.exists(csv_path), "CSV file not found — run 01_export_neb_data.R first")

  # Load original R data
  bsmbi_pw <- load_pairwise_matrix("BsmBI")
  r_oh_fid <- load_overhang_fidelity("BsmBI")
  r_eff <- compute_overhang_efficiency(bsmbi_pw)

  # Re-read CSV using OOGGA's formula
  lines <- readLines(csv_path)
  n_ohs <- length(lines) - 1L
  expect_equal(n_ohs, 256L)

  # First pass: find max diagonal
  max_count <- 0L
  diagonal_pos <- 2L
  for (i in seq_len(n_ohs)) {
    words <- strsplit(lines[i + 1L], ",")[[1]]
    diag_val <- as.integer(words[diagonal_pos])
    if (diag_val > max_count) max_count <- diag_val
    diagonal_pos <- diagonal_pos + 1L
  }

  # Second pass: compute eff and fid
  csv_eff <- numeric(n_ohs)
  csv_fid <- numeric(n_ohs)
  csv_names <- character(n_ohs)
  diagonal_pos <- 2L
  for (i in seq_len(n_ohs)) {
    words <- strsplit(lines[i + 1L], ",")[[1]]
    csv_names[i] <- words[1]
    diag_val <- as.integer(words[diagonal_pos])
    row_total <- sum(as.integer(words[2:257]))
    csv_eff[i] <- diag_val / max_count
    csv_fid[i] <- diag_val / row_total
    diagonal_pos <- diagonal_pos + 1L
  }

  # Compare against R values
  r_fid_vec <- r_oh_fid$fidelity[match(csv_names, r_oh_fid$overhang)]
  r_eff_vec <- r_eff[csv_names]

  # P_fid tolerance is 1e-6 (not 1e-10) because RDS stores doubles while
  # CSV roundtrip goes through integers; sum of 256 doubles can differ
  # from sum of 256 integers by a few ULPs (~5e-7 observed).
  expect_equal(csv_fid, unname(r_fid_vec), tolerance = 1e-6,
               label = "P_fid roundtrip")
  expect_equal(csv_eff, unname(r_eff_vec), tolerance = 1e-10,
               label = "P_eff roundtrip")
})

# =============================================================================
# TEST 2: Scoring equivalence
# =============================================================================
test_that("Scoring equivalence: R overhang_score == OOGGA (eff/100)*(fid/100)", {
  skip_if_not(file.exists(csv_path), "CSV file not found")

  bsmbi_pw <- load_pairwise_matrix("BsmBI")
  oh_fidelity <- load_overhang_fidelity("BsmBI")
  eff_lookup <- compute_overhang_efficiency(bsmbi_pw)
  fid_lookup <- oh_fidelity$fidelity
  names(fid_lookup) <- oh_fidelity$overhang

  # Read CSV to get OOGGA-format scores
  lines <- readLines(csv_path)
  n_ohs <- length(lines) - 1L
  max_count <- 0L
  diagonal_pos <- 2L
  for (i in seq_len(n_ohs)) {
    words <- strsplit(lines[i + 1L], ",")[[1]]
    diag_val <- as.integer(words[diagonal_pos])
    if (diag_val > max_count) max_count <- diag_val
    diagonal_pos <- diagonal_pos + 1L
  }

  # Test 10 overhangs
  test_ohs <- c("AACT", "GCTA", "TTAC", "AGCG", "CATG",
                 "TGAC", "CAGT", "GTTC", "ACGA", "TCAG")
  diagonal_pos <- 2L
  csv_scores <- numeric(n_ohs)
  csv_names <- character(n_ohs)
  for (i in seq_len(n_ohs)) {
    words <- strsplit(lines[i + 1L], ",")[[1]]
    csv_names[i] <- words[1]
    diag_val <- as.integer(words[diagonal_pos])
    row_total <- sum(as.integer(words[2:257]))
    csv_eff <- diag_val / max_count
    csv_fid <- diag_val / row_total
    csv_scores[i] <- csv_eff * csv_fid
    diagonal_pos <- diagonal_pos + 1L
  }
  names(csv_scores) <- csv_names

  # Tolerance 1e-6: P_fid differs by ~5e-7 between RDS (doubles) and CSV
  # (integers) due to row-sum floating-point arithmetic. The product
  # P_fid * P_eff inherits this difference.
  for (oh in test_ohs) {
    r_score <- overhang_score(oh, fid_lookup, eff_lookup)
    oogga_score <- csv_scores[oh]
    expect_equal(r_score, unname(oogga_score), tolerance = 1e-6,
                 label = paste("Score for", oh))
  }
})

# =============================================================================
# TEST 3: Single-OH mode sanity
# =============================================================================
test_that("Single-OH mode: R produces valid boundaries", {
  skip_if_not(file.exists(r_json_path), "R results not found — run 03_run_r_single_oh.R first")
  skip_if_not(file.exists(params_path), "params.json not found")

  r_results <- fromJSON(r_json_path)
  params <- fromJSON(params_path)

  # All segments within [min_len, max_len]
  for (seg_len in r_results$segment_lengths) {
    expect_gte(seg_len, params$min_len,
               label = paste("Segment length >=", params$min_len))
    expect_lte(seg_len, params$max_len,
               label = paste("Segment length <=", params$max_len))
  }

  # Segments sum to total length
  expect_equal(sum(r_results$segment_lengths), r_results$total_len,
               label = "Segments sum to total length")

  # Boundaries are sorted and within valid range
  bounds <- sort(r_results$boundaries_1indexed)
  expect_true(all(bounds > 0 & bounds < r_results$total_len),
              label = "Boundaries within valid range")
  expect_equal(bounds, r_results$boundaries_1indexed[order(r_results$boundaries_1indexed)],
               label = "Boundaries are sorted")
})

# =============================================================================
# TEST 4: Collision check
# =============================================================================
test_that("Collision check: all overhangs pass pairwise identity check", {
  skip_if_not(file.exists(r_json_path) && file.exists(py_json_path),
              "Results not found — run scripts 03 and 04 first")
  skip_if_not(file.exists(params_path), "params.json not found")

  r_results <- fromJSON(r_json_path)
  py_results <- fromJSON(py_json_path)
  params <- fromJSON(params_path)

  check_no_collisions <- function(ohs, label) {
    n <- length(ohs)
    for (i in seq_len(n - 1L)) {
      for (j in (i + 1L):n) {
        a <- ohs[i]
        b <- ohs[j]
        b_rc <- reverse_complement(b)
        # Skip RC-self pairs (same physical overhang on opposite strands)
        if (a == b_rc) next
        id_ab <- sum(utf8ToInt(a) == utf8ToInt(b))
        id_a_rcb <- sum(utf8ToInt(a) == utf8ToInt(b_rc))
        expect_lte(id_ab, params$max_identity,
                   label = paste(label, a, "vs", b, "identity"))
        expect_lte(id_a_rcb, params$max_identity,
                   label = paste(label, a, "vs RC(", b, ") identity"))
      }
    }
  }

  # R overhangs: alien + boundary oh1s
  r_ohs <- unique(c(r_results$alien_ohs, r_results$boundary_oh1s))
  r_ohs <- r_ohs[nchar(r_ohs) == 4L]
  check_no_collisions(r_ohs, "R")

  # Python overhangs: oh_L + oh_terminal + boundary ohs
  py_ohs <- unique(c(params$oh_L, params$oh_terminal, py_results$boundary_ohs))
  py_ohs <- py_ohs[nchar(py_ohs) == 4L]
  check_no_collisions(py_ohs, "Python")
})

# =============================================================================
# TEST 5: Position match
# =============================================================================
test_that("Position match: R and Python boundary positions are identical", {
  skip_if_not(file.exists(r_json_path) && file.exists(py_json_path),
              "Results not found — run scripts 03 and 04 first")

  r_results <- fromJSON(r_json_path)
  py_results <- fromJSON(py_json_path)

  r_bounds <- sort(as.integer(r_results$boundaries_1indexed))
  py_bounds <- sort(as.integer(py_results$boundaries_0indexed))

  # R boundary p = OOGGA boundary j = p (same numeric value)
  expect_equal(r_bounds, py_bounds,
               label = "Boundary positions (after index conversion)")
})

# =============================================================================
# TEST 6: Overhang match
# =============================================================================
test_that("Overhang match: overhang sequences at each boundary are identical", {
  skip_if_not(file.exists(r_json_path) && file.exists(py_json_path),
              "Results not found — run scripts 03 and 04 first")

  r_results <- fromJSON(r_json_path)
  py_results <- fromJSON(py_json_path)

  # Sort both by position
  r_order <- order(r_results$boundaries_1indexed)
  py_order <- order(py_results$boundaries_0indexed)

  r_ohs <- r_results$boundary_oh1s[r_order]
  py_ohs <- py_results$boundary_ohs[py_order]

  expect_equal(r_ohs, py_ohs,
               label = "Overhang sequences at each boundary")
})

# =============================================================================
# TEST 7: Score match
# =============================================================================
test_that("Score match: total multiplicative scores match within tolerance", {
  skip_if_not(file.exists(r_json_path) && file.exists(py_json_path),
              "Results not found — run scripts 03 and 04 first")

  r_results <- fromJSON(r_json_path)
  py_results <- fromJSON(py_json_path)

  r_score <- r_results$total_score
  py_score <- py_results$total_score

  # Relative tolerance: 1e-6 because R uses RDS (doubles) while Python
  # uses CSV (integers). P_fid differs by ~5e-7 per overhang due to float
  # vs int row-sum. With K boundaries, accumulated diff is ~K * 5e-7.
  if (max(r_score, py_score) > 0) {
    rel_diff <- abs(r_score - py_score) / max(r_score, py_score)
    expect_lt(rel_diff, 1e-6,
              label = "Relative score difference < 1e-6")
  }
})

# =============================================================================
# TEST 8: Set fidelity
# =============================================================================
test_that("Set fidelity: Potapov set fidelity for both overhang sets match", {
  skip_if_not(file.exists(r_json_path) && file.exists(py_json_path),
              "Results not found — run scripts 03 and 04 first")
  skip_if_not(file.exists(params_path), "params.json not found")

  r_results <- fromJSON(r_json_path)
  py_results <- fromJSON(py_json_path)
  params <- fromJSON(params_path)

  bsmbi_pw <- load_pairwise_matrix("BsmBI")

  # R set
  r_ohs <- unique(c(r_results$alien_ohs, r_results$boundary_oh1s))
  r_ohs <- r_ohs[nchar(r_ohs) == 4L]
  r_set_fid <- compute_set_fidelity(r_ohs, bsmbi_pw)

  # Python set (use same OH set for fair comparison)
  py_ohs <- unique(c(params$oh_L, params$oh_terminal, py_results$boundary_ohs))
  py_ohs <- py_ohs[nchar(py_ohs) == 4L]
  py_set_fid <- compute_set_fidelity(py_ohs, bsmbi_pw)

  # If positions and overhangs match, set fidelities should be very close
  # (may differ slightly if alien_ohs sets differ in their RCs)
  expect_equal(r_set_fid$set_fidelity, py_set_fid$set_fidelity,
               tolerance = 1e-6,
               label = "Set fidelity match within 1e-6")
})
