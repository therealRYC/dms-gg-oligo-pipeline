# Smoke-test script: oh_L validation in validate_config()
# Run standalone via Rscript — sources pipeline files directly.

suppressPackageStartupMessages({
  library(Biostrings)
  library(yaml)
  library(cli)
})

# --- Source pipeline modules in dependency order ---
# Resolve project root relative to this test file's actual location
PIPELINE_ROOT <- normalizePath(file.path(
  testthat::test_path(), "..", ".."
), mustWork = TRUE)

`%||%` <- function(a, b) if (!is.null(a)) a else b

options(dmsggoligo.data_dir = file.path(PIPELINE_ROOT, "data"))

source(file.path(PIPELINE_ROOT, "R", "constants.R"))
source(file.path(PIPELINE_ROOT, "R", "utils.R"))
source(file.path(PIPELINE_ROOT, "R", "00_config.R"))

# --- Helper: build a minimal valid config for validate_config() ---
# All required fields present, with oh_L = "TGAA" as the valid baseline.
make_base_config <- function(oh_L_val = "TGAA") {
  list(
    gene_cds            = "ATGGCTGAATAA",
    polIII_promoter     = "ACGTACGTACGT",
    paqci_star2         = "AGTC",
    paqci_star1         = "TCGA",
    oh_L                = oh_L_val,
    upstream_cassette   = "",
    oh3                 = "ACTA",
    oh4                 = "GATA",
    max_oligo_length    = 300L,
    max_geneblock_length = 1800L,
    min_geneblock_length = 300L,
    barcode_length      = 20L,
    min_hamming_distance = 3L,
    barcode_prefix_length = 12L,
    barcode_gc_range    = c(0.25, 0.75),
    barcode_max_homopolymer = 4L,
    barcodes_per_variant = 10L,
    overlap_codons      = 6L,
    geneblock_flanking_pad = "TGCATG",
    handle_overhead     = 0L,
    fwd_handle_length   = 0L,
    rev_handle_length   = 0L,
    barcode_filter_hairpin = TRUE,
    barcode_max_hairpin_stem = 3L,
    barcode_filter_dinuc_repeats = TRUE,
    barcode_max_dinuc_repeat_units = 4L,
    barcode_filter_polyg = FALSE,
    barcode_max_polyg   = 2L,
    barcode_filter_ggc  = FALSE,
    barcode_filter_tm_uniformity = FALSE,
    barcode_tm_tolerance = 2.0
  )
}

# --- Test runner ---
# Each test: name, config-modification, expected_error_regex (NULL = should pass)
tests <- list(
  list(
    id   = 1,
    name = "oh_L missing (NULL)",
    modify = function(cfg) { cfg$oh_L <- NULL; cfg },
    expect_error_re = "oh_L must be specified",
    should_pass = FALSE
  ),
  list(
    id   = 2,
    name = "oh_L = 'NNNN'",
    modify = function(cfg) { cfg$oh_L <- "NNNN"; cfg },
    expect_error_re = "oh_L must be specified",
    should_pass = FALSE
  ),
  list(
    id   = 3,
    name = "oh_L = 'ACG' (3 chars)",
    modify = function(cfg) { cfg$oh_L <- "ACG"; cfg },
    expect_error_re = "oh_L must be exactly 4 ACGT",
    should_pass = FALSE
  ),
  list(
    id   = 4,
    name = "oh_L = 'ACGU' (RNA)",
    modify = function(cfg) { cfg$oh_L <- "ACGU"; cfg },
    expect_error_re = "oh_L must be exactly 4 ACGT",
    should_pass = FALSE
  ),
  list(
    id   = 5,
    name = "oh_L = 'AAAA' (homopolymer)",
    modify = function(cfg) { cfg$oh_L <- "AAAA"; cfg },
    expect_error_re = "homopolymer",
    should_pass = FALSE
  ),
  list(
    id   = 6,
    name = "oh_L = 'ACGT' (palindromic)",
    modify = function(cfg) { cfg$oh_L <- "ACGT"; cfg },
    expect_error_re = "palindromic",
    should_pass = FALSE
  ),
  list(
    id   = 7,
    name = "oh_L = oh3 collision",
    modify = function(cfg) { cfg$oh_L <- "ACTA"; cfg$oh3 <- "ACTA"; cfg },
    expect_error_re = "oh_L.*collides with oh3",
    should_pass = FALSE
  ),
  list(
    id   = 8,
    name = "oh_L = 'TGAA' (valid)",
    modify = function(cfg) { cfg$oh_L <- "TGAA"; cfg },
    expect_error_re = NULL,
    should_pass = TRUE
  ),
  list(
    id   = 9,
    name = "oh_L = 'tgaa' (lowercase)",
    modify = function(cfg) { cfg$oh_L <- "tgaa"; cfg },
    expect_error_re = NULL,
    should_pass = TRUE
  )
)

# --- Execute tests ---
results <- data.frame(
  ID       = integer(0),
  Test     = character(0),
  Expected = character(0),
  Actual   = character(0),
  Status   = character(0),
  Message  = character(0),
  stringsAsFactors = FALSE
)

for (tt in tests) {
  cfg <- make_base_config()
  cfg <- tt$modify(cfg)

  # For the lowercase test (id 9), we must uppercase oh_L BEFORE calling
  # validate_config, because load_config() does the uppercasing — but here
  # we're calling validate_config() directly.
  # This mirrors the real pipeline path: load_config -> toupper -> validate_config.
  if (!is.null(cfg$oh_L)) cfg$oh_L <- toupper(cfg$oh_L)

  err_msg <- tryCatch(
    {
      validate_config(cfg)
      NULL # no error
    },
    error = function(e) conditionMessage(e)
  )

  if (tt$should_pass) {
    if (is.null(err_msg)) {
      status <- "PASS"
      detail <- "No error (as expected)"
    } else {
      status <- "FAIL"
      detail <- paste0("Unexpected error: ", err_msg)
    }
  } else {
    if (is.null(err_msg)) {
      status <- "FAIL"
      detail <- "Expected error but none raised"
    } else if (grepl(tt$expect_error_re, err_msg)) {
      status <- "PASS"
      detail <- paste0("Error matched: ", substr(err_msg, 1, 80))
    } else {
      status <- "FAIL"
      detail <- paste0("Error raised but pattern '", tt$expect_error_re,
                        "' not matched. Got: ", err_msg)
    }
  }

  results <- rbind(results, data.frame(
    ID       = tt$id,
    Test     = tt$name,
    Expected = if (tt$should_pass) "PASS" else "ERROR",
    Actual   = if (is.null(err_msg)) "PASS" else "ERROR",
    Status   = status,
    Message  = detail,
    stringsAsFactors = FALSE
  ))
}

# --- Print results ---
cat("\n========================================\n")
cat("  oh_L Validation Smoke Test Results\n")
cat("========================================\n\n")

# Print as aligned table
col_widths <- c(3, 30, 8, 8, 6, 60)
header <- sprintf("%-*s  %-*s  %-*s  %-*s  %-*s  %-*s",
  col_widths[1], "ID",
  col_widths[2], "Test",
  col_widths[3], "Expected",
  col_widths[4], "Actual",
  col_widths[5], "Status",
  col_widths[6], "Message")
cat(header, "\n")
cat(paste(rep("-", sum(col_widths) + 10), collapse = ""), "\n")

for (i in seq_len(nrow(results))) {
  r <- results[i, ]
  line <- sprintf("%-*d  %-*s  %-*s  %-*s  %-*s  %-*s",
    col_widths[1], r$ID,
    col_widths[2], r$Test,
    col_widths[3], r$Expected,
    col_widths[4], r$Actual,
    col_widths[5], r$Status,
    col_widths[6], substr(r$Message, 1, col_widths[6]))
  cat(line, "\n")
}

# Summary
n_pass <- sum(results$Status == "PASS")
n_fail <- sum(results$Status == "FAIL")
cat("\n----------------------------------------\n")
cat(sprintf("Total: %d | PASS: %d | FAIL: %d\n", nrow(results), n_pass, n_fail))
if (n_fail > 0) {
  cat("\n*** FAILURES ***\n")
  fails <- results[results$Status == "FAIL", ]
  for (i in seq_len(nrow(fails))) {
    cat(sprintf("  [%d] %s: %s\n", fails$ID[i], fails$Test[i], fails$Message[i]))
  }
}
cat("\n")
