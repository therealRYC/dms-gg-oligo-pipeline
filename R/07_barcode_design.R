# 07_barcode_design.R — Programmed barcodes with OPS / non-OPS mode support
# DMS Golden Gate Oligo Pipeline
#
# Two modes:
#   OPS mode (ops_mode=TRUE):  Prefix-first algorithm with hard prefix Hamming
#     distance and soft full-barcode tolerance. Supports auto-sizing barcode_length
#     to the minimum needed for the variant count.
#   Non-OPS mode (ops_mode=FALSE): Global hard Hamming distance guarantee.
#     No prefix/suffix splitting. Random+greedy generation for long barcodes.

# ============================================================================
# Capacity estimation helpers
# ============================================================================

#' Compute the Hamming ball volume V(n, t) over a 4-letter alphabet
#'
#' V(n, t) = sum_{i=0}^{t} choose(n, i) * 3^i
#' This is the number of sequences within Hamming distance t of any given sequence.
#'
#' @param n Sequence length
#' @param t Radius (typically floor((d-1)/2) for error-correction)
#' @return Numeric ball volume
hamming_ball_volume <- function(n, t) {
  vol <- 0
  for (i in 0:t) {
    vol <- vol + choose(n, i) * (3^i)
  }
  vol
}

#' Estimate barcode capacity for prefix-first generation (hard suffix constraint)
#'
#' Used by the original hard-constraint path and for backward-compatible capacity checks.
#'
#' @param prefix_length Prefix length
#' @param suffix_length Suffix length
#' @param min_hamming Minimum Hamming distance
#' @param filter_pass_rate Estimated filter pass rate (default 0.50)
#' @return Numeric estimated capacity
estimate_barcode_capacity <- function(prefix_length, suffix_length, min_hamming,
                                       filter_pass_rate = 0.50) {
  t_val <- floor((min_hamming - 1) / 2)

  max_prefixes <- floor(4^prefix_length / hamming_ball_volume(prefix_length, t_val))

  if (suffix_length == 0L) {
    max_suffixes <- 1
  } else {
    max_suffixes <- floor(4^suffix_length / hamming_ball_volume(suffix_length, t_val))
  }

  max_prefixes * max_suffixes * filter_pass_rate
}

#' Estimate OPS capacity with soft suffix constraint
#'
#' In OPS mode, suffixes are NOT required to have mutual Hamming distance.
#' Capacity = max_prefixes * (4^suffix_length * filter_pass_rate).
#' Also estimates the expected violation fraction for the soft Hamming constraint.
#'
#' @param prefix_length Prefix length
#' @param suffix_length Suffix length
#' @param min_hamming Minimum Hamming distance
#' @param filter_pass_rate Estimated filter pass rate (default 0.50)
#' @return List with capacity and expected_violation_fraction
estimate_ops_capacity <- function(prefix_length, suffix_length, min_hamming,
                                   filter_pass_rate = 0.50) {
  t_val <- floor((min_hamming - 1) / 2)
  max_prefixes <- floor(4^prefix_length / hamming_ball_volume(prefix_length, t_val))

  if (suffix_length == 0L) {
    # No suffix: each prefix IS a barcode; all pairs have distance >= min_hamming
    return(list(capacity = max_prefixes * filter_pass_rate,
                expected_violation_fraction = 0))
  }

  suffixes_per_prefix <- floor(4^suffix_length * filter_pass_rate)
  capacity <- max_prefixes * suffixes_per_prefix

  # Estimate violation fraction:
  # Cross-prefix pairs always have distance >= min_hamming (from prefix alone).
  # Within-prefix pairs have distance = suffix distance.
  # P(suffix_distance < min_hamming) = sum_{i=0}^{d-1} C(s,i)*3^i / 4^s
  prob_suffix_close <- 0
  for (i in 0:(min_hamming - 1L)) {
    if (i > suffix_length) break
    prob_suffix_close <- prob_suffix_close + choose(suffix_length, i) * (3^i)
  }
  prob_suffix_close <- prob_suffix_close / (4^suffix_length)

  # Fraction of within-prefix pairs ≈ 1/num_prefixes (for large pools)
  # Total pairs: N*(N-1)/2 where N = P * S
  # Within-prefix pairs: P * S*(S-1)/2
  # Fraction within: P*S*(S-1) / (P*S*(P*S-1)) ≈ (S-1) / (P*S - 1) ≈ 1/P for P >> 1
  P <- max_prefixes
  S <- suffixes_per_prefix
  if (P > 0 && S > 1) {
    frac_within <- (S - 1) / (P * S - 1)
    expected_violation <- frac_within * prob_suffix_close
  } else {
    expected_violation <- 0
  }

  list(capacity = capacity, expected_violation_fraction = expected_violation)
}

#' Auto-size barcode length for OPS mode
#'
#' Finds the minimum barcode_length = prefix_length + suffix_length such that:
#' 1. Estimated OPS capacity >= n_total
#' 2. Expected violation fraction <= (1 - tolerance)
#'
#' @param n_total Total barcodes needed
#' @param prefix_length Prefix length (fixed by OPS sequencing)
#' @param min_hamming Minimum Hamming distance
#' @param tolerance Fraction of pairs that must meet min_hamming (default 0.99)
#' @param filter_pass_rate Estimated filter pass rate (default 0.50)
#' @return Integer auto-sized barcode_length
auto_size_barcode_length <- function(n_total, prefix_length, min_hamming,
                                      tolerance = DEFAULT_BARCODE_CAPACITY_TOLERANCE,
                                      filter_pass_rate = 0.50) {
  max_violation <- 1 - tolerance

  for (suffix_length in 0:22L) {
    barcode_length <- prefix_length + suffix_length
    if (barcode_length > 30L) break
    if (barcode_length < 6L) next

    est <- estimate_ops_capacity(prefix_length, suffix_length, min_hamming,
                                  filter_pass_rate)

    if (est$capacity >= n_total &&
        est$expected_violation_fraction <= max_violation) {
      cli::cli_alert_success(paste0(
        "OPS auto-sizing: barcode_length=", barcode_length,
        " (prefix=", prefix_length, " + suffix=", suffix_length, ")",
        ", estimated capacity=", round(est$capacity),
        ", expected violation=", round(est$expected_violation_fraction * 100, 2), "%",
        ", need=", n_total
      ))
      return(as.integer(barcode_length))
    }
  }

  stop(
    "Cannot auto-size barcode length for ", n_total, " barcodes ",
    "with prefix_length=", prefix_length, ", min_hamming=", min_hamming,
    ", tolerance=", tolerance, ".\n",
    "Maximum barcode_length=30 is insufficient. ",
    "Consider reducing min_hamming_distance, increasing prefix_length, ",
    "or reducing barcodes_per_variant."
  )
}

# ============================================================================
# Main entry point
# ============================================================================

#' Design programmed barcodes for all variants
#'
#' Two modes:
#' - OPS mode: prefix-first algorithm with hard prefix Hamming distance and
#'   soft full-barcode tolerance. Auto-sizes barcode_length if "auto".
#' - Non-OPS mode: global hard Hamming distance. Random+greedy for long barcodes.
#'
#' @param n_variants Number of variants needing barcodes
#' @param barcode_length Total barcode length (integer or "auto" for OPS)
#' @param min_hamming Minimum Hamming distance (default 3)
#' @param prefix_length Prefix length for OPS optimization (default 8)
#' @param gc_range Numeric vector c(min, max) for GC content
#' @param max_homopolymer Maximum homopolymer run length (default 4)
#' @param barcodes_per_variant Number of barcodes per variant (default 1)
#' @param ops_mode Logical: use OPS mode? (default FALSE)
#' @param capacity_tolerance Soft Hamming tolerance for OPS mode (default 0.99)
#' @return List with barcodes, barcode_assignments, barcode_length, ops_mode,
#'   prefix_length, compliance_fraction
design_barcodes <- function(n_variants,
                            barcode_length = DEFAULT_BARCODE_LENGTH,
                            min_hamming = DEFAULT_MIN_HAMMING,
                            prefix_length = DEFAULT_PREFIX_LENGTH,
                            gc_range = DEFAULT_GC_RANGE,
                            max_homopolymer = DEFAULT_MAX_HOMOPOLYMER,
                            barcodes_per_variant = DEFAULT_BARCODES_PER_VARIANT,
                            ops_mode = DEFAULT_OPS_MODE,
                            capacity_tolerance = DEFAULT_BARCODE_CAPACITY_TOLERANCE) {

  n_total <- n_variants * barcodes_per_variant

  if (ops_mode) {
    result <- design_barcodes_ops(
      n_total, barcode_length, min_hamming, prefix_length,
      gc_range, max_homopolymer, capacity_tolerance
    )
  } else {
    result <- design_barcodes_standard(
      n_total, barcode_length, min_hamming,
      gc_range, max_homopolymer
    )
  }

  barcodes <- result$barcodes
  resolved_length <- result$barcode_length
  compliance <- result$compliance_fraction

  cli::cli_alert_success(paste0(
    "Generated ", n_total, " unique barcodes",
    " (mode=", if (ops_mode) "OPS" else "standard",
    ", length=", resolved_length, ")"
  ))
  if (ops_mode && !is.null(compliance)) {
    cli::cli_alert_info(paste0(
      "Hamming compliance: ", round(compliance * 100, 2),
      "% of pairs >= ", min_hamming,
      " (tolerance: ", capacity_tolerance * 100, "%)"
    ))
  }

  # Compute per-barcode nearest-neighbor Hamming distance
  cli::cli_alert("Computing per-barcode nearest-neighbor Hamming distances...")
  min_hamming_dist <- compute_min_hamming_per_barcode(barcodes)
  cli::cli_alert_success(paste0(
    "Nearest-neighbor distances: min=", min(min_hamming_dist),
    ", median=", median(min_hamming_dist),
    ", max=", max(min_hamming_dist)
  ))

  # Build assignment table
  barcode_assignments <- data.frame(
    variant_idx      = rep(seq_len(n_variants), each = barcodes_per_variant),
    barcode_idx      = rep(seq_len(barcodes_per_variant), times = n_variants),
    barcode          = barcodes,
    min_hamming_dist = min_hamming_dist,
    stringsAsFactors = FALSE
  )

  list(
    barcodes            = barcodes,
    barcode_assignments = barcode_assignments,
    min_hamming_dist    = min_hamming_dist,
    barcode_length      = resolved_length,
    ops_mode            = ops_mode,
    prefix_length       = if (ops_mode) prefix_length else NULL,
    compliance_fraction = compliance
  )
}

# ============================================================================
# OPS mode: prefix-first with soft full-barcode tolerance
# ============================================================================

#' Design barcodes in OPS mode (prefix-first, soft full-barcode constraint)
#'
#' @param n_total Total barcodes needed
#' @param barcode_length Integer or "auto"
#' @param min_hamming Minimum Hamming distance
#' @param prefix_length Prefix length
#' @param gc_range GC content range
#' @param max_homopolymer Max homopolymer
#' @param tolerance Soft Hamming tolerance
#' @return List with barcodes, barcode_length, compliance_fraction
design_barcodes_ops <- function(n_total, barcode_length, min_hamming,
                                 prefix_length, gc_range, max_homopolymer,
                                 tolerance) {

  # Auto-size if requested
  if (identical(barcode_length, "auto")) {
    barcode_length <- auto_size_barcode_length(
      n_total, prefix_length, min_hamming, tolerance
    )
  }

  suffix_length <- barcode_length - prefix_length

  cli::cli_alert_info(paste0(
    "OPS mode: generating barcodes (length=", barcode_length,
    ", prefix=", prefix_length, ", suffix=", suffix_length,
    ", min_hamming=", min_hamming,
    ", tolerance=", tolerance * 100, "%",
    ", need ", n_total, ")"
  ))

  # Capacity check (using OPS estimate with relaxed suffix)
  est <- estimate_ops_capacity(prefix_length, suffix_length, min_hamming)
  if (est$capacity < n_total) {
    stop("Insufficient OPS barcode capacity. Need ", n_total,
         " but estimated capacity is ~", round(est$capacity), ".\n",
         "  Try: increase barcode_length, decrease min_hamming_distance, ",
         "or decrease barcodes_per_variant.")
  }

  # Step 1: Generate prefixes with HARD Hamming distance
  cli::cli_alert("Generating prefix set (hard Hamming >= {min_hamming})...")
  prefixes <- generate_prefixes(prefix_length, min_hamming, n_total)

  # Step 2: Generate ALL valid suffixes (NO suffix Hamming constraint)
  # This is the key difference from the hard-constraint path.
  if (suffix_length > 0L) {
    all_suffixes <- generate_all_kmers(suffix_length)
    all_suffixes <- filter_sequences_fast(all_suffixes, max_homopolymer)
    cli::cli_alert_info(paste0(
      "Suffix pool (no Hamming constraint): ", length(all_suffixes),
      " valid ", suffix_length, "-mers"
    ))
  } else {
    all_suffixes <- ""
  }

  # Step 3: Combine prefixes with suffixes, filter full barcodes
  cli::cli_alert("Combining prefixes with suffixes and filtering...")
  barcodes <- generate_filtered_barcodes(
    prefixes, all_suffixes, gc_range, max_homopolymer, n_total
  )

  # Step 4: If not enough, expand prefix pool
  if (length(barcodes) < n_total) {
    cli::cli_alert_info("Expanding prefix pool with greedy generation...")
    extra_needed <- ceiling((n_total - length(barcodes)) /
                              max(1L, length(all_suffixes))) + 50L
    extra_prefixes <- generate_prefixes_greedy_excluding(
      prefix_length, min_hamming, extra_needed, prefixes
    )
    extra_barcodes <- generate_filtered_barcodes(
      extra_prefixes, all_suffixes, gc_range, max_homopolymer,
      n_total - length(barcodes)
    )
    barcodes <- c(barcodes, extra_barcodes)
  }

  if (length(barcodes) < n_total) {
    stop("Could only generate ", length(barcodes), " OPS barcodes, but need ", n_total,
         ". Try: increase barcode_length, decrease min_hamming_distance, ",
         "or decrease barcodes_per_variant.")
  }

  barcodes <- barcodes[seq_len(n_total)]

  # Step 5: Validate soft Hamming constraint
  compliance <- validate_barcode_distances_soft(
    barcodes, min_hamming, prefix_length, tolerance
  )

  list(barcodes = barcodes, barcode_length = barcode_length,
       compliance_fraction = compliance)
}

# ============================================================================
# Non-OPS mode: global hard Hamming distance
# ============================================================================

#' Design barcodes in standard mode (global hard Hamming distance)
#'
#' @param n_total Total barcodes needed
#' @param barcode_length Integer barcode length
#' @param min_hamming Minimum Hamming distance
#' @param gc_range GC content range
#' @param max_homopolymer Max homopolymer
#' @return List with barcodes, barcode_length, compliance_fraction
design_barcodes_standard <- function(n_total, barcode_length, min_hamming,
                                      gc_range, max_homopolymer) {

  cli::cli_alert_info(paste0(
    "Standard mode: generating barcodes (length=", barcode_length,
    ", min_hamming=", min_hamming,
    ", need ", n_total, ")"
  ))

  if (barcode_length <= 10L) {
    # Small enough to enumerate all k-mers (4^10 = ~1M, manageable)
    barcodes <- generate_barcodes_enumerated(
      n_total, barcode_length, min_hamming, gc_range, max_homopolymer
    )
  } else {
    # Too large for full enumeration; use random+greedy
    barcodes <- generate_barcodes_global(
      n_total, barcode_length, min_hamming, gc_range, max_homopolymer
    )
  }

  # Validate with full hard constraint (no prefix structure)
  validate_barcode_distances(barcodes, min_hamming, prefix_length = NULL)

  list(barcodes = barcodes, barcode_length = barcode_length,
       compliance_fraction = 1.0)
}

#' Generate barcodes via full enumeration + greedy selection (for short barcodes)
#'
#' @param n_total Number of barcodes needed
#' @param barcode_length Barcode length (<= 10, to keep 4^k manageable)
#' @param min_hamming Minimum Hamming distance
#' @param gc_range GC content range
#' @param max_homopolymer Max homopolymer
#' @return Character vector of barcodes
generate_barcodes_enumerated <- function(n_total, barcode_length, min_hamming,
                                          gc_range, max_homopolymer) {
  # Generate all k-mers and pre-filter
  all_kmers <- generate_all_kmers(barcode_length)
  all_kmers <- sample(all_kmers)  # shuffle for randomness
  all_kmers <- filter_sequences_fast(all_kmers, max_homopolymer)

  # GC filter
  gc_counts <- nchar(gsub("[AT]", "", all_kmers))
  gc_vals <- gc_counts / barcode_length
  all_kmers <- all_kmers[gc_vals >= gc_range[1] & gc_vals <= gc_range[2]]

  if (length(all_kmers) == 0) {
    stop("No valid barcodes after filtering. Try relaxing GC or homopolymer constraints.")
  }

  # Greedy selection with hard Hamming distance
  k <- barcode_length
  n_cand <- length(all_kmers)
  cand_mat <- matrix(unlist(lapply(all_kmers, utf8ToInt)),
                     nrow = k, ncol = n_cand)

  selected <- character(0)
  sel_mat <- matrix(integer(0), nrow = k, ncol = 0)

  for (i in seq_len(n_cand)) {
    q_int <- cand_mat[, i]
    if (ncol(sel_mat) == 0) {
      selected <- all_kmers[i]
      sel_mat <- matrix(q_int, nrow = k, ncol = 1)
      next
    }
    dists <- as.integer(colSums(sel_mat != q_int))
    if (all(dists >= min_hamming)) {
      selected <- c(selected, all_kmers[i])
      sel_mat <- cbind(sel_mat, q_int)
    }
    if (length(selected) >= n_total) break
  }

  if (length(selected) < n_total) {
    stop("Could only generate ", length(selected), " barcodes with Hamming >= ",
         min_hamming, ", need ", n_total,
         ". Try: increase barcode_length or decrease min_hamming_distance.")
  }

  selected[seq_len(n_total)]
}

#' Generate barcodes via random sampling + greedy selection (for long barcodes)
#'
#' @param n_total Number of barcodes needed
#' @param barcode_length Barcode length (> 12)
#' @param min_hamming Minimum Hamming distance
#' @param gc_range GC content range
#' @param max_homopolymer Max homopolymer
#' @return Character vector of barcodes
generate_barcodes_global <- function(n_total, barcode_length, min_hamming,
                                      gc_range, max_homopolymer) {
  target <- n_total
  batch_size <- 100000L
  max_attempts <- 50L
  k <- barcode_length

  selected <- character(0)
  sel_mat <- matrix(integer(0), nrow = k, ncol = 0)

  for (attempt in seq_len(max_attempts)) {
    if (length(selected) >= target) break

    # Generate random candidate barcodes
    candidates <- vapply(seq_len(batch_size), function(x) {
      paste0(sample(c("A", "C", "G", "T"), k, replace = TRUE), collapse = "")
    }, character(1))
    candidates <- unique(candidates)

    # Pre-filter
    candidates <- filter_sequences_fast(candidates, max_homopolymer)
    if (length(candidates) == 0) next

    gc_counts <- nchar(gsub("[AT]", "", candidates))
    gc_vals <- gc_counts / k
    candidates <- candidates[gc_vals >= gc_range[1] & gc_vals <= gc_range[2]]
    if (length(candidates) == 0) next

    # Greedy selection against existing set
    cand_mat <- matrix(unlist(lapply(candidates, utf8ToInt)),
                       nrow = k, ncol = length(candidates))

    for (i in seq_len(ncol(cand_mat))) {
      q_int <- cand_mat[, i]
      if (ncol(sel_mat) == 0) {
        selected <- candidates[i]
        sel_mat <- matrix(q_int, nrow = k, ncol = 1)
        next
      }
      dists <- as.integer(colSums(sel_mat != q_int))
      if (all(dists >= min_hamming)) {
        selected <- c(selected, candidates[i])
        sel_mat <- cbind(sel_mat, q_int)
      }
      if (length(selected) >= target) break
    }

    if (attempt %% 10 == 0) {
      cli::cli_alert_info(paste0(
        "Random+greedy progress: ", length(selected), "/", target,
        " barcodes after ", attempt, " rounds"
      ))
    }
  }

  if (length(selected) < target) {
    stop("Could only generate ", length(selected),
         " barcodes with global Hamming >= ", min_hamming,
         ", need ", target,
         ". Try: increase barcode_length or decrease min_hamming_distance.")
  }

  selected[seq_len(target)]
}

# ============================================================================
# Prefix/suffix generation helpers (shared with OPS mode)
# ============================================================================

#' Select a maximal greedy group of suffixes with mutual Hamming distance >= d
#' @param suffixes Character vector of all possible suffixes
#' @param min_hamming Minimum Hamming distance
#' @return Character vector of selected suffixes
select_suffix_group <- function(suffixes, min_hamming) {
  selected <- character(0)
  for (s in suffixes) {
    if (length(selected) == 0) {
      selected <- s
      next
    }
    ok <- TRUE
    for (sel in selected) {
      if (hamming_distance(s, sel) < min_hamming) {
        ok <- FALSE
        break
      }
    }
    if (ok) selected <- c(selected, s)
  }
  selected
}

#' Check whether enough barcodes can be generated (hard-constraint estimate)
#'
#' @param n_needed Total barcodes needed
#' @param prefix_length Prefix length
#' @param suffix_length Suffix length
#' @param min_hamming Minimum Hamming distance
#' @param gc_range GC content range
#' @param max_homopolymer Max homopolymer
#' @param barcodes_per_variant Barcodes per variant
check_barcode_capacity <- function(n_needed, prefix_length, suffix_length, min_hamming,
                                    gc_range, max_homopolymer, barcodes_per_variant) {
  estimated_capacity <- estimate_barcode_capacity(
    prefix_length, suffix_length, min_hamming, filter_pass_rate = 0.50
  )

  if (estimated_capacity < n_needed) {
    t_val <- floor((min_hamming - 1) / 2)
    max_prefixes <- floor(4^prefix_length / hamming_ball_volume(prefix_length, t_val))
    max_suffixes <- if (suffix_length == 0L) 1 else {
      floor(4^suffix_length / hamming_ball_volume(suffix_length, t_val))
    }
    stop(
      "Insufficient barcode capacity. Need ", n_needed, " barcodes",
      " but estimated capacity is ~", round(estimated_capacity), ".\n",
      "  Max prefixes (prefix_length=", prefix_length, ", min_hamming=", min_hamming, "): ~", max_prefixes, "\n",
      "  Max suffixes per group (suffix_length=", suffix_length, ", min_hamming=", min_hamming, "): ~", max_suffixes, "\n",
      "  Estimated pass rate: 50%\n",
      "  Suggestions: increase barcode_length, decrease min_hamming_distance",
      if (barcodes_per_variant > 1) paste0(", or decrease barcodes_per_variant (currently ", barcodes_per_variant, ")") else ""
    )
  }
}

#' Generate prefix sequences with guaranteed Hamming distance
#'
#' @param k Prefix length
#' @param min_hamming Minimum Hamming distance
#' @param n_needed Approximate number of prefixes needed
#' @return Character vector of prefix sequences
generate_prefixes <- function(k, min_hamming, n_needed) {
  prefixes <- generate_prefixes_greedy(k, min_hamming, n_needed)

  # Filter out prefixes with enzyme sites or extreme composition
  prefixes <- filter_sequences_fast(prefixes, DEFAULT_MAX_HOMOPOLYMER)

  if (length(prefixes) == 0) {
    stop("No valid prefixes generated. Try different parameters.")
  }

  cli::cli_alert_info(paste0("Generated ", length(prefixes), " valid prefixes."))
  prefixes
}

#' Greedy prefix generation (vectorized)
#' @param k Prefix length
#' @param min_hamming Minimum Hamming distance
#' @param n_needed Number needed
#' @return Character vector of prefixes
generate_prefixes_greedy <- function(k, min_hamming, n_needed) {
  all_kmers <- generate_all_kmers(k)
  # Shuffle for randomness
  all_kmers <- sample(all_kmers)
  # Pre-filter enzyme sites and homopolymers (vectorized)
  all_kmers <- filter_sequences_fast(all_kmers, DEFAULT_MAX_HOMOPOLYMER)

  # Pre-compute integer matrix for all candidates
  n_cand <- length(all_kmers)
  cand_mat <- matrix(unlist(lapply(all_kmers, utf8ToInt)),
                     nrow = k, ncol = n_cand)

  target <- n_needed * 2L  # Get extra margin
  selected <- character(0)
  sel_mat <- matrix(integer(0), nrow = k, ncol = 0)

  for (i in seq_len(n_cand)) {
    q_int <- cand_mat[, i]
    if (ncol(sel_mat) == 0) {
      selected <- all_kmers[i]
      sel_mat <- matrix(q_int, nrow = k, ncol = 1)
      next
    }
    dists <- as.integer(colSums(sel_mat != q_int))
    if (all(dists >= min_hamming)) {
      selected <- c(selected, all_kmers[i])
      sel_mat <- cbind(sel_mat, q_int)
    }
    if (length(selected) >= target) break
  }
  selected
}

#' Greedy prefix generation excluding known prefixes (vectorized)
#'
#' @param k Prefix length
#' @param min_hamming Minimum Hamming distance
#' @param n_needed Number of additional prefixes needed
#' @param existing_prefixes Prefixes already in use
#' @return Character vector of new prefixes
generate_prefixes_greedy_excluding <- function(k, min_hamming, n_needed, existing_prefixes) {
  all_kmers <- generate_all_kmers(k)
  all_kmers <- setdiff(all_kmers, existing_prefixes)
  all_kmers <- sample(all_kmers)

  # Pre-filter for enzyme sites and homopolymers (vectorized)
  all_kmers <- filter_sequences_fast(all_kmers, DEFAULT_MAX_HOMOPOLYMER)

  n_cand <- length(all_kmers)
  if (n_cand == 0) {
    cli::cli_alert_info("Generated 0 additional prefixes.")
    return(character(0))
  }

  # Convert all candidates to integer matrix (k x n_cand)
  cand_mat <- matrix(unlist(lapply(all_kmers, utf8ToInt)),
                     nrow = k, ncol = n_cand)

  # Compute minimum distance to existing prefixes for each candidate
  min_dist <- rep(as.integer(k), n_cand)
  for (ep in existing_prefixes) {
    ref <- utf8ToInt(ep)
    dists <- as.integer(colSums(cand_mat != ref))
    min_dist <- pmin(min_dist, dists)
  }

  # Only keep candidates with min_dist >= min_hamming to existing set
  valid <- which(min_dist >= min_hamming)
  if (length(valid) == 0) {
    cli::cli_alert_info("Generated 0 additional prefixes.")
    return(character(0))
  }

  # Greedy selection from valid candidates
  new_selected <- character(0)
  sel_ints <- list()

  for (idx in valid) {
    q_int <- cand_mat[, idx]

    ok <- TRUE
    for (s_int in sel_ints) {
      if (sum(q_int != s_int) < min_hamming) {
        ok <- FALSE
        break
      }
    }
    if (ok) {
      new_selected <- c(new_selected, all_kmers[idx])
      sel_ints[[length(sel_ints) + 1L]] <- q_int
    }
    if (length(new_selected) >= n_needed) break
  }

  cli::cli_alert_info(paste0("Generated ", length(new_selected), " additional prefixes."))
  new_selected
}

#' Generate filtered barcodes by combining prefixes with suffixes (vectorized)
#'
#' @param prefixes Character vector of prefix sequences
#' @param suffix_group Character vector of valid suffix sequences
#' @param gc_range GC content range c(min, max)
#' @param max_homopolymer Maximum homopolymer run length
#' @param n_needed Maximum barcodes to return
#' @return Character vector of valid barcodes
generate_filtered_barcodes <- function(prefixes, suffix_group, gc_range,
                                       max_homopolymer, n_needed) {
  # Generate all combinations
  all_bcs <- as.vector(outer(prefixes, suffix_group, paste0))

  # Vectorized filtering
  # 1. Enzyme sites and homopolymers
  all_bcs <- filter_sequences_fast(all_bcs, max_homopolymer)

  # 2. GC content (vectorized using gsub)
  gc_counts <- nchar(gsub("[AT]", "", all_bcs))
  total_len <- nchar(all_bcs)
  gc_vals <- gc_counts / total_len
  all_bcs <- all_bcs[gc_vals >= gc_range[1] & gc_vals <= gc_range[2]]

  # Return up to n_needed
  if (length(all_bcs) > n_needed) all_bcs <- all_bcs[seq_len(n_needed)]
  all_bcs
}

# ============================================================================
# Filtering and k-mer helpers
# ============================================================================

#' Fast vectorized filter for enzyme sites and homopolymers
#'
#' @param seqs Character vector of sequences
#' @param max_homopolymer Maximum allowed homopolymer run
#' @return Filtered character vector
filter_sequences_fast <- function(seqs, max_homopolymer = 4L) {
  bad <- rep(FALSE, length(seqs))
  for (enz_name in names(ENZYMES)) {
    enz <- ENZYMES[[enz_name]]
    bad <- bad | grepl(enz$recog, seqs, fixed = TRUE) |
                 grepl(enz$recog_rc, seqs, fixed = TRUE)
  }
  homo_pattern <- paste0("([ACGT])\\1{", max_homopolymer, ",}")
  bad <- bad | grepl(homo_pattern, seqs)
  seqs[!bad]
}

#' Generate all DNA k-mers
#' @param k Length of k-mer
#' @return Character vector of all 4^k k-mers
generate_all_kmers <- function(k) {
  if (k == 0) return("")
  bases <- c("A", "C", "G", "T")
  kmers <- bases
  if (k == 1) return(kmers)
  for (i in 2:k) {
    kmers <- as.vector(outer(kmers, bases, paste0))
  }
  kmers
}

#' Check if a barcode passes all filters
#' @param bc Barcode sequence
#' @param gc_range GC content range c(min, max)
#' @param max_homopolymer Max homopolymer run
#' @return Logical
passes_barcode_filters <- function(bc, gc_range, max_homopolymer) {
  gc <- gc_content(bc)
  if (gc < gc_range[1] || gc > gc_range[2]) return(FALSE)
  if (has_homopolymer(bc, max_homopolymer)) return(FALSE)
  if (has_enzyme_sites(bc)) return(FALSE)
  TRUE
}

# ============================================================================
# Hamming distance helpers
# ============================================================================

#' Calculate Hamming distance between two equal-length strings
#' @param a Character string
#' @param b Character string
#' @return Integer Hamming distance
hamming_distance <- function(a, b) {
  sum(utf8ToInt(a) != utf8ToInt(b))
}

#' Calculate Hamming distances from one string to a vector of strings
#' @param query Single character string
#' @param targets Character vector of strings (all same length as query)
#' @return Integer vector of Hamming distances
hamming_distance_1_to_many <- function(query, targets) {
  q_int <- utf8ToInt(query)
  k <- length(q_int)
  n <- length(targets)
  t_int <- matrix(unlist(lapply(targets, utf8ToInt)), nrow = k, ncol = n)
  as.integer(colSums(t_int != q_int))
}

# ============================================================================
# Per-barcode nearest-neighbor Hamming distance
# ============================================================================

#' Compute the minimum Hamming distance to the nearest neighbor for each barcode
#'
#' For each barcode, finds the closest other barcode and returns that distance.
#' Uses vectorized integer-matrix comparisons for speed.
#'
#' @param barcodes Character vector of equal-length barcode sequences
#' @return Integer vector of the same length as barcodes, where each element
#'   is the minimum Hamming distance from that barcode to any other barcode
compute_min_hamming_per_barcode <- function(barcodes) {
  n <- length(barcodes)
  if (n <= 1L) return(rep(NA_integer_, n))

  k <- nchar(barcodes[1])
  bc_mat <- matrix(unlist(lapply(barcodes, utf8ToInt)), nrow = k, ncol = n)
  min_dists <- rep(as.integer(k), n)

  for (i in seq_len(n - 1L)) {
    dists <- as.integer(colSums(bc_mat[, (i + 1L):n, drop = FALSE] != bc_mat[, i]))
    # Update barcode i
    if (min(dists) < min_dists[i]) min_dists[i] <- min(dists)
    # Update each j > i
    j_idxs <- (i + 1L):n
    improved <- dists < min_dists[j_idxs]
    if (any(improved)) {
      min_dists[j_idxs[improved]] <- dists[improved]
    }
  }

  min_dists
}

# ============================================================================
# Validation
# ============================================================================

#' Validate that all barcodes have minimum pairwise Hamming distance (hard)
#'
#' Uses prefix-group validation when prefix_length is known.
#' Errors on any violation.
#'
#' @param barcodes Character vector of barcodes
#' @param min_hamming Minimum required Hamming distance
#' @param prefix_length Length of the prefix used during generation (or NULL)
validate_barcode_distances <- function(barcodes, min_hamming, prefix_length = NULL) {
  n <- length(barcodes)
  if (n <= 1) return(invisible(NULL))

  barcode_len <- nchar(barcodes[1])

  # Use prefix-group validation if prefix_length is known and < barcode_len
  if (!is.null(prefix_length) && prefix_length > 0 &&
      prefix_length < barcode_len) {
    prefixes <- substring(barcodes, 1, prefix_length)
    prefix_groups <- split(seq_len(n), prefixes)

    violations <- character(0)
    for (group_name in names(prefix_groups)) {
      idxs <- prefix_groups[[group_name]]
      ng <- length(idxs)
      if (ng < 2) next
      for (i in seq_len(ng - 1L)) {
        for (j in (i + 1L):ng) {
          d <- hamming_distance(barcodes[idxs[i]], barcodes[idxs[j]])
          if (d < min_hamming) {
            violations <- c(violations, paste0(
              barcodes[idxs[i]], " vs ", barcodes[idxs[j]], " (d=", d, ")"
            ))
          }
        }
      }
    }

    if (length(violations) > 0) {
      stop("Barcode Hamming distance violations (min_hamming=", min_hamming, "):\n  ",
           paste(head(violations, 5), collapse = "\n  "),
           if (length(violations) > 5) paste0("\n  ... and ", length(violations) - 5, " more") else "")
    }

    cli::cli_alert_success("Barcode distance validation passed (prefix-group check).")
  } else {
    # Full pairwise check
    if (n > 5000) {
      cli::cli_alert_info("Large barcode set; performing sampled check...")
      n_checks <- min(50000L, as.integer(n) * (as.integer(n) - 1L) / 2L)
      for (k_check in seq_len(n_checks)) {
        ij <- sample(n, 2)
        d <- hamming_distance(barcodes[ij[1]], barcodes[ij[2]])
        if (d < min_hamming) {
          stop("Barcode Hamming distance violation: ",
               barcodes[ij[1]], " vs ", barcodes[ij[2]],
               " (distance=", d, ", min=", min_hamming, ")")
        }
      }
      cli::cli_alert_success("Sampled barcode distance check passed.")
    } else {
      min_found <- Inf
      for (i in seq_len(n - 1)) {
        for (j in (i + 1):n) {
          d <- hamming_distance(barcodes[i], barcodes[j])
          if (d < min_found) min_found <- d
          if (d < min_hamming) {
            stop("Barcode Hamming distance violation: ",
                 barcodes[i], " vs ", barcodes[j],
                 " (distance=", d, ", min=", min_hamming, ")")
          }
        }
      }
      cli::cli_alert_info(paste0("Minimum pairwise Hamming distance: ", min_found))
    }
  }

  invisible(NULL)
}

#' Validate barcodes with soft Hamming constraint (OPS mode)
#'
#' Cross-prefix pairs are guaranteed to have distance >= min_hamming (from prefix
#' Hamming distance alone). Within-prefix pairs may violate since the suffix
#' constraint is relaxed. Checks that the fraction of compliant pairs >= tolerance.
#'
#' @param barcodes Character vector of barcodes
#' @param min_hamming Minimum Hamming distance
#' @param prefix_length Prefix length
#' @param tolerance Required fraction of compliant pairs
#' @return Numeric compliance fraction
validate_barcode_distances_soft <- function(barcodes, min_hamming, prefix_length,
                                             tolerance) {
  n <- length(barcodes)
  if (n <= 1) return(1.0)

  barcode_len <- nchar(barcodes[1])
  prefixes <- substring(barcodes, 1, prefix_length)
  prefix_groups <- split(seq_len(n), prefixes)

  # Count violations within prefix groups (cross-prefix pairs are always OK)
  n_violations <- 0L
  n_within_pairs <- 0L

  for (group_name in names(prefix_groups)) {
    idxs <- prefix_groups[[group_name]]
    ng <- length(idxs)
    if (ng < 2) next
    n_within_pairs <- n_within_pairs + ng * (ng - 1L) / 2L

    # For large groups, use vectorized distance computation
    if (ng > 50) {
      group_bcs <- barcodes[idxs]
      k <- barcode_len
      bc_mat <- matrix(unlist(lapply(group_bcs, utf8ToInt)),
                       nrow = k, ncol = ng)
      for (i in seq_len(ng - 1L)) {
        dists <- as.integer(colSums(bc_mat[, (i + 1L):ng, drop = FALSE] != bc_mat[, i]))
        n_violations <- n_violations + sum(dists < min_hamming)
      }
    } else {
      for (i in seq_len(ng - 1L)) {
        for (j in (i + 1L):ng) {
          d <- hamming_distance(barcodes[idxs[i]], barcodes[idxs[j]])
          if (d < min_hamming) n_violations <- n_violations + 1L
        }
      }
    }
  }

  # Total pairs = n*(n-1)/2
  total_pairs <- as.numeric(n) * (as.numeric(n) - 1) / 2
  # Cross-prefix pairs are all compliant
  n_cross_pairs <- total_pairs - n_within_pairs
  n_compliant <- n_cross_pairs + (n_within_pairs - n_violations)
  compliance_fraction <- n_compliant / total_pairs

  cli::cli_alert_info(paste0(
    "Soft Hamming validation: ", n_violations, " violations in ",
    n_within_pairs, " within-prefix pairs (",
    total_pairs, " total pairs). Compliance: ",
    round(compliance_fraction * 100, 2), "%"
  ))

  if (compliance_fraction < tolerance) {
    stop(
      "Barcode soft Hamming constraint not met. Compliance: ",
      round(compliance_fraction * 100, 2), "%, required: ",
      tolerance * 100, "%.\n",
      "  Violations: ", n_violations, " pairs below min_hamming=", min_hamming, "\n",
      "  Try: increase barcode_length, decrease barcodes_per_variant, ",
      "or lower barcode_capacity_tolerance."
    )
  }

  cli::cli_alert_success(paste0(
    "Soft Hamming constraint met: ",
    round(compliance_fraction * 100, 2), "% >= ",
    tolerance * 100, "% threshold"
  ))

  compliance_fraction
}
