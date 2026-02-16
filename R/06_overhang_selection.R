# 06_overhang_selection.R — Integrated assembly planning with dynamic tile boundary search
# DMS Golden Gate Oligo Pipeline
#
# Integrates tiling and overhang selection into a single planning system.
# Instead of fixing tile boundaries geometrically and then scoring overhangs,
# this module dynamically searches candidate boundary positions for ones where
# the gene-derived overhangs fall within a pre-validated high-fidelity (HF) set
# (Potapov 2018, Set 2).
#
# In the 3-enzyme architecture:
# - oh1 (BsaI) and oh2 (BsmBI) are gene-derived at tile boundaries — optimized by boundary search
# - oh3 is a fixed BsmBI overhang (same for all tiles) — selected from HF set
# - oh4 is a fixed BsaI overhang (same for all tiles) — selected from HF set
# - Superblock junction overhangs are gene-derived at split positions — optimized by split search
#
# Key references:
#   Potapov et al. 2018, ACS Synth Bio — 256x256 ligation fidelity matrices, HF overhang sets
#   Pryor et al. 2020, PLOS ONE — Enzyme-specific (BsaI, BsmBI) pairwise matrices

# =============================================================================
# DATA LOADING
# =============================================================================

#' Built-in fidelity data for all 256 4-nt overhangs
#'
#' Data from Potapov et al. 2018 (T4 DNA Ligase, 37C, 18h incubation).
#' Fidelity = M[X][RC(X)] / sum(M[X][*]) — correct Watson-Crick pairing.
#'
#' @return Data frame with overhang and fidelity columns (256 rows, sorted by fidelity desc)
builtin_overhang_fidelity <- function() {
  oh_data <- data.frame(
    overhang = c(
      "AAAA", "AAAC", "AAAG", "AAAT", "AACA", "AACC", "AACG", "AACT",
      "AAGA", "AAGC", "AAGG", "AAGT", "AATA", "AATC", "AATG", "AATT",
      "ACAA", "ACAC", "ACAG", "ACAT", "ACCA", "ACCC", "ACCG", "ACCT",
      "ACGA", "ACGC", "ACGG", "ACGT", "ACTA", "ACTC", "ACTG", "ACTT",
      "AGAA", "AGAC", "AGAG", "AGAT", "AGCA", "AGCC", "AGCG", "AGCT",
      "AGGA", "AGGC", "AGGG", "AGGT", "AGTA", "AGTC", "AGTG", "AGTT",
      "ATAA", "ATAC", "ATAG", "ATAT", "ATCA", "ATCC", "ATCG", "ATCT",
      "ATGA", "ATGC", "ATGG", "ATGT", "ATTA", "ATTC", "ATTG", "ATTT",
      "CAAA", "CAAC", "CAAG", "CAAT", "CACA", "CACC", "CACG", "CACT",
      "CAGA", "CAGC", "CAGG", "CAGT", "CATA", "CATC", "CATG", "CATT",
      "CCAA", "CCAC", "CCAG", "CCAT", "CCCA", "CCCC", "CCCG", "CCCT",
      "CCGA", "CCGC", "CCGG", "CCGT", "CCTA", "CCTC", "CCTG", "CCTT",
      "CGAA", "CGAC", "CGAG", "CGAT", "CGCA", "CGCC", "CGCG", "CGCT",
      "CGGA", "CGGC", "CGGG", "CGGT", "CGTA", "CGTC", "CGTG", "CGTT",
      "CTAA", "CTAC", "CTAG", "CTAT", "CTCA", "CTCC", "CTCG", "CTCT",
      "CTGA", "CTGC", "CTGG", "CTGT", "CTTA", "CTTC", "CTTG", "CTTT",
      "GAAA", "GAAC", "GAAG", "GAAT", "GACA", "GACC", "GACG", "GACT",
      "GAGA", "GAGC", "GAGG", "GAGT", "GATA", "GATC", "GATG", "GATT",
      "GCAA", "GCAC", "GCAG", "GCAT", "GCCA", "GCCC", "GCCG", "GCCT",
      "GCGA", "GCGC", "GCGG", "GCGT", "GCTA", "GCTC", "GCTG", "GCTT",
      "GGAA", "GGAC", "GGAG", "GGAT", "GGCA", "GGCC", "GGCG", "GGCT",
      "GGGA", "GGGC", "GGGG", "GGGT", "GGTA", "GGTC", "GGTG", "GGTT",
      "GTAA", "GTAC", "GTAG", "GTAT", "GTCA", "GTCC", "GTCG", "GTCT",
      "GTGA", "GTGC", "GTGG", "GTGT", "GTTA", "GTTC", "GTTG", "GTTT",
      "TAAA", "TAAC", "TAAG", "TAAT", "TACA", "TACC", "TACG", "TACT",
      "TAGA", "TAGC", "TAGG", "TAGT", "TATA", "TATC", "TATG", "TATT",
      "TCAA", "TCAC", "TCAG", "TCAT", "TCCA", "TCCC", "TCCG", "TCCT",
      "TCGA", "TCGC", "TCGG", "TCGT", "TCTA", "TCTC", "TCTG", "TCTT",
      "TGAA", "TGAC", "TGAG", "TGAT", "TGCA", "TGCC", "TGCG", "TGCT",
      "TGGA", "TGGC", "TGGG", "TGGT", "TGTA", "TGTC", "TGTG", "TGTT",
      "TTAA", "TTAC", "TTAG", "TTAT", "TTCA", "TTCC", "TTCG", "TTCT",
      "TTGA", "TTGC", "TTGG", "TTGT", "TTTA", "TTTC", "TTTG", "TTTT"
    ),
    fidelity = c(
      0.996399, 0.991669, 0.985656, 0.960613, 0.997462, 0.986860, 0.934402, 0.964709,
      0.996025, 0.991562, 0.962182, 0.976118, 0.991438, 0.989569, 0.981808, 0.984592,
      0.995050, 0.957746, 0.942216, 0.958216, 0.992011, 0.972123, 0.940947, 0.950543,
      0.989796, 0.969128, 0.912218, 0.961523, 0.991162, 0.966285, 0.921625, 0.978242,
      0.991430, 0.956155, 0.932648, 0.945036, 0.980071, 0.959045, 0.829770, 0.912004,
      0.991660, 0.950406, 0.882669, 0.945695, 0.993056, 0.970982, 0.953297, 0.968155,
      0.982188, 0.973815, 0.977660, 0.979140, 0.991886, 0.985596, 0.951461, 0.959392,
      0.989987, 0.958657, 0.945946, 0.976938, 0.982801, 0.971968, 0.964772, 0.970881,
      0.992041, 0.987258, 0.975133, 0.970991, 0.974753, 0.968572, 0.910901, 0.869402,
      0.988806, 0.974133, 0.925286, 0.971874, 0.963162, 0.919937, 0.925725, 0.920242,
      0.992739, 0.964418, 0.974302, 0.961832, 0.980597, 0.973859, 0.910703, 0.865414,
      0.971559, 0.938094, 0.888999, 0.927624, 0.964517, 0.891679, 0.894609, 0.908947,
      0.992364, 0.925083, 0.929690, 0.933666, 0.967794, 0.915152, 0.786593, 0.844628,
      0.977144, 0.885744, 0.794914, 0.896406, 0.975674, 0.902548, 0.878818, 0.918865,
      0.983670, 0.946985, 0.944602, 0.972918, 0.967401, 0.932135, 0.899384, 0.859896,
      0.956563, 0.902432, 0.876162, 0.920274, 0.957210, 0.897371, 0.882400, 0.912792,
      0.991863, 0.961172, 0.922391, 0.923431, 0.982421, 0.937701, 0.851127, 0.900155,
      0.994942, 0.951239, 0.800902, 0.925373, 0.987263, 0.949519, 0.901187, 0.943009,
      0.992293, 0.930008, 0.893738, 0.882729, 0.933795, 0.833707, 0.833128, 0.829200,
      0.965362, 0.837267, 0.770099, 0.848189, 0.972489, 0.885406, 0.895522, 0.920647,
      0.987470, 0.833052, 0.737377, 0.826289, 0.892601, 0.772152, 0.669030, 0.752661,
      0.958004, 0.795132, 0.629880, 0.791084, 0.970082, 0.864006, 0.765917, 0.897990,
      0.987234, 0.950319, 0.945731, 0.970598, 0.941727, 0.856186, 0.831214, 0.855090,
      0.968685, 0.825587, 0.836634, 0.913978, 0.970072, 0.881461, 0.883929, 0.908867,
      0.960699, 0.897232, 0.904935, 0.920598, 0.959211, 0.908319, 0.887260, 0.935720,
      0.949875, 0.917448, 0.891711, 0.944301, 0.943262, 0.942996, 0.900610, 0.952303,
      0.971831, 0.924443, 0.929358, 0.952247, 0.911121, 0.856272, 0.892875, 0.925690,
      0.954222, 0.829464, 0.901426, 0.932692, 0.887588, 0.852618, 0.931310, 0.923360,
      0.974332, 0.833734, 0.855339, 0.890710, 0.909869, 0.749410, 0.715476, 0.822722,
      0.969447, 0.816420, 0.795400, 0.872876, 0.960474, 0.863257, 0.863274, 0.913953,
      0.692308, 0.970711, 0.953997, 0.950739, 0.973291, 0.939736, 0.957842, 0.965340,
      0.965035, 0.931621, 0.953506, 0.977310, 0.920502, 0.951019, 0.950954, 0.959538
    ),
    stringsAsFactors = FALSE
  )
  oh_data[order(oh_data$fidelity, decreasing = TRUE), ]
}

# Keep old name as alias for backward compatibility
builtin_high_fidelity_overhangs <- builtin_overhang_fidelity

#' Load NEB overhang fidelity data for a given enzyme
#'
#' @param enzyme_name Name of enzyme ("BsaI" or "BsmBI")
#' @return Data frame with columns: overhang, fidelity (all 256 4-nt overhangs)
load_overhang_fidelity <- function(enzyme_name = "BsmBI") {
  data_path <- file.path(find_data_dir(), "neb_overhang_fidelity",
                         paste0(tolower(enzyme_name), "_overhangs.rds"))
  if (file.exists(data_path)) {
    return(readRDS(data_path))
  }
  generic_path <- file.path(find_data_dir(), "neb_overhang_fidelity",
                            "potapov_18h_overhangs.rds")
  if (file.exists(generic_path)) {
    return(readRDS(generic_path))
  }
  builtin_overhang_fidelity()
}

#' Load a pre-validated high-fidelity overhang set
#'
#' Default: Potapov 2018, Table 1, Set 2 (non-MoClo, 20 overhangs, ~98% set fidelity).
#' Falls back to generating from individual fidelity data if RDS not found.
#'
#' @param set_name Name of the set (default "potapov_set2_20")
#' @return Character vector of high-fidelity overhangs
load_high_fidelity_set <- function(set_name = "potapov_set2_20") {
  data_path <- file.path(find_data_dir(), "neb_overhang_fidelity",
                         "high_fidelity_sets.rds")
  if (file.exists(data_path)) {
    sets <- readRDS(data_path)
    if (set_name %in% names(sets)) {
      return(sets[[set_name]])
    }
  }
  cli::cli_alert_info("Generating HF set from individual fidelity data (fallback).")
  oh_data <- builtin_overhang_fidelity()
  n <- if (grepl("10", set_name)) 10L else 20L
  generate_hf_set(oh_data, n)
}

#' Generate a high-fidelity overhang set by greedy selection
#'
#' Selects the top n mutually-orthogonal overhangs (no identity or RC collision)
#' from the fidelity data, prioritizing highest individual fidelity.
#'
#' @param oh_data Data frame with overhang and fidelity columns
#' @param n_members Number of overhangs to select
#' @return Character vector of selected overhangs
generate_hf_set <- function(oh_data, n_members) {
  sorted <- oh_data[order(oh_data$fidelity, decreasing = TRUE), ]
  selected <- character(0)
  used <- character(0)
  for (i in seq_len(nrow(sorted))) {
    oh <- sorted$overhang[i]
    oh_rc <- reverse_complement(oh)
    if (!(oh %in% used) && !(oh_rc %in% used)) {
      selected <- c(selected, oh)
      used <- c(used, oh, oh_rc)
      if (length(selected) == n_members) break
    }
  }
  selected
}

#' Load 256x256 pairwise ligation matrix
#'
#' M[X,Y] = ligation frequency of overhang X with RC(Y).
#' Correct ligation: M[X,X] (X ligates with RC(X)).
#' Cross-reactivity: M[X,Y] for Y != X.
#'
#' @param enzyme_name Enzyme name for enzyme-specific matrix
#' @return Named 256x256 numeric matrix
load_pairwise_matrix <- function(enzyme_name = "potapov_18h") {
  data_path <- file.path(find_data_dir(), "neb_overhang_fidelity",
                         paste0(tolower(enzyme_name), "_pairwise.rds"))
  if (file.exists(data_path)) {
    return(readRDS(data_path))
  }
  cli::cli_alert_info(paste0(
    "Generating pairwise matrix from individual fidelity (fallback for ",
    enzyme_name, ")."
  ))
  oh_data <- load_overhang_fidelity(enzyme_name)
  generate_pairwise_from_fidelity(oh_data)
}

#' Generate a synthetic 256x256 pairwise matrix from individual fidelity data
#'
#' Uses a Hamming-distance model: cross-reactivity between overhangs X and Y
#' decreases exponentially with the Hamming distance between X and RC(Y).
#' The matrix is calibrated so that individual fidelity values match the input.
#'
#' @param oh_data Data frame with overhang and fidelity columns
#' @return Named 256x256 numeric matrix
generate_pairwise_from_fidelity <- function(oh_data) {
  overhangs <- oh_data$overhang
  fidelities <- oh_data$fidelity
  names(fidelities) <- overhangs
  n <- length(overhangs)

  rcs <- vapply(overhangs, reverse_complement, character(1), USE.NAMES = FALSE)
  oh_chars <- lapply(overhangs, function(x) strsplit(x, "")[[1]])
  rc_chars <- lapply(rcs, function(x) strsplit(x, "")[[1]])

  mat <- matrix(0, nrow = n, ncol = n, dimnames = list(overhangs, overhangs))

  for (i in seq_len(n)) {
    f_i <- fidelities[i]
    chars_i <- oh_chars[[i]]

    # Hamming-distance-based cross-reactivity weights
    raw_weights <- numeric(n)
    for (j in seq_len(n)) {
      if (i == j) next
      h <- sum(chars_i != rc_chars[[j]])
      raw_weights[j] <- exp(-2 * h)
    }

    # Calibrate: M[i,i] / (M[i,i] + sum_off) = f_i
    correct_val <- 1000
    target_off_total <- correct_val * (1 / f_i - 1)
    raw_sum <- sum(raw_weights)
    if (raw_sum > 0) {
      mat[i, ] <- raw_weights / raw_sum * target_off_total
    }
    mat[i, i] <- correct_val
  }

  mat
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
      per_overhang = data.frame(overhang = overhangs, correct_fraction = 1.0,
                                stringsAsFactors = FALSE)
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
# DYNAMIC TILE BOUNDARY SEARCH
# =============================================================================

#' Search for optimal tile boundaries using high-fidelity overhang matching
#'
#' Instead of fixing tile boundaries by pure geometry, this function searches
#' candidate boundary positions (within a window around the ideal position)
#' for ones where the gene-derived overhangs (oh1, oh2) are members of the
#' pre-validated high-fidelity set. Uses greedy forward assignment.
#'
#' @param cds Domesticated gene sequence
#' @param max_mutable_nt Max mutable region size in nt (from compute_max_tile_size)
#' @param min_mutable_nt Min mutable region size in nt (default: max/3, floor 81)
#' @param hf_set Character vector of high-fidelity overhangs
#' @param oh_fidelity Data frame with overhang + fidelity columns
#' @param search_window_K Search window: +/- K codons around ideal boundary
#' @return Data frame with tile info including oh1/oh2 and HF membership
search_tile_boundaries <- function(cds, max_mutable_nt,
                                    min_mutable_nt = NULL,
                                    hf_set = NULL,
                                    oh_fidelity = NULL,
                                    search_window_K = 15L) {
  gene_len <- nchar(cds)
  n_codons <- gene_len %/% 3L

  if (is.null(min_mutable_nt)) {
    min_mutable_nt <- max(81L, max_mutable_nt %/% 3L)
    min_mutable_nt <- (min_mutable_nt %/% 3L) * 3L  # codon boundary
  }
  if (is.null(hf_set)) hf_set <- load_high_fidelity_set()
  if (is.null(oh_fidelity)) oh_fidelity <- builtin_overhang_fidelity()

  # Create lookup for individual fidelity
  fid_lookup <- oh_fidelity$fidelity
  names(fid_lookup) <- oh_fidelity$overhang

  max_codons <- max_mutable_nt %/% 3L
  min_codons <- min_mutable_nt %/% 3L

  # Single-tile gene: no boundaries to search
  if (n_codons <= max_codons) {
    oh1 <- substring(cds, 1, 4)
    oh2 <- substring(cds, gene_len - 3, gene_len)
    oh1_fid <- if (oh1 %in% names(fid_lookup)) fid_lookup[oh1] else NA_real_
    oh2_fid <- if (oh2 %in% names(fid_lookup)) fid_lookup[oh2] else NA_real_

    return(data.frame(
      tile_id       = 1L,
      start_codon   = 1L,
      end_codon     = n_codons,
      start_nt      = 1L,
      end_nt        = gene_len,
      oh1_seq       = oh1,
      oh2_seq       = oh2,
      oh1_in_hf     = oh1 %in% hf_set,
      oh2_in_hf     = oh2 %in% hf_set,
      oh1_fidelity  = unname(oh1_fid),
      oh2_fidelity  = unname(oh2_fid),
      tile_seq      = cds,
      boundary_shift = 0L,
      stringsAsFactors = FALSE
    ))
  }

  # Multi-tile gene: compute ideal layout
  n_tiles <- ceiling(n_codons / max_codons)
  ideal_size <- ceiling(n_codons / n_tiles)
  ideal_boundaries <- ideal_size * seq_len(n_tiles - 1L)

  # Phase 2-3: Score and greedily assign boundaries
  assigned <- list()  # list of list(pos, oh2, oh1_next, oh2_in_hf, oh1_in_hf, score, shift)

  for (bi in seq_along(ideal_boundaries)) {
    center <- ideal_boundaries[bi]
    prev_end <- if (bi == 1L) 0L else assigned[[bi - 1L]]$pos

    lo <- max(prev_end + min_codons, center - search_window_K)
    # Ensure last tile gets at least min_codons
    hi <- min(n_codons - min_codons, center + search_window_K)
    # Also ensure this tile doesn't exceed max_codons
    hi <- min(hi, prev_end + max_codons)

    if (lo > hi) lo <- hi  # degenerate case

    # Score all candidates in the window
    candidates <- list()
    for (B in lo:hi) {
      # oh2 of current tile ending at codon B
      oh2_pos <- B * 3L
      oh2_seq <- substring(cds, oh2_pos - 3L, oh2_pos)
      # oh1 of next tile starting at codon B+1
      oh1_pos <- B * 3L + 1L
      oh1_seq <- substring(cds, oh1_pos, oh1_pos + 3L)

      oh2_in <- oh2_seq %in% hf_set
      oh1_in <- oh1_seq %in% hf_set
      oh2_fid <- if (oh2_seq %in% names(fid_lookup)) fid_lookup[oh2_seq] else 0.5
      oh1_fid <- if (oh1_seq %in% names(fid_lookup)) fid_lookup[oh1_seq] else 0.5

      # Composite score: HF membership (10 pts each) + fidelity tiebreaker
      score <- 10 * (oh2_in + oh1_in) + unname(oh2_fid) + unname(oh1_fid)

      candidates[[length(candidates) + 1L]] <- list(
        pos = B, oh2 = oh2_seq, oh1_next = oh1_seq,
        oh2_in_hf = oh2_in, oh1_in_hf = oh1_in,
        score = score, shift = as.integer(B - center)
      )
    }

    # Sort by score descending
    scores <- vapply(candidates, function(c) c$score, numeric(1))
    candidates <- candidates[order(scores, decreasing = TRUE)]

    # Greedy: pick best candidate satisfying constraints
    oh_L <- substring(cds, 1, 4)
    oh_L_rc <- reverse_complement(oh_L)
    picked <- FALSE
    for (cand in candidates) {
      # Hard constraint: oh1_next must not collide with oh_L
      if (cand$oh1_next == oh_L || cand$oh1_next == oh_L_rc) next

      # Hard constraint: tile size within [min, max]
      tile_before_size <- (cand$pos - prev_end) * 3L
      if (tile_before_size < min_mutable_nt || tile_before_size > max_mutable_nt) next

      # Check last tile won't be too small (for last boundary)
      if (bi == length(ideal_boundaries)) {
        last_tile_size <- (n_codons - cand$pos) * 3L
        if (last_tile_size < min_mutable_nt) next
      }

      assigned[[bi]] <- cand
      picked <- TRUE
      break
    }

    # Fallback: relax HF requirement, just pick best valid size
    if (!picked) {
      for (cand in candidates) {
        tile_before_size <- (cand$pos - prev_end) * 3L
        if (tile_before_size < min_mutable_nt || tile_before_size > max_mutable_nt) next
        if (bi == length(ideal_boundaries)) {
          last_tile_size <- (n_codons - cand$pos) * 3L
          if (last_tile_size < min_mutable_nt) next
        }
        assigned[[bi]] <- cand
        picked <- TRUE
        break
      }
    }

    # Ultimate fallback: use the ideal boundary
    if (!picked) {
      B <- min(max(center, lo), hi)
      oh2_pos <- B * 3L
      oh1_pos <- B * 3L + 1L
      assigned[[bi]] <- list(
        pos = B,
        oh2 = substring(cds, oh2_pos - 3L, oh2_pos),
        oh1_next = substring(cds, oh1_pos, oh1_pos + 3L),
        oh2_in_hf = FALSE, oh1_in_hf = FALSE,
        score = 0, shift = 0L
      )
    }
  }

  # Build tiles data.frame from assigned boundaries
  boundary_positions <- c(0L, vapply(assigned, function(a) a$pos, integer(1)), n_codons)

  tiles <- data.frame(
    tile_id       = integer(n_tiles),
    start_codon   = integer(n_tiles),
    end_codon     = integer(n_tiles),
    start_nt      = integer(n_tiles),
    end_nt        = integer(n_tiles),
    oh1_seq       = character(n_tiles),
    oh2_seq       = character(n_tiles),
    oh1_in_hf     = logical(n_tiles),
    oh2_in_hf     = logical(n_tiles),
    oh1_fidelity  = numeric(n_tiles),
    oh2_fidelity  = numeric(n_tiles),
    tile_seq      = character(n_tiles),
    boundary_shift = integer(n_tiles),
    stringsAsFactors = FALSE
  )

  for (i in seq_len(n_tiles)) {
    sc <- boundary_positions[i] + 1L
    ec <- boundary_positions[i + 1L]
    sn <- (sc - 1L) * 3L + 1L
    en <- ec * 3L

    oh1 <- substring(cds, sn, sn + 3L)
    oh2 <- substring(cds, en - 3L, en)

    oh1_fid <- if (oh1 %in% names(fid_lookup)) unname(fid_lookup[oh1]) else NA_real_
    oh2_fid <- if (oh2 %in% names(fid_lookup)) unname(fid_lookup[oh2]) else NA_real_

    # boundary_shift: how far the start boundary shifted from ideal
    bshift <- if (i == 1L) 0L else assigned[[i - 1L]]$shift

    tiles$tile_id[i]        <- i
    tiles$start_codon[i]    <- sc
    tiles$end_codon[i]      <- ec
    tiles$start_nt[i]       <- sn
    tiles$end_nt[i]         <- en
    tiles$oh1_seq[i]        <- oh1
    tiles$oh2_seq[i]        <- oh2
    tiles$oh1_in_hf[i]      <- oh1 %in% hf_set
    tiles$oh2_in_hf[i]      <- oh2 %in% hf_set
    tiles$oh1_fidelity[i]   <- oh1_fid
    tiles$oh2_fidelity[i]   <- oh2_fid
    tiles$tile_seq[i]       <- substring(cds, sn, en)
    tiles$boundary_shift[i] <- bshift
  }

  n_both <- sum(vapply(assigned, function(a) a$oh2_in_hf && a$oh1_in_hf, logical(1)))
  n_one <- sum(vapply(assigned, function(a) xor(a$oh2_in_hf, a$oh1_in_hf), logical(1)))
  n_neither <- length(assigned) - n_both - n_one

  cli::cli_alert_success(paste0(
    "Dynamic boundary search: ", n_tiles, " tiles, ", length(assigned),
    " boundaries (both_HF=", n_both, ", one_HF=", n_one,
    ", neither=", n_neither, ")"
  ))

  tiles
}

# =============================================================================
# DYNAMIC PROGRAMMING TILE BOUNDARY OPTIMIZER
# =============================================================================

#' Precompute boundary scores for all valid codon positions
#'
#' For each codon position b in the gene, extract the gene-derived overhangs
#' (oh1, oh2) and compute a composite score incorporating HF set membership,
#' pairwise fidelity with oh_L (BsaI reaction), and individual fidelity (BsmBI).
#'
#' @param cds Domesticated gene sequence
#' @param hf_set Character vector of high-fidelity overhangs
#' @param oh_fidelity Data frame with overhang + fidelity columns
#' @param bsai_matrix 256x256 BsaI pairwise ligation matrix (or NULL)
#' @return List with vectors: oh1_seq, oh2_seq, score, valid (all length n_codons)
precompute_boundary_scores <- function(cds, hf_set, oh_fidelity,
                                        bsai_matrix = NULL) {
  gene_len <- nchar(cds)
  n_codons <- gene_len %/% 3L
  oh_L <- substring(cds, 1, 4)
  oh_L_rc <- reverse_complement(oh_L)

  fid_lookup <- oh_fidelity$fidelity
  names(fid_lookup) <- oh_fidelity$overhang

  oh1_seq <- character(n_codons)
  oh2_seq <- character(n_codons)
  scores  <- rep(-Inf, n_codons)
  valid   <- logical(n_codons)
  oh1_hf  <- logical(n_codons)
  oh2_hf  <- logical(n_codons)

  for (b in seq_len(n_codons - 1L)) {
    oh2_pos <- b * 3L
    oh1_pos <- oh2_pos + 1L
    oh2 <- substring(cds, oh2_pos - 3L, oh2_pos)
    oh1 <- substring(cds, oh1_pos, oh1_pos + 3L)

    oh1_seq[b] <- oh1
    oh2_seq[b] <- oh2

    # Hard constraint: oh1 must not collide with oh_L in BsaI reaction
    if (oh1 == oh_L || oh1 == oh_L_rc) {
      valid[b] <- FALSE
      next
    }
    valid[b] <- TRUE

    # HF membership (10 pts each)
    oh1_in <- oh1 %in% hf_set
    oh2_in <- oh2 %in% hf_set
    oh1_hf[b] <- oh1_in
    oh2_hf[b] <- oh2_in
    hf_bonus <- 10.0 * (oh1_in + oh2_in)

    # oh1 pairwise fidelity with oh_L (BsaI reaction context)
    if (!is.null(bsai_matrix) && oh1 %in% rownames(bsai_matrix) &&
        oh_L %in% rownames(bsai_matrix)) {
      sf <- compute_set_fidelity(c(oh_L, oh1), bsai_matrix)
      oh1_pw <- sf$set_fidelity
    } else {
      oh1_pw <- if (oh1 %in% names(fid_lookup)) unname(fid_lookup[oh1]) else 0.5
    }

    # oh2 individual fidelity (BsmBI reaction partner oh3 not yet chosen)
    oh2_fid <- if (oh2 %in% names(fid_lookup)) unname(fid_lookup[oh2]) else 0.5

    # Penalize boundaries where either overhang has very low individual fidelity
    fid_penalty <- 0.0
    oh1_ind_fid <- if (oh1 %in% names(fid_lookup)) unname(fid_lookup[oh1]) else 0.5
    if (oh1_ind_fid < 0.80 || oh2_fid < 0.80) fid_penalty <- -5.0

    scores[b] <- hf_bonus + 2.0 * oh1_pw + 1.0 * oh2_fid + fid_penalty
  }

  list(
    oh1_seq = oh1_seq, oh2_seq = oh2_seq,
    score = scores, valid = valid,
    oh1_hf = oh1_hf, oh2_hf = oh2_hf
  )
}

#' Solve the boundary placement DP for a fixed number of boundaries K
#'
#' Finds the K boundary positions that maximize total boundary score,
#' subject to tile size constraints [min_codons, max_codons].
#'
#' @param K Number of internal boundaries (tiles = K + 1)
#' @param n_codons Total codons in gene
#' @param min_codons Minimum tile size in codons
#' @param max_codons Maximum tile size in codons
#' @param boundary_scores Numeric vector of scores per codon position
#' @param boundary_valid Logical vector of valid positions
#' @return List with boundaries (integer vector) and total_score, or NULL
dp_solve_k <- function(K, n_codons, min_codons, max_codons,
                        boundary_scores, boundary_valid) {
  if (K == 0L) return(NULL)

  # Early feasibility check: need at least (K+1)*min_codons codons
  if ((K + 1L) * min_codons > n_codons) return(NULL)

  # dp_prev[b] = best total score with previous boundary layer ending at codon b
  dp_prev <- rep(-Inf, n_codons)
  # Parent pointers: parent[k, b] = optimal predecessor position for boundary k at b
  parent <- matrix(NA_integer_, nrow = K, ncol = n_codons)

  # Layer k=1: first boundary, first tile spans [1..b]
  lo_b <- min_codons
  hi_b <- min(max_codons, n_codons - 1L)
  if (lo_b <= hi_b) {
    for (b in lo_b:hi_b) {
      if (!boundary_valid[b]) next
      dp_prev[b] <- boundary_scores[b]
    }
  }

  # Layers k=2..K
  if (K >= 2L) {
    for (k in 2L:K) {
      dp_curr <- rep(-Inf, n_codons)

      lo_b <- k * min_codons
      hi_b <- min(n_codons - 1L, n_codons - min_codons)
      if (lo_b > hi_b) {
        dp_prev <- dp_curr
        next
      }

      for (b in lo_b:hi_b) {
        if (!boundary_valid[b]) next

        # Predecessor range: b' must give tile size [min_codons, max_codons]
        lo <- max(1L, b - max_codons)
        hi <- b - min_codons
        if (hi < lo) next

        # Scan for best predecessor in [lo, hi]
        best_score <- -Inf
        best_pos <- NA_integer_
        for (bp in lo:hi) {
          if (dp_prev[bp] > best_score) {
            best_score <- dp_prev[bp]
            best_pos <- bp
          }
        }

        if (is.finite(best_score)) {
          dp_curr[b] <- best_score + boundary_scores[b]
          parent[k, b] <- best_pos
        }
      }

      dp_prev <- dp_curr
    }
  }

  # Find optimal last boundary: last tile must be [min_codons, max_codons]
  best_total <- -Inf
  best_b <- NA_integer_
  for (b in seq_len(n_codons - 1L)) {
    last_tile <- n_codons - b
    if (last_tile < min_codons || last_tile > max_codons) next
    if (dp_prev[b] > best_total) {
      best_total <- dp_prev[b]
      best_b <- b
    }
  }

  if (!is.finite(best_total)) return(NULL)

  # Backtrack to recover boundary positions
  boundaries <- integer(K)
  boundaries[K] <- best_b
  if (K >= 2L) {
    for (k in K:2L) {
      boundaries[k - 1L] <- parent[k, boundaries[k]]
    }
  }

  list(boundaries = boundaries, total_score = best_total)
}

#' Search tile boundaries using dynamic programming (globally optimal)
#'
#' Replaces the greedy forward search with a DP that finds the globally optimal
#' set of tile boundary positions maximizing total overhang quality. Inspired by
#' OOGGA (Pryor et al.) and NEB SplitSet approaches.
#'
#' The DP explores ALL valid boundary positions (not just a local window),
#' and optionally searches across different tile counts (multi-K) to find
#' the best tiling of the gene.
#'
#' @param cds Domesticated gene sequence
#' @param max_mutable_nt Max mutable region size in nt (from compute_max_tile_size)
#' @param min_mutable_nt Min mutable region size in nt (default: max/3, floor 81)
#' @param hf_set Character vector of high-fidelity overhangs
#' @param oh_fidelity Data frame with overhang + fidelity columns
#' @param bsai_matrix BsaI 256x256 pairwise ligation matrix (for oh1 scoring)
#' @param multi_k Logical: try multiple tile counts? (default TRUE)
#' @param k_range Integer vector of K values to try (NULL = auto)
#' @param search_window_K Unused (kept for interface compatibility)
#' @return Data frame with tile info (same format as search_tile_boundaries)
search_tile_boundaries_dp <- function(cds, max_mutable_nt,
                                       min_mutable_nt = NULL,
                                       hf_set = NULL,
                                       oh_fidelity = NULL,
                                       bsai_matrix = NULL,
                                       multi_k = TRUE,
                                       k_range = NULL,
                                       search_window_K = NULL) {
  gene_len <- nchar(cds)
  n_codons <- gene_len %/% 3L

  if (is.null(min_mutable_nt)) {
    min_mutable_nt <- max(81L, max_mutable_nt %/% 3L)
    min_mutable_nt <- (min_mutable_nt %/% 3L) * 3L
  }
  if (is.null(hf_set)) hf_set <- load_high_fidelity_set()
  if (is.null(oh_fidelity)) oh_fidelity <- builtin_overhang_fidelity()
  if (is.null(bsai_matrix)) {
    bsai_matrix <- tryCatch(load_pairwise_matrix("BsaI"), error = function(e) NULL)
  }

  fid_lookup <- oh_fidelity$fidelity
  names(fid_lookup) <- oh_fidelity$overhang

  max_codons <- max_mutable_nt %/% 3L
  min_codons <- min_mutable_nt %/% 3L

  # Single-tile gene: no boundaries to search
  if (n_codons <= max_codons) {
    oh1 <- substring(cds, 1, 4)
    oh2 <- substring(cds, gene_len - 3, gene_len)
    oh1_fid <- if (oh1 %in% names(fid_lookup)) fid_lookup[oh1] else NA_real_
    oh2_fid <- if (oh2 %in% names(fid_lookup)) fid_lookup[oh2] else NA_real_

    return(data.frame(
      tile_id       = 1L,
      start_codon   = 1L,
      end_codon     = n_codons,
      start_nt      = 1L,
      end_nt        = gene_len,
      oh1_seq       = oh1,
      oh2_seq       = oh2,
      oh1_in_hf     = oh1 %in% hf_set,
      oh2_in_hf     = oh2 %in% hf_set,
      oh1_fidelity  = unname(oh1_fid),
      oh2_fidelity  = unname(oh2_fid),
      tile_seq      = cds,
      boundary_shift = 0L,
      stringsAsFactors = FALSE
    ))
  }

  # Precompute scores for all boundary positions
  precomp <- precompute_boundary_scores(cds, hf_set, oh_fidelity, bsai_matrix)

  # Determine K range to search
  K_ideal <- ceiling(n_codons / max_codons) - 1L
  if (is.null(k_range)) {
    if (multi_k) {
      K_min <- max(1L, ceiling(n_codons / max_codons) - 1L)
      K_max <- floor(n_codons / min_codons) - 1L
      k_range <- seq(max(K_min, K_ideal - 2L), min(K_max, K_ideal + 2L))
      k_range <- k_range[k_range >= 1L]
    } else {
      k_range <- K_ideal
    }
  }

  cli::cli_alert_info(paste0(
    "DP boundary search: ", n_codons, " codons, ",
    sum(precomp$valid), " valid candidate positions, K range [",
    min(k_range), ", ", max(k_range), "]"
  ))

  # Run DP for each K, track best
  best_result <- NULL
  best_avg_score <- -Inf
  k_results <- list()

  for (K in k_range) {
    result <- dp_solve_k(K, n_codons, min_codons, max_codons,
                          precomp$score, precomp$valid)
    if (!is.null(result)) {
      avg <- result$total_score / K
      k_results[[as.character(K)]] <- list(K = K, score = result$total_score, avg = avg)
      if (avg > best_avg_score) {
        best_avg_score <- avg
        best_result <- result
        best_result$K <- K
      }
    }
  }

  if (is.null(best_result)) {
    cli::cli_alert_warning("DP found no valid solution; falling back to greedy search.")
    return(search_tile_boundaries(
      cds, max_mutable_nt, min_mutable_nt, hf_set, oh_fidelity
    ))
  }

  # Log multi-K comparison
  if (length(k_results) > 1) {
    k_summary <- vapply(k_results, function(r) {
      sprintf("K=%d score=%.1f", r$K, r$score)
    }, character(1))
    cli::cli_alert_info(paste0(
      "Multi-K: ", paste(k_summary, collapse = ", "),
      " | best K=", best_result$K
    ))
  }

  K <- best_result$K
  n_tiles <- K + 1L
  boundary_positions <- c(0L, best_result$boundaries, n_codons)

  # Build tiles data frame (same format as greedy)
  tiles <- data.frame(
    tile_id       = integer(n_tiles),
    start_codon   = integer(n_tiles),
    end_codon     = integer(n_tiles),
    start_nt      = integer(n_tiles),
    end_nt        = integer(n_tiles),
    oh1_seq       = character(n_tiles),
    oh2_seq       = character(n_tiles),
    oh1_in_hf     = logical(n_tiles),
    oh2_in_hf     = logical(n_tiles),
    oh1_fidelity  = numeric(n_tiles),
    oh2_fidelity  = numeric(n_tiles),
    tile_seq      = character(n_tiles),
    boundary_shift = integer(n_tiles),
    stringsAsFactors = FALSE
  )

  for (i in seq_len(n_tiles)) {
    sc <- boundary_positions[i] + 1L
    ec <- boundary_positions[i + 1L]
    sn <- (sc - 1L) * 3L + 1L
    en <- ec * 3L

    oh1 <- substring(cds, sn, sn + 3L)
    oh2 <- substring(cds, en - 3L, en)

    oh1_fid <- if (oh1 %in% names(fid_lookup)) unname(fid_lookup[oh1]) else NA_real_
    oh2_fid <- if (oh2 %in% names(fid_lookup)) unname(fid_lookup[oh2]) else NA_real_

    tiles$tile_id[i]        <- i
    tiles$start_codon[i]    <- sc
    tiles$end_codon[i]      <- ec
    tiles$start_nt[i]       <- sn
    tiles$end_nt[i]         <- en
    tiles$oh1_seq[i]        <- oh1
    tiles$oh2_seq[i]        <- oh2
    tiles$oh1_in_hf[i]      <- oh1 %in% hf_set
    tiles$oh2_in_hf[i]      <- oh2 %in% hf_set
    tiles$oh1_fidelity[i]   <- oh1_fid
    tiles$oh2_fidelity[i]   <- oh2_fid
    tiles$tile_seq[i]       <- substring(cds, sn, en)
    tiles$boundary_shift[i] <- 0L  # DP doesn't use "shift from ideal"
  }

  # Compute summary stats
  n_both <- 0L; n_one <- 0L; n_neither <- 0L
  for (bi in seq_len(K)) {
    bp <- best_result$boundaries[bi]
    oh2_hf <- precomp$oh2_hf[bp]
    oh1_hf <- precomp$oh1_hf[bp]
    if (oh2_hf && oh1_hf) {
      n_both <- n_both + 1L
    } else if (oh2_hf || oh1_hf) {
      n_one <- n_one + 1L
    } else {
      n_neither <- n_neither + 1L
    }
  }

  cli::cli_alert_success(paste0(
    "DP boundary search: ", n_tiles, " tiles, ", K,
    " boundaries (both_HF=", n_both, ", one_HF=", n_one,
    ", neither=", n_neither, ")"
  ))

  tiles
}

# =============================================================================
# SUPERBLOCK SPLIT-POINT OPTIMIZATION
# =============================================================================

#' Optimize superblock split positions for oversized gene blocks
#'
#' Same search strategy as tile boundaries: search candidate positions within
#' the block where the gene-derived junction overhang is in the HF set.
#'
#' @param cds Full domesticated gene sequence
#' @param block_start_nt Start position in gene (1-based)
#' @param block_end_nt End position in gene (1-based)
#' @param max_sub_length Max synthesis length for sub-blocks
#' @param existing_ohs Overhangs already committed in this reaction
#' @param hf_set High-fidelity overhang set
#' @param oh_fidelity Fidelity data frame
#' @param search_window Search window in codons (default 50)
#' @param extra_content_length Additional content appended to the last sub-block
#'   (e.g., PolIII promoter length for 3'WT blocks) that isn't part of the gene
#'   region but must be counted for sizing. Default 0.
#' @return Data frame with split positions and junction overhangs
optimize_split_points <- function(cds, block_start_nt, block_end_nt,
                                   max_sub_length, existing_ohs,
                                   hf_set, oh_fidelity,
                                   search_window = 50L,
                                   extra_content_length = 0L) {
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

  # Enzyme site overhead per sub-block junction
  junction_overhead <- 22L  # 2 x 11-nt enzyme sites
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

        if (junction_oh %in% local_existing) next  # collision

        in_hf <- junction_oh %in% hf_set
        fid <- if (junction_oh %in% names(fid_lookup)) unname(fid_lookup[junction_oh]) else 0.5
        score <- 10 * in_hf + fid

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
    n_splits <- n_splits + 1L  # Need more splits; retry
  }

  rownames(result) <- NULL
  result
}

# =============================================================================
# MASTER ASSEMBLY PLANNER
# =============================================================================

#' Plan the complete assembly: tiles, overhangs, and superblock splits
#'
#' Master function that orchestrates:
#'   Phase 1-3: Dynamic tile boundary search
#'   Phase 4: oh3/oh4 selection from HF set
#'   Phase 5: Superblock split-point optimization
#'   Phase 6: Per-reaction pairwise validation
#'
#' @param cds Domesticated gene sequence
#' @param polIII PolIII promoter sequence
#' @param max_mutable_nt Max mutable region in nt (from compute_max_tile_size)
#' @param max_block_length Max synthesis length (default 1800)
#' @param config List with fidelity_threshold, manual_oh3, manual_oh4,
#'   search_window_K, min_mutable_codons
#' @return assembly_plan list (see plan doc Section 5.2)
plan_assembly <- function(cds, polIII, max_mutable_nt,
                           max_block_length = MAX_GENEBLOCK_LENGTH,
                           config = list()) {
  gene_len <- nchar(cds)
  polIII_len <- nchar(polIII)

  # Unpack config with defaults
  fidelity_threshold <- config$fidelity_threshold %||% DEFAULT_FIDELITY_THRESHOLD
  manual_oh3 <- config$manual_oh3
  manual_oh4 <- config$manual_oh4
  search_window_K <- config$search_window_K %||% 15L
  boundary_method <- config$boundary_method %||% "dp"
  multi_k <- config$multi_k %||% TRUE
  min_mutable_nt <- config$min_mutable_nt
  if (is.null(min_mutable_nt)) {
    min_mutable_nt <- max(81L, max_mutable_nt %/% 3L)
    min_mutable_nt <- (min_mutable_nt %/% 3L) * 3L
  }

  # Load data (pairwise matrices loaded early for DP scoring)
  hf_set <- load_high_fidelity_set()
  oh_fidelity <- builtin_overhang_fidelity()
  bsai_matrix <- load_pairwise_matrix("BsaI")
  bsmbi_matrix <- load_pairwise_matrix("BsmBI")

  # Phase 1-3: Search tile boundaries
  if (boundary_method == "dp") {
    cli::cli_h3("Searching tile boundaries for HF overhangs (DP optimizer)")
    tiles <- search_tile_boundaries_dp(
      cds = cds,
      max_mutable_nt = max_mutable_nt,
      min_mutable_nt = min_mutable_nt,
      hf_set = hf_set,
      oh_fidelity = oh_fidelity,
      bsai_matrix = bsai_matrix,
      multi_k = multi_k
    )
  } else {
    cli::cli_h3("Searching tile boundaries for HF overhangs (greedy)")
    tiles <- search_tile_boundaries(
      cds = cds,
      max_mutable_nt = max_mutable_nt,
      min_mutable_nt = min_mutable_nt,
      hf_set = hf_set,
      oh_fidelity = oh_fidelity,
      search_window_K = search_window_K
    )
  }

  # Phase 4: Select oh3, oh4
  cli::cli_h3("Selecting fixed overhangs (oh3, oh4)")
  oh_L <- substring(cds, 1, 4)

  if (!is.null(manual_oh3) && !is.null(manual_oh4)) {
    validate_fixed_overhangs(manual_oh3, manual_oh4)
    oh3 <- toupper(manual_oh3)
    oh4 <- toupper(manual_oh4)
    oh3_in_hf <- oh3 %in% hf_set
    oh4_in_hf <- oh4 %in% hf_set
    cli::cli_alert_info(paste0("Using manual overhangs: oh3=", oh3, ", oh4=", oh4))
  } else {
    # Collect committed gene-derived overhangs
    all_oh1 <- unique(c(oh_L, tiles$oh1_seq))
    all_oh2 <- unique(tiles$oh2_seq)

    # oh4 must be orthogonal to ALL oh1 values (BsaI reactions)
    oh4_exclude <- unique(c(all_oh1, vapply(all_oh1, reverse_complement, character(1))))
    oh4_candidates <- hf_set[!(hf_set %in% oh4_exclude)]

    # oh3 must be orthogonal to ALL oh2 values (BsmBI reactions)
    oh3_exclude <- unique(c(all_oh2, vapply(all_oh2, reverse_complement, character(1))))
    oh3_candidates <- hf_set[!(hf_set %in% oh3_exclude)]

    # Pick highest-fidelity candidate
    fid_lookup <- oh_fidelity$fidelity
    names(fid_lookup) <- oh_fidelity$overhang

    strategy_used <- "hf_set"

    if (length(oh3_candidates) > 0) {
      oh3_fids <- unname(fid_lookup[oh3_candidates])
      oh3 <- oh3_candidates[which.max(oh3_fids)]
      oh3_in_hf <- TRUE
    } else {
      # Tier 2 fallback: use all overhangs above threshold
      cli::cli_alert_warning("No HF-set oh3 candidate available. Using pairwise fallback.")
      strategy_used <- "pairwise_matrix"
      all_ohs <- oh_fidelity$overhang[oh_fidelity$fidelity >= 0.90]
      all_ohs <- all_ohs[!(all_ohs %in% oh3_exclude)]
      if (length(all_ohs) == 0) stop("Cannot find any valid oh3 candidate.")
      oh3_fids <- unname(fid_lookup[all_ohs])
      oh3 <- all_ohs[which.max(oh3_fids)]
      oh3_in_hf <- FALSE
    }

    if (length(oh4_candidates) > 0) {
      oh4_fids <- unname(fid_lookup[oh4_candidates])
      oh4 <- oh4_candidates[which.max(oh4_fids)]
      oh4_in_hf <- TRUE
    } else {
      cli::cli_alert_warning("No HF-set oh4 candidate available. Using pairwise fallback.")
      strategy_used <- "pairwise_matrix"
      all_ohs <- oh_fidelity$overhang[oh_fidelity$fidelity >= 0.90]
      all_ohs <- all_ohs[!(all_ohs %in% oh4_exclude)]
      if (length(all_ohs) == 0) stop("Cannot find any valid oh4 candidate.")
      oh4_fids <- unname(fid_lookup[all_ohs])
      oh4 <- all_ohs[which.max(oh4_fids)]
      oh4_in_hf <- FALSE
    }
  }

  cli::cli_alert_success(paste0(
    "Selected fixed overhangs: oh3=", oh3,
    if (oh3_in_hf) " (HF)" else " (non-HF)",
    ", oh4=", oh4,
    if (oh4_in_hf) " (HF)" else " (non-HF)"
  ))

  # Phase 5: Superblock split-point optimization
  cli::cli_h3("Checking gene block sizes for superblock splitting")
  block_overhead <- 22L  # 2 x 11-nt enzyme sites per block
  n_tiles <- nrow(tiles)
  superblock_splits <- list()

  for (i in seq_len(n_tiles)) {
    tile <- tiles[i, ]

    # 5'WT block (BsaI reaction): gene start to this tile's start
    if (tile$start_nt > 1L) {
      wt5_len <- tile$start_nt - 1L + block_overhead
      if (wt5_len > max_block_length) {
        existing_ohs <- unique(c(oh_L, tiles$oh1_seq[i], oh4))
        splits <- optimize_split_points(
          cds, 1L, tile$start_nt - 1L,
          max_block_length - block_overhead, existing_ohs,
          hf_set, oh_fidelity
        )
        if (nrow(splits) > 0) {
          splits$block_type <- "bsai_5wt"
          splits$tile_id <- i
          superblock_splits[[length(superblock_splits) + 1L]] <- splits
        }
      }
    }

    # 3'WT + PolIII block (BsmBI reaction): this tile's end to gene end + PolIII
    wt3_start <- tile$end_nt + 1L
    wt3_content_len <- (gene_len - tile$end_nt) + polIII_len
    if (wt3_content_len + block_overhead > max_block_length) {
      existing_ohs <- unique(c(tiles$oh2_seq[i], oh3))
      splits <- optimize_split_points(
        cds, wt3_start, gene_len,
        max_block_length - block_overhead, existing_ohs,
        hf_set, oh_fidelity,
        extra_content_length = polIII_len
      )
      if (nrow(splits) > 0) {
        splits$block_type <- "bsmbi_3wt"
        splits$tile_id <- i
        superblock_splits[[length(superblock_splits) + 1L]] <- splits
      }
    }
  }

  if (length(superblock_splits) > 0) {
    all_splits <- do.call(rbind, superblock_splits)
    rownames(all_splits) <- NULL
    cli::cli_alert_info(paste0(
      "Optimized ", nrow(all_splits), " superblock split point(s). ",
      sum(all_splits$junction_in_hf), " junction(s) in HF set."
    ))
  } else {
    all_splits <- data.frame(
      split_nt = integer(0), junction_oh = character(0),
      junction_in_hf = logical(0), junction_fidelity = numeric(0),
      block_type = character(0), tile_id = integer(0),
      stringsAsFactors = FALSE
    )
    cli::cli_alert_success("All gene blocks within synthesis limit. No superblock splits needed.")
  }

  # Phase 6: Per-reaction pairwise validation
  cli::cli_h3("Validating per-reaction overhang fidelity")
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

    # BsmBI reaction overhangs: oh2_i, [3'WT junction ohs], oh3
    bsmbi_ohs <- unique(c(tile$oh2_seq, oh3))
    tile_3wt_splits <- all_splits[all_splits$tile_id == i & all_splits$block_type == "bsmbi_3wt", ]
    if (nrow(tile_3wt_splits) > 0) {
      bsmbi_ohs <- unique(c(bsmbi_ohs, tile_3wt_splits$junction_oh))
    }

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

  # Warn about low-fidelity reactions
  low_fid <- reaction_fidelity_df$set_fidelity < fidelity_threshold
  if (any(low_fid)) {
    n_low <- sum(low_fid)
    min_fid <- min(reaction_fidelity_df$set_fidelity)
    cli::cli_alert_warning(paste0(
      n_low, " reaction(s) below fidelity threshold (",
      fidelity_threshold, "). Min: ", round(min_fid, 4)
    ))
  } else {
    cli::cli_alert_success(paste0(
      "All ", nrow(reaction_fidelity_df), " reactions above fidelity threshold. ",
      "Min: ", round(min(reaction_fidelity_df$set_fidelity), 4)
    ))
  }

  # Summary
  n_boundaries <- n_tiles - 1L
  n_both_hf <- if (n_boundaries > 0) {
    sum(tiles$oh2_in_hf[-n_tiles] & tiles$oh1_in_hf[-1L])
  } else 0L
  n_one_hf <- if (n_boundaries > 0) {
    sum(xor(tiles$oh2_in_hf[-n_tiles], tiles$oh1_in_hf[-1L]))
  } else 0L
  n_neither_hf <- n_boundaries - n_both_hf - n_one_hf

  assembly_plan <- list(
    tiles = tiles,
    oh3 = oh3,
    oh4 = oh4,
    oh_L = oh_L,
    oh3_in_hf = oh3_in_hf,
    oh4_in_hf = oh4_in_hf,
    superblock_splits = all_splits,
    reaction_fidelity = reaction_fidelity_df,
    strategy_used = if (exists("strategy_used")) strategy_used else "hf_set",
    hf_set_used = hf_set,
    summary = list(
      n_tiles = n_tiles,
      n_boundaries = n_boundaries,
      n_boundaries_both_in_hf = n_both_hf,
      n_boundaries_one_in_hf = n_one_hf,
      n_boundaries_neither_in_hf = n_neither_hf,
      n_superblock_splits = nrow(all_splits),
      overall_min_fidelity = min(reaction_fidelity_df$set_fidelity)
    )
  )

  assembly_plan
}

# =============================================================================
# VALIDATION HELPERS
# =============================================================================

#' Validate that overhangs within a single reaction are mutually orthogonal
#'
#' Checks for identity and reverse-complement collisions. Optionally validates
#' against a pairwise ligation matrix for cross-reactivity.
#'
#' @param reaction_overhangs Character vector of all overhangs in one reaction
#' @param reaction_name Descriptive name for error messages
#' @return Logical TRUE if orthogonal, warns and returns FALSE otherwise
validate_reaction_overhangs <- function(reaction_overhangs, reaction_name = "reaction") {
  n <- length(reaction_overhangs)
  if (n < 2) return(TRUE)

  for (i in seq_len(n - 1L)) {
    for (j in (i + 1L):n) {
      oh_i <- reaction_overhangs[i]
      oh_j <- reaction_overhangs[j]
      if (oh_i == oh_j || oh_i == reverse_complement(oh_j)) {
        cli::cli_warn(paste0(
          "Non-orthogonal overhangs in ", reaction_name, ": ",
          oh_i, " and ", oh_j
        ))
        return(FALSE)
      }
    }
  }
  TRUE
}

#' Validate manually specified oh3 and oh4
#' @param oh3 4-nt overhang string
#' @param oh4 4-nt overhang string
validate_fixed_overhangs <- function(oh3, oh4) {
  oh3 <- toupper(oh3)
  oh4 <- toupper(oh4)

  for (name_val in list(list("oh3", oh3), list("oh4", oh4))) {
    nm <- name_val[[1]]; val <- name_val[[2]]
    if (nchar(val) != 4 || grepl("[^ACGT]", val)) {
      stop(nm, " must be exactly 4 ACGT characters, got: ", val)
    }
  }

  if (oh3 == oh4) stop("oh3 and oh4 must be different sequences.")
  if (oh3 == reverse_complement(oh4)) {
    stop("oh3 and oh4 must not be reverse complements of each other.")
  }

  invisible(NULL)
}

#' Select n mutually orthogonal overhangs from candidates
#'
#' @param candidates Character vector of candidate overhangs (pre-sorted by fidelity desc)
#' @param n Number to select
#' @return Character vector of selected overhangs
select_orthogonal_set <- function(candidates, n) {
  selected <- character(0)
  used <- character(0)

  for (oh in candidates) {
    oh_rc <- reverse_complement(oh)
    if (!(oh %in% used) && !(oh_rc %in% used)) {
      selected <- c(selected, oh)
      used <- c(used, oh, oh_rc)
      if (length(selected) == n) break
    }
  }

  if (length(selected) < n) {
    stop("Could not find ", n, " mutually orthogonal overhangs from candidates.")
  }

  selected
}

# =============================================================================
# BACKWARD COMPATIBILITY — Legacy functions that delegate to new system
# =============================================================================

#' Extract tile boundary overhangs from tiles (legacy wrapper)
#'
#' In the new system, tiles already contain oh1/oh2 fidelity info from
#' search_tile_boundaries(). This function extracts the relevant columns
#' for backward compatibility with code that expects the old format.
#'
#' @param tiles Data frame (must include oh1_seq, oh2_seq)
#' @param oh_fidelity_data Optional fidelity data
#' @return Data frame with tile_id, oh1_seq, oh2_seq, oh1_fidelity, oh2_fidelity
extract_tile_overhangs <- function(tiles, oh_fidelity_data = NULL) {
  # If tiles already have fidelity columns (from search_tile_boundaries), use them
  if ("oh1_fidelity" %in% names(tiles) && "oh2_fidelity" %in% names(tiles)) {
    return(data.frame(
      tile_id      = tiles$tile_id,
      oh1_seq      = tiles$oh1_seq,
      oh2_seq      = tiles$oh2_seq,
      oh1_fidelity = tiles$oh1_fidelity,
      oh2_fidelity = tiles$oh2_fidelity,
      stringsAsFactors = FALSE
    ))
  }

  # Fallback: look up fidelity
  if (is.null(oh_fidelity_data)) oh_fidelity_data <- builtin_overhang_fidelity()

  result <- data.frame(
    tile_id      = tiles$tile_id,
    oh1_seq      = tiles$oh1_seq,
    oh2_seq      = tiles$oh2_seq,
    oh1_fidelity = numeric(nrow(tiles)),
    oh2_fidelity = numeric(nrow(tiles)),
    stringsAsFactors = FALSE
  )

  for (i in seq_len(nrow(tiles))) {
    fid1 <- oh_fidelity_data$fidelity[oh_fidelity_data$overhang == tiles$oh1_seq[i]]
    fid2 <- oh_fidelity_data$fidelity[oh_fidelity_data$overhang == tiles$oh2_seq[i]]
    result$oh1_fidelity[i] <- if (length(fid1) > 0) fid1[1] else NA_real_
    result$oh2_fidelity[i] <- if (length(fid2) > 0) fid2[1] else NA_real_
  }

  result
}

#' Select fixed overhangs (legacy wrapper)
#'
#' Delegates to the new HF-set-based selection used by plan_assembly().
#' Kept for backward compatibility with tests and direct callers.
#'
#' @param cds Character string of domesticated CDS
#' @param polIII Character string of PolIII promoter
#' @param tile_overhangs Data frame from extract_tile_overhangs()
#' @param fidelity_threshold Minimum fidelity score
#' @param manual_oh3 Optional user-specified oh3
#' @param manual_oh4 Optional user-specified oh4
#' @return Named list with oh3, oh4
select_fixed_overhangs <- function(cds, polIII, tile_overhangs,
                                    fidelity_threshold = DEFAULT_FIDELITY_THRESHOLD,
                                    manual_oh3 = NULL, manual_oh4 = NULL) {
  if (!is.null(manual_oh3) && !is.null(manual_oh4)) {
    cli::cli_alert_info("Using manually specified oh3 and oh4.")
    validate_fixed_overhangs(manual_oh3, manual_oh4)
    return(list(oh3 = toupper(manual_oh3), oh4 = toupper(manual_oh4)))
  }

  hf_set <- load_high_fidelity_set()
  oh_data <- builtin_overhang_fidelity()

  gene_ohs <- unique(c(tile_overhangs$oh1_seq, tile_overhangs$oh2_seq))
  oh_L <- substring(cds, 1, 4)
  gene_ohs <- unique(c(gene_ohs, oh_L))
  gene_oh_rcs <- vapply(gene_ohs, reverse_complement, character(1), USE.NAMES = FALSE)
  used <- unique(c(gene_ohs, gene_oh_rcs))

  # Try HF set first
  candidates <- hf_set[!(hf_set %in% used)]
  if (length(candidates) >= 2) {
    selected <- select_orthogonal_set(candidates, 2)
    result <- list(oh3 = selected[1], oh4 = selected[2])
  } else {
    # Fallback to full fidelity-sorted list
    oh_data <- oh_data[order(oh_data$fidelity, decreasing = TRUE), ]
    candidates <- oh_data$overhang[oh_data$fidelity >= fidelity_threshold]
    candidates <- candidates[!(candidates %in% used)]
    if (length(candidates) < 2) {
      candidates <- oh_data$overhang[oh_data$fidelity >= 0.85]
      candidates <- candidates[!(candidates %in% used)]
    }
    selected <- select_orthogonal_set(candidates, 2)
    result <- list(oh3 = selected[1], oh4 = selected[2])
  }

  cli::cli_alert_success(paste0(
    "Selected fixed overhangs: oh3=", result$oh3, ", oh4=", result$oh4
  ))
  result
}

#' Select superblock overhangs (legacy wrapper)
#'
#' @param cds CDS (unused, kept for API compat)
#' @param polIII PolIII (unused, kept for API compat)
#' @param existing_overhangs Already-used overhangs
#' @param n_additional Number needed
#' @param fidelity_threshold Minimum fidelity
#' @return Character vector of additional overhangs
select_superblock_overhangs <- function(cds, polIII, existing_overhangs,
                                        n_additional,
                                        fidelity_threshold = DEFAULT_FIDELITY_THRESHOLD) {
  if (n_additional == 0) return(character(0))

  oh_data <- builtin_overhang_fidelity()
  oh_data <- oh_data[order(oh_data$fidelity, decreasing = TRUE), ]
  candidates <- oh_data$overhang[oh_data$fidelity >= fidelity_threshold]

  used <- character(0)
  for (oh in existing_overhangs) {
    used <- c(used, oh, reverse_complement(oh))
  }
  candidates <- candidates[!(candidates %in% used)]

  selected <- select_orthogonal_set(candidates, n_additional)

  cli::cli_alert_info(paste0(
    "Selected ", n_additional, " additional superblock overhang(s): ",
    paste(selected, collapse = ", ")
  ))

  selected
}
