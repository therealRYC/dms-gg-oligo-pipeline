# Created: 2026-03-02
# Last updated: 2026-03-02 — Initial implementation

# =============================================================================
# Compare individual overhang fidelity across three experimental conditions
# =============================================================================
#
# For all 256 4-nt overhangs, compute P_fid and P_eff under three datasets:
#   1. T4 ligase, 25°C/18h (Potapov et al. 2018)
#   2. BsaI cycling, 37°C/1h (Pryor et al. 2020)
#   3. BsmBI cycling, 37°C/1h (Pryor et al. 2020)
#
# Analyses:
#   - Spearman rank correlations between all dataset pairs
#   - Top-25 overlap by individual P_fid
#   - Palindrome fidelity comparison
#   - P_fid / P_eff distribution histograms
#   - Scatter: T4 vs BsmBI fidelity
#   - Scatter: BsaI vs BsmBI fidelity
#
# Usage: Rscript compare_fidelity.R
# =============================================================================

library(data.table)
library(ggplot2)

# ---------------------------------------------------------------------------
# Paths
# ---------------------------------------------------------------------------
SCRIPT_DIR <- tryCatch(
  {
    args <- commandArgs(trailingOnly = FALSE)
    file_arg <- args[grep("^--file=", args)]
    dirname(normalizePath(sub("^--file=", "", file_arg)))
  },
  error = function(e) "."
)

# Simpler fallback: if SCRIPT_DIR detection fails, use the known path
if (length(SCRIPT_DIR) == 0 || is.na(SCRIPT_DIR)) {
  SCRIPT_DIR <- "."
}

DATA_DIR <- file.path(SCRIPT_DIR, "data")
OUTPUT_DIR <- file.path(SCRIPT_DIR, "output")
dir.create(OUTPUT_DIR, showWarnings = FALSE, recursive = TRUE)

# ---------------------------------------------------------------------------
# Helper functions
# ---------------------------------------------------------------------------

#' Compute reverse complement of a DNA sequence.
#'
#' @param seq Character string of DNA bases (A, C, G, T).
#' @return Reverse complement as a character string.
reverse_complement <- function(seq) {
  comp <- chartr("ACGT", "TGCA", seq)
  paste0(rev(strsplit(comp, "")[[1]]), collapse = "")
}

# Vectorized version for efficiency
rc_vec <- function(seqs) {
  vapply(seqs, reverse_complement, character(1), USE.NAMES = FALSE)
}

#' Load a 256x256 ligation fidelity matrix from CSV.
#'
#' @param csv_path Path to CSV file with overhang row/column labels.
#' @return Named matrix (256x256) with overhang names on rows and columns.
load_matrix <- function(csv_path) {
  df <- fread(csv_path, header = TRUE)
  # First column is the row overhang label
  row_names <- df[[1]]
  mat <- as.matrix(df[, -1, with = FALSE])
  rownames(mat) <- row_names
  mat
}

#' Compute P_fid and P_eff for all 256 overhangs from a fidelity matrix.
#'
#' P_fid(X) = M[X, RC(X)] / sum(M[X, *]) — fraction of correct ligation.
#' P_eff(X) = M[X, RC(X)] / max_Y(M[Y, RC(Y)]) — efficiency relative to best.
#'
#' @param mat Named 256x256 matrix with overhang row/column labels.
#' @return data.table with columns: overhang, rc, correct_count, row_sum,
#'   p_fid, p_eff, is_palindrome, is_homopolymer.
compute_metrics <- function(mat) {
  overhangs <- rownames(mat)
  rcs <- rc_vec(overhangs)

  # Correct ligation count: M[X, RC(X)]
  correct <- vapply(seq_along(overhangs), function(i) {
    mat[overhangs[i], rcs[i]]
  }, numeric(1))

  # Row sums for normalization
  row_sums <- rowSums(mat)

  # Fidelity: fraction of correct ligations
  p_fid <- ifelse(row_sums > 0, correct / row_sums, 0)

  # Efficiency: relative to the best overhang
  # Note: can't use ifelse() here — scalar condition + vector 'yes' returns
  # only the first element. Use if/else instead.
  max_correct <- max(correct)
  p_eff <- if (max_correct > 0) correct / max_correct else rep(0, length(correct))

  # Flag palindromes (X == RC(X)) — there are exactly 16 for 4-nt

  is_palindrome <- overhangs == rcs

  # Flag homopolymers (AAAA, CCCC, GGGG, TTTT)
  is_homopolymer <- overhangs %in% c("AAAA", "CCCC", "GGGG", "TTTT")

  data.table(
    overhang       = overhangs,
    rc             = rcs,
    correct_count  = correct,
    row_sum        = row_sums,
    p_fid          = p_fid,
    p_eff          = p_eff,
    is_palindrome  = is_palindrome,
    is_homopolymer = is_homopolymer
  )
}


# ---------------------------------------------------------------------------
# Load data and compute metrics
# ---------------------------------------------------------------------------
cat("Loading matrices...\n")

datasets <- list(
  t4_25c_18h     = load_matrix(file.path(DATA_DIR, "t4_25c_18h_matrix.csv")),
  bsai_cycling   = load_matrix(file.path(DATA_DIR, "bsai_cycling_matrix.csv")),
  bsmbi_cycling  = load_matrix(file.path(DATA_DIR, "bsmbi_cycling_matrix.csv"))
)

cat("Computing fidelity metrics...\n")

metrics <- lapply(datasets, compute_metrics)

# Merge into one wide table for comparison
# Each dataset contributes p_fid and p_eff columns
merged <- Reduce(function(a, b) {
  merge(a, b,
    by = c("overhang", "rc", "is_palindrome", "is_homopolymer"),
    suffixes = c("", "")
  )
}, list(
  metrics$t4_25c_18h[, .(overhang, rc, is_palindrome, is_homopolymer,
    p_fid_t4 = p_fid, p_eff_t4 = p_eff
  )],
  metrics$bsai_cycling[, .(overhang, rc, is_palindrome, is_homopolymer,
    p_fid_bsai = p_fid, p_eff_bsai = p_eff
  )],
  metrics$bsmbi_cycling[, .(overhang, rc, is_palindrome, is_homopolymer,
    p_fid_bsmbi = p_fid, p_eff_bsmbi = p_eff
  )]
))

# Save full comparison table
fwrite(merged, file.path(OUTPUT_DIR, "individual_fidelity_comparison.csv"))
cat("Saved individual_fidelity_comparison.csv\n")


# ===========================================================================
# Analysis 1: Spearman rank correlations
# ===========================================================================
cat("\n--- Analysis 1: Spearman rank correlations ---\n")

pairs <- list(
  c("t4_25c_18h", "bsai_cycling"),
  c("t4_25c_18h", "bsmbi_cycling"),
  c("bsai_cycling", "bsmbi_cycling")
)

# Build correlation results table
cor_results <- rbindlist(lapply(pairs, function(p) {
  x <- metrics[[p[1]]]$p_fid
  y <- metrics[[p[2]]]$p_fid
  ct <- cor.test(x, y, method = "spearman", exact = FALSE)
  data.table(
    dataset_1 = p[1],
    dataset_2 = p[2],
    spearman_rho = round(ct$estimate, 4),
    p_value = ct$p.value,
    n = length(x)
  )
}))

cat("\nSpearman correlations (P_fid):\n")
print(cor_results)
fwrite(cor_results, file.path(OUTPUT_DIR, "spearman_correlations.csv"))


# ===========================================================================
# Analysis 2: Top-25 overlap by individual P_fid
# ===========================================================================
cat("\n--- Analysis 2: Top-25 overlap ---\n")

top25 <- lapply(metrics, function(m) {
  # Exclude palindromes and homopolymers from top-25 ranking
  m_filtered <- m[is_palindrome == FALSE & is_homopolymer == FALSE]
  head(m_filtered[order(-p_fid)], 25)$overhang
})

# Pairwise overlaps
for (p in pairs) {
  overlap <- length(intersect(top25[[p[1]]], top25[[p[2]]]))
  cat(sprintf("  %s ∩ %s: %d/25 shared\n", p[1], p[2], overlap))
}

# Three-way overlap
three_way <- Reduce(intersect, top25)
cat(sprintf("  Three-way overlap: %d overhangs\n", length(three_way)))
if (length(three_way) > 0) cat(sprintf("    %s\n", paste(three_way, collapse = ", ")))

# Save top-25 table
top25_dt <- data.table(
  rank = 1:25,
  t4_25c_18h = top25$t4_25c_18h,
  bsai_cycling = top25$bsai_cycling,
  bsmbi_cycling = top25$bsmbi_cycling
)
fwrite(top25_dt, file.path(OUTPUT_DIR, "top25_overhangs.csv"))


# ===========================================================================
# Analysis 3: Palindrome fidelity comparison
# ===========================================================================
cat("\n--- Analysis 3: Palindrome fidelity ---\n")

palindromes <- merged[
  is_palindrome == TRUE,
  .(overhang, p_fid_t4, p_fid_bsai, p_fid_bsmbi)
][order(-p_fid_t4)]

cat("Palindrome P_fid (sorted by T4):\n")
print(palindromes)
fwrite(palindromes, file.path(OUTPUT_DIR, "palindrome_fidelity.csv"))

# How many palindromes would pass a 0.95 threshold under each condition?
cat(sprintf(
  "\nPalindromes above 0.95:  T4=%d, BsaI=%d, BsmBI=%d\n",
  sum(palindromes$p_fid_t4 >= 0.95),
  sum(palindromes$p_fid_bsai >= 0.95),
  sum(palindromes$p_fid_bsmbi >= 0.95)
))


# ===========================================================================
# Analysis 4: P_fid distribution histograms
# ===========================================================================
cat("\n--- Analysis 4: Distribution histograms ---\n")

# Reshape for faceted plotting
long_fid <- rbindlist(list(
  data.table(
    dataset = "T4 25°C/18h", p_fid = metrics$t4_25c_18h$p_fid,
    p_eff = metrics$t4_25c_18h$p_eff
  ),
  data.table(
    dataset = "BsaI cycling", p_fid = metrics$bsai_cycling$p_fid,
    p_eff = metrics$bsai_cycling$p_eff
  ),
  data.table(
    dataset = "BsmBI cycling", p_fid = metrics$bsmbi_cycling$p_fid,
    p_eff = metrics$bsmbi_cycling$p_eff
  )
))

# P_fid histogram
p1 <- ggplot(long_fid, aes(x = p_fid, fill = dataset)) +
  geom_histogram(bins = 50, alpha = 0.7, position = "identity") +
  facet_wrap(~dataset, ncol = 1) +
  geom_vline(xintercept = 0.95, linetype = "dashed", color = "red") +
  labs(
    title = "Individual Overhang Fidelity (P_fid) Distribution",
    subtitle = "Red dashed line = 0.95 threshold",
    x = "P_fid",
    y = "Count"
  ) +
  theme_minimal() +
  theme(legend.position = "none")

ggsave(file.path(OUTPUT_DIR, "pfid_histograms.pdf"), p1,
  width = 8, height = 8
)

# P_eff histogram
p2 <- ggplot(long_fid, aes(x = p_eff, fill = dataset)) +
  geom_histogram(bins = 50, alpha = 0.7, position = "identity") +
  facet_wrap(~dataset, ncol = 1) +
  labs(
    title = "Individual Overhang Efficiency (P_eff) Distribution",
    x = "P_eff",
    y = "Count"
  ) +
  theme_minimal() +
  theme(legend.position = "none")

ggsave(file.path(OUTPUT_DIR, "peff_histograms.pdf"), p2,
  width = 8, height = 8
)

cat("Saved pfid_histograms.pdf and peff_histograms.pdf\n")

# Count overhangs above 0.95 threshold per dataset
cat("\nOverhangs with P_fid >= 0.95 (all):\n")
for (nm in names(metrics)) {
  n_above <- sum(metrics[[nm]]$p_fid >= 0.95)
  n_nonpal <- sum(metrics[[nm]][is_palindrome == FALSE]$p_fid >= 0.95)
  cat(sprintf("  %s: %d total, %d non-palindrome\n", nm, n_above, n_nonpal))
}


# ===========================================================================
# Analysis 5: Scatter — T4 vs BsmBI fidelity
# ===========================================================================
cat("\n--- Analysis 5: T4 vs BsmBI scatter ---\n")

# Potapov Table 1 Set 3 overhangs (for annotation)
hf_set3 <- c(
  "CCTC", "CTAA", "GACA", "GCAC", "AATC", "GTAA", "TGAA", "ATTA",
  "CCAG", "AGGA", "ACAA", "TAGA", "CGGA", "CATA", "CAGC", "AACG",
  "AAGT", "CTCC", "AGAT", "ACCA", "AGTG", "GGTA", "GCGA", "AAAA",
  "ATGA"
)

merged[, point_type := fifelse(
  is_palindrome, "palindrome",
  fifelse(overhang %in% hf_set3, "HF Set 3", "other")
)]

p3 <- ggplot(merged, aes(x = p_fid_t4, y = p_fid_bsmbi)) +
  geom_abline(slope = 1, intercept = 0, linetype = "dashed", color = "gray50") +
  geom_point(
    data = merged[point_type == "other"],
    aes(color = point_type), alpha = 0.3, size = 1.5
  ) +
  geom_point(
    data = merged[point_type == "HF Set 3"],
    aes(color = point_type), alpha = 0.8, size = 2.5
  ) +
  geom_point(
    data = merged[point_type == "palindrome"],
    aes(color = point_type), alpha = 0.8, size = 2.5, shape = 17
  ) +
  scale_color_manual(values = c(
    "other" = "gray60",
    "HF Set 3" = "steelblue",
    "palindrome" = "red"
  )) +
  labs(
    title = "Overhang Fidelity: T4 25°C/18h vs BsmBI Cycling",
    subtitle = "Blue = Potapov HF Set 3; Red triangles = palindromes",
    x = "P_fid (T4 25°C/18h)",
    y = "P_fid (BsmBI cycling)",
    color = "Type"
  ) +
  coord_fixed() +
  theme_minimal()

ggsave(file.path(OUTPUT_DIR, "scatter_t4_vs_bsmbi.pdf"), p3,
  width = 8, height = 7
)
cat("Saved scatter_t4_vs_bsmbi.pdf\n")


# ===========================================================================
# Analysis 6: Scatter — BsaI vs BsmBI fidelity
# ===========================================================================
cat("\n--- Analysis 6: BsaI vs BsmBI scatter ---\n")

p4 <- ggplot(merged, aes(x = p_fid_bsai, y = p_fid_bsmbi)) +
  geom_abline(slope = 1, intercept = 0, linetype = "dashed", color = "gray50") +
  geom_point(
    data = merged[point_type == "other"],
    aes(color = point_type), alpha = 0.3, size = 1.5
  ) +
  geom_point(
    data = merged[point_type == "HF Set 3"],
    aes(color = point_type), alpha = 0.8, size = 2.5
  ) +
  geom_point(
    data = merged[point_type == "palindrome"],
    aes(color = point_type), alpha = 0.8, size = 2.5, shape = 17
  ) +
  scale_color_manual(values = c(
    "other" = "gray60",
    "HF Set 3" = "steelblue",
    "palindrome" = "red"
  )) +
  labs(
    title = "Overhang Fidelity: BsaI vs BsmBI Cycling",
    subtitle = "Pryor 2020 claim: enzyme choice barely matters",
    x = "P_fid (BsaI cycling)",
    y = "P_fid (BsmBI cycling)",
    color = "Type"
  ) +
  coord_fixed() +
  theme_minimal()

# Compute correlation for annotation
bsai_bsmbi_cor <- cor(merged$p_fid_bsai, merged$p_fid_bsmbi,
  method = "spearman"
)
p4 <- p4 + annotate("text",
  x = 0.1, y = 0.95,
  label = sprintf("Spearman rho = %.3f", bsai_bsmbi_cor),
  hjust = 0, size = 4
)

ggsave(file.path(OUTPUT_DIR, "scatter_bsai_vs_bsmbi.pdf"), p4,
  width = 8, height = 7
)
cat("Saved scatter_bsai_vs_bsmbi.pdf\n")


# ===========================================================================
# Summary statistics
# ===========================================================================
cat("\n--- Summary ---\n")
for (nm in names(metrics)) {
  m <- metrics[[nm]]
  cat(sprintf("\n%s:\n", nm))
  cat(sprintf(
    "  P_fid: mean=%.3f, median=%.3f, min=%.3f, max=%.3f\n",
    mean(m$p_fid), median(m$p_fid), min(m$p_fid), max(m$p_fid)
  ))
  cat(sprintf(
    "  P_eff: mean=%.3f, median=%.3f, min=%.3f, max=%.3f\n",
    mean(m$p_eff), median(m$p_eff), min(m$p_eff), max(m$p_eff)
  ))
}

cat("\nDone. All outputs saved to:", OUTPUT_DIR, "\n")
