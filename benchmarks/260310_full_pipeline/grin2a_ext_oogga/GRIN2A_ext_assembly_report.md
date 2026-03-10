# DMS-GG Assembly Report: GRIN2A_ext

Generated: 2026-03-10 10:42:26
Pipeline: dms-gg-oligo-pipeline (3-Enzyme Architecture: BsaI + BsmBI + PaqCI)

---

## 1. Gene Summary

| Property             | Value                                                                          |
| -------------------- | ------------------------------------------------------------------------------ |
| Gene name            | GRIN2A_NM_000833.5 Human GRIN2A native CDS (NM_000833.5, NP_000824.1, 1464 aa) |
| CDS length           | 4395 nt (1465 codons)                                                          |
| Protein length       | 1464 aa                                                                        |
| Number of tiles      | 27                                                                             |
| Total variants       | 28497                                                                          |
| Total oligos         | 284970                                                                         |
| Oligo length range   | 137-287 nt                                                                     |
| Gene blocks to order | 68                                                                             |
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
[PaqCI**]--[gene+mutation]--[P2A_EGFP]--[WPRE]--[spacer]--[bGH_polyA]--[PolIII]--[barcode]--[PaqCI*]
```

## 3. Oligo Pool Summary

**Total oligos:** 284970 | **Length range:** 137-287 nt

| Tile | Codons    | Oligos | Length |
| ---- | --------- | ------ | ------ |
| 1    | 1-46      | 8820   | 194 nt |
| 2    | 47-123    | 15330  | 287 nt |
| 3    | 124-179   | 10920  | 224 nt |
| 4    | 180-229   | 9660   | 206 nt |
| 5    | 230-279   | 9660   | 206 nt |
| 6    | 280-349   | 13860  | 266 nt |
| 7    | 350-402   | 10290  | 215 nt |
| 8    | 403-449   | 9030   | 197 nt |
| 9    | 450-488   | 7350   | 173 nt |
| 10   | 489-537   | 9450   | 203 nt |
| 11   | 538-596   | 11550  | 233 nt |
| 12   | 597-670   | 14700  | 278 nt |
| 13   | 671-709   | 7350   | 173 nt |
| 14   | 710-766   | 11130  | 227 nt |
| 15   | 767-831   | 12810  | 251 nt |
| 16   | 832-907   | 15120  | 284 nt |
| 17   | 908-979   | 14280  | 272 nt |
| 18   | 980-1025  | 8820   | 194 nt |
| 19   | 1026-1066 | 7770   | 179 nt |
| 20   | 1067-1127 | 11970  | 239 nt |
| 21   | 1128-1171 | 8400   | 188 nt |
| 22   | 1172-1224 | 10290  | 215 nt |
| 23   | 1225-1277 | 10290  | 215 nt |
| 24   | 1278-1354 | 15330  | 287 nt |
| 25   | 1355-1406 | 10080  | 212 nt |
| 26   | 1407-1433 | 4830   | 137 nt |
| 27   | 1434-1465 | 5880   | 152 nt |

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
| Total barcodes    | 284970                             |
| Unique barcodes   | 284970                             |
| GC content range  | 25% - 75%                          |
| GC content mean   | 47.9%                              |
| Hamming guarantee | 100% cross-variant (prefix d >= 3) |

## 5. QC Summary

**Overall:** ISSUES FOUND

| Check                     | Description                                                   | Result | Detail                                                                                                                                                |
| ------------------------- | ------------------------------------------------------------- | ------ | ----------------------------------------------------------------------------------------------------------------------------------------------------- |
| oligo_lengths             | All oligos within synthesis length limit                      | PASS   | Range: 137-287 nt (limit: 300)                                                                                                                        |
| block_lengths             | All gene blocks within synthesis length limit                 | PASS   | Range: 22-1756 nt (limit: 1800)                                                                                                                       |
| barcode_junction_sites    | No enzyme sites at barcode-context junctions                  | PASS   | 0 barcode(s) with junction enzyme sites (left='CACACC', right='AGAATG')                                                                               |
| barcode_uniqueness        | All barcodes are unique                                       | PASS   | 284970 unique / 284970 total                                                                                                                          |
| tile_coverage             | Tiles cover entire gene without gaps                          | PASS   | 4395 / 4395 nt covered                                                                                                                                |
| variant_count             | Expected number of variants generated                         | PASS   | 28497 unique variants (expected: 28497 across 1357/1463 mutable positions; 25783 missense + 1357 nonsense + 1357 wt_control; 106 position(s) skipped) |
| single_codon_change       | Each non-control variant differs by exactly one codon from WT | PASS   | 271400 / 271400 variants confirmed (WT controls excluded)                                                                                             |
| oligo_gc_content          | Oligo GC content within reasonable range (25-75%)             | PASS   | GC range: 38.2-66.5% | 0 oligo(s) with extreme GC                                                                                                     |
| domestication_complete    | Gene domesticated for all 3 enzymes (BsaI, BsmBI, PaqCI)      | PASS   | No enzyme sites in gene                                                                                                                               |
| overhang_fidelity         | Tile boundary overhangs have adequate fidelity                | FAIL   | 21 tile(s) with low-fidelity boundary overhangs (<0.80)                                                                                               |
| tile_manifests            | Per-tile assembly manifests complete                          | PASS   | 27 tile manifest(s) generated                                                                                                                         |
| helper_plasmid            | Helper plasmid free of unintended BsmBI sites                 | PASS   | OK                                                                                                                                                    |
| reaction_fidelity         | Per-reaction set-level overhang fidelity                      | PASS   | Min set fidelity: 0.894 across 54 reactions | 1 reaction(s) below 0.90                                                                                |
| barcode_poliii_term       | No barcodes contain PolIII terminator signal (TTTT)           | PASS   | 0 / 284970 barcode(s) contain TTTT                                                                                                                    |
| block_min_length          | All gene blocks above synthesis minimum length                | FAIL   | 12 block(s) below 300 nt minimum. Range: 22-1756 nt                                                                                                   |
| cassette_fragment_lengths | Cassette fragments within synthesis limits                    | PASS   | 2 cassette fragment(s). Range: 409-1507 nt. 0 over max, 0 under min.                                                                                  |
| sb_overhang_collisions    | Superblock boundary overhangs are unique (no collisions)      | PASS   | 3 SB boundary OH(s), all unique                                                                                                                       |

## 5b. Reaction Fidelity Summary

Set fidelity for each tile's BsaI and BsmBI reactions,
computed from the actual block overhangs after construction:

| Tile | BsaI OHs | BsaI Set Fidelity | BsmBI OHs | BsmBI Set Fidelity |
| ---- | -------- | ----------------- | --------- | ------------------ |
| 1    | 2        | 1.0000            | 5         | 1.0000             |
| 2    | 3        | 1.0000            | 5         | 1.0000             |
| 3    | 3        | 1.0000            | 5         | 1.0000             |
| 4    | 3        | 1.0000            | 5         | 1.0000             |
| 5    | 3        | 1.0000            | 5         | 1.0000             |
| 6    | 3        | 1.0000            | 5         | 1.0000             |
| 7    | 3        | 1.0000            | 5         | 1.0000             |
| 8    | 3        | 1.0000            | 5         | 1.0000             |
| 9    | 3        | 0.8940            | 4         | 1.0000             |
| 10   | 3        | 1.0000            | 4         | 1.0000             |
| 11   | 3        | 1.0000            | 4         | 1.0000             |
| 12   | 4        | 1.0000            | 4         | 1.0000             |
| 13   | 4        | 1.0000            | 4         | 1.0000             |
| 14   | 4        | 1.0000            | 4         | 1.0000             |
| 15   | 4        | 1.0000            | 4         | 0.9984             |
| 16   | 4        | 1.0000            | 4         | 1.0000             |
| 17   | 4        | 1.0000            | 4         | 1.0000             |
| 18   | 4        | 1.0000            | 4         | 1.0000             |
| 19   | 4        | 1.0000            | 6         | 0.9731             |
| 20   | 4        | 0.9981            | 5         | 0.9736             |
| 21   | 5        | 1.0000            | 6         | 0.9905             |
| 22   | 5        | 0.9439            | 5         | 0.9904             |
| 23   | 5        | 1.0000            | 4         | 1.0000             |
| 24   | 5        | 1.0000            | 4         | 0.9644             |
| 25   | 5        | 1.0000            | 4         | 1.0000             |
| 26   | 5        | 1.0000            | 4         | 1.0000             |
| 27   | 5        | 1.0000            | 3         | 1.0000             |

**Min:** 0.8940 | **Max:** 1.0000 | **Mean:** 0.9949

**Warning:** 1 reaction(s) below 0.90 fidelity — consider alternative split points or overhang reassignment.
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

### Tile 1 of 27 -- Codons 1-46 (138 nt)

**Boundary overhangs:**

| Position          | Sequence | Fidelity |
| ----------------- | -------- | -------- |
| oh1 (5' boundary) | ATGG     | 0.5393   |
| oh2 (3' boundary) | CGAA     | 0.7461   |

**Variants:** 8820 mutations, 8820 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name                          | Length | 5' OH | 3' OH |
| --- | --------------- | ---------------------------------- | ------ | ----- | ----- |
| 1   | 5'WT gene block | (none -- tile starts at gene nt 1) | --     | --    | --    |
| 2   | Oligo pool      | Tile 1 (8820 oligos)               | 194 nt | ATGG  | AGAA  |
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
| 2   | 3'WT block        | bsmbi_3wt_tile1_sub1      | 1344 nt | CGAA  | TGTG  |
| 3   | 3'WT block        | bsmbi_3wt_tile1_sub2      | 1752 nt | TGTG  | GTGC  |
| 4   | 3'WT block        | bsmbi_3wt_tile1_sub3      | 1606 nt | GTGC  | AAGA  |
| 5   | 3'WT+PolIII block | bsmbi_cassette_tile1_sub4 | 1507 nt | AAGA  | CACC  |
| 6   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1  | --      | --    | --    |

```
  [CGAA]----3'WT sub1----[TGTG]----3'WT sub2----[GTGC]----3'WT sub3----[AAGA]----3'WT+PolIII sub4----[CACC]
   CGAA                   TGTG                   GTGC                   AAGA                          CACC 
```

**Set fidelity:** 1.0000 (5 overhangs)

---

### Tile 2 of 27 -- Codons 47-123 (231 nt)

**Boundary overhangs:**

| Position          | Sequence | Fidelity |
| ----------------- | -------- | -------- |
| oh1 (5' boundary) | ACAG     | 0.5793   |
| oh2 (3' boundary) | CATT     | 0.6770   |

**Variants:** 15330 mutations, 15330 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name             | Length | 5' OH | 3' OH |
| --- | --------------- | --------------------- | ------ | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile2        | 156 nt | ATGG  | ACAG  |
| 2   | Oligo pool      | Tile 2 (15330 oligos) | 287 nt | ACAG  | AGAA  |
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
| 2   | 3'WT block        | bsmbi_3wt_tile2_sub1      | 1113 nt | CATT  | TGTG  |
| 3   | 3'WT block        | bsmbi_3wt_tile1_sub2      | 1752 nt | TGTG  | GTGC  |
| 4   | 3'WT block        | bsmbi_3wt_tile1_sub3      | 1606 nt | GTGC  | AAGA  |
| 5   | 3'WT+PolIII block | bsmbi_cassette_tile1_sub4 | 1507 nt | AAGA  | CACC  |
| 6   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1  | --      | --    | --    |

```
  [CATT]----3'WT sub1----[TGTG]----3'WT sub2----[GTGC]----3'WT sub3----[AAGA]----3'WT+PolIII sub4----[CACC]
   CATT                   TGTG                   GTGC                   AAGA                          CACC 
```

**Set fidelity:** 1.0000 (5 overhangs)

---

### Tile 3 of 27 -- Codons 124-179 (168 nt)

**Boundary overhangs:**

| Position          | Sequence | Fidelity |
| ----------------- | -------- | -------- |
| oh1 (5' boundary) | ATCT     | 0.7151   |
| oh2 (3' boundary) | ATTC     | 0.7084   |

**Variants:** 10920 mutations, 10920 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name             | Length | 5' OH | 3' OH |
| --- | --------------- | --------------------- | ------ | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile3        | 387 nt | ATGG  | ATCT  |
| 2   | Oligo pool      | Tile 3 (10920 oligos) | 224 nt | ATCT  | AGAA  |
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
| 2   | 3'WT block        | bsmbi_3wt_tile3_sub1      | 945 nt  | ATTC  | TGTG  |
| 3   | 3'WT block        | bsmbi_3wt_tile1_sub2      | 1752 nt | TGTG  | GTGC  |
| 4   | 3'WT block        | bsmbi_3wt_tile1_sub3      | 1606 nt | GTGC  | AAGA  |
| 5   | 3'WT+PolIII block | bsmbi_cassette_tile1_sub4 | 1507 nt | AAGA  | CACC  |
| 6   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1  | --      | --    | --    |

```
  [ATTC]----3'WT sub1----[TGTG]----3'WT sub2----[GTGC]----3'WT sub3----[AAGA]----3'WT+PolIII sub4----[CACC]
   ATTC                   TGTG                   GTGC                   AAGA                          CACC 
```

**Set fidelity:** 1.0000 (5 overhangs)

---

### Tile 4 of 27 -- Codons 180-229 (150 nt)

**Boundary overhangs:**

| Position          | Sequence | Fidelity |
| ----------------- | -------- | -------- |
| oh1 (5' boundary) | TACA     | 0.8652   |
| oh2 (3' boundary) | CAAA     | 0.8948   |

**Variants:** 9660 mutations, 9660 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name             | Length | 5' OH | 3' OH |
| --- | --------------- | --------------------- | ------ | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile4        | 555 nt | ATGG  | TACA  |
| 2   | Oligo pool      | Tile 4 (9660 oligos)  | 206 nt | TACA  | AGAA  |
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
| 2   | 3'WT block        | bsmbi_3wt_tile4_sub1      | 795 nt  | CAAA  | TGTG  |
| 3   | 3'WT block        | bsmbi_3wt_tile1_sub2      | 1752 nt | TGTG  | GTGC  |
| 4   | 3'WT block        | bsmbi_3wt_tile1_sub3      | 1606 nt | GTGC  | AAGA  |
| 5   | 3'WT+PolIII block | bsmbi_cassette_tile1_sub4 | 1507 nt | AAGA  | CACC  |
| 6   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1  | --      | --    | --    |

```
  [CAAA]----3'WT sub1----[TGTG]----3'WT sub2----[GTGC]----3'WT sub3----[AAGA]----3'WT+PolIII sub4----[CACC]
   CAAA                   TGTG                   GTGC                   AAGA                          CACC 
```

**Set fidelity:** 1.0000 (5 overhangs)

---

### Tile 5 of 27 -- Codons 230-279 (150 nt)

**Boundary overhangs:**

| Position          | Sequence | Fidelity |
| ----------------- | -------- | -------- |
| oh1 (5' boundary) | TACT     | 0.7445   |
| oh2 (3' boundary) | TGAC     | 0.6485   |

**Variants:** 9660 mutations, 9660 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name             | Length | 5' OH | 3' OH |
| --- | --------------- | --------------------- | ------ | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile5        | 705 nt | ATGG  | TACT  |
| 2   | Oligo pool      | Tile 5 (9660 oligos)  | 206 nt | TACT  | AGAA  |
| 3   | Helper plasmid  | helper_plasmid_insert | --     | --    | --    |
| 4   | Enzyme + buffer | BsaI-HFv2 + CutSmart  | --     | --    | --    |

```
  [ATGG]----5'WT block----[TACT]----oligo+BC----[AGAA]
   ATGG                    TACT                  AGAA 
```

**Set fidelity:** 1.0000 (3 overhangs)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                 | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------- | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)       | --      | --    | --    |
| 2   | 3'WT block        | bsmbi_3wt_tile5_sub1      | 645 nt  | TGAC  | TGTG  |
| 3   | 3'WT block        | bsmbi_3wt_tile1_sub2      | 1752 nt | TGTG  | GTGC  |
| 4   | 3'WT block        | bsmbi_3wt_tile1_sub3      | 1606 nt | GTGC  | AAGA  |
| 5   | 3'WT+PolIII block | bsmbi_cassette_tile1_sub4 | 1507 nt | AAGA  | CACC  |
| 6   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1  | --      | --    | --    |

```
  [TGAC]----3'WT sub1----[TGTG]----3'WT sub2----[GTGC]----3'WT sub3----[AAGA]----3'WT+PolIII sub4----[CACC]
   TGAC                   TGTG                   GTGC                   AAGA                          CACC 
```

**Set fidelity:** 1.0000 (5 overhangs)

---

### Tile 6 of 27 -- Codons 280-349 (210 nt)

**Boundary overhangs:**

| Position          | Sequence | Fidelity |
| ----------------- | -------- | -------- |
| oh1 (5' boundary) | TCCT     | 0.7573   |
| oh2 (3' boundary) | GGAA     | 0.7463   |

**Variants:** 13860 mutations, 13860 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name             | Length | 5' OH | 3' OH |
| --- | --------------- | --------------------- | ------ | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile6        | 855 nt | ATGG  | TCCT  |
| 2   | Oligo pool      | Tile 6 (13860 oligos) | 266 nt | TCCT  | AGAA  |
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
| 2   | 3'WT block        | bsmbi_3wt_tile6_sub1      | 435 nt  | GGAA  | TGTG  |
| 3   | 3'WT block        | bsmbi_3wt_tile1_sub2      | 1752 nt | TGTG  | GTGC  |
| 4   | 3'WT block        | bsmbi_3wt_tile1_sub3      | 1606 nt | GTGC  | AAGA  |
| 5   | 3'WT+PolIII block | bsmbi_cassette_tile1_sub4 | 1507 nt | AAGA  | CACC  |
| 6   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1  | --      | --    | --    |

```
  [GGAA]----3'WT sub1----[TGTG]----3'WT sub2----[GTGC]----3'WT sub3----[AAGA]----3'WT+PolIII sub4----[CACC]
   GGAA                   TGTG                   GTGC                   AAGA                          CACC 
```

**Set fidelity:** 1.0000 (5 overhangs)

---

### Tile 7 of 27 -- Codons 350-402 (159 nt)

**Boundary overhangs:**

| Position          | Sequence | Fidelity |
| ----------------- | -------- | -------- |
| oh1 (5' boundary) | TTCA     | 0.8824   |
| oh2 (3' boundary) | TCTC     | 0.8105   |

**Variants:** 10290 mutations, 10290 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name             | Length  | 5' OH | 3' OH |
| --- | --------------- | --------------------- | ------- | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile7        | 1065 nt | ATGG  | TTCA  |
| 2   | Oligo pool      | Tile 7 (10290 oligos) | 215 nt  | TTCA  | AGAA  |
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
| 2   | 3'WT block        | bsmbi_3wt_tile7_sub1      | 276 nt  | TCTC  | TGTG  |
| 3   | 3'WT block        | bsmbi_3wt_tile1_sub2      | 1752 nt | TGTG  | GTGC  |
| 4   | 3'WT block        | bsmbi_3wt_tile1_sub3      | 1606 nt | GTGC  | AAGA  |
| 5   | 3'WT+PolIII block | bsmbi_cassette_tile1_sub4 | 1507 nt | AAGA  | CACC  |
| 6   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1  | --      | --    | --    |

```
  [TCTC]----3'WT sub1----[TGTG]----3'WT sub2----[GTGC]----3'WT sub3----[AAGA]----3'WT+PolIII sub4----[CACC]
   TCTC                   TGTG                   GTGC                   AAGA                          CACC 
```

**Set fidelity:** 1.0000 (5 overhangs)

---

### Tile 8 of 27 -- Codons 403-449 (141 nt)

**Boundary overhangs:**

| Position          | Sequence | Fidelity |
| ----------------- | -------- | -------- |
| oh1 (5' boundary) | GACA     | 0.6127   |
| oh2 (3' boundary) | GAAG     | 0.6752   |

**Variants:** 9030 mutations, 9030 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name             | Length  | 5' OH | 3' OH |
| --- | --------------- | --------------------- | ------- | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile8        | 1224 nt | ATGG  | GACA  |
| 2   | Oligo pool      | Tile 8 (9030 oligos)  | 197 nt  | GACA  | AGAA  |
| 3   | Helper plasmid  | helper_plasmid_insert | --      | --    | --    |
| 4   | Enzyme + buffer | BsaI-HFv2 + CutSmart  | --      | --    | --    |

```
  [ATGG]----5'WT block----[GACA]----oligo+BC----[AGAA]
   ATGG                    GACA                  AGAA 
```

**Set fidelity:** 1.0000 (3 overhangs)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                 | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------- | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)       | --      | --    | --    |
| 2   | 3'WT block        | bsmbi_3wt_tile8_sub1      | 135 nt  | GAAG  | TGTG  |
| 3   | 3'WT block        | bsmbi_3wt_tile1_sub2      | 1752 nt | TGTG  | GTGC  |
| 4   | 3'WT block        | bsmbi_3wt_tile1_sub3      | 1606 nt | GTGC  | AAGA  |
| 5   | 3'WT+PolIII block | bsmbi_cassette_tile1_sub4 | 1507 nt | AAGA  | CACC  |
| 6   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1  | --      | --    | --    |

```
  [GAAG]----3'WT sub1----[TGTG]----3'WT sub2----[GTGC]----3'WT sub3----[AAGA]----3'WT+PolIII sub4----[CACC]
   GAAG                   TGTG                   GTGC                   AAGA                          CACC 
```

**Set fidelity:** 1.0000 (5 overhangs)

---

### Tile 9 of 27 -- Codons 450-488 (117 nt)

**Boundary overhangs:**

| Position          | Sequence | Fidelity |
| ----------------- | -------- | -------- |
| oh1 (5' boundary) | ATGA     | 0.7549   |
| oh2 (3' boundary) | TGTG     | 0.5408   |

**Variants:** 7350 mutations, 7350 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name             | Length  | 5' OH | 3' OH |
| --- | --------------- | --------------------- | ------- | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile9        | 1365 nt | ATGG  | ATGA  |
| 2   | Oligo pool      | Tile 9 (7350 oligos)  | 173 nt  | ATGA  | AGAA  |
| 3   | Helper plasmid  | helper_plasmid_insert | --      | --    | --    |
| 4   | Enzyme + buffer | BsaI-HFv2 + CutSmart  | --      | --    | --    |

```
  [ATGG]----5'WT block----[ATGA]----oligo+BC----[AGAA]
   ATGG                    ATGA                  AGAA 
```

**Set fidelity:** 0.8940 (3 overhangs)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                 | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------- | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)       | --      | --    | --    |
| 2   | 3'WT block        | bsmbi_3wt_tile1_sub2      | 1752 nt | TGTG  | GTGC  |
| 3   | 3'WT block        | bsmbi_3wt_tile1_sub3      | 1606 nt | GTGC  | AAGA  |
| 4   | 3'WT+PolIII block | bsmbi_cassette_tile1_sub4 | 1507 nt | AAGA  | CACC  |
| 5   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1  | --      | --    | --    |

```
  [TGTG]----3'WT sub1----[GTGC]----3'WT sub2----[AAGA]----3'WT+PolIII sub3----[CACC]
   TGTG                   GTGC                   AAGA                          CACC 
```

**Set fidelity:** 1.0000 (4 overhangs)

---

### Tile 10 of 27 -- Codons 489-537 (147 nt)

**Boundary overhangs:**

| Position          | Sequence | Fidelity |
| ----------------- | -------- | -------- |
| oh1 (5' boundary) | GTTA     | 0.6139   |
| oh2 (3' boundary) | TAAT     | 0.8165   |

**Variants:** 9450 mutations, 9450 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name             | Length  | 5' OH | 3' OH |
| --- | --------------- | --------------------- | ------- | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile10_sub1  | 1482 nt | ATGG  | GTTA  |
| 2   | Oligo pool      | Tile 10 (9450 oligos) | 203 nt  | GTTA  | AGAA  |
| 3   | Helper plasmid  | helper_plasmid_insert | --      | --    | --    |
| 4   | Enzyme + buffer | BsaI-HFv2 + CutSmart  | --      | --    | --    |

```
  [ATGG]----5'WT block----[GTTA]----oligo+BC----[AGAA]
   ATGG                    GTTA                  AGAA 
```

**Set fidelity:** 1.0000 (3 overhangs)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                 | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------- | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)       | --      | --    | --    |
| 2   | 3'WT block        | bsmbi_3wt_tile10_sub1     | 1605 nt | TAAT  | GTGC  |
| 3   | 3'WT block        | bsmbi_3wt_tile1_sub3      | 1606 nt | GTGC  | AAGA  |
| 4   | 3'WT+PolIII block | bsmbi_cassette_tile1_sub4 | 1507 nt | AAGA  | CACC  |
| 5   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1  | --      | --    | --    |

```
  [TAAT]----3'WT sub1----[GTGC]----3'WT sub2----[AAGA]----3'WT+PolIII sub3----[CACC]
   TAAT                   GTGC                   AAGA                          CACC 
```

**Set fidelity:** 1.0000 (4 overhangs)

---

### Tile 11 of 27 -- Codons 538-596 (177 nt)

**Boundary overhangs:**

| Position          | Sequence | Fidelity |
| ----------------- | -------- | -------- |
| oh1 (5' boundary) | TCAA     | 0.9425   |
| oh2 (3' boundary) | TACA     | 0.8652   |

**Variants:** 11550 mutations, 11550 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name              | Length  | 5' OH | 3' OH |
| --- | --------------- | ---------------------- | ------- | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile11_sub1   | 1629 nt | ATGG  | TCAA  |
| 2   | Oligo pool      | Tile 11 (11550 oligos) | 233 nt  | TCAA  | AGAA  |
| 3   | Helper plasmid  | helper_plasmid_insert  | --      | --    | --    |
| 4   | Enzyme + buffer | BsaI-HFv2 + CutSmart   | --      | --    | --    |

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
| 2   | 3'WT block        | bsmbi_3wt_tile11_sub1     | 1428 nt | TACA  | GTGC  |
| 3   | 3'WT block        | bsmbi_3wt_tile1_sub3      | 1606 nt | GTGC  | AAGA  |
| 4   | 3'WT+PolIII block | bsmbi_cassette_tile1_sub4 | 1507 nt | AAGA  | CACC  |
| 5   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1  | --      | --    | --    |

```
  [TACA]----3'WT sub1----[GTGC]----3'WT sub2----[AAGA]----3'WT+PolIII sub3----[CACC]
   TACA                   GTGC                   AAGA                          CACC 
```

**Set fidelity:** 1.0000 (4 overhangs)

---

### Tile 12 of 27 -- Codons 597-670 (222 nt)

**Boundary overhangs:**

| Position          | Sequence | Fidelity |
| ----------------- | -------- | -------- |
| oh1 (5' boundary) | CCTT     | 0.6891   |
| oh2 (3' boundary) | TCAT     | 0.8102   |

**Variants:** 14700 mutations, 14700 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name              | Length  | 5' OH | 3' OH |
| --- | --------------- | ---------------------- | ------- | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile12_sub1   | 1478 nt | ATGG  | TGTG  |
| 2   | 5'WT gene block | bsai_5wt_tile12_sub2   | 346 nt  | TGTG  | CCTT  |
| 3   | Oligo pool      | Tile 12 (14700 oligos) | 278 nt  | CCTT  | AGAA  |
| 4   | Helper plasmid  | helper_plasmid_insert  | --      | --    | --    |
| 5   | Enzyme + buffer | BsaI-HFv2 + CutSmart   | --      | --    | --    |

```
  [ATGG]----5'WT sub1----[TGTG]----5'WT sub2----[CCTT]----oligo+BC----[AGAA]
   ATGG                   TGTG                   CCTT                  AGAA 
```

**Set fidelity:** 1.0000 (4 overhangs)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                 | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------- | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)       | --      | --    | --    |
| 2   | 3'WT block        | bsmbi_3wt_tile12_sub1     | 1206 nt | TCAT  | GTGC  |
| 3   | 3'WT block        | bsmbi_3wt_tile1_sub3      | 1606 nt | GTGC  | AAGA  |
| 4   | 3'WT+PolIII block | bsmbi_cassette_tile1_sub4 | 1507 nt | AAGA  | CACC  |
| 5   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1  | --      | --    | --    |

```
  [TCAT]----3'WT sub1----[GTGC]----3'WT sub2----[AAGA]----3'WT+PolIII sub3----[CACC]
   TCAT                   GTGC                   AAGA                          CACC 
```

**Set fidelity:** 1.0000 (4 overhangs)

---

### Tile 13 of 27 -- Codons 671-709 (117 nt)

**Boundary overhangs:**

| Position          | Sequence | Fidelity |
| ----------------- | -------- | -------- |
| oh1 (5' boundary) | CAAA     | 0.8948   |
| oh2 (3' boundary) | AGTA     | 0.7286   |

**Variants:** 7350 mutations, 7350 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name             | Length  | 5' OH | 3' OH |
| --- | --------------- | --------------------- | ------- | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile12_sub1  | 1478 nt | ATGG  | TGTG  |
| 2   | 5'WT gene block | bsai_5wt_tile13_sub2  | 568 nt  | TGTG  | CAAA  |
| 3   | Oligo pool      | Tile 13 (7350 oligos) | 173 nt  | CAAA  | AGAA  |
| 4   | Helper plasmid  | helper_plasmid_insert | --      | --    | --    |
| 5   | Enzyme + buffer | BsaI-HFv2 + CutSmart  | --      | --    | --    |

```
  [ATGG]----5'WT sub1----[TGTG]----5'WT sub2----[CAAA]----oligo+BC----[AGAA]
   ATGG                   TGTG                   CAAA                  AGAA 
```

**Set fidelity:** 1.0000 (4 overhangs)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                 | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------- | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)       | --      | --    | --    |
| 2   | 3'WT block        | bsmbi_3wt_tile13_sub1     | 1089 nt | AGTA  | GTGC  |
| 3   | 3'WT block        | bsmbi_3wt_tile1_sub3      | 1606 nt | GTGC  | AAGA  |
| 4   | 3'WT+PolIII block | bsmbi_cassette_tile1_sub4 | 1507 nt | AAGA  | CACC  |
| 5   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1  | --      | --    | --    |

```
  [AGTA]----3'WT sub1----[GTGC]----3'WT sub2----[AAGA]----3'WT+PolIII sub3----[CACC]
   AGTA                   GTGC                   AAGA                          CACC 
```

**Set fidelity:** 1.0000 (4 overhangs)

---

### Tile 14 of 27 -- Codons 710-766 (171 nt)

**Boundary overhangs:**

| Position          | Sequence | Fidelity |
| ----------------- | -------- | -------- |
| oh1 (5' boundary) | CAGA     | 0.8175   |
| oh2 (3' boundary) | TCCT     | 0.7573   |

**Variants:** 11130 mutations, 11130 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name              | Length  | 5' OH | 3' OH |
| --- | --------------- | ---------------------- | ------- | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile12_sub1   | 1478 nt | ATGG  | TGTG  |
| 2   | 5'WT gene block | bsai_5wt_tile14_sub2   | 685 nt  | TGTG  | CAGA  |
| 3   | Oligo pool      | Tile 14 (11130 oligos) | 227 nt  | CAGA  | AGAA  |
| 4   | Helper plasmid  | helper_plasmid_insert  | --      | --    | --    |
| 5   | Enzyme + buffer | BsaI-HFv2 + CutSmart   | --      | --    | --    |

```
  [ATGG]----5'WT sub1----[TGTG]----5'WT sub2----[CAGA]----oligo+BC----[AGAA]
   ATGG                   TGTG                   CAGA                  AGAA 
```

**Set fidelity:** 1.0000 (4 overhangs)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                 | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------- | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)       | --      | --    | --    |
| 2   | 3'WT block        | bsmbi_3wt_tile14_sub1     | 918 nt  | TCCT  | GTGC  |
| 3   | 3'WT block        | bsmbi_3wt_tile1_sub3      | 1606 nt | GTGC  | AAGA  |
| 4   | 3'WT+PolIII block | bsmbi_cassette_tile1_sub4 | 1507 nt | AAGA  | CACC  |
| 5   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1  | --      | --    | --    |

```
  [TCCT]----3'WT sub1----[GTGC]----3'WT sub2----[AAGA]----3'WT+PolIII sub3----[CACC]
   TCCT                   GTGC                   AAGA                          CACC 
```

**Set fidelity:** 1.0000 (4 overhangs)

---

### Tile 15 of 27 -- Codons 767-831 (195 nt)

**Boundary overhangs:**

| Position          | Sequence | Fidelity |
| ----------------- | -------- | -------- |
| oh1 (5' boundary) | AAAG     | 0.7511   |
| oh2 (3' boundary) | CTTC     | 0.6384   |

**Variants:** 12810 mutations, 12810 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name              | Length  | 5' OH | 3' OH |
| --- | --------------- | ---------------------- | ------- | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile12_sub1   | 1478 nt | ATGG  | TGTG  |
| 2   | 5'WT gene block | bsai_5wt_tile15_sub2   | 856 nt  | TGTG  | AAAG  |
| 3   | Oligo pool      | Tile 15 (12810 oligos) | 251 nt  | AAAG  | AGAA  |
| 4   | Helper plasmid  | helper_plasmid_insert  | --      | --    | --    |
| 5   | Enzyme + buffer | BsaI-HFv2 + CutSmart   | --      | --    | --    |

```
  [ATGG]----5'WT sub1----[TGTG]----5'WT sub2----[AAAG]----oligo+BC----[AGAA]
   ATGG                   TGTG                   AAAG                  AGAA 
```

**Set fidelity:** 1.0000 (4 overhangs)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                 | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------- | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)       | --      | --    | --    |
| 2   | 3'WT block        | bsmbi_3wt_tile15_sub1     | 723 nt  | CTTC  | GTGC  |
| 3   | 3'WT block        | bsmbi_3wt_tile1_sub3      | 1606 nt | GTGC  | AAGA  |
| 4   | 3'WT+PolIII block | bsmbi_cassette_tile1_sub4 | 1507 nt | AAGA  | CACC  |
| 5   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1  | --      | --    | --    |

```
  [CTTC]----3'WT sub1----[GTGC]----3'WT sub2----[AAGA]----3'WT+PolIII sub3----[CACC]
   CTTC                   GTGC                   AAGA                          CACC 
```

**Set fidelity:** 0.9984 (4 overhangs)

---

### Tile 16 of 27 -- Codons 832-907 (228 nt)

**Boundary overhangs:**

| Position          | Sequence | Fidelity |
| ----------------- | -------- | -------- |
| oh1 (5' boundary) | CTCA     | 0.6872   |
| oh2 (3' boundary) | GAAC     | 0.6079   |

**Variants:** 15120 mutations, 15120 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name              | Length  | 5' OH | 3' OH |
| --- | --------------- | ---------------------- | ------- | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile12_sub1   | 1478 nt | ATGG  | TGTG  |
| 2   | 5'WT gene block | bsai_5wt_tile16_sub2   | 1051 nt | TGTG  | CTCA  |
| 3   | Oligo pool      | Tile 16 (15120 oligos) | 284 nt  | CTCA  | AGAA  |
| 4   | Helper plasmid  | helper_plasmid_insert  | --      | --    | --    |
| 5   | Enzyme + buffer | BsaI-HFv2 + CutSmart   | --      | --    | --    |

```
  [ATGG]----5'WT sub1----[TGTG]----5'WT sub2----[CTCA]----oligo+BC----[AGAA]
   ATGG                   TGTG                   CTCA                  AGAA 
```

**Set fidelity:** 1.0000 (4 overhangs)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                 | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------- | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)       | --      | --    | --    |
| 2   | 3'WT block        | bsmbi_3wt_tile16_sub1     | 495 nt  | GAAC  | GTGC  |
| 3   | 3'WT block        | bsmbi_3wt_tile1_sub3      | 1606 nt | GTGC  | AAGA  |
| 4   | 3'WT+PolIII block | bsmbi_cassette_tile1_sub4 | 1507 nt | AAGA  | CACC  |
| 5   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1  | --      | --    | --    |

```
  [GAAC]----3'WT sub1----[GTGC]----3'WT sub2----[AAGA]----3'WT+PolIII sub3----[CACC]
   GAAC                   GTGC                   AAGA                          CACC 
```

**Set fidelity:** 1.0000 (4 overhangs)

---

### Tile 17 of 27 -- Codons 908-979 (216 nt)

**Boundary overhangs:**

| Position          | Sequence | Fidelity |
| ----------------- | -------- | -------- |
| oh1 (5' boundary) | TCCA     | 0.8519   |
| oh2 (3' boundary) | ACAA     | 0.8919   |

**Variants:** 14280 mutations, 14280 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name              | Length  | 5' OH | 3' OH |
| --- | --------------- | ---------------------- | ------- | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile12_sub1   | 1478 nt | ATGG  | TGTG  |
| 2   | 5'WT gene block | bsai_5wt_tile17_sub2   | 1279 nt | TGTG  | TCCA  |
| 3   | Oligo pool      | Tile 17 (14280 oligos) | 272 nt  | TCCA  | AGAA  |
| 4   | Helper plasmid  | helper_plasmid_insert  | --      | --    | --    |
| 5   | Enzyme + buffer | BsaI-HFv2 + CutSmart   | --      | --    | --    |

```
  [ATGG]----5'WT sub1----[TGTG]----5'WT sub2----[TCCA]----oligo+BC----[AGAA]
   ATGG                   TGTG                   TCCA                  AGAA 
```

**Set fidelity:** 1.0000 (4 overhangs)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                 | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------- | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)       | --      | --    | --    |
| 2   | 3'WT block        | bsmbi_3wt_tile17_sub1     | 279 nt  | ACAA  | GTGC  |
| 3   | 3'WT block        | bsmbi_3wt_tile1_sub3      | 1606 nt | GTGC  | AAGA  |
| 4   | 3'WT+PolIII block | bsmbi_cassette_tile1_sub4 | 1507 nt | AAGA  | CACC  |
| 5   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1  | --      | --    | --    |

```
  [ACAA]----3'WT sub1----[GTGC]----3'WT sub2----[AAGA]----3'WT+PolIII sub3----[CACC]
   ACAA                   GTGC                   AAGA                          CACC 
```

**Set fidelity:** 1.0000 (4 overhangs)

---

### Tile 18 of 27 -- Codons 980-1025 (138 nt)

**Boundary overhangs:**

| Position          | Sequence | Fidelity |
| ----------------- | -------- | -------- |
| oh1 (5' boundary) | TTCC     | 0.7958   |
| oh2 (3' boundary) | GAAT     | 0.7246   |

**Variants:** 8820 mutations, 8820 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name             | Length  | 5' OH | 3' OH |
| --- | --------------- | --------------------- | ------- | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile12_sub1  | 1478 nt | ATGG  | TGTG  |
| 2   | 5'WT gene block | bsai_5wt_tile18_sub2  | 1495 nt | TGTG  | TTCC  |
| 3   | Oligo pool      | Tile 18 (8820 oligos) | 194 nt  | TTCC  | AGAA  |
| 4   | Helper plasmid  | helper_plasmid_insert | --      | --    | --    |
| 5   | Enzyme + buffer | BsaI-HFv2 + CutSmart  | --      | --    | --    |

```
  [ATGG]----5'WT sub1----[TGTG]----5'WT sub2----[TTCC]----oligo+BC----[AGAA]
   ATGG                   TGTG                   TTCC                  AGAA 
```

**Set fidelity:** 1.0000 (4 overhangs)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                 | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------- | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)       | --      | --    | --    |
| 2   | 3'WT block        | bsmbi_3wt_tile18_sub1     | 141 nt  | GAAT  | GTGC  |
| 3   | 3'WT block        | bsmbi_3wt_tile1_sub3      | 1606 nt | GTGC  | AAGA  |
| 4   | 3'WT+PolIII block | bsmbi_cassette_tile1_sub4 | 1507 nt | AAGA  | CACC  |
| 5   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1  | --      | --    | --    |

```
  [GAAT]----3'WT sub1----[GTGC]----3'WT sub2----[AAGA]----3'WT+PolIII sub3----[CACC]
   GAAT                   GTGC                   AAGA                          CACC 
```

**Set fidelity:** 1.0000 (4 overhangs)

---

### Tile 19 of 27 -- Codons 1026-1066 (123 nt)

**Boundary overhangs:**

| Position          | Sequence | Fidelity |
| ----------------- | -------- | -------- |
| oh1 (5' boundary) | CTAT     | 0.7299   |
| oh2 (3' boundary) | GTGC     | 0.4969   |

**Variants:** 7770 mutations, 7770 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name             | Length  | 5' OH | 3' OH |
| --- | --------------- | --------------------- | ------- | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile12_sub1  | 1478 nt | ATGG  | TGTG  |
| 2   | 5'WT gene block | bsai_5wt_tile19_sub2  | 1633 nt | TGTG  | CTAT  |
| 3   | Oligo pool      | Tile 19 (7770 oligos) | 179 nt  | CTAT  | AGAA  |
| 4   | Helper plasmid  | helper_plasmid_insert | --      | --    | --    |
| 5   | Enzyme + buffer | BsaI-HFv2 + CutSmart  | --      | --    | --    |

```
  [ATGG]----5'WT sub1----[TGTG]----5'WT sub2----[CTAT]----oligo+BC----[AGAA]
   ATGG                   TGTG                   CTAT                  AGAA 
```

**Set fidelity:** 1.0000 (4 overhangs)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                 | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------- | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)       | --      | --    | --    |
| 2   | 3'WT block        | bsmbi_3wt_tile19_sub1     | 375 nt  | GTGC  | TAAA  |
| 3   | 3'WT block        | bsmbi_3wt_tile19_sub2     | 297 nt  | TAAA  | TCAA  |
| 4   | 3'WT block        | bsmbi_3wt_tile19_sub3     | 204 nt  | TCAA  | AAAA  |
| 5   | 3'WT block        | bsmbi_3wt_tile19_sub4     | 784 nt  | AAAA  | AAGA  |
| 6   | 3'WT+PolIII block | bsmbi_cassette_tile1_sub4 | 1507 nt | AAGA  | CACC  |
| 7   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1  | --      | --    | --    |

```
  [GTGC]----3'WT sub1----[TAAA]----3'WT sub2----[TCAA]----3'WT sub3----[AAAA]----3'WT sub4----[AAGA]----3'WT+PolIII sub5----[CACC]
   GTGC                   TAAA                   TCAA                   AAAA                   AAGA                          CACC 
```

**Set fidelity:** 0.9731 (6 overhangs)

---

### Tile 20 of 27 -- Codons 1067-1127 (183 nt)

**Boundary overhangs:**

| Position          | Sequence | Fidelity |
| ----------------- | -------- | -------- |
| oh1 (5' boundary) | CGGG     | 0.5212   |
| oh2 (3' boundary) | AGAT     | 0.6825   |

**Variants:** 11970 mutations, 11970 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name              | Length  | 5' OH | 3' OH |
| --- | --------------- | ---------------------- | ------- | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile12_sub1   | 1478 nt | ATGG  | TGTG  |
| 2   | 5'WT gene block | bsai_5wt_tile20_sub2   | 1756 nt | TGTG  | CGGG  |
| 3   | Oligo pool      | Tile 20 (11970 oligos) | 239 nt  | CGGG  | AGAA  |
| 4   | Helper plasmid  | helper_plasmid_insert  | --      | --    | --    |
| 5   | Enzyme + buffer | BsaI-HFv2 + CutSmart   | --      | --    | --    |

```
  [ATGG]----5'WT sub1----[TGTG]----5'WT sub2----[CGGG]----oligo+BC----[AGAA]
   ATGG                   TGTG                   CGGG                  AGAA 
```

**Set fidelity:** 0.9981 (4 overhangs)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                 | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------- | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)       | --      | --    | --    |
| 2   | 3'WT block        | bsmbi_3wt_tile20_sub1     | 657 nt  | AGAT  | AAAA  |
| 3   | 3'WT block        | bsmbi_3wt_tile20_sub2     | 22 nt   | AAAA  | GAAA  |
| 4   | 3'WT block        | bsmbi_3wt_tile20_sub3     | 787 nt  | GAAA  | AAGA  |
| 5   | 3'WT+PolIII block | bsmbi_cassette_tile1_sub4 | 1507 nt | AAGA  | CACC  |
| 6   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1  | --      | --    | --    |

```
  [AGAT]----3'WT sub1----[AAAA]----3'WT sub2----[GAAA]----3'WT sub3----[AAGA]----3'WT+PolIII sub4----[CACC]
   AGAT                   AAAA                   GAAA                   AAGA                          CACC 
```

**Set fidelity:** 0.9736 (5 overhangs)

---

### Tile 21 of 27 -- Codons 1128-1171 (132 nt)

**Boundary overhangs:**

| Position          | Sequence | Fidelity |
| ----------------- | -------- | -------- |
| oh1 (5' boundary) | TTCC     | 0.7958   |
| oh2 (3' boundary) | TGAA     | 0.8621   |

**Variants:** 8400 mutations, 8400 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name             | Length  | 5' OH | 3' OH |
| --- | --------------- | --------------------- | ------- | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile12_sub1  | 1478 nt | ATGG  | TGTG  |
| 2   | 5'WT gene block | bsai_5wt_tile21_sub2  | 1752 nt | TGTG  | GTGC  |
| 3   | 5'WT gene block | bsai_5wt_tile21_sub3  | 205 nt  | GTGC  | TTCC  |
| 4   | Oligo pool      | Tile 21 (8400 oligos) | 188 nt  | TTCC  | AGAA  |
| 5   | Helper plasmid  | helper_plasmid_insert | --      | --    | --    |
| 6   | Enzyme + buffer | BsaI-HFv2 + CutSmart  | --      | --    | --    |

```
  [ATGG]----5'WT sub1----[TGTG]----5'WT sub2----[GTGC]----5'WT sub3----[TTCC]----oligo+BC----[AGAA]
   ATGG                   TGTG                   GTGC                   TTCC                  AGAA 
```

**Set fidelity:** 1.0000 (5 overhangs)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                 | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------- | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)       | --      | --    | --    |
| 2   | 3'WT block        | bsmbi_3wt_tile21_sub1     | 339 nt  | TGAA  | TCAA  |
| 3   | 3'WT block        | bsmbi_3wt_tile19_sub3     | 204 nt  | TCAA  | AAAA  |
| 4   | 3'WT block        | bsmbi_3wt_tile21_sub3     | 291 nt  | AAAA  | TTAT  |
| 5   | 3'WT block        | bsmbi_3wt_tile21_sub4     | 511 nt  | TTAT  | AAGA  |
| 6   | 3'WT+PolIII block | bsmbi_cassette_tile1_sub4 | 1507 nt | AAGA  | CACC  |
| 7   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1  | --      | --    | --    |

```
  [TGAA]----3'WT sub1----[TCAA]----3'WT sub2----[AAAA]----3'WT sub3----[TTAT]----3'WT sub4----[AAGA]----3'WT+PolIII sub5----[CACC]
   TGAA                   TCAA                   AAAA                   TTAT                   AAGA                          CACC 
```

**Set fidelity:** 0.9905 (6 overhangs)

---

### Tile 22 of 27 -- Codons 1172-1224 (159 nt)

**Boundary overhangs:**

| Position          | Sequence | Fidelity |
| ----------------- | -------- | -------- |
| oh1 (5' boundary) | TTGC     | 0.7336   |
| oh2 (3' boundary) | CTTC     | 0.6384   |

**Variants:** 10290 mutations, 10290 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name              | Length  | 5' OH | 3' OH |
| --- | --------------- | ---------------------- | ------- | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile12_sub1   | 1478 nt | ATGG  | TGTG  |
| 2   | 5'WT gene block | bsai_5wt_tile21_sub2   | 1752 nt | TGTG  | GTGC  |
| 3   | 5'WT gene block | bsai_5wt_tile22_sub3   | 337 nt  | GTGC  | TTGC  |
| 4   | Oligo pool      | Tile 22 (10290 oligos) | 215 nt  | TTGC  | AGAA  |
| 5   | Helper plasmid  | helper_plasmid_insert  | --      | --    | --    |
| 6   | Enzyme + buffer | BsaI-HFv2 + CutSmart   | --      | --    | --    |

```
  [ATGG]----5'WT sub1----[TGTG]----5'WT sub2----[GTGC]----5'WT sub3----[TTGC]----oligo+BC----[AGAA]
   ATGG                   TGTG                   GTGC                   TTGC                  AGAA 
```

**Set fidelity:** 0.9439 (5 overhangs)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                 | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------- | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)       | --      | --    | --    |
| 2   | 3'WT block        | bsmbi_3wt_tile22_sub1     | 366 nt  | CTTC  | AAAA  |
| 3   | 3'WT block        | bsmbi_3wt_tile22_sub2     | 333 nt  | AAAA  | TTTA  |
| 4   | 3'WT block        | bsmbi_3wt_tile22_sub3     | 469 nt  | TTTA  | AAGA  |
| 5   | 3'WT+PolIII block | bsmbi_cassette_tile1_sub4 | 1507 nt | AAGA  | CACC  |
| 6   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1  | --      | --    | --    |

```
  [CTTC]----3'WT sub1----[AAAA]----3'WT sub2----[TTTA]----3'WT sub3----[AAGA]----3'WT+PolIII sub4----[CACC]
   CTTC                   AAAA                   TTTA                   AAGA                          CACC 
```

**Set fidelity:** 0.9904 (5 overhangs)

---

### Tile 23 of 27 -- Codons 1225-1277 (159 nt)

**Boundary overhangs:**

| Position          | Sequence | Fidelity |
| ----------------- | -------- | -------- |
| oh1 (5' boundary) | TCAG     | 0.7814   |
| oh2 (3' boundary) | AAAG     | 0.7511   |

**Variants:** 10290 mutations, 10290 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name              | Length  | 5' OH | 3' OH |
| --- | --------------- | ---------------------- | ------- | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile12_sub1   | 1478 nt | ATGG  | TGTG  |
| 2   | 5'WT gene block | bsai_5wt_tile21_sub2   | 1752 nt | TGTG  | GTGC  |
| 3   | 5'WT gene block | bsai_5wt_tile23_sub3   | 496 nt  | GTGC  | TCAG  |
| 4   | Oligo pool      | Tile 23 (10290 oligos) | 215 nt  | TCAG  | AGAA  |
| 5   | Helper plasmid  | helper_plasmid_insert  | --      | --    | --    |
| 6   | Enzyme + buffer | BsaI-HFv2 + CutSmart   | --      | --    | --    |

```
  [ATGG]----5'WT sub1----[TGTG]----5'WT sub2----[GTGC]----5'WT sub3----[TCAG]----oligo+BC----[AGAA]
   ATGG                   TGTG                   GTGC                   TCAG                  AGAA 
```

**Set fidelity:** 1.0000 (5 overhangs)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                 | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------- | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)       | --      | --    | --    |
| 2   | 3'WT block        | bsmbi_3wt_tile23_sub1     | 522 nt  | AAAG  | TTTA  |
| 3   | 3'WT block        | bsmbi_3wt_tile22_sub3     | 469 nt  | TTTA  | AAGA  |
| 4   | 3'WT+PolIII block | bsmbi_cassette_tile1_sub4 | 1507 nt | AAGA  | CACC  |
| 5   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1  | --      | --    | --    |

```
  [AAAG]----3'WT sub1----[TTTA]----3'WT sub2----[AAGA]----3'WT+PolIII sub3----[CACC]
   AAAG                   TTTA                   AAGA                          CACC 
```

**Set fidelity:** 1.0000 (4 overhangs)

---

### Tile 24 of 27 -- Codons 1278-1354 (231 nt)

**Boundary overhangs:**

| Position          | Sequence | Fidelity |
| ----------------- | -------- | -------- |
| oh1 (5' boundary) | CAAT     | 0.7361   |
| oh2 (3' boundary) | CTTG     | 0.7594   |

**Variants:** 15330 mutations, 15330 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name              | Length  | 5' OH | 3' OH |
| --- | --------------- | ---------------------- | ------- | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile12_sub1   | 1478 nt | ATGG  | TGTG  |
| 2   | 5'WT gene block | bsai_5wt_tile21_sub2   | 1752 nt | TGTG  | GTGC  |
| 3   | 5'WT gene block | bsai_5wt_tile24_sub3   | 655 nt  | GTGC  | CAAT  |
| 4   | Oligo pool      | Tile 24 (15330 oligos) | 287 nt  | CAAT  | AGAA  |
| 5   | Helper plasmid  | helper_plasmid_insert  | --      | --    | --    |
| 6   | Enzyme + buffer | BsaI-HFv2 + CutSmart   | --      | --    | --    |

```
  [ATGG]----5'WT sub1----[TGTG]----5'WT sub2----[GTGC]----5'WT sub3----[CAAT]----oligo+BC----[AGAA]
   ATGG                   TGTG                   GTGC                   CAAT                  AGAA 
```

**Set fidelity:** 1.0000 (5 overhangs)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                 | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------- | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)       | --      | --    | --    |
| 2   | 3'WT block        | bsmbi_3wt_tile24_sub1     | 309 nt  | CTTG  | TAGA  |
| 3   | 3'WT block        | bsmbi_3wt_tile24_sub2     | 451 nt  | TAGA  | AAGA  |
| 4   | 3'WT+PolIII block | bsmbi_cassette_tile1_sub4 | 1507 nt | AAGA  | CACC  |
| 5   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1  | --      | --    | --    |

```
  [CTTG]----3'WT sub1----[TAGA]----3'WT sub2----[AAGA]----3'WT+PolIII sub3----[CACC]
   CTTG                   TAGA                   AAGA                          CACC 
```

**Set fidelity:** 0.9644 (4 overhangs)

---

### Tile 25 of 27 -- Codons 1355-1406 (156 nt)

**Boundary overhangs:**

| Position          | Sequence | Fidelity |
| ----------------- | -------- | -------- |
| oh1 (5' boundary) | AAGT     | 0.7629   |
| oh2 (3' boundary) | ATCG     | 0.5700   |

**Variants:** 10080 mutations, 10080 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name              | Length  | 5' OH | 3' OH |
| --- | --------------- | ---------------------- | ------- | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile12_sub1   | 1478 nt | ATGG  | TGTG  |
| 2   | 5'WT gene block | bsai_5wt_tile21_sub2   | 1752 nt | TGTG  | GTGC  |
| 3   | 5'WT gene block | bsai_5wt_tile25_sub3   | 886 nt  | GTGC  | AAGT  |
| 4   | Oligo pool      | Tile 25 (10080 oligos) | 212 nt  | AAGT  | AGAA  |
| 5   | Helper plasmid  | helper_plasmid_insert  | --      | --    | --    |
| 6   | Enzyme + buffer | BsaI-HFv2 + CutSmart   | --      | --    | --    |

```
  [ATGG]----5'WT sub1----[TGTG]----5'WT sub2----[GTGC]----5'WT sub3----[AAGT]----oligo+BC----[AGAA]
   ATGG                   TGTG                   GTGC                   AAGT                  AGAA 
```

**Set fidelity:** 1.0000 (5 overhangs)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                 | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------- | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)       | --      | --    | --    |
| 2   | 3'WT block        | bsmbi_3wt_tile25_sub1     | 168 nt  | ATCG  | GAAA  |
| 3   | 3'WT block        | bsmbi_3wt_tile25_sub2     | 436 nt  | GAAA  | AAGA  |
| 4   | 3'WT+PolIII block | bsmbi_cassette_tile1_sub4 | 1507 nt | AAGA  | CACC  |
| 5   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1  | --      | --    | --    |

```
  [ATCG]----3'WT sub1----[GAAA]----3'WT sub2----[AAGA]----3'WT+PolIII sub3----[CACC]
   ATCG                   GAAA                   AAGA                          CACC 
```

**Set fidelity:** 1.0000 (4 overhangs)

---

### Tile 26 of 27 -- Codons 1407-1433 (81 nt)

**Boundary overhangs:**

| Position          | Sequence | Fidelity |
| ----------------- | -------- | -------- |
| oh1 (5' boundary) | TCAA     | 0.9425   |
| oh2 (3' boundary) | TAAT     | 0.8165   |

**Variants:** 4830 mutations, 4830 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name             | Length  | 5' OH | 3' OH |
| --- | --------------- | --------------------- | ------- | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile12_sub1  | 1478 nt | ATGG  | TGTG  |
| 2   | 5'WT gene block | bsai_5wt_tile21_sub2  | 1752 nt | TGTG  | GTGC  |
| 3   | 5'WT gene block | bsai_5wt_tile26_sub3  | 1042 nt | GTGC  | TCAA  |
| 4   | Oligo pool      | Tile 26 (4830 oligos) | 137 nt  | TCAA  | AGAA  |
| 5   | Helper plasmid  | helper_plasmid_insert | --      | --    | --    |
| 6   | Enzyme + buffer | BsaI-HFv2 + CutSmart  | --      | --    | --    |

```
  [ATGG]----5'WT sub1----[TGTG]----5'WT sub2----[GTGC]----5'WT sub3----[TCAA]----oligo+BC----[AGAA]
   ATGG                   TGTG                   GTGC                   TCAA                  AGAA 
```

**Set fidelity:** 1.0000 (5 overhangs)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                 | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------- | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)       | --      | --    | --    |
| 2   | 3'WT block        | bsmbi_3wt_tile26_sub1     | 87 nt   | TAAT  | GAAA  |
| 3   | 3'WT block        | bsmbi_3wt_tile25_sub2     | 436 nt  | GAAA  | AAGA  |
| 4   | 3'WT+PolIII block | bsmbi_cassette_tile1_sub4 | 1507 nt | AAGA  | CACC  |
| 5   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1  | --      | --    | --    |

```
  [TAAT]----3'WT sub1----[GAAA]----3'WT sub2----[AAGA]----3'WT+PolIII sub3----[CACC]
   TAAT                   GAAA                   AAGA                          CACC 
```

**Set fidelity:** 1.0000 (4 overhangs)

---

### Tile 27 of 27 -- Codons 1434-1465 (96 nt)

**Boundary overhangs:**

| Position          | Sequence | Fidelity |
| ----------------- | -------- | -------- |
| oh1 (5' boundary) | AATA     | 0.8816   |
| oh2 (3' boundary) | TTAA     | 0.9448   |

**Variants:** 5880 mutations, 5880 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name             | Length  | 5' OH | 3' OH |
| --- | --------------- | --------------------- | ------- | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile12_sub1  | 1478 nt | ATGG  | TGTG  |
| 2   | 5'WT gene block | bsai_5wt_tile21_sub2  | 1752 nt | TGTG  | GTGC  |
| 3   | 5'WT gene block | bsai_5wt_tile27_sub3  | 1123 nt | GTGC  | AATA  |
| 4   | Oligo pool      | Tile 27 (5880 oligos) | 152 nt  | AATA  | AGAA  |
| 5   | Helper plasmid  | helper_plasmid_insert | --      | --    | --    |
| 6   | Enzyme + buffer | BsaI-HFv2 + CutSmart  | --      | --    | --    |

```
  [ATGG]----5'WT sub1----[TGTG]----5'WT sub2----[GTGC]----5'WT sub3----[AATA]----oligo+BC----[AGAA]
   ATGG                   TGTG                   GTGC                   AATA                  AGAA 
```

**Set fidelity:** 1.0000 (5 overhangs)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                  | Length  | 5' OH | 3' OH |
| --- | ----------------- | -------------------------- | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)        | --      | --    | --    |
| 2   | 3'WT block        | bsmbi_cassette_tile27_sub1 | 409 nt  | TTAA  | AAGA  |
| 3   | 3'WT+PolIII block | bsmbi_cassette_tile1_sub4  | 1507 nt | AAGA  | CACC  |
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

**Total blocks:** 68

| Block name                 | Length (nt) | Enzyme type | Gene region                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                              |
| -------------------------- | ----------- | ----------- | -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| bsai_5wt_tile10_sub1       | 1482        | BsaI        | 5wt_tile10_sub1                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                          |
| bsai_5wt_tile11_sub1       | 1629        | BsaI        | 5wt_tile11_sub1                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                          |
| bsai_5wt_tile12_sub1       | 1478        | BsaI        | 5wt_tile12_sub1;5wt_tile13_sub1;5wt_tile14_sub1;5wt_tile15_sub1;5wt_tile16_sub1;5wt_tile17_sub1;5wt_tile18_sub1;5wt_tile19_sub1;5wt_tile20_sub1;5wt_tile21_sub1;5wt_tile22_sub1;5wt_tile23_sub1;5wt_tile24_sub1;5wt_tile25_sub1;5wt_tile26_sub1;5wt_tile27_sub1                                                                                                                                                                                                                                                                                                                                          |
| bsai_5wt_tile12_sub2       | 346         | BsaI        | 5wt_tile12_sub2                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                          |
| bsai_5wt_tile13_sub2       | 568         | BsaI        | 5wt_tile13_sub2                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                          |
| bsai_5wt_tile14_sub2       | 685         | BsaI        | 5wt_tile14_sub2                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                          |
| bsai_5wt_tile15_sub2       | 856         | BsaI        | 5wt_tile15_sub2                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                          |
| bsai_5wt_tile16_sub2       | 1051        | BsaI        | 5wt_tile16_sub2                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                          |
| bsai_5wt_tile17_sub2       | 1279        | BsaI        | 5wt_tile17_sub2                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                          |
| bsai_5wt_tile18_sub2       | 1495        | BsaI        | 5wt_tile18_sub2                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                          |
| bsai_5wt_tile19_sub2       | 1633        | BsaI        | 5wt_tile19_sub2                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                          |
| bsai_5wt_tile2             | 156         | BsaI        | 5wt_tile2                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                |
| bsai_5wt_tile20_sub2       | 1756        | BsaI        | 5wt_tile20_sub2                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                          |
| bsai_5wt_tile21_sub2       | 1752        | BsaI        | 5wt_tile21_sub2;5wt_tile22_sub2;5wt_tile23_sub2;5wt_tile24_sub2;5wt_tile25_sub2;5wt_tile26_sub2;5wt_tile27_sub2                                                                                                                                                                                                                                                                                                                                                                                                                                                                                          |
| bsai_5wt_tile21_sub3       | 205         | BsaI        | 5wt_tile21_sub3                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                          |
| bsai_5wt_tile22_sub3       | 337         | BsaI        | 5wt_tile22_sub3                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                          |
| bsai_5wt_tile23_sub3       | 496         | BsaI        | 5wt_tile23_sub3                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                          |
| bsai_5wt_tile24_sub3       | 655         | BsaI        | 5wt_tile24_sub3                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                          |
| bsai_5wt_tile25_sub3       | 886         | BsaI        | 5wt_tile25_sub3                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                          |
| bsai_5wt_tile26_sub3       | 1042        | BsaI        | 5wt_tile26_sub3                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                          |
| bsai_5wt_tile27_sub3       | 1123        | BsaI        | 5wt_tile27_sub3                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                          |
| bsai_5wt_tile3             | 387         | BsaI        | 5wt_tile3                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                |
| bsai_5wt_tile4             | 555         | BsaI        | 5wt_tile4                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                |
| bsai_5wt_tile5             | 705         | BsaI        | 5wt_tile5                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                |
| bsai_5wt_tile6             | 855         | BsaI        | 5wt_tile6                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                |
| bsai_5wt_tile7             | 1065        | BsaI        | 5wt_tile7                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                |
| bsai_5wt_tile8             | 1224        | BsaI        | 5wt_tile8                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                |
| bsai_5wt_tile9             | 1365        | BsaI        | 5wt_tile9                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                |
| bsmbi_3wt_tile1_sub1       | 1344        | BsmBI       | 3wt_tile1_sub1                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                           |
| bsmbi_3wt_tile1_sub2       | 1752        | BsmBI       | 3wt_tile1_sub2;3wt_tile2_sub2;3wt_tile3_sub2;3wt_tile4_sub2;3wt_tile5_sub2;3wt_tile6_sub2;3wt_tile7_sub2;3wt_tile8_sub2;3wt_tile9_sub1                                                                                                                                                                                                                                                                                                                                                                                                                                                                   |
| bsmbi_3wt_tile1_sub3       | 1606        | BsmBI       | 3wt_tile1_sub3;3wt_tile2_sub3;3wt_tile3_sub3;3wt_tile4_sub3;3wt_tile5_sub3;3wt_tile6_sub3;3wt_tile7_sub3;3wt_tile8_sub3;3wt_tile9_sub2;3wt_tile10_sub2;3wt_tile11_sub2;3wt_tile12_sub2;3wt_tile13_sub2;3wt_tile14_sub2;3wt_tile15_sub2;3wt_tile16_sub2;3wt_tile17_sub2;3wt_tile18_sub2                                                                                                                                                                                                                                                                                                                   |
| bsmbi_3wt_tile10_sub1      | 1605        | BsmBI       | 3wt_tile10_sub1                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                          |
| bsmbi_3wt_tile11_sub1      | 1428        | BsmBI       | 3wt_tile11_sub1                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                          |
| bsmbi_3wt_tile12_sub1      | 1206        | BsmBI       | 3wt_tile12_sub1                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                          |
| bsmbi_3wt_tile13_sub1      | 1089        | BsmBI       | 3wt_tile13_sub1                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                          |
| bsmbi_3wt_tile14_sub1      | 918         | BsmBI       | 3wt_tile14_sub1                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                          |
| bsmbi_3wt_tile15_sub1      | 723         | BsmBI       | 3wt_tile15_sub1                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                          |
| bsmbi_3wt_tile16_sub1      | 495         | BsmBI       | 3wt_tile16_sub1                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                          |
| bsmbi_3wt_tile17_sub1      | 279         | BsmBI       | 3wt_tile17_sub1                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                          |
| bsmbi_3wt_tile18_sub1      | 141         | BsmBI       | 3wt_tile18_sub1                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                          |
| bsmbi_3wt_tile19_sub1      | 375         | BsmBI       | 3wt_tile19_sub1                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                          |
| bsmbi_3wt_tile19_sub2      | 297         | BsmBI       | 3wt_tile19_sub2                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                          |
| bsmbi_3wt_tile19_sub3      | 204         | BsmBI       | 3wt_tile19_sub3;3wt_tile21_sub2                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                          |
| bsmbi_3wt_tile19_sub4      | 784         | BsmBI       | 3wt_tile19_sub4                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                          |
| bsmbi_3wt_tile2_sub1       | 1113        | BsmBI       | 3wt_tile2_sub1                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                           |
| bsmbi_3wt_tile20_sub1      | 657         | BsmBI       | 3wt_tile20_sub1                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                          |
| bsmbi_3wt_tile20_sub2      | 22          | BsmBI       | 3wt_tile20_sub2                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                          |
| bsmbi_3wt_tile20_sub3      | 787         | BsmBI       | 3wt_tile20_sub3                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                          |
| bsmbi_3wt_tile21_sub1      | 339         | BsmBI       | 3wt_tile21_sub1                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                          |
| bsmbi_3wt_tile21_sub3      | 291         | BsmBI       | 3wt_tile21_sub3                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                          |
| bsmbi_3wt_tile21_sub4      | 511         | BsmBI       | 3wt_tile21_sub4                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                          |
| bsmbi_3wt_tile22_sub1      | 366         | BsmBI       | 3wt_tile22_sub1                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                          |
| bsmbi_3wt_tile22_sub2      | 333         | BsmBI       | 3wt_tile22_sub2                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                          |
| bsmbi_3wt_tile22_sub3      | 469         | BsmBI       | 3wt_tile22_sub3;3wt_tile23_sub2                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                          |
| bsmbi_3wt_tile23_sub1      | 522         | BsmBI       | 3wt_tile23_sub1                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                          |
| bsmbi_3wt_tile24_sub1      | 309         | BsmBI       | 3wt_tile24_sub1                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                          |
| bsmbi_3wt_tile24_sub2      | 451         | BsmBI       | 3wt_tile24_sub2                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                          |
| bsmbi_3wt_tile25_sub1      | 168         | BsmBI       | 3wt_tile25_sub1                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                          |
| bsmbi_3wt_tile25_sub2      | 436         | BsmBI       | 3wt_tile25_sub2;3wt_tile26_sub2                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                          |
| bsmbi_3wt_tile26_sub1      | 87          | BsmBI       | 3wt_tile26_sub1                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                          |
| bsmbi_3wt_tile3_sub1       | 945         | BsmBI       | 3wt_tile3_sub1                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                           |
| bsmbi_3wt_tile4_sub1       | 795         | BsmBI       | 3wt_tile4_sub1                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                           |
| bsmbi_3wt_tile5_sub1       | 645         | BsmBI       | 3wt_tile5_sub1                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                           |
| bsmbi_3wt_tile6_sub1       | 435         | BsmBI       | 3wt_tile6_sub1                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                           |
| bsmbi_3wt_tile7_sub1       | 276         | BsmBI       | 3wt_tile7_sub1                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                           |
| bsmbi_3wt_tile8_sub1       | 135         | BsmBI       | 3wt_tile8_sub1                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                           |
| bsmbi_cassette_tile1_sub4  | 1507        | BsmBI       | cassette_tile1_frag1;cassette_tile2_frag1;cassette_tile3_frag1;cassette_tile4_frag1;cassette_tile5_frag1;cassette_tile6_frag1;cassette_tile7_frag1;cassette_tile8_frag1;cassette_tile9_frag1;cassette_tile10_frag1;cassette_tile11_frag1;cassette_tile12_frag1;cassette_tile13_frag1;cassette_tile14_frag1;cassette_tile15_frag1;cassette_tile16_frag1;cassette_tile17_frag1;cassette_tile18_frag1;cassette_tile19_frag1;cassette_tile20_frag1;cassette_tile21_frag1;cassette_tile22_frag1;cassette_tile23_frag1;cassette_tile24_frag1;cassette_tile25_frag1;cassette_tile26_frag1;cassette_tile27_frag2 |
| bsmbi_cassette_tile27_sub1 | 409         | BsmBI       | cassette_tile27_frag1                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                    |

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
| barcodes_per_variant  | 10             |
| boundary_method       | oogga_two_pass |
| multi_k_search        | TRUE           |
| auto_domesticate      | TRUE           |

