# 03_codon_table.R — Human codon usage table, preferred codon lookup
# DMS Golden Gate Oligo Pipeline

#' Load human codon usage table
#'
#' Returns a data frame with columns: codon, aa, frequency
#' Default uses bundled Kazusa human codon usage data.
#' @param custom_path Optional path to a custom codon usage RDS file
#' @return Data frame with codon usage frequencies
load_codon_usage <- function(custom_path = NULL) {
  if (!is.null(custom_path)) {
    return(readRDS(custom_path))
  }

  # Use bundled human codon usage
  data_path <- system.file("data", "human_codon_usage.rds", package = "dmsggoligo")
  if (!nzchar(data_path)) {
    # Fallback: look relative to script location
    data_path <- file.path(find_data_dir(), "human_codon_usage.rds")
  }

  if (!file.exists(data_path)) {
    cli::cli_alert_info("Bundled codon usage data not found; using built-in table.")
    return(builtin_human_codon_usage())
  }

  readRDS(data_path)
}

#' Get the preferred (most frequent) human codon for each amino acid
#' @param codon_usage Data frame from load_codon_usage()
#' @return Named character vector: names = amino acids, values = preferred codons
get_preferred_codons <- function(codon_usage) {
  # For each amino acid, find the codon with the highest frequency
  result <- character(0)
  for (aa in unique(codon_usage$aa)) {
    subset_df <- codon_usage[codon_usage$aa == aa, , drop = FALSE]
    best <- subset_df$codon[which.max(subset_df$frequency)]
    result[aa] <- best
  }
  result
}

#' Get the preferred codon for a single amino acid
#' @param aa Single-letter amino acid code
#' @param preferred_codons Named vector from get_preferred_codons()
#' @return Character codon string
get_preferred_codon <- function(aa, preferred_codons) {
  result <- preferred_codons[aa]
  if (is.na(result)) stop("No preferred codon for amino acid: ", aa)
  result
}

#' Get codons ranked by usage frequency for a given amino acid
#' @param aa Single-letter amino acid code
#' @param codon_usage Data frame from load_codon_usage()
#' @return Character vector of codons, highest frequency first
get_ranked_codons <- function(aa, codon_usage) {
  subset_df <- codon_usage[codon_usage$aa == aa, , drop = FALSE]
  subset_df <- subset_df[order(-subset_df$frequency), , drop = FALSE]
  subset_df$codon
}

#' Built-in human codon usage table (Kazusa, Homo sapiens)
#' Frequencies per thousand codons
#' @return Data frame with columns: codon, aa, frequency
builtin_human_codon_usage <- function() {
  # Kazusa Human codon usage (per thousand)
  data.frame(
    codon = c(
      "TTT","TTC","TTA","TTG","CTT","CTC","CTA","CTG",
      "ATT","ATC","ATA","ATG",
      "GTT","GTC","GTA","GTG",
      "TCT","TCC","TCA","TCG","AGT","AGC",
      "CCT","CCC","CCA","CCG",
      "ACT","ACC","ACA","ACG",
      "GCT","GCC","GCA","GCG",
      "TAT","TAC",
      "TAA","TAG","TGA",
      "CAT","CAC","CAA","CAG",
      "AAT","AAC","AAA","AAG",
      "GAT","GAC","GAA","GAG",
      "TGT","TGC","TGG",
      "CGT","CGC","CGA","CGG","AGA","AGG",
      "GGT","GGC","GGA","GGG"
    ),
    aa = c(
      "F","F","L","L","L","L","L","L",
      "I","I","I","M",
      "V","V","V","V",
      "S","S","S","S","S","S",
      "P","P","P","P",
      "T","T","T","T",
      "A","A","A","A",
      "Y","Y",
      "*","*","*",
      "H","H","Q","Q",
      "N","N","K","K",
      "D","D","E","E",
      "C","C","W",
      "R","R","R","R","R","R",
      "G","G","G","G"
    ),
    frequency = c(
      17.6, 20.3, 7.7, 12.9, 13.2, 19.6, 7.2, 39.6,
      16.0, 20.8, 7.5, 22.0,
      11.0, 14.5, 7.1, 28.1,
      15.2, 17.7, 12.2, 4.4, 12.1, 19.5,
      17.5, 19.8, 16.9, 6.9,
      13.1, 18.9, 15.1, 6.1,
      18.4, 27.7, 15.8, 7.4,
      12.2, 15.3,
      1.0, 0.8, 1.6,
      10.9, 15.1, 12.3, 34.2,
      17.0, 19.1, 24.4, 31.9,
      21.8, 25.1, 29.0, 39.6,
      10.6, 12.6, 13.2,
      4.5, 10.4, 6.2, 11.4, 12.2, 12.0,
      10.8, 22.2, 16.5, 16.5
    ),
    stringsAsFactors = FALSE
  )
}

#' Find the data directory (works both installed and from source)
#' @return Path to data directory
find_data_dir <- function() {
  # Try relative to R/ directory
  candidates <- c(
    file.path(getwd(), "data"),
    file.path(dirname(sys.frame(1)$ofile %||% ""), "..", "data"),
    system.file("data", package = "dmsggoligo")
  )
  for (p in candidates) {
    if (dir.exists(p)) return(p)
  }
  file.path(getwd(), "data")  # fallback
}
