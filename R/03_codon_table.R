# Created: 2025-02-01
# Last updated: 2026-02-21 — Switch from Kazusa to CoCoPUTs codon usage data; add CSV support and validation
# 03_codon_table.R — Human codon usage table, preferred codon lookup
# DMS Golden Gate Oligo Pipeline

#' Load human codon usage table
#'
#' Returns a data frame with columns: codon, aa, frequency.
#' Default uses bundled CoCoPUTs human codon usage data (Alexaki et al. 2019).
#' Supports custom tables in RDS or CSV format.
#'
#' @param custom_path Optional path to a custom codon usage file (.rds or .csv).
#'   CSV files must have columns: codon, aa, frequency (64 rows, one per codon).
#' @return Data frame with codon usage frequencies (per thousand)
load_codon_usage <- function(custom_path = NULL) {
  if (!is.null(custom_path)) {
    ext <- tolower(tools::file_ext(custom_path))
    if (ext == "csv") {
      tbl <- read.csv(custom_path, stringsAsFactors = FALSE)
      validate_codon_table(tbl, source = custom_path)
      return(tbl)
    } else if (ext == "rds") {
      tbl <- readRDS(custom_path)
      validate_codon_table(tbl, source = custom_path)
      return(tbl)
    } else {
      stop("Unsupported codon table format: '.", ext,
           "'. Use .csv or .rds (got: ", custom_path, ")")
    }
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

#' Validate a codon usage table
#'
#' Checks that a data frame has the expected structure for use as a codon usage
#' table: 3 required columns (codon, aa, frequency), 64 rows, valid 3-nt ACGT
#' codons, and non-negative numeric frequencies.
#'
#' @param tbl Data frame to validate
#' @param source Optional string describing where the table came from (for error messages)
#' @return Invisible NULL; stops with informative error on validation failure
validate_codon_table <- function(tbl, source = "codon table") {
  errors <- character(0)

  # Check required columns
  required_cols <- c("codon", "aa", "frequency")
  missing_cols <- setdiff(required_cols, names(tbl))
  if (length(missing_cols) > 0) {
    errors <- c(errors, paste0(
      "Missing required columns: ", paste(missing_cols, collapse = ", "),
      ". Expected: codon, aa, frequency"
    ))
  }

  # If columns are missing, we can't check further

  if (length(errors) > 0) {
    stop("Invalid ", source, ":\n  - ", paste(errors, collapse = "\n  - "))
  }

  # Check row count
  if (nrow(tbl) != 64) {
    errors <- c(errors, paste0(
      "Expected 64 rows (one per codon), got ", nrow(tbl)
    ))
  }

  # Check codons are valid 3-nt ACGT strings
  bad_codons <- tbl$codon[!grepl("^[ACGT]{3}$", toupper(tbl$codon))]
  if (length(bad_codons) > 0) {
    errors <- c(errors, paste0(
      "Invalid codons (must be 3-nt ACGT): ",
      paste(head(bad_codons, 5), collapse = ", "),
      if (length(bad_codons) > 5) paste0(" (and ", length(bad_codons) - 5, " more)")
    ))
  }

  # Check for duplicate codons
  dup_codons <- tbl$codon[duplicated(toupper(tbl$codon))]
  if (length(dup_codons) > 0) {
    errors <- c(errors, paste0(
      "Duplicate codons: ", paste(unique(dup_codons), collapse = ", ")
    ))
  }

  # Check frequencies are non-negative numeric
  if (!is.numeric(tbl$frequency)) {
    errors <- c(errors, "frequency column must be numeric")
  } else if (any(tbl$frequency < 0, na.rm = TRUE)) {
    errors <- c(errors, "frequency values must be non-negative")
  } else if (any(is.na(tbl$frequency))) {
    errors <- c(errors, "frequency column contains NA values")
  }

  if (length(errors) > 0) {
    stop("Invalid ", source, ":\n  - ", paste(errors, collapse = "\n  - "))
  }

  invisible(NULL)
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

#' Built-in human codon usage table (CoCoPUTs, Homo sapiens)
#'
#' Frequencies per thousand codons, aggregated from the CoCoPUTs database
#' (Codon and Codon-Pair Usage Tables). This is the modern replacement for the
#' Kazusa codon usage database (last updated 2007).
#'
#' Source: CoCoPUTs (Alexaki et al. 2019, J Mol Biol 431:2434-2441)
#'   - https://dnahive.fda.gov/dna.cgi?cmd=codon_usage&id=537&mode=cocoputs
#'   - Organism: Homo sapiens (taxid 9606)
#'   - Assembly: GCF_000001405.39 (GRCh38.p13)
#'   - 119,196 CDS entries, 77,461,688 total codons
#'   - Downloaded: 2026-02-21
#'
#' @return Data frame with columns: codon, aa, frequency
builtin_human_codon_usage <- function() {
  # CoCoPUTs Human codon usage (per thousand)
  # Aggregated from per-CDS counts in o537-Human_CDS.tsv
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
      17.20, 17.53,  8.83, 13.47, 14.16, 17.82,  7.49, 36.06,  # F, L
      16.58, 18.69,  8.18, 21.46,                                # I, M
      11.79, 13.44,  7.70, 25.76,                                # V
      16.92, 17.29, 14.19,  4.06, 14.04, 19.64,                  # S
      19.11, 18.88, 18.75,  6.16,                                # P
      14.29, 17.76, 16.56,  5.60,                                # T
      18.86, 25.66, 17.05,  5.96,                                # A
      12.15, 13.47,                                              # Y
       0.44,  0.35,  0.80,                                       # *
      11.91, 14.63, 14.18, 35.30,                                # H, Q
      18.51, 18.28, 27.77, 31.79,                                # N, K
      24.07, 24.25, 33.87, 39.42,                                # D, E
      10.49, 10.84, 11.67,                                       # C, W
       4.56,  8.71,  6.41, 10.63, 13.40, 12.19,                  # R
      10.80, 19.75, 17.17, 15.27                                 # G
    ),
    stringsAsFactors = FALSE
  )
}

#' Find the data directory (works both installed and from source)
#'
#' Resolution order:
#'   1. Option "dmsggoligo.data_dir" (set by test setup.R to project root)
#'   2. getwd()/data  (works when run from project root)
#'   3. Relative to the calling R script's source file
#'   4. Installed package data directory
#'
#' @return Path to data directory
find_data_dir <- function() {
  # Check option first (set by test setup.R or user)
  opt <- getOption("dmsggoligo.data_dir")
  if (!is.null(opt) && dir.exists(opt)) return(opt)

  # Try relative to working directory or source file
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
