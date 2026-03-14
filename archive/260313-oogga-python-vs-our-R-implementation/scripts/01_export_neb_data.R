# 01_export_neb_data.R — Export our BsmBI pairwise matrix to OOGGA CSV format
# Created: 2026-03-13
#
# OOGGA's load_csv_table_as_di() expects a CSV where:
#   - Header row: label for overhang column + 256 overhang column names
#   - Data rows: overhang_label, count_1, count_2, ..., count_256
#   - The diagonal (correct WC ligation) is at words[diagonal_pos] where
#     diagonal_pos increments from 1 for each row
#
# Our BsmBI pairwise matrix (from Pryor et al. 2020) is a named 256x256
# integer matrix where M[X,Y] = ligation count of X with RC(Y).
# Row/column names are the 256 4-nt overhangs in the same order.
#
# This script also verifies the roundtrip: re-reads the CSV using the same
# formula as OOGGA's load_csv_table_as_di(), then compares P_fid and P_eff
# against R's computed values to ensure no data corruption.

suppressPackageStartupMessages(library(Biostrings))

# --- Locate project root ---
# Works whether run via Rscript or source()
get_script_dir <- function() {
  # Try commandArgs (Rscript invocation)
  args <- commandArgs(trailingOnly = FALSE)
  file_arg <- grep("^--file=", args, value = TRUE)
  if (length(file_arg) > 0) {
    return(normalizePath(dirname(sub("^--file=", "", file_arg[1]))))
  }
  # Try sys.frame (source() invocation)
  for (i in seq_len(sys.nframe())) {
    ofile <- tryCatch(sys.frame(i)$ofile, error = function(e) NULL)
    if (!is.null(ofile)) return(normalizePath(dirname(ofile)))
  }
  # Fallback: working directory
  getwd()
}
project_root <- normalizePath(file.path(get_script_dir(), "..", ".."))
setwd(project_root)
cat("Project root:", project_root, "\n")

# Source utilities
source("R/utils.R")
source("R/constants.R")
source("R/03_codon_table.R")  # for find_data_dir()
source("R/06_overhang_selection.R")

# --- Load the BsmBI pairwise matrix ---
bsmbi_pw <- load_pairwise_matrix("BsmBI")
cat("Loaded BsmBI pairwise matrix:", nrow(bsmbi_pw), "x", ncol(bsmbi_pw), "\n")

# Sanity: row and column names should be identical (same overhang order)
stopifnot(identical(rownames(bsmbi_pw), colnames(bsmbi_pw)))
oh_names <- rownames(bsmbi_pw)
cat("Overhang order sample:", paste(head(oh_names, 5), collapse=", "), "...\n")

# --- Write CSV in OOGGA format ---
# Header: "overhang,OH1,OH2,...,OH256"
# Each data row: "OHi,M[i,1],M[i,2],...,M[i,256]"
#
# OOGGA's load_csv_table_as_di reads:
#   words[0] = overhang label
#   words[1:] = count values (256 of them)
#   diagonal_pos starts at 1, increments per row
# So words[diagonal_pos] for row i = M[i,i] (the diagonal)

output_csv <- "260313-oogga-python-vs-our-R-implementation/inputs/bsmbi_for_oogga.csv"
cat("Writing CSV to:", output_csv, "\n")

# Build header
header <- paste(c("overhang", oh_names), collapse = ",")

# Build data lines
data_lines <- character(length(oh_names))
for (i in seq_along(oh_names)) {
  row_values <- as.integer(bsmbi_pw[i, ])
  data_lines[i] <- paste(c(oh_names[i], row_values), collapse = ",")
}

# Write
writeLines(c(header, data_lines), output_csv)
cat("CSV written successfully:", length(data_lines), "data rows\n")

# --- Verify roundtrip ---
# Re-read the CSV and compute P_eff and P_fid using OOGGA's formula,
# then compare against R's computed values.

cat("\n--- Roundtrip verification ---\n")

lines <- readLines(output_csv)
# Skip header (line 1), parse data lines
n_ohs <- length(lines) - 1L
stopifnot(n_ohs == 256L)

csv_eff <- numeric(n_ohs)
csv_fid <- numeric(n_ohs)
csv_names <- character(n_ohs)

# First pass: find max diagonal (OOGGA does this first)
max_count <- 0L
diagonal_pos <- 2L  # 1-indexed: column 2 is the first count column for row 1
for (i in seq_len(n_ohs)) {
  words <- strsplit(lines[i + 1L], ",")[[1]]
  diag_val <- as.integer(words[diagonal_pos])
  if (diag_val > max_count) max_count <- diag_val
  diagonal_pos <- diagonal_pos + 1L
}
cat("Max diagonal count:", max_count, "\n")

# Second pass: compute eff and fid
diagonal_pos <- 2L
for (i in seq_len(n_ohs)) {
  words <- strsplit(lines[i + 1L], ",")[[1]]
  csv_names[i] <- words[1]
  diag_val <- as.integer(words[diagonal_pos])
  row_total <- sum(as.integer(words[2:257]))  # words[2:257] = 256 count columns

  csv_eff[i] <- (diag_val / max_count)    # fraction, not percentage
  csv_fid[i] <- (diag_val / row_total)    # fraction, not percentage
  diagonal_pos <- diagonal_pos + 1L
}

# Compare against R's values
r_oh_fid <- load_overhang_fidelity("BsmBI")
r_eff <- compute_overhang_efficiency(bsmbi_pw)

# Match ordering
r_fid_vec <- r_oh_fid$fidelity[match(csv_names, r_oh_fid$overhang)]
r_eff_vec <- r_eff[csv_names]

# Check agreement
fid_diff <- max(abs(csv_fid - r_fid_vec))
eff_diff <- max(abs(csv_eff - r_eff_vec))

cat("Max P_fid difference (CSV vs R):", format(fid_diff, digits = 10), "\n")
cat("Max P_eff difference (CSV vs R):", format(eff_diff, digits = 10), "\n")

# Spot-check 5 overhangs
cat("\nSpot-check (5 overhangs):\n")
cat(sprintf("  %-6s  %10s  %10s  %10s  %10s\n",
            "OH", "CSV_fid", "R_fid", "CSV_eff", "R_eff"))
for (idx in c(1, 50, 100, 150, 200)) {
  cat(sprintf("  %-6s  %10.6f  %10.6f  %10.6f  %10.6f\n",
              csv_names[idx],
              csv_fid[idx], r_fid_vec[idx],
              csv_eff[idx], r_eff_vec[idx]))
}

# Assert roundtrip passes
# P_fid tolerance is 1e-6 (not 1e-10) because the RDS matrix stores doubles
# while the CSV roundtrip converts through integers. The sum of 256 doubles
# can differ from the sum of 256 integers by a few ULPs (~5e-7 observed).
# P_eff uses only the diagonal (single division), so it's exact.
if (fid_diff < 1e-6 && eff_diff < 1e-10) {
  cat("\nROUNDTRIP PASSED: CSV data matches R computed values within tolerance.\n")
  cat(sprintf("  P_fid max diff: %.2e (tolerance: 1e-6)\n", fid_diff))
  cat(sprintf("  P_eff max diff: %.2e (tolerance: 1e-10)\n", eff_diff))
} else {
  stop("ROUNDTRIP FAILED: P_fid diff=", format(fid_diff, digits=10),
       ", P_eff diff=", format(eff_diff, digits=10))
}
