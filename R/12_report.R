# Created: 2025-02-01
# Last updated: 2026-03-07 — Fix report OH display: use block metadata instead of junction indices
# 12_report.R — Wetlab-compatible Markdown assembly report
# DMS Golden Gate Oligo Pipeline
#
# Generates a bench-ready report after each pipeline run, structured so a
# researcher can use it as a reference when setting up Golden Gate Assembly
# reactions. Includes per-tile component tables, overhang maps, fidelity
# scores, and a gene block order sheet.

#' Generate a wetlab-compatible Markdown assembly report
#'
#' @param gene List with cds, protein, gene_name, n_codons
#' @param cfg Config list from load_config()
#' @param assembly_plan List from plan_assembly()
#' @param geneblock_result List from design_wt_geneblocks()
#' @param oligos Data frame from assemble_oligos()
#' @param variants Data frame with tile assignments
#' @param barcodes Character vector of barcodes
#' @param qc_result List from run_qc_checks()
#' @param scan_result List from scan_enzyme_sites()
#' @param output_dir Output directory path
#' @param barcode_result List from design_barcodes() (optional)
#' @return Path to generated report file (invisible)
generate_report <- function(gene, cfg, assembly_plan, geneblock_result,
                            oligos, variants, barcodes, qc_result,
                            scan_result, output_dir, barcode_result = NULL) {
  if (!dir.exists(output_dir)) dir.create(output_dir, recursive = TRUE)

  tiles <- assembly_plan$tiles
  blocks <- geneblock_result$blocks
  manifests <- geneblock_result$tile_manifests
  helper <- geneblock_result$helper_plasmid

  lines <- character(0)
  add <- function(...) lines <<- c(lines, ...)

  # Header
  add(paste0("# DMS-GG Assembly Report: ", gene$gene_name))
  add("")
  add(paste0("Generated: ", format(Sys.time(), "%Y-%m-%d %H:%M:%S")))
  add("Pipeline: dms-gg-oligo-pipeline (3-Enzyme Architecture: BsaI + BsmBI + PaqCI)")
  add("")
  add("---")
  add("")

  # Section 1: Gene Summary
  add(report_gene_summary(gene, assembly_plan, oligos, variants, blocks, cfg))

  # Section 2: Assembly Architecture Overview
  add(report_architecture(cfg))

  # Section 3: Oligo Pool Summary
  add(report_oligo_summary(oligos, tiles))

  # Section 4: Barcode Design
  add(report_barcode_summary(barcode_result, barcodes, cfg))

  # Section 5: QC Summary
  add(report_qc_summary(qc_result))

  # Section 6: Fixed Overhangs & Helper Plasmid
  add(report_fixed_overhangs(assembly_plan, helper, cfg))

  # Section 7: Per-Tile Assembly Guide
  add("## 7. Per-Tile Assembly Guide")
  add("")
  for (i in seq_len(nrow(tiles))) {
    add(report_tile_guide(i, tiles, assembly_plan, geneblock_result, oligos, variants))
  }

  # Section 8: PaqCI Level 2 Reaction
  add(report_paqci_reaction(cfg))

  # Section 9: Gene Block Order Sheet
  add(report_geneblock_sheet(blocks))

  # Section 10: Domestication Log
  add(report_domestication(scan_result))

  # Section 11: Configuration Parameters
  add(report_config(cfg))

  # Write file
  report_path <- file.path(output_dir, paste0(gene$gene_name, "_assembly_report.md"))
  writeLines(lines, report_path)
  cli::cli_alert_success(paste0("Wrote wetlab assembly report: ", report_path))

  invisible(report_path)
}


# =============================================================================
# SECTION GENERATORS
# =============================================================================

#' Section 1: Gene Summary
report_gene_summary <- function(gene, assembly_plan, oligos, variants, blocks, cfg) {
  tiles <- assembly_plan$tiles
  barcodes_per <- cfg$barcodes_per_variant %||% 1L
  # Use full description for display, unique variant_id for variant count
  display_name <- gene$gene_description %||% gene$gene_name
  n_unique_variants <- length(unique(variants$variant_id))
  oligo_len_range <- if (min(oligos$length) == max(oligos$length)) {
    paste0(min(oligos$length), " nt")
  } else {
    paste0(min(oligos$length), "-", max(oligos$length), " nt")
  }
  df <- data.frame(
    Property = c(
      "Gene name", "CDS length", "Protein length", "Number of tiles",
      "Total variants", "Total oligos", "Oligo length range",
      "Gene blocks to order", "Barcodes per variant"
    ),
    Value = c(
      display_name,
      paste0(nchar(gene$cds), " nt (", gene$n_codons, " codons)"),
      paste0(nchar(gene$protein), " aa"),
      nrow(tiles),
      n_unique_variants,
      nrow(oligos),
      oligo_len_range,
      nrow(blocks),
      barcodes_per
    ),
    stringsAsFactors = FALSE
  )
  c("## 1. Gene Summary", "", md_table(df), "")
}

#' Section 2: Assembly Architecture Overview
report_architecture <- function(cfg) {
  barcode_len <- cfg$barcode_length %||% 12L
  c(
    "## 2. Assembly Architecture Overview", "",
    "This pipeline uses a **3-enzyme Golden Gate Assembly** strategy:", "",
    "1. **BsaI Level 1** (37C): Inserts the oligo (mutant tile + barcode) and 5'WT gene block(s) into a helper plasmid.",
    "2. **BsmBI Level 1b** (42C): Inserts 3'WT+PolIII gene block(s) between the tile and barcode.",
    "3. **PaqCI Level 2** (37C): Moves the complete insert from helper plasmid into the destination backbone.", "",
    "### Universal Oligo Structure", "",
    "Every oligo in the pool has the same layout regardless of tile position:", "",
    "```",
    paste0("5'--[BsaI>>]--oh1--[mutable region]--[<<BsmBI]--[BsmBI>>]--barcode--[<<BsaI]--3'"),
    paste0("     7 nt     4 nt    variable          11 nt      11 nt    ", barcode_len, " nt    11 nt"),
    "```", "",
    "### Final Assembled Construct", "",
    "```",
    construct_diagram(cfg),
    "```", ""
  )
}

#' Section 3: Oligo Pool Summary
report_oligo_summary <- function(oligos, tiles) {
  per_tile <- data.frame(
    Tile = integer(nrow(tiles)),
    Codons = character(nrow(tiles)),
    Oligos = integer(nrow(tiles)),
    Length = character(nrow(tiles)),
    stringsAsFactors = FALSE,
    check.names = FALSE
  )
  for (i in seq_len(nrow(tiles))) {
    tid <- tiles$tile_id[i]
    tile_oligos <- oligos[oligos$tile_id == tid, ]
    per_tile$Tile[i] <- tid
    per_tile$Codons[i] <- paste0(tiles$start_codon[i], "-", tiles$end_codon[i])
    per_tile$Oligos[i] <- nrow(tile_oligos)
    if (nrow(tile_oligos) > 0) {
      min_len <- min(tile_oligos$length)
      max_len <- max(tile_oligos$length)
      per_tile$Length[i] <- if (min_len == max_len) {
        paste0(min_len, " nt")
      } else {
        paste0(min_len, "-", max_len, " nt")
      }
    } else {
      per_tile$Length[i] <- "--"
    }
  }
  c(
    "## 3. Oligo Pool Summary", "",
    paste0(
      "**Total oligos:** ", nrow(oligos),
      " | **Length range:** ", min(oligos$length), "-", max(oligos$length), " nt"
    ), "",
    md_table(per_tile), ""
  )
}

#' Section 4: Barcode Design
report_barcode_summary <- function(barcode_result, barcodes, cfg) {
  lines <- character(0)
  add <- function(...) lines <<- c(lines, ...)

  add("## 4. Barcode Design")
  add("")

  # Parameters from unified hierarchical mode
  bc_length <- barcode_result$barcode_length %||% cfg$barcode_length %||% 20L
  prefix_len <- barcode_result$prefix_length %||% cfg$barcode_prefix_length %||% 12L
  suffix_len <- bc_length - prefix_len
  effective_ham <- barcode_result$effective_hamming %||% cfg$min_hamming_distance %||% 3L
  min_ham <- cfg$min_hamming_distance %||% 3L
  barcodes_per <- cfg$barcodes_per_variant %||% 1L

  # --- Design Parameters table ---
  param_names <- c(
    "Mode", "Barcode length", "Prefix length", "Suffix length",
    "Requested min Hamming", "Effective min Hamming",
    "Barcodes per variant"
  )
  param_vals <- c(
    "Unified hierarchical (prefix-suffix)",
    paste0(bc_length, " nt"),
    paste0(prefix_len, " nt"),
    paste0(suffix_len, " nt"),
    as.character(min_ham),
    as.character(effective_ham),
    as.character(barcodes_per)
  )

  param_df <- data.frame(
    Parameter = param_names, Value = param_vals,
    stringsAsFactors = FALSE
  )
  add("### Design Parameters")
  add("")
  add(md_table(param_df))
  add("")

  # --- Pool Statistics table ---
  n_total <- length(barcodes)
  n_unique <- length(unique(barcodes))
  gc_vals <- vapply(barcodes, gc_content, numeric(1))
  gc_range_str <- paste0(
    round(min(gc_vals) * 100, 1), "% - ",
    round(max(gc_vals) * 100, 1), "%"
  )
  gc_mean_str <- paste0(round(mean(gc_vals) * 100, 1), "%")

  compliance_str <- paste0("100% cross-variant (prefix d >= ", effective_ham, ")")

  stat_df <- data.frame(
    Statistic = c(
      "Total barcodes", "Unique barcodes",
      "GC content range", "GC content mean",
      "Hamming guarantee"
    ),
    Value = c(
      n_total, n_unique, gc_range_str, gc_mean_str,
      compliance_str
    ),
    stringsAsFactors = FALSE
  )
  add("### Pool Statistics")
  add("")
  add(md_table(stat_df))
  add("")

  lines
}

#' Section 5: QC Summary
report_qc_summary <- function(qc_result) {
  report <- qc_result$qc_report
  df <- data.frame(
    Check = report$check_name,
    Description = report$desc,
    Result = ifelse(report$pass, "PASS", "FAIL"),
    Detail = report$detail,
    stringsAsFactors = FALSE
  )
  overall <- if (qc_result$qc_pass) "ALL CHECKS PASSED" else "ISSUES FOUND"
  c(
    "## 5. QC Summary", "",
    paste0("**Overall:** ", overall), "",
    md_table(df), ""
  )
}

#' Section 6: Fixed Overhangs & Helper Plasmid
report_fixed_overhangs <- function(assembly_plan, helper, cfg) {
  oh_L <- assembly_plan$oh_L
  oh3 <- assembly_plan$oh3
  oh4 <- assembly_plan$oh4

  oh_df <- data.frame(
    Overhang = c("oh_L", "oh3", "oh4", "paqci_star2", "paqci_star1"),
    Sequence = c(
      oh_L, oh3, oh4,
      cfg$paqci_star2 %||% "NNNN",
      cfg$paqci_star1 %||% "NNNN"
    ),
    Role = c(
      "Gene start (BsaI, all tiles)",
      "Downstream cassette-barcode junction (BsmBI, all tiles)",
      "Barcode-helper junction (BsaI, all tiles)",
      "PaqCI 5' end of insert (Level 2)",
      "PaqCI 3' end of insert (Level 2)"
    ),
    stringsAsFactors = FALSE,
    check.names = FALSE
  )

  helper_lines <- character(0)
  if (nrow(helper) > 0) {
    helper_lines <- c(
      "### Helper Plasmid Insert", "",
      "The helper plasmid provides the backbone for each BsaI Level 1 reaction.", "",
      "```",
      paste0("[PaqCI**]--[BsaI>>", oh_L, "]--STUFFER--[", oh4, "<<BsaI]--[PaqCI*]"),
      "```", "",
      paste0("Insert length: ", helper$length[1], " nt"),
      paste0("oh_L = ", helper$oh_L[1], " (first 4 nt of gene)"),
      paste0("oh_R = ", helper$oh_R[1], " (= oh4, barcode-helper junction)"), ""
    )
  }

  c(
    "## 6. Fixed Overhangs & Helper Plasmid", "",
    "These overhangs are the same across all tile reactions:", "",
    md_table(oh_df), "",
    helper_lines
  )
}

#' Section 7: Per-Tile Assembly Guide (single tile)
report_tile_guide <- function(tile_idx, tiles, assembly_plan, geneblock_result,
                              oligos, variants) {
  tile <- tiles[tile_idx, ]
  n_tiles <- nrow(tiles)
  tid <- tile$tile_id
  tile_len <- tile$end_nt - tile$start_nt + 1L

  manifests <- geneblock_result$tile_manifests
  blocks <- geneblock_result$blocks
  manifest <- manifests[manifests$tile_id == tid, ]

  tile_oligos <- oligos[oligos$tile_id == tid, ]
  tile_variants <- variants[variants$tile_id == tid, ]

  lines <- character(0)
  add <- function(...) lines <<- c(lines, ...)

  add(paste0(
    "### Tile ", tile_idx, " of ", n_tiles,
    " -- Codons ", tile$start_codon, "-", tile$end_codon,
    " (", tile_len, " nt)"
  ))
  add("")

  # Boundary overhang table
  oh_df <- data.frame(
    Position = c("oh1 (5' boundary)", "oh2 (3' boundary)"),
    Sequence = c(tile$oh1_seq, tile$oh2_seq),
    Fidelity = c(
      format_fidelity(tile$oh1_fidelity),
      format_fidelity(tile$oh2_fidelity)
    ),
    stringsAsFactors = FALSE,
    check.names = FALSE
  )
  add("**Boundary overhangs:**")
  add("")
  add(md_table(oh_df))
  add("")
  add(paste0(
    "**Variants:** ", nrow(tile_variants), " mutations, ",
    nrow(tile_oligos), " oligos"
  ))
  add("")

  # --- BsaI Level 1 Reaction ---
  add("#### BsaI Level 1 Reaction (37C)")
  add("")

  # Parse bsai_parts from manifest
  bsai_part_names <- if (nrow(manifest) > 0 && nzchar(manifest$bsai_parts[1])) {
    strsplit(manifest$bsai_parts[1], ";")[[1]]
  } else {
    character(0)
  }

  # Build component table (physical assembly order: 5' → 3')
  comp_rows <- list()
  comp_idx <- 1L

  # 5'WT gene blocks first (physical order)
  if (length(bsai_part_names) == 0) {
    comp_rows[[comp_idx]] <- c(
      comp_idx,
      "5'WT gene block",
      "(none -- tile starts at gene nt 1)",
      "--", "--", "--"
    )
    comp_idx <- comp_idx + 1L
  } else {
    for (j in seq_along(bsai_part_names)) {
      bp <- bsai_part_names[j]
      block_row <- blocks[blocks$block_name == bp, ]
      blen <- if (nrow(block_row) > 0) paste0(block_row$length[1], " nt") else "?"
      # Read overhangs directly from block metadata (correct after dedup/filtering)
      oh_5 <- if (nrow(block_row) > 0) block_row$oh_5[1] else "?"
      oh_3 <- if (nrow(block_row) > 0) block_row$oh_3[1] else "?"
      comp_rows[[comp_idx]] <- c(comp_idx, "5'WT gene block", bp, blen, oh_5, oh_3)
      comp_idx <- comp_idx + 1L
    }
  }

  # Oligo pool
  oligo_range <- if (nrow(tile_oligos) > 0) {
    min_len <- min(tile_oligos$length)
    max_len <- max(tile_oligos$length)
    if (min_len == max_len) paste0(min_len, " nt") else paste0(min_len, "-", max_len, " nt")
  } else {
    "--"
  }
  oligo_oh_5 <- if (length(bsai_part_names) > 0) tile$oh1_seq else assembly_plan$oh_L
  oligo_oh_3 <- assembly_plan$oh4
  comp_rows[[comp_idx]] <- c(
    comp_idx, "Oligo pool",
    paste0("Tile ", tid, " (", nrow(tile_oligos), " oligos)"),
    oligo_range, oligo_oh_5, oligo_oh_3
  )
  comp_idx <- comp_idx + 1L

  # Helper plasmid
  comp_rows[[comp_idx]] <- c(
    comp_idx, "Helper plasmid", "helper_plasmid_insert",
    "--", "--", "--"
  )
  comp_idx <- comp_idx + 1L

  # Enzyme
  comp_rows[[comp_idx]] <- c(
    comp_idx, "Enzyme + buffer", "BsaI-HFv2 + CutSmart",
    "--", "--", "--"
  )

  comp_df <- data.frame(
    do.call(rbind, comp_rows),
    stringsAsFactors = FALSE
  )
  names(comp_df) <- c("#", "Component", "Part name", "Length", "5' OH", "3' OH")

  add("**Components:**")
  add("")
  add(md_table(comp_df))
  add("")

  # BsaI overhang map
  bsai_rxn_fid <- get_reaction_fidelity(assembly_plan, tid, "BsaI")
  bsai_map <- format_bsai_overhang_map(
    oh_L = assembly_plan$oh_L,
    bsai_part_names = bsai_part_names,
    oh1 = tile$oh1_seq,
    oh4 = assembly_plan$oh4,
    blocks = blocks
  )
  add(bsai_map)
  add("")
  if (!is.null(bsai_rxn_fid)) {
    add(paste0(
      "**Set fidelity:** ", format_fidelity(bsai_rxn_fid$set_fidelity),
      " (", bsai_rxn_fid$n_overhangs, " overhangs)"
    ))
  }
  add("")

  # --- BsmBI Level 1b Reaction ---
  add("#### BsmBI Level 1b Reaction (42C)")
  add("")

  # Parse bsmbi_parts from manifest
  bsmbi_part_names <- if (nrow(manifest) > 0 && nzchar(manifest$bsmbi_parts[1])) {
    strsplit(manifest$bsmbi_parts[1], ";")[[1]]
  } else {
    character(0)
  }

  comp_rows2 <- list()
  comp_idx2 <- 1L

  # BsaI product
  comp_rows2[[comp_idx2]] <- c(
    comp_idx2, "BsaI product", "(in helper plasmid)",
    "--", "--", "--"
  )
  comp_idx2 <- comp_idx2 + 1L

  # 3'WT+PolIII gene blocks — only the final sub-block contains PolIII
  if (length(bsmbi_part_names) == 0) {
    comp_rows2[[comp_idx2]] <- c(
      comp_idx2, "3'WT+PolIII block", "(none)",
      "--", "--", "--"
    )
    comp_idx2 <- comp_idx2 + 1L
  } else {
    # Find the index of the last 3'WT block (non-PolIII-only) to label correctly
    last_3wt_idx <- max(
      which(!grepl("^bsmbi_polIII_tile", bsmbi_part_names)),
      0L
    )
    for (bp_idx in seq_along(bsmbi_part_names)) {
      bp <- bsmbi_part_names[bp_idx]
      block_row <- blocks[blocks$block_name == bp, ]
      blen <- if (nrow(block_row) > 0) paste0(block_row$length[1], " nt") else "?"
      # PolIII-only fragment (last tile, no 3'WT gene content)
      if (grepl("^bsmbi_polIII_tile", bp)) {
        label <- "PolIII-only fragment"
        # Final 3'WT sub-block (or single block) — contains PolIII
      } else if (bp_idx == last_3wt_idx || !grepl("_sub", bp)) {
        label <- "3'WT+PolIII block"
        # Non-final sub-block — gene content only, no PolIII
      } else {
        label <- "3'WT block"
      }
      # Read overhangs directly from block metadata (correct after dedup/filtering)
      oh_5 <- if (nrow(block_row) > 0) block_row$oh_5[1] else "?"
      oh_3 <- if (nrow(block_row) > 0) block_row$oh_3[1] else "?"
      comp_rows2[[comp_idx2]] <- c(comp_idx2, label, bp, blen, oh_5, oh_3)
      comp_idx2 <- comp_idx2 + 1L
    }
  }

  # Enzyme
  comp_rows2[[comp_idx2]] <- c(
    comp_idx2, "Enzyme + buffer", "BsmBI-v2 + NEBuffer r3.1",
    "--", "--", "--"
  )

  comp_df2 <- data.frame(
    do.call(rbind, comp_rows2),
    stringsAsFactors = FALSE
  )
  names(comp_df2) <- c("#", "Component", "Part name", "Length", "5' OH", "3' OH")

  add("**Components:**")
  add("")
  add(md_table(comp_df2))
  add("")

  # BsmBI overhang map
  bsmbi_map <- format_bsmbi_overhang_map(
    oh2 = tile$oh2_seq,
    bsmbi_part_names = bsmbi_part_names,
    oh3 = assembly_plan$oh3,
    blocks = blocks
  )
  add(bsmbi_map)
  add("")
  bsmbi_rxn_fid <- get_reaction_fidelity(assembly_plan, tid, "BsmBI")
  if (!is.null(bsmbi_rxn_fid)) {
    add(paste0(
      "**Set fidelity:** ", format_fidelity(bsmbi_rxn_fid$set_fidelity),
      " (", bsmbi_rxn_fid$n_overhangs, " overhangs)"
    ))
  }
  add("")
  add("---")
  add("")

  lines
}

#' Section 8: PaqCI Level 2 Reaction
report_paqci_reaction <- function(cfg) {
  paqci_star2 <- cfg$paqci_star2 %||% "NNNN"
  paqci_star1 <- cfg$paqci_star1 %||% "NNNN"
  c(
    "## 8. PaqCI Level 2 Reaction (37C)", "",
    "The final cloning step transfers the complete insert from the helper plasmid",
    "into the destination backbone.", "",
    "**Components per reaction:**", "",
    "| # | Component | Detail |",
    "| --- | --- | --- |",
    "| 1 | BsmBI product | Complete insert in helper plasmid |",
    "| 2 | Destination backbone | PaqCI-compatible receiving vector |",
    paste0("| 3 | Enzyme + buffer | PaqCI + CutSmart (37C) |"), "",
    "**PaqCI overhangs:**", "",
    paste0("- paqci_star2 (5'): `", paqci_star2, "`"),
    paste0("- paqci_star1 (3'): `", paqci_star1, "`"), "",
    "```",
    paste0("[PaqCI** ", paqci_star2, "]--", construct_diagram_inner(cfg), "--[PaqCI* ", paqci_star1, "]"),
    "```", ""
  )
}

#' Section 9: Gene Block Order Sheet
report_geneblock_sheet <- function(blocks) {
  df <- data.frame(
    `Block name` = blocks$block_name,
    `Length (nt)` = blocks$length,
    `Enzyme type` = blocks$enzyme_type,
    `Gene region` = blocks$gene_region,
    stringsAsFactors = FALSE,
    check.names = FALSE
  )
  # Sort by enzyme type then block name
  df <- df[order(df$`Enzyme type`, df$`Block name`), ]
  rownames(df) <- NULL

  c(
    "## 9. Gene Block Order Sheet", "",
    "Order these gene blocks as synthesized gene fragments (e.g., Twist gene fragments, IDT gBlocks).",
    "Gene blocks are synthesized once and reused across experiments.", "",
    paste0("**Total blocks:** ", nrow(df)), "",
    md_table(df), ""
  )
}

#' Section 10: Domestication Log
report_domestication <- function(scan_result) {
  if (is.null(scan_result) || is.null(scan_result$domestication) ||
    nrow(scan_result$domestication) == 0) {
    return(c(
      "## 10. Domestication Log", "",
      "No endogenous BsaI, BsmBI, or PaqCI sites were found in the gene.",
      "No silent mutations were needed.", ""
    ))
  }

  dom <- scan_result$domestication
  # Build a summary table from the domestication data
  # The exact columns depend on scan_enzyme_sites output
  cols_available <- intersect(
    names(dom),
    c("enzyme", "site_start", "strand", "codon_pos", "original_codon", "new_codon", "aa")
  )
  if (length(cols_available) > 0) {
    df <- dom[, cols_available, drop = FALSE]
  } else {
    df <- dom
  }

  c(
    "## 10. Domestication Log", "",
    paste0(nrow(dom), " endogenous enzyme site(s) were removed via silent mutations:"), "",
    md_table(df), ""
  )
}

#' Section 11: Configuration Parameters
report_config <- function(cfg) {
  params <- data.frame(
    Parameter = c(
      "max_oligo_length", "max_geneblock_length",
      "barcode_length", "min_hamming_distance",
      "barcode_prefix_length", "barcodes_per_variant",
      "overhang_fidelity_threshold", "boundary_method",
      "multi_k_search", "auto_domesticate"
    ),
    Value = c(
      cfg$max_oligo_length %||% 300,
      cfg$max_geneblock_length %||% 1800,
      cfg$barcode_length %||% 12,
      cfg$min_hamming_distance %||% 3,
      cfg$barcode_prefix_length %||% 8,
      cfg$barcodes_per_variant %||% 1,
      cfg$overhang_fidelity_threshold %||% 0.95,
      cfg$boundary_method %||% "dp",
      cfg$multi_k_search %||% TRUE,
      cfg$auto_domesticate %||% TRUE
    ),
    stringsAsFactors = FALSE
  )
  c(
    "## 11. Configuration Parameters", "",
    md_table(params), ""
  )
}


# =============================================================================
# OVERHANG MAP HELPERS
# =============================================================================

#' Build ASCII overhang map for a BsaI reaction
#'
#' Builds the OH chain from block oh_5/oh_3 metadata. Each block's oh_3
#' is the junction to the next block (or oh1 for the last block).
#' Chain: oh_L -> [5'WT blocks] -> oh1 -> [oligo+BC] -> oh4
#'
#' @param oh_L Gene start overhang (first 4 nt of gene)
#' @param bsai_part_names Character vector of BsaI block names for this tile
#' @param oh1 Tile boundary overhang (oh1)
#' @param oh4 Fixed barcode-helper junction overhang
#' @param blocks Data frame of gene blocks (with oh_5, oh_3 columns)
format_bsai_overhang_map <- function(oh_L, bsai_part_names, oh1, oh4,
                                     blocks, ...) {
  # Collect overhangs and segment labels in order
  ohs <- c(oh_L)
  labels <- character(0)

  if (length(bsai_part_names) > 0) {
    if (length(bsai_part_names) > 1) {
      # Multiple sub-blocks — build chain from block metadata
      for (j in seq_along(bsai_part_names)) {
        labels <- c(labels, paste0("5'WT sub", j))
        block_row <- blocks[blocks$block_name == bsai_part_names[j], ]
        if (nrow(block_row) > 0) {
          ohs <- c(ohs, block_row$oh_3[1])
        }
      }
    } else {
      labels <- c(labels, "5'WT block")
      # Single block: oh_3 = oh1
      ohs <- c(ohs, oh1)
    }
  }
  # else: no 5'WT block (tile 1). oh_L == oh1, so just use oh_L already added.

  labels <- c(labels, "oligo+BC")

  # oh4 at end
  ohs <- c(ohs, oh4)

  format_overhang_map(ohs, labels)
}

#' Build ASCII overhang map for a BsmBI reaction
#'
#' Builds the OH chain from block oh_5/oh_3 metadata. Each block's oh_3
#' is the junction to the next block (or oh3 for the last block).
#' Chain: oh2 -> [3'WT/PolIII blocks] -> oh3
#'
#' @param oh2 Tile boundary overhang (oh2)
#' @param bsmbi_part_names Character vector of BsmBI block names for this tile
#' @param oh3 Fixed downstream cassette-barcode junction overhang
#' @param blocks Data frame of gene blocks (with oh_5, oh_3 columns)
format_bsmbi_overhang_map <- function(oh2, bsmbi_part_names, oh3,
                                      blocks, ...) {
  ohs <- c(oh2)
  labels <- character(0)

  if (length(bsmbi_part_names) > 0) {
    if (length(bsmbi_part_names) > 1) {
      # Multiple sub-blocks — build chain from block metadata
      last_3wt_idx <- max(which(!grepl("^bsmbi_polIII_tile", bsmbi_part_names)), 0L)
      for (j in seq_along(bsmbi_part_names)) {
        is_polIII_only <- grepl("^bsmbi_polIII_tile", bsmbi_part_names[j])
        if (is_polIII_only) {
          labels <- c(labels, "PolIII")
        } else if (j == last_3wt_idx) {
          labels <- c(labels, paste0("3'WT+PolIII sub", j))
        } else {
          labels <- c(labels, paste0("3'WT sub", j))
        }
        block_row <- blocks[blocks$block_name == bsmbi_part_names[j], ]
        if (nrow(block_row) > 0) {
          ohs <- c(ohs, block_row$oh_3[1])
        }
      }
    } else {
      is_polIII_only <- grepl("^bsmbi_polIII_tile", bsmbi_part_names[1])
      labels <- c(labels, if (is_polIII_only) "PolIII" else "3'WT+PolIII")
      # Single block: oh_3 = oh3
      ohs <- c(ohs, oh3)
    }
  } else {
    # No blocks (shouldn't happen normally)
    ohs <- c(ohs, oh3)
  }

  format_overhang_map(ohs, labels)
}


# =============================================================================
# CONSTRUCT DIAGRAM HELPERS
# =============================================================================

#' Build the inner construct diagram (gene--elements--barcode)
#' @param cfg Config list
#' @return Character string
construct_diagram_inner <- function(cfg) {
  parts <- "[gene+mutation]"
  if (length(cfg$intergene_elements) > 0) {
    for (elem in cfg$intergene_elements) {
      parts <- paste0(parts, "--[", elem$name, "]")
    }
  }
  paste0(parts, "--[PolIII]--[barcode]")
}

#' Build the full construct diagram with PaqCI sites
#' @param cfg Config list
#' @return Character string
construct_diagram <- function(cfg) {
  paste0("[PaqCI**]--", construct_diagram_inner(cfg), "--[PaqCI*]")
}


# =============================================================================
# FORMATTING HELPERS
# =============================================================================

#' Format a data frame as a Markdown table
#' @param df Data frame to format
#' @return Character vector of Markdown table lines
md_table <- function(df) {
  headers <- names(df)
  # Convert all to character
  for (j in seq_along(df)) {
    df[[j]] <- as.character(df[[j]])
  }

  # Column widths
  widths <- vapply(seq_along(headers), function(j) {
    max(nchar(headers[j]), max(nchar(df[[j]]), na.rm = TRUE), 3L)
  }, integer(1))

  # Header line
  header_line <- paste0(
    "| ",
    paste(vapply(seq_along(headers), function(j) {
      pad_right(headers[j], widths[j])
    }, character(1)), collapse = " | "),
    " |"
  )

  # Separator
  sep_line <- paste0(
    "| ",
    paste(vapply(widths, function(w) {
      paste(rep("-", w), collapse = "")
    }, character(1)), collapse = " | "),
    " |"
  )

  # Data rows
  data_lines <- character(nrow(df))
  for (i in seq_len(nrow(df))) {
    data_lines[i] <- paste0(
      "| ",
      paste(vapply(seq_along(headers), function(j) {
        val <- df[[j]][i]
        if (is.na(val)) val <- "--"
        pad_right(val, widths[j])
      }, character(1)), collapse = " | "),
      " |"
    )
  }

  c(header_line, sep_line, data_lines)
}

#' Build an ASCII overhang connection map
#'
#' @param ohs Character vector of overhang sequences (N+1 for N segments)
#' @param labels Character vector of segment labels (N segments between overhangs)
#' @return Character vector of lines (inside a code block)
format_overhang_map <- function(ohs, labels) {
  n_oh <- length(ohs)
  n_seg <- length(labels)

  # Build diagram and track overhang start positions (0-based)
  diagram <- ""
  oh_positions <- integer(n_oh)

  for (i in seq_len(n_oh)) {
    oh_positions[i] <- nchar(diagram)
    diagram <- paste0(diagram, "[", ohs[i], "]")
    if (i <= n_seg) {
      diagram <- paste0(diagram, "----", labels[i], "----")
    }
  }

  # Build aligned annotation line with overhang sequences
  seq_line <- ""

  for (i in seq_len(n_oh)) {
    target_pos <- oh_positions[i]
    oh_text <- paste0(" ", ohs[i], " ")

    # Pad to target position
    while (nchar(seq_line) < target_pos) seq_line <- paste0(seq_line, " ")

    seq_line <- paste0(seq_line, oh_text)
  }

  c(
    "```",
    paste0("  ", diagram),
    paste0("  ", seq_line),
    "```"
  )
}

#' Format a fidelity value
format_fidelity <- function(val) {
  if (is.null(val) || is.na(val)) {
    return("--")
  }
  sprintf("%.4f", val)
}

#' Pad a string to the right
pad_right <- function(x, width) {
  spaces <- max(0, width - nchar(x))
  paste0(x, paste(rep(" ", spaces), collapse = ""))
}

#' Get reaction fidelity for a specific tile and reaction type
get_reaction_fidelity <- function(assembly_plan, tile_id, reaction_type) {
  if (is.null(assembly_plan$reaction_fidelity)) {
    return(NULL)
  }
  rxn <- assembly_plan$reaction_fidelity
  row <- rxn[rxn$tile_id == tile_id & rxn$reaction_type == reaction_type, , drop = FALSE]
  if (nrow(row) == 0) {
    return(NULL)
  }
  row[1, ]
}

#' Get reaction overhangs as character vector
get_reaction_overhangs <- function(assembly_plan, tile_id, reaction_type) {
  rxn_fid <- get_reaction_fidelity(assembly_plan, tile_id, reaction_type)
  if (is.null(rxn_fid)) {
    return(character(0))
  }
  strsplit(rxn_fid$overhangs, ";")[[1]]
}
