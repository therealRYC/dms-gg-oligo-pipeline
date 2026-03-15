# Created: 2026-03-15
# Last updated: 2026-03-15 — Fresh start: BUG-010, BUG-011

# Active Bugs

Previous bug history archived to `archive/BUGS-pre-260315.md`.

## BUG-010: Oligo assembly uses wrong oh2 position — mutable region truncated

**Status**: OPEN — root cause identified
**Severity**: Critical
**Discovered**: 2026-03-14 (full pipeline benchmark), root-caused 2026-03-15

### Symptom

Hundreds of variants skipped per gene (147-546) as `partial_oh_overlap`.
Skipped positions appear at EVERY tile boundary, not just gene edges.

### Root cause

The oh2 overhang is at `end_codon + overlap_codons` (18 nt past the tile end
with overlap_codons=6). But two places in the code assume oh2 is the last 4 nt
of the tile:

1. **`R/08_oligo_assembly.R:92`** — `mutable_regions <- substring(mutant_tiles, 5L, t_len - 4L)`
   Strips the last 4 nt of the tile as "oh2". But the actual oh2 is 18 nt past
   the tile end. The mutable region is truncated 18 nt too early.

2. **`R/05_tiling.R:183`** — `dist_from_oh2 <- (tile_len - 4L) - local_end`
   Computes clearance against `tile_len - 4` as the oh2 boundary. But oh2 is at
   `end_codon + overlap_codons`, which is 18 nt past the tile end.

### Correct geometry (example: raw boundary at codon 74, overlap_codons=6)

```
Tile 1:  codon 1 ──────────────────────────── codon 80 (end_codon = raw + overlap)
         nt 1                                  nt 240

oh1:     nt 1-4   (first 4 nt of tile)
oh2:     nt 255-258 (end_codon + overlap_codons = codon 86, 18 nt PAST tile end)

Mutable: codon 2 to codon 80 - overlap/2 = codon 77
         (5 nt WT buffer between last mutable codon and oh2)

Tile 2:  codon 77 ─────────────────────────── codon 140
oh1:     nt 229-232
Mutable: codon 77 + overlap/2 = codon 80 onward
         (5 nt WT buffer between oh1 and first mutable codon)
```

No mutable gaps: codon 77 is mutable in tile 1, codon 80 is mutable in tile 2.
Codons 78-79 are in the WT buffer zone of both tiles but covered by one or the other.

### Files to fix

- `R/08_oligo_assembly.R:92` — mutable region extraction
- `R/05_tiling.R:182-183` — clearance computation

---

## BUG-011: In-silico assembly simulator fails on nearly all tiles

**Status**: OPEN — diagnostic needed to narrow
**Severity**: Critical
**Discovered**: 2026-03-14 (full pipeline benchmark)

### Symptom

Assembly simulation fails on all non-final tiles across all 4 genes:

| Gene | Pass | Fail |
|------|------|------|
| GRIN2A | 1/25 (tile 25) | 24 |
| AKAP11 | 1/31 (tile 31) | 30 |
| TRIO | 1/53 (tile 53) | 52 |
| GRIN2A_ext | 1/24 (tile 24) | 23 |

The only passing tile is always the **last tile**, which uniquely has no 3'WT
gene blocks (its BsmBI blocks contain only the cassette).

### What we know

Deep code trace (2026-03-15) found:
- The 3-step reaction architecture is correctly modeled in the simulator
- Fragment chaining logic (start fragment, overhang matching) is correct on paper
- The bug could not be identified through static analysis alone
- Likely related to BUG-010's wrong oh2 position (oligo has wrong mutable region
  → assembled product doesn't match expected CDS → verification fails)

### Diagnostic needed

Add prints to show which verification sub-check fails per tile:
`has_mut_gene`, `has_polIII`, `has_barcode`, `correct_order`.

### Key insight

BUG-010 and BUG-011 are likely the SAME underlying bug. If the oligo's mutable
region is truncated (BUG-010), the assembled product's gene sequence won't match
the expected mutant CDS, causing `has_mut_gene = FALSE` in the verification step.
Fixing BUG-010's oh2 position may resolve BUG-011 automatically.

### Files

- `R/13_gg_simulator.R` — `simulate_tile_assembly()`, `verify_assembly_product()`
- `run_pipeline.R:363-398` — simulation call site (add diagnostic prints here)
