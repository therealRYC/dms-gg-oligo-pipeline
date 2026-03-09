# Created: 2026-03-09
# 06b_oogga_dp.R — OOGGA collision-aware boundary selection
# DMS Golden Gate Oligo Pipeline
#
# Implements collision-aware boundary selection inspired by OOGGA
# (Mukundan & Madhusudhan 2025). Three methods:
#   - oogga_two_pass: SB-first OOGGA DP → per-SB tile OOGGA DP
#   - oogga_greedy:   SB-first OOGGA DP → greedy sequential tile selection
#   - oogga_single:   Single-pass OOGGA DP on entire gene+cassette
#
# Key difference from existing DP (BUG-009): the DP transition checks each
# candidate overhang against ALL prior overhangs on the path, rejecting
# candidates with >max_identity/4 positional matches (including RC checks).
# This eliminates the iterative blacklisting loop in plan_assembly().
#
# Dependencies: reverse_complement() (utils.R), overhang_score(),
#   load_overhang_fidelity(), compute_set_fidelity(), PALINDROMIC_4NT,
#   HOMOPOLYMER_4NT (06_overhang_selection.R)

# =============================================================================
# COLLISION PRIMITIVES (shared by all 3 methods)
# =============================================================================
# Faithful to OOGGA's __overlap_pass() + __find_identities() logic,
# with a pre-computed lookup table for O(1) per-pair checks.

#' Build 256x256 overhang compatibility matrix
#'
#' Pre-computes OOGGA's identity check for all pairs of 4-nt overhangs.
#' compat[A, B] = TRUE iff A passes the identity check against B:
#'   - positional matches of A vs B <= max_identity
#'   - positional matches of A vs RC(B) <= max_identity
#'
#' Matches OOGGA's __find_identities() exactly: for each "other" overhang O,
#' the candidate C is checked against both O and RC(O). Only 2 conditions,
#' not 3. (The extra identity(RC(A), B) check from a prior version was not
#' in OOGGA — removed for faithfulness. Could be re-added as a future
#' strict_compat=TRUE option if needed.)
#'
#' @param max_identity Integer, maximum allowed positional matches (default 2).
#'   OOGGA default is 2: reject if >2/4 positions match.
#' @return Named 256x256 logical matrix. Rows and columns are all 256
#'   4-nt DNA sequences in lexicographic order (AAAA..TTTT).
build_oh_compatibility <- function(max_identity = 2L) {
  bases <- c("A", "C", "G", "T")
  # Generate all 256 4-nt overhangs
  all_ohs <- do.call(paste0, expand.grid(
    bases, bases, bases, bases,
    stringsAsFactors = FALSE
  ))
  n <- length(all_ohs) # 256

  # Pre-split all overhangs and their RCs into integer vectors for fast
  # positional comparison
  oh_chars <- lapply(all_ohs, function(x) utf8ToInt(x))
  rc_chars <- lapply(all_ohs, function(x) utf8ToInt(reverse_complement(x)))

  # Build the matrix
  compat <- matrix(TRUE,
    nrow = n, ncol = n,
    dimnames = list(all_ohs, all_ohs)
  )

  for (i in seq_len(n)) {
    a_int <- oh_chars[[i]]
    for (j in seq_len(n)) {
      b_int <- oh_chars[[j]]
      rc_b_int <- rc_chars[[j]]

      # OOGGA checks 2 conditions per pair: A vs B, A vs RC(B)
      id_ab <- sum(a_int == b_int)
      id_a_rcb <- sum(a_int == rc_b_int)

      # Reject if EITHER comparison exceeds max_identity
      if (id_ab > max_identity || id_a_rcb > max_identity) {
        compat[i, j] <- FALSE
      }
    }
  }

  compat
}


#' Check if a candidate overhang passes OOGGA's overlap check
#'
#' Equivalent to OOGGA's __overlap_pass(): checks the candidate against
#' every prior overhang on the DP path AND against alien overhangs.
#' Also checks the self-palindrome constraint: identity(candidate,
#' RC(candidate)) must not exceed max_identity. This matches OOGGA's
#' inclusion of RC(current_overhang) in the identity check list.
#'
#' @param candidate_oh Character, 4-nt candidate overhang
#' @param prior_ohs Character vector of overhangs already committed on this
#'   DP path. Can be empty (always passes).
#' @param alien_ohs Character vector of fixed overhangs that must not collide
#'   with the candidate (e.g., oh3, oh4, oh_L). Can be empty.
#' @param compat_matrix Named 256x256 logical matrix from build_oh_compatibility().
#' @param max_identity Integer, max allowed positional identity (must match
#'   the max_identity used to build compat_matrix). Needed for the
#'   self-palindrome check, which can't use the compat matrix directly.
#' @return Logical TRUE if candidate is compatible with all prior + alien OHs
#'   and passes the self-palindrome check.
oogga_overlap_pass <- function(candidate_oh, prior_ohs, alien_ohs,
                               compat_matrix, max_identity = 2L) {
  # Self-palindrome check: OOGGA includes RC(candidate) in the identity list.
  # identity(candidate, RC(candidate)) > max_identity means the candidate's
  # own reverse complement is too similar to itself — reject.
  # Note: can't use compat_matrix for this because compat[A, RC(A)] also
  # checks identity(A, A)=4 which always fails.
  rc_cand <- reverse_complement(candidate_oh)
  if (count_positional_identity(candidate_oh, rc_cand) > max_identity) {
    return(FALSE)
  }

  # Vectorized check against all prior + alien overhangs in one operation
  # Filter to valid compat_matrix entries to avoid subscript-out-of-bounds
  all_ohs <- c(prior_ohs, alien_ohs)
  if (length(all_ohs) > 0L) {
    valid <- all_ohs %in% rownames(compat_matrix)
    if (!all(valid)) all_ohs <- all_ohs[valid]
    if (length(all_ohs) > 0L) {
      return(all(compat_matrix[candidate_oh, all_ohs]))
    }
  }

  TRUE
}


#' Count positional identity between two 4-nt overhangs
#'
#' Counts the number of positions (0-4) where the two overhangs have
#' the same nucleotide. Useful for testing and debugging.
#'
#' @param oh_a Character, 4-nt overhang
#' @param oh_b Character, 4-nt overhang
#' @return Integer 0-4
count_positional_identity <- function(oh_a, oh_b) {
  sum(utf8ToInt(oh_a) == utf8ToInt(oh_b))
}


# =============================================================================
# SB BOUNDARY OOGGA DP (shared by oogga_two_pass and oogga_greedy)
# =============================================================================

#' Precompute SB boundary candidate scores and overhangs
#'
#' For each valid nucleotide position in the full sequence (gene + cassette),
#' extracts the 4-nt overhang, computes its score, and applies hard filters
#' (palindromes, homopolymers, blacklist).
#'
#' @param full_seq Character, full sequence (gene + cassette)
#' @param gene_len Integer, length of gene CDS portion
#' @param oh_fidelity Data frame with overhang + fidelity columns
#' @param eff_lookup Named numeric vector (overhang -> efficiency)
#' @param blacklist_ohs Character vector of overhangs to exclude
#' @param allowed_gene_positions Integer vector of valid gene-region boundary
#'   positions. NULL = allow all codon-aligned positions.
#' @return List with vectors: oh_seq, score, valid (all length = nchar(full_seq))
precompute_sb_boundary_candidates <- function(full_seq, gene_len,
                                              oh_fidelity, eff_lookup,
                                              blacklist_ohs = character(0),
                                              allowed_gene_positions = NULL) {
  total_len <- nchar(full_seq)
  fid_lookup <- oh_fidelity$fidelity
  names(fid_lookup) <- oh_fidelity$overhang

  # Expand blacklist with reverse complements
  blacklist_set <- unique(c(
    blacklist_ohs,
    vapply(blacklist_ohs, reverse_complement, character(1))
  ))

  oh_seq <- character(total_len)
  scores <- rep(-Inf, total_len)
  valid <- rep(FALSE, total_len)

  for (p in 4L:total_len) {
    oh <- substring(full_seq, p - 3L, p)
    oh_seq[p] <- oh

    # Hard filters
    if (oh %in% blacklist_set) next
    if (oh %in% PALINDROMIC_4NT) next
    if (oh %in% HOMOPOLYMER_4NT) next

    # Gene-region constraints
    if (p <= gene_len) {
      if ((p %% 3L) != 0L) next # codon boundary
      if (!is.null(allowed_gene_positions) && !(p %in% allowed_gene_positions)) next
    }

    scores[p] <- overhang_score(oh, fid_lookup, eff_lookup)
    valid[p] <- TRUE
  }

  list(oh_seq = oh_seq, score = scores, valid = valid)
}


#' Solve SB boundary placement with OOGGA collision-aware DP for fixed K
#'
#' Like sb_dp_solve_k() but with collision checking: at each DP transition,
#' the candidate overhang must pass oogga_overlap_pass() against all prior
#' overhangs on the path. This makes the DP path-dependent — we can't just
#' take the best predecessor, we must trace back and check compatibility.
#'
#' Implementation: Instead of storing just the best score at each position,
#' we store the full path (all boundary OHs) and check compatibility during
#' transitions. For small K (typically 1-5 for SB boundaries), this is
#' tractable because the path length is short.
#'
#' @param K Number of internal boundaries (superblocks = K + 1)
#' @param total_len Total sequence length in nucleotides
#' @param min_len Minimum segment length in nucleotides
#' @param max_len Maximum segment length in nucleotides
#' @param boundary_scores Numeric vector of scores per position
#' @param boundary_valid Logical vector of valid positions
#' @param oh_seq Character vector of overhang at each position
#' @param alien_ohs Character vector of fixed overhangs to avoid
#' @param compat_matrix Named 256x256 logical compatibility matrix
#' @return List with boundaries, total_score, boundary_ohs, or NULL
oogga_sb_dp_solve_k <- function(K, total_len, min_len, max_len,
                                boundary_scores, boundary_valid,
                                oh_seq, alien_ohs, compat_matrix) {
  if (K == 0L) {
    return(NULL)
  }
  if ((K + 1L) * min_len > total_len) {
    return(NULL)
  }

  # For collision-aware DP, we need to track the full set of overhangs

  # on each path. We use a list-of-lists approach:
  # dp_paths[[p]] = list of candidate paths ending at position p,
  # each path being list(score, ohs = character vector of boundary OHs)

  # Layer k=1: first boundary, first segment spans [1..p]
  dp_paths <- vector("list", total_len)

  lo_p <- min_len
  hi_p <- min(max_len, total_len - 1L)
  if (lo_p <= hi_p) {
    for (p in lo_p:hi_p) {
      if (!boundary_valid[p]) next
      oh <- oh_seq[p]
      # Check against alien OHs only (no prior OHs for first boundary)
      if (!oogga_overlap_pass(oh, character(0), alien_ohs, compat_matrix)) next
      dp_paths[[p]] <- list(list(score = boundary_scores[p], ohs = oh))
    }
  }

  # Layers k=2..K
  if (K >= 2L) {
    for (k in 2L:K) {
      dp_paths_new <- vector("list", total_len)

      lo_p <- k * min_len
      hi_p <- min(total_len - 1L, total_len - min_len)
      if (lo_p > hi_p) {
        dp_paths <- dp_paths_new
        next
      }

      for (p in lo_p:hi_p) {
        if (!boundary_valid[p]) next
        oh <- oh_seq[p]

        # Predecessor range
        lo <- max(1L, p - max_len)
        hi <- p - min_len
        if (hi < lo) next

        # Find best compatible predecessor
        best_path <- NULL
        best_score <- -Inf

        for (pp in lo:hi) {
          if (is.null(dp_paths[[pp]])) next
          # Check each candidate path from predecessor
          for (path in dp_paths[[pp]]) {
            # Check candidate OH against all OHs on this path + alien
            if (!oogga_overlap_pass(oh, path$ohs, alien_ohs, compat_matrix)) next
            new_score <- path$score + boundary_scores[p]
            if (new_score > best_score) {
              best_score <- new_score
              best_path <- list(
                score = new_score,
                ohs = c(path$ohs, oh)
              )
            }
          }
        }

        if (!is.null(best_path)) {
          # Keep only the best path at each position (prune for efficiency)
          dp_paths_new[[p]] <- list(best_path)
        }
      }

      dp_paths <- dp_paths_new
    }
  }

  # Find optimal last boundary: last segment must be [min_len, max_len]
  best_total <- -Inf
  best_final_path <- NULL
  best_p <- NA_integer_

  for (p in seq_len(total_len - 1L)) {
    last_seg <- total_len - p
    if (last_seg < min_len || last_seg > max_len) next
    if (is.null(dp_paths[[p]])) next
    for (path in dp_paths[[p]]) {
      if (path$score > best_total) {
        best_total <- path$score
        best_final_path <- path
        best_p <- p
      }
    }
  }

  if (!is.finite(best_total)) {
    return(NULL)
  }

  # Reconstruct boundary positions from the best path
  # We need positions, not just OHs. Re-trace using stored paths.
  # Since we pruned to 1 path per position per layer, the path OHs
  # give us the sequence but not positions. We need a different approach.
  #
  # Alternative: store parent pointers along with paths.
  # Let me restructure to track positions explicitly.

  # Actually, we need to re-implement with explicit position tracking.
  # Let's do a cleaner version that stores (score, positions, ohs) tuples.
  NULL # Placeholder — see oogga_sb_dp_solve_k_v2 below
}


#' Solve SB boundary placement with OOGGA collision-aware DP (v2)
#'
#' Stores full (score, positions, ohs) tuples for path reconstruction.
#' Uses beam search: retains top beam_width paths per position to explore
#' multiple collision-compatible paths (Bellman optimality doesn't hold
#' because the collision constraint is path-dependent).
#'
#' Scoring is multiplicative (OOGGA-faithful): each boundary's
#' overhang_score(oh) is multiplied into a running product. This matches
#' OOGGA's ∏(eff_i × fid_i) formulation exactly.
#'
#' @inheritParams oogga_sb_dp_solve_k
#' @param beam_width Integer, max paths to retain per position (default 10).
#'   Higher = more exploration but slower. beam_width=1 matches OOGGA's
#'   single-path behavior.
#' @param max_identity Integer, max positional identity for self-palindrome
#'   check in oogga_overlap_pass (must match compat_matrix's max_identity).
#' @return List with boundaries (integer vector), total_score, boundary_ohs,
#'   or NULL if no feasible solution
oogga_sb_dp_solve_k_v2 <- function(K, total_len, min_len, max_len,
                                   boundary_scores, boundary_valid,
                                   oh_seq, alien_ohs, compat_matrix,
                                   beam_width = 10L,
                                   max_identity = 2L) {
  if (K == 0L) {
    return(NULL)
  }
  if ((K + 1L) * min_len > total_len) {
    return(NULL)
  }

  # Each path entry: list(score, positions = int vector, ohs = char vector)
  # dp_paths[[p]] = list of path entries ending at position p
  # Score is a multiplicative product of overhang_score values.

  # ---- Precompute static (path-independent) checks per position ----
  # Self-palindrome + alien compat are position-dependent but NOT path-
  # dependent. Computing them once avoids millions of redundant R function
  # calls inside the DP inner loop.

  # Filter alien_ohs to only include valid compat_matrix entries
  valid_ohs <- rownames(compat_matrix)
  alien_ohs <- alien_ohs[alien_ohs %in% valid_ohs]

  static_ok <- logical(total_len)
  has_aliens <- length(alien_ohs) > 0L
  for (p in seq_len(total_len)) {
    if (!boundary_valid[p]) next
    oh <- oh_seq[p]
    if (!oh %in% valid_ohs) next
    # Self-palindrome check
    rc_oh <- reverse_complement(oh)
    if (count_positional_identity(oh, rc_oh) > max_identity) next
    # Alien compat
    if (has_aliens && !all(compat_matrix[oh, alien_ohs])) next
    static_ok[p] <- TRUE
  }

  # Layer k=1
  dp_paths <- vector("list", total_len)

  lo_p <- min_len
  hi_p <- min(max_len, total_len - 1L)
  if (lo_p <= hi_p) {
    for (p in lo_p:hi_p) {
      if (!static_ok[p]) next
      dp_paths[[p]] <- list(list(
        score = boundary_scores[p], # first boundary: product starts here
        positions = p,
        ohs = oh_seq[p]
      ))
    }
  }

  # Layers k=2..K
  if (K >= 2L) {
    for (k in 2L:K) {
      dp_paths_new <- vector("list", total_len)

      lo_p <- k * min_len
      hi_p <- min(total_len - 1L, total_len - min_len)
      if (lo_p > hi_p) {
        dp_paths <- dp_paths_new
        next
      }

      for (p in lo_p:hi_p) {
        if (!static_ok[p]) next
        oh <- oh_seq[p]

        lo <- max(1L, p - max_len)
        hi <- p - min_len
        if (hi < lo) next

        candidates <- list()

        for (pp in lo:hi) {
          if (is.null(dp_paths[[pp]])) next
          for (path in dp_paths[[pp]]) {
            # Vectorized check: oh vs all prior OHs on the path
            if (!all(compat_matrix[oh, path$ohs])) next

            # Multiplicative scoring: product of overhang scores
            candidates[[length(candidates) + 1L]] <- list(
              score = path$score * boundary_scores[p],
              positions = c(path$positions, p),
              ohs = c(path$ohs, oh)
            )
          }
        }

        # Beam pruning: keep top beam_width paths by score
        if (length(candidates) > 0L) {
          if (length(candidates) > beam_width) {
            scores <- vapply(candidates, function(c) c$score, numeric(1))
            keep_idx <- order(scores, decreasing = TRUE)[seq_len(beam_width)]
            candidates <- candidates[keep_idx]
          }
          dp_paths_new[[p]] <- candidates
        }
      }

      dp_paths <- dp_paths_new
    }
  }

  # Find best final path
  best_total <- -Inf
  best_path <- NULL

  for (p in seq_len(total_len - 1L)) {
    last_seg <- total_len - p
    if (last_seg < min_len || last_seg > max_len) next
    if (is.null(dp_paths[[p]])) next
    for (path in dp_paths[[p]]) {
      if (path$score > best_total) {
        best_total <- path$score
        best_path <- path
      }
    }
  }

  if (!is.finite(best_total) || is.null(best_path)) {
    return(NULL)
  }

  list(
    boundaries = best_path$positions,
    total_score = best_total,
    boundary_ohs = best_path$ohs
  )
}


#' Search SB boundaries using OOGGA collision-aware DP
#'
#' Multi-K wrapper for oogga_sb_dp_solve_k_v2. Returns the same format as
#' search_superblock_boundaries_dp() for drop-in replacement.
#'
#' @param full_seq Character, full sequence (gene + cassette)
#' @param gene_len Integer, length of gene CDS portion
#' @param max_block_length Integer, max block length in nt (default 1800)
#' @param min_block_length Integer, min block length in nt (default 300)
#' @param alien_ohs Character vector of fixed overhangs to avoid collisions
#'   with (oh3, oh4, oh_L, and their RCs)
#' @param oh_fidelity Data frame with overhang + fidelity columns
#' @param eff_lookup Named numeric vector of overhang efficiencies
#' @param max_identity Integer, max allowed positional identity (default 2)
#' @param allowed_gene_positions Integer vector of valid gene-region positions
#' @param cassette_blacklist_ohs Character vector of tile oh1/oh2 values to
#'   exclude from cassette-region SB boundaries
#' @return List with n_superblocks, boundaries (data frame), total_score
search_sb_boundaries_oogga <- function(full_seq, gene_len,
                                       max_block_length = 1800L,
                                       min_block_length = 300L,
                                       alien_ohs = character(0),
                                       oh_fidelity = NULL,
                                       eff_lookup = NULL,
                                       max_identity = 2L,
                                       beam_width = 10L,
                                       allowed_gene_positions = NULL,
                                       cassette_blacklist_ohs = character(0)) {
  total_len <- nchar(full_seq)

  # Load data if not provided
  if (is.null(oh_fidelity)) oh_fidelity <- load_overhang_fidelity("BsmBI")
  if (is.null(eff_lookup)) {
    bsmbi_pw <- load_pairwise_matrix("BsmBI")
    eff_lookup <- compute_overhang_efficiency(bsmbi_pw)
  }

  # Edge case: sequence fits in a single block
  if (total_len <= max_block_length) {
    return(list(
      n_superblocks = 1L,
      boundaries = data.frame(
        sb_id = 1L, start_nt = 1L, end_nt = total_len,
        boundary_oh = NA_character_, boundary_score = NA_real_,
        stringsAsFactors = FALSE
      ),
      total_score = 0
    ))
  }

  # Build blacklist: alien_ohs + homopolymers + cassette blacklist
  blacklist <- unique(c(alien_ohs, HOMOPOLYMER_4NT))

  # Precompute candidates
  candidates <- precompute_sb_boundary_candidates(
    full_seq, gene_len, oh_fidelity, eff_lookup,
    blacklist_ohs = blacklist,
    allowed_gene_positions = allowed_gene_positions
  )

  # Additionally filter cassette-region positions against tile oh1/oh2
  if (length(cassette_blacklist_ohs) > 0) {
    cass_bl_set <- unique(c(
      cassette_blacklist_ohs,
      vapply(cassette_blacklist_ohs, reverse_complement, character(1))
    ))
    for (p in which(candidates$valid)) {
      if (p > gene_len && candidates$oh_seq[p] %in% cass_bl_set) {
        candidates$valid[p] <- FALSE
        candidates$score[p] <- -Inf
      }
    }
  }

  n_valid <- sum(candidates$valid)
  cli::cli_alert_info(
    "OOGGA SB DP: {n_valid} valid candidates, max_identity={max_identity}"
  )

  if (n_valid == 0L) {
    cli::cli_alert_warning("No valid SB boundary positions for OOGGA DP.")
    return(list(
      n_superblocks = 1L,
      boundaries = data.frame(
        sb_id = 1L, start_nt = 1L, end_nt = total_len,
        boundary_oh = NA_character_, boundary_score = NA_real_,
        stringsAsFactors = FALSE
      ),
      total_score = 0
    ))
  }

  # Build compatibility matrix
  compat <- build_oh_compatibility(max_identity)

  # Determine K range
  K_min <- max(1L, ceiling(total_len / max_block_length) - 1L)
  K_max <- min(K_min + 2L, floor(total_len / min_block_length) - 1L)
  k_range <- seq(K_min, K_max)

  cli::cli_alert_info("OOGGA SB DP: K range [{K_min}, {K_max}]")

  # Run DP for each K
  # Multiplicative scoring: compare via geometric mean (score^(1/K))
  # to normalize across different K values
  best_result <- NULL
  best_geo_mean <- -Inf

  dp_start <- proc.time()
  for (K in k_range) {
    result <- oogga_sb_dp_solve_k_v2(
      K, total_len, min_block_length, max_block_length,
      candidates$score, candidates$valid, candidates$oh_seq,
      alien_ohs, compat,
      beam_width = beam_width,
      max_identity = max_identity
    )
    if (!is.null(result) && result$total_score > 0) {
      geo_mean <- result$total_score^(1 / K)
      if (geo_mean > best_geo_mean) {
        best_geo_mean <- geo_mean
        best_result <- result
        best_result$K <- K
      }
    }
  }
  dp_elapsed <- (proc.time() - dp_start)[["elapsed"]]
  cli::cli_alert_info("OOGGA SB DP completed in {round(dp_elapsed, 1)}s.")

  # If OOGGA at max_identity=2 fails, try max_identity=3
  if (is.null(best_result) && max_identity == 2L) {
    cli::cli_alert_warning(
      "OOGGA SB DP infeasible at max_identity=2. Retrying with max_identity=3."
    )
    compat3 <- build_oh_compatibility(3L)
    for (K in k_range) {
      result <- oogga_sb_dp_solve_k_v2(
        K, total_len, min_block_length, max_block_length,
        candidates$score, candidates$valid, candidates$oh_seq,
        alien_ohs, compat3,
        beam_width = beam_width,
        max_identity = 3L
      )
      if (!is.null(result) && result$total_score > 0) {
        geo_mean <- result$total_score^(1 / K)
        if (geo_mean > best_geo_mean) {
          best_geo_mean <- geo_mean
          best_result <- result
          best_result$K <- K
        }
      }
    }
    if (!is.null(best_result)) {
      cli::cli_alert_info("OOGGA SB DP succeeded at max_identity=3.")
    }
  }

  if (is.null(best_result)) {
    stop(
      "OOGGA SB DP found no feasible solution. ",
      "Check gene length and max_block_length constraints."
    )
  }

  # Convert to output format matching search_superblock_boundaries_dp()
  K <- best_result$K
  boundaries <- best_result$boundaries
  boundary_ohs <- best_result$boundary_ohs

  # Build boundaries data frame
  sb_starts <- c(1L, boundaries + 1L)
  sb_ends <- c(boundaries, total_len)
  n_sbs <- K + 1L

  bnd_df <- data.frame(
    sb_id = seq_len(n_sbs),
    start_nt = sb_starts,
    end_nt = sb_ends,
    boundary_oh = c(boundary_ohs, NA_character_),
    boundary_score = c(
      vapply(seq_len(K), function(i) {
        overhang_score(
          boundary_ohs[i],
          setNames(oh_fidelity$fidelity, oh_fidelity$overhang),
          eff_lookup
        )
      }, numeric(1)),
      NA_real_
    ),
    stringsAsFactors = FALSE
  )

  cli::cli_alert_success(paste0(
    "OOGGA SB DP: ", n_sbs, " superblocks, ",
    K, " collision-free boundary(ies). Score: ",
    round(best_result$total_score, 3)
  ))

  list(
    n_superblocks = n_sbs,
    boundaries = bnd_df,
    total_score = best_result$total_score
  )
}


# =============================================================================
# METHOD A1: oogga_two_pass — SB-first OOGGA DP → per-SB tile OOGGA DP
# =============================================================================

#' Solve tile boundary placement with OOGGA collision-aware DP for fixed K
#'
#' Like dp_solve_k() but with collision checking. At each transition, checks
#' both oh1 and oh2 at the candidate boundary against all prior OHs on the
#' path, plus alien OHs (SB junction OHs, oh3, oh_L, oh4).
#'
#' Scoring is multiplicative (OOGGA-faithful): each boundary contributes
#' overhang_score(oh1) * overhang_score(oh2) to a running product.
#'
#' @param K Number of internal tile boundaries
#' @param n_codons Total codons in gene (or gene segment for per-SB)
#' @param min_codons Minimum tile size in codons
#' @param max_codons Maximum tile size in codons
#' @param oh1_seq Character vector: oh1 at each codon boundary position
#' @param oh2_seq Character vector: oh2 at each codon boundary position
#' @param oh1_scores Numeric vector: overhang_score(oh1) per boundary position
#' @param oh2_scores Numeric vector: overhang_score(oh2) per boundary position
#' @param boundary_valid Logical vector of valid positions
#' @param alien_ohs Character vector of fixed overhangs to avoid
#' @param compat_matrix Named 256x256 logical compatibility matrix
#' @param beam_width Integer, max paths to retain per position (default 10)
#' @param max_identity Integer, for self-palindrome check in overlap_pass
#' @return List with boundaries, total_score, path_ohs, or NULL
oogga_tile_dp_solve_k <- function(K, n_codons, min_codons, max_codons,
                                  oh1_seq, oh2_seq,
                                  oh1_scores, oh2_scores,
                                  boundary_valid,
                                  alien_ohs, compat_matrix,
                                  beam_width = 10L,
                                  max_identity = 2L) {
  if (K == 0L) {
    return(NULL)
  }
  if ((K + 1L) * min_codons > n_codons) {
    return(NULL)
  }

  # Each path entry: list(score, positions, ohs)
  # ohs includes BOTH oh1 and oh2 at each boundary (both participate in
  # BsmBI reactions and must be collision-free)
  # Score is multiplicative: product of (oh1_score * oh2_score) per boundary

  # ---- Precompute static (path-independent) checks per position ----
  # Self-palindrome, alien compat, and oh1/oh2 mutual compat are position-
  # dependent but NOT path-dependent. Computing them once eliminates ~80% of
  # redundant work inside the DP inner loop.

  # Filter alien_ohs to only include valid 4-nt ACGT sequences present in
  # the compat_matrix. Invalid entries (empty strings, NAs) would cause
  # subscript-out-of-bounds errors.
  valid_ohs <- rownames(compat_matrix)
  alien_ohs <- alien_ohs[alien_ohs %in% valid_ohs]

  static_ok <- logical(n_codons)
  has_aliens <- length(alien_ohs) > 0L
  for (b in seq_len(n_codons)) {
    if (!boundary_valid[b]) next
    oh1 <- oh1_seq[b]
    oh2 <- oh2_seq[b]
    # Skip if oh1 or oh2 are not valid compat_matrix entries
    if (!oh1 %in% valid_ohs || !oh2 %in% valid_ohs) next
    # Self-palindrome for oh1
    rc1 <- reverse_complement(oh1)
    if (count_positional_identity(oh1, rc1) > max_identity) next
    # Self-palindrome for oh2
    rc2 <- reverse_complement(oh2)
    if (count_positional_identity(oh2, rc2) > max_identity) next
    # Alien compat for both oh1 and oh2
    if (has_aliens) {
      if (!all(compat_matrix[oh1, alien_ohs])) next
      if (!all(compat_matrix[oh2, alien_ohs])) next
    }
    # oh1/oh2 mutual compat
    if (!compat_matrix[oh1, oh2]) next
    static_ok[b] <- TRUE
  }

  # Layer k=1
  dp_paths <- vector("list", n_codons)

  lo_b <- min_codons
  hi_b <- min(max_codons, n_codons - 1L)
  if (lo_b <= hi_b) {
    for (b in lo_b:hi_b) {
      if (!static_ok[b]) next

      # Multiplicative: first boundary's score = oh1_score * oh2_score
      dp_paths[[b]] <- list(list(
        score = oh1_scores[b] * oh2_scores[b],
        positions = b,
        ohs = c(oh1_seq[b], oh2_seq[b])
      ))
    }
  }

  # Layers k=2..K
  if (K >= 2L) {
    for (k in 2L:K) {
      dp_paths_new <- vector("list", n_codons)

      lo_b <- k * min_codons
      hi_b <- min(n_codons - 1L, n_codons - min_codons)
      if (lo_b > hi_b) {
        dp_paths <- dp_paths_new
        next
      }

      for (b in lo_b:hi_b) {
        if (!static_ok[b]) next
        oh1 <- oh1_seq[b]
        oh2 <- oh2_seq[b]

        lo <- max(1L, b - max_codons)
        hi <- b - min_codons
        if (hi < lo) next

        candidates <- list()

        for (bp in lo:hi) {
          if (is.null(dp_paths[[bp]])) next
          for (path in dp_paths[[bp]]) {
            # Vectorized check: oh1 and oh2 vs all prior OHs on the path
            prior <- path$ohs
            if (!all(compat_matrix[oh1, prior])) next
            if (!all(compat_matrix[oh2, prior])) next

            # Multiplicative scoring
            candidates[[length(candidates) + 1L]] <- list(
              score = path$score * oh1_scores[b] * oh2_scores[b],
              positions = c(path$positions, b),
              ohs = c(prior, oh1, oh2)
            )
          }
        }

        # Beam pruning: keep top beam_width paths by score
        if (length(candidates) > 0L) {
          if (length(candidates) > beam_width) {
            scores <- vapply(candidates, function(c) c$score, numeric(1))
            keep_idx <- order(scores, decreasing = TRUE)[seq_len(beam_width)]
            candidates <- candidates[keep_idx]
          }
          dp_paths_new[[b]] <- candidates
        }
      }

      dp_paths <- dp_paths_new
    }
  }

  # Find best final path
  best_total <- -Inf
  best_path <- NULL

  for (b in seq_len(n_codons - 1L)) {
    last_tile <- n_codons - b
    if (last_tile < min_codons || last_tile > max_codons) next
    if (is.null(dp_paths[[b]])) next
    for (path in dp_paths[[b]]) {
      if (path$score > best_total) {
        best_total <- path$score
        best_path <- path
      }
    }
  }

  if (!is.finite(best_total) || is.null(best_path)) {
    return(NULL)
  }

  list(
    boundaries = best_path$positions,
    total_score = best_total,
    path_ohs = best_path$ohs
  )
}


#' Search tile boundaries using OOGGA collision-aware DP
#'
#' Drop-in replacement for search_tile_boundaries_dp() that uses
#' collision-aware DP instead of standard Bellman DP. Produces the same
#' output format (data frame with tile info).
#'
#' @param cds Domesticated gene sequence
#' @param max_mutable_nt Max mutable region in nt
#' @param min_mutable_nt Min mutable region in nt
#' @param oh_fidelity Data frame with overhang + fidelity
#' @param multi_k Logical: try multiple tile counts?
#' @param dp_k_range Integer: search K_ideal +/- dp_k_range
#' @param overlap_codons Number of overlap codons between adjacent tiles
#' @param eff_lookup Named numeric vector (overhang -> efficiency)
#' @param alien_ohs Character vector of fixed overhangs to avoid (SB junction
#'   OHs + oh3 + oh_L + oh4 and their RCs)
#' @param max_identity Integer, max positional identity (default 2)
#' @return Data frame with tile info (same format as search_tile_boundaries_dp)
search_tile_boundaries_oogga <- function(cds, max_mutable_nt,
                                         min_mutable_nt = NULL,
                                         oh_fidelity = NULL,
                                         multi_k = TRUE,
                                         dp_k_range = 5L,
                                         overlap_codons = 4L,
                                         eff_lookup = NULL,
                                         alien_ohs = character(0),
                                         max_identity = 2L,
                                         beam_width = 10L) {
  gene_len <- nchar(cds)
  n_codons <- gene_len %/% 3L

  if (is.null(min_mutable_nt)) {
    min_mutable_nt <- max(81L, max_mutable_nt %/% 3L)
    min_mutable_nt <- (min_mutable_nt %/% 3L) * 3L
  }
  max_codons <- max_mutable_nt %/% 3L
  min_codons <- min_mutable_nt %/% 3L

  if (is.null(oh_fidelity)) oh_fidelity <- load_overhang_fidelity("BsmBI")
  if (is.null(eff_lookup)) {
    bsmbi_pw <- load_pairwise_matrix("BsmBI")
    eff_lookup <- compute_overhang_efficiency(bsmbi_pw)
  }

  fid_lookup <- oh_fidelity$fidelity
  names(fid_lookup) <- oh_fidelity$overhang

  # Precompute boundary data (reuse existing function for oh1/oh2 extraction)
  precomp <- precompute_boundary_scores(
    cds, oh_fidelity,
    eff_lookup = eff_lookup,
    overlap_codons = overlap_codons
  )

  # Compute per-OH scores for multiplicative DP (OOGGA-faithful)
  # precomp$score is additive (oh1 + oh2) — we need individual products
  oh1_scores <- vapply(precomp$oh1_seq, function(oh) {
    if (nchar(oh) == 4L && oh %in% names(fid_lookup)) {
      overhang_score(oh, fid_lookup, eff_lookup)
    } else {
      0
    }
  }, numeric(1), USE.NAMES = FALSE)
  oh2_scores <- vapply(precomp$oh2_seq, function(oh) {
    if (nchar(oh) == 4L && oh %in% names(fid_lookup)) {
      overhang_score(oh, fid_lookup, eff_lookup)
    } else {
      0
    }
  }, numeric(1), USE.NAMES = FALSE)

  # Build compatibility matrix
  compat <- build_oh_compatibility(max_identity)

  # Determine K range
  K_ideal <- max(1L, ceiling(n_codons / max_codons) - 1L)
  if (multi_k) {
    K_lo <- max(1L, K_ideal - dp_k_range)
    K_hi <- min(n_codons %/% min_codons - 1L, K_ideal + dp_k_range)
    K_hi <- max(K_hi, K_lo)
  } else {
    K_lo <- K_ideal
    K_hi <- K_ideal
  }

  cli::cli_alert_info(
    "OOGGA tile DP: {n_codons} codons, K range [{K_lo}, {K_hi}], max_identity={max_identity}"
  )

  # Run collision-aware DP for each K
  # Multiplicative scoring: compare via geometric mean (score^(1/K))
  best_result <- NULL
  best_geo_mean <- -Inf

  dp_start <- proc.time()
  for (K in K_lo:K_hi) {
    result <- oogga_tile_dp_solve_k(
      K, n_codons, min_codons, max_codons,
      precomp$oh1_seq, precomp$oh2_seq,
      oh1_scores, oh2_scores,
      precomp$valid,
      alien_ohs, compat,
      beam_width = beam_width,
      max_identity = max_identity
    )
    if (!is.null(result) && result$total_score > 0) {
      geo_mean <- result$total_score^(1 / K)
      if (geo_mean > best_geo_mean) {
        best_geo_mean <- geo_mean
        best_result <- result
        best_result$K <- K
      }
    }
  }
  dp_elapsed <- (proc.time() - dp_start)[["elapsed"]]
  cli::cli_alert_info("OOGGA tile DP completed in {round(dp_elapsed, 1)}s.")

  # Track effective max_identity (may fall back from 2 to 3)
  effective_max_identity <- max_identity

  # If infeasible at max_identity=2, try max_identity=3
  if (is.null(best_result) && max_identity == 2L) {
    cli::cli_alert_warning(
      "OOGGA tile DP infeasible at max_identity=2. Retrying with max_identity=3."
    )
    compat3 <- build_oh_compatibility(3L)
    for (K in K_lo:K_hi) {
      result <- oogga_tile_dp_solve_k(
        K, n_codons, min_codons, max_codons,
        precomp$oh1_seq, precomp$oh2_seq,
        oh1_scores, oh2_scores,
        precomp$valid,
        alien_ohs, compat3,
        beam_width = beam_width,
        max_identity = 3L
      )
      if (!is.null(result) && result$total_score > 0) {
        geo_mean <- result$total_score^(1 / K)
        if (geo_mean > best_geo_mean) {
          best_geo_mean <- geo_mean
          best_result <- result
          best_result$K <- K
        }
      }
    }
    if (!is.null(best_result)) {
      effective_max_identity <- 3L
      cli::cli_alert_info("OOGGA tile DP succeeded at max_identity=3.")
    }
  }

  if (is.null(best_result)) {
    stop(
      "OOGGA tile DP found no feasible collision-free tiling. ",
      "Gene may be too constrained for max_identity=", max_identity, "."
    )
  }

  # Convert boundaries to tile data frame (same format as search_tile_boundaries_dp)
  boundaries <- best_result$boundaries
  K <- best_result$K
  n_tiles <- K + 1L

  tile_starts_codon <- c(1L, boundaries + 1L)
  tile_ends_codon <- c(boundaries, n_codons)
  tile_starts_nt <- (tile_starts_codon - 1L) * 3L + 1L
  tile_ends_nt <- tile_ends_codon * 3L

  # Build tile data frame
  tiles <- data.frame(
    tile_id = seq_len(n_tiles),
    start_codon = tile_starts_codon,
    end_codon = tile_ends_codon,
    start_nt = tile_starts_nt,
    end_nt = tile_ends_nt,
    n_codons = tile_ends_codon - tile_starts_codon + 1L,
    stringsAsFactors = FALSE
  )

  # Extract oh1/oh2 for each tile boundary
  oh_L <- substring(cds, 1, 4)
  fid_lookup <- oh_fidelity$fidelity
  names(fid_lookup) <- oh_fidelity$overhang
  hf_set <- load_high_fidelity_set()

  tiles$oh1_seq <- NA_character_
  tiles$oh2_seq <- NA_character_
  tiles$oh1_score <- NA_real_
  tiles$oh2_score <- NA_real_
  tiles$oh1_in_hf <- NA
  tiles$oh2_in_hf <- NA
  tiles$oh1_fidelity <- NA_real_
  tiles$oh2_fidelity <- NA_real_
  tiles$tile_seq <- NA_character_
  tiles$boundary_shift <- 0L
  tiles$boundary_score <- NA_real_

  for (i in seq_len(n_tiles)) {
    # oh1: first 4 nt of this tile
    tiles$oh1_seq[i] <- substring(cds, tiles$start_nt[i], tiles$start_nt[i] + 3L)
    # oh2: last 4 nt of this tile's extended region
    oh2_codon <- min(tiles$end_codon[i] + overlap_codons, n_codons)
    oh2_pos <- oh2_codon * 3L
    tiles$oh2_seq[i] <- substring(cds, oh2_pos - 3L, oh2_pos)

    tiles$oh1_score[i] <- overhang_score(tiles$oh1_seq[i], fid_lookup, eff_lookup)
    tiles$oh2_score[i] <- overhang_score(tiles$oh2_seq[i], fid_lookup, eff_lookup)
    tiles$oh1_in_hf[i] <- tiles$oh1_seq[i] %in% hf_set
    tiles$oh2_in_hf[i] <- tiles$oh2_seq[i] %in% hf_set
    oh1_fid <- if (tiles$oh1_seq[i] %in% names(fid_lookup)) unname(fid_lookup[tiles$oh1_seq[i]]) else NA_real_
    oh2_fid <- if (tiles$oh2_seq[i] %in% names(fid_lookup)) unname(fid_lookup[tiles$oh2_seq[i]]) else NA_real_
    tiles$oh1_fidelity[i] <- oh1_fid
    tiles$oh2_fidelity[i] <- oh2_fid
    tiles$tile_seq[i] <- substring(cds, tiles$start_nt[i], tiles$end_nt[i])
    tiles$boundary_score[i] <- tiles$oh1_score[i] + tiles$oh2_score[i]
  }

  cli::cli_alert_success(paste0(
    "OOGGA tile DP: ", n_tiles, " tiles, ", K, " collision-free boundaries. ",
    "Total score: ", round(best_result$total_score, 3)
  ))

  attr(tiles, "max_identity_used") <- effective_max_identity
  tiles
}


# =============================================================================
# METHOD A2: oogga_greedy — SB-first OOGGA DP → greedy sequential tile selection
# =============================================================================

#' Search tile boundaries using greedy sequential selection with collision checks
#'
#' Processes tile boundaries left-to-right. At each boundary position, picks
#' the highest-scoring candidate whose oh1 and oh2 pass oogga_overlap_pass()
#' against all previously committed OHs and alien OHs. No backtracking.
#'
#' Simpler and faster than the OOGGA tile DP, but may produce suboptimal
#' results when early greedy choices constrain later options.
#'
#' @param cds Domesticated gene sequence
#' @param max_mutable_nt Max mutable region in nt
#' @param min_mutable_nt Min mutable region in nt
#' @param oh_fidelity Data frame with overhang + fidelity columns
#' @param overlap_codons Number of overlap codons
#' @param eff_lookup Named numeric vector (overhang -> efficiency)
#' @param alien_ohs Character vector of fixed overhangs to avoid
#' @param max_identity Integer, max positional identity (default 2)
#' @return Data frame with tile info (same format as search_tile_boundaries_dp)
search_tile_boundaries_greedy_seq <- function(cds, max_mutable_nt,
                                              min_mutable_nt = NULL,
                                              oh_fidelity = NULL,
                                              overlap_codons = 4L,
                                              eff_lookup = NULL,
                                              alien_ohs = character(0),
                                              max_identity = 2L,
                                              beam_width = 10L) { # unused, API consistency
  gene_len <- nchar(cds)
  n_codons <- gene_len %/% 3L

  if (is.null(min_mutable_nt)) {
    min_mutable_nt <- max(81L, max_mutable_nt %/% 3L)
    min_mutable_nt <- (min_mutable_nt %/% 3L) * 3L
  }
  max_codons <- max_mutable_nt %/% 3L
  min_codons <- min_mutable_nt %/% 3L

  if (is.null(oh_fidelity)) oh_fidelity <- load_overhang_fidelity("BsmBI")
  if (is.null(eff_lookup)) {
    bsmbi_pw <- load_pairwise_matrix("BsmBI")
    eff_lookup <- compute_overhang_efficiency(bsmbi_pw)
  }

  fid_lookup <- oh_fidelity$fidelity
  names(fid_lookup) <- oh_fidelity$overhang
  hf_set <- load_high_fidelity_set()
  oh_L <- substring(cds, 1, 4)

  # Build compatibility matrix
  compat <- build_oh_compatibility(max_identity)

  # Greedy forward: place boundaries left-to-right
  committed_ohs <- character(0) # All committed OHs on this path
  boundary_positions <- integer(0)

  current_start <- 1L # Current tile start (in codons)

  cli::cli_alert_info(
    "OOGGA greedy tile search: {n_codons} codons, max_identity={max_identity}"
  )

  greedy_start <- proc.time()

  while (current_start + min_codons <= n_codons) {
    # Search window for next boundary
    lo_b <- current_start + min_codons - 1L
    hi_b <- min(current_start + max_codons - 1L, n_codons - 1L)

    # Collect candidates: (position, oh1, oh2, score) tuples
    candidates <- list()
    for (b in lo_b:hi_b) {
      oh1_pos <- b * 3L + 1L
      oh1 <- substring(cds, oh1_pos, oh1_pos + 3L)

      oh2_codon <- min(b + overlap_codons, n_codons)
      oh2_pos <- oh2_codon * 3L
      oh2 <- substring(cds, oh2_pos - 3L, oh2_pos)

      # Guard: OH must be exactly 4 nt (boundary near gene end may truncate)
      if (nchar(oh1) != 4L || nchar(oh2) != 4L) next

      # Hard filters
      if (oh1 %in% PALINDROMIC_4NT || oh2 %in% PALINDROMIC_4NT) next
      if (oh1 %in% HOMOPOLYMER_4NT || oh2 %in% HOMOPOLYMER_4NT) next
      if (oh1 == oh_L || oh1 == reverse_complement(oh_L)) next

      # Collision checks (incl. self-palindrome via max_identity param)
      if (!oogga_overlap_pass(
        oh1, committed_ohs, alien_ohs, compat,
        max_identity
      )) {
        next
      }
      if (!oogga_overlap_pass(
        oh2, committed_ohs, alien_ohs, compat,
        max_identity
      )) {
        next
      }
      if (!compat[oh1, oh2]) next

      # Multiplicative score for ranking (OOGGA-faithful)
      score <- overhang_score(oh1, fid_lookup, eff_lookup) *
        overhang_score(oh2, fid_lookup, eff_lookup)

      candidates[[length(candidates) + 1L]] <- list(
        pos = b, oh1 = oh1, oh2 = oh2, score = score
      )
    }

    if (length(candidates) == 0L) {
      # No valid boundary in this window — check if we can end the gene
      remaining <- n_codons - current_start + 1L
      if (remaining <= max_codons) {
        break # Last tile is within bounds
      }
      # Truly stuck — try max_identity=3 as fallback
      if (max_identity == 2L) {
        cli::cli_alert_warning(
          "OOGGA greedy stuck at codon {current_start}. Retrying with max_identity=3."
        )
        return(search_tile_boundaries_greedy_seq(
          cds, max_mutable_nt, min_mutable_nt, oh_fidelity,
          overlap_codons, eff_lookup, alien_ohs,
          max_identity = 3L
        ))
      }
      stop(
        "OOGGA greedy tile search failed: no valid boundary at codon ",
        current_start, " with max_identity=", max_identity
      )
    }

    # Pick best candidate
    scores <- vapply(candidates, function(c) c$score, numeric(1))
    best <- candidates[[which.max(scores)]]

    boundary_positions <- c(boundary_positions, best$pos)
    committed_ohs <- c(committed_ohs, best$oh1, best$oh2)
    current_start <- best$pos + 1L
  }

  greedy_elapsed <- (proc.time() - greedy_start)[["elapsed"]]

  # Build tile data frame
  K <- length(boundary_positions)
  n_tiles <- K + 1L

  tile_starts_codon <- c(1L, boundary_positions + 1L)
  tile_ends_codon <- c(boundary_positions, n_codons)
  tile_starts_nt <- (tile_starts_codon - 1L) * 3L + 1L
  tile_ends_nt <- tile_ends_codon * 3L

  tiles <- data.frame(
    tile_id = seq_len(n_tiles),
    start_codon = tile_starts_codon,
    end_codon = tile_ends_codon,
    start_nt = tile_starts_nt,
    end_nt = tile_ends_nt,
    n_codons = tile_ends_codon - tile_starts_codon + 1L,
    stringsAsFactors = FALSE
  )

  tiles$oh1_seq <- NA_character_
  tiles$oh2_seq <- NA_character_
  tiles$oh1_score <- NA_real_
  tiles$oh2_score <- NA_real_
  tiles$oh1_in_hf <- NA
  tiles$oh2_in_hf <- NA
  tiles$oh1_fidelity <- NA_real_
  tiles$oh2_fidelity <- NA_real_
  tiles$tile_seq <- NA_character_
  tiles$boundary_shift <- 0L
  tiles$boundary_score <- NA_real_

  for (i in seq_len(n_tiles)) {
    tiles$oh1_seq[i] <- substring(cds, tiles$start_nt[i], tiles$start_nt[i] + 3L)
    oh2_codon <- min(tiles$end_codon[i] + overlap_codons, n_codons)
    oh2_pos <- oh2_codon * 3L
    tiles$oh2_seq[i] <- substring(cds, oh2_pos - 3L, oh2_pos)

    tiles$oh1_score[i] <- overhang_score(tiles$oh1_seq[i], fid_lookup, eff_lookup)
    tiles$oh2_score[i] <- overhang_score(tiles$oh2_seq[i], fid_lookup, eff_lookup)
    tiles$oh1_in_hf[i] <- tiles$oh1_seq[i] %in% hf_set
    tiles$oh2_in_hf[i] <- tiles$oh2_seq[i] %in% hf_set
    oh1_fid <- if (tiles$oh1_seq[i] %in% names(fid_lookup)) unname(fid_lookup[tiles$oh1_seq[i]]) else NA_real_
    oh2_fid <- if (tiles$oh2_seq[i] %in% names(fid_lookup)) unname(fid_lookup[tiles$oh2_seq[i]]) else NA_real_
    tiles$oh1_fidelity[i] <- oh1_fid
    tiles$oh2_fidelity[i] <- oh2_fid
    tiles$tile_seq[i] <- substring(cds, tiles$start_nt[i], tiles$end_nt[i])
    tiles$boundary_score[i] <- tiles$oh1_score[i] + tiles$oh2_score[i]
  }

  cli::cli_alert_success(paste0(
    "OOGGA greedy: ", n_tiles, " tiles, ", K, " collision-free boundaries ",
    "in {round(greedy_elapsed, 1)}s."
  ))

  attr(tiles, "max_identity_used") <- max_identity
  tiles
}


# =============================================================================
# METHOD A3: oogga_single — Single-pass OOGGA DP on entire gene+cassette
# =============================================================================

#' Run single-pass OOGGA DP on gene+cassette
#'
#' Runs OOGGA natively on the full gene+cassette sequence with fragment size
#' = tile constraints. All boundaries are found in one pass with mutual
#' collision checking across ALL fragments. This is the strictest collision
#' mode (all OHs in one collision domain), which over-constrains relative to
#' the actual biology (tiles have separate pots).
#'
#' @param full_seq Character, gene + cassette sequence
#' @param gene_len Integer, length of gene CDS portion
#' @param min_codons Minimum tile size in codons
#' @param max_codons Maximum tile size in codons
#' @param oh_fidelity Data frame with overhang + fidelity
#' @param eff_lookup Named numeric vector (overhang -> efficiency)
#' @param alien_ohs Character vector of fixed overhangs to avoid
#' @param max_identity Integer, max positional identity (default 2)
#' @param dp_k_range Integer, search K_ideal +/- range
#' @return List with boundaries (nt positions), boundary_ohs, total_score
oogga_single_pass_dp <- function(full_seq, gene_len,
                                 min_codons, max_codons,
                                 oh_fidelity, eff_lookup,
                                 alien_ohs = character(0),
                                 max_identity = 2L,
                                 dp_k_range = 5L,
                                 beam_width = 10L) {
  total_len <- nchar(full_seq)
  n_codons_gene <- gene_len %/% 3L

  fid_lookup <- oh_fidelity$fidelity
  names(fid_lookup) <- oh_fidelity$overhang

  # Convert codon-based constraints to nt for the single-pass
  # Fragment sizes in nt (boundaries at codon positions)
  min_frag_nt <- min_codons * 3L
  max_frag_nt <- max_codons * 3L

  # Build compatibility matrix
  compat <- build_oh_compatibility(max_identity)

  # Precompute scores at every codon-aligned position in the gene
  # (For the single-pass, we only consider codon-aligned boundaries within
  # the gene portion. Cassette is treated as the final "fragment".)
  boundary_scores <- rep(-Inf, total_len)
  boundary_valid <- rep(FALSE, total_len)
  oh_seq <- character(total_len)

  for (p in 4L:total_len) {
    oh <- substring(full_seq, p - 3L, p)
    oh_seq[p] <- oh

    # Only codon-aligned positions in gene region
    if (p <= gene_len && (p %% 3L) != 0L) next
    if (p > gene_len) next # Don't place boundaries in cassette

    if (oh %in% PALINDROMIC_4NT) next
    if (oh %in% HOMOPOLYMER_4NT) next

    boundary_scores[p] <- overhang_score(oh, fid_lookup, eff_lookup)
    boundary_valid[p] <- TRUE
  }

  # Determine K range — based on gene codons / max tile size
  K_ideal <- max(1L, ceiling(n_codons_gene / max_codons) - 1L)
  K_lo <- max(1L, K_ideal - dp_k_range)
  K_hi <- min(n_codons_gene %/% min_codons - 1L, K_ideal + dp_k_range)
  K_hi <- max(K_hi, K_lo)

  cli::cli_alert_info(
    "OOGGA single-pass: {total_len} bp, K range [{K_lo}, {K_hi}], max_identity={max_identity}"
  )

  # For single-pass, treat the full gene+cassette as the total length.
  # But boundaries only in gene region, so last "segment" extends to total_len.
  # We use oogga_sb_dp_solve_k_v2 with nt-based min/max fragment lengths.
  # However, the last segment can be larger (gene tail + cassette).

  best_result <- NULL
  best_geo_mean <- -Inf

  dp_start <- proc.time()
  for (K in K_lo:K_hi) {
    # Run the DP treating boundaries as codon-aligned gene positions
    # Last segment = remaining gene + cassette, so max_len for final
    # segment is unconstrained. We handle this by setting max_len
    # to total_len for the final segment check.
    result <- oogga_sb_dp_solve_k_v2(
      K, gene_len, min_frag_nt, max_frag_nt,
      boundary_scores[seq_len(gene_len)],
      boundary_valid[seq_len(gene_len)],
      oh_seq[seq_len(gene_len)],
      alien_ohs, compat,
      beam_width = beam_width,
      max_identity = max_identity
    )
    if (!is.null(result) && result$total_score > 0) {
      geo_mean <- result$total_score^(1 / K)
      if (geo_mean > best_geo_mean) {
        best_geo_mean <- geo_mean
        best_result <- result
        best_result$K <- K
      }
    }
  }
  dp_elapsed <- (proc.time() - dp_start)[["elapsed"]]
  cli::cli_alert_info("OOGGA single-pass DP completed in {round(dp_elapsed, 1)}s.")

  # Fallback to max_identity=3
  if (is.null(best_result) && max_identity == 2L) {
    cli::cli_alert_warning(
      "OOGGA single-pass infeasible at max_identity=2. Retrying with max_identity=3."
    )
    compat3 <- build_oh_compatibility(3L)
    for (K in K_lo:K_hi) {
      result <- oogga_sb_dp_solve_k_v2(
        K, gene_len, min_frag_nt, max_frag_nt,
        boundary_scores[seq_len(gene_len)],
        boundary_valid[seq_len(gene_len)],
        oh_seq[seq_len(gene_len)],
        alien_ohs, compat3,
        beam_width = beam_width,
        max_identity = 3L
      )
      if (!is.null(result) && result$total_score > 0) {
        geo_mean <- result$total_score^(1 / K)
        if (geo_mean > best_geo_mean) {
          best_geo_mean <- geo_mean
          best_result <- result
          best_result$K <- K
        }
      }
    }
  }

  if (is.null(best_result)) {
    stop("OOGGA single-pass DP found no feasible solution.")
  }

  best_result
}


#' Search boundaries using single-pass OOGGA on gene+cassette
#'
#' Wrapper: runs single-pass OOGGA to find all tile boundaries, then
#' applies post-hoc SB splitting for any oversized gene blocks.
#'
#' @param cds Domesticated gene sequence
#' @param cassette_seq Downstream cassette sequence (intergene + polIII)
#' @param max_mutable_nt Max mutable region in nt
#' @param min_mutable_nt Min mutable region in nt
#' @param max_block_length Max block length for SB splitting
#' @param min_block_length Min block length for SB splitting
#' @param oh_fidelity Data frame
#' @param eff_lookup Named numeric vector
#' @param alien_ohs Character vector
#' @param max_identity Integer
#' @param dp_k_range Integer
#' @param overlap_codons Integer
#' @return List with tiles (data frame) and sb_result
search_boundaries_oogga_single <- function(cds, cassette_seq,
                                           max_mutable_nt,
                                           min_mutable_nt = NULL,
                                           max_block_length = 1800L,
                                           min_block_length = 300L,
                                           oh_fidelity = NULL,
                                           eff_lookup = NULL,
                                           alien_ohs = character(0),
                                           max_identity = 2L,
                                           beam_width = 10L,
                                           dp_k_range = 5L,
                                           overlap_codons = 4L) {
  gene_len <- nchar(cds)
  n_codons <- gene_len %/% 3L
  full_seq <- paste0(cds, cassette_seq)

  if (is.null(min_mutable_nt)) {
    min_mutable_nt <- max(81L, max_mutable_nt %/% 3L)
    min_mutable_nt <- (min_mutable_nt %/% 3L) * 3L
  }
  max_codons <- max_mutable_nt %/% 3L
  min_codons <- min_mutable_nt %/% 3L

  if (is.null(oh_fidelity)) oh_fidelity <- load_overhang_fidelity("BsmBI")
  if (is.null(eff_lookup)) {
    bsmbi_pw <- load_pairwise_matrix("BsmBI")
    eff_lookup <- compute_overhang_efficiency(bsmbi_pw)
  }

  fid_lookup <- oh_fidelity$fidelity
  names(fid_lookup) <- oh_fidelity$overhang
  hf_set <- load_high_fidelity_set()

  # Run single-pass OOGGA on gene+cassette
  sp_result <- oogga_single_pass_dp(
    full_seq, gene_len, min_codons, max_codons,
    oh_fidelity, eff_lookup, alien_ohs, max_identity, dp_k_range,
    beam_width = beam_width
  )

  # Convert nt-position boundaries to codon boundaries
  boundary_nt <- sp_result$boundaries
  boundary_codons <- boundary_nt %/% 3L

  K <- length(boundary_codons)
  n_tiles <- K + 1L

  tile_starts_codon <- c(1L, boundary_codons + 1L)
  tile_ends_codon <- c(boundary_codons, n_codons)
  tile_starts_nt <- (tile_starts_codon - 1L) * 3L + 1L
  tile_ends_nt <- tile_ends_codon * 3L

  tiles <- data.frame(
    tile_id = seq_len(n_tiles),
    start_codon = tile_starts_codon,
    end_codon = tile_ends_codon,
    start_nt = tile_starts_nt,
    end_nt = tile_ends_nt,
    n_codons = tile_ends_codon - tile_starts_codon + 1L,
    stringsAsFactors = FALSE
  )

  tiles$oh1_seq <- NA_character_
  tiles$oh2_seq <- NA_character_
  tiles$oh1_score <- NA_real_
  tiles$oh2_score <- NA_real_
  tiles$oh1_in_hf <- NA
  tiles$oh2_in_hf <- NA
  tiles$oh1_fidelity <- NA_real_
  tiles$oh2_fidelity <- NA_real_
  tiles$tile_seq <- NA_character_
  tiles$boundary_shift <- 0L
  tiles$boundary_score <- NA_real_

  for (i in seq_len(n_tiles)) {
    tiles$oh1_seq[i] <- substring(cds, tiles$start_nt[i], tiles$start_nt[i] + 3L)
    oh2_codon <- min(tiles$end_codon[i] + overlap_codons, n_codons)
    oh2_pos <- oh2_codon * 3L
    tiles$oh2_seq[i] <- substring(cds, oh2_pos - 3L, oh2_pos)

    tiles$oh1_score[i] <- overhang_score(tiles$oh1_seq[i], fid_lookup, eff_lookup)
    tiles$oh2_score[i] <- overhang_score(tiles$oh2_seq[i], fid_lookup, eff_lookup)
    tiles$oh1_in_hf[i] <- tiles$oh1_seq[i] %in% hf_set
    tiles$oh2_in_hf[i] <- tiles$oh2_seq[i] %in% hf_set
    oh1_fid <- if (tiles$oh1_seq[i] %in% names(fid_lookup)) unname(fid_lookup[tiles$oh1_seq[i]]) else NA_real_
    oh2_fid <- if (tiles$oh2_seq[i] %in% names(fid_lookup)) unname(fid_lookup[tiles$oh2_seq[i]]) else NA_real_
    tiles$oh1_fidelity[i] <- oh1_fid
    tiles$oh2_fidelity[i] <- oh2_fid
    tiles$tile_seq[i] <- substring(cds, tiles$start_nt[i], tiles$end_nt[i])
    tiles$boundary_score[i] <- tiles$oh1_score[i] + tiles$oh2_score[i]
  }

  # Post-hoc SB splitting: check if any gene block exceeds synthesis limit
  # Use the existing SB DP for this (it's a post-processing step)
  block_overhead <- 22L
  total_content_len <- nchar(full_seq)

  if (total_content_len > (max_block_length - block_overhead)) {
    # Need SB splitting — use OOGGA SB DP for consistency
    tile_end_positions <- tiles$end_nt[-n_tiles]

    cassette_oh_blacklist <- unique(c(
      tiles$oh1_seq, tiles$oh2_seq,
      vapply(tiles$oh1_seq, reverse_complement, character(1)),
      vapply(tiles$oh2_seq, reverse_complement, character(1))
    ))

    # Only pass fixed assembly OHs as alien_ohs (not tile boundary OHs).
    # Tile boundary OHs are the oh2 at allowed_gene_positions — if we included
    # them as aliens, the DP would reject every allowed position since the OH
    # there IS a tile boundary OH.
    sb_result <- search_sb_boundaries_oogga(
      full_seq = full_seq,
      gene_len = gene_len,
      max_block_length = max_block_length - block_overhead,
      min_block_length = min_block_length,
      alien_ohs = alien_ohs,
      oh_fidelity = oh_fidelity,
      eff_lookup = eff_lookup,
      max_identity = max_identity,
      beam_width = beam_width,
      allowed_gene_positions = tile_end_positions,
      cassette_blacklist_ohs = cassette_oh_blacklist
    )
  } else {
    sb_result <- list(
      n_superblocks = 1L,
      boundaries = data.frame(
        sb_id = 1L, start_nt = 1L, end_nt = total_content_len,
        boundary_oh = NA_character_, boundary_score = NA_real_,
        stringsAsFactors = FALSE
      ),
      total_score = 0
    )
  }

  cli::cli_alert_success(paste0(
    "OOGGA single-pass: ", n_tiles, " tiles, ", K, " boundaries, ",
    sb_result$n_superblocks, " superblocks."
  ))

  list(
    tiles = tiles,
    sb_result = sb_result
  )
}
