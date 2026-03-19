# Created: 2026-02-21
# Last updated: 2026-03-17 — Targeted junctional sampling + strict nucleotide-level verification
# 13_gg_simulator.R — In-silico Golden Gate Assembly Simulator
# DMS Golden Gate Oligo Pipeline
#
# Simulates Type IIS restriction enzyme digestion and ligation to verify
# that designed oligos, gene blocks, and helper plasmid assemble correctly.
#
# Key functions:
#   digest_linear()           — Cut a linear DNA sequence with a Type IIS enzyme
#   mark_terminal_waste()     — Mark first/last fragments as waste
#   mark_stuffer_waste()      — Mark internal fragments (both oh non-NA) as waste
#   ligate_fragments()        — Assemble fragments by matching overhangs
#   simulate_tile_assembly()  — Full BsaI + BsmBI simulation for one tile
#   select_junctional_variants() — Pick boundary-vulnerable variants per tile
#   build_expected_product()  — Construct expected product from first principles
#   verify_assembly_product_strict() — Exhaustive nucleotide-level product verification
#   verify_assembly_product() — Coarse check (grepl-based, backward compat)
#   simulate_pipeline_assembly() — Orchestrate over all tiles

#' Simulate Type IIS restriction enzyme digestion of a linear DNA sequence
#'
#' Finds all enzyme recognition sites (both strands), computes top-strand cut
#' positions, and returns ordered fragments with 5'/3' overhang annotations.
#'
#' For a forward (+) site at position s:
#'   top_cut = s + recog_len + cut_fwd - 1
#'   overhang = substring(seq, top_cut + 1, top_cut + oh_len)
#'
#' For a reverse (-) site at position s (RC match on top strand):
#'   top_cut = s - 1 - cut_rev
#'   overhang = substring(seq, top_cut + 1, top_cut + oh_len)
#'
#' Concatenating all fragment bodies in order recovers the original sequence.
#'
#' @param sequence Character string of DNA sequence (top strand, 5'->3')
#' @param enzyme_name Name of enzyme (e.g., "BsaI", "BsmBI", "PaqCI")
#' @param source_label Label to tag fragments with their source molecule
#' @return List of fragment lists, each with: body, oh_5, oh_3, source
digest_linear <- function(sequence, enzyme_name, source_label = "unknown") {
  enz <- ENZYMES[[enzyme_name]]
  if (is.null(enz)) stop("Unknown enzyme: ", enzyme_name)

  seq_len <- nchar(sequence)
  recog_len <- nchar(enz$recog)

  sites <- find_enzyme_sites(sequence, enz$recog)

  # No sites → return the whole sequence as one fragment
  if (nrow(sites) == 0L) {
    return(list(
      list(body = sequence, oh_5 = NA_character_, oh_3 = NA_character_,
           source = source_label)
    ))
  }

  # Compute top-strand cut position and overhang for each site
  n_sites <- nrow(sites)
  top_cuts <- integer(n_sites)
  overhangs <- character(n_sites)

  for (i in seq_len(n_sites)) {
    s <- sites$start[i]
    if (sites$strand[i] == "+") {
      tc <- s + recog_len + enz$cut_fwd - 1L
    } else {
      tc <- s - 1L - enz$cut_rev
    }

    # Validate cut position is within sequence bounds
    if (tc < 0L || (tc + enz$oh_len) > seq_len) {
      stop("Enzyme site at position ", s, " (", sites$strand[i],
           ") produces cut outside sequence bounds (top_cut=", tc,
           ", seq_len=", seq_len, ")")
    }

    top_cuts[i] <- tc
    overhangs[i] <- substring(sequence, tc + 1L, tc + enz$oh_len)
  }

  # Sort by cut position
  ord <- order(top_cuts)
  top_cuts <- top_cuts[ord]
  overhangs <- overhangs[ord]

  # Check for duplicate cut positions (would mean overlapping sites)
  if (anyDuplicated(top_cuts)) {
    stop("Overlapping enzyme sites produce duplicate cut positions")
  }

  # Extract fragments between consecutive cut positions
  n_cuts <- length(top_cuts)
  fragments <- vector("list", n_cuts + 1L)

  for (i in seq_len(n_cuts + 1L)) {
    start_pos <- if (i == 1L) 1L else top_cuts[i - 1L] + 1L
    end_pos <- if (i == n_cuts + 1L) seq_len else top_cuts[i]

    body <- substring(sequence, start_pos, end_pos)
    oh_5 <- if (i == 1L) NA_character_ else overhangs[i - 1L]
    oh_3 <- if (i == n_cuts + 1L) NA_character_ else overhangs[i]

    fragments[[i]] <- list(
      body = body, oh_5 = oh_5, oh_3 = oh_3, source = source_label
    )
  }

  fragments
}

#' Mark first and last fragments as waste
#'
#' For oligos and gene blocks, the terminal fragments (flanking the productive
#' insert) are waste — they contain enzyme recognition/spacer sequences that
#' are not part of the desired product.
#'
#' @param fragments List of fragment lists from digest_linear()
#' @return Modified fragment list with terminal sources set to "waste"
mark_terminal_waste <- function(fragments) {
  if (length(fragments) >= 1L) fragments[[1]]$source <- "waste"
  if (length(fragments) >= 2L) fragments[[length(fragments)]]$source <- "waste"
  fragments
}

#' Mark internal fragments (stuffer) as waste
#'
#' For the helper plasmid and BsaI product, the fragment between enzyme sites
#' (stuffer/spacer) has both oh_5 and oh_3 non-NA. Mark these as waste.
#'
#' @param fragments List of fragment lists from digest_linear()
#' @return Modified fragment list with stuffer fragments marked as waste
mark_stuffer_waste <- function(fragments) {
  for (i in seq_along(fragments)) {
    if (!is.na(fragments[[i]]$oh_5) && !is.na(fragments[[i]]$oh_3)) {
      fragments[[i]]$source <- "waste"
    }
  }
  fragments
}

#' Assemble fragments by matching overhangs
#'
#' Performs greedy chain assembly: starting from the unique fragment with
#' oh_5 = NA, walk through fragments matching oh_3 of the current fragment
#' to oh_5 of the next. Excludes waste fragments.
#'
#' @param fragments List of fragment lists (from multiple digest_linear calls)
#' @param exclude_sources Character vector of source labels to exclude (default: "waste")
#' @return Character string of the assembled product (top-strand sequence)
ligate_fragments <- function(fragments, exclude_sources = "waste") {
  # Filter out excluded fragments
  keep <- vapply(fragments, function(f) !(f$source %in% exclude_sources), logical(1))
  frags <- fragments[keep]

  if (length(frags) == 0L) {
    stop("No fragments available for ligation after excluding sources: ",
         paste(exclude_sources, collapse = ", "))
  }

  # Find start fragment (oh_5 == NA)
  starts <- which(vapply(frags, function(f) is.na(f$oh_5), logical(1)))
  if (length(starts) == 0L) {
    stop("No start fragment found (no fragment with oh_5 = NA)")
  }
  if (length(starts) > 1L) {
    stop("Ambiguous assembly: ", length(starts),
         " fragments have oh_5 = NA (expected exactly 1)")
  }

  # Greedy walk: match oh_3 of current to oh_5 of next
  chain <- list(frags[[starts[1]]])
  used <- starts[1]

  while (!is.na(chain[[length(chain)]]$oh_3)) {
    target_oh <- chain[[length(chain)]]$oh_3

    # Find fragment whose oh_5 matches
    matches <- which(vapply(frags, function(f) {
      !is.na(f$oh_5) && f$oh_5 == target_oh
    }, logical(1)))
    matches <- setdiff(matches, used)

    if (length(matches) == 0L) {
      stop("Ligation failed: no fragment found with oh_5 = '", target_oh,
           "' to continue the chain")
    }
    if (length(matches) > 1L) {
      stop("Ambiguous ligation: ", length(matches),
           " fragments match oh_5 = '", target_oh, "'")
    }

    chain[[length(chain) + 1L]] <- frags[[matches[1]]]
    used <- c(used, matches[1])
  }

  # Verify all non-waste fragments were used
  if (length(used) != length(frags)) {
    n_unused <- length(frags) - length(used)
    warning("Ligation used ", length(used), " of ", length(frags),
            " non-waste fragments (", n_unused, " unused)")
  }

  # Concatenate bodies to form the product
  paste0(vapply(chain, function(f) f$body, character(1)), collapse = "")
}

#' Simulate the full Golden Gate assembly for one tile
#'
#' Performs the two-step assembly:
#'   Step A (BsaI): oligo + 5'WT gene block(s) + helper → intermediate
#'   Step B (BsmBI): intermediate + 3'WT+PolIII gene block(s) → product
#'
#' @param oligo_seq Complete oligo sequence (top strand)
#' @param helper_insert_seq Helper plasmid insert sequence
#' @param bsai_block_seqs Character vector of 5'WT BsaI gene block sequences
#'   (empty character(0) if tile is at gene start)
#' @param bsmbi_block_seqs Character vector of 3'WT+PolIII BsmBI gene block sequences
#' @return Character string of the assembled product, or an error condition
simulate_tile_assembly <- function(oligo_seq, helper_insert_seq,
                                    bsai_block_seqs, bsmbi_block_seqs) {

  # === Step A: BsaI Reaction ===

  # 1. Digest helper plasmid insert with BsaI
  helper_frags <- digest_linear(helper_insert_seq, "BsaI", source_label = "helper")
  helper_frags <- mark_stuffer_waste(helper_frags)

  # 2. Digest oligo with BsaI
  oligo_frags <- digest_linear(oligo_seq, "BsaI", source_label = "oligo")
  oligo_frags <- mark_terminal_waste(oligo_frags)

  # 3. Digest each 5'WT BsaI gene block
  block_frags_bsai <- list()
  for (i in seq_along(bsai_block_seqs)) {
    bf <- digest_linear(bsai_block_seqs[i], "BsaI",
                         source_label = paste0("bsai_block_", i))
    bf <- mark_terminal_waste(bf)
    block_frags_bsai <- c(block_frags_bsai, bf)
  }

  # 4. Pool all fragments and ligate
  all_bsai_frags <- c(helper_frags, oligo_frags, block_frags_bsai)
  bsai_product <- ligate_fragments(all_bsai_frags, exclude_sources = "waste")

  # === Step B: BsmBI Reaction ===

  # 1. Digest BsaI product with BsmBI
  product_frags <- digest_linear(bsai_product, "BsmBI", source_label = "bsai_product")
  product_frags <- mark_stuffer_waste(product_frags)

  # 2. Digest each 3'WT+PolIII BsmBI gene block
  block_frags_bsmbi <- list()
  for (i in seq_along(bsmbi_block_seqs)) {
    bf <- digest_linear(bsmbi_block_seqs[i], "BsmBI",
                         source_label = paste0("bsmbi_block_", i))
    bf <- mark_terminal_waste(bf)
    block_frags_bsmbi <- c(block_frags_bsmbi, bf)
  }

  # 3. Pool and ligate
  all_bsmbi_frags <- c(product_frags, block_frags_bsmbi)
  final_product <- ligate_fragments(all_bsmbi_frags, exclude_sources = "waste")

  final_product
}

#' Select junctional variants for targeted assembly simulation
#'
#' For each tile, picks variant positions most vulnerable to assembly errors:
#' the first and last `overlap_codons/2` codon positions (near oh1 and oh2
#' overhangs), plus 1 random interior position. One representative variant
#' per selected position — all AA substitutions at the same position exercise
#' the same assembly path.
#'
#' With default `overlap_codons = 6`: 3 + 3 + 1 = 7 variants per tile.
#'
#' @param tile_var_idx Integer vector of row indices into `variants` for this tile
#' @param variants Data frame of all variants (must have `position` column)
#' @param tile Single-row data frame for this tile (unused, reserved for future use)
#' @param overlap_codons Number of overlap codons at tile boundaries (default 6)
#' @return Integer vector of row indices into `variants` to simulate
select_junctional_variants <- function(tile_var_idx, variants, tile,
                                        overlap_codons = 6L) {
  # Get unique codon positions assigned to this tile, sorted
  positions <- sort(unique(variants$position[tile_var_idx]))
  n_positions <- length(positions)
  n_edge <- overlap_codons %/% 2L  # default: 3

  if (n_positions <= 2L * n_edge + 1L) {
    # Not enough positions to separate edges from interior — use all
    selected_positions <- positions
  } else {
    oh1_positions <- positions[seq_len(n_edge)]
    oh2_positions <- positions[seq(n_positions - n_edge + 1L, n_positions)]
    interior <- setdiff(positions, c(oh1_positions, oh2_positions))
    random_interior <- if (length(interior) > 0L) sample(interior, 1L) else integer(0)
    selected_positions <- c(oh1_positions, oh2_positions, random_interior)
  }

  # For each selected position, pick 1 representative variant
  selected_idx <- integer(length(selected_positions))
  for (i in seq_along(selected_positions)) {
    pos_idx <- tile_var_idx[variants$position[tile_var_idx] == selected_positions[i]]
    selected_idx[i] <- pos_idx[1L]
  }

  selected_idx
}

#' Build expected assembly product from first principles
#'
#' Constructs the exact nucleotide sequence the GG assembly should produce
#' by concatenating known components, without re-simulating digestion/ligation.
#' This serves as an independent oracle for verifying simulate_tile_assembly().
#'
#' Product structure:
#'   helper_left_cap + mutant_CDS + cassette_for_block + oh3 + barcode + helper_right_cap
#'
#' Where:
#'   - helper_left_cap = PaqCI_fwd(star2) + BsaI_fwd recognition + spacer
#'   - helper_right_cap = oh4 + BsaI_rev spacer + recognition + PaqCI_rev(star1)
#'   - cassette_for_block = core_polIII, core_downstream_cassette, or full polIII
#'   - oh3 = 4-nt BsmBI overhang bridging cassette and barcode
#'
#' When tile boundaries are provided, the mutation is applied only to the
#' nucleotides within the tile's mutable region (between oh1 and oh2).
#' Codons that straddle the oh1/mutable or mutable/oh2 boundary will be
#' partially mutated — this matches the physical assembly behavior.
#'
#' @param variant_row Single-row data frame with `position` and `mut_codon`
#' @param barcode Barcode sequence for this variant
#' @param cds Domesticated WT CDS (full length)
#' @param cassette_for_block Cassette content as it appears in gene blocks
#'   (core_polIII when oh3 is derived, or full polIII otherwise)
#' @param oh3 4-nt BsmBI overhang between cassette and barcode
#' @param helper_left_cap Left helper cap body (from BsaI digestion of helper insert)
#' @param helper_right_cap Right helper cap body (from BsaI digestion of helper insert)
#' @param tile_start_nt Tile start position in gene (1-based). When provided
#'   with tile_end_nt, enables partial-overlap-aware mutation.
#' @param tile_end_nt Tile end position in gene (1-based).
#' @param oh_L 4-nt BsaI overhang upstream of ATG (user-specified, external to CDS).
#'   In the assembled product, oh_L appears between helper_left_cap and the CDS.
#'   Default "" for backward compatibility with callers that don't use oh_L.
#' @param upstream_cassette Sequence between oh_L and ATG (default "").
#' @return Character string of the expected assembled product
build_expected_product <- function(variant_row, barcode, cds,
                                    cassette_for_block, oh3,
                                    helper_left_cap, helper_right_cap,
                                    tile_start_nt = NULL, tile_end_nt = NULL,
                                    oh_L = "", upstream_cassette = "") {

  codon_start <- (variant_row$position - 1L) * 3L + 1L

  if (!is.null(tile_start_nt) && !is.null(tile_end_nt)) {
    # The oligo's mutable region covers gene positions [mutable_start, tile_end-4].
    # For tile 1 (tile_start_nt == 1), oh_L is external to the CDS so no front
    # strip is consumed — all positions from 1 are mutable. For other tiles,
    # oh1 (4 nt) is consumed at the 5' end, so mutable starts at tile_start + 4.
    mutable_start <- if (tile_start_nt == 1L) tile_start_nt else tile_start_nt + 4L
    mutable_end <- tile_end_nt - 4L
    gene_chars <- strsplit(cds, "")[[1]]
    mut_chars <- strsplit(variant_row$mut_codon, "")[[1]]
    for (i in 0:2) {
      gene_pos <- codon_start + i
      if (gene_pos >= mutable_start && gene_pos <= mutable_end) {
        gene_chars[gene_pos] <- mut_chars[i + 1L]
      }
    }
    mutant_cds <- paste0(gene_chars, collapse = "")
  } else {
    mutant_cds <- replace_codon(cds, variant_row$position, variant_row$mut_codon)
  }

  # oh_L and upstream_cassette sit between the helper left cap and the CDS in
  # the assembled product. In the old architecture oh_L = CDS[1..4] so it was
  # already implicit in mutant_cds; with the new oh_L architecture oh_L is
  # external to the CDS and must be included explicitly here.
  paste0(helper_left_cap, oh_L, upstream_cassette, mutant_cds, cassette_for_block, oh3, barcode, helper_right_cap)
}

#' Strict nucleotide-level verification of an assembled product
#'
#' Performs exhaustive checks beyond the coarse grepl-based verify_assembly_product().
#' Catches off-by-one errors, duplicated elements, residual enzyme sites, PaqCI
#' flank issues, and length mismatches.
#'
#' @param product Character string of the actual assembled product
#' @param expected Character string of the expected product (from build_expected_product)
#' @param expected_cds Domesticated WT CDS
#' @param mut_position Codon position of the mutation (1-based)
#' @param mut_codon Mutant codon sequence
#' @param cassette_for_block Cassette content as it appears in gene blocks
#' @param barcode Barcode sequence
#' @param oh3 4-nt BsmBI overhang between cassette and barcode
#' @param paqci_star2 PaqCI** overhang (5' end)
#' @param paqci_star1 PaqCI* overhang (3' end)
#' @param helper_left_cap_len Length of the left helper cap (for interior boundary)
#' @param helper_right_cap_len Length of the right helper cap (for interior boundary)
#' @param tile_start_nt Tile start position (1-based) for overlap-aware mutation.
#'   When provided, the duplication check uses the partial mutation that the
#'   assembly actually produces (matching build_expected_product behavior).
#' @param tile_end_nt Tile end position (1-based).
#' @return List with pass (logical) and diagnostic flags
verify_assembly_product_strict <- function(product, expected,
                                            expected_cds, mut_position, mut_codon,
                                            cassette_for_block, barcode, oh3,
                                            paqci_star2, paqci_star1,
                                            helper_left_cap_len, helper_right_cap_len,
                                            tile_start_nt = NULL, tile_end_nt = NULL) {

  # --- Check 1: Exact length ---
  correct_length <- nchar(product) == nchar(expected)

  # --- Check 2: Exact sequence match ---
  exact_match <- identical(product, expected)

  # --- Check 3: No internal enzyme sites ---
  # Check the biological payload (gene + cassette + oh3 + barcode),
  # excluding helper cap regions which contain structural BsaI sites.
  product_len <- nchar(product)
  internal_sites_found <- character(0)
  if (product_len > helper_left_cap_len + helper_right_cap_len) {
    payload <- substring(product,
                          helper_left_cap_len + 1L,
                          product_len - helper_right_cap_len)
    for (enz_name in c("BsaI", "BsmBI", "PaqCI")) {
      sites <- find_enzyme_sites(payload, ENZYMES[[enz_name]]$recog)
      if (nrow(sites) > 0L) {
        internal_sites_found <- c(internal_sites_found, enz_name)
      }
    }
  }
  no_internal_enzyme_sites <- length(internal_sites_found) == 0L

  # --- Check 4: PaqCI flanks correct ---
  paqci_fwd <- orient_enzyme_site("PaqCI", paqci_star2, "forward")
  paqci_rev <- orient_enzyme_site("PaqCI", paqci_star1, "reverse")
  paqci_flanks_present <- startsWith(product, paqci_fwd) && endsWith(product, paqci_rev)

  # --- Check 5: No duplicated elements ---
  # Each key element should appear exactly once in the product.
  # Use overlap-aware mutation when tile boundaries are provided,
  # matching the physical assembly behavior for boundary codons.
  if (!is.null(tile_start_nt) && !is.null(tile_end_nt)) {
    # Tile 1 (tile_start_nt == 1): oh_L is external, no front strip consumed.
    mutable_start <- if (tile_start_nt == 1L) tile_start_nt else tile_start_nt + 4L
    mutable_end <- tile_end_nt - 4L
    codon_start <- (mut_position - 1L) * 3L + 1L
    gene_chars <- strsplit(expected_cds, "")[[1]]
    mut_chars <- strsplit(mut_codon, "")[[1]]
    for (i in 0:2) {
      gene_pos <- codon_start + i
      if (gene_pos >= mutable_start && gene_pos <= mutable_end) {
        gene_chars[gene_pos] <- mut_chars[i + 1L]
      }
    }
    mutant_cds <- paste0(gene_chars, collapse = "")
  } else {
    mutant_cds <- replace_codon(expected_cds, mut_position, mut_codon)
  }
  count_occurrences <- function(pattern, text) {
    m <- gregexpr(pattern, text, fixed = TRUE)[[1]]
    if (length(m) == 1L && m[1L] == -1L) 0L else length(m)
  }
  cds_count <- count_occurrences(mutant_cds, product)
  cassette_count <- count_occurrences(cassette_for_block, product)
  barcode_count <- count_occurrences(barcode, product)
  no_duplications <- (cds_count == 1L) && (cassette_count == 1L) && (barcode_count == 1L)

  # --- Check 6: First mismatch position (diagnostic) ---
  first_mismatch_pos <- NA_integer_
  if (!exact_match) {
    min_len <- min(nchar(product), nchar(expected))
    if (min_len > 0L) {
      prod_chars <- strsplit(substring(product, 1, min_len), "")[[1]]
      exp_chars <- strsplit(substring(expected, 1, min_len), "")[[1]]
      diffs <- which(prod_chars != exp_chars)
      first_mismatch_pos <- if (length(diffs) > 0L) diffs[1] else min_len + 1L
    }
  }

  pass <- correct_length && exact_match && no_internal_enzyme_sites &&
          paqci_flanks_present && no_duplications

  list(
    pass = pass,
    correct_length = correct_length,
    exact_match = exact_match,
    no_internal_enzyme_sites = no_internal_enzyme_sites,
    paqci_flanks_present = paqci_flanks_present,
    no_duplications = no_duplications,
    product_length = nchar(product),
    expected_length = nchar(expected),
    first_mismatch_pos = first_mismatch_pos,
    internal_sites_found = paste(internal_sites_found, collapse = ",")
  )
}

#' Verify an assembled product matches the expected sequence
#'
#' Checks that the product contains the expected mutant CDS, the PolIII
#' promoter (or core_polIII), and the barcode in the correct order.
#'
#' @param product Character string of assembled product
#' @param expected_cds Domesticated WT CDS (before mutation)
#' @param mut_position Codon position of the mutation (1-based)
#' @param mut_codon Mutant codon sequence
#' @param polIII Full PolIII promoter sequence
#' @param barcode Barcode sequence for this variant
#' @param core_polIII Optional truncated PolIII (promoter minus last 5 nt).
#'   If provided, checks for core_polIII instead of full polIII.
#' @return List with pass (logical), and detail flags
verify_assembly_product <- function(product, expected_cds, mut_position, mut_codon,
                                      polIII, barcode, core_polIII = NULL,
                                      upstream_cassette = "") {

  # Build expected mutant CDS
  expected_mut_cds <- replace_codon(expected_cds, mut_position, mut_codon)

  # Check for mutant CDS in product
  has_mut_gene <- grepl(expected_mut_cds, product, fixed = TRUE)

  # Check for PolIII (use core_polIII if provided, to handle promoter-derived oh3)
  polIII_check <- if (!is.null(core_polIII)) core_polIII else polIII
  has_polIII <- grepl(polIII_check, product, fixed = TRUE)

  # Check for barcode
  has_barcode <- grepl(barcode, product, fixed = TRUE)

  # Check upstream_cassette appears before CDS (if non-empty)
  has_upstream <- if (nzchar(upstream_cassette)) {
    uc_pos <- regexpr(upstream_cassette, product, fixed = TRUE)
    gene_pos_check <- regexpr(expected_mut_cds, product, fixed = TRUE)
    (uc_pos > 0L) && (gene_pos_check > 0L) && (uc_pos < gene_pos_check)
  } else {
    TRUE
  }

  # Check order: gene before polIII before barcode
  gene_pos <- regexpr(expected_mut_cds, product, fixed = TRUE)
  polIII_pos <- regexpr(polIII_check, product, fixed = TRUE)
  barcode_pos <- regexpr(barcode, product, fixed = TRUE)
  correct_order <- (gene_pos > 0L) && (polIII_pos > 0L) && (barcode_pos > 0L) &&
                   (gene_pos < polIII_pos) && (polIII_pos < barcode_pos)

  list(
    pass = has_mut_gene && has_polIII && has_barcode && correct_order && has_upstream,
    has_mut_gene = has_mut_gene,
    has_polIII = has_polIII,
    has_barcode = has_barcode,
    has_upstream = has_upstream,
    correct_order = correct_order
  )
}

#' Simulate assembly for multiple tiles across the pipeline
#'
#' For each tile, samples variant(s) and runs simulate_tile_assembly +
#' verify_assembly_product. When strict_verification is TRUE (default),
#' also runs build_expected_product + verify_assembly_product_strict for
#' exhaustive nucleotide-level checks. When targeted_sampling is TRUE
#' (default), selects junctional variants instead of random sampling.
#'
#' @param oligos Data frame from assemble_oligos()
#' @param geneblock_result List from design_wt_geneblocks()
#' @param tiles Data frame of tiles
#' @param variants Data frame of variants (with tile_id)
#' @param barcodes Character vector of barcodes
#' @param cds Domesticated CDS
#' @param polIII PolIII promoter sequence
#' @param assembly_plan Assembly plan from plan_assembly()
#' @param samples_per_tile Number of random variants per tile (when targeted_sampling=FALSE)
#' @param overlap_codons Number of overlap codons at tile boundaries for
#'   junctional variant selection (default 6, gives 3+3+1=7 per tile)
#' @param targeted_sampling Logical; if TRUE (default), use select_junctional_variants()
#'   instead of random sampling
#' @param strict_verification Logical; if TRUE (default), run verify_assembly_product_strict()
#'   in addition to the original verify_assembly_product()
#' @param paqci_star2 PaqCI** overhang (5' end). If NULL, extracted from helper_plasmid.
#' @param paqci_star1 PaqCI* overhang (3' end). If NULL, extracted from helper_plasmid.
#' @return Data frame with tile_id, variant_id, pass, detail columns, and
#'   strict verification columns when enabled
simulate_pipeline_assembly <- function(oligos, geneblock_result, tiles, variants,
                                        barcodes, cds, polIII,
                                        assembly_plan = NULL,
                                        samples_per_tile = 1L,
                                        overlap_codons = 6L,
                                        targeted_sampling = TRUE,
                                        strict_verification = TRUE,
                                        paqci_star2 = NULL,
                                        paqci_star1 = NULL) {

  blocks <- geneblock_result$blocks
  manifests <- geneblock_result$tile_manifests
  helper_insert_seq <- geneblock_result$helper_plasmid$sequence

  # Get core downstream cassette from assembly plan (if available).
  # Priority: core_downstream_cassette (intergene+core_polIII) > core_polIII
  core_polIII <- if (!is.null(assembly_plan) && !is.null(assembly_plan$core_downstream_cassette)) {
    assembly_plan$core_downstream_cassette
  } else if (!is.null(assembly_plan)) {
    assembly_plan$core_polIII
  } else {
    NULL
  }

  # --- Pre-compute strict verification components (once, before tile loop) ---
  cassette_for_block <- NULL
  helper_left_cap <- NULL
  helper_right_cap <- NULL
  oh3 <- NULL

  if (strict_verification) {
    # Cassette content as it appears in gene blocks:
    # core_downstream_cassette (intergene+derived) > core_polIII (derived) > polIII (non-derived)
    cassette_for_block <- core_polIII %||% polIII

    oh3 <- if (!is.null(assembly_plan)) assembly_plan$oh3 else NULL

    # Pre-compute helper caps by BsaI digestion of helper insert
    helper_frags <- digest_linear(helper_insert_seq, "BsaI", source_label = "helper")
    helper_left_cap <- helper_frags[[1]]$body
    helper_right_cap <- helper_frags[[length(helper_frags)]]$body

    # Get PaqCI overhangs from helper plasmid if not provided
    if (is.null(paqci_star2)) paqci_star2 <- geneblock_result$helper_plasmid$paqci_star2
    if (is.null(paqci_star1)) paqci_star1 <- geneblock_result$helper_plasmid$paqci_star1
  }

  results <- list()

  for (t in seq_len(nrow(tiles))) {
    tile_id <- tiles$tile_id[t]

    # Get variants for this tile
    tile_var_idx <- which(variants$tile_id == tile_id)
    if (length(tile_var_idx) == 0L) next

    # Select variants: targeted junctional sampling or random
    sampled_idx <- if (targeted_sampling) {
      select_junctional_variants(tile_var_idx, variants, tiles[t, ], overlap_codons)
    } else {
      n_sample <- min(samples_per_tile, length(tile_var_idx))
      if (n_sample == length(tile_var_idx)) tile_var_idx else sample(tile_var_idx, n_sample)
    }

    # Get BsaI and BsmBI block sequences for this tile from the manifest
    manifest <- manifests[manifests$tile_id == tile_id, , drop = FALSE]
    bsai_names <- if (nzchar(manifest$bsai_parts)) {
      strsplit(manifest$bsai_parts, ";")[[1]]
    } else {
      character(0)
    }
    bsmbi_names <- strsplit(manifest$bsmbi_parts, ";")[[1]]

    bsai_block_seqs <- blocks$sequence[match(bsai_names, blocks$block_name)]
    bsmbi_block_seqs <- blocks$sequence[match(bsmbi_names, blocks$block_name)]

    for (vi in sampled_idx) {
      oligo_seq <- oligos$sequence[vi]
      barcode <- barcodes[vi]

      # Run assembly simulation
      result <- tryCatch({
        product <- simulate_tile_assembly(
          oligo_seq = oligo_seq,
          helper_insert_seq = helper_insert_seq,
          bsai_block_seqs = bsai_block_seqs,
          bsmbi_block_seqs = bsmbi_block_seqs
        )
        upstream_cassette <- if (!is.null(assembly_plan)) {
          assembly_plan$upstream_cassette %||% ""
        } else {
          ""
        }
        verify <- verify_assembly_product(
          product = product,
          expected_cds = cds,
          mut_position = variants$position[vi],
          mut_codon = variants$mut_codon[vi],
          polIII = polIII,
          barcode = barcode,
          core_polIII = core_polIII,
          upstream_cassette = upstream_cassette
        )

        # Strict (nucleotide-level) verification
        strict <- if (strict_verification && !is.null(oh3)) {
          expected_product <- build_expected_product(
            variant_row = variants[vi, , drop = FALSE],
            barcode = barcode,
            cds = cds,
            cassette_for_block = cassette_for_block,
            oh3 = oh3,
            helper_left_cap = helper_left_cap,
            helper_right_cap = helper_right_cap,
            tile_start_nt = tiles$start_nt[t],
            tile_end_nt = tiles$end_nt[t],
            oh_L = if (!is.null(assembly_plan)) assembly_plan$oh_L %||% "" else "",
            upstream_cassette = if (!is.null(assembly_plan)) assembly_plan$upstream_cassette %||% "" else ""
          )
          verify_assembly_product_strict(
            product = product,
            expected = expected_product,
            expected_cds = cds,
            mut_position = variants$position[vi],
            mut_codon = variants$mut_codon[vi],
            cassette_for_block = cassette_for_block,
            barcode = barcode,
            oh3 = oh3,
            paqci_star2 = paqci_star2,
            paqci_star1 = paqci_star1,
            helper_left_cap_len = nchar(helper_left_cap),
            helper_right_cap_len = nchar(helper_right_cap),
            tile_start_nt = tiles$start_nt[t],
            tile_end_nt = tiles$end_nt[t]
          )
        } else {
          list(pass = NA, correct_length = NA, exact_match = NA,
               no_internal_enzyme_sites = NA, paqci_flanks_present = NA,
               no_duplications = NA, product_length = NA_integer_,
               expected_length = NA_integer_, first_mismatch_pos = NA_integer_,
               internal_sites_found = NA_character_)
        }

        list(
          pass = verify$pass,
          has_mut_gene = verify$has_mut_gene,
          has_polIII = verify$has_polIII,
          has_barcode = verify$has_barcode,
          correct_order = verify$correct_order,
          error = NA_character_,
          strict_pass = strict$pass,
          correct_length = strict$correct_length,
          exact_match = strict$exact_match,
          no_internal_enzyme_sites = strict$no_internal_enzyme_sites,
          paqci_flanks_present = strict$paqci_flanks_present,
          no_duplications = strict$no_duplications,
          first_mismatch_pos = strict$first_mismatch_pos
        )
      }, error = function(e) {
        list(
          pass = FALSE,
          has_mut_gene = NA,
          has_polIII = NA,
          has_barcode = NA,
          correct_order = NA,
          error = conditionMessage(e),
          strict_pass = NA,
          correct_length = NA,
          exact_match = NA,
          no_internal_enzyme_sites = NA,
          paqci_flanks_present = NA,
          no_duplications = NA,
          first_mismatch_pos = NA_integer_
        )
      })

      results[[length(results) + 1L]] <- data.frame(
        tile_id = tile_id,
        variant_id = variants$variant_id[vi],
        pass = result$pass,
        has_mut_gene = result$has_mut_gene,
        has_polIII = result$has_polIII,
        has_barcode = result$has_barcode,
        correct_order = result$correct_order,
        error = result$error,
        strict_pass = result$strict_pass,
        correct_length = result$correct_length,
        exact_match = result$exact_match,
        no_internal_enzyme_sites = result$no_internal_enzyme_sites,
        paqci_flanks_present = result$paqci_flanks_present,
        no_duplications = result$no_duplications,
        first_mismatch_pos = result$first_mismatch_pos,
        stringsAsFactors = FALSE
      )
    }
  }

  if (length(results) == 0L) {
    return(data.frame(
      tile_id = integer(0), variant_id = character(0),
      pass = logical(0), has_mut_gene = logical(0),
      has_polIII = logical(0), has_barcode = logical(0),
      correct_order = logical(0), error = character(0),
      strict_pass = logical(0), correct_length = logical(0),
      exact_match = logical(0), no_internal_enzyme_sites = logical(0),
      paqci_flanks_present = logical(0), no_duplications = logical(0),
      first_mismatch_pos = integer(0),
      stringsAsFactors = FALSE
    ))
  }

  do.call(rbind, results)
}
