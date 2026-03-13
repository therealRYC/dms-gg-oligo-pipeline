# Created: 2025-02-01
# Last updated: 2026-02-22 — Replace greedy prefix generation with GF(4) linear code + DNABarcodes lexicode;
#   vectorize suffix generation; skip validation for algebraically-guaranteed codes
# 07_barcode_design.R — Programmed barcodes with unified hierarchical prefix-suffix design
# DMS Golden Gate Oligo Pipeline
#
# Architecture:
#   barcode = prefix(p nt) + suffix(L-p nt)
#   - One unique prefix per VARIANT (not per barcode)
#   - Each variant's barcodes_per_variant barcodes share the same prefix, different random suffixes
#   - All prefix pairs have d >= min_hamming (hard guarantee)
#   - Suffixes are random, filtered only for: enzyme sites, homopolymers, GC (no pairwise d)
#   - Cross-variant pairs: d(full) >= d(prefix) >= min_hamming
#   - Within-variant pairs: d(full) = d(suffix) = random (OK — same variant)
#
# Prefix generation strategy (ordered by priority):
#   1. GF(4) shortened Hamming code (d <= 3): deterministic, maximum capacity, O(n) per codeword
#   2. DNABarcodes lexicode (any d): Conway heuristic first, Ashlock fallback for larger sets
#   3. Error: impossible parameters

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

#' Estimate prefix capacity for a given prefix_length and min_hamming
#'
#' Uses the sphere-packing (Hamming) bound: max_prefixes = 4^k / V(k, t)
#' where t = floor((d-1)/2), then applies a filter_pass_rate discount.
#'
#' @param prefix_length Prefix length
#' @param min_hamming Minimum Hamming distance
#' @param filter_pass_rate Estimated filter pass rate (default 0.50)
#' @return Numeric estimated number of usable prefixes
estimate_prefix_capacity <- function(prefix_length, min_hamming,
                                      filter_pass_rate = 0.50) {
  t_val <- floor((min_hamming - 1) / 2)
  V <- hamming_ball_volume(prefix_length, t_val)
  max_prefixes <- floor(4^prefix_length / V)
  floor(max_prefixes * filter_pass_rate)
}

#' Check prefix feasibility and auto-adjust min_hamming if needed
#'
#' Tries the requested min_hamming first. If prefix capacity is insufficient,
#' reduces min_hamming down to min_hamming_floor, warning on each reduction.
#' Errors if even the floor can't accommodate n_variants.
#'
#' @param n_variants Number of unique prefixes needed (one per variant)
#' @param prefix_length Prefix length
#' @param min_hamming Requested minimum Hamming distance
#' @param min_hamming_floor Lowest acceptable min_hamming (default 2)
#' @param filter_pass_rate Estimated filter pass rate (default 0.50)
#' @return Integer effective min_hamming to use
check_prefix_feasibility <- function(n_variants, prefix_length, min_hamming,
                                      min_hamming_floor = DEFAULT_MIN_HAMMING_FLOOR,
                                      filter_pass_rate = 0.50) {
  for (d in seq(min_hamming, min_hamming_floor, by = -1L)) {
    estimated <- estimate_prefix_capacity(prefix_length, d, filter_pass_rate)
    if (estimated >= n_variants) {
      if (d < min_hamming) {
        cli::cli_alert_warning(paste0(
          "Reduced min_hamming_distance from ", min_hamming, " to ", d,
          " to accommodate ", n_variants, " variants",
          " (prefix_length=", prefix_length, ", est. capacity=", estimated, ")"
        ))
      }
      return(as.integer(d))
    }
  }
  # Even d=min_hamming_floor can't accommodate — error
  estimated <- estimate_prefix_capacity(prefix_length, min_hamming_floor,
                                         filter_pass_rate)
  stop("Cannot generate enough unique prefixes for ", n_variants, " variants.\n",
       "  prefix_length=", prefix_length, ", even at min_hamming=", min_hamming_floor,
       " estimated capacity=~", estimated, ".\n",
       "  Suggestions: increase prefix_length (more prefix capacity),\n",
       "  or reduce barcodes_per_variant.")
}

#' Auto-size barcode length (simplified for unified mode)
#'
#' Finds the minimum barcode_length = prefix_length + suffix_length such that
#' suffix space >= barcodes_per_variant (after filtering).
#'
#' @param n_variants Number of variants
#' @param prefix_length Prefix length (fixed)
#' @param barcodes_per_variant Number of barcodes per variant
#' @param min_hamming Minimum Hamming distance
#' @param filter_pass_rate Estimated filter pass rate (default 0.50)
#' @return Integer auto-sized barcode_length
auto_size_barcode_length <- function(n_variants, prefix_length, barcodes_per_variant,
                                      min_hamming, filter_pass_rate = 0.50) {
  for (suffix_length in 0:18L) {
    barcode_length <- prefix_length + suffix_length
    if (barcode_length > 30L) break
    if (barcode_length < 6L) next
    # Suffix capacity check
    if (suffix_length == 0L && barcodes_per_variant > 1L) next
    if (suffix_length > 0L) {
      suffix_capacity <- floor(4^suffix_length * filter_pass_rate)
      if (suffix_capacity < barcodes_per_variant * 2L) next  # 2x safety margin
    }
    cli::cli_alert_success(paste0(
      "Auto-sizing: barcode_length=", barcode_length,
      " (prefix=", prefix_length, " + suffix=", suffix_length, ")",
      ", need=", n_variants, " variants x ", barcodes_per_variant, " barcodes"
    ))
    return(as.integer(barcode_length))
  }
  stop("Cannot auto-size barcode_length. Try reducing barcodes_per_variant or increasing prefix_length.")
}

# ============================================================================
# Main entry point
# ============================================================================

#' Design programmed barcodes for all variants (unified hierarchical mode)
#'
#' Uses a single prefix-suffix architecture for all use cases:
#' - One unique prefix per variant with hard Hamming distance guarantee
#' - Random filtered suffixes (no pairwise constraint) for replicate barcodes
#' - Cross-variant distance >= min_hamming (guaranteed by prefix)
#' - Within-variant distance = random (acceptable — same variant)
#'
#' Prefix generation strategy:
#' - d <= 3: GF(4) shortened Hamming code (deterministic, maximum capacity)
#' - d >= 4: DNABarcodes lexicode (Conway heuristic, Ashlock fallback)
#'
#' @param n_variants Number of variants needing barcodes
#' @param barcode_length Total barcode length (integer or "auto")
#' @param min_hamming Minimum Hamming distance between variant prefixes (default 3)
#' @param prefix_length Prefix length — Hamming-constrained region (default 12)
#' @param gc_range Numeric vector c(min, max) for GC content
#' @param max_homopolymer Maximum homopolymer run length (default 4)
#' @param barcodes_per_variant Number of barcodes per variant (default 10)
#' @param junction_left_context Left junction context for barcode filtering (default "")
#' @param junction_right_context Right junction context for barcode filtering (default "")
#' @return List with barcodes, barcode_assignments, barcode_length, prefix_length,
#'   effective_hamming, min_hamming_dist, code_type
design_barcodes <- function(n_variants,
                            barcode_length = DEFAULT_BARCODE_LENGTH,
                            min_hamming = DEFAULT_MIN_HAMMING,
                            prefix_length = DEFAULT_PREFIX_LENGTH,
                            gc_range = DEFAULT_GC_RANGE,
                            max_homopolymer = DEFAULT_MAX_HOMOPOLYMER,
                            barcodes_per_variant = DEFAULT_BARCODES_PER_VARIANT,
                            junction_left_context = "",
                            junction_right_context = "",
                            filter_poliii_term = TRUE) {

  n_total <- n_variants * barcodes_per_variant

  # 1. Auto-size barcode_length if "auto"
  if (identical(barcode_length, "auto")) {
    barcode_length <- auto_size_barcode_length(
      n_variants, prefix_length, barcodes_per_variant, min_hamming
    )
  }
  suffix_length <- barcode_length - prefix_length

  # Validate suffix space for replicate barcodes
  if (suffix_length < 0L) {
    stop("barcode_prefix_length (", prefix_length,
         ") exceeds barcode_length (", barcode_length, ")")
  }
  if (suffix_length == 0L && barcodes_per_variant > 1L) {
    stop("prefix_length == barcode_length but barcodes_per_variant > 1. ",
         "Need suffix space for replicate barcodes.")
  }

  cli::cli_alert_info(paste0(
    "Unified hierarchical mode: generating barcodes (length=", barcode_length,
    ", prefix=", prefix_length, ", suffix=", suffix_length,
    ", min_hamming=", min_hamming,
    ", need ", n_variants, " variants x ", barcodes_per_variant, " barcodes = ", n_total, ")"
  ))

  # 2. Feasibility check + auto-adjust min_hamming if needed
  effective_hamming <- check_prefix_feasibility(
    n_variants, prefix_length, min_hamming, min_hamming_floor = DEFAULT_MIN_HAMMING_FLOOR
  )

  # 3. Generate n_variants unique prefixes via algebraic code or lexicode
  cli::cli_alert("Generating {n_variants} unique prefixes (hard Hamming >= {effective_hamming})...")
  prefix_result <- generate_prefixes(
    prefix_length, effective_hamming, n_variants, max_homopolymer,
    junction_left_context, junction_right_context,
    filter_poliii_term = filter_poliii_term
  )
  prefixes <- prefix_result$prefixes
  code_type <- prefix_result$code_type

  if (length(prefixes) < n_variants) {
    stop("Could only generate ", length(prefixes), " unique prefixes, need ", n_variants,
         ". Try increasing prefix_length or decreasing min_hamming_distance.")
  }
  prefixes <- prefixes[seq_len(n_variants)]

  cli::cli_alert_info(paste0(
    "Generated ", length(prefixes), " unique prefixes (method=", code_type, ")."
  ))

  # 4. Generate barcodes: vectorized batch suffix generation
  cli::cli_alert("Generating barcodes (random suffixes per prefix)...")
  barcodes <- generate_barcodes_per_prefix(
    prefixes, suffix_length, barcodes_per_variant, gc_range, max_homopolymer,
    junction_left_context = junction_left_context,
    junction_right_context = junction_right_context,
    filter_poliii_term = filter_poliii_term
  )

  # 5. Validate prefix distances — skip for algebraically-guaranteed codes
  if (code_type %in% c("linear", "lexicode")) {
    cli::cli_alert_success(paste0(
      "Skipping prefix distance validation (d >= ", effective_hamming,
      " guaranteed by ", code_type, " construction)."
    ))
  } else {
    validate_prefix_distances(prefixes, effective_hamming)
  }

  cli::cli_alert_success(paste0(
    "Generated ", n_total, " barcodes",
    " (mode=unified hierarchical, length=", barcode_length,
    ", prefix_method=", code_type, ")"
  ))

  # 6. Compute per-barcode nearest-neighbor Hamming distance
  cli::cli_alert("Computing per-barcode nearest-neighbor Hamming distances...")
  min_hamming_dist <- compute_min_hamming_per_barcode(
    barcodes, prefix_length = prefix_length, min_hamming = effective_hamming
  )
  cli::cli_alert_success(paste0(
    "Nearest-neighbor distances: min=", min(min_hamming_dist),
    ", median=", median(min_hamming_dist),
    ", max=", max(min_hamming_dist)
  ))

  # 7. Build assignment table
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
    barcode_length      = barcode_length,
    prefix_length       = prefix_length,
    effective_hamming   = effective_hamming,
    code_type           = code_type
  )
}

# ============================================================================
# Prefix generation — unified entry point
# ============================================================================

#' Generate prefix sequences with guaranteed minimum Hamming distance
#'
#' Strategy:
#'   1. d <= 3: GF(4) shortened Hamming code (deterministic, max capacity)
#'   2. d >= 4 (and k <= 14): DNABarcodes Conway lexicode, then Ashlock fallback
#'   3. Error if nothing works
#'
#' Biological filtering (enzyme sites, homopolymers, junction context) is applied
#' to prefixes after generation. This is safe: removing codewords from a code
#' with minimum distance d preserves d >= d_code for all remaining pairs.
#'
#' @param k Prefix length
#' @param min_hamming Minimum Hamming distance
#' @param n_needed Number of prefixes needed (after filtering)
#' @param max_homopolymer Maximum homopolymer run (default 4)
#' @param junction_left_context Left junction context (default "")
#' @param junction_right_context Right junction context (default "")
#' @return List with: prefixes (character vector), code_type ("linear" or "lexicode")
generate_prefixes <- function(k, min_hamming, n_needed,
                               max_homopolymer = DEFAULT_MAX_HOMOPOLYMER,
                               junction_left_context = "",
                               junction_right_context = "",
                               filter_poliii_term = TRUE) {
  code_type <- NULL
  prefixes <- NULL

  # --- Path 1: GF(4) Hamming code for d <= 3 ---
  if (min_hamming <= 3L) {
    result <- tryCatch({
      generate_prefixes_linear(k, n_needed)
    }, error = function(e) {
      cli::cli_alert_warning("GF(4) linear code failed: {e$message}")
      NULL
    })

    if (!is.null(result)) {
      prefixes <- result$prefixes
      code_type <- "linear"

      # Stage 1 prefix filtering: enzyme sites, homopolymers, PolIII terminator
      prefixes <- filter_sequences_fast(prefixes, max_homopolymer,
                                        filter_poliii_term = filter_poliii_term)

      # Stage 1 prefix filtering: junction context
      if (nchar(junction_left_context) > 0 || nchar(junction_right_context) > 0) {
        n_before <- length(prefixes)
        prefixes <- filter_barcode_junctions(
          prefixes, junction_left_context, junction_right_context
        )
        n_removed <- n_before - length(prefixes)
        if (n_removed > 0) {
          cli::cli_alert_info(paste0(
            "Removed ", n_removed, " prefixes with enzyme sites at junction boundaries."
          ))
        }
      }

      if (length(prefixes) >= n_needed) {
        cli::cli_alert_success(paste0(
          "GF(4) linear code: ", length(prefixes),
          " prefixes after filtering (need ", n_needed, ")"
        ))
        return(list(prefixes = prefixes, code_type = code_type))
      }

      cli::cli_alert_warning(paste0(
        "GF(4) linear code: only ", length(prefixes),
        " prefixes after filtering (need ", n_needed, "). Trying DNABarcodes..."
      ))
    }
  }

  # --- Path 2: DNABarcodes lexicode (any d, k <= ~14) ---
  for (heuristic in c("conway", "ashlock")) {
    result <- tryCatch({
      generate_prefixes_lexicode(k, min_hamming, n_needed, heuristic = heuristic)
    }, error = function(e) {
      cli::cli_alert_warning("DNABarcodes ({heuristic}) failed: {e$message}")
      NULL
    })

    if (!is.null(result)) {
      prefixes <- result$prefixes
      code_type <- "lexicode"

      # Stage 1 prefix filtering
      prefixes <- filter_sequences_fast(prefixes, max_homopolymer,
                                        filter_poliii_term = filter_poliii_term)
      if (nchar(junction_left_context) > 0 || nchar(junction_right_context) > 0) {
        n_before <- length(prefixes)
        prefixes <- filter_barcode_junctions(
          prefixes, junction_left_context, junction_right_context
        )
        n_removed <- n_before - length(prefixes)
        if (n_removed > 0) {
          cli::cli_alert_info(paste0(
            "Removed ", n_removed, " prefixes with enzyme sites at junction boundaries."
          ))
        }
      }

      if (length(prefixes) >= n_needed) {
        cli::cli_alert_success(paste0(
          "DNABarcodes (", heuristic, "): ", length(prefixes),
          " prefixes after filtering (need ", n_needed, ")"
        ))
        return(list(prefixes = prefixes, code_type = code_type))
      }

      cli::cli_alert_warning(paste0(
        "DNABarcodes (", heuristic, "): only ", length(prefixes),
        " prefixes after filtering (need ", n_needed, ").",
        if (heuristic == "conway") " Trying Ashlock..." else ""
      ))
    }
  }

  # --- Path 3: Error ---
  n_got <- if (!is.null(prefixes)) length(prefixes) else 0L
  stop("Cannot generate ", n_needed, " prefixes of length ", k,
       " with min_hamming >= ", min_hamming, " after biological filtering",
       " (best attempt: ", n_got, " prefixes).\n",
       "  Suggestions: increase prefix_length, decrease min_hamming_distance,\n",
       "  or relax GC/homopolymer constraints.")
}

#' Generate prefixes using DNABarcodes lexicode
#'
#' Wraps DNABarcodes::create.dnabarcodes() to generate a high-quality prefix set.
#'
#' @param k Prefix length
#' @param min_hamming Minimum Hamming distance
#' @param n_needed Number of prefixes needed
#' @param heuristic "conway" (fast, deterministic) or "ashlock" (slower, larger sets)
#' @return List with: prefixes (character vector), code_type ("lexicode")
generate_prefixes_lexicode <- function(k, min_hamming, n_needed,
                                        heuristic = "conway") {
  if (!requireNamespace("DNABarcodes", quietly = TRUE)) {
    stop("DNABarcodes package not available")
  }

  cli::cli_alert_info(paste0(
    "Generating prefixes via DNABarcodes (heuristic=", heuristic,
    ", n=", k, ", dist=", min_hamming, ")..."
  ))

  bc_set <- DNABarcodes::create.dnabarcodes(
    n = k,
    dist = min_hamming,
    metric = "hamming",
    heuristic = heuristic,
    filter.triplets = FALSE,
    filter.gc = FALSE,
    filter.self_complementary = FALSE
  )

  prefixes <- as.character(bc_set)

  cli::cli_alert_info(paste0(
    "DNABarcodes (", heuristic, ") generated ", length(prefixes), " prefixes."
  ))

  list(prefixes = prefixes, code_type = "lexicode")
}

# ============================================================================
# Barcode generation (vectorized batch suffix generation)
# ============================================================================

#' Generate barcodes by assigning random filtered suffixes to each prefix
#'
#' Uses a two-pass vectorized approach:
#'   Pass 1: Generate all suffix candidates in one batch, paste with prefixes,
#'           apply all filters once (enzyme sites, homopolymers, GC, junction context)
#'   Pass 2: Per-variant retry for any variants that didn't get enough barcodes
#'
#' @param prefixes Character vector of unique prefix sequences (one per variant)
#' @param suffix_length Length of suffix portion
#' @param barcodes_per_variant Number of barcodes per variant
#' @param gc_range GC content range c(min, max)
#' @param max_homopolymer Maximum homopolymer run allowed
#' @param oversample_factor Oversampling multiplier per variant (default 20)
#' @param junction_left_context Left junction context for enzyme site check (default "")
#' @param junction_right_context Right junction context for enzyme site check (default "")
#' @return Character vector of barcodes (length = n_variants * barcodes_per_variant)
generate_barcodes_per_prefix <- function(prefixes, suffix_length,
                                          barcodes_per_variant,
                                          gc_range, max_homopolymer,
                                          oversample_factor = 20L,
                                          junction_left_context = "",
                                          junction_right_context = "",
                                          filter_poliii_term = TRUE) {
  n_variants <- length(prefixes)
  n_total <- n_variants * barcodes_per_variant

  # If suffix_length == 0, each prefix IS a barcode (only for bpv=1)
  if (suffix_length == 0L) {
    return(prefixes)
  }

  bc_start <- proc.time()
  bases <- c("A", "C", "G", "T")

  # --- Pass 1: Vectorized batch generation ---
  n_suf_per_variant <- max(barcodes_per_variant * oversample_factor, 500L)
  n_total_candidates <- n_variants * n_suf_per_variant

  cli::cli_alert_info(paste0(
    "Batch suffix generation: ", n_variants, " variants x ",
    n_suf_per_variant, " candidates = ",
    format(n_total_candidates, big.mark = ","), " total"
  ))

  # Generate all random suffixes at once (vectorized string construction)
  suf_mat <- matrix(sample(bases, suffix_length * n_total_candidates, replace = TRUE),
                    nrow = n_total_candidates, ncol = suffix_length)
  all_suffixes <- do.call(paste0, as.data.frame(suf_mat, stringsAsFactors = FALSE))

  # Pair each suffix with its corresponding prefix
  variant_ids <- rep(seq_len(n_variants), each = n_suf_per_variant)
  all_prefixes_rep <- rep(prefixes, each = n_suf_per_variant)
  all_barcodes <- paste0(all_prefixes_rep, all_suffixes)

  # Apply all filters in one vectorized pass
  keep <- filter_barcodes_batch(
    all_barcodes, max_homopolymer, gc_range,
    junction_left_context, junction_right_context,
    filter_poliii_term = filter_poliii_term
  )
  valid_barcodes <- all_barcodes[keep]
  valid_variant_ids <- variant_ids[keep]

  # Split by variant and select barcodes_per_variant per group
  barcodes <- character(n_total)
  needs_retry <- integer(0)

  bc_by_variant <- split(valid_barcodes, valid_variant_ids)
  for (vname in names(bc_by_variant)) {
    v <- as.integer(vname)
    v_bcs <- unique(bc_by_variant[[vname]])
    if (length(v_bcs) >= barcodes_per_variant) {
      idx_start <- (v - 1L) * barcodes_per_variant + 1L
      idx_end <- v * barcodes_per_variant
      barcodes[idx_start:idx_end] <- v_bcs[seq_len(barcodes_per_variant)]
    } else {
      needs_retry <- c(needs_retry, v)
    }
  }
  # Variants with zero valid barcodes won't appear in bc_by_variant
  all_variants_in_split <- as.integer(names(bc_by_variant))
  missing_variants <- setdiff(seq_len(n_variants), all_variants_in_split)
  needs_retry <- c(needs_retry, missing_variants)

  # --- Pass 2: Per-variant retry for failures ---
  if (length(needs_retry) > 0) {
    cli::cli_alert_info(paste0(
      "Retrying suffix generation for ", length(needs_retry), " variants..."
    ))
    n_retry_suf <- max(barcodes_per_variant * oversample_factor * 10L, 5000L)

    for (v in needs_retry) {
      prefix <- prefixes[v]
      retry_mat <- matrix(sample(bases, suffix_length * n_retry_suf, replace = TRUE),
                          nrow = n_retry_suf, ncol = suffix_length)
      retry_suffixes <- do.call(paste0, as.data.frame(retry_mat, stringsAsFactors = FALSE))
      retry_bcs <- paste0(prefix, unique(retry_suffixes))
      retry_keep <- filter_barcodes_batch(
        retry_bcs, max_homopolymer, gc_range,
        junction_left_context, junction_right_context,
        filter_poliii_term = filter_poliii_term
      )
      retry_valid <- unique(retry_bcs[retry_keep])

      # Combine with any from pass 1
      existing <- valid_barcodes[valid_variant_ids == v]
      all_valid <- unique(c(existing, retry_valid))

      if (length(all_valid) < barcodes_per_variant) {
        stop("Insufficient valid suffixes for prefix ", prefix,
             ". Got ", length(all_valid), ", need ", barcodes_per_variant,
             ". Try increasing barcode_length.")
      }

      idx_start <- (v - 1L) * barcodes_per_variant + 1L
      idx_end <- v * barcodes_per_variant
      barcodes[idx_start:idx_end] <- all_valid[seq_len(barcodes_per_variant)]
    }
  }

  bc_elapsed <- (proc.time() - bc_start)[["elapsed"]]
  cli::cli_alert_success(paste0(
    "Barcode generation: ", n_total, " barcodes for ", n_variants,
    " variants in ", round(bc_elapsed, 1), "s."
  ))
  barcodes
}

#' Vectorized batch filter for full barcodes
#'
#' Applies all biological filters in a single pass over the entire candidate vector:
#' enzyme sites, homopolymers, GC content, and junction context.
#'
#' @param barcodes Character vector of barcode sequences
#' @param max_homopolymer Maximum homopolymer run
#' @param gc_range GC content range c(min, max)
#' @param junction_left_context Left context for junction check
#' @param junction_right_context Right context for junction check
#' @return Logical vector (TRUE = passes all filters)
filter_barcodes_batch <- function(barcodes, max_homopolymer, gc_range,
                                   junction_left_context = "",
                                   junction_right_context = "",
                                   filter_poliii_term = TRUE) {
  n <- length(barcodes)
  if (n == 0L) return(logical(0))

  # Enzyme site filter (on barcode alone)
  bad <- rep(FALSE, n)
  for (enz_name in names(ENZYMES)) {
    enz <- ENZYMES[[enz_name]]
    bad <- bad | grepl(enz$recog, barcodes, fixed = TRUE) |
                  grepl(enz$recog_rc, barcodes, fixed = TRUE)
  }

  # Homopolymer filter
  homo_pattern <- paste0("([ACGT])\\1{", max_homopolymer, ",}")
  bad <- bad | grepl(homo_pattern, barcodes)

  # PolIII terminator filter (TTTT causes premature transcription termination)
  if (filter_poliii_term) {
    bad <- bad | grepl(POLIII_TERM_SEQ, barcodes, fixed = TRUE)
  }

  # GC filter
  gc_counts <- nchar(gsub("[AT]", "", barcodes))
  gc_vals <- gc_counts / nchar(barcodes)
  bad <- bad | gc_vals < gc_range[1] | gc_vals > gc_range[2]

  # Junction context filter (enzyme sites spanning barcode-flanking junction)
  if (nchar(junction_left_context) > 0 || nchar(junction_right_context) > 0) {
    junction_seqs <- paste0(junction_left_context, barcodes, junction_right_context)
    for (enz_name in names(ENZYMES)) {
      enz <- ENZYMES[[enz_name]]
      bad <- bad | grepl(enz$recog, junction_seqs, fixed = TRUE) |
                    grepl(enz$recog_rc, junction_seqs, fixed = TRUE)
    }
  }

  !bad
}

# ============================================================================
# Filtering and k-mer helpers
# ============================================================================

#' Fast vectorized filter for enzyme sites and homopolymers
#'
#' @param seqs Character vector of sequences
#' @param max_homopolymer Maximum allowed homopolymer run
#' @return Filtered character vector
filter_sequences_fast <- function(seqs, max_homopolymer = 4L,
                                   filter_poliii_term = TRUE) {
  bad <- rep(FALSE, length(seqs))
  for (enz_name in names(ENZYMES)) {
    enz <- ENZYMES[[enz_name]]
    bad <- bad | grepl(enz$recog, seqs, fixed = TRUE) |
                 grepl(enz$recog_rc, seqs, fixed = TRUE)
  }
  homo_pattern <- paste0("([ACGT])\\1{", max_homopolymer, ",}")
  bad <- bad | grepl(homo_pattern, seqs)
  # PolIII terminator filter (TTTT causes premature transcription termination)
  if (filter_poliii_term) {
    bad <- bad | grepl(POLIII_TERM_SEQ, seqs, fixed = TRUE)
  }
  seqs[!bad]
}

#' Filter barcodes that create enzyme sites at junction boundaries
#'
#' Checks whether the context `left_context + barcode + right_context` contains
#' any enzyme recognition site (BsaI, BsmBI, PaqCI on either strand). This
#' catches sites that span the barcode-to-enzyme-site junction and would not
#' be detected by checking the barcode sequence in isolation.
#'
#' @param barcodes Character vector of barcode sequences
#' @param left_context String: the last few nt of the element left of the barcode
#'   (e.g., last 6 nt of BsmBI_fwd_oh3 site). Use "" if no context.
#' @param right_context String: the first few nt of the element right of the barcode
#'   (e.g., first 7 nt of BsaI_rev_oh4 site). Use "" if no context.
#' @return Filtered character vector of barcodes (those NOT creating junction sites)
filter_barcode_junctions <- function(barcodes, left_context = "", right_context = "") {
  if (length(barcodes) == 0L) return(barcodes)
  if (nchar(left_context) == 0L && nchar(right_context) == 0L) return(barcodes)

  junction_seqs <- paste0(left_context, barcodes, right_context)
  bad <- rep(FALSE, length(barcodes))
  for (enz_name in names(ENZYMES)) {
    enz <- ENZYMES[[enz_name]]
    bad <- bad | grepl(enz$recog, junction_seqs, fixed = TRUE) |
                  grepl(enz$recog_rc, junction_seqs, fixed = TRUE)
  }
  barcodes[!bad]
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

# ============================================================================
# Per-barcode nearest-neighbor Hamming distance
# ============================================================================

#' Compute the minimum Hamming distance to the nearest neighbor for each barcode
#'
#' For each barcode, finds the closest other barcode and returns that distance.
#' Uses vectorized integer-matrix comparisons for speed.
#'
#' When prefix_length is provided and n > 50,000, uses an optimized path:
#' cross-prefix-group NN distance >= min_hamming by construction (from the
#' prefix Hamming guarantee), so only within-group comparisons are needed.
#' This reduces complexity from O(n^2) to O(s^2 * n_groups) where s is the
#' group size.
#'
#' @param barcodes Character vector of equal-length barcode sequences
#' @param prefix_length Length of the prefix used during generation (or NULL)
#' @param min_hamming Known minimum Hamming distance guarantee (used with
#'   prefix_length optimization; default NULL)
#' @return Integer vector of the same length as barcodes, where each element
#'   is the minimum Hamming distance from that barcode to any other barcode
compute_min_hamming_per_barcode <- function(barcodes, prefix_length = NULL,
                                             min_hamming = NULL) {
  n <- length(barcodes)
  if (n <= 1L) return(rep(NA_integer_, n))

  k <- nchar(barcodes[1])

  # Optimized path: when prefix_length is known and set is large,
  # only compute within-group NN (cross-group is >= min_hamming by construction)
  if (!is.null(prefix_length) && !is.null(min_hamming) &&
      prefix_length > 0 && prefix_length < k && n > 50000) {
    cli::cli_alert_info(paste0(
      "Using prefix-group optimization for NN computation (", n, " barcodes, ",
      "prefix_length=", prefix_length, ")"
    ))

    prefixes <- substring(barcodes, 1, prefix_length)
    prefix_groups <- split(seq_len(n), prefixes)

    # Initialize all NN distances to min_hamming (the cross-group lower bound)
    min_dists <- rep(as.integer(min_hamming), n)

    for (group_idxs in prefix_groups) {
      ng <- length(group_idxs)
      if (ng < 2L) next

      # Compute all pairwise distances within group
      group_bcs <- barcodes[group_idxs]
      g_mat <- matrix(unlist(lapply(group_bcs, utf8ToInt)), nrow = k, ncol = ng)

      for (i in seq_len(ng - 1L)) {
        dists <- as.integer(colSums(g_mat[, (i + 1L):ng, drop = FALSE] != g_mat[, i]))
        # Update barcode i within group
        d_min_i <- min(dists)
        if (d_min_i < min_dists[group_idxs[i]]) {
          min_dists[group_idxs[i]] <- d_min_i
        }
        # Update each j > i within group
        j_local <- (i + 1L):ng
        improved <- dists < min_dists[group_idxs[j_local]]
        if (any(improved)) {
          min_dists[group_idxs[j_local[improved]]] <- dists[improved]
        }
      }
    }

    return(min_dists)
  }

  # Standard O(n^2) path for smaller sets
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

#' Validate that all unique prefixes have pairwise Hamming distance >= min_hamming
#'
#' Only validates unique prefixes (much smaller than full barcode set).
#' Errors on any violation.
#'
#' @param prefixes Character vector of unique prefix sequences
#' @param min_hamming Minimum required Hamming distance
validate_prefix_distances <- function(prefixes, min_hamming) {
  n <- length(prefixes)
  if (n <= 1) return(invisible(NULL))
  k <- nchar(prefixes[1])
  n_pairs <- as.numeric(n) * (n - 1) / 2
  cli::cli_alert_info("Validating prefix distances: {n} prefixes ({format(n_pairs, big.mark=',')} pairs)...")
  val_start <- proc.time()

  p_mat <- matrix(unlist(lapply(prefixes, utf8ToInt)), nrow = k, ncol = n)
  last_report <- 0L

  for (i in seq_len(n - 1L)) {
    dists <- as.integer(colSums(p_mat[, (i + 1L):n, drop = FALSE] != p_mat[, i]))
    min_d <- min(dists)
    if (min_d < min_hamming) {
      j <- which.min(dists) + i
      stop("Prefix Hamming distance violation: ",
           prefixes[i], " vs ", prefixes[j],
           " (distance=", min_d, ", required=", min_hamming, ")")
    }
    # Progress report every 5000 rows
    if (i >= last_report + 5000L) {
      cli::cli_alert("  ...validated {i}/{n - 1L} prefix rows")
      last_report <- i
    }
  }

  val_elapsed <- (proc.time() - val_start)[["elapsed"]]
  cli::cli_alert_success(paste0(
    "Prefix distance validation passed: all ", n, " prefix pairs have d >= ", min_hamming,
    " (", round(val_elapsed, 1), "s)"
  ))
  invisible(NULL)
}
