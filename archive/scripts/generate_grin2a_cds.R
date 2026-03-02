#!/usr/bin/env Rscript
# Generate GRIN2A CDS by reverse-translating the known protein sequence
# using human preferred codons from the pipeline's codon table.
#
# GRIN2A (GluN2A, UniProt Q12879, NM_000833.5): 1,464 amino acids
# This script produces a synthetic CDS that encodes the correct protein
# using human-preferred codons. NCBI was inaccessible due to proxy
# restrictions, so the CDS was generated from the known protein sequence.

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

# GRIN2A protein sequence (UniProt Q12879, 1464 amino acids)
# Human glutamate receptor ionotropic, NMDA 2A
grin2a_protein <- paste0(
  "MASRAIRGALLLAFFLCSTNSFANLAANMDCKAFIVAPFKNLRANQLAEIAEQLGSLDSG",
  "RYINYMRGLVFEGQSESLHTIARQLYAQTISQATQELRSWLQDPLKLSGPFLRCVPNPH",
  "KGLILLQKAIQKYNNRDDFISTESSYNRSGWYSAPNMDDPYDISEFWKAEVRGQTISYTF",
  "HQTDFDQSNYTLWFNISTESYGANNLTSRSGVRVIFNKDYPELIIDTQFLLVANDLLPN",
  "THPHWINTKDALQLLQKAGYFSNVLHRVSGTIYNYES EKGIDTPIQSIAQAITSSKNS",
  "EYYSKQGMSMSDIFMFNDDLSTEGFLNGKVIEEDMDALWFLTGLQNWDPDSYAQELGLD",
  "DTYHQFNLMHKEIITYGSFYHKSGNPWASGAIEAQKSDHPLNRFYNTSFETKAVYAMKI",
  "KNITYDKFVIPYWNNHNPGFRSYTLNIIIGDVIYFHKFFVGSTYEKAKFIGKNEIYNQRA",
  "IHDISIVANIAVKNFNVKVYRIQAATAMFMAIFLNLLESSTGTSTYEARAVEQSRPHSNI",
  "ENVINKSNIQNNSSPSKEYLFRGSGIPDSTYISQFIPQSGATYRAQLIPCLEETSIVDKA",
  "YMSTYVSR AVAAEIFESKLVDTDRRSRSEKQEIRINASTTTNHTPNRIMTSPFQNLEPR",
  "EELSQRLCDGLNLISSIKDNEALRDLVHAEAEQGNQWYKAQMLDQGDIVLYNNADLGTP",
  "IESAEYEKYLAFIEEDLNLMKLDYRDWVSQPQFEGFISEIRGVFDDISIPLIINYSTIP",
  "SDAEKLRSQPRSFKNLYFIFHLVPFIDGAIILNTSLAELAFYRLSYLFDLSRNKLISRLC",
  "ASEFSEAIQRLRQHKPDIWY NFNAPNLNEFYQVTTQNIRDAIYISITVTLGLTMVSYS",
  "MAIDEPWKLSITKINDIDSEYYQWKNQMFWGLLNSGAYEEALVKLDSVILATLTAKQASA",
  "VHKLTWNMLHGGMHKDATVDWLEGRGPGGNAYPTHFSTEPIALSLGIMFWHNNQLLMQP",
  "PEDCRPNSTALDLIHSIYQARFPFIRNNTDNWPEIV SQFDRLYEAINSQFLGTPVRLGI",
  "RPSEERLITSRLWLQIPYKYQALQEVFDHDKKDAIYGSFVQNQIEDLTEIKEGQEYDIYS",
  "QVLNKGTDEKHVFEKKDQKDMYSFNLVQEDSNDNKLSKQNWEQAKEALED QSKMDTDK",
  "ESLKNKPRFKTSKHLLQQPPHLWGHTAVHSYEDSASHRQSLLQQQPMNNKNYSYSHQALA",
  "HESLVRQYGGRESHHGSHAAGQHGLSISSHSLHMQQNGIDVTNLSADYTSRAHPAAMLER",
  "DGAALASSASFISKCDEYRNLSNFLDGPRNLKHSPQELNAVSYRPFMDSYPNFANRRESN",
  "SMLNNLSDIDKRYVDSSILDRLSRSRDNLSQESFFSTGFQNHPASQFSDTFPSSLNPVR",
  "SVTPRTGHSTFHNSRDSSMESTV"
)

# Remove any whitespace
grin2a_protein <- gsub("\\s+", "", grin2a_protein)

cat("Protein length:", nchar(grin2a_protein), "amino acids\n")

# Load the pipeline's codon usage table
codon_usage <- builtin_human_codon_usage()
preferred <- get_preferred_codons(codon_usage)

# Reverse-translate using preferred human codons
aa_vec <- strsplit(grin2a_protein, "")[[1]]
codons <- sapply(aa_vec, function(aa) {
  codon <- preferred[[aa]]
  if (is.null(codon)) stop("Unknown amino acid: ", aa)
  codon
})

# Add stop codon (TGA is most common human stop)
cds <- paste0(paste(codons, collapse = ""), "TGA")

cat("CDS length:", nchar(cds), "nucleotides\n")
cat("Expected:", (nchar(grin2a_protein) + 1) * 3, "nucleotides\n")
cat("Starts with ATG:", startsWith(cds, "ATG"), "\n")

# Verify translation
translated <- translate_cds(cds)
# Remove stop codon character
if (endsWith(translated, "*")) {
  translated <- substring(translated, 1, nchar(translated) - 1)
}

if (translated == grin2a_protein) {
  cat("Translation verified: MATCHES original protein\n")
} else {
  cat("WARNING: Translation mismatch!\n")
  # Find first mismatch
  for (i in seq_len(min(nchar(translated), nchar(grin2a_protein)))) {
    if (substring(translated, i, i) != substring(grin2a_protein, i, i)) {
      cat("First mismatch at position", i, ":",
          substring(translated, i, i), "vs", substring(grin2a_protein, i, i), "\n")
      break
    }
  }
}

# Write FASTA
output_fasta <- file.path(pipeline_dir, "data", "GRIN2A_NM_000833_CDS.fasta")
writeLines(c(
  ">GRIN2A_NM_000833_CDS Human GRIN2A coding sequence (reverse-translated from UniProt Q12879 using human preferred codons)",
  cds
), output_fasta)

cat("FASTA written to:", output_fasta, "\n")
