# Bug C Fix Review: Collision Loop Blacklist Scoping

<!-- Created: 2026-03-06 -->

## Status: Complete

Bug C fix already committed (66a281f). This review addresses a correctness concern
raised during code review: the collision avoidance loop's blacklist was globally scoped,
meaning cassette-region collisions could over-constrain gene-region boundary selection.

## Issue Identified

The collision avoidance loop (lines 3219-3378) has two blacklisting paths:

1. **`cassette_blacklist_ohs`** (pre-blacklist, passed to SB DP): Applied ONLY to
   cassette-region positions (`p > gene_len`). Gene-region boundaries unaffected.

2. **`sb_extra_blacklist`** (collision loop): When the post-hoc collision check detects
   a cassette junction OH colliding with a tile OH, it added the OH to
   `sb_extra_blacklist` -> merged into `blacklist_ohs` -> **applied to ALL positions**
   (gene AND cassette). This meant a cassette-colliding OH got unnecessarily excluded
   from gene-region boundary selection too.

The pre-blacklist (path 1) should prevent cassette-tile collisions from ever reaching the
collision loop, making path 2 a dead path for cassette collisions. But if it ever leaked
through, the global blacklist would over-constrain gene-region choices.

## Fix Applied (7a3d7d7)

In the collision loop, when a colliding OH is identified, classify it as cassette-region
or gene-region:

- **Cassette junction OHs** (identified via `cassette_splits$junction_oh`)
  -> added to `cassette_oh_blacklist` -> only excluded from cassette-region positions
- **Gene boundary OHs** -> added to `sb_extra_blacklist` -> excluded globally
  (correct, since gene-region SB boundary OHs need to be unique across all boundaries)

### Files Modified

| File | Function | Change |
|------|----------|--------|
| `R/06_overhang_selection.R` | `plan_assembly()` collision loop | Route cassette vs gene collisions to separate blacklists |

## Verification

1. `devtools::test()` -- FAIL 0 | WARN 43 | SKIP 4 | PASS 6393
2. All 4 production configs pass with identical results:

| Config | Tiles | Result |
|--------|-------|--------|
| GRIN2A | 25/25 | Pass |
| GRIN2A_long_cassette | 25/25 | Pass |
| AKAP11 | 31/31 | Pass |
| TRIO | 47/47 | Pass |

3. Log messages now show scoped classification:
   - `SB collision: blacklisting gene: AAAT`
   - `SB collision: blacklisting cassette: TCAA`

## Notes

This is a defense-in-depth fix. The pre-blacklist already prevents most cassette-tile
collisions from reaching the loop. The scoped blacklisting ensures correct behavior
even if a collision leaks through.
