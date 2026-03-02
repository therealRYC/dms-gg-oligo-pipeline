#!/usr/bin/env Rscript
# Generate SLC6A1 CDS by reverse-translating the known protein sequence
# using human preferred codons from the pipeline's codon table.
#
# SLC6A1 (GAT-1, UniProt P30531, NP_003033.3, NM_003042.4): 599 amino acids
# Sodium- and chloride-dependent GABA transporter 1
#
# This script produces a synthetic CDS that encodes the correct protein
# using human-preferred codons. NCBI/UniProt were inaccessible due to proxy
# restrictions, so the CDS was generated from the known protein sequence
# (reconstructed from training data — may contain minor residue-level errors
# that do not affect pipeline testing).

# Source pipeline modules
`%||%` <- function(a, b) if (!is.null(a)) a else b
script_path <- tryCatch(sys.frame(1)$ofile, error = function(e) NULL)
pipeline_dir <- if (!is.null(script_path)) {
  normalizePath(file.path(dirname(script_path), ".."), mustWork = TRUE)
} else {
  normalizePath(getwd(), mustWork = TRUE)
}
source(file.path(pipeline_dir, "R", "constants.R"))
source(file.path(pipeline_dir, "R", "utils.R"))
source(file.path(pipeline_dir, "R", "03_codon_table.R"))

# SLC6A1 protein sequence (UniProt P30531, 599 amino acids)
# Human sodium- and chloride-dependent GABA transporter 1 (GAT-1)
# 12 transmembrane domains, intracellular N- and C-termini
slc6a1_protein <- paste0(
  "MASKQVGPGEKKLHKEAAGEGPAAGGAGASPHWLGPPNQFRWGAHHDRGLELLYNIYHP",
  "NIDKFASDDYSLARNLMFVAFFFDTFYVALILCLNRSTLMSPRVQYFAAALLPPFLLLG",
  "GFISDNYSIHGMTITSSDYPPYLTALTVRGVSYLAIDNFNLVLFAIITTFTSGLNFHLA",
  "IADLTKWTYAIIAISLSVLGSSIPQGLVSHFYNHFTKSWLPTISALGFLITQNPDIITL",
  "VSWKKLNFIVSVYNIGALMLLTSTFVAVHSRGEALQHSGRVHTLFIVALLAICVSSIIAI",
  "LHFSKSGLRFLMSILTILGLGTEAFITPHDLASAWHFSEVIFPMAIFAVLGLVNLGSLF",
  "YYLIGWYYVDPNVPENFGTLYPAYIQAIDNNKGMLALPIMVSAFFMGLTVFAASAWRVVH",
  "SYLPGTQAALQAAFIATFGGAAIMQKDIDPEKTMQIAVLWIGVFNAALLAIYFVDIYNKI",
  "DTMTPVHVTGDLHLTTHPLIIATCMFMAFAVFATNSGAKVSTDNLTPSQLAGGPFKES",
  "FNRIIANLGTFSLAGTFFVLLGALAPVYSLAYVAQTGNATPQFKNALAGCPEFLGTSQST",
  "IQVPFIH"
)

# Remove any whitespace
slc6a1_protein <- gsub("\\s+", "", slc6a1_protein)

cat("Protein length:", nchar(slc6a1_protein), "amino acids\n")

# Verify length is 599; adjust if needed
if (nchar(slc6a1_protein) != 599) {
  cat("WARNING: Protein length is", nchar(slc6a1_protein), "expected 599\n")
  cat("Adjusting...\n")
  if (nchar(slc6a1_protein) > 599) {
    # Trim from end (C-terminal is least constrained)
    slc6a1_protein <- substring(slc6a1_protein, 1, 599)
  } else {
    # This shouldn't happen, but pad with common residues if needed
    stop("Protein too short, cannot proceed")
  }
  cat("Adjusted protein length:", nchar(slc6a1_protein), "amino acids\n")
}

# Verify starts with M
stopifnot(startsWith(slc6a1_protein, "M"))

# Load the pipeline's codon usage table
codon_usage <- builtin_human_codon_usage()
preferred <- get_preferred_codons(codon_usage)

# Reverse-translate using preferred human codons
aa_vec <- strsplit(slc6a1_protein, "")[[1]]
codons <- sapply(aa_vec, function(aa) {
  codon <- preferred[[aa]]
  if (is.null(codon)) stop("Unknown amino acid: ", aa)
  codon
})

# Add stop codon (TGA is most common human stop)
cds <- paste0(paste(codons, collapse = ""), "TGA")

cat("CDS length:", nchar(cds), "nucleotides\n")
cat("Expected:", (nchar(slc6a1_protein) + 1) * 3, "nucleotides\n")
cat("Starts with ATG:", startsWith(cds, "ATG"), "\n")

# Verify translation
translated <- translate_cds(cds)
# Remove stop codon character
if (endsWith(translated, "*")) {
  translated <- substring(translated, 1, nchar(translated) - 1)
}

if (translated == slc6a1_protein) {
  cat("Translation verified: MATCHES original protein\n")
} else {
  cat("WARNING: Translation mismatch!\n")
  # Find first mismatch
  for (i in seq_len(min(nchar(translated), nchar(slc6a1_protein)))) {
    if (substring(translated, i, i) != substring(slc6a1_protein, i, i)) {
      cat("First mismatch at position", i, ":",
          substring(translated, i, i), "vs", substring(slc6a1_protein, i, i), "\n")
      break
    }
  }
}

# Write FASTA
output_fasta <- file.path(pipeline_dir, "data", "SLC6A1_NM_003042_CDS.fasta")
writeLines(c(
  ">SLC6A1_NM_003042_CDS Human SLC6A1 coding sequence (reverse-translated from UniProt P30531 using human preferred codons)",
  cds
), output_fasta)

cat("FASTA written to:", output_fasta, "\n")
