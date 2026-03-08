# DMS-GG Assembly Report: GRIN2A

Generated: 2026-03-06 18:23:44
Pipeline: dms-gg-oligo-pipeline (3-Enzyme Architecture: BsaI + BsmBI + PaqCI)

---

## 1. Gene Summary

| Property             | Value                                                                          |
| -------------------- | ------------------------------------------------------------------------------ |
| Gene name            | GRIN2A_NM_000833.5 Human GRIN2A native CDS (NM_000833.5, NP_000824.1, 1464 aa) |
| CDS length           | 4395 nt (1465 codons)                                                          |
| Protein length       | 1464 aa                                                                        |
| Number of tiles      | 25                                                                             |
| Total variants       | 30681                                                                          |
| Total oligos         | 306810                                                                         |
| Oligo length range   | 176-290 nt                                                                     |
| Gene blocks to order | 55                                                                             |
| Barcodes per variant | 10                                                                             |

## 2. Assembly Architecture Overview

This pipeline uses a **3-enzyme Golden Gate Assembly** strategy:

1. **BsaI Level 1** (37C): Inserts the oligo (mutant tile + barcode) and 5'WT gene block(s) into a helper plasmid.
2. **BsmBI Level 1b** (42C): Inserts 3'WT+PolIII gene block(s) between the tile and barcode.
3. **PaqCI Level 2** (37C): Moves the complete insert from helper plasmid into the destination backbone.

### Universal Oligo Structure

Every oligo in the pool has the same layout regardless of tile position:

```
5'--[BsaI>>]--oh1--[mutable region]--[<<BsmBI]--[BsmBI>>]--barcode--[<<BsaI]--3'
     7 nt     4 nt    variable          11 nt      11 nt    20 nt    11 nt
```

### Final Assembled Construct

```
[PaqCI**]--[gene+mutation]--[WPRE]--[spacer]--[bGH_polyA]--[PolIII]--[barcode]--[PaqCI*]
```

## 3. Oligo Pool Summary

**Total oligos:** 306810 | **Length range:** 176-290 nt

| Tile | Codons    | Oligos | Length |
| ---- | --------- | ------ | ------ |
| 1    | 1-53      | 10290  | 215 nt |
| 2    | 50-127    | 15540  | 290 nt |
| 3    | 124-183   | 11760  | 236 nt |
| 4    | 180-257   | 15540  | 290 nt |
| 5    | 254-313   | 11760  | 236 nt |
| 6    | 310-353   | 8400   | 188 nt |
| 7    | 350-399   | 9660   | 206 nt |
| 8    | 396-468   | 14490  | 275 nt |
| 9    | 465-542   | 15540  | 290 nt |
| 10   | 539-600   | 12180  | 242 nt |
| 11   | 597-672   | 15120  | 284 nt |
| 12   | 669-708   | 7560   | 176 nt |
| 13   | 705-770   | 13020  | 254 nt |
| 14   | 767-844   | 15540  | 290 nt |
| 15   | 841-905   | 12810  | 251 nt |
| 16   | 902-979   | 15540  | 290 nt |
| 17   | 976-1020  | 8610   | 191 nt |
| 18   | 1017-1066 | 9660   | 206 nt |
| 19   | 1063-1110 | 9240   | 200 nt |
| 20   | 1107-1175 | 13650  | 263 nt |
| 21   | 1172-1218 | 9030   | 197 nt |
| 22   | 1215-1289 | 14910  | 281 nt |
| 23   | 1286-1343 | 11340  | 230 nt |
| 24   | 1340-1413 | 14700  | 278 nt |
| 25   | 1410-1465 | 10920  | 224 nt |

## 4. Barcode Design

### Design Parameters

| Parameter             | Value                                |
| --------------------- | ------------------------------------ |
| Mode                  | Unified hierarchical (prefix-suffix) |
| Barcode length        | 20 nt                                |
| Prefix length         | 12 nt                                |
| Suffix length         | 8 nt                                 |
| Requested min Hamming | 3                                    |
| Effective min Hamming | 3                                    |
| Barcodes per variant  | 10                                   |

### Pool Statistics

| Statistic         | Value                              |
| ----------------- | ---------------------------------- |
| Total barcodes    | 306810                             |
| Unique barcodes   | 306810                             |
| GC content range  | 25% - 75%                          |
| GC content mean   | 47.9%                              |
| Hamming guarantee | 100% cross-variant (prefix d >= 3) |

## 5. QC Summary

**Overall:** ISSUES FOUND

| Check                     | Description                                                   | Result | Detail                                                                                                                                              |
| ------------------------- | ------------------------------------------------------------- | ------ | --------------------------------------------------------------------------------------------------------------------------------------------------- |
| oligo_lengths             | All oligos within synthesis length limit                      | PASS   | Range: 176-290 nt (limit: 300)                                                                                                                      |
| block_lengths             | All gene blocks within synthesis length limit                 | PASS   | Range: 165-1743 nt (limit: 1800)                                                                                                                    |
| barcode_junction_sites    | No enzyme sites at barcode-context junctions                  | PASS   | 0 barcode(s) with junction enzyme sites (left='CACACC', right='TTCCTG')                                                                             |
| barcode_uniqueness        | All barcodes are unique                                       | PASS   | 306810 unique / 306810 total                                                                                                                        |
| tile_coverage             | Tiles cover entire gene without gaps                          | PASS   | 4395 / 4395 nt covered                                                                                                                              |
| variant_count             | Expected number of variants generated                         | PASS   | 30681 unique variants (expected: 30681 across 1461/1463 mutable positions; 27759 missense + 1461 nonsense + 1461 wt_control; 2 position(s) skipped) |
| single_codon_change       | Each non-control variant differs by exactly one codon from WT | PASS   | 292200 / 292200 variants confirmed (WT controls excluded)                                                                                           |
| oligo_gc_content          | Oligo GC content within reasonable range (25-75%)             | PASS   | GC range: 41.5-67% | 0 oligo(s) with extreme GC                                                                                                     |
| domestication_complete    | Gene domesticated for all 3 enzymes (BsaI, BsmBI, PaqCI)      | PASS   | No enzyme sites in gene                                                                                                                             |
| overhang_fidelity         | Tile boundary overhangs have adequate fidelity                | FAIL   | 23 tile(s) with low-fidelity boundary overhangs (<0.80)                                                                                             |
| tile_manifests            | Per-tile assembly manifests complete                          | PASS   | 25 tile manifest(s) generated                                                                                                                       |
| helper_plasmid            | Helper plasmid free of unintended BsmBI sites                 | PASS   | OK                                                                                                                                                  |
| reaction_fidelity         | Per-reaction set-level overhang fidelity                      | PASS   | Min set fidelity: 0.8115 across 50 reactions | 2 reaction(s) below 0.90                                                                             |
| barcode_poliii_term       | No barcodes contain PolIII terminator signal (TTTT)           | PASS   | 0 / 306810 barcode(s) contain TTTT                                                                                                                  |
| block_min_length          | All gene blocks above synthesis minimum length                | FAIL   | 2 block(s) below 300 nt minimum. Range: 165-1743 nt                                                                                                 |
| cassette_fragment_lengths | Cassette fragments within synthesis limits                    | PASS   | 1 cassette fragment(s). Range: 1094-1094 nt. 0 over max, 0 under min.                                                                               |
| sb_overhang_collisions    | Superblock boundary overhangs are unique (no collisions)      | PASS   | 4 SB boundary OH(s), all unique                                                                                                                     |

## 6. Fixed Overhangs & Helper Plasmid

These overhangs are the same across all tile reactions:

| Overhang    | Sequence | Role                                                    |
| ----------- | -------- | ------------------------------------------------------- |
| oh_L        | ATGG     | Gene start (BsaI, all tiles)                            |
| oh3         | CACC     | Downstream cassette-barcode junction (BsmBI, all tiles) |
| oh4         | TTCC     | Barcode-helper junction (BsaI, all tiles)               |
| paqci_star2 | AATG     | PaqCI 5' end of insert (Level 2)                        |
| paqci_star1 | GCTA     | PaqCI 3' end of insert (Level 2)                        |

### Helper Plasmid Insert

The helper plasmid provides the backbone for each BsaI Level 1 reaction.

```
[PaqCI**]--[BsaI>>ATGG]--STUFFER--[TTCC<<BsaI]--[PaqCI*]
```

Insert length: 72 nt
oh_L = ATGG (first 4 nt of gene)
oh_R = TTCC (= oh4, barcode-helper junction)

## 7. Per-Tile Assembly Guide

### Tile 1 of 25 -- Codons 1-53 (159 nt)

**Boundary overhangs:**

| Position          | Sequence | Fidelity |
| ----------------- | -------- | -------- |
| oh1 (5' boundary) | ATGG     | 0.5393   |
| oh2 (3' boundary) | AACA     | 0.8032   |

**Variants:** 10290 mutations, 10290 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name                          | Length | 5' OH | 3' OH |
| --- | --------------- | ---------------------------------- | ------ | ----- | ----- |
| 1   | 5'WT gene block | (none -- tile starts at gene nt 1) | --     | --    | --    |
| 2   | Oligo pool      | Tile 1 (10290 oligos)              | 215 nt | ATGG  | TTCC  |
| 3   | Helper plasmid  | helper_plasmid_insert              | --     | --    | --    |
| 4   | Enzyme + buffer | BsaI-HFv2 + CutSmart               | --     | --    | --    |

```
  [ATGG]----oligo+BC----[TTCC]
   ATGG                  TTCC 
```

**Set fidelity:** 1.0000 (2 overhangs)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                 | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------- | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)       | --      | --    | --    |
| 2   | 3'WT block        | bsmbi_3wt_tile1_sub1      | 408 nt  | AACA  | ATTC  |
| 3   | 3'WT block        | bsmbi_3wt_tile1_sub2      | 1485 nt | ATTC  | AAGA  |
| 4   | 3'WT block        | bsmbi_3wt_tile1_sub3      | 1527 nt | AAGA  | TGAA  |
| 5   | 3'WT block        | bsmbi_3wt_tile1_sub4      | 906 nt  | TGAA  | --    |
| 6   | 3'WT+PolIII block | bsmbi_cassette_tile1_sub5 | 1094 nt | --    | CACC  |
| 7   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1  | --      | --    | --    |

```
  [AACA]----3'WT sub1----[ATTC]----3'WT sub2----[AAGA]----3'WT sub3----[TGAA]----3'WT sub4----[CACC]----3'WT+PolIII sub5----
   AACA                   ATTC                   AAGA                   TGAA                   CACC 
```

**Set fidelity:** 0.9920 (5 overhangs)

---

### Tile 2 of 25 -- Codons 50-127 (234 nt)

**Boundary overhangs:**

| Position          | Sequence | Fidelity |
| ----------------- | -------- | -------- |
| oh1 (5' boundary) | GAAC     | 0.6079   |
| oh2 (3' boundary) | CATT     | 0.6770   |

**Variants:** 15540 mutations, 15540 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name             | Length | 5' OH | 3' OH |
| --- | --------------- | --------------------- | ------ | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile2        | 165 nt | ATGG  | GAAC  |
| 2   | Oligo pool      | Tile 2 (15540 oligos) | 290 nt | GAAC  | TTCC  |
| 3   | Helper plasmid  | helper_plasmid_insert | --     | --    | --    |
| 4   | Enzyme + buffer | BsaI-HFv2 + CutSmart  | --     | --    | --    |

```
  [ATGG]----5'WT block----[GAAC]----oligo+BC----[TTCC]
   ATGG                    GAAC                  TTCC 
```

**Set fidelity:** 1.0000 (3 overhangs)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                 | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------- | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)       | --      | --    | --    |
| 2   | 3'WT block        | bsmbi_3wt_tile2_sub1      | 1653 nt | CATT  | ATTC  |
| 3   | 3'WT block        | bsmbi_3wt_tile1_sub3      | 1527 nt | ATTC  | AAGA  |
| 4   | 3'WT block        | bsmbi_3wt_tile1_sub4      | 906 nt  | AAGA  | TGAA  |
| 5   | 3'WT+PolIII block | bsmbi_cassette_tile1_sub5 | 1094 nt | TGAA  | CACC  |
| 6   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1  | --      | --    | --    |

```
  [CATT]----3'WT sub1----[ATTC]----3'WT sub2----[AAGA]----3'WT sub3----[TGAA]----3'WT+PolIII sub4----[CACC]
   CATT                   ATTC                   AAGA                   TGAA                          CACC 
```

**Set fidelity:** 1.0000 (5 overhangs)

---

### Tile 3 of 25 -- Codons 124-183 (180 nt)

**Boundary overhangs:**

| Position          | Sequence | Fidelity |
| ----------------- | -------- | -------- |
| oh1 (5' boundary) | ATCT     | 0.7151   |
| oh2 (3' boundary) | ATTC     | 0.7084   |

**Variants:** 11760 mutations, 11760 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name             | Length | 5' OH | 3' OH |
| --- | --------------- | --------------------- | ------ | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile3        | 387 nt | ATGG  | ATCT  |
| 2   | Oligo pool      | Tile 3 (11760 oligos) | 236 nt | ATCT  | TTCC  |
| 3   | Helper plasmid  | helper_plasmid_insert | --     | --    | --    |
| 4   | Enzyme + buffer | BsaI-HFv2 + CutSmart  | --     | --    | --    |

```
  [ATGG]----5'WT block----[ATCT]----oligo+BC----[TTCC]
   ATGG                    ATCT                  TTCC 
```

**Set fidelity:** 0.9985 (3 overhangs)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                 | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------- | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)       | --      | --    | --    |
| 2   | 3'WT block        | bsmbi_3wt_tile1_sub2      | 1485 nt | ATTC  | AAGA  |
| 3   | 3'WT block        | bsmbi_3wt_tile1_sub3      | 1527 nt | AAGA  | TGAA  |
| 4   | 3'WT block        | bsmbi_3wt_tile1_sub4      | 906 nt  | TGAA  | --    |
| 5   | 3'WT+PolIII block | bsmbi_cassette_tile1_sub5 | 1094 nt | --    | CACC  |
| 6   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1  | --      | --    | --    |

```
  [ATTC]----3'WT sub1----[AAGA]----3'WT sub2----[TGAA]----3'WT sub3----[CACC]----3'WT+PolIII sub4----
   ATTC                   AAGA                   TGAA                   CACC 
```

**Set fidelity:** 1.0000 (4 overhangs)

---

### Tile 4 of 25 -- Codons 180-257 (234 nt)

**Boundary overhangs:**

| Position          | Sequence | Fidelity |
| ----------------- | -------- | -------- |
| oh1 (5' boundary) | TACA     | 0.8652   |
| oh2 (3' boundary) | TGTC     | 0.6650   |

**Variants:** 15540 mutations, 15540 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name             | Length | 5' OH | 3' OH |
| --- | --------------- | --------------------- | ------ | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile4        | 555 nt | ATGG  | TACA  |
| 2   | Oligo pool      | Tile 4 (15540 oligos) | 290 nt | TACA  | TTCC  |
| 3   | Helper plasmid  | helper_plasmid_insert | --     | --    | --    |
| 4   | Enzyme + buffer | BsaI-HFv2 + CutSmart  | --     | --    | --    |

```
  [ATGG]----5'WT block----[TACA]----oligo+BC----[TTCC]
   ATGG                    TACA                  TTCC 
```

**Set fidelity:** 1.0000 (3 overhangs)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                 | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------- | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)       | --      | --    | --    |
| 2   | 3'WT block        | bsmbi_3wt_tile4_sub1      | 1263 nt | TGTC  | AAGA  |
| 3   | 3'WT block        | bsmbi_3wt_tile1_sub3      | 1527 nt | AAGA  | TGAA  |
| 4   | 3'WT block        | bsmbi_3wt_tile1_sub4      | 906 nt  | TGAA  | --    |
| 5   | 3'WT+PolIII block | bsmbi_cassette_tile1_sub5 | 1094 nt | --    | CACC  |
| 6   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1  | --      | --    | --    |

```
  [TGTC]----3'WT sub1----[AAGA]----3'WT sub2----[TGAA]----3'WT sub3----[CACC]----3'WT+PolIII sub4----
   TGTC                   AAGA                   TGAA                   CACC 
```

**Set fidelity:** 1.0000 (4 overhangs)

---

### Tile 5 of 25 -- Codons 254-313 (180 nt)

**Boundary overhangs:**

| Position          | Sequence | Fidelity |
| ----------------- | -------- | -------- |
| oh1 (5' boundary) | TTCT     | 0.8181   |
| oh2 (3' boundary) | CATC     | 0.5216   |

**Variants:** 11760 mutations, 11760 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name             | Length | 5' OH | 3' OH |
| --- | --------------- | --------------------- | ------ | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile5_sub1   | 777 nt | ATGG  | TTCT  |
| 2   | Oligo pool      | Tile 5 (11760 oligos) | 236 nt | TTCT  | TTCC  |
| 3   | Helper plasmid  | helper_plasmid_insert | --     | --    | --    |
| 4   | Enzyme + buffer | BsaI-HFv2 + CutSmart  | --     | --    | --    |

```
  [ATGG]----5'WT sub1----[ATTC]----oligo+BC----[TTCT][TTCC]
   ATGG                   ATTC                  TTCT  TTCC 
```

**Set fidelity:** 0.9485 (4 overhangs)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                 | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------- | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)       | --      | --    | --    |
| 2   | 3'WT block        | bsmbi_3wt_tile5_sub1      | 1095 nt | CATC  | AAGA  |
| 3   | 3'WT block        | bsmbi_3wt_tile1_sub3      | 1527 nt | AAGA  | TGAA  |
| 4   | 3'WT block        | bsmbi_3wt_tile1_sub4      | 906 nt  | TGAA  | --    |
| 5   | 3'WT+PolIII block | bsmbi_cassette_tile1_sub5 | 1094 nt | --    | CACC  |
| 6   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1  | --      | --    | --    |

```
  [CATC]----3'WT sub1----[AAGA]----3'WT sub2----[TGAA]----3'WT sub3----[CACC]----3'WT+PolIII sub4----
   CATC                   AAGA                   TGAA                   CACC 
```

**Set fidelity:** 0.8115 (4 overhangs)

---

### Tile 6 of 25 -- Codons 310-353 (132 nt)

**Boundary overhangs:**

| Position          | Sequence | Fidelity |
| ----------------- | -------- | -------- |
| oh1 (5' boundary) | TTCT     | 0.8181   |
| oh2 (3' boundary) | GGAA     | 0.7463   |

**Variants:** 8400 mutations, 8400 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name             | Length | 5' OH | 3' OH |
| --- | --------------- | --------------------- | ------ | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile6_sub1   | 563 nt | ATGG  | ATTC  |
| 2   | 5'WT gene block | bsai_5wt_tile6_sub2   | 400 nt | ATTC  | TTCT  |
| 3   | Oligo pool      | Tile 6 (8400 oligos)  | 188 nt | TTCT  | TTCC  |
| 4   | Helper plasmid  | helper_plasmid_insert | --     | --    | --    |
| 5   | Enzyme + buffer | BsaI-HFv2 + CutSmart  | --     | --    | --    |

```
  [ATGG]----5'WT sub1----[ATTC]----5'WT sub2----[TTCT]----oligo+BC----[TTCC]
   ATGG                   ATTC                   TTCT                  TTCC 
```

**Set fidelity:** 0.9485 (4 overhangs)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                 | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------- | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)       | --      | --    | --    |
| 2   | 3'WT block        | bsmbi_3wt_tile6_sub1      | 975 nt  | GGAA  | AAGA  |
| 3   | 3'WT block        | bsmbi_3wt_tile1_sub3      | 1527 nt | AAGA  | TGAA  |
| 4   | 3'WT block        | bsmbi_3wt_tile1_sub4      | 906 nt  | TGAA  | --    |
| 5   | 3'WT+PolIII block | bsmbi_cassette_tile1_sub5 | 1094 nt | --    | CACC  |
| 6   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1  | --      | --    | --    |

```
  [GGAA]----3'WT sub1----[AAGA]----3'WT sub2----[TGAA]----3'WT sub3----[CACC]----3'WT+PolIII sub4----
   GGAA                   AAGA                   TGAA                   CACC 
```

**Set fidelity:** 0.9926 (4 overhangs)

---

### Tile 7 of 25 -- Codons 350-399 (150 nt)

**Boundary overhangs:**

| Position          | Sequence | Fidelity |
| ----------------- | -------- | -------- |
| oh1 (5' boundary) | TTCA     | 0.8824   |
| oh2 (3' boundary) | CTGT     | 0.6476   |

**Variants:** 9660 mutations, 9660 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name             | Length | 5' OH | 3' OH |
| --- | --------------- | --------------------- | ------ | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile6_sub1   | 563 nt | ATGG  | ATTC  |
| 2   | 5'WT gene block | bsai_5wt_tile7_sub2   | 520 nt | ATTC  | TTCA  |
| 3   | Oligo pool      | Tile 7 (9660 oligos)  | 206 nt | TTCA  | TTCC  |
| 4   | Helper plasmid  | helper_plasmid_insert | --     | --    | --    |
| 5   | Enzyme + buffer | BsaI-HFv2 + CutSmart  | --     | --    | --    |

```
  [ATGG]----5'WT sub1----[ATTC]----5'WT sub2----[TTCA]----oligo+BC----[TTCC]
   ATGG                   ATTC                   TTCA                  TTCC 
```

**Set fidelity:** 0.9899 (4 overhangs)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                 | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------- | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)       | --      | --    | --    |
| 2   | 3'WT block        | bsmbi_3wt_tile7_sub1      | 837 nt  | CTGT  | AAGA  |
| 3   | 3'WT block        | bsmbi_3wt_tile1_sub3      | 1527 nt | AAGA  | TGAA  |
| 4   | 3'WT block        | bsmbi_3wt_tile1_sub4      | 906 nt  | TGAA  | --    |
| 5   | 3'WT+PolIII block | bsmbi_cassette_tile1_sub5 | 1094 nt | --    | CACC  |
| 6   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1  | --      | --    | --    |

```
  [CTGT]----3'WT sub1----[AAGA]----3'WT sub2----[TGAA]----3'WT sub3----[CACC]----3'WT+PolIII sub4----
   CTGT                   AAGA                   TGAA                   CACC 
```

**Set fidelity:** 1.0000 (4 overhangs)

---

### Tile 8 of 25 -- Codons 396-468 (219 nt)

**Boundary overhangs:**

| Position          | Sequence | Fidelity |
| ----------------- | -------- | -------- |
| oh1 (5' boundary) | TTCT     | 0.8181   |
| oh2 (3' boundary) | TTCC     | 0.7958   |

**Variants:** 14490 mutations, 14490 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name             | Length | 5' OH | 3' OH |
| --- | --------------- | --------------------- | ------ | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile6_sub1   | 563 nt | ATGG  | ATTC  |
| 2   | 5'WT gene block | bsai_5wt_tile8_sub2   | 658 nt | ATTC  | TTCT  |
| 3   | Oligo pool      | Tile 8 (14490 oligos) | 275 nt | TTCT  | TTCC  |
| 4   | Helper plasmid  | helper_plasmid_insert | --     | --    | --    |
| 5   | Enzyme + buffer | BsaI-HFv2 + CutSmart  | --     | --    | --    |

```
  [ATGG]----5'WT sub1----[ATTC]----5'WT sub2----[TTCT]----oligo+BC----[TTCC]
   ATGG                   ATTC                   TTCT                  TTCC 
```

**Set fidelity:** 0.9485 (4 overhangs)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                 | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------- | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)       | --      | --    | --    |
| 2   | 3'WT block        | bsmbi_3wt_tile8_sub1      | 630 nt  | TTCC  | AAGA  |
| 3   | 3'WT block        | bsmbi_3wt_tile1_sub3      | 1527 nt | AAGA  | TGAA  |
| 4   | 3'WT block        | bsmbi_3wt_tile1_sub4      | 906 nt  | TGAA  | --    |
| 5   | 3'WT+PolIII block | bsmbi_cassette_tile1_sub5 | 1094 nt | --    | CACC  |
| 6   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1  | --      | --    | --    |

```
  [TTCC]----3'WT sub1----[AAGA]----3'WT sub2----[TGAA]----3'WT sub3----[CACC]----3'WT+PolIII sub4----
   TTCC                   AAGA                   TGAA                   CACC 
```

**Set fidelity:** 0.9988 (4 overhangs)

---

### Tile 9 of 25 -- Codons 465-542 (234 nt)

**Boundary overhangs:**

| Position          | Sequence | Fidelity |
| ----------------- | -------- | -------- |
| oh1 (5' boundary) | AAGA     | 0.9209   |
| oh2 (3' boundary) | TGGC     | 0.5926   |

**Variants:** 15540 mutations, 15540 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name             | Length | 5' OH | 3' OH |
| --- | --------------- | --------------------- | ------ | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile6_sub1   | 563 nt | ATGG  | ATTC  |
| 2   | 5'WT gene block | bsai_5wt_tile9_sub2   | 865 nt | ATTC  | AAGA  |
| 3   | Oligo pool      | Tile 9 (15540 oligos) | 290 nt | AAGA  | TTCC  |
| 4   | Helper plasmid  | helper_plasmid_insert | --     | --    | --    |
| 5   | Enzyme + buffer | BsaI-HFv2 + CutSmart  | --     | --    | --    |

```
  [ATGG]----5'WT sub1----[ATTC]----5'WT sub2----[AAGA]----oligo+BC----[TTCC]
   ATGG                   ATTC                   AAGA                  TTCC 
```

**Set fidelity:** 1.0000 (4 overhangs)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                 | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------- | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)       | --      | --    | --    |
| 2   | 3'WT block        | bsmbi_3wt_tile9_sub1      | 408 nt  | TGGC  | AAGA  |
| 3   | 3'WT block        | bsmbi_3wt_tile1_sub3      | 1527 nt | AAGA  | TGAA  |
| 4   | 3'WT block        | bsmbi_3wt_tile1_sub4      | 906 nt  | TGAA  | --    |
| 5   | 3'WT+PolIII block | bsmbi_cassette_tile1_sub5 | 1094 nt | --    | CACC  |
| 6   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1  | --      | --    | --    |

```
  [TGGC]----3'WT sub1----[AAGA]----3'WT sub2----[TGAA]----3'WT sub3----[CACC]----3'WT+PolIII sub4----
   TGGC                   AAGA                   TGAA                   CACC 
```

**Set fidelity:** 1.0000 (4 overhangs)

---

### Tile 10 of 25 -- Codons 539-600 (186 nt)

**Boundary overhangs:**

| Position          | Sequence | Fidelity |
| ----------------- | -------- | -------- |
| oh1 (5' boundary) | AGAA     | 0.8847   |
| oh2 (3' boundary) | TACA     | 0.8652   |

**Variants:** 12180 mutations, 12180 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name              | Length  | 5' OH | 3' OH |
| --- | --------------- | ---------------------- | ------- | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile6_sub1    | 563 nt  | ATGG  | ATTC  |
| 2   | 5'WT gene block | bsai_5wt_tile10_sub2   | 1087 nt | ATTC  | AGAA  |
| 3   | Oligo pool      | Tile 10 (12180 oligos) | 242 nt  | AGAA  | TTCC  |
| 4   | Helper plasmid  | helper_plasmid_insert  | --      | --    | --    |
| 5   | Enzyme + buffer | BsaI-HFv2 + CutSmart   | --      | --    | --    |

```
  [ATGG]----5'WT sub1----[ATTC]----5'WT sub2----[AGAA]----oligo+BC----[TTCC]
   ATGG                   ATTC                   AGAA                  TTCC 
```

**Set fidelity:** 1.0000 (4 overhangs)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                 | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------- | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)       | --      | --    | --    |
| 2   | 3'WT block        | bsmbi_3wt_tile10_sub1     | 1743 nt | TACA  | AAGA  |
| 3   | 3'WT block        | bsmbi_3wt_tile1_sub4      | 906 nt  | AAGA  | TGAA  |
| 4   | 3'WT+PolIII block | bsmbi_cassette_tile1_sub5 | 1094 nt | TGAA  | CACC  |
| 5   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1  | --      | --    | --    |

```
  [TACA]----3'WT sub1----[AAGA]----3'WT sub2----[TGAA]----3'WT+PolIII sub3----[CACC]
   TACA                   AAGA                   TGAA                          CACC 
```

**Set fidelity:** 1.0000 (4 overhangs)

---

### Tile 11 of 25 -- Codons 597-672 (228 nt)

**Boundary overhangs:**

| Position          | Sequence | Fidelity |
| ----------------- | -------- | -------- |
| oh1 (5' boundary) | CCTT     | 0.6891   |
| oh2 (3' boundary) | AAGA     | 0.9209   |

**Variants:** 15120 mutations, 15120 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name              | Length  | 5' OH | 3' OH |
| --- | --------------- | ---------------------- | ------- | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile6_sub1    | 563 nt  | ATGG  | ATTC  |
| 2   | 5'WT gene block | bsai_5wt_tile11_sub2   | 1261 nt | ATTC  | CCTT  |
| 3   | Oligo pool      | Tile 11 (15120 oligos) | 284 nt  | CCTT  | TTCC  |
| 4   | Helper plasmid  | helper_plasmid_insert  | --      | --    | --    |
| 5   | Enzyme + buffer | BsaI-HFv2 + CutSmart   | --      | --    | --    |

```
  [ATGG]----5'WT sub1----[ATTC]----5'WT sub2----[CCTT]----oligo+BC----[TTCC]
   ATGG                   ATTC                   CCTT                  TTCC 
```

**Set fidelity:** 1.0000 (4 overhangs)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                 | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------- | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)       | --      | --    | --    |
| 2   | 3'WT block        | bsmbi_3wt_tile1_sub3      | 1527 nt | AAGA  | TGAA  |
| 3   | 3'WT block        | bsmbi_3wt_tile1_sub4      | 906 nt  | TGAA  | --    |
| 4   | 3'WT+PolIII block | bsmbi_cassette_tile1_sub5 | 1094 nt | --    | CACC  |
| 5   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1  | --      | --    | --    |

```
  [AAGA]----3'WT sub1----[TGAA]----3'WT sub2----[CACC]----3'WT+PolIII sub3----
   AAGA                   TGAA                   CACC 
```

**Set fidelity:** 1.0000 (3 overhangs)

---

### Tile 12 of 25 -- Codons 669-708 (120 nt)

**Boundary overhangs:**

| Position          | Sequence | Fidelity |
| ----------------- | -------- | -------- |
| oh1 (5' boundary) | AAGT     | 0.7629   |
| oh2 (3' boundary) | ATTT     | 0.7664   |

**Variants:** 7560 mutations, 7560 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name             | Length  | 5' OH | 3' OH |
| --- | --------------- | --------------------- | ------- | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile6_sub1   | 563 nt  | ATGG  | ATTC  |
| 2   | 5'WT gene block | bsai_5wt_tile12_sub2  | 1477 nt | ATTC  | AAGT  |
| 3   | Oligo pool      | Tile 12 (7560 oligos) | 176 nt  | AAGT  | TTCC  |
| 4   | Helper plasmid  | helper_plasmid_insert | --      | --    | --    |
| 5   | Enzyme + buffer | BsaI-HFv2 + CutSmart  | --      | --    | --    |

```
  [ATGG]----5'WT sub1----[ATTC]----5'WT sub2----[AAGT]----oligo+BC----[TTCC]
   ATGG                   ATTC                   AAGT                  TTCC 
```

**Set fidelity:** 1.0000 (4 overhangs)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                 | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------- | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)       | --      | --    | --    |
| 2   | 3'WT block        | bsmbi_3wt_tile12_sub1     | 1419 nt | ATTT  | TGAA  |
| 3   | 3'WT block        | bsmbi_3wt_tile1_sub4      | 906 nt  | TGAA  | --    |
| 4   | 3'WT+PolIII block | bsmbi_cassette_tile1_sub5 | 1094 nt | --    | CACC  |
| 5   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1  | --      | --    | --    |

```
  [ATTT]----3'WT sub1----[TGAA]----3'WT sub2----[CACC]----3'WT+PolIII sub3----
   ATTT                   TGAA                   CACC 
```

**Set fidelity:** 1.0000 (3 overhangs)

---

### Tile 13 of 25 -- Codons 705-770 (198 nt)

**Boundary overhangs:**

| Position          | Sequence | Fidelity |
| ----------------- | -------- | -------- |
| oh1 (5' boundary) | ATGA     | 0.7549   |
| oh2 (3' boundary) | TCCT     | 0.7573   |

**Variants:** 13020 mutations, 13020 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name              | Length  | 5' OH | 3' OH |
| --- | --------------- | ---------------------- | ------- | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile6_sub1    | 563 nt  | ATGG  | ATTC  |
| 2   | 5'WT gene block | bsai_5wt_tile13_sub2   | 1585 nt | ATTC  | ATGA  |
| 3   | Oligo pool      | Tile 13 (13020 oligos) | 254 nt  | ATGA  | TTCC  |
| 4   | Helper plasmid  | helper_plasmid_insert  | --      | --    | --    |
| 5   | Enzyme + buffer | BsaI-HFv2 + CutSmart   | --      | --    | --    |

```
  [ATGG]----5'WT sub1----[ATTC]----5'WT sub2----[AAGA]----oligo+BC----[ATGA][TTCC]
   ATGG                   ATTC                   AAGA                  ATGA  TTCC 
```

**Set fidelity:** 0.8570 (5 overhangs)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                 | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------- | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)       | --      | --    | --    |
| 2   | 3'WT block        | bsmbi_3wt_tile13_sub1     | 1233 nt | TCCT  | TGAA  |
| 3   | 3'WT block        | bsmbi_3wt_tile1_sub4      | 906 nt  | TGAA  | --    |
| 4   | 3'WT+PolIII block | bsmbi_cassette_tile1_sub5 | 1094 nt | --    | CACC  |
| 5   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1  | --      | --    | --    |

```
  [TCCT]----3'WT sub1----[TGAA]----3'WT sub2----[CACC]----3'WT+PolIII sub3----
   TCCT                   TGAA                   CACC 
```

**Set fidelity:** 1.0000 (3 overhangs)

---

### Tile 14 of 25 -- Codons 767-844 (234 nt)

**Boundary overhangs:**

| Position          | Sequence | Fidelity |
| ----------------- | -------- | -------- |
| oh1 (5' boundary) | AAAG     | 0.7511   |
| oh2 (3' boundary) | GAAG     | 0.6752   |

**Variants:** 15540 mutations, 15540 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name              | Length  | 5' OH | 3' OH |
| --- | --------------- | ---------------------- | ------- | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile6_sub1    | 563 nt  | ATGG  | ATTC  |
| 2   | 5'WT gene block | bsai_5wt_tile14_sub2   | 1485 nt | ATTC  | AAGA  |
| 3   | 5'WT gene block | bsai_5wt_tile14_sub3   | 304 nt  | AAGA  | AAAG  |
| 4   | Oligo pool      | Tile 14 (15540 oligos) | 290 nt  | AAAG  | TTCC  |
| 5   | Helper plasmid  | helper_plasmid_insert  | --      | --    | --    |
| 6   | Enzyme + buffer | BsaI-HFv2 + CutSmart   | --      | --    | --    |

```
  [ATGG]----5'WT sub1----[ATTC]----5'WT sub2----[AAGA]----5'WT sub3----[AAAG]----oligo+BC----[TTCC]
   ATGG                   ATTC                   AAGA                   AAAG                  TTCC 
```

**Set fidelity:** 1.0000 (5 overhangs)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                 | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------- | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)       | --      | --    | --    |
| 2   | 3'WT block        | bsmbi_3wt_tile14_sub1     | 1011 nt | GAAG  | TGAA  |
| 3   | 3'WT block        | bsmbi_3wt_tile1_sub4      | 906 nt  | TGAA  | --    |
| 4   | 3'WT+PolIII block | bsmbi_cassette_tile1_sub5 | 1094 nt | --    | CACC  |
| 5   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1  | --      | --    | --    |

```
  [GAAG]----3'WT sub1----[TGAA]----3'WT sub2----[CACC]----3'WT+PolIII sub3----
   GAAG                   TGAA                   CACC 
```

**Set fidelity:** 1.0000 (3 overhangs)

---

### Tile 15 of 25 -- Codons 841-905 (195 nt)

**Boundary overhangs:**

| Position          | Sequence | Fidelity |
| ----------------- | -------- | -------- |
| oh1 (5' boundary) | TTCT     | 0.8181   |
| oh2 (3' boundary) | TTCC     | 0.7958   |

**Variants:** 12810 mutations, 12810 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name              | Length  | 5' OH | 3' OH |
| --- | --------------- | ---------------------- | ------- | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile6_sub1    | 563 nt  | ATGG  | ATTC  |
| 2   | 5'WT gene block | bsai_5wt_tile14_sub2   | 1485 nt | ATTC  | AAGA  |
| 3   | 5'WT gene block | bsai_5wt_tile15_sub3   | 526 nt  | AAGA  | TTCT  |
| 4   | Oligo pool      | Tile 15 (12810 oligos) | 251 nt  | TTCT  | TTCC  |
| 5   | Helper plasmid  | helper_plasmid_insert  | --      | --    | --    |
| 6   | Enzyme + buffer | BsaI-HFv2 + CutSmart   | --      | --    | --    |

```
  [ATGG]----5'WT sub1----[ATTC]----5'WT sub2----[AAGA]----5'WT sub3----[TTCT]----oligo+BC----[TTCC]
   ATGG                   ATTC                   AAGA                   TTCT                  TTCC 
```

**Set fidelity:** 0.9485 (5 overhangs)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                 | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------- | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)       | --      | --    | --    |
| 2   | 3'WT block        | bsmbi_3wt_tile15_sub1     | 828 nt  | TTCC  | TGAA  |
| 3   | 3'WT block        | bsmbi_3wt_tile1_sub4      | 906 nt  | TGAA  | --    |
| 4   | 3'WT+PolIII block | bsmbi_cassette_tile1_sub5 | 1094 nt | --    | CACC  |
| 5   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1  | --      | --    | --    |

```
  [TTCC]----3'WT sub1----[TGAA]----3'WT sub2----[CACC]----3'WT+PolIII sub3----
   TTCC                   TGAA                   CACC 
```

**Set fidelity:** 0.9988 (3 overhangs)

---

### Tile 16 of 25 -- Codons 902-979 (234 nt)

**Boundary overhangs:**

| Position          | Sequence | Fidelity |
| ----------------- | -------- | -------- |
| oh1 (5' boundary) | AAAA     | 0.9502   |
| oh2 (3' boundary) | TGTA     | 0.7693   |

**Variants:** 15540 mutations, 15540 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name              | Length  | 5' OH | 3' OH |
| --- | --------------- | ---------------------- | ------- | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile6_sub1    | 563 nt  | ATGG  | ATTC  |
| 2   | 5'WT gene block | bsai_5wt_tile14_sub2   | 1485 nt | ATTC  | AAGA  |
| 3   | 5'WT gene block | bsai_5wt_tile16_sub3   | 709 nt  | AAGA  | AAAA  |
| 4   | Oligo pool      | Tile 16 (15540 oligos) | 290 nt  | AAAA  | TTCC  |
| 5   | Helper plasmid  | helper_plasmid_insert  | --      | --    | --    |
| 6   | Enzyme + buffer | BsaI-HFv2 + CutSmart   | --      | --    | --    |

```
  [ATGG]----5'WT sub1----[ATTC]----5'WT sub2----[AAGA]----5'WT sub3----[AAAA]----oligo+BC----[TTCC]
   ATGG                   ATTC                   AAGA                   AAAA                  TTCC 
```

**Set fidelity:** 0.9909 (5 overhangs)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                 | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------- | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)       | --      | --    | --    |
| 2   | 3'WT block        | bsmbi_3wt_tile16_sub1     | 606 nt  | TGTA  | TGAA  |
| 3   | 3'WT block        | bsmbi_3wt_tile1_sub4      | 906 nt  | TGAA  | --    |
| 4   | 3'WT+PolIII block | bsmbi_cassette_tile1_sub5 | 1094 nt | --    | CACC  |
| 5   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1  | --      | --    | --    |

```
  [TGTA]----3'WT sub1----[TGAA]----3'WT sub2----[CACC]----3'WT+PolIII sub3----
   TGTA                   TGAA                   CACC 
```

**Set fidelity:** 0.9842 (3 overhangs)

---

### Tile 17 of 25 -- Codons 976-1020 (135 nt)

**Boundary overhangs:**

| Position          | Sequence | Fidelity |
| ----------------- | -------- | -------- |
| oh1 (5' boundary) | AATA     | 0.8816   |
| oh2 (3' boundary) | TTCC     | 0.7958   |

**Variants:** 8610 mutations, 8610 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name             | Length  | 5' OH | 3' OH |
| --- | --------------- | --------------------- | ------- | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile6_sub1   | 563 nt  | ATGG  | ATTC  |
| 2   | 5'WT gene block | bsai_5wt_tile14_sub2  | 1485 nt | ATTC  | AAGA  |
| 3   | 5'WT gene block | bsai_5wt_tile17_sub3  | 931 nt  | AAGA  | AATA  |
| 4   | Oligo pool      | Tile 17 (8610 oligos) | 191 nt  | AATA  | TTCC  |
| 5   | Helper plasmid  | helper_plasmid_insert | --      | --    | --    |
| 6   | Enzyme + buffer | BsaI-HFv2 + CutSmart  | --      | --    | --    |

```
  [ATGG]----5'WT sub1----[ATTC]----5'WT sub2----[AAGA]----5'WT sub3----[AATA]----oligo+BC----[TTCC]
   ATGG                   ATTC                   AAGA                   AATA                  TTCC 
```

**Set fidelity:** 1.0000 (5 overhangs)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                 | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------- | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)       | --      | --    | --    |
| 2   | 3'WT block        | bsmbi_3wt_tile17_sub1     | 483 nt  | TTCC  | TGAA  |
| 3   | 3'WT block        | bsmbi_3wt_tile1_sub4      | 906 nt  | TGAA  | --    |
| 4   | 3'WT+PolIII block | bsmbi_cassette_tile1_sub5 | 1094 nt | --    | CACC  |
| 5   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1  | --      | --    | --    |

```
  [TTCC]----3'WT sub1----[TGAA]----3'WT sub2----[CACC]----3'WT+PolIII sub3----
   TTCC                   TGAA                   CACC 
```

**Set fidelity:** 0.9988 (3 overhangs)

---

### Tile 18 of 25 -- Codons 1017-1066 (150 nt)

**Boundary overhangs:**

| Position          | Sequence | Fidelity |
| ----------------- | -------- | -------- |
| oh1 (5' boundary) | TCCG     | 0.7234   |
| oh2 (3' boundary) | AAAT     | 0.7737   |

**Variants:** 9660 mutations, 9660 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name             | Length  | 5' OH | 3' OH |
| --- | --------------- | --------------------- | ------- | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile6_sub1   | 563 nt  | ATGG  | ATTC  |
| 2   | 5'WT gene block | bsai_5wt_tile14_sub2  | 1485 nt | ATTC  | AAGA  |
| 3   | 5'WT gene block | bsai_5wt_tile18_sub3  | 1054 nt | AAGA  | TCCG  |
| 4   | Oligo pool      | Tile 18 (9660 oligos) | 206 nt  | TCCG  | TTCC  |
| 5   | Helper plasmid  | helper_plasmid_insert | --      | --    | --    |
| 6   | Enzyme + buffer | BsaI-HFv2 + CutSmart  | --      | --    | --    |

```
  [ATGG]----5'WT sub1----[ATTC]----5'WT sub2----[AAGA]----5'WT sub3----[TCCG]----oligo+BC----[TTCC]
   ATGG                   ATTC                   AAGA                   TCCG                  TTCC 
```

**Set fidelity:** 1.0000 (5 overhangs)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                 | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------- | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)       | --      | --    | --    |
| 2   | 3'WT block        | bsmbi_3wt_tile18_sub1     | 345 nt  | AAAT  | TGAA  |
| 3   | 3'WT block        | bsmbi_3wt_tile1_sub4      | 906 nt  | TGAA  | --    |
| 4   | 3'WT+PolIII block | bsmbi_cassette_tile1_sub5 | 1094 nt | --    | CACC  |
| 5   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1  | --      | --    | --    |

```
  [AAAT]----3'WT sub1----[TGAA]----3'WT sub2----[CACC]----3'WT+PolIII sub3----
   AAAT                   TGAA                   CACC 
```

**Set fidelity:** 1.0000 (3 overhangs)

---

### Tile 19 of 25 -- Codons 1063-1110 (144 nt)

**Boundary overhangs:**

| Position          | Sequence | Fidelity |
| ----------------- | -------- | -------- |
| oh1 (5' boundary) | GAAA     | 0.8745   |
| oh2 (3' boundary) | ATCA     | 0.7483   |

**Variants:** 9240 mutations, 9240 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name             | Length  | 5' OH | 3' OH |
| --- | --------------- | --------------------- | ------- | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile6_sub1   | 563 nt  | ATGG  | ATTC  |
| 2   | 5'WT gene block | bsai_5wt_tile14_sub2  | 1485 nt | ATTC  | AAGA  |
| 3   | 5'WT gene block | bsai_5wt_tile19_sub3  | 1192 nt | AAGA  | GAAA  |
| 4   | Oligo pool      | Tile 19 (9240 oligos) | 200 nt  | GAAA  | TTCC  |
| 5   | Helper plasmid  | helper_plasmid_insert | --      | --    | --    |
| 6   | Enzyme + buffer | BsaI-HFv2 + CutSmart  | --      | --    | --    |

```
  [ATGG]----5'WT sub1----[ATTC]----5'WT sub2----[AAGA]----5'WT sub3----[GAAA]----oligo+BC----[TTCC]
   ATGG                   ATTC                   AAGA                   GAAA                  TTCC 
```

**Set fidelity:** 1.0000 (5 overhangs)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                 | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------- | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)       | --      | --    | --    |
| 2   | 3'WT block        | bsmbi_3wt_tile19_sub1     | 213 nt  | ATCA  | TGAA  |
| 3   | 3'WT block        | bsmbi_3wt_tile1_sub4      | 906 nt  | TGAA  | --    |
| 4   | 3'WT+PolIII block | bsmbi_cassette_tile1_sub5 | 1094 nt | --    | CACC  |
| 5   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1  | --      | --    | --    |

```
  [ATCA]----3'WT sub1----[TGAA]----3'WT sub2----[CACC]----3'WT+PolIII sub3----
   ATCA                   TGAA                   CACC 
```

**Set fidelity:** 1.0000 (3 overhangs)

---

### Tile 20 of 25 -- Codons 1107-1175 (207 nt)

**Boundary overhangs:**

| Position          | Sequence | Fidelity |
| ----------------- | -------- | -------- |
| oh1 (5' boundary) | AAAA     | 0.9502   |
| oh2 (3' boundary) | TGAA     | 0.8621   |

**Variants:** 13650 mutations, 13650 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name              | Length  | 5' OH | 3' OH |
| --- | --------------- | ---------------------- | ------- | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile6_sub1    | 563 nt  | ATGG  | ATTC  |
| 2   | 5'WT gene block | bsai_5wt_tile14_sub2   | 1485 nt | ATTC  | AAGA  |
| 3   | 5'WT gene block | bsai_5wt_tile20_sub3   | 1324 nt | AAGA  | AAAA  |
| 4   | Oligo pool      | Tile 20 (13650 oligos) | 263 nt  | AAAA  | TTCC  |
| 5   | Helper plasmid  | helper_plasmid_insert  | --      | --    | --    |
| 6   | Enzyme + buffer | BsaI-HFv2 + CutSmart   | --      | --    | --    |

```
  [ATGG]----5'WT sub1----[ATTC]----5'WT sub2----[AAGA]----5'WT sub3----[AAAA]----oligo+BC----[TTCC]
   ATGG                   ATTC                   AAGA                   AAAA                  TTCC 
```

**Set fidelity:** 0.9909 (5 overhangs)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------ | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)      | --      | --    | --    |
| 2   | 3'WT block        | bsmbi_3wt_tile20_sub1    | 513 nt  | TGAA  | --    |
| 3   | 3'WT+PolIII block | bsmbi_3wt_tile20_sub2    | 1487 nt | --    | CACC  |
| 4   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1 | --      | --    | --    |

```
  [TGAA]----3'WT+PolIII----[CACC]
   TGAA                     CACC 
```

**Set fidelity:** 1.0000 (2 overhangs)

---

### Tile 21 of 25 -- Codons 1172-1218 (141 nt)

**Boundary overhangs:**

| Position          | Sequence | Fidelity |
| ----------------- | -------- | -------- |
| oh1 (5' boundary) | TTGC     | 0.7336   |
| oh2 (3' boundary) | CCTT     | 0.6891   |

**Variants:** 9030 mutations, 9030 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name             | Length  | 5' OH | 3' OH |
| --- | --------------- | --------------------- | ------- | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile6_sub1   | 563 nt  | ATGG  | ATTC  |
| 2   | 5'WT gene block | bsai_5wt_tile14_sub2  | 1485 nt | ATTC  | AAGA  |
| 3   | 5'WT gene block | bsai_5wt_tile21_sub3  | 1519 nt | AAGA  | TTGC  |
| 4   | Oligo pool      | Tile 21 (9030 oligos) | 197 nt  | TTGC  | TTCC  |
| 5   | Helper plasmid  | helper_plasmid_insert | --      | --    | --    |
| 6   | Enzyme + buffer | BsaI-HFv2 + CutSmart  | --      | --    | --    |

```
  [ATGG]----5'WT sub1----[ATTC]----5'WT sub2----[AAGA]----5'WT sub3----[TTGC]----oligo+BC----[TTCC]
   ATGG                   ATTC                   AAGA                   TTGC                  TTCC 
```

**Set fidelity:** 0.9761 (5 overhangs)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------ | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)      | --      | --    | --    |
| 2   | 3'WT block        | bsmbi_3wt_tile21_sub1    | 384 nt  | CCTT  | --    |
| 3   | 3'WT+PolIII block | bsmbi_3wt_tile20_sub2    | 1487 nt | --    | CACC  |
| 4   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1 | --      | --    | --    |

```
  [CCTT]----3'WT+PolIII----[CACC]
   CCTT                     CACC 
```

**Set fidelity:** 1.0000 (2 overhangs)

---

### Tile 22 of 25 -- Codons 1215-1289 (225 nt)

**Boundary overhangs:**

| Position          | Sequence | Fidelity |
| ----------------- | -------- | -------- |
| oh1 (5' boundary) | AGAA     | 0.8847   |
| oh2 (3' boundary) | TCAG     | 0.7814   |

**Variants:** 14910 mutations, 14910 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name              | Length  | 5' OH | 3' OH |
| --- | --------------- | ---------------------- | ------- | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile6_sub1    | 563 nt  | ATGG  | ATTC  |
| 2   | 5'WT gene block | bsai_5wt_tile14_sub2   | 1485 nt | ATTC  | AAGA  |
| 3   | 5'WT gene block | bsai_5wt_tile22_sub3   | 1648 nt | AAGA  | AGAA  |
| 4   | Oligo pool      | Tile 22 (14910 oligos) | 281 nt  | AGAA  | TTCC  |
| 5   | Helper plasmid  | helper_plasmid_insert  | --      | --    | --    |
| 6   | Enzyme + buffer | BsaI-HFv2 + CutSmart   | --      | --    | --    |

```
  [ATGG]----5'WT sub1----[ATTC]----5'WT sub2----[AAGA]----5'WT sub3----[TGAA]----oligo+BC----[AGAA][TTCC]
   ATGG                   ATTC                   AAGA                   TGAA                  AGAA  TTCC 
```

**Set fidelity:** 0.9406 (6 overhangs)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------ | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)      | --      | --    | --    |
| 2   | 3'WT+PolIII block | bsmbi_3wt_tile22         | 1640 nt | TCAG  | CACC  |
| 3   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1 | --      | --    | --    |

```
  [TCAG]----3'WT+PolIII----[CACC]
   TCAG                     CACC 
```

**Set fidelity:** 1.0000 (2 overhangs)

---

### Tile 23 of 25 -- Codons 1286-1343 (174 nt)

**Boundary overhangs:**

| Position          | Sequence | Fidelity |
| ----------------- | -------- | -------- |
| oh1 (5' boundary) | ATTA     | 0.7818   |
| oh2 (3' boundary) | CCTT     | 0.6891   |

**Variants:** 11340 mutations, 11340 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name              | Length  | 5' OH | 3' OH |
| --- | --------------- | ---------------------- | ------- | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile6_sub1    | 563 nt  | ATGG  | ATTC  |
| 2   | 5'WT gene block | bsai_5wt_tile14_sub2   | 1485 nt | ATTC  | AAGA  |
| 3   | 5'WT gene block | bsai_5wt_tile23_sub3   | 1527 nt | AAGA  | TGAA  |
| 4   | 5'WT gene block | bsai_5wt_tile23_sub4   | 352 nt  | TGAA  | ATTA  |
| 5   | Oligo pool      | Tile 23 (11340 oligos) | 230 nt  | ATTA  | TTCC  |
| 6   | Helper plasmid  | helper_plasmid_insert  | --      | --    | --    |
| 7   | Enzyme + buffer | BsaI-HFv2 + CutSmart   | --      | --    | --    |

```
  [ATGG]----5'WT sub1----[ATTC]----5'WT sub2----[AAGA]----5'WT sub3----[TGAA]----5'WT sub4----[ATTA]----oligo+BC----[TTCC]
   ATGG                   ATTC                   AAGA                   TGAA                   ATTA                  TTCC 
```

**Set fidelity:** 0.9581 (6 overhangs)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------ | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)      | --      | --    | --    |
| 2   | 3'WT+PolIII block | bsmbi_3wt_tile23         | 1478 nt | CCTT  | CACC  |
| 3   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1 | --      | --    | --    |

```
  [CCTT]----3'WT+PolIII----[CACC]
   CCTT                     CACC 
```

**Set fidelity:** 1.0000 (2 overhangs)

---

### Tile 24 of 25 -- Codons 1340-1413 (222 nt)

**Boundary overhangs:**

| Position          | Sequence | Fidelity |
| ----------------- | -------- | -------- |
| oh1 (5' boundary) | AAAA     | 0.9502   |
| oh2 (3' boundary) | TTCC     | 0.7958   |

**Variants:** 14700 mutations, 14700 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name              | Length  | 5' OH | 3' OH |
| --- | --------------- | ---------------------- | ------- | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile6_sub1    | 563 nt  | ATGG  | ATTC  |
| 2   | 5'WT gene block | bsai_5wt_tile14_sub2   | 1485 nt | ATTC  | AAGA  |
| 3   | 5'WT gene block | bsai_5wt_tile23_sub3   | 1527 nt | AAGA  | TGAA  |
| 4   | 5'WT gene block | bsai_5wt_tile24_sub4   | 514 nt  | TGAA  | AAAA  |
| 5   | Oligo pool      | Tile 24 (14700 oligos) | 278 nt  | AAAA  | TTCC  |
| 6   | Helper plasmid  | helper_plasmid_insert  | --      | --    | --    |
| 7   | Enzyme + buffer | BsaI-HFv2 + CutSmart   | --      | --    | --    |

```
  [ATGG]----5'WT sub1----[ATTC]----5'WT sub2----[AAGA]----5'WT sub3----[TGAA]----5'WT sub4----[AAAA]----oligo+BC----[TTCC]
   ATGG                   ATTC                   AAGA                   TGAA                   AAAA                  TTCC 
```

**Set fidelity:** 0.9909 (6 overhangs)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------ | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)      | --      | --    | --    |
| 2   | 3'WT+PolIII block | bsmbi_3wt_tile24         | 1268 nt | TTCC  | CACC  |
| 3   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1 | --      | --    | --    |

```
  [TTCC]----3'WT+PolIII----[CACC]
   TTCC                     CACC 
```

**Set fidelity:** 0.9988 (2 overhangs)

---

### Tile 25 of 25 -- Codons 1410-1465 (168 nt)

**Boundary overhangs:**

| Position          | Sequence | Fidelity |
| ----------------- | -------- | -------- |
| oh1 (5' boundary) | TCGT     | 0.7335   |
| oh2 (3' boundary) | TTAA     | 0.9448   |

**Variants:** 10920 mutations, 10920 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name              | Length  | 5' OH | 3' OH |
| --- | --------------- | ---------------------- | ------- | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile6_sub1    | 563 nt  | ATGG  | ATTC  |
| 2   | 5'WT gene block | bsai_5wt_tile14_sub2   | 1485 nt | ATTC  | AAGA  |
| 3   | 5'WT gene block | bsai_5wt_tile23_sub3   | 1527 nt | AAGA  | TGAA  |
| 4   | 5'WT gene block | bsai_5wt_tile25_sub4   | 724 nt  | TGAA  | TCGT  |
| 5   | Oligo pool      | Tile 25 (10920 oligos) | 224 nt  | TCGT  | TTCC  |
| 6   | Helper plasmid  | helper_plasmid_insert  | --      | --    | --    |
| 7   | Enzyme + buffer | BsaI-HFv2 + CutSmart   | --      | --    | --    |

```
  [ATGG]----5'WT sub1----[ATTC]----5'WT sub2----[AAGA]----5'WT sub3----[TGAA]----5'WT sub4----[TCGT]----oligo+BC----[TTCC]
   ATGG                   ATTC                   AAGA                   TGAA                   TCGT                  TTCC 
```

**Set fidelity:** 1.0000 (6 overhangs)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component            | Part name                | Length  | 5' OH | 3' OH |
| --- | -------------------- | ------------------------ | ------- | ----- | ----- |
| 1   | BsaI product         | (in helper plasmid)      | --      | --    | --    |
| 2   | PolIII-only fragment | bsmbi_polIII_tile25      | 1112 nt | TTAA  | CACC  |
| 3   | Enzyme + buffer      | BsmBI-v2 + NEBuffer r3.1 | --      | --    | --    |

```
  [TTAA]----PolIII----[CACC]
   TTAA                CACC 
```

**Set fidelity:** 1.0000 (2 overhangs)

---

## 8. PaqCI Level 2 Reaction (37C)

The final cloning step transfers the complete insert from the helper plasmid
into the destination backbone.

**Components per reaction:**

| # | Component | Detail |
| --- | --- | --- |
| 1 | BsmBI product | Complete insert in helper plasmid |
| 2 | Destination backbone | PaqCI-compatible receiving vector |
| 3 | Enzyme + buffer | PaqCI + CutSmart (37C) |

**PaqCI overhangs:**

- paqci_star2 (5'): `AATG`
- paqci_star1 (3'): `GCTA`

```
[PaqCI** AATG]--[gene+mutation]--[WPRE]--[spacer]--[bGH_polyA]--[PolIII]--[barcode]--[PaqCI* GCTA]
```

## 9. Gene Block Order Sheet

Order these gene blocks as synthesized gene fragments (e.g., Twist gene fragments, IDT gBlocks).
Gene blocks are synthesized once and reused across experiments.

**Total blocks:** 55

| Block name                | Length (nt) | Enzyme type | Gene region                                                                                                                                                                                                                                                                                                                                                                                                              |
| ------------------------- | ----------- | ----------- | ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------ |
| bsai_5wt_tile10_sub2      | 1087        | BsaI        | 5wt_tile10_sub2                                                                                                                                                                                                                                                                                                                                                                                                          |
| bsai_5wt_tile11_sub2      | 1261        | BsaI        | 5wt_tile11_sub2                                                                                                                                                                                                                                                                                                                                                                                                          |
| bsai_5wt_tile12_sub2      | 1477        | BsaI        | 5wt_tile12_sub2                                                                                                                                                                                                                                                                                                                                                                                                          |
| bsai_5wt_tile13_sub2      | 1585        | BsaI        | 5wt_tile13_sub2                                                                                                                                                                                                                                                                                                                                                                                                          |
| bsai_5wt_tile14_sub2      | 1485        | BsaI        | 5wt_tile14_sub2;5wt_tile15_sub2;5wt_tile16_sub2;5wt_tile17_sub2;5wt_tile18_sub2;5wt_tile19_sub2;5wt_tile20_sub2;5wt_tile21_sub2;5wt_tile22_sub2;5wt_tile23_sub2;5wt_tile24_sub2;5wt_tile25_sub2                                                                                                                                                                                                                          |
| bsai_5wt_tile14_sub3      | 304         | BsaI        | 5wt_tile14_sub3                                                                                                                                                                                                                                                                                                                                                                                                          |
| bsai_5wt_tile15_sub3      | 526         | BsaI        | 5wt_tile15_sub3                                                                                                                                                                                                                                                                                                                                                                                                          |
| bsai_5wt_tile16_sub3      | 709         | BsaI        | 5wt_tile16_sub3                                                                                                                                                                                                                                                                                                                                                                                                          |
| bsai_5wt_tile17_sub3      | 931         | BsaI        | 5wt_tile17_sub3                                                                                                                                                                                                                                                                                                                                                                                                          |
| bsai_5wt_tile18_sub3      | 1054        | BsaI        | 5wt_tile18_sub3                                                                                                                                                                                                                                                                                                                                                                                                          |
| bsai_5wt_tile19_sub3      | 1192        | BsaI        | 5wt_tile19_sub3                                                                                                                                                                                                                                                                                                                                                                                                          |
| bsai_5wt_tile2            | 165         | BsaI        | 5wt_tile2                                                                                                                                                                                                                                                                                                                                                                                                                |
| bsai_5wt_tile20_sub3      | 1324        | BsaI        | 5wt_tile20_sub3                                                                                                                                                                                                                                                                                                                                                                                                          |
| bsai_5wt_tile21_sub3      | 1519        | BsaI        | 5wt_tile21_sub3                                                                                                                                                                                                                                                                                                                                                                                                          |
| bsai_5wt_tile22_sub3      | 1648        | BsaI        | 5wt_tile22_sub3                                                                                                                                                                                                                                                                                                                                                                                                          |
| bsai_5wt_tile23_sub3      | 1527        | BsaI        | 5wt_tile23_sub3;5wt_tile24_sub3;5wt_tile25_sub3                                                                                                                                                                                                                                                                                                                                                                          |
| bsai_5wt_tile23_sub4      | 352         | BsaI        | 5wt_tile23_sub4                                                                                                                                                                                                                                                                                                                                                                                                          |
| bsai_5wt_tile24_sub4      | 514         | BsaI        | 5wt_tile24_sub4                                                                                                                                                                                                                                                                                                                                                                                                          |
| bsai_5wt_tile25_sub4      | 724         | BsaI        | 5wt_tile25_sub4                                                                                                                                                                                                                                                                                                                                                                                                          |
| bsai_5wt_tile3            | 387         | BsaI        | 5wt_tile3                                                                                                                                                                                                                                                                                                                                                                                                                |
| bsai_5wt_tile4            | 555         | BsaI        | 5wt_tile4                                                                                                                                                                                                                                                                                                                                                                                                                |
| bsai_5wt_tile5_sub1       | 777         | BsaI        | 5wt_tile5_sub1                                                                                                                                                                                                                                                                                                                                                                                                           |
| bsai_5wt_tile6_sub1       | 563         | BsaI        | 5wt_tile6_sub1;5wt_tile7_sub1;5wt_tile8_sub1;5wt_tile9_sub1;5wt_tile10_sub1;5wt_tile11_sub1;5wt_tile12_sub1;5wt_tile13_sub1;5wt_tile14_sub1;5wt_tile15_sub1;5wt_tile16_sub1;5wt_tile17_sub1;5wt_tile18_sub1;5wt_tile19_sub1;5wt_tile20_sub1;5wt_tile21_sub1;5wt_tile22_sub1;5wt_tile23_sub1;5wt_tile24_sub1;5wt_tile25_sub1                                                                                              |
| bsai_5wt_tile6_sub2       | 400         | BsaI        | 5wt_tile6_sub2                                                                                                                                                                                                                                                                                                                                                                                                           |
| bsai_5wt_tile7_sub2       | 520         | BsaI        | 5wt_tile7_sub2                                                                                                                                                                                                                                                                                                                                                                                                           |
| bsai_5wt_tile8_sub2       | 658         | BsaI        | 5wt_tile8_sub2                                                                                                                                                                                                                                                                                                                                                                                                           |
| bsai_5wt_tile9_sub2       | 865         | BsaI        | 5wt_tile9_sub2                                                                                                                                                                                                                                                                                                                                                                                                           |
| bsmbi_3wt_tile1_sub1      | 408         | BsmBI       | 3wt_tile1_sub1                                                                                                                                                                                                                                                                                                                                                                                                           |
| bsmbi_3wt_tile1_sub2      | 1485        | BsmBI       | 3wt_tile1_sub2;3wt_tile3_sub1                                                                                                                                                                                                                                                                                                                                                                                            |
| bsmbi_3wt_tile1_sub3      | 1527        | BsmBI       | 3wt_tile1_sub3;3wt_tile2_sub2;3wt_tile3_sub2;3wt_tile4_sub2;3wt_tile5_sub2;3wt_tile6_sub2;3wt_tile7_sub2;3wt_tile8_sub2;3wt_tile9_sub2;3wt_tile11_sub1                                                                                                                                                                                                                                                                   |
| bsmbi_3wt_tile1_sub4      | 906         | BsmBI       | 3wt_tile1_sub4;3wt_tile2_sub3;3wt_tile3_sub3;3wt_tile4_sub3;3wt_tile5_sub3;3wt_tile6_sub3;3wt_tile7_sub3;3wt_tile8_sub3;3wt_tile9_sub3;3wt_tile10_sub2;3wt_tile11_sub2;3wt_tile12_sub2;3wt_tile13_sub2;3wt_tile14_sub2;3wt_tile15_sub2;3wt_tile16_sub2;3wt_tile17_sub2;3wt_tile18_sub2;3wt_tile19_sub2                                                                                                                   |
| bsmbi_3wt_tile10_sub1     | 1743        | BsmBI       | 3wt_tile10_sub1                                                                                                                                                                                                                                                                                                                                                                                                          |
| bsmbi_3wt_tile12_sub1     | 1419        | BsmBI       | 3wt_tile12_sub1                                                                                                                                                                                                                                                                                                                                                                                                          |
| bsmbi_3wt_tile13_sub1     | 1233        | BsmBI       | 3wt_tile13_sub1                                                                                                                                                                                                                                                                                                                                                                                                          |
| bsmbi_3wt_tile14_sub1     | 1011        | BsmBI       | 3wt_tile14_sub1                                                                                                                                                                                                                                                                                                                                                                                                          |
| bsmbi_3wt_tile15_sub1     | 828         | BsmBI       | 3wt_tile15_sub1                                                                                                                                                                                                                                                                                                                                                                                                          |
| bsmbi_3wt_tile16_sub1     | 606         | BsmBI       | 3wt_tile16_sub1                                                                                                                                                                                                                                                                                                                                                                                                          |
| bsmbi_3wt_tile17_sub1     | 483         | BsmBI       | 3wt_tile17_sub1                                                                                                                                                                                                                                                                                                                                                                                                          |
| bsmbi_3wt_tile18_sub1     | 345         | BsmBI       | 3wt_tile18_sub1                                                                                                                                                                                                                                                                                                                                                                                                          |
| bsmbi_3wt_tile19_sub1     | 213         | BsmBI       | 3wt_tile19_sub1                                                                                                                                                                                                                                                                                                                                                                                                          |
| bsmbi_3wt_tile2_sub1      | 1653        | BsmBI       | 3wt_tile2_sub1                                                                                                                                                                                                                                                                                                                                                                                                           |
| bsmbi_3wt_tile20_sub1     | 513         | BsmBI       | 3wt_tile20_sub1                                                                                                                                                                                                                                                                                                                                                                                                          |
| bsmbi_3wt_tile20_sub2     | 1487        | BsmBI       | 3wt_polIII_tile20_sub2;3wt_polIII_tile21_sub2                                                                                                                                                                                                                                                                                                                                                                            |
| bsmbi_3wt_tile21_sub1     | 384         | BsmBI       | 3wt_tile21_sub1                                                                                                                                                                                                                                                                                                                                                                                                          |
| bsmbi_3wt_tile22          | 1640        | BsmBI       | 3wt_polIII_tile22                                                                                                                                                                                                                                                                                                                                                                                                        |
| bsmbi_3wt_tile23          | 1478        | BsmBI       | 3wt_polIII_tile23                                                                                                                                                                                                                                                                                                                                                                                                        |
| bsmbi_3wt_tile24          | 1268        | BsmBI       | 3wt_polIII_tile24                                                                                                                                                                                                                                                                                                                                                                                                        |
| bsmbi_3wt_tile4_sub1      | 1263        | BsmBI       | 3wt_tile4_sub1                                                                                                                                                                                                                                                                                                                                                                                                           |
| bsmbi_3wt_tile5_sub1      | 1095        | BsmBI       | 3wt_tile5_sub1                                                                                                                                                                                                                                                                                                                                                                                                           |
| bsmbi_3wt_tile6_sub1      | 975         | BsmBI       | 3wt_tile6_sub1                                                                                                                                                                                                                                                                                                                                                                                                           |
| bsmbi_3wt_tile7_sub1      | 837         | BsmBI       | 3wt_tile7_sub1                                                                                                                                                                                                                                                                                                                                                                                                           |
| bsmbi_3wt_tile8_sub1      | 630         | BsmBI       | 3wt_tile8_sub1                                                                                                                                                                                                                                                                                                                                                                                                           |
| bsmbi_3wt_tile9_sub1      | 408         | BsmBI       | 3wt_tile9_sub1                                                                                                                                                                                                                                                                                                                                                                                                           |
| bsmbi_cassette_tile1_sub5 | 1094        | BsmBI       | cassette_tile1_frag1;cassette_tile2_frag1;cassette_tile3_frag1;cassette_tile4_frag1;cassette_tile5_frag1;cassette_tile6_frag1;cassette_tile7_frag1;cassette_tile8_frag1;cassette_tile9_frag1;cassette_tile10_frag1;cassette_tile11_frag1;cassette_tile12_frag1;cassette_tile13_frag1;cassette_tile14_frag1;cassette_tile15_frag1;cassette_tile16_frag1;cassette_tile17_frag1;cassette_tile18_frag1;cassette_tile19_frag1 |
| bsmbi_polIII_tile25       | 1112        | BsmBI       | polIII_tile25                                                                                                                                                                                                                                                                                                                                                                                                            |

## 10. Domestication Log

6 endogenous enzyme site(s) were removed via silent mutations:

| site_start | enzyme | strand | codon_pos | original_codon | new_codon | aa  |
| ---------- | ------ | ------ | --------- | -------------- | --------- | --- |
| 780        | BsaI   | +      | 260       | TTG            | CTT       | L   |
| 2013       | BsaI   | -      | 671       | CAG            | CAA       | Q   |
| 2374       | BsaI   | -      | 792       | GAG            | GAA       | E   |
| 3604       | BsaI   | -      | 1202      | GAG            | GAA       | E   |
| 1279       | BsmBI  | -      | 427       | GAG            | GAA       | E   |
| 1629       | BsmBI  | +      | 543       | ACC            | ACA       | T   |

## 11. Configuration Parameters

| Parameter                   | Value |
| --------------------------- | ----- |
| max_oligo_length            | 300   |
| max_geneblock_length        | 1800  |
| barcode_length              | 20    |
| min_hamming_distance        | 3     |
| barcode_prefix_length       | 12    |
| barcodes_per_variant        | 10    |
| overhang_fidelity_threshold | 0.95  |
| boundary_method             | dp    |
| multi_k_search              | TRUE  |
| auto_domesticate            | TRUE  |

