# DMS-GG Assembly Report: AKAP11

Generated: 2026-03-12 07:43:55
Pipeline: dms-gg-oligo-pipeline (3-Enzyme Architecture: BsaI + BsmBI + PaqCI)

---

## 1. Gene Summary

| Property             | Value                                                                          |
| -------------------- | ------------------------------------------------------------------------------ |
| Gene name            | AKAP11_NM_016248.4_CDS Homo sapiens A-kinase anchoring protein 11 (AKAP11) CDS |
| CDS length           | 5706 nt (1902 codons)                                                          |
| Protein length       | 1901 aa                                                                        |
| Number of tiles      | 33                                                                             |
| Total variants       | 37506                                                                          |
| Total oligos         | 375060                                                                         |
| Oligo length range   | 146-287 nt                                                                     |
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
[PaqCI**]--[gene+mutation]--[WPRE]--[spacer]--[bGH_polyA]--[PolIII]--[barcode]--[PaqCI*]
```

## 3. Oligo Pool Summary

**Total oligos:** 375060 | **Length range:** 146-287 nt

| Tile | Codons    | Oligos | Length |
| ---- | --------- | ------ | ------ |
| 1    | 1-69      | 13650  | 263 nt |
| 2    | 70-128    | 11550  | 233 nt |
| 3    | 129-188   | 11760  | 236 nt |
| 4    | 189-265   | 15330  | 287 nt |
| 5    | 262-329   | 13440  | 260 nt |
| 6    | 330-393   | 12600  | 248 nt |
| 7    | 394-445   | 10080  | 212 nt |
| 8    | 446-509   | 12600  | 248 nt |
| 9    | 510-582   | 14490  | 275 nt |
| 10   | 583-653   | 14070  | 269 nt |
| 11   | 654-720   | 13230  | 257 nt |
| 12   | 721-774   | 10500  | 218 nt |
| 13   | 775-813   | 7350   | 173 nt |
| 14   | 810-882   | 14490  | 275 nt |
| 15   | 883-946   | 12600  | 248 nt |
| 16   | 947-1012  | 13020  | 254 nt |
| 17   | 1013-1070 | 11340  | 230 nt |
| 18   | 1071-1113 | 8190   | 185 nt |
| 19   | 1114-1150 | 6930   | 167 nt |
| 20   | 1151-1217 | 13230  | 257 nt |
| 21   | 1218-1265 | 9240   | 200 nt |
| 22   | 1266-1313 | 9240   | 200 nt |
| 23   | 1310-1362 | 10290  | 215 nt |
| 24   | 1363-1404 | 7980   | 182 nt |
| 25   | 1405-1437 | 6090   | 155 nt |
| 26   | 1438-1505 | 13440  | 260 nt |
| 27   | 1506-1553 | 9240   | 200 nt |
| 28   | 1554-1626 | 14490  | 275 nt |
| 29   | 1627-1667 | 7770   | 179 nt |
| 30   | 1668-1736 | 13650  | 263 nt |
| 31   | 1737-1811 | 14910  | 281 nt |
| 32   | 1812-1876 | 12810  | 251 nt |
| 33   | 1873-1902 | 5460   | 146 nt |

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
| Total barcodes    | 375060                             |
| Unique barcodes   | 375060                             |
| GC content range  | 25% - 75%                          |
| GC content mean   | 48.2%                              |
| Hamming guarantee | 100% cross-variant (prefix d >= 3) |

## 5. QC Summary

**Overall:** ISSUES FOUND

| Check                  | Description                                                   | Result | Detail                                                                                                                                                |
| ---------------------- | ------------------------------------------------------------- | ------ | ----------------------------------------------------------------------------------------------------------------------------------------------------- |
| oligo_lengths          | All oligos within synthesis length limit                      | PASS   | Range: 146-287 nt (limit: 300)                                                                                                                        |
| block_lengths          | All gene blocks within synthesis length limit                 | PASS   | Range: 162-1795 nt (limit: 1800)                                                                                                                      |
| barcode_junction_sites | No enzyme sites at barcode-context junctions                  | PASS   | 0 barcode(s) with junction enzyme sites (left='CACACC', right='AGAATG')                                                                               |
| barcode_uniqueness     | All barcodes are unique                                       | PASS   | 375060 unique / 375060 total                                                                                                                          |
| tile_coverage          | Tiles cover entire gene without gaps                          | PASS   | 5706 / 5706 nt covered                                                                                                                                |
| variant_count          | Expected number of variants generated                         | PASS   | 37506 unique variants (expected: 37506 across 1786/1900 mutable positions; 33934 missense + 1786 nonsense + 1786 wt_control; 114 position(s) skipped) |
| single_codon_change    | Each non-control variant differs by exactly one codon from WT | PASS   | 357200 / 357200 variants confirmed (WT controls excluded)                                                                                             |
| oligo_gc_content       | Oligo GC content within reasonable range (25-75%)             | PASS   | GC range: 30.5-53.6% | 0 oligo(s) with extreme GC                                                                                                     |
| domestication_complete | Gene domesticated for all 3 enzymes (BsaI, BsmBI, PaqCI)      | PASS   | No enzyme sites in gene                                                                                                                               |
| overhang_fidelity      | Tile boundary overhangs have adequate fidelity                | FAIL   | 27 tile(s) with low-fidelity boundary overhangs (<0.80)                                                                                               |
| tile_manifests         | Per-tile assembly manifests complete                          | PASS   | 33 tile manifest(s) generated                                                                                                                         |
| helper_plasmid         | Helper plasmid free of unintended BsmBI sites                 | PASS   | OK                                                                                                                                                    |
| reaction_fidelity      | Per-reaction set-level overhang fidelity                      | PASS   | Min set fidelity: 0.8382 across 66 reactions | 2 reaction(s) below 0.90                                                                               |
| barcode_poliii_term    | No barcodes contain PolIII terminator signal (TTTT)           | PASS   | 0 / 375060 barcode(s) contain TTTT                                                                                                                    |
| block_min_length       | All gene blocks above synthesis minimum length                | FAIL   | 5 block(s) below 300 nt minimum. Range: 162-1795 nt                                                                                                   |
| sb_overhang_collisions | Superblock boundary overhangs are unique (no collisions)      | PASS   | 4 SB boundary OH(s), all unique                                                                                                                       |
| gene_reconstruct       | Gene reconstruction from tiles matches original CDS           | PASS   | All 4 SB junction OH(s) match gene sequence; reconstructed gene (5706 nt) matches CDS                                                                 |

## 5b. Reaction Fidelity Summary

Set fidelity for each tile's BsaI and BsmBI reactions,
computed from the actual block overhangs after construction:

| Tile | BsaI OHs | BsaI Set Fidelity | BsmBI OHs | BsmBI Set Fidelity |
| ---- | -------- | ----------------- | --------- | ------------------ |
| 1    | 2        | 1.0000            | 6         | 0.9957             |
| 2    | 3        | 1.0000            | 6         | 1.0000             |
| 3    | 3        | 1.0000            | 6         | 1.0000             |
| 4    | 3        | 1.0000            | 5         | 1.0000             |
| 5    | 3        | 1.0000            | 5         | 1.0000             |
| 6    | 3        | 1.0000            | 5         | 0.9018             |
| 7    | 4        | 1.0000            | 5         | 1.0000             |
| 8    | 4        | 1.0000            | 5         | 1.0000             |
| 9    | 4        | 1.0000            | 5         | 1.0000             |
| 10   | 4        | 1.0000            | 5         | 0.9985             |
| 11   | 4        | 1.0000            | 5         | 0.9010             |
| 12   | 4        | 1.0000            | 4         | 0.9986             |
| 13   | 4        | 0.9175            | 4         | 1.0000             |
| 14   | 4        | 0.9712            | 4         | 0.9985             |
| 15   | 5        | 0.9376            | 4         | 0.9988             |
| 16   | 5        | 1.0000            | 4         | 0.9779             |
| 17   | 5        | 1.0000            | 4         | 1.0000             |
| 18   | 5        | 1.0000            | 4         | 0.9961             |
| 19   | 5        | 0.8382            | 4         | 0.9883             |
| 20   | 5        | 0.9778            | 4         | 1.0000             |
| 21   | 5        | 1.0000            | 4         | 1.0000             |
| 22   | 5        | 0.9132            | 3         | 1.0000             |
| 23   | 5        | 1.0000            | 3         | 0.9553             |
| 24   | 5        | 0.9947            | 3         | 1.0000             |
| 25   | 5        | 0.9907            | 3         | 0.9985             |
| 26   | 6        | 0.9986            | 3         | 1.0000             |
| 27   | 6        | 0.8382            | 3         | 1.0000             |
| 28   | 6        | 1.0000            | 3         | 1.0000             |
| 29   | 6        | 1.0000            | 3         | 1.0000             |
| 30   | 6        | 0.9712            | 3         | 1.0000             |
| 31   | 6        | 1.0000            | 2         | 1.0000             |
| 32   | 6        | 1.0000            | 2         | 1.0000             |
| 33   | 6        | 1.0000            | 2         | 1.0000             |

**Min:** 0.8382 | **Max:** 1.0000 | **Mean:** 0.9857

**Warning:** 2 reaction(s) below 0.90 fidelity — consider alternative split points or overhang reassignment.
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

### Tile 1 of 33 -- Codons 1-69 (207 nt)

**Boundary overhangs:**

| Position          | Sequence | Fidelity |
| ----------------- | -------- | -------- |
| oh1 (5' boundary) | ATGG     | 0.5393   |
| oh2 (3' boundary) | GGAT     | 0.5385   |

**Variants:** 13650 mutations, 13650 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name                          | Length | 5' OH | 3' OH |
| --- | --------------- | ---------------------------------- | ------ | ----- | ----- |
| 1   | 5'WT gene block | (none -- tile starts at gene nt 1) | --     | --    | --    |
| 2   | Oligo pool      | Tile 1 (13650 oligos)              | 263 nt | ATGG  | AGAA  |
| 3   | Helper plasmid  | helper_plasmid_insert              | --     | --    | --    |
| 4   | Enzyme + buffer | BsaI-HFv2 + CutSmart               | --     | --    | --    |

```
  [ATGG]----oligo+BC----[AGAA]
   ATGG                  AGAA 
```

**Set fidelity:** 1.0000 (2 overhangs)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------ | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)      | --      | --    | --    |
| 2   | 3'WT block        | bsmbi_3wt_tile1_sub1     | 606 nt  | GGAT  | GAAA  |
| 3   | 3'WT block        | bsmbi_3wt_tile1_sub2     | 1662 nt | GAAA  | AAAT  |
| 4   | 3'WT block        | bsmbi_3wt_tile1_sub3     | 1518 nt | AAAT  | AAGA  |
| 5   | 3'WT block        | bsmbi_3wt_tile1_sub4     | 1707 nt | AAGA  | TCAA  |
| 6   | 3'WT+PolIII block | bsmbi_3wt_tile1_sub5     | 1190 nt | TCAA  | CACC  |
| 7   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1 | --      | --    | --    |

```
  [GGAT]----3'WT sub1----[GAAA]----3'WT sub2----[AAAT]----3'WT sub3----[AAGA]----3'WT sub4----[TCAA]----3'WT+PolIII sub5----[CACC]
   GGAT                   GAAA                   AAAT                   AAGA                   TCAA                          CACC 
```

**Set fidelity:** 0.9957 (6 overhangs)

---

### Tile 2 of 33 -- Codons 70-128 (177 nt)

**Boundary overhangs:**

| Position          | Sequence | Fidelity |
| ----------------- | -------- | -------- |
| oh1 (5' boundary) | CATA     | 0.7540   |
| oh2 (3' boundary) | TACA     | 0.8652   |

**Variants:** 11550 mutations, 11550 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name             | Length | 5' OH | 3' OH |
| --- | --------------- | --------------------- | ------ | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile2        | 225 nt | ATGG  | CATA  |
| 2   | Oligo pool      | Tile 2 (11550 oligos) | 233 nt | CATA  | AGAA  |
| 3   | Helper plasmid  | helper_plasmid_insert | --     | --    | --    |
| 4   | Enzyme + buffer | BsaI-HFv2 + CutSmart  | --     | --    | --    |

```
  [ATGG]----5'WT block----[CATA]----oligo+BC----[AGAA]
   ATGG                    CATA                  AGAA 
```

**Set fidelity:** 1.0000 (3 overhangs)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------ | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)      | --      | --    | --    |
| 2   | 3'WT block        | bsmbi_3wt_tile2_sub1     | 429 nt  | TACA  | GAAA  |
| 3   | 3'WT block        | bsmbi_3wt_tile1_sub2     | 1662 nt | GAAA  | AAAT  |
| 4   | 3'WT block        | bsmbi_3wt_tile1_sub3     | 1518 nt | AAAT  | AAGA  |
| 5   | 3'WT block        | bsmbi_3wt_tile1_sub4     | 1707 nt | AAGA  | TCAA  |
| 6   | 3'WT+PolIII block | bsmbi_3wt_tile1_sub5     | 1190 nt | TCAA  | CACC  |
| 7   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1 | --      | --    | --    |

```
  [TACA]----3'WT sub1----[GAAA]----3'WT sub2----[AAAT]----3'WT sub3----[AAGA]----3'WT sub4----[TCAA]----3'WT+PolIII sub5----[CACC]
   TACA                   GAAA                   AAAT                   AAGA                   TCAA                          CACC 
```

**Set fidelity:** 1.0000 (6 overhangs)

---

### Tile 3 of 33 -- Codons 129-188 (180 nt)

**Boundary overhangs:**

| Position          | Sequence | Fidelity |
| ----------------- | -------- | -------- |
| oh1 (5' boundary) | GTGT     | 0.5081   |
| oh2 (3' boundary) | TGAG     | 0.6546   |

**Variants:** 11760 mutations, 11760 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name             | Length | 5' OH | 3' OH |
| --- | --------------- | --------------------- | ------ | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile3        | 402 nt | ATGG  | GTGT  |
| 2   | Oligo pool      | Tile 3 (11760 oligos) | 236 nt | GTGT  | AGAA  |
| 3   | Helper plasmid  | helper_plasmid_insert | --     | --    | --    |
| 4   | Enzyme + buffer | BsaI-HFv2 + CutSmart  | --     | --    | --    |

```
  [ATGG]----5'WT block----[GTGT]----oligo+BC----[AGAA]
   ATGG                    GTGT                  AGAA 
```

**Set fidelity:** 1.0000 (3 overhangs)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------ | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)      | --      | --    | --    |
| 2   | 3'WT block        | bsmbi_3wt_tile3_sub1     | 249 nt  | TGAG  | GAAA  |
| 3   | 3'WT block        | bsmbi_3wt_tile1_sub2     | 1662 nt | GAAA  | AAAT  |
| 4   | 3'WT block        | bsmbi_3wt_tile1_sub3     | 1518 nt | AAAT  | AAGA  |
| 5   | 3'WT block        | bsmbi_3wt_tile1_sub4     | 1707 nt | AAGA  | TCAA  |
| 6   | 3'WT+PolIII block | bsmbi_3wt_tile1_sub5     | 1190 nt | TCAA  | CACC  |
| 7   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1 | --      | --    | --    |

```
  [TGAG]----3'WT sub1----[GAAA]----3'WT sub2----[AAAT]----3'WT sub3----[AAGA]----3'WT sub4----[TCAA]----3'WT+PolIII sub5----[CACC]
   TGAG                   GAAA                   AAAT                   AAGA                   TCAA                          CACC 
```

**Set fidelity:** 1.0000 (6 overhangs)

---

### Tile 4 of 33 -- Codons 189-265 (231 nt)

**Boundary overhangs:**

| Position          | Sequence | Fidelity |
| ----------------- | -------- | -------- |
| oh1 (5' boundary) | ACTG     | 0.5529   |
| oh2 (3' boundary) | GAAA     | 0.8745   |

**Variants:** 15330 mutations, 15330 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name             | Length | 5' OH | 3' OH |
| --- | --------------- | --------------------- | ------ | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile4        | 582 nt | ATGG  | ACTG  |
| 2   | Oligo pool      | Tile 4 (15330 oligos) | 287 nt | ACTG  | AGAA  |
| 3   | Helper plasmid  | helper_plasmid_insert | --     | --    | --    |
| 4   | Enzyme + buffer | BsaI-HFv2 + CutSmart  | --     | --    | --    |

```
  [ATGG]----5'WT block----[ACTG]----oligo+BC----[AGAA]
   ATGG                    ACTG                  AGAA 
```

**Set fidelity:** 1.0000 (3 overhangs)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------ | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)      | --      | --    | --    |
| 2   | 3'WT block        | bsmbi_3wt_tile1_sub2     | 1662 nt | GAAA  | AAAT  |
| 3   | 3'WT block        | bsmbi_3wt_tile1_sub3     | 1518 nt | AAAT  | AAGA  |
| 4   | 3'WT block        | bsmbi_3wt_tile1_sub4     | 1707 nt | AAGA  | TCAA  |
| 5   | 3'WT+PolIII block | bsmbi_3wt_tile1_sub5     | 1190 nt | TCAA  | CACC  |
| 6   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1 | --      | --    | --    |

```
  [GAAA]----3'WT sub1----[AAAT]----3'WT sub2----[AAGA]----3'WT sub3----[TCAA]----3'WT+PolIII sub4----[CACC]
   GAAA                   AAAT                   AAGA                   TCAA                          CACC 
```

**Set fidelity:** 1.0000 (5 overhangs)

---

### Tile 5 of 33 -- Codons 262-329 (204 nt)

**Boundary overhangs:**

| Position          | Sequence | Fidelity |
| ----------------- | -------- | -------- |
| oh1 (5' boundary) | CCTT     | 0.6891   |
| oh2 (3' boundary) | ACTT     | 0.7315   |

**Variants:** 13440 mutations, 13440 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name             | Length | 5' OH | 3' OH |
| --- | --------------- | --------------------- | ------ | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile5        | 801 nt | ATGG  | CCTT  |
| 2   | Oligo pool      | Tile 5 (13440 oligos) | 260 nt | CCTT  | AGAA  |
| 3   | Helper plasmid  | helper_plasmid_insert | --     | --    | --    |
| 4   | Enzyme + buffer | BsaI-HFv2 + CutSmart  | --     | --    | --    |

```
  [ATGG]----5'WT block----[CCTT]----oligo+BC----[AGAA]
   ATGG                    CCTT                  AGAA 
```

**Set fidelity:** 1.0000 (3 overhangs)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------ | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)      | --      | --    | --    |
| 2   | 3'WT block        | bsmbi_3wt_tile5_sub1     | 1470 nt | ACTT  | AAAT  |
| 3   | 3'WT block        | bsmbi_3wt_tile1_sub3     | 1518 nt | AAAT  | AAGA  |
| 4   | 3'WT block        | bsmbi_3wt_tile1_sub4     | 1707 nt | AAGA  | TCAA  |
| 5   | 3'WT+PolIII block | bsmbi_3wt_tile1_sub5     | 1190 nt | TCAA  | CACC  |
| 6   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1 | --      | --    | --    |

```
  [ACTT]----3'WT sub1----[AAAT]----3'WT sub2----[AAGA]----3'WT sub3----[TCAA]----3'WT+PolIII sub4----[CACC]
   ACTT                   AAAT                   AAGA                   TCAA                          CACC 
```

**Set fidelity:** 1.0000 (5 overhangs)

---

### Tile 6 of 33 -- Codons 330-393 (192 nt)

**Boundary overhangs:**

| Position          | Sequence | Fidelity |
| ----------------- | -------- | -------- |
| oh1 (5' boundary) | AAAG     | 0.7511   |
| oh2 (3' boundary) | GAAT     | 0.7246   |

**Variants:** 12600 mutations, 12600 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name             | Length  | 5' OH | 3' OH |
| --- | --------------- | --------------------- | ------- | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile6_sub1   | 1005 nt | ATGG  | AAAG  |
| 2   | Oligo pool      | Tile 6 (12600 oligos) | 248 nt  | AAAG  | AGAA  |
| 3   | Helper plasmid  | helper_plasmid_insert | --      | --    | --    |
| 4   | Enzyme + buffer | BsaI-HFv2 + CutSmart  | --      | --    | --    |

```
  [ATGG]----5'WT block----[AAAG]----oligo+BC----[AGAA]
   ATGG                    AAAG                  AGAA 
```

**Set fidelity:** 1.0000 (3 overhangs)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------ | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)      | --      | --    | --    |
| 2   | 3'WT block        | bsmbi_3wt_tile6_sub1     | 1278 nt | GAAT  | AAAT  |
| 3   | 3'WT block        | bsmbi_3wt_tile1_sub3     | 1518 nt | AAAT  | AAGA  |
| 4   | 3'WT block        | bsmbi_3wt_tile1_sub4     | 1707 nt | AAGA  | TCAA  |
| 5   | 3'WT+PolIII block | bsmbi_3wt_tile1_sub5     | 1190 nt | TCAA  | CACC  |
| 6   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1 | --      | --    | --    |

```
  [GAAT]----3'WT sub1----[AAAT]----3'WT sub2----[AAGA]----3'WT sub3----[TCAA]----3'WT+PolIII sub4----[CACC]
   GAAT                   AAAT                   AAGA                   TCAA                          CACC 
```

**Set fidelity:** 0.9018 (5 overhangs)

---

### Tile 7 of 33 -- Codons 394-445 (156 nt)

**Boundary overhangs:**

| Position          | Sequence | Fidelity |
| ----------------- | -------- | -------- |
| oh1 (5' boundary) | TCAT     | 0.8102   |
| oh2 (3' boundary) | TCCT     | 0.7573   |

**Variants:** 10080 mutations, 10080 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name             | Length | 5' OH | 3' OH |
| --- | --------------- | --------------------- | ------ | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile7_sub1   | 809 nt | ATGG  | GAAA  |
| 2   | 5'WT gene block | bsai_5wt_tile7_sub2   | 406 nt | GAAA  | TCAT  |
| 3   | Oligo pool      | Tile 7 (10080 oligos) | 212 nt | TCAT  | AGAA  |
| 4   | Helper plasmid  | helper_plasmid_insert | --     | --    | --    |
| 5   | Enzyme + buffer | BsaI-HFv2 + CutSmart  | --     | --    | --    |

```
  [ATGG]----5'WT sub1----[GAAA]----5'WT sub2----[TCAT]----oligo+BC----[AGAA]
   ATGG                   GAAA                   TCAT                  AGAA 
```

**Set fidelity:** 1.0000 (4 overhangs)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------ | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)      | --      | --    | --    |
| 2   | 3'WT block        | bsmbi_3wt_tile7_sub1     | 1122 nt | TCCT  | AAAT  |
| 3   | 3'WT block        | bsmbi_3wt_tile1_sub3     | 1518 nt | AAAT  | AAGA  |
| 4   | 3'WT block        | bsmbi_3wt_tile1_sub4     | 1707 nt | AAGA  | TCAA  |
| 5   | 3'WT+PolIII block | bsmbi_3wt_tile1_sub5     | 1190 nt | TCAA  | CACC  |
| 6   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1 | --      | --    | --    |

```
  [TCCT]----3'WT sub1----[AAAT]----3'WT sub2----[AAGA]----3'WT sub3----[TCAA]----3'WT+PolIII sub4----[CACC]
   TCCT                   AAAT                   AAGA                   TCAA                          CACC 
```

**Set fidelity:** 1.0000 (5 overhangs)

---

### Tile 8 of 33 -- Codons 446-509 (192 nt)

**Boundary overhangs:**

| Position          | Sequence | Fidelity |
| ----------------- | -------- | -------- |
| oh1 (5' boundary) | TTAT     | 0.8673   |
| oh2 (3' boundary) | ATCA     | 0.7483   |

**Variants:** 12600 mutations, 12600 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name             | Length | 5' OH | 3' OH |
| --- | --------------- | --------------------- | ------ | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile7_sub1   | 809 nt | ATGG  | GAAA  |
| 2   | 5'WT gene block | bsai_5wt_tile8_sub2   | 562 nt | GAAA  | TTAT  |
| 3   | Oligo pool      | Tile 8 (12600 oligos) | 248 nt | TTAT  | AGAA  |
| 4   | Helper plasmid  | helper_plasmid_insert | --     | --    | --    |
| 5   | Enzyme + buffer | BsaI-HFv2 + CutSmart  | --     | --    | --    |

```
  [ATGG]----5'WT sub1----[GAAA]----5'WT sub2----[TTAT]----oligo+BC----[AGAA]
   ATGG                   GAAA                   TTAT                  AGAA 
```

**Set fidelity:** 1.0000 (4 overhangs)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------ | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)      | --      | --    | --    |
| 2   | 3'WT block        | bsmbi_3wt_tile8_sub1     | 930 nt  | ATCA  | AAAT  |
| 3   | 3'WT block        | bsmbi_3wt_tile1_sub3     | 1518 nt | AAAT  | AAGA  |
| 4   | 3'WT block        | bsmbi_3wt_tile1_sub4     | 1707 nt | AAGA  | TCAA  |
| 5   | 3'WT+PolIII block | bsmbi_3wt_tile1_sub5     | 1190 nt | TCAA  | CACC  |
| 6   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1 | --      | --    | --    |

```
  [ATCA]----3'WT sub1----[AAAT]----3'WT sub2----[AAGA]----3'WT sub3----[TCAA]----3'WT+PolIII sub4----[CACC]
   ATCA                   AAAT                   AAGA                   TCAA                          CACC 
```

**Set fidelity:** 1.0000 (5 overhangs)

---

### Tile 9 of 33 -- Codons 510-582 (219 nt)

**Boundary overhangs:**

| Position          | Sequence | Fidelity |
| ----------------- | -------- | -------- |
| oh1 (5' boundary) | AATA     | 0.8816   |
| oh2 (3' boundary) | CAAA     | 0.8948   |

**Variants:** 14490 mutations, 14490 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name             | Length | 5' OH | 3' OH |
| --- | --------------- | --------------------- | ------ | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile7_sub1   | 809 nt | ATGG  | GAAA  |
| 2   | 5'WT gene block | bsai_5wt_tile9_sub2   | 754 nt | GAAA  | AATA  |
| 3   | Oligo pool      | Tile 9 (14490 oligos) | 275 nt | AATA  | AGAA  |
| 4   | Helper plasmid  | helper_plasmid_insert | --     | --    | --    |
| 5   | Enzyme + buffer | BsaI-HFv2 + CutSmart  | --     | --    | --    |

```
  [ATGG]----5'WT sub1----[GAAA]----5'WT sub2----[AATA]----oligo+BC----[AGAA]
   ATGG                   GAAA                   AATA                  AGAA 
```

**Set fidelity:** 1.0000 (4 overhangs)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------ | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)      | --      | --    | --    |
| 2   | 3'WT block        | bsmbi_3wt_tile9_sub1     | 711 nt  | CAAA  | AAAT  |
| 3   | 3'WT block        | bsmbi_3wt_tile1_sub3     | 1518 nt | AAAT  | AAGA  |
| 4   | 3'WT block        | bsmbi_3wt_tile1_sub4     | 1707 nt | AAGA  | TCAA  |
| 5   | 3'WT+PolIII block | bsmbi_3wt_tile1_sub5     | 1190 nt | TCAA  | CACC  |
| 6   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1 | --      | --    | --    |

```
  [CAAA]----3'WT sub1----[AAAT]----3'WT sub2----[AAGA]----3'WT sub3----[TCAA]----3'WT+PolIII sub4----[CACC]
   CAAA                   AAAT                   AAGA                   TCAA                          CACC 
```

**Set fidelity:** 1.0000 (5 overhangs)

---

### Tile 10 of 33 -- Codons 583-653 (213 nt)

**Boundary overhangs:**

| Position          | Sequence | Fidelity |
| ----------------- | -------- | -------- |
| oh1 (5' boundary) | TTAG     | 0.8480   |
| oh2 (3' boundary) | TGAA     | 0.8621   |

**Variants:** 14070 mutations, 14070 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name              | Length | 5' OH | 3' OH |
| --- | --------------- | ---------------------- | ------ | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile7_sub1    | 809 nt | ATGG  | GAAA  |
| 2   | 5'WT gene block | bsai_5wt_tile10_sub2   | 973 nt | GAAA  | TTAG  |
| 3   | Oligo pool      | Tile 10 (14070 oligos) | 269 nt | TTAG  | AGAA  |
| 4   | Helper plasmid  | helper_plasmid_insert  | --     | --    | --    |
| 5   | Enzyme + buffer | BsaI-HFv2 + CutSmart   | --     | --    | --    |

```
  [ATGG]----5'WT sub1----[GAAA]----5'WT sub2----[TTAG]----oligo+BC----[AGAA]
   ATGG                   GAAA                   TTAG                  AGAA 
```

**Set fidelity:** 1.0000 (4 overhangs)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------ | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)      | --      | --    | --    |
| 2   | 3'WT block        | bsmbi_3wt_tile10_sub1    | 498 nt  | TGAA  | AAAT  |
| 3   | 3'WT block        | bsmbi_3wt_tile1_sub3     | 1518 nt | AAAT  | AAGA  |
| 4   | 3'WT block        | bsmbi_3wt_tile1_sub4     | 1707 nt | AAGA  | TCAA  |
| 5   | 3'WT+PolIII block | bsmbi_3wt_tile1_sub5     | 1190 nt | TCAA  | CACC  |
| 6   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1 | --      | --    | --    |

```
  [TGAA]----3'WT sub1----[AAAT]----3'WT sub2----[AAGA]----3'WT sub3----[TCAA]----3'WT+PolIII sub4----[CACC]
   TGAA                   AAAT                   AAGA                   TCAA                          CACC 
```

**Set fidelity:** 0.9985 (5 overhangs)

---

### Tile 11 of 33 -- Codons 654-720 (201 nt)

**Boundary overhangs:**

| Position          | Sequence | Fidelity |
| ----------------- | -------- | -------- |
| oh1 (5' boundary) | CTTG     | 0.7594   |
| oh2 (3' boundary) | TAAT     | 0.8165   |

**Variants:** 13230 mutations, 13230 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name              | Length  | 5' OH | 3' OH |
| --- | --------------- | ---------------------- | ------- | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile7_sub1    | 809 nt  | ATGG  | GAAA  |
| 2   | 5'WT gene block | bsai_5wt_tile11_sub2   | 1186 nt | GAAA  | CTTG  |
| 3   | Oligo pool      | Tile 11 (13230 oligos) | 257 nt  | CTTG  | AGAA  |
| 4   | Helper plasmid  | helper_plasmid_insert  | --      | --    | --    |
| 5   | Enzyme + buffer | BsaI-HFv2 + CutSmart   | --      | --    | --    |

```
  [ATGG]----5'WT sub1----[GAAA]----5'WT sub2----[CTTG]----oligo+BC----[AGAA]
   ATGG                   GAAA                   CTTG                  AGAA 
```

**Set fidelity:** 1.0000 (4 overhangs)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------ | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)      | --      | --    | --    |
| 2   | 3'WT block        | bsmbi_3wt_tile11_sub1    | 297 nt  | TAAT  | AAAT  |
| 3   | 3'WT block        | bsmbi_3wt_tile1_sub3     | 1518 nt | AAAT  | AAGA  |
| 4   | 3'WT block        | bsmbi_3wt_tile1_sub4     | 1707 nt | AAGA  | TCAA  |
| 5   | 3'WT+PolIII block | bsmbi_3wt_tile1_sub5     | 1190 nt | TCAA  | CACC  |
| 6   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1 | --      | --    | --    |

```
  [TAAT]----3'WT sub1----[AAAT]----3'WT sub2----[AAGA]----3'WT sub3----[TCAA]----3'WT+PolIII sub4----[CACC]
   TAAT                   AAAT                   AAGA                   TCAA                          CACC 
```

**Set fidelity:** 0.9010 (5 overhangs)

---

### Tile 12 of 33 -- Codons 721-774 (162 nt)

**Boundary overhangs:**

| Position          | Sequence | Fidelity |
| ----------------- | -------- | -------- |
| oh1 (5' boundary) | TCTA     | 0.8892   |
| oh2 (3' boundary) | TACT     | 0.7445   |

**Variants:** 10500 mutations, 10500 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name              | Length  | 5' OH | 3' OH |
| --- | --------------- | ---------------------- | ------- | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile7_sub1    | 809 nt  | ATGG  | GAAA  |
| 2   | 5'WT gene block | bsai_5wt_tile12_sub2   | 1387 nt | GAAA  | TCTA  |
| 3   | Oligo pool      | Tile 12 (10500 oligos) | 218 nt  | TCTA  | AGAA  |
| 4   | Helper plasmid  | helper_plasmid_insert  | --      | --    | --    |
| 5   | Enzyme + buffer | BsaI-HFv2 + CutSmart   | --      | --    | --    |

```
  [ATGG]----5'WT sub1----[GAAA]----5'WT sub2----[TCTA]----oligo+BC----[AGAA]
   ATGG                   GAAA                   TCTA                  AGAA 
```

**Set fidelity:** 1.0000 (4 overhangs)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------ | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)      | --      | --    | --    |
| 2   | 3'WT block        | bsmbi_3wt_tile12_sub1    | 1635 nt | TACT  | AAGA  |
| 3   | 3'WT block        | bsmbi_3wt_tile1_sub4     | 1707 nt | AAGA  | TCAA  |
| 4   | 3'WT+PolIII block | bsmbi_3wt_tile1_sub5     | 1190 nt | TCAA  | CACC  |
| 5   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1 | --      | --    | --    |

```
  [TACT]----3'WT sub1----[AAGA]----3'WT sub2----[TCAA]----3'WT+PolIII sub3----[CACC]
   TACT                   AAGA                   TCAA                          CACC 
```

**Set fidelity:** 0.9986 (4 overhangs)

---

### Tile 13 of 33 -- Codons 775-813 (117 nt)

**Boundary overhangs:**

| Position          | Sequence | Fidelity |
| ----------------- | -------- | -------- |
| oh1 (5' boundary) | GGAA     | 0.7463   |
| oh2 (3' boundary) | AAAT     | 0.7737   |

**Variants:** 7350 mutations, 7350 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name             | Length  | 5' OH | 3' OH |
| --- | --------------- | --------------------- | ------- | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile7_sub1   | 809 nt  | ATGG  | GAAA  |
| 2   | 5'WT gene block | bsai_5wt_tile13_sub2  | 1549 nt | GAAA  | GGAA  |
| 3   | Oligo pool      | Tile 13 (7350 oligos) | 173 nt  | GGAA  | AGAA  |
| 4   | Helper plasmid  | helper_plasmid_insert | --      | --    | --    |
| 5   | Enzyme + buffer | BsaI-HFv2 + CutSmart  | --      | --    | --    |

```
  [ATGG]----5'WT sub1----[GAAA]----5'WT sub2----[GGAA]----oligo+BC----[AGAA]
   ATGG                   GAAA                   GGAA                  AGAA 
```

**Set fidelity:** 0.9175 (4 overhangs)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------ | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)      | --      | --    | --    |
| 2   | 3'WT block        | bsmbi_3wt_tile1_sub3     | 1518 nt | AAAT  | AAGA  |
| 3   | 3'WT block        | bsmbi_3wt_tile1_sub4     | 1707 nt | AAGA  | TCAA  |
| 4   | 3'WT+PolIII block | bsmbi_3wt_tile1_sub5     | 1190 nt | TCAA  | CACC  |
| 5   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1 | --      | --    | --    |

```
  [AAAT]----3'WT sub1----[AAGA]----3'WT sub2----[TCAA]----3'WT+PolIII sub3----[CACC]
   AAAT                   AAGA                   TCAA                          CACC 
```

**Set fidelity:** 1.0000 (4 overhangs)

---

### Tile 14 of 33 -- Codons 810-882 (219 nt)

**Boundary overhangs:**

| Position          | Sequence | Fidelity |
| ----------------- | -------- | -------- |
| oh1 (5' boundary) | AGTA     | 0.7286   |
| oh2 (3' boundary) | TGAA     | 0.8621   |

**Variants:** 14490 mutations, 14490 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name              | Length  | 5' OH | 3' OH |
| --- | --------------- | ---------------------- | ------- | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile7_sub1    | 809 nt  | ATGG  | GAAA  |
| 2   | 5'WT gene block | bsai_5wt_tile14_sub2   | 1654 nt | GAAA  | AGTA  |
| 3   | Oligo pool      | Tile 14 (14490 oligos) | 275 nt  | AGTA  | AGAA  |
| 4   | Helper plasmid  | helper_plasmid_insert  | --      | --    | --    |
| 5   | Enzyme + buffer | BsaI-HFv2 + CutSmart   | --      | --    | --    |

```
  [ATGG]----5'WT sub1----[GAAA]----5'WT sub2----[AGTA]----oligo+BC----[AGAA]
   ATGG                   GAAA                   AGTA                  AGAA 
```

**Set fidelity:** 0.9712 (4 overhangs)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------ | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)      | --      | --    | --    |
| 2   | 3'WT block        | bsmbi_3wt_tile14_sub1    | 1311 nt | TGAA  | AAGA  |
| 3   | 3'WT block        | bsmbi_3wt_tile1_sub4     | 1707 nt | AAGA  | TCAA  |
| 4   | 3'WT+PolIII block | bsmbi_3wt_tile1_sub5     | 1190 nt | TCAA  | CACC  |
| 5   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1 | --      | --    | --    |

```
  [TGAA]----3'WT sub1----[AAGA]----3'WT sub2----[TCAA]----3'WT+PolIII sub3----[CACC]
   TGAA                   AAGA                   TCAA                          CACC 
```

**Set fidelity:** 0.9985 (4 overhangs)

---

### Tile 15 of 33 -- Codons 883-946 (192 nt)

**Boundary overhangs:**

| Position          | Sequence | Fidelity |
| ----------------- | -------- | -------- |
| oh1 (5' boundary) | ATAG     | 0.7330   |
| oh2 (3' boundary) | TTCC     | 0.7958   |

**Variants:** 12600 mutations, 12600 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name              | Length  | 5' OH | 3' OH |
| --- | --------------- | ---------------------- | ------- | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile7_sub1    | 809 nt  | ATGG  | GAAA  |
| 2   | 5'WT gene block | bsai_5wt_tile15_sub2   | 1662 nt | GAAA  | AAAT  |
| 3   | 5'WT gene block | bsai_5wt_tile15_sub3   | 229 nt  | AAAT  | ATAG  |
| 4   | Oligo pool      | Tile 15 (12600 oligos) | 248 nt  | ATAG  | AGAA  |
| 5   | Helper plasmid  | helper_plasmid_insert  | --      | --    | --    |
| 6   | Enzyme + buffer | BsaI-HFv2 + CutSmart   | --      | --    | --    |

```
  [ATGG]----5'WT sub1----[GAAA]----5'WT sub2----[AAAT]----5'WT sub3----[ATAG]----oligo+BC----[AGAA]
   ATGG                   GAAA                   AAAT                   ATAG                  AGAA 
```

**Set fidelity:** 0.9376 (5 overhangs)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------ | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)      | --      | --    | --    |
| 2   | 3'WT block        | bsmbi_3wt_tile15_sub1    | 1119 nt | TTCC  | AAGA  |
| 3   | 3'WT block        | bsmbi_3wt_tile1_sub4     | 1707 nt | AAGA  | TCAA  |
| 4   | 3'WT+PolIII block | bsmbi_3wt_tile1_sub5     | 1190 nt | TCAA  | CACC  |
| 5   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1 | --      | --    | --    |

```
  [TTCC]----3'WT sub1----[AAGA]----3'WT sub2----[TCAA]----3'WT+PolIII sub3----[CACC]
   TTCC                   AAGA                   TCAA                          CACC 
```

**Set fidelity:** 0.9988 (4 overhangs)

---

### Tile 16 of 33 -- Codons 947-1012 (198 nt)

**Boundary overhangs:**

| Position          | Sequence | Fidelity |
| ----------------- | -------- | -------- |
| oh1 (5' boundary) | ATTA     | 0.7818   |
| oh2 (3' boundary) | TCAT     | 0.8102   |

**Variants:** 13020 mutations, 13020 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name              | Length  | 5' OH | 3' OH |
| --- | --------------- | ---------------------- | ------- | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile7_sub1    | 809 nt  | ATGG  | GAAA  |
| 2   | 5'WT gene block | bsai_5wt_tile15_sub2   | 1662 nt | GAAA  | AAAT  |
| 3   | 5'WT gene block | bsai_5wt_tile16_sub3   | 421 nt  | AAAT  | ATTA  |
| 4   | Oligo pool      | Tile 16 (13020 oligos) | 254 nt  | ATTA  | AGAA  |
| 5   | Helper plasmid  | helper_plasmid_insert  | --      | --    | --    |
| 6   | Enzyme + buffer | BsaI-HFv2 + CutSmart   | --      | --    | --    |

```
  [ATGG]----5'WT sub1----[GAAA]----5'WT sub2----[AAAT]----5'WT sub3----[ATTA]----oligo+BC----[AGAA]
   ATGG                   GAAA                   AAAT                   ATTA                  AGAA 
```

**Set fidelity:** 1.0000 (5 overhangs)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------ | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)      | --      | --    | --    |
| 2   | 3'WT block        | bsmbi_3wt_tile16_sub1    | 921 nt  | TCAT  | AAGA  |
| 3   | 3'WT block        | bsmbi_3wt_tile1_sub4     | 1707 nt | AAGA  | TCAA  |
| 4   | 3'WT+PolIII block | bsmbi_3wt_tile1_sub5     | 1190 nt | TCAA  | CACC  |
| 5   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1 | --      | --    | --    |

```
  [TCAT]----3'WT sub1----[AAGA]----3'WT sub2----[TCAA]----3'WT+PolIII sub3----[CACC]
   TCAT                   AAGA                   TCAA                          CACC 
```

**Set fidelity:** 0.9779 (4 overhangs)

---

### Tile 17 of 33 -- Codons 1013-1070 (174 nt)

**Boundary overhangs:**

| Position          | Sequence | Fidelity |
| ----------------- | -------- | -------- |
| oh1 (5' boundary) | TCTA     | 0.8892   |
| oh2 (3' boundary) | ATCT     | 0.7151   |

**Variants:** 11340 mutations, 11340 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name              | Length  | 5' OH | 3' OH |
| --- | --------------- | ---------------------- | ------- | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile7_sub1    | 809 nt  | ATGG  | GAAA  |
| 2   | 5'WT gene block | bsai_5wt_tile15_sub2   | 1662 nt | GAAA  | AAAT  |
| 3   | 5'WT gene block | bsai_5wt_tile17_sub3   | 619 nt  | AAAT  | TCTA  |
| 4   | Oligo pool      | Tile 17 (11340 oligos) | 230 nt  | TCTA  | AGAA  |
| 5   | Helper plasmid  | helper_plasmid_insert  | --      | --    | --    |
| 6   | Enzyme + buffer | BsaI-HFv2 + CutSmart   | --      | --    | --    |

```
  [ATGG]----5'WT sub1----[GAAA]----5'WT sub2----[AAAT]----5'WT sub3----[TCTA]----oligo+BC----[AGAA]
   ATGG                   GAAA                   AAAT                   TCTA                  AGAA 
```

**Set fidelity:** 1.0000 (5 overhangs)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------ | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)      | --      | --    | --    |
| 2   | 3'WT block        | bsmbi_3wt_tile17_sub1    | 747 nt  | ATCT  | AAGA  |
| 3   | 3'WT block        | bsmbi_3wt_tile1_sub4     | 1707 nt | AAGA  | TCAA  |
| 4   | 3'WT+PolIII block | bsmbi_3wt_tile1_sub5     | 1190 nt | TCAA  | CACC  |
| 5   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1 | --      | --    | --    |

```
  [ATCT]----3'WT sub1----[AAGA]----3'WT sub2----[TCAA]----3'WT+PolIII sub3----[CACC]
   ATCT                   AAGA                   TCAA                          CACC 
```

**Set fidelity:** 1.0000 (4 overhangs)

---

### Tile 18 of 33 -- Codons 1071-1113 (129 nt)

**Boundary overhangs:**

| Position          | Sequence | Fidelity |
| ----------------- | -------- | -------- |
| oh1 (5' boundary) | ACTT     | 0.7315   |
| oh2 (3' boundary) | TATC     | 0.8041   |

**Variants:** 8190 mutations, 8190 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name             | Length  | 5' OH | 3' OH |
| --- | --------------- | --------------------- | ------- | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile7_sub1   | 809 nt  | ATGG  | GAAA  |
| 2   | 5'WT gene block | bsai_5wt_tile15_sub2  | 1662 nt | GAAA  | AAAT  |
| 3   | 5'WT gene block | bsai_5wt_tile18_sub3  | 793 nt  | AAAT  | ACTT  |
| 4   | Oligo pool      | Tile 18 (8190 oligos) | 185 nt  | ACTT  | AGAA  |
| 5   | Helper plasmid  | helper_plasmid_insert | --      | --    | --    |
| 6   | Enzyme + buffer | BsaI-HFv2 + CutSmart  | --      | --    | --    |

```
  [ATGG]----5'WT sub1----[GAAA]----5'WT sub2----[AAAT]----5'WT sub3----[ACTT]----oligo+BC----[AGAA]
   ATGG                   GAAA                   AAAT                   ACTT                  AGAA 
```

**Set fidelity:** 1.0000 (5 overhangs)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------ | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)      | --      | --    | --    |
| 2   | 3'WT block        | bsmbi_3wt_tile18_sub1    | 618 nt  | TATC  | AAGA  |
| 3   | 3'WT block        | bsmbi_3wt_tile1_sub4     | 1707 nt | AAGA  | TCAA  |
| 4   | 3'WT+PolIII block | bsmbi_3wt_tile1_sub5     | 1190 nt | TCAA  | CACC  |
| 5   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1 | --      | --    | --    |

```
  [TATC]----3'WT sub1----[AAGA]----3'WT sub2----[TCAA]----3'WT+PolIII sub3----[CACC]
   TATC                   AAGA                   TCAA                          CACC 
```

**Set fidelity:** 0.9961 (4 overhangs)

---

### Tile 19 of 33 -- Codons 1114-1150 (111 nt)

**Boundary overhangs:**

| Position          | Sequence | Fidelity |
| ----------------- | -------- | -------- |
| oh1 (5' boundary) | GAAT     | 0.7246   |
| oh2 (3' boundary) | ACAA     | 0.8919   |

**Variants:** 6930 mutations, 6930 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name             | Length  | 5' OH | 3' OH |
| --- | --------------- | --------------------- | ------- | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile7_sub1   | 809 nt  | ATGG  | GAAA  |
| 2   | 5'WT gene block | bsai_5wt_tile15_sub2  | 1662 nt | GAAA  | AAAT  |
| 3   | 5'WT gene block | bsai_5wt_tile19_sub3  | 922 nt  | AAAT  | GAAT  |
| 4   | Oligo pool      | Tile 19 (6930 oligos) | 167 nt  | GAAT  | AGAA  |
| 5   | Helper plasmid  | helper_plasmid_insert | --      | --    | --    |
| 6   | Enzyme + buffer | BsaI-HFv2 + CutSmart  | --      | --    | --    |

```
  [ATGG]----5'WT sub1----[GAAA]----5'WT sub2----[AAAT]----5'WT sub3----[GAAT]----oligo+BC----[AGAA]
   ATGG                   GAAA                   AAAT                   GAAT                  AGAA 
```

**Set fidelity:** 0.8382 (5 overhangs)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------ | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)      | --      | --    | --    |
| 2   | 3'WT block        | bsmbi_3wt_tile19_sub1    | 507 nt  | ACAA  | AAGA  |
| 3   | 3'WT block        | bsmbi_3wt_tile1_sub4     | 1707 nt | AAGA  | TCAA  |
| 4   | 3'WT+PolIII block | bsmbi_3wt_tile1_sub5     | 1190 nt | TCAA  | CACC  |
| 5   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1 | --      | --    | --    |

```
  [ACAA]----3'WT sub1----[AAGA]----3'WT sub2----[TCAA]----3'WT+PolIII sub3----[CACC]
   ACAA                   AAGA                   TCAA                          CACC 
```

**Set fidelity:** 0.9883 (4 overhangs)

---

### Tile 20 of 33 -- Codons 1151-1217 (201 nt)

**Boundary overhangs:**

| Position          | Sequence | Fidelity |
| ----------------- | -------- | -------- |
| oh1 (5' boundary) | GAGA     | 0.7444   |
| oh2 (3' boundary) | CAAA     | 0.8948   |

**Variants:** 13230 mutations, 13230 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name              | Length  | 5' OH | 3' OH |
| --- | --------------- | ---------------------- | ------- | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile7_sub1    | 809 nt  | ATGG  | GAAA  |
| 2   | 5'WT gene block | bsai_5wt_tile15_sub2   | 1662 nt | GAAA  | AAAT  |
| 3   | 5'WT gene block | bsai_5wt_tile20_sub3   | 1033 nt | AAAT  | GAGA  |
| 4   | Oligo pool      | Tile 20 (13230 oligos) | 257 nt  | GAGA  | AGAA  |
| 5   | Helper plasmid  | helper_plasmid_insert  | --      | --    | --    |
| 6   | Enzyme + buffer | BsaI-HFv2 + CutSmart   | --      | --    | --    |

```
  [ATGG]----5'WT sub1----[GAAA]----5'WT sub2----[AAAT]----5'WT sub3----[GAGA]----oligo+BC----[AGAA]
   ATGG                   GAAA                   AAAT                   GAGA                  AGAA 
```

**Set fidelity:** 0.9778 (5 overhangs)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------ | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)      | --      | --    | --    |
| 2   | 3'WT block        | bsmbi_3wt_tile20_sub1    | 306 nt  | CAAA  | AAGA  |
| 3   | 3'WT block        | bsmbi_3wt_tile1_sub4     | 1707 nt | AAGA  | TCAA  |
| 4   | 3'WT+PolIII block | bsmbi_3wt_tile1_sub5     | 1190 nt | TCAA  | CACC  |
| 5   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1 | --      | --    | --    |

```
  [CAAA]----3'WT sub1----[AAGA]----3'WT sub2----[TCAA]----3'WT+PolIII sub3----[CACC]
   CAAA                   AAGA                   TCAA                          CACC 
```

**Set fidelity:** 1.0000 (4 overhangs)

---

### Tile 21 of 33 -- Codons 1218-1265 (144 nt)

**Boundary overhangs:**

| Position          | Sequence | Fidelity |
| ----------------- | -------- | -------- |
| oh1 (5' boundary) | TTAG     | 0.8480   |
| oh2 (3' boundary) | TACA     | 0.8652   |

**Variants:** 9240 mutations, 9240 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name             | Length  | 5' OH | 3' OH |
| --- | --------------- | --------------------- | ------- | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile7_sub1   | 809 nt  | ATGG  | GAAA  |
| 2   | 5'WT gene block | bsai_5wt_tile15_sub2  | 1662 nt | GAAA  | AAAT  |
| 3   | 5'WT gene block | bsai_5wt_tile21_sub3  | 1234 nt | AAAT  | TTAG  |
| 4   | Oligo pool      | Tile 21 (9240 oligos) | 200 nt  | TTAG  | AGAA  |
| 5   | Helper plasmid  | helper_plasmid_insert | --      | --    | --    |
| 6   | Enzyme + buffer | BsaI-HFv2 + CutSmart  | --      | --    | --    |

```
  [ATGG]----5'WT sub1----[GAAA]----5'WT sub2----[AAAT]----5'WT sub3----[TTAG]----oligo+BC----[AGAA]
   ATGG                   GAAA                   AAAT                   TTAG                  AGAA 
```

**Set fidelity:** 1.0000 (5 overhangs)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------ | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)      | --      | --    | --    |
| 2   | 3'WT block        | bsmbi_3wt_tile21_sub1    | 162 nt  | TACA  | AAGA  |
| 3   | 3'WT block        | bsmbi_3wt_tile1_sub4     | 1707 nt | AAGA  | TCAA  |
| 4   | 3'WT+PolIII block | bsmbi_3wt_tile1_sub5     | 1190 nt | TCAA  | CACC  |
| 5   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1 | --      | --    | --    |

```
  [TACA]----3'WT sub1----[AAGA]----3'WT sub2----[TCAA]----3'WT+PolIII sub3----[CACC]
   TACA                   AAGA                   TCAA                          CACC 
```

**Set fidelity:** 1.0000 (4 overhangs)

---

### Tile 22 of 33 -- Codons 1266-1313 (144 nt)

**Boundary overhangs:**

| Position          | Sequence | Fidelity |
| ----------------- | -------- | -------- |
| oh1 (5' boundary) | GAAG     | 0.6752   |
| oh2 (3' boundary) | AAGA     | 0.9209   |

**Variants:** 9240 mutations, 9240 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name             | Length  | 5' OH | 3' OH |
| --- | --------------- | --------------------- | ------- | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile7_sub1   | 809 nt  | ATGG  | GAAA  |
| 2   | 5'WT gene block | bsai_5wt_tile15_sub2  | 1662 nt | GAAA  | AAAT  |
| 3   | 5'WT gene block | bsai_5wt_tile22_sub3  | 1378 nt | AAAT  | GAAG  |
| 4   | Oligo pool      | Tile 22 (9240 oligos) | 200 nt  | GAAG  | AGAA  |
| 5   | Helper plasmid  | helper_plasmid_insert | --      | --    | --    |
| 6   | Enzyme + buffer | BsaI-HFv2 + CutSmart  | --      | --    | --    |

```
  [ATGG]----5'WT sub1----[GAAA]----5'WT sub2----[AAAT]----5'WT sub3----[GAAG]----oligo+BC----[AGAA]
   ATGG                   GAAA                   AAAT                   GAAG                  AGAA 
```

**Set fidelity:** 0.9132 (5 overhangs)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------ | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)      | --      | --    | --    |
| 2   | 3'WT block        | bsmbi_3wt_tile1_sub4     | 1707 nt | AAGA  | TCAA  |
| 3   | 3'WT+PolIII block | bsmbi_3wt_tile1_sub5     | 1190 nt | TCAA  | CACC  |
| 4   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1 | --      | --    | --    |

```
  [AAGA]----3'WT sub1----[TCAA]----3'WT+PolIII sub2----[CACC]
   AAGA                   TCAA                          CACC 
```

**Set fidelity:** 1.0000 (3 overhangs)

---

### Tile 23 of 33 -- Codons 1310-1362 (159 nt)

**Boundary overhangs:**

| Position          | Sequence | Fidelity |
| ----------------- | -------- | -------- |
| oh1 (5' boundary) | GTGC     | 0.4969   |
| oh2 (3' boundary) | TCAG     | 0.7814   |

**Variants:** 10290 mutations, 10290 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name              | Length  | 5' OH | 3' OH |
| --- | --------------- | ---------------------- | ------- | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile7_sub1    | 809 nt  | ATGG  | GAAA  |
| 2   | 5'WT gene block | bsai_5wt_tile15_sub2   | 1662 nt | GAAA  | AAAT  |
| 3   | 5'WT gene block | bsai_5wt_tile23_sub3   | 1510 nt | AAAT  | GTGC  |
| 4   | Oligo pool      | Tile 23 (10290 oligos) | 215 nt  | GTGC  | AGAA  |
| 5   | Helper plasmid  | helper_plasmid_insert  | --      | --    | --    |
| 6   | Enzyme + buffer | BsaI-HFv2 + CutSmart   | --      | --    | --    |

```
  [ATGG]----5'WT sub1----[GAAA]----5'WT sub2----[AAAT]----5'WT sub3----[GTGC]----oligo+BC----[AGAA]
   ATGG                   GAAA                   AAAT                   GTGC                  AGAA 
```

**Set fidelity:** 1.0000 (5 overhangs)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------ | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)      | --      | --    | --    |
| 2   | 3'WT block        | bsmbi_3wt_tile23_sub1    | 1560 nt | TCAG  | TCAA  |
| 3   | 3'WT+PolIII block | bsmbi_3wt_tile1_sub5     | 1190 nt | TCAA  | CACC  |
| 4   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1 | --      | --    | --    |

```
  [TCAG]----3'WT sub1----[TCAA]----3'WT+PolIII sub2----[CACC]
   TCAG                   TCAA                          CACC 
```

**Set fidelity:** 0.9553 (3 overhangs)

---

### Tile 24 of 33 -- Codons 1363-1404 (126 nt)

**Boundary overhangs:**

| Position          | Sequence | Fidelity |
| ----------------- | -------- | -------- |
| oh1 (5' boundary) | ATAA     | 0.9170   |
| oh2 (3' boundary) | GGAA     | 0.7463   |

**Variants:** 7980 mutations, 7980 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name             | Length  | 5' OH | 3' OH |
| --- | --------------- | --------------------- | ------- | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile7_sub1   | 809 nt  | ATGG  | GAAA  |
| 2   | 5'WT gene block | bsai_5wt_tile15_sub2  | 1662 nt | GAAA  | AAAT  |
| 3   | 5'WT gene block | bsai_5wt_tile24_sub3  | 1669 nt | AAAT  | ATAA  |
| 4   | Oligo pool      | Tile 24 (7980 oligos) | 182 nt  | ATAA  | AGAA  |
| 5   | Helper plasmid  | helper_plasmid_insert | --      | --    | --    |
| 6   | Enzyme + buffer | BsaI-HFv2 + CutSmart  | --      | --    | --    |

```
  [ATGG]----5'WT sub1----[GAAA]----5'WT sub2----[AAAT]----5'WT sub3----[ATAA]----oligo+BC----[AGAA]
   ATGG                   GAAA                   AAAT                   ATAA                  AGAA 
```

**Set fidelity:** 0.9947 (5 overhangs)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------ | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)      | --      | --    | --    |
| 2   | 3'WT block        | bsmbi_3wt_tile24_sub1    | 1434 nt | GGAA  | TCAA  |
| 3   | 3'WT+PolIII block | bsmbi_3wt_tile1_sub5     | 1190 nt | TCAA  | CACC  |
| 4   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1 | --      | --    | --    |

```
  [GGAA]----3'WT sub1----[TCAA]----3'WT+PolIII sub2----[CACC]
   GGAA                   TCAA                          CACC 
```

**Set fidelity:** 1.0000 (3 overhangs)

---

### Tile 25 of 33 -- Codons 1405-1437 (99 nt)

**Boundary overhangs:**

| Position          | Sequence | Fidelity |
| ----------------- | -------- | -------- |
| oh1 (5' boundary) | ACAA     | 0.8919   |
| oh2 (3' boundary) | TGAA     | 0.8621   |

**Variants:** 6090 mutations, 6090 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name             | Length  | 5' OH | 3' OH |
| --- | --------------- | --------------------- | ------- | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile7_sub1   | 809 nt  | ATGG  | GAAA  |
| 2   | 5'WT gene block | bsai_5wt_tile15_sub2  | 1662 nt | GAAA  | AAAT  |
| 3   | 5'WT gene block | bsai_5wt_tile25_sub3  | 1795 nt | AAAT  | ACAA  |
| 4   | Oligo pool      | Tile 25 (6090 oligos) | 155 nt  | ACAA  | AGAA  |
| 5   | Helper plasmid  | helper_plasmid_insert | --      | --    | --    |
| 6   | Enzyme + buffer | BsaI-HFv2 + CutSmart  | --      | --    | --    |

```
  [ATGG]----5'WT sub1----[GAAA]----5'WT sub2----[AAAT]----5'WT sub3----[ACAA]----oligo+BC----[AGAA]
   ATGG                   GAAA                   AAAT                   ACAA                  AGAA 
```

**Set fidelity:** 0.9907 (5 overhangs)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------ | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)      | --      | --    | --    |
| 2   | 3'WT block        | bsmbi_3wt_tile25_sub1    | 1335 nt | TGAA  | TCAA  |
| 3   | 3'WT+PolIII block | bsmbi_3wt_tile1_sub5     | 1190 nt | TCAA  | CACC  |
| 4   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1 | --      | --    | --    |

```
  [TGAA]----3'WT sub1----[TCAA]----3'WT+PolIII sub2----[CACC]
   TGAA                   TCAA                          CACC 
```

**Set fidelity:** 0.9985 (3 overhangs)

---

### Tile 26 of 33 -- Codons 1438-1505 (204 nt)

**Boundary overhangs:**

| Position          | Sequence | Fidelity |
| ----------------- | -------- | -------- |
| oh1 (5' boundary) | CAAA     | 0.8948   |
| oh2 (3' boundary) | TAAG     | 0.8377   |

**Variants:** 13440 mutations, 13440 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name              | Length  | 5' OH | 3' OH |
| --- | --------------- | ---------------------- | ------- | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile7_sub1    | 809 nt  | ATGG  | GAAA  |
| 2   | 5'WT gene block | bsai_5wt_tile15_sub2   | 1662 nt | GAAA  | AAAT  |
| 3   | 5'WT gene block | bsai_5wt_tile26_sub3   | 1518 nt | AAAT  | AAGA  |
| 4   | 5'WT gene block | bsai_5wt_tile26_sub4   | 394 nt  | AAGA  | CAAA  |
| 5   | Oligo pool      | Tile 26 (13440 oligos) | 260 nt  | CAAA  | AGAA  |
| 6   | Helper plasmid  | helper_plasmid_insert  | --      | --    | --    |
| 7   | Enzyme + buffer | BsaI-HFv2 + CutSmart   | --      | --    | --    |

```
  [ATGG]----5'WT sub1----[GAAA]----5'WT sub2----[AAAT]----5'WT sub3----[AAGA]----5'WT sub4----[CAAA]----oligo+BC----[AGAA]
   ATGG                   GAAA                   AAAT                   AAGA                   CAAA                  AGAA 
```

**Set fidelity:** 0.9986 (6 overhangs)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------ | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)      | --      | --    | --    |
| 2   | 3'WT block        | bsmbi_3wt_tile26_sub1    | 1131 nt | TAAG  | TCAA  |
| 3   | 3'WT+PolIII block | bsmbi_3wt_tile1_sub5     | 1190 nt | TCAA  | CACC  |
| 4   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1 | --      | --    | --    |

```
  [TAAG]----3'WT sub1----[TCAA]----3'WT+PolIII sub2----[CACC]
   TAAG                   TCAA                          CACC 
```

**Set fidelity:** 1.0000 (3 overhangs)

---

### Tile 27 of 33 -- Codons 1506-1553 (144 nt)

**Boundary overhangs:**

| Position          | Sequence | Fidelity |
| ----------------- | -------- | -------- |
| oh1 (5' boundary) | GAAT     | 0.7246   |
| oh2 (3' boundary) | AGGA     | 0.7515   |

**Variants:** 9240 mutations, 9240 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name             | Length  | 5' OH | 3' OH |
| --- | --------------- | --------------------- | ------- | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile7_sub1   | 809 nt  | ATGG  | GAAA  |
| 2   | 5'WT gene block | bsai_5wt_tile15_sub2  | 1662 nt | GAAA  | AAAT  |
| 3   | 5'WT gene block | bsai_5wt_tile26_sub3  | 1518 nt | AAAT  | AAGA  |
| 4   | 5'WT gene block | bsai_5wt_tile27_sub4  | 598 nt  | AAGA  | GAAT  |
| 5   | Oligo pool      | Tile 27 (9240 oligos) | 200 nt  | GAAT  | AGAA  |
| 6   | Helper plasmid  | helper_plasmid_insert | --      | --    | --    |
| 7   | Enzyme + buffer | BsaI-HFv2 + CutSmart  | --      | --    | --    |

```
  [ATGG]----5'WT sub1----[GAAA]----5'WT sub2----[AAAT]----5'WT sub3----[AAGA]----5'WT sub4----[GAAT]----oligo+BC----[AGAA]
   ATGG                   GAAA                   AAAT                   AAGA                   GAAT                  AGAA 
```

**Set fidelity:** 0.8382 (6 overhangs)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------ | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)      | --      | --    | --    |
| 2   | 3'WT block        | bsmbi_3wt_tile27_sub1    | 987 nt  | AGGA  | TCAA  |
| 3   | 3'WT+PolIII block | bsmbi_3wt_tile1_sub5     | 1190 nt | TCAA  | CACC  |
| 4   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1 | --      | --    | --    |

```
  [AGGA]----3'WT sub1----[TCAA]----3'WT+PolIII sub2----[CACC]
   AGGA                   TCAA                          CACC 
```

**Set fidelity:** 1.0000 (3 overhangs)

---

### Tile 28 of 33 -- Codons 1554-1626 (219 nt)

**Boundary overhangs:**

| Position          | Sequence | Fidelity |
| ----------------- | -------- | -------- |
| oh1 (5' boundary) | CTAA     | 0.8691   |
| oh2 (3' boundary) | ATCT     | 0.7151   |

**Variants:** 14490 mutations, 14490 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name              | Length  | 5' OH | 3' OH |
| --- | --------------- | ---------------------- | ------- | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile7_sub1    | 809 nt  | ATGG  | GAAA  |
| 2   | 5'WT gene block | bsai_5wt_tile15_sub2   | 1662 nt | GAAA  | AAAT  |
| 3   | 5'WT gene block | bsai_5wt_tile26_sub3   | 1518 nt | AAAT  | AAGA  |
| 4   | 5'WT gene block | bsai_5wt_tile28_sub4   | 742 nt  | AAGA  | CTAA  |
| 5   | Oligo pool      | Tile 28 (14490 oligos) | 275 nt  | CTAA  | AGAA  |
| 6   | Helper plasmid  | helper_plasmid_insert  | --      | --    | --    |
| 7   | Enzyme + buffer | BsaI-HFv2 + CutSmart   | --      | --    | --    |

```
  [ATGG]----5'WT sub1----[GAAA]----5'WT sub2----[AAAT]----5'WT sub3----[AAGA]----5'WT sub4----[CTAA]----oligo+BC----[AGAA]
   ATGG                   GAAA                   AAAT                   AAGA                   CTAA                  AGAA 
```

**Set fidelity:** 1.0000 (6 overhangs)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------ | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)      | --      | --    | --    |
| 2   | 3'WT block        | bsmbi_3wt_tile28_sub1    | 768 nt  | ATCT  | TCAA  |
| 3   | 3'WT+PolIII block | bsmbi_3wt_tile1_sub5     | 1190 nt | TCAA  | CACC  |
| 4   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1 | --      | --    | --    |

```
  [ATCT]----3'WT sub1----[TCAA]----3'WT+PolIII sub2----[CACC]
   ATCT                   TCAA                          CACC 
```

**Set fidelity:** 1.0000 (3 overhangs)

---

### Tile 29 of 33 -- Codons 1627-1667 (123 nt)

**Boundary overhangs:**

| Position          | Sequence | Fidelity |
| ----------------- | -------- | -------- |
| oh1 (5' boundary) | TATC     | 0.8041   |
| oh2 (3' boundary) | CCTG     | 0.6383   |

**Variants:** 7770 mutations, 7770 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name             | Length  | 5' OH | 3' OH |
| --- | --------------- | --------------------- | ------- | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile7_sub1   | 809 nt  | ATGG  | GAAA  |
| 2   | 5'WT gene block | bsai_5wt_tile15_sub2  | 1662 nt | GAAA  | AAAT  |
| 3   | 5'WT gene block | bsai_5wt_tile26_sub3  | 1518 nt | AAAT  | AAGA  |
| 4   | 5'WT gene block | bsai_5wt_tile29_sub4  | 961 nt  | AAGA  | TATC  |
| 5   | Oligo pool      | Tile 29 (7770 oligos) | 179 nt  | TATC  | AGAA  |
| 6   | Helper plasmid  | helper_plasmid_insert | --      | --    | --    |
| 7   | Enzyme + buffer | BsaI-HFv2 + CutSmart  | --      | --    | --    |

```
  [ATGG]----5'WT sub1----[GAAA]----5'WT sub2----[AAAT]----5'WT sub3----[AAGA]----5'WT sub4----[TATC]----oligo+BC----[AGAA]
   ATGG                   GAAA                   AAAT                   AAGA                   TATC                  AGAA 
```

**Set fidelity:** 1.0000 (6 overhangs)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------ | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)      | --      | --    | --    |
| 2   | 3'WT block        | bsmbi_3wt_tile29_sub1    | 645 nt  | CCTG  | TCAA  |
| 3   | 3'WT+PolIII block | bsmbi_3wt_tile1_sub5     | 1190 nt | TCAA  | CACC  |
| 4   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1 | --      | --    | --    |

```
  [CCTG]----3'WT sub1----[TCAA]----3'WT+PolIII sub2----[CACC]
   CCTG                   TCAA                          CACC 
```

**Set fidelity:** 1.0000 (3 overhangs)

---

### Tile 30 of 33 -- Codons 1668-1736 (207 nt)

**Boundary overhangs:**

| Position          | Sequence | Fidelity |
| ----------------- | -------- | -------- |
| oh1 (5' boundary) | AGTA     | 0.7286   |
| oh2 (3' boundary) | AAGT     | 0.7629   |

**Variants:** 13650 mutations, 13650 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name              | Length  | 5' OH | 3' OH |
| --- | --------------- | ---------------------- | ------- | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile7_sub1    | 809 nt  | ATGG  | GAAA  |
| 2   | 5'WT gene block | bsai_5wt_tile15_sub2   | 1662 nt | GAAA  | AAAT  |
| 3   | 5'WT gene block | bsai_5wt_tile26_sub3   | 1518 nt | AAAT  | AAGA  |
| 4   | 5'WT gene block | bsai_5wt_tile30_sub4   | 1084 nt | AAGA  | AGTA  |
| 5   | Oligo pool      | Tile 30 (13650 oligos) | 263 nt  | AGTA  | AGAA  |
| 6   | Helper plasmid  | helper_plasmid_insert  | --      | --    | --    |
| 7   | Enzyme + buffer | BsaI-HFv2 + CutSmart   | --      | --    | --    |

```
  [ATGG]----5'WT sub1----[GAAA]----5'WT sub2----[AAAT]----5'WT sub3----[AAGA]----5'WT sub4----[AGTA]----oligo+BC----[AGAA]
   ATGG                   GAAA                   AAAT                   AAGA                   AGTA                  AGAA 
```

**Set fidelity:** 0.9712 (6 overhangs)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------ | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)      | --      | --    | --    |
| 2   | 3'WT block        | bsmbi_3wt_tile30_sub1    | 438 nt  | AAGT  | TCAA  |
| 3   | 3'WT+PolIII block | bsmbi_3wt_tile1_sub5     | 1190 nt | TCAA  | CACC  |
| 4   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1 | --      | --    | --    |

```
  [AAGT]----3'WT sub1----[TCAA]----3'WT+PolIII sub2----[CACC]
   AAGT                   TCAA                          CACC 
```

**Set fidelity:** 1.0000 (3 overhangs)

---

### Tile 31 of 33 -- Codons 1737-1811 (225 nt)

**Boundary overhangs:**

| Position          | Sequence | Fidelity |
| ----------------- | -------- | -------- |
| oh1 (5' boundary) | TCCA     | 0.8519   |
| oh2 (3' boundary) | TATT     | 0.8134   |

**Variants:** 14910 mutations, 14910 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name              | Length  | 5' OH | 3' OH |
| --- | --------------- | ---------------------- | ------- | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile7_sub1    | 809 nt  | ATGG  | GAAA  |
| 2   | 5'WT gene block | bsai_5wt_tile15_sub2   | 1662 nt | GAAA  | AAAT  |
| 3   | 5'WT gene block | bsai_5wt_tile26_sub3   | 1518 nt | AAAT  | AAGA  |
| 4   | 5'WT gene block | bsai_5wt_tile31_sub4   | 1291 nt | AAGA  | TCCA  |
| 5   | Oligo pool      | Tile 31 (14910 oligos) | 281 nt  | TCCA  | AGAA  |
| 6   | Helper plasmid  | helper_plasmid_insert  | --      | --    | --    |
| 7   | Enzyme + buffer | BsaI-HFv2 + CutSmart   | --      | --    | --    |

```
  [ATGG]----5'WT sub1----[GAAA]----5'WT sub2----[AAAT]----5'WT sub3----[AAGA]----5'WT sub4----[TCCA]----oligo+BC----[AGAA]
   ATGG                   GAAA                   AAAT                   AAGA                   TCCA                  AGAA 
```

**Set fidelity:** 1.0000 (6 overhangs)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------ | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)      | --      | --    | --    |
| 2   | 3'WT+PolIII block | bsmbi_3wt_tile31_sub1    | 1385 nt | TATT  | CACC  |
| 3   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1 | --      | --    | --    |

```
  [TATT]----3'WT+PolIII----[CACC]
   TATT                     CACC 
```

**Set fidelity:** 1.0000 (2 overhangs)

---

### Tile 32 of 33 -- Codons 1812-1876 (195 nt)

**Boundary overhangs:**

| Position          | Sequence | Fidelity |
| ----------------- | -------- | -------- |
| oh1 (5' boundary) | ATTA     | 0.7818   |
| oh2 (3' boundary) | TCAA     | 0.9425   |

**Variants:** 12810 mutations, 12810 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name              | Length  | 5' OH | 3' OH |
| --- | --------------- | ---------------------- | ------- | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile7_sub1    | 809 nt  | ATGG  | GAAA  |
| 2   | 5'WT gene block | bsai_5wt_tile15_sub2   | 1662 nt | GAAA  | AAAT  |
| 3   | 5'WT gene block | bsai_5wt_tile26_sub3   | 1518 nt | AAAT  | AAGA  |
| 4   | 5'WT gene block | bsai_5wt_tile32_sub4   | 1516 nt | AAGA  | ATTA  |
| 5   | Oligo pool      | Tile 32 (12810 oligos) | 251 nt  | ATTA  | AGAA  |
| 6   | Helper plasmid  | helper_plasmid_insert  | --      | --    | --    |
| 7   | Enzyme + buffer | BsaI-HFv2 + CutSmart   | --      | --    | --    |

```
  [ATGG]----5'WT sub1----[GAAA]----5'WT sub2----[AAAT]----5'WT sub3----[AAGA]----5'WT sub4----[ATTA]----oligo+BC----[AGAA]
   ATGG                   GAAA                   AAAT                   AAGA                   ATTA                  AGAA 
```

**Set fidelity:** 1.0000 (6 overhangs)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------ | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)      | --      | --    | --    |
| 2   | 3'WT+PolIII block | bsmbi_3wt_tile1_sub5     | 1190 nt | TCAA  | CACC  |
| 3   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1 | --      | --    | --    |

```
  [TCAA]----3'WT+PolIII----[CACC]
   TCAA                     CACC 
```

**Set fidelity:** 1.0000 (2 overhangs)

---

### Tile 33 of 33 -- Codons 1873-1902 (90 nt)

**Boundary overhangs:**

| Position          | Sequence | Fidelity |
| ----------------- | -------- | -------- |
| oh1 (5' boundary) | GCTG     | 0.4520   |
| oh2 (3' boundary) | ATAG     | 0.7330   |

**Variants:** 5460 mutations, 5460 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name             | Length  | 5' OH | 3' OH |
| --- | --------------- | --------------------- | ------- | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile7_sub1   | 809 nt  | ATGG  | GAAA  |
| 2   | 5'WT gene block | bsai_5wt_tile15_sub2  | 1662 nt | GAAA  | AAAT  |
| 3   | 5'WT gene block | bsai_5wt_tile26_sub3  | 1518 nt | AAAT  | AAGA  |
| 4   | 5'WT gene block | bsai_5wt_tile33_sub4  | 1699 nt | AAGA  | GCTG  |
| 5   | Oligo pool      | Tile 33 (5460 oligos) | 146 nt  | GCTG  | AGAA  |
| 6   | Helper plasmid  | helper_plasmid_insert | --      | --    | --    |
| 7   | Enzyme + buffer | BsaI-HFv2 + CutSmart  | --      | --    | --    |

```
  [ATGG]----5'WT sub1----[GAAA]----5'WT sub2----[AAAT]----5'WT sub3----[AAGA]----5'WT sub4----[GCTG]----oligo+BC----[AGAA]
   ATGG                   GAAA                   AAAT                   AAGA                   GCTG                  AGAA 
```

**Set fidelity:** 1.0000 (6 overhangs)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component            | Part name                | Length  | 5' OH | 3' OH |
| --- | -------------------- | ------------------------ | ------- | ----- | ----- |
| 1   | BsaI product         | (in helper plasmid)      | --      | --    | --    |
| 2   | PolIII-only fragment | bsmbi_polIII_tile33      | 1112 nt | ATAG  | CACC  |
| 3   | Enzyme + buffer      | BsmBI-v2 + NEBuffer r3.1 | --      | --    | --    |

```
  [ATAG]----PolIII----[CACC]
   ATAG                CACC 
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

**Total blocks:** 68

| Block name            | Length (nt) | Enzyme type | Gene region                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                |
| --------------------- | ----------- | ----------- | -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| bsai_5wt_tile10_sub2  | 973         | BsaI        | 5wt_tile10_sub2                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                            |
| bsai_5wt_tile11_sub2  | 1186        | BsaI        | 5wt_tile11_sub2                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                            |
| bsai_5wt_tile12_sub2  | 1387        | BsaI        | 5wt_tile12_sub2                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                            |
| bsai_5wt_tile13_sub2  | 1549        | BsaI        | 5wt_tile13_sub2                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                            |
| bsai_5wt_tile14_sub2  | 1654        | BsaI        | 5wt_tile14_sub2                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                            |
| bsai_5wt_tile15_sub2  | 1662        | BsaI        | 5wt_tile15_sub2;5wt_tile16_sub2;5wt_tile17_sub2;5wt_tile18_sub2;5wt_tile19_sub2;5wt_tile20_sub2;5wt_tile21_sub2;5wt_tile22_sub2;5wt_tile23_sub2;5wt_tile24_sub2;5wt_tile25_sub2;5wt_tile26_sub2;5wt_tile27_sub2;5wt_tile28_sub2;5wt_tile29_sub2;5wt_tile30_sub2;5wt_tile31_sub2;5wt_tile32_sub2;5wt_tile33_sub2                                                                                                                                                                                                                                                                                                                                                                                                            |
| bsai_5wt_tile15_sub3  | 229         | BsaI        | 5wt_tile15_sub3                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                            |
| bsai_5wt_tile16_sub3  | 421         | BsaI        | 5wt_tile16_sub3                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                            |
| bsai_5wt_tile17_sub3  | 619         | BsaI        | 5wt_tile17_sub3                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                            |
| bsai_5wt_tile18_sub3  | 793         | BsaI        | 5wt_tile18_sub3                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                            |
| bsai_5wt_tile19_sub3  | 922         | BsaI        | 5wt_tile19_sub3                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                            |
| bsai_5wt_tile2        | 225         | BsaI        | 5wt_tile2                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                  |
| bsai_5wt_tile20_sub3  | 1033        | BsaI        | 5wt_tile20_sub3                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                            |
| bsai_5wt_tile21_sub3  | 1234        | BsaI        | 5wt_tile21_sub3                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                            |
| bsai_5wt_tile22_sub3  | 1378        | BsaI        | 5wt_tile22_sub3                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                            |
| bsai_5wt_tile23_sub3  | 1510        | BsaI        | 5wt_tile23_sub3                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                            |
| bsai_5wt_tile24_sub3  | 1669        | BsaI        | 5wt_tile24_sub3                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                            |
| bsai_5wt_tile25_sub3  | 1795        | BsaI        | 5wt_tile25_sub3                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                            |
| bsai_5wt_tile26_sub3  | 1518        | BsaI        | 5wt_tile26_sub3;5wt_tile27_sub3;5wt_tile28_sub3;5wt_tile29_sub3;5wt_tile30_sub3;5wt_tile31_sub3;5wt_tile32_sub3;5wt_tile33_sub3                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                            |
| bsai_5wt_tile26_sub4  | 394         | BsaI        | 5wt_tile26_sub4                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                            |
| bsai_5wt_tile27_sub4  | 598         | BsaI        | 5wt_tile27_sub4                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                            |
| bsai_5wt_tile28_sub4  | 742         | BsaI        | 5wt_tile28_sub4                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                            |
| bsai_5wt_tile29_sub4  | 961         | BsaI        | 5wt_tile29_sub4                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                            |
| bsai_5wt_tile3        | 402         | BsaI        | 5wt_tile3                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                  |
| bsai_5wt_tile30_sub4  | 1084        | BsaI        | 5wt_tile30_sub4                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                            |
| bsai_5wt_tile31_sub4  | 1291        | BsaI        | 5wt_tile31_sub4                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                            |
| bsai_5wt_tile32_sub4  | 1516        | BsaI        | 5wt_tile32_sub4                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                            |
| bsai_5wt_tile33_sub4  | 1699        | BsaI        | 5wt_tile33_sub4                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                            |
| bsai_5wt_tile4        | 582         | BsaI        | 5wt_tile4                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                  |
| bsai_5wt_tile5        | 801         | BsaI        | 5wt_tile5                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                  |
| bsai_5wt_tile6_sub1   | 1005        | BsaI        | 5wt_tile6_sub1                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                             |
| bsai_5wt_tile7_sub1   | 809         | BsaI        | 5wt_tile7_sub1;5wt_tile8_sub1;5wt_tile9_sub1;5wt_tile10_sub1;5wt_tile11_sub1;5wt_tile12_sub1;5wt_tile13_sub1;5wt_tile14_sub1;5wt_tile15_sub1;5wt_tile16_sub1;5wt_tile17_sub1;5wt_tile18_sub1;5wt_tile19_sub1;5wt_tile20_sub1;5wt_tile21_sub1;5wt_tile22_sub1;5wt_tile23_sub1;5wt_tile24_sub1;5wt_tile25_sub1;5wt_tile26_sub1;5wt_tile27_sub1;5wt_tile28_sub1;5wt_tile29_sub1;5wt_tile30_sub1;5wt_tile31_sub1;5wt_tile32_sub1;5wt_tile33_sub1                                                                                                                                                                                                                                                                               |
| bsai_5wt_tile7_sub2   | 406         | BsaI        | 5wt_tile7_sub2                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                             |
| bsai_5wt_tile8_sub2   | 562         | BsaI        | 5wt_tile8_sub2                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                             |
| bsai_5wt_tile9_sub2   | 754         | BsaI        | 5wt_tile9_sub2                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                             |
| bsmbi_3wt_tile1_sub1  | 606         | BsmBI       | 3wt_tile1_sub1                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                             |
| bsmbi_3wt_tile1_sub2  | 1662        | BsmBI       | 3wt_tile1_sub2;3wt_tile2_sub2;3wt_tile3_sub2;3wt_tile4_sub1                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                |
| bsmbi_3wt_tile1_sub3  | 1518        | BsmBI       | 3wt_tile1_sub3;3wt_tile2_sub3;3wt_tile3_sub3;3wt_tile4_sub2;3wt_tile5_sub2;3wt_tile6_sub2;3wt_tile7_sub2;3wt_tile8_sub2;3wt_tile9_sub2;3wt_tile10_sub2;3wt_tile11_sub2;3wt_tile13_sub1                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                     |
| bsmbi_3wt_tile1_sub4  | 1707        | BsmBI       | 3wt_tile1_sub4;3wt_tile2_sub4;3wt_tile3_sub4;3wt_tile4_sub3;3wt_tile5_sub3;3wt_tile6_sub3;3wt_tile7_sub3;3wt_tile8_sub3;3wt_tile9_sub3;3wt_tile10_sub3;3wt_tile11_sub3;3wt_tile12_sub2;3wt_tile13_sub2;3wt_tile14_sub2;3wt_tile15_sub2;3wt_tile16_sub2;3wt_tile17_sub2;3wt_tile18_sub2;3wt_tile19_sub2;3wt_tile20_sub2;3wt_tile21_sub2;3wt_tile22_sub1                                                                                                                                                                                                                                                                                                                                                                     |
| bsmbi_3wt_tile1_sub5  | 1190        | BsmBI       | 3wt_polIII_tile1_sub5;3wt_polIII_tile2_sub5;3wt_polIII_tile3_sub5;3wt_polIII_tile4_sub4;3wt_polIII_tile5_sub4;3wt_polIII_tile6_sub4;3wt_polIII_tile7_sub4;3wt_polIII_tile8_sub4;3wt_polIII_tile9_sub4;3wt_polIII_tile10_sub4;3wt_polIII_tile11_sub4;3wt_polIII_tile12_sub3;3wt_polIII_tile13_sub3;3wt_polIII_tile14_sub3;3wt_polIII_tile15_sub3;3wt_polIII_tile16_sub3;3wt_polIII_tile17_sub3;3wt_polIII_tile18_sub3;3wt_polIII_tile19_sub3;3wt_polIII_tile20_sub3;3wt_polIII_tile21_sub3;3wt_polIII_tile22_sub2;3wt_polIII_tile23_sub2;3wt_polIII_tile24_sub2;3wt_polIII_tile25_sub2;3wt_polIII_tile26_sub2;3wt_polIII_tile27_sub2;3wt_polIII_tile28_sub2;3wt_polIII_tile29_sub2;3wt_polIII_tile30_sub2;3wt_polIII_tile32 |
| bsmbi_3wt_tile10_sub1 | 498         | BsmBI       | 3wt_tile10_sub1                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                            |
| bsmbi_3wt_tile11_sub1 | 297         | BsmBI       | 3wt_tile11_sub1                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                            |
| bsmbi_3wt_tile12_sub1 | 1635        | BsmBI       | 3wt_tile12_sub1                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                            |
| bsmbi_3wt_tile14_sub1 | 1311        | BsmBI       | 3wt_tile14_sub1                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                            |
| bsmbi_3wt_tile15_sub1 | 1119        | BsmBI       | 3wt_tile15_sub1                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                            |
| bsmbi_3wt_tile16_sub1 | 921         | BsmBI       | 3wt_tile16_sub1                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                            |
| bsmbi_3wt_tile17_sub1 | 747         | BsmBI       | 3wt_tile17_sub1                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                            |
| bsmbi_3wt_tile18_sub1 | 618         | BsmBI       | 3wt_tile18_sub1                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                            |
| bsmbi_3wt_tile19_sub1 | 507         | BsmBI       | 3wt_tile19_sub1                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                            |
| bsmbi_3wt_tile2_sub1  | 429         | BsmBI       | 3wt_tile2_sub1                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                             |
| bsmbi_3wt_tile20_sub1 | 306         | BsmBI       | 3wt_tile20_sub1                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                            |
| bsmbi_3wt_tile21_sub1 | 162         | BsmBI       | 3wt_tile21_sub1                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                            |
| bsmbi_3wt_tile23_sub1 | 1560        | BsmBI       | 3wt_tile23_sub1                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                            |
| bsmbi_3wt_tile24_sub1 | 1434        | BsmBI       | 3wt_tile24_sub1                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                            |
| bsmbi_3wt_tile25_sub1 | 1335        | BsmBI       | 3wt_tile25_sub1                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                            |
| bsmbi_3wt_tile26_sub1 | 1131        | BsmBI       | 3wt_tile26_sub1                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                            |
| bsmbi_3wt_tile27_sub1 | 987         | BsmBI       | 3wt_tile27_sub1                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                            |
| bsmbi_3wt_tile28_sub1 | 768         | BsmBI       | 3wt_tile28_sub1                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                            |
| bsmbi_3wt_tile29_sub1 | 645         | BsmBI       | 3wt_tile29_sub1                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                            |
| bsmbi_3wt_tile3_sub1  | 249         | BsmBI       | 3wt_tile3_sub1                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                             |
| bsmbi_3wt_tile30_sub1 | 438         | BsmBI       | 3wt_tile30_sub1                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                            |
| bsmbi_3wt_tile31_sub1 | 1385        | BsmBI       | 3wt_polIII_tile31_sub1                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                     |
| bsmbi_3wt_tile5_sub1  | 1470        | BsmBI       | 3wt_tile5_sub1                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                             |
| bsmbi_3wt_tile6_sub1  | 1278        | BsmBI       | 3wt_tile6_sub1                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                             |
| bsmbi_3wt_tile7_sub1  | 1122        | BsmBI       | 3wt_tile7_sub1                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                             |
| bsmbi_3wt_tile8_sub1  | 930         | BsmBI       | 3wt_tile8_sub1                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                             |
| bsmbi_3wt_tile9_sub1  | 711         | BsmBI       | 3wt_tile9_sub1                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                             |
| bsmbi_polIII_tile33   | 1112        | BsmBI       | polIII_tile33                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                              |

## 10. Domestication Log

5 endogenous enzyme site(s) were removed via silent mutations:

| site_start | enzyme | strand | codon_pos | original_codon | new_codon | aa  |
| ---------- | ------ | ------ | --------- | -------------- | --------- | --- |
| 499        | BsaI   | -      | 167       | GAG            | GAA       | E   |
| 4350       | BsaI   | +      | 1450      | GAG            | GAA       | E   |
| 4693       | BsaI   | -      | 1565      | GAG            | GAA       | E   |
| 5603       | BsaI   | -      | 1868      | GGA            | GGC       | G   |
| 3398       | PaqCI  | +      | 1133      | GCA            | GCC       | A   |

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

