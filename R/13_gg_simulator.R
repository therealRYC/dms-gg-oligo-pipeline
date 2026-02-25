# Created: 2026-02-21
# Last updated: 2026-02-25 — Support downstream_cassette (intergene + polIII) in verification
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
#   verify_assembly_product() — Check product matches expected gene + barcode
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
                                      polIII, barcode, core_polIII = NULL) {

  # Build expected mutant CDS
  expected_mut_cds <- replace_codon(expected_cds, mut_position, mut_codon)

  # Check for mutant CDS in product
  has_mut_gene <- grepl(expected_mut_cds, product, fixed = TRUE)

  # Check for PolIII (use core_polIII if provided, to handle promoter-derived oh3)
  polIII_check <- if (!is.null(core_polIII)) core_polIII else polIII
  has_polIII <- grepl(polIII_check, product, fixed = TRUE)

  # Check for barcode
  has_barcode <- grepl(barcode, product, fixed = TRUE)

  # Check order: gene before polIII before barcode
  gene_pos <- regexpr(expected_mut_cds, product, fixed = TRUE)
  polIII_pos <- regexpr(polIII_check, product, fixed = TRUE)
  barcode_pos <- regexpr(barcode, product, fixed = TRUE)
  correct_order <- (gene_pos > 0L) && (polIII_pos > 0L) && (barcode_pos > 0L) &&
                   (gene_pos < polIII_pos) && (polIII_pos < barcode_pos)

  list(
    pass = has_mut_gene && has_polIII && has_barcode && correct_order,
    has_mut_gene = has_mut_gene,
    has_polIII = has_polIII,
    has_barcode = has_barcode,
    correct_order = correct_order
  )
}

#' Simulate assembly for multiple tiles across the pipeline
#'
#' For each tile, samples variant(s) and runs simulate_tile_assembly +
#' verify_assembly_product. Reports results per tile.
#'
#' @param oligos Data frame from assemble_oligos()
#' @param geneblock_result List from design_wt_geneblocks()
#' @param tiles Data frame of tiles
#' @param variants Data frame of variants (with tile_id)
#' @param barcodes Character vector of barcodes
#' @param cds Domesticated CDS
#' @param polIII PolIII promoter sequence
#' @param assembly_plan Assembly plan from plan_assembly()
#' @param samples_per_tile Number of variants to test per tile (default 1)
#' @return Data frame with tile_id, variant_id, pass, and detail columns
simulate_pipeline_assembly <- function(oligos, geneblock_result, tiles, variants,
                                        barcodes, cds, polIII,
                                        assembly_plan = NULL,
                                        samples_per_tile = 1L) {

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

  results <- list()

  for (t in seq_len(nrow(tiles))) {
    tile_id <- tiles$tile_id[t]

    # Get variants for this tile
    tile_var_idx <- which(variants$tile_id == tile_id)
    if (length(tile_var_idx) == 0L) next

    # Sample variants
    n_sample <- min(samples_per_tile, length(tile_var_idx))
    sampled_idx <- if (n_sample == length(tile_var_idx)) {
      tile_var_idx
    } else {
      sample(tile_var_idx, n_sample)
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
        verify <- verify_assembly_product(
          product = product,
          expected_cds = cds,
          mut_position = variants$position[vi],
          mut_codon = variants$mut_codon[vi],
          polIII = polIII,
          barcode = barcode,
          core_polIII = core_polIII
        )
        list(
          pass = verify$pass,
          has_mut_gene = verify$has_mut_gene,
          has_polIII = verify$has_polIII,
          has_barcode = verify$has_barcode,
          correct_order = verify$correct_order,
          error = NA_character_
        )
      }, error = function(e) {
        list(
          pass = FALSE,
          has_mut_gene = NA,
          has_polIII = NA,
          has_barcode = NA,
          correct_order = NA,
          error = conditionMessage(e)
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
      stringsAsFactors = FALSE
    ))
  }

  do.call(rbind, results)
}
