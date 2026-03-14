# 02_prepare_inputs.R — Build domesticated GRIN2A + cassette sequence and params.json
# Created: 2026-03-13
#
# This script:
# 1. Loads the GRIN2A config and gene FASTA
# 2. Domesticates the gene (removes endogenous BsaI/BsmBI/PaqCI sites)
# 3. Builds the full sequence: domesticated CDS + downstream cassette
# 4. Writes the full sequence as a FASTA file
# 5. Writes params.json with aligned parameters for both R and Python runners
#
# The params.json captures everything both scripts need to run identically:
#   - min_len, max_len (segment length constraints)
#   - alien_ohs (fixed overhangs to avoid collisions with)
#   - max_identity (max positional identity threshold)
#   - gene_len (to know where gene region ends and cassette begins)
#   - exclusion_list (non-codon-boundary positions in the gene region)
#   - full_seq_len (for sanity checks)

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

# Source pipeline modules
source("R/utils.R")
source("R/constants.R")
source("R/03_codon_table.R")
source("R/00_config.R")
source("R/01_gene_input.R")
source("R/02_enzyme_site_scan.R")
source("R/06_overhang_selection.R")

# --- Load config and gene ---
cfg <- load_config("configs/grin2a.yaml")
gene <- read_gene(cfg$gene_fasta)
cat("Gene:", gene$gene_name, "—", gene$n_codons, "codons,", nchar(gene$cds), "nt\n")

# --- Domesticate ---
codon_usage <- load_codon_usage(cfg$codon_table_path)
scan_result <- scan_enzyme_sites(gene$cds, cfg$polIII_promoter, codon_usage,
                                  cfg$intergene_elements)

if (nrow(scan_result$domestication) > 0) {
  domesticated_cds <- apply_domestication(gene$cds, scan_result$domestication,
                                           codon_usage)
} else {
  domesticated_cds <- gene$cds
}
cat("Domesticated CDS length:", nchar(domesticated_cds), "nt\n")

# Verify clean
for (enz_name in c("BsaI", "BsmBI", "PaqCI")) {
  remaining <- find_enzyme_sites(domesticated_cds, ENZYMES[[enz_name]]$recog)
  if (nrow(remaining) > 0) {
    stop("Domestication incomplete: ", nrow(remaining), " ", enz_name, " sites remain!")
  }
}
cat("Domestication verified: no BsaI/BsmBI/PaqCI sites in gene.\n")

# --- Build full sequence ---
# full_seq = domesticated CDS + downstream_cassette
# downstream_cassette = intergene_concat + polIII_promoter (from config)
full_seq <- paste0(domesticated_cds, cfg$downstream_cassette)
gene_len <- nchar(domesticated_cds)
total_len <- nchar(full_seq)
cat("Full sequence:", total_len, "nt (gene:", gene_len, "+ cassette:",
    nchar(cfg$downstream_cassette), ")\n")

# --- Write FASTA ---
fasta_path <- "260313-oogga-python-vs-our-R-implementation/inputs/grin2a_full_seq.fasta"
writeLines(c(
  paste0(">GRIN2A_domesticated_plus_cassette length=", total_len,
         " gene_len=", gene_len),
  full_seq
), fasta_path)
cat("Wrote FASTA:", fasta_path, "\n")

# --- Build exclusion list ---
# OOGGA's exclusion_list prevents overhangs at certain positions.
# For gene-region: only codon boundaries (every 3rd position) are valid.
# In OOGGA (0-indexed): position j means overhang = seq[j:j+4].
# In our R (1-indexed): position p means overhang = seq[p+1:p+4].
#
# For OOGGA alignment: a gene-region position j (0-indexed) is a codon
# boundary if j % 3 == 0. Exclusion list = gene-region positions where
# j % 3 != 0.
#
# Cassette-region positions (j >= gene_len) have no codon constraint.

gene_positions <- 0:(gene_len - 1)  # 0-indexed
non_codon_boundary <- gene_positions[gene_positions %% 3 != 0]
exclusion_list <- as.integer(non_codon_boundary)
cat("Exclusion list:", length(exclusion_list), "positions (non-codon-boundary in gene region)\n")

# --- Build alien overhangs ---
# These are fixed overhangs that must not collide with DP-selected boundaries.
# For OOGGA alignment, we include:
#   1. oh_L = first 4 nt of full_seq (leading edge; OOGGA includes start_site
#      in its trace, so seq[0:4] is always checked)
#   2. seq[-4:] = last 4 nt of full_seq (OOGGA always adds this)
#   3. Their reverse complements
#
# We do NOT include oh3/oh4 from our pipeline because OOGGA doesn't know
# about them — this comparison is about matching OOGGA's behavior exactly.

oh_L <- substring(full_seq, 1, 4)
oh_terminal <- substring(full_seq, total_len - 3, total_len)
oh_L_rc <- reverse_complement(oh_L)
oh_terminal_rc <- reverse_complement(oh_terminal)

# Deduplicate
alien_ohs <- unique(c(oh_L, oh_terminal, oh_L_rc, oh_terminal_rc))
cat("Alien overhangs:", paste(alien_ohs, collapse = ", "), "\n")
cat("  oh_L (seq[1:4]):", oh_L, "  RC:", oh_L_rc, "\n")
cat("  oh_terminal (seq[-4:]):", oh_terminal, "  RC:", oh_terminal_rc, "\n")

# --- Write params.json ---
params <- list(
  min_len = as.integer(cfg$min_geneblock_length),
  max_len = as.integer(cfg$max_geneblock_length),
  max_identity = 2L,
  gene_len = as.integer(gene_len),
  full_seq_len = as.integer(total_len),
  alien_ohs = alien_ohs,
  exclusion_list = exclusion_list,
  oh_L = oh_L,
  oh_terminal = oh_terminal,
  gene_name = gene$gene_name,
  # For reference: what's in the cassette

  cassette_len = nchar(cfg$downstream_cassette),
  intergene_len = nchar(cfg$intergene_concat),
  polIII_len = nchar(cfg$polIII_promoter)
)

params_path <- "260313-oogga-python-vs-our-R-implementation/inputs/params.json"
writeLines(toJSON(params, auto_unbox = TRUE, pretty = TRUE), params_path)
cat("Wrote params:", params_path, "\n")

# --- Summary ---
cat("\n=== Input preparation complete ===\n")
cat("  FASTA: ", fasta_path, "\n")
cat("  Params:", params_path, "\n")
cat("  Gene:  ", gene_len, "nt (", gene_len %/% 3, "codons)\n")
cat("  Total: ", total_len, "nt\n")
cat("  Min/Max block:", params$min_len, "/", params$max_len, "nt\n")
cat("  Exclusion positions:", length(exclusion_list), "\n")
cat("  Alien OHs:", length(alien_ohs), "\n")
