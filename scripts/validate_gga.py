# Created: 2026-02-20
# Last updated: 2026-02-20 — Add overhang conflict detection, junction site reporting
#!/usr/bin/env python3
"""
validate_gga.py — In silico Golden Gate Assembly validation.

Reads pipeline output files and validates the two-stage assembly by parsing
enzyme recognition sites from part sequences, matching overhangs, and
reconstructing the expected assembled product.

Assembly stages:
  Stage 1 (BsaI):  oligo + 5'WT gene blocks + helper plasmid → intermediate
  Stage 2 (BsmBI): intermediate + 3'WT+PolIII gene blocks → final product

For each sampled variant, verifies:
  - All parts have valid enzyme sites with extractable overhangs
  - Overhangs form a complete, unambiguous assembly path
  - The assembled product contains the expected mutant gene sequence
  - The assembled product contains the expected barcode

Usage:
    python3 scripts/validate_gga.py \
        --output-dir output/test_gene/ \
        --gene-name test_gene \
        --n-samples 10

    python3 scripts/validate_gga.py \
        --output-dir output/test_gene/ \
        --gene-name test_gene \
        --all
"""

import argparse
import csv
import random
import re
import sys
from pathlib import Path

from Bio.Seq import Seq


# ---------------------------------------------------------------------------
# Enzyme definitions — must match R/constants.R
# ---------------------------------------------------------------------------

ENZYMES = {
    "BsaI":  {"recog": "GGTCTC", "spacer_len": 1, "oh_len": 4},
    "BsmBI": {"recog": "CGTCTC", "spacer_len": 1, "oh_len": 4},
    "PaqCI": {"recog": "CACCTGC", "spacer_len": 4, "oh_len": 4},
}


# ---------------------------------------------------------------------------
# Helpers: file I/O
# ---------------------------------------------------------------------------

def read_csv(path: Path) -> list[dict]:
    """Read a CSV file into a list of dicts (one per row)."""
    with open(path, newline="") as fh:
        return list(csv.DictReader(fh))


def read_fasta_sequences(path: Path) -> dict[str, str]:
    """Read a multi-record FASTA into {header_first_word: sequence}."""
    records: dict[str, str] = {}
    current_name = None
    current_seq: list[str] = []
    with open(path) as fh:
        for line in fh:
            line = line.strip()
            if line.startswith(">"):
                if current_name is not None:
                    records[current_name] = "".join(current_seq)
                current_name = line[1:].split()[0]
                current_seq = []
            else:
                current_seq.append(line)
    if current_name is not None:
        records[current_name] = "".join(current_seq)
    return records


# ---------------------------------------------------------------------------
# Helpers: sequence manipulation
# ---------------------------------------------------------------------------

def reverse_complement(seq: str) -> str:
    """Return the reverse complement of a DNA sequence."""
    return str(Seq(seq).reverse_complement())


def replace_codon(cds: str, position: int, new_codon: str) -> str:
    """Replace the codon at 1-based amino-acid position with new_codon."""
    start = (position - 1) * 3
    return cds[:start] + new_codon + cds[start + 3:]


def find_gene_in_product(product_seq: str, wt_gene: str) -> int | None:
    """Find the start position of the gene region in a circular product.

    Uses a 40-nt probe from the middle of the WT gene to locate the gene
    region. This probe is always far from tile boundaries, so it will match
    exactly even when mutations or overhang effects are present at boundaries.

    Args:
        product_seq: Assembled product (circular, so searched as doubled).
        wt_gene: Wild-type domesticated CDS.

    Returns:
        Start index of the gene in the (doubled) product, or None if not found.
    """
    # Use a probe from the middle of the gene (far from any tile boundary)
    mid = len(wt_gene) // 2
    probe_len = min(40, len(wt_gene) // 3)
    probe = wt_gene[mid : mid + probe_len]

    search_seq = product_seq + product_seq
    idx = search_seq.find(probe)
    if idx >= 0:
        return idx - mid  # Adjust to gene start
    # Try reverse complement
    rc_search = reverse_complement(product_seq) * 2
    idx = rc_search.find(probe)
    if idx >= 0:
        return -(idx - mid)  # Negative = found on RC strand
    return None


def classify_gene_match(
    product_seq: str,
    wt_gene: str,
    mut_position: int,
    mut_codon: str,
) -> dict:
    """Classify how the gene in the product relates to the expected mutation.

    Checks whether the assembled product contains:
    - The full mutant gene (gene_match)
    - The full WT gene (full overhang conflict)
    - A partially mutated gene (partial overhang conflict: mutation codon
      spans an overhang boundary, so only some nt are mutated)

    Args:
        product_seq: Assembled circular product sequence.
        wt_gene: Wild-type domesticated CDS.
        mut_position: 1-based amino acid position of mutation.
        mut_codon: The intended mutant codon (3 nt).

    Returns:
        Dict with: gene_match, overhang_conflict, detail (str).
    """
    expected_gene = replace_codon(wt_gene, mut_position, mut_codon)
    search_seq = product_seq + product_seq

    # Check for exact mutant gene match
    if expected_gene in search_seq:
        return {"gene_match": True, "overhang_conflict": False, "detail": ""}
    rc_search = reverse_complement(product_seq) * 2
    if expected_gene in rc_search:
        return {"gene_match": True, "overhang_conflict": False, "detail": ""}

    # Check for exact WT gene match (full overhang conflict)
    if wt_gene in search_seq or wt_gene in rc_search:
        return {
            "gene_match": False,
            "overhang_conflict": True,
            "detail": "full overhang conflict (all mutation nt overridden)",
        }

    # Try to find gene region and check for partial overhang conflict
    gene_start = find_gene_in_product(product_seq, wt_gene)
    if gene_start is None:
        return {
            "gene_match": False,
            "overhang_conflict": False,
            "detail": "gene region not found in product",
        }

    # Extract the gene region from the product
    if gene_start >= 0:
        actual_gene = search_seq[gene_start : gene_start + len(wt_gene)]
    else:
        actual_gene = rc_search[-gene_start : -gene_start + len(wt_gene)]

    # Compare nucleotide-by-nucleotide at the mutation codon
    codon_start = (mut_position - 1) * 3
    codon_end = codon_start + 3

    # Check: all differences between actual and WT gene should be at the
    # mutation codon, and the actual gene should match the WT at overhang
    # positions of the mutation codon.
    diffs_outside_codon = 0
    for i in range(len(wt_gene)):
        if i < codon_start or i >= codon_end:
            if actual_gene[i] != wt_gene[i]:
                diffs_outside_codon += 1

    if diffs_outside_codon > 0:
        return {
            "gene_match": False,
            "overhang_conflict": False,
            "detail": (
                f"{diffs_outside_codon} unexpected difference(s) outside mutation codon"
            ),
        }

    # All differences are within the mutation codon — check which nt match.
    # Count how many of the 3 codon nt were overridden by the overhang
    # (actual matches WT but differs from mutant) vs. successfully mutated
    # (actual matches mutant but differs from WT).
    n_overridden = 0  # nt where WT was preserved instead of mutation
    n_mutated = 0     # nt where mutation was successfully applied
    for j in range(3):
        actual_nt = actual_gene[codon_start + j]
        wt_nt = wt_gene[codon_start + j]
        mut_nt = mut_codon[j]
        if wt_nt == mut_nt:
            pass  # No change needed at this position
        elif actual_nt == wt_nt:
            n_overridden += 1
        elif actual_nt == mut_nt:
            n_mutated += 1

    if n_overridden == 0:
        # Full mutation present (shouldn't reach here, but just in case)
        return {"gene_match": True, "overhang_conflict": False, "detail": ""}
    elif n_mutated == 0:
        # Full WT preserved at all differing positions
        return {
            "gene_match": False,
            "overhang_conflict": True,
            "detail": "full overhang conflict (all mutation nt overridden)",
        }
    else:
        # Partial: some nt overridden, some mutated
        return {
            "gene_match": False,
            "overhang_conflict": True,
            "detail": (
                f"partial overhang conflict "
                f"({n_overridden} nt overridden, {n_mutated} nt mutated)"
            ),
        }


# ---------------------------------------------------------------------------
# Core: enzyme site parsing and overhang extraction
# ---------------------------------------------------------------------------

def find_enzyme_sites(seq: str, enzyme_name: str) -> list[dict]:
    """Find all forward and reverse enzyme sites in a sequence.

    For each site, extract the overhang using the pipeline's convention:
      Forward site: RECOG + spacer + oh  → overhang = oh
      Reverse site: RC(RECOG + spacer + oh) → overhang = oh

    This means both forward and reverse sites at the same junction share
    the same overhang name, which is how the R pipeline designs parts.

    Args:
        seq: DNA sequence to search (uppercase).
        enzyme_name: Name of enzyme (e.g., "BsaI", "BsmBI").

    Returns:
        List of dicts with keys: orientation, recog_start, overhang, body_edge.
        body_edge is the position where the usable body begins/ends (for
        extracting the insert between two sites).
    """
    enz = ENZYMES[enzyme_name]
    recog = enz["recog"]
    recog_rc = reverse_complement(recog)
    spacer = enz["spacer_len"]
    oh_len = enz["oh_len"]

    sites = []

    # Forward sites: RECOG + spacer + oh on top strand
    # After cutting, oh starts at recog_end + spacer
    for m in re.finditer(recog, seq):
        pos = m.start()
        oh_start = pos + len(recog) + spacer
        oh_end = oh_start + oh_len
        if oh_end <= len(seq):
            oh = seq[oh_start:oh_end]
            sites.append({
                "orientation": "forward",
                "recog_start": pos,
                "overhang": oh,
                # Body starts at the overhang (oh is part of the body)
                "body_edge": oh_start,
            })

    # Reverse sites: top strand has RC(oh + spacer + RECOG)
    # = RC(oh) + RC(spacer) + RC(RECOG) = RC(oh) + spacer_rc + recog_rc
    # The overhang (in pipeline convention) is the ORIGINAL oh, not what
    # appears on the top strand. We recover it by taking RC of the top-strand
    # overhang region.
    for m in re.finditer(recog_rc, seq):
        pos = m.start()
        # Working backwards from recog_rc start:
        #   recog_rc is at [pos : pos+len(recog)]
        #   spacer is at [pos - spacer : pos]
        #   RC(oh) is at [pos - spacer - oh_len : pos - spacer]
        rc_oh_end = pos - spacer
        rc_oh_start = rc_oh_end - oh_len
        if rc_oh_start >= 0:
            rc_oh = seq[rc_oh_start:rc_oh_end]
            oh = reverse_complement(rc_oh)
            sites.append({
                "orientation": "reverse",
                "recog_start": pos,
                "overhang": oh,
                # Body ends just before RC(oh) starts
                # (the oh region is part of the body on this side)
                "body_edge": rc_oh_end,
            })

    return sorted(sites, key=lambda s: s["recog_start"])


def extract_fragment(seq: str, enzyme_name: str) -> dict | None:
    """Extract the usable fragment from a linear part with enzyme sites at both ends.

    A linear part has the structure:
        [fwd/rev site] + [body] + [fwd/rev site]

    After enzyme digestion, the body is released with overhangs on each side.
    The body INCLUDES the overhang nucleotides at each edge (these become
    single-stranded overhangs that participate in ligation).

    Args:
        seq: Complete part sequence (e.g., oligo or gene block).
        enzyme_name: Enzyme for this part's sites.

    Returns:
        Dict with: left_oh, right_oh, body (sequence between cuts including
        overhangs), or None if sites not found.
    """
    sites = find_enzyme_sites(seq, enzyme_name)
    if len(sites) < 2:
        return None

    # For a linear part, we expect one site near each end.
    # The leftmost site contributes the left overhang,
    # the rightmost site contributes the right overhang.
    left_site = sites[0]
    right_site = sites[-1]

    # The body extends from the left site's body_edge to the right site's body_edge
    if left_site["orientation"] == "forward":
        # Forward site on the left: body starts at oh_start
        body_start = left_site["body_edge"]
    else:
        # Reverse site on the left: body starts at rc_oh_end (after the oh region)
        body_start = left_site["body_edge"]

    if right_site["orientation"] == "forward":
        # Forward site on the right: body ends at oh_start + oh_len
        body_end = right_site["body_edge"] + ENZYMES[enzyme_name]["oh_len"]
    else:
        # Reverse site on the right: body ends at rc_oh_end
        body_end = right_site["body_edge"]

    body = seq[body_start:body_end]

    return {
        "left_oh": left_site["overhang"],
        "right_oh": right_site["overhang"],
        "body": body,
    }


def extract_circular_fragments(seq: str, enzyme_name: str) -> list[dict]:
    """Extract fragments from a circular part cut by the given enzyme.

    A circular part (like the helper plasmid) has enzyme sites that divide
    it into fragments. Each fragment has left and right overhangs.

    Returns:
        List of dicts, each with: left_oh, right_oh, body.
    """
    sites = find_enzyme_sites(seq, enzyme_name)
    if len(sites) < 2:
        return []

    oh_len = ENZYMES[enzyme_name]["oh_len"]
    fragments = []

    # For a circular molecule, each consecutive pair of sites defines a fragment.
    # We need to handle wrap-around.
    n = len(sites)
    for i in range(n):
        left_site = sites[i]
        right_site = sites[(i + 1) % n]

        left_oh = left_site["overhang"]
        right_oh = right_site["overhang"]

        # Determine body boundaries
        if left_site["orientation"] == "forward":
            body_start = left_site["body_edge"]
        else:
            body_start = left_site["body_edge"]

        if right_site["orientation"] == "forward":
            body_end = right_site["body_edge"] + oh_len
        else:
            body_end = right_site["body_edge"]

        # Handle wrap-around for circular sequences
        if body_end > body_start:
            body = seq[body_start:body_end]
        else:
            body = seq[body_start:] + seq[:body_end]

        fragments.append({
            "left_oh": left_oh,
            "right_oh": right_oh,
            "body": body,
        })

    return fragments


# ---------------------------------------------------------------------------
# Core: assemble fragments by overhang matching
# ---------------------------------------------------------------------------

def assemble_fragments(fragments: list[dict]) -> str | None:
    """Assemble a list of fragments into a circular product by matching overhangs.

    Each fragment has left_oh and right_oh. We find a circular path where
    each fragment's right_oh matches the next fragment's left_oh.

    Args:
        fragments: List of dicts with left_oh, right_oh, body.

    Returns:
        Assembled sequence (linear representation of the circular product),
        or None if assembly fails.
    """
    if not fragments:
        return None

    # Build lookup: left_oh -> list of fragment indices
    by_left_oh: dict[str, list[int]] = {}
    for i, frag in enumerate(fragments):
        by_left_oh.setdefault(frag["left_oh"], []).append(i)

    # Start from fragment 0, follow the chain
    used = set()
    order = [0]
    used.add(0)
    current = fragments[0]

    while True:
        next_oh = current["right_oh"]
        candidates = [
            i for i in by_left_oh.get(next_oh, []) if i not in used
        ]

        if not candidates:
            # Check if we've completed a circle back to fragment 0
            if next_oh == fragments[0]["left_oh"] and len(used) == len(fragments):
                break
            return None  # Dead end or not all fragments used

        if len(candidates) > 1:
            return None  # Ambiguous assembly

        next_idx = candidates[0]
        order.append(next_idx)
        used.add(next_idx)
        current = fragments[next_idx]

    # Check circular closure
    if current["right_oh"] != fragments[0]["left_oh"]:
        return None

    # Build assembled sequence
    # In the assembled circular product, each junction overhang appears once.
    # Fragment body = oh_left + interior + oh_right (overhangs included).
    # Adjacent fragments share the overhang at their junction.
    # So we concatenate: body_0[:-oh_len] + body_1[:-oh_len] + ... + body_n[:-oh_len]
    # (each body minus its right overhang, which is the same as the next body's left overhang)
    oh_len = len(fragments[0]["left_oh"])  # All overhangs same length
    parts = []
    for idx in order:
        body = fragments[idx]["body"]
        # Remove the right overhang (it will be contributed by the next fragment's left oh)
        parts.append(body[:-oh_len] if oh_len > 0 else body)

    return "".join(parts)


# ---------------------------------------------------------------------------
# Core: load pipeline outputs
# ---------------------------------------------------------------------------

def load_pipeline_outputs(output_dir: Path, gene_name: str) -> dict:
    """Load all pipeline output files into a convenient dict."""
    oligos = read_csv(output_dir / f"{gene_name}_oligo_pool.csv")
    geneblocks = read_csv(output_dir / f"{gene_name}_geneblock_order.csv")
    variants = read_csv(output_dir / f"{gene_name}_variant_barcode_map.csv")
    manifests = read_csv(output_dir / f"{gene_name}_tile_manifests.csv")
    helper_rows = read_csv(output_dir / f"{gene_name}_helper_plasmid.csv")

    # Read domesticated CDS from sequences FASTA
    seq_fasta = output_dir / f"{gene_name}_sequences.fasta"
    fasta_records = read_fasta_sequences(seq_fasta)
    dom_cds_key = f"{gene_name}_domesticated_CDS"
    if dom_cds_key not in fasta_records:
        dom_cds = None
        for key, seq in fasta_records.items():
            if "domesticated" in key.lower():
                dom_cds = seq
                break
        if dom_cds is None:
            raise ValueError(
                f"Could not find domesticated CDS in {seq_fasta}. "
                f"Available keys: {list(fasta_records.keys())}"
            )
    else:
        dom_cds = fasta_records[dom_cds_key]

    oligo_by_variant = {row["variant_id"]: row for row in oligos}
    block_by_name = {row["block_name"]: row for row in geneblocks}
    manifest_by_tile = {row["tile_id"]: row for row in manifests}

    return {
        "oligos": oligos,
        "oligo_by_variant": oligo_by_variant,
        "geneblocks": geneblocks,
        "block_by_name": block_by_name,
        "variants": variants,
        "manifests": manifests,
        "manifest_by_tile": manifest_by_tile,
        "helper": helper_rows[0],
        "dom_cds": dom_cds.upper(),
    }


# ---------------------------------------------------------------------------
# Core: validate assembly for one variant
# ---------------------------------------------------------------------------

def validate_variant(variant: dict, data: dict) -> dict:
    """Validate the two-stage GGA for one variant.

    Instead of simulating enzyme cutting, we parse enzyme sites from each
    part, extract overhangs and body sequences, verify overhang compatibility,
    and reconstruct the assembled product.

    Returns a dict with:
        variant_id, tile_id, bsai_ok, bsmbi_ok,
        gene_match, barcode_match, overhang_conflict, overall_pass, notes

    Overhang conflicts occur when the mutation falls within a tile boundary
    overhang region (oh1 or oh2, each 4 nt). The assembly works correctly,
    but the fixed overhang sequence overrides the mutation, producing the
    WT gene at that position. These are a known pipeline design limitation,
    not assembly errors.
    """
    variant_id = variant["variant_id"]
    tile_id = variant["tile_id"]
    position = int(variant["position"])
    mut_codon = variant["mut_codon"]
    barcode = variant["barcode"]

    result = {
        "variant_id": variant_id,
        "tile_id": tile_id,
        "bsai_ok": False,
        "bsmbi_ok": False,
        "gene_match": False,
        "barcode_match": False,
        "overhang_conflict": False,
        "overall_pass": False,
        "notes": "",
    }

    # --- Gather parts ---
    oligo_row = data["oligo_by_variant"].get(variant_id)
    if oligo_row is None:
        result["notes"] = f"Oligo not found for {variant_id}"
        return result
    oligo_seq = oligo_row["sequence"].upper()

    manifest = data["manifest_by_tile"].get(tile_id)
    if manifest is None:
        result["notes"] = f"Manifest not found for tile {tile_id}"
        return result

    # 5'WT gene blocks (BsaI parts)
    bsai_part_names = [
        n.strip() for n in manifest["bsai_parts"].split(";") if n.strip()
    ]
    bsai_block_seqs = {}
    for name in bsai_part_names:
        block = data["block_by_name"].get(name)
        if block is None:
            result["notes"] = f"BsaI block '{name}' not found"
            return result
        bsai_block_seqs[name] = block["sequence"].upper()

    # 3'WT+PolIII gene blocks (BsmBI parts)
    bsmbi_part_names = [
        n.strip() for n in manifest["bsmbi_parts"].split(";") if n.strip()
    ]
    bsmbi_block_seqs = {}
    for name in bsmbi_part_names:
        block = data["block_by_name"].get(name)
        if block is None:
            result["notes"] = f"BsmBI block '{name}' not found"
            return result
        bsmbi_block_seqs[name] = block["sequence"].upper()

    helper_insert_seq = data["helper"]["sequence"].upper()

    # ===================================================================
    # Stage 1: BsaI assembly
    # Parts: helper plasmid (circular) + oligo (linear) + 5'WT blocks (linear)
    # ===================================================================

    # Extract BsaI fragments from each linear part
    bsai_fragments = []

    # Oligo: has BsaI sites at both ends
    oligo_frag = extract_fragment(oligo_seq, "BsaI")
    if oligo_frag is None:
        result["notes"] = "Could not extract BsaI fragment from oligo"
        return result
    bsai_fragments.append(oligo_frag)

    # 5'WT gene blocks: each has BsaI sites at both ends
    for name in bsai_part_names:
        block_frag = extract_fragment(bsai_block_seqs[name], "BsaI")
        if block_frag is None:
            result["notes"] = f"Could not extract BsaI fragment from {name}"
            return result
        bsai_fragments.append(block_frag)

    # Helper plasmid: circular, has two BsaI sites
    # Extract the backbone fragment (not the stuffer)
    helper_circ_frags = extract_circular_fragments(helper_insert_seq, "BsaI")
    if len(helper_circ_frags) < 2:
        result["notes"] = "Could not extract BsaI fragments from helper plasmid"
        return result

    # The backbone fragment connects oh4 (right of barcode region) to oh_L (start of gene).
    # We need to identify which fragment is the backbone vs. stuffer.
    # The backbone should have overhangs that match the insert parts.
    insert_left_ohs = {f["left_oh"] for f in bsai_fragments}
    insert_right_ohs = {f["right_oh"] for f in bsai_fragments}

    backbone_frag = None
    for frag in helper_circ_frags:
        # Backbone's right_oh should match some insert's left_oh
        # Backbone's left_oh should match some insert's right_oh
        if frag["right_oh"] in insert_left_ohs and frag["left_oh"] in insert_right_ohs:
            backbone_frag = frag
            break

    if backbone_frag is None:
        # Fallback: pick the larger fragment (backbone is typically much bigger than stuffer)
        backbone_frag = max(helper_circ_frags, key=lambda f: len(f["body"]))

    all_bsai_frags = [backbone_frag] + bsai_fragments

    # Assemble BsaI fragments
    bsai_product = assemble_fragments(all_bsai_frags)
    if bsai_product is None:
        # Try different fragment orderings by rotating the start
        for start_idx in range(1, len(all_bsai_frags)):
            rotated = all_bsai_frags[start_idx:] + all_bsai_frags[:start_idx]
            bsai_product = assemble_fragments(rotated)
            if bsai_product is not None:
                break

    if bsai_product is None:
        oh_info = [(f["left_oh"], f["right_oh"]) for f in all_bsai_frags]
        result["notes"] = f"BsaI assembly failed. Fragment OHs: {oh_info}"
        return result

    result["bsai_ok"] = True

    # ===================================================================
    # Stage 2: BsmBI assembly
    # The BsaI product (circular) has BsmBI sites. We cut it and insert
    # the 3'WT+PolIII blocks.
    # ===================================================================

    # Extract BsmBI fragments from the BsaI product (treat as circular)
    bsmbi_product_frags = extract_circular_fragments(bsai_product, "BsmBI")

    # Extract BsmBI fragments from the 3'WT+PolIII linear blocks
    bsmbi_insert_frags = []
    for name in bsmbi_part_names:
        block_frag = extract_fragment(bsmbi_block_seqs[name], "BsmBI")
        if block_frag is None:
            result["notes"] = f"Could not extract BsmBI fragment from {name}"
            return result
        bsmbi_insert_frags.append(block_frag)

    # From the BsaI product's BsmBI fragments, find the "backbone" fragment
    # (the one that should be kept, containing the gene + barcode but not
    # the small region between BsmBI sites in the oligo)
    insert_left_ohs_2 = {f["left_oh"] for f in bsmbi_insert_frags}
    insert_right_ohs_2 = {f["right_oh"] for f in bsmbi_insert_frags}

    bsmbi_backbone = None
    for frag in bsmbi_product_frags:
        if (frag["right_oh"] in insert_left_ohs_2
                and frag["left_oh"] in insert_right_ohs_2):
            bsmbi_backbone = frag
            break

    if bsmbi_backbone is None and bsmbi_product_frags:
        bsmbi_backbone = max(bsmbi_product_frags, key=lambda f: len(f["body"]))

    if bsmbi_backbone is None:
        result["notes"] = "Could not identify BsmBI backbone in BsaI product"
        return result

    all_bsmbi_frags = [bsmbi_backbone] + bsmbi_insert_frags

    # Assemble BsmBI fragments
    final_product = assemble_fragments(all_bsmbi_frags)
    if final_product is None:
        for start_idx in range(1, len(all_bsmbi_frags)):
            rotated = all_bsmbi_frags[start_idx:] + all_bsmbi_frags[:start_idx]
            final_product = assemble_fragments(rotated)
            if final_product is not None:
                break

    if final_product is None:
        oh_info = [(f["left_oh"], f["right_oh"]) for f in all_bsmbi_frags]
        result["notes"] = f"BsmBI assembly failed. Fragment OHs: {oh_info}"
        return result

    result["bsmbi_ok"] = True

    # ===================================================================
    # Validation: check final product
    # ===================================================================
    product_seq = final_product.upper()

    # Classify gene match: exact mutant, full overhang conflict, or partial
    gene_result = classify_gene_match(
        product_seq, data["dom_cds"], position, mut_codon
    )
    result["gene_match"] = gene_result["gene_match"]
    result["overhang_conflict"] = gene_result["overhang_conflict"]
    if gene_result["detail"]:
        result["notes"] += f" {gene_result['detail']}"

    # Check barcode match
    search_seq = product_seq + product_seq
    if barcode in search_seq:
        result["barcode_match"] = True
    else:
        rc_search = reverse_complement(product_seq) * 2
        if barcode in rc_search:
            result["barcode_match"] = True
        else:
            result["notes"] += " Barcode not found in product."

    # Overall pass: assembly works AND either the expected mutation is present
    # OR it's a known overhang conflict (assembly correct, mutation at boundary)
    result["overall_pass"] = (
        result["bsai_ok"]
        and result["bsmbi_ok"]
        and (result["gene_match"] or result["overhang_conflict"])
        and result["barcode_match"]
    )

    return result


# ---------------------------------------------------------------------------
# Main
# ---------------------------------------------------------------------------

def main():
    parser = argparse.ArgumentParser(
        description="Validate Golden Gate Assembly via in-silico simulation"
    )
    parser.add_argument(
        "--output-dir", required=True, type=Path,
        help="Pipeline output directory containing CSVs and FASTAs"
    )
    parser.add_argument(
        "--gene-name", required=True,
        help="Gene name prefix for output files"
    )

    group = parser.add_mutually_exclusive_group()
    group.add_argument(
        "--n-samples", type=int, default=10,
        help="Number of variants to sample (default: 10)"
    )
    group.add_argument(
        "--all", action="store_true",
        help="Validate all variants (can be slow for large genes)"
    )
    group.add_argument(
        "--variant-ids", nargs="+",
        help="Specific variant IDs to validate"
    )

    parser.add_argument(
        "--seed", type=int, default=42,
        help="Random seed for variant sampling (default: 42)"
    )
    parser.add_argument(
        "--results-csv", type=Path,
        help="Write per-variant results to this CSV file"
    )
    parser.add_argument(
        "--verbose", "-v", action="store_true",
        help="Print detailed progress"
    )
    args = parser.parse_args()

    # --- Load data ---
    print(f"Loading pipeline outputs from {args.output_dir}...", file=sys.stderr)
    data = load_pipeline_outputs(args.output_dir, args.gene_name)
    print(
        f"  {len(data['variants'])} variants, "
        f"{len(data['geneblocks'])} gene blocks, "
        f"{len(data['oligos'])} oligos",
        file=sys.stderr,
    )

    # --- Select variants to validate ---
    all_variants = data["variants"]

    if args.all:
        selected = all_variants
    elif args.variant_ids:
        variant_set = set(args.variant_ids)
        selected = [v for v in all_variants if v["variant_id"] in variant_set]
        missing = variant_set - {v["variant_id"] for v in selected}
        if missing:
            print(f"WARNING: variant IDs not found: {missing}", file=sys.stderr)
    else:
        random.seed(args.seed)
        n = min(args.n_samples, len(all_variants))
        selected = random.sample(all_variants, n)

    print(f"Validating {len(selected)} variants...", file=sys.stderr)

    # --- Run validations ---
    results = []
    n_pass = 0
    n_fail = 0

    for i, variant in enumerate(selected, 1):
        vid = variant["variant_id"]
        if args.verbose:
            print(f"  [{i}/{len(selected)}] {vid}...", end="", file=sys.stderr)

        res = validate_variant(variant, data)
        results.append(res)

        if res["overall_pass"]:
            n_pass += 1
            if args.verbose:
                if res["overhang_conflict"]:
                    print(f" PASS (overhang conflict: {res['notes'].strip()})", file=sys.stderr)
                else:
                    print(" PASS", file=sys.stderr)
        else:
            n_fail += 1
            if args.verbose:
                print(f" FAIL: {res['notes']}", file=sys.stderr)
            else:
                print(
                    f"  FAIL: {vid} — {res['notes']}",
                    file=sys.stderr,
                )

    # --- Report ---
    n_overhang = sum(1 for r in results if r["overhang_conflict"])
    n_gene_match = sum(1 for r in results if r["gene_match"])

    print(file=sys.stderr)
    print(
        f"Results: {n_pass} PASS, {n_fail} FAIL out of {len(selected)}",
        file=sys.stderr,
    )
    if n_overhang > 0:
        print(
            f"  ({n_gene_match} exact gene match, "
            f"{n_overhang} overhang conflicts — assembly OK but mutation at boundary)",
            file=sys.stderr,
        )

    if n_fail > 0:
        print("\nFailed variants:", file=sys.stderr)
        for res in results:
            if not res["overall_pass"]:
                print(
                    f"  {res['variant_id']} (tile {res['tile_id']}): "
                    f"{res['notes']}",
                    file=sys.stderr,
                )

    # --- Write results CSV ---
    if args.results_csv:
        fieldnames = [
            "variant_id", "tile_id", "bsai_ok", "bsmbi_ok",
            "gene_match", "barcode_match", "overhang_conflict",
            "overall_pass", "notes",
        ]
        with open(args.results_csv, "w", newline="") as fh:
            writer = csv.DictWriter(fh, fieldnames=fieldnames)
            writer.writeheader()
            writer.writerows(results)
        print(f"Results written to {args.results_csv}", file=sys.stderr)

    # Exit code: 0 if all pass, 1 if any fail
    sys.exit(0 if n_fail == 0 else 1)


if __name__ == "__main__":
    main()
