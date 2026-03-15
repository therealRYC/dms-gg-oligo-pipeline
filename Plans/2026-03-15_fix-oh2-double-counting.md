# Plan: Fix oh2 Double-Counting Bug (BUG-010 + BUG-011)

**Status**: completed (2026-03-15)

## Context

Full pipeline benchmark (2026-03-14) revealed two critical bugs. Root cause
analysis with user's geometry spreadsheet (2026-03-15) found they are the
**same underlying bug**: oh2_seq in tile metadata is computed at
`end_codon + overlap_codons`, but it should be at just `end_codon` (the tile end).

**The double-counting**: The DP precomputes oh2 at `raw_boundary + overlap_codons`
(= tile end). Then the tile metadata adds ANOTHER `+ overlap_codons`, putting oh2
at `raw_boundary + 2 * overlap_codons`. The DP scoring is correct; the metadata is wrong.

**Consequence**: The oligo's BsmBI site uses a sequence 18 nt past the tile end,
while the mutable region strips only the last 4 nt of the tile. This creates a
sequence discontinuity in the assembled product -> BUG-011 (simulator fails).
The clearance computation is actually correct (uses tile_len - 4, which matches
the true oh2 at the tile end), but the oh2_seq mismatch causes skipped variants
at every tile boundary -> BUG-010.

## Correct Geometry (from user's spreadsheet, nt values corrected)

```
Raw DP boundary at codon 74, overlap_codons = 6

Tile 1:  codon 1 ──────────────── codon 80 (= raw + overlap)
         nt 1                      nt 240

oh1:     nt 1-4     (first 4 nt of tile)
oh2:     nt 237-240 (last 4 nt of tile = last nt of codon 79 + codon 80)

Mutable: codons 2-77 (tile 1 covers up to boundary + overlap/2)
WT buffer: codons 78-80 (3 codons between last mutable and oh2)

Tile 2:  codon 75 ──────────────── codon 155
oh1:     nt 223-226 (first 4 nt of tile)
Mutable: codons 78+ (starts at tile_start + overlap/2)
```

6-codon overlap between tiles. 3 codons mutable in each tile's overlap zone.
3 codons WT buffer before each oh2. No mutable gaps.

## The Fix (2 lines)

`R/06b_oogga_dp.R`:
```r
# BEFORE (wrong — double-counts overlap):
oh2_codon <- min(tiles$end_codon[i] + overlap_codons, n_codons_cds)

# AFTER (oh2 = last 4 nt of tile):
oh2_codon <- min(tiles$end_codon[i], n_codons_cds)
```

Applied in both `search_tile_boundaries_oogga()` (line ~1082) and
`tile_segments_oogga()` (line ~1353).

## What Already Worked (no changes needed)

| Component | Code | Why it's correct |
|-----------|------|-----------------|
| Oligo mutable region | `tile[5 : t_len-4]` | oh2 IS the last 4 nt of tile |
| Clearance scoring | `(tile_len - 4) - local_end` | Measures from tile end |
| 3'WT block start | `tile$end_nt + 1` | Starts right after tile |
| DP oh2 scoring | `boundary + overlap` | = tile end codon |
| `compute_max_tile_size()` | 300 - 56 = 244 | No extension needed |

## Verification (GRIN2A)

| Metric | Before fix | After fix |
|--------|-----------|-----------|
| Skipped variants | 210 (incl. boundary) | 210 (gene-edge only) |
| Assembly simulation | 1/25 tiles pass | 25/25 tiles pass |
| Oligo lengths | 152-290 nt | 152-290 nt |
| Unit tests | N/A | 5264 pass, 0 fail |

## Deferred

- **Gene-edge codon 2**: clearance = 0 (touching oh1) not flagged. Will be
  properly fixed by moving oh_L into Kozak sequence (separate session).
