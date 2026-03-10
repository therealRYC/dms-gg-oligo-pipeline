# DMS-GG Assembly Report: AKAP11

Generated: 2026-03-09 18:58:59
Pipeline: dms-gg-oligo-pipeline (3-Enzyme Architecture: BsaI + BsmBI + PaqCI)

---

## 1. Gene Summary

| Property             | Value                                                                          |
| -------------------- | ------------------------------------------------------------------------------ |
| Gene name            | AKAP11_NM_016248.4_CDS Homo sapiens A-kinase anchoring protein 11 (AKAP11) CDS |
| CDS length           | 5706 nt (1902 codons)                                                          |
| Protein length       | 1901 aa                                                                        |
| Number of tiles      | 37                                                                             |
| Total variants       | 36834                                                                          |
| Total oligos         | 36834                                                                          |
| Oligo length range   | 140-290 nt                                                                     |
| Gene blocks to order | 147                                                                            |
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
[PaqCI**]--[gene+mutation]--[WPRE]--[spacer]--[bGH_polyA]--[PolIII]--[barcode]--[PaqCI*]
```

## 3. Oligo Pool Summary

**Total oligos:** 36834 | **Length range:** 140-290 nt

| Tile | Codons    | Oligos | Length |
| ---- | --------- | ------ | ------ |
| 1    | 1-33      | 609    | 155 nt |
| 2    | 34-83     | 966    | 206 nt |
| 3    | 84-140    | 1113   | 227 nt |
| 4    | 141-193   | 1029   | 215 nt |
| 5    | 194-251   | 1134   | 230 nt |
| 6    | 252-329   | 1554   | 290 nt |
| 7    | 330-394   | 1281   | 251 nt |
| 8    | 395-468   | 1470   | 278 nt |
| 9    | 469-525   | 1113   | 227 nt |
| 10   | 526-574   | 945    | 203 nt |
| 11   | 575-639   | 1281   | 251 nt |
| 12   | 640-681   | 798    | 182 nt |
| 13   | 682-720   | 735    | 173 nt |
| 14   | 721-748   | 504    | 140 nt |
| 15   | 749-804   | 1092   | 224 nt |
| 16   | 805-855   | 987    | 209 nt |
| 17   | 856-902   | 903    | 197 nt |
| 18   | 903-971   | 1365   | 263 nt |
| 19   | 972-1003  | 588    | 152 nt |
| 20   | 1004-1052 | 945    | 203 nt |
| 21   | 1053-1087 | 651    | 161 nt |
| 22   | 1088-1134 | 903    | 197 nt |
| 23   | 1135-1210 | 1512   | 284 nt |
| 24   | 1211-1274 | 1260   | 248 nt |
| 25   | 1275-1329 | 1071   | 221 nt |
| 26   | 1330-1373 | 840    | 188 nt |
| 27   | 1374-1415 | 798    | 182 nt |
| 28   | 1416-1479 | 1260   | 248 nt |
| 29   | 1480-1520 | 777    | 179 nt |
| 30   | 1521-1562 | 798    | 182 nt |
| 31   | 1563-1623 | 1197   | 239 nt |
| 32   | 1624-1677 | 1050   | 218 nt |
| 33   | 1678-1718 | 777    | 179 nt |
| 34   | 1719-1792 | 1470   | 278 nt |
| 35   | 1793-1824 | 588    | 152 nt |
| 36   | 1825-1870 | 882    | 194 nt |
| 37   | 1871-1902 | 588    | 152 nt |

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
| Total barcodes    | 36834                              |
| Unique barcodes   | 36834                              |
| GC content range  | 25% - 75%                          |
| GC content mean   | 48%                                |
| Hamming guarantee | 100% cross-variant (prefix d >= 3) |

## 5. QC Summary

**Overall:** ISSUES FOUND

| Check                  | Description                                                   | Result | Detail                                                                                                                                                |
| ---------------------- | ------------------------------------------------------------- | ------ | ----------------------------------------------------------------------------------------------------------------------------------------------------- |
| oligo_lengths          | All oligos within synthesis length limit                      | PASS   | Range: 140-290 nt (limit: 300)                                                                                                                        |
| block_lengths          | All gene blocks within synthesis length limit                 | FAIL   | Range: 117-2162 nt (limit: 1800)                                                                                                                      |
| barcode_junction_sites | No enzyme sites at barcode-context junctions                  | PASS   | 0 barcode(s) with junction enzyme sites (left='CACACC', right='AGAATG')                                                                               |
| barcode_uniqueness     | All barcodes are unique                                       | PASS   | 36834 unique / 36834 total                                                                                                                            |
| tile_coverage          | Tiles cover entire gene without gaps                          | PASS   | 5706 / 5706 nt covered                                                                                                                                |
| variant_count          | Expected number of variants generated                         | PASS   | 36834 unique variants (expected: 36834 across 1754/1900 mutable positions; 33326 missense + 1754 nonsense + 1754 wt_control; 146 position(s) skipped) |
| single_codon_change    | Each non-control variant differs by exactly one codon from WT | PASS   | 35080 / 35080 variants confirmed (WT controls excluded)                                                                                               |
| oligo_gc_content       | Oligo GC content within reasonable range (25-75%)             | PASS   | GC range: 32-53.6% | 0 oligo(s) with extreme GC                                                                                                       |
| domestication_complete | Gene domesticated for all 3 enzymes (BsaI, BsmBI, PaqCI)      | PASS   | No enzyme sites in gene                                                                                                                               |
| overhang_fidelity      | Tile boundary overhangs have adequate fidelity                | FAIL   | 35 tile(s) with low-fidelity boundary overhangs (<0.80)                                                                                               |
| tile_manifests         | Per-tile assembly manifests complete                          | PASS   | 37 tile manifest(s) generated                                                                                                                         |
| helper_plasmid         | Helper plasmid free of unintended BsmBI sites                 | PASS   | OK                                                                                                                                                    |
| reaction_fidelity      | Per-reaction set-level overhang fidelity                      | FAIL   | Min set fidelity: 0.7829 across 74 reactions | 5 reaction(s) below 0.90                                                                               |
| barcode_poliii_term    | No barcodes contain PolIII terminator signal (TTTT)           | PASS   | 0 / 36834 barcode(s) contain TTTT                                                                                                                     |
| block_min_length       | All gene blocks above synthesis minimum length                | FAIL   | 2 block(s) below 300 nt minimum. Range: 117-2162 nt                                                                                                   |
| sb_overhang_collisions | Superblock boundary overhangs are unique (no collisions)      | PASS   | 4 SB boundary OH(s), all unique                                                                                                                       |

## 5b. Reaction Fidelity Summary

Set fidelity for each tile's BsaI and BsmBI reactions,
computed from the actual block overhangs after construction:

| Tile | BsaI OHs | BsaI Set Fidelity | BsmBI OHs | BsmBI Set Fidelity |
| ---- | -------- | ----------------- | --------- | ------------------ |
| 1    | 2        | 1.0000            | 7         | 0.9633             |
| 2    | 3        | 1.0000            | 7         | 0.9819             |
| 3    | 3        | 1.0000            | 7         | 0.9777             |
| 4    | 3        | 1.0000            | 7         | 0.8779             |
| 5    | 3        | 1.0000            | 7         | 0.9649             |
| 6    | 3        | 1.0000            | 7         | 0.9584             |
| 7    | 3        | 1.0000            | 7         | 0.9662             |
| 8    | 3        | 1.0000            | 7         | 0.9777             |
| 9    | 3        | 1.0000            | 6         | 0.9832             |
| 10   | 3        | 1.0000            | 6         | 0.8836             |
| 11   | 3        | 1.0000            | 6         | 0.9856             |
| 12   | 4        | 0.9816            | 6         | 0.9602             |
| 13   | 4        | 0.9907            | 6         | 0.9856             |
| 14   | 4        | 0.9907            | 6         | 0.9856             |
| 15   | 4        | 0.9907            | 6         | 0.9832             |
| 16   | 4        | 0.9907            | 6         | 0.9853             |
| 17   | 4        | 0.9907            | 5         | 0.9911             |
| 18   | 4        | 0.9907            | 5         | 0.9911             |
| 19   | 4        | 0.9907            | 5         | 0.9911             |
| 20   | 4        | 0.8660            | 5         | 0.9911             |
| 21   | 4        | 0.9907            | 5         | 0.9911             |
| 22   | 5        | 0.9698            | 4         | 0.9911             |
| 23   | 5        | 0.9907            | 4         | 0.9911             |
| 24   | 5        | 0.9764            | 4         | 0.9911             |
| 25   | 5        | 0.9764            | 4         | 1.0000             |
| 26   | 5        | 0.9764            | 4         | 0.9809             |
| 27   | 5        | 0.9764            | 4         | 1.0000             |
| 28   | 5        | 0.9764            | 4         | 1.0000             |
| 29   | 5        | 0.9764            | 4         | 0.7829             |
| 30   | 5        | 0.9907            | 3         | 0.8550             |
| 31   | 5        | 0.9907            | 3         | 1.0000             |
| 32   | 5        | 0.9721            | 2         | 1.0000             |
| 33   | 5        | 0.9764            | 2         | 1.0000             |
| 34   | 6        | 0.9764            | 2         | 1.0000             |
| 35   | 6        | 0.9676            | 2         | 1.0000             |
| 36   | 6        | 0.9676            | 2         | 1.0000             |
| 37   | 6        | 0.9764            | 2         | 1.0000             |

**Min:** 0.7829 | **Max:** 1.0000 | **Mean:** 0.9781

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

### Tile 1 of 37 -- Codons 1-33 (99 nt)

**Boundary overhangs:**

| Position          | Sequence | Fidelity |
| ----------------- | -------- | -------- |
| oh1 (5' boundary) | ATGG     | 0.5393   |
| oh2 (3' boundary) | ACTA     | 0.7946   |

**Variants:** 609 mutations, 609 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name                          | Length | 5' OH | 3' OH |
| --- | --------------- | ---------------------------------- | ------ | ----- | ----- |
| 1   | 5'WT gene block | (none -- tile starts at gene nt 1) | --     | --    | --    |
| 2   | Oligo pool      | Tile 1 (609 oligos)                | 155 nt | ATGG  | AGAA  |
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
| 2   | 3'WT block        | bsmbi_3wt_tile1_sub1     | 900 nt  | ACTA  | AAAA  |
| 3   | 3'WT block        | bsmbi_3wt_tile1_sub2     | 1044 nt | AAAA  | TCAA  |
| 4   | 3'WT block        | bsmbi_3wt_tile1_sub3     | 876 nt  | TCAA  | CAAA  |
| 5   | 3'WT block        | bsmbi_3wt_tile1_sub4     | 870 nt  | CAAA  | AAGA  |
| 6   | 3'WT block        | bsmbi_3wt_tile1_sub5     | 957 nt  | AAGA  | TCTA  |
| 7   | 3'WT+PolIII block | bsmbi_3wt_tile1_sub6     | 2162 nt | TCTA  | CACC  |
| 8   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1 | --      | --    | --    |

```
  [ACTA]----3'WT sub1----[AAAA]----3'WT sub2----[TCAA]----3'WT sub3----[CAAA]----3'WT sub4----[AAGA]----3'WT sub5----[TCTA]----3'WT+PolIII sub6----[CACC]
   ACTA                   AAAA                   TCAA                   CAAA                   AAGA                   TCTA                          CACC 
```

**Set fidelity:** 0.9633 (7 overhangs)

---

### Tile 2 of 37 -- Codons 34-83 (150 nt)

**Boundary overhangs:**

| Position          | Sequence | Fidelity |
| ----------------- | -------- | -------- |
| oh1 (5' boundary) | CAGA     | 0.8175   |
| oh2 (3' boundary) | TTCA     | 0.8824   |

**Variants:** 966 mutations, 966 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name             | Length | 5' OH | 3' OH |
| --- | --------------- | --------------------- | ------ | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile2        | 117 nt | ATGG  | CAGA  |
| 2   | Oligo pool      | Tile 2 (966 oligos)   | 206 nt | CAGA  | AGAA  |
| 3   | Helper plasmid  | helper_plasmid_insert | --     | --    | --    |
| 4   | Enzyme + buffer | BsaI-HFv2 + CutSmart  | --     | --    | --    |

```
  [ATGG]----5'WT block----[CAGA]----oligo+BC----[AGAA]
   ATGG                    CAGA                  AGAA 
```

**Set fidelity:** 1.0000 (3 overhangs)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------ | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)      | --      | --    | --    |
| 2   | 3'WT block        | bsmbi_3wt_tile2_sub1     | 969 nt  | TTCA  | AAAA  |
| 3   | 3'WT block        | bsmbi_3wt_tile2_sub2     | 825 nt  | AAAA  | TCAA  |
| 4   | 3'WT block        | bsmbi_3wt_tile1_sub3     | 876 nt  | TCAA  | CAAA  |
| 5   | 3'WT block        | bsmbi_3wt_tile2_sub4     | 1092 nt | CAAA  | AAGA  |
| 6   | 3'WT block        | bsmbi_3wt_tile2_sub5     | 735 nt  | AAGA  | TCTA  |
| 7   | 3'WT+PolIII block | bsmbi_3wt_tile1_sub6     | 2162 nt | TCTA  | CACC  |
| 8   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1 | --      | --    | --    |

```
  [TTCA]----3'WT sub1----[AAAA]----3'WT sub2----[TCAA]----3'WT sub3----[CAAA]----3'WT sub4----[AAGA]----3'WT sub5----[TCTA]----3'WT+PolIII sub6----[CACC]
   TTCA                   AAAA                   TCAA                   CAAA                   AAGA                   TCTA                          CACC 
```

**Set fidelity:** 0.9819 (7 overhangs)

---

### Tile 3 of 37 -- Codons 84-140 (171 nt)

**Boundary overhangs:**

| Position          | Sequence | Fidelity |
| ----------------- | -------- | -------- |
| oh1 (5' boundary) | ATTC     | 0.7084   |
| oh2 (3' boundary) | TCTC     | 0.8105   |

**Variants:** 1113 mutations, 1113 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name             | Length | 5' OH | 3' OH |
| --- | --------------- | --------------------- | ------ | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile3        | 267 nt | ATGG  | ATTC  |
| 2   | Oligo pool      | Tile 3 (1113 oligos)  | 227 nt | ATTC  | AGAA  |
| 3   | Helper plasmid  | helper_plasmid_insert | --     | --    | --    |
| 4   | Enzyme + buffer | BsaI-HFv2 + CutSmart  | --     | --    | --    |

```
  [ATGG]----5'WT block----[ATTC]----oligo+BC----[AGAA]
   ATGG                    ATTC                  AGAA 
```

**Set fidelity:** 1.0000 (3 overhangs)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------ | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)      | --      | --    | --    |
| 2   | 3'WT block        | bsmbi_3wt_tile3_sub1     | 798 nt  | TCTC  | AAAA  |
| 3   | 3'WT block        | bsmbi_3wt_tile3_sub2     | 1065 nt | AAAA  | TCAA  |
| 4   | 3'WT block        | bsmbi_3wt_tile3_sub3     | 732 nt  | TCAA  | CAAA  |
| 5   | 3'WT block        | bsmbi_3wt_tile3_sub4     | 996 nt  | CAAA  | AAGA  |
| 6   | 3'WT block        | bsmbi_3wt_tile3_sub5     | 810 nt  | AAGA  | AGAA  |
| 7   | 3'WT+PolIII block | bsmbi_3wt_tile3_sub6     | 2087 nt | AGAA  | CACC  |
| 8   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1 | --      | --    | --    |

```
  [TCTC]----3'WT sub1----[AAAA]----3'WT sub2----[TCAA]----3'WT sub3----[CAAA]----3'WT sub4----[AAGA]----3'WT sub5----[AGAA]----3'WT+PolIII sub6----[CACC]
   TCTC                   AAAA                   TCAA                   CAAA                   AAGA                   AGAA                          CACC 
```

**Set fidelity:** 0.9777 (7 overhangs)

---

### Tile 4 of 37 -- Codons 141-193 (159 nt)

**Boundary overhangs:**

| Position          | Sequence | Fidelity |
| ----------------- | -------- | -------- |
| oh1 (5' boundary) | ATCT     | 0.7151   |
| oh2 (3' boundary) | GGAA     | 0.7463   |

**Variants:** 1029 mutations, 1029 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name             | Length | 5' OH | 3' OH |
| --- | --------------- | --------------------- | ------ | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile4        | 438 nt | ATGG  | ATCT  |
| 2   | Oligo pool      | Tile 4 (1029 oligos)  | 215 nt | ATCT  | AGAA  |
| 3   | Helper plasmid  | helper_plasmid_insert | --     | --    | --    |
| 4   | Enzyme + buffer | BsaI-HFv2 + CutSmart  | --     | --    | --    |

```
  [ATGG]----5'WT block----[ATCT]----oligo+BC----[AGAA]
   ATGG                    ATCT                  AGAA 
```

**Set fidelity:** 1.0000 (3 overhangs)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------ | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)      | --      | --    | --    |
| 2   | 3'WT block        | bsmbi_3wt_tile4_sub1     | 918 nt  | GGAA  | AAAA  |
| 3   | 3'WT block        | bsmbi_3wt_tile4_sub2     | 786 nt  | AAAA  | TCAA  |
| 4   | 3'WT block        | bsmbi_3wt_tile4_sub3     | 798 nt  | TCAA  | AGAA  |
| 5   | 3'WT block        | bsmbi_3wt_tile4_sub4     | 930 nt  | AGAA  | AAGA  |
| 6   | 3'WT block        | bsmbi_3wt_tile4_sub5     | 966 nt  | AAGA  | GAAA  |
| 7   | 3'WT+PolIII block | bsmbi_3wt_tile4_sub6     | 1931 nt | GAAA  | CACC  |
| 8   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1 | --      | --    | --    |

```
  [GGAA]----3'WT sub1----[AAAA]----3'WT sub2----[TCAA]----3'WT sub3----[AGAA]----3'WT sub4----[AAGA]----3'WT sub5----[GAAA]----3'WT+PolIII sub6----[CACC]
   GGAA                   AAAA                   TCAA                   AGAA                   AAGA                   GAAA                          CACC 
```

**Set fidelity:** 0.8779 (7 overhangs)

---

### Tile 5 of 37 -- Codons 194-251 (174 nt)

**Boundary overhangs:**

| Position          | Sequence | Fidelity |
| ----------------- | -------- | -------- |
| oh1 (5' boundary) | TTAG     | 0.8480   |
| oh2 (3' boundary) | TGTC     | 0.6650   |

**Variants:** 1134 mutations, 1134 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name             | Length | 5' OH | 3' OH |
| --- | --------------- | --------------------- | ------ | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile5        | 597 nt | ATGG  | TTAG  |
| 2   | Oligo pool      | Tile 5 (1134 oligos)  | 230 nt | TTAG  | AGAA  |
| 3   | Helper plasmid  | helper_plasmid_insert | --     | --    | --    |
| 4   | Enzyme + buffer | BsaI-HFv2 + CutSmart  | --     | --    | --    |

```
  [ATGG]----5'WT block----[TTAG]----oligo+BC----[AGAA]
   ATGG                    TTAG                  AGAA 
```

**Set fidelity:** 1.0000 (3 overhangs)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------ | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)      | --      | --    | --    |
| 2   | 3'WT block        | bsmbi_3wt_tile5_sub1     | 744 nt  | TGTC  | AAAA  |
| 3   | 3'WT block        | bsmbi_3wt_tile5_sub2     | 1020 nt | AAAA  | AGAA  |
| 4   | 3'WT block        | bsmbi_3wt_tile5_sub3     | 666 nt  | AGAA  | TCAA  |
| 5   | 3'WT block        | bsmbi_3wt_tile5_sub4     | 828 nt  | TCAA  | AAGA  |
| 6   | 3'WT block        | bsmbi_3wt_tile4_sub5     | 966 nt  | AAGA  | GAAA  |
| 7   | 3'WT+PolIII block | bsmbi_3wt_tile4_sub6     | 1931 nt | GAAA  | CACC  |
| 8   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1 | --      | --    | --    |

```
  [TGTC]----3'WT sub1----[AAAA]----3'WT sub2----[AGAA]----3'WT sub3----[TCAA]----3'WT sub4----[AAGA]----3'WT sub5----[GAAA]----3'WT+PolIII sub6----[CACC]
   TGTC                   AAAA                   AGAA                   TCAA                   AAGA                   GAAA                          CACC 
```

**Set fidelity:** 0.9649 (7 overhangs)

---

### Tile 6 of 37 -- Codons 252-329 (234 nt)

**Boundary overhangs:**

| Position          | Sequence | Fidelity |
| ----------------- | -------- | -------- |
| oh1 (5' boundary) | TCAG     | 0.7814   |
| oh2 (3' boundary) | ACTT     | 0.7315   |

**Variants:** 1554 mutations, 1554 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name             | Length | 5' OH | 3' OH |
| --- | --------------- | --------------------- | ------ | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile6        | 771 nt | ATGG  | TCAG  |
| 2   | Oligo pool      | Tile 6 (1554 oligos)  | 290 nt | TCAG  | AGAA  |
| 3   | Helper plasmid  | helper_plasmid_insert | --     | --    | --    |
| 4   | Enzyme + buffer | BsaI-HFv2 + CutSmart  | --     | --    | --    |

```
  [ATGG]----5'WT block----[TCAG]----oligo+BC----[AGAA]
   ATGG                    TCAG                  AGAA 
```

**Set fidelity:** 1.0000 (3 overhangs)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------ | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)      | --      | --    | --    |
| 2   | 3'WT block        | bsmbi_3wt_tile6_sub1     | 687 nt  | ACTT  | AAAA  |
| 3   | 3'WT block        | bsmbi_3wt_tile6_sub2     | 843 nt  | AAAA  | AGAA  |
| 4   | 3'WT block        | bsmbi_3wt_tile6_sub3     | 927 nt  | AGAA  | CAAA  |
| 5   | 3'WT block        | bsmbi_3wt_tile6_sub4     | 810 nt  | CAAA  | AAGA  |
| 6   | 3'WT block        | bsmbi_3wt_tile6_sub5     | 723 nt  | AAGA  | GAAA  |
| 7   | 3'WT+PolIII block | bsmbi_3wt_tile4_sub6     | 1931 nt | GAAA  | CACC  |
| 8   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1 | --      | --    | --    |

```
  [ACTT]----3'WT sub1----[AAAA]----3'WT sub2----[AGAA]----3'WT sub3----[CAAA]----3'WT sub4----[AAGA]----3'WT sub5----[GAAA]----3'WT+PolIII sub6----[CACC]
   ACTT                   AAAA                   AGAA                   CAAA                   AAGA                   GAAA                          CACC 
```

**Set fidelity:** 0.9584 (7 overhangs)

---

### Tile 7 of 37 -- Codons 330-394 (195 nt)

**Boundary overhangs:**

| Position          | Sequence | Fidelity |
| ----------------- | -------- | -------- |
| oh1 (5' boundary) | AAAG     | 0.7511   |
| oh2 (3' boundary) | TCCT     | 0.7573   |

**Variants:** 1281 mutations, 1281 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name             | Length  | 5' OH | 3' OH |
| --- | --------------- | --------------------- | ------- | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile7        | 1005 nt | ATGG  | AAAG  |
| 2   | Oligo pool      | Tile 7 (1281 oligos)  | 251 nt  | AAAG  | AGAA  |
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
| 2   | 3'WT block        | bsmbi_3wt_tile7_sub1     | 660 nt  | TCCT  | AAAA  |
| 3   | 3'WT block        | bsmbi_3wt_tile7_sub2     | 936 nt  | AAAA  | GAAA  |
| 4   | 3'WT block        | bsmbi_3wt_tile7_sub3     | 666 nt  | GAAA  | CAAA  |
| 5   | 3'WT block        | bsmbi_3wt_tile7_sub4     | 942 nt  | CAAA  | TCAA  |
| 6   | 3'WT block        | bsmbi_3wt_tile7_sub5     | 777 nt  | TCAA  | AGAA  |
| 7   | 3'WT+PolIII block | bsmbi_3wt_tile7_sub6     | 1745 nt | AGAA  | CACC  |
| 8   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1 | --      | --    | --    |

```
  [TCCT]----3'WT sub1----[AAAA]----3'WT sub2----[GAAA]----3'WT sub3----[CAAA]----3'WT sub4----[TCAA]----3'WT sub5----[AGAA]----3'WT+PolIII sub6----[CACC]
   TCCT                   AAAA                   GAAA                   CAAA                   TCAA                   AGAA                          CACC 
```

**Set fidelity:** 0.9662 (7 overhangs)

---

### Tile 8 of 37 -- Codons 395-468 (222 nt)

**Boundary overhangs:**

| Position          | Sequence | Fidelity |
| ----------------- | -------- | -------- |
| oh1 (5' boundary) | TGTA     | 0.7693   |
| oh2 (3' boundary) | TATT     | 0.8134   |

**Variants:** 1470 mutations, 1470 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name             | Length  | 5' OH | 3' OH |
| --- | --------------- | --------------------- | ------- | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile8        | 1200 nt | ATGG  | TGTA  |
| 2   | Oligo pool      | Tile 8 (1470 oligos)  | 278 nt  | TGTA  | AGAA  |
| 3   | Helper plasmid  | helper_plasmid_insert | --      | --    | --    |
| 4   | Enzyme + buffer | BsaI-HFv2 + CutSmart  | --      | --    | --    |

```
  [ATGG]----5'WT block----[TGTA]----oligo+BC----[AGAA]
   ATGG                    TGTA                  AGAA 
```

**Set fidelity:** 1.0000 (3 overhangs)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------ | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)      | --      | --    | --    |
| 2   | 3'WT block        | bsmbi_3wt_tile8_sub1     | 687 nt  | TATT  | AAAA  |
| 3   | 3'WT block        | bsmbi_3wt_tile8_sub2     | 810 nt  | AAAA  | CAAA  |
| 4   | 3'WT block        | bsmbi_3wt_tile8_sub3     | 825 nt  | CAAA  | TCAA  |
| 5   | 3'WT block        | bsmbi_3wt_tile8_sub4     | 528 nt  | TCAA  | AAGA  |
| 6   | 3'WT block        | bsmbi_3wt_tile8_sub5     | 909 nt  | AAGA  | AGAA  |
| 7   | 3'WT+PolIII block | bsmbi_3wt_tile7_sub6     | 1745 nt | AGAA  | CACC  |
| 8   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1 | --      | --    | --    |

```
  [TATT]----3'WT sub1----[AAAA]----3'WT sub2----[CAAA]----3'WT sub3----[TCAA]----3'WT sub4----[AAGA]----3'WT sub5----[AGAA]----3'WT+PolIII sub6----[CACC]
   TATT                   AAAA                   CAAA                   TCAA                   AAGA                   AGAA                          CACC 
```

**Set fidelity:** 0.9777 (7 overhangs)

---

### Tile 9 of 37 -- Codons 469-525 (171 nt)

**Boundary overhangs:**

| Position          | Sequence | Fidelity |
| ----------------- | -------- | -------- |
| oh1 (5' boundary) | CAAA     | 0.8948   |
| oh2 (3' boundary) | TAAG     | 0.8377   |

**Variants:** 1113 mutations, 1113 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name             | Length  | 5' OH | 3' OH |
| --- | --------------- | --------------------- | ------- | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile9        | 1422 nt | ATGG  | CAAA  |
| 2   | Oligo pool      | Tile 9 (1113 oligos)  | 227 nt  | CAAA  | AGAA  |
| 3   | Helper plasmid  | helper_plasmid_insert | --      | --    | --    |
| 4   | Enzyme + buffer | BsaI-HFv2 + CutSmart  | --      | --    | --    |

```
  [ATGG]----5'WT block----[CAAA]----oligo+BC----[AGAA]
   ATGG                    CAAA                  AGAA 
```

**Set fidelity:** 1.0000 (3 overhangs)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------ | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)      | --      | --    | --    |
| 2   | 3'WT block        | bsmbi_3wt_tile9_sub1     | 708 nt  | TAAG  | AAAA  |
| 3   | 3'WT block        | bsmbi_3wt_tile9_sub2     | 882 nt  | AAAA  | TCAA  |
| 4   | 3'WT block        | bsmbi_3wt_tile5_sub4     | 828 nt  | TCAA  | AAGA  |
| 5   | 3'WT block        | bsmbi_3wt_tile3_sub5     | 810 nt  | AAGA  | AGAA  |
| 6   | 3'WT+PolIII block | bsmbi_3wt_tile3_sub6     | 2087 nt | AGAA  | CACC  |
| 7   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1 | --      | --    | --    |

```
  [TAAG]----3'WT sub1----[AAAA]----3'WT sub2----[TCAA]----3'WT sub3----[AAGA]----3'WT sub4----[AGAA]----3'WT+PolIII sub5----[CACC]
   TAAG                   AAAA                   TCAA                   AAGA                   AGAA                          CACC 
```

**Set fidelity:** 0.9832 (6 overhangs)

---

### Tile 10 of 37 -- Codons 526-574 (147 nt)

**Boundary overhangs:**

| Position          | Sequence | Fidelity |
| ----------------- | -------- | -------- |
| oh1 (5' boundary) | GTAA     | 0.8029   |
| oh2 (3' boundary) | CAAT     | 0.7361   |

**Variants:** 945 mutations, 945 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name             | Length  | 5' OH | 3' OH |
| --- | --------------- | --------------------- | ------- | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile10       | 1593 nt | ATGG  | GTAA  |
| 2   | Oligo pool      | Tile 10 (945 oligos)  | 203 nt  | GTAA  | AGAA  |
| 3   | Helper plasmid  | helper_plasmid_insert | --      | --    | --    |
| 4   | Enzyme + buffer | BsaI-HFv2 + CutSmart  | --      | --    | --    |

```
  [ATGG]----5'WT block----[GTAA]----oligo+BC----[AGAA]
   ATGG                    GTAA                  AGAA 
```

**Set fidelity:** 1.0000 (3 overhangs)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------ | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)      | --      | --    | --    |
| 2   | 3'WT block        | bsmbi_3wt_tile10_sub1    | 768 nt  | CAAT  | AAAA  |
| 3   | 3'WT block        | bsmbi_3wt_tile10_sub2    | 936 nt  | AAAA  | CAAA  |
| 4   | 3'WT block        | bsmbi_3wt_tile6_sub4     | 810 nt  | CAAA  | AAGA  |
| 5   | 3'WT block        | bsmbi_3wt_tile10_sub4    | 618 nt  | AAGA  | AGAA  |
| 6   | 3'WT+PolIII block | bsmbi_3wt_tile10_sub5    | 2036 nt | AGAA  | CACC  |
| 7   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1 | --      | --    | --    |

```
  [CAAT]----3'WT sub1----[AAAA]----3'WT sub2----[CAAA]----3'WT sub3----[AAGA]----3'WT sub4----[AGAA]----3'WT+PolIII sub5----[CACC]
   CAAT                   AAAA                   CAAA                   AAGA                   AGAA                          CACC 
```

**Set fidelity:** 0.8836 (6 overhangs)

---

### Tile 11 of 37 -- Codons 575-639 (195 nt)

**Boundary overhangs:**

| Position          | Sequence | Fidelity |
| ----------------- | -------- | -------- |
| oh1 (5' boundary) | TCAT     | 0.8102   |
| oh2 (3' boundary) | AGTT     | 0.6748   |

**Variants:** 1281 mutations, 1281 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name             | Length  | 5' OH | 3' OH |
| --- | --------------- | --------------------- | ------- | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile11       | 1740 nt | ATGG  | TCAT  |
| 2   | Oligo pool      | Tile 11 (1281 oligos) | 251 nt  | TCAT  | AGAA  |
| 3   | Helper plasmid  | helper_plasmid_insert | --      | --    | --    |
| 4   | Enzyme + buffer | BsaI-HFv2 + CutSmart  | --      | --    | --    |

```
  [ATGG]----5'WT block----[TCAT]----oligo+BC----[AGAA]
   ATGG                    TCAT                  AGAA 
```

**Set fidelity:** 1.0000 (3 overhangs)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------ | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)      | --      | --    | --    |
| 2   | 3'WT block        | bsmbi_3wt_tile11_sub1    | 693 nt  | AGTT  | AAAA  |
| 3   | 3'WT block        | bsmbi_3wt_tile11_sub2    | 816 nt  | AAAA  | CAAA  |
| 4   | 3'WT block        | bsmbi_3wt_tile7_sub4     | 942 nt  | CAAA  | TCAA  |
| 5   | 3'WT block        | bsmbi_3wt_tile7_sub5     | 777 nt  | TCAA  | AGAA  |
| 6   | 3'WT+PolIII block | bsmbi_3wt_tile7_sub6     | 1745 nt | AGAA  | CACC  |
| 7   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1 | --      | --    | --    |

```
  [AGTT]----3'WT sub1----[AAAA]----3'WT sub2----[CAAA]----3'WT sub3----[TCAA]----3'WT sub4----[AGAA]----3'WT+PolIII sub5----[CACC]
   AGTT                   AAAA                   CAAA                   TCAA                   AGAA                          CACC 
```

**Set fidelity:** 0.9856 (6 overhangs)

---

### Tile 12 of 37 -- Codons 640-681 (126 nt)

**Boundary overhangs:**

| Position          | Sequence | Fidelity |
| ----------------- | -------- | -------- |
| oh1 (5' boundary) | ACAA     | 0.8919   |
| oh2 (3' boundary) | AGTA     | 0.7286   |

**Variants:** 798 mutations, 798 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name             | Length | 5' OH | 3' OH |
| --- | --------------- | --------------------- | ------ | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile12_sub1  | 995 nt | ATGG  | AAAA  |
| 2   | 5'WT gene block | bsai_5wt_tile12_sub2  | 958 nt | AAAA  | ACAA  |
| 3   | Oligo pool      | Tile 12 (798 oligos)  | 182 nt | ACAA  | AGAA  |
| 4   | Helper plasmid  | helper_plasmid_insert | --     | --    | --    |
| 5   | Enzyme + buffer | BsaI-HFv2 + CutSmart  | --     | --    | --    |

```
  [ATGG]----5'WT sub1----[AAAA]----5'WT sub2----[ACAA]----oligo+BC----[AGAA]
   ATGG                   AAAA                   ACAA                  AGAA 
```

**Set fidelity:** 0.9816 (4 overhangs)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------ | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)      | --      | --    | --    |
| 2   | 3'WT block        | bsmbi_3wt_tile12_sub1    | 669 nt  | AGTA  | AAAA  |
| 3   | 3'WT block        | bsmbi_3wt_tile12_sub2    | 714 nt  | AAAA  | CAAA  |
| 4   | 3'WT block        | bsmbi_3wt_tile7_sub4     | 942 nt  | CAAA  | TCAA  |
| 5   | 3'WT block        | bsmbi_3wt_tile7_sub5     | 777 nt  | TCAA  | AGAA  |
| 6   | 3'WT+PolIII block | bsmbi_3wt_tile7_sub6     | 1745 nt | AGAA  | CACC  |
| 7   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1 | --      | --    | --    |

```
  [AGTA]----3'WT sub1----[AAAA]----3'WT sub2----[CAAA]----3'WT sub3----[TCAA]----3'WT sub4----[AGAA]----3'WT+PolIII sub5----[CACC]
   AGTA                   AAAA                   CAAA                   TCAA                   AGAA                          CACC 
```

**Set fidelity:** 0.9602 (6 overhangs)

---

### Tile 13 of 37 -- Codons 682-720 (117 nt)

**Boundary overhangs:**

| Position          | Sequence | Fidelity |
| ----------------- | -------- | -------- |
| oh1 (5' boundary) | GAAG     | 0.6752   |
| oh2 (3' boundary) | TAAT     | 0.8165   |

**Variants:** 735 mutations, 735 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name             | Length  | 5' OH | 3' OH |
| --- | --------------- | --------------------- | ------- | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile12_sub1  | 995 nt  | ATGG  | AAAA  |
| 2   | 5'WT gene block | bsai_5wt_tile13_sub2  | 1084 nt | AAAA  | GAAG  |
| 3   | Oligo pool      | Tile 13 (735 oligos)  | 173 nt  | GAAG  | AGAA  |
| 4   | Helper plasmid  | helper_plasmid_insert | --      | --    | --    |
| 5   | Enzyme + buffer | BsaI-HFv2 + CutSmart  | --      | --    | --    |

```
  [ATGG]----5'WT sub1----[AAAA]----5'WT sub2----[GAAG]----oligo+BC----[AGAA]
   ATGG                   AAAA                   GAAG                  AGAA 
```

**Set fidelity:** 0.9907 (4 overhangs)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------ | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)      | --      | --    | --    |
| 2   | 3'WT block        | bsmbi_3wt_tile13_sub1    | 723 nt  | TAAT  | CAAA  |
| 3   | 3'WT block        | bsmbi_3wt_tile13_sub2    | 630 nt  | CAAA  | AAAA  |
| 4   | 3'WT block        | bsmbi_3wt_tile13_sub3    | 855 nt  | AAAA  | TCAA  |
| 5   | 3'WT block        | bsmbi_3wt_tile7_sub5     | 777 nt  | TCAA  | AGAA  |
| 6   | 3'WT+PolIII block | bsmbi_3wt_tile7_sub6     | 1745 nt | AGAA  | CACC  |
| 7   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1 | --      | --    | --    |

```
  [TAAT]----3'WT sub1----[CAAA]----3'WT sub2----[AAAA]----3'WT sub3----[TCAA]----3'WT sub4----[AGAA]----3'WT+PolIII sub5----[CACC]
   TAAT                   CAAA                   AAAA                   TCAA                   AGAA                          CACC 
```

**Set fidelity:** 0.9856 (6 overhangs)

---

### Tile 14 of 37 -- Codons 721-748 (84 nt)

**Boundary overhangs:**

| Position          | Sequence | Fidelity |
| ----------------- | -------- | -------- |
| oh1 (5' boundary) | TCTA     | 0.8892   |
| oh2 (3' boundary) | TATG     | 0.7006   |

**Variants:** 504 mutations, 504 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name             | Length  | 5' OH | 3' OH |
| --- | --------------- | --------------------- | ------- | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile12_sub1  | 995 nt  | ATGG  | AAAA  |
| 2   | 5'WT gene block | bsai_5wt_tile14_sub2  | 1201 nt | AAAA  | TCTA  |
| 3   | Oligo pool      | Tile 14 (504 oligos)  | 140 nt  | TCTA  | AGAA  |
| 4   | Helper plasmid  | helper_plasmid_insert | --      | --    | --    |
| 5   | Enzyme + buffer | BsaI-HFv2 + CutSmart  | --      | --    | --    |

```
  [ATGG]----5'WT sub1----[AAAA]----5'WT sub2----[TCTA]----oligo+BC----[AGAA]
   ATGG                   AAAA                   TCTA                  AGAA 
```

**Set fidelity:** 0.9907 (4 overhangs)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------ | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)      | --      | --    | --    |
| 2   | 3'WT block        | bsmbi_3wt_tile14_sub1    | 639 nt  | TATG  | CAAA  |
| 3   | 3'WT block        | bsmbi_3wt_tile13_sub2    | 630 nt  | CAAA  | AAAA  |
| 4   | 3'WT block        | bsmbi_3wt_tile13_sub3    | 855 nt  | AAAA  | TCAA  |
| 5   | 3'WT block        | bsmbi_3wt_tile7_sub5     | 777 nt  | TCAA  | AGAA  |
| 6   | 3'WT+PolIII block | bsmbi_3wt_tile7_sub6     | 1745 nt | AGAA  | CACC  |
| 7   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1 | --      | --    | --    |

```
  [TATG]----3'WT sub1----[CAAA]----3'WT sub2----[AAAA]----3'WT sub3----[TCAA]----3'WT sub4----[AGAA]----3'WT+PolIII sub5----[CACC]
   TATG                   CAAA                   AAAA                   TCAA                   AGAA                          CACC 
```

**Set fidelity:** 0.9856 (6 overhangs)

---

### Tile 15 of 37 -- Codons 749-804 (168 nt)

**Boundary overhangs:**

| Position          | Sequence | Fidelity |
| ----------------- | -------- | -------- |
| oh1 (5' boundary) | CAAG     | 0.6640   |
| oh2 (3' boundary) | TGAT     | 0.6933   |

**Variants:** 1092 mutations, 1092 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name             | Length  | 5' OH | 3' OH |
| --- | --------------- | --------------------- | ------- | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile12_sub1  | 995 nt  | ATGG  | AAAA  |
| 2   | 5'WT gene block | bsai_5wt_tile15_sub2  | 1285 nt | AAAA  | CAAG  |
| 3   | Oligo pool      | Tile 15 (1092 oligos) | 224 nt  | CAAG  | AGAA  |
| 4   | Helper plasmid  | helper_plasmid_insert | --      | --    | --    |
| 5   | Enzyme + buffer | BsaI-HFv2 + CutSmart  | --      | --    | --    |

```
  [ATGG]----5'WT sub1----[AAAA]----5'WT sub2----[CAAG]----oligo+BC----[AGAA]
   ATGG                   AAAA                   CAAG                  AGAA 
```

**Set fidelity:** 0.9907 (4 overhangs)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------ | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)      | --      | --    | --    |
| 2   | 3'WT block        | bsmbi_3wt_tile15_sub1    | 735 nt  | TGAT  | TCAA  |
| 3   | 3'WT block        | bsmbi_3wt_tile15_sub2    | 717 nt  | TCAA  | AAAA  |
| 4   | 3'WT block        | bsmbi_3wt_tile15_sub3    | 477 nt  | AAAA  | AAGA  |
| 5   | 3'WT block        | bsmbi_3wt_tile15_sub4    | 804 nt  | AAGA  | AGAA  |
| 6   | 3'WT+PolIII block | bsmbi_3wt_tile7_sub6     | 1745 nt | AGAA  | CACC  |
| 7   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1 | --      | --    | --    |

```
  [TGAT]----3'WT sub1----[TCAA]----3'WT sub2----[AAAA]----3'WT sub3----[AAGA]----3'WT sub4----[AGAA]----3'WT+PolIII sub5----[CACC]
   TGAT                   TCAA                   AAAA                   AAGA                   AGAA                          CACC 
```

**Set fidelity:** 0.9832 (6 overhangs)

---

### Tile 16 of 37 -- Codons 805-855 (153 nt)

**Boundary overhangs:**

| Position          | Sequence | Fidelity |
| ----------------- | -------- | -------- |
| oh1 (5' boundary) | CTGT     | 0.6476   |
| oh2 (3' boundary) | AATG     | 0.6412   |

**Variants:** 987 mutations, 987 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name             | Length  | 5' OH | 3' OH |
| --- | --------------- | --------------------- | ------- | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile16_sub1  | 1214 nt | ATGG  | AAAA  |
| 2   | 5'WT gene block | bsai_5wt_tile16_sub2  | 1234 nt | AAAA  | CTGT  |
| 3   | Oligo pool      | Tile 16 (987 oligos)  | 209 nt  | CTGT  | AGAA  |
| 4   | Helper plasmid  | helper_plasmid_insert | --      | --    | --    |
| 5   | Enzyme + buffer | BsaI-HFv2 + CutSmart  | --      | --    | --    |

```
  [ATGG]----5'WT sub1----[AAAA]----5'WT sub2----[CTGT]----oligo+BC----[AGAA]
   ATGG                   AAAA                   CTGT                  AGAA 
```

**Set fidelity:** 0.9907 (4 overhangs)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------ | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)      | --      | --    | --    |
| 2   | 3'WT block        | bsmbi_3wt_tile16_sub1    | 582 nt  | AATG  | TCAA  |
| 3   | 3'WT block        | bsmbi_3wt_tile15_sub2    | 717 nt  | TCAA  | AAAA  |
| 4   | 3'WT block        | bsmbi_3wt_tile16_sub3    | 534 nt  | AAAA  | TAGA  |
| 5   | 3'WT block        | bsmbi_3wt_tile16_sub4    | 747 nt  | TAGA  | AGAA  |
| 6   | 3'WT+PolIII block | bsmbi_3wt_tile7_sub6     | 1745 nt | AGAA  | CACC  |
| 7   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1 | --      | --    | --    |

```
  [AATG]----3'WT sub1----[TCAA]----3'WT sub2----[AAAA]----3'WT sub3----[TAGA]----3'WT sub4----[AGAA]----3'WT+PolIII sub5----[CACC]
   AATG                   TCAA                   AAAA                   TAGA                   AGAA                          CACC 
```

**Set fidelity:** 0.9853 (6 overhangs)

---

### Tile 17 of 37 -- Codons 856-902 (141 nt)

**Boundary overhangs:**

| Position          | Sequence | Fidelity |
| ----------------- | -------- | -------- |
| oh1 (5' boundary) | GATA     | 0.7029   |
| oh2 (3' boundary) | TTAT     | 0.8673   |

**Variants:** 903 mutations, 903 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name             | Length  | 5' OH | 3' OH |
| --- | --------------- | --------------------- | ------- | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile16_sub1  | 1214 nt | ATGG  | AAAA  |
| 2   | 5'WT gene block | bsai_5wt_tile17_sub2  | 1387 nt | AAAA  | GATA  |
| 3   | Oligo pool      | Tile 17 (903 oligos)  | 197 nt  | GATA  | AGAA  |
| 4   | Helper plasmid  | helper_plasmid_insert | --      | --    | --    |
| 5   | Enzyme + buffer | BsaI-HFv2 + CutSmart  | --      | --    | --    |

```
  [ATGG]----5'WT sub1----[AAAA]----5'WT sub2----[GATA]----oligo+BC----[AGAA]
   ATGG                   AAAA                   GATA                  AGAA 
```

**Set fidelity:** 0.9907 (4 overhangs)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------ | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)      | --      | --    | --    |
| 2   | 3'WT block        | bsmbi_3wt_tile17_sub1    | 789 nt  | TTAT  | AAAA  |
| 3   | 3'WT block        | bsmbi_3wt_tile13_sub3    | 855 nt  | AAAA  | TCAA  |
| 4   | 3'WT block        | bsmbi_3wt_tile7_sub5     | 777 nt  | TCAA  | AGAA  |
| 5   | 3'WT+PolIII block | bsmbi_3wt_tile7_sub6     | 1745 nt | AGAA  | CACC  |
| 6   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1 | --      | --    | --    |

```
  [TTAT]----3'WT sub1----[AAAA]----3'WT sub2----[TCAA]----3'WT sub3----[AGAA]----3'WT+PolIII sub4----[CACC]
   TTAT                   AAAA                   TCAA                   AGAA                          CACC 
```

**Set fidelity:** 0.9911 (5 overhangs)

---

### Tile 18 of 37 -- Codons 903-971 (207 nt)

**Boundary overhangs:**

| Position          | Sequence | Fidelity |
| ----------------- | -------- | -------- |
| oh1 (5' boundary) | CGTA     | 0.6538   |
| oh2 (3' boundary) | TGGA     | 0.7377   |

**Variants:** 1365 mutations, 1365 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name             | Length  | 5' OH | 3' OH |
| --- | --------------- | --------------------- | ------- | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile18_sub1  | 1493 nt | ATGG  | AAAA  |
| 2   | 5'WT gene block | bsai_5wt_tile18_sub2  | 1249 nt | AAAA  | CGTA  |
| 3   | Oligo pool      | Tile 18 (1365 oligos) | 263 nt  | CGTA  | AGAA  |
| 4   | Helper plasmid  | helper_plasmid_insert | --      | --    | --    |
| 5   | Enzyme + buffer | BsaI-HFv2 + CutSmart  | --      | --    | --    |

```
  [ATGG]----5'WT sub1----[AAAA]----5'WT sub2----[CGTA]----oligo+BC----[AGAA]
   ATGG                   AAAA                   CGTA                  AGAA 
```

**Set fidelity:** 0.9907 (4 overhangs)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------ | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)      | --      | --    | --    |
| 2   | 3'WT block        | bsmbi_3wt_tile18_sub1    | 582 nt  | TGGA  | AAAA  |
| 3   | 3'WT block        | bsmbi_3wt_tile13_sub3    | 855 nt  | AAAA  | TCAA  |
| 4   | 3'WT block        | bsmbi_3wt_tile7_sub5     | 777 nt  | TCAA  | AGAA  |
| 5   | 3'WT+PolIII block | bsmbi_3wt_tile7_sub6     | 1745 nt | AGAA  | CACC  |
| 6   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1 | --      | --    | --    |

```
  [TGGA]----3'WT sub1----[AAAA]----3'WT sub2----[TCAA]----3'WT sub3----[AGAA]----3'WT+PolIII sub4----[CACC]
   TGGA                   AAAA                   TCAA                   AGAA                          CACC 
```

**Set fidelity:** 0.9911 (5 overhangs)

---

### Tile 19 of 37 -- Codons 972-1003 (96 nt)

**Boundary overhangs:**

| Position          | Sequence | Fidelity |
| ----------------- | -------- | -------- |
| oh1 (5' boundary) | CCTG     | 0.6383   |
| oh2 (3' boundary) | TGTT     | 0.6450   |

**Variants:** 588 mutations, 588 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name             | Length  | 5' OH | 3' OH |
| --- | --------------- | --------------------- | ------- | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile18_sub1  | 1493 nt | ATGG  | AAAA  |
| 2   | 5'WT gene block | bsai_5wt_tile19_sub2  | 1456 nt | AAAA  | CCTG  |
| 3   | Oligo pool      | Tile 19 (588 oligos)  | 152 nt  | CCTG  | AGAA  |
| 4   | Helper plasmid  | helper_plasmid_insert | --      | --    | --    |
| 5   | Enzyme + buffer | BsaI-HFv2 + CutSmart  | --      | --    | --    |

```
  [ATGG]----5'WT sub1----[AAAA]----5'WT sub2----[CCTG]----oligo+BC----[AGAA]
   ATGG                   AAAA                   CCTG                  AGAA 
```

**Set fidelity:** 0.9907 (4 overhangs)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------ | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)      | --      | --    | --    |
| 2   | 3'WT block        | bsmbi_3wt_tile19_sub1    | 837 nt  | TGTT  | AAAA  |
| 3   | 3'WT block        | bsmbi_3wt_tile19_sub2    | 504 nt  | AAAA  | TCAA  |
| 4   | 3'WT block        | bsmbi_3wt_tile7_sub5     | 777 nt  | TCAA  | AGAA  |
| 5   | 3'WT+PolIII block | bsmbi_3wt_tile7_sub6     | 1745 nt | AGAA  | CACC  |
| 6   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1 | --      | --    | --    |

```
  [TGTT]----3'WT sub1----[AAAA]----3'WT sub2----[TCAA]----3'WT sub3----[AGAA]----3'WT+PolIII sub4----[CACC]
   TGTT                   AAAA                   TCAA                   AGAA                          CACC 
```

**Set fidelity:** 0.9911 (5 overhangs)

---

### Tile 20 of 37 -- Codons 1004-1052 (147 nt)

**Boundary overhangs:**

| Position          | Sequence | Fidelity |
| ----------------- | -------- | -------- |
| oh1 (5' boundary) | AAGG     | 0.6552   |
| oh2 (3' boundary) | TGAG     | 0.6546   |

**Variants:** 945 mutations, 945 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name             | Length  | 5' OH | 3' OH |
| --- | --------------- | --------------------- | ------- | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile18_sub1  | 1493 nt | ATGG  | AAAA  |
| 2   | 5'WT gene block | bsai_5wt_tile20_sub2  | 1552 nt | AAAA  | AAGG  |
| 3   | Oligo pool      | Tile 20 (945 oligos)  | 203 nt  | AAGG  | AGAA  |
| 4   | Helper plasmid  | helper_plasmid_insert | --      | --    | --    |
| 5   | Enzyme + buffer | BsaI-HFv2 + CutSmart  | --      | --    | --    |

```
  [ATGG]----5'WT sub1----[AAAA]----5'WT sub2----[AAGG]----oligo+BC----[AGAA]
   ATGG                   AAAA                   AAGG                  AGAA 
```

**Set fidelity:** 0.8660 (4 overhangs)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------ | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)      | --      | --    | --    |
| 2   | 3'WT block        | bsmbi_3wt_tile20_sub1    | 690 nt  | TGAG  | AAAA  |
| 3   | 3'WT block        | bsmbi_3wt_tile19_sub2    | 504 nt  | AAAA  | TCAA  |
| 4   | 3'WT block        | bsmbi_3wt_tile7_sub5     | 777 nt  | TCAA  | AGAA  |
| 5   | 3'WT+PolIII block | bsmbi_3wt_tile7_sub6     | 1745 nt | AGAA  | CACC  |
| 6   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1 | --      | --    | --    |

```
  [TGAG]----3'WT sub1----[AAAA]----3'WT sub2----[TCAA]----3'WT sub3----[AGAA]----3'WT+PolIII sub4----[CACC]
   TGAG                   AAAA                   TCAA                   AGAA                          CACC 
```

**Set fidelity:** 0.9911 (5 overhangs)

---

### Tile 21 of 37 -- Codons 1053-1087 (105 nt)

**Boundary overhangs:**

| Position          | Sequence | Fidelity |
| ----------------- | -------- | -------- |
| oh1 (5' boundary) | ACAT     | 0.6621   |
| oh2 (3' boundary) | AGTC     | 0.5938   |

**Variants:** 651 mutations, 651 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name             | Length  | 5' OH | 3' OH |
| --- | --------------- | --------------------- | ------- | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile18_sub1  | 1493 nt | ATGG  | AAAA  |
| 2   | 5'WT gene block | bsai_5wt_tile21_sub2  | 1699 nt | AAAA  | ACAT  |
| 3   | Oligo pool      | Tile 21 (651 oligos)  | 161 nt  | ACAT  | AGAA  |
| 4   | Helper plasmid  | helper_plasmid_insert | --      | --    | --    |
| 5   | Enzyme + buffer | BsaI-HFv2 + CutSmart  | --      | --    | --    |

```
  [ATGG]----5'WT sub1----[AAAA]----5'WT sub2----[ACAT]----oligo+BC----[AGAA]
   ATGG                   AAAA                   ACAT                  AGAA 
```

**Set fidelity:** 0.9907 (4 overhangs)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------ | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)      | --      | --    | --    |
| 2   | 3'WT block        | bsmbi_3wt_tile21_sub1    | 585 nt  | AGTC  | AAAA  |
| 3   | 3'WT block        | bsmbi_3wt_tile21_sub2    | 804 nt  | AAAA  | TCAA  |
| 4   | 3'WT block        | bsmbi_3wt_tile21_sub3    | 477 nt  | TCAA  | AGAA  |
| 5   | 3'WT+PolIII block | bsmbi_3wt_tile7_sub6     | 1745 nt | AGAA  | CACC  |
| 6   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1 | --      | --    | --    |

```
  [AGTC]----3'WT sub1----[AAAA]----3'WT sub2----[TCAA]----3'WT sub3----[AGAA]----3'WT+PolIII sub4----[CACC]
   AGTC                   AAAA                   TCAA                   AGAA                          CACC 
```

**Set fidelity:** 0.9911 (5 overhangs)

---

### Tile 22 of 37 -- Codons 1088-1134 (141 nt)

**Boundary overhangs:**

| Position          | Sequence | Fidelity |
| ----------------- | -------- | -------- |
| oh1 (5' boundary) | AAAC     | 0.6694   |
| oh2 (3' boundary) | ACCT     | 0.6222   |

**Variants:** 903 mutations, 903 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name             | Length  | 5' OH | 3' OH |
| --- | --------------- | --------------------- | ------- | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile12_sub1  | 995 nt  | ATGG  | AAAA  |
| 2   | 5'WT gene block | bsai_5wt_tile22_sub2  | 1284 nt | AAAA  | TCAA  |
| 3   | 5'WT gene block | bsai_5wt_tile22_sub3  | 1036 nt | TCAA  | AAAC  |
| 4   | Oligo pool      | Tile 22 (903 oligos)  | 197 nt  | AAAC  | AGAA  |
| 5   | Helper plasmid  | helper_plasmid_insert | --      | --    | --    |
| 6   | Enzyme + buffer | BsaI-HFv2 + CutSmart  | --      | --    | --    |

```
  [ATGG]----5'WT sub1----[AAAA]----5'WT sub2----[TCAA]----5'WT sub3----[AAAC]----oligo+BC----[AGAA]
   ATGG                   AAAA                   TCAA                   AAAC                  AGAA 
```

**Set fidelity:** 0.9698 (5 overhangs)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------ | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)      | --      | --    | --    |
| 2   | 3'WT block        | bsmbi_3wt_tile22_sub1    | 678 nt  | ACCT  | AAAA  |
| 3   | 3'WT block        | bsmbi_3wt_tile22_sub2    | 1029 nt | AAAA  | AGAA  |
| 4   | 3'WT+PolIII block | bsmbi_3wt_tile7_sub6     | 1745 nt | AGAA  | CACC  |
| 5   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1 | --      | --    | --    |

```
  [ACCT]----3'WT sub1----[AAAA]----3'WT sub2----[AGAA]----3'WT+PolIII sub3----[CACC]
   ACCT                   AAAA                   AGAA                          CACC 
```

**Set fidelity:** 0.9911 (4 overhangs)

---

### Tile 23 of 37 -- Codons 1135-1210 (228 nt)

**Boundary overhangs:**

| Position          | Sequence | Fidelity |
| ----------------- | -------- | -------- |
| oh1 (5' boundary) | GCTA     | 0.5810   |
| oh2 (3' boundary) | GGCA     | 0.5273   |

**Variants:** 1512 mutations, 1512 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name             | Length  | 5' OH | 3' OH |
| --- | --------------- | --------------------- | ------- | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile23_sub1  | 1004 nt | ATGG  | AAAA  |
| 2   | 5'WT gene block | bsai_5wt_tile23_sub2  | 1275 nt | AAAA  | TCAA  |
| 3   | 5'WT gene block | bsai_5wt_tile23_sub3  | 1177 nt | TCAA  | GCTA  |
| 4   | Oligo pool      | Tile 23 (1512 oligos) | 284 nt  | GCTA  | AGAA  |
| 5   | Helper plasmid  | helper_plasmid_insert | --      | --    | --    |
| 6   | Enzyme + buffer | BsaI-HFv2 + CutSmart  | --      | --    | --    |

```
  [ATGG]----5'WT sub1----[AAAA]----5'WT sub2----[TCAA]----5'WT sub3----[GCTA]----oligo+BC----[AGAA]
   ATGG                   AAAA                   TCAA                   GCTA                  AGAA 
```

**Set fidelity:** 0.9907 (5 overhangs)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------ | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)      | --      | --    | --    |
| 2   | 3'WT block        | bsmbi_3wt_tile23_sub1    | 789 nt  | GGCA  | AAAA  |
| 3   | 3'WT block        | bsmbi_3wt_tile23_sub2    | 690 nt  | AAAA  | AGAA  |
| 4   | 3'WT+PolIII block | bsmbi_3wt_tile7_sub6     | 1745 nt | AGAA  | CACC  |
| 5   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1 | --      | --    | --    |

```
  [GGCA]----3'WT sub1----[AAAA]----3'WT sub2----[AGAA]----3'WT+PolIII sub3----[CACC]
   GGCA                   AAAA                   AGAA                          CACC 
```

**Set fidelity:** 0.9911 (4 overhangs)

---

### Tile 24 of 37 -- Codons 1211-1274 (192 nt)

**Boundary overhangs:**

| Position          | Sequence | Fidelity |
| ----------------- | -------- | -------- |
| oh1 (5' boundary) | ACTG     | 0.5529   |
| oh2 (3' boundary) | CCGA     | 0.6442   |

**Variants:** 1260 mutations, 1260 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name             | Length  | 5' OH | 3' OH |
| --- | --------------- | --------------------- | ------- | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile16_sub1  | 1214 nt | ATGG  | AAAA  |
| 2   | 5'WT gene block | bsai_5wt_tile24_sub2  | 1101 nt | AAAA  | TAAA  |
| 3   | 5'WT gene block | bsai_5wt_tile24_sub3  | 1369 nt | TAAA  | ACTG  |
| 4   | Oligo pool      | Tile 24 (1260 oligos) | 248 nt  | ACTG  | AGAA  |
| 5   | Helper plasmid  | helper_plasmid_insert | --      | --    | --    |
| 6   | Enzyme + buffer | BsaI-HFv2 + CutSmart  | --      | --    | --    |

```
  [ATGG]----5'WT sub1----[AAAA]----5'WT sub2----[TAAA]----5'WT sub3----[ACTG]----oligo+BC----[AGAA]
   ATGG                   AAAA                   TAAA                   ACTG                  AGAA 
```

**Set fidelity:** 0.9764 (5 overhangs)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------ | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)      | --      | --    | --    |
| 2   | 3'WT block        | bsmbi_3wt_tile24_sub1    | 597 nt  | CCGA  | AAAA  |
| 3   | 3'WT block        | bsmbi_3wt_tile23_sub2    | 690 nt  | AAAA  | AGAA  |
| 4   | 3'WT+PolIII block | bsmbi_3wt_tile7_sub6     | 1745 nt | AGAA  | CACC  |
| 5   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1 | --      | --    | --    |

```
  [CCGA]----3'WT sub1----[AAAA]----3'WT sub2----[AGAA]----3'WT+PolIII sub3----[CACC]
   CCGA                   AAAA                   AGAA                          CACC 
```

**Set fidelity:** 0.9911 (4 overhangs)

---

### Tile 25 of 37 -- Codons 1275-1329 (165 nt)

**Boundary overhangs:**

| Position          | Sequence | Fidelity |
| ----------------- | -------- | -------- |
| oh1 (5' boundary) | GCAA     | 0.7543   |
| oh2 (3' boundary) | GTAT     | 0.6602   |

**Variants:** 1071 mutations, 1071 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name             | Length  | 5' OH | 3' OH |
| --- | --------------- | --------------------- | ------- | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile16_sub1  | 1214 nt | ATGG  | AAAA  |
| 2   | 5'WT gene block | bsai_5wt_tile25_sub2  | 1371 nt | AAAA  | TAAA  |
| 3   | 5'WT gene block | bsai_5wt_tile25_sub3  | 1291 nt | TAAA  | GCAA  |
| 4   | Oligo pool      | Tile 25 (1071 oligos) | 221 nt  | GCAA  | AGAA  |
| 5   | Helper plasmid  | helper_plasmid_insert | --      | --    | --    |
| 6   | Enzyme + buffer | BsaI-HFv2 + CutSmart  | --      | --    | --    |

```
  [ATGG]----5'WT sub1----[AAAA]----5'WT sub2----[TAAA]----5'WT sub3----[GCAA]----oligo+BC----[AGAA]
   ATGG                   AAAA                   TAAA                   GCAA                  AGAA 
```

**Set fidelity:** 0.9764 (5 overhangs)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------ | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)      | --      | --    | --    |
| 2   | 3'WT block        | bsmbi_3wt_tile25_sub1    | 477 nt  | GTAT  | AAAA  |
| 3   | 3'WT block        | bsmbi_3wt_tile25_sub2    | 837 nt  | AAAA  | TCTA  |
| 4   | 3'WT+PolIII block | bsmbi_3wt_tile25_sub3    | 1553 nt | TCTA  | CACC  |
| 5   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1 | --      | --    | --    |

```
  [GTAT]----3'WT sub1----[AAAA]----3'WT sub2----[TCTA]----3'WT+PolIII sub3----[CACC]
   GTAT                   AAAA                   TCTA                          CACC 
```

**Set fidelity:** 1.0000 (4 overhangs)

---

### Tile 26 of 37 -- Codons 1330-1373 (132 nt)

**Boundary overhangs:**

| Position          | Sequence | Fidelity |
| ----------------- | -------- | -------- |
| oh1 (5' boundary) | GGTC     | 0.5144   |
| oh2 (3' boundary) | TAAA     | 0.9392   |

**Variants:** 840 mutations, 840 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name             | Length  | 5' OH | 3' OH |
| --- | --------------- | --------------------- | ------- | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile16_sub1  | 1214 nt | ATGG  | AAAA  |
| 2   | 5'WT gene block | bsai_5wt_tile25_sub2  | 1371 nt | AAAA  | TAAA  |
| 3   | 5'WT gene block | bsai_5wt_tile26_sub3  | 1456 nt | TAAA  | GGTC  |
| 4   | Oligo pool      | Tile 26 (840 oligos)  | 188 nt  | GGTC  | AGAA  |
| 5   | Helper plasmid  | helper_plasmid_insert | --      | --    | --    |
| 6   | Enzyme + buffer | BsaI-HFv2 + CutSmart  | --      | --    | --    |

```
  [ATGG]----5'WT sub1----[AAAA]----5'WT sub2----[TAAA]----5'WT sub3----[GGTC]----oligo+BC----[AGAA]
   ATGG                   AAAA                   TAAA                   GGTC                  AGAA 
```

**Set fidelity:** 0.9764 (5 overhangs)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------ | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)      | --      | --    | --    |
| 2   | 3'WT block        | bsmbi_3wt_tile26_sub1    | 537 nt  | TAAA  | AAAA  |
| 3   | 3'WT block        | bsmbi_3wt_tile26_sub2    | 645 nt  | AAAA  | TCTA  |
| 4   | 3'WT+PolIII block | bsmbi_3wt_tile25_sub3    | 1553 nt | TCTA  | CACC  |
| 5   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1 | --      | --    | --    |

```
  [TAAA]----3'WT sub1----[AAAA]----3'WT sub2----[TCTA]----3'WT+PolIII sub3----[CACC]
   TAAA                   AAAA                   TCTA                          CACC 
```

**Set fidelity:** 0.9809 (4 overhangs)

---

### Tile 27 of 37 -- Codons 1374-1415 (126 nt)

**Boundary overhangs:**

| Position          | Sequence | Fidelity |
| ----------------- | -------- | -------- |
| oh1 (5' boundary) | CGAT     | 0.6118   |
| oh2 (3' boundary) | CCAA     | 0.8439   |

**Variants:** 798 mutations, 798 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name             | Length  | 5' OH | 3' OH |
| --- | --------------- | --------------------- | ------- | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile18_sub1  | 1493 nt | ATGG  | AAAA  |
| 2   | 5'WT gene block | bsai_5wt_tile27_sub2  | 1266 nt | AAAA  | TAAA  |
| 3   | 5'WT gene block | bsai_5wt_tile27_sub3  | 1414 nt | TAAA  | CGAT  |
| 4   | Oligo pool      | Tile 27 (798 oligos)  | 182 nt  | CGAT  | AGAA  |
| 5   | Helper plasmid  | helper_plasmid_insert | --      | --    | --    |
| 6   | Enzyme + buffer | BsaI-HFv2 + CutSmart  | --      | --    | --    |

```
  [ATGG]----5'WT sub1----[AAAA]----5'WT sub2----[TAAA]----5'WT sub3----[CGAT]----oligo+BC----[AGAA]
   ATGG                   AAAA                   TAAA                   CGAT                  AGAA 
```

**Set fidelity:** 0.9764 (5 overhangs)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------ | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)      | --      | --    | --    |
| 2   | 3'WT block        | bsmbi_3wt_tile27_sub1    | 411 nt  | CCAA  | AAAA  |
| 3   | 3'WT block        | bsmbi_3wt_tile26_sub2    | 645 nt  | AAAA  | TCTA  |
| 4   | 3'WT+PolIII block | bsmbi_3wt_tile25_sub3    | 1553 nt | TCTA  | CACC  |
| 5   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1 | --      | --    | --    |

```
  [CCAA]----3'WT sub1----[AAAA]----3'WT sub2----[TCTA]----3'WT+PolIII sub3----[CACC]
   CCAA                   AAAA                   TCTA                          CACC 
```

**Set fidelity:** 1.0000 (4 overhangs)

---

### Tile 28 of 37 -- Codons 1416-1479 (192 nt)

**Boundary overhangs:**

| Position          | Sequence | Fidelity |
| ----------------- | -------- | -------- |
| oh1 (5' boundary) | GAGC     | 0.5446   |
| oh2 (3' boundary) | ATCC     | 0.6015   |

**Variants:** 1260 mutations, 1260 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name             | Length  | 5' OH | 3' OH |
| --- | --------------- | --------------------- | ------- | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile18_sub1  | 1493 nt | ATGG  | AAAA  |
| 2   | 5'WT gene block | bsai_5wt_tile27_sub2  | 1266 nt | AAAA  | TAAA  |
| 3   | 5'WT gene block | bsai_5wt_tile28_sub3  | 1540 nt | TAAA  | GAGC  |
| 4   | Oligo pool      | Tile 28 (1260 oligos) | 248 nt  | GAGC  | AGAA  |
| 5   | Helper plasmid  | helper_plasmid_insert | --      | --    | --    |
| 6   | Enzyme + buffer | BsaI-HFv2 + CutSmart  | --      | --    | --    |

```
  [ATGG]----5'WT sub1----[AAAA]----5'WT sub2----[TAAA]----5'WT sub3----[GAGC]----oligo+BC----[AGAA]
   ATGG                   AAAA                   TAAA                   GAGC                  AGAA 
```

**Set fidelity:** 0.9764 (5 overhangs)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------ | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)      | --      | --    | --    |
| 2   | 3'WT block        | bsmbi_3wt_tile28_sub1    | 447 nt  | ATCC  | AAAA  |
| 3   | 3'WT block        | bsmbi_3wt_tile28_sub2    | 417 nt  | AAAA  | TCTA  |
| 4   | 3'WT+PolIII block | bsmbi_3wt_tile25_sub3    | 1553 nt | TCTA  | CACC  |
| 5   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1 | --      | --    | --    |

```
  [ATCC]----3'WT sub1----[AAAA]----3'WT sub2----[TCTA]----3'WT+PolIII sub3----[CACC]
   ATCC                   AAAA                   TCTA                          CACC 
```

**Set fidelity:** 1.0000 (4 overhangs)

---

### Tile 29 of 37 -- Codons 1480-1520 (123 nt)

**Boundary overhangs:**

| Position          | Sequence | Fidelity |
| ----------------- | -------- | -------- |
| oh1 (5' boundary) | CTAC     | 0.6583   |
| oh2 (3' boundary) | CACT     | 0.5337   |

**Variants:** 777 mutations, 777 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name             | Length  | 5' OH | 3' OH |
| --- | --------------- | --------------------- | ------- | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile18_sub1  | 1493 nt | ATGG  | AAAA  |
| 2   | 5'WT gene block | bsai_5wt_tile29_sub2  | 1371 nt | AAAA  | TAAA  |
| 3   | 5'WT gene block | bsai_5wt_tile29_sub3  | 1627 nt | TAAA  | CTAC  |
| 4   | Oligo pool      | Tile 29 (777 oligos)  | 179 nt  | CTAC  | AGAA  |
| 5   | Helper plasmid  | helper_plasmid_insert | --      | --    | --    |
| 6   | Enzyme + buffer | BsaI-HFv2 + CutSmart  | --      | --    | --    |

```
  [ATGG]----5'WT sub1----[AAAA]----5'WT sub2----[TAAA]----5'WT sub3----[CTAC]----oligo+BC----[AGAA]
   ATGG                   AAAA                   TAAA                   CTAC                  AGAA 
```

**Set fidelity:** 0.9764 (5 overhangs)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------ | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)      | --      | --    | --    |
| 2   | 3'WT block        | bsmbi_3wt_tile29_sub1    | 324 nt  | CACT  | AAAA  |
| 3   | 3'WT block        | bsmbi_3wt_tile28_sub2    | 417 nt  | AAAA  | TCTA  |
| 4   | 3'WT+PolIII block | bsmbi_3wt_tile25_sub3    | 1553 nt | TCTA  | CACC  |
| 5   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1 | --      | --    | --    |

```
  [CACT]----3'WT sub1----[AAAA]----3'WT sub2----[TCTA]----3'WT+PolIII sub3----[CACC]
   CACT                   AAAA                   TCTA                          CACC 
```

**Set fidelity:** 0.7829 (4 overhangs)

---

### Tile 30 of 37 -- Codons 1521-1562 (126 nt)

**Boundary overhangs:**

| Position          | Sequence | Fidelity |
| ----------------- | -------- | -------- |
| oh1 (5' boundary) | TACC     | 0.7054   |
| oh2 (3' boundary) | AACC     | 0.5451   |

**Variants:** 798 mutations, 798 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name             | Length  | 5' OH | 3' OH |
| --- | --------------- | --------------------- | ------- | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile18_sub1  | 1493 nt | ATGG  | AAAA  |
| 2   | 5'WT gene block | bsai_5wt_tile30_sub2  | 1668 nt | AAAA  | TCAA  |
| 3   | 5'WT gene block | bsai_5wt_tile30_sub3  | 1453 nt | TCAA  | TACC  |
| 4   | Oligo pool      | Tile 30 (798 oligos)  | 182 nt  | TACC  | AGAA  |
| 5   | Helper plasmid  | helper_plasmid_insert | --      | --    | --    |
| 6   | Enzyme + buffer | BsaI-HFv2 + CutSmart  | --      | --    | --    |

```
  [ATGG]----5'WT sub1----[AAAA]----5'WT sub2----[TCAA]----5'WT sub3----[TACC]----oligo+BC----[AGAA]
   ATGG                   AAAA                   TCAA                   TACC                  AGAA 
```

**Set fidelity:** 0.9907 (5 overhangs)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------ | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)      | --      | --    | --    |
| 2   | 3'WT block        | bsmbi_3wt_tile30_sub1    | 456 nt  | AACC  | AAAA  |
| 3   | 3'WT+PolIII block | bsmbi_3wt_tile30_sub2    | 1694 nt | AAAA  | CACC  |
| 4   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1 | --      | --    | --    |

```
  [AACC]----3'WT sub1----[AAAA]----3'WT+PolIII sub2----[CACC]
   AACC                   AAAA                          CACC 
```

**Set fidelity:** 0.8550 (3 overhangs)

---

### Tile 31 of 37 -- Codons 1563-1623 (183 nt)

**Boundary overhangs:**

| Position          | Sequence | Fidelity |
| ----------------- | -------- | -------- |
| oh1 (5' boundary) | GTGT     | 0.5081   |
| oh2 (3' boundary) | CTAT     | 0.7299   |

**Variants:** 1197 mutations, 1197 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name             | Length  | 5' OH | 3' OH |
| --- | --------------- | --------------------- | ------- | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile18_sub1  | 1493 nt | ATGG  | AAAA  |
| 2   | 5'WT gene block | bsai_5wt_tile30_sub2  | 1668 nt | AAAA  | TCAA  |
| 3   | 5'WT gene block | bsai_5wt_tile31_sub3  | 1579 nt | TCAA  | GTGT  |
| 4   | Oligo pool      | Tile 31 (1197 oligos) | 239 nt  | GTGT  | AGAA  |
| 5   | Helper plasmid  | helper_plasmid_insert | --      | --    | --    |
| 6   | Enzyme + buffer | BsaI-HFv2 + CutSmart  | --      | --    | --    |

```
  [ATGG]----5'WT sub1----[AAAA]----5'WT sub2----[TCAA]----5'WT sub3----[GTGT]----oligo+BC----[AGAA]
   ATGG                   AAAA                   TCAA                   GTGT                  AGAA 
```

**Set fidelity:** 0.9907 (5 overhangs)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------ | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)      | --      | --    | --    |
| 2   | 3'WT block        | bsmbi_3wt_tile31_sub1    | 414 nt  | CTAT  | TCTA  |
| 3   | 3'WT+PolIII block | bsmbi_3wt_tile25_sub3    | 1553 nt | TCTA  | CACC  |
| 4   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1 | --      | --    | --    |

```
  [CTAT]----3'WT sub1----[TCTA]----3'WT+PolIII sub2----[CACC]
   CTAT                   TCTA                          CACC 
```

**Set fidelity:** 1.0000 (3 overhangs)

---

### Tile 32 of 37 -- Codons 1624-1677 (162 nt)

**Boundary overhangs:**

| Position          | Sequence | Fidelity |
| ----------------- | -------- | -------- |
| oh1 (5' boundary) | AGCA     | 0.5690   |
| oh2 (3' boundary) | GGGT     | 0.5294   |

**Variants:** 1050 mutations, 1050 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name             | Length  | 5' OH | 3' OH |
| --- | --------------- | --------------------- | ------- | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile18_sub1  | 1493 nt | ATGG  | AAAA  |
| 2   | 5'WT gene block | bsai_5wt_tile30_sub2  | 1668 nt | AAAA  | TCAA  |
| 3   | 5'WT gene block | bsai_5wt_tile32_sub3  | 1762 nt | TCAA  | AGCA  |
| 4   | Oligo pool      | Tile 32 (1050 oligos) | 218 nt  | AGCA  | AGAA  |
| 5   | Helper plasmid  | helper_plasmid_insert | --      | --    | --    |
| 6   | Enzyme + buffer | BsaI-HFv2 + CutSmart  | --      | --    | --    |

```
  [ATGG]----5'WT sub1----[AAAA]----5'WT sub2----[TCAA]----5'WT sub3----[AGCA]----oligo+BC----[AGAA]
   ATGG                   AAAA                   TCAA                   AGCA                  AGAA 
```

**Set fidelity:** 0.9721 (5 overhangs)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------ | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)      | --      | --    | --    |
| 2   | 3'WT+PolIII block | bsmbi_3wt_tile32         | 1787 nt | GGGT  | CACC  |
| 3   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1 | --      | --    | --    |

```
  [GGGT]----3'WT+PolIII----[CACC]
   GGGT                     CACC 
```

**Set fidelity:** 1.0000 (2 overhangs)

---

### Tile 33 of 37 -- Codons 1678-1718 (123 nt)

**Boundary overhangs:**

| Position          | Sequence | Fidelity |
| ----------------- | -------- | -------- |
| oh1 (5' boundary) | GGAC     | 0.5754   |
| oh2 (3' boundary) | CCAG     | 0.6122   |

**Variants:** 777 mutations, 777 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name             | Length  | 5' OH | 3' OH |
| --- | --------------- | --------------------- | ------- | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile33_sub1  | 1622 nt | ATGG  | AAAA  |
| 2   | 5'WT gene block | bsai_5wt_tile33_sub2  | 1674 nt | AAAA  | TAAA  |
| 3   | 5'WT gene block | bsai_5wt_tile33_sub3  | 1789 nt | TAAA  | GGAC  |
| 4   | Oligo pool      | Tile 33 (777 oligos)  | 179 nt  | GGAC  | AGAA  |
| 5   | Helper plasmid  | helper_plasmid_insert | --      | --    | --    |
| 6   | Enzyme + buffer | BsaI-HFv2 + CutSmart  | --      | --    | --    |

```
  [ATGG]----5'WT sub1----[AAAA]----5'WT sub2----[TAAA]----5'WT sub3----[GGAC]----oligo+BC----[AGAA]
   ATGG                   AAAA                   TAAA                   GGAC                  AGAA 
```

**Set fidelity:** 0.9764 (5 overhangs)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------ | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)      | --      | --    | --    |
| 2   | 3'WT+PolIII block | bsmbi_3wt_tile33         | 1664 nt | CCAG  | CACC  |
| 3   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1 | --      | --    | --    |

```
  [CCAG]----3'WT+PolIII----[CACC]
   CCAG                     CACC 
```

**Set fidelity:** 1.0000 (2 overhangs)

---

### Tile 34 of 37 -- Codons 1719-1792 (222 nt)

**Boundary overhangs:**

| Position          | Sequence | Fidelity |
| ----------------- | -------- | -------- |
| oh1 (5' boundary) | GTCA     | 0.5915   |
| oh2 (3' boundary) | GCAT     | 0.5827   |

**Variants:** 1470 mutations, 1470 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name             | Length  | 5' OH | 3' OH |
| --- | --------------- | --------------------- | ------- | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile16_sub1  | 1214 nt | ATGG  | AAAA  |
| 2   | 5'WT gene block | bsai_5wt_tile25_sub2  | 1371 nt | AAAA  | TAAA  |
| 3   | 5'WT gene block | bsai_5wt_tile34_sub3  | 1179 nt | TAAA  | TCAA  |
| 4   | 5'WT gene block | bsai_5wt_tile34_sub4  | 1462 nt | TCAA  | GTCA  |
| 5   | Oligo pool      | Tile 34 (1470 oligos) | 278 nt  | GTCA  | AGAA  |
| 6   | Helper plasmid  | helper_plasmid_insert | --      | --    | --    |
| 7   | Enzyme + buffer | BsaI-HFv2 + CutSmart  | --      | --    | --    |

```
  [ATGG]----5'WT sub1----[AAAA]----5'WT sub2----[TAAA]----5'WT sub3----[TCAA]----5'WT sub4----[GTCA]----oligo+BC----[AGAA]
   ATGG                   AAAA                   TAAA                   TCAA                   GTCA                  AGAA 
```

**Set fidelity:** 0.9764 (6 overhangs)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------ | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)      | --      | --    | --    |
| 2   | 3'WT+PolIII block | bsmbi_3wt_tile34         | 1442 nt | GCAT  | CACC  |
| 3   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1 | --      | --    | --    |

```
  [GCAT]----3'WT+PolIII----[CACC]
   GCAT                     CACC 
```

**Set fidelity:** 1.0000 (2 overhangs)

---

### Tile 35 of 37 -- Codons 1793-1824 (96 nt)

**Boundary overhangs:**

| Position          | Sequence | Fidelity |
| ----------------- | -------- | -------- |
| oh1 (5' boundary) | GATG     | 0.4742   |
| oh2 (3' boundary) | GATT     | 0.6417   |

**Variants:** 588 mutations, 588 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name             | Length  | 5' OH | 3' OH |
| --- | --------------- | --------------------- | ------- | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile16_sub1  | 1214 nt | ATGG  | AAAA  |
| 2   | 5'WT gene block | bsai_5wt_tile25_sub2  | 1371 nt | AAAA  | TAAA  |
| 3   | 5'WT gene block | bsai_5wt_tile35_sub3  | 1404 nt | TAAA  | AAGA  |
| 4   | 5'WT gene block | bsai_5wt_tile35_sub4  | 1459 nt | AAGA  | GATG  |
| 5   | Oligo pool      | Tile 35 (588 oligos)  | 152 nt  | GATG  | AGAA  |
| 6   | Helper plasmid  | helper_plasmid_insert | --      | --    | --    |
| 7   | Enzyme + buffer | BsaI-HFv2 + CutSmart  | --      | --    | --    |

```
  [ATGG]----5'WT sub1----[AAAA]----5'WT sub2----[TAAA]----5'WT sub3----[AAGA]----5'WT sub4----[GATG]----oligo+BC----[AGAA]
   ATGG                   AAAA                   TAAA                   AAGA                   GATG                  AGAA 
```

**Set fidelity:** 0.9676 (6 overhangs)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------ | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)      | --      | --    | --    |
| 2   | 3'WT+PolIII block | bsmbi_3wt_tile35         | 1346 nt | GATT  | CACC  |
| 3   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1 | --      | --    | --    |

```
  [GATT]----3'WT+PolIII----[CACC]
   GATT                     CACC 
```

**Set fidelity:** 1.0000 (2 overhangs)

---

### Tile 36 of 37 -- Codons 1825-1870 (138 nt)

**Boundary overhangs:**

| Position          | Sequence | Fidelity |
| ----------------- | -------- | -------- |
| oh1 (5' boundary) | CAGC     | 0.4815   |
| oh2 (3' boundary) | TGTG     | 0.5408   |

**Variants:** 882 mutations, 882 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name             | Length  | 5' OH | 3' OH |
| --- | --------------- | --------------------- | ------- | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile18_sub1  | 1493 nt | ATGG  | AAAA  |
| 2   | 5'WT gene block | bsai_5wt_tile27_sub2  | 1266 nt | AAAA  | TAAA  |
| 3   | 5'WT gene block | bsai_5wt_tile36_sub3  | 1473 nt | TAAA  | AAGA  |
| 4   | 5'WT gene block | bsai_5wt_tile36_sub4  | 1312 nt | AAGA  | CAGC  |
| 5   | Oligo pool      | Tile 36 (882 oligos)  | 194 nt  | CAGC  | AGAA  |
| 6   | Helper plasmid  | helper_plasmid_insert | --      | --    | --    |
| 7   | Enzyme + buffer | BsaI-HFv2 + CutSmart  | --      | --    | --    |

```
  [ATGG]----5'WT sub1----[AAAA]----5'WT sub2----[TAAA]----5'WT sub3----[AAGA]----5'WT sub4----[CAGC]----oligo+BC----[AGAA]
   ATGG                   AAAA                   TAAA                   AAGA                   CAGC                  AGAA 
```

**Set fidelity:** 0.9676 (6 overhangs)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------ | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)      | --      | --    | --    |
| 2   | 3'WT+PolIII block | bsmbi_3wt_tile36         | 1208 nt | TGTG  | CACC  |
| 3   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1 | --      | --    | --    |

```
  [TGTG]----3'WT+PolIII----[CACC]
   TGTG                     CACC 
```

**Set fidelity:** 1.0000 (2 overhangs)

---

### Tile 37 of 37 -- Codons 1871-1902 (96 nt)

**Boundary overhangs:**

| Position          | Sequence | Fidelity |
| ----------------- | -------- | -------- |
| oh1 (5' boundary) | CTGC     | 0.5642   |
| oh2 (3' boundary) | ATAG     | 0.7330   |

**Variants:** 588 mutations, 588 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name             | Length  | 5' OH | 3' OH |
| --- | --------------- | --------------------- | ------- | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile18_sub1  | 1493 nt | ATGG  | AAAA  |
| 2   | 5'WT gene block | bsai_5wt_tile27_sub2  | 1266 nt | AAAA  | TAAA  |
| 3   | 5'WT gene block | bsai_5wt_tile37_sub3  | 1605 nt | TAAA  | TCAA  |
| 4   | 5'WT gene block | bsai_5wt_tile37_sub4  | 1318 nt | TCAA  | CTGC  |
| 5   | Oligo pool      | Tile 37 (588 oligos)  | 152 nt  | CTGC  | AGAA  |
| 6   | Helper plasmid  | helper_plasmid_insert | --      | --    | --    |
| 7   | Enzyme + buffer | BsaI-HFv2 + CutSmart  | --      | --    | --    |

```
  [ATGG]----5'WT sub1----[AAAA]----5'WT sub2----[TAAA]----5'WT sub3----[TCAA]----5'WT sub4----[CTGC]----oligo+BC----[AGAA]
   ATGG                   AAAA                   TAAA                   TCAA                   CTGC                  AGAA 
```

**Set fidelity:** 0.9764 (6 overhangs)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component            | Part name                | Length  | 5' OH | 3' OH |
| --- | -------------------- | ------------------------ | ------- | ----- | ----- |
| 1   | BsaI product         | (in helper plasmid)      | --      | --    | --    |
| 2   | PolIII-only fragment | bsmbi_polIII_tile37      | 1112 nt | ATAG  | CACC  |
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

**Total blocks:** 147

| Block name            | Length (nt) | Enzyme type | Gene region                                                                                                                                                                                                                                                                                                                                                                   |
| --------------------- | ----------- | ----------- | ----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| bsai_5wt_tile10       | 1593        | BsaI        | 5wt_tile10                                                                                                                                                                                                                                                                                                                                                                    |
| bsai_5wt_tile11       | 1740        | BsaI        | 5wt_tile11                                                                                                                                                                                                                                                                                                                                                                    |
| bsai_5wt_tile12_sub1  | 995         | BsaI        | 5wt_tile12_sub1;5wt_tile13_sub1;5wt_tile14_sub1;5wt_tile15_sub1;5wt_tile22_sub1                                                                                                                                                                                                                                                                                               |
| bsai_5wt_tile12_sub2  | 958         | BsaI        | 5wt_tile12_sub2                                                                                                                                                                                                                                                                                                                                                               |
| bsai_5wt_tile13_sub2  | 1084        | BsaI        | 5wt_tile13_sub2                                                                                                                                                                                                                                                                                                                                                               |
| bsai_5wt_tile14_sub2  | 1201        | BsaI        | 5wt_tile14_sub2                                                                                                                                                                                                                                                                                                                                                               |
| bsai_5wt_tile15_sub2  | 1285        | BsaI        | 5wt_tile15_sub2                                                                                                                                                                                                                                                                                                                                                               |
| bsai_5wt_tile16_sub1  | 1214        | BsaI        | 5wt_tile16_sub1;5wt_tile17_sub1;5wt_tile24_sub1;5wt_tile25_sub1;5wt_tile26_sub1;5wt_tile34_sub1;5wt_tile35_sub1                                                                                                                                                                                                                                                               |
| bsai_5wt_tile16_sub2  | 1234        | BsaI        | 5wt_tile16_sub2                                                                                                                                                                                                                                                                                                                                                               |
| bsai_5wt_tile17_sub2  | 1387        | BsaI        | 5wt_tile17_sub2                                                                                                                                                                                                                                                                                                                                                               |
| bsai_5wt_tile18_sub1  | 1493        | BsaI        | 5wt_tile18_sub1;5wt_tile19_sub1;5wt_tile20_sub1;5wt_tile21_sub1;5wt_tile27_sub1;5wt_tile28_sub1;5wt_tile29_sub1;5wt_tile30_sub1;5wt_tile31_sub1;5wt_tile32_sub1;5wt_tile36_sub1;5wt_tile37_sub1                                                                                                                                                                               |
| bsai_5wt_tile18_sub2  | 1249        | BsaI        | 5wt_tile18_sub2                                                                                                                                                                                                                                                                                                                                                               |
| bsai_5wt_tile19_sub2  | 1456        | BsaI        | 5wt_tile19_sub2                                                                                                                                                                                                                                                                                                                                                               |
| bsai_5wt_tile2        | 117         | BsaI        | 5wt_tile2                                                                                                                                                                                                                                                                                                                                                                     |
| bsai_5wt_tile20_sub2  | 1552        | BsaI        | 5wt_tile20_sub2                                                                                                                                                                                                                                                                                                                                                               |
| bsai_5wt_tile21_sub2  | 1699        | BsaI        | 5wt_tile21_sub2                                                                                                                                                                                                                                                                                                                                                               |
| bsai_5wt_tile22_sub2  | 1284        | BsaI        | 5wt_tile22_sub2                                                                                                                                                                                                                                                                                                                                                               |
| bsai_5wt_tile22_sub3  | 1036        | BsaI        | 5wt_tile22_sub3                                                                                                                                                                                                                                                                                                                                                               |
| bsai_5wt_tile23_sub1  | 1004        | BsaI        | 5wt_tile23_sub1                                                                                                                                                                                                                                                                                                                                                               |
| bsai_5wt_tile23_sub2  | 1275        | BsaI        | 5wt_tile23_sub2                                                                                                                                                                                                                                                                                                                                                               |
| bsai_5wt_tile23_sub3  | 1177        | BsaI        | 5wt_tile23_sub3                                                                                                                                                                                                                                                                                                                                                               |
| bsai_5wt_tile24_sub2  | 1101        | BsaI        | 5wt_tile24_sub2                                                                                                                                                                                                                                                                                                                                                               |
| bsai_5wt_tile24_sub3  | 1369        | BsaI        | 5wt_tile24_sub3                                                                                                                                                                                                                                                                                                                                                               |
| bsai_5wt_tile25_sub2  | 1371        | BsaI        | 5wt_tile25_sub2;5wt_tile26_sub2;5wt_tile34_sub2;5wt_tile35_sub2                                                                                                                                                                                                                                                                                                               |
| bsai_5wt_tile25_sub3  | 1291        | BsaI        | 5wt_tile25_sub3                                                                                                                                                                                                                                                                                                                                                               |
| bsai_5wt_tile26_sub3  | 1456        | BsaI        | 5wt_tile26_sub3                                                                                                                                                                                                                                                                                                                                                               |
| bsai_5wt_tile27_sub2  | 1266        | BsaI        | 5wt_tile27_sub2;5wt_tile28_sub2;5wt_tile36_sub2;5wt_tile37_sub2                                                                                                                                                                                                                                                                                                               |
| bsai_5wt_tile27_sub3  | 1414        | BsaI        | 5wt_tile27_sub3                                                                                                                                                                                                                                                                                                                                                               |
| bsai_5wt_tile28_sub3  | 1540        | BsaI        | 5wt_tile28_sub3                                                                                                                                                                                                                                                                                                                                                               |
| bsai_5wt_tile29_sub2  | 1371        | BsaI        | 5wt_tile29_sub2                                                                                                                                                                                                                                                                                                                                                               |
| bsai_5wt_tile29_sub3  | 1627        | BsaI        | 5wt_tile29_sub3                                                                                                                                                                                                                                                                                                                                                               |
| bsai_5wt_tile3        | 267         | BsaI        | 5wt_tile3                                                                                                                                                                                                                                                                                                                                                                     |
| bsai_5wt_tile30_sub2  | 1668        | BsaI        | 5wt_tile30_sub2;5wt_tile31_sub2;5wt_tile32_sub2                                                                                                                                                                                                                                                                                                                               |
| bsai_5wt_tile30_sub3  | 1453        | BsaI        | 5wt_tile30_sub3                                                                                                                                                                                                                                                                                                                                                               |
| bsai_5wt_tile31_sub3  | 1579        | BsaI        | 5wt_tile31_sub3                                                                                                                                                                                                                                                                                                                                                               |
| bsai_5wt_tile32_sub3  | 1762        | BsaI        | 5wt_tile32_sub3                                                                                                                                                                                                                                                                                                                                                               |
| bsai_5wt_tile33_sub1  | 1622        | BsaI        | 5wt_tile33_sub1                                                                                                                                                                                                                                                                                                                                                               |
| bsai_5wt_tile33_sub2  | 1674        | BsaI        | 5wt_tile33_sub2                                                                                                                                                                                                                                                                                                                                                               |
| bsai_5wt_tile33_sub3  | 1789        | BsaI        | 5wt_tile33_sub3                                                                                                                                                                                                                                                                                                                                                               |
| bsai_5wt_tile34_sub3  | 1179        | BsaI        | 5wt_tile34_sub3                                                                                                                                                                                                                                                                                                                                                               |
| bsai_5wt_tile34_sub4  | 1462        | BsaI        | 5wt_tile34_sub4                                                                                                                                                                                                                                                                                                                                                               |
| bsai_5wt_tile35_sub3  | 1404        | BsaI        | 5wt_tile35_sub3                                                                                                                                                                                                                                                                                                                                                               |
| bsai_5wt_tile35_sub4  | 1459        | BsaI        | 5wt_tile35_sub4                                                                                                                                                                                                                                                                                                                                                               |
| bsai_5wt_tile36_sub3  | 1473        | BsaI        | 5wt_tile36_sub3                                                                                                                                                                                                                                                                                                                                                               |
| bsai_5wt_tile36_sub4  | 1312        | BsaI        | 5wt_tile36_sub4                                                                                                                                                                                                                                                                                                                                                               |
| bsai_5wt_tile37_sub3  | 1605        | BsaI        | 5wt_tile37_sub3                                                                                                                                                                                                                                                                                                                                                               |
| bsai_5wt_tile37_sub4  | 1318        | BsaI        | 5wt_tile37_sub4                                                                                                                                                                                                                                                                                                                                                               |
| bsai_5wt_tile4        | 438         | BsaI        | 5wt_tile4                                                                                                                                                                                                                                                                                                                                                                     |
| bsai_5wt_tile5        | 597         | BsaI        | 5wt_tile5                                                                                                                                                                                                                                                                                                                                                                     |
| bsai_5wt_tile6        | 771         | BsaI        | 5wt_tile6                                                                                                                                                                                                                                                                                                                                                                     |
| bsai_5wt_tile7        | 1005        | BsaI        | 5wt_tile7                                                                                                                                                                                                                                                                                                                                                                     |
| bsai_5wt_tile8        | 1200        | BsaI        | 5wt_tile8                                                                                                                                                                                                                                                                                                                                                                     |
| bsai_5wt_tile9        | 1422        | BsaI        | 5wt_tile9                                                                                                                                                                                                                                                                                                                                                                     |
| bsmbi_3wt_tile1_sub1  | 900         | BsmBI       | 3wt_tile1_sub1                                                                                                                                                                                                                                                                                                                                                                |
| bsmbi_3wt_tile1_sub2  | 1044        | BsmBI       | 3wt_tile1_sub2                                                                                                                                                                                                                                                                                                                                                                |
| bsmbi_3wt_tile1_sub3  | 876         | BsmBI       | 3wt_tile1_sub3;3wt_tile2_sub3                                                                                                                                                                                                                                                                                                                                                 |
| bsmbi_3wt_tile1_sub4  | 870         | BsmBI       | 3wt_tile1_sub4                                                                                                                                                                                                                                                                                                                                                                |
| bsmbi_3wt_tile1_sub5  | 957         | BsmBI       | 3wt_tile1_sub5                                                                                                                                                                                                                                                                                                                                                                |
| bsmbi_3wt_tile1_sub6  | 2162        | BsmBI       | 3wt_polIII_tile1_sub6;3wt_polIII_tile2_sub6                                                                                                                                                                                                                                                                                                                                   |
| bsmbi_3wt_tile10_sub1 | 768         | BsmBI       | 3wt_tile10_sub1                                                                                                                                                                                                                                                                                                                                                               |
| bsmbi_3wt_tile10_sub2 | 936         | BsmBI       | 3wt_tile10_sub2                                                                                                                                                                                                                                                                                                                                                               |
| bsmbi_3wt_tile10_sub4 | 618         | BsmBI       | 3wt_tile10_sub4                                                                                                                                                                                                                                                                                                                                                               |
| bsmbi_3wt_tile10_sub5 | 2036        | BsmBI       | 3wt_polIII_tile10_sub5                                                                                                                                                                                                                                                                                                                                                        |
| bsmbi_3wt_tile11_sub1 | 693         | BsmBI       | 3wt_tile11_sub1                                                                                                                                                                                                                                                                                                                                                               |
| bsmbi_3wt_tile11_sub2 | 816         | BsmBI       | 3wt_tile11_sub2                                                                                                                                                                                                                                                                                                                                                               |
| bsmbi_3wt_tile12_sub1 | 669         | BsmBI       | 3wt_tile12_sub1                                                                                                                                                                                                                                                                                                                                                               |
| bsmbi_3wt_tile12_sub2 | 714         | BsmBI       | 3wt_tile12_sub2                                                                                                                                                                                                                                                                                                                                                               |
| bsmbi_3wt_tile13_sub1 | 723         | BsmBI       | 3wt_tile13_sub1                                                                                                                                                                                                                                                                                                                                                               |
| bsmbi_3wt_tile13_sub2 | 630         | BsmBI       | 3wt_tile13_sub2;3wt_tile14_sub2                                                                                                                                                                                                                                                                                                                                               |
| bsmbi_3wt_tile13_sub3 | 855         | BsmBI       | 3wt_tile13_sub3;3wt_tile14_sub3;3wt_tile17_sub2;3wt_tile18_sub2                                                                                                                                                                                                                                                                                                               |
| bsmbi_3wt_tile14_sub1 | 639         | BsmBI       | 3wt_tile14_sub1                                                                                                                                                                                                                                                                                                                                                               |
| bsmbi_3wt_tile15_sub1 | 735         | BsmBI       | 3wt_tile15_sub1                                                                                                                                                                                                                                                                                                                                                               |
| bsmbi_3wt_tile15_sub2 | 717         | BsmBI       | 3wt_tile15_sub2;3wt_tile16_sub2                                                                                                                                                                                                                                                                                                                                               |
| bsmbi_3wt_tile15_sub3 | 477         | BsmBI       | 3wt_tile15_sub3                                                                                                                                                                                                                                                                                                                                                               |
| bsmbi_3wt_tile15_sub4 | 804         | BsmBI       | 3wt_tile15_sub4                                                                                                                                                                                                                                                                                                                                                               |
| bsmbi_3wt_tile16_sub1 | 582         | BsmBI       | 3wt_tile16_sub1                                                                                                                                                                                                                                                                                                                                                               |
| bsmbi_3wt_tile16_sub3 | 534         | BsmBI       | 3wt_tile16_sub3                                                                                                                                                                                                                                                                                                                                                               |
| bsmbi_3wt_tile16_sub4 | 747         | BsmBI       | 3wt_tile16_sub4                                                                                                                                                                                                                                                                                                                                                               |
| bsmbi_3wt_tile17_sub1 | 789         | BsmBI       | 3wt_tile17_sub1                                                                                                                                                                                                                                                                                                                                                               |
| bsmbi_3wt_tile18_sub1 | 582         | BsmBI       | 3wt_tile18_sub1                                                                                                                                                                                                                                                                                                                                                               |
| bsmbi_3wt_tile19_sub1 | 837         | BsmBI       | 3wt_tile19_sub1                                                                                                                                                                                                                                                                                                                                                               |
| bsmbi_3wt_tile19_sub2 | 504         | BsmBI       | 3wt_tile19_sub2;3wt_tile20_sub2                                                                                                                                                                                                                                                                                                                                               |
| bsmbi_3wt_tile2_sub1  | 969         | BsmBI       | 3wt_tile2_sub1                                                                                                                                                                                                                                                                                                                                                                |
| bsmbi_3wt_tile2_sub2  | 825         | BsmBI       | 3wt_tile2_sub2                                                                                                                                                                                                                                                                                                                                                                |
| bsmbi_3wt_tile2_sub4  | 1092        | BsmBI       | 3wt_tile2_sub4                                                                                                                                                                                                                                                                                                                                                                |
| bsmbi_3wt_tile2_sub5  | 735         | BsmBI       | 3wt_tile2_sub5                                                                                                                                                                                                                                                                                                                                                                |
| bsmbi_3wt_tile20_sub1 | 690         | BsmBI       | 3wt_tile20_sub1                                                                                                                                                                                                                                                                                                                                                               |
| bsmbi_3wt_tile21_sub1 | 585         | BsmBI       | 3wt_tile21_sub1                                                                                                                                                                                                                                                                                                                                                               |
| bsmbi_3wt_tile21_sub2 | 804         | BsmBI       | 3wt_tile21_sub2                                                                                                                                                                                                                                                                                                                                                               |
| bsmbi_3wt_tile21_sub3 | 477         | BsmBI       | 3wt_tile21_sub3                                                                                                                                                                                                                                                                                                                                                               |
| bsmbi_3wt_tile22_sub1 | 678         | BsmBI       | 3wt_tile22_sub1                                                                                                                                                                                                                                                                                                                                                               |
| bsmbi_3wt_tile22_sub2 | 1029        | BsmBI       | 3wt_tile22_sub2                                                                                                                                                                                                                                                                                                                                                               |
| bsmbi_3wt_tile23_sub1 | 789         | BsmBI       | 3wt_tile23_sub1                                                                                                                                                                                                                                                                                                                                                               |
| bsmbi_3wt_tile23_sub2 | 690         | BsmBI       | 3wt_tile23_sub2;3wt_tile24_sub2                                                                                                                                                                                                                                                                                                                                               |
| bsmbi_3wt_tile24_sub1 | 597         | BsmBI       | 3wt_tile24_sub1                                                                                                                                                                                                                                                                                                                                                               |
| bsmbi_3wt_tile25_sub1 | 477         | BsmBI       | 3wt_tile25_sub1                                                                                                                                                                                                                                                                                                                                                               |
| bsmbi_3wt_tile25_sub2 | 837         | BsmBI       | 3wt_tile25_sub2                                                                                                                                                                                                                                                                                                                                                               |
| bsmbi_3wt_tile25_sub3 | 1553        | BsmBI       | 3wt_polIII_tile25_sub3;3wt_polIII_tile26_sub3;3wt_polIII_tile27_sub3;3wt_polIII_tile28_sub3;3wt_polIII_tile29_sub3;3wt_polIII_tile31_sub2                                                                                                                                                                                                                                     |
| bsmbi_3wt_tile26_sub1 | 537         | BsmBI       | 3wt_tile26_sub1                                                                                                                                                                                                                                                                                                                                                               |
| bsmbi_3wt_tile26_sub2 | 645         | BsmBI       | 3wt_tile26_sub2;3wt_tile27_sub2                                                                                                                                                                                                                                                                                                                                               |
| bsmbi_3wt_tile27_sub1 | 411         | BsmBI       | 3wt_tile27_sub1                                                                                                                                                                                                                                                                                                                                                               |
| bsmbi_3wt_tile28_sub1 | 447         | BsmBI       | 3wt_tile28_sub1                                                                                                                                                                                                                                                                                                                                                               |
| bsmbi_3wt_tile28_sub2 | 417         | BsmBI       | 3wt_tile28_sub2;3wt_tile29_sub2                                                                                                                                                                                                                                                                                                                                               |
| bsmbi_3wt_tile29_sub1 | 324         | BsmBI       | 3wt_tile29_sub1                                                                                                                                                                                                                                                                                                                                                               |
| bsmbi_3wt_tile3_sub1  | 798         | BsmBI       | 3wt_tile3_sub1                                                                                                                                                                                                                                                                                                                                                                |
| bsmbi_3wt_tile3_sub2  | 1065        | BsmBI       | 3wt_tile3_sub2                                                                                                                                                                                                                                                                                                                                                                |
| bsmbi_3wt_tile3_sub3  | 732         | BsmBI       | 3wt_tile3_sub3                                                                                                                                                                                                                                                                                                                                                                |
| bsmbi_3wt_tile3_sub4  | 996         | BsmBI       | 3wt_tile3_sub4                                                                                                                                                                                                                                                                                                                                                                |
| bsmbi_3wt_tile3_sub5  | 810         | BsmBI       | 3wt_tile3_sub5;3wt_tile9_sub4                                                                                                                                                                                                                                                                                                                                                 |
| bsmbi_3wt_tile3_sub6  | 2087        | BsmBI       | 3wt_polIII_tile3_sub6;3wt_polIII_tile9_sub5                                                                                                                                                                                                                                                                                                                                   |
| bsmbi_3wt_tile30_sub1 | 456         | BsmBI       | 3wt_tile30_sub1                                                                                                                                                                                                                                                                                                                                                               |
| bsmbi_3wt_tile30_sub2 | 1694        | BsmBI       | 3wt_polIII_tile30_sub2                                                                                                                                                                                                                                                                                                                                                        |
| bsmbi_3wt_tile31_sub1 | 414         | BsmBI       | 3wt_tile31_sub1                                                                                                                                                                                                                                                                                                                                                               |
| bsmbi_3wt_tile32      | 1787        | BsmBI       | 3wt_polIII_tile32                                                                                                                                                                                                                                                                                                                                                             |
| bsmbi_3wt_tile33      | 1664        | BsmBI       | 3wt_polIII_tile33                                                                                                                                                                                                                                                                                                                                                             |
| bsmbi_3wt_tile34      | 1442        | BsmBI       | 3wt_polIII_tile34                                                                                                                                                                                                                                                                                                                                                             |
| bsmbi_3wt_tile35      | 1346        | BsmBI       | 3wt_polIII_tile35                                                                                                                                                                                                                                                                                                                                                             |
| bsmbi_3wt_tile36      | 1208        | BsmBI       | 3wt_polIII_tile36                                                                                                                                                                                                                                                                                                                                                             |
| bsmbi_3wt_tile4_sub1  | 918         | BsmBI       | 3wt_tile4_sub1                                                                                                                                                                                                                                                                                                                                                                |
| bsmbi_3wt_tile4_sub2  | 786         | BsmBI       | 3wt_tile4_sub2                                                                                                                                                                                                                                                                                                                                                                |
| bsmbi_3wt_tile4_sub3  | 798         | BsmBI       | 3wt_tile4_sub3                                                                                                                                                                                                                                                                                                                                                                |
| bsmbi_3wt_tile4_sub4  | 930         | BsmBI       | 3wt_tile4_sub4                                                                                                                                                                                                                                                                                                                                                                |
| bsmbi_3wt_tile4_sub5  | 966         | BsmBI       | 3wt_tile4_sub5;3wt_tile5_sub5                                                                                                                                                                                                                                                                                                                                                 |
| bsmbi_3wt_tile4_sub6  | 1931        | BsmBI       | 3wt_polIII_tile4_sub6;3wt_polIII_tile5_sub6;3wt_polIII_tile6_sub6                                                                                                                                                                                                                                                                                                             |
| bsmbi_3wt_tile5_sub1  | 744         | BsmBI       | 3wt_tile5_sub1                                                                                                                                                                                                                                                                                                                                                                |
| bsmbi_3wt_tile5_sub2  | 1020        | BsmBI       | 3wt_tile5_sub2                                                                                                                                                                                                                                                                                                                                                                |
| bsmbi_3wt_tile5_sub3  | 666         | BsmBI       | 3wt_tile5_sub3                                                                                                                                                                                                                                                                                                                                                                |
| bsmbi_3wt_tile5_sub4  | 828         | BsmBI       | 3wt_tile5_sub4;3wt_tile9_sub3                                                                                                                                                                                                                                                                                                                                                 |
| bsmbi_3wt_tile6_sub1  | 687         | BsmBI       | 3wt_tile6_sub1                                                                                                                                                                                                                                                                                                                                                                |
| bsmbi_3wt_tile6_sub2  | 843         | BsmBI       | 3wt_tile6_sub2                                                                                                                                                                                                                                                                                                                                                                |
| bsmbi_3wt_tile6_sub3  | 927         | BsmBI       | 3wt_tile6_sub3                                                                                                                                                                                                                                                                                                                                                                |
| bsmbi_3wt_tile6_sub4  | 810         | BsmBI       | 3wt_tile6_sub4;3wt_tile10_sub3                                                                                                                                                                                                                                                                                                                                                |
| bsmbi_3wt_tile6_sub5  | 723         | BsmBI       | 3wt_tile6_sub5                                                                                                                                                                                                                                                                                                                                                                |
| bsmbi_3wt_tile7_sub1  | 660         | BsmBI       | 3wt_tile7_sub1                                                                                                                                                                                                                                                                                                                                                                |
| bsmbi_3wt_tile7_sub2  | 936         | BsmBI       | 3wt_tile7_sub2                                                                                                                                                                                                                                                                                                                                                                |
| bsmbi_3wt_tile7_sub3  | 666         | BsmBI       | 3wt_tile7_sub3                                                                                                                                                                                                                                                                                                                                                                |
| bsmbi_3wt_tile7_sub4  | 942         | BsmBI       | 3wt_tile7_sub4;3wt_tile11_sub3;3wt_tile12_sub3                                                                                                                                                                                                                                                                                                                                |
| bsmbi_3wt_tile7_sub5  | 777         | BsmBI       | 3wt_tile7_sub5;3wt_tile11_sub4;3wt_tile12_sub4;3wt_tile13_sub4;3wt_tile14_sub4;3wt_tile17_sub3;3wt_tile18_sub3;3wt_tile19_sub3;3wt_tile20_sub3                                                                                                                                                                                                                                |
| bsmbi_3wt_tile7_sub6  | 1745        | BsmBI       | 3wt_polIII_tile7_sub6;3wt_polIII_tile8_sub6;3wt_polIII_tile11_sub5;3wt_polIII_tile12_sub5;3wt_polIII_tile13_sub5;3wt_polIII_tile14_sub5;3wt_polIII_tile15_sub5;3wt_polIII_tile16_sub5;3wt_polIII_tile17_sub4;3wt_polIII_tile18_sub4;3wt_polIII_tile19_sub4;3wt_polIII_tile20_sub4;3wt_polIII_tile21_sub4;3wt_polIII_tile22_sub3;3wt_polIII_tile23_sub3;3wt_polIII_tile24_sub3 |
| bsmbi_3wt_tile8_sub1  | 687         | BsmBI       | 3wt_tile8_sub1                                                                                                                                                                                                                                                                                                                                                                |
| bsmbi_3wt_tile8_sub2  | 810         | BsmBI       | 3wt_tile8_sub2                                                                                                                                                                                                                                                                                                                                                                |
| bsmbi_3wt_tile8_sub3  | 825         | BsmBI       | 3wt_tile8_sub3                                                                                                                                                                                                                                                                                                                                                                |
| bsmbi_3wt_tile8_sub4  | 528         | BsmBI       | 3wt_tile8_sub4                                                                                                                                                                                                                                                                                                                                                                |
| bsmbi_3wt_tile8_sub5  | 909         | BsmBI       | 3wt_tile8_sub5                                                                                                                                                                                                                                                                                                                                                                |
| bsmbi_3wt_tile9_sub1  | 708         | BsmBI       | 3wt_tile9_sub1                                                                                                                                                                                                                                                                                                                                                                |
| bsmbi_3wt_tile9_sub2  | 882         | BsmBI       | 3wt_tile9_sub2                                                                                                                                                                                                                                                                                                                                                                |
| bsmbi_polIII_tile37   | 1112        | BsmBI       | polIII_tile37                                                                                                                                                                                                                                                                                                                                                                 |

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

| Parameter             | Value        |
| --------------------- | ------------ |
| max_oligo_length      | 300          |
| max_geneblock_length  | 1800         |
| barcode_length        | 20           |
| min_hamming_distance  | 3            |
| barcode_prefix_length | 12           |
| barcodes_per_variant  | 1            |
| boundary_method       | oogga_greedy |
| multi_k_search        | TRUE         |
| auto_domesticate      | TRUE         |

