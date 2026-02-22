# Created: 2025-02-01
# Last updated: 2026-02-18 — Unified hierarchical barcode mode: PREFIX_LENGTH=12, remove OPS/tolerance constants
# constants.R — Enzyme definitions, synthesis limits, amino acid alphabet
# DMS Golden Gate Oligo Pipeline

# --- Enzyme Definitions ---
# Each enzyme is a list with: name, recognition sequence (5'->3'), cut offsets,
# overhang length, and optimal temperature.

ENZYMES <- list(
  BsaI = list(
    name       = "BsaI",
    recog      = "GGTCTC",
    recog_rc   = "GAGACC",
    cut_fwd    = 1L,   # cuts 1 nt downstream of recognition on sense strand
    cut_rev    = 5L,   # cuts 5 nt downstream on antisense strand
    oh_len     = 4L,   # 4-nt overhang
    spacer_len = 1L,   # 1 nt spacer between recognition end and overhang start
    temp       = 37L
  ),
  BsmBI = list(
    name       = "BsmBI",
    recog      = "CGTCTC",
    recog_rc   = "GAGACG",
    cut_fwd    = 1L,   # cuts 1 nt downstream of recognition on sense strand
    cut_rev    = 5L,   # cuts 5 nt downstream on antisense strand
    oh_len     = 4L,   # 4-nt overhang
    spacer_len = 1L,   # 1 nt spacer between recognition end and overhang start
    temp       = 42L
  ),
  PaqCI = list(
    name       = "PaqCI",
    recog      = "CACCTGC",
    recog_rc   = "GCAGGTG",
    cut_fwd    = 4L,
    cut_rev    = 8L,
    oh_len     = 4L,
    spacer_len = 4L,   # 4 nt spacer between recognition end and overhang start
    temp       = 37L
  )
)

# --- Synthesis Limits ---
MAX_OLIGO_LENGTH    <- 300L    # Twist Bioscience oligo pool max
MAX_GENEBLOCK_LENGTH <- 1800L  # Gene fragment synthesis max

# --- Amino Acid Alphabet ---
AA_STANDARD <- c("A","C","D","E","F","G","H","I","K","L",
                  "M","N","P","Q","R","S","T","V","W","Y")
AA_STOP     <- "*"
AA_ALL      <- c(AA_STANDARD, AA_STOP)

# --- Genetic Code (standard) ---
CODON_TABLE <- list(
  "TTT" = "F", "TTC" = "F",
  "TTA" = "L", "TTG" = "L", "CTT" = "L", "CTC" = "L", "CTA" = "L", "CTG" = "L",
  "ATT" = "I", "ATC" = "I", "ATA" = "I",
  "ATG" = "M",
  "GTT" = "V", "GTC" = "V", "GTA" = "V", "GTG" = "V",
  "TCT" = "S", "TCC" = "S", "TCA" = "S", "TCG" = "S", "AGT" = "S", "AGC" = "S",

  "CCT" = "P", "CCC" = "P", "CCA" = "P", "CCG" = "P",
  "ACT" = "T", "ACC" = "T", "ACA" = "T", "ACG" = "T",
  "GCT" = "A", "GCC" = "A", "GCA" = "A", "GCG" = "A",
  "TAT" = "Y", "TAC" = "Y",
  "TAA" = "*", "TAG" = "*", "TGA" = "*",
  "CAT" = "H", "CAC" = "H",
  "CAA" = "Q", "CAG" = "Q",
  "AAT" = "N", "AAC" = "N",
  "AAA" = "K", "AAG" = "K",
  "GAT" = "D", "GAC" = "D",
  "GAA" = "E", "GAG" = "E",
  "TGT" = "C", "TGC" = "C",
  "TGG" = "W",
  "CGT" = "R", "CGC" = "R", "CGA" = "R", "CGG" = "R", "AGA" = "R", "AGG" = "R",
  "GGT" = "G", "GGC" = "G", "GGA" = "G", "GGG" = "G"
)

# Reverse lookup: amino acid -> all codons
AA_TO_CODONS <- list()
for (codon in names(CODON_TABLE)) {
  aa <- CODON_TABLE[[codon]]
  if (is.null(AA_TO_CODONS[[aa]])) {
    AA_TO_CODONS[[aa]] <- codon
} else {
    AA_TO_CODONS[[aa]] <- c(AA_TO_CODONS[[aa]], codon)
  }
}

# --- Barcode Defaults ---
DEFAULT_BARCODE_LENGTH   <- 20L
DEFAULT_MIN_HAMMING      <- 3L
DEFAULT_PREFIX_LENGTH    <- 12L   # Unified hierarchical mode: prefix carries hard Hamming guarantee
DEFAULT_GC_RANGE         <- c(0.25, 0.75)
DEFAULT_MAX_HOMOPOLYMER  <- 4L
DEFAULT_MIN_HAMMING_FLOOR <- 2L   # Floor for auto-adjustment when capacity is tight

# --- PolIII Terminator Signal ---
# RNA Polymerase III terminates at runs of >=4 consecutive Ts on the non-template
# strand. Barcodes transcribed by PolIII (U6) must not contain TTTT.
POLIII_TERM_SEQ <- "TTTT"

# --- Overhang Fidelity Threshold ---
# Based on NEB Ligase Fidelity data (Potapov et al. 2018, 37C, 18h)
# Fidelity = M[X][RC(X)] / sum(M[X][*]) (correct Watson-Crick pairing)
# 0.95 threshold gives ~117 high-fidelity overhangs
# 0.90 threshold gives ~186 overhangs
# 0.85 threshold gives ~224 overhangs
DEFAULT_FIDELITY_THRESHOLD <- 0.95

# --- Barcodes Per Variant ---
DEFAULT_BARCODES_PER_VARIANT <- 10L
