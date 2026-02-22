# Created: 2025-02-01
# Last updated: 2026-02-20 — Add junction-context barcode filtering (BUG-2)
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
#'   effective_hamming, min_hamming_dist
design_barcodes <- function(n_variants,
                            barcode_length = DEFAULT_BARCODE_LENGTH,
                            min_hamming = DEFAULT_MIN_HAMMING,
                            prefix_length = DEFAULT_PREFIX_LENGTH,
                            gc_range = DEFAULT_GC_RANGE,
                            max_homopolymer = DEFAULT_MAX_HOMOPOLYMER,
                            barcodes_per_variant = DEFAULT_BARCODES_PER_VARIANT,
                            junction_left_context = "",
                            junction_right_context = "") {

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

  # 3. Generate n_variants unique prefixes
  cli::cli_alert("Generating {n_variants} unique prefixes (hard Hamming >= {effective_hamming})...")
  if (prefix_length <= 10L) {
    prefixes <- generate_prefixes(prefix_length, effective_hamming, n_variants)
  } else {
    prefixes <- generate_prefixes_random_greedy(
      prefix_length, effective_hamming, n_variants
    )
    # Post-filter for enzyme sites/homopolymers
    prefixes <- filter_sequences_fast(prefixes, max_homopolymer)
  }

  # Filter prefixes that create enzyme sites at junction boundaries.
  # A prefix like "CCTG..." with left context "...ACA" creates PaqCI site "CACCTGC"
  # spanning the junction — no suffix can fix this, so remove the prefix entirely.
  if (nchar(junction_left_context) > 0 || nchar(junction_right_context) > 0) {
    n_before <- length(prefixes)
    prefixes <- filter_barcode_junctions(prefixes, junction_left_context, junction_right_context)
    n_removed <- n_before - length(prefixes)
    if (n_removed > 0) {
      cli::cli_alert_info(paste0(
        "Removed ", n_removed, " prefixes with enzyme sites at junction boundaries."
      ))
    }
  }

  if (length(prefixes) < n_variants) {
    stop("Could only generate ", length(prefixes), " unique prefixes, need ", n_variants,
         ". Try increasing prefix_length or decreasing min_hamming_distance.")
  }
  prefixes <- prefixes[seq_len(n_variants)]

  cli::cli_alert_info(paste0("Generated ", length(prefixes), " unique prefixes."))

  # 4. For each prefix, generate barcodes_per_variant random filtered suffixes
  cli::cli_alert("Generating barcodes (random suffixes per prefix)...")
  barcodes <- generate_barcodes_per_prefix(
    prefixes, suffix_length, barcodes_per_variant, gc_range, max_homopolymer,
    junction_left_context = junction_left_context,
    junction_right_context = junction_right_context
  )

  # 5. Validate prefix distances (fast: only unique prefixes)
  validate_prefix_distances(prefixes, effective_hamming)

  cli::cli_alert_success(paste0(
    "Generated ", n_total, " barcodes",
    " (mode=unified hierarchical, length=", barcode_length, ")"
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
    effective_hamming   = effective_hamming
  )
}

# ============================================================================
# Prefix generation
# ============================================================================

#' Generate prefix sequences with guaranteed Hamming distance
#'
#' For prefix_length <= 10, enumerates all 4^k k-mers and greedily selects.
#' For larger prefix_length, use generate_prefixes_random_greedy() instead.
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

  prefixes
}

#' Greedy prefix generation via full enumeration (for k <= 10)
#'
#' Enumerates all 4^k k-mers, shuffles, pre-filters, then greedily selects
#' prefixes with mutual Hamming distance >= min_hamming.
#'
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

#' Greedy prefix generation excluding known prefixes (for expanding prefix pool)
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
  if (n_cand == 0) return(character(0))

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
  if (length(valid) == 0) return(character(0))

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

  new_selected
}

#' Random greedy prefix generation (for prefix_length > 10)
#'
#' For large prefix spaces (4^k > 1M), enumerating all k-mers is infeasible.
#' Instead: random sample → filter → greedy select with vectorized distance.
#'
#' @param k Prefix length
#' @param min_hamming Minimum Hamming distance
#' @param n_needed Number of prefixes needed
#' @param n_sample Number of random candidates to sample (default 500000)
#' @return Character vector of prefixes with mutual d >= min_hamming
generate_prefixes_random_greedy <- function(k, min_hamming, n_needed,
                                             n_sample = 500000L) {
  bases <- c("A", "C", "G", "T")
  cli::cli_alert_info("Generating {n_sample} random {k}-mer candidates...")
  rand_mat <- matrix(sample(bases, k * n_sample, replace = TRUE),
                     nrow = k, ncol = n_sample)
  candidates <- apply(rand_mat, 2, paste0, collapse = "")
  candidates <- unique(candidates)
  candidates <- filter_sequences_fast(candidates, DEFAULT_MAX_HOMOPOLYMER)
  candidates <- sample(candidates)

  # Pre-allocate
  n_cand <- length(candidates)
  target <- min(n_needed * 2L, n_cand)
  cli::cli_alert_info("Greedy selection from {n_cand} filtered candidates (target={target})...")
  greedy_start <- proc.time()

  cand_mat <- matrix(unlist(lapply(candidates, utf8ToInt)), nrow = k, ncol = n_cand)
  selected <- character(target)
  sel_mat <- matrix(0L, nrow = k, ncol = target)
  n_sel <- 0L
  last_report <- 0L

  for (i in seq_len(n_cand)) {
    q_int <- cand_mat[, i]
    if (n_sel == 0L) {
      n_sel <- 1L
      selected[1L] <- candidates[i]
      sel_mat[, 1L] <- q_int
      next
    }
    dists <- as.integer(colSums(sel_mat[, seq_len(n_sel), drop = FALSE] != q_int))
    if (all(dists >= min_hamming)) {
      n_sel <- n_sel + 1L
      selected[n_sel] <- candidates[i]
      sel_mat[, n_sel] <- q_int
    }
    # Progress report every 10K selected prefixes
    if (n_sel >= last_report + 10000L) {
      cli::cli_alert("  ...selected {n_sel}/{target} prefixes ({i}/{n_cand} candidates scanned)")
      last_report <- n_sel
    }
    if (n_sel >= target) break
  }

  greedy_elapsed <- (proc.time() - greedy_start)[["elapsed"]]
  cli::cli_alert_success("Greedy prefix selection: {n_sel} prefixes in {round(greedy_elapsed, 1)}s.")
  selected[seq_len(n_sel)]
}

# ============================================================================
# Barcode generation (per-prefix random suffixes)
# ============================================================================

#' Generate barcodes by assigning random filtered suffixes to each prefix
#'
#' For each variant's prefix, generates random suffix candidates, combines
#' them into full barcodes, filters for enzyme sites/homopolymers/GC and
#' junction context, then selects barcodes_per_variant results.
#'
#' @param prefixes Character vector of unique prefix sequences (one per variant)
#' @param suffix_length Length of suffix portion
#' @param barcodes_per_variant Number of barcodes per variant
#' @param gc_range GC content range c(min, max)
#' @param max_homopolymer Maximum homopolymer run allowed
#' @param oversample Oversampling multiplier for suffix candidates (default 10)
#' @param junction_left_context Left junction context for enzyme site check (default "")
#' @param junction_right_context Right junction context for enzyme site check (default "")
#' @return Character vector of barcodes (length = n_variants * barcodes_per_variant)
generate_barcodes_per_prefix <- function(prefixes, suffix_length,
                                          barcodes_per_variant,
                                          gc_range, max_homopolymer,
                                          oversample = 10L,
                                          junction_left_context = "",
                                          junction_right_context = "") {
  n_variants <- length(prefixes)
  n_total <- n_variants * barcodes_per_variant
  barcodes <- character(n_total)

  # If suffix_length == 0, each prefix IS a barcode (only for bpv=1)
  if (suffix_length == 0L) {
    return(prefixes)
  }

  bases <- c("A", "C", "G", "T")
  # Ensure enough candidates even when barcodes_per_variant is small (e.g., 1).
  # With suffix_length=8 there are 65K possible suffixes; sampling only 10 misses valid ones.
  n_suffix_candidates <- max(barcodes_per_variant * oversample, 500L)
  bc_start <- proc.time()
  last_report <- 0L

  for (v in seq_len(n_variants)) {
    prefix <- prefixes[v]
    # Progress report every 5000 variants
    if (v >= last_report + 5000L) {
      cli::cli_alert("  ...generating barcodes for variant {v}/{n_variants}")
      last_report <- v
    }
    # Generate random suffix candidates
    suf_mat <- matrix(sample(bases, suffix_length * n_suffix_candidates, replace = TRUE),
                      nrow = suffix_length, ncol = n_suffix_candidates)
    suffixes <- apply(suf_mat, 2, paste0, collapse = "")
    suffixes <- unique(suffixes)

    # Combine with prefix for full-barcode filtering
    full_bcs <- paste0(prefix, suffixes)
    full_bcs <- filter_sequences_fast(full_bcs, max_homopolymer)
    full_bcs <- filter_barcode_junctions(full_bcs, junction_left_context, junction_right_context)

    # GC filter
    if (length(full_bcs) > 0) {
      gc_counts <- nchar(gsub("[AT]", "", full_bcs))
      gc_vals <- gc_counts / nchar(full_bcs)
      full_bcs <- full_bcs[gc_vals >= gc_range[1] & gc_vals <= gc_range[2]]
    }

    if (length(full_bcs) < barcodes_per_variant) {
      # Retry with much larger sample
      n_retry <- max(barcodes_per_variant * oversample * 10L, 5000L)
      suf_mat2 <- matrix(sample(bases, suffix_length * n_retry, replace = TRUE),
                         nrow = suffix_length, ncol = n_retry)
      suffixes2 <- apply(suf_mat2, 2, paste0, collapse = "")
      suffixes2 <- unique(suffixes2)
      full_bcs2 <- paste0(prefix, suffixes2)
      full_bcs2 <- filter_sequences_fast(full_bcs2, max_homopolymer)
      full_bcs2 <- filter_barcode_junctions(full_bcs2, junction_left_context, junction_right_context)
      if (length(full_bcs2) > 0) {
        gc_counts2 <- nchar(gsub("[AT]", "", full_bcs2))
        gc_vals2 <- gc_counts2 / nchar(full_bcs2)
        full_bcs2 <- full_bcs2[gc_vals2 >= gc_range[1] & gc_vals2 <= gc_range[2]]
      }
      # Combine with first attempt (dedup)
      full_bcs <- unique(c(full_bcs, full_bcs2))
    }

    if (length(full_bcs) < barcodes_per_variant) {
      stop("Insufficient valid suffixes for prefix ", prefix,
           ". Got ", length(full_bcs), ", need ", barcodes_per_variant,
           ". Try increasing barcode_length.")
    }

    idx_start <- (v - 1L) * barcodes_per_variant + 1L
    idx_end <- v * barcodes_per_variant
    barcodes[idx_start:idx_end] <- full_bcs[seq_len(barcodes_per_variant)]
  }

  bc_elapsed <- (proc.time() - bc_start)[["elapsed"]]
  cli::cli_alert_success("Barcode generation: {n_total} barcodes for {n_variants} variants in {round(bc_elapsed, 1)}s.")
  barcodes
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
