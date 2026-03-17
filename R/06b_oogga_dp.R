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
#' not 3. The prior version also checked identity(RC(A), B), but this is
#' mathematically redundant: identity(A, RC(B)) == identity(RC(A), B) always
#' holds (proof: both count positions i where A[i] == complement(B[3-i]),
#' related by the substitution j = 3-i). So the 2-condition and 3-condition
#' matrices are identical.
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

#' Precompute SB boundary candidate scores and overhangs (two-OH model)
#'
#' For each valid nucleotide position in the full sequence (gene + cassette),
#' computes the boundary overhangs and scores with hard filtering.
#'
#' **Gene-region boundaries** (p <= gene_len): Uses the unified two-overhang
#' model — same formula as tile boundaries in precompute_boundary_scores().
#' Each boundary has oh1 (first 4 nt past boundary = start of next segment)
#' and oh2 (4 nt at the overlap extension point). Score is multiplicative:
#' overhang_score(oh1) * overhang_score(oh2). Both must pass hard filters.
#'
#' **Cassette-region boundaries** (p > gene_len): Single-OH model. No tile
#' overlap in the cassette, so only one junction OH is needed. oh1 = the
#' junction OH at the split point, oh2 = "" (empty, not used).
#'
#' @param full_seq Character, full sequence (gene + cassette)
#' @param gene_len Integer, length of gene CDS portion
#' @param oh_fidelity Data frame with overhang + fidelity columns
#' @param eff_lookup Named numeric vector (overhang -> efficiency)
#' @param blacklist_ohs Character vector of overhangs to exclude
#' @param allowed_gene_positions Integer vector of valid gene-region boundary
#'   positions. NULL = allow all codon-aligned positions.
#' @param cassette_needs_splitting Logical: if FALSE, positions in the cassette
#'   region (> gene_len) are excluded as candidates. This prevents the SB DP
#'   from placing boundaries inside a cassette that fits within a single block.
#'   Default TRUE (allow cassette-region candidates).
#' @param overlap_codons Integer, number of overlap codons for oh2 computation
#'   in gene-region boundaries (default 4). Must match the tile DP's
#'   overlap_codons to ensure SB and tile boundaries use the same formula.
#' @param min_gene_residual Integer, minimum gene nt that must remain AFTER
#'   a gene-region boundary (i.e., gene_len - p >= min_gene_residual).
#'   Prevents SB boundaries from creating runt last-gene-segments that are
#'   too short for a useful tile. Default 0 (no constraint).
#' @return List with vectors: oh1_seq, oh2_seq, score, valid (all length =
#'   nchar(full_seq)). oh2_seq is "" for cassette-region positions.
precompute_sb_boundary_candidates <- function(full_seq, gene_len,
                                              oh_fidelity, eff_lookup,
                                              blacklist_ohs = character(0),
                                              allowed_gene_positions = NULL,
                                              cassette_needs_splitting = TRUE,
                                              overlap_codons = 4L,
                                              min_gene_residual = 0L) {
  total_len <- nchar(full_seq)
  n_codons_gene <- gene_len %/% 3L
  fid_lookup <- oh_fidelity$fidelity
  names(fid_lookup) <- oh_fidelity$overhang

  # Expand blacklist with reverse complements
  blacklist_set <- unique(c(
    blacklist_ohs,
    vapply(blacklist_ohs, reverse_complement, character(1))
  ))

  oh1_seq <- character(total_len)
  oh2_seq <- character(total_len)
  scores <- rep(-Inf, total_len)
  valid <- rep(FALSE, total_len)

  for (p in 4L:total_len) {
    if (p <= gene_len) {
      # --- Gene-region: two-overhang model ---
      # Same formula as tile DP's precompute_boundary_scores()
      if ((p %% 3L) != 0L) next # codon boundary only
      if (!is.null(allowed_gene_positions) && !(p %in% allowed_gene_positions)) next
      # Option 1 runt-tile prevention: exclude positions that leave too
      # little gene content after the boundary for a useful last tile.
      if (min_gene_residual > 0L && (gene_len - p) < min_gene_residual) next

      # oh1: first 4 nt past boundary (= oh1 of next segment's first tile)
      if (p + 4L > total_len) next # need room for oh1
      oh1 <- substring(full_seq, p + 1L, p + 4L)

      # oh2: 4 nt at overlap extension (= oh2 of prev segment's last tile)
      # Same as tile DP: oh2 at boundary + overlap_codons.
      # No gene-end clamp — oh2 can extend into the cassette when the
      # boundary is near the gene end. This ensures each SB boundary gets
      # a unique oh2 (clamping caused duplicate oh2 for near-end boundaries).
      boundary_codon <- p %/% 3L
      oh2_pos_target <- (boundary_codon + overlap_codons) * 3L
      if (oh2_pos_target > total_len || oh2_pos_target < 4L) next
      oh2 <- substring(full_seq, oh2_pos_target - 3L, oh2_pos_target)

      oh1_seq[p] <- oh1
      oh2_seq[p] <- oh2

      # Hard filters on BOTH oh1 and oh2
      if (oh1 %in% blacklist_set || oh2 %in% blacklist_set) next
      if (oh1 %in% PALINDROMIC_4NT || oh2 %in% PALINDROMIC_4NT) next
      if (oh1 %in% HOMOPOLYMER_4NT || oh2 %in% HOMOPOLYMER_4NT) next

      # Multiplicative score (same as tile DP)
      score <- overhang_score(oh1, fid_lookup, eff_lookup) *
        overhang_score(oh2, fid_lookup, eff_lookup)
      # Skip boundaries with unscorable overhangs
      if (!is.na(score)) {
        scores[p] <- score
        valid[p] <- TRUE
      }

    } else {
      # --- Cassette-region: single-OH model ---
      # No tile overlap in cassette, only a junction OH for gene block splitting

      # Cassette-region gate: skip when cassette doesn't need splitting
      if (!cassette_needs_splitting) next

      oh <- substring(full_seq, p - 3L, p)
      oh1_seq[p] <- oh
      # oh2_seq[p] stays "" (no second overhang for cassette boundaries)

      # Hard filters
      if (oh %in% blacklist_set) next
      if (oh %in% PALINDROMIC_4NT) next
      if (oh %in% HOMOPOLYMER_4NT) next

      score <- overhang_score(oh, fid_lookup, eff_lookup)
      # Skip boundaries with unscorable overhangs
      if (!is.na(score)) {
        scores[p] <- score
        valid[p] <- TRUE
      }
    }
  }

  list(oh1_seq = oh1_seq, oh2_seq = oh2_seq, score = scores, valid = valid)
}


#' Solve SB boundary placement with OOGGA collision-aware DP (v2, two-OH)
#'
#' Stores full (score, positions, ohs, oh1s, oh2s) tuples for path
#' reconstruction. Uses beam search: retains top beam_width paths per position
#' to explore multiple collision-compatible paths (Bellman optimality doesn't
#' hold because the collision constraint is path-dependent).
#'
#' Scoring is multiplicative (OOGGA-faithful): each boundary's score is
#' multiplied into a running product. For gene-region boundaries, the score
#' is overhang_score(oh1) * overhang_score(oh2). For cassette-region
#' boundaries (oh2 = ""), the score is overhang_score(oh1) only.
#'
#' **Two-OH model**: Each gene-region boundary contributes 2 overhangs
#' (oh1 + oh2) to the path's collision set. Cassette-region boundaries
#' contribute 1 overhang (oh1 only). All overhangs on the path must be
#' pairwise compatible (no identity or RC collisions).
#'
#' @param K Number of internal boundaries (superblocks = K + 1)
#' @param total_len Total sequence length in nucleotides
#' @param min_len Minimum segment length in nucleotides
#' @param max_len Maximum segment length in nucleotides
#' @param boundary_scores Numeric vector of scores per position
#' @param boundary_valid Logical vector of valid positions
#' @param oh1_seq Character vector of oh1 overhang at each position
#' @param oh2_seq Character vector of oh2 overhang at each position
#'   ("" for cassette-region positions where no oh2 exists)
#' @param alien_ohs Character vector of fixed overhangs to avoid
#' @param compat_matrix Named 256x256 logical compatibility matrix
#' @param beam_width Integer, max paths to retain per position (default 10).
#'   Higher = more exploration but slower.
#' @param max_identity Integer, max positional identity for self-palindrome
#'   check (must match compat_matrix's max_identity).
#' @return List with boundaries, total_score, boundary_oh1s, boundary_oh2s,
#'   or NULL if no feasible solution
oogga_sb_dp_solve_k_v2 <- function(K, total_len, min_len, max_len,
                                   boundary_scores, boundary_valid,
                                   oh1_seq, oh2_seq,
                                   alien_ohs, compat_matrix,
                                   beam_width = 10L,
                                   max_identity = 2L) {
  if (K == 0L) {
    return(NULL)
  }
  if ((K + 1L) * min_len > total_len) {
    return(NULL)
  }

  # Each path entry: list(score, positions, ohs, oh1s, oh2s)
  # ohs = all non-empty overhangs on the path (for collision checking)
  # oh1s/oh2s = per-boundary oh1/oh2 (for output reconstruction)
  # dp_paths[[p]] = list of path entries ending at position p

  # ---- Precompute static (path-independent) checks per position ----
  # Self-palindrome + alien compat are position-dependent but NOT path-
  # dependent. Computing them once avoids redundant R function calls.

  # Filter alien_ohs to only include valid compat_matrix entries
  valid_ohs <- rownames(compat_matrix)
  alien_ohs <- alien_ohs[alien_ohs %in% valid_ohs]

  static_ok <- logical(total_len)
  has_aliens <- length(alien_ohs) > 0L
  for (p in seq_len(total_len)) {
    if (!boundary_valid[p]) next
    oh1 <- oh1_seq[p]
    oh2 <- oh2_seq[p]
    has_oh2 <- nchar(oh2) == 4L

    if (!oh1 %in% valid_ohs) next
    # Self-palindrome check for oh1
    rc1 <- reverse_complement(oh1)
    if (count_positional_identity(oh1, rc1) > max_identity) next
    # Alien compat for oh1
    if (has_aliens && !all(compat_matrix[oh1, alien_ohs])) next

    if (has_oh2) {
      if (!oh2 %in% valid_ohs) next
      # Self-palindrome check for oh2
      rc2 <- reverse_complement(oh2)
      if (count_positional_identity(oh2, rc2) > max_identity) next
      # Alien compat for oh2
      if (has_aliens && !all(compat_matrix[oh2, alien_ohs])) next
      # Mutual compat between oh1 and oh2
      if (!compat_matrix[oh1, oh2]) next
    }

    static_ok[p] <- TRUE
  }

  # Helper: collect non-empty OHs for a new boundary at position p
  # Returns character vector of OHs to add to the path's collision set
  get_new_ohs <- function(p) {
    ohs <- oh1_seq[p]
    if (nchar(oh2_seq[p]) == 4L) ohs <- c(ohs, oh2_seq[p])
    ohs
  }

  # Layer k=1
  dp_paths <- vector("list", total_len)

  lo_p <- min_len
  hi_p <- min(max_len, total_len - 1L)
  if (lo_p <= hi_p) {
    for (p in lo_p:hi_p) {
      if (!static_ok[p]) next
      new_ohs <- get_new_ohs(p)
      dp_paths[[p]] <- list(list(
        score = boundary_scores[p],
        positions = p,
        ohs = new_ohs,
        oh1s = oh1_seq[p],
        oh2s = oh2_seq[p]
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
        new_ohs <- get_new_ohs(p)

        lo <- max(1L, p - max_len)
        hi <- p - min_len
        if (hi < lo) next

        candidates <- list()

        for (pp in lo:hi) {
          if (is.null(dp_paths[[pp]])) next
          for (path in dp_paths[[pp]]) {
            # Vectorized check: ALL new OHs vs ALL prior OHs on the path
            all_compat <- TRUE
            for (new_oh in new_ohs) {
              if (!all(compat_matrix[new_oh, path$ohs])) {
                all_compat <- FALSE
                break
              }
            }
            if (!all_compat) next

            # Multiplicative scoring
            candidates[[length(candidates) + 1L]] <- list(
              score = path$score * boundary_scores[p],
              positions = c(path$positions, p),
              ohs = c(path$ohs, new_ohs),
              oh1s = c(path$oh1s, oh1_seq[p]),
              oh2s = c(path$oh2s, oh2_seq[p])
            )
          }
        }

        # Beam pruning: keep top beam_width paths by score
        if (length(candidates) > 0L) {
          if (length(candidates) > beam_width) {
            cand_scores <- vapply(candidates, function(c) c$score, numeric(1))
            keep_idx <- order(cand_scores, decreasing = TRUE)[seq_len(beam_width)]
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
    boundary_oh1s = best_path$oh1s,
    boundary_oh2s = best_path$oh2s
  )
}


#' Search SB boundaries using OOGGA collision-aware DP (two-OH model)
#'
#' Multi-K wrapper for oogga_sb_dp_solve_k_v2. Uses the unified two-overhang
#' model: gene-region boundaries have oh1_sb + oh2_sb (same formula as tile
#' boundaries), cassette-region boundaries have oh1_sb only.
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
#' @param beam_width Integer, beam search width (default 10)
#' @param allowed_gene_positions Integer vector of valid gene-region positions
#' @param cassette_blacklist_ohs Character vector of tile oh1/oh2 values to
#'   exclude from cassette-region SB boundaries
#' @param cassette_needs_splitting Logical: if FALSE, cassette-region positions
#'   are excluded as boundary candidates (default TRUE)
#' @param overlap_codons Integer, overlap codons for two-OH scoring (default 4)
#' @return List with n_superblocks, boundaries (data frame with oh1_sb/oh2_sb),
#'   total_score
search_sb_boundaries_oogga <- function(full_seq, gene_len,
                                       max_block_length = 1800L,
                                       min_block_length = 300L,
                                       alien_ohs = character(0),
                                       oh_fidelity = NULL,
                                       eff_lookup = NULL,
                                       max_identity = 2L,
                                       beam_width = 10L,
                                       allowed_gene_positions = NULL,
                                       cassette_blacklist_ohs = character(0),
                                       cassette_needs_splitting = TRUE,
                                       overlap_codons = 4L,
                                       min_gene_residual = 0L) {
  total_len <- nchar(full_seq)

  # Load data if not provided
  if (is.null(oh_fidelity)) oh_fidelity <- load_overhang_fidelity("BsmBI")
  if (is.null(eff_lookup)) {
    bsmbi_pw <- load_pairwise_matrix("BsmBI")
    eff_lookup <- compute_overhang_efficiency(bsmbi_pw)
  }

  # Helper to build single-SB return value (no boundaries needed)
  make_single_sb <- function() {
    list(
      n_superblocks = 1L,
      boundaries = data.frame(
        sb_id = 1L, start_nt = 1L, end_nt = total_len,
        oh1_sb = NA_character_, oh2_sb = NA_character_,
        boundary_score = NA_real_,
        stringsAsFactors = FALSE
      ),
      total_score = 0
    )
  }

  # Edge case: sequence fits in a single block
  if (total_len <= max_block_length) {
    return(make_single_sb())
  }

  # Build blacklist: alien_ohs + homopolymers
  blacklist <- unique(c(alien_ohs, HOMOPOLYMER_4NT))

  # Precompute candidates with two-OH model
  candidates <- precompute_sb_boundary_candidates(
    full_seq, gene_len, oh_fidelity, eff_lookup,
    blacklist_ohs = blacklist,
    min_gene_residual = min_gene_residual,
    allowed_gene_positions = allowed_gene_positions,
    cassette_needs_splitting = cassette_needs_splitting,
    overlap_codons = overlap_codons
  )

  # Additionally filter cassette-region positions against tile oh1/oh2
  if (length(cassette_blacklist_ohs) > 0) {
    cass_bl_set <- unique(c(
      cassette_blacklist_ohs,
      vapply(cassette_blacklist_ohs, reverse_complement, character(1))
    ))
    for (p in which(candidates$valid)) {
      # Cassette boundaries use oh1_seq only (oh2 is "" for cassette)
      if (p > gene_len && candidates$oh1_seq[p] %in% cass_bl_set) {
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
    return(make_single_sb())
  }

  # Build compatibility matrix
  compat <- build_oh_compatibility(max_identity)

  # Determine K range (narrow: K_min to K_min+2)
  # Raw product scoring: extra boundaries must earn their keep by improving
  # junction quality — embeds soft parsimony without needing wide K search.
  K_min <- max(1L, ceiling(total_len / max_block_length) - 1L)
  K_max <- min(K_min + 2L, floor(total_len / min_block_length) - 1L)
  k_range <- seq(K_min, K_max)

  cli::cli_alert_info(
    "OOGGA SB DP: K range [{K_min}, {K_max}]"
  )

  # Run DP for each K (two-OH model)
  # Raw product scoring: higher score = higher total assembly probability
  best_result <- NULL
  best_comparison <- -Inf

  run_dp <- function(compat_mat, mi) {
    for (K in k_range) {
      result <- oogga_sb_dp_solve_k_v2(
        K, total_len, min_block_length, max_block_length,
        candidates$score, candidates$valid,
        candidates$oh1_seq, candidates$oh2_seq,
        alien_ohs, compat_mat,
        beam_width = beam_width,
        max_identity = mi
      )
      if (!is.null(result) && result$total_score > 0) {
        comp <- result$total_score
        if (comp > best_comparison) {
          best_comparison <<- comp
          best_result <<- result
          best_result$K <<- K
        }
      }
    }
  }

  dp_start <- proc.time()
  run_dp(compat, max_identity)
  dp_elapsed <- (proc.time() - dp_start)[["elapsed"]]
  cli::cli_alert_info("OOGGA SB DP completed in {round(dp_elapsed, 1)}s.")

  # If OOGGA at max_identity=2 fails, try max_identity=3
  if (is.null(best_result) && max_identity == 2L) {
    cli::cli_alert_warning(
      "OOGGA SB DP infeasible at max_identity=2. Retrying with max_identity=3."
    )
    compat3 <- build_oh_compatibility(3L)
    run_dp(compat3, 3L)
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

  # Convert to output format with two-OH columns
  K <- best_result$K
  boundaries <- best_result$boundaries
  boundary_oh1s <- best_result$boundary_oh1s
  boundary_oh2s <- best_result$boundary_oh2s

  # Build boundaries data frame
  sb_starts <- c(1L, boundaries + 1L)
  sb_ends <- c(boundaries, total_len)
  n_sbs <- K + 1L

  fid_lookup <- setNames(oh_fidelity$fidelity, oh_fidelity$overhang)

  bnd_df <- data.frame(
    sb_id = seq_len(n_sbs),
    start_nt = sb_starts,
    end_nt = sb_ends,
    oh1_sb = c(boundary_oh1s, NA_character_),
    oh2_sb = c(boundary_oh2s, NA_character_),
    boundary_score = c(
      vapply(seq_len(K), function(i) {
        candidates$score[boundaries[i]]
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

#' Solve tile boundary placement with standard Bellman DP for fixed K
#'
#' Each candidate boundary is checked for self-palindrome and enzyme-specific
#' alien compat only. No tile-to-tile collision check (reactions are independent)
#' and no oh1↔oh2 mutual check (different enzyme pots: BsaI vs BsmBI).
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
#' @param alien_ohs_oh1 Character vector of BsaI-pot alien overhangs for oh1
#' @param alien_ohs_oh2 Character vector of BsmBI-pot alien overhangs for oh2
#' @param compat_matrix Named 256x256 logical compatibility matrix
#' @param max_identity Integer, for self-palindrome check in overlap_pass
#' @return List with boundaries, total_score, or NULL
oogga_tile_dp_solve_k <- function(K, n_codons, min_codons, max_codons,
                                  oh1_seq, oh2_seq,
                                  oh1_scores, oh2_scores,
                                  boundary_valid,
                                  alien_ohs_oh1, alien_ohs_oh2,
                                  compat_matrix,
                                  max_identity = 2L) {
  if (K == 0L) {
    return(NULL)
  }
  if ((K + 1L) * min_codons > n_codons) {
    return(NULL)
  }

  # Standard Bellman DP — no path tracking or beam search needed.
  # Tile-to-tile collision is unnecessary because each tile's assembly

  # reaction is independent (separate pot). oh1 and oh2 are also in
  # different enzyme pots (BsaI vs BsmBI), so no mutual compat check.
  # Score is multiplicative: product of (oh1_score * oh2_score) per boundary.

  # ---- Precompute static (path-independent) checks per position ----
  # Self-palindrome and enzyme-specific alien compat are position-dependent
  # but NOT path-dependent. Computing them once avoids redundant work.

  # Filter alien sets to only include valid 4-nt ACGT sequences present in
  # the compat_matrix. Invalid entries (empty strings, NAs) would cause
  # subscript-out-of-bounds errors.
  valid_ohs <- rownames(compat_matrix)
  alien_ohs_oh1 <- alien_ohs_oh1[alien_ohs_oh1 %in% valid_ohs]
  alien_ohs_oh2 <- alien_ohs_oh2[alien_ohs_oh2 %in% valid_ohs]

  static_ok <- logical(n_codons)
  has_oh1_aliens <- length(alien_ohs_oh1) > 0L
  has_oh2_aliens <- length(alien_ohs_oh2) > 0L
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
    # oh1 checked against BsaI aliens only (same enzyme pot)
    if (has_oh1_aliens && !all(compat_matrix[oh1, alien_ohs_oh1])) next
    # oh2 checked against BsmBI aliens only (same enzyme pot)
    if (has_oh2_aliens && !all(compat_matrix[oh2, alien_ohs_oh2])) next
    # REMOVED: oh1/oh2 mutual compat — different enzyme pots (BsaI vs BsmBI)
    static_ok[b] <- TRUE
  }

  # Standard Bellman DP: store single best (score, positions) per position.
  # No path-based overhang tracking needed — tile reactions are independent.

  # dp[[b]] = list(score, positions) for best path ending at position b
  dp <- vector("list", n_codons)

  # Layer k=1
  lo_b <- min_codons
  hi_b <- min(max_codons, n_codons - 1L)
  if (lo_b <= hi_b) {
    for (b in lo_b:hi_b) {
      if (!static_ok[b]) next
      dp[[b]] <- list(
        score = oh1_scores[b] * oh2_scores[b],
        positions = b
      )
    }
  }

  # Layers k=2..K
  if (K >= 2L) {
    for (k in 2L:K) {
      dp_new <- vector("list", n_codons)

      lo_b <- k * min_codons
      hi_b <- min(n_codons - 1L, n_codons - min_codons)
      if (lo_b > hi_b) {
        dp <- dp_new
        next
      }

      for (b in lo_b:hi_b) {
        if (!static_ok[b]) next

        lo <- max(1L, b - max_codons)
        hi <- b - min_codons
        if (hi < lo) next

        best_score <- -Inf
        best_prev <- NULL

        for (bp in lo:hi) {
          if (is.null(dp[[bp]])) next
          candidate_score <- dp[[bp]]$score * oh1_scores[b] * oh2_scores[b]
          if (candidate_score > best_score) {
            best_score <- candidate_score
            best_prev <- dp[[bp]]
          }
        }

        if (is.finite(best_score) && !is.null(best_prev)) {
          dp_new[[b]] <- list(
            score = best_score,
            positions = c(best_prev$positions, b)
          )
        }
      }

      dp <- dp_new
    }
  }

  # Find best final path
  best_total <- -Inf
  best_entry <- NULL

  for (b in seq_len(n_codons - 1L)) {
    last_tile <- n_codons - b
    if (last_tile < min_codons || last_tile > max_codons) next
    if (is.null(dp[[b]])) next
    if (dp[[b]]$score > best_total) {
      best_total <- dp[[b]]$score
      best_entry <- dp[[b]]
    }
  }

  if (!is.finite(best_total) || is.null(best_entry)) {
    return(NULL)
  }

  list(
    boundaries = best_entry$positions,
    total_score = best_total
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
#' @param alien_ohs_oh1 Character vector of BsaI-pot alien overhangs for oh1
#'   (oh_L, oh4 + their RCs, plus SB junction OHs from superblocks before
#'   this segment)
#' @param alien_ohs_oh2 Character vector of BsmBI-pot alien overhangs for oh2
#'   (oh3 + RC, plus SB junction OHs from superblocks at/after this segment)
#' @param max_identity Integer, max positional identity (default 2)
#' @param n_codons_tile Integer or NULL. If provided, overrides the CDS-derived
#'   codon count for tile boundary placement. Used when CDS is forward-extended
#'   past a SB boundary: the DP places boundaries within n_codons_tile codons,
#'   but precompute_boundary_scores() sees the full extended CDS for oh2
#'   computation at the last boundary.
#' @return Data frame with tile info (same format as search_tile_boundaries_dp)
search_tile_boundaries_oogga <- function(cds, max_mutable_nt,
                                         min_mutable_nt = NULL,
                                         oh_fidelity = NULL,
                                         multi_k = TRUE,
                                         dp_k_range = 5L,
                                         overlap_codons = 4L,
                                         eff_lookup = NULL,
                                         alien_ohs_oh1 = character(0),
                                         alien_ohs_oh2 = character(0),
                                         max_identity = 2L,
                                         n_codons_tile = NULL) {
  gene_len <- nchar(cds)
  n_codons <- gene_len %/% 3L

  # If n_codons_tile is provided, use it for tile boundary placement.
  # The CDS may be longer (forward-extended) but boundaries are constrained
  # to the original segment length. precompute_boundary_scores() still sees
  # the full CDS for correct oh2 extraction at the last boundary.
  # n_codons_cds preserves the full CDS length for oh2 computation in
  # post-processing (last tile's oh2 extends into the overlap zone).
  n_codons_cds <- n_codons
  if (!is.null(n_codons_tile)) {
    stopifnot(n_codons_tile <= n_codons)
    n_codons <- n_codons_tile
  }

  if (is.null(min_mutable_nt)) {
    min_mutable_nt <- max(81L, max_mutable_nt %/% 3L)
    min_mutable_nt <- (min_mutable_nt %/% 3L) * 3L
  }
  max_codons <- max_mutable_nt %/% 3L
  min_codons <- min_mutable_nt %/% 3L

  # Reduce max tile size by overlap so that when tiles are extended by
  # overlap_codons after the DP, the total tile size stays within budget.
  # This mirrors the legacy DP's effective_max_codons pattern.
  effective_max_codons <- max_codons - overlap_codons
  if (effective_max_codons < min_codons) {
    cli::cli_alert_warning(paste0(
      "overlap_codons (", overlap_codons, ") too large for tile budget. ",
      "Falling back to overlap_codons=0."
    ))
    overlap_codons <- 0L
    effective_max_codons <- max_codons
  }

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
  # Delegate to overhang_score() directly — it handles unknown/short overhangs
  # with a 0.5 fallback, avoiding the zero-multiplication trap
  oh1_scores <- vapply(precomp$oh1_seq, function(oh) {
    overhang_score(oh, fid_lookup, eff_lookup)
  }, numeric(1), USE.NAMES = FALSE)
  oh2_scores <- vapply(precomp$oh2_seq, function(oh) {
    overhang_score(oh, fid_lookup, eff_lookup)
  }, numeric(1), USE.NAMES = FALSE)

  # Build compatibility matrix
  compat <- build_oh_compatibility(max_identity)

  # Determine K range (narrow: K_ideal +/- dp_k_range)
  # Raw product scoring embeds soft parsimony — wide K search adds no benefit.
  K_ideal <- max(1L, ceiling(n_codons / effective_max_codons) - 1L)
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
  # Raw product scoring: higher score = higher total assembly probability
  best_result <- NULL
  best_comparison <- -Inf

  dp_start <- proc.time()
  for (K in K_lo:K_hi) {
    result <- oogga_tile_dp_solve_k(
      K, n_codons, min_codons, effective_max_codons,
      precomp$oh1_seq, precomp$oh2_seq,
      oh1_scores, oh2_scores,
      precomp$valid,
      alien_ohs_oh1, alien_ohs_oh2, compat,
      max_identity = max_identity
    )
    if (!is.null(result) && result$total_score > 0) {
      comp <- result$total_score
      if (comp > best_comparison) {
        best_comparison <- comp
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
        K, n_codons, min_codons, effective_max_codons,
        precomp$oh1_seq, precomp$oh2_seq,
        oh1_scores, oh2_scores,
        precomp$valid,
        alien_ohs_oh1, alien_ohs_oh2, compat3,
        max_identity = 3L
      )
      if (!is.null(result) && result$total_score > 0) {
        comp <- result$total_score
        if (comp > best_comparison) {
          best_comparison <- comp
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
  # Extend each tile's end by overlap_codons (capped at gene end).
  # Codons in the overlap region appear in BOTH adjacent tiles, so mutations
  # near tile boundaries are mutable in one tile's interior even if they fall

  # in the other tile's overhang region. Matches legacy DP (line 1076).
  tile_ends_codon <- pmin(c(boundaries + overlap_codons, n_codons), n_codons)
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
    # oh2: last 4 nt of this tile (end_codon already includes overlap extension
    # from the DP, so no further offset needed). Capped at full CDS length.
    oh2_codon <- min(tiles$end_codon[i], n_codons_cds)
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
    "Geo-mean score: ", round(best_result$total_score^(1 / K), 4),
    " (raw product: ", format(best_result$total_score, digits = 3, scientific = TRUE), ")"
  ))

  attr(tiles, "max_identity_used") <- effective_max_identity
  tiles
}


# =============================================================================
# PER-SEGMENT TILE SEARCH (oogga_two_pass)
# =============================================================================

#' Tile the gene per SB segment, ensuring SB/tile alignment
#'
#' After Pass 1 finds SB boundaries, this function runs tile DP search
#' independently within each SB gene-region segment. This guarantees
#' that tile end positions align with SB boundaries — eliminating the skip
#' warnings from `sb_dp_to_partition()` and the gene block explosion bug.
#'
#' Enzyme-aware alien sets: oh1 (BsaI) and oh2 (BsmBI) are in different
#' enzyme pots, so each gets its own alien set. SB junction OHs are split
#' by which pot they appear in:
#'   - SB boundaries BEFORE this segment → BsaI pot (constrain oh1)
#'   - SB boundaries AT/AFTER this segment → BsmBI pot (constrain oh2)
#' Tile-to-tile collision is not checked because each tile's assembly
#' reaction is independent (separate pot).
#'
#' @param cds Domesticated gene CDS sequence
#' @param sb_result SB result list from `search_sb_boundaries_oogga()` with
#'   `$boundaries` data frame (sb_id, start_nt, end_nt, oh1_sb, oh2_sb) and
#'   `$n_superblocks`
#' @param gene_len Integer, length of gene CDS in nt
#' @param max_mutable_nt Integer, max mutable region in nt
#' @param min_mutable_nt Integer, min mutable region in nt
#' @param oh_fidelity Data frame with overhang + fidelity columns
#' @param eff_lookup Named numeric vector (overhang -> efficiency)
#' @param bsai_base_aliens Character vector of BsaI-pot base aliens (oh_L, oh4
#'   + their RCs). SB junction OHs from superblocks before each segment are
#'   added per-segment.
#' @param bsmbi_base_aliens Character vector of BsmBI-pot base aliens (oh3 + RC).
#'   SB junction OHs from superblocks at/after each segment are added per-segment.
#' @param max_identity Integer, max positional identity (default 2)
#' @param multi_k Logical, try multiple tile counts in DP?
#' @param dp_k_range Integer, search K_ideal +/- dp_k_range
#' @param overlap_codons Integer, number of overlap codons between adjacent tiles
#' @return Data frame with tile info (same format as search_tile_boundaries_oogga),
#'   with attribute "max_identity_used" set to the worst max_identity across segments.
tile_segments_oogga <- function(cds, sb_result, gene_len,
                                max_mutable_nt, min_mutable_nt,
                                oh_fidelity, eff_lookup,
                                bsai_base_aliens = character(0),
                                bsmbi_base_aliens = character(0),
                                max_identity = 2L,
                                multi_k = TRUE, dp_k_range = 5L,
                                overlap_codons = 4L) {
  sb_df <- sb_result$boundaries
  n_sb <- sb_result$n_superblocks

  max_codons <- max_mutable_nt %/% 3L
  min_codons <- min_mutable_nt %/% 3L
  total_n_codons <- gene_len %/% 3L

  # --- Extract gene-region SB segments ---
  # SB boundaries span gene + cassette. We only tile the gene region.
  # Gene-region segments: each from sb start to min(sb end, gene_len).
  segments <- list()
  for (i in seq_len(n_sb)) {
    seg_start <- sb_df$start_nt[i]
    seg_end <- min(sb_df$end_nt[i], gene_len)
    if (seg_start > gene_len) next # Cassette-only SB, skip
    segments[[length(segments) + 1L]] <- list(
      start_nt = seg_start,
      end_nt = seg_end,
      sb_id = i
    )
  }

  if (length(segments) == 0L) {
    stop("No gene-region SB segments found. Check SB result.")
  }

  # --- Enzyme-aware alien set construction ---
  # oh1 (BsaI overhang) and oh2 (BsmBI overhang) are in different enzyme
  # pots, so they get separate alien sets. SB junction OHs are split by
  # which pot they appear in:
  #   - SB boundaries BEFORE this segment → BsaI pot (constrain oh1)
  #   - SB boundaries AT/AFTER this segment → BsmBI pot (constrain oh2)
  # Base aliens (oh_L, oh4 for BsaI; oh3 for BsmBI) are provided by caller.

  # Collect all SB junction OHs for per-segment splitting
  all_sb_oh1s <- sb_df$oh1_sb  # indexed by sb_id
  all_sb_oh2s <- sb_df$oh2_sb  # indexed by sb_id

  cli::cli_alert_info(paste0(
    "Per-segment tile search: ", length(segments), " gene segment(s), ",
    "enzyme-aware alien sets (BsaI/BsmBI pots separated)"
  ))

  # Load lookups needed for post-processing
  fid_lookup <- oh_fidelity$fidelity
  names(fid_lookup) <- oh_fidelity$overhang
  hf_set <- load_high_fidelity_set()

  # --- Tile each segment ---
  all_tiles <- list()
  max_identity_used <- max_identity

  for (seg_idx in seq_along(segments)) {
    seg <- segments[[seg_idx]]
    seg_start <- seg$start_nt
    seg_end <- seg$end_nt
    seg_len <- seg_end - seg_start + 1L
    seg_n_codons <- seg_len %/% 3L
    sb_id <- seg$sb_id

    cli::cli_alert_info(paste0(
      "  Segment ", seg_idx, "/", length(segments),
      ": nt ", seg_start, "-", seg_end,
      " (", seg_n_codons, " codons, SB ", sb_id, ")"
    ))

    # --- Per-segment enzyme-aware alien set construction ---
    # SB boundaries BEFORE this segment → BsaI pot (constrain oh1)
    bsai_sb_ohs <- character(0)
    if (sb_id > 1L) {
      for (b in seq_len(sb_id - 1L)) {
        oh1_b <- all_sb_oh1s[b]
        oh2_b <- all_sb_oh2s[b]
        if (!is.na(oh1_b) && nchar(oh1_b) == 4L) bsai_sb_ohs <- c(bsai_sb_ohs, oh1_b)
        if (!is.na(oh2_b) && nchar(oh2_b) == 4L) bsai_sb_ohs <- c(bsai_sb_ohs, oh2_b)
      }
    }
    bsai_sb_rcs <- if (length(bsai_sb_ohs) > 0L) {
      vapply(bsai_sb_ohs, reverse_complement, character(1), USE.NAMES = FALSE)
    } else {
      character(0)
    }
    oh1_aliens <- unique(c(bsai_base_aliens, bsai_sb_ohs, bsai_sb_rcs))

    # SB boundaries AT/AFTER this segment → BsmBI pot (constrain oh2)
    bsmbi_sb_ohs <- character(0)
    for (b in sb_id:n_sb) {
      oh1_b <- all_sb_oh1s[b]
      oh2_b <- all_sb_oh2s[b]
      if (!is.na(oh1_b) && nchar(oh1_b) == 4L) bsmbi_sb_ohs <- c(bsmbi_sb_ohs, oh1_b)
      if (!is.na(oh2_b) && nchar(oh2_b) == 4L) bsmbi_sb_ohs <- c(bsmbi_sb_ohs, oh2_b)
    }
    bsmbi_sb_rcs <- if (length(bsmbi_sb_ohs) > 0L) {
      vapply(bsmbi_sb_ohs, reverse_complement, character(1), USE.NAMES = FALSE)
    } else {
      character(0)
    }
    oh2_aliens <- unique(c(bsmbi_base_aliens, bsmbi_sb_ohs, bsmbi_sb_rcs))

    cli::cli_alert_info(paste0(
      "    oh1 aliens (BsaI pot): ", length(oh1_aliens),
      ", oh2 aliens (BsmBI pot): ", length(oh2_aliens)
    ))

    # --- Forward extension for non-last segments ---
    # Non-last gene segments get their CDS extended forward by overlap_codons*3 nt
    # so the last tile's oh2 naturally extends past the SB boundary into the
    # overlap zone. This is the unified two-OH model: SB boundaries and tile
    # boundaries use the same 4-codon overlap formula.
    is_last_gene_seg <- (seg_idx == length(segments))
    if (!is_last_gene_seg) {
      seg_end_extended <- min(seg_end + overlap_codons * 3L, gene_len)
    } else {
      seg_end_extended <- seg_end
    }
    seg_cds_extended <- substring(cds, seg_start, seg_end_extended)

    if (seg_n_codons <= max_codons) {
      # --- Single-tile segment: no DP needed ---
      # Include all columns that DP/greedy produces so rbind() works
      seg_tiles <- data.frame(
        tile_id = 1L,
        start_codon = 1L,
        end_codon = seg_n_codons,
        start_nt = 1L,
        end_nt = seg_len,
        n_codons = seg_n_codons,
        oh1_seq = NA_character_,
        oh2_seq = NA_character_,
        oh1_score = NA_real_,
        oh2_score = NA_real_,
        oh1_in_hf = NA,
        oh2_in_hf = NA,
        oh1_fidelity = NA_real_,
        oh2_fidelity = NA_real_,
        tile_seq = NA_character_,
        boundary_shift = 0L,
        boundary_score = NA_real_,
        stringsAsFactors = FALSE
      )
      cli::cli_alert_info("    Single-tile segment (no DP needed)")
    } else {
      # --- Multi-tile segment: run tile DP ---
      # Pass extended CDS for oh2 computation, but n_codons_tile constrains
      # tile boundaries to the original segment length. The extended CDS
      # provides nucleotides for oh2 of the last tile to extend into the
      # overlap zone (codons past the SB boundary).
      seg_tiles <- search_tile_boundaries_oogga(
          cds = seg_cds_extended,
          max_mutable_nt = max_mutable_nt,
          min_mutable_nt = min_mutable_nt,
          oh_fidelity = oh_fidelity,
          multi_k = multi_k,
          dp_k_range = dp_k_range,
          overlap_codons = overlap_codons,
          eff_lookup = eff_lookup,
          alien_ohs_oh1 = oh1_aliens,
          alien_ohs_oh2 = oh2_aliens,
          max_identity = max_identity,
          n_codons_tile = seg_n_codons
        )

      # Track worst-case max_identity used across segments
      seg_mi <- attr(seg_tiles, "max_identity_used")
      if (!is.null(seg_mi) && seg_mi > max_identity_used) {
        max_identity_used <- seg_mi
      }
    }

    # --- Offset positions to gene-absolute coordinates ---
    offset_nt <- seg_start - 1L
    offset_codon <- offset_nt %/% 3L
    seg_tiles$start_codon <- seg_tiles$start_codon + offset_codon
    seg_tiles$end_codon <- seg_tiles$end_codon + offset_codon
    seg_tiles$start_nt <- seg_tiles$start_nt + offset_nt
    seg_tiles$end_nt <- seg_tiles$end_nt + offset_nt

    all_tiles[[seg_idx]] <- seg_tiles
  }

  # --- Merge all segment tiles ---
  tiles <- do.call(rbind, all_tiles)
  tiles$tile_id <- seq_len(nrow(tiles))
  rownames(tiles) <- NULL

  # --- Populate oh1/oh2 metadata from full gene CDS ---
  # This loop fills tile metadata (oh sequences, scores, fidelity) that the
  # tile DP doesn't always populate (e.g., single-tile segments have oh1=NA).
  # oh2 = last 4 nt of each tile. end_codon already includes the overlap
  # extension from the DP, so no further offset is needed. The min() cap
  # uses total_n_codons (full gene length), correctly handling gene-end
  # boundaries.
  for (i in seq_len(nrow(tiles))) {
    # oh1: first 4 nt of this tile
    tiles$oh1_seq[i] <- substring(cds, tiles$start_nt[i], tiles$start_nt[i] + 3L)
    # oh2: last 4 nt of this tile (end_codon already includes overlap extension
    # from the DP, so no further offset needed). Capped at full gene length.
    oh2_codon <- min(tiles$end_codon[i], total_n_codons)
    oh2_pos <- oh2_codon * 3L
    tiles$oh2_seq[i] <- substring(cds, oh2_pos - 3L, oh2_pos)

    tiles$oh1_score[i] <- overhang_score(tiles$oh1_seq[i], fid_lookup, eff_lookup)
    tiles$oh2_score[i] <- overhang_score(tiles$oh2_seq[i], fid_lookup, eff_lookup)
    tiles$oh1_in_hf[i] <- tiles$oh1_seq[i] %in% hf_set
    tiles$oh2_in_hf[i] <- tiles$oh2_seq[i] %in% hf_set
    tiles$oh1_fidelity[i] <- if (tiles$oh1_seq[i] %in% names(fid_lookup)) {
      unname(fid_lookup[tiles$oh1_seq[i]])
    } else {
      NA_real_
    }
    tiles$oh2_fidelity[i] <- if (tiles$oh2_seq[i] %in% names(fid_lookup)) {
      unname(fid_lookup[tiles$oh2_seq[i]])
    } else {
      NA_real_
    }
    tiles$tile_seq[i] <- substring(cds, tiles$start_nt[i], tiles$end_nt[i])
    tiles$boundary_score[i] <- tiles$oh1_score[i] + tiles$oh2_score[i]
    if (!"boundary_shift" %in% names(tiles)) tiles$boundary_shift <- 0L
  }

  n_tiles <- nrow(tiles)
  cli::cli_alert_success(paste0(
    "Per-segment tile search: ", n_tiles, " tiles across ",
    length(segments), " segment(s)"
  ))

  attr(tiles, "max_identity_used") <- max_identity_used
  tiles
}


