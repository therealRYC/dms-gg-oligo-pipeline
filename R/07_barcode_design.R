# 07_barcode_design.R — Programmed barcodes with prefix-optimized Hamming distance
# DMS Golden Gate Oligo Pipeline

#' Design programmed barcodes for all variants
#'
#' Uses a prefix-first approach:
#' 1. Generate high-Hamming-distance k-nt prefixes using DNABarcodes
#' 2. Extend each prefix with suffix candidates (enforcing within-group Hamming distance)
#' 3. Filter for GC content, homopolymers, enzyme sites
#' 4. Assign barcodes to variants (barcodes_per_variant each)
#'
#' @param n_variants Number of variants needing barcodes
#' @param barcode_length Total barcode length (default 12)
#' @param min_hamming Minimum Hamming distance (default 3)
#' @param prefix_length Prefix length for OPS optimization (default 8)
#' @param gc_range Numeric vector c(min, max) for GC content (default c(0.25, 0.75))
#' @param max_homopolymer Maximum homopolymer run length (default 4)
#' @param barcodes_per_variant Number of barcodes per variant (default 1)
#' @return List with:
#'   - barcodes: character vector of all barcodes (length = n_variants * barcodes_per_variant)
#'   - barcode_assignments: data frame with variant_idx, barcode_idx, barcode
design_barcodes <- function(n_variants,
                            barcode_length = DEFAULT_BARCODE_LENGTH,
                            min_hamming = DEFAULT_MIN_HAMMING,
                            prefix_length = DEFAULT_PREFIX_LENGTH,
                            gc_range = DEFAULT_GC_RANGE,
                            max_homopolymer = DEFAULT_MAX_HOMOPOLYMER,
                            barcodes_per_variant = DEFAULT_BARCODES_PER_VARIANT) {

  n_total <- n_variants * barcodes_per_variant
  suffix_length <- barcode_length - prefix_length

  cli::cli_alert_info(paste0(
    "Generating barcodes: length=", barcode_length,
    ", prefix=", prefix_length, ", suffix=", suffix_length,
    ", min Hamming=", min_hamming,
    ", barcodes_per_variant=", barcodes_per_variant,
    ", need ", n_total, " barcodes"
  ))

  # Capacity check
  check_barcode_capacity(n_total, prefix_length, suffix_length, min_hamming,
                         gc_range, max_homopolymer, barcodes_per_variant)

  # Step 1: Generate prefix set with high Hamming distance
  cli::cli_alert("Generating prefix set with DNABarcodes...")
  prefixes <- generate_prefixes(prefix_length, min_hamming, n_total)

  # Step 2: Generate all possible suffixes and pre-compute valid suffix groups
  # A suffix group is a maximal set of suffixes with mutual Hamming distance >= min_hamming
  suffixes <- generate_all_kmers(suffix_length)

  # Pre-compute one valid suffix group (shared across all prefixes since suffix
  # Hamming distance is independent of prefix). We pick the largest greedy set.
  valid_suffix_group <- select_suffix_group(suffixes, min_hamming)

  cli::cli_alert_info(paste0(
    "Max suffixes per prefix group (d>=", min_hamming, "): ", length(valid_suffix_group)
  ))

  # Step 3: Combine prefixes with valid suffixes, filtering each full barcode
  cli::cli_alert("Combining prefixes with suffixes and filtering...")

  # Generate all prefix+suffix combinations at once for vectorized filtering
  barcodes <- generate_filtered_barcodes(
    prefixes, valid_suffix_group, gc_range, max_homopolymer, n_total
  )

  # If not enough, try greedy expansion of prefix pool
  if (length(barcodes) < n_total) {
    cli::cli_alert_info("Expanding prefix pool with greedy generation...")
    extra_needed <- ceiling((n_total - length(barcodes)) / length(valid_suffix_group)) + 50L
    extra_prefixes <- generate_prefixes_greedy_excluding(
      prefix_length, min_hamming, extra_needed, prefixes
    )
    extra_barcodes <- generate_filtered_barcodes(
      extra_prefixes, valid_suffix_group, gc_range, max_homopolymer,
      n_total - length(barcodes)
    )
    barcodes <- c(barcodes, extra_barcodes)
  }

  if (length(barcodes) < n_total) {
    stop("Could only generate ", length(barcodes), " barcodes, but need ", n_total,
         ". Try: increase barcode_length, decrease min_hamming_distance, ",
         "or decrease barcodes_per_variant.")
  }

  barcodes <- barcodes[seq_len(n_total)]

  # Step 4: Validate full-length Hamming distances
  validate_barcode_distances(barcodes, min_hamming, prefix_length)

  cli::cli_alert_success(paste0("Generated ", n_total, " unique barcodes."))

  # Build assignment table
  barcode_assignments <- data.frame(
    variant_idx = rep(seq_len(n_variants), each = barcodes_per_variant),
    barcode_idx = rep(seq_len(barcodes_per_variant), times = n_variants),
    barcode     = barcodes,
    stringsAsFactors = FALSE
  )

  list(
    barcodes            = barcodes,
    barcode_assignments = barcode_assignments
  )
}

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

#' Check whether enough barcodes can be generated
#'
#' Estimates theoretical capacity and errors immediately if insufficient.
#' @param n_needed Total barcodes needed
#' @param prefix_length Prefix length
#' @param suffix_length Suffix length
#' @param min_hamming Minimum Hamming distance
#' @param gc_range GC content range
#' @param max_homopolymer Max homopolymer
#' @param barcodes_per_variant Barcodes per variant
check_barcode_capacity <- function(n_needed, prefix_length, suffix_length, min_hamming,
                                    gc_range, max_homopolymer, barcodes_per_variant) {
  # Hamming ball volume V(k,d) for prefix capacity estimate
  t_val <- floor((min_hamming - 1) / 2)
  ball_vol <- 0
  for (i in 0:t_val) {
    ball_vol <- ball_vol + choose(prefix_length, i) * (3^i)
  }
  max_prefixes <- floor(4^prefix_length / ball_vol)

  # Suffix capacity: max suffixes per group with mutual d >= min_hamming
  suffix_ball_vol <- 0
  for (i in 0:t_val) {
    suffix_ball_vol <- suffix_ball_vol + choose(suffix_length, i) * (3^i)
  }
  max_suffixes_per_group <- floor(4^suffix_length / suffix_ball_vol)

  # Filter pass rate estimate
  estimated_pass_rate <- 0.50  # conservative
  estimated_capacity <- max_prefixes * max_suffixes_per_group * estimated_pass_rate

  if (estimated_capacity < n_needed) {
    stop(
      "Insufficient barcode capacity. Need ", n_needed, " barcodes",
      " but estimated capacity is ~", round(estimated_capacity), ".\n",
      "  Max prefixes (prefix_length=", prefix_length, ", min_hamming=", min_hamming, "): ~", max_prefixes, "\n",
      "  Max suffixes per group (suffix_length=", suffix_length, ", min_hamming=", min_hamming, "): ~", max_suffixes_per_group, "\n",
      "  Estimated pass rate: ", estimated_pass_rate * 100, "%\n",
      "  Suggestions: increase barcode_length, decrease min_hamming_distance",
      if (barcodes_per_variant > 1) paste0(", or decrease barcodes_per_variant (currently ", barcodes_per_variant, ")") else ""
    )
  }
}

#' Generate prefix sequences with guaranteed Hamming distance
#'
#' Uses greedy generation which is fast and produces near-optimal results.
#' For k=8, d=3: typically generates ~950 valid prefixes in ~2 seconds.
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

#' Greedy prefix generation fallback (vectorized)
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
#' Uses batch minimum-distance computation: for each existing prefix, compute
#' distances to all candidates in one vectorized operation, then eliminate those
#' too close. From survivors, greedily select new prefixes.
#'
#' @param k Prefix length
#' @param min_hamming Minimum Hamming distance
#' @param n_needed Number of additional prefixes needed
#' @param existing_prefixes Prefixes already in use (must maintain d >= min_hamming)
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

  # Convert all candidates to integer matrix (k × n_cand)
  cand_mat <- matrix(unlist(lapply(all_kmers, utf8ToInt)),
                     nrow = k, ncol = n_cand)

  # Compute minimum distance to existing prefixes for each candidate
  # Do this one existing prefix at a time to avoid huge memory allocation
  min_dist <- rep(as.integer(k), n_cand)  # start with max possible distance
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
  sel_ints <- list()  # store as list of int vectors for fast access

  for (idx in valid) {
    q_int <- cand_mat[, idx]

    # Check against previously selected new prefixes
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

#' Fast vectorized filter for enzyme sites and homopolymers
#'
#' Uses grepl on the full vector instead of per-element has_enzyme_sites/has_homopolymer.
#' @param seqs Character vector of sequences
#' @param max_homopolymer Maximum allowed homopolymer run
#' @return Filtered character vector
filter_sequences_fast <- function(seqs, max_homopolymer = 4L) {
  # Build patterns for all enzyme recognition sites (fwd and RC)
  bad <- rep(FALSE, length(seqs))
  for (enz_name in names(ENZYMES)) {
    enz <- ENZYMES[[enz_name]]
    bad <- bad | grepl(enz$recog, seqs, fixed = TRUE) |
                 grepl(enz$recog_rc, seqs, fixed = TRUE)
  }
  # Homopolymer check
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
  # GC content
  gc <- gc_content(bc)
  if (gc < gc_range[1] || gc > gc_range[2]) return(FALSE)

  # Homopolymer
  if (has_homopolymer(bc, max_homopolymer)) return(FALSE)

  # Enzyme sites
  if (has_enzyme_sites(bc)) return(FALSE)

  TRUE
}

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
  # Convert all targets to a single raw matrix for vectorized comparison
  t_int <- matrix(unlist(lapply(targets, utf8ToInt)), nrow = k, ncol = n)
  as.integer(colSums(t_int != q_int))
}

#' Validate that all barcodes have minimum pairwise Hamming distance
#'
#' Uses prefix-group validation: barcodes with different prefixes are guaranteed
#' to have >= min_hamming distance (since prefix distances >= min_hamming).
#' Within each prefix group, does exhaustive pairwise check.
#' Errors (not warns) on violations.
#'
#' @param barcodes Character vector of barcodes
#' @param min_hamming Minimum required Hamming distance
#' @param prefix_length Length of the prefix used during generation
validate_barcode_distances <- function(barcodes, min_hamming, prefix_length = NULL) {
  n <- length(barcodes)
  if (n <= 1) return(invisible(NULL))

  barcode_len <- nchar(barcodes[1])

  # Use prefix-group validation if prefix_length is known
  if (!is.null(prefix_length) && prefix_length > 0 && prefix_length <= barcode_len) {
    prefixes <- substring(barcodes, 1, prefix_length)
    prefix_groups <- split(seq_len(n), prefixes)

    # Within each prefix group, check all pairs exhaustively
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
    # Full pairwise check for small sets or unknown prefix
    if (n > 5000) {
      cli::cli_alert_info("Large barcode set without prefix info; performing sampled check...")
      n_checks <- min(50000L, as.integer(n) * (as.integer(n) - 1L) / 2L)
      for (k in seq_len(n_checks)) {
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
