# 06_overhang_selection.R — Overhang selection for 3-enzyme Golden Gate assembly
# DMS Golden Gate Oligo Pipeline
#
# In the 3-enzyme architecture:
# - oh1 and oh2 are gene-derived (WT sequence at tile boundaries) — extracted, not selected
# - oh3 is a fixed BsmBI overhang at the PolIII-barcode junction (same for all tiles)
# - oh4 is a fixed BsaI overhang at the barcode-helper plasmid junction (same for all tiles)
# - Superblock junctions use gene-derived overhangs at tile boundaries

#' Load NEB overhang fidelity data for a given enzyme
#'
#' Loads the full 256-overhang fidelity dataset. Tries RDS file first,
#' falls back to built-in data derived from Potapov et al. 2018 (37C, 18h).
#'
#' @param enzyme_name Name of enzyme ("BsaI" or "BsmBI") — used for RDS lookup
#' @return Data frame with columns: overhang, fidelity (all 256 4-nt overhangs)
load_overhang_fidelity <- function(enzyme_name = "BsmBI") {
  # Try enzyme-specific RDS first
  data_path <- file.path(find_data_dir(), "neb_overhang_fidelity",
                         paste0(tolower(enzyme_name), "_overhangs.rds"))
  if (file.exists(data_path)) {
    return(readRDS(data_path))
  }

  # Try generic 18h RDS
  generic_path <- file.path(find_data_dir(), "neb_overhang_fidelity",
                            "potapov_18h_overhangs.rds")
  if (file.exists(generic_path)) {
    return(readRDS(generic_path))
  }

  # Fallback: use built-in 256-overhang data
  cli::cli_alert_info(paste0("Using built-in overhang fidelity data (Potapov 2018, 37C, 18h)."))
  builtin_overhang_fidelity()
}

#' Built-in fidelity data for all 256 4-nt overhangs
#'
#' Data from Potapov et al. 2018 (T4 DNA Ligase, 37C, 18h incubation).
#' Fidelity = M[X][RC(X)] / sum(M[X][*]) — correct Watson-Crick pairing.
#' Extracted via the tatapov Python package from NEB's published 256x256 matrix.
#'
#' At 0.95 threshold: 117 overhangs pass. At 0.90: 186. At 0.85: 224.
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
  # Return sorted by fidelity descending for selection priority
  oh_data[order(oh_data$fidelity, decreasing = TRUE), ]
}

# Keep old name as alias for backward compatibility in tests
builtin_high_fidelity_overhangs <- builtin_overhang_fidelity

#' Extract tile boundary overhangs from the gene sequence
#'
#' For each tile, extracts oh1 and oh2 from the gene and looks up their
#' fidelity in the NEB data for both BsaI and BsmBI.
#'
#' @param tiles Data frame from partition_tiles() (must include oh1_seq, oh2_seq)
#' @param oh_fidelity_data Data frame of overhang fidelity scores
#' @return Data frame with tile_id, oh1_seq, oh2_seq, oh1_fidelity, oh2_fidelity
extract_tile_overhangs <- function(tiles, oh_fidelity_data = NULL) {
  if (is.null(oh_fidelity_data)) {
    oh_fidelity_data <- builtin_overhang_fidelity()
  }

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

  # Warn about low-fidelity overhangs (all 256 are in the database now, so no NAs expected)
  low_oh1 <- !is.na(result$oh1_fidelity) & result$oh1_fidelity < 0.80
  low_oh2 <- !is.na(result$oh2_fidelity) & result$oh2_fidelity < 0.80
  na_oh1 <- is.na(result$oh1_fidelity)
  na_oh2 <- is.na(result$oh2_fidelity)

  if (any(low_oh1 | low_oh2)) {
    cli::cli_alert_warning(paste0(
      sum(low_oh1 | low_oh2), " tile boundary overhang(s) have low fidelity (<0.80)."
    ))
  }
  if (any(na_oh1 | na_oh2)) {
    cli::cli_alert_info(paste0(
      sum(na_oh1 | na_oh2), " tile boundary overhang(s) not found in fidelity database."
    ))
  }

  result
}

#' Select fixed overhangs oh3 and oh4 for the 3-enzyme assembly
#'
#' oh3 = BsmBI overhang at the PolIII-barcode junction (same for all tiles)
#' oh4 = BsaI overhang at the barcode-helper plasmid junction (same for all tiles)
#'
#' These must be:
#' - High fidelity for their respective enzymes
#' - Orthogonal to all gene-derived tile boundary overhangs (oh1, oh2)
#' - Distinct from each other and their reverse complements
#'
#' Candidates are sorted by fidelity descending so the highest-fidelity
#' overhangs are selected first.
#'
#' Note: we do NOT exclude overhangs that merely appear as substrings in the gene,
#' because 4-nt sequences occur frequently by chance in any gene. What matters is
#' that oh3/oh4 are orthogonal to the specific overhangs produced by enzyme digestion
#' in the same reaction (oh1, oh2, gene-start oh).
#'
#' @param cds Character string of domesticated CDS
#' @param polIII Character string of PolIII promoter
#' @param tile_overhangs Data frame from extract_tile_overhangs()
#' @param fidelity_threshold Minimum fidelity score (default 0.95)
#' @param manual_oh3 Optional user-specified oh3
#' @param manual_oh4 Optional user-specified oh4
#' @return Named list with oh3, oh4
select_fixed_overhangs <- function(cds, polIII, tile_overhangs,
                                    fidelity_threshold = DEFAULT_FIDELITY_THRESHOLD,
                                    manual_oh3 = NULL, manual_oh4 = NULL) {
  # If user provided manual overhangs, validate and return
  if (!is.null(manual_oh3) && !is.null(manual_oh4)) {
    cli::cli_alert_info("Using manually specified oh3 and oh4.")
    validate_fixed_overhangs(manual_oh3, manual_oh4)
    return(list(oh3 = toupper(manual_oh3), oh4 = toupper(manual_oh4)))
  }

  oh_data <- builtin_overhang_fidelity()
  # Sort by fidelity descending to prioritize highest-fidelity overhangs
  oh_data <- oh_data[order(oh_data$fidelity, decreasing = TRUE), ]
  candidates <- oh_data$overhang[oh_data$fidelity >= fidelity_threshold]

  if (length(candidates) < 2) {
    cli::cli_warn("Fewer than 2 overhangs above fidelity threshold; lowering to 0.85.")
    candidates <- oh_data$overhang[oh_data$fidelity >= 0.85]
  }

  # Filter out overhangs that collide with gene-derived tile boundary overhangs.
  # oh3 must be orthogonal to all oh2 values (both in the same BsmBI reaction).
  # oh4 must be orthogonal to all oh1 values and the gene-start oh (all in the same BsaI reaction).
  # For simplicity we exclude any candidate that matches any tile boundary overhang or its RC.
  gene_ohs <- unique(c(tile_overhangs$oh1_seq, tile_overhangs$oh2_seq))
  # Also include the gene-start overhang (oh_L = first 4 nt), which is in the BsaI reaction
  oh_L <- substring(cds, 1, 4)
  gene_ohs <- unique(c(gene_ohs, oh_L))
  gene_oh_rcs <- vapply(gene_ohs, reverse_complement, character(1), USE.NAMES = FALSE)
  used <- unique(c(gene_ohs, gene_oh_rcs))
  candidates <- candidates[!(candidates %in% used)]

  if (length(candidates) < 2) {
    stop("Cannot find 2 orthogonal high-fidelity fixed overhangs (oh3, oh4). ",
         "Consider manual specification.")
  }

  # Select 2 mutually orthogonal overhangs (candidates already sorted by fidelity desc)
  selected <- select_orthogonal_set(candidates, n = 2)

  result <- list(
    oh3 = selected[1],  # BsmBI overhang at PolIII-barcode junction
    oh4 = selected[2]   # BsaI overhang at barcode-helper junction
  )

  cli::cli_alert_success(paste0(
    "Selected fixed overhangs: oh3=", result$oh3, ", oh4=", result$oh4
  ))

  result
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
#' Orthogonal = no overhang is the same as or reverse complement of another.
#' Candidates should be pre-sorted by fidelity descending so the highest-fidelity
#' overhangs are picked first.
#'
#' @param candidates Character vector of candidate overhangs (pre-sorted by fidelity desc)
#' @param n Number to select
#' @return Character vector of selected overhangs
select_orthogonal_set <- function(candidates, n) {
  selected <- character(0)
  used <- character(0)  # track both overhang and its RC

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

#' Validate that overhangs within a single reaction are mutually orthogonal
#'
#' For BsaI reactions: check oh_L (gene-start or superblock junction), oh1, oh4
#' For BsmBI reactions: check oh2, oh3, and any superblock junction overhangs
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

#' Select additional overhangs for superblock internal junctions
#'
#' Selects high-fidelity overhangs that are orthogonal to all already-used
#' overhangs (tile boundaries, oh3, oh4). Does not filter by gene-substring
#' presence, since 4-nt sequences appear by chance in any gene and what matters
#' is orthogonality to other overhangs in the same reaction.
#'
#' Candidates are sorted by fidelity descending so the highest-fidelity
#' overhangs are selected first.
#'
#' @param cds Character string of domesticated CDS (unused, kept for API compat)
#' @param polIII PolIII promoter sequence (unused, kept for API compat)
#' @param existing_overhangs Character vector of already-used overhangs
#' @param n_additional Number of additional overhangs needed
#' @param fidelity_threshold Minimum fidelity score
#' @return Character vector of additional overhangs
select_superblock_overhangs <- function(cds, polIII, existing_overhangs,
                                        n_additional,
                                        fidelity_threshold = DEFAULT_FIDELITY_THRESHOLD) {
  if (n_additional == 0) return(character(0))

  oh_data <- builtin_overhang_fidelity()
  # Sort by fidelity descending to prioritize highest-fidelity overhangs
  oh_data <- oh_data[order(oh_data$fidelity, decreasing = TRUE), ]
  candidates <- oh_data$overhang[oh_data$fidelity >= fidelity_threshold]

  # Exclude existing overhangs and their RCs
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
