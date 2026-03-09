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

#' Built-in T4 ligase fidelity data for all 256 4-nt overhangs (legacy)
#'
#' Data from Potapov et al. 2018 (T4 DNA Ligase, 37C, 18h incubation).
#' Fidelity = M[X][RC(X)] / sum(M[X][*]) — correct Watson-Crick pairing.
#'
#' NOTE: This is legacy T4 data retained as an optional fallback. The pipeline
#' defaults to BsmBI cycling data (Pryor et al. 2020) via load_overhang_fidelity().
#' T4 fidelity values are substantially higher than BsmBI cycling (median 0.94 vs 0.64).
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
load_pairwise_matrix <- function(enzyme_name = "BsmBI") {
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
#' FALLBACK ONLY — real Pryor 2020 pairwise matrices should be used when available.
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
  # Look up P_fid; fall back to 0.5 for unknown overhangs (conservative default)
  fid <- if (oh %in% names(fid_lookup)) unname(fid_lookup[oh]) else 0.5
  # Look up P_eff; fall back to 0.5 for unknown overhangs
  eff <- if (oh %in% names(eff_lookup)) unname(eff_lookup[oh]) else 0.5
  fid * eff
}

#' @rdname overhang_score
#' @description Legacy alias for overhang_score (backward compatibility).
oogga_score <- function(oh, fid_lookup, eff_lookup, hf_set = character(0),
                        w_hf = 0) {
  overhang_score(oh, fid_lookup, eff_lookup)
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
#' @param oh_fidelity Data frame with overhang + fidelity columns
#' @param eff_lookup Named numeric vector of overhang efficiencies (P_eff)
#' @param search_window_K Search window: +/- K codons around ideal boundary
#' @return Data frame with tile info including oh1/oh2 and HF membership
search_tile_boundaries <- function(cds, max_mutable_nt,
                                   min_mutable_nt = NULL,
                                   oh_fidelity = NULL,
                                   eff_lookup = NULL,
                                   search_window_K = 15L) {
  gene_len <- nchar(cds)
  n_codons <- gene_len %/% 3L

  if (is.null(min_mutable_nt)) {
    min_mutable_nt <- max(81L, max_mutable_nt %/% 3L)
    min_mutable_nt <- (min_mutable_nt %/% 3L) * 3L # codon boundary
  }
  if (is.null(oh_fidelity)) oh_fidelity <- load_overhang_fidelity("BsmBI")
  if (is.null(eff_lookup)) {
    # Load BsmBI cycling pairwise matrix and compute efficiency
    bsmbi_pw <- load_pairwise_matrix("BsmBI")
    eff_lookup <- compute_overhang_efficiency(bsmbi_pw)
  }

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
      oh1_in_hf = oh1 %in% POTAPOV_TABLE1_SET3_25,
      oh2_in_hf = oh2 %in% POTAPOV_TABLE1_SET3_25,
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

      oh2_in <- oh2_seq %in% POTAPOV_TABLE1_SET3_25
      oh1_in <- oh1_seq %in% POTAPOV_TABLE1_SET3_25
      # Score = P_fid * P_eff for each boundary overhang (BUG-008)
      oh2_score <- overhang_score(oh2_seq, fid_lookup, eff_lookup)
      oh1_score <- overhang_score(oh1_seq, fid_lookup, eff_lookup)
      score <- oh2_score + oh1_score

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

    # Fallback: relax constraints, pick best valid size
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
    tiles$oh1_in_hf[i] <- oh1 %in% POTAPOV_TABLE1_SET3_25
    tiles$oh2_in_hf[i] <- oh2 %in% POTAPOV_TABLE1_SET3_25
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
#' @param oh_fidelity Data frame with overhang + fidelity columns
#' @param multi_k Logical: try multiple tile counts? (default TRUE)
#' @param dp_k_range Integer: search K_ideal +/- dp_k_range (default 5).
#'   Larger values explore more tile counts but take longer.
#' @param k_range Integer vector of K values to try (NULL = auto from dp_k_range)
#' @param overlap_codons Number of overlap codons between adjacent tiles
#' @param eff_lookup Named numeric vector (overhang -> efficiency). If NULL,
#'   efficiency is treated as 1.0 for all overhangs.
#' @param blacklisted_oh2 Character vector of oh2 overhangs to exclude from
#'   tile boundaries (OPT-005 legacy). Default NULL.
#' @param sb_blacklist Character vector of SB boundary overhangs to avoid at
#'   tile boundaries. Merged into both oh1 and oh2 blacklists so that no tile
#'   boundary reuses an SB junction overhang. Default NULL.
#' @return Data frame with tile info (same format as search_tile_boundaries)
search_tile_boundaries_dp <- function(cds, max_mutable_nt,
                                      min_mutable_nt = NULL,
                                      oh_fidelity = NULL,
                                      multi_k = TRUE,
                                      dp_k_range = 5L,
                                      k_range = NULL,
                                      overlap_codons = 4L,
                                      eff_lookup = NULL,
                                      blacklisted_oh2 = NULL,
                                      sb_blacklist = NULL) {
  gene_len <- nchar(cds)
  n_codons <- gene_len %/% 3L

  if (is.null(min_mutable_nt)) {
    min_mutable_nt <- max(81L, max_mutable_nt %/% 3L)
    min_mutable_nt <- (min_mutable_nt %/% 3L) * 3L
  }
  if (is.null(oh_fidelity)) oh_fidelity <- load_overhang_fidelity("BsmBI")

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
      oh1_in_hf = oh1 %in% POTAPOV_TABLE1_SET3_25,
      oh2_in_hf = oh2 %in% POTAPOV_TABLE1_SET3_25,
      oh1_fidelity = unname(oh1_fid),
      oh2_fidelity = unname(oh2_fid),
      tile_seq = cds,
      boundary_shift = 0L,
      stringsAsFactors = FALSE
    ))
  }

  # Merge SB blacklist into oh2 blacklist (both prevent those overhangs at
  # tile boundaries). SB boundary overhangs must not appear as oh1 or oh2 at
  # any tile boundary, so we pass sb_blacklist as blacklisted_oh1 separately.
  combined_oh2_blacklist <- unique(c(blacklisted_oh2, sb_blacklist))
  if (length(combined_oh2_blacklist) == 0L) combined_oh2_blacklist <- NULL

  # Precompute scores for all boundary positions
  # Pass overlap_codons so oh2 is computed at the EXTENDED tile end
  precomp <- precompute_boundary_scores(cds, oh_fidelity,
    eff_lookup = eff_lookup,
    blacklisted_oh2 = combined_oh2_blacklist,
    blacklisted_oh1 = sb_blacklist,
    overlap_codons = overlap_codons
  )

  # Determine K range to search (use effective_max_codons for boundary spacing)
  K_ideal <- ceiling(n_codons / effective_max_codons) - 1L
  if (is.null(k_range)) {
    if (multi_k) {
      K_min <- max(1L, ceiling(n_codons / effective_max_codons) - 1L)
      K_max <- floor(n_codons / min_codons) - 1L
      k_range <- seq(
        max(K_min, K_ideal - dp_k_range),
        min(K_max, K_ideal + dp_k_range)
      )
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

  # Run DP for each K, track best (OPT-004: diminishing returns stopping)
  # When avg score improvement drops below 0.5% from K to K+1 AND K > K_ideal,
  # stop expanding upward — prefer fewer gene blocks when fidelity gain is marginal.
  best_result <- NULL
  best_avg_score <- -Inf
  k_results <- list()
  prev_avg <- -Inf
  diminishing_stop_pct <- 0.005 # 0.5% threshold

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
      # Diminishing returns check: only stop when K is above K_ideal
      # (we always want to explore smaller K values fully)
      if (K > K_ideal && is.finite(prev_avg) && prev_avg > 0) {
        improvement <- (avg - prev_avg) / prev_avg
        if (improvement < diminishing_stop_pct) {
          cli::cli_alert_info(sprintf(
            "Stopping K search at K=%d: avg score improvement %.2f%% < %.1f%% threshold",
            K, improvement * 100, diminishing_stop_pct * 100
          ))
          break
        }
      }
      prev_avg <- avg
    }
  }

  dp_elapsed <- (proc.time() - dp_start)[["elapsed"]]
  cli::cli_alert_info("DP tile boundary search completed in {round(dp_elapsed, 1)}s ({length(k_range)} K values).")

  if (is.null(best_result)) {
    cli::cli_alert_warning("DP found no valid solution; falling back to greedy search.")
    return(search_tile_boundaries(
      cds, max_mutable_nt, min_mutable_nt, oh_fidelity, eff_lookup
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
    tiles$oh1_in_hf[i] <- oh1 %in% POTAPOV_TABLE1_SET3_25
    tiles$oh2_in_hf[i] <- oh2 %in% POTAPOV_TABLE1_SET3_25
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

#' Search tile boundaries within a single superblock
#'
#' Wrapper around search_tile_boundaries_dp() for use in the two-pass
#' SB-first assembly planning. Operates on a subsequence of the gene
#' (one superblock's coding region).
#'
#' @param cds Full domesticated gene CDS (the SB's portion is extracted)
#' @param sb_start_nt 1-based start position of this SB in the gene (nt)
#' @param sb_end_nt 1-based end position of this SB in the gene (nt)
#' @param max_mutable_nt Max mutable region size from compute_max_tile_size()
#' @param sb_blacklist Character vector of ALL SB boundary overhangs to avoid
#'   at internal tile boundaries. Default NULL.
#' @param ... Additional arguments passed to search_tile_boundaries_dp()
#' @return Data frame of tiles (same format as search_tile_boundaries_dp),
#'   with start_codon/end_codon/start_nt/end_nt adjusted to gene-level
#'   coordinates.
search_tile_boundaries_within_sb <- function(cds, sb_start_nt, sb_end_nt,
                                             max_mutable_nt,
                                             sb_blacklist = NULL,
                                             ...) {
  # Extract the SB's portion of the gene
  sb_seq <- substring(cds, sb_start_nt, sb_end_nt)

  # Run tile DP on the subsequence, passing blacklist info
  tiles <- search_tile_boundaries_dp(
    cds = sb_seq,
    max_mutable_nt = max_mutable_nt,
    sb_blacklist = sb_blacklist,
    ...
  )

  # Adjust coordinates back to gene-level (SB subsequence starts at
  # sb_start_nt in the full gene, so offset all positions accordingly)
  offset_nt <- sb_start_nt - 1L
  offset_codons <- offset_nt %/% 3L
  tiles$start_codon <- tiles$start_codon + offset_codons
  tiles$end_codon <- tiles$end_codon + offset_codons
  tiles$start_nt <- tiles$start_nt + offset_nt
  tiles$end_nt <- tiles$end_nt + offset_nt

  tiles
}

# =============================================================================
# SUPERBLOCK BOUNDARY SEARCH (SB-FIRST DP)
# =============================================================================

#' Solve the SB boundary placement DP for a fixed number of boundaries K
#'
#' Finds the K boundary positions (in nucleotide coordinates) that maximize
#' total boundary overhang score, subject to segment length constraints.
#' This is the nucleotide-level analog of dp_solve_k (which works in codons).
#'
#' @param K Number of internal boundaries (superblocks = K + 1)
#' @param total_len Total sequence length in nucleotides
#' @param min_len Minimum segment length in nucleotides
#' @param max_len Maximum segment length in nucleotides
#' @param boundary_scores Numeric vector of scores per nucleotide position
#'   (length = total_len). Score at position p is for placing a boundary after
#'   nucleotide p (the overhang is derived from nts p-3..p).
#' @param boundary_valid Logical vector of valid positions (length = total_len)
#' @return List with boundaries (integer vector of nt positions) and total_score,
#'   or NULL if no feasible solution exists
sb_dp_solve_k <- function(K, total_len, min_len, max_len,
                          boundary_scores, boundary_valid) {
  if (K == 0L) {
    return(NULL)
  }

  # Early feasibility check: need at least (K+1)*min_len nucleotides
  if ((K + 1L) * min_len > total_len) {
    return(NULL)
  }

  # dp_prev[p] = best total score with previous boundary layer ending at nt p
  dp_prev <- rep(-Inf, total_len)
  # Parent pointers: parent[k, p] = optimal predecessor position for boundary k at p
  parent <- matrix(NA_integer_, nrow = K, ncol = total_len)

  # Layer k=1: first boundary, first segment spans [1..p]
  lo_p <- min_len
  hi_p <- min(max_len, total_len - 1L)
  if (lo_p <= hi_p) {
    for (p in lo_p:hi_p) {
      if (!boundary_valid[p]) next
      dp_prev[p] <- boundary_scores[p]
    }
  }

  # Layers k=2..K
  if (K >= 2L) {
    for (k in 2L:K) {
      dp_curr <- rep(-Inf, total_len)

      lo_p <- k * min_len
      hi_p <- min(total_len - 1L, total_len - min_len)
      if (lo_p > hi_p) {
        dp_prev <- dp_curr
        next
      }

      for (p in lo_p:hi_p) {
        if (!boundary_valid[p]) next

        # Predecessor range: p' must give segment size [min_len, max_len]
        lo <- max(1L, p - max_len)
        hi <- p - min_len
        if (hi < lo) next

        # Scan for best predecessor in [lo, hi]
        best_score <- -Inf
        best_pos <- NA_integer_
        for (pp in lo:hi) {
          if (dp_prev[pp] > best_score) {
            best_score <- dp_prev[pp]
            best_pos <- pp
          }
        }

        if (is.finite(best_score)) {
          dp_curr[p] <- best_score + boundary_scores[p]
          parent[k, p] <- best_pos
        }
      }

      dp_prev <- dp_curr
    }
  }

  # Find optimal last boundary: last segment must be [min_len, max_len]
  best_total <- -Inf
  best_p <- NA_integer_
  for (p in seq_len(total_len - 1L)) {
    last_seg <- total_len - p
    if (last_seg < min_len || last_seg > max_len) next
    if (dp_prev[p] > best_total) {
      best_total <- dp_prev[p]
      best_p <- p
    }
  }

  if (!is.finite(best_total)) {
    return(NULL)
  }

  # Backtrack to recover boundary positions
  boundaries <- integer(K)
  boundaries[K] <- best_p
  if (K >= 2L) {
    for (k in K:2L) {
      boundaries[k - 1L] <- parent[k, boundaries[k]]
    }
  }

  list(boundaries = boundaries, total_score = best_total)
}


#' Refine SB boundary positions to ensure unique overhangs
#'
#' Post-processing step after DP finds optimal boundary positions. Iterates
#' through boundaries left-to-right, and for each boundary whose overhang
#' collides with an already-committed boundary overhang, searches the valid
#' range for the best-scoring non-colliding alternative position.
#'
#' This is necessary because the DP maximizes total overhang score but has no
#' inter-boundary uniqueness constraint. Without refinement, all boundaries
#' can land on positions sharing the same high-scoring 4-mer (e.g., GAAA).
#'
#' @param boundary_positions Integer vector of K boundary nt positions from DP
#' @param full_seq Character: the full sequence (gene + cassette)
#' @param gene_len Integer: length of gene CDS portion (codon constraint)
#' @param min_block_length Integer: minimum segment size
#' @param max_block_length Integer: maximum segment size
#' @param blacklist_set Character vector of blacklisted overhangs (includes RCs)
#' @param fid_lookup Named numeric vector: overhang -> fidelity
#' @param eff_lookup Named numeric vector: overhang -> efficiency
#' @return List with refined boundary_positions (integer vector) and
#'   n_unresolved (count of remaining collisions, ideally 0)
refine_sb_boundaries_unique <- function(
  boundary_positions,
  full_seq,
  gene_len,
  min_block_length,
  max_block_length,
  blacklist_set,
  fid_lookup,
  eff_lookup
) {
  K <- length(boundary_positions)
  total_len <- nchar(full_seq)

  if (K <= 1L) {
    # Single boundary — no collisions possible
    return(list(boundary_positions = boundary_positions, n_unresolved = 0L))
  }

  # Check if refinement is even needed
  ohs <- vapply(boundary_positions, function(p) {
    substring(full_seq, p - 3L, p)
  }, character(1))

  has_collision <- FALSE
  for (i in 2L:K) {
    for (j in seq_len(i - 1L)) {
      if (oh_collides(ohs[i], ohs[j])) {
        has_collision <- TRUE
        break
      }
    }
    if (has_collision) break
  }

  if (!has_collision) {
    return(list(boundary_positions = boundary_positions, n_unresolved = 0L))
  }

  cli::cli_alert_info("Refining SB boundaries to resolve overhang collisions...")

  refined <- integer(K)
  # Track committed OHs as a set (both oh and RC)
  committed_ohs <- character(0)
  n_unresolved <- 0L

  for (i in seq_len(K)) {
    p <- boundary_positions[i]
    oh <- substring(full_seq, p - 3L, p)
    oh_rc <- reverse_complement(oh)

    # Check if this OH collides with any committed OH
    collides <- any(oh %in% committed_ohs) || any(oh_rc %in% committed_ohs)

    if (!collides) {
      # No collision — commit as-is
      refined[i] <- p
      committed_ohs <- c(committed_ohs, oh, oh_rc)
      next
    }

    # Collision detected — search for best alternative position in valid range
    # Compute valid range for this boundary based on neighbors
    prev_end <- if (i == 1L) 0L else refined[i - 1L]
    # Next boundary: original position (or end of sequence for last boundary)
    next_point <- if (i < K) boundary_positions[i + 1L] else total_len

    # Left segment [prev_end+1 .. refined[i]] must be in [min, max]
    lo <- prev_end + min_block_length
    hi <- prev_end + max_block_length

    # Right segment [refined[i]+1 .. next_point] must be in [min, max]
    lo <- max(lo, next_point - max_block_length)
    hi <- min(hi, next_point - min_block_length)

    # Global feasibility: enough room for remaining boundaries
    hi <- min(hi, total_len - (K - i) * min_block_length - min_block_length)

    # Need at least 4 nt for overhang extraction
    lo <- max(lo, 4L)
    if (lo > hi) {
      # No room to shift — keep original (collision remains)
      refined[i] <- p
      committed_ohs <- c(committed_ohs, oh, oh_rc)
      n_unresolved <- n_unresolved + 1L
      cli::cli_alert_warning(paste0(
        "SB boundary ", i, ": no room to shift (range [", lo, ",", hi,
        "]). Keeping colliding OH=", oh
      ))
      next
    }

    # Score all valid candidates in range, pick best non-colliding one
    best_alt_p <- NA_integer_
    best_alt_score <- -Inf

    for (cand in lo:hi) {
      # Codon constraint within gene portion
      if (cand <= gene_len && (cand %% 3L) != 0L) next

      cand_oh <- substring(full_seq, cand - 3L, cand)

      # Skip blacklisted or palindromic
      if (cand_oh %in% blacklist_set) next
      if (cand_oh %in% PALINDROMIC_4NT) next

      # Skip if collides with any committed OH
      cand_rc <- reverse_complement(cand_oh)
      if (any(cand_oh %in% committed_ohs) || any(cand_rc %in% committed_ohs)) next

      score <- overhang_score(cand_oh, fid_lookup, eff_lookup)
      if (score > best_alt_score) {
        best_alt_score <- score
        best_alt_p <- cand
      }
    }

    if (!is.na(best_alt_p)) {
      alt_oh <- substring(full_seq, best_alt_p - 3L, best_alt_p)
      alt_rc <- reverse_complement(alt_oh)
      refined[i] <- best_alt_p
      committed_ohs <- c(committed_ohs, alt_oh, alt_rc)
      if (best_alt_p != p) {
        cli::cli_alert_info(paste0(
          "SB boundary ", i, ": shifted ", p, " -> ", best_alt_p,
          " (OH: ", oh, " -> ", alt_oh,
          ", score: ", round(best_alt_score, 3), ")"
        ))
      }
    } else {
      # No non-colliding alternative found — keep original
      refined[i] <- p
      committed_ohs <- c(committed_ohs, oh, oh_rc)
      n_unresolved <- n_unresolved + 1L
      cli::cli_alert_warning(paste0(
        "SB boundary ", i, ": no non-colliding alternative in [", lo, ",", hi,
        "]. Keeping OH=", oh
      ))
    }
  }

  if (n_unresolved == 0L) {
    cli::cli_alert_success("All SB boundary collisions resolved by local refinement.")
  } else {
    cli::cli_alert_warning(paste0(
      n_unresolved, " SB boundary collision(s) could not be resolved."
    ))
  }

  list(boundary_positions = refined, n_unresolved = n_unresolved)
}


#' Search for optimal superblock boundaries using dynamic programming
#'
#' Pass 1 of the two-pass assembly planning refactor. Finds optimal positions
#' to split the full sequence (gene CDS + downstream cassette) into superblocks,
#' each within synthesis length limits, maximizing the overhang quality at
#' each split point.
#'
#' The DP operates on nucleotide positions (not codons), but prefers codon
#' boundaries within the gene portion. Positions in the cassette portion
#' (past gene_len) have no codon constraint.
#'
#' @param full_seq Character: gene CDS + downstream cassette concatenated
#' @param gene_len Integer: length of gene CDS portion only (for codon
#'   boundary preference). Set equal to nchar(full_seq) if no cassette.
#' @param max_block_length Integer: max synthesis length per superblock
#'   (default 1800, the Twist gene fragment limit)
#' @param min_block_length Integer: min synthesis length per superblock
#'   (default 300, the Twist gene fragment minimum)
#' @param blacklist_ohs Character vector: overhangs to avoid at SB boundaries
#'   (e.g., oh_L, oh3, oh4, palindromes, homopolymers). Both the overhang and
#'   its reverse complement are checked.
#' @param oh_fidelity Data frame with overhang + fidelity columns. If NULL,
#'   loads BsmBI default fidelity data.
#' @param eff_lookup Named numeric vector of overhang efficiencies (P_eff).
#'   If NULL, loads from BsmBI pairwise matrix.
#' @param allowed_gene_positions Integer vector of valid SB boundary positions
#'   within the gene portion (e.g., tile end_nt values). When provided, gene-
#'   region boundaries (p <= gene_len) are restricted to these positions only.
#'   Cassette-region positions (p > gene_len) remain unrestricted. Default NULL
#'   (any codon-aligned position is valid).
#' @return List with:
#'   \item{n_superblocks}{Integer count of superblocks}
#'   \item{boundaries}{Data frame with columns: sb_id, start_nt, end_nt,
#'     boundary_oh (4-nt overhang at 3' end of each non-final SB, NA for
#'     last SB), boundary_score (score at that boundary, NA for last SB)}
#'   \item{total_score}{Sum of boundary scores (0 if no splits needed)}
search_superblock_boundaries_dp <- function(
  full_seq,
  gene_len,
  max_block_length = 1800L,
  min_block_length = 300L,
  blacklist_ohs = character(0),
  cassette_blacklist_ohs = character(0),
  oh_fidelity = NULL,
  eff_lookup = NULL,
  allowed_gene_positions = NULL
) {
  total_len <- nchar(full_seq)

  # --- Input validation ---
  stopifnot(is.character(full_seq), length(full_seq) == 1, total_len > 0)
  stopifnot(is.numeric(gene_len), gene_len >= 1, gene_len <= total_len)
  stopifnot(max_block_length > min_block_length)

  # --- Load fidelity/efficiency data if not provided ---
  if (is.null(oh_fidelity)) oh_fidelity <- load_overhang_fidelity("BsmBI")
  if (is.null(eff_lookup)) {
    bsmbi_pw <- load_pairwise_matrix("BsmBI")
    eff_lookup <- compute_overhang_efficiency(bsmbi_pw)
  }

  # Build fidelity lookup
  fid_lookup <- oh_fidelity$fidelity
  names(fid_lookup) <- oh_fidelity$overhang

  # --- Edge case: sequence fits in a single block ---
  if (total_len <= max_block_length) {
    cli::cli_alert_info(
      "Sequence length ({total_len} bp) <= max_block_length ({max_block_length} bp). No SB split needed."
    )
    return(list(
      n_superblocks = 1L,
      boundaries = data.frame(
        sb_id = 1L,
        start_nt = 1L,
        end_nt = total_len,
        boundary_oh = NA_character_,
        boundary_score = NA_real_,
        stringsAsFactors = FALSE
      ),
      total_score = 0
    ))
  }

  # --- Build blacklist set (include reverse complements) ---
  blacklist_set <- unique(c(
    blacklist_ohs,
    vapply(blacklist_ohs, reverse_complement, character(1))
  ))

  # --- Build cassette-specific blacklist set ---
  # These overhangs are additionally excluded for positions in the cassette

  # region (p > gene_len). Cassette junction OHs participate in every tile's
  # BsmBI reaction, so they must not collide with any tile oh1/oh2.
  cassette_blacklist_set <- if (length(cassette_blacklist_ohs) > 0) {
    unique(c(
      cassette_blacklist_ohs,
      vapply(cassette_blacklist_ohs, reverse_complement, character(1))
    ))
  } else {
    character(0)
  }

  # --- Build allowed gene positions set for O(1) lookup ---
  # When allowed_gene_positions is provided, gene-region boundaries are
  # restricted to these positions (e.g., tile end positions). Cassette-region
  # positions (p > gene_len) remain unrestricted.
  allowed_gene_pos_set <- NULL
  if (!is.null(allowed_gene_positions)) {
    allowed_gene_pos_set <- as.integer(allowed_gene_positions)
  }

  # --- Precompute boundary scores for every nucleotide position ---
  # At position p, the overhang is the 4 nt ending at p: substring(full_seq, p-3, p)
  # Positions 1-3 can't form a 4-nt overhang, so they're invalid.
  boundary_scores <- rep(-Inf, total_len)
  boundary_valid <- rep(FALSE, total_len)

  cli::cli_alert_info("Precomputing SB boundary scores for {total_len} positions...")

  for (p in 4L:total_len) {
    # Extract the 4-nt overhang at this position
    oh <- substring(full_seq, p - 3L, p)

    # Skip if overhang is blacklisted (or its RC is blacklisted)
    if (oh %in% blacklist_set) next

    # For cassette-region positions, also check the cassette-specific blacklist
    # (tile oh1/oh2 values that would collide in every tile's BsmBI reaction)
    if (p > gene_len && length(cassette_blacklist_set) > 0 &&
      oh %in% cassette_blacklist_set) {
      next
    }

    # Skip palindromic overhangs — these cause self-ligation issues in GG
    if (oh %in% PALINDROMIC_4NT) next

    # Compute overhang score: P_fid * P_eff
    score <- overhang_score(oh, fid_lookup, eff_lookup)

    # Within the gene portion, apply constraints:
    # 1. Codon boundary: p must be divisible by 3 (never split a codon)
    # 2. Tile boundary (if allowed_gene_positions provided): p must be in the
    #    allowed set (restricts SB boundaries to tile end positions)
    # Positions in the cassette portion (p > gene_len) have no constraint.
    if (p <= gene_len) {
      if ((p %% 3L) != 0L) next
      if (!is.null(allowed_gene_pos_set) && !(p %in% allowed_gene_pos_set)) next
    }

    boundary_scores[p] <- score
    boundary_valid[p] <- TRUE
  }

  n_valid <- sum(boundary_valid)
  cli::cli_alert_info("{n_valid} valid SB boundary candidates out of {total_len} positions.")

  if (n_valid == 0L) {
    cli::cli_alert_warning(
      "No valid SB boundary positions found! All overhangs blacklisted or palindromic."
    )
    # Return single SB even though it exceeds max_block_length
    return(list(
      n_superblocks = 1L,
      boundaries = data.frame(
        sb_id = 1L,
        start_nt = 1L,
        end_nt = total_len,
        boundary_oh = NA_character_,
        boundary_score = NA_real_,
        stringsAsFactors = FALSE
      ),
      total_score = 0
    ))
  }

  # --- Determine K range ---
  # K = number of internal boundaries (superblocks = K + 1)
  K_min <- ceiling(total_len / max_block_length) - 1L
  K_min <- max(1L, K_min) # At least 1 boundary needed (we already handled single-block case)

  # Search K_min to K_min + 2 (narrow range — SB count is tightly constrained)
  K_max <- K_min + 2L
  # Upper bound: can't have more boundaries than segments of min_block_length
  K_upper <- floor(total_len / min_block_length) - 1L
  K_max <- min(K_max, K_upper)
  k_range <- seq(K_min, K_max)

  cli::cli_alert_info(
    "SB boundary DP: {total_len} bp, K range [{K_min}, {K_max}]"
  )

  # --- Run DP for each K, track best ---
  best_result <- NULL
  best_avg_score <- -Inf
  k_results <- list()
  prev_avg <- -Inf
  diminishing_stop_pct <- 0.005 # 0.5% threshold

  dp_start <- proc.time()
  for (K in k_range) {
    result <- sb_dp_solve_k(
      K, total_len, min_block_length, max_block_length,
      boundary_scores, boundary_valid
    )
    if (!is.null(result)) {
      avg <- result$total_score / K
      k_results[[as.character(K)]] <- list(K = K, score = result$total_score, avg = avg)
      if (avg > best_avg_score) {
        best_avg_score <- avg
        best_result <- result
        best_result$K <- K
      }
      # Diminishing returns stopping (same pattern as tile DP)
      if (K > K_min && is.finite(prev_avg) && prev_avg > 0) {
        improvement <- (avg - prev_avg) / prev_avg
        if (improvement < diminishing_stop_pct) {
          cli::cli_alert_info(sprintf(
            "Stopping SB K search at K=%d: avg score improvement %.2f%% < %.1f%% threshold",
            K, improvement * 100, diminishing_stop_pct * 100
          ))
          break
        }
      }
      prev_avg <- avg
    }
  }

  dp_elapsed <- (proc.time() - dp_start)[["elapsed"]]
  cli::cli_alert_info(
    "SB boundary DP completed in {round(dp_elapsed, 1)}s ({length(k_range)} K values)."
  )

  if (is.null(best_result)) {
    # Defensive fallback: retry with soft penalty instead of hard constraint.
    # This should never trigger in practice — with ~600 codon-aligned positions
    # per 1800 bp and ~14% exclusion rate, there are always enough candidates.
    cli::cli_alert_warning(
      "SB DP found no valid solution with hard codon constraint. Retrying with soft penalty (-0.5)."
    )
    boundary_scores_soft <- rep(-Inf, total_len)
    boundary_valid_soft <- rep(FALSE, total_len)
    for (p in 4L:total_len) {
      oh <- substring(full_seq, p - 3L, p)
      if (oh %in% blacklist_set) next
      if (oh %in% PALINDROMIC_4NT) next
      score <- overhang_score(oh, fid_lookup, eff_lookup)
      codon_penalty <- 0.0
      if (p <= gene_len) {
        if ((p %% 3L) != 0L) {
          codon_penalty <- -0.5
        }
        # In soft fallback, still enforce tile-boundary constraint (these
        # positions are the only ones that produce valid SB partitions)
        if (!is.null(allowed_gene_pos_set) && !(p %in% allowed_gene_pos_set)) next
      }
      boundary_scores_soft[p] <- score + codon_penalty
      boundary_valid_soft[p] <- TRUE
    }
    for (K in k_range) {
      result <- sb_dp_solve_k(
        K, total_len, min_block_length, max_block_length,
        boundary_scores_soft, boundary_valid_soft
      )
      if (!is.null(result)) {
        avg <- result$total_score / K
        if (is.null(best_result) || avg > best_avg_score) {
          best_avg_score <- avg
          best_result <- result
          best_result$K <- K
        }
      }
    }
  }

  if (is.null(best_result)) {
    cli::cli_alert_warning(
      "SB DP found no valid solution even with soft penalty; returning single oversized superblock."
    )
    return(list(
      n_superblocks = 1L,
      boundaries = data.frame(
        sb_id = 1L,
        start_nt = 1L,
        end_nt = total_len,
        boundary_oh = NA_character_,
        boundary_score = NA_real_,
        stringsAsFactors = FALSE
      ),
      total_score = 0
    ))
  }

  # Log multi-K comparison
  if (length(k_results) > 1) {
    k_summary <- vapply(k_results, function(r) {
      sprintf("K=%d score=%.3f", r$K, r$score)
    }, character(1))
    cli::cli_alert_info(paste0(
      "SB multi-K: ", paste(k_summary, collapse = ", "),
      " | best K=", best_result$K
    ))
  }

  # --- Build output boundaries data frame ---
  K <- best_result$K
  n_superblocks <- K + 1L
  boundary_positions <- best_result$boundaries # nt positions

  # Build SB table: each SB spans from previous boundary+1 to current boundary
  sb_df <- data.frame(
    sb_id = integer(n_superblocks),
    start_nt = integer(n_superblocks),
    end_nt = integer(n_superblocks),
    boundary_oh = character(n_superblocks),
    boundary_score = numeric(n_superblocks),
    stringsAsFactors = FALSE
  )

  for (i in seq_len(n_superblocks)) {
    sb_df$sb_id[i] <- i

    if (i == 1L) {
      sb_df$start_nt[i] <- 1L
    } else {
      sb_df$end_nt[i - 1L] <- boundary_positions[i - 1L]
      sb_df$start_nt[i] <- boundary_positions[i - 1L] + 1L
    }

    if (i == n_superblocks) {
      sb_df$end_nt[i] <- total_len
      sb_df$boundary_oh[i] <- NA_character_
      sb_df$boundary_score[i] <- NA_real_
    } else {
      sb_df$end_nt[i] <- boundary_positions[i]
      oh <- substring(full_seq, boundary_positions[i] - 3L, boundary_positions[i])
      sb_df$boundary_oh[i] <- oh
      sb_df$boundary_score[i] <- overhang_score(oh, fid_lookup, eff_lookup)
    }
  }

  # Verify segment sizes
  for (i in seq_len(n_superblocks)) {
    seg_len <- sb_df$end_nt[i] - sb_df$start_nt[i] + 1L
    if (seg_len > max_block_length) {
      cli::cli_alert_warning(
        "SB {i} is {seg_len} bp, exceeding max_block_length ({max_block_length})."
      )
    }
  }

  cli::cli_alert_success(
    "SB boundary search: {n_superblocks} superblocks, {K} boundaries, total score = {round(best_result$total_score, 4)}"
  )

  list(
    n_superblocks = n_superblocks,
    boundaries = sb_df,
    total_score = best_result$total_score
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
# GLOBAL SUPERBLOCK BOUNDARY OPTIMIZATION
# =============================================================================

#' DP-optimize superblock split positions within a gene region
#'
#' Finds the set of split positions maximizing total junction score,
#' using exactly K splits (where K = minimum splits needed for all sub-blocks
#' to fit within max_sub_length). Uses a layered DP analogous to dp_solve_k()
#' for tile boundaries.
#'
#' Scoring per candidate: score(p) = P_fid(oh) * P_eff(oh) (BsmBI cycling)
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
                                       exclude_ohs, oh_fidelity,
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

    in_hf <- oh %in% POTAPOV_TABLE1_SET3_25
    fid <- if (oh %in% names(fid_lookup)) unname(fid_lookup[oh]) else 0.5
    cand_in_hf[ci] <- in_hf
    cand_fid[ci] <- fid
    cand_score[ci] <- overhang_score(oh, fid_lookup, eff_lookup)

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
#' This eliminates BUG-005 by using per-tile overhang exclusion instead of
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
#'   oh3 collision detection.
#' @param oh4 Optional oh4 overhang for collision checking. NULL skips
#'   oh4 collision detection. When provided, SB boundary overhangs are
#'   also checked against oh4 (BsaI-level collision).
#' @param oh_fidelity Optional fidelity data frame (reserved for future use)
#' @return List with:
#'   \item{n_superblocks}{Integer, number of superblocks}
#'   \item{superblocks}{Data frame: sb_id, start_tile, end_tile, gene_content}
#'   \item{n_collisions}{Integer, number of unresolved overhang collisions
#'     (0 = clean partition)}
#'   \item{block_count}{List with tile_blocks and full_sb_blocks counts}
partition_tile_superblocks <- function(tiles, gene_len, polIII_len,
                                       max_sub_length,
                                       oh3 = NULL,
                                       oh4 = NULL,
                                       oh_fidelity = NULL) {
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
  # Phases 1+2: Backwards-sweep cassette-aware partitioning
  # =========================================================================
  # The last SB must accommodate both gene content AND the downstream cassette
  # (polIII_len) within max_sub_length. The old approach (forward greedy +
  # Phase 2 fixup) created unbalanced partitions — e.g., a 1-tile SB4 in
  # AKAP11 when the cassette forced Phase 2 to split the last greedy SB.
  #
  # New algorithm:
  #   Step 1 (backwards): Walk from the last tile backwards, accumulating
  #          tiles into the last SB until gene_content + polIII_len would
  #          exceed max_sub_length. This naturally sizes the last SB to fit
  #          the cassette with maximum tile count.
  #   Step 2 (forward greedy): Partition the remaining tiles (gene-only,
  #          no cassette overhead) using the standard forward greedy.
  #
  # When cassette_needs_splitting is TRUE (cassette alone > max_sub_length),
  # the cassette will be split into separate BsmBI fragments downstream
  # by find_cassette_split_points(). In that case, skip the backwards step
  # and partition the entire gene with forward greedy (no cassette budget).

  sb_end_tiles <- integer(0)

  if (polIII_len > 0L && !cassette_needs_splitting) {
    # --- Step 1: Backwards sweep to find last SB ---
    # Walk from last tile backwards. The last SB's total budget is
    # gene_content + cassette <= max_sub_length, where gene_content =
    # gene_len - left_boundary_nt.
    last_sb_first_tile <- n_tiles # start with just the last tile
    for (t in rev(seq_len(n_tiles))) {
      # If this tile starts the last SB, gene_content = gene_len - gene_start
      gene_start <- if (t == 1L) 0L else tiles$end_nt[t - 1L]
      gene_content_candidate <- gene_len - gene_start
      if (gene_content_candidate + polIII_len <= max_sub_length) {
        last_sb_first_tile <- t
      } else {
        break # adding more tiles would overflow
      }
    }

    # --- Step 2: Forward greedy on tiles 1..(last_sb_first_tile - 1) ---
    if (last_sb_first_tile > 1L) {
      prefix_end <- last_sb_first_tile - 1L
      prev_boundary_nt <- 0L
      current_start_tile <- 1L
      for (i in seq_len(prefix_end)) {
        content <- tiles$end_nt[i] - prev_boundary_nt
        if (content > max_sub_length && i > current_start_tile) {
          sb_end_tiles <- c(sb_end_tiles, i - 1L)
          prev_boundary_nt <- tiles$end_nt[i - 1L]
          current_start_tile <- i
        }
      }
      # Close the prefix SB
      sb_end_tiles <- c(sb_end_tiles, prefix_end)
    }
    # Close the last (cassette-carrying) SB
    sb_end_tiles <- c(sb_end_tiles, n_tiles)
  } else {
    # No cassette budget, or cassette will be split separately.
    # Pure forward greedy on all tiles.
    if (cassette_needs_splitting) {
      cli::cli_alert_info(paste0(
        "Cassette will be split into separate fragments — ",
        "partitioning gene-only (no cassette budget in last SB)."
      ))
    }
    prev_boundary_nt <- 0L
    current_start_tile <- 1L
    for (i in seq_len(n_tiles)) {
      content <- tiles$end_nt[i] - prev_boundary_nt
      if (content > max_sub_length && i > current_start_tile) {
        sb_end_tiles <- c(sb_end_tiles, i - 1L)
        prev_boundary_nt <- tiles$end_nt[i - 1L]
        current_start_tile <- i
      }
    }
    sb_end_tiles <- c(sb_end_tiles, n_tiles)
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
  # SB boundary overhangs must not collide with oh3, oh4, each other, or
  # tile oh1_seq values in later superblocks (BUG-007: BsaI-level collision).
  # If a collision is detected, try shifting the boundary ±1 tile.
  n_collisions <- 0L

  if (n_sb >= 2L) {
    for (bi in seq_len(n_sb - 1L)) {
      boundary_tile <- sb_end_tiles[bi]
      boundary_oh <- tiles$oh2_seq[boundary_tile]

      # --- Check for collision ---
      has_collision <- FALSE

      # vs oh3 (BsmBI-level)
      if (!is.null(oh3) && oh_collides(boundary_oh, oh3)) {
        has_collision <- TRUE
      }

      # vs other SB boundary OHs (BsmBI-level)
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

      # vs tile oh1_seq in later superblocks (BsaI-level — BUG-007)
      # The SB boundary OH becomes a BsaI junction overhang for tiles whose
      # 5'WT region spans past this boundary. If it matches a tile's oh1_seq,
      # the BsaI reaction has ambiguous ligation (two frags with same oh_5).
      if (!has_collision) {
        boundary_pos <- tiles$end_nt[boundary_tile]
        for (t in seq_len(n_tiles)) {
          if (tiles$start_nt[t] > boundary_pos &&
            oh_collides(boundary_oh, tiles$oh1_seq[t])) {
            has_collision <- TRUE
            break
          }
        }
      }

      # vs oh4 (BsaI-level — helper-to-oligo junction)
      if (!has_collision && !is.null(oh4)) {
        if (oh_collides(boundary_oh, oh4)) {
          has_collision <- TRUE
        }
      }

      # vs tile oh2_seq in earlier superblocks (BsmBI-level)
      # The SB boundary OH becomes a BsmBI junction overhang for tiles whose
      # 3'WT region spans past this boundary. If it matches a tile's oh2_seq,
      # the BsmBI reaction has ambiguous ligation (two frags with same oh).
      # This catches the TGAT-type collision: boundary tile B has oh2=X, and
      # an earlier tile T also has oh2=X; T's 3'WT region includes B's
      # position, so both X values appear in T's BsmBI reaction.
      if (!has_collision) {
        boundary_pos <- tiles$end_nt[boundary_tile]
        for (t in seq_len(n_tiles)) {
          if (t == boundary_tile) next
          if (tiles$end_nt[t] < boundary_pos &&
            oh_collides(boundary_oh, tiles$oh2_seq[t])) {
            has_collision <- TRUE
            break
          }
        }
      }

      if (!has_collision) next

      n_collisions <- n_collisions + 1L
      cli::cli_alert_warning(sprintf(
        "SB boundary %d (tile %d, oh2=%s): collision detected.",
        bi, boundary_tile, boundary_oh
      ))
      # Note: Collision resolution is handled by the iterative DP loop in
      # plan_assembly() (OPT-005). The old ±5 tile shift heuristic has been
      # removed — it had zero guarantees and failed on AKAP11's ACCA collision.
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
  cassette_splits <- data.frame(
    split_pos = integer(0), junction_oh = character(0),
    stringsAsFactors = FALSE
  )
  for (i in seq_len(n_sb_total - 1L)) {
    if (sb_df$end_nt[i] > gene_len && !is.na(sb_df$boundary_oh[i])) {
      cassette_splits <- rbind(cassette_splits, data.frame(
        split_pos = sb_df$end_nt[i] - gene_len,
        junction_oh = sb_df$boundary_oh[i],
        stringsAsFactors = FALSE
      ))
    }
  }

  # Determine if cassette needs splitting
  max_sub_content <- max_block_length - block_overhead
  cassette_needs_splitting <- polIII_len > max_sub_content

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

  is_oogga <- boundary_method %in% c("oogga_two_pass", "oogga_greedy", "oogga_single")

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
    # Collision prevention is built into the DP transition — no iterative
    # blacklisting needed. The DP rejects candidates with >max_identity/4
    # positional matches against all prior overhangs on the path.
    cli::cli_h3(paste0(
      "Phase 2+3: OOGGA collision-aware boundary selection (",
      boundary_method, ")"
    ))

    if (boundary_method == "oogga_single") {
      # A3: Single-pass OOGGA on entire gene+cassette
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
        dp_k_range = dp_k_range,
        overlap_codons = overlap_codons
      )
      tiles <- single_result$tiles
      sb_result <- single_result$sb_result
    } else {
      # A1/A2: SB-first OOGGA DP → tile boundary search
      # Step 1: Tile boundaries (collision-aware)
      if (boundary_method == "oogga_two_pass") {
        cli::cli_alert_info("Using OOGGA two-pass DP (tile DP)")
        tiles <- search_tile_boundaries_oogga(
          cds = cds,
          max_mutable_nt = max_mutable_nt,
          min_mutable_nt = min_mutable_nt,
          oh_fidelity = oh_fidelity,
          multi_k = multi_k,
          dp_k_range = dp_k_range,
          overlap_codons = overlap_codons,
          eff_lookup = eff_lookup,
          alien_ohs = alien_ohs,
          max_identity = oogga_max_identity
        )
      } else {
        # oogga_greedy
        cli::cli_alert_info("Using OOGGA greedy sequential tile search")
        tiles <- search_tile_boundaries_greedy_seq(
          cds = cds,
          max_mutable_nt = max_mutable_nt,
          min_mutable_nt = min_mutable_nt,
          oh_fidelity = oh_fidelity,
          overlap_codons = overlap_codons,
          eff_lookup = eff_lookup,
          alien_ohs = alien_ohs,
          max_identity = oogga_max_identity
        )
      }

      # Step 2: SB partitioning (collision-aware OOGGA SB DP)
      n_tiles <- nrow(tiles)
      full_seq_for_sb <- paste0(cds, cassette_seq)
      total_content_len <- nchar(full_seq_for_sb)

      if (total_content_len <= (max_block_length - block_overhead)) {
        sb_result <- list(
          n_superblocks = 1L,
          boundaries = data.frame(
            sb_id = 1L, start_nt = 1L, end_nt = total_content_len,
            boundary_oh = NA_character_, boundary_score = NA_real_,
            stringsAsFactors = FALSE
          ),
          total_score = 0
        )
      } else {
        tile_end_positions <- tiles$end_nt[-n_tiles]
        # SB alien OHs: all tile oh1/oh2 + fixed overhangs
        sb_alien <- unique(c(
          alien_ohs, tiles$oh1_seq, tiles$oh2_seq,
          vapply(tiles$oh1_seq, reverse_complement, character(1)),
          vapply(tiles$oh2_seq, reverse_complement, character(1))
        ))
        cassette_oh_blacklist <- unique(c(
          tiles$oh1_seq, tiles$oh2_seq,
          vapply(tiles$oh1_seq, reverse_complement, character(1)),
          vapply(tiles$oh2_seq, reverse_complement, character(1))
        ))

        sb_result <- search_sb_boundaries_oogga(
          full_seq = full_seq_for_sb,
          gene_len = gene_len,
          max_block_length = max_block_length - block_overhead,
          min_block_length = min_geneblock_length,
          alien_ohs = alien_ohs,
          oh_fidelity = oh_fidelity,
          eff_lookup = eff_lookup,
          max_identity = oogga_max_identity,
          allowed_gene_positions = tile_end_positions,
          cassette_blacklist_ohs = cassette_oh_blacklist
        )
      }
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
        "Constrained SB DP: ", partition_result$n_superblocks,
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
  } # end legacy (non-OOGGA) path

  # Convert partition to legacy all_splits format for downstream consumers
  # (OOGGA path also needs this — moved outside the if/else)
  all_splits <- convert_partition_to_splits(
    partition_result = partition_result,
    tiles = tiles,
    gene_len = gene_len,
    polIII_len = polIII_len
  )

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

#' Select additional overhangs for superblock junctions
#'
#' Picks n_additional high-fidelity, mutually orthogonal overhangs that don't
#' collide with any already-used overhangs (or their reverse complements).
#' Uses BsmBI cycling fidelity data (Pryor et al. 2020) for ranking.
#'
#' @param existing_overhangs Already-used overhangs to exclude
#' @param n_additional Number of new overhangs needed
#' @return Character vector of additional overhangs
select_superblock_overhangs <- function(existing_overhangs,
                                        n_additional) {
  if (n_additional == 0) {
    return(character(0))
  }

  # Use BsmBI cycling data (default) — sorted by fidelity descending so
  # select_orthogonal_set picks the best available overhangs
  oh_data <- load_overhang_fidelity("BsmBI")
  oh_data <- oh_data[order(oh_data$fidelity, decreasing = TRUE), ]
  candidates <- oh_data$overhang

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
