# Script to generate bundled data files
# Run once: Rscript data/generate_data.R
#
# Overhang fidelity data extracted from Potapov et al. 2018 and Pryor et al. 2020
# via the tatapov Python package (Edinburgh Genome Foundry).
#
# Fidelity = M[X][RC(X)] / sum(M[X][*]) — correct Watson-Crick pairing
# (NOT diagonal M[X][X], which is only correct for palindromes).

# --- Human Codon Usage (CoCoPUTs) ---
# Source: CoCoPUTs (Alexaki et al. 2019, J Mol Biol 431:2434-2441)
# https://dnahive.fda.gov/dna.cgi?cmd=codon_usage&id=537&mode=cocoputs
# Homo sapiens, GCF_000001405.39 (GRCh38.p13), 119,196 CDS, 77,461,688 codons
# Downloaded: 2026-02-21
source("R/03_codon_table.R")
codon_usage <- builtin_human_codon_usage()
saveRDS(codon_usage, "data/human_codon_usage.rds")
cat("Saved data/human_codon_usage.rds\n")

# --- Create output directory ---
dir.create("data/neb_overhang_fidelity", showWarnings = FALSE, recursive = TRUE)

# All 256 possible 4-nt overhangs (alphabetical order)
all_overhangs <- c(
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
)

# --- Dataset 1: Potapov 2018, 37C, 18h (generic T4 DNA Ligase) ---
# NEB's standard reference dataset. 117 overhangs >= 0.95.
potapov_18h <- data.frame(
  overhang = all_overhangs,
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
saveRDS(potapov_18h, "data/neb_overhang_fidelity/potapov_18h_overhangs.rds")
cat("Saved data/neb_overhang_fidelity/potapov_18h_overhangs.rds\n")
cat(sprintf("  %d overhangs >= 0.95 fidelity\n", sum(potapov_18h$fidelity >= 0.95)))

# --- Dataset 2: Pryor 2020, 37C, 1h, BsaI-specific ---
# 2 overhangs >= 0.95, 9 >= 0.90, 42 >= 0.80
bsai_overhangs <- data.frame(
  overhang = all_overhangs,
  fidelity = c(
    0.956325, 0.680973, 0.744070, 0.787730, 0.805556, 0.632308, 0.589247, 0.678133,
    0.928485, 0.630350, 0.674074, 0.756208, 0.868750, 0.722388, 0.685307, 0.819565,
    0.914122, 0.555556, 0.617066, 0.724057, 0.772277, 0.596358, 0.526795, 0.659731,
    0.757158, 0.437337, 0.490104, 0.640969, 0.839096, 0.660182, 0.601618, 0.757919,
    0.877934, 0.553691, 0.675000, 0.702820, 0.596814, 0.455882, 0.483476, 0.527778,
    0.778875, 0.575901, 0.555133, 0.653333, 0.752147, 0.597633, 0.518667, 0.657143,
    0.895604, 0.720399, 0.739075, 0.813776, 0.757534, 0.675676, 0.570571, 0.723214,
    0.789655, 0.637209, 0.598370, 0.718970, 0.813783, 0.732318, 0.624402, 0.767025,
    0.898148, 0.566667, 0.657795, 0.786145, 0.628352, 0.451613, 0.420359, 0.556509,
    0.817722, 0.503577, 0.548163, 0.699177, 0.737805, 0.582596, 0.589474, 0.707814,
    0.825000, 0.568273, 0.617341, 0.700272, 0.700183, 0.546000, 0.545969, 0.623044,
    0.712838, 0.411491, 0.522829, 0.610329, 0.702128, 0.583333, 0.611973, 0.705426,
    0.783493, 0.432802, 0.509413, 0.624315, 0.486264, 0.341463, 0.412292, 0.441834,
    0.671763, 0.434825, 0.474785, 0.580825, 0.638539, 0.484914, 0.503587, 0.620612,
    0.853535, 0.653910, 0.716826, 0.734355, 0.668073, 0.559322, 0.690691, 0.657010,
    0.725051, 0.535925, 0.599327, 0.644565, 0.703896, 0.677108, 0.734088, 0.682703,
    0.875153, 0.636153, 0.666667, 0.742007, 0.603909, 0.529162, 0.476190, 0.563197,
    0.796818, 0.556593, 0.587413, 0.636250, 0.722973, 0.598058, 0.509021, 0.601242,
    0.740223, 0.477245, 0.522388, 0.601537, 0.537541, 0.489017, 0.448345, 0.554845,
    0.619362, 0.440047, 0.382948, 0.447263, 0.623068, 0.503696, 0.438903, 0.580645,
    0.792494, 0.515385, 0.540984, 0.633260, 0.500492, 0.382178, 0.376344, 0.470245,
    0.667476, 0.488453, 0.476440, 0.535422, 0.638814, 0.495040, 0.401274, 0.562244,
    0.805040, 0.596450, 0.570392, 0.659269, 0.576098, 0.557752, 0.429864, 0.545755,
    0.577778, 0.481988, 0.438760, 0.522496, 0.648022, 0.580338, 0.430380, 0.612613,
    0.942559, 0.758786, 0.826220, 0.842185, 0.865353, 0.729231, 0.647510, 0.735894,
    0.917044, 0.729805, 0.688396, 0.804847, 0.886311, 0.782164, 0.688478, 0.783099,
    0.917603, 0.770035, 0.798206, 0.827711, 0.887208, 0.757576, 0.725243, 0.775049,
    0.823256, 0.679131, 0.629225, 0.755556, 0.888889, 0.795844, 0.694624, 0.814028,
    0.834621, 0.618421, 0.689405, 0.681034, 0.669231, 0.559956, 0.504274, 0.592457,
    0.748260, 0.546460, 0.567407, 0.624000, 0.781899, 0.657335, 0.530744, 0.672578,
    0.967742, 0.847765, 0.811200, 0.857895, 0.900000, 0.816837, 0.704301, 0.800857,
    0.819398, 0.742297, 0.614907, 0.738059, 0.916244, 0.828505, 0.729323, 0.844415
  ),
  stringsAsFactors = FALSE
)
saveRDS(bsai_overhangs, "data/neb_overhang_fidelity/bsai_overhangs.rds")
cat("Saved data/neb_overhang_fidelity/bsai_overhangs.rds\n")
cat(sprintf("  %d overhangs >= 0.95 fidelity (BsaI 1h)\n", sum(bsai_overhangs$fidelity >= 0.95)))

# --- Dataset 3: Pryor 2020, 37C, 1h, BsmBI-specific ---
# 1 overhang >= 0.95, 8 >= 0.90, 39 >= 0.80
bsmbi_overhangs <- data.frame(
  overhang = all_overhangs,
  fidelity = c(
    0.950243, 0.669355, 0.751082, 0.773674, 0.803231, 0.545082, 0.556566, 0.663522,
    0.920890, 0.590012, 0.655236, 0.762857, 0.881628, 0.711560, 0.641171, 0.800696,
    0.891935, 0.562874, 0.579304, 0.662105, 0.720000, 0.552756, 0.516865, 0.622172,
    0.763934, 0.448113, 0.498584, 0.630244, 0.794621, 0.597914, 0.552885, 0.731507,
    0.884690, 0.569649, 0.601554, 0.682495, 0.569002, 0.464407, 0.419738, 0.511732,
    0.751456, 0.570991, 0.518471, 0.625000, 0.728571, 0.593750, 0.519004, 0.674840,
    0.917044, 0.680425, 0.733046, 0.793443, 0.748276, 0.601542, 0.570035, 0.715122,
    0.754912, 0.617108, 0.539273, 0.682213, 0.781818, 0.708369, 0.612395, 0.766417,
    0.894822, 0.578014, 0.664027, 0.736111, 0.614065, 0.417208, 0.464819, 0.533693,
    0.817490, 0.481534, 0.535777, 0.651189, 0.753998, 0.521622, 0.604559, 0.676969,
    0.843866, 0.542593, 0.612245, 0.646976, 0.668737, 0.551456, 0.582345, 0.620427,
    0.644220, 0.377493, 0.564192, 0.607595, 0.667929, 0.566757, 0.638254, 0.689084,
    0.746085, 0.469484, 0.535141, 0.611798, 0.467480, 0.354686, 0.404358, 0.430488,
    0.660909, 0.430950, 0.521226, 0.556624, 0.653846, 0.513605, 0.589189, 0.578782,
    0.869110, 0.658307, 0.713693, 0.729904, 0.687173, 0.550992, 0.725170, 0.634660,
    0.679134, 0.564193, 0.575621, 0.647568, 0.718294, 0.638384, 0.759379, 0.663480,
    0.874494, 0.607863, 0.675214, 0.724625, 0.612670, 0.515464, 0.459898, 0.553734,
    0.744361, 0.544643, 0.559892, 0.620939, 0.702920, 0.582104, 0.474201, 0.641700,
    0.754300, 0.505718, 0.511752, 0.582692, 0.572668, 0.546185, 0.451745, 0.528855,
    0.583618, 0.431818, 0.433715, 0.509383, 0.581050, 0.523044, 0.452000, 0.563193,
    0.746283, 0.575397, 0.522849, 0.538550, 0.527305, 0.453501, 0.430216, 0.469714,
    0.619448, 0.495146, 0.529851, 0.529412, 0.583893, 0.514403, 0.445407, 0.570815,
    0.802879, 0.583957, 0.561497, 0.660183, 0.591486, 0.580581, 0.486618, 0.560134,
    0.561338, 0.496879, 0.466561, 0.508108, 0.613904, 0.597621, 0.475912, 0.587264,
    0.939173, 0.771505, 0.837696, 0.816456, 0.865217, 0.705405, 0.647806, 0.744526,
    0.911504, 0.701102, 0.673028, 0.743707, 0.880503, 0.804147, 0.700571, 0.813424,
    0.942529, 0.762626, 0.781427, 0.810211, 0.851852, 0.775940, 0.723383, 0.757339,
    0.837046, 0.679470, 0.634254, 0.733473, 0.889209, 0.810526, 0.668394, 0.798499,
    0.862069, 0.648461, 0.654613, 0.693291, 0.683091, 0.586653, 0.494269, 0.597547,
    0.737686, 0.592593, 0.503115, 0.583921, 0.769330, 0.665029, 0.540785, 0.645047,
    0.944828, 0.833333, 0.848020, 0.867332, 0.882353, 0.795837, 0.689050, 0.818100,
    0.885290, 0.733572, 0.600529, 0.714470, 0.914692, 0.834783, 0.706258, 0.862335
  ),
  stringsAsFactors = FALSE
)
saveRDS(bsmbi_overhangs, "data/neb_overhang_fidelity/bsmbi_overhangs.rds")
cat("Saved data/neb_overhang_fidelity/bsmbi_overhangs.rds\n")
cat(sprintf("  %d overhangs >= 0.95 fidelity (BsmBI 1h)\n", sum(bsmbi_overhangs$fidelity >= 0.95)))

# --- Dataset 4: High-Fidelity Overhang Sets ---
# Pre-validated sets of mutually orthogonal overhangs selected for maximal
# set-level fidelity. Based on Potapov 2018 individual fidelity data.
# Selected via greedy algorithm: pick highest-fidelity overhangs that don't
# collide (identity or reverse-complement) with already-selected members.

# Helper: reverse complement (base R, no Biostrings needed)
rc_base <- function(seq) {
  comp <- chartr("ACGT", "TGCA", seq)
  paste0(rev(strsplit(comp, "")[[1]]), collapse = "")
}

generate_hf_set_standalone <- function(oh_data, n_members) {
  sorted <- oh_data[order(oh_data$fidelity, decreasing = TRUE), ]
  selected <- character(0)
  used <- character(0)
  for (i in seq_len(nrow(sorted))) {
    oh <- sorted$overhang[i]
    oh_rc <- rc_base(oh)
    if (!(oh %in% used) && !(oh_rc %in% used)) {
      selected <- c(selected, oh)
      used <- c(used, oh, oh_rc)
      if (length(selected) == n_members) break
    }
  }
  selected
}

hf_20 <- generate_hf_set_standalone(potapov_18h, 20)
hf_10 <- generate_hf_set_standalone(potapov_18h, 10)

hf_sets <- list(
  greedy_fidelity_20 = hf_20,
  greedy_fidelity_10 = hf_10
)
saveRDS(hf_sets, "data/neb_overhang_fidelity/high_fidelity_sets.rds")
cat("Saved data/neb_overhang_fidelity/high_fidelity_sets.rds\n")
cat(sprintf("  20-member set: %s\n", paste(hf_20, collapse = ", ")))
cat(sprintf("  10-member set: %s\n", paste(hf_10, collapse = ", ")))

# --- Dataset 5: Pairwise Ligation Matrices (synthetic) ---
# 256x256 matrices where M[X,Y] = ligation frequency of overhang X with RC(Y).
# Generated from individual fidelity data using a Hamming-distance model for
# cross-reactivity. When real Potapov/Pryor pairwise matrices are available,
# regenerate these from the tatapov Python package.

generate_pairwise_standalone <- function(oh_data) {
  overhangs <- oh_data$overhang
  fidelities <- oh_data$fidelity
  names(fidelities) <- overhangs
  n <- length(overhangs)

  rcs <- vapply(overhangs, rc_base, character(1), USE.NAMES = FALSE)
  oh_chars <- lapply(overhangs, function(x) strsplit(x, "")[[1]])
  rc_chars <- lapply(rcs, function(x) strsplit(x, "")[[1]])

  mat <- matrix(0, nrow = n, ncol = n, dimnames = list(overhangs, overhangs))
  for (i in seq_len(n)) {
    f_i <- fidelities[i]
    chars_i <- oh_chars[[i]]
    raw_weights <- numeric(n)
    for (j in seq_len(n)) {
      if (i == j) next
      h <- sum(chars_i != rc_chars[[j]])
      raw_weights[j] <- exp(-2 * h)
    }
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

cat("Generating pairwise matrices (this may take a minute)...\n")
potapov_18h_pw <- generate_pairwise_standalone(potapov_18h)
saveRDS(potapov_18h_pw, "data/neb_overhang_fidelity/potapov_18h_pairwise.rds")
cat("Saved data/neb_overhang_fidelity/potapov_18h_pairwise.rds\n")

bsai_pw <- generate_pairwise_standalone(bsai_overhangs)
saveRDS(bsai_pw, "data/neb_overhang_fidelity/bsai_pairwise.rds")
cat("Saved data/neb_overhang_fidelity/bsai_pairwise.rds\n")

bsmbi_pw <- generate_pairwise_standalone(bsmbi_overhangs)
saveRDS(bsmbi_pw, "data/neb_overhang_fidelity/bsmbi_pairwise.rds")
cat("Saved data/neb_overhang_fidelity/bsmbi_pairwise.rds\n")

cat("\nAll data files generated.\n")
