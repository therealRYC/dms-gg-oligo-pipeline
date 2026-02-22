# Created: 2026-02-22
# 07b_linear_codes.R — GF(4) linear code construction for DNA barcode prefixes
# DMS Golden Gate Oligo Pipeline
#
# Implements shortened quaternary Hamming codes over GF(4) = GF(2^2).
# These produce prefix sets with *algebraically guaranteed* minimum Hamming
# distance d >= 3, eliminating the need for pairwise distance checking.
#
# GF(4) elements: {0, 1, alpha, alpha^2} where alpha^2 + alpha + 1 = 0.
# DNA mapping: 0 -> A, 1 -> C, alpha -> G, alpha^2 -> T
#
# Key properties:
#   - Any two codewords have Hamming distance >= d (by linearity)
#   - Removing codewords (biological filtering) preserves d >= d_code
#   - Random sampling from the code preserves d >= d_code
#   - Capacity for [n, n-3, 3]_4 shortened Hamming code: 4^(n-3)

# ============================================================================
# GF(4) Arithmetic
# ============================================================================

# GF(4) = GF(2^2) with irreducible polynomial x^2 + x + 1 over GF(2).
# Elements represented as integers 0-3:
#   0 = 0b00 (zero)
#   1 = 0b01 (one)
#   2 = 0b10 (alpha)
#   3 = 0b11 (alpha^2 = alpha + 1)

# Addition table (XOR of 2-bit representation)
# a + b = bitwXor(a, b)
GF4_ADD <- matrix(
  c(0L, 1L, 2L, 3L,
    1L, 0L, 3L, 2L,
    2L, 3L, 0L, 1L,
    3L, 2L, 1L, 0L),
  nrow = 4, ncol = 4, byrow = TRUE
)

# Multiplication table
# 0*x = 0, 1*x = x, alpha*alpha = alpha+1 = 3, alpha*(alpha+1) = alpha^2+alpha = 1
# (alpha+1)*(alpha+1) = alpha^2 + 2*alpha + 1 = alpha^2 + 1 = alpha (since char 2)
GF4_MUL <- matrix(
  c(0L, 0L, 0L, 0L,
    0L, 1L, 2L, 3L,
    0L, 2L, 3L, 1L,
    0L, 3L, 1L, 2L),
  nrow = 4, ncol = 4, byrow = TRUE
)

# DNA mapping: GF(4) element -> nucleotide
GF4_TO_DNA <- c("A", "C", "G", "T")  # indexed by element + 1

# DNA -> GF(4) element
DNA_TO_GF4 <- c(A = 0L, C = 1L, G = 2L, T = 3L)

#' Add two GF(4) elements
#' @param a Integer 0-3
#' @param b Integer 0-3
#' @return Integer 0-3
gf4_add <- function(a, b) {
  bitwXor(a, b)
}

#' Multiply two GF(4) elements
#' @param a Integer 0-3
#' @param b Integer 0-3
#' @return Integer 0-3
gf4_mul <- function(a, b) {
  GF4_MUL[a + 1L, b + 1L]
}

#' Vectorized GF(4) dot product of two integer vectors
#' @param u Integer vector (elements 0-3)
#' @param v Integer vector (elements 0-3)
#' @return Integer scalar (element 0-3), the dot product in GF(4)
gf4_dot <- function(u, v) {
  # Multiply element-wise using lookup, then sum (XOR fold)
  products <- GF4_MUL[cbind(u + 1L, v + 1L)]
  Reduce(bitwXor, products, accumulate = FALSE)
}

# ============================================================================
# Hamming Code Construction
# ============================================================================

#' Build the parity-check matrix H for Ham_4(m)
#'
#' The quaternary Hamming code Ham_4(m) has parameters:
#'   n = (4^m - 1) / 3,  k = n - m,  d = 3
#'
#' H is an m x n matrix over GF(4). Its columns are all nonzero m-tuples
#' from GF(4)^m, normalized so the leading nonzero entry is 1.
#' (This ensures each 1-dimensional subspace is represented exactly once.)
#'
#' @param m Redundancy parameter (m >= 2)
#' @return Integer matrix (m x n) with entries in {0, 1, 2, 3}
gf4_hamming_parity_check <- function(m) {
  if (m < 2L) stop("m must be >= 2 for a meaningful Hamming code")

  n <- (4^m - 1L) %/% 3L

  # Generate all nonzero vectors in GF(4)^m
  # Then normalize: for each vector, divide by its leading nonzero entry
  # (i.e., multiply by the inverse of the leading entry)
  # GF(4) inverses: inv(1)=1, inv(alpha)=alpha^2=3, inv(alpha^2)=alpha=2
  # Indexed directly by element value: gf4_inv[1]=1, gf4_inv[2]=3, gf4_inv[3]=2
  gf4_inv <- c(1L, 3L, 2L)

  columns <- matrix(0L, nrow = m, ncol = n)
  col_idx <- 0L

  # Enumerate all 4^m vectors, skip zero vector, normalize
  seen <- list()

  for (i in seq_len(4^m - 1L)) {
    # Convert integer i to base-4 vector of length m
    vec <- integer(m)
    val <- i
    for (j in m:1) {
      vec[j] <- val %% 4L
      val <- val %/% 4L
    }

    # Find leading nonzero position
    lead_pos <- which(vec != 0L)[1]
    lead_val <- vec[lead_pos]

    # Normalize: multiply entire vector by inverse of leading entry
    if (lead_val != 1L) {
      inv_lead <- gf4_inv[lead_val]
      normalized <- integer(m)
      for (j in seq_len(m)) {
        normalized[j] <- GF4_MUL[vec[j] + 1L, inv_lead + 1L]
      }
    } else {
      normalized <- vec
    }

    # Check if we've seen this normalized form
    key <- paste(normalized, collapse = ",")
    if (is.null(seen[[key]])) {
      seen[[key]] <- TRUE
      col_idx <- col_idx + 1L
      columns[, col_idx] <- normalized
    }
  }

  if (col_idx != n) {
    stop("Expected ", n, " columns, got ", col_idx)
  }

  columns
}

#' Derive the generator matrix G from the parity-check matrix H
#'
#' For a systematic code, we rearrange H = [P | I_m] and then
#' G = [I_k | -P^T] = [I_k | P^T] (since -1 = 1 in GF(2^2)).
#'
#' Actually, since GF(4) has characteristic 2, negation is identity.
#' So G = [I_k | P^T] where H = [P | I_m].
#'
#' @param H Parity-check matrix (m x n) over GF(4)
#' @return Generator matrix (k x n) over GF(4), where k = n - m
gf4_generator_from_parity <- function(H) {
  m <- nrow(H)
  n <- ncol(H)
  k <- n - m

  # We need to put H into systematic form [A | I_m] via column operations.
  # Alternatively, use Gaussian elimination on rows to get reduced row echelon form,
  # then identify pivot and non-pivot columns.

  # Gaussian elimination over GF(4)
  H_work <- H  # copy
  pivot_cols <- integer(m)
  gf4_inv <- c(1L, 3L, 2L)

  for (row in seq_len(m)) {
    # Find pivot column (first column with nonzero entry in this row or below)
    pivot_found <- FALSE
    for (col in seq_len(n)) {
      if (col %in% pivot_cols[seq_len(row - 1L)]) next
      if (H_work[row, col] != 0L) {
        pivot_cols[row] <- col
        pivot_found <- TRUE
        break
      }
      # Check if any row below has nonzero in this column
      if (row < m) {
        for (below in (row + 1L):m) {
          if (H_work[below, col] != 0L) {
            # Swap rows
            tmp <- H_work[row, ]
            H_work[row, ] <- H_work[below, ]
            H_work[below, ] <- tmp
            pivot_cols[row] <- col
            pivot_found <- TRUE
            break
          }
        }
        if (pivot_found) break
      }
    }
    if (!pivot_found) stop("H is not full rank")

    col <- pivot_cols[row]
    # Scale pivot row so pivot entry = 1
    pivot_val <- H_work[row, col]
    if (pivot_val != 1L) {
      inv_pv <- gf4_inv[pivot_val]
      for (j in seq_len(n)) {
        H_work[row, j] <- GF4_MUL[H_work[row, j] + 1L, inv_pv + 1L]
      }
    }

    # Eliminate all other rows in this column
    for (other in seq_len(m)) {
      if (other == row) next
      factor <- H_work[other, col]
      if (factor != 0L) {
        for (j in seq_len(n)) {
          product <- GF4_MUL[H_work[row, j] + 1L, factor + 1L]
          H_work[other, j] <- bitwXor(H_work[other, j], product)
        }
      }
    }
  }

  # Now H_work has identity in the pivot columns.
  # Non-pivot columns form the "information" positions.
  non_pivot_cols <- setdiff(seq_len(n), pivot_cols)
  if (length(non_pivot_cols) != k) {
    stop("Expected ", k, " non-pivot columns, got ", length(non_pivot_cols))
  }

  # Generator matrix: G is k x n
  # For each non-pivot column j (information position i),
  # the codeword has 1 in position j and the pivot positions
  # carry the negation (= same, in char 2) of H_rref column j.
  G <- matrix(0L, nrow = k, ncol = n)
  for (i in seq_len(k)) {
    info_col <- non_pivot_cols[i]
    G[i, info_col] <- 1L  # identity part
    for (r in seq_len(m)) {
      G[i, pivot_cols[r]] <- H_work[r, info_col]  # -P^T = P^T in char 2
    }
  }

  G
}

#' Shorten a linear code's generator matrix to target length
#'
#' Shortening removes columns (coordinate positions) and corresponding
#' rows from G that would require those positions to be nonzero.
#' More precisely: to shorten by s positions, we remove s columns and
#' keep only the rows of G that have 0 in those columns — but for the
#' systematic construction, we simply remove the last s information
#' positions (non-pivot columns) and their corresponding rows.
#'
#' @param G Generator matrix (k x n) over GF(4)
#' @param target_n Target codeword length
#' @param pivot_cols Integer vector of pivot column indices from H
#' @param non_pivot_cols Integer vector of non-pivot column indices
#' @return List with: G_short (k' x target_n matrix), col_map (original column indices kept)
gf4_shorten_code <- function(G, target_n, pivot_cols, non_pivot_cols) {
  n <- ncol(G)
  k <- nrow(G)
  s <- n - target_n  # number of positions to remove

  if (s < 0L) stop("target_n (", target_n, ") > code length (", n, ")")
  if (s == 0L) return(list(G_short = G, col_map = seq_len(n)))
  if (s >= k) stop("Cannot shorten by ", s, " (would remove all information positions)")

  # Remove the last s information (non-pivot) columns and their rows
  cols_to_remove <- tail(non_pivot_cols, s)
  rows_to_remove <- which(non_pivot_cols %in% cols_to_remove)

  kept_cols <- setdiff(seq_len(n), cols_to_remove)
  kept_rows <- setdiff(seq_len(k), rows_to_remove)

  G_short <- G[kept_rows, kept_cols, drop = FALSE]

  list(G_short = G_short, col_map = kept_cols)
}

# ============================================================================
# Codeword Generation
# ============================================================================

#' Enumerate all codewords of a GF(4) linear code
#'
#' Encodes all 4^k message vectors by multiplying with the generator matrix.
#' Returns DNA sequences.
#'
#' @param G Generator matrix (k x n) over GF(4)
#' @return Character vector of 4^k DNA sequences, each of length n
gf4_enumerate_codewords <- function(G) {
  k <- nrow(G)
  n <- ncol(G)
  n_codewords <- 4^k

  # Generate all message vectors (k-tuples over {0,1,2,3})
  # Use expand.grid for small k, or manual base-4 expansion
  if (k <= 12L) {
    # Build message matrix (n_codewords x k) by base-4 expansion
    msg_mat <- matrix(0L, nrow = n_codewords, ncol = k)
    for (i in seq_len(n_codewords) - 1L) {
      val <- i
      for (j in k:1) {
        msg_mat[i + 1L, j] <- val %% 4L
        val <- val %/% 4L
      }
    }
  } else {
    stop("k=", k, " too large for full enumeration (4^", k, " = ",
         format(4^k, big.mark = ","), " codewords). Use gf4_sample_codewords().")
  }

  # Encode: codeword = message * G over GF(4)
  # For each message vector m (length k) and generator G (k x n):
  #   codeword[j] = sum_{i=1}^{k} gf4_mul(m[i], G[i,j])
  # where sum is GF(4) addition (XOR).
  #
  # Vectorize using the multiplication lookup table.
  code_mat <- matrix(0L, nrow = n_codewords, ncol = n)

  for (j in seq_len(n)) {
    col_result <- integer(n_codewords)  # all zeros
    for (i in seq_len(k)) {
      # products[r] = gf4_mul(msg_mat[r, i], G[i, j]) for all r
      products <- GF4_MUL[cbind(msg_mat[, i] + 1L, G[i, j] + 1L)]
      col_result <- bitwXor(col_result, products)
    }
    code_mat[, j] <- col_result
  }

  # Convert to DNA strings
  apply(code_mat, 1, function(row) paste0(GF4_TO_DNA[row + 1L], collapse = ""))
}

#' Sample codewords from a GF(4) linear code (for large codes)
#'
#' Randomly generates message vectors and encodes them. Since all pairs
#' of codewords in a linear code have Hamming distance >= d, no pairwise
#' checking is needed.
#'
#' @param G Generator matrix (k x n) over GF(4)
#' @param n_sample Number of codewords to sample
#' @return Character vector of n_sample unique DNA sequences
gf4_sample_codewords <- function(G, n_sample) {
  k <- nrow(G)
  n <- ncol(G)

  # Over-sample to account for duplicates from random generation
  n_gen <- ceiling(n_sample * 1.2)

  # Random message vectors
  msg_mat <- matrix(sample(0:3, k * n_gen, replace = TRUE),
                    nrow = n_gen, ncol = k)

  # Encode
  code_mat <- matrix(0L, nrow = n_gen, ncol = n)
  for (j in seq_len(n)) {
    col_result <- integer(n_gen)
    for (i in seq_len(k)) {
      products <- GF4_MUL[cbind(msg_mat[, i] + 1L, G[i, j] + 1L)]
      col_result <- bitwXor(col_result, products)
    }
    code_mat[, j] <- col_result
  }

  # Convert to DNA and deduplicate
  seqs <- apply(code_mat, 1, function(row) paste0(GF4_TO_DNA[row + 1L], collapse = ""))
  seqs <- unique(seqs)

  # If not enough unique, sample more
  attempts <- 0L
  while (length(seqs) < n_sample && attempts < 5L) {
    attempts <- attempts + 1L
    n_extra <- ceiling((n_sample - length(seqs)) * 1.5)
    msg_extra <- matrix(sample(0:3, k * n_extra, replace = TRUE),
                        nrow = n_extra, ncol = k)
    code_extra <- matrix(0L, nrow = n_extra, ncol = n)
    for (j in seq_len(n)) {
      col_result <- integer(n_extra)
      for (i in seq_len(k)) {
        products <- GF4_MUL[cbind(msg_extra[, i] + 1L, G[i, j] + 1L)]
        col_result <- bitwXor(col_result, products)
      }
      code_extra[, j] <- col_result
    }
    extra_seqs <- apply(code_extra, 1, function(row) paste0(GF4_TO_DNA[row + 1L], collapse = ""))
    seqs <- unique(c(seqs, extra_seqs))
  }

  if (length(seqs) < n_sample) {
    cli::cli_alert_warning("Could only generate {length(seqs)} unique codewords (requested {n_sample})")
    return(seqs)
  }

  seqs[seq_len(n_sample)]
}

# ============================================================================
# Main Entry Point
# ============================================================================

#' Generate DNA barcode prefixes using a GF(4) shortened Hamming code
#'
#' Constructs a shortened quaternary Hamming code with guaranteed minimum
#' Hamming distance d = 3. For prefix_length n, the code has parameters
#' [n, n-3, >=3]_4 with 4^(n-3) codewords.
#'
#' For n <= 14 (4^(n-3) <= 4M), all codewords are enumerated.
#' For n > 14, codewords are sampled (distance guarantee still holds).
#'
#' @param prefix_length Length of each prefix (n)
#' @param n_needed Number of prefixes needed (after filtering)
#' @return List with:
#'   - prefixes: character vector of DNA sequences
#'   - code_type: "linear" (for skipping redundant validation)
#'   - code_params: list(n, k, d, m, capacity) describing the code
generate_prefixes_linear <- function(prefix_length, n_needed) {
  if (prefix_length < 5L) {
    # For very short prefixes, use Ham_4(2) = [5, 3, 3]_4
    m <- 2L
  } else if (prefix_length <= 21L) {
    # Use Ham_4(3) = [21, 18, 3]_4
    m <- 3L
  } else if (prefix_length <= 85L) {
    # Use Ham_4(4) = [85, 81, 3]_4
    m <- 4L
  } else {
    stop("prefix_length ", prefix_length, " exceeds maximum supported (85)")
  }

  native_n <- (4^m - 1L) %/% 3L
  native_k <- native_n - m
  shorten_by <- native_n - prefix_length

  cli::cli_alert_info(paste0(
    "Building GF(4) Hamming code: Ham_4(", m, ") = [", native_n, ", ", native_k, ", 3]_4",
    if (shorten_by > 0) paste0(", shortened to [", prefix_length, ", ", native_k - shorten_by, ", >=3]_4")
  ))

  # Build parity-check matrix and generator matrix
  H <- gf4_hamming_parity_check(m)
  G_full <- gf4_generator_from_parity(H)

  # Shorten if needed
  if (shorten_by > 0L) {
    # Identify pivot and non-pivot columns from H
    # Re-do the Gaussian elimination to find them (same as in generator construction)
    H_work <- H
    gf4_inv <- c(1L, 3L, 2L)
    pivot_cols <- integer(m)
    for (row in seq_len(m)) {
      for (col in seq_len(native_n)) {
        if (col %in% pivot_cols[seq_len(row - 1L)]) next
        if (H_work[row, col] != 0L) {
          pivot_cols[row] <- col
          break
        }
        if (row < m) {
          found_below <- FALSE
          for (below in (row + 1L):m) {
            if (H_work[below, col] != 0L) {
              tmp <- H_work[row, ]
              H_work[row, ] <- H_work[below, ]
              H_work[below, ] <- tmp
              pivot_cols[row] <- col
              found_below <- TRUE
              break
            }
          }
          if (found_below) break
        }
      }
      col <- pivot_cols[row]
      pivot_val <- H_work[row, col]
      if (pivot_val != 1L) {
        inv_pv <- gf4_inv[pivot_val]
        for (j in seq_len(native_n)) {
          H_work[row, j] <- GF4_MUL[H_work[row, j] + 1L, inv_pv + 1L]
        }
      }
      for (other in seq_len(m)) {
        if (other == row) next
        factor <- H_work[other, col]
        if (factor != 0L) {
          for (j in seq_len(native_n)) {
            product <- GF4_MUL[H_work[row, j] + 1L, factor + 1L]
            H_work[other, j] <- bitwXor(H_work[other, j], product)
          }
        }
      }
    }
    non_pivot_cols <- setdiff(seq_len(native_n), pivot_cols)

    result <- gf4_shorten_code(G_full, prefix_length, pivot_cols, non_pivot_cols)
    G <- result$G_short
  } else {
    G <- G_full
  }

  k <- nrow(G)
  capacity <- 4^k

  cli::cli_alert_info(paste0(
    "Code capacity: 4^", k, " = ", format(capacity, big.mark = ","), " codewords"
  ))

  # Generate codewords
  if (k <= 12L) {
    cli::cli_alert("Enumerating all {format(capacity, big.mark=',')} codewords...")
    prefixes <- gf4_enumerate_codewords(G)
  } else {
    # Sample with generous oversampling for post-filtering
    n_sample <- min(n_needed * 5L, capacity)
    cli::cli_alert("Sampling {format(n_sample, big.mark=',')} codewords from code with {format(capacity, big.mark=',')} total...")
    prefixes <- gf4_sample_codewords(G, n_sample)
  }

  cli::cli_alert_success(paste0(
    "Generated ", format(length(prefixes), big.mark = ","),
    " prefix codewords (d >= 3 guaranteed by algebraic construction)"
  ))

  list(
    prefixes = prefixes,
    code_type = "linear",
    code_params = list(
      n = prefix_length,
      k = k,
      d = 3L,
      m = m,
      capacity = capacity
    )
  )
}
