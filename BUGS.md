# Created: 2026-03-15
# Last updated: 2026-03-15 — BUG-010 and BUG-011 FIXED

# Active Bugs

(none)

# Resolved Bugs

Previous bug history archived to `archive/BUGS-pre-260315.md`.

## BUG-010: oh2 double-counting causes skipped variants at tile boundaries — FIXED

**Status**: FIXED (2026-03-15)
**Severity**: Critical
**Discovered**: 2026-03-14 (full pipeline benchmark), root-caused 2026-03-15

### Symptom

210 variants skipped as `partial_oh_overlap` for GRIN2A. Skipped positions
appeared at EVERY tile boundary, not just gene edges.

### Root cause

The tile metadata loop in `R/06b_oogga_dp.R` computed oh2 at
`end_codon + overlap_codons`, but `end_codon` already includes the overlap
extension from the DP (`raw_boundary + overlap_codons`). This double-counted
the overlap, putting oh2 18 nt past the tile end.

### Fix

Two lines in `R/06b_oogga_dp.R`:
- `search_tile_boundaries_oogga()` (line ~1082): `oh2_codon <- min(tiles$end_codon[i], n_codons_cds)`
- `tile_segments_oogga()` (line ~1353): `oh2_codon <- min(tiles$end_codon[i], total_n_codons)`

Removed `+ overlap_codons` from both. The DP scoring was already correct
(it uses `boundary + overlap_codons` = tile end); only the metadata was wrong.

### Verification

After fix: 210 skipped variants remain — these are the expected gene-edge
variants (codons near start/stop where mutations overlap oh1/oh2), NOT
internal tile boundary variants.

---

## BUG-011: In-silico assembly simulator fails on nearly all tiles — FIXED

**Status**: FIXED (2026-03-15) — same root cause as BUG-010
**Severity**: Critical
**Discovered**: 2026-03-14 (full pipeline benchmark)

### Symptom

Assembly simulation failed on 24/25 tiles for GRIN2A. Only the last tile
(which has no 3'WT gene blocks) passed.

### Root cause

Same as BUG-010. The wrong oh2 position caused the oligo's BsmBI site to
reference a 4-nt sequence 18 nt past the tile end. The resulting cut-and-
ligate product didn't match the expected gene sequence.

### Fix

Same 2-line fix as BUG-010. No simulator code changes needed.

### Verification

After fix: **25/25 tiles pass** assembly simulation for GRIN2A.
