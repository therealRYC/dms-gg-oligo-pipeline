# Created: 2025-02-01
# Last updated: 2026-03-03 — Add include_synonymous config parameter
# 00_config.R — YAML config parsing, validation, defaults
# DMS Golden Gate Oligo Pipeline

#' Load and validate pipeline configuration from a YAML file
#' @param config_path Path to YAML config file
#' @return Named list of validated configuration parameters
load_config <- function(config_path) {
  if (!file.exists(config_path)) {
    stop("Config file not found: ", config_path)
  }

  cfg <- yaml::read_yaml(config_path)

  # --- Deprecation warning for ops_mode ---
  if (!is.null(cfg$ops_mode)) {
    cli::cli_alert_warning(
      "ops_mode is deprecated and ignored -- barcode generation now uses unified hierarchical mode"
    )
    cfg$ops_mode <- NULL
  }
  if (!is.null(cfg$barcode_capacity_tolerance)) {
    cli::cli_alert_warning(
      "barcode_capacity_tolerance is deprecated and ignored -- unified mode uses prefix-only Hamming guarantee"
    )
    cfg$barcode_capacity_tolerance <- NULL
  }

  # --- Apply defaults ---
  defaults <- list(
    max_oligo_length = 300L,
    max_geneblock_length = 1800L,
    min_geneblock_length = 300L,
    barcode_length = 20L,
    min_hamming_distance = 3L,
    barcode_prefix_length = 12L,
    barcode_gc_range = c(0.25, 0.75),
    barcode_max_homopolymer = 4L,
    search_window_K = 15L,
    dp_k_range = 5L,
    boundary_method = "dp",
    oogga_max_identity = 2L,
    oogga_beam_width = 10L,
    mc_iterations = 1000L,
    mc_temperature = 1.0,
    mc_cooling_rate = 0.995,
    multi_k_search = TRUE,
    barcodes_per_variant = 10L,
    overlap_codons = 4L,
    codon_table_path = NULL,
    include_synonymous = FALSE,
    auto_domesticate = TRUE,
    simulate_assembly = TRUE,
    simulation_samples_per_tile = 1L,
    output_dir = "output"
  )

  for (key in names(defaults)) {
    if (is.null(cfg[[key]])) {
      cfg[[key]] <- defaults[[key]]
    }
  }

  # Coerce types
  cfg$max_oligo_length <- as.integer(cfg$max_oligo_length)
  cfg$max_geneblock_length <- as.integer(cfg$max_geneblock_length)
  cfg$min_geneblock_length <- as.integer(cfg$min_geneblock_length)
  # barcode_length: handle "auto" sentinel
  if (is.character(cfg$barcode_length) && tolower(cfg$barcode_length) == "auto") {
    cfg$barcode_length <- "auto"
  } else {
    cfg$barcode_length <- as.integer(cfg$barcode_length)
  }
  cfg$min_hamming_distance <- as.integer(cfg$min_hamming_distance)
  cfg$barcode_prefix_length <- as.integer(cfg$barcode_prefix_length)
  cfg$barcode_max_homopolymer <- as.integer(cfg$barcode_max_homopolymer)
  cfg$barcode_gc_range <- as.numeric(cfg$barcode_gc_range)
  cfg$search_window_K <- as.integer(cfg$search_window_K)
  cfg$dp_k_range <- as.integer(cfg$dp_k_range %||% 5L)
  cfg$boundary_method <- as.character(cfg$boundary_method)
  cfg$oogga_max_identity <- as.integer(cfg$oogga_max_identity %||% 2L)
  cfg$oogga_beam_width <- as.integer(cfg$oogga_beam_width %||% 10L)
  cfg$mc_iterations <- as.integer(cfg$mc_iterations %||% 1000L)
  cfg$mc_temperature <- as.numeric(cfg$mc_temperature %||% 1.0)
  cfg$mc_cooling_rate <- as.numeric(cfg$mc_cooling_rate %||% 0.995)
  cfg$multi_k_search <- as.logical(cfg$multi_k_search)
  cfg$barcodes_per_variant <- as.integer(cfg$barcodes_per_variant)
  cfg$overlap_codons <- as.integer(cfg$overlap_codons)
  cfg$include_synonymous <- as.logical(cfg$include_synonymous)
  cfg$simulate_assembly <- as.logical(cfg$simulate_assembly)
  cfg$simulation_samples_per_tile <- as.integer(cfg$simulation_samples_per_tile)

  # --- Validate oh3 and oh4 ---
  # These are fixed BsmBI/BsaI overhangs used in the 3-enzyme assembly
  if (!is.null(cfg$oh3)) cfg$oh3 <- toupper(cfg$oh3)
  if (!is.null(cfg$oh4)) cfg$oh4 <- toupper(cfg$oh4)

  # --- Intergene elements: parse and build downstream cassette ---
  cfg <- build_downstream_cassette(cfg)

  # --- Validation ---
  validate_config(cfg)

  cfg
}

#' Parse intergene_elements and build the downstream cassette
#'
#' The downstream cassette is the full sequence placed between the gene 3' end
#' and the barcode in the BsmBI gene blocks:
#'   downstream_cassette = concat(intergene_elements) + polIII_promoter
#'
#' When intergene_elements is NULL or empty (the default), the cassette is just
#' the polIII_promoter — identical to the original pipeline behavior.
#'
#' @param cfg Config list (must already have polIII_promoter set)
#' @return Modified cfg with added fields:
#'   - intergene_elements: validated list of elements (may be empty list)
#'   - downstream_cassette: concatenated sequence string
#'   - intergene_concat: concatenated intergene-only sequence (empty string if none)
build_downstream_cassette <- function(cfg) {
  # Normalize intergene_elements
  if (is.null(cfg$intergene_elements)) {
    cfg$intergene_elements <- list()
  }

  # Validate each element has name and sequence
  if (length(cfg$intergene_elements) > 0) {
    for (i in seq_along(cfg$intergene_elements)) {
      elem <- cfg$intergene_elements[[i]]
      if (is.null(elem$name) || !nzchar(elem$name)) {
        stop("intergene_elements[[", i, "]] is missing a 'name' field")
      }
      if (is.null(elem$sequence) || !nzchar(elem$sequence)) {
        stop("intergene_elements[[", i, "]] ('", elem$name, "') is missing a 'sequence' field")
      }
      # Uppercase and validate DNA
      elem$sequence <- toupper(elem$sequence)
      if (grepl("[^ACGT]", elem$sequence)) {
        stop(
          "intergene_elements[[", i, "]] ('", elem$name,
          "') sequence contains non-ACGT characters"
        )
      }
      cfg$intergene_elements[[i]] <- elem
    }

    # Build concatenated intergene sequence
    intergene_seqs <- vapply(cfg$intergene_elements, function(e) e$sequence, character(1))
    cfg$intergene_concat <- paste0(intergene_seqs, collapse = "")

    element_names <- vapply(cfg$intergene_elements, function(e) e$name, character(1))
    cli::cli_alert_info(paste0(
      "Intergene elements: ", paste(element_names, collapse = " + "),
      " (", nchar(cfg$intergene_concat), " nt total)"
    ))
  } else {
    cfg$intergene_concat <- ""
  }

  # Build full downstream cassette: intergene elements + polIII promoter
  polIII <- cfg$polIII_promoter %||% ""
  cfg$downstream_cassette <- paste0(cfg$intergene_concat, polIII)

  cfg
}

#' Validate configuration parameters
#' @param cfg Named list of config parameters
#' @return Invisible NULL; stops on validation errors
validate_config <- function(cfg) {
  errors <- character(0)

  # Gene input: require exactly one of gene_fasta or gene_cds
  has_fasta <- !is.null(cfg$gene_fasta) && nzchar(cfg$gene_fasta)
  has_cds <- !is.null(cfg$gene_cds) && nzchar(cfg$gene_cds)
  if (has_fasta && has_cds) {
    errors <- c(errors, "Specify only one of gene_fasta or gene_cds (not both)")
  } else if (!has_fasta && !has_cds) {
    errors <- c(errors, "One of gene_fasta or gene_cds is required")
  } else if (has_fasta && !file.exists(cfg$gene_fasta)) {
    errors <- c(errors, paste("gene_fasta file not found:", cfg$gene_fasta))
  } else if (has_cds) {
    cds_upper <- toupper(cfg$gene_cds)
    if (grepl("[^ACGT]", cds_upper)) {
      errors <- c(errors, "gene_cds contains non-ACGT characters")
    }
    if (nchar(cds_upper) %% 3 != 0) {
      errors <- c(errors, paste0("gene_cds length (", nchar(cds_upper), ") is not divisible by 3"))
    }
  }

  # gene_name: optional override, must be filesystem-safe if provided
  if (!is.null(cfg$gene_name)) {
    if (!nzchar(cfg$gene_name)) {
      errors <- c(errors, "gene_name must be non-empty if provided")
    } else if (grepl('[/\\\\:*?"<>|]', cfg$gene_name)) {
      errors <- c(errors, "gene_name contains filesystem-unsafe characters (/\\:*?\"<>|)")
    }
  }

  # codon_table_path: optional custom codon usage table
  if (!is.null(cfg$codon_table_path) && nzchar(cfg$codon_table_path)) {
    if (!file.exists(cfg$codon_table_path)) {
      errors <- c(errors, paste("codon_table_path file not found:", cfg$codon_table_path))
    } else {
      ext <- tolower(tools::file_ext(cfg$codon_table_path))
      if (!ext %in% c("csv", "rds")) {
        errors <- c(errors, paste0(
          "codon_table_path must be a .csv or .rds file, got: .", ext
        ))
      }
    }
  }

  if (is.null(cfg$polIII_promoter) || !nzchar(cfg$polIII_promoter)) {
    errors <- c(errors, "polIII_promoter sequence is required")
  }

  if (is.null(cfg$paqci_star2) || cfg$paqci_star2 == "NNNN") {
    errors <- c(errors, "paqci_star2 overhang must be specified (not NNNN)")
  }
  if (is.null(cfg$paqci_star1) || cfg$paqci_star1 == "NNNN") {
    errors <- c(errors, "paqci_star1 overhang must be specified (not NNNN)")
  }

  # --- oh3 and oh4 validation (optional but validated if provided) ---
  for (oh_name in c("oh3", "oh4")) {
    if (!is.null(cfg[[oh_name]])) {
      oh_val <- cfg[[oh_name]]
      if (nchar(oh_val) != 4L || grepl("[^ACGT]", oh_val)) {
        errors <- c(errors, paste0(oh_name, " must be exactly 4 ACGT characters, got: ", oh_val))
      }
    }
  }
  # If both provided, check they're distinct and don't collide
  if (!is.null(cfg$oh3) && !is.null(cfg$oh4)) {
    if (cfg$oh3 == cfg$oh4) {
      errors <- c(errors, "oh3 and oh4 must be different sequences")
    }
    if (nchar(cfg$oh3) == 4 && nchar(cfg$oh4) == 4 &&
      !grepl("[^ACGT]", cfg$oh3) && !grepl("[^ACGT]", cfg$oh4)) {
      oh3_rc <- reverse_complement(cfg$oh3)
      oh4_rc <- reverse_complement(cfg$oh4)
      if (cfg$oh3 == oh4_rc || cfg$oh4 == oh3_rc) {
        errors <- c(errors, "oh3 and oh4 must not be reverse complements of each other")
      }
      # Check oh3/oh4 don't contain enzyme sites
      for (oh_name in c("oh3", "oh4")) {
        oh_val <- cfg[[oh_name]]
        for (enz_name in c("BsaI", "BsmBI", "PaqCI")) {
          if (grepl(ENZYMES[[enz_name]]$recog, oh_val, fixed = TRUE) ||
            grepl(ENZYMES[[enz_name]]$recog_rc, oh_val, fixed = TRUE)) {
            errors <- c(errors, paste0(oh_name, " contains ", enz_name, " recognition site"))
          }
        }
      }
    }
  }

  # Range checks
  if (cfg$max_oligo_length < 100 || cfg$max_oligo_length > 500) {
    errors <- c(errors, "max_oligo_length must be between 100 and 500")
  }

  # barcode_length: "auto" or 6-30
  if (identical(cfg$barcode_length, "auto")) {
    # "auto" is always valid in unified mode
  } else {
    if (cfg$barcode_length < 6 || cfg$barcode_length > 30) {
      errors <- c(errors, "barcode_length must be between 6 and 30 (or 'auto')")
    }
  }

  if (cfg$min_hamming_distance < 1) {
    errors <- c(errors, "min_hamming_distance must be >= 1")
  }
  if (!identical(cfg$barcode_length, "auto") &&
    cfg$min_hamming_distance > cfg$barcode_length) {
    errors <- c(errors, "min_hamming_distance must be <= barcode_length")
  }

  # prefix_length validation (always used in unified hierarchical mode)
  if (cfg$barcode_prefix_length < cfg$min_hamming_distance) {
    errors <- c(errors, "barcode_prefix_length must be >= min_hamming_distance")
  }
  if (!identical(cfg$barcode_length, "auto") &&
    cfg$barcode_prefix_length > cfg$barcode_length) {
    errors <- c(errors, "barcode_prefix_length must be <= barcode_length")
  }
  # prefix_length == barcode_length only valid when barcodes_per_variant == 1
  if (!identical(cfg$barcode_length, "auto") &&
    cfg$barcode_prefix_length >= cfg$barcode_length &&
    cfg$barcodes_per_variant > 1L) {
    errors <- c(
      errors,
      "barcode_prefix_length must be < barcode_length when barcodes_per_variant > 1 (suffix space needed for replicate barcodes)"
    )
  }

  if (length(cfg$barcode_gc_range) != 2 ||
    cfg$barcode_gc_range[1] >= cfg$barcode_gc_range[2]) {
    errors <- c(errors, "barcode_gc_range must be a 2-element vector [min, max] with min < max")
  }
  if (cfg$barcodes_per_variant < 1L) {
    errors <- c(errors, "barcodes_per_variant must be an integer >= 1")
  }

  if (length(errors) > 0) {
    stop("Configuration errors:\n  - ", paste(errors, collapse = "\n  - "))
  }

  invisible(NULL)
}
