# DMS-GG Assembly Report: GRIN2A_long_cassette

Generated: 2026-03-09 18:46:54
Pipeline: dms-gg-oligo-pipeline (3-Enzyme Architecture: BsaI + BsmBI + PaqCI)

---

## 1. Gene Summary

| Property             | Value                                                                          |
| -------------------- | ------------------------------------------------------------------------------ |
| Gene name            | GRIN2A_NM_000833.5 Human GRIN2A native CDS (NM_000833.5, NP_000824.1, 1464 aa) |
| CDS length           | 4395 nt (1465 codons)                                                          |
| Protein length       | 1464 aa                                                                        |
| Number of tiles      | 24                                                                             |
| Total variants       | 28749                                                                          |
| Total oligos         | 28749                                                                          |
| Oligo length range   | 143-290 nt                                                                     |
| Gene blocks to order | 98                                                                             |
| Barcodes per variant | 1                                                                              |

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
[PaqCI**]--[gene+mutation]--[P2A_EGFP]--[WPRE]--[spacer]--[bGH_polyA]--[PolIII]--[barcode]--[PaqCI*]
```

## 3. Oligo Pool Summary

**Total oligos:** 28749 | **Length range:** 143-290 nt

| Tile | Codons    | Oligos | Length |
| ---- | --------- | ------ | ------ |
| 1    | 1-46      | 882    | 194 nt |
| 2    | 47-123    | 1533   | 287 nt |
| 3    | 124-179   | 1092   | 224 nt |
| 4    | 180-212   | 609    | 155 nt |
| 5    | 213-279   | 1323   | 257 nt |
| 6    | 280-349   | 1386   | 266 nt |
| 7    | 350-421   | 1428   | 272 nt |
| 8    | 422-471   | 966    | 206 nt |
| 9    | 472-537   | 1302   | 254 nt |
| 10   | 538-615   | 1554   | 290 nt |
| 11   | 616-670   | 1071   | 221 nt |
| 12   | 671-709   | 735    | 173 nt |
| 13   | 710-768   | 1155   | 233 nt |
| 14   | 769-822   | 1050   | 218 nt |
| 15   | 823-899   | 1533   | 287 nt |
| 16   | 900-972   | 1449   | 275 nt |
| 17   | 973-1026  | 1050   | 218 nt |
| 18   | 1027-1095 | 1365   | 263 nt |
| 19   | 1096-1156 | 1197   | 239 nt |
| 20   | 1157-1206 | 966    | 206 nt |
| 21   | 1207-1283 | 1533   | 287 nt |
| 22   | 1284-1361 | 1554   | 290 nt |
| 23   | 1362-1436 | 1491   | 281 nt |
| 24   | 1437-1465 | 525    | 143 nt |

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
| Barcodes per variant  | 1                                    |

### Pool Statistics

| Statistic         | Value                              |
| ----------------- | ---------------------------------- |
| Total barcodes    | 28749                              |
| Unique barcodes   | 28749                              |
| GC content range  | 25% - 75%                          |
| GC content mean   | 47.9%                              |
| Hamming guarantee | 100% cross-variant (prefix d >= 3) |

## 5. QC Summary

**Overall:** ISSUES FOUND

| Check                     | Description                                                   | Result | Detail                                                                                                                                               |
| ------------------------- | ------------------------------------------------------------- | ------ | ---------------------------------------------------------------------------------------------------------------------------------------------------- |
| oligo_lengths             | All oligos within synthesis length limit                      | PASS   | Range: 143-290 nt (limit: 300)                                                                                                                       |
| block_lengths             | All gene blocks within synthesis length limit                 | PASS   | Range: 78-1690 nt (limit: 1800)                                                                                                                      |
| barcode_junction_sites    | No enzyme sites at barcode-context junctions                  | PASS   | 0 barcode(s) with junction enzyme sites (left='CACACC', right='AGAATG')                                                                              |
| barcode_uniqueness        | All barcodes are unique                                       | PASS   | 28749 unique / 28749 total                                                                                                                           |
| tile_coverage             | Tiles cover entire gene without gaps                          | PASS   | 4395 / 4395 nt covered                                                                                                                               |
| variant_count             | Expected number of variants generated                         | PASS   | 28749 unique variants (expected: 28749 across 1369/1463 mutable positions; 26011 missense + 1369 nonsense + 1369 wt_control; 94 position(s) skipped) |
| single_codon_change       | Each non-control variant differs by exactly one codon from WT | PASS   | 27380 / 27380 variants confirmed (WT controls excluded)                                                                                              |
| oligo_gc_content          | Oligo GC content within reasonable range (25-75%)             | PASS   | GC range: 40.6-66.5% | 0 oligo(s) with extreme GC                                                                                                    |
| domestication_complete    | Gene domesticated for all 3 enzymes (BsaI, BsmBI, PaqCI)      | PASS   | No enzyme sites in gene                                                                                                                              |
| overhang_fidelity         | Tile boundary overhangs have adequate fidelity                | FAIL   | 22 tile(s) with low-fidelity boundary overhangs (<0.80)                                                                                              |
| tile_manifests            | Per-tile assembly manifests complete                          | PASS   | 24 tile manifest(s) generated                                                                                                                        |
| helper_plasmid            | Helper plasmid free of unintended BsmBI sites                 | PASS   | OK                                                                                                                                                   |
| reaction_fidelity         | Per-reaction set-level overhang fidelity                      | FAIL   | Min set fidelity: 0.7942 across 48 reactions | 5 reaction(s) below 0.90                                                                              |
| barcode_poliii_term       | No barcodes contain PolIII terminator signal (TTTT)           | PASS   | 0 / 28749 barcode(s) contain TTTT                                                                                                                    |
| block_min_length          | All gene blocks above synthesis minimum length                | FAIL   | 8 block(s) below 300 nt minimum. Range: 78-1690 nt                                                                                                   |
| cassette_fragment_lengths | Cassette fragments within synthesis limits                    | PASS   | 2 cassette fragment(s). Range: 409-1507 nt. 0 over max, 0 under min.                                                                                 |
| sb_overhang_collisions    | Superblock boundary overhangs are unique (no collisions)      | PASS   | 3 SB boundary OH(s), all unique                                                                                                                      |

## 5b. Reaction Fidelity Summary

Set fidelity for each tile's BsaI and BsmBI reactions,
computed from the actual block overhangs after construction:

| Tile | BsaI OHs | BsaI Set Fidelity | BsmBI OHs | BsmBI Set Fidelity |
| ---- | -------- | ----------------- | --------- | ------------------ |
| 1    | 2        | 1.0000            | 8         | 0.8364             |
| 2    | 3        | 1.0000            | 8         | 0.9299             |
| 3    | 3        | 1.0000            | 8         | 0.8699             |
| 4    | 3        | 1.0000            | 8         | 0.8932             |
| 5    | 3        | 1.0000            | 7         | 0.9246             |
| 6    | 3        | 1.0000            | 7         | 0.9011             |
| 7    | 3        | 1.0000            | 7         | 0.9645             |
| 8    | 3        | 0.9376            | 7         | 0.9246             |
| 9    | 3        | 1.0000            | 6         | 0.9617             |
| 10   | 3        | 1.0000            | 6         | 0.9443             |
| 11   | 4        | 0.9907            | 7         | 0.9288             |
| 12   | 4        | 1.0000            | 7         | 0.9371             |
| 13   | 4        | 1.0000            | 7         | 0.9716             |
| 14   | 4        | 1.0000            | 6         | 0.9665             |
| 15   | 4        | 0.9866            | 7         | 0.9247             |
| 16   | 4        | 1.0000            | 6         | 0.9731             |
| 17   | 4        | 0.9611            | 5         | 0.9875             |
| 18   | 4        | 1.0000            | 5         | 0.9920             |
| 19   | 4        | 0.7942            | 6         | 0.8822             |
| 20   | 5        | 1.0000            | 5         | 0.9920             |
| 21   | 5        | 1.0000            | 4         | 1.0000             |
| 22   | 5        | 0.9587            | 4         | 0.9627             |
| 23   | 5        | 0.9605            | 4         | 0.9945             |
| 24   | 5        | 1.0000            | 3         | 1.0000             |

**Min:** 0.7942 | **Max:** 1.0000 | **Mean:** 0.9636

**Warning:** 5 reaction(s) below 0.90 fidelity — consider alternative split points or overhang reassignment.
## 6. Fixed Overhangs & Helper Plasmid

These overhangs are the same across all tile reactions:

| Overhang    | Sequence | Role                                                    |
| ----------- | -------- | ------------------------------------------------------- |
| oh_L        | ATGG     | Gene start (BsaI, all tiles)                            |
| oh3         | CACC     | Downstream cassette-barcode junction (BsmBI, all tiles) |
| oh4         | AGAA     | Barcode-helper junction (BsaI, all tiles)               |
| paqci_star2 | AATG     | PaqCI 5' end of insert (Level 2)                        |
| paqci_star1 | GCTA     | PaqCI 3' end of insert (Level 2)                        |

### Helper Plasmid Insert

The helper plasmid provides the backbone for each BsaI Level 1 reaction.

```
[PaqCI**]--[BsaI>>ATGG]--STUFFER--[AGAA<<BsaI]--[PaqCI*]
```

Insert length: 72 nt
oh_L = ATGG (first 4 nt of gene)
oh_R = AGAA (= oh4, barcode-helper junction)

## 7. Per-Tile Assembly Guide

### Tile 1 of 24 -- Codons 1-46 (138 nt)

**Boundary overhangs:**

| Position          | Sequence | Fidelity |
| ----------------- | -------- | -------- |
| oh1 (5' boundary) | ATGG     | 0.5393   |
| oh2 (3' boundary) | CGAA     | 0.7461   |

**Variants:** 882 mutations, 882 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name                          | Length | 5' OH | 3' OH |
| --- | --------------- | ---------------------------------- | ------ | ----- | ----- |
| 1   | 5'WT gene block | (none -- tile starts at gene nt 1) | --     | --    | --    |
| 2   | Oligo pool      | Tile 1 (882 oligos)                | 194 nt | ATGG  | AGAA  |
| 3   | Helper plasmid  | helper_plasmid_insert              | --     | --    | --    |
| 4   | Enzyme + buffer | BsaI-HFv2 + CutSmart               | --     | --    | --    |

```
  [ATGG]----oligo+BC----[AGAA]
   ATGG                  AGAA 
```

**Set fidelity:** 1.0000 (2 overhangs)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                 | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------- | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)       | --      | --    | --    |
| 2   | 3'WT block        | bsmbi_3wt_tile1_sub1      | 690 nt  | CGAA  | AAAA  |
| 3   | 3'WT block        | bsmbi_3wt_tile1_sub2      | 717 nt  | AAAA  | TCAA  |
| 4   | 3'WT block        | bsmbi_3wt_tile1_sub3      | 630 nt  | TCAA  | CAAA  |
| 5   | 3'WT block        | bsmbi_3wt_tile1_sub4      | 924 nt  | CAAA  | TAGA  |
| 6   | 3'WT block        | bsmbi_3wt_tile1_sub5      | 546 nt  | TAGA  | TAAA  |
| 7   | 3'WT block        | bsmbi_3wt_tile1_sub6      | 1249 nt | TAAA  | AAGA  |
| 8   | 3'WT+PolIII block | bsmbi_cassette_tile1_sub7 | 1507 nt | AAGA  | CACC  |
| 9   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1  | --      | --    | --    |

```
  [CGAA]----3'WT sub1----[AAAA]----3'WT sub2----[TCAA]----3'WT sub3----[CAAA]----3'WT sub4----[TAGA]----3'WT sub5----[TAAA]----3'WT sub6----[AAGA]----3'WT+PolIII sub7----[CACC]
   CGAA                   AAAA                   TCAA                   CAAA                   TAGA                   TAAA                   AAGA                          CACC 
```

**Set fidelity:** 0.8364 (8 overhangs)

---

### Tile 2 of 24 -- Codons 47-123 (231 nt)

**Boundary overhangs:**

| Position          | Sequence | Fidelity |
| ----------------- | -------- | -------- |
| oh1 (5' boundary) | ACAG     | 0.5793   |
| oh2 (3' boundary) | CATT     | 0.6770   |

**Variants:** 1533 mutations, 1533 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name             | Length | 5' OH | 3' OH |
| --- | --------------- | --------------------- | ------ | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile2        | 156 nt | ATGG  | ACAG  |
| 2   | Oligo pool      | Tile 2 (1533 oligos)  | 287 nt | ACAG  | AGAA  |
| 3   | Helper plasmid  | helper_plasmid_insert | --     | --    | --    |
| 4   | Enzyme + buffer | BsaI-HFv2 + CutSmart  | --     | --    | --    |

```
  [ATGG]----5'WT block----[ACAG]----oligo+BC----[AGAA]
   ATGG                    ACAG                  AGAA 
```

**Set fidelity:** 1.0000 (3 overhangs)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                 | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------- | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)       | --      | --    | --    |
| 2   | 3'WT block        | bsmbi_3wt_tile2_sub1      | 687 nt  | CATT  | CAAA  |
| 3   | 3'WT block        | bsmbi_3wt_tile2_sub2      | 789 nt  | CAAA  | AAAA  |
| 4   | 3'WT block        | bsmbi_3wt_tile2_sub3      | 510 nt  | AAAA  | GAAA  |
| 5   | 3'WT block        | bsmbi_3wt_tile2_sub4      | 744 nt  | GAAA  | TAGA  |
| 6   | 3'WT block        | bsmbi_3wt_tile2_sub5      | 825 nt  | TAGA  | TCAA  |
| 7   | 3'WT block        | bsmbi_3wt_tile2_sub6      | 970 nt  | TCAA  | AAGA  |
| 8   | 3'WT+PolIII block | bsmbi_cassette_tile1_sub7 | 1507 nt | AAGA  | CACC  |
| 9   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1  | --      | --    | --    |

```
  [CATT]----3'WT sub1----[CAAA]----3'WT sub2----[AAAA]----3'WT sub3----[GAAA]----3'WT sub4----[TAGA]----3'WT sub5----[TCAA]----3'WT sub6----[AAGA]----3'WT+PolIII sub7----[CACC]
   CATT                   CAAA                   AAAA                   GAAA                   TAGA                   TCAA                   AAGA                          CACC 
```

**Set fidelity:** 0.9299 (8 overhangs)

---

### Tile 3 of 24 -- Codons 124-179 (168 nt)

**Boundary overhangs:**

| Position          | Sequence | Fidelity |
| ----------------- | -------- | -------- |
| oh1 (5' boundary) | ATCT     | 0.7151   |
| oh2 (3' boundary) | ATTC     | 0.7084   |

**Variants:** 1092 mutations, 1092 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name             | Length | 5' OH | 3' OH |
| --- | --------------- | --------------------- | ------ | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile3        | 387 nt | ATGG  | ATCT  |
| 2   | Oligo pool      | Tile 3 (1092 oligos)  | 224 nt | ATCT  | AGAA  |
| 3   | Helper plasmid  | helper_plasmid_insert | --     | --    | --    |
| 4   | Enzyme + buffer | BsaI-HFv2 + CutSmart  | --     | --    | --    |

```
  [ATGG]----5'WT block----[ATCT]----oligo+BC----[AGAA]
   ATGG                    ATCT                  AGAA 
```

**Set fidelity:** 1.0000 (3 overhangs)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                 | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------- | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)       | --      | --    | --    |
| 2   | 3'WT block        | bsmbi_3wt_tile3_sub1      | 519 nt  | ATTC  | CAAA  |
| 3   | 3'WT block        | bsmbi_3wt_tile2_sub2      | 789 nt  | CAAA  | AAAA  |
| 4   | 3'WT block        | bsmbi_3wt_tile3_sub3      | 756 nt  | AAAA  | TTTC  |
| 5   | 3'WT block        | bsmbi_3wt_tile3_sub4      | 498 nt  | TTTC  | TAGA  |
| 6   | 3'WT block        | bsmbi_3wt_tile2_sub5      | 825 nt  | TAGA  | TCAA  |
| 7   | 3'WT block        | bsmbi_3wt_tile2_sub6      | 970 nt  | TCAA  | AAGA  |
| 8   | 3'WT+PolIII block | bsmbi_cassette_tile1_sub7 | 1507 nt | AAGA  | CACC  |
| 9   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1  | --      | --    | --    |

```
  [ATTC]----3'WT sub1----[CAAA]----3'WT sub2----[AAAA]----3'WT sub3----[TTTC]----3'WT sub4----[TAGA]----3'WT sub5----[TCAA]----3'WT sub6----[AAGA]----3'WT+PolIII sub7----[CACC]
   ATTC                   CAAA                   AAAA                   TTTC                   TAGA                   TCAA                   AAGA                          CACC 
```

**Set fidelity:** 0.8699 (8 overhangs)

---

### Tile 4 of 24 -- Codons 180-212 (99 nt)

**Boundary overhangs:**

| Position          | Sequence | Fidelity |
| ----------------- | -------- | -------- |
| oh1 (5' boundary) | TACA     | 0.8652   |
| oh2 (3' boundary) | ACAA     | 0.8919   |

**Variants:** 609 mutations, 609 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name             | Length | 5' OH | 3' OH |
| --- | --------------- | --------------------- | ------ | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile4        | 555 nt | ATGG  | TACA  |
| 2   | Oligo pool      | Tile 4 (609 oligos)   | 155 nt | TACA  | AGAA  |
| 3   | Helper plasmid  | helper_plasmid_insert | --     | --    | --    |
| 4   | Enzyme + buffer | BsaI-HFv2 + CutSmart  | --     | --    | --    |

```
  [ATGG]----5'WT block----[TACA]----oligo+BC----[AGAA]
   ATGG                    TACA                  AGAA 
```

**Set fidelity:** 1.0000 (3 overhangs)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                 | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------- | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)       | --      | --    | --    |
| 2   | 3'WT block        | bsmbi_3wt_tile4_sub1      | 705 nt  | ACAA  | CAAA  |
| 3   | 3'WT block        | bsmbi_3wt_tile4_sub2      | 504 nt  | CAAA  | AAAA  |
| 4   | 3'WT block        | bsmbi_3wt_tile4_sub3      | 843 nt  | AAAA  | AGAA  |
| 5   | 3'WT block        | bsmbi_3wt_tile4_sub4      | 645 nt  | AGAA  | TAAA  |
| 6   | 3'WT block        | bsmbi_3wt_tile4_sub5      | 591 nt  | TAAA  | TCAA  |
| 7   | 3'WT block        | bsmbi_3wt_tile2_sub6      | 970 nt  | TCAA  | AAGA  |
| 8   | 3'WT+PolIII block | bsmbi_cassette_tile1_sub7 | 1507 nt | AAGA  | CACC  |
| 9   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1  | --      | --    | --    |

```
  [ACAA]----3'WT sub1----[CAAA]----3'WT sub2----[AAAA]----3'WT sub3----[AGAA]----3'WT sub4----[TAAA]----3'WT sub5----[TCAA]----3'WT sub6----[AAGA]----3'WT+PolIII sub7----[CACC]
   ACAA                   CAAA                   AAAA                   AGAA                   TAAA                   TCAA                   AAGA                          CACC 
```

**Set fidelity:** 0.8932 (8 overhangs)

---

### Tile 5 of 24 -- Codons 213-279 (201 nt)

**Boundary overhangs:**

| Position          | Sequence | Fidelity |
| ----------------- | -------- | -------- |
| oh1 (5' boundary) | GCAA     | 0.7543   |
| oh2 (3' boundary) | TGAC     | 0.6485   |

**Variants:** 1323 mutations, 1323 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name             | Length | 5' OH | 3' OH |
| --- | --------------- | --------------------- | ------ | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile5        | 654 nt | ATGG  | GCAA  |
| 2   | Oligo pool      | Tile 5 (1323 oligos)  | 257 nt | GCAA  | AGAA  |
| 3   | Helper plasmid  | helper_plasmid_insert | --     | --    | --    |
| 4   | Enzyme + buffer | BsaI-HFv2 + CutSmart  | --     | --    | --    |

```
  [ATGG]----5'WT block----[GCAA]----oligo+BC----[AGAA]
   ATGG                    GCAA                  AGAA 
```

**Set fidelity:** 1.0000 (3 overhangs)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                 | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------- | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)       | --      | --    | --    |
| 2   | 3'WT block        | bsmbi_3wt_tile5_sub1      | 690 nt  | TGAC  | TCAA  |
| 3   | 3'WT block        | bsmbi_3wt_tile5_sub2      | 525 nt  | TCAA  | AAGA  |
| 4   | 3'WT block        | bsmbi_3wt_tile5_sub3      | 690 nt  | AAGA  | AAAA  |
| 5   | 3'WT block        | bsmbi_3wt_tile5_sub4      | 591 nt  | AAAA  | TAAA  |
| 6   | 3'WT block        | bsmbi_3wt_tile5_sub5      | 651 nt  | TAAA  | CAAA  |
| 7   | 3'WT block        | bsmbi_3wt_tile5_sub6      | 910 nt  | CAAA  | AAGA  |
| 8   | 3'WT+PolIII block | bsmbi_cassette_tile1_sub7 | 1507 nt | AAGA  | CACC  |
| 9   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1  | --      | --    | --    |

```
  [TGAC]----3'WT sub1----[TCAA]----3'WT sub2----[AAGA]----3'WT sub3----[AAAA]----3'WT sub4----[TAAA]----3'WT sub5----[CAAA]----3'WT sub6----[AAGA]----3'WT+PolIII sub7----[CACC]
   TGAC                   TCAA                   AAGA                   AAAA                   TAAA                   CAAA                   AAGA                          CACC 
```

**Set fidelity:** 0.9246 (7 overhangs)

---

### Tile 6 of 24 -- Codons 280-349 (210 nt)

**Boundary overhangs:**

| Position          | Sequence | Fidelity |
| ----------------- | -------- | -------- |
| oh1 (5' boundary) | TCCT     | 0.7573   |
| oh2 (3' boundary) | GGAA     | 0.7463   |

**Variants:** 1386 mutations, 1386 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name             | Length | 5' OH | 3' OH |
| --- | --------------- | --------------------- | ------ | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile6        | 855 nt | ATGG  | TCCT  |
| 2   | Oligo pool      | Tile 6 (1386 oligos)  | 266 nt | TCCT  | AGAA  |
| 3   | Helper plasmid  | helper_plasmid_insert | --     | --    | --    |
| 4   | Enzyme + buffer | BsaI-HFv2 + CutSmart  | --     | --    | --    |

```
  [ATGG]----5'WT block----[TCCT]----oligo+BC----[AGAA]
   ATGG                    TCCT                  AGAA 
```

**Set fidelity:** 1.0000 (3 overhangs)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                 | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------- | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)       | --      | --    | --    |
| 2   | 3'WT block        | bsmbi_3wt_tile6_sub1      | 780 nt  | GGAA  | AAAA  |
| 3   | 3'WT block        | bsmbi_3wt_tile2_sub3      | 510 nt  | AAAA  | GAAA  |
| 4   | 3'WT block        | bsmbi_3wt_tile2_sub4      | 744 nt  | GAAA  | TAGA  |
| 5   | 3'WT block        | bsmbi_3wt_tile2_sub5      | 825 nt  | TAGA  | TCAA  |
| 6   | 3'WT block        | bsmbi_3wt_tile2_sub6      | 970 nt  | TCAA  | AAGA  |
| 7   | 3'WT+PolIII block | bsmbi_cassette_tile1_sub7 | 1507 nt | AAGA  | CACC  |
| 8   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1  | --      | --    | --    |

```
  [GGAA]----3'WT sub1----[AAAA]----3'WT sub2----[GAAA]----3'WT sub3----[TAGA]----3'WT sub4----[TCAA]----3'WT sub5----[AAGA]----3'WT+PolIII sub6----[CACC]
   GGAA                   AAAA                   GAAA                   TAGA                   TCAA                   AAGA                          CACC 
```

**Set fidelity:** 0.9011 (7 overhangs)

---

### Tile 7 of 24 -- Codons 350-421 (216 nt)

**Boundary overhangs:**

| Position          | Sequence | Fidelity |
| ----------------- | -------- | -------- |
| oh1 (5' boundary) | TTCA     | 0.8824   |
| oh2 (3' boundary) | CCTG     | 0.6383   |

**Variants:** 1428 mutations, 1428 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name             | Length  | 5' OH | 3' OH |
| --- | --------------- | --------------------- | ------- | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile7        | 1065 nt | ATGG  | TTCA  |
| 2   | Oligo pool      | Tile 7 (1428 oligos)  | 272 nt  | TTCA  | AGAA  |
| 3   | Helper plasmid  | helper_plasmid_insert | --      | --    | --    |
| 4   | Enzyme + buffer | BsaI-HFv2 + CutSmart  | --      | --    | --    |

```
  [ATGG]----5'WT block----[TTCA]----oligo+BC----[AGAA]
   ATGG                    TTCA                  AGAA 
```

**Set fidelity:** 1.0000 (3 overhangs)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                 | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------- | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)       | --      | --    | --    |
| 2   | 3'WT block        | bsmbi_3wt_tile7_sub1      | 564 nt  | CCTG  | AAAA  |
| 3   | 3'WT block        | bsmbi_3wt_tile4_sub3      | 843 nt  | AAAA  | AGAA  |
| 4   | 3'WT block        | bsmbi_3wt_tile4_sub4      | 645 nt  | AGAA  | TAAA  |
| 5   | 3'WT block        | bsmbi_3wt_tile4_sub5      | 591 nt  | TAAA  | TCAA  |
| 6   | 3'WT block        | bsmbi_3wt_tile2_sub6      | 970 nt  | TCAA  | AAGA  |
| 7   | 3'WT+PolIII block | bsmbi_cassette_tile1_sub7 | 1507 nt | AAGA  | CACC  |
| 8   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1  | --      | --    | --    |

```
  [CCTG]----3'WT sub1----[AAAA]----3'WT sub2----[AGAA]----3'WT sub3----[TAAA]----3'WT sub4----[TCAA]----3'WT sub5----[AAGA]----3'WT+PolIII sub6----[CACC]
   CCTG                   AAAA                   AGAA                   TAAA                   TCAA                   AAGA                          CACC 
```

**Set fidelity:** 0.9645 (7 overhangs)

---

### Tile 8 of 24 -- Codons 422-471 (150 nt)

**Boundary overhangs:**

| Position          | Sequence | Fidelity |
| ----------------- | -------- | -------- |
| oh1 (5' boundary) | ATAG     | 0.7330   |
| oh2 (3' boundary) | TTAC     | 0.8333   |

**Variants:** 966 mutations, 966 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name             | Length  | 5' OH | 3' OH |
| --- | --------------- | --------------------- | ------- | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile8        | 1281 nt | ATGG  | ATAG  |
| 2   | Oligo pool      | Tile 8 (966 oligos)   | 206 nt  | ATAG  | AGAA  |
| 3   | Helper plasmid  | helper_plasmid_insert | --      | --    | --    |
| 4   | Enzyme + buffer | BsaI-HFv2 + CutSmart  | --      | --    | --    |

```
  [ATGG]----5'WT block----[ATAG]----oligo+BC----[AGAA]
   ATGG                    ATAG                  AGAA 
```

**Set fidelity:** 0.9376 (3 overhangs)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                 | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------- | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)       | --      | --    | --    |
| 2   | 3'WT block        | bsmbi_3wt_tile8_sub1      | 618 nt  | TTAC  | TCAA  |
| 3   | 3'WT block        | bsmbi_3wt_tile8_sub2      | 693 nt  | TCAA  | AAAA  |
| 4   | 3'WT block        | bsmbi_3wt_tile5_sub4      | 591 nt  | AAAA  | TAAA  |
| 5   | 3'WT block        | bsmbi_3wt_tile5_sub5      | 651 nt  | TAAA  | CAAA  |
| 6   | 3'WT block        | bsmbi_3wt_tile5_sub6      | 910 nt  | CAAA  | AAGA  |
| 7   | 3'WT+PolIII block | bsmbi_cassette_tile1_sub7 | 1507 nt | AAGA  | CACC  |
| 8   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1  | --      | --    | --    |

```
  [TTAC]----3'WT sub1----[TCAA]----3'WT sub2----[AAAA]----3'WT sub3----[TAAA]----3'WT sub4----[CAAA]----3'WT sub5----[AAGA]----3'WT+PolIII sub6----[CACC]
   TTAC                   TCAA                   AAAA                   TAAA                   CAAA                   AAGA                          CACC 
```

**Set fidelity:** 0.9246 (7 overhangs)

---

### Tile 9 of 24 -- Codons 472-537 (198 nt)

**Boundary overhangs:**

| Position          | Sequence | Fidelity |
| ----------------- | -------- | -------- |
| oh1 (5' boundary) | AAGT     | 0.7629   |
| oh2 (3' boundary) | TAAT     | 0.8165   |

**Variants:** 1302 mutations, 1302 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name             | Length  | 5' OH | 3' OH |
| --- | --------------- | --------------------- | ------- | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile9        | 1431 nt | ATGG  | AAGT  |
| 2   | Oligo pool      | Tile 9 (1302 oligos)  | 254 nt  | AAGT  | AGAA  |
| 3   | Helper plasmid  | helper_plasmid_insert | --      | --    | --    |
| 4   | Enzyme + buffer | BsaI-HFv2 + CutSmart  | --      | --    | --    |

```
  [ATGG]----5'WT block----[AAGT]----oligo+BC----[AGAA]
   ATGG                    AAGT                  AGAA 
```

**Set fidelity:** 1.0000 (3 overhangs)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                 | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------- | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)       | --      | --    | --    |
| 2   | 3'WT block        | bsmbi_3wt_tile9_sub1      | 423 nt  | TAAT  | AAGA  |
| 3   | 3'WT block        | bsmbi_3wt_tile5_sub3      | 690 nt  | AAGA  | AAAA  |
| 4   | 3'WT block        | bsmbi_3wt_tile5_sub4      | 591 nt  | AAAA  | TAAA  |
| 5   | 3'WT block        | bsmbi_3wt_tile4_sub5      | 591 nt  | TAAA  | TCAA  |
| 6   | 3'WT block        | bsmbi_3wt_tile2_sub6      | 970 nt  | TCAA  | AAGA  |
| 7   | 3'WT+PolIII block | bsmbi_cassette_tile1_sub7 | 1507 nt | AAGA  | CACC  |
| 8   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1  | --      | --    | --    |

```
  [TAAT]----3'WT sub1----[AAGA]----3'WT sub2----[AAAA]----3'WT sub3----[TAAA]----3'WT sub4----[TCAA]----3'WT sub5----[AAGA]----3'WT+PolIII sub6----[CACC]
   TAAT                   AAGA                   AAAA                   TAAA                   TCAA                   AAGA                          CACC 
```

**Set fidelity:** 0.9617 (6 overhangs)

---

### Tile 10 of 24 -- Codons 538-615 (234 nt)

**Boundary overhangs:**

| Position          | Sequence | Fidelity |
| ----------------- | -------- | -------- |
| oh1 (5' boundary) | TCAA     | 0.9425   |
| oh2 (3' boundary) | TGTC     | 0.6650   |

**Variants:** 1554 mutations, 1554 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name             | Length  | 5' OH | 3' OH |
| --- | --------------- | --------------------- | ------- | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile10       | 1629 nt | ATGG  | TCAA  |
| 2   | Oligo pool      | Tile 10 (1554 oligos) | 290 nt  | TCAA  | AGAA  |
| 3   | Helper plasmid  | helper_plasmid_insert | --      | --    | --    |
| 4   | Enzyme + buffer | BsaI-HFv2 + CutSmart  | --      | --    | --    |

```
  [ATGG]----5'WT block----[TCAA]----oligo+BC----[AGAA]
   ATGG                    TCAA                  AGAA 
```

**Set fidelity:** 1.0000 (3 overhangs)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                 | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------- | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)       | --      | --    | --    |
| 2   | 3'WT block        | bsmbi_3wt_tile10_sub1     | 474 nt  | TGTC  | GAAA  |
| 3   | 3'WT block        | bsmbi_3wt_tile10_sub2     | 459 nt  | GAAA  | AAGA  |
| 4   | 3'WT block        | bsmbi_3wt_tile10_sub3     | 537 nt  | AAGA  | TAAA  |
| 5   | 3'WT block        | bsmbi_3wt_tile10_sub4     | 777 nt  | TAAA  | AAAA  |
| 6   | 3'WT block        | bsmbi_3wt_tile10_sub5     | 784 nt  | AAAA  | AAGA  |
| 7   | 3'WT+PolIII block | bsmbi_cassette_tile1_sub7 | 1507 nt | AAGA  | CACC  |
| 8   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1  | --      | --    | --    |

```
  [TGTC]----3'WT sub1----[GAAA]----3'WT sub2----[AAGA]----3'WT sub3----[TAAA]----3'WT sub4----[AAAA]----3'WT sub5----[AAGA]----3'WT+PolIII sub6----[CACC]
   TGTC                   GAAA                   AAGA                   TAAA                   AAAA                   AAGA                          CACC 
```

**Set fidelity:** 0.9443 (6 overhangs)

---

### Tile 11 of 24 -- Codons 616-670 (165 nt)

**Boundary overhangs:**

| Position          | Sequence | Fidelity |
| ----------------- | -------- | -------- |
| oh1 (5' boundary) | TCCG     | 0.7234   |
| oh2 (3' boundary) | TCAT     | 0.8102   |

**Variants:** 1071 mutations, 1071 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name             | Length  | 5' OH | 3' OH |
| --- | --------------- | --------------------- | ------- | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile11_sub1  | 824 nt  | ATGG  | AAAA  |
| 2   | 5'WT gene block | bsai_5wt_tile11_sub2  | 1057 nt | AAAA  | TCCG  |
| 3   | Oligo pool      | Tile 11 (1071 oligos) | 221 nt  | TCCG  | AGAA  |
| 4   | Helper plasmid  | helper_plasmid_insert | --      | --    | --    |
| 5   | Enzyme + buffer | BsaI-HFv2 + CutSmart  | --      | --    | --    |

```
  [ATGG]----5'WT sub1----[AAAA]----5'WT sub2----[TCCG]----oligo+BC----[AGAA]
   ATGG                   AAAA                   TCCG                  AGAA 
```

**Set fidelity:** 0.9907 (4 overhangs)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                 | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------- | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)       | --      | --    | --    |
| 2   | 3'WT block        | bsmbi_3wt_tile11_sub1     | 642 nt  | TCAT  | AGAA  |
| 3   | 3'WT block        | bsmbi_3wt_tile11_sub2     | 411 nt  | AGAA  | TAGA  |
| 4   | 3'WT block        | bsmbi_3wt_tile1_sub5      | 546 nt  | TAGA  | TAAA  |
| 5   | 3'WT block        | bsmbi_3wt_tile11_sub4     | 483 nt  | TAAA  | AAAA  |
| 6   | 3'WT block        | bsmbi_3wt_tile10_sub5     | 784 nt  | AAAA  | AAGA  |
| 7   | 3'WT+PolIII block | bsmbi_cassette_tile1_sub7 | 1507 nt | AAGA  | CACC  |
| 8   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1  | --      | --    | --    |

```
  [TCAT]----3'WT sub1----[AGAA]----3'WT sub2----[TAGA]----3'WT sub3----[TAAA]----3'WT sub4----[AAAA]----3'WT sub5----[AAGA]----3'WT+PolIII sub6----[CACC]
   TCAT                   AGAA                   TAGA                   TAAA                   AAAA                   AAGA                          CACC 
```

**Set fidelity:** 0.9288 (7 overhangs)

---

### Tile 12 of 24 -- Codons 671-709 (117 nt)

**Boundary overhangs:**

| Position          | Sequence | Fidelity |
| ----------------- | -------- | -------- |
| oh1 (5' boundary) | CAAA     | 0.8948   |
| oh2 (3' boundary) | AGTA     | 0.7286   |

**Variants:** 735 mutations, 735 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name             | Length  | 5' OH | 3' OH |
| --- | --------------- | --------------------- | ------- | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile12_sub1  | 1025 nt | ATGG  | ATTT  |
| 2   | 5'WT gene block | bsai_5wt_tile12_sub2  | 1021 nt | ATTT  | CAAA  |
| 3   | Oligo pool      | Tile 12 (735 oligos)  | 173 nt  | CAAA  | AGAA  |
| 4   | Helper plasmid  | helper_plasmid_insert | --      | --    | --    |
| 5   | Enzyme + buffer | BsaI-HFv2 + CutSmart  | --      | --    | --    |

```
  [ATGG]----5'WT sub1----[ATTT]----5'WT sub2----[CAAA]----oligo+BC----[AGAA]
   ATGG                   ATTT                   CAAA                  AGAA 
```

**Set fidelity:** 1.0000 (4 overhangs)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                 | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------- | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)       | --      | --    | --    |
| 2   | 3'WT block        | bsmbi_3wt_tile12_sub1     | 579 nt  | AGTA  | AAAA  |
| 3   | 3'WT block        | bsmbi_3wt_tile12_sub2     | 357 nt  | AAAA  | TAGA  |
| 4   | 3'WT block        | bsmbi_3wt_tile1_sub5      | 546 nt  | TAGA  | TAAA  |
| 5   | 3'WT block        | bsmbi_3wt_tile12_sub4     | 297 nt  | TAAA  | TCAA  |
| 6   | 3'WT block        | bsmbi_3wt_tile2_sub6      | 970 nt  | TCAA  | AAGA  |
| 7   | 3'WT+PolIII block | bsmbi_cassette_tile1_sub7 | 1507 nt | AAGA  | CACC  |
| 8   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1  | --      | --    | --    |

```
  [AGTA]----3'WT sub1----[AAAA]----3'WT sub2----[TAGA]----3'WT sub3----[TAAA]----3'WT sub4----[TCAA]----3'WT sub5----[AAGA]----3'WT+PolIII sub6----[CACC]
   AGTA                   AAAA                   TAGA                   TAAA                   TCAA                   AAGA                          CACC 
```

**Set fidelity:** 0.9371 (7 overhangs)

---

### Tile 13 of 24 -- Codons 710-768 (177 nt)

**Boundary overhangs:**

| Position          | Sequence | Fidelity |
| ----------------- | -------- | -------- |
| oh1 (5' boundary) | CAGA     | 0.8175   |
| oh2 (3' boundary) | GAAG     | 0.6752   |

**Variants:** 1155 mutations, 1155 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name             | Length  | 5' OH | 3' OH |
| --- | --------------- | --------------------- | ------- | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile12_sub1  | 1025 nt | ATGG  | ATTT  |
| 2   | 5'WT gene block | bsai_5wt_tile13_sub2  | 1138 nt | ATTT  | CAGA  |
| 3   | Oligo pool      | Tile 13 (1155 oligos) | 233 nt  | CAGA  | AGAA  |
| 4   | Helper plasmid  | helper_plasmid_insert | --      | --    | --    |
| 5   | Enzyme + buffer | BsaI-HFv2 + CutSmart  | --      | --    | --    |

```
  [ATGG]----5'WT sub1----[ATTT]----5'WT sub2----[CAGA]----oligo+BC----[AGAA]
   ATGG                   ATTT                   CAGA                  AGAA 
```

**Set fidelity:** 1.0000 (4 overhangs)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                 | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------- | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)       | --      | --    | --    |
| 2   | 3'WT block        | bsmbi_3wt_tile13_sub1     | 402 nt  | GAAG  | AAAA  |
| 3   | 3'WT block        | bsmbi_3wt_tile5_sub4      | 591 nt  | AAAA  | TAAA  |
| 4   | 3'WT block        | bsmbi_3wt_tile13_sub3     | 432 nt  | TAAA  | TTCA  |
| 5   | 3'WT block        | bsmbi_3wt_tile13_sub4     | 177 nt  | TTCA  | TCAA  |
| 6   | 3'WT block        | bsmbi_3wt_tile2_sub6      | 970 nt  | TCAA  | AAGA  |
| 7   | 3'WT+PolIII block | bsmbi_cassette_tile1_sub7 | 1507 nt | AAGA  | CACC  |
| 8   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1  | --      | --    | --    |

```
  [GAAG]----3'WT sub1----[AAAA]----3'WT sub2----[TAAA]----3'WT sub3----[TTCA]----3'WT sub4----[TCAA]----3'WT sub5----[AAGA]----3'WT+PolIII sub6----[CACC]
   GAAG                   AAAA                   TAAA                   TTCA                   TCAA                   AAGA                          CACC 
```

**Set fidelity:** 0.9716 (7 overhangs)

---

### Tile 14 of 24 -- Codons 769-822 (162 nt)

**Boundary overhangs:**

| Position          | Sequence | Fidelity |
| ----------------- | -------- | -------- |
| oh1 (5' boundary) | TCTC     | 0.8105   |
| oh2 (3' boundary) | TGCC     | 0.5867   |

**Variants:** 1050 mutations, 1050 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name             | Length  | 5' OH | 3' OH |
| --- | --------------- | --------------------- | ------- | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile12_sub1  | 1025 nt | ATGG  | ATTT  |
| 2   | 5'WT gene block | bsai_5wt_tile14_sub2  | 1315 nt | ATTT  | TCTC  |
| 3   | Oligo pool      | Tile 14 (1050 oligos) | 218 nt  | TCTC  | AGAA  |
| 4   | Helper plasmid  | helper_plasmid_insert | --      | --    | --    |
| 5   | Enzyme + buffer | BsaI-HFv2 + CutSmart  | --      | --    | --    |

```
  [ATGG]----5'WT sub1----[ATTT]----5'WT sub2----[TCTC]----oligo+BC----[AGAA]
   ATGG                   ATTT                   TCTC                  AGAA 
```

**Set fidelity:** 1.0000 (4 overhangs)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                 | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------- | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)       | --      | --    | --    |
| 2   | 3'WT block        | bsmbi_3wt_tile14_sub1     | 813 nt  | TGCC  | TAAA  |
| 3   | 3'WT block        | bsmbi_3wt_tile13_sub3     | 432 nt  | TAAA  | TTCA  |
| 4   | 3'WT block        | bsmbi_3wt_tile14_sub3     | 363 nt  | TTCA  | AAAA  |
| 5   | 3'WT block        | bsmbi_3wt_tile10_sub5     | 784 nt  | AAAA  | AAGA  |
| 6   | 3'WT+PolIII block | bsmbi_cassette_tile1_sub7 | 1507 nt | AAGA  | CACC  |
| 7   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1  | --      | --    | --    |

```
  [TGCC]----3'WT sub1----[TAAA]----3'WT sub2----[TTCA]----3'WT sub3----[AAAA]----3'WT sub4----[AAGA]----3'WT+PolIII sub5----[CACC]
   TGCC                   TAAA                   TTCA                   AAAA                   AAGA                          CACC 
```

**Set fidelity:** 0.9665 (6 overhangs)

---

### Tile 15 of 24 -- Codons 823-899 (231 nt)

**Boundary overhangs:**

| Position          | Sequence | Fidelity |
| ----------------- | -------- | -------- |
| oh1 (5' boundary) | ATGC     | 0.6171   |
| oh2 (3' boundary) | AAAC     | 0.6694   |

**Variants:** 1533 mutations, 1533 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name             | Length  | 5' OH | 3' OH |
| --- | --------------- | --------------------- | ------- | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile15_sub1  | 1376 nt | ATGG  | GAAA  |
| 2   | 5'WT gene block | bsai_5wt_tile15_sub2  | 1126 nt | GAAA  | ATGC  |
| 3   | Oligo pool      | Tile 15 (1533 oligos) | 287 nt  | ATGC  | AGAA  |
| 4   | Helper plasmid  | helper_plasmid_insert | --      | --    | --    |
| 5   | Enzyme + buffer | BsaI-HFv2 + CutSmart  | --      | --    | --    |

```
  [ATGG]----5'WT sub1----[GAAA]----5'WT sub2----[ATGC]----oligo+BC----[AGAA]
   ATGG                   GAAA                   ATGC                  AGAA 
```

**Set fidelity:** 0.9866 (4 overhangs)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                 | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------- | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)       | --      | --    | --    |
| 2   | 3'WT block        | bsmbi_3wt_tile15_sub1     | 348 nt  | AAAC  | TAGA  |
| 3   | 3'WT block        | bsmbi_3wt_tile15_sub2     | 252 nt  | TAGA  | TAAA  |
| 4   | 3'WT block        | bsmbi_3wt_tile4_sub5      | 591 nt  | TAAA  | TCAA  |
| 5   | 3'WT block        | bsmbi_3wt_tile15_sub4     | 204 nt  | TCAA  | AAAA  |
| 6   | 3'WT block        | bsmbi_3wt_tile10_sub5     | 784 nt  | AAAA  | AAGA  |
| 7   | 3'WT+PolIII block | bsmbi_cassette_tile1_sub7 | 1507 nt | AAGA  | CACC  |
| 8   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1  | --      | --    | --    |

```
  [AAAC]----3'WT sub1----[TAGA]----3'WT sub2----[TAAA]----3'WT sub3----[TCAA]----3'WT sub4----[AAAA]----3'WT sub5----[AAGA]----3'WT+PolIII sub6----[CACC]
   AAAC                   TAGA                   TAAA                   TCAA                   AAAA                   AAGA                          CACC 
```

**Set fidelity:** 0.9247 (7 overhangs)

---

### Tile 16 of 24 -- Codons 900-972 (219 nt)

**Boundary overhangs:**

| Position          | Sequence | Fidelity |
| ----------------- | -------- | -------- |
| oh1 (5' boundary) | TCAG     | 0.7814   |
| oh2 (3' boundary) | CAAT     | 0.7361   |

**Variants:** 1449 mutations, 1449 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name             | Length  | 5' OH | 3' OH |
| --- | --------------- | --------------------- | ------- | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile15_sub1  | 1376 nt | ATGG  | GAAA  |
| 2   | 5'WT gene block | bsai_5wt_tile16_sub2  | 1357 nt | GAAA  | TCAG  |
| 3   | Oligo pool      | Tile 16 (1449 oligos) | 275 nt  | TCAG  | AGAA  |
| 4   | Helper plasmid  | helper_plasmid_insert | --      | --    | --    |
| 5   | Enzyme + buffer | BsaI-HFv2 + CutSmart  | --      | --    | --    |

```
  [ATGG]----5'WT sub1----[GAAA]----5'WT sub2----[TCAG]----oligo+BC----[AGAA]
   ATGG                   GAAA                   TCAG                  AGAA 
```

**Set fidelity:** 1.0000 (4 overhangs)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                 | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------- | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)       | --      | --    | --    |
| 2   | 3'WT block        | bsmbi_3wt_tile16_sub1     | 363 nt  | CAAT  | TAAA  |
| 3   | 3'WT block        | bsmbi_3wt_tile13_sub3     | 432 nt  | TAAA  | TTCA  |
| 4   | 3'WT block        | bsmbi_3wt_tile14_sub3     | 363 nt  | TTCA  | AAAA  |
| 5   | 3'WT block        | bsmbi_3wt_tile10_sub5     | 784 nt  | AAAA  | AAGA  |
| 6   | 3'WT+PolIII block | bsmbi_cassette_tile1_sub7 | 1507 nt | AAGA  | CACC  |
| 7   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1  | --      | --    | --    |

```
  [CAAT]----3'WT sub1----[TAAA]----3'WT sub2----[TTCA]----3'WT sub3----[AAAA]----3'WT sub4----[AAGA]----3'WT+PolIII sub5----[CACC]
   CAAT                   TAAA                   TTCA                   AAAA                   AAGA                          CACC 
```

**Set fidelity:** 0.9731 (6 overhangs)

---

### Tile 17 of 24 -- Codons 973-1026 (162 nt)

**Boundary overhangs:**

| Position          | Sequence | Fidelity |
| ----------------- | -------- | -------- |
| oh1 (5' boundary) | GATA     | 0.7029   |
| oh2 (3' boundary) | TCCA     | 0.8519   |

**Variants:** 1050 mutations, 1050 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name             | Length  | 5' OH | 3' OH |
| --- | --------------- | --------------------- | ------- | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile15_sub1  | 1376 nt | ATGG  | GAAA  |
| 2   | 5'WT gene block | bsai_5wt_tile17_sub2  | 1576 nt | GAAA  | GATA  |
| 3   | Oligo pool      | Tile 17 (1050 oligos) | 218 nt  | GATA  | AGAA  |
| 4   | Helper plasmid  | helper_plasmid_insert | --      | --    | --    |
| 5   | Enzyme + buffer | BsaI-HFv2 + CutSmart  | --      | --    | --    |

```
  [ATGG]----5'WT sub1----[GAAA]----5'WT sub2----[GATA]----oligo+BC----[AGAA]
   ATGG                   GAAA                   GATA                  AGAA 
```

**Set fidelity:** 0.9611 (4 overhangs)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                 | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------- | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)       | --      | --    | --    |
| 2   | 3'WT block        | bsmbi_3wt_tile17_sub1     | 774 nt  | TCCA  | TCAA  |
| 3   | 3'WT block        | bsmbi_3wt_tile15_sub4     | 204 nt  | TCAA  | AAAA  |
| 4   | 3'WT block        | bsmbi_3wt_tile10_sub5     | 784 nt  | AAAA  | AAGA  |
| 5   | 3'WT+PolIII block | bsmbi_cassette_tile1_sub7 | 1507 nt | AAGA  | CACC  |
| 6   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1  | --      | --    | --    |

```
  [TCCA]----3'WT sub1----[TCAA]----3'WT sub2----[AAAA]----3'WT sub3----[AAGA]----3'WT+PolIII sub4----[CACC]
   TCCA                   TCAA                   AAAA                   AAGA                          CACC 
```

**Set fidelity:** 0.9875 (5 overhangs)

---

### Tile 18 of 24 -- Codons 1027-1095 (207 nt)

**Boundary overhangs:**

| Position          | Sequence | Fidelity |
| ----------------- | -------- | -------- |
| oh1 (5' boundary) | TCCC     | 0.7759   |
| oh2 (3' boundary) | TAGT     | 0.7437   |

**Variants:** 1365 mutations, 1365 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name             | Length  | 5' OH | 3' OH |
| --- | --------------- | --------------------- | ------- | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile18_sub1  | 1631 nt | ATGG  | AAGA  |
| 2   | 5'WT gene block | bsai_5wt_tile18_sub2  | 1483 nt | AAGA  | TCCC  |
| 3   | Oligo pool      | Tile 18 (1365 oligos) | 263 nt  | TCCC  | AGAA  |
| 4   | Helper plasmid  | helper_plasmid_insert | --      | --    | --    |
| 5   | Enzyme + buffer | BsaI-HFv2 + CutSmart  | --      | --    | --    |

```
  [ATGG]----5'WT sub1----[AAGA]----5'WT sub2----[TCCC]----oligo+BC----[AGAA]
   ATGG                   AAGA                   TCCC                  AGAA 
```

**Set fidelity:** 1.0000 (4 overhangs)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                 | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------- | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)       | --      | --    | --    |
| 2   | 3'WT block        | bsmbi_3wt_tile18_sub1     | 567 nt  | TAGT  | TCAA  |
| 3   | 3'WT block        | bsmbi_3wt_tile15_sub4     | 204 nt  | TCAA  | AAAA  |
| 4   | 3'WT block        | bsmbi_3wt_tile10_sub5     | 784 nt  | AAAA  | AAGA  |
| 5   | 3'WT+PolIII block | bsmbi_cassette_tile1_sub7 | 1507 nt | AAGA  | CACC  |
| 6   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1  | --      | --    | --    |

```
  [TAGT]----3'WT sub1----[TCAA]----3'WT sub2----[AAAA]----3'WT sub3----[AAGA]----3'WT+PolIII sub4----[CACC]
   TAGT                   TCAA                   AAAA                   AAGA                          CACC 
```

**Set fidelity:** 0.9920 (5 overhangs)

---

### Tile 19 of 24 -- Codons 1096-1156 (183 nt)

**Boundary overhangs:**

| Position          | Sequence | Fidelity |
| ----------------- | -------- | -------- |
| oh1 (5' boundary) | AAGG     | 0.6552   |
| oh2 (3' boundary) | CAAG     | 0.6640   |

**Variants:** 1197 mutations, 1197 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name             | Length  | 5' OH | 3' OH |
| --- | --------------- | --------------------- | ------- | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile18_sub1  | 1631 nt | ATGG  | AAGA  |
| 2   | 5'WT gene block | bsai_5wt_tile19_sub2  | 1690 nt | AAGA  | AAGG  |
| 3   | Oligo pool      | Tile 19 (1197 oligos) | 239 nt  | AAGG  | AGAA  |
| 4   | Helper plasmid  | helper_plasmid_insert | --      | --    | --    |
| 5   | Enzyme + buffer | BsaI-HFv2 + CutSmart  | --      | --    | --    |

```
  [ATGG]----5'WT sub1----[AAGA]----5'WT sub2----[AAGG]----oligo+BC----[AGAA]
   ATGG                   AAGA                   AAGG                  AGAA 
```

**Set fidelity:** 0.7942 (4 overhangs)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                 | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------- | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)       | --      | --    | --    |
| 2   | 3'WT block        | bsmbi_3wt_tile19_sub1     | 384 nt  | CAAG  | TCAA  |
| 3   | 3'WT block        | bsmbi_3wt_tile15_sub4     | 204 nt  | TCAA  | AAAA  |
| 4   | 3'WT block        | bsmbi_3wt_tile19_sub3     | 162 nt  | AAAA  | CAAA  |
| 5   | 3'WT block        | bsmbi_3wt_tile19_sub4     | 640 nt  | CAAA  | AAGA  |
| 6   | 3'WT+PolIII block | bsmbi_cassette_tile1_sub7 | 1507 nt | AAGA  | CACC  |
| 7   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1  | --      | --    | --    |

```
  [CAAG]----3'WT sub1----[TCAA]----3'WT sub2----[AAAA]----3'WT sub3----[CAAA]----3'WT sub4----[AAGA]----3'WT+PolIII sub5----[CACC]
   CAAG                   TCAA                   AAAA                   CAAA                   AAGA                          CACC 
```

**Set fidelity:** 0.8822 (6 overhangs)

---

### Tile 20 of 24 -- Codons 1157-1206 (150 nt)

**Boundary overhangs:**

| Position          | Sequence | Fidelity |
| ----------------- | -------- | -------- |
| oh1 (5' boundary) | AACT     | 0.6635   |
| oh2 (3' boundary) | GAAC     | 0.6079   |

**Variants:** 966 mutations, 966 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name             | Length  | 5' OH | 3' OH |
| --- | --------------- | --------------------- | ------- | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile12_sub1  | 1025 nt | ATGG  | ATTT  |
| 2   | 5'WT gene block | bsai_5wt_tile20_sub2  | 1170 nt | ATTT  | GAAA  |
| 3   | 5'WT gene block | bsai_5wt_tile20_sub3  | 1327 nt | GAAA  | AACT  |
| 4   | Oligo pool      | Tile 20 (966 oligos)  | 206 nt  | AACT  | AGAA  |
| 5   | Helper plasmid  | helper_plasmid_insert | --      | --    | --    |
| 6   | Enzyme + buffer | BsaI-HFv2 + CutSmart  | --      | --    | --    |

```
  [ATGG]----5'WT sub1----[ATTT]----5'WT sub2----[GAAA]----5'WT sub3----[AACT]----oligo+BC----[AGAA]
   ATGG                   ATTT                   GAAA                   AACT                  AGAA 
```

**Set fidelity:** 1.0000 (5 overhangs)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                 | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------- | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)       | --      | --    | --    |
| 2   | 3'WT block        | bsmbi_3wt_tile20_sub1     | 420 nt  | GAAC  | AAAA  |
| 3   | 3'WT block        | bsmbi_3wt_tile20_sub2     | 333 nt  | AAAA  | TTTA  |
| 4   | 3'WT block        | bsmbi_3wt_tile20_sub3     | 469 nt  | TTTA  | AAGA  |
| 5   | 3'WT+PolIII block | bsmbi_cassette_tile1_sub7 | 1507 nt | AAGA  | CACC  |
| 6   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1  | --      | --    | --    |

```
  [GAAC]----3'WT sub1----[AAAA]----3'WT sub2----[TTTA]----3'WT sub3----[AAGA]----3'WT+PolIII sub4----[CACC]
   GAAC                   AAAA                   TTTA                   AAGA                          CACC 
```

**Set fidelity:** 0.9920 (5 overhangs)

---

### Tile 21 of 24 -- Codons 1207-1283 (231 nt)

**Boundary overhangs:**

| Position          | Sequence | Fidelity |
| ----------------- | -------- | -------- |
| oh1 (5' boundary) | TACC     | 0.7054   |
| oh2 (3' boundary) | TAGC     | 0.7011   |

**Variants:** 1533 mutations, 1533 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name             | Length  | 5' OH | 3' OH |
| --- | --------------- | --------------------- | ------- | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile21_sub1  | 1280 nt | ATGG  | CATA  |
| 2   | 5'WT gene block | bsai_5wt_tile21_sub2  | 1053 nt | CATA  | GAAA  |
| 3   | 5'WT gene block | bsai_5wt_tile21_sub3  | 1339 nt | GAAA  | TACC  |
| 4   | Oligo pool      | Tile 21 (1533 oligos) | 287 nt  | TACC  | AGAA  |
| 5   | Helper plasmid  | helper_plasmid_insert | --      | --    | --    |
| 6   | Enzyme + buffer | BsaI-HFv2 + CutSmart  | --      | --    | --    |

```
  [ATGG]----5'WT sub1----[CATA]----5'WT sub2----[GAAA]----5'WT sub3----[TACC]----oligo+BC----[AGAA]
   ATGG                   CATA                   GAAA                   TACC                  AGAA 
```

**Set fidelity:** 1.0000 (5 overhangs)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                 | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------- | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)       | --      | --    | --    |
| 2   | 3'WT block        | bsmbi_3wt_tile21_sub1     | 504 nt  | TAGC  | TTTA  |
| 3   | 3'WT block        | bsmbi_3wt_tile20_sub3     | 469 nt  | TTTA  | AAGA  |
| 4   | 3'WT+PolIII block | bsmbi_cassette_tile1_sub7 | 1507 nt | AAGA  | CACC  |
| 5   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1  | --      | --    | --    |

```
  [TAGC]----3'WT sub1----[TTTA]----3'WT sub2----[AAGA]----3'WT+PolIII sub3----[CACC]
   TAGC                   TTTA                   AAGA                          CACC 
```

**Set fidelity:** 1.0000 (4 overhangs)

---

### Tile 22 of 24 -- Codons 1284-1361 (234 nt)

**Boundary overhangs:**

| Position          | Sequence | Fidelity |
| ----------------- | -------- | -------- |
| oh1 (5' boundary) | CTAA     | 0.8691   |
| oh2 (3' boundary) | TAAC     | 0.7715   |

**Variants:** 1554 mutations, 1554 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name             | Length  | 5' OH | 3' OH |
| --- | --------------- | --------------------- | ------- | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile15_sub1  | 1376 nt | ATGG  | GAAA  |
| 2   | 5'WT gene block | bsai_5wt_tile22_sub2  | 1344 nt | GAAA  | AAAA  |
| 3   | 5'WT gene block | bsai_5wt_tile22_sub3  | 1183 nt | AAAA  | CTAA  |
| 4   | Oligo pool      | Tile 22 (1554 oligos) | 290 nt  | CTAA  | AGAA  |
| 5   | Helper plasmid  | helper_plasmid_insert | --      | --    | --    |
| 6   | Enzyme + buffer | BsaI-HFv2 + CutSmart  | --      | --    | --    |

```
  [ATGG]----5'WT sub1----[GAAA]----5'WT sub2----[AAAA]----5'WT sub3----[CTAA]----oligo+BC----[AGAA]
   ATGG                   GAAA                   AAAA                   CTAA                  AGAA 
```

**Set fidelity:** 0.9587 (5 overhangs)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                 | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------- | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)       | --      | --    | --    |
| 2   | 3'WT block        | bsmbi_3wt_tile22_sub1     | 288 nt  | TAAC  | TAGA  |
| 3   | 3'WT block        | bsmbi_3wt_tile22_sub2     | 451 nt  | TAGA  | AAGA  |
| 4   | 3'WT+PolIII block | bsmbi_cassette_tile1_sub7 | 1507 nt | AAGA  | CACC  |
| 5   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1  | --      | --    | --    |

```
  [TAAC]----3'WT sub1----[TAGA]----3'WT sub2----[AAGA]----3'WT+PolIII sub3----[CACC]
   TAAC                   TAGA                   AAGA                          CACC 
```

**Set fidelity:** 0.9627 (4 overhangs)

---

### Tile 23 of 24 -- Codons 1362-1436 (225 nt)

**Boundary overhangs:**

| Position          | Sequence | Fidelity |
| ----------------- | -------- | -------- |
| oh1 (5' boundary) | ACCT     | 0.6222   |
| oh2 (3' boundary) | CTCT     | 0.6347   |

**Variants:** 1491 mutations, 1491 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name             | Length  | 5' OH | 3' OH |
| --- | --------------- | --------------------- | ------- | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile15_sub1  | 1376 nt | ATGG  | GAAA  |
| 2   | 5'WT gene block | bsai_5wt_tile22_sub2  | 1344 nt | GAAA  | AAAA  |
| 3   | 5'WT gene block | bsai_5wt_tile23_sub3  | 1417 nt | AAAA  | ACCT  |
| 4   | Oligo pool      | Tile 23 (1491 oligos) | 281 nt  | ACCT  | AGAA  |
| 5   | Helper plasmid  | helper_plasmid_insert | --      | --    | --    |
| 6   | Enzyme + buffer | BsaI-HFv2 + CutSmart  | --      | --    | --    |

```
  [ATGG]----5'WT sub1----[GAAA]----5'WT sub2----[AAAA]----5'WT sub3----[ACCT]----oligo+BC----[AGAA]
   ATGG                   GAAA                   AAAA                   ACCT                  AGAA 
```

**Set fidelity:** 0.9605 (5 overhangs)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                 | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------- | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)       | --      | --    | --    |
| 2   | 3'WT block        | bsmbi_3wt_tile23_sub1     | 78 nt   | CTCT  | GAAA  |
| 3   | 3'WT block        | bsmbi_3wt_tile23_sub2     | 436 nt  | GAAA  | AAGA  |
| 4   | 3'WT+PolIII block | bsmbi_cassette_tile1_sub7 | 1507 nt | AAGA  | CACC  |
| 5   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1  | --      | --    | --    |

```
  [CTCT]----3'WT sub1----[GAAA]----3'WT sub2----[AAGA]----3'WT+PolIII sub3----[CACC]
   CTCT                   GAAA                   AAGA                          CACC 
```

**Set fidelity:** 0.9945 (4 overhangs)

---

### Tile 24 of 24 -- Codons 1437-1465 (87 nt)

**Boundary overhangs:**

| Position          | Sequence | Fidelity |
| ----------------- | -------- | -------- |
| oh1 (5' boundary) | AATA     | 0.8816   |
| oh2 (3' boundary) | TTAA     | 0.9448   |

**Variants:** 525 mutations, 525 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name             | Length  | 5' OH | 3' OH |
| --- | --------------- | --------------------- | ------- | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile15_sub1  | 1376 nt | ATGG  | GAAA  |
| 2   | 5'WT gene block | bsai_5wt_tile24_sub2  | 1398 nt | GAAA  | AAGA  |
| 3   | 5'WT gene block | bsai_5wt_tile24_sub3  | 1588 nt | AAGA  | AATA  |
| 4   | Oligo pool      | Tile 24 (525 oligos)  | 143 nt  | AATA  | AGAA  |
| 5   | Helper plasmid  | helper_plasmid_insert | --      | --    | --    |
| 6   | Enzyme + buffer | BsaI-HFv2 + CutSmart  | --      | --    | --    |

```
  [ATGG]----5'WT sub1----[GAAA]----5'WT sub2----[AAGA]----5'WT sub3----[AATA]----oligo+BC----[AGAA]
   ATGG                   GAAA                   AAGA                   AATA                  AGAA 
```

**Set fidelity:** 1.0000 (5 overhangs)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                  | Length  | 5' OH | 3' OH |
| --- | ----------------- | -------------------------- | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)        | --      | --    | --    |
| 2   | 3'WT block        | bsmbi_cassette_tile24_sub1 | 409 nt  | TTAA  | AAGA  |
| 3   | 3'WT+PolIII block | bsmbi_cassette_tile1_sub7  | 1507 nt | AAGA  | CACC  |
| 4   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1   | --      | --    | --    |

```
  [TTAA]----3'WT sub1----[AAGA]----3'WT+PolIII sub2----[CACC]
   TTAA                   AAGA                          CACC 
```

**Set fidelity:** 1.0000 (3 overhangs)

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
[PaqCI** AATG]--[gene+mutation]--[P2A_EGFP]--[WPRE]--[spacer]--[bGH_polyA]--[PolIII]--[barcode]--[PaqCI* GCTA]
```

## 9. Gene Block Order Sheet

Order these gene blocks as synthesized gene fragments (e.g., Twist gene fragments, IDT gBlocks).
Gene blocks are synthesized once and reused across experiments.

**Total blocks:** 98

| Block name                 | Length (nt) | Enzyme type | Gene region                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                            |
| -------------------------- | ----------- | ----------- | -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| bsai_5wt_tile10            | 1629        | BsaI        | 5wt_tile10                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                             |
| bsai_5wt_tile11_sub1       | 824         | BsaI        | 5wt_tile11_sub1                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                        |
| bsai_5wt_tile11_sub2       | 1057        | BsaI        | 5wt_tile11_sub2                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                        |
| bsai_5wt_tile12_sub1       | 1025        | BsaI        | 5wt_tile12_sub1;5wt_tile13_sub1;5wt_tile14_sub1;5wt_tile20_sub1                                                                                                                                                                                                                                                                                                                                                                                                                                                                        |
| bsai_5wt_tile12_sub2       | 1021        | BsaI        | 5wt_tile12_sub2                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                        |
| bsai_5wt_tile13_sub2       | 1138        | BsaI        | 5wt_tile13_sub2                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                        |
| bsai_5wt_tile14_sub2       | 1315        | BsaI        | 5wt_tile14_sub2                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                        |
| bsai_5wt_tile15_sub1       | 1376        | BsaI        | 5wt_tile15_sub1;5wt_tile16_sub1;5wt_tile17_sub1;5wt_tile22_sub1;5wt_tile23_sub1;5wt_tile24_sub1                                                                                                                                                                                                                                                                                                                                                                                                                                        |
| bsai_5wt_tile15_sub2       | 1126        | BsaI        | 5wt_tile15_sub2                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                        |
| bsai_5wt_tile16_sub2       | 1357        | BsaI        | 5wt_tile16_sub2                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                        |
| bsai_5wt_tile17_sub2       | 1576        | BsaI        | 5wt_tile17_sub2                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                        |
| bsai_5wt_tile18_sub1       | 1631        | BsaI        | 5wt_tile18_sub1;5wt_tile19_sub1                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                        |
| bsai_5wt_tile18_sub2       | 1483        | BsaI        | 5wt_tile18_sub2                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                        |
| bsai_5wt_tile19_sub2       | 1690        | BsaI        | 5wt_tile19_sub2                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                        |
| bsai_5wt_tile2             | 156         | BsaI        | 5wt_tile2                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                              |
| bsai_5wt_tile20_sub2       | 1170        | BsaI        | 5wt_tile20_sub2                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                        |
| bsai_5wt_tile20_sub3       | 1327        | BsaI        | 5wt_tile20_sub3                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                        |
| bsai_5wt_tile21_sub1       | 1280        | BsaI        | 5wt_tile21_sub1                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                        |
| bsai_5wt_tile21_sub2       | 1053        | BsaI        | 5wt_tile21_sub2                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                        |
| bsai_5wt_tile21_sub3       | 1339        | BsaI        | 5wt_tile21_sub3                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                        |
| bsai_5wt_tile22_sub2       | 1344        | BsaI        | 5wt_tile22_sub2;5wt_tile23_sub2                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                        |
| bsai_5wt_tile22_sub3       | 1183        | BsaI        | 5wt_tile22_sub3                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                        |
| bsai_5wt_tile23_sub3       | 1417        | BsaI        | 5wt_tile23_sub3                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                        |
| bsai_5wt_tile24_sub2       | 1398        | BsaI        | 5wt_tile24_sub2                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                        |
| bsai_5wt_tile24_sub3       | 1588        | BsaI        | 5wt_tile24_sub3                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                        |
| bsai_5wt_tile3             | 387         | BsaI        | 5wt_tile3                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                              |
| bsai_5wt_tile4             | 555         | BsaI        | 5wt_tile4                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                              |
| bsai_5wt_tile5             | 654         | BsaI        | 5wt_tile5                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                              |
| bsai_5wt_tile6             | 855         | BsaI        | 5wt_tile6                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                              |
| bsai_5wt_tile7             | 1065        | BsaI        | 5wt_tile7                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                              |
| bsai_5wt_tile8             | 1281        | BsaI        | 5wt_tile8                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                              |
| bsai_5wt_tile9             | 1431        | BsaI        | 5wt_tile9                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                              |
| bsmbi_3wt_tile1_sub1       | 690         | BsmBI       | 3wt_tile1_sub1                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                         |
| bsmbi_3wt_tile1_sub2       | 717         | BsmBI       | 3wt_tile1_sub2                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                         |
| bsmbi_3wt_tile1_sub3       | 630         | BsmBI       | 3wt_tile1_sub3                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                         |
| bsmbi_3wt_tile1_sub4       | 924         | BsmBI       | 3wt_tile1_sub4                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                         |
| bsmbi_3wt_tile1_sub5       | 546         | BsmBI       | 3wt_tile1_sub5;3wt_tile11_sub3;3wt_tile12_sub3                                                                                                                                                                                                                                                                                                                                                                                                                                                                                         |
| bsmbi_3wt_tile1_sub6       | 1249        | BsmBI       | 3wt_tile1_sub6                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                         |
| bsmbi_3wt_tile10_sub1      | 474         | BsmBI       | 3wt_tile10_sub1                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                        |
| bsmbi_3wt_tile10_sub2      | 459         | BsmBI       | 3wt_tile10_sub2                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                        |
| bsmbi_3wt_tile10_sub3      | 537         | BsmBI       | 3wt_tile10_sub3                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                        |
| bsmbi_3wt_tile10_sub4      | 777         | BsmBI       | 3wt_tile10_sub4                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                        |
| bsmbi_3wt_tile10_sub5      | 784         | BsmBI       | 3wt_tile10_sub5;3wt_tile11_sub5;3wt_tile14_sub4;3wt_tile15_sub5;3wt_tile16_sub4;3wt_tile17_sub3;3wt_tile18_sub3                                                                                                                                                                                                                                                                                                                                                                                                                        |
| bsmbi_3wt_tile11_sub1      | 642         | BsmBI       | 3wt_tile11_sub1                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                        |
| bsmbi_3wt_tile11_sub2      | 411         | BsmBI       | 3wt_tile11_sub2                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                        |
| bsmbi_3wt_tile11_sub4      | 483         | BsmBI       | 3wt_tile11_sub4                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                        |
| bsmbi_3wt_tile12_sub1      | 579         | BsmBI       | 3wt_tile12_sub1                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                        |
| bsmbi_3wt_tile12_sub2      | 357         | BsmBI       | 3wt_tile12_sub2                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                        |
| bsmbi_3wt_tile12_sub4      | 297         | BsmBI       | 3wt_tile12_sub4                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                        |
| bsmbi_3wt_tile13_sub1      | 402         | BsmBI       | 3wt_tile13_sub1                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                        |
| bsmbi_3wt_tile13_sub3      | 432         | BsmBI       | 3wt_tile13_sub3;3wt_tile14_sub2;3wt_tile16_sub2                                                                                                                                                                                                                                                                                                                                                                                                                                                                                        |
| bsmbi_3wt_tile13_sub4      | 177         | BsmBI       | 3wt_tile13_sub4                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                        |
| bsmbi_3wt_tile14_sub1      | 813         | BsmBI       | 3wt_tile14_sub1                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                        |
| bsmbi_3wt_tile14_sub3      | 363         | BsmBI       | 3wt_tile14_sub3;3wt_tile16_sub3                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                        |
| bsmbi_3wt_tile15_sub1      | 348         | BsmBI       | 3wt_tile15_sub1                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                        |
| bsmbi_3wt_tile15_sub2      | 252         | BsmBI       | 3wt_tile15_sub2                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                        |
| bsmbi_3wt_tile15_sub4      | 204         | BsmBI       | 3wt_tile15_sub4;3wt_tile17_sub2;3wt_tile18_sub2;3wt_tile19_sub2                                                                                                                                                                                                                                                                                                                                                                                                                                                                        |
| bsmbi_3wt_tile16_sub1      | 363         | BsmBI       | 3wt_tile16_sub1                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                        |
| bsmbi_3wt_tile17_sub1      | 774         | BsmBI       | 3wt_tile17_sub1                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                        |
| bsmbi_3wt_tile18_sub1      | 567         | BsmBI       | 3wt_tile18_sub1                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                        |
| bsmbi_3wt_tile19_sub1      | 384         | BsmBI       | 3wt_tile19_sub1                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                        |
| bsmbi_3wt_tile19_sub3      | 162         | BsmBI       | 3wt_tile19_sub3                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                        |
| bsmbi_3wt_tile19_sub4      | 640         | BsmBI       | 3wt_tile19_sub4                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                        |
| bsmbi_3wt_tile2_sub1       | 687         | BsmBI       | 3wt_tile2_sub1                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                         |
| bsmbi_3wt_tile2_sub2       | 789         | BsmBI       | 3wt_tile2_sub2;3wt_tile3_sub2                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                          |
| bsmbi_3wt_tile2_sub3       | 510         | BsmBI       | 3wt_tile2_sub3;3wt_tile6_sub2                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                          |
| bsmbi_3wt_tile2_sub4       | 744         | BsmBI       | 3wt_tile2_sub4;3wt_tile6_sub3                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                          |
| bsmbi_3wt_tile2_sub5       | 825         | BsmBI       | 3wt_tile2_sub5;3wt_tile3_sub5;3wt_tile6_sub4                                                                                                                                                                                                                                                                                                                                                                                                                                                                                           |
| bsmbi_3wt_tile2_sub6       | 970         | BsmBI       | 3wt_tile2_sub6;3wt_tile3_sub6;3wt_tile4_sub6;3wt_tile6_sub5;3wt_tile7_sub5;3wt_tile9_sub5;3wt_tile12_sub5;3wt_tile13_sub5                                                                                                                                                                                                                                                                                                                                                                                                              |
| bsmbi_3wt_tile20_sub1      | 420         | BsmBI       | 3wt_tile20_sub1                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                        |
| bsmbi_3wt_tile20_sub2      | 333         | BsmBI       | 3wt_tile20_sub2                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                        |
| bsmbi_3wt_tile20_sub3      | 469         | BsmBI       | 3wt_tile20_sub3;3wt_tile21_sub2                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                        |
| bsmbi_3wt_tile21_sub1      | 504         | BsmBI       | 3wt_tile21_sub1                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                        |
| bsmbi_3wt_tile22_sub1      | 288         | BsmBI       | 3wt_tile22_sub1                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                        |
| bsmbi_3wt_tile22_sub2      | 451         | BsmBI       | 3wt_tile22_sub2                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                        |
| bsmbi_3wt_tile23_sub1      | 78          | BsmBI       | 3wt_tile23_sub1                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                        |
| bsmbi_3wt_tile23_sub2      | 436         | BsmBI       | 3wt_tile23_sub2                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                        |
| bsmbi_3wt_tile3_sub1       | 519         | BsmBI       | 3wt_tile3_sub1                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                         |
| bsmbi_3wt_tile3_sub3       | 756         | BsmBI       | 3wt_tile3_sub3                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                         |
| bsmbi_3wt_tile3_sub4       | 498         | BsmBI       | 3wt_tile3_sub4                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                         |
| bsmbi_3wt_tile4_sub1       | 705         | BsmBI       | 3wt_tile4_sub1                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                         |
| bsmbi_3wt_tile4_sub2       | 504         | BsmBI       | 3wt_tile4_sub2                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                         |
| bsmbi_3wt_tile4_sub3       | 843         | BsmBI       | 3wt_tile4_sub3;3wt_tile7_sub2                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                          |
| bsmbi_3wt_tile4_sub4       | 645         | BsmBI       | 3wt_tile4_sub4;3wt_tile7_sub3                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                          |
| bsmbi_3wt_tile4_sub5       | 591         | BsmBI       | 3wt_tile4_sub5;3wt_tile7_sub4;3wt_tile9_sub4;3wt_tile15_sub3                                                                                                                                                                                                                                                                                                                                                                                                                                                                           |
| bsmbi_3wt_tile5_sub1       | 690         | BsmBI       | 3wt_tile5_sub1                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                         |
| bsmbi_3wt_tile5_sub2       | 525         | BsmBI       | 3wt_tile5_sub2                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                         |
| bsmbi_3wt_tile5_sub3       | 690         | BsmBI       | 3wt_tile5_sub3;3wt_tile9_sub2                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                          |
| bsmbi_3wt_tile5_sub4       | 591         | BsmBI       | 3wt_tile5_sub4;3wt_tile8_sub3;3wt_tile9_sub3;3wt_tile13_sub2                                                                                                                                                                                                                                                                                                                                                                                                                                                                           |
| bsmbi_3wt_tile5_sub5       | 651         | BsmBI       | 3wt_tile5_sub5;3wt_tile8_sub4                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                          |
| bsmbi_3wt_tile5_sub6       | 910         | BsmBI       | 3wt_tile5_sub6;3wt_tile8_sub5                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                          |
| bsmbi_3wt_tile6_sub1       | 780         | BsmBI       | 3wt_tile6_sub1                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                         |
| bsmbi_3wt_tile7_sub1       | 564         | BsmBI       | 3wt_tile7_sub1                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                         |
| bsmbi_3wt_tile8_sub1       | 618         | BsmBI       | 3wt_tile8_sub1                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                         |
| bsmbi_3wt_tile8_sub2       | 693         | BsmBI       | 3wt_tile8_sub2                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                         |
| bsmbi_3wt_tile9_sub1       | 423         | BsmBI       | 3wt_tile9_sub1                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                         |
| bsmbi_cassette_tile1_sub7  | 1507        | BsmBI       | cassette_tile1_frag1;cassette_tile2_frag1;cassette_tile3_frag1;cassette_tile4_frag1;cassette_tile5_frag1;cassette_tile6_frag1;cassette_tile7_frag1;cassette_tile8_frag1;cassette_tile9_frag1;cassette_tile10_frag1;cassette_tile11_frag1;cassette_tile12_frag1;cassette_tile13_frag1;cassette_tile14_frag1;cassette_tile15_frag1;cassette_tile16_frag1;cassette_tile17_frag1;cassette_tile18_frag1;cassette_tile19_frag1;cassette_tile20_frag1;cassette_tile21_frag1;cassette_tile22_frag1;cassette_tile23_frag1;cassette_tile24_frag2 |
| bsmbi_cassette_tile24_sub1 | 409         | BsmBI       | cassette_tile24_frag1                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                  |

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

| Parameter             | Value          |
| --------------------- | -------------- |
| max_oligo_length      | 300            |
| max_geneblock_length  | 1800           |
| barcode_length        | 20             |
| min_hamming_distance  | 3              |
| barcode_prefix_length | 12             |
| barcodes_per_variant  | 1              |
| boundary_method       | oogga_two_pass |
| multi_k_search        | TRUE           |
| auto_domesticate      | TRUE           |

