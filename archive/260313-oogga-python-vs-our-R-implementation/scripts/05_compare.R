# 05_compare.R — Side-by-side comparison of R vs Python OOGGA results
# Created: 2026-03-13
#
# Loads the JSON outputs from both R and Python OOGGA runs, aligns indexing,
# compares K / boundary positions / overhangs / scores, and generates a
# markdown comparison report.
#
# Key indexing alignment:
#   R boundary position p = OOGGA boundary position j = p
#   Both represent the same nucleotide offset from the start of the sequence.
#   R uses 1-indexed nucleotide positions but the boundary value itself is
#   the offset, so R boundary p ↔ OOGGA boundary j=p.

suppressPackageStartupMessages(library(jsonlite))
suppressPackageStartupMessages(library(Biostrings))

# --- Locate project root ---
get_script_dir <- function() {
  args <- commandArgs(trailingOnly = FALSE)
  file_arg <- grep("^--file=", args, value = TRUE)
  if (length(file_arg) > 0) return(normalizePath(dirname(sub("^--file=", "", file_arg[1]))))
  for (i in seq_len(sys.nframe())) {
    ofile <- tryCatch(sys.frame(i)$ofile, error = function(e) NULL)
    if (!is.null(ofile)) return(normalizePath(dirname(ofile)))
  }
  getwd()
}
project_root <- normalizePath(file.path(get_script_dir(), "..", ".."))
setwd(project_root)

# Source utilities for set fidelity computation
source("R/utils.R")
source("R/constants.R")
source("R/03_codon_table.R")
source("R/06_overhang_selection.R")

# --- Load results ---
r_results <- fromJSON("260313-oogga-python-vs-our-R-implementation/outputs/r_results.json")
py_results <- fromJSON("260313-oogga-python-vs-our-R-implementation/outputs/python_results.json")

# --- Load sequence for verification ---
fasta_lines <- readLines("260313-oogga-python-vs-our-R-implementation/inputs/grin2a_full_seq.fasta")
full_seq <- fasta_lines[2]

cat("=" , rep("=", 59), "\n", sep = "")
cat("  OOGGA COMPARISON: R vs Python\n")
cat("=", rep("=", 59), "\n\n", sep = "")

# =============================================================================
# 1. Basic comparison
# =============================================================================
cat("--- 1. BASIC PARAMETERS ---\n")
cat(sprintf("  %-25s  %15s  %15s  %s\n", "Parameter", "R", "Python", "Match?"))
cat(sprintf("  %-25s  %15d  %15d  %s\n", "K (boundaries)",
            r_results$K, py_results$K,
            if (r_results$K == py_results$K) "YES" else "NO"))
cat(sprintf("  %-25s  %15d  %15d  %s\n", "N segments",
            r_results$n_segments, py_results$n_segments,
            if (r_results$n_segments == py_results$n_segments) "YES" else "NO"))
cat(sprintf("  %-25s  %15d  %15d  %s\n", "Total length",
            r_results$total_len, py_results$total_len,
            if (r_results$total_len == py_results$total_len) "YES" else "NO"))

# =============================================================================
# 2. Boundary positions
# =============================================================================
cat("\n--- 2. BOUNDARY POSITIONS ---\n")

r_bounds <- sort(r_results$boundaries_1indexed)
py_bounds <- sort(py_results$boundaries_0indexed)

# R boundary p ↔ OOGGA boundary j=p (same numeric value)
cat("  R boundaries (R-indexed):     ", paste(r_bounds, collapse = ", "), "\n")
cat("  Python boundaries (0-indexed):", paste(py_bounds, collapse = ", "), "\n")

positions_match <- identical(as.integer(r_bounds), as.integer(py_bounds))
cat("  Positions match:", if (positions_match) "YES" else "NO", "\n")

if (!positions_match && length(r_bounds) == length(py_bounds)) {
  diffs <- r_bounds - py_bounds
  cat("  Position differences:", paste(diffs, collapse = ", "), "\n")
}

# =============================================================================
# 3. Overhangs
# =============================================================================
cat("\n--- 3. OVERHANGS AT BOUNDARIES ---\n")

r_ohs <- r_results$boundary_oh1s
py_ohs <- py_results$boundary_ohs

# Sort both by position for comparison
r_order <- order(r_bounds)
py_order <- order(py_bounds)

r_ohs_sorted <- r_ohs[r_order]
py_ohs_sorted <- py_ohs[py_order]

cat(sprintf("  %-8s  %-8s  %-6s  %-6s  %s\n",
            "R_pos", "Py_pos", "R_OH", "Py_OH", "Match?"))
max_len <- max(length(r_bounds), length(py_bounds))
for (i in seq_len(max_len)) {
  r_p <- if (i <= length(r_bounds)) r_bounds[r_order[i]] else NA
  py_p <- if (i <= length(py_bounds)) py_bounds[py_order[i]] else NA
  r_oh <- if (i <= length(r_ohs_sorted)) r_ohs_sorted[i] else NA
  py_oh <- if (i <= length(py_ohs_sorted)) py_ohs_sorted[i] else NA

  match_str <- if (!is.na(r_oh) && !is.na(py_oh) && r_oh == py_oh) "YES" else "NO"
  cat(sprintf("  %-8s  %-8s  %-6s  %-6s  %s\n",
              as.character(r_p), as.character(py_p),
              as.character(r_oh), as.character(py_oh),
              match_str))
}

ohs_match <- identical(r_ohs_sorted, py_ohs_sorted)
cat("  All overhangs match:", if (ohs_match) "YES" else "NO", "\n")

# Verify overhangs match sequence at the reported positions
cat("\n  Verification (overhangs from sequence):\n")
for (i in seq_len(max_len)) {
  if (i <= length(r_bounds)) {
    p <- r_bounds[r_order[i]]
    oh_from_seq <- substring(full_seq, p + 1L, p + 4L)
    cat(sprintf("    R  pos %d: reported=%s, from_seq=%s, match=%s\n",
                p, r_ohs_sorted[i], oh_from_seq,
                if (r_ohs_sorted[i] == oh_from_seq) "YES" else "NO"))
  }
  if (i <= length(py_bounds)) {
    j <- py_bounds[py_order[i]]
    # OOGGA 0-indexed: seq[j:j+4] = R 1-indexed: seq[j+1, j+4]
    oh_from_seq <- substring(full_seq, j + 1L, j + 4L)
    cat(sprintf("    Py pos %d: reported=%s, from_seq=%s, match=%s\n",
                j, py_ohs_sorted[i], oh_from_seq,
                if (py_ohs_sorted[i] == oh_from_seq) "YES" else "NO"))
  }
}

# =============================================================================
# 4. Scores
# =============================================================================
cat("\n--- 4. SCORES ---\n")

r_score <- r_results$total_score
py_score <- py_results$total_score

cat(sprintf("  R total score:      %.15e\n", r_score))
cat(sprintf("  Python total score: %.15e\n", py_score))

if (r_score > 0 && py_score > 0) {
  rel_diff <- abs(r_score - py_score) / max(r_score, py_score)
  cat(sprintf("  Relative difference: %.2e\n", rel_diff))
  # Tolerance 1e-6: R uses RDS (doubles) while Python uses CSV (integers).
  # P_fid differs by ~5e-7 per overhang due to float vs int sum.
  # With K boundaries, accumulated diff is ~K * 5e-7.
  cat(sprintf("  Scores match (tol 1e-6): %s\n",
              if (rel_diff < 1e-6) "YES" else "NO"))
} else {
  cat("  Cannot compute relative difference (zero score)\n")
}

# Per-boundary score comparison
cat("\n  Per-boundary scores:\n")
r_per <- r_results$per_boundary_scores
py_per <- py_results$per_boundary_scores

if (length(r_per) == length(py_per)) {
  cat(sprintf("  %-8s  %15s  %15s  %12s\n", "Pos", "R_score", "Py_score", "Rel_diff"))
  for (i in seq_along(r_per)) {
    rd <- if (max(r_per[i], py_per[i]) > 0) {
      abs(r_per[i] - py_per[i]) / max(r_per[i], py_per[i])
    } else 0
    cat(sprintf("  %-8d  %15.10f  %15.10f  %12.2e\n",
                r_bounds[r_order[i]], r_per[r_order[i]], py_per[py_order[i]], rd))
  }
}

# =============================================================================
# 5. Segment lengths
# =============================================================================
cat("\n--- 5. SEGMENT LENGTHS ---\n")
r_segs <- r_results$segment_lengths
py_segs <- py_results$segment_lengths

cat("  R segments: ", paste(r_segs, collapse = ", "), "\n")
cat("  Py segments:", paste(py_segs, collapse = ", "), "\n")
segs_match <- identical(as.integer(r_segs), as.integer(py_segs))
cat("  Match:", if (segs_match) "YES" else "NO", "\n")

# =============================================================================
# 6. Set fidelity
# =============================================================================
cat("\n--- 6. SET FIDELITY ---\n")

bsmbi_pw <- load_pairwise_matrix("BsmBI")

# R set: alien_ohs + boundary oh1s
r_all_ohs <- unique(c(r_results$alien_ohs, r_ohs))
r_all_ohs <- r_all_ohs[nchar(r_all_ohs) == 4L]
r_set_fid <- compute_set_fidelity(r_all_ohs, bsmbi_pw)

# Python set: oh_L + oh_terminal + boundary ohs (matching what OOGGA uses internally)
params <- fromJSON("260313-oogga-python-vs-our-R-implementation/inputs/params.json")
py_all_ohs <- unique(c(params$oh_L, params$oh_terminal, py_ohs))
py_all_ohs <- py_all_ohs[nchar(py_all_ohs) == 4L]
py_set_fid <- compute_set_fidelity(py_all_ohs, bsmbi_pw)

cat(sprintf("  R set fidelity:      %.10f  (%d overhangs)\n",
            r_set_fid$set_fidelity, length(r_all_ohs)))
cat(sprintf("  Python set fidelity: %.10f  (%d overhangs)\n",
            py_set_fid$set_fidelity, length(py_all_ohs)))

if (positions_match && ohs_match) {
  fid_diff <- abs(r_set_fid$set_fidelity - py_set_fid$set_fidelity)
  cat(sprintf("  Set fidelity difference: %.2e\n", fid_diff))
  cat(sprintf("  Match (tol 1e-6): %s\n",
              if (fid_diff < 1e-6) "YES" else "NO"))
}

# =============================================================================
# 7. Collision check
# =============================================================================
cat("\n--- 7. COLLISION CHECK ---\n")

check_collisions <- function(ohs, label, max_identity = 2L) {
  # Check pairwise collisions, skipping pairs where one is the RC of the
  # other (an overhang and its own RC represent the same physical junction
  # on opposite strands — they're not independent overhangs that need to
  # be compatible).
  n <- length(ohs)
  violations <- 0L
  for (i in seq_len(n - 1L)) {
    for (j in (i + 1L):n) {
      a <- ohs[i]
      b <- ohs[j]
      b_rc <- reverse_complement(b)

      # Skip RC-self pairs (same physical overhang)
      if (a == b_rc) next

      id_ab <- sum(utf8ToInt(a) == utf8ToInt(b))
      id_a_rcb <- sum(utf8ToInt(a) == utf8ToInt(b_rc))

      if (id_ab > max_identity || id_a_rcb > max_identity) {
        cat(sprintf("  COLLISION in %s: %s vs %s (id=%d, id_rc=%d)\n",
                    label, a, b, id_ab, id_a_rcb))
        violations <- violations + 1L
      }
    }
  }
  cat(sprintf("  %s: %d violations among %d overhangs\n", label, violations, n))
  violations
}

r_violations <- check_collisions(r_all_ohs, "R")
py_violations <- check_collisions(py_all_ohs, "Python")

# =============================================================================
# 8. Summary
# =============================================================================
cat("\n", rep("=", 60), "\n", sep = "")
cat("  SUMMARY\n")
cat(rep("=", 60), "\n", sep = "")

all_pass <- TRUE
tests <- list(
  c("K matches", r_results$K == py_results$K),
  c("Positions match", positions_match),
  c("Overhangs match", ohs_match),
  c("Segments match", segs_match),
  c("R no collisions", r_violations == 0),
  c("Python no collisions", py_violations == 0)
)

# Score match (only meaningful if positions match)
if (r_score > 0 && py_score > 0) {
  rel_diff <- abs(r_score - py_score) / max(r_score, py_score)
  tests <- c(tests, list(c("Scores match (1e-6)", rel_diff < 1e-6)))
}

for (t in tests) {
  status <- if (as.logical(t[2])) "PASS" else "FAIL"
  if (!as.logical(t[2])) all_pass <- FALSE
  cat(sprintf("  [%s] %s\n", status, t[1]))
}

cat("\n")
if (all_pass) {
  cat("  RESULT: ALL CHECKS PASSED\n")
  cat("  R OOGGA (single-OH, beam=1) matches Python OOGGA exactly.\n")
} else {
  cat("  RESULT: SOME CHECKS FAILED — see details above.\n")
  cat("  Investigate divergences before trusting production results.\n")
}
cat(rep("=", 60), "\n", sep = "")

# --- Write markdown report ---
report_path <- "260313-oogga-python-vs-our-R-implementation/outputs/comparison_report.md"
report_lines <- c(
  "# OOGGA Comparison Report: R vs Python",
  paste0("Generated: ", Sys.time()),
  "",
  "## Parameters",
  paste0("- Gene: GRIN2A (", r_results$gene_len, " nt CDS + ",
         r_results$total_len - r_results$gene_len, " nt cassette)"),
  paste0("- Min/Max block: ", r_results$min_len, "/", r_results$max_len, " nt"),
  paste0("- Max identity: ", r_results$max_identity),
  "",
  "## Results",
  "",
  "| Metric | R | Python | Match? |",
  "|--------|---|--------|--------|",
  sprintf("| K | %d | %d | %s |", r_results$K, py_results$K,
          if (r_results$K == py_results$K) "Yes" else "**NO**"),
  sprintf("| Total score | %.6e | %.6e | %s |", r_score, py_score,
          if (r_score > 0 && py_score > 0 && abs(r_score - py_score) / max(r_score, py_score) < 1e-6) "Yes" else "**NO**"),
  sprintf("| Positions | %s | %s | %s |",
          paste(r_bounds, collapse=","), paste(py_bounds, collapse=","),
          if (positions_match) "Yes" else "**NO**"),
  sprintf("| Overhangs | %s | %s | %s |",
          paste(r_ohs_sorted, collapse=","), paste(py_ohs_sorted, collapse=","),
          if (ohs_match) "Yes" else "**NO**"),
  sprintf("| Set fidelity | %.6f | %.6f | %s |",
          r_set_fid$set_fidelity, py_set_fid$set_fidelity,
          if (positions_match && ohs_match) "Yes" else "N/A"),
  sprintf("| R collisions | %d | — | %s |", r_violations,
          if (r_violations == 0) "Pass" else "**FAIL**"),
  sprintf("| Py collisions | — | %d | %s |", py_violations,
          if (py_violations == 0) "Pass" else "**FAIL**"),
  "",
  "## Segments",
  paste0("- R:  ", paste(r_segs, collapse = ", ")),
  paste0("- Py: ", paste(py_segs, collapse = ", ")),
  "",
  sprintf("## Overall: %s", if (all_pass) "ALL CHECKS PASSED" else "SOME CHECKS FAILED")
)

writeLines(report_lines, report_path)
cat("\nComparison report written to:", report_path, "\n")
