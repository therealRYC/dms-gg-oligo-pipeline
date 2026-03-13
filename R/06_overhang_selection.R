# Created: 2025-02-01
# Last updated: 2026-03-05 — Hard codon constraint, remove anchors, SB overlap, cassette pass-through
# 06_overhang_selection.R — Integrated assembly planning with dynamic tile boundary search
# DMS Golden Gate Oligo Pipeline
#
# Integrates tiling and overhang selection into a single planning system.
# Instead of fixing tile boundaries geometrically and then scoring overhangs,
# this module dynamically searches candidate boundary positions for ones where
# the gene-derived overhangs score highest under BsmBI cycling conditions.
#
# Overhang scoring (BUG-008):
#   Score = P_fid_bsmbi(oh) * P_eff_bsmbi(oh)
# Both from BsmBI cycling matrix (Pryor et al. 2020). HF set bonus dropped.
#
# In the 3-enzyme architecture:
# - oh1 (BsaI) and oh2 (BsmBI) are gene-derived at tile boundaries — optimized by boundary search
# - oh3 is a fixed BsmBI overhang (same for all tiles) — derived from promoter or score-selected
# - oh4 is a fixed BsaI overhang (same for all tiles) — score-selected
# - Superblock junction overhangs are gene-derived at split positions — optimized by split search
#
# Key references:
#   Potapov et al. 2018, ACS Synth Bio — 256x256 ligation fidelity matrices, HF overhang sets
#   Pryor et al. 2020, PLOS ONE — Enzyme-specific (BsaI, BsmBI) cycling pairwise matrices

# =============================================================================
# CONSTANTS
# =============================================================================

# Homopolymer 4-nt overhangs — excluded from oh3/oh4 selection because
# polyA/polyT runs after PolIII promoters can cause premature transcription
# termination, and homopolymer overhangs have poor ligation specificity.
HOMOPOLYMER_4NT <- c("AAAA", "CCCC", "GGGG", "TTTT")

# Potapov et al. 2018 Table 1, Set 3 — 25-overhang high-fidelity set
# Source: Potapov et al. 2018, ACS Synth Bio 7:2665-2674 (PMID 30335370), Table 1
# Optimized via simulated annealing (GetSet/MCMC) for SET fidelity (not individual).
# Predicted set fidelity: 95.8% — highest for any 25-overhang set in the paper.
# Note: includes AAAA (homopolymer), which is present in the paper's SA-optimized set.
# The HOMOPOLYMER_4NT filter above applies only to freely-chosen overhangs (oh3/oh4),
# NOT to HF set membership checks.
POTAPOV_TABLE1_SET3_25 <- c(
  "CCTC", "CTAA", "GACA", "GCAC", "AATC",
  "GTAA", "TGAA", "ATTA", "CCAG", "AGGA",
  "ACAA", "TAGA", "CGGA", "CATA", "CAGC",
  "AACG", "AAGT", "CTCC", "AGAT", "ACCA",
  "AGTG", "GGTA", "GCGA", "AAAA", "ATGA"
)

# =============================================================================
# DATA LOADING
# =============================================================================

#' Load NEB overhang fidelity data for a given enzyme
#'
#' @param enzyme_name Name of enzyme ("BsaI" or "BsmBI")
#' @return Data frame with columns: overhang, fidelity (all 256 4-nt overhangs)
load_overhang_fidelity <- function(enzyme_name = "BsmBI") {
  data_path <- file.path(
    find_data_dir(), "neb_overhang_fidelity",
    paste0(tolower(enzyme_name), "_overhangs.rds")
  )
  if (file.exists(data_path)) {
    return(readRDS(data_path))
  }
  # Fallback: derive from pairwise matrix if available
  pw_path <- file.path(
    find_data_dir(), "neb_overhang_fidelity",
    paste0(tolower(enzyme_name), "_pairwise.rds")
  )
  if (file.exists(pw_path)) {
    cli::cli_alert_info("Deriving 1D fidelity from pairwise matrix for {enzyme_name}.")
    mat <- readRDS(pw_path)
    ohs <- rownames(mat)
    fid <- vapply(ohs, function(oh) mat[oh, oh] / sum(mat[oh, ]), numeric(1))
    return(data.frame(overhang = ohs, fidelity = unname(fid), stringsAsFactors = FALSE))
  }
  stop("BsmBI fidelity RDS not found at: ", data_path,
       "\n  and no pairwise matrix available at: ", pw_path)
}

#' Load a pre-validated high-fidelity overhang set
#'
#' Returns the Potapov 2018 Table 1, Set 3 (25 overhangs, 95.8% predicted set
#' fidelity) by default. This set was optimized via simulated annealing for SET
#' fidelity by NEB's GetSet tool. Falls back to greedy generation only if
#' explicitly requested via set_name.
#'
#' @param set_name Name of the set. Default "potapov_set3_25" returns the
#'   hard-coded Potapov Table 1 Set 3. Legacy names like "greedy_fidelity_20"
#'   will attempt to load from RDS, falling back to greedy generation.
#' @return Character vector of high-fidelity overhangs
load_high_fidelity_set <- function(set_name = "potapov_set3_25") {
  # Default: return the hard-coded Potapov Table 1 Set 3 (25 overhangs)
  if (set_name == "potapov_set3_25") {
    return(POTAPOV_TABLE1_SET3_25)
  }

  # Legacy path: try loading from RDS file for other named sets
  data_path <- file.path(
    find_data_dir(), "neb_overhang_fidelity",
    "high_fidelity_sets.rds"
  )
  if (file.exists(data_path)) {
    sets <- readRDS(data_path)
    if (set_name %in% names(sets)) {
      return(sets[[set_name]])
    }
  }

  stop("HF set '", set_name, "' not found in RDS or built-in sets.")
}

#' Load 256x256 pairwise ligation matrix
#'
#' M[X,Y] = ligation frequency of overhang X with RC(Y).
#' Correct ligation: M[X,X] (X ligates with RC(X)).
#' Cross-reactivity: M[X,Y] for Y != X.
#'
#' @param enzyme_name Enzyme name for enzyme-specific matrix
#' @return Named 256x256 numeric matrix
load_pairwise_matrix <- function(enzyme_name = "BsmBI") {
  data_path <- file.path(
    find_data_dir(), "neb_overhang_fidelity",
    paste0(tolower(enzyme_name), "_pairwise.rds")
  )
  if (file.exists(data_path)) {
    return(readRDS(data_path))
  }
  stop("Pairwise matrix RDS not found at: ", data_path)
}

# =============================================================================
# CORE MATH
# =============================================================================

#' Compute predicted set-level fidelity for overhangs in one reaction
#'
#' Uses the Potapov 2018 method:
#'   f(X) = M[X,X] / sum(M[X,Y] for Y in set)
#'   Set fidelity = product of f(X) for all X in set
#'
#' @param overhangs Character vector of overhangs in the reaction
#' @param pairwise_matrix Named 256x256 matrix (or NULL for fidelity-only estimate)
#' @return List with set_fidelity (numeric) and per_overhang (data.frame)
compute_set_fidelity <- function(overhangs, pairwise_matrix) {
  n <- length(overhangs)
  if (n < 2) {
    return(list(
      set_fidelity = 1.0,
      per_overhang = data.frame(
        overhang = overhangs, correct_fraction = 1.0,
        stringsAsFactors = FALSE
      )
    ))
  }

  per_oh_fidelity <- numeric(n)
  for (i in seq_len(n)) {
    oh_i <- overhangs[i]
    total <- sum(pairwise_matrix[oh_i, overhangs])
    correct <- pairwise_matrix[oh_i, oh_i]
    per_oh_fidelity[i] <- if (total > 0) correct / total else 0
  }

  list(
    set_fidelity = prod(per_oh_fidelity),
    per_overhang = data.frame(
      overhang = overhangs,
      correct_fraction = per_oh_fidelity,
      stringsAsFactors = FALSE
    )
  )
}

# =============================================================================
# OVERHANG SCORING (BUG-008 fix)
# =============================================================================
# Both metrics from BsmBI cycling matrix (Pryor et al. 2020):
#   Score = P_fid_bsmbi(oh) * P_eff_bsmbi(oh)
# P_fid = M[X][RC(X)] / sum(M[X][*])      — individual fidelity (accuracy)
# P_eff = M[X][RC(X)] / max_Y(M[Y][RC(Y)])  — relative ligation efficiency (yield)
# HF set bonus dropped: pairwise misligation negligible under cycling conditions.

#' Compute relative ligation efficiency for all 256 overhangs
#'
#' Efficiency measures how much correct product you get (yield), distinct from
#' fidelity (what fraction of product is correct). Extracted from the diagonal
#' of the 256x256 pairwise ligation matrix: P_eff(X) = M[X][X] / max(diag(M)).
#'
#' @param pairwise_matrix Named 256x256 matrix (diagonal = correct ligation).
#'   M[X,Y] = ligation frequency of overhang X with RC(Y). Diagonal M[X,X]
#'   gives the correct Watson-Crick ligation count.
#' @return Named numeric vector of length 256 (overhang -> efficiency in [0, 1],
#'   with the best overhang = 1.0)
compute_overhang_efficiency <- function(pairwise_matrix) {
  diagonal <- diag(pairwise_matrix)
  max_diag <- max(diagonal)
  # Guard against zero/degenerate matrix (shouldn't happen with real data)
  if (max_diag <= 0) {
    cli::cli_alert_warning("Pairwise matrix diagonal has max <= 0; returning uniform efficiency.")
    eff <- rep(1.0, length(diagonal))
    names(eff) <- rownames(pairwise_matrix)
    return(eff)
  }
  eff <- diagonal / max_diag
  names(eff) <- rownames(pairwise_matrix)
  eff
}

#' Compute overhang score from BsmBI cycling fidelity and efficiency
#'
#' Combines ligation fidelity (P_fid) and efficiency (P_eff) multiplicatively.
#' Both metrics sourced from BsmBI cycling data (Pryor et al. 2020), matching
#' actual assembly conditions.
#'
#' Score = P_fid(oh) * P_eff(oh)
#'
#' @param oh Character, 4-nt overhang sequence
#' @param fid_lookup Named numeric vector (overhang -> fidelity, i.e. P_fid)
#' @param eff_lookup Named numeric vector (overhang -> efficiency, i.e. P_eff)
#' @return Numeric score (higher is better)
overhang_score <- function(oh, fid_lookup, eff_lookup) {
  # Falls back to 0.5 for unknown/empty overhangs (conservative default).
  # This ensures multiplicative scoring never produces exact zeros.
  fid <- if (oh %in% names(fid_lookup)) unname(fid_lookup[oh]) else 0.5
  eff <- if (oh %in% names(eff_lookup)) unname(eff_lookup[oh]) else 0.5
  fid * eff
}

# =============================================================================
# DYNAMIC PROGRAMMING TILE BOUNDARY OPTIMIZER
# =============================================================================

#' Precompute boundary scores for all valid codon positions
#'
#' For each codon position b in the gene, extract the gene-derived overhangs
#' (oh1, oh2) and compute a composite score:
#'   score = overhang_score(oh1) + overhang_score(oh2) + penalty
#'
#' @param cds Domesticated gene sequence
#' @param oh_fidelity Data frame with overhang + fidelity columns
#' @param eff_lookup Named numeric vector (overhang -> efficiency from
#'   compute_overhang_efficiency()). If NULL, efficiency is treated as 1.0.
#' @param blacklisted_oh2 Character vector of oh2 sequences to invalidate
#'   (OPT-005: SB-aware blacklisting). Boundaries where oh2 is in this set
#'   are marked invalid. Default NULL (no blacklisting).
#' @param blacklisted_oh1 Character vector of oh1 sequences to invalidate
#'   (SB boundary collision prevention). Boundaries where oh1 matches any
#'   element (identity or RC) are marked invalid. Default NULL (no blacklisting).
#' @param overlap_codons Integer, tile overlap (rightward extension). oh2 is
#'   computed at the EXTENDED tile end (b + overlap_codons), not at the core
#'   boundary (b). Default 0 (no overlap, oh2 at core boundary).
#' @return List with vectors: oh1_seq, oh2_seq, score, valid (all length n_codons)
precompute_boundary_scores <- function(cds, oh_fidelity,
                                       eff_lookup = NULL,
                                       blacklisted_oh2 = NULL,
                                       blacklisted_oh1 = NULL,
                                       overlap_codons = 0L) {
  gene_len <- nchar(cds)
  n_codons <- gene_len %/% 3L
  oh_L <- substring(cds, 1, 4)
  oh_L_rc <- reverse_complement(oh_L)

  fid_lookup <- oh_fidelity$fidelity
  names(fid_lookup) <- oh_fidelity$overhang

  # Default efficiency: 1.0 for all overhangs (no efficiency penalty)
  if (is.null(eff_lookup)) {
    eff_lookup <- rep(1.0, nrow(oh_fidelity))
    names(eff_lookup) <- oh_fidelity$overhang
  }

  oh1_seq <- character(n_codons)
  oh2_seq <- character(n_codons)
  scores <- rep(-Inf, n_codons)
  valid <- logical(n_codons)
  oh1_hf <- logical(n_codons)
  oh2_hf <- logical(n_codons)

  cli::cli_alert_info("Precomputing boundary scores for {n_codons - 1L} candidate positions...")
  precomp_start <- proc.time()

  for (b in seq_len(n_codons - 1L)) {
    # oh1 is at the start of the NEXT tile (core boundary + 1), unchanged by overlap
    oh1_pos <- b * 3L + 1L
    oh1 <- substring(cds, oh1_pos, oh1_pos + 3L)
    # oh2 is at the EXTENDED tile end (core boundary + overlap_codons).
    # Tiles extend rightward by overlap_codons, capped at gene end.
    oh2_codon <- min(b + overlap_codons, n_codons)
    oh2_pos <- oh2_codon * 3L
    oh2 <- substring(cds, oh2_pos - 3L, oh2_pos)

    oh1_seq[b] <- oh1
    oh2_seq[b] <- oh2

    # Hard constraint: oh1 must not collide with oh_L in BsaI reaction
    if (oh1 == oh_L || oh1 == oh_L_rc) {
      valid[b] <- FALSE
      next
    }
    # SB blacklist: oh1 must not collide with any SB boundary overhang
    # (prevents tile boundary overhangs from reusing SB junction overhangs)
    if (!is.null(blacklisted_oh1) &&
      (oh1 %in% blacklisted_oh1 || reverse_complement(oh1) %in% blacklisted_oh1)) {
      valid[b] <- FALSE
      next
    }
    # OPT-005: blacklisted oh2 values (SB boundary collision prevention)
    if (!is.null(blacklisted_oh2) &&
      (oh2 %in% blacklisted_oh2 || reverse_complement(oh2) %in% blacklisted_oh2)) {
      valid[b] <- FALSE
      next
    }
    # Hard filter: palindromic overhangs cause self-ligation
    if (oh1 %in% PALINDROMIC_4NT || oh2 %in% PALINDROMIC_4NT) {
      valid[b] <- FALSE
      next
    }
    # Hard filter: homopolymer overhangs cause slippage during annealing
    if (oh1 %in% HOMOPOLYMER_4NT || oh2 %in% HOMOPOLYMER_4NT) {
      valid[b] <- FALSE
      next
    }
    valid[b] <- TRUE

    oh1_in <- oh1 %in% POTAPOV_TABLE1_SET3_25
    oh2_in <- oh2 %in% POTAPOV_TABLE1_SET3_25
    oh1_hf[b] <- oh1_in
    oh2_hf[b] <- oh2_in

    # Score = P_fid * P_eff for each overhang (both from BsmBI cycling, BUG-008)
    oh1_base <- overhang_score(oh1, fid_lookup, eff_lookup)
    oh2_base <- overhang_score(oh2, fid_lookup, eff_lookup)

    scores[b] <- oh1_base + oh2_base
  }

  precomp_elapsed <- (proc.time() - precomp_start)[["elapsed"]]
  cli::cli_alert_success("Boundary scores precomputed in {round(precomp_elapsed, 1)}s.")

  list(
    oh1_seq = oh1_seq, oh2_seq = oh2_seq,
    score = scores, valid = valid,
    oh1_hf = oh1_hf, oh2_hf = oh2_hf
  )
}

# =============================================================================
# SUPERBLOCK SPLIT-POINT OPTIMIZATION
# =============================================================================

#' Optimize superblock split positions for oversized gene blocks (greedy)
#'
#' Greedy search for split positions within the block where the gene-derived
#' junction overhang scores highest.
#'
#' @param cds Full domesticated gene sequence
#' @param block_start_nt Start position in gene (1-based)
#' @param block_end_nt End position in gene (1-based)
#' @param max_sub_length Max synthesis length for sub-blocks
#' @param existing_ohs Overhangs already committed in this reaction
#' @param oh_fidelity Fidelity data frame
#' @param search_window Search window in codons (default 50)
#' @param extra_content_length Additional content appended to the last sub-block
#'   (e.g., PolIII promoter length for 3'WT blocks) that isn't part of the gene
#'   region but must be counted for sizing. Default 0.
#' @param eff_lookup Named numeric vector (overhang -> efficiency). If NULL,
#'   efficiency is treated as 1.0 for all overhangs.
#' @return Data frame with split positions and junction overhangs
optimize_split_points <- function(cds, block_start_nt, block_end_nt,
                                  max_sub_length, existing_ohs,
                                  oh_fidelity,
                                  search_window = 50L,
                                  extra_content_length = 0L,
                                  eff_lookup = NULL) {
  gene_block_length <- block_end_nt - block_start_nt + 1L
  total_block_length <- gene_block_length + extra_content_length

  if (total_block_length <= max_sub_length) {
    return(data.frame(
      split_nt = integer(0), junction_oh = character(0),
      junction_in_hf = logical(0), junction_fidelity = numeric(0),
      stringsAsFactors = FALSE
    ))
  }

  fid_lookup <- oh_fidelity$fidelity
  names(fid_lookup) <- oh_fidelity$overhang

  # Default efficiency: 1.0 for all overhangs if not provided
  if (is.null(eff_lookup)) {
    eff_lookup <- rep(1.0, nrow(oh_fidelity))
    names(eff_lookup) <- oh_fidelity$overhang
  }

  # Enzyme site overhead per sub-block junction
  junction_overhead <- 22L # 2 x 11-nt enzyme sites
  effective_max <- max_sub_length - junction_overhead

  n_splits <- ceiling(total_block_length / effective_max) - 1L
  if (n_splits < 1L) n_splits <- 1L

  existing_set <- unique(c(existing_ohs, vapply(existing_ohs, reverse_complement, character(1))))

  # Search for split points, validating sub-block sizes; retry with more splits
  # if the search window drift causes any sub-block to exceed the limit
  max_retry <- 3L
  for (retry in seq_len(max_retry)) {
    target_sub_size <- gene_block_length / (n_splits + 1L)
    local_existing <- existing_set
    splits <- list()

    for (s in seq_len(n_splits)) {
      center_nt <- block_start_nt + as.integer(s * target_sub_size)
      center_codon <- center_nt %/% 3L

      lo_codon <- max((block_start_nt %/% 3L) + 5L, center_codon - search_window)
      hi_codon <- min((block_end_nt %/% 3L) - 5L, center_codon + search_window)

      best <- list(pos = center_codon * 3L, oh = "NNNN", in_hf = FALSE, fid = 0, score = -1)

      for (C in lo_codon:hi_codon) {
        split_nt <- C * 3L
        junction_oh <- substring(cds, split_nt - 3L, split_nt)

        if (junction_oh %in% local_existing) next # collision

        in_hf <- junction_oh %in% POTAPOV_TABLE1_SET3_25
        fid <- if (junction_oh %in% names(fid_lookup)) unname(fid_lookup[junction_oh]) else 0.5
        score <- overhang_score(junction_oh, fid_lookup, eff_lookup)

        if (score > best$score) {
          best <- list(pos = split_nt, oh = junction_oh, in_hf = in_hf, fid = fid, score = score)
        }
      }

      local_existing <- c(local_existing, best$oh, reverse_complement(best$oh))

      splits[[s]] <- data.frame(
        split_nt = best$pos, junction_oh = best$oh,
        junction_in_hf = best$in_hf, junction_fidelity = best$fid,
        stringsAsFactors = FALSE
      )
    }

    result <- do.call(rbind, splits)

    # Validate that all sub-blocks are within the size limit
    split_positions <- sort(result$split_nt)
    boundaries <- c(block_start_nt, split_positions, block_end_nt)
    all_ok <- TRUE
    for (j in seq_len(length(boundaries) - 1L)) {
      sub_content <- boundaries[j + 1L] - boundaries[j]
      # Last sub-block carries the extra content (e.g., PolIII promoter)
      if (j == length(boundaries) - 1L) {
        sub_content <- sub_content + extra_content_length
      }
      if (sub_content > max_sub_length) {
        all_ok <- FALSE
        break
      }
    }

    if (all_ok) break
    n_splits <- n_splits + 1L # Need more splits; retry
  }

  rownames(result) <- NULL
  result
}

# =============================================================================
# TILE-BOUNDARY SUPERBLOCK PARTITIONING
# =============================================================================

#' Check if two overhangs collide (identity or reverse complement)
#'
#' Two overhangs collide if they are identical or reverse complements of each
#' other. In a Golden Gate reaction, colliding overhangs would ligate
#' incorrectly, producing misassembled products.
#'
#' @param oh_a Character string, 4-nt overhang
#' @param oh_b Character string, 4-nt overhang
#' @return Logical TRUE if overhangs collide
oh_collides <- function(oh_a, oh_b) {
  oh_a == oh_b || oh_a == reverse_complement(oh_b)
}

#' Get all overhangs in a tile's BsmBI reaction
#'
#' For a tile in SB_i, the BsmBI (3'WT) reaction contains fragments joined by:
#'   - oh2 of this tile (tile → 3'WT junction)
#'   - SB boundary OHs visible to this tile: boundaries from SB_i onward,
#'     excluding self if this tile IS the SB boundary (self-collision excluded)
#'   - oh3 (last gene content → barcode junction)
#'
#' Used for per-tile collision validation: all returned OHs must be pairwise
#' distinct (no identity or RC collisions).
#'
#' @param partition_result Output from partition_tile_superblocks()
#' @param tile_idx Integer, tile index (1-based)
#' @param tiles Data frame of tiles (must have oh2_seq column)
#' @param oh3 Character, oh3 overhang sequence
#' @param enzyme_context Character, enzyme context ("bsmbi" supported)
#' @return Character vector of overhang sequences in this tile's reaction
get_tile_reaction_overhangs <- function(partition_result, tile_idx, tiles,
                                        oh3, enzyme_context) {
  sbs <- partition_result$superblocks
  n_sb <- partition_result$n_superblocks

  # Find which SB this tile belongs to
  my_sb_idx <- which(sbs$start_tile <= tile_idx & sbs$end_tile >= tile_idx)

  ohs <- character(0)

  if (enzyme_context == "bsmbi") {
    # oh2 of this tile
    ohs <- c(ohs, tiles$oh2_seq[tile_idx])

    # SB boundary OHs visible to this tile.
    # Boundaries are at end_tile of each non-final SB. A tile in SB_i sees:
    #   - SB_i boundary (if tile is NOT the last tile in SB_i)
    #   - SB_{i+1} through SB_{n-1} boundaries (always)
    # The last tile of SB_i has oh2 == SB_i boundary, so including it would
    # be a self-collision — we skip it.
    if (n_sb >= 2L) {
      for (si in seq_len(n_sb - 1L)) {
        if (si >= my_sb_idx) {
          boundary_tile <- sbs$end_tile[si]
          # Exclude self: if this tile IS the boundary, its oh2 is already in ohs
          if (boundary_tile != tile_idx) {
            ohs <- c(ohs, tiles$oh2_seq[boundary_tile])
          }
        }
      }
    }

    # oh3 (always present in BsmBI reactions)
    if (!is.null(oh3) && nchar(oh3) > 0L) {
      ohs <- c(ohs, oh3)
    }
  }

  ohs
}

#' Convert tile-boundary partition to legacy all_splits format
#'
#' Translates the output of partition_tile_superblocks() into the per-tile
#' split data frame consumed by design_wt_geneblocks() and R/12_report.R.
#' This is a compatibility shim — downstream consumers expect columns:
#' split_nt, junction_oh, junction_in_hf, junction_fidelity, block_type, tile_id.
#'
#' For each SB boundary (at tiles$end_nt[boundary_tile]):
#'   - bsmbi_3wt entries: tiles whose 3'WT region spans past this boundary
#'     (tile$end_nt < split_nt)
#'   - bsai_5wt entries: tiles whose 5'WT region spans back past this boundary
#'     (split_nt < tile$start_nt)
#'
#' @param partition_result List from partition_tile_superblocks()
#' @param tiles Data frame of tiles (must have end_nt, start_nt, oh2_seq,
#'   oh2_in_hf, oh2_fidelity, tile_id columns)
#' @param gene_len Length of the domesticated CDS in nucleotides
#' @param polIII_len Length of downstream cassette (unused, kept for interface
#'   consistency)
#' @return Data frame with columns: split_nt, junction_oh, junction_in_hf,
#'   junction_fidelity, block_type, tile_id. Empty (0-row) if n_superblocks <= 1.
convert_partition_to_splits <- function(partition_result, tiles, gene_len,
                                        polIII_len = 0L) {
  empty_result <- data.frame(
    split_nt = integer(0), junction_oh = character(0),
    junction_in_hf = logical(0), junction_fidelity = numeric(0),
    block_type = character(0), tile_id = integer(0),
    stringsAsFactors = FALSE
  )

  sbs <- partition_result$superblocks
  n_sb <- partition_result$n_superblocks

  # No splits needed if only 1 superblock
  if (n_sb <= 1L) {
    return(empty_result)
  }

  n_tiles <- nrow(tiles)
  splits_list <- vector("list", 0L)

  # Pre-extract boundary info for each SB boundary (between SB bi and SB bi+1)
  for (bi in seq_len(n_sb - 1L)) {
    boundary_tile <- sbs$end_tile[bi]
    split_nt <- tiles$end_nt[boundary_tile]
    junction_oh <- tiles$oh2_seq[boundary_tile]
    junction_in_hf <- tiles$oh2_in_hf[boundary_tile]
    junction_fidelity <- tiles$oh2_fidelity[boundary_tile]

    # --- bsmbi_3wt entries ---
    # Tile t's 3'WT region: [tile_t.end_nt + 1, gene_len]
    # This boundary is within that region if tile_t.end_nt < split_nt
    for (t in seq_len(n_tiles)) {
      if (tiles$end_nt[t] < split_nt) {
        splits_list[[length(splits_list) + 1L]] <- data.frame(
          split_nt = split_nt,
          junction_oh = junction_oh,
          junction_in_hf = junction_in_hf,
          junction_fidelity = junction_fidelity,
          block_type = "bsmbi_3wt",
          tile_id = tiles$tile_id[t],
          stringsAsFactors = FALSE
        )
      }
    }

    # --- bsai_5wt entries ---
    # Tile t's 5'WT region: [1, tile_t.start_nt - 1]
    # This boundary is within that region if split_nt < tile_t.start_nt
    # (and tile must actually have a 5'WT region, i.e., start_nt > 1)
    for (t in seq_len(n_tiles)) {
      if (tiles$start_nt[t] > 1L && split_nt < tiles$start_nt[t]) {
        splits_list[[length(splits_list) + 1L]] <- data.frame(
          split_nt = split_nt,
          junction_oh = junction_oh,
          junction_in_hf = junction_in_hf,
          junction_fidelity = junction_fidelity,
          block_type = "bsai_5wt",
          tile_id = tiles$tile_id[t],
          stringsAsFactors = FALSE
        )
      }
    }
  }

  if (length(splits_list) > 0) {
    all_splits <- do.call(rbind, splits_list)
    rownames(all_splits) <- NULL
    all_splits
  } else {
    empty_result
  }
}

# =============================================================================
# PROMOTER-DERIVED oh3
# =============================================================================

#' Derive oh3 overhang and spacer from the PolIII promoter's 3' end
#'
#' In PerturbView/pCROP-Seq-v2 architecture, oh3 (the BsmBI overhang at the
#' PolIII–barcode junction) is derived from the promoter's terminal nucleotides:
#'   - Last 5 nt of promoter = oh3 (4 nt) + spacer (1 nt)
#'   - Example: promoter ends ...GAAACACCG → oh3=CACC, spacer=G
#'   - core_polIII = promoter minus last 5 nt (used in gene blocks)
#'
#' After BsmBI digestion and ligation, the junction reconstructs:
#'   ...core_polIII + oh3 + barcode (seamless, no duplicated sequence)
#'
#' The terminal nucleotide (spacer) is positioned between the BsmBI recognition
#' site and the overhang on the gene block. It is cut away during digestion, so
#' it doesn't appear in the final assembled product — but it must be present for
#' BsmBI to recognize and cut the block correctly.
#'
#' @param polIII Character string of PolIII promoter sequence
#' @return List with oh3, spacer, core_polIII; or NULL if promoter < 5 nt
derive_oh3_from_promoter <- function(polIII) {
  polIII_upper <- toupper(polIII)
  n <- nchar(polIII_upper)
  if (n < 5L) {
    return(NULL)
  }

  oh3 <- substring(polIII_upper, n - 4L, n - 1L) # 4 nt overhang
  spacer <- substring(polIII_upper, n, n) # terminal nucleotide
  core_polIII <- substring(polIII_upper, 1L, n - 5L) # promoter without oh3+spacer

  list(oh3 = oh3, spacer = spacer, core_polIII = core_polIII)
}

# =============================================================================
# SB DP → PARTITION CONVERSION
# =============================================================================

#' Convert SB DP result to partition_result format for downstream compatibility
#'
#' Maps SB DP boundary positions to tile indices. Since gene-region boundaries
#' are constrained to tile end positions (via allowed_gene_positions), every
#' gene-portion boundary maps to exactly one tile's end_nt. Cassette-region
#' boundaries are extracted separately for the gene block designer.
#'
#' @param sb_result List from search_superblock_boundaries_dp()
#' @param tiles Data frame of tiles (must have end_nt, oh2_seq columns)
#' @param gene_len Integer, length of gene CDS in nucleotides
#' @param polIII_len Integer, length of downstream cassette
#' @param max_block_length Integer, max synthesis length
#' @param block_overhead Integer, overhead per block (enzyme sites)
#' @param oh_fidelity Data frame with overhang + fidelity columns
#' @return List with n_superblocks, superblocks (tile-indexed), n_collisions,
#'   cassette_needs_splitting, cassette_splits
sb_dp_to_partition <- function(sb_result, tiles, gene_len, polIII_len,
                               max_block_length, block_overhead,
                               oh_fidelity = NULL) {
  sb_df <- sb_result$boundaries
  n_sb_total <- sb_result$n_superblocks
  n_tiles <- nrow(tiles)

  # Build fidelity lookup if provided
  fid_lookup <- NULL
  if (!is.null(oh_fidelity)) {
    fid_lookup <- oh_fidelity$fidelity
    names(fid_lookup) <- oh_fidelity$overhang
  }

  # --- Map gene-region SB boundaries to tile indices ---
  # Each gene-region boundary (end_nt of a non-final SB, where end_nt <= gene_len)
  # should be at a tile's end_nt. Build a lookup from end_nt → tile index.
  tile_end_lookup <- tiles$end_nt
  names(tile_end_lookup) <- seq_len(n_tiles)

  # Collect gene-region SB boundaries (positions where SB ends within gene)
  gene_sb_boundary_positions <- integer(0)
  for (i in seq_len(n_sb_total - 1L)) {
    if (sb_df$end_nt[i] <= gene_len) {
      gene_sb_boundary_positions <- c(gene_sb_boundary_positions, sb_df$end_nt[i])
    }
  }

  # Map boundary positions to tile indices
  sb_end_tiles <- integer(0)
  for (bp in gene_sb_boundary_positions) {
    tile_match <- which(tiles$end_nt == bp)
    if (length(tile_match) == 0L) {
      cli::cli_alert_warning(paste0(
        "SB boundary at position ", bp,
        " does not match any tile end_nt. Skipping."
      ))
      next
    }
    sb_end_tiles <- c(sb_end_tiles, tile_match[1])
  }
  # Close the last SB with the last tile
  sb_end_tiles <- c(sb_end_tiles, n_tiles)

  n_sb_gene <- length(sb_end_tiles)
  sb_start_tiles <- c(1L, sb_end_tiles[-n_sb_gene] + 1L)

  # Compute gene content per SB
  gene_contents <- integer(n_sb_gene)
  for (i in seq_len(n_sb_gene)) {
    left_nt <- if (i == 1L) 0L else tiles$end_nt[sb_end_tiles[i - 1L]]
    right_nt <- if (i == n_sb_gene) gene_len else tiles$end_nt[sb_end_tiles[i]]
    gene_contents[i] <- right_nt - left_nt
  }

  superblocks <- data.frame(
    sb_id = seq_len(n_sb_gene),
    start_tile = sb_start_tiles,
    end_tile = sb_end_tiles,
    gene_content = gene_contents,
    stringsAsFactors = FALSE
  )

  # --- Extract cassette-region SB boundaries ---
  # Defense-in-depth: only extract cassette splits when the cassette actually
  # needs splitting. With the upstream fix in precompute_sb_boundary_candidates(),
  # the DP shouldn't place cassette-region boundaries when cassette fits in one
  # block — but this guard catches any edge cases.
  max_sub_content <- max_block_length - block_overhead
  cassette_needs_splitting <- polIII_len > max_sub_content

  cassette_splits <- data.frame(
    split_pos = integer(0), junction_oh = character(0),
    stringsAsFactors = FALSE
  )
  if (cassette_needs_splitting) {
    for (i in seq_len(n_sb_total - 1L)) {
      if (sb_df$end_nt[i] > gene_len && !is.na(sb_df$boundary_oh[i])) {
        cassette_splits <- rbind(cassette_splits, data.frame(
          split_pos = sb_df$end_nt[i] - gene_len,
          junction_oh = sb_df$boundary_oh[i],
          stringsAsFactors = FALSE
        ))
      }
    }
  }

  if (nrow(cassette_splits) > 0) {
    cli::cli_alert_info(paste0(
      "SB DP placed ", nrow(cassette_splits), " cassette boundary(ies) at positions ",
      paste(cassette_splits$split_pos, collapse = ", "),
      " (overhangs: ", paste(cassette_splits$junction_oh, collapse = ", "), ")"
    ))
  }

  list(
    n_superblocks = n_sb_gene,
    superblocks = superblocks,
    n_collisions = 0L,
    cassette_needs_splitting = cassette_needs_splitting,
    cassette_splits = cassette_splits
  )
}

# =============================================================================
# MASTER ASSEMBLY PLANNER (Hybrid: Tile-First DP + Constrained SB DP)
# =============================================================================

#' Plan the complete assembly: tiles, overhangs, and superblock splits
#'
#' Hybrid assembly planner combining tile-first DP (natural overhang diversity)
#' with constrained SB DP (optimal segment sizing + cassette splitting).
#'
#'   Pass 1 (Phase 1-3): Tile DP on gene only → tile boundaries with diverse oh2s
#'   Phase 1: Select fixed overhangs (oh_L, oh3, oh4) — constrained first
#'   Phase 2: Tile boundary DP (blacklists oh3/oh4), with SB-aware refinement
#'   Phase 3: SB DP on gene+cassette, constrained to tile boundary positions
#'   Phase 4: Per-reaction pairwise validation
#'
#' @param cds Domesticated gene sequence
#' @param polIII PolIII promoter sequence
#' @param max_mutable_nt Max mutable region in nt (from compute_max_tile_size)
#' @param max_block_length Max synthesis length (default 1800)
#' @param config List with manual_oh3, manual_oh4,
#'   search_window_K, min_mutable_codons
#' @param downstream_cassette Full downstream cassette sequence (intergene + polIII).
#'   When NULL (default), uses polIII only — backward compatible.
#' @return assembly_plan list (see plan doc Section 5.2)
plan_assembly <- function(cds, polIII, max_mutable_nt,
                          max_block_length = MAX_GENEBLOCK_LENGTH,
                          config = list(),
                          downstream_cassette = NULL) {
  gene_len <- nchar(cds)
  # For oh3 derivation, always use polIII (the last element, adjacent to barcode).
  # For block length calculations, use the full downstream cassette length.
  polIII_len <- if (!is.null(downstream_cassette)) nchar(downstream_cassette) else nchar(polIII)

  # Unpack config with defaults
  manual_oh3 <- config$manual_oh3
  manual_oh4 <- config$manual_oh4
  search_window_K <- config$search_window_K %||% 15L
  dp_k_range <- config$dp_k_range %||% 5L
  boundary_method <- config$boundary_method %||% "dp"
  oogga_max_identity <- config$oogga_max_identity %||% 2L
  oogga_beam_width <- config$oogga_beam_width %||% 10L
  multi_k <- config$multi_k %||% TRUE
  overlap_codons <- config$overlap_codons %||% 4L
  min_geneblock_length <- config$min_geneblock_length %||% MIN_GENEBLOCK_LENGTH
  min_mutable_nt <- config$min_mutable_nt
  if (is.null(min_mutable_nt)) {
    min_mutable_nt <- max(81L, max_mutable_nt %/% 3L)
    min_mutable_nt <- (min_mutable_nt %/% 3L) * 3L
  }

  # Load data
  # BsmBI cycling fidelity (Pryor 2020) for boundary scoring — matches actual
  # assembly conditions and is more conservative than T4 static data.
  hf_set <- load_high_fidelity_set() # informational only, not used in scoring
  oh_fidelity <- load_overhang_fidelity("BsmBI")

  # Load real enzyme-specific 256x256 pairwise matrices (Pryor et al. 2020).
  # Used for scoring (P_fid * P_eff) and set fidelity validation.
  bsai_matrix <- load_pairwise_matrix("BsaI")
  bsmbi_matrix <- load_pairwise_matrix("BsmBI")
  eff_lookup <- compute_overhang_efficiency(bsmbi_matrix)

  # =========================================================================
  # Phase 1: Select fixed overhangs (oh_L, oh3, oh4) before any DP
  # =========================================================================
  # These are physical constraints — oh_L is the gene's first 4 nt, oh3 is
  # derived from the PolIII promoter (or score-selected), oh4 is score-selected.
  # All three are committed before the tile DP runs so the DP can route around
  # them. Constrained things first, flexible things second.
  cli::cli_h3("Phase 1: Selecting fixed overhangs (oh_L, oh3, oh4)")
  oh_L <- substring(cds, 1, 4)
  fid_lookup <- oh_fidelity$fidelity
  names(fid_lookup) <- oh_fidelity$overhang
  strategy_used <- "promoter_derived"
  core_polIII <- NULL
  oh3_spacer <- NULL

  if (!is.null(manual_oh3) && !is.null(manual_oh4)) {
    validate_fixed_overhangs(manual_oh3, manual_oh4)
    oh3 <- toupper(manual_oh3)
    oh4 <- toupper(manual_oh4)
    oh3_in_hf <- oh3 %in% hf_set
    oh4_in_hf <- oh4 %in% hf_set
    strategy_used <- "manual"
    cli::cli_alert_info(paste0("Using manual overhangs: oh3=", oh3, ", oh4=", oh4))
  } else {
    # --- oh3: derive from PolIII promoter 3' end ---
    # In PerturbView/pCROP-Seq-v2 architecture, the promoter's terminal 5 nt
    # encode oh3 (4 nt overhang) + spacer (1 nt for BsmBI), so the BsmBI
    # junction seamlessly reconstructs the promoter-barcode boundary.
    # oh3 is a fixed constraint — it does NOT check against oh2 (which doesn't
    # exist yet). The tile DP will blacklist oh3 and route around it.
    promoter_derived <- derive_oh3_from_promoter(polIII)

    if (!is.null(promoter_derived) &&
      !(promoter_derived$oh3 %in% HOMOPOLYMER_4NT) &&
      !(promoter_derived$oh3 %in% PALINDROMIC_4NT)) {
      oh3 <- promoter_derived$oh3
      core_polIII <- promoter_derived$core_polIII
      oh3_spacer <- promoter_derived$spacer
      oh3_in_hf <- oh3 %in% hf_set
      oh3_fid <- if (oh3 %in% names(fid_lookup)) unname(fid_lookup[oh3]) else NA_real_
      cli::cli_alert_info(paste0(
        "Derived oh3=", oh3, " from PolIII promoter 3' end",
        " (fidelity=", round(oh3_fid, 3), ")"
      ))
    } else {
      # Promoter-derived oh3 not usable — fall back to score-based selection
      if (is.null(promoter_derived)) {
        cli::cli_alert_warning("PolIII promoter too short for oh3 derivation. Falling back to score-based selection.")
      } else {
        cli::cli_alert_warning(paste0(
          "Promoter-derived oh3=", promoter_derived$oh3,
          " is homopolymer or palindromic. Falling back to score-based selection."
        ))
      }
      strategy_used <- "score_based"
      # Select by P_fid * P_eff (BUG-008: no HF set preference)
      oh3_candidates <- oh_fidelity$overhang[oh_fidelity$fidelity >= 0.50]
      oh3_candidates <- oh3_candidates[!(oh3_candidates %in% HOMOPOLYMER_4NT)]
      oh3_candidates <- oh3_candidates[!(oh3_candidates %in% PALINDROMIC_4NT)]

      if (length(oh3_candidates) == 0) stop("Cannot find any valid oh3 candidate.")
      oh3_scores <- unname(fid_lookup[oh3_candidates]) * unname(eff_lookup[oh3_candidates])
      oh3 <- oh3_candidates[which.max(oh3_scores)]
      oh3_in_hf <- oh3 %in% hf_set
    }

    # --- oh4: auto-select by P_fid * P_eff (BUG-008: no HF preference) ---
    # oh4 is in the BsaI reaction with oh_L, so it must avoid oh_L collision.
    # It does NOT check against oh1 (which doesn't exist yet) — the tile DP
    # will blacklist oh4 and route around it.
    oh4_exclude <- unique(c(oh_L, reverse_complement(oh_L)))
    oh4_candidates <- oh_fidelity$overhang[oh_fidelity$fidelity >= 0.50]
    oh4_candidates <- oh4_candidates[!(oh4_candidates %in% oh4_exclude)]
    oh4_candidates <- oh4_candidates[!(oh4_candidates %in% HOMOPOLYMER_4NT)]
    oh4_candidates <- oh4_candidates[!(oh4_candidates %in% PALINDROMIC_4NT)]

    if (length(oh4_candidates) == 0) stop("Cannot find any valid oh4 candidate.")
    oh4_scores <- unname(fid_lookup[oh4_candidates]) * unname(eff_lookup[oh4_candidates])
    oh4 <- oh4_candidates[which.max(oh4_scores)]
    oh4_in_hf <- oh4 %in% hf_set
  }

  cli::cli_alert_success(paste0(
    "Fixed overhangs: oh3=", oh3,
    if (oh3_in_hf) " (HF)" else " (non-HF)",
    ", oh4=", oh4,
    if (oh4_in_hf) " (HF)" else " (non-HF)"
  ))

  # =========================================================================
  # Phase 2+3: Tile boundaries + Superblock partitioning
  # =========================================================================
  # OOGGA methods handle collision prevention inside the DP transition,
  # so they bypass the iterative refinement loop entirely.
  # Legacy methods (dp, greedy) use the existing iterative blacklisting.

  is_oogga <- boundary_method %in% c("oogga_two_pass", "oogga_greedy", "oogga_single", "oogga_two_pass_mc")

  # Build alien overhangs set — fixed overhangs that OOGGA must avoid
  # (oh3, oh4, oh_L, and all their RCs)
  alien_ohs <- unique(c(
    oh3, reverse_complement(oh3),
    oh4, reverse_complement(oh4),
    oh_L, reverse_complement(oh_L)
  ))

  # Build the full sequence: gene + cassette (needed for SB DP)
  cassette_seq <- if (!is.null(downstream_cassette) && !is.null(core_polIII)) {
    substring(downstream_cassette, 1, nchar(downstream_cassette) - 5L)
  } else if (!is.null(core_polIII)) {
    core_polIII
  } else {
    ""
  }

  block_overhead <- 22L # 2 x 11-nt enzyme sites per block

  if (is_oogga) {
    # =======================================================================
    # OOGGA collision-aware path (Phases 2+3 combined)
    # =======================================================================
    # Architecture: SB-first → per-segment tile search.
    # Pass 1: SB DP on full gene+cassette → SB boundaries + junction OHs.
    # Pass 2: Tile DP/greedy per SB segment, with ALL SB junction OHs as
    #   alien. Tiles naturally end at SB boundaries → perfect alignment.
    #
    # Collision prevention is built into the DP transition — no iterative
    # blacklisting needed.
    cli::cli_h3(paste0(
      "Phase 2+3: OOGGA collision-aware boundary selection (",
      boundary_method, ")"
    ))

    if (boundary_method == "oogga_single") {
      # A3: Single-pass OOGGA on entire gene+cassette
      # (intentionally single collision domain — over-constrains, but simplest)
      cli::cli_alert_info("Using OOGGA single-pass DP")
      single_result <- search_boundaries_oogga_single(
        cds = cds,
        cassette_seq = cassette_seq,
        max_mutable_nt = max_mutable_nt,
        min_mutable_nt = min_mutable_nt,
        max_block_length = max_block_length,
        min_block_length = min_geneblock_length,
        oh_fidelity = oh_fidelity,
        eff_lookup = eff_lookup,
        alien_ohs = alien_ohs,
        max_identity = oogga_max_identity,
        beam_width = oogga_beam_width,
        dp_k_range = dp_k_range,
        overlap_codons = overlap_codons
      )
      tiles <- single_result$tiles
      sb_result <- single_result$sb_result
    } else {
      # A1/A2: SB-first OOGGA DP → tile boundary search
      # ---------------------------------------------------------------
      # Pass 1: SB boundaries on full gene+cassette
      # ---------------------------------------------------------------
      # SBs at ANY codon position — no tile constraint. SB junction OHs
      # must avoid fixed overhangs (oh3, oh4, oh_L) but know nothing
      # about tile boundaries yet.
      full_seq_for_sb <- paste0(cds, cassette_seq)
      total_content_len <- nchar(full_seq_for_sb)

      if (total_content_len <= (max_block_length - block_overhead)) {
        # Gene+cassette fits in one block — no SB splits needed
        sb_result <- list(
          n_superblocks = 1L,
          boundaries = data.frame(
            sb_id = 1L, start_nt = 1L, end_nt = total_content_len,
            boundary_oh = NA_character_, boundary_score = NA_real_,
            stringsAsFactors = FALSE
          ),
          total_score = 0
        )
        sb_junction_ohs <- character(0)
        cli::cli_alert_info("Gene+cassette fits in 1 block — no SB splits needed.")
      } else {
        cli::cli_alert_info("Pass 1: SB boundary search (OOGGA DP)")
        # Determine if cassette needs splitting BEFORE DP so we can constrain
        # the search space. When cassette fits in one block, exclude cassette
        # positions to prevent unnecessary splitting.
        max_sub_content <- max_block_length - block_overhead
        cass_needs_split <- polIII_len > max_sub_content
        sb_result <- search_sb_boundaries_oogga(
          full_seq = full_seq_for_sb,
          gene_len = gene_len,
          max_block_length = max_block_length - block_overhead,
          min_block_length = min_geneblock_length,
          alien_ohs = alien_ohs, # oh3, oh4, oh_L + RCs
          oh_fidelity = oh_fidelity,
          eff_lookup = eff_lookup,
          max_identity = oogga_max_identity,
          beam_width = oogga_beam_width,
          cassette_needs_splitting = cass_needs_split
          # NO allowed_gene_positions — SBs at any codon position
        )
        # Extract the actual junction overhangs from the SB result
        sb_junction_ohs <- sb_result$boundaries$boundary_oh[
          !is.na(sb_result$boundaries$boundary_oh)
        ]
      }

      # ---------------------------------------------------------------
      # Pass 2: Per-segment tile search
      # ---------------------------------------------------------------
      # Each SB segment gets its own tile DP/greedy. SB junction OHs are
      # alien to prevent tile OH collisions with SB OHs in the BsmBI
      # reaction pot. This ensures SB boundaries = tile boundaries →
      # perfect alignment, no skipping in sb_dp_to_partition().
      cli::cli_alert_info(paste0(
        "Pass 2: Per-segment tile search (",
        if (boundary_method %in% c("oogga_two_pass", "oogga_two_pass_mc")) {
          "OOGGA DP"
        } else {
          "OOGGA greedy"
        }, ")"
      ))
      tiles <- tile_segments_oogga(
        cds = cds,
        sb_result = sb_result,
        gene_len = gene_len,
        max_mutable_nt = max_mutable_nt,
        min_mutable_nt = min_mutable_nt,
        oh_fidelity = oh_fidelity,
        eff_lookup = eff_lookup,
        base_alien_ohs = alien_ohs, # oh3, oh4, oh_L + RCs
        max_identity = oogga_max_identity,
        beam_width = oogga_beam_width,
        tile_method = if (boundary_method == "oogga_two_pass_mc") "oogga_two_pass" else boundary_method,
        multi_k = multi_k,
        dp_k_range = dp_k_range,
        overlap_codons = overlap_codons,
        mc_refine = (boundary_method == "oogga_two_pass_mc"),
        mc_iterations = config$mc_iterations %||% 1000L,
        mc_temperature = config$mc_temperature %||% 1.0,
        mc_cooling_rate = config$mc_cooling_rate %||% 0.995
      )
    }

    # Convert SB result to partition format (shared with legacy path)
    n_tiles <- nrow(tiles)
    full_seq_for_sb <- paste0(cds, cassette_seq)
    total_content_len <- nchar(full_seq_for_sb)

    if (total_content_len <= (max_block_length - block_overhead)) {
      partition_result <- list(
        n_superblocks = 1L,
        superblocks = data.frame(
          sb_id = 1L, start_tile = 1L, end_tile = n_tiles,
          gene_content = gene_len, stringsAsFactors = FALSE
        ),
        n_collisions = 0L,
        cassette_needs_splitting = FALSE,
        cassette_splits = data.frame(
          split_pos = integer(0), junction_oh = character(0),
          stringsAsFactors = FALSE
        )
      )
      cassette_splits <- partition_result$cassette_splits
    } else {
      partition_result <- sb_dp_to_partition(
        sb_result = sb_result,
        tiles = tiles,
        gene_len = gene_len,
        polIII_len = polIII_len,
        max_block_length = max_block_length,
        block_overhead = block_overhead,
        oh_fidelity = oh_fidelity
      )
      cassette_splits <- partition_result$cassette_splits
      # OOGGA methods enforce collisions in DP — set n_collisions=0
      partition_result$n_collisions <- 0L
    }
  } else {
    # =======================================================================
    # Legacy path: existing dp/greedy with iterative SB refinement
    # =======================================================================
    cli::cli_h3("Phase 2: Searching tile boundaries")

    # Fixed-overhang blacklist: oh3 collides with oh2 (BsmBI), oh4 with oh1 (BsaI).
    # Passing both via sb_blacklist ensures neither appears as oh1 or oh2.
    fixed_oh_blacklist <- unique(c(
      oh3, reverse_complement(oh3),
      oh4, reverse_complement(oh4)
    ))

    max_sb_iterations <- 5L
    blacklisted_oh2 <- HOMOPOLYMER_4NT

    for (sb_iter in seq_len(max_sb_iterations)) {
      if (sb_iter > 1L) {
        cli::cli_h3(paste0(
          "SB-aware refinement iteration ", sb_iter,
          " (blacklisted: ", paste(blacklisted_oh2, collapse = ", "), ")"
        ))
      }

      if (boundary_method == "dp") {
        if (sb_iter == 1L) cli::cli_alert_info("Using DP optimizer")
        tiles <- search_tile_boundaries_dp(
          cds = cds,
          max_mutable_nt = max_mutable_nt,
          min_mutable_nt = min_mutable_nt,
          oh_fidelity = oh_fidelity,
          multi_k = multi_k,
          dp_k_range = dp_k_range,
          overlap_codons = overlap_codons,
          eff_lookup = eff_lookup,
          blacklisted_oh2 = if (length(blacklisted_oh2) > 0) blacklisted_oh2 else NULL,
          sb_blacklist = fixed_oh_blacklist
        )
      } else {
        if (sb_iter == 1L) cli::cli_alert_info("Using greedy search")
        tiles <- search_tile_boundaries(
          cds = cds,
          max_mutable_nt = max_mutable_nt,
          min_mutable_nt = min_mutable_nt,
          oh_fidelity = oh_fidelity,
          eff_lookup = eff_lookup,
          search_window_K = search_window_K
        )
        # Greedy doesn't support blacklisting — can't iterate
        if (sb_iter > 1L) {
          cli::cli_alert_warning("Greedy boundary method does not support SB-aware refinement.")
          break
        }
      }

      # Trial SB partitioning to check for collisions
      block_overhead_iter <- 22L
      trial_partition <- partition_tile_superblocks(
        tiles = tiles,
        gene_len = gene_len,
        polIII_len = polIII_len,
        max_sub_length = max_block_length - block_overhead_iter,
        oh3 = oh3,
        oh4 = oh4
      )

      if (trial_partition$n_collisions == 0L) {
        if (sb_iter > 1L) {
          cli::cli_alert_success(paste0(
            "SB collision resolved after ", sb_iter, " iteration(s)."
          ))
        }
        break
      }

      # Collision found — identify the colliding oh2 values and blacklist them.
      sbs <- trial_partition$superblocks
      sb_end_tiles <- sbs$end_tile[seq_len(nrow(sbs) - 1L)]
      new_blacklist <- character(0)

      for (bi in seq_along(sb_end_tiles)) {
        boundary_tile <- sb_end_tiles[bi]
        boundary_oh <- tiles$oh2_seq[boundary_tile]
        boundary_pos <- tiles$end_nt[boundary_tile]

        for (t in seq_len(nrow(tiles))) {
          if (tiles$start_nt[t] > boundary_pos &&
            oh_collides(boundary_oh, tiles$oh1_seq[t])) {
            new_blacklist <- c(new_blacklist, boundary_oh)
            break
          }
        }
        for (t in seq_len(nrow(tiles))) {
          if (t == boundary_tile) next
          if (tiles$end_nt[t] < boundary_pos &&
            oh_collides(boundary_oh, tiles$oh2_seq[t])) {
            new_blacklist <- c(new_blacklist, boundary_oh)
            break
          }
        }
        if (oh_collides(boundary_oh, oh3)) {
          new_blacklist <- c(new_blacklist, boundary_oh)
        }
        if (oh_collides(boundary_oh, oh4)) {
          new_blacklist <- c(new_blacklist, boundary_oh)
        }
      }

      new_blacklist <- unique(new_blacklist)
      new_blacklist <- new_blacklist[!(new_blacklist %in% blacklisted_oh2)]

      if (length(new_blacklist) == 0L) {
        cli::cli_alert_warning(paste0(
          "SB collision detected but no new oh2 to blacklist. ",
          trial_partition$n_collisions, " unresolved collision(s) remain."
        ))
        break
      }

      blacklisted_oh2 <- unique(c(blacklisted_oh2, new_blacklist))
      cli::cli_alert_info(paste0(
        "SB collision: blacklisting oh2=", paste(new_blacklist, collapse = ", "),
        ". Re-running DP..."
      ))
    } # end sb_iter loop

    # =========================================================================
    # Phase 3: Constrained SB DP on gene+cassette
    # =========================================================================
    # Runs the SB DP with gene-region boundaries constrained to tile end positions
    # (allowed_gene_positions). This gives optimal segment sizing with natural
    # overhang diversity (tile oh2s are inherently different at ~240 nt spacing).
    # Cassette-region boundaries remain unrestricted.
    cli::cli_h3("Phase 3: Superblock partitioning (constrained SB DP)")
    # block_overhead, cassette_seq already defined above
    n_tiles <- nrow(tiles)

    # Blacklist: oh_L, oh3, oh4, their RCs, homopolymers — these overhangs
    # must not appear at SB boundaries since they're committed elsewhere
    sb_blacklist_ohs <- unique(c(
      oh_L, reverse_complement(oh_L),
      oh3, reverse_complement(oh3),
      oh4, reverse_complement(oh4),
      HOMOPOLYMER_4NT
    ))

    # Tile end positions = allowed gene-region boundary positions for SB DP.
    # Exclude the last tile's end (gene end = always the SB terminus, never a
    # boundary position — no SB boundary can be placed at the very end of the gene).
    tile_end_positions <- tiles$end_nt[-n_tiles]

    # If gene + cassette is short enough for 1 block, skip the SB DP
    full_seq_for_sb <- paste0(cds, cassette_seq)
    total_content_len <- nchar(full_seq_for_sb)

    if (total_content_len <= (max_block_length - block_overhead)) {
      # No SB split needed
      partition_result <- list(
        n_superblocks = 1L,
        superblocks = data.frame(
          sb_id = 1L, start_tile = 1L, end_tile = n_tiles,
          gene_content = gene_len, stringsAsFactors = FALSE
        ),
        n_collisions = 0L,
        cassette_needs_splitting = FALSE,
        cassette_splits = data.frame(
          split_pos = integer(0), junction_oh = character(0),
          stringsAsFactors = FALSE
        )
      )
      sb_result <- list(
        n_superblocks = 1L,
        boundaries = data.frame(
          sb_id = 1L, start_nt = 1L, end_nt = total_content_len,
          boundary_oh = NA_character_, boundary_score = NA_real_,
          stringsAsFactors = FALSE
        ),
        total_score = 0
      )
      cassette_splits <- partition_result$cassette_splits
    } else {
      # Run constrained SB DP with collision avoidance loop
      max_sb_collision_iters <- 10L
      sb_extra_blacklist <- character(0)

      # Build cassette-specific blacklist from all tile oh1/oh2 and their RCs.
      # Cassette junction OHs participate in every tile's BsmBI reaction, so
      # they must not match any tile oh1 or oh2 — pre-exclude them from DP.
      cassette_oh_blacklist <- unique(c(
        tiles$oh1_seq, tiles$oh2_seq,
        vapply(tiles$oh1_seq, reverse_complement, character(1)),
        vapply(tiles$oh2_seq, reverse_complement, character(1))
      ))

      for (sb_coll_iter in seq_len(max_sb_collision_iters)) {
        if (sb_coll_iter > 1L) {
          cli::cli_alert_info(paste0(
            "SB collision avoidance iteration ", sb_coll_iter,
            " (extra blacklist: ", paste(sb_extra_blacklist, collapse = ", "), ")"
          ))
        }

        current_sb_blacklist <- unique(c(
          sb_blacklist_ohs, sb_extra_blacklist,
          vapply(sb_extra_blacklist, reverse_complement, character(1))
        ))

        sb_result <- search_superblock_boundaries_dp(
          full_seq = full_seq_for_sb,
          gene_len = gene_len,
          max_block_length = max_block_length - block_overhead,
          min_block_length = config$min_geneblock_length %||% MIN_GENEBLOCK_LENGTH,
          blacklist_ohs = current_sb_blacklist,
          cassette_blacklist_ohs = cassette_oh_blacklist,
          oh_fidelity = oh_fidelity,
          eff_lookup = eff_lookup,
          allowed_gene_positions = tile_end_positions
        )

        # Convert SB DP result to partition format
        partition_result <- sb_dp_to_partition(
          sb_result = sb_result,
          tiles = tiles,
          gene_len = gene_len,
          polIII_len = polIII_len,
          max_block_length = max_block_length,
          block_overhead = block_overhead,
          oh_fidelity = oh_fidelity
        )
        cassette_splits <- partition_result$cassette_splits

        # --- Collision check ---
        # SB boundary OHs must not collide with each other, oh3, oh4, or
        # tile oh1/oh2 in other reactions visible across SB boundaries.
        sb_boundary_ohs <- character(0)
        if (partition_result$n_superblocks >= 2L) {
          sbs <- partition_result$superblocks
          for (bi in seq_len(partition_result$n_superblocks - 1L)) {
            sb_boundary_ohs <- c(sb_boundary_ohs, tiles$oh2_seq[sbs$end_tile[bi]])
          }
        }
        # Also include cassette boundary OHs
        if (nrow(cassette_splits) > 0) {
          sb_boundary_ohs <- c(sb_boundary_ohs, cassette_splits$junction_oh)
        }

        # Check pairwise collisions among all SB boundary OHs
        has_collision <- FALSE
        colliding_ohs <- character(0)
        if (length(sb_boundary_ohs) >= 2L) {
          for (i in 2L:length(sb_boundary_ohs)) {
            for (j in seq_len(i - 1L)) {
              if (oh_collides(sb_boundary_ohs[i], sb_boundary_ohs[j])) {
                has_collision <- TRUE
                colliding_ohs <- c(colliding_ohs, sb_boundary_ohs[i])
              }
            }
          }
        }
        # Check SB boundary OHs vs oh3
        for (sb_oh in sb_boundary_ohs) {
          if (oh_collides(sb_oh, oh3)) {
            has_collision <- TRUE
            colliding_ohs <- c(colliding_ohs, sb_oh)
          }
        }
        # Check SB boundary OHs vs oh4
        for (sb_oh in sb_boundary_ohs) {
          if (oh_collides(sb_oh, oh4)) {
            has_collision <- TRUE
            colliding_ohs <- c(colliding_ohs, sb_oh)
          }
        }
        # Check SB boundary OHs vs tile oh1 in tiles whose 5'WT spans the
        # boundary (BsaI-level collision — BUG-007 equivalent).
        # The SB boundary OH becomes a BsaI junction overhang for tiles whose
        # 5'WT region spans past this boundary. If it matches a tile's oh1_seq,
        # the BsaI reaction has ambiguous ligation.
        if (partition_result$n_superblocks >= 2L) {
          sbs <- partition_result$superblocks
          for (bi in seq_len(partition_result$n_superblocks - 1L)) {
            boundary_tile <- sbs$end_tile[bi]
            boundary_oh <- tiles$oh2_seq[boundary_tile]
            boundary_pos <- tiles$end_nt[boundary_tile]
            for (t in seq_len(n_tiles)) {
              if (tiles$start_nt[t] > boundary_pos &&
                oh_collides(boundary_oh, tiles$oh1_seq[t])) {
                has_collision <- TRUE
                colliding_ohs <- c(colliding_ohs, boundary_oh)
              }
            }
          }
        }
        # Check SB boundary OHs vs tile oh2 in earlier tiles whose 3'WT spans
        # past the boundary (BsmBI-level collision).
        if (partition_result$n_superblocks >= 2L) {
          sbs <- partition_result$superblocks
          for (bi in seq_len(partition_result$n_superblocks - 1L)) {
            boundary_tile <- sbs$end_tile[bi]
            boundary_oh <- tiles$oh2_seq[boundary_tile]
            boundary_pos <- tiles$end_nt[boundary_tile]
            for (t in seq_len(n_tiles)) {
              if (t == boundary_tile) next
              if (tiles$end_nt[t] < boundary_pos &&
                oh_collides(boundary_oh, tiles$oh2_seq[t])) {
                has_collision <- TRUE
                colliding_ohs <- c(colliding_ohs, boundary_oh)
              }
            }
          }
        }

        # Cassette split junction OHs are GLOBAL — they participate in every
        # tile's BsmBI reaction. Check against ALL tile oh1/oh2 (no spatial filter).
        if (nrow(cassette_splits) > 0) {
          for (cj_oh in cassette_splits$junction_oh) {
            for (t in seq_len(n_tiles)) {
              if (oh_collides(cj_oh, tiles$oh1_seq[t])) {
                has_collision <- TRUE
                colliding_ohs <- c(colliding_ohs, cj_oh)
              }
              if (oh_collides(cj_oh, tiles$oh2_seq[t])) {
                has_collision <- TRUE
                colliding_ohs <- c(colliding_ohs, cj_oh)
              }
            }
          }
        }

        if (!has_collision) {
          if (sb_coll_iter > 1L) {
            cli::cli_alert_success(paste0(
              "SB collision resolved after ", sb_coll_iter, " iteration(s)."
            ))
          }
          break
        }

        # Classify collisions: cassette-region OHs go to cassette blacklist,
        # gene-region OHs go to global blacklist. This prevents a cassette
        # collision from unnecessarily constraining gene-region SB choices.
        cassette_junction_set <- if (nrow(cassette_splits) > 0) {
          cassette_splits$junction_oh
        } else {
          character(0)
        }
        new_cassette_blacklist <- unique(
          colliding_ohs[colliding_ohs %in% cassette_junction_set]
        )
        new_gene_blacklist <- unique(
          colliding_ohs[!(colliding_ohs %in% cassette_junction_set)]
        )

        # Remove already-blacklisted OHs
        new_cassette_blacklist <- new_cassette_blacklist[
          !(new_cassette_blacklist %in% cassette_oh_blacklist)
        ]
        new_gene_blacklist <- new_gene_blacklist[
          !(new_gene_blacklist %in% sb_extra_blacklist)
        ]

        if (length(new_cassette_blacklist) == 0L &&
          length(new_gene_blacklist) == 0L) {
          cli::cli_alert_warning(
            "SB collision detected but no new OH to blacklist. Unresolved collisions remain."
          )
          partition_result$n_collisions <- length(colliding_ohs)
          break
        }

        # Add to appropriate blacklists
        cassette_oh_blacklist <- unique(c(
          cassette_oh_blacklist, new_cassette_blacklist
        ))
        sb_extra_blacklist <- unique(c(sb_extra_blacklist, new_gene_blacklist))
        cli::cli_alert_info(paste0(
          "SB collision: blacklisting ",
          if (length(new_gene_blacklist) > 0) {
            paste0("gene: ", paste(new_gene_blacklist, collapse = ", "))
          },
          if (length(new_cassette_blacklist) > 0) {
            paste0(" cassette: ", paste(new_cassette_blacklist, collapse = ", "))
          },
          ". Re-running constrained SB DP..."
        ))
      }

      # Post-loop guard: if loop exhausted iterations without resolving, report
      if (has_collision && sb_coll_iter == max_sb_collision_iters) {
        n_unresolved <- length(unique(colliding_ohs))
        partition_result$n_collisions <- n_unresolved
        cli::cli_alert_warning(paste0(
          "SB collision avoidance exhausted ", max_sb_collision_iters,
          " iterations. ", n_unresolved,
          " unresolved collision(s): ", paste(unique(colliding_ohs), collapse = ", ")
        ))
      }
    }
  } # end legacy (non-OOGGA) path

  # Convert partition to legacy all_splits format for downstream consumers
  all_splits <- convert_partition_to_splits(
    partition_result = partition_result,
    tiles = tiles,
    gene_len = gene_len,
    polIII_len = polIII_len
  )

  # Summary logging (shared by all paths)
  if (partition_result$n_superblocks > 1L) {
    n_boundaries_sb <- partition_result$n_superblocks - 1L
    n_hf <- sum(tiles$oh2_in_hf[partition_result$superblocks$end_tile[
      seq_len(n_boundaries_sb)
    ]])
    cass_msg <- if (partition_result$cassette_needs_splitting) {
      " Cassette will be split into fragments."
    } else {
      ""
    }
    cli::cli_alert_info(paste0(
      boundary_method, " SB: ", partition_result$n_superblocks,
      " superblocks, ", n_boundaries_sb, " boundary(ies). ",
      n_hf, " junction(s) in HF set. ",
      nrow(all_splits), " per-tile split entries. ",
      partition_result$n_collisions, " unresolved collision(s).",
      cass_msg
    ))
  } else {
    cass_msg <- if (partition_result$cassette_needs_splitting) {
      " Cassette will be split into fragments."
    } else {
      ""
    }
    cli::cli_alert_success(paste0(
      "All gene blocks within synthesis limit. No superblock splits needed.",
      cass_msg
    ))
  }

  # Ensure n_tiles is defined after both paths
  n_tiles <- nrow(tiles)

  # =========================================================================
  # Phase 4: Per-reaction pairwise validation
  # =========================================================================
  cli::cli_h3("Phase 4: Validating per-reaction overhang fidelity")
  # bsai_matrix and bsmbi_matrix already loaded at top of plan_assembly()

  reaction_fidelity <- list()
  for (i in seq_len(n_tiles)) {
    tile <- tiles[i, ]

    # BsaI reaction overhangs: oh_L, [5'WT junction ohs], oh1_i, oh4
    bsai_ohs <- unique(c(oh_L, tile$oh1_seq, oh4))
    # Add any 5'WT superblock junction overhangs for this tile
    tile_5wt_splits <- all_splits[all_splits$tile_id == i & all_splits$block_type == "bsai_5wt", ]
    if (nrow(tile_5wt_splits) > 0) {
      bsai_ohs <- unique(c(bsai_ohs, tile_5wt_splits$junction_oh))
    }

    bsai_result <- compute_set_fidelity(bsai_ohs, bsai_matrix)
    n_bsai_hf <- sum(bsai_ohs %in% hf_set)

    reaction_fidelity[[length(reaction_fidelity) + 1L]] <- data.frame(
      tile_id = i, reaction_type = "BsaI",
      overhangs = paste(bsai_ohs, collapse = ";"),
      n_overhangs = length(bsai_ohs), n_in_hf = n_bsai_hf,
      set_fidelity = bsai_result$set_fidelity,
      stringsAsFactors = FALSE
    )

    # BsmBI reaction overhangs: use get_tile_reaction_overhangs() which
    # computes the correct per-tile OH set from the partition (oh2 of this tile,
    # visible SB boundary OHs, and oh3)
    bsmbi_ohs <- unique(get_tile_reaction_overhangs(
      partition_result, i, tiles, oh3, "bsmbi"
    ))

    bsmbi_result <- compute_set_fidelity(bsmbi_ohs, bsmbi_matrix)
    n_bsmbi_hf <- sum(bsmbi_ohs %in% hf_set)

    reaction_fidelity[[length(reaction_fidelity) + 1L]] <- data.frame(
      tile_id = i, reaction_type = "BsmBI",
      overhangs = paste(bsmbi_ohs, collapse = ";"),
      n_overhangs = length(bsmbi_ohs), n_in_hf = n_bsmbi_hf,
      set_fidelity = bsmbi_result$set_fidelity,
      stringsAsFactors = FALSE
    )
  }

  reaction_fidelity_df <- do.call(rbind, reaction_fidelity)
  rownames(reaction_fidelity_df) <- NULL

  # Warn about low-fidelity reactions (internal safety net)
  low_fid <- reaction_fidelity_df$set_fidelity < SET_FIDELITY_WARNING_THRESHOLD
  if (any(low_fid)) {
    n_low <- sum(low_fid)
    min_fid <- min(reaction_fidelity_df$set_fidelity)
    cli::cli_alert_warning(paste0(
      n_low, " reaction(s) below set fidelity warning threshold (",
      SET_FIDELITY_WARNING_THRESHOLD, "). Min: ", round(min_fid, 4)
    ))
  } else {
    cli::cli_alert_success(paste0(
      "All ", nrow(reaction_fidelity_df), " reactions above set fidelity threshold. ",
      "Min: ", round(min(reaction_fidelity_df$set_fidelity), 4)
    ))
  }

  # Summary
  n_boundaries <- n_tiles - 1L
  n_both_hf <- if (n_boundaries > 0) {
    sum(tiles$oh2_in_hf[-n_tiles] & tiles$oh1_in_hf[-1L])
  } else {
    0L
  }
  n_one_hf <- if (n_boundaries > 0) {
    sum(xor(tiles$oh2_in_hf[-n_tiles], tiles$oh1_in_hf[-1L]))
  } else {
    0L
  }
  n_neither_hf <- n_boundaries - n_both_hf - n_one_hf

  # Compute core_downstream_cassette for gene block design.
  # When oh3 is derived from the PolIII promoter's terminal 5 nt, gene blocks
  # use the cassette with the last 5 nt trimmed (encoded by the BsmBI oh3+spacer).
  # For backward compat: NULL when no intergene elements (existing core_polIII
  # already handles the PolIII-only case in design_wt_geneblocks).
  core_downstream_cassette <- if (!is.null(downstream_cassette) && !is.null(core_polIII)) {
    # downstream_cassette = intergene + polIII; trim last 5 nt = intergene + core_polIII
    substring(downstream_cassette, 1, nchar(downstream_cassette) - 5L)
  } else {
    NULL
  }

  assembly_plan <- list(
    tiles = tiles,
    oh3 = oh3,
    oh4 = oh4,
    oh_L = oh_L,
    oh3_in_hf = oh3_in_hf,
    oh4_in_hf = oh4_in_hf,
    core_polIII = core_polIII, # promoter minus last 5 nt (NULL if not derived)
    core_downstream_cassette = core_downstream_cassette, # full cassette minus last 5 nt (NULL if not derived)
    oh3_spacer = oh3_spacer, # terminal nt of promoter (NULL if not derived)
    superblock_splits = all_splits,
    tile_partition = partition_result, # tile-boundary partition (native format)
    reaction_fidelity = reaction_fidelity_df,
    strategy_used = strategy_used,
    hf_set_used = hf_set,
    oh_fidelity_used = oh_fidelity,
    cassette_needs_splitting = partition_result$cassette_needs_splitting,
    sb_result = sb_result, # SB DP result for inspection
    cassette_splits = cassette_splits, # pre-computed cassette boundaries
    summary = list(
      n_tiles = n_tiles,
      n_boundaries = n_boundaries,
      n_boundaries_both_in_hf = n_both_hf,
      n_boundaries_one_in_hf = n_one_hf,
      n_boundaries_neither_in_hf = n_neither_hf,
      n_superblocks = partition_result$n_superblocks,
      n_superblock_splits = nrow(all_splits),
      n_sb_collisions = partition_result$n_collisions,
      cassette_needs_splitting = partition_result$cassette_needs_splitting,
      overall_min_fidelity = min(reaction_fidelity_df$set_fidelity)
    )
  )

  assembly_plan
}

# =============================================================================
# VALIDATION HELPERS
# =============================================================================

#' Validate manually specified oh3 and oh4
#' @param oh3 4-nt overhang string
#' @param oh4 4-nt overhang string
validate_fixed_overhangs <- function(oh3, oh4) {
  oh3 <- toupper(oh3)
  oh4 <- toupper(oh4)

  for (name_val in list(list("oh3", oh3), list("oh4", oh4))) {
    nm <- name_val[[1]]
    val <- name_val[[2]]
    if (nchar(val) != 4 || grepl("[^ACGT]", val)) {
      stop(nm, " must be exactly 4 ACGT characters, got: ", val)
    }
  }

  if (oh3 == oh4) stop("oh3 and oh4 must be different sequences.")
  if (oh3 == reverse_complement(oh4)) {
    stop("oh3 and oh4 must not be reverse complements of each other.")
  }

  # Reject homopolymers and palindromes (OPT-003)
  for (name_val in list(list("oh3", oh3), list("oh4", oh4))) {
    nm <- name_val[[1]]
    val <- name_val[[2]]
    if (val %in% HOMOPOLYMER_4NT) {
      stop(nm, " is a homopolymer (", val, "); not suitable for Golden Gate assembly.")
    }
    if (val %in% PALINDROMIC_4NT) {
      stop(nm, " is palindromic (", val, "); not suitable for Golden Gate assembly.")
    }
  }

  invisible(NULL)
}

