# Created: 2025-02-01
# Last updated: 2026-03-04 — Replace synthetic pairwise matrices with real Pryor 2020 xlsx data
#
# Script to generate bundled data files
# Run once: Rscript data-raw/generate_data.R
#
# Pairwise ligation matrices from Pryor et al. 2020 supplement (Tables S1-S4).
# Raw xlsx files in data/pryor2020_overhang_fidelity/
#
# Matrix convention after RC remap:
#   M[X,Y] = ligation frequency of overhang X with overhang Y
#   Diagonal M[X,X] = correct Watson-Crick ligation (X with RC(X))
#   Off-diagonal M[X,Y] = misligation
#
# Individual fidelity derived from matrix:
#   fidelity(X) = M[X,X] / sum(M[X,])

library(readxl)

# --- Helper: reverse complement (base R, no Biostrings needed) ---
rc_base <- function(seq) {
  comp <- chartr("ACGT", "TGCA", seq)
  paste0(rev(strsplit(comp, "")[[1]]), collapse = "")
}

# --- Helper: build pairwise matrix from Pryor xlsx ---
# The raw Pryor matrices have M[X,Y] where Y is the complement strand overhang.
# We apply an RC column remap so that M_new[X,X] = correct ligation (diagonal).
build_pairwise_from_xlsx <- function(xlsx_path) {
  d <- read_xlsx(xlsx_path)
  ohs_raw <- d$Overhang
  mat_raw <- as.matrix(d[, -1])
  rownames(mat_raw) <- ohs_raw
  storage.mode(mat_raw) <- "double"

  # Sort to standard alphabetical order (AAAA, AAAC, ...)
  std_ohs <- sort(ohs_raw)
  mat_sorted <- mat_raw[std_ohs, std_ohs]

  # RC column remap: M_new[X,Y] = M_raw[X, RC(Y)]
  rcs <- vapply(std_ohs, rc_base, character(1))
  names(rcs) <- std_ohs
  mat_remapped <- mat_sorted[, rcs]
  colnames(mat_remapped) <- std_ohs

  mat_remapped
}

# --- Helper: derive 1D fidelity from pairwise matrix ---
derive_fidelity <- function(pairwise_matrix) {
  ohs <- rownames(pairwise_matrix)
  fid <- vapply(ohs, function(oh) {
    pairwise_matrix[oh, oh] / sum(pairwise_matrix[oh, ])
  }, numeric(1))
  data.frame(overhang = ohs, fidelity = unname(fid), stringsAsFactors = FALSE)
}

# --- Create output directory ---
dir.create("data/neb_overhang_fidelity", showWarnings = FALSE, recursive = TRUE)

# =============================================================================
# Human Codon Usage (CoCoPUTs)
# =============================================================================
# Source: CoCoPUTs (Alexaki et al. 2019, J Mol Biol 431:2434-2441)
# https://dnahive.fda.gov/dna.cgi?cmd=codon_usage&id=537&mode=cocoputs
# Homo sapiens, GCF_000001405.39 (GRCh38.p13), 119,196 CDS, 77,461,688 codons
# Downloaded: 2026-02-21
source("R/03_codon_table.R")
codon_usage <- builtin_human_codon_usage()
saveRDS(codon_usage, "data/human_codon_usage.rds")
cat("Saved data/human_codon_usage.rds\n")

# =============================================================================
# Pairwise Ligation Matrices (real data from Pryor et al. 2020)
# =============================================================================
# Source: Pryor et al. 2020 (PLOS ONE, doi:10.1371/journal.pone.0238592)
# Supplement Tables S1-S4: 256x256 pairwise ligation counts for 4-nt overhangs
# Downloaded from: https://journals.plos.org/plosone/article?id=10.1371/journal.pone.0238592

cat("\n--- Building pairwise matrices from Pryor 2020 supplement ---\n")

# BsaI-HFv2 (Table S1)
bsai_matrix <- build_pairwise_from_xlsx(
  "data/pryor2020_overhang_fidelity/pone.0238592.s001.xlsx"
)
saveRDS(bsai_matrix, "data/neb_overhang_fidelity/bsai_pairwise.rds")
cat("Saved bsai_pairwise.rds (BsaI-HFv2, Table S1)\n")

# BsmBI-v2 (Table S2)
bsmbi_matrix <- build_pairwise_from_xlsx(
  "data/pryor2020_overhang_fidelity/pone.0238592.s002.xlsx"
)
saveRDS(bsmbi_matrix, "data/neb_overhang_fidelity/bsmbi_pairwise.rds")
cat("Saved bsmbi_pairwise.rds (BsmBI-v2, Table S2)\n")

# =============================================================================
# Individual Overhang Fidelity (derived from pairwise matrices)
# =============================================================================
# fidelity(X) = M[X,X] / sum(M[X,])

bsai_overhangs <- derive_fidelity(bsai_matrix)
saveRDS(bsai_overhangs, "data/neb_overhang_fidelity/bsai_overhangs.rds")
cat(sprintf(
  "Saved bsai_overhangs.rds (%d overhangs >= 0.95 fidelity)\n",
  sum(bsai_overhangs$fidelity >= 0.95)
))

bsmbi_overhangs <- derive_fidelity(bsmbi_matrix)
saveRDS(bsmbi_overhangs, "data/neb_overhang_fidelity/bsmbi_overhangs.rds")
cat(sprintf(
  "Saved bsmbi_overhangs.rds (%d overhangs >= 0.95 fidelity)\n",
  sum(bsmbi_overhangs$fidelity >= 0.95)
))

# =============================================================================
# High-Fidelity Overhang Sets (Potapov 2018 Table 1)
# =============================================================================
# Pre-validated sets selected by greedy fidelity ranking.
# Note: The Potapov Table 1 Set 3 (25 overhangs) is hard-coded in constants.R
# and does NOT come from this file. This generates legacy greedy sets only.

generate_hf_set_standalone <- function(oh_data, n_members) {
  sorted <- oh_data[order(oh_data$fidelity, decreasing = TRUE), ]
  selected <- character(0)
  used <- character(0)
  for (i in seq_len(nrow(sorted))) {
    oh <- sorted$overhang[i]
    oh_rc <- rc_base(oh)
    if (!(oh %in% used) && !(oh_rc %in% used)) {
      selected <- c(selected, oh)
      used <- c(used, oh, oh_rc)
      if (length(selected) == n_members) break
    }
  }
  selected
}

# Use BsmBI fidelity for HF set generation (matches assembly enzyme)
hf_20 <- generate_hf_set_standalone(bsmbi_overhangs, 20)
hf_10 <- generate_hf_set_standalone(bsmbi_overhangs, 10)

hf_sets <- list(
  greedy_fidelity_20 = hf_20,
  greedy_fidelity_10 = hf_10
)
saveRDS(hf_sets, "data/neb_overhang_fidelity/high_fidelity_sets.rds")
cat(sprintf("Saved high_fidelity_sets.rds (20-member, 10-member)\n"))

cat("\nAll data files generated.\n")
