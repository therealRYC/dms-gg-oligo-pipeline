# Created: 2025-02-01
# Last updated: 2026-02-20 — Split FASTA header into gene_name + gene_description; add read_gene_from_string()
# 01_gene_input.R — Read FASTA, validate CDS
# DMS Golden Gate Oligo Pipeline

#' Read and validate a gene coding sequence from a FASTA file
#'
#' Parses the FASTA header to extract a short gene_name (first whitespace-
#' delimited token) and the full header as gene_description. The short name
#' is used for output file naming; the full description for traceability.
#'
#' @param fasta_path Path to FASTA file containing a single CDS
#' @return List with components:
#'   - cds: character string of the coding DNA sequence (uppercase)
#'   - protein: character string of the translated amino acid sequence
#'   - n_codons: integer number of codons (including start, excluding stop if present)
#'   - gene_name: character short name (first token of FASTA header)
#'   - gene_description: character full FASTA header for traceability
read_gene <- function(fasta_path) {
  seqs <- Biostrings::readDNAStringSet(fasta_path)

  if (length(seqs) == 0) {
    stop("No sequences found in FASTA file: ", fasta_path)
  }
  if (length(seqs) > 1) {
    cli::cli_warn("Multiple sequences in FASTA; using the first one.")
  }

  full_header <- names(seqs)[1]
  # Extract first whitespace-delimited token as the short name
  gene_name <- strsplit(full_header, "\\s+")[[1]][1]

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
    cds              = cds,
    protein          = protein_clean,
    n_codons         = nchar(cds) %/% 3L,
    gene_name        = gene_name,
    gene_description = full_header
  )
}

#' Read and validate a gene CDS from a string (no FASTA file needed)
#'
#' @param cds_string Character string of the coding DNA sequence
#' @param gene_name Character name for the gene (used in outputs)
#' @return List with same structure as read_gene()
read_gene_from_string <- function(cds_string, gene_name = "gene") {
  cds <- toupper(trimws(cds_string))

  validate_cds(cds, gene_name)

  protein <- translate_cds(cds)

  # Remove terminal stop from protein for counting purposes
  if (endsWith(protein, "*")) {
    protein_clean <- substring(protein, 1, nchar(protein) - 1)
  } else {
    protein_clean <- protein
  }

  list(
    cds              = cds,
    protein          = protein_clean,
    n_codons         = nchar(cds) %/% 3L,
    gene_name        = gene_name,
    gene_description = gene_name
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
