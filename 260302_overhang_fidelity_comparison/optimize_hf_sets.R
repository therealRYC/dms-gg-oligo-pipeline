# Created: 2026-03-02
# Last updated: 2026-03-02 — Initial implementation

# =============================================================================
# Optimize high-fidelity overhang sets via simulated annealing
# =============================================================================
#
# For each of 3 experimental datasets, find the optimal 25-overhang set
# that maximizes context-dependent set fidelity using simulated annealing
# (same approach as Potapov/NEB GetSet tool).
#
# Set fidelity formula:
#   F(S) = prod_i [ M[i, RC(i)] / sum_j_in_S( M[i, RC(j)] ) ]
#
# Computed in log space for numerical stability:
#   log F(S) = sum_i [ log M[i, RC(i)] - log sum_j_in_S( M[i, RC(j)] ) ]
#
# SA parameters:
#   T_start = 1.0, alpha = 0.9999, 100K iterations, 10 runs per dataset
#
# Constraints:
#   - No homopolymers (AAAA, CCCC, GGGG, TTTT)
#   - No reverse-complement pairs in the same set
#
# Usage: Rscript optimize_hf_sets.R
# =============================================================================

library(data.table)

# ---------------------------------------------------------------------------
# Paths
# ---------------------------------------------------------------------------
SCRIPT_DIR <- tryCatch(
  {
    args <- commandArgs(trailingOnly = FALSE)
    file_arg <- args[grep("^--file=", args)]
    dirname(normalizePath(sub("^--file=", "", file_arg)))
  },
  error = function(e) "."
)

if (length(SCRIPT_DIR) == 0 || is.na(SCRIPT_DIR)) {
  SCRIPT_DIR <- "."
}

DATA_DIR <- file.path(SCRIPT_DIR, "data")
OUTPUT_DIR <- file.path(SCRIPT_DIR, "output")
dir.create(OUTPUT_DIR, showWarnings = FALSE, recursive = TRUE)

# ---------------------------------------------------------------------------
# SA parameters
# ---------------------------------------------------------------------------
SET_SIZE <- 25L # Target set size (matches Potapov Table 1)
T_START <- 1.0 # Starting temperature
ALPHA <- 0.9999 # Cooling rate
N_ITER <- 100000L # Iterations per run
N_RUNS <- 10L # Independent runs per dataset
BASE_SEED <- 42L # Base random seed for reproducibility

# Homopolymers to exclude
HOMOPOLYMERS <- c("AAAA", "CCCC", "GGGG", "TTTT")

# ---------------------------------------------------------------------------
# Helper functions
# ---------------------------------------------------------------------------

#' Compute reverse complement of a DNA sequence.
#'
#' @param seq Character string of DNA bases.
#' @return Reverse complement string.
reverse_complement <- function(seq) {
  comp <- chartr("ACGT", "TGCA", seq)
  paste0(rev(strsplit(comp, "")[[1]]), collapse = "")
}

rc_vec <- function(seqs) {
  vapply(seqs, reverse_complement, character(1), USE.NAMES = FALSE)
}

#' Load a 256x256 ligation fidelity matrix from CSV.
#'
#' @param csv_path Path to the CSV file.
#' @return Named numeric matrix.
load_matrix <- function(csv_path) {
  df <- data.table::fread(csv_path, header = TRUE)
  row_names <- df[[1]]
  mat <- as.matrix(df[, -1, with = FALSE])
  rownames(mat) <- row_names
  mat
}


#' Get overhangs eligible for HF set membership.
#'
#' Excludes homopolymers. Palindromes are kept as single entries since
#' they are their own RC. RC-pair conflicts handled during SA.
#'
#' @param mat Named 256x256 fidelity matrix.
#' @return Character vector of eligible overhangs.
get_eligible_overhangs <- function(mat) {
  all_oh <- rownames(mat)

  # Remove homopolymers
  eligible <- setdiff(all_oh, HOMOPOLYMERS)

  # For each RC pair, keep only the lexicographically smaller one
  # This prevents both X and RC(X) from being in the candidate pool
  # (we'll handle RC-pair conflicts during SA)
  eligible
}


#' Compute log set fidelity for a set of overhangs.
#'
#' log F(S) = sum_i [ log M[i, RC(i)] - log sum_{j in S} M[i, RC(j)] ]
#'
#' @param mat Named 256x256 fidelity matrix.
#' @param set_oh Character vector of overhangs in the set.
#' @return Log set fidelity (scalar). Returns -Inf if any correct count is 0.
compute_log_set_fidelity <- function(mat, set_oh) {
  # The full set of column targets: RC of each set member
  # In a GG reaction, overhang X ligates to RC(X). The matrix M[X, Y]
  # gives the count of X ligating to Y. So for a set S, overhang X
  # competes with all j in S for binding to RC(j) columns.
  rc_set <- rc_vec(set_oh)
  all_targets <- unique(c(set_oh, rc_set))

  log_fid <- 0
  for (i in seq_along(set_oh)) {
    oh <- set_oh[i]
    rc_oh <- rc_set[i]

    correct <- mat[oh, rc_oh]
    if (correct <= 0) {
      return(-Inf)
    }

    # Sum of all cross-ligations: M[oh, RC(j)] for all j in set
    # RC(j) values are the columns where oh could ligate
    cross_sum <- sum(mat[oh, rc_set])
    if (cross_sum <= 0) {
      return(-Inf)
    }

    log_fid <- log_fid + log(correct) - log(cross_sum)
  }

  log_fid
}


#' Check if adding new_oh would create a reverse-complement pair.
#'
#' @param set_oh Current set of overhangs.
#' @param new_oh Candidate overhang to add.
#' @return TRUE if RC(new_oh) is already in set_oh.
has_rc_conflict <- function(set_oh, new_oh) {
  rc_new <- reverse_complement(new_oh)
  # Palindromes are their own RC — they can appear once but not twice
  # (which is already prevented by set membership)
  rc_new %in% set_oh
}


#' Run one simulated annealing optimization for a 25-overhang HF set.
#'
#' @param mat Named 256x256 fidelity matrix.
#' @param eligible Character vector of all eligible overhangs.
#' @param seed Random seed for reproducibility.
#' @return List: best_set, best_log_fid, best_fid, accept_rate.
run_sa <- function(mat, eligible, seed) {
  set.seed(seed)

  # Initialize: random 25-overhang set without RC conflicts
  current_set <- character(0)
  pool <- sample(eligible) # Shuffle eligible overhangs

  for (oh in pool) {
    if (length(current_set) >= SET_SIZE) break
    if (!has_rc_conflict(current_set, oh)) {
      current_set <- c(current_set, oh)
    }
  }

  if (length(current_set) < SET_SIZE) {
    stop(
      "Could not initialize a valid set of size ", SET_SIZE,
      " from ", length(eligible), " eligible overhangs"
    )
  }

  current_log_fid <- compute_log_set_fidelity(mat, current_set)
  best_set <- current_set
  best_log_fid <- current_log_fid
  n_accepted <- 0L

  # Pre-compute the non-set pool (eligible overhangs not in current set)
  non_set <- setdiff(eligible, current_set)
  # Also remove RCs of current set from non_set
  rc_current <- rc_vec(current_set)
  non_set <- setdiff(non_set, rc_current)

  temp <- T_START

  for (iter in seq_len(N_ITER)) {
    # Propose: swap one random set member for a random non-member
    swap_out_idx <- sample.int(SET_SIZE, 1L)
    swap_out <- current_set[swap_out_idx]

    # Temporarily remove swap_out and its RC exclusion
    candidate_pool <- c(non_set, reverse_complement(swap_out))
    # Don't add swap_out itself back (it's being removed)
    # Also filter out any that would create RC conflicts with remaining set
    remaining_set <- current_set[-swap_out_idx]

    # Pick a random candidate that doesn't conflict
    # For efficiency, just try a few random picks
    swap_in <- NULL
    attempts <- sample(candidate_pool)
    for (cand in attempts) {
      if (!has_rc_conflict(remaining_set, cand)) {
        swap_in <- cand
        break
      }
    }
    if (is.null(swap_in)) next # Skip if no valid swap found

    # Build proposed set
    proposed_set <- c(remaining_set, swap_in)
    proposed_log_fid <- compute_log_set_fidelity(mat, proposed_set)

    # Metropolis acceptance
    delta <- proposed_log_fid - current_log_fid
    if (delta > 0 || runif(1) < exp(delta / temp)) {
      # Accept
      # Update non_set: add swap_out and its RC, remove swap_in and its RC
      non_set <- setdiff(non_set, swap_in)
      non_set <- setdiff(non_set, reverse_complement(swap_in))
      non_set <- c(non_set, swap_out)
      rc_swap_out <- reverse_complement(swap_out)
      if (rc_swap_out != swap_out && !(rc_swap_out %in% proposed_set)) {
        non_set <- c(non_set, rc_swap_out)
      }

      current_set <- proposed_set
      current_log_fid <- proposed_log_fid
      n_accepted <- n_accepted + 1L

      if (current_log_fid > best_log_fid) {
        best_set <- current_set
        best_log_fid <- current_log_fid
      }
    }

    temp <- temp * ALPHA
  }

  list(
    best_set      = sort(best_set),
    best_log_fid  = best_log_fid,
    best_fid      = exp(best_log_fid),
    accept_rate   = n_accepted / N_ITER
  )
}


#' Run SA optimization for a single dataset (N_RUNS independent runs).
#'
#' @param mat Named 256x256 fidelity matrix.
#' @param dataset_name Human-readable dataset name for logging.
#' @return List: best_run (best result), all_runs (all results).
optimize_dataset <- function(mat, dataset_name) {
  eligible <- get_eligible_overhangs(mat)
  cat(sprintf(
    "\nOptimizing %s (%d eligible overhangs, %d runs)...\n",
    dataset_name, length(eligible), N_RUNS
  ))

  all_runs <- vector("list", N_RUNS)
  for (r in seq_len(N_RUNS)) {
    seed <- BASE_SEED + r
    t0 <- proc.time()["elapsed"]
    all_runs[[r]] <- run_sa(mat, eligible, seed)
    dt <- proc.time()["elapsed"] - t0
    cat(sprintf(
      "  Run %2d: set_fid=%.4f (log=%.2f), accept_rate=%.3f, %.1fs\n",
      r, all_runs[[r]]$best_fid, all_runs[[r]]$best_log_fid,
      all_runs[[r]]$accept_rate, dt
    ))
  }

  # Find the best run
  best_idx <- which.max(vapply(all_runs, function(x) x$best_log_fid, numeric(1)))
  cat(sprintf(
    "  Best run: #%d with set_fid=%.4f\n", best_idx,
    all_runs[[best_idx]]$best_fid
  ))

  list(best_run = all_runs[[best_idx]], all_runs = all_runs)
}


#' Compute individual P_fid for a vector of overhangs.
#'
#' @param mat Named 256x256 fidelity matrix.
#' @param overhangs Character vector of overhang sequences.
#' @return Named numeric vector of P_fid values.
compute_individual_fidelity <- function(mat, overhangs) {
  rcs <- rc_vec(overhangs)
  p_fid <- vapply(seq_along(overhangs), function(i) {
    oh <- overhangs[i]
    rc <- rcs[i]
    correct <- mat[oh, rc]
    row_sum <- sum(mat[oh, ])
    if (row_sum > 0) correct / row_sum else 0
  }, numeric(1))
  names(p_fid) <- overhangs
  p_fid
}


# ===========================================================================
# Main
# ===========================================================================

cat("Loading matrices...\n")
matrices <- list(
  t4_25c_18h    = load_matrix(file.path(DATA_DIR, "t4_25c_18h_matrix.csv")),
  bsai_cycling  = load_matrix(file.path(DATA_DIR, "bsai_cycling_matrix.csv")),
  bsmbi_cycling = load_matrix(file.path(DATA_DIR, "bsmbi_cycling_matrix.csv"))
)


# --- Run SA for each dataset ---
results <- list()
for (nm in names(matrices)) {
  results[[nm]] <- optimize_dataset(matrices[[nm]], nm)
}


# --- Save optimal sets ---
cat("\n--- Saving optimal HF sets ---\n")

# Potapov Table 1 Set 3 for comparison
potapov_set3 <- c(
  "CCTC", "CTAA", "GACA", "GCAC", "AATC", "GTAA", "TGAA",
  "ATTA", "CCAG", "AGGA", "ACAA", "TAGA", "CGGA", "CATA",
  "CAGC", "AACG", "AAGT", "CTCC", "AGAT", "ACCA", "AGTG",
  "GGTA", "GCGA", "AAAA", "ATGA"
)

for (nm in names(results)) {
  best <- results[[nm]]$best_run
  oh_set <- best$best_set
  p_fid <- compute_individual_fidelity(matrices[[nm]], oh_set)
  in_potapov <- oh_set %in% potapov_set3

  dt <- data.table(
    overhang = oh_set,
    individual_pfid = round(p_fid, 4),
    in_potapov_set3 = in_potapov
  )[order(-individual_pfid)]

  # Add set-level summary as attributes in the filename
  out_name <- sprintf("hf_set_%s.csv", nm)
  fwrite(dt, file.path(OUTPUT_DIR, out_name))
  cat(sprintf(
    "  %s: set_fid=%.4f, %d/%d overlap with Potapov Set 3\n",
    out_name, best$best_fid, sum(in_potapov), length(oh_set)
  ))
}


# --- Evaluate Potapov Set 3 under each dataset ---
cat("\n--- Potapov Set 3 evaluated under each dataset ---\n")

potapov_eval <- rbindlist(lapply(names(matrices), function(nm) {
  log_fid <- compute_log_set_fidelity(matrices[[nm]], potapov_set3)
  data.table(
    dataset   = nm,
    set_fid   = round(exp(log_fid), 4),
    log_fid   = round(log_fid, 2)
  )
}))
cat("\n")
print(potapov_eval)


# --- Cross-dataset comparison ---
cat("\n--- Cross-dataset comparison ---\n")

optimal_sets <- lapply(results, function(r) r$best_run$best_set)

# Pairwise overlap
pairs <- list(
  c("t4_25c_18h", "bsai_cycling"),
  c("t4_25c_18h", "bsmbi_cycling"),
  c("bsai_cycling", "bsmbi_cycling")
)

cross_dt <- rbindlist(lapply(pairs, function(p) {
  overlap <- intersect(optimal_sets[[p[1]]], optimal_sets[[p[2]]])
  data.table(
    dataset_1  = p[1],
    dataset_2  = p[2],
    overlap    = length(overlap),
    set_size   = SET_SIZE,
    shared_oh  = paste(sort(overlap), collapse = ", ")
  )
}))

cat("\nPairwise overlap of optimal sets:\n")
print(cross_dt[, .(dataset_1, dataset_2, overlap, set_size)])

# Three-way overlap
three_way <- Reduce(intersect, optimal_sets)
cat(sprintf("\nThree-way overlap: %d overhangs\n", length(three_way)))
if (length(three_way) > 0) {
  cat(sprintf("  %s\n", paste(sort(three_way), collapse = ", ")))
}

# Consensus: overhangs appearing in 2+ optimal sets
all_oh <- unlist(optimal_sets)
oh_counts <- table(all_oh)
consensus <- sort(names(oh_counts[oh_counts >= 2]))
cat(sprintf("\nConsensus (in 2+ optimal sets): %d overhangs\n", length(consensus)))
cat(sprintf("  %s\n", paste(consensus, collapse = ", ")))

# Save cross-dataset comparison
fwrite(cross_dt, file.path(OUTPUT_DIR, "cross_dataset_comparison.csv"))

# Save comprehensive summary
summary_dt <- rbindlist(lapply(names(results), function(nm) {
  best <- results[[nm]]$best_run
  data.table(
    dataset         = nm,
    set_fidelity    = round(best$best_fid, 4),
    log_fidelity    = round(best$best_log_fid, 2),
    accept_rate     = round(best$accept_rate, 3),
    potapov_overlap = sum(best$best_set %in% potapov_set3),
    set_overhangs   = paste(best$best_set, collapse = ", ")
  )
}))

# Add Potapov Set 3 row
summary_dt <- rbind(summary_dt, data.table(
  dataset         = "potapov_set3_reference",
  set_fidelity    = NA_real_,
  log_fidelity    = NA_real_,
  accept_rate     = NA_real_,
  potapov_overlap = 25L,
  set_overhangs   = paste(sort(potapov_set3), collapse = ", ")
))

# Fill in Potapov Set 3 fidelity under each matrix
for (i in seq_len(nrow(potapov_eval))) {
  nm <- potapov_eval$dataset[i]
  row_idx <- which(summary_dt$dataset == "potapov_set3_reference")
  # We report T4 fidelity for Potapov since that's the reference condition
  if (nm == "t4_25c_18h") {
    summary_dt[row_idx, set_fidelity := potapov_eval$set_fid[i]]
    summary_dt[row_idx, log_fidelity := potapov_eval$log_fid[i]]
  }
}

fwrite(summary_dt, file.path(OUTPUT_DIR, "optimization_summary.csv"))

cat("\nDone. All outputs saved to:", OUTPUT_DIR, "\n")
