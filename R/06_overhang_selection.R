# Created: 2025-02-01
# Last updated: 2026-02-27 — Allow oversized cassettes in partition_tile_superblocks(); expose cassette_needs_splitting flag
# 06_overhang_selection.R — Integrated assembly planning with dynamic tile boundary search
# DMS Golden Gate Oligo Pipeline
#
# Integrates tiling and overhang selection into a single planning system.
# Instead of fixing tile boundaries geometrically and then scoring overhangs,
# this module dynamically searches candidate boundary positions for ones where
# the gene-derived overhangs fall within a pre-validated high-fidelity (HF) set
# (Potapov 2018, Table 1 Set 3 — 25 overhangs, 95.8% predicted set fidelity).
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
  data_path <- file.path(
    find_data_dir(), "neb_overhang_fidelity",
    paste0(tolower(enzyme_name), "_overhangs.rds")
  )
  if (file.exists(data_path)) {
    return(readRDS(data_path))
  }
  generic_path <- file.path(
    find_data_dir(), "neb_overhang_fidelity",
    "potapov_18h_overhangs.rds"
  )
  if (file.exists(generic_path)) {
    return(readRDS(generic_path))
  }
  builtin_overhang_fidelity()
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

  # Last-resort fallback: greedy generation
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
  data_path <- file.path(
    find_data_dir(), "neb_overhang_fidelity",
    paste0(tolower(enzyme_name), "_pairwise.rds")
  )
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
# OOGGA-STYLE SCORING
# =============================================================================
# Scoring based on OOGGA (Mukundan & Madhusudhan 2025):
#   score = P_fid(oh) * P_eff(oh) * (1 + w_hf * in_HF)
# P_fid = M[X][RC(X)] / sum(M[X][*])  — individual fidelity (context-independent)
# P_eff = M[X][RC(X)] / max(diag(M))  — relative ligation efficiency
# w_hf  = bonus for Potapov Table 1 HF set membership (default 0.5)

#' Compute relative ligation efficiency for all 256 overhangs
#'
#' Efficiency measures how much correct product you get (yield), distinct from
#' fidelity (what fraction of product is correct). Extracted from the diagonal
#' of the Potapov 256x256 pairwise ligation matrix: P_eff(X) = M[X][RC(X)] / max(diag(M)).
#'
#' @param pairwise_matrix Named 256x256 matrix from load_pairwise_matrix().
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

#' Compute OOGGA-style overhang score with HF set bonus
#'
#' Combines ligation fidelity (P_fid) and efficiency (P_eff) multiplicatively,
#' with an additive bonus for membership in the Potapov Table 1 high-fidelity set.
#' This biases selection toward experimentally validated overhangs that have both
#' high individual quality AND low cross-reactivity in multi-fragment assemblies.
#'
#' Score = P_fid(oh) * P_eff(oh) * (1 + w_hf * in_HF)
#'
#' @param oh Character, 4-nt overhang sequence
#' @param fid_lookup Named numeric vector (overhang -> fidelity, i.e. P_fid)
#' @param eff_lookup Named numeric vector (overhang -> efficiency, i.e. P_eff)
#' @param hf_set Character vector of Potapov Table 1 HF overhangs
#' @param w_hf Numeric, HF bonus weight (default DEFAULT_HF_BONUS_WEIGHT = 0.5).
#'   A value of 0.5 means HF overhangs get 1.5x their base score.
#' @return Numeric score (higher is better)
oogga_score <- function(oh, fid_lookup, eff_lookup, hf_set,
                        w_hf = DEFAULT_HF_BONUS_WEIGHT) {
  # Look up P_fid; fall back to 0.5 for unknown overhangs (conservative default)
  fid <- if (oh %in% names(fid_lookup)) unname(fid_lookup[oh]) else 0.5
  # Look up P_eff; fall back to 0.5 for unknown overhangs
  eff <- if (oh %in% names(eff_lookup)) unname(eff_lookup[oh]) else 0.5
  in_hf <- oh %in% hf_set
  fid * eff * (1 + w_hf * in_hf)
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
    min_mutable_nt <- (min_mutable_nt %/% 3L) * 3L # codon boundary
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
      tile_id = 1L,
      start_codon = 1L,
      end_codon = n_codons,
      start_nt = 1L,
      end_nt = gene_len,
      oh1_seq = oh1,
      oh2_seq = oh2,
      oh1_in_hf = oh1 %in% hf_set,
      oh2_in_hf = oh2 %in% hf_set,
      oh1_fidelity = unname(oh1_fid),
      oh2_fidelity = unname(oh2_fid),
      tile_seq = cds,
      boundary_shift = 0L,
      stringsAsFactors = FALSE
    ))
  }

  # Multi-tile gene: compute ideal layout
  n_tiles <- ceiling(n_codons / max_codons)
  ideal_size <- ceiling(n_codons / n_tiles)
  ideal_boundaries <- ideal_size * seq_len(n_tiles - 1L)

  # Phase 2-3: Score and greedily assign boundaries
  assigned <- list() # list of list(pos, oh2, oh1_next, oh2_in_hf, oh1_in_hf, score, shift)

  for (bi in seq_along(ideal_boundaries)) {
    center <- ideal_boundaries[bi]
    prev_end <- if (bi == 1L) 0L else assigned[[bi - 1L]]$pos

    lo <- max(prev_end + min_codons, center - search_window_K)
    # Ensure last tile gets at least min_codons
    hi <- min(n_codons - min_codons, center + search_window_K)
    # Also ensure this tile doesn't exceed max_codons
    hi <- min(hi, prev_end + max_codons)

    if (lo > hi) lo <- hi # degenerate case

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
    tile_id = integer(n_tiles),
    start_codon = integer(n_tiles),
    end_codon = integer(n_tiles),
    start_nt = integer(n_tiles),
    end_nt = integer(n_tiles),
    oh1_seq = character(n_tiles),
    oh2_seq = character(n_tiles),
    oh1_in_hf = logical(n_tiles),
    oh2_in_hf = logical(n_tiles),
    oh1_fidelity = numeric(n_tiles),
    oh2_fidelity = numeric(n_tiles),
    tile_seq = character(n_tiles),
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

    tiles$tile_id[i] <- i
    tiles$start_codon[i] <- sc
    tiles$end_codon[i] <- ec
    tiles$start_nt[i] <- sn
    tiles$end_nt[i] <- en
    tiles$oh1_seq[i] <- oh1
    tiles$oh2_seq[i] <- oh2
    tiles$oh1_in_hf[i] <- oh1 %in% hf_set
    tiles$oh2_in_hf[i] <- oh2 %in% hf_set
    tiles$oh1_fidelity[i] <- oh1_fid
    tiles$oh2_fidelity[i] <- oh2_fid
    tiles$tile_seq[i] <- substring(cds, sn, en)
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
#' (oh1, oh2) and compute a composite OOGGA-style score:
#'   score = oogga_score(oh1) + oogga_score(oh2) + pairwise_bonus(oh1, oh_L) + penalty
#'
#' The pairwise bonus uses context-dependent set fidelity for oh1 with oh_L in the
#' BsaI reaction, which is MORE accurate than OOGGA's context-independent approach.
#'
#' @param cds Domesticated gene sequence
#' @param hf_set Character vector of high-fidelity overhangs
#' @param oh_fidelity Data frame with overhang + fidelity columns
#' @param bsai_matrix 256x256 BsaI pairwise ligation matrix (or NULL)
#' @param eff_lookup Named numeric vector (overhang -> efficiency from
#'   compute_overhang_efficiency()). If NULL, efficiency is treated as 1.0.
#' @return List with vectors: oh1_seq, oh2_seq, score, valid (all length n_codons)
precompute_boundary_scores <- function(cds, hf_set, oh_fidelity,
                                       bsai_matrix = NULL,
                                       eff_lookup = NULL) {
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

    oh1_in <- oh1 %in% hf_set
    oh2_in <- oh2 %in% hf_set
    oh1_hf[b] <- oh1_in
    oh2_hf[b] <- oh2_in

    # OOGGA-style base scores for both gene-derived overhangs
    oh1_base <- oogga_score(oh1, fid_lookup, eff_lookup, hf_set)
    oh2_base <- oogga_score(oh2, fid_lookup, eff_lookup, hf_set)

    # oh1 pairwise fidelity bonus with oh_L (BsaI reaction context).
    # This is context-dependent scoring — more accurate than OOGGA's
    # context-independent P_fid, so we add it as a bonus on top.
    if (!is.null(bsai_matrix) && oh1 %in% rownames(bsai_matrix) &&
      oh_L %in% rownames(bsai_matrix)) {
      sf <- compute_set_fidelity(c(oh_L, oh1), bsai_matrix)
      oh1_pw_bonus <- sf$set_fidelity
    } else {
      oh1_pw_bonus <- if (oh1 %in% names(fid_lookup)) unname(fid_lookup[oh1]) else 0.5
    }

    # Low-fidelity safety floor: penalize boundaries where either overhang
    # has very low individual fidelity (< 0.80). The multiplicative OOGGA
    # score already penalizes low-fidelity overhangs, but this explicit
    # penalty provides a hard safety threshold.
    fid_penalty <- 0.0
    oh1_ind_fid <- if (oh1 %in% names(fid_lookup)) unname(fid_lookup[oh1]) else 0.5
    oh2_ind_fid <- if (oh2 %in% names(fid_lookup)) unname(fid_lookup[oh2]) else 0.5
    if (oh1_ind_fid < 0.80 || oh2_ind_fid < 0.80) fid_penalty <- -5.0

    scores[b] <- oh1_base + oh2_base + oh1_pw_bonus + fid_penalty
  }

  precomp_elapsed <- (proc.time() - precomp_start)[["elapsed"]]
  cli::cli_alert_success("Boundary scores precomputed in {round(precomp_elapsed, 1)}s.")

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
  if (K == 0L) {
    return(NULL)
  }

  # Early feasibility check: need at least (K+1)*min_codons codons
  if ((K + 1L) * min_codons > n_codons) {
    return(NULL)
  }

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

  if (!is.finite(best_total)) {
    return(NULL)
  }

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
#' @param overlap_codons Number of overlap codons between adjacent tiles
#' @param eff_lookup Named numeric vector (overhang -> efficiency). If NULL,
#'   efficiency is treated as 1.0 for all overhangs.
#' @return Data frame with tile info (same format as search_tile_boundaries)
search_tile_boundaries_dp <- function(cds, max_mutable_nt,
                                      min_mutable_nt = NULL,
                                      hf_set = NULL,
                                      oh_fidelity = NULL,
                                      bsai_matrix = NULL,
                                      multi_k = TRUE,
                                      k_range = NULL,
                                      search_window_K = NULL,
                                      overlap_codons = 4L,
                                      eff_lookup = NULL) {
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

  # Effective max codons for DP constraint: reduced by overlap so that when
  # tiles are extended by overlap_codons, total tile size <= max_codons.
  effective_max_codons <- max_codons - overlap_codons
  if (effective_max_codons < min_codons) {
    # Overlap is too large for the tile budget; fall back to no overlap
    cli::cli_alert_warning(paste0(
      "overlap_codons (", overlap_codons, ") too large for tile budget. ",
      "Falling back to overlap_codons=0."
    ))
    overlap_codons <- 0L
    effective_max_codons <- max_codons
  }

  # Single-tile gene: no boundaries to search
  if (n_codons <= max_codons) {
    oh1 <- substring(cds, 1, 4)
    oh2 <- substring(cds, gene_len - 3, gene_len)
    oh1_fid <- if (oh1 %in% names(fid_lookup)) fid_lookup[oh1] else NA_real_
    oh2_fid <- if (oh2 %in% names(fid_lookup)) fid_lookup[oh2] else NA_real_

    return(data.frame(
      tile_id = 1L,
      start_codon = 1L,
      end_codon = n_codons,
      start_nt = 1L,
      end_nt = gene_len,
      oh1_seq = oh1,
      oh2_seq = oh2,
      oh1_in_hf = oh1 %in% hf_set,
      oh2_in_hf = oh2 %in% hf_set,
      oh1_fidelity = unname(oh1_fid),
      oh2_fidelity = unname(oh2_fid),
      tile_seq = cds,
      boundary_shift = 0L,
      stringsAsFactors = FALSE
    ))
  }

  # Precompute scores for all boundary positions
  precomp <- precompute_boundary_scores(cds, hf_set, oh_fidelity, bsai_matrix,
    eff_lookup = eff_lookup
  )

  # Determine K range to search (use effective_max_codons for boundary spacing)
  K_ideal <- ceiling(n_codons / effective_max_codons) - 1L
  if (is.null(k_range)) {
    if (multi_k) {
      K_min <- max(1L, ceiling(n_codons / effective_max_codons) - 1L)
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

  dp_start <- proc.time()
  for (K in k_range) {
    result <- dp_solve_k(
      K, n_codons, min_codons, effective_max_codons,
      precomp$score, precomp$valid
    )
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

  dp_elapsed <- (proc.time() - dp_start)[["elapsed"]]
  cli::cli_alert_info("DP tile boundary search completed in {round(dp_elapsed, 1)}s ({length(k_range)} K values).")

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
    tile_id = integer(n_tiles),
    start_codon = integer(n_tiles),
    end_codon = integer(n_tiles),
    start_nt = integer(n_tiles),
    end_nt = integer(n_tiles),
    oh1_seq = character(n_tiles),
    oh2_seq = character(n_tiles),
    oh1_in_hf = logical(n_tiles),
    oh2_in_hf = logical(n_tiles),
    oh1_fidelity = numeric(n_tiles),
    oh2_fidelity = numeric(n_tiles),
    tile_seq = character(n_tiles),
    boundary_shift = integer(n_tiles),
    stringsAsFactors = FALSE
  )

  for (i in seq_len(n_tiles)) {
    # Core boundaries from DP
    core_sc <- boundary_positions[i] + 1L
    core_ec <- boundary_positions[i + 1L]

    # Extend tile by overlap_codons on the right (into next tile's territory)
    # First tile starts at codon 1 (no left extension needed since there's no previous tile)
    # Last tile is capped at n_codons
    sc <- core_sc
    ec <- min(n_codons, core_ec + overlap_codons)

    sn <- (sc - 1L) * 3L + 1L
    en <- ec * 3L

    oh1 <- substring(cds, sn, sn + 3L)
    oh2 <- substring(cds, en - 3L, en)

    oh1_fid <- if (oh1 %in% names(fid_lookup)) unname(fid_lookup[oh1]) else NA_real_
    oh2_fid <- if (oh2 %in% names(fid_lookup)) unname(fid_lookup[oh2]) else NA_real_

    tiles$tile_id[i] <- i
    tiles$start_codon[i] <- sc
    tiles$end_codon[i] <- ec
    tiles$start_nt[i] <- sn
    tiles$end_nt[i] <- en
    tiles$oh1_seq[i] <- oh1
    tiles$oh2_seq[i] <- oh2
    tiles$oh1_in_hf[i] <- oh1 %in% hf_set
    tiles$oh2_in_hf[i] <- oh2 %in% hf_set
    tiles$oh1_fidelity[i] <- oh1_fid
    tiles$oh2_fidelity[i] <- oh2_fid
    tiles$tile_seq[i] <- substring(cds, sn, en)
    tiles$boundary_shift[i] <- 0L # DP doesn't use "shift from ideal"
  }

  # Compute summary stats
  n_both <- 0L
  n_one <- 0L
  n_neither <- 0L
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

#' Optimize superblock split positions for oversized gene blocks (greedy)
#'
#' Greedy search for split positions within the block where the gene-derived
#' junction overhang scores highest under OOGGA-style scoring.
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
#' @param eff_lookup Named numeric vector (overhang -> efficiency). If NULL,
#'   efficiency is treated as 1.0 for all overhangs.
#' @return Data frame with split positions and junction overhangs
optimize_split_points <- function(cds, block_start_nt, block_end_nt,
                                  max_sub_length, existing_ohs,
                                  hf_set, oh_fidelity,
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

        in_hf <- junction_oh %in% hf_set
        fid <- if (junction_oh %in% names(fid_lookup)) unname(fid_lookup[junction_oh]) else 0.5
        score <- oogga_score(junction_oh, fid_lookup, eff_lookup, hf_set)

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
# GLOBAL SUPERBLOCK BOUNDARY OPTIMIZATION
# =============================================================================

#' DP-optimize superblock split positions within a gene region
#'
#' Finds the set of split positions maximizing total OOGGA-style junction score,
#' using exactly K splits (where K = minimum splits needed for all sub-blocks
#' to fit within max_sub_length). Uses a layered DP analogous to dp_solve_k()
#' for tile boundaries.
#'
#' OOGGA scoring per candidate:
#'   score(p) = P_fid(oh) * P_eff(oh) * (1 + w_hf * in_HF)
#'
#' Constraint: every sub-block's gene content <= max_sub_length nt, where
#' the last sub-block also carries extra_content_length (e.g., PolIII).
#'
#' @param cds Full domesticated gene sequence
#' @param region_start_nt Start of region in CDS (1-based, inclusive)
#' @param region_end_nt End of region in CDS (1-based, inclusive)
#' @param max_sub_length Max nucleotide content per sub-block (gene content only,
#'   excluding enzyme site overhead — caller should subtract block_overhead)
#' @param extra_content_length Extra content appended to the last sub-block
#'   (e.g., PolIII promoter length for 3'WT blocks). Default 0.
#' @param exclude_ohs Character vector of overhangs to exclude (already committed
#'   in the same GG reaction — e.g., oh3 + all oh2 values for BsmBI)
#' @param hf_set High-fidelity overhang set
#' @param oh_fidelity Fidelity data frame (overhang + fidelity columns)
#' @param min_sub_length Minimum gene content per sub-block (default 0, no minimum).
#'   When > 0, the DP rejects transitions that produce sub-blocks shorter than this.
#' @param tile_boundary_nts Integer vector of tile boundary positions (end_nt for 3'WT,
#'   start_nt for 5'WT). Used for soft proximity penalty: splits near a tile boundary
#'   get a reduced score to avoid tiny sub-blocks for narrower tiles.
#' @param eff_lookup Named numeric vector (overhang -> efficiency). If NULL,
#'   efficiency is treated as 1.0 for all overhangs.
#' @return Data frame with split_nt, junction_oh, junction_in_hf, junction_fidelity
dp_solve_superblock_splits <- function(cds, region_start_nt, region_end_nt,
                                       max_sub_length, extra_content_length = 0L,
                                       exclude_ohs, hf_set, oh_fidelity,
                                       min_sub_length = 0L,
                                       tile_boundary_nts = integer(0),
                                       eff_lookup = NULL) {
  gene_region_length <- region_end_nt - region_start_nt + 1L
  total_content <- gene_region_length + extra_content_length

  cli::cli_alert_info(paste0(
    "Superblock DP: region [", region_start_nt, ", ", region_end_nt,
    "] (", gene_region_length, " nt gene + ", extra_content_length,
    " nt extra = ", total_content, " nt total)"
  ))
  sb_start <- proc.time()

  # No splitting needed if total content fits in one sub-block
  if (total_content <= max_sub_length) {
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

  # Build exclusion set including reverse complements
  exclude_set <- unique(c(
    exclude_ohs,
    vapply(exclude_ohs, reverse_complement, character(1))
  ))

  # Candidate split positions: codon boundaries (multiples of 3) within the region.
  # A split at nt position p means sub-blocks [..., p] and [p+1, ...].
  # The junction overhang is the 4-nt ending at p: substring(cds, p-3, p).
  # Require p >= 4 so the overhang is exactly 4 nt (substring(cds, p-3, p)).
  all_codon_ends <- seq(3L, nchar(cds), by = 3L)
  candidates <- all_codon_ends[
    all_codon_ends >= max(region_start_nt + 2L, 4L) &
      all_codon_ends <= region_end_nt - 3L
  ]

  if (length(candidates) == 0) {
    cli::cli_alert_warning(
      "No valid superblock split candidates in region [{region_start_nt}, {region_end_nt}]."
    )
    return(data.frame(
      split_nt = integer(0), junction_oh = character(0),
      junction_in_hf = logical(0), junction_fidelity = numeric(0),
      stringsAsFactors = FALSE
    ))
  }

  # Score each candidate position
  n_cand <- length(candidates)
  cand_oh <- character(n_cand)
  cand_score <- numeric(n_cand)
  cand_valid <- logical(n_cand)
  cand_in_hf <- logical(n_cand)
  cand_fid <- numeric(n_cand)
  prev_boundary <- region_start_nt - 1L # implicit zeroth boundary

  for (ci in seq_len(n_cand)) {
    p <- candidates[ci]
    oh <- substring(cds, p - 3L, p)
    cand_oh[ci] <- oh

    # Exclude overhangs that collide with committed overhangs in the same reaction
    if (nchar(oh) != 4L || oh %in% exclude_set) {
      cand_valid[ci] <- FALSE
      next
    }
    cand_valid[ci] <- TRUE

    in_hf <- oh %in% hf_set
    fid <- if (oh %in% names(fid_lookup)) unname(fid_lookup[oh]) else 0.5
    cand_in_hf[ci] <- in_hf
    cand_fid[ci] <- fid
    cand_score[ci] <- oogga_score(oh, fid_lookup, eff_lookup, hf_set)

    # Soft penalty: prefer splits away from tile boundaries.
    # When a global split falls just inside a narrow tile's WT region, it creates
    # a tiny first sub-block. Penalizing near-boundary candidates makes the DP
    # prefer positions that produce well-sized blocks for all tiles.
    if (min_sub_length > 0L && length(tile_boundary_nts) > 0) {
      dists <- p - tile_boundary_nts
      near <- dists[dists > 0L & dists < min_sub_length]
      if (length(near) > 0) {
        cand_score[ci] <- cand_score[ci] - 5 * max(1 - near / min_sub_length)
      }
    }
  }

  # Determine minimum number of splits K
  # K+1 sub-blocks must each be <= max_sub_length (last carries extra_content)
  K_min <- ceiling(total_content / max_sub_length) - 1L
  if (K_min < 1L) K_min <- 1L

  # Try K = K_min, then K_min+1, etc. up to a reasonable max.
  # This handles edge cases where the minimum K fails due to exclusion constraints.
  best_score <- -Inf
  best_ci <- NA_integer_
  best_K <- NA_integer_
  best_parent <- NULL

  for (K in K_min:min(K_min + 5L, 10L)) {
    # Layered DP for exactly K splits (analogous to dp_solve_k for tile boundaries)
    # dp_prev[ci] = best total score with previous boundary layer ending at candidate ci
    # parent[k, ci] = predecessor candidate index for layer k at position ci
    dp_prev <- rep(-Inf, n_cand)
    parent <- matrix(NA_integer_, nrow = K, ncol = n_cand)

    # Layer k=1: first split. Sub-block from region_start to candidates[ci].
    for (ci in seq_len(n_cand)) {
      if (!cand_valid[ci]) next
      p <- candidates[ci]
      first_sub <- p - prev_boundary # = p - region_start_nt + 1
      if (first_sub >= min_sub_length && first_sub <= max_sub_length) {
        dp_prev[ci] <- cand_score[ci]
      }
    }

    # Layers k=2..K
    if (K >= 2L) {
      for (k in 2L:K) {
        dp_curr <- rep(-Inf, n_cand)
        for (ci in seq_len(n_cand)) {
          if (!cand_valid[ci]) next
          p <- candidates[ci]

          # Check predecessors within max_sub_length distance (sliding window)
          for (cj in rev(seq_len(ci - 1L))) {
            sub_len <- p - candidates[cj]
            if (sub_len > max_sub_length) break # all earlier are farther
            if (sub_len < min_sub_length) next # sub-block too small
            if (!is.finite(dp_prev[cj])) next

            # Enforce overhang uniqueness: cand_oh[ci] must not match any
            # ancestor in the parent chain. This prevents ambiguous ligation
            # where two superblock junction overhangs are identical.
            oh_conflict <- FALSE
            ancestor <- cj
            for (kk in (k - 1L):1L) {
              if (cand_oh[ancestor] == cand_oh[ci]) {
                oh_conflict <- TRUE
                break
              }
              if (kk > 1L) {
                ancestor <- parent[kk, ancestor]
                if (is.na(ancestor)) break
              }
            }
            if (oh_conflict) next

            new_score <- dp_prev[cj] + cand_score[ci]
            if (new_score > dp_curr[ci]) {
              dp_curr[ci] <- new_score
              parent[k, ci] <- cj
            }
          }
        }
        dp_prev <- dp_curr
      }
    }

    # Find best endpoint: last sub-block (from last split to region_end + extra)
    # must fit within max_sub_length
    for (ci in seq_len(n_cand)) {
      if (!is.finite(dp_prev[ci])) next
      last_sub <- (region_end_nt - candidates[ci]) + extra_content_length
      if (last_sub >= min_sub_length && last_sub <= max_sub_length && last_sub > 0L) {
        if (dp_prev[ci] > best_score) {
          best_score <- dp_prev[ci]
          best_ci <- ci
          best_K <- K
          best_parent <- parent
        }
      }
    }

    # Stop as soon as we find a feasible solution at the minimum K
    if (is.finite(best_score)) break
  }

  if (!is.finite(best_score)) {
    cli::cli_alert_warning(paste0(
      "DP superblock split found no valid solution for region [",
      region_start_nt, ", ", region_end_nt, "]."
    ))
    return(data.frame(
      split_nt = integer(0), junction_oh = character(0),
      junction_in_hf = logical(0), junction_fidelity = numeric(0),
      stringsAsFactors = FALSE
    ))
  }

  sb_elapsed <- (proc.time() - sb_start)[["elapsed"]]
  cli::cli_alert_success(paste0(
    "Superblock DP solved: ", best_K, " split(s) in ", round(sb_elapsed, 1), "s."
  ))

  K <- best_K
  parent <- best_parent

  # Backtrack to recover split positions
  boundaries <- integer(K)
  boundaries[K] <- best_ci
  if (K >= 2L) {
    for (k in K:2L) {
      boundaries[k - 1L] <- parent[k, boundaries[k]]
    }
  }

  data.frame(
    split_nt = candidates[boundaries],
    junction_oh = cand_oh[boundaries],
    junction_in_hf = cand_in_hf[boundaries],
    junction_fidelity = cand_fid[boundaries],
    stringsAsFactors = FALSE
  )
}

#' DEPRECATED: Use partition_tile_superblocks() + convert_partition_to_splits()
#' instead. Kept for regression tests and backward compatibility.
#'
#' Compute global superblock boundaries for 3'WT and 5'WT regions
#'
#' Instead of computing split points independently per tile (which produces
#' tile-specific boundaries that drift and prevent block reuse), this function
#' computes GLOBAL boundaries shared across all tiles. Each tile then gets
#' the subset of global boundaries within its WT region range.
#'
#' This maximizes block reuse: tiles with overlapping WT regions share the
#' same boundary-to-boundary sub-blocks, so deduplication removes far more
#' duplicates.
#'
#' @param cds Full domesticated gene sequence
#' @param gene_len Length of CDS in nt
#' @param tiles Data frame of tiles from search_tile_boundaries_dp()
#' @param polIII_len Length of PolIII promoter in nt
#' @param max_sub_length Max gene content per sub-block (max_block_length - overhead)
#' @param hf_set High-fidelity overhang set
#' @param oh_fidelity Fidelity data frame
#' @param oh3 Fixed BsmBI overhang
#' @param oh4 Fixed BsaI overhang
#' @param oh_L First 4 nt of gene (BsaI overhang)
#' @param min_sub_length Minimum gene content per sub-block (default 0)
#' @param eff_lookup Named numeric vector (overhang -> efficiency). If NULL,
#'   efficiency is treated as 1.0 for all overhangs.
#' @return List with $splits_3wt and $splits_5wt data frames
compute_global_superblock_boundaries <- function(cds, gene_len, tiles,
                                                 polIII_len, max_sub_length,
                                                 hf_set, oh_fidelity,
                                                 oh3, oh4, oh_L,
                                                 min_sub_length = 0L,
                                                 eff_lookup = NULL) {
  # --- 3'WT boundaries (BsmBI reaction) ---
  # The longest possible 3'WT region: from earliest tile end to gene end
  earliest_3wt_start <- min(tiles$end_nt) + 1L

  # Exclusion set: oh3 + all oh2 values + their RCs (all in BsmBI reactions)
  exclude_3wt <- unique(c(
    oh3, tiles$oh2_seq,
    vapply(c(oh3, tiles$oh2_seq), reverse_complement, character(1))
  ))

  # Collect tile boundary nt positions for proximity penalty
  tile_boundary_nts <- unique(c(tiles$start_nt, tiles$end_nt))

  splits_3wt <- dp_solve_superblock_splits(
    cds = cds,
    region_start_nt = earliest_3wt_start,
    region_end_nt = gene_len,
    max_sub_length = max_sub_length,
    extra_content_length = polIII_len,
    exclude_ohs = exclude_3wt,
    hf_set = hf_set,
    oh_fidelity = oh_fidelity,
    min_sub_length = min_sub_length,
    tile_boundary_nts = tile_boundary_nts,
    eff_lookup = eff_lookup
  )

  # --- 5'WT boundaries (BsaI reaction) ---
  # The longest possible 5'WT region: from gene start to latest tile start
  latest_5wt_end <- max(tiles$start_nt) - 1L

  # Exclusion set: oh_L + oh4 + all oh1 values + their RCs (all in BsaI reactions)
  exclude_5wt <- unique(c(
    oh_L, oh4, tiles$oh1_seq,
    vapply(c(oh_L, oh4, tiles$oh1_seq), reverse_complement, character(1))
  ))

  # Only compute 5'WT splits if there's actually a 5'WT region to split
  if (latest_5wt_end >= 1L) {
    splits_5wt <- dp_solve_superblock_splits(
      cds = cds,
      region_start_nt = 1L,
      region_end_nt = latest_5wt_end,
      max_sub_length = max_sub_length,
      extra_content_length = 0L,
      exclude_ohs = exclude_5wt,
      hf_set = hf_set,
      oh_fidelity = oh_fidelity,
      min_sub_length = min_sub_length,
      tile_boundary_nts = tile_boundary_nts,
      eff_lookup = eff_lookup
    )
  } else {
    splits_5wt <- data.frame(
      split_nt = integer(0), junction_oh = character(0),
      junction_in_hf = logical(0), junction_fidelity = numeric(0),
      stringsAsFactors = FALSE
    )
  }

  list(splits_3wt = splits_3wt, splits_5wt = splits_5wt)
}

#' DEPRECATED: Use partition_tile_superblocks() + convert_partition_to_splits()
#' instead. Kept for regression tests and backward compatibility.
#'
#' Assign global superblock boundaries to individual tiles
#'
#' For each tile, selects the subset of global boundaries that fall within
#' that tile's WT region range, then validates per-tile sub-block sizes.
#' Splits that create undersized leading or trailing sub-blocks are dropped
#' (merged with adjacent sub-block) unless merging would exceed max_sub_length.
#'
#' Because boundaries are global, tiles with overlapping WT regions share
#' the same boundary-to-boundary sub-blocks, enabling efficient deduplication.
#'
#' @param tiles Data frame of tiles
#' @param global_3wt Data frame of global 3'WT split positions
#' @param global_5wt Data frame of global 5'WT split positions
#' @param gene_len Gene length in nt
#' @param min_sub_length Minimum gene content per sub-block (default 0)
#' @param max_sub_length Maximum gene content per sub-block (default Inf)
#' @param polIII_len Length of PolIII/downstream cassette appended to last 3'WT sub-block
#' @return Data frame with split_nt, junction_oh, junction_in_hf,
#'   junction_fidelity, block_type, tile_id
assign_global_boundaries_to_tiles <- function(tiles, global_3wt, global_5wt,
                                              gene_len,
                                              min_sub_length = 0L,
                                              max_sub_length = Inf,
                                              polIII_len = 0L) {
  splits_list <- list()

  for (i in seq_len(nrow(tiles))) {
    tile <- tiles[i, ]

    # 3'WT: tile's 3'WT region is [tile$end_nt + 1, gene_len]
    # Assign global splits that fall strictly within this range
    if (nrow(global_3wt) > 0 && tile$end_nt < gene_len) {
      in_range <- global_3wt$split_nt > tile$end_nt &
        global_3wt$split_nt < gene_len
      if (any(in_range)) {
        s3 <- global_3wt[in_range, , drop = FALSE]

        # Per-tile size validation for 3'WT splits
        if (min_sub_length > 0L && nrow(s3) > 0) {
          region_start <- tile$end_nt # boundary before first sub-block
          region_end <- gene_len
          split_nts <- s3$split_nt

          # Drop leading splits that create undersized first sub-block
          while (length(split_nts) > 0) {
            leading_gap <- split_nts[1L] - region_start
            if (leading_gap >= min_sub_length) break
            # Check if merging with second sub-block would overflow
            next_boundary <- if (length(split_nts) >= 2L) split_nts[2L] else region_end
            merged <- next_boundary - region_start
            if (merged > max_sub_length) break # can't merge, keep undersized
            split_nts <- split_nts[-1L]
          }

          # Drop trailing splits that create undersized last sub-block
          # (last 3'WT sub-block carries polIII_len extra content)
          while (length(split_nts) > 0) {
            trailing_gene <- region_end - split_nts[length(split_nts)]
            trailing_total <- trailing_gene + polIII_len
            if (trailing_total >= min_sub_length) break
            # Check if merging with preceding sub-block would overflow
            if (length(split_nts) >= 2L) {
              prev_boundary <- split_nts[length(split_nts) - 1L]
            } else {
              prev_boundary <- region_start
            }
            merged_total <- (region_end - prev_boundary) + polIII_len
            if (merged_total > max_sub_length) break # can't merge, keep undersized
            split_nts <- split_nts[-length(split_nts)]
          }

          # Rebuild s3 with surviving splits
          s3 <- s3[s3$split_nt %in% split_nts, , drop = FALSE]
        }

        if (nrow(s3) > 0) {
          s3$block_type <- "bsmbi_3wt"
          s3$tile_id <- tile$tile_id
          splits_list[[length(splits_list) + 1L]] <- s3
        }
      }
    }

    # 5'WT: tile's 5'WT region is [1, tile$start_nt - 1]
    # Assign global splits that fall strictly within this range
    if (nrow(global_5wt) > 0 && tile$start_nt > 1L) {
      in_range <- global_5wt$split_nt >= 1L &
        global_5wt$split_nt < tile$start_nt
      if (any(in_range)) {
        s5 <- global_5wt[in_range, , drop = FALSE]

        # Per-tile size validation for 5'WT splits
        if (min_sub_length > 0L && nrow(s5) > 0) {
          region_start <- 0L # boundary before first sub-block (gene start - 1)
          region_end <- tile$start_nt - 1L
          split_nts <- s5$split_nt

          # Drop trailing splits that create undersized last sub-block
          while (length(split_nts) > 0) {
            trailing_gap <- region_end - split_nts[length(split_nts)]
            if (trailing_gap >= min_sub_length) break
            # Check if merging with preceding sub-block would overflow
            if (length(split_nts) >= 2L) {
              prev_boundary <- split_nts[length(split_nts) - 1L]
            } else {
              prev_boundary <- region_start
            }
            merged <- region_end - prev_boundary
            if (merged > max_sub_length) break # can't merge, keep undersized
            split_nts <- split_nts[-length(split_nts)]
          }

          # Drop leading splits that create undersized first sub-block
          while (length(split_nts) > 0) {
            leading_gap <- split_nts[1L] - region_start
            if (leading_gap >= min_sub_length) break
            next_boundary <- if (length(split_nts) >= 2L) split_nts[2L] else region_end
            merged <- next_boundary - region_start
            if (merged > max_sub_length) break
            split_nts <- split_nts[-1L]
          }

          # Rebuild s5 with surviving splits
          s5 <- s5[s5$split_nt %in% split_nts, , drop = FALSE]
        }

        if (nrow(s5) > 0) {
          s5$block_type <- "bsai_5wt"
          s5$tile_id <- tile$tile_id
          splits_list[[length(splits_list) + 1L]] <- s5
        }
      }
    }
  }

  if (length(splits_list) > 0) {
    all_splits <- do.call(rbind, splits_list)
    rownames(all_splits) <- NULL
    all_splits
  } else {
    data.frame(
      split_nt = integer(0), junction_oh = character(0),
      junction_in_hf = logical(0), junction_fidelity = numeric(0),
      block_type = character(0), tile_id = integer(0),
      stringsAsFactors = FALSE
    )
  }
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

#' Partition tiles into superblocks at tile boundaries
#'
#' Groups contiguous tiles into superblocks (SBs) such that each SB's gene
#' content fits within max_sub_length. The last SB also accounts for the
#' PolIII/cassette length when possible. SB boundaries align with tile
#' boundaries — the boundary overhang is the oh2 of the last tile in each
#' non-final SB.
#'
#' This replaces the old global superblock system
#' (compute_global_superblock_boundaries + assign_global_boundaries_to_tiles)
#' and eliminates BUG-005 by using per-tile overhang exclusion instead of
#' global exclusion.
#'
#' Algorithm:
#'   Phase 1: Forward greedy — accumulate tiles into SBs until adding the
#'     next tile would exceed max_sub_length.
#'   Phase 2: Adjust last SB to accommodate polIII_len (soft constraint —
#'     the function proceeds even if no partition can fit polIII attached).
#'   Phase 3: Build superblocks data frame.
#'   Phase 4: Detect and resolve overhang collisions at SB boundaries by
#'     shifting boundaries ±1 tile.
#'   Phase 5: Compute block counts.
#'
#' @param tiles Data frame from search_tile_boundaries_dp() with columns:
#'   tile_id, start_nt, end_nt, oh1_seq, oh2_seq, etc.
#' @param gene_len Length of the domesticated CDS in nucleotides
#' @param polIII_len Length of downstream cassette (PolIII + intergene elements)
#'   in nt. Set to 0 if cassette is handled as a separate fragment.
#' @param max_sub_length Maximum gene content per sub-block in nt
#'   (typically max_block_length - block_overhead, e.g. 1800 - 22 = 1778)
#' @param oh3 Optional oh3 overhang for collision checking. NULL skips
#'   collision detection.
#' @param oh_fidelity Optional fidelity data frame (reserved for future use)
#' @param hf_set Optional HF overhang set (reserved for future use)
#' @return List with:
#'   \item{n_superblocks}{Integer, number of superblocks}
#'   \item{superblocks}{Data frame: sb_id, start_tile, end_tile, gene_content}
#'   \item{n_collisions}{Integer, number of unresolved overhang collisions
#'     (0 = clean partition)}
#'   \item{block_count}{List with tile_blocks and full_sb_blocks counts}
partition_tile_superblocks <- function(tiles, gene_len, polIII_len,
                                       max_sub_length,
                                       oh3 = NULL,
                                       oh_fidelity = NULL,
                                       hf_set = NULL) {
  n_tiles <- nrow(tiles)

  # --- Input validation ---
  # If cassette alone exceeds max_sub_length, the partition planner can still
  # proceed — the cassette will be split into multiple fragments downstream
  # by find_cassette_split_points() in design_wt_geneblocks(). Flag this so
  # downstream consumers know cassette splitting is required.
  cassette_needs_splitting <- polIII_len > max_sub_length
  if (cassette_needs_splitting) {
    cli::cli_alert_info(sprintf(
      "Cassette length (%d) exceeds max_sub_length (%d). Cassette will be split into fragments.",
      polIII_len, max_sub_length
    ))
  }

  # =========================================================================
  # Phase 1: Forward greedy partitioning
  # =========================================================================
  # Accumulate tiles left-to-right. When adding the next tile would cause the
  # current SB's gene content to exceed max_sub_length, close the current SB
  # and start a new one.
  #
  # Gene content of SB_i = right_boundary_nt - left_boundary_nt, where:
  #   - left_boundary = 0 for first SB, tiles[prev_end_tile].end_nt otherwise
  #   - right_boundary = tiles[end_tile].end_nt for non-last, gene_len for last
  sb_end_tiles <- integer(0) # end_tile index for each SB
  prev_boundary_nt <- 0L # left boundary (nt) of current SB
  current_start_tile <- 1L

  for (i in seq_len(n_tiles)) {
    # Gene content of current SB if we include tile i
    content <- tiles$end_nt[i] - prev_boundary_nt

    if (content > max_sub_length && i > current_start_tile) {
      # Close current SB at tile i-1 (tile i would overflow)
      sb_end_tiles <- c(sb_end_tiles, i - 1L)
      prev_boundary_nt <- tiles$end_nt[i - 1L]
      current_start_tile <- i
    }
  }
  # Close the last SB
  sb_end_tiles <- c(sb_end_tiles, n_tiles)

  # =========================================================================
  # Phase 2: Adjust last SB for polIII/cassette budget
  # =========================================================================
  # The last SB's gene block includes the PolIII cassette. Its orderable
  # length = gene_content + polIII_len, which must be <= max_sub_length.
  # If it doesn't fit, split tiles from the last SB into a new penultimate SB.
  # This is a soft constraint: if no partition can fit polIII (e.g., single
  # tile's gene region + polIII > max_sub_length), proceed anyway.
  n_sb <- length(sb_end_tiles)
  if (polIII_len > 0L && !cassette_needs_splitting) {
    # Normal case: cassette fits in one block, optimize gene content in last SB
    last_left_nt <- if (n_sb >= 2L) tiles$end_nt[sb_end_tiles[n_sb - 1L]] else 0L
    last_gene_content <- gene_len - last_left_nt

    while (last_gene_content + polIII_len > max_sub_length) {
      last_start_tile <- if (n_sb >= 2L) sb_end_tiles[n_sb - 1L] + 1L else 1L
      last_end_tile <- sb_end_tiles[n_sb]

      # Can't split a single-tile last SB further — accept and move on
      if (last_start_tile == last_end_tile) break

      # Find the earliest split tile where the remaining gene + polIII fits
      found_split <- FALSE
      for (split_at in seq(last_start_tile, last_end_tile - 1L)) {
        remaining <- gene_len - tiles$end_nt[split_at]
        if (remaining + polIII_len <= max_sub_length) {
          # Also verify the new penultimate SB fits
          new_penult_content <- tiles$end_nt[split_at] - last_left_nt
          if (new_penult_content <= max_sub_length) {
            # Insert new boundary: replace [..., last_end] with [..., split_at, last_end]
            sb_end_tiles <- c(sb_end_tiles[-n_sb], split_at, last_end_tile)
            found_split <- TRUE
            break
          }
        }
      }

      if (!found_split) break # No valid split exists — accept oversized last SB

      # Recompute for next iteration
      n_sb <- length(sb_end_tiles)
      last_left_nt <- tiles$end_nt[sb_end_tiles[n_sb - 1L]]
      last_gene_content <- gene_len - last_left_nt
    }
  } else if (polIII_len > 0L && cassette_needs_splitting) {
    # Cassette is oversized — it will be split into separate BsmBI fragments
    # by design_wt_geneblocks(). For partition purposes, treat the last SB as
    # needing only gene content (no cassette budget), since the cassette will
    # be in its own sub-blocks. Skip the normal Phase 2 adjustment.
    cli::cli_alert_info(paste0(
      "Skipping Phase 2 cassette budget adjustment — ",
      "cassette will be split into separate fragments."
    ))
  }

  # =========================================================================
  # Phase 3: Build superblocks data frame
  # =========================================================================
  n_sb <- length(sb_end_tiles)
  sb_start_tiles <- c(1L, sb_end_tiles[-n_sb] + 1L)
  gene_contents <- integer(n_sb)

  for (i in seq_len(n_sb)) {
    left_nt <- if (i == 1L) 0L else tiles$end_nt[sb_end_tiles[i - 1L]]
    right_nt <- if (i == n_sb) gene_len else tiles$end_nt[sb_end_tiles[i]]
    gene_contents[i] <- right_nt - left_nt
  }

  sbs <- data.frame(
    sb_id = seq_len(n_sb),
    start_tile = sb_start_tiles,
    end_tile = sb_end_tiles,
    gene_content = gene_contents,
    stringsAsFactors = FALSE
  )

  # =========================================================================
  # Phase 4: Overhang collision detection and resolution
  # =========================================================================
  # SB boundary overhangs must not collide with oh3 or with each other.
  # If a collision is detected, try shifting the boundary ±1 tile.
  n_collisions <- 0L

  if (n_sb >= 2L && !is.null(oh3)) {
    oh3_rc <- reverse_complement(oh3)

    for (bi in seq_len(n_sb - 1L)) {
      boundary_tile <- sb_end_tiles[bi]
      boundary_oh <- tiles$oh2_seq[boundary_tile]

      # --- Check for collision ---
      has_collision <- FALSE

      # vs oh3
      if (oh_collides(boundary_oh, oh3)) {
        has_collision <- TRUE
      }

      # vs other SB boundary OHs
      if (!has_collision) {
        for (bj in seq_len(n_sb - 1L)) {
          if (bj == bi) next
          other_oh <- tiles$oh2_seq[sb_end_tiles[bj]]
          if (oh_collides(boundary_oh, other_oh)) {
            has_collision <- TRUE
            break
          }
        }
      }

      if (!has_collision) next

      n_collisions <- n_collisions + 1L

      # --- Try shifting boundary ±1 tile ---
      shift_candidates <- c(boundary_tile - 1L, boundary_tile + 1L)
      resolved <- FALSE

      for (new_bt in shift_candidates) {
        # Must be a valid tile index
        if (new_bt < 1L || new_bt >= n_tiles) next

        # Must maintain SB ordering: prev_boundary < new_bt < next_boundary
        prev_end <- if (bi > 1L) sb_end_tiles[bi - 1L] else 0L
        next_end <- if (bi < n_sb - 1L) sb_end_tiles[bi + 1L] else n_tiles
        if (new_bt <= prev_end || new_bt >= next_end) next

        # Validate sizing: SB before this boundary
        left_nt <- if (bi == 1L) 0L else tiles$end_nt[sb_end_tiles[bi - 1L]]
        new_right <- tiles$end_nt[new_bt]
        if ((new_right - left_nt) > max_sub_length) next

        # Validate sizing: SB after this boundary
        if (bi == n_sb - 1L) {
          # Boundary before the last SB — check polIII constraint
          after_content <- gene_len - new_right
          if (polIII_len > 0L && (after_content + polIII_len) > max_sub_length) next
          if (after_content > max_sub_length) next
        } else {
          after_right <- tiles$end_nt[sb_end_tiles[bi + 1L]]
          if ((after_right - new_right) > max_sub_length) next
        }

        # Check new OH for collisions
        new_oh <- tiles$oh2_seq[new_bt]
        new_has_collision <- FALSE

        if (oh_collides(new_oh, oh3)) new_has_collision <- TRUE

        if (!new_has_collision) {
          for (bj in seq_len(n_sb - 1L)) {
            if (bj == bi) next
            other_oh <- tiles$oh2_seq[sb_end_tiles[bj]]
            if (oh_collides(new_oh, other_oh)) {
              new_has_collision <- TRUE
              break
            }
          }
        }

        if (!new_has_collision) {
          sb_end_tiles[bi] <- new_bt
          resolved <- TRUE
          break
        }
      }

      if (resolved) n_collisions <- n_collisions - 1L
    }

    # Rebuild superblocks data frame with potentially updated boundaries
    sb_start_tiles <- c(1L, sb_end_tiles[-n_sb] + 1L)
    for (i in seq_len(n_sb)) {
      left_nt <- if (i == 1L) 0L else tiles$end_nt[sb_end_tiles[i - 1L]]
      right_nt <- if (i == n_sb) gene_len else tiles$end_nt[sb_end_tiles[i]]
      gene_contents[i] <- right_nt - left_nt
    }
    sbs <- data.frame(
      sb_id = seq_len(n_sb),
      start_tile = sb_start_tiles,
      end_tile = sb_end_tiles,
      gene_content = gene_contents,
      stringsAsFactors = FALSE
    )
  }

  # =========================================================================
  # Phase 5: Block counting
  # =========================================================================
  # tile_blocks: within each SB, interior tile boundaries need partial fragments
  #   for both BsaI (5'WT) and BsmBI (3'WT) → 2 * (N_i - 1) per SB
  # full_sb_blocks: each non-terminal SB needs both BsaI and BsmBI versions
  #   → 2 * (n_sb - 1) total
  tile_blocks <- 0L
  for (i in seq_len(n_sb)) {
    n_tiles_in_sb <- sbs$end_tile[i] - sbs$start_tile[i] + 1L
    tile_blocks <- tile_blocks + 2L * (n_tiles_in_sb - 1L)
  }
  full_sb_blocks <- 2L * (n_sb - 1L)

  list(
    n_superblocks = n_sb,
    superblocks = sbs,
    n_collisions = n_collisions,
    cassette_needs_splitting = cassette_needs_splitting,
    block_count = list(
      tile_blocks = tile_blocks,
      full_sb_blocks = full_sb_blocks
    )
  )
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
# MASTER ASSEMBLY PLANNER
# =============================================================================

#' Plan the complete assembly: tiles, overhangs, and superblock splits
#'
#' Master function that orchestrates:
#'   Phase 1-3: Dynamic tile boundary search
#'   Phase 4: oh3 derivation from promoter + oh4 selection from HF set
#'   Phase 5: Superblock split-point optimization
#'   Phase 6: Per-reaction pairwise validation
#'
#' @param cds Domesticated gene sequence
#' @param polIII PolIII promoter sequence
#' @param max_mutable_nt Max mutable region in nt (from compute_max_tile_size)
#' @param max_block_length Max synthesis length (default 1800)
#' @param config List with fidelity_threshold, manual_oh3, manual_oh4,
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
  fidelity_threshold <- config$fidelity_threshold %||% DEFAULT_FIDELITY_THRESHOLD
  manual_oh3 <- config$manual_oh3
  manual_oh4 <- config$manual_oh4
  search_window_K <- config$search_window_K %||% 15L
  boundary_method <- config$boundary_method %||% "dp"
  multi_k <- config$multi_k %||% TRUE
  overlap_codons <- config$overlap_codons %||% 4L
  min_geneblock_length <- config$min_geneblock_length %||% MIN_GENEBLOCK_LENGTH
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

  # Compute OOGGA efficiency metric from the generic Potapov pairwise matrix.
  # P_eff(X) = M[X][RC(X)] / max(diag(M)) — relative ligation efficiency.
  potapov_matrix <- load_pairwise_matrix("potapov_18h")
  eff_lookup <- compute_overhang_efficiency(potapov_matrix)

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
      multi_k = multi_k,
      overlap_codons = overlap_codons,
      eff_lookup = eff_lookup
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

  # Phase 4: Select oh3 (from promoter), oh4 (from HF set)
  cli::cli_h3("Selecting fixed overhangs (oh3, oh4)")
  oh_L <- substring(cds, 1, 4)

  # Collect committed gene-derived overhangs (needed for orthogonality checks)
  all_oh1 <- unique(c(oh_L, tiles$oh1_seq))
  all_oh2 <- unique(tiles$oh2_seq)
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
    # junction seamlessly reconstructs the promoter–barcode boundary.
    oh3_exclude <- unique(c(all_oh2, vapply(all_oh2, reverse_complement, character(1))))
    promoter_derived <- derive_oh3_from_promoter(polIII)

    if (!is.null(promoter_derived) &&
      !(promoter_derived$oh3 %in% oh3_exclude) &&
      !(promoter_derived$oh3 %in% HOMOPOLYMER_4NT)) {
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
      # Promoter-derived oh3 not usable — fall back to HF set selection
      if (is.null(promoter_derived)) {
        cli::cli_alert_warning("PolIII promoter too short for oh3 derivation. Falling back to HF set.")
      } else {
        cli::cli_alert_warning(paste0(
          "Promoter-derived oh3=", promoter_derived$oh3,
          " collides with oh2 or is homopolymer. Falling back to HF set."
        ))
      }
      strategy_used <- "hf_set"
      oh3_candidates <- hf_set[!(hf_set %in% oh3_exclude)]
      oh3_candidates <- oh3_candidates[!(oh3_candidates %in% HOMOPOLYMER_4NT)]

      if (length(oh3_candidates) > 0) {
        oh3_fids <- unname(fid_lookup[oh3_candidates])
        oh3 <- oh3_candidates[which.max(oh3_fids)]
        oh3_in_hf <- TRUE
      } else {
        cli::cli_alert_warning("No HF-set oh3 candidate available. Using pairwise fallback.")
        strategy_used <- "pairwise_matrix"
        all_ohs <- oh_fidelity$overhang[oh_fidelity$fidelity >= 0.90]
        all_ohs <- all_ohs[!(all_ohs %in% oh3_exclude)]
        all_ohs <- all_ohs[!(all_ohs %in% HOMOPOLYMER_4NT)]
        if (length(all_ohs) == 0) stop("Cannot find any valid oh3 candidate.")
        oh3_fids <- unname(fid_lookup[all_ohs])
        oh3 <- all_ohs[which.max(oh3_fids)]
        oh3_in_hf <- FALSE
      }
    }

    # --- oh4: auto-select from HF set (unchanged logic) ---
    oh4_exclude <- unique(c(all_oh1, vapply(all_oh1, reverse_complement, character(1))))
    oh4_candidates <- hf_set[!(hf_set %in% oh4_exclude)]
    oh4_candidates <- oh4_candidates[!(oh4_candidates %in% HOMOPOLYMER_4NT)]

    if (length(oh4_candidates) > 0) {
      oh4_fids <- unname(fid_lookup[oh4_candidates])
      oh4 <- oh4_candidates[which.max(oh4_fids)]
      oh4_in_hf <- TRUE
    } else {
      cli::cli_alert_warning("No HF-set oh4 candidate available. Using pairwise fallback.")
      if (strategy_used != "pairwise_matrix") strategy_used <- "hf_set"
      all_ohs <- oh_fidelity$overhang[oh_fidelity$fidelity >= 0.90]
      all_ohs <- all_ohs[!(all_ohs %in% oh4_exclude)]
      all_ohs <- all_ohs[!(all_ohs %in% HOMOPOLYMER_4NT)]
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

  # Phase 5: Tile-boundary superblock partitioning
  #
  # Groups contiguous tiles into superblocks at tile boundaries, replacing the
  # old global DP system. Each SB's gene content fits within the synthesis limit.
  # SB boundary overhangs (oh2 of boundary tiles) are checked for collisions
  # with oh3 and each other.
  cli::cli_h3("Partitioning tiles into superblocks")
  block_overhead <- 22L # 2 x 11-nt enzyme sites per block
  n_tiles <- nrow(tiles)

  partition_result <- partition_tile_superblocks(
    tiles = tiles,
    gene_len = gene_len,
    polIII_len = polIII_len,
    max_sub_length = max_block_length - block_overhead,
    oh3 = oh3
  )

  # Convert partition to legacy all_splits format for downstream consumers
  # (design_wt_geneblocks, R/12_report.R)
  all_splits <- convert_partition_to_splits(
    partition_result = partition_result,
    tiles = tiles,
    gene_len = gene_len,
    polIII_len = polIII_len
  )

  if (partition_result$n_superblocks > 1L) {
    n_boundaries <- partition_result$n_superblocks - 1L
    n_hf <- sum(tiles$oh2_in_hf[partition_result$superblocks$end_tile[
      seq_len(n_boundaries)
    ]])
    cass_msg <- if (partition_result$cassette_needs_splitting) {
      " Cassette will be split into fragments."
    } else {
      ""
    }
    cli::cli_alert_info(paste0(
      "Tile-boundary partition: ", partition_result$n_superblocks,
      " superblocks, ", n_boundaries, " boundary(ies). ",
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
    tile_partition = partition_result, # new tile-boundary partition (native format)
    reaction_fidelity = reaction_fidelity_df,
    strategy_used = strategy_used,
    hf_set_used = hf_set,
    oh_fidelity_used = oh_fidelity,
    cassette_needs_splitting = partition_result$cassette_needs_splitting,
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
  if (n < 2) {
    return(TRUE)
  }

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
      tile_id = tiles$tile_id,
      oh1_seq = tiles$oh1_seq,
      oh2_seq = tiles$oh2_seq,
      oh1_fidelity = tiles$oh1_fidelity,
      oh2_fidelity = tiles$oh2_fidelity,
      stringsAsFactors = FALSE
    ))
  }

  # Fallback: look up fidelity
  if (is.null(oh_fidelity_data)) oh_fidelity_data <- builtin_overhang_fidelity()

  result <- data.frame(
    tile_id = tiles$tile_id,
    oh1_seq = tiles$oh1_seq,
    oh2_seq = tiles$oh2_seq,
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
  candidates <- candidates[!(candidates %in% HOMOPOLYMER_4NT)]
  if (length(candidates) >= 2) {
    selected <- select_orthogonal_set(candidates, 2)
    result <- list(oh3 = selected[1], oh4 = selected[2])
  } else {
    # Fallback to full fidelity-sorted list
    oh_data <- oh_data[order(oh_data$fidelity, decreasing = TRUE), ]
    candidates <- oh_data$overhang[oh_data$fidelity >= fidelity_threshold]
    candidates <- candidates[!(candidates %in% used)]
    candidates <- candidates[!(candidates %in% HOMOPOLYMER_4NT)]
    if (length(candidates) < 2) {
      candidates <- oh_data$overhang[oh_data$fidelity >= 0.85]
      candidates <- candidates[!(candidates %in% used)]
      candidates <- candidates[!(candidates %in% HOMOPOLYMER_4NT)]
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
  if (n_additional == 0) {
    return(character(0))
  }

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
