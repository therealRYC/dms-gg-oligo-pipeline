# Created: 2025-02-01
# Last updated: 2026-02-21 — Add simulate_assembly and simulation_samples_per_tile config options
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
    max_oligo_length         = 300L,
    max_geneblock_length     = 1800L,
    barcode_length           = 20L,
    min_hamming_distance     = 3L,
    barcode_prefix_length    = 12L,
    barcode_gc_range         = c(0.25, 0.75),
    barcode_max_homopolymer  = 4L,
    overhang_fidelity_threshold = 0.95,
    search_window_K          = 15L,
    boundary_method          = "dp",
    multi_k_search           = TRUE,
    barcodes_per_variant     = 10L,
    auto_domesticate         = TRUE,
    simulate_assembly        = FALSE,
    simulation_samples_per_tile = 1L,
    output_dir               = "output"
  )

  for (key in names(defaults)) {
    if (is.null(cfg[[key]])) {
      cfg[[key]] <- defaults[[key]]
    }
  }

  # Coerce types
  cfg$max_oligo_length      <- as.integer(cfg$max_oligo_length)
  cfg$max_geneblock_length  <- as.integer(cfg$max_geneblock_length)
  # barcode_length: handle "auto" sentinel
  if (is.character(cfg$barcode_length) && tolower(cfg$barcode_length) == "auto") {
    cfg$barcode_length <- "auto"
  } else {
    cfg$barcode_length <- as.integer(cfg$barcode_length)
  }
  cfg$min_hamming_distance  <- as.integer(cfg$min_hamming_distance)
  cfg$barcode_prefix_length <- as.integer(cfg$barcode_prefix_length)
  cfg$barcode_max_homopolymer <- as.integer(cfg$barcode_max_homopolymer)
  cfg$barcode_gc_range      <- as.numeric(cfg$barcode_gc_range)
  cfg$overhang_fidelity_threshold <- as.numeric(cfg$overhang_fidelity_threshold)
  cfg$search_window_K       <- as.integer(cfg$search_window_K)
  cfg$boundary_method       <- as.character(cfg$boundary_method)
  cfg$multi_k_search        <- as.logical(cfg$multi_k_search)
  cfg$barcodes_per_variant  <- as.integer(cfg$barcodes_per_variant)
  cfg$simulate_assembly     <- as.logical(cfg$simulate_assembly)
  cfg$simulation_samples_per_tile <- as.integer(cfg$simulation_samples_per_tile)

  # --- Validate oh3 and oh4 ---
  # These are fixed BsmBI/BsaI overhangs used in the 3-enzyme assembly
  if (!is.null(cfg$oh3)) cfg$oh3 <- toupper(cfg$oh3)
  if (!is.null(cfg$oh4)) cfg$oh4 <- toupper(cfg$oh4)

  # --- Validation ---
  validate_config(cfg)

  cfg
}

#' Validate configuration parameters
#' @param cfg Named list of config parameters
#' @return Invisible NULL; stops on validation errors
validate_config <- function(cfg) {
  errors <- character(0)

  # Gene input: require exactly one of gene_fasta or gene_cds
  has_fasta <- !is.null(cfg$gene_fasta) && nzchar(cfg$gene_fasta)
  has_cds   <- !is.null(cfg$gene_cds) && nzchar(cfg$gene_cds)
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
    errors <- c(errors,
      "barcode_prefix_length must be < barcode_length when barcodes_per_variant > 1 (suffix space needed for replicate barcodes)")
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
