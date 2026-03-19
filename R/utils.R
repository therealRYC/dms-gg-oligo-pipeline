# Created: 2025-02-01
# Last updated: 2026-02-26 — Handle DNAString S4 objects in extract_codons()
# DMS Golden Gate Oligo Pipeline

# Null-coalescing operator (not in base R; available in rlang)
if (!exists("%||%", mode = "function")) {
  `%||%` <- function(a, b) if (!is.null(a)) a else b
}

#' Reverse complement of a DNA string
#' @param seq Character string of DNA sequence (uppercase)
#' @return Character string of reverse complement
reverse_complement <- function(seq) {
  as.character(Biostrings::reverseComplement(Biostrings::DNAString(seq)))
}

#' Calculate GC content of a DNA sequence
#' @param seq Character string of DNA sequence
#' @return Numeric GC fraction
gc_content <- function(seq) {
  bases <- strsplit(toupper(seq), "")[[1]]
  sum(bases %in% c("G", "C")) / length(bases)
}

#' Find all occurrences of a recognition site (both strands) in a sequence
#' @param seq Character DNA sequence to search
#' @param site Character recognition sequence (5'->3')
#' @return Data frame with columns: start, end, strand, match
find_enzyme_sites <- function(seq, site) {
  seq_upper <- toupper(seq)
  site_upper <- toupper(site)
  site_rc <- reverse_complement(site_upper)

  results <- data.frame(
    start = integer(0),
    end = integer(0),
    strand = character(0),
    match = character(0),
    stringsAsFactors = FALSE
  )

  # Forward strand
  pos <- 1L
  while (pos <= nchar(seq_upper) - nchar(site_upper) + 1L) {
    hit <- regexpr(site_upper, substring(seq_upper, pos), fixed = TRUE)
    if (hit == -1L) break
    abs_start <- pos + hit - 1L
    abs_end <- abs_start + nchar(site_upper) - 1L
    results <- rbind(results, data.frame(
      start = abs_start, end = abs_end, strand = "+",
      match = substring(seq_upper, abs_start, abs_end),
      stringsAsFactors = FALSE
    ))
    pos <- abs_start + 1L
  }

  # Reverse strand (search for RC of site)
  if (site_upper != site_rc) {
    pos <- 1L
    while (pos <= nchar(seq_upper) - nchar(site_rc) + 1L) {
      hit <- regexpr(site_rc, substring(seq_upper, pos), fixed = TRUE)
      if (hit == -1L) break
      abs_start <- pos + hit - 1L
      abs_end <- abs_start + nchar(site_rc) - 1L
      results <- rbind(results, data.frame(
        start = abs_start, end = abs_end, strand = "-",
        match = substring(seq_upper, abs_start, abs_end),
        stringsAsFactors = FALSE
      ))
      pos <- abs_start + 1L
    }
  }

  results[order(results$start), , drop = FALSE]
}

#' Check if a sequence contains any enzyme recognition sites
#' @param seq Character DNA sequence
#' @param enzymes Character vector of enzyme names to check (default: BsaI, BsmBI, PaqCI)
#' @return Logical TRUE if any sites found
has_enzyme_sites <- function(seq, enzymes = c("BsaI", "BsmBI", "PaqCI")) {
  for (enz_name in enzymes) {
    enz <- ENZYMES[[enz_name]]
    if (nrow(find_enzyme_sites(seq, enz$recog)) > 0) {
      return(TRUE)
    }
  }
  FALSE
}

#' Check for homopolymer runs in a sequence
#' @param seq Character DNA sequence
#' @param max_run Maximum allowed homopolymer length
#' @return Logical TRUE if a run exceeding max_run is found
has_homopolymer <- function(seq, max_run = 4L) {
  pattern <- paste0("([ACGT])\\1{", max_run, ",}")
  grepl(pattern, toupper(seq))
}

#' Build an oriented enzyme site string for oligo construction
#'
#' Enzyme sites on oligos can be in "forward" or "reverse" orientation.
#' Forward: recognition_seq + spacer + overhang
#' Reverse: RC(overhang + spacer + recognition_seq) = RC(overhang) + RC(spacer) + RC(recognition)
#'
#' @param enzyme_name Name of enzyme (e.g., "BsmBI")
#' @param overhang 4-nt overhang sequence
#' @param orientation "forward" or "reverse"
#' @param spacer_seq Optional explicit spacer sequence. If NULL, uses "N" * spacer_len.
#' @return Character string of the complete oriented site
orient_enzyme_site <- function(enzyme_name, overhang, orientation = "forward",
                               spacer_seq = NULL) {
  enz <- ENZYMES[[enzyme_name]]
  if (is.null(spacer_seq)) {
    spacer_seq <- paste(rep("A", enz$spacer_len), collapse = "")
  }

  if (orientation == "forward") {
    # Site reads 5'->3': recognition + spacer + overhang
    # After cutting, overhang is left as 5' or 3' sticky end
    paste0(enz$recog, spacer_seq, overhang)
  } else {
    # Reverse orientation: put on opposite strand.
    # Use RC(overhang) so the exposed sticky end after digestion is complementary
    # to the forward site's overhang — required for Golden Gate ligation.
    # Result: starts with overhang, ends with RC(recognition).
    reverse_complement(paste0(enz$recog, spacer_seq, reverse_complement(overhang)))
  }
}

#' Extract codons from a coding sequence
#' @param cds Character string of coding DNA sequence (length divisible by 3)
#' @return Character vector of codons
extract_codons <- function(cds) {
  # Convert DNAString/S4 objects to plain character for base R string ops
  if (is(cds, "DNAString")) cds <- as.character(cds)
  n <- nchar(cds)
  if (n %% 3 != 0) stop("CDS length not divisible by 3")
  starts <- seq(1, n, by = 3)
  substring(cds, starts, starts + 2)
}

#' Replace a codon at a specific position in a CDS
#' @param cds Character string of coding DNA sequence
#' @param position Amino acid position (1-based)
#' @param new_codon Character string of new codon (3 nt)
#' @return Modified CDS string
replace_codon <- function(cds, position, new_codon) {
  start <- (position - 1L) * 3L + 1L
  end <- start + 2L
  paste0(
    substring(cds, 1, start - 1L),
    new_codon,
    substring(cds, end + 1L)
  )
}

#' Translate a codon to an amino acid using the standard genetic code
#' @param codon Character string (3 nt)
#' @return Single-letter amino acid code or "*" for stop
translate_codon <- function(codon) {
  result <- CODON_TABLE[[toupper(codon)]]
  if (is.null(result)) stop("Unknown codon: ", codon)
  result
}

#' Translate a full CDS to a protein sequence
#' @param cds Character string of coding DNA sequence
#' @return Character string of amino acid sequence
translate_cds <- function(cds) {
  codons <- extract_codons(toupper(cds))
  paste(vapply(codons, translate_codon, character(1)), collapse = "")
}

# ============================================================================
# Sub-step timing helpers (for verbose_timing mode)
# ============================================================================

#' Create a new timer object for sub-step profiling
#'
#' Returns a list that accumulates named timing entries. Use with timer_mark()
#' and timer_report() for fine-grained module profiling.
#'
#' @return A timer environment (list with start time and entries)
timer_start <- function() {
  list(
    t0 = proc.time()[["elapsed"]],
    last = proc.time()[["elapsed"]],
    entries = list()
  )
}

#' Record a timing checkpoint
#'
#' Marks the elapsed time since the last checkpoint (or timer creation).
#' Call this after each sub-step you want to profile.
#'
#' @param timer Timer object from timer_start()
#' @param label Human-readable label for this sub-step
#' @return Updated timer object (must be reassigned: timer <- timer_mark(timer, "label"))
timer_mark <- function(timer, label) {
  now <- proc.time()[["elapsed"]]
  elapsed <- now - timer$last
  timer$entries[[length(timer$entries) + 1L]] <- list(
    label = label,
    elapsed = elapsed
  )
  timer$last <- now
  timer
}

#' Print a formatted timing report via cli
#'
#' Emits one cli_alert_info line per sub-step, plus a total. Only call this
#' when verbose_timing is TRUE (callers should check before invoking).
#'
#' @param timer Timer object with accumulated entries
#' @param module_name Name of the module (used as header)
timer_report <- function(timer, module_name) {
  total <- proc.time()[["elapsed"]] - timer$t0
  cli::cli_alert_info("[timing] {module_name}: {round(total, 1)}s total")
  for (entry in timer$entries) {
    pct <- if (total > 0) round(entry$elapsed / total * 100, 1) else 0
    cli::cli_alert_info(
      "  {entry$label}: {round(entry$elapsed, 1)}s ({pct}%)"
    )
  }
}
