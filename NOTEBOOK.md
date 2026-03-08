<!-- Created: 2026-03-07 -->
<!-- Lab notebook retroactively constructed from git history, PR descriptions, planning docs, and bug tracking -->

# Lab Notebook — DMS GG Oligo Pipeline

**Project:** dms-gg-oligo-pipeline
**PI:** Doug Fowler, University of Washington
**Author:** Robert Chen (robchen@uw.edu)
**Repo:** github.com/therealRYC/dms-gg-oligo-pipeline
**Start date:** 2026-01-29

## Project Context

R pipeline for designing oligonucleotide pools for Deep Mutational Scanning (DMS) using a 3-enzyme Golden Gate assembly strategy (BsaI + BsmBI + PaqCI). Each oligo encodes a single specified amino acid substitution at one position in the gene, with a pre-assigned barcode for variant tracking. The pipeline outputs oligo pool sequences for Twist synthesis, WT gene block sequences, and a variant-barcode mapping file.

## Key Questions

1. How do we design a Golden Gate assembly scheme that keeps the tile and barcode on the same oligo through all pooled steps (preventing tile-barcode scrambling)?
2. What overhang scoring approach best predicts actual Golden Gate assembly fidelity under BsmBI cycling conditions?
3. How do we handle genes too long for single gene block synthesis (>1800 nt regions)?
4. What barcode generation algorithm guarantees minimum Hamming distance while scaling to >300K barcodes?

## Decision Log

| Date | Decision | Rationale | Ref |
|------|----------|-----------|-----|
| 2026-01-29 | 3-enzyme architecture (BsaI + BsmBI + PaqCI) | Orthogonal enzymes allow keeping tile + barcode on same oligo | Entry 1 |
| 2026-01-29 | Fully specified codons (no NNK/NNS) | Precise control over each mutation; human codon-optimized | Entry 1 |
| 2026-01-29 | Programmed barcodes with prefix optimization | Pre-assigned barcodes enable OPS compatibility | Entry 1 |
| 2026-02-16 | DP tile boundary optimizer over greedy search | DP globally optimizes overhang fidelity across all boundaries | Entry 5 |
| 2026-02-18 | Unified barcode mode (no OPS/standard split) | Single prefix-suffix hierarchy serves all readout modes | Entry 7 |
| 2026-02-18 | Global superblock DP (replaced by tile-boundary SBs on 02-26) | Gene block reuse across tiles; later replaced for correctness | Entry 7 |
| 2026-02-18 | Derive oh3 from PolIII promoter 3' end | Gene-independent, high-fidelity overhang (CACC, fid=0.969) | Entry 7 |
| 2026-02-21 | CoCoPUTs codon usage over Kazusa | 119K CDS, GRCh38.p13; Kazusa from 2007 is outdated | Entry 9 |
| 2026-02-22 | GF(4) linear codes for barcode prefixes | Algebraic guarantee of Hamming distance, no O(n^2) validation | Entry 10 |
| 2026-02-25 | Intergene elements support (WPRE, polyA, etc.) | Flexible downstream cassette for different readout assays | Entry 11 |
| 2026-02-26 | Tile-boundary superblocks over global DP | Fixes BUG-005; SBs split at tile boundaries only; per-tile overhang scope | Entry 12 |
| 2026-02-26 | Potapov Table 1 Set 3 (25 overhangs) as HF set | Simulated annealing-optimized for set fidelity, not greedy individual fidelity | Entry 12 |
| 2026-02-26 | OOGGA-style scoring: P_fid * P_eff * HF_bonus | Multiplicative formula balances fidelity, efficiency, and HF membership | Entry 12 |
| 2026-03-01 | Backwards-sweep SB partitioning | Sizes last SB first to accommodate cassette; avoids 1-tile SBs | Entry 17 |
| 2026-03-02 | BsmBI cycling matrix for all scoring | Standardize on one experimental condition; T4 data overestimates fidelity | Entry 18 |
| 2026-03-03 | WT controls (1 per position, always on) | Normalization controls for fitness scoring | Entry 19 |
| 2026-03-04 | SB-first two-pass DP architecture | Decide globals (SBs) first, locals (tiles) second — natural order | Entry 20 |

## Entries

