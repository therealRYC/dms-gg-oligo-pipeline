# 01_gene_input.R — Read FASTA, validate CDS
# DMS Golden Gate Oligo Pipeline

#' Read and validate a gene coding sequence from a FASTA file
#' @param fasta_path Path to FASTA file containing a single CDS
#' @return List with components:
#'   - cds: character string of the coding DNA sequence (uppercase)
#'   - protein: character string of the translated amino acid sequence
#'   - n_codons: integer number of codons (including start, excluding stop if present)
#'   - gene_name: character name from FASTA header
read_gene <- function(fasta_path) {
  seqs <- Biostrings::readDNAStringSet(fasta_path)

  if (length(seqs) == 0) {
    stop("No sequences found in FASTA file: ", fasta_path)
  }
  if (length(seqs) > 1) {
    cli::cli_warn("Multiple sequences in FASTA; using the first one.")
  }

  gene_name <- names(seqs)[1]
  cds <- as.character(seqs[[1]])
  cds <- toupper(cds)

  validate_cds(cds, gene_name)

  protein <- translate_cds(cds)

  # Remove terminal stop from protein for counting purposes
  if (endsWith(protein, "*")) {
    protein_clean <- substring(protein, 1, nchar(protein) - 1)
  } else {
    protein_clean <- protein
  }

  list(
    cds      = cds,
    protein  = protein_clean,
    n_codons = nchar(cds) %/% 3L,
    gene_name = gene_name
  )
}

#' Validate a coding DNA sequence
#' @param cds Character string of DNA sequence (uppercase)
#' @param name Gene name for error messages
validate_cds <- function(cds, name = "gene") {
  errors <- character(0)

  # Check valid DNA characters
  if (grepl("[^ACGT]", cds)) {
    errors <- c(errors, "CDS contains non-ACGT characters")
  }

  # Check divisible by 3
  if (nchar(cds) %% 3 != 0) {
    errors <- c(errors, paste0("CDS length (", nchar(cds), ") is not divisible by 3"))
  }

  # Check starts with ATG
  if (!startsWith(cds, "ATG")) {
    errors <- c(errors, paste0("CDS does not start with ATG (starts with: ",
                               substring(cds, 1, 3), ")"))
  }

  # Check for internal stop codons (all codons except the last)
  if (nchar(cds) >= 6 && nchar(cds) %% 3 == 0) {
    codons <- extract_codons(cds)
    stop_codons <- c("TAA", "TAG", "TGA")
    # Check all codons except the last (which may be a stop)
    internal <- codons[-length(codons)]
    internal_stops <- which(internal %in% stop_codons)
    if (length(internal_stops) > 0) {
      errors <- c(errors, paste0("Internal stop codon(s) at position(s): ",
                                 paste(internal_stops, collapse = ", ")))
    }
  }

  if (length(errors) > 0) {
    stop("CDS validation failed for '", name, "':\n  - ",
         paste(errors, collapse = "\n  - "))
  }

  invisible(NULL)
}
