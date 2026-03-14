# 03_run_r_single_oh.R — Run R OOGGA in single-OH mode (beam_width=1)
# Created: 2026-03-13
#
# This script configures our R OOGGA DP to behave identically to the Python
# OOGGA for a fair comparison:
#   - Single-OH mode: override oh2 to "" for ALL positions (gene + cassette)
#   - beam_width = 1: single-path DP (no beam search)
#   - Multiplicative scoring: product of individual overhang scores
#   - Alien overhangs: oh_L + oh_terminal + RCs (matching OOGGA's behavior)
#
# The production R code is NOT modified — the single-OH override is done
# here by modifying the precomputed candidate data before calling the DP.
#
# Output: JSON with boundaries (1-indexed), overhangs, scores, K

suppressPackageStartupMessages(library(Biostrings))
suppressPackageStartupMessages(library(jsonlite))

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
cat("Project root:", project_root, "\n")

# Source pipeline modules (read-only — we don't modify production code)
source("R/utils.R")
source("R/constants.R")
source("R/03_codon_table.R")
source("R/06_overhang_selection.R")
source("R/06b_oogga_dp.R")

# --- Load inputs ---
params <- fromJSON("260313-oogga-python-vs-our-R-implementation/inputs/params.json")
fasta_lines <- readLines("260313-oogga-python-vs-our-R-implementation/inputs/grin2a_full_seq.fasta")
full_seq <- fasta_lines[2]  # sequence is on line 2

cat("Full sequence length:", nchar(full_seq), "nt\n")
cat("Gene length:", params$gene_len, "nt\n")
cat("Min/Max block:", params$min_len, "/", params$max_len, "nt\n")
cat("Alien OHs:", paste(params$alien_ohs, collapse = ", "), "\n")

# --- Load overhang data ---
oh_fidelity <- load_overhang_fidelity("BsmBI")
bsmbi_pw <- load_pairwise_matrix("BsmBI")
eff_lookup <- compute_overhang_efficiency(bsmbi_pw)

# --- Precompute boundary candidates ---
# Use precompute_sb_boundary_candidates but then OVERRIDE to single-OH mode.
# This way we get the same position filtering (codon boundaries, blacklist)
# as the production code, but with single-OH scoring.

# First, get the standard two-OH candidates
candidates <- precompute_sb_boundary_candidates(
  full_seq = full_seq,
  gene_len = params$gene_len,
  oh_fidelity = oh_fidelity,
  eff_lookup = eff_lookup,
  blacklist_ohs = character(0),  # No pipeline-specific blacklist
  allowed_gene_positions = NULL,  # All codon positions allowed
  cassette_needs_splitting = TRUE,
  overlap_codons = 4L
)

cat("Standard candidates: ", sum(candidates$valid), "valid positions\n")

# --- OVERRIDE: Single-OH mode ---
# For gene-region positions (p <= gene_len):
#   Original: score = overhang_score(oh1) * overhang_score(oh2), both oh1 and oh2 in collision set
#   Single-OH: score = overhang_score(oh1) only, oh2 = "" (not used)
#
# For cassette-region positions (p > gene_len):
#   Already single-OH in production code (oh2 = ""), no change needed.
#
# OOGGA Python: overhang at position j = seq[j:j+4]
# Our R oh1: at position p (1-indexed), oh1 = seq[p+1 : p+4]
# So R's oh1 at position p corresponds to OOGGA's overhang at j=p (0-indexed: seq[p:p+4])
#
# Wait — let's check the exact mapping:
# OOGGA Python: overhang at j = seq[j:j+4] (0-indexed, 4 chars starting at j)
#   This means the "split" is BEFORE position j, and the overhang is the
#   first 4 nt of the next segment.
#
# Our R: oh1 at position p = substring(full_seq, p+1, p+4) (1-indexed)
#   This is also the first 4 nt past the boundary.
#
# Mapping: R position p ↔ OOGGA position j=p
# (Both refer to the same nucleotide position as the boundary.)

fid_lookup <- oh_fidelity$fidelity
names(fid_lookup) <- oh_fidelity$overhang

total_len <- nchar(full_seq)

for (p in seq_len(total_len)) {
  if (!candidates$valid[p]) next

  if (p <= params$gene_len) {
    # Gene region: override to single-OH
    oh1 <- candidates$oh1_seq[p]
    candidates$oh2_seq[p] <- ""  # Remove oh2 from collision set
    candidates$score[p] <- overhang_score(oh1, fid_lookup, eff_lookup)
  }
  # Cassette region: already single-OH, no change needed
}

# Re-validate: positions where oh1 is in palindromes/homopolymers should
# have already been filtered by precompute_sb_boundary_candidates.
cat("Single-OH candidates:", sum(candidates$valid), "valid positions\n")

# --- Build compatibility matrix ---
compat_matrix <- build_oh_compatibility(max_identity = params$max_identity)

# --- Determine K range ---
# Try K from 1 to max feasible
min_K <- max(1L, ceiling(total_len / params$max_len) - 1L)
max_K <- floor(total_len / params$min_len) - 1L
cat("K search range:", min_K, "to", max_K, "\n")

# --- Run DP for each K ---
best_result <- NULL
best_K <- NULL

for (K in min_K:max_K) {
  cat("  Trying K =", K, "...")

  result <- oogga_sb_dp_solve_k_v2(
    K = K,
    total_len = total_len,
    min_len = params$min_len,
    max_len = params$max_len,
    boundary_scores = candidates$score,
    boundary_valid = candidates$valid,
    oh1_seq = candidates$oh1_seq,
    oh2_seq = candidates$oh2_seq,
    alien_ohs = params$alien_ohs,
    compat_matrix = compat_matrix,
    beam_width = 1L,  # Single-path DP (no beam search)
    max_identity = params$max_identity
  )

  if (!is.null(result)) {
    cat(" score =", format(result$total_score, digits = 10), "\n")
    if (is.null(best_result) || result$total_score > best_result$total_score) {
      best_result <- result
      best_K <- K
    }
  } else {
    cat(" no feasible solution\n")
  }
}

if (is.null(best_result)) {
  stop("No feasible solution found for any K!")
}

cat("\n=== Best result: K =", best_K, "===\n")
cat("Boundaries (1-indexed):", paste(best_result$boundaries, collapse = ", "), "\n")
cat("OH1s:", paste(best_result$boundary_oh1s, collapse = ", "), "\n")
cat("Total score:", format(best_result$total_score, digits = 15), "\n")

# --- Compute per-boundary scores ---
per_boundary_scores <- numeric(length(best_result$boundaries))
for (i in seq_along(best_result$boundaries)) {
  p <- best_result$boundaries[i]
  oh1 <- best_result$boundary_oh1s[i]
  per_boundary_scores[i] <- overhang_score(oh1, fid_lookup, eff_lookup)
}

# --- Compute segment lengths ---
boundaries_sorted <- sort(best_result$boundaries)
starts <- c(1L, boundaries_sorted + 1L)
ends <- c(boundaries_sorted, total_len)
segment_lengths <- ends - starts + 1L

# --- Compute set fidelity ---
all_ohs <- c(params$alien_ohs, best_result$boundary_oh1s)
# Remove empty strings and deduplicate for set fidelity
all_ohs <- unique(all_ohs[nchar(all_ohs) == 4L])
set_fid <- compute_set_fidelity(all_ohs, bsmbi_pw)

cat("Set fidelity:", format(set_fid$set_fidelity, digits = 10), "\n")
cat("Segments:", paste(segment_lengths, collapse = ", "), "\n")

# --- Write JSON output ---
output <- list(
  source = "R_OOGGA_single_OH",
  K = best_K,
  n_segments = best_K + 1L,
  # 1-indexed boundaries (R native)
  boundaries_1indexed = best_result$boundaries,
  # 0-indexed boundaries (for Python comparison)
  boundaries_0indexed = best_result$boundaries,  # See note below
  boundary_oh1s = best_result$boundary_oh1s,
  per_boundary_scores = per_boundary_scores,
  total_score = best_result$total_score,
  segment_lengths = segment_lengths,
  set_fidelity = set_fid$set_fidelity,
  per_oh_fidelity = set_fid$per_overhang,
  alien_ohs = params$alien_ohs,
  beam_width = 1L,
  max_identity = params$max_identity,
  min_len = params$min_len,
  max_len = params$max_len,
  gene_len = params$gene_len,
  total_len = total_len
)

# NOTE on indexing:
# R boundary position p means: boundary is AFTER nucleotide p.
# Segment 1 = seq[1..p], segment 2 = seq[p+1..next_p], etc.
# The overhang oh1 = seq[p+1..p+4] = first 4 nt of the next segment.
#
# OOGGA boundary position j means: overhang = seq[j:j+4] (0-indexed).
# Fragment 1 = seq[0..j+4-1] (inclusive of overhang), fragment 2 = seq[j..next_j+4-1], etc.
#
# Key: R's boundary p = OOGGA's boundary j=p.
# Because: R oh1 at p = substring(full_seq, p+1, p+4) = full_seq[(p+1)..(p+4)] in 1-indexed
# And: OOGGA overhang at j = seq[j:j+4] = seq[j].seq[j+1].seq[j+2].seq[j+3] in 0-indexed
# When j=p: seq[p:p+4] in 0-indexed = seq[(p+1)..(p+4)] in 1-indexed ✓

output_path <- "260313-oogga-python-vs-our-R-implementation/outputs/r_results.json"
writeLines(toJSON(output, auto_unbox = TRUE, pretty = TRUE, digits = 15), output_path)
cat("\nResults written to:", output_path, "\n")
