# Created: 2026-02-17
# Last updated: 2026-02-17 — Initial creation
#!/usr/bin/env Rscript
# Generate AKAP11 CDS by reverse-translating the known protein sequence
# using human preferred codons from the pipeline's codon table.
#
# AKAP11 (A-kinase anchor protein 11, UniProt Q9UKA4, NM_016248): 1901 amino acids
# Also known as AKAP220, PRKA11, KIAA0629, PPP1R44
#
# This script produces a synthetic CDS that encodes the correct protein
# using human-preferred codons. The protein sequence was retrieved from
# UniProt Q9UKA4 (reviewed, SwissProt).

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

# AKAP11 protein sequence (UniProt Q9UKA4, 1901 amino acids)
# Human A-kinase anchor protein 11
akap11_protein <- paste0(
  "MATFRNNHMKTKASVRKSFSEDVFQSVKSLLQSQKELCSVTAEDCLQQDEHANLTEVTFL",
  "GFNEETDAAHIQDLAAVSLELPDILNSLHFCSLNENEIICMKNINKPLDISSDPLNQSHP",
  "SGMLCVMRVSPTSPRLRIDFIFSLLSKYATGIRYTLDTFLHQKHQLETTDEDDDDTNQSV",
  "SSIEDDFVTAFEHLEEEETSKPYNDGMNITVLRSQCDAASQTVTGHHLETHDLKILISSG",
  "QQKSLAKPSTSSVNVLGHKELPSVKTSVTTSISEPWTQRSFYRSSNASDKDSDLQKTFFS",
  "SSPAYSSESECSSPSPVIFLDEEGYQKSLKAKLELPKIPVMKDDIEDSDSEVSEFFDSFD",
  "QFDELEQTLETCLFNKDPVIGKSSQRKGHKHGKSCMNPQKFKFDRPALPANVRKPTPRKP",
  "ESPYGNLCDAPDSPRPVKASREDSGLFSPIRSSAFSPLGGCTPAECFCQTDIGGDRIHEN",
  "HDSVYYTYEDYAKSISCEVLGSVLRTHHTNTLSNINSIKHGENKTVTFKHGNLDQKNKSK",
  "NKSLMIKDSIQKFAADLVEKSFGSAFKDLQKGVSSCTNALYHLAIKLTSSVLQMAFDELR",
  "RQRAFSLKERAISGLANFLVSEALSNALKDLQYVKKQIFTNTVARFAADLAEELVFEGIM",
  "EVCQFSYPQTPASPQCGSFDFEDKVVKLYAKDLSESVIQEAFIELSQVDVTFTTKAAVSV",
  "STDNIKYVSAESVVPSTQAVTFSPSFHNQAIMVTKPVQEYKKEYTVQQALFCTSGIVTSI",
  "PVPLAGSALLPYHISSTACQAKAHLSSDDSNSNGDSAQVHIATKNREEKAACLRNICLPS",
  "EHNPGNQNDFKPTNDDIEMQSSSKLPNDPAIISNFSAAVVHTIVNETLESMTSLEVTKMV",
  "DERTDYLTKSLKEKTPPFSHCDQAVLQCSEASSNKDMFADRLSKSIIKHSIDKSKSVIPN",
  "IDKNAVYKESLPVSGEESQLTPEKSPKFPDSQNQLTHCSLSAAKDCVPECKVSMVHGSSL",
  "ETLPSCPAVTGQKSDLKESAKDQPLKKHNLNSTSLEALSFGQENPFPHSHTFSSTALTCV",
  "DGLHVEDKQKVRDRNVIPDTPPSTPLVPSRASSEWDIKKLTKKLKGELAKEFAPATPPST",
  "PHNSSVGSLSENEQNTIEKEEFMLKLMRSLSEEVESSESGELPEVDVKSEHSGKKVQFAE",
  "ALATHILSLATEMAASHLDNKIIQEPKVKNPCLNVQSQRSVSPTFLNPSDENLKTLCNFA",
  "GDLAAEVITEAEKIAKVRNCMLFKQKKNSCYADGDEDYKVEEKLDIEAVVHPREVDPFIL",
  "SLPPSSCMSGLMYKYPSCESVTDEYAGHLIQILKQEGGNSELIMDQYANRLAYRSVKSGL",
  "QEAAKTTKVQCNSRMFPVPSSQVKTNKELLMFSNKEHHQEADKKRQSKRNEGYFCKNQTC",
  "ERTLDPYRNEVSQLYSFSTSLVHSITKDAKEELTASLVGLPKSLTDSCLFEKSGYEEDNE",
  "CHVTPELPKSLQPSSQNHRFYHSTGSLNGYGCGDNVVQAVEQYAKKVVDDTLELTLGSTV",
  "FRVSETTKSADRVTYAEKLSPLTGQACRYCDLKELHNCTGNSSQHFFRQGSLASSKPASN",
  "PKFSSRYQKSRIFHLSVPQIHVNLDKKAVLAEKIVAEAIEKAERELSSTSLAADSGIGQE",
  "GASFAESLATETMTAAVTNVGHAVSSSKEIEDFQSTESVSSQQMNLSIGDDSTGSWSNLS",
  "FEDEHQDESSSFHHLSESNGNSSSWSSLGLEGDLYEDNLSFPTSDSDGPDDKDEEHEDEV",
  "EGLGQDGKTLLITNIDMEPCTVDPQLRIILQWLIASEAEVAELYFHDSANKEFMLLSKQL",
  "QEKGWKVGDLLQAVLQYYEVMEKASSEERCKSLFDWLLENA"
)

# Remove any whitespace
akap11_protein <- gsub("\\s+", "", akap11_protein)

cat("Protein length:", nchar(akap11_protein), "amino acids\n")

# Verify length is 1901
if (nchar(akap11_protein) != 1901) {
  stop("ERROR: Protein length is ", nchar(akap11_protein), ", expected 1901")
}

# Verify starts with M
stopifnot(startsWith(akap11_protein, "M"))

# Load the pipeline's codon usage table
codon_usage <- builtin_human_codon_usage()
preferred <- get_preferred_codons(codon_usage)

# Reverse-translate using preferred human codons
aa_vec <- strsplit(akap11_protein, "")[[1]]
codons <- sapply(aa_vec, function(aa) {
  codon <- preferred[[aa]]
  if (is.null(codon)) stop("Unknown amino acid: ", aa)
  codon
})

# Add stop codon (TGA is most common human stop)
cds <- paste0(paste(codons, collapse = ""), "TGA")

cat("CDS length:", nchar(cds), "nucleotides\n")
cat("Expected:", (nchar(akap11_protein) + 1) * 3, "nucleotides\n")
cat("Starts with ATG:", startsWith(cds, "ATG"), "\n")

# Verify translation
translated <- translate_cds(cds)
# Remove stop codon character
if (endsWith(translated, "*")) {
  translated <- substring(translated, 1, nchar(translated) - 1)
}

if (translated == akap11_protein) {
  cat("Translation verified: MATCHES original protein\n")
} else {
  cat("WARNING: Translation mismatch!\n")
  # Find first mismatch
  for (i in seq_len(min(nchar(translated), nchar(akap11_protein)))) {
    if (substring(translated, i, i) != substring(akap11_protein, i, i)) {
      cat("First mismatch at position", i, ":",
          substring(translated, i, i), "vs", substring(akap11_protein, i, i), "\n")
      break
    }
  }
}

# Write FASTA
output_fasta <- file.path(pipeline_dir, "data", "AKAP11_NM_016248_CDS.fasta")
writeLines(c(
  ">AKAP11_NM_016248_CDS Human AKAP11 coding sequence (reverse-translated from UniProt Q9UKA4 using human preferred codons)",
  cds
), output_fasta)

cat("FASTA written to:", output_fasta, "\n")
