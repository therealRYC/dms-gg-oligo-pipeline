# Created: 2025-02-01
# Last updated: 2026-03-17 — Add DEFAULT_GENEBLOCK_FLANKING_PAD constant
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
    cut_fwd    = 1L, # cuts 1 nt downstream of recognition on sense strand
    cut_rev    = 5L, # cuts 5 nt downstream on antisense strand
    oh_len     = 4L, # 4-nt overhang
    spacer_len = 1L, # 1 nt spacer between recognition end and overhang start
    temp       = 37L
  ),
  BsmBI = list(
    name       = "BsmBI",
    recog      = "CGTCTC",
    recog_rc   = "GAGACG",
    cut_fwd    = 1L, # cuts 1 nt downstream of recognition on sense strand
    cut_rev    = 5L, # cuts 5 nt downstream on antisense strand
    oh_len     = 4L, # 4-nt overhang
    spacer_len = 1L, # 1 nt spacer between recognition end and overhang start
    temp       = 42L
  ),
  PaqCI = list(
    name       = "PaqCI",
    recog      = "CACCTGC",
    recog_rc   = "GCAGGTG",
    cut_fwd    = 4L,
    cut_rev    = 8L,
    oh_len     = 4L,
    spacer_len = 4L, # 4 nt spacer between recognition end and overhang start
    temp       = 37L
  )
)

# --- Synthesis Limits ---
MAX_OLIGO_LENGTH <- 300L # Twist Bioscience oligo pool max
MAX_GENEBLOCK_LENGTH <- 1800L # Gene fragment synthesis max
MIN_GENEBLOCK_LENGTH <- 300L # Twist gene fragment synthesis minimum
DEFAULT_GENEBLOCK_FLANKING_PAD <- "TGCATG" # 6 bp flanking pad for gene block termini (NEB recommends ≥6 bp)

# --- Amino Acid Alphabet ---
AA_STANDARD <- c(
  "A", "C", "D", "E", "F", "G", "H", "I", "K", "L",
  "M", "N", "P", "Q", "R", "S", "T", "V", "W", "Y"
)
AA_STOP <- "*"
AA_ALL <- c(AA_STANDARD, AA_STOP)

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
DEFAULT_BARCODE_LENGTH <- 20L
DEFAULT_MIN_HAMMING <- 3L
DEFAULT_PREFIX_LENGTH <- 12L # Unified hierarchical mode: prefix carries hard Hamming guarantee
DEFAULT_GC_RANGE <- c(0.35, 0.65) # Tightened from 0.25-0.75; captures most Tm benefit cheaply
DEFAULT_MAX_HOMOPOLYMER <- 4L
DEFAULT_MIN_HAMMING_FLOOR <- 2L # Floor for auto-adjustment when capacity is tight

# --- Enhanced Barcode Filters ---
# Literature-motivated filters for improved barcode quality in VIS-Seq/LABEL-Seq readout.
# Each filter has a boolean toggle (ON/OFF) and a threshold parameter.
# Conservative defaults: low-rejection filters ON, high-rejection filters OFF.

# GGC motif: Illumina error hotspot — 16% of substitution errors linked to GG motifs
# (Schirmer et al. 2016). ~25% rejection rate, so OFF by default.
DEFAULT_FILTER_GGC <- FALSE

# Self-complementarity (hairpins): Hairpin stems reduce PCR efficiency 40-90% and
# impair padlock probe hybridization. ~10-15% rejection rate. ON by default.
DEFAULT_FILTER_HAIRPIN <- TRUE
DEFAULT_MAX_HAIRPIN_STEM <- 3L # Max stem length (bp) before rejection

# Dinucleotide repeats: Excessive runs (e.g., ACACAC) cause indel errors during
# sequencing via polymerase slippage. ~2% rejection rate. ON by default.
DEFAULT_FILTER_DINUC_REPEATS <- TRUE
DEFAULT_MAX_DINUC_REPEAT_UNITS <- 4L # Max repeat units before rejection (e.g., 4 = ACACACAC ok)

# Strict poly-G: Worst homopolymer for Illumina two-channel chemistry + T7 slippage.
# ~6% rejection rate. OFF by default — general homopolymer filter already catches runs > 4.
DEFAULT_FILTER_POLYG <- FALSE
DEFAULT_MAX_POLYG <- 2L # Max consecutive G's when filter is enabled

# Tm uniformity: All barcodes within ±N°C of set median for consistent padlock probe
# ligation. Post-hoc filter (needs full set). ~10-20% rejection rate. OFF by default.
DEFAULT_FILTER_TM_UNIFORMITY <- FALSE
DEFAULT_TM_TOLERANCE <- 2.0 # ±°C from median Tm

# --- PolIII Terminator Signal ---
# RNA Polymerase III terminates at runs of >=4 consecutive Ts on the non-template
# strand. Barcodes transcribed by PolIII (U6) must not contain TTTT.
POLIII_TERM_SEQ <- "TTTT"

# --- Palindromic 4-nt overhangs ---
# Sequence equals its own reverse complement (e.g., TTAA = RC(TTAA)).
# Palindromic overhangs are problematic for Golden Gate assembly:
#   - Enable self-circularization and inverted-insertion products
#   - Under BsmBI conditions, 7 of 16 have fidelity < 0.60
#   - None appear in Potapov HF Set 3
# Treatment: hard blacklist for freely-chosen overhangs (oh3, oh4, SB junctions);
# heavy penalty (-10.0) for gene-derived boundary overhangs (oh1, oh2).
PALINDROMIC_4NT <- c(
  "AATT", "ATAT", "ACGT", "AGCT",
  "TATA", "TTAA", "TGCA", "TCGA",
  "CATG", "CTAG", "CCGG", "CGCG",
  "GATC", "GTAC", "GCGC", "GGCC"
)

# --- Overhang Scoring (BUG-008 fix) ---
# Scoring formula: Score = P_fid_bsmbi(oh) * P_eff_bsmbi(oh)
# Both metrics from the BsmBI cycling 256x256 matrix (Pryor et al. 2020):
#   P_fid = M[X][RC(X)] / sum(M[X][*])    — individual fidelity (accuracy)
#   P_eff = M[X][RC(X)] / max_Y(M[Y][RC(Y)]) — relative ligation efficiency (yield)

# --- Barcodes Per Variant ---
DEFAULT_BARCODES_PER_VARIANT <- 10L
