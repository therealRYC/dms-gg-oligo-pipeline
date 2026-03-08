<!-- Created: 2026-03-05 -->
<!-- Last updated: 2026-03-05 — Initial writeup -->

# How the Tile DP Works: Boundaries, Overhangs, and Overlap

## Purpose of this document

This document explains in full detail how the dynamic programming (DP) algorithm
in `search_tile_boundaries_dp()` places tile boundaries, how each boundary
generates two overhangs at two different positions, and how the overlap mechanism
ensures every codon in the gene is mutable by at least one tile.

This is reference documentation for the DMS Golden Gate oligo pipeline.

---

## Background: Each tile is an independent reaction

Before diving into the DP, one critical architectural point must be understood:
**each tile assembles the entire full-length gene independently**. Tiles are NOT
adjacent fragments that ligate to each other in one pot. Each tile has its own
set of reactions:

- **BsaI (Level 1a):** oligo + 5'WT gene blocks → helper plasmid
- **BsmBI (Level 1b):** helper plasmid + 3'WT gene blocks → full insert
- **PaqCI (Level 2):** full insert → destination backbone

For tile T1 (the first tile), there are no 5'WT gene blocks — oh1 = oh\_L
(gene start), and the oligo connects directly to the backbone in the BsaI
reaction.

For tile T2 (second tile), the 5'WT blocks cover the gene from the start up to
T2's oh1 boundary. The 3'WT blocks cover the gene from T2's oh2 boundary to
the end, plus the PolIII promoter.

**T1's overhangs and T2's overhangs are completely independent.** They're in
separate tubes, with separate gene blocks, and each reconstructs the full gene
with a different mutation.

---

## The universal oligo structure

Every oligo in the pool has the same layout:

```
5'—BsaI_fwd(7)—oh1(4)—[mutable region]—BsmBI_rev_oh2(11)—BsmBI_fwd_oh3(11)—barcode(12)—BsaI_rev_oh4(11)—3'
```

- **oh1** (4 nt): WT gene sequence at the tile's 5' boundary. This is a BsaI
  overhang that connects the oligo to the 5'WT gene blocks (or directly to the
  backbone for the first tile).
- **oh2** (4 nt): WT gene sequence at the tile's 3' boundary. This is a BsmBI
  overhang that connects the oligo to the 3'WT gene blocks.
- **Mutable region**: The interior of the tile, between oh1 and oh2. This is
  where the single codon mutation lives.
- oh1 and oh2 are **invariant WT sequence** on every oligo — they must match
  the gene blocks exactly for ligation to work. Codons that overlap with oh1
  or oh2 cannot be mutated in that tile's oligo.

Total fixed overhead = 7 + 4 + 11 + 11 + 12 + 11 = 56 nt.
At 300 nt max oligo length: mutable region = 244 nt → rounded to 243 nt
(81 codons).

---

## Why overlap is needed

oh1 is 4 nt at the very start of the tile, and oh2 is 4 nt at the very end.
Any codon that overlaps with these 4-nt zones is immutable in that tile,
because mutating it would change the overhang and break the Golden Gate ligation.

4 nt ≈ 1.33 codons. So the first ~2 codons of a tile (partially in oh1) and
the last ~2 codons (partially in oh2) cannot be mutated.

Without overlap, these boundary codons would be permanently immutable — no tile
could mutate them. For a DMS experiment requiring complete coverage of every
amino acid position, this is unacceptable.

**Solution: adjacent tiles overlap.** Each tile extends past its core boundary
by `overlap_codons` (default 4) codons to the right. The overlapping codons
are in the oh1/oh2 zone of one tile but in the mutable interior of the adjacent
tile. This guarantees every codon is mutable by at least one tile.

---

## The DP algorithm: step by step

### Setup

Consider a 300-codon gene (900 nt).

- `max_codons = 81` (from 243 nt max mutable region ÷ 3)
- `overlap_codons = 4`
- `effective_max_codons = 81 - 4 = 77` (core tile size limit, reduced to
  leave room for the rightward extension)
- `min_codons = 27` (configurable, default max_codons ÷ 3)

The DP needs K internal boundaries to split 300 codons into K+1 tiles.
Minimum K: `ceil(300 / 77) - 1 = 3` (4 tiles).

### What a "boundary" means

A boundary at codon position **b** means:

- The current tile's **core** region ends at codon b
- The next tile's **core** region starts at codon b + 1

The word "core" is important — tiles are extended past their core boundaries
by the overlap. The core boundary is where the DP places the split; the
actual tile extent includes the extension.

### Each boundary generates TWO overhangs

This is the key insight. A single boundary at codon b produces:

1. **oh1** for the next tile: the 4 nt starting at codon b + 1
   (the next tile's 5' overhang, a BsaI junction)

2. **oh2** for the current tile: the 4 nt ending at codon b + overlap\_codons
   (the current tile's 3' overhang, at the extended end, a BsmBI junction)

These are at **different positions** because the current tile extends rightward
by `overlap_codons` past the core boundary.

```
Boundary at codon b:

Gene: ...codon b-1  codon b  codon b+1  codon b+2  ...  codon b+4  codon b+5...
                        |
                   core boundary
                        |
          oh1 --------->| 4 nt starting at codon b+1
          (next tile)   |     (nt position: b*3 + 1  to  b*3 + 4)
                        |
          oh2 --------->|----------> 4 codons to the right
          (current tile)|     4 nt ending at codon b + overlap_codons
                              (nt position: (b+4)*3 - 3  to  (b+4)*3)
```

### Concrete example: boundary at codon 75

For a gene with codon 75 = nt 223–225, codon 76 = nt 226–228, etc.:

```
Codon positions:  ...74   75   76   77   78   79   80...
Nucleotide pos:   220  223  226  229  232  235  238
                 -222 -225 -228 -231 -234 -237 -240

                        core boundary at codon 75
                              |
                              v
Gene: ...codon 74  codon 75 | codon 76  codon 77  codon 78  codon 79  codon 80...
                             |
                             |
    oh1 (next tile) -------->| starts at codon 76
                             | = nt 226, 227, 228, 229
                             | (all of codon 76 + first nt of codon 77)
                             |
    oh2 (current tile) ----->|---------> +4 codons = codon 79
                                        = nt 235, 236, 237, 238...
                                        wait, let me be precise:
                                        oh2_codon = 75 + 4 = 79
                                        oh2 = last 4 nt ending at codon 79
                                        codon 79 ends at nt 79*3 = 237
                                        oh2 = nt 234, 235, 236, 237
                                        (last nt of codon 78 + all of codon 79)
```

So boundary at codon 75 produces:
- **oh1** = `substring(cds, 226, 229)` — e.g., `"ATCG"`
- **oh2** = `substring(cds, 234, 237)` — e.g., `"GCTA"`

These are 8 nucleotides apart. Different positions, different sequences, used
in different enzymes (BsaI for oh1, BsmBI for oh2) in different reactions.

### How the DP scores each boundary

In `precompute_boundary_scores()`, for every candidate boundary position b:

```r
# oh1: 4 nt at start of next tile (codon b+1)
oh1_pos <- b * 3L + 1L
oh1 <- substring(cds, oh1_pos, oh1_pos + 3L)

# oh2: 4 nt at extended end of current tile (codon b + overlap_codons)
oh2_codon <- min(b + overlap_codons, n_codons)
oh2_pos <- oh2_codon * 3L
oh2 <- substring(cds, oh2_pos - 3L, oh2_pos)

# Combined score (both must be high quality for a good boundary)
score[b] <- overhang_score(oh1) + overhang_score(oh2) + penalties
```

Where `overhang_score(oh) = P_fidelity(oh) * P_efficiency(oh)` from the BsmBI
cycling pairwise matrix (Pryor et al. 2020).

The DP searches for the set of K boundary positions that **maximizes the total
score** (sum of scores across all K boundaries), subject to the constraint that
every core tile is between `min_codons` and `effective_max_codons` codons.

### DP internals (for K = 3 boundaries → 4 tiles)

**Layer 1** — place the 1st boundary:

```
For each position b1 from min_codons (27) to effective_max_codons (77):
    if boundary is valid (not blacklisted, not palindromic):
        dp[b1] = score[b1]
```

**Layer 2** — place the 2nd boundary:

```
For each position b2 from 2*min_codons (54) to 2*effective_max_codons (154):
    if boundary is valid:
        Find the best b1 such that (b2 - b1) is in [min_codons, effective_max_codons]
        dp[b2] = max(dp_prev[b1]) + score[b2]
        parent[2, b2] = best b1
```

**Layer 3** — place the 3rd boundary:

```
For each position b3 from 3*min_codons (81) to n_codons - min_codons (273):
    if boundary is valid:
        Find the best b2 such that (b3 - b2) is in [min_codons, effective_max_codons]
        dp[b3] = max(dp_prev[b2]) + score[b3]
        parent[3, b3] = best b2

    Also: last tile (b3+1 to 300) must be in [min_codons, effective_max_codons]
```

**Backtrack** — recover boundary positions from parent pointers:

```
b3 = argmax(dp[b3]) where (300 - b3) is in [min_codons, effective_max_codons]
b2 = parent[3, b3]
b1 = parent[2, b2]
boundaries = [b1, b2, b3]
```

The DP also searches across multiple K values (multi-K) and picks the K with
the best average score per boundary, stopping when improvements become marginal.

---

## From boundaries to tiles

Suppose the DP finds boundaries at codons **75, 150, 227**.

The boundary positions vector becomes `c(0, 75, 150, 227, 300)`.

For each tile i, the code computes:

```r
core_sc <- boundary_positions[i] + 1      # core start codon
core_ec <- boundary_positions[i + 1]      # core end codon
sc <- core_sc                              # actual start (no left extension)
ec <- min(n_codons, core_ec + overlap_codons)  # actual end (right extension)
```

This produces:

| Tile | Core codons | Actual codons (extended) | oh1 position | oh2 position |
|------|------------|-------------------------|-------------|-------------|
| T1   | 1–75       | 1–**79**                | nt 1–4       | nt 234–237   |
| T2   | 76–150     | 76–**154**              | nt 226–229   | nt 459–462   |
| T3   | 151–227    | 151–**231**             | nt 451–454   | nt 690–693   |
| T4   | 228–300    | 228–**300** (capped)    | nt 682–685   | nt 897–900   |

Key observations:
- T1 extends from core end 75 to actual end 79 (4 codons of rightward extension)
- T2 starts at codon 76, overlapping with T1's extension (codons 76–79)
- T4 can't extend past codon 300 (end of gene), so it's capped

---

## Overlap in action: the boundary between T1 and T2

Zooming into the boundary at codon 75:

```
Codon:    73   74   75 | 76   77   78   79   80   81   82
                       |
              core boundary

T1:  [oh1..mutable interior..............|.oh2 zone.]
     T1 spans codons 1–79 (extended)
     oh1 = nt 1–4 (gene start)
     oh2 = nt 234–237 (at codon 79)
     Mutable interior: roughly codons 2–78

T2:            [oh1 zone|..mutable interior................]
               T2 spans codons 76–154 (extended)
               oh1 = nt 226–229 (at codon 76)
               Mutable interior: roughly codons 78–153
```

**Overlap zone = codons 76–79** (4 codons shared by both tiles):

| Codon | Status in T1 | Status in T2 | Mutated via |
|-------|-------------|-------------|------------|
| 75    | Mutable interior | not in T2 | **T1** |
| 76    | Mutable interior | oh1 zone (invariant) | **T1** |
| 77    | Mutable interior | oh1/mutable boundary | **T1** |
| 78    | Near oh2 boundary | Mutable interior | **T2** |
| 79    | oh2 zone (invariant) | Mutable interior | **T2** |
| 80    | not in T1 | Mutable interior | **T2** |

**Every codon is in the mutable interior of at least one tile.**

The `assign_variants_to_tiles()` function handles the routing: for each
variant's codon position, it finds which tile(s) cover that position and
picks the one where the codon is in the mutable interior (quality 2) over
one where it's in the oh zone (quality 1).

---

## Assembly for T1 and T2: separate reactions

To make this concrete, here's what physically happens in the lab:

### T1's reactions (for a variant at, say, codon 50)

**BsaI reaction (Level 1a):**
- Oligo: `BsaI_fwd — oh1(nt 1–4) — [mutant at codon 50] — BsmBI_rev_oh2(nt 234–237) — BsmBI_fwd_oh3 — barcode — BsaI_rev_oh4`
- No 5'WT blocks needed (T1 is the first tile, oh1 = oh_L = gene start)
- Helper plasmid provides the backbone

**BsmBI reaction (Level 1b):**
- 3'WT blocks: gene from nt 238 to nt 900 + PolIII
- These may be split at superblock boundaries if oversized

**Result:** Full gene with mutation at codon 50, barcode linked.

### T2's reactions (for a variant at, say, codon 100)

**BsaI reaction (Level 1a):**
- Oligo: `BsaI_fwd — oh1(nt 226–229) — [mutant at codon 100] — BsmBI_rev_oh2(nt 459–462) — BsmBI_fwd_oh3 — barcode — BsaI_rev_oh4`
- 5'WT block: gene from nt 1 to nt 225 (everything upstream of oh1)
- The 5'WT block has BsaI sites: oh\_L at its 5' end, oh1\_T2 at its 3' end

**BsmBI reaction (Level 1b):**
- 3'WT blocks: gene from nt 463 to nt 900 + PolIII

**Result:** Full gene with mutation at codon 100, barcode linked.

Note how T1 and T2 use completely different overhangs, different gene block
configurations, and different reactions. They never see each other.

### T1's reaction for a variant at codon 76 (in the overlap zone)

Because codon 76 is in T1's mutable interior (not in oh1 or oh2), T1 can
carry this mutation:

- Oligo: `BsaI_fwd — oh1(nt 1–4) — [mutant at codon 76] — BsmBI_rev_oh2(nt 234–237) — ...`
- The mutation at codon 76 (nt 226–228) is safely in the mutable interior,
  well before oh2 (nt 234–237).
- 3'WT blocks start at nt 238, unaffected by the mutation at nt 226–228.

If we tried to mutate codon 76 via T2 instead, the mutation would fall in
T2's oh1 (nt 226–229), changing the BsaI overhang and breaking ligation.
That's why `assign_variants_to_tiles()` routes codon 76 to T1.

---

## The overlap problem at superblock boundaries

### How superblocks work

For long genes, the WT gene blocks (5'WT and 3'WT) may exceed synthesis limits
(~1800 bp for Twist gene fragments). Superblock (SB) boundaries split these
blocks into sub-blocks, joined by BsmBI overhangs at the junction.

In the SB-first DP approach:
1. **Pass 1:** SB DP finds optimal split points for the full gene+cassette
2. **Pass 2:** Per-SB tile DP finds tile boundaries within each superblock

### The gap

When running tile DP within SB1, the tile extension is capped at SB1's end:

```r
ec <- min(n_codons_in_sb1, core_ec + overlap_codons)
# For the last tile: n_codons_in_sb1 == core_ec, so ec = core_ec. No extension.
```

The last tile of SB1 can't extend into SB2. The first tile of SB2 starts at
the SB boundary with no backward extension. Result: ~4 codons on each side of
the SB boundary are trapped in oh zones with no overlap coverage.

### The fix: post-hoc extension (Approach A)

After all per-SB tile DPs, extend the last tile of each non-last SB by
`overlap_codons` into the next SB:

1. For each SB boundary between SB\_i and SB\_{i+1}:
   - Take SB\_i's last tile
   - Extend `end_codon` by `overlap_codons` (using the full CDS, not the SB subsequence)
   - Recompute oh2 from the full CDS at the new end position
   - Validate new oh2 against blacklists
   - If collision: try extending by 3, then 2, then 1 codons

This restores overlap coverage at SB boundaries. The SB boundary overhang is
absorbed into the extended tile's mutable region (the oligo encodes it), so the
gene blocks for that tile don't reference the SB boundary junction at all.

---

## Summary

| Concept | Key point |
|---------|-----------|
| Tiles are independent | Each tile has its own reaction; tiles don't ligate to each other |
| One boundary → two overhangs | oh1 (next tile start) and oh2 (current tile extended end) at different positions |
| Overlap = rightward extension | Each tile extends `overlap_codons` past its core boundary |
| DP scores both overhangs | `score[b] = quality(oh1) + quality(oh2)` |
| Variant routing | `assign_variants_to_tiles()` picks the tile where each codon is in the mutable interior |
| SB boundary gap | Last tile of an SB can't extend past the SB boundary → fixed by post-hoc extension |
