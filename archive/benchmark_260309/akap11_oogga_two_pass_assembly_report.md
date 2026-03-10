# DMS-GG Assembly Report: AKAP11

Generated: 2026-03-09 18:51:32
Pipeline: dms-gg-oligo-pipeline (3-Enzyme Architecture: BsaI + BsmBI + PaqCI)

---

## 1. Gene Summary

| Property             | Value                                                                          |
| -------------------- | ------------------------------------------------------------------------------ |
| Gene name            | AKAP11_NM_016248.4_CDS Homo sapiens A-kinase anchoring protein 11 (AKAP11) CDS |
| CDS length           | 5706 nt (1902 codons)                                                          |
| Protein length       | 1901 aa                                                                        |
| Number of tiles      | 27                                                                             |
| Total variants       | 37674                                                                          |
| Total oligos         | 37674                                                                          |
| Oligo length range   | 179-290 nt                                                                     |
| Gene blocks to order | 119                                                                            |
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

**Total oligos:** 37674 | **Length range:** 179-290 nt

| Tile | Codons    | Oligos | Length |
| ---- | --------- | ------ | ------ |
| 1    | 1-73      | 1449   | 275 nt |
| 2    | 74-142    | 1365   | 263 nt |
| 3    | 143-220   | 1554   | 290 nt |
| 4    | 221-296   | 1512   | 284 nt |
| 5    | 297-372   | 1512   | 284 nt |
| 6    | 373-449   | 1533   | 287 nt |
| 7    | 450-525   | 1512   | 284 nt |
| 8    | 526-603   | 1554   | 290 nt |
| 9    | 604-677   | 1470   | 278 nt |
| 10   | 678-750   | 1449   | 275 nt |
| 11   | 751-791   | 777    | 179 nt |
| 12   | 792-868   | 1533   | 287 nt |
| 13   | 869-941   | 1449   | 275 nt |
| 14   | 942-1012  | 1407   | 269 nt |
| 15   | 1013-1082 | 1386   | 266 nt |
| 16   | 1083-1150 | 1344   | 260 nt |
| 17   | 1151-1227 | 1533   | 287 nt |
| 18   | 1228-1305 | 1554   | 290 nt |
| 19   | 1306-1373 | 1344   | 260 nt |
| 20   | 1374-1451 | 1554   | 290 nt |
| 21   | 1452-1529 | 1554   | 290 nt |
| 22   | 1530-1593 | 1260   | 248 nt |
| 23   | 1594-1646 | 1029   | 215 nt |
| 24   | 1647-1710 | 1260   | 248 nt |
| 25   | 1711-1779 | 1365   | 263 nt |
| 26   | 1780-1830 | 987    | 209 nt |
| 27   | 1831-1902 | 1428   | 272 nt |

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
| Total barcodes    | 37674                              |
| Unique barcodes   | 37674                              |
| GC content range  | 25% - 75%                          |
| GC content mean   | 48.3%                              |
| Hamming guarantee | 100% cross-variant (prefix d >= 3) |

## 5. QC Summary

**Overall:** ISSUES FOUND

| Check                  | Description                                                   | Result | Detail                                                                                                                                                |
| ---------------------- | ------------------------------------------------------------- | ------ | ----------------------------------------------------------------------------------------------------------------------------------------------------- |
| oligo_lengths          | All oligos within synthesis length limit                      | PASS   | Range: 179-290 nt (limit: 300)                                                                                                                        |
| block_lengths          | All gene blocks within synthesis length limit                 | FAIL   | Range: 237-2162 nt (limit: 1800)                                                                                                                      |
| barcode_junction_sites | No enzyme sites at barcode-context junctions                  | PASS   | 0 barcode(s) with junction enzyme sites (left='CACACC', right='AGAATG')                                                                               |
| barcode_uniqueness     | All barcodes are unique                                       | PASS   | 37674 unique / 37674 total                                                                                                                            |
| tile_coverage          | Tiles cover entire gene without gaps                          | PASS   | 5706 / 5706 nt covered                                                                                                                                |
| variant_count          | Expected number of variants generated                         | PASS   | 37674 unique variants (expected: 37674 across 1794/1900 mutable positions; 34086 missense + 1794 nonsense + 1794 wt_control; 106 position(s) skipped) |
| single_codon_change    | Each non-control variant differs by exactly one codon from WT | PASS   | 35880 / 35880 variants confirmed (WT controls excluded)                                                                                               |
| oligo_gc_content       | Oligo GC content within reasonable range (25-75%)             | PASS   | GC range: 34.8-55.2% | 0 oligo(s) with extreme GC                                                                                                     |
| domestication_complete | Gene domesticated for all 3 enzymes (BsaI, BsmBI, PaqCI)      | PASS   | No enzyme sites in gene                                                                                                                               |
| overhang_fidelity      | Tile boundary overhangs have adequate fidelity                | FAIL   | 25 tile(s) with low-fidelity boundary overhangs (<0.80)                                                                                               |
| tile_manifests         | Per-tile assembly manifests complete                          | PASS   | 27 tile manifest(s) generated                                                                                                                         |
| helper_plasmid         | Helper plasmid free of unintended BsmBI sites                 | PASS   | OK                                                                                                                                                    |
| reaction_fidelity      | Per-reaction set-level overhang fidelity                      | PASS   | Min set fidelity: 0.8534 across 54 reactions | 1 reaction(s) below 0.90                                                                               |
| barcode_poliii_term    | No barcodes contain PolIII terminator signal (TTTT)           | PASS   | 0 / 37674 barcode(s) contain TTTT                                                                                                                     |
| block_min_length       | All gene blocks above synthesis minimum length                | FAIL   | 1 block(s) below 300 nt minimum. Range: 237-2162 nt                                                                                                   |
| sb_overhang_collisions | Superblock boundary overhangs are unique (no collisions)      | PASS   | 4 SB boundary OH(s), all unique                                                                                                                       |

## 5b. Reaction Fidelity Summary

Set fidelity for each tile's BsaI and BsmBI reactions,
computed from the actual block overhangs after construction:

| Tile | BsaI OHs | BsaI Set Fidelity | BsmBI OHs | BsmBI Set Fidelity |
| ---- | -------- | ----------------- | --------- | ------------------ |
| 1    | 2        | 1.0000            | 7         | 0.9786             |
| 2    | 3        | 1.0000            | 7         | 0.9260             |
| 3    | 3        | 1.0000            | 7         | 0.9773             |
| 4    | 3        | 1.0000            | 7         | 0.9786             |
| 5    | 3        | 1.0000            | 7         | 0.9617             |
| 6    | 3        | 1.0000            | 7         | 0.9596             |
| 7    | 3        | 1.0000            | 6         | 0.9832             |
| 8    | 3        | 1.0000            | 6         | 0.9646             |
| 9    | 4        | 0.9907            | 6         | 0.9727             |
| 10   | 4        | 0.9907            | 6         | 0.9662             |
| 11   | 4        | 0.9907            | 6         | 0.9832             |
| 12   | 4        | 0.9907            | 6         | 0.9911             |
| 13   | 4        | 0.9907            | 5         | 0.9911             |
| 14   | 4        | 0.9907            | 5         | 0.9692             |
| 15   | 4        | 0.9907            | 5         | 0.9381             |
| 16   | 4        | 0.9907            | 4         | 0.9775             |
| 17   | 5        | 0.9907            | 4         | 0.9911             |
| 18   | 5        | 0.9764            | 4         | 0.9911             |
| 19   | 5        | 0.9155            | 4         | 0.9809             |
| 20   | 5        | 0.9764            | 4         | 1.0000             |
| 21   | 5        | 0.9764            | 3         | 1.0000             |
| 22   | 5        | 0.9907            | 3         | 1.0000             |
| 23   | 5        | 0.9907            | 3         | 1.0000             |
| 24   | 5        | 0.8534            | 2         | 1.0000             |
| 25   | 5        | 0.9764            | 2         | 1.0000             |
| 26   | 6        | 0.9676            | 2         | 1.0000             |
| 27   | 6        | 0.9676            | 2         | 1.0000             |

**Min:** 0.8534 | **Max:** 1.0000 | **Mean:** 0.9813

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

### Tile 1 of 27 -- Codons 1-73 (219 nt)

**Boundary overhangs:**

| Position          | Sequence | Fidelity |
| ----------------- | -------- | -------- |
| oh1 (5' boundary) | ATGG     | 0.5393   |
| oh2 (3' boundary) | AGTT     | 0.6748   |

**Variants:** 1449 mutations, 1449 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name                          | Length | 5' OH | 3' OH |
| --- | --------------- | ---------------------------------- | ------ | ----- | ----- |
| 1   | 5'WT gene block | (none -- tile starts at gene nt 1) | --     | --    | --    |
| 2   | Oligo pool      | Tile 1 (1449 oligos)               | 275 nt | ATGG  | AGAA  |
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
| 2   | 3'WT block        | bsmbi_3wt_tile1_sub1     | 789 nt  | AGTT  | AAAA  |
| 3   | 3'WT block        | bsmbi_3wt_tile1_sub2     | 1035 nt | AAAA  | TCAA  |
| 4   | 3'WT block        | bsmbi_3wt_tile1_sub3     | 939 nt  | TCAA  | AGAA  |
| 5   | 3'WT block        | bsmbi_3wt_tile1_sub4     | 1029 nt | AGAA  | AAGA  |
| 6   | 3'WT block        | bsmbi_3wt_tile1_sub5     | 735 nt  | AAGA  | TCTA  |
| 7   | 3'WT+PolIII block | bsmbi_3wt_tile1_sub6     | 2162 nt | TCTA  | CACC  |
| 8   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1 | --      | --    | --    |

```
  [AGTT]----3'WT sub1----[AAAA]----3'WT sub2----[TCAA]----3'WT sub3----[AGAA]----3'WT sub4----[AAGA]----3'WT sub5----[TCTA]----3'WT+PolIII sub6----[CACC]
   AGTT                   AAAA                   TCAA                   AGAA                   AAGA                   TCTA                          CACC 
```

**Set fidelity:** 0.9786 (7 overhangs)

---

### Tile 2 of 27 -- Codons 74-142 (207 nt)

**Boundary overhangs:**

| Position          | Sequence | Fidelity |
| ----------------- | -------- | -------- |
| oh1 (5' boundary) | TTAG     | 0.8480   |
| oh2 (3' boundary) | AAGT     | 0.7629   |

**Variants:** 1365 mutations, 1365 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name             | Length | 5' OH | 3' OH |
| --- | --------------- | --------------------- | ------ | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile2        | 237 nt | ATGG  | TTAG  |
| 2   | Oligo pool      | Tile 2 (1365 oligos)  | 263 nt | TTAG  | AGAA  |
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
| 2   | 3'WT block        | bsmbi_3wt_tile2_sub1     | 792 nt  | AAGT  | AAAA  |
| 3   | 3'WT block        | bsmbi_3wt_tile2_sub2     | 1065 nt | AAAA  | TCAA  |
| 4   | 3'WT block        | bsmbi_3wt_tile2_sub3     | 699 nt  | TCAA  | AGAA  |
| 5   | 3'WT block        | bsmbi_3wt_tile1_sub4     | 1029 nt | AGAA  | AAGA  |
| 6   | 3'WT block        | bsmbi_3wt_tile2_sub5     | 966 nt  | AAGA  | GAAA  |
| 7   | 3'WT+PolIII block | bsmbi_3wt_tile2_sub6     | 1931 nt | GAAA  | CACC  |
| 8   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1 | --      | --    | --    |

```
  [AAGT]----3'WT sub1----[AAAA]----3'WT sub2----[TCAA]----3'WT sub3----[AGAA]----3'WT sub4----[AAGA]----3'WT sub5----[GAAA]----3'WT+PolIII sub6----[CACC]
   AAGT                   AAAA                   TCAA                   AGAA                   AAGA                   GAAA                          CACC 
```

**Set fidelity:** 0.9260 (7 overhangs)

---

### Tile 3 of 27 -- Codons 143-220 (234 nt)

**Boundary overhangs:**

| Position          | Sequence | Fidelity |
| ----------------- | -------- | -------- |
| oh1 (5' boundary) | AGTC     | 0.5938   |
| oh2 (3' boundary) | TACT     | 0.7445   |

**Variants:** 1554 mutations, 1554 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name             | Length | 5' OH | 3' OH |
| --- | --------------- | --------------------- | ------ | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile3        | 444 nt | ATGG  | AGTC  |
| 2   | Oligo pool      | Tile 3 (1554 oligos)  | 290 nt | AGTC  | AGAA  |
| 3   | Helper plasmid  | helper_plasmid_insert | --     | --    | --    |
| 4   | Enzyme + buffer | BsaI-HFv2 + CutSmart  | --     | --    | --    |

```
  [ATGG]----5'WT block----[AGTC]----oligo+BC----[AGAA]
   ATGG                    AGTC                  AGAA 
```

**Set fidelity:** 1.0000 (3 overhangs)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------ | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)      | --      | --    | --    |
| 2   | 3'WT block        | bsmbi_3wt_tile3_sub1     | 837 nt  | TACT  | AAAA  |
| 3   | 3'WT block        | bsmbi_3wt_tile3_sub2     | 786 nt  | AAAA  | TCAA  |
| 4   | 3'WT block        | bsmbi_3wt_tile3_sub3     | 1089 nt | TCAA  | TCTA  |
| 5   | 3'WT block        | bsmbi_3wt_tile3_sub4     | 639 nt  | TCTA  | AAGA  |
| 6   | 3'WT block        | bsmbi_3wt_tile3_sub5     | 810 nt  | AAGA  | AGAA  |
| 7   | 3'WT+PolIII block | bsmbi_3wt_tile3_sub6     | 2087 nt | AGAA  | CACC  |
| 8   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1 | --      | --    | --    |

```
  [TACT]----3'WT sub1----[AAAA]----3'WT sub2----[TCAA]----3'WT sub3----[TCTA]----3'WT sub4----[AAGA]----3'WT sub5----[AGAA]----3'WT+PolIII sub6----[CACC]
   TACT                   AAAA                   TCAA                   TCTA                   AAGA                   AGAA                          CACC 
```

**Set fidelity:** 0.9773 (7 overhangs)

---

### Tile 4 of 27 -- Codons 221-296 (228 nt)

**Boundary overhangs:**

| Position          | Sequence | Fidelity |
| ----------------- | -------- | -------- |
| oh1 (5' boundary) | CAGA     | 0.8175   |
| oh2 (3' boundary) | TTCG     | 0.6891   |

**Variants:** 1512 mutations, 1512 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name             | Length | 5' OH | 3' OH |
| --- | --------------- | --------------------- | ------ | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile4        | 678 nt | ATGG  | CAGA  |
| 2   | Oligo pool      | Tile 4 (1512 oligos)  | 284 nt | CAGA  | AGAA  |
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
| 2   | 3'WT block        | bsmbi_3wt_tile4_sub1     | 738 nt  | TTCG  | AAAA  |
| 3   | 3'WT block        | bsmbi_3wt_tile4_sub2     | 891 nt  | AAAA  | AGAA  |
| 4   | 3'WT block        | bsmbi_3wt_tile4_sub3     | 855 nt  | AGAA  | TCTA  |
| 5   | 3'WT block        | bsmbi_3wt_tile4_sub4     | 882 nt  | TCTA  | AAGA  |
| 6   | 3'WT block        | bsmbi_3wt_tile4_sub5     | 591 nt  | AAGA  | TCAA  |
| 7   | 3'WT+PolIII block | bsmbi_3wt_tile4_sub6     | 2063 nt | TCAA  | CACC  |
| 8   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1 | --      | --    | --    |

```
  [TTCG]----3'WT sub1----[AAAA]----3'WT sub2----[AGAA]----3'WT sub3----[TCTA]----3'WT sub4----[AAGA]----3'WT sub5----[TCAA]----3'WT+PolIII sub6----[CACC]
   TTCG                   AAAA                   AGAA                   TCTA                   AAGA                   TCAA                          CACC 
```

**Set fidelity:** 0.9786 (7 overhangs)

---

### Tile 5 of 27 -- Codons 297-372 (228 nt)

**Boundary overhangs:**

| Position          | Sequence | Fidelity |
| ----------------- | -------- | -------- |
| oh1 (5' boundary) | ACAT     | 0.6621   |
| oh2 (3' boundary) | CAAA     | 0.8948   |

**Variants:** 1512 mutations, 1512 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name             | Length | 5' OH | 3' OH |
| --- | --------------- | --------------------- | ------ | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile5        | 906 nt | ATGG  | ACAT  |
| 2   | Oligo pool      | Tile 5 (1512 oligos)  | 284 nt | ACAT  | AGAA  |
| 3   | Helper plasmid  | helper_plasmid_insert | --     | --    | --    |
| 4   | Enzyme + buffer | BsaI-HFv2 + CutSmart  | --     | --    | --    |

```
  [ATGG]----5'WT block----[ACAT]----oligo+BC----[AGAA]
   ATGG                    ACAT                  AGAA 
```

**Set fidelity:** 1.0000 (3 overhangs)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------ | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)      | --      | --    | --    |
| 2   | 3'WT block        | bsmbi_3wt_tile5_sub1     | 726 nt  | CAAA  | AAAA  |
| 3   | 3'WT block        | bsmbi_3wt_tile5_sub2     | 717 nt  | AAAA  | AGAA  |
| 4   | 3'WT block        | bsmbi_3wt_tile5_sub3     | 813 nt  | AGAA  | TCTA  |
| 5   | 3'WT block        | bsmbi_3wt_tile5_sub4     | 1014 nt | TCTA  | TCAA  |
| 6   | 3'WT block        | bsmbi_3wt_tile5_sub5     | 591 nt  | TCAA  | GAAA  |
| 7   | 3'WT+PolIII block | bsmbi_3wt_tile2_sub6     | 1931 nt | GAAA  | CACC  |
| 8   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1 | --      | --    | --    |

```
  [CAAA]----3'WT sub1----[AAAA]----3'WT sub2----[AGAA]----3'WT sub3----[TCTA]----3'WT sub4----[TCAA]----3'WT sub5----[GAAA]----3'WT+PolIII sub6----[CACC]
   CAAA                   AAAA                   AGAA                   TCTA                   TCAA                   GAAA                          CACC 
```

**Set fidelity:** 0.9617 (7 overhangs)

---

### Tile 6 of 27 -- Codons 373-449 (231 nt)

**Boundary overhangs:**

| Position          | Sequence | Fidelity |
| ----------------- | -------- | -------- |
| oh1 (5' boundary) | CTGT     | 0.6476   |
| oh2 (3' boundary) | CTCT     | 0.6347   |

**Variants:** 1533 mutations, 1533 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name             | Length  | 5' OH | 3' OH |
| --- | --------------- | --------------------- | ------- | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile6        | 1134 nt | ATGG  | CTGT  |
| 2   | Oligo pool      | Tile 6 (1533 oligos)  | 287 nt  | CTGT  | AGAA  |
| 3   | Helper plasmid  | helper_plasmid_insert | --      | --    | --    |
| 4   | Enzyme + buffer | BsaI-HFv2 + CutSmart  | --      | --    | --    |

```
  [ATGG]----5'WT block----[CTGT]----oligo+BC----[AGAA]
   ATGG                    CTGT                  AGAA 
```

**Set fidelity:** 1.0000 (3 overhangs)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------ | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)      | --      | --    | --    |
| 2   | 3'WT block        | bsmbi_3wt_tile6_sub1     | 744 nt  | CTCT  | AAAA  |
| 3   | 3'WT block        | bsmbi_3wt_tile6_sub2     | 873 nt  | AAAA  | AGAA  |
| 4   | 3'WT block        | bsmbi_3wt_tile6_sub3     | 762 nt  | AGAA  | TCAA  |
| 5   | 3'WT block        | bsmbi_3wt_tile6_sub4     | 528 nt  | TCAA  | AAGA  |
| 6   | 3'WT block        | bsmbi_3wt_tile6_sub5     | 723 nt  | AAGA  | GAAA  |
| 7   | 3'WT+PolIII block | bsmbi_3wt_tile2_sub6     | 1931 nt | GAAA  | CACC  |
| 8   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1 | --      | --    | --    |

```
  [CTCT]----3'WT sub1----[AAAA]----3'WT sub2----[AGAA]----3'WT sub3----[TCAA]----3'WT sub4----[AAGA]----3'WT sub5----[GAAA]----3'WT+PolIII sub6----[CACC]
   CTCT                   AAAA                   AGAA                   TCAA                   AAGA                   GAAA                          CACC 
```

**Set fidelity:** 0.9596 (7 overhangs)

---

### Tile 7 of 27 -- Codons 450-525 (228 nt)

**Boundary overhangs:**

| Position          | Sequence | Fidelity |
| ----------------- | -------- | -------- |
| oh1 (5' boundary) | ATTC     | 0.7084   |
| oh2 (3' boundary) | TAAG     | 0.8377   |

**Variants:** 1512 mutations, 1512 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name             | Length  | 5' OH | 3' OH |
| --- | --------------- | --------------------- | ------- | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile7        | 1365 nt | ATGG  | ATTC  |
| 2   | Oligo pool      | Tile 7 (1512 oligos)  | 284 nt  | ATTC  | AGAA  |
| 3   | Helper plasmid  | helper_plasmid_insert | --      | --    | --    |
| 4   | Enzyme + buffer | BsaI-HFv2 + CutSmart  | --      | --    | --    |

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
| 2   | 3'WT block        | bsmbi_3wt_tile7_sub1     | 708 nt  | TAAG  | AAAA  |
| 3   | 3'WT block        | bsmbi_3wt_tile7_sub2     | 882 nt  | AAAA  | TCAA  |
| 4   | 3'WT block        | bsmbi_3wt_tile7_sub3     | 828 nt  | TCAA  | AAGA  |
| 5   | 3'WT block        | bsmbi_3wt_tile3_sub5     | 810 nt  | AAGA  | AGAA  |
| 6   | 3'WT+PolIII block | bsmbi_3wt_tile3_sub6     | 2087 nt | AGAA  | CACC  |
| 7   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1 | --      | --    | --    |

```
  [TAAG]----3'WT sub1----[AAAA]----3'WT sub2----[TCAA]----3'WT sub3----[AAGA]----3'WT sub4----[AGAA]----3'WT+PolIII sub5----[CACC]
   TAAG                   AAAA                   TCAA                   AAGA                   AGAA                          CACC 
```

**Set fidelity:** 0.9832 (6 overhangs)

---

### Tile 8 of 27 -- Codons 526-603 (234 nt)

**Boundary overhangs:**

| Position          | Sequence | Fidelity |
| ----------------- | -------- | -------- |
| oh1 (5' boundary) | GTAA     | 0.8029   |
| oh2 (3' boundary) | ACTA     | 0.7946   |

**Variants:** 1554 mutations, 1554 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name             | Length  | 5' OH | 3' OH |
| --- | --------------- | --------------------- | ------- | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile8        | 1593 nt | ATGG  | GTAA  |
| 2   | Oligo pool      | Tile 8 (1554 oligos)  | 290 nt  | GTAA  | AGAA  |
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
| 2   | 3'WT block        | bsmbi_3wt_tile8_sub1     | 681 nt  | ACTA  | AAAA  |
| 3   | 3'WT block        | bsmbi_3wt_tile8_sub2     | 864 nt  | AAAA  | TCTA  |
| 4   | 3'WT block        | bsmbi_3wt_tile4_sub4     | 882 nt  | TCTA  | AAGA  |
| 5   | 3'WT block        | bsmbi_3wt_tile8_sub4     | 618 nt  | AAGA  | AGAA  |
| 6   | 3'WT+PolIII block | bsmbi_3wt_tile8_sub5     | 2036 nt | AGAA  | CACC  |
| 7   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1 | --      | --    | --    |

```
  [ACTA]----3'WT sub1----[AAAA]----3'WT sub2----[TCTA]----3'WT sub3----[AAGA]----3'WT sub4----[AGAA]----3'WT+PolIII sub5----[CACC]
   ACTA                   AAAA                   TCTA                   AAGA                   AGAA                          CACC 
```

**Set fidelity:** 0.9646 (6 overhangs)

---

### Tile 9 of 27 -- Codons 604-677 (222 nt)

**Boundary overhangs:**

| Position          | Sequence | Fidelity |
| ----------------- | -------- | -------- |
| oh1 (5' boundary) | GCAT     | 0.5827   |
| oh2 (3' boundary) | CTTT     | 0.6635   |

**Variants:** 1470 mutations, 1470 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name             | Length | 5' OH | 3' OH |
| --- | --------------- | --------------------- | ------ | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile9_sub1   | 995 nt | ATGG  | AAAA  |
| 2   | 5'WT gene block | bsai_5wt_tile9_sub2   | 850 nt | AAAA  | GCAT  |
| 3   | Oligo pool      | Tile 9 (1470 oligos)  | 278 nt | GCAT  | AGAA  |
| 4   | Helper plasmid  | helper_plasmid_insert | --     | --    | --    |
| 5   | Enzyme + buffer | BsaI-HFv2 + CutSmart  | --     | --    | --    |

```
  [ATGG]----5'WT sub1----[AAAA]----5'WT sub2----[GCAT]----oligo+BC----[AGAA]
   ATGG                   AAAA                   GCAT                  AGAA 
```

**Set fidelity:** 0.9907 (4 overhangs)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------ | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)      | --      | --    | --    |
| 2   | 3'WT block        | bsmbi_3wt_tile9_sub1     | 681 nt  | CTTT  | AAAA  |
| 3   | 3'WT block        | bsmbi_3wt_tile9_sub2     | 705 nt  | AAAA  | AGAA  |
| 4   | 3'WT block        | bsmbi_3wt_tile9_sub3     | 951 nt  | AGAA  | TCAA  |
| 5   | 3'WT block        | bsmbi_3wt_tile5_sub5     | 591 nt  | TCAA  | GAAA  |
| 6   | 3'WT+PolIII block | bsmbi_3wt_tile2_sub6     | 1931 nt | GAAA  | CACC  |
| 7   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1 | --      | --    | --    |

```
  [CTTT]----3'WT sub1----[AAAA]----3'WT sub2----[AGAA]----3'WT sub3----[TCAA]----3'WT sub4----[GAAA]----3'WT+PolIII sub5----[CACC]
   CTTT                   AAAA                   AGAA                   TCAA                   GAAA                          CACC 
```

**Set fidelity:** 0.9727 (6 overhangs)

---

### Tile 10 of 27 -- Codons 678-750 (219 nt)

**Boundary overhangs:**

| Position          | Sequence | Fidelity |
| ----------------- | -------- | -------- |
| oh1 (5' boundary) | TCGT     | 0.7335   |
| oh2 (3' boundary) | GACA     | 0.6127   |

**Variants:** 1449 mutations, 1449 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name             | Length  | 5' OH | 3' OH |
| --- | --------------- | --------------------- | ------- | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile9_sub1   | 995 nt  | ATGG  | AAAA  |
| 2   | 5'WT gene block | bsai_5wt_tile10_sub2  | 1072 nt | AAAA  | TCGT  |
| 3   | Oligo pool      | Tile 10 (1449 oligos) | 275 nt  | TCGT  | AGAA  |
| 4   | Helper plasmid  | helper_plasmid_insert | --      | --    | --    |
| 5   | Enzyme + buffer | BsaI-HFv2 + CutSmart  | --      | --    | --    |

```
  [ATGG]----5'WT sub1----[AAAA]----5'WT sub2----[TCGT]----oligo+BC----[AGAA]
   ATGG                   AAAA                   TCGT                  AGAA 
```

**Set fidelity:** 0.9907 (4 overhangs)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------ | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)      | --      | --    | --    |
| 2   | 3'WT block        | bsmbi_3wt_tile10_sub1    | 696 nt  | GACA  | AGAA  |
| 3   | 3'WT block        | bsmbi_3wt_tile6_sub3     | 762 nt  | AGAA  | TCAA  |
| 4   | 3'WT block        | bsmbi_3wt_tile10_sub3    | 747 nt  | TCAA  | AAAA  |
| 5   | 3'WT block        | bsmbi_3wt_tile10_sub4    | 504 nt  | AAAA  | GAAA  |
| 6   | 3'WT+PolIII block | bsmbi_3wt_tile2_sub6     | 1931 nt | GAAA  | CACC  |
| 7   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1 | --      | --    | --    |

```
  [GACA]----3'WT sub1----[AGAA]----3'WT sub2----[TCAA]----3'WT sub3----[AAAA]----3'WT sub4----[GAAA]----3'WT+PolIII sub5----[CACC]
   GACA                   AGAA                   TCAA                   AAAA                   GAAA                          CACC 
```

**Set fidelity:** 0.9662 (6 overhangs)

---

### Tile 11 of 27 -- Codons 751-791 (123 nt)

**Boundary overhangs:**

| Position          | Sequence | Fidelity |
| ----------------- | -------- | -------- |
| oh1 (5' boundary) | ATTA     | 0.7818   |
| oh2 (3' boundary) | TTCA     | 0.8824   |

**Variants:** 777 mutations, 777 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name             | Length  | 5' OH | 3' OH |
| --- | --------------- | --------------------- | ------- | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile9_sub1   | 995 nt  | ATGG  | AAAA  |
| 2   | 5'WT gene block | bsai_5wt_tile11_sub2  | 1291 nt | AAAA  | ATTA  |
| 3   | Oligo pool      | Tile 11 (777 oligos)  | 179 nt  | ATTA  | AGAA  |
| 4   | Helper plasmid  | helper_plasmid_insert | --      | --    | --    |
| 5   | Enzyme + buffer | BsaI-HFv2 + CutSmart  | --      | --    | --    |

```
  [ATGG]----5'WT sub1----[AAAA]----5'WT sub2----[ATTA]----oligo+BC----[AGAA]
   ATGG                   AAAA                   ATTA                  AGAA 
```

**Set fidelity:** 0.9907 (4 overhangs)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------ | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)      | --      | --    | --    |
| 2   | 3'WT block        | bsmbi_3wt_tile11_sub1    | 774 nt  | TTCA  | TCAA  |
| 3   | 3'WT block        | bsmbi_3wt_tile11_sub2    | 717 nt  | TCAA  | AAAA  |
| 4   | 3'WT block        | bsmbi_3wt_tile11_sub3    | 477 nt  | AAAA  | AAGA  |
| 5   | 3'WT block        | bsmbi_3wt_tile11_sub4    | 804 nt  | AAGA  | AGAA  |
| 6   | 3'WT+PolIII block | bsmbi_3wt_tile11_sub5    | 1745 nt | AGAA  | CACC  |
| 7   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1 | --      | --    | --    |

```
  [TTCA]----3'WT sub1----[TCAA]----3'WT sub2----[AAAA]----3'WT sub3----[AAGA]----3'WT sub4----[AGAA]----3'WT+PolIII sub5----[CACC]
   TTCA                   TCAA                   AAAA                   AAGA                   AGAA                          CACC 
```

**Set fidelity:** 0.9832 (6 overhangs)

---

### Tile 12 of 27 -- Codons 792-868 (231 nt)

**Boundary overhangs:**

| Position          | Sequence | Fidelity |
| ----------------- | -------- | -------- |
| oh1 (5' boundary) | TATC     | 0.8041   |
| oh2 (3' boundary) | TATT     | 0.8134   |

**Variants:** 1533 mutations, 1533 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name             | Length  | 5' OH | 3' OH |
| --- | --------------- | --------------------- | ------- | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile12_sub1  | 1214 nt | ATGG  | AAAA  |
| 2   | 5'WT gene block | bsai_5wt_tile12_sub2  | 1195 nt | AAAA  | TATC  |
| 3   | Oligo pool      | Tile 12 (1533 oligos) | 287 nt  | TATC  | AGAA  |
| 4   | Helper plasmid  | helper_plasmid_insert | --      | --    | --    |
| 5   | Enzyme + buffer | BsaI-HFv2 + CutSmart  | --      | --    | --    |

```
  [ATGG]----5'WT sub1----[AAAA]----5'WT sub2----[TATC]----oligo+BC----[AGAA]
   ATGG                   AAAA                   TATC                  AGAA 
```

**Set fidelity:** 0.9907 (4 overhangs)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------ | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)      | --      | --    | --    |
| 2   | 3'WT block        | bsmbi_3wt_tile12_sub1    | 543 nt  | TATT  | TCAA  |
| 3   | 3'WT block        | bsmbi_3wt_tile11_sub2    | 717 nt  | TCAA  | AAAA  |
| 4   | 3'WT block        | bsmbi_3wt_tile12_sub3    | 534 nt  | AAAA  | TAGA  |
| 5   | 3'WT block        | bsmbi_3wt_tile12_sub4    | 747 nt  | TAGA  | AGAA  |
| 6   | 3'WT+PolIII block | bsmbi_3wt_tile11_sub5    | 1745 nt | AGAA  | CACC  |
| 7   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1 | --      | --    | --    |

```
  [TATT]----3'WT sub1----[TCAA]----3'WT sub2----[AAAA]----3'WT sub3----[TAGA]----3'WT sub4----[AGAA]----3'WT+PolIII sub5----[CACC]
   TATT                   TCAA                   AAAA                   TAGA                   AGAA                          CACC 
```

**Set fidelity:** 0.9911 (6 overhangs)

---

### Tile 13 of 27 -- Codons 869-941 (219 nt)

**Boundary overhangs:**

| Position          | Sequence | Fidelity |
| ----------------- | -------- | -------- |
| oh1 (5' boundary) | CCTG     | 0.6383   |
| oh2 (3' boundary) | ATCT     | 0.7151   |

**Variants:** 1449 mutations, 1449 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name             | Length  | 5' OH | 3' OH |
| --- | --------------- | --------------------- | ------- | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile12_sub1  | 1214 nt | ATGG  | AAAA  |
| 2   | 5'WT gene block | bsai_5wt_tile13_sub2  | 1426 nt | AAAA  | CCTG  |
| 3   | Oligo pool      | Tile 13 (1449 oligos) | 275 nt  | CCTG  | AGAA  |
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
| 2   | 3'WT block        | bsmbi_3wt_tile13_sub1    | 672 nt  | ATCT  | AAAA  |
| 3   | 3'WT block        | bsmbi_3wt_tile13_sub2    | 855 nt  | AAAA  | TCAA  |
| 4   | 3'WT block        | bsmbi_3wt_tile13_sub3    | 777 nt  | TCAA  | AGAA  |
| 5   | 3'WT+PolIII block | bsmbi_3wt_tile11_sub5    | 1745 nt | AGAA  | CACC  |
| 6   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1 | --      | --    | --    |

```
  [ATCT]----3'WT sub1----[AAAA]----3'WT sub2----[TCAA]----3'WT sub3----[AGAA]----3'WT+PolIII sub4----[CACC]
   ATCT                   AAAA                   TCAA                   AGAA                          CACC 
```

**Set fidelity:** 0.9911 (5 overhangs)

---

### Tile 14 of 27 -- Codons 942-1012 (213 nt)

**Boundary overhangs:**

| Position          | Sequence | Fidelity |
| ----------------- | -------- | -------- |
| oh1 (5' boundary) | TTAT     | 0.8673   |
| oh2 (3' boundary) | TCAT     | 0.8102   |

**Variants:** 1407 mutations, 1407 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name             | Length  | 5' OH | 3' OH |
| --- | --------------- | --------------------- | ------- | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile14_sub1  | 1493 nt | ATGG  | AAAA  |
| 2   | 5'WT gene block | bsai_5wt_tile14_sub2  | 1366 nt | AAAA  | TTAT  |
| 3   | Oligo pool      | Tile 14 (1407 oligos) | 269 nt  | TTAT  | AGAA  |
| 4   | Helper plasmid  | helper_plasmid_insert | --      | --    | --    |
| 5   | Enzyme + buffer | BsaI-HFv2 + CutSmart  | --      | --    | --    |

```
  [ATGG]----5'WT sub1----[AAAA]----5'WT sub2----[TTAT]----oligo+BC----[AGAA]
   ATGG                   AAAA                   TTAT                  AGAA 
```

**Set fidelity:** 0.9907 (4 overhangs)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------ | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)      | --      | --    | --    |
| 2   | 3'WT block        | bsmbi_3wt_tile14_sub1    | 810 nt  | TCAT  | AAAA  |
| 3   | 3'WT block        | bsmbi_3wt_tile14_sub2    | 504 nt  | AAAA  | TCAA  |
| 4   | 3'WT block        | bsmbi_3wt_tile13_sub3    | 777 nt  | TCAA  | AGAA  |
| 5   | 3'WT+PolIII block | bsmbi_3wt_tile11_sub5    | 1745 nt | AGAA  | CACC  |
| 6   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1 | --      | --    | --    |

```
  [TCAT]----3'WT sub1----[AAAA]----3'WT sub2----[TCAA]----3'WT sub3----[AGAA]----3'WT+PolIII sub4----[CACC]
   TCAT                   AAAA                   TCAA                   AGAA                          CACC 
```

**Set fidelity:** 0.9692 (5 overhangs)

---

### Tile 15 of 27 -- Codons 1013-1082 (210 nt)

**Boundary overhangs:**

| Position          | Sequence | Fidelity |
| ----------------- | -------- | -------- |
| oh1 (5' boundary) | TCTA     | 0.8892   |
| oh2 (3' boundary) | GGAA     | 0.7463   |

**Variants:** 1386 mutations, 1386 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name             | Length  | 5' OH | 3' OH |
| --- | --------------- | --------------------- | ------- | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile14_sub1  | 1493 nt | ATGG  | AAAA  |
| 2   | 5'WT gene block | bsai_5wt_tile15_sub2  | 1579 nt | AAAA  | TCTA  |
| 3   | Oligo pool      | Tile 15 (1386 oligos) | 266 nt  | TCTA  | AGAA  |
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
| 2   | 3'WT block        | bsmbi_3wt_tile15_sub1    | 600 nt  | GGAA  | AAAA  |
| 3   | 3'WT block        | bsmbi_3wt_tile15_sub2    | 804 nt  | AAAA  | TCAA  |
| 4   | 3'WT block        | bsmbi_3wt_tile15_sub3    | 477 nt  | TCAA  | AGAA  |
| 5   | 3'WT+PolIII block | bsmbi_3wt_tile11_sub5    | 1745 nt | AGAA  | CACC  |
| 6   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1 | --      | --    | --    |

```
  [GGAA]----3'WT sub1----[AAAA]----3'WT sub2----[TCAA]----3'WT sub3----[AGAA]----3'WT+PolIII sub4----[CACC]
   GGAA                   AAAA                   TCAA                   AGAA                          CACC 
```

**Set fidelity:** 0.9381 (5 overhangs)

---

### Tile 16 of 27 -- Codons 1083-1150 (204 nt)

**Boundary overhangs:**

| Position          | Sequence | Fidelity |
| ----------------- | -------- | -------- |
| oh1 (5' boundary) | TTGC     | 0.7336   |
| oh2 (3' boundary) | ACAA     | 0.8919   |

**Variants:** 1344 mutations, 1344 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name             | Length  | 5' OH | 3' OH |
| --- | --------------- | --------------------- | ------- | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile14_sub1  | 1493 nt | ATGG  | AAAA  |
| 2   | 5'WT gene block | bsai_5wt_tile16_sub2  | 1789 nt | AAAA  | TTGC  |
| 3   | Oligo pool      | Tile 16 (1344 oligos) | 260 nt  | TTGC  | AGAA  |
| 4   | Helper plasmid  | helper_plasmid_insert | --      | --    | --    |
| 5   | Enzyme + buffer | BsaI-HFv2 + CutSmart  | --      | --    | --    |

```
  [ATGG]----5'WT sub1----[AAAA]----5'WT sub2----[TTGC]----oligo+BC----[AGAA]
   ATGG                   AAAA                   TTGC                  AGAA 
```

**Set fidelity:** 0.9907 (4 overhangs)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------ | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)      | --      | --    | --    |
| 2   | 3'WT block        | bsmbi_3wt_tile16_sub1    | 630 nt  | ACAA  | AAAA  |
| 3   | 3'WT block        | bsmbi_3wt_tile16_sub2    | 1029 nt | AAAA  | AGAA  |
| 4   | 3'WT+PolIII block | bsmbi_3wt_tile11_sub5    | 1745 nt | AGAA  | CACC  |
| 5   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1 | --      | --    | --    |

```
  [ACAA]----3'WT sub1----[AAAA]----3'WT sub2----[AGAA]----3'WT+PolIII sub3----[CACC]
   ACAA                   AAAA                   AGAA                          CACC 
```

**Set fidelity:** 0.9775 (4 overhangs)

---

### Tile 17 of 27 -- Codons 1151-1227 (231 nt)

**Boundary overhangs:**

| Position          | Sequence | Fidelity |
| ----------------- | -------- | -------- |
| oh1 (5' boundary) | GAGA     | 0.7444   |
| oh2 (3' boundary) | CCCT     | 0.6204   |

**Variants:** 1533 mutations, 1533 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name             | Length  | 5' OH | 3' OH |
| --- | --------------- | --------------------- | ------- | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile12_sub1  | 1214 nt | ATGG  | AAAA  |
| 2   | 5'WT gene block | bsai_5wt_tile17_sub2  | 1065 nt | AAAA  | TCAA  |
| 3   | 5'WT gene block | bsai_5wt_tile17_sub3  | 1225 nt | TCAA  | GAGA  |
| 4   | Oligo pool      | Tile 17 (1533 oligos) | 287 nt  | GAGA  | AGAA  |
| 5   | Helper plasmid  | helper_plasmid_insert | --      | --    | --    |
| 6   | Enzyme + buffer | BsaI-HFv2 + CutSmart  | --      | --    | --    |

```
  [ATGG]----5'WT sub1----[AAAA]----5'WT sub2----[TCAA]----5'WT sub3----[GAGA]----oligo+BC----[AGAA]
   ATGG                   AAAA                   TCAA                   GAGA                  AGAA 
```

**Set fidelity:** 0.9907 (5 overhangs)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------ | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)      | --      | --    | --    |
| 2   | 3'WT block        | bsmbi_3wt_tile17_sub1    | 738 nt  | CCCT  | AAAA  |
| 3   | 3'WT block        | bsmbi_3wt_tile17_sub2    | 690 nt  | AAAA  | AGAA  |
| 4   | 3'WT+PolIII block | bsmbi_3wt_tile11_sub5    | 1745 nt | AGAA  | CACC  |
| 5   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1 | --      | --    | --    |

```
  [CCCT]----3'WT sub1----[AAAA]----3'WT sub2----[AGAA]----3'WT+PolIII sub3----[CACC]
   CCCT                   AAAA                   AGAA                          CACC 
```

**Set fidelity:** 0.9911 (4 overhangs)

---

### Tile 18 of 27 -- Codons 1228-1305 (234 nt)

**Boundary overhangs:**

| Position          | Sequence | Fidelity |
| ----------------- | -------- | -------- |
| oh1 (5' boundary) | GTTA     | 0.6139   |
| oh2 (3' boundary) | TGTA     | 0.7693   |

**Variants:** 1554 mutations, 1554 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name             | Length  | 5' OH | 3' OH |
| --- | --------------- | --------------------- | ------- | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile12_sub1  | 1214 nt | ATGG  | AAAA  |
| 2   | 5'WT gene block | bsai_5wt_tile18_sub2  | 1371 nt | AAAA  | TAAA  |
| 3   | 5'WT gene block | bsai_5wt_tile18_sub3  | 1150 nt | TAAA  | GTTA  |
| 4   | Oligo pool      | Tile 18 (1554 oligos) | 290 nt  | GTTA  | AGAA  |
| 5   | Helper plasmid  | helper_plasmid_insert | --      | --    | --    |
| 6   | Enzyme + buffer | BsaI-HFv2 + CutSmart  | --      | --    | --    |

```
  [ATGG]----5'WT sub1----[AAAA]----5'WT sub2----[TAAA]----5'WT sub3----[GTTA]----oligo+BC----[AGAA]
   ATGG                   AAAA                   TAAA                   GTTA                  AGAA 
```

**Set fidelity:** 0.9764 (5 overhangs)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------ | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)      | --      | --    | --    |
| 2   | 3'WT block        | bsmbi_3wt_tile18_sub1    | 504 nt  | TGTA  | AAAA  |
| 3   | 3'WT block        | bsmbi_3wt_tile17_sub2    | 690 nt  | AAAA  | AGAA  |
| 4   | 3'WT+PolIII block | bsmbi_3wt_tile11_sub5    | 1745 nt | AGAA  | CACC  |
| 5   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1 | --      | --    | --    |

```
  [TGTA]----3'WT sub1----[AAAA]----3'WT sub2----[AGAA]----3'WT+PolIII sub3----[CACC]
   TGTA                   AAAA                   AGAA                          CACC 
```

**Set fidelity:** 0.9911 (4 overhangs)

---

### Tile 19 of 27 -- Codons 1306-1373 (204 nt)

**Boundary overhangs:**

| Position          | Sequence | Fidelity |
| ----------------- | -------- | -------- |
| oh1 (5' boundary) | ATAG     | 0.7330   |
| oh2 (3' boundary) | TAAA     | 0.9392   |

**Variants:** 1344 mutations, 1344 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name             | Length  | 5' OH | 3' OH |
| --- | --------------- | --------------------- | ------- | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile12_sub1  | 1214 nt | ATGG  | AAAA  |
| 2   | 5'WT gene block | bsai_5wt_tile18_sub2  | 1371 nt | AAAA  | TAAA  |
| 3   | 5'WT gene block | bsai_5wt_tile19_sub3  | 1384 nt | TAAA  | ATAG  |
| 4   | Oligo pool      | Tile 19 (1344 oligos) | 260 nt  | ATAG  | AGAA  |
| 5   | Helper plasmid  | helper_plasmid_insert | --      | --    | --    |
| 6   | Enzyme + buffer | BsaI-HFv2 + CutSmart  | --      | --    | --    |

```
  [ATGG]----5'WT sub1----[AAAA]----5'WT sub2----[TAAA]----5'WT sub3----[ATAG]----oligo+BC----[AGAA]
   ATGG                   AAAA                   TAAA                   ATAG                  AGAA 
```

**Set fidelity:** 0.9155 (5 overhangs)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------ | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)      | --      | --    | --    |
| 2   | 3'WT block        | bsmbi_3wt_tile19_sub1    | 537 nt  | TAAA  | AAAA  |
| 3   | 3'WT block        | bsmbi_3wt_tile19_sub2    | 645 nt  | AAAA  | TCTA  |
| 4   | 3'WT+PolIII block | bsmbi_3wt_tile19_sub3    | 1553 nt | TCTA  | CACC  |
| 5   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1 | --      | --    | --    |

```
  [TAAA]----3'WT sub1----[AAAA]----3'WT sub2----[TCTA]----3'WT+PolIII sub3----[CACC]
   TAAA                   AAAA                   TCTA                          CACC 
```

**Set fidelity:** 0.9809 (4 overhangs)

---

### Tile 20 of 27 -- Codons 1374-1451 (234 nt)

**Boundary overhangs:**

| Position          | Sequence | Fidelity |
| ----------------- | -------- | -------- |
| oh1 (5' boundary) | CGAT     | 0.6118   |
| oh2 (3' boundary) | GTAT     | 0.6602   |

**Variants:** 1554 mutations, 1554 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name             | Length  | 5' OH | 3' OH |
| --- | --------------- | --------------------- | ------- | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile14_sub1  | 1493 nt | ATGG  | AAAA  |
| 2   | 5'WT gene block | bsai_5wt_tile20_sub2  | 1266 nt | AAAA  | TAAA  |
| 3   | 5'WT gene block | bsai_5wt_tile20_sub3  | 1414 nt | TAAA  | CGAT  |
| 4   | Oligo pool      | Tile 20 (1554 oligos) | 290 nt  | CGAT  | AGAA  |
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
| 2   | 3'WT block        | bsmbi_3wt_tile20_sub1    | 369 nt  | GTAT  | AAAA  |
| 3   | 3'WT block        | bsmbi_3wt_tile20_sub2    | 579 nt  | AAAA  | TCTA  |
| 4   | 3'WT+PolIII block | bsmbi_3wt_tile19_sub3    | 1553 nt | TCTA  | CACC  |
| 5   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1 | --      | --    | --    |

```
  [GTAT]----3'WT sub1----[AAAA]----3'WT sub2----[TCTA]----3'WT+PolIII sub3----[CACC]
   GTAT                   AAAA                   TCTA                          CACC 
```

**Set fidelity:** 1.0000 (4 overhangs)

---

### Tile 21 of 27 -- Codons 1452-1529 (234 nt)

**Boundary overhangs:**

| Position          | Sequence | Fidelity |
| ----------------- | -------- | -------- |
| oh1 (5' boundary) | TCCC     | 0.7759   |
| oh2 (3' boundary) | TGGA     | 0.7377   |

**Variants:** 1554 mutations, 1554 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name             | Length  | 5' OH | 3' OH |
| --- | --------------- | --------------------- | ------- | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile14_sub1  | 1493 nt | ATGG  | AAAA  |
| 2   | 5'WT gene block | bsai_5wt_tile21_sub2  | 1371 nt | AAAA  | TAAA  |
| 3   | 5'WT gene block | bsai_5wt_tile21_sub3  | 1543 nt | TAAA  | TCCC  |
| 4   | Oligo pool      | Tile 21 (1554 oligos) | 290 nt  | TCCC  | AGAA  |
| 5   | Helper plasmid  | helper_plasmid_insert | --      | --    | --    |
| 6   | Enzyme + buffer | BsaI-HFv2 + CutSmart  | --      | --    | --    |

```
  [ATGG]----5'WT sub1----[AAAA]----5'WT sub2----[TAAA]----5'WT sub3----[TCCC]----oligo+BC----[AGAA]
   ATGG                   AAAA                   TAAA                   TCCC                  AGAA 
```

**Set fidelity:** 0.9764 (5 overhangs)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------ | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)      | --      | --    | --    |
| 2   | 3'WT block        | bsmbi_3wt_tile21_sub1    | 555 nt  | TGGA  | AAAA  |
| 3   | 3'WT+PolIII block | bsmbi_3wt_tile21_sub2    | 1694 nt | AAAA  | CACC  |
| 4   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1 | --      | --    | --    |

```
  [TGGA]----3'WT sub1----[AAAA]----3'WT+PolIII sub2----[CACC]
   TGGA                   AAAA                          CACC 
```

**Set fidelity:** 1.0000 (3 overhangs)

---

### Tile 22 of 27 -- Codons 1530-1593 (192 nt)

**Boundary overhangs:**

| Position          | Sequence | Fidelity |
| ----------------- | -------- | -------- |
| oh1 (5' boundary) | TATG     | 0.7006   |
| oh2 (3' boundary) | CAAT     | 0.7361   |

**Variants:** 1260 mutations, 1260 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name             | Length  | 5' OH | 3' OH |
| --- | --------------- | --------------------- | ------- | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile14_sub1  | 1493 nt | ATGG  | AAAA  |
| 2   | 5'WT gene block | bsai_5wt_tile22_sub2  | 1668 nt | AAAA  | TCAA  |
| 3   | 5'WT gene block | bsai_5wt_tile22_sub3  | 1480 nt | TCAA  | TATG  |
| 4   | Oligo pool      | Tile 22 (1260 oligos) | 248 nt  | TATG  | AGAA  |
| 5   | Helper plasmid  | helper_plasmid_insert | --      | --    | --    |
| 6   | Enzyme + buffer | BsaI-HFv2 + CutSmart  | --      | --    | --    |

```
  [ATGG]----5'WT sub1----[AAAA]----5'WT sub2----[TCAA]----5'WT sub3----[TATG]----oligo+BC----[AGAA]
   ATGG                   AAAA                   TCAA                   TATG                  AGAA 
```

**Set fidelity:** 0.9907 (5 overhangs)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------ | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)      | --      | --    | --    |
| 2   | 3'WT block        | bsmbi_3wt_tile22_sub1    | 363 nt  | CAAT  | AAAA  |
| 3   | 3'WT+PolIII block | bsmbi_3wt_tile21_sub2    | 1694 nt | AAAA  | CACC  |
| 4   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1 | --      | --    | --    |

```
  [CAAT]----3'WT sub1----[AAAA]----3'WT+PolIII sub2----[CACC]
   CAAT                   AAAA                          CACC 
```

**Set fidelity:** 1.0000 (3 overhangs)

---

### Tile 23 of 27 -- Codons 1594-1646 (159 nt)

**Boundary overhangs:**

| Position          | Sequence | Fidelity |
| ----------------- | -------- | -------- |
| oh1 (5' boundary) | GAAC     | 0.6079   |
| oh2 (3' boundary) | GCTT     | 0.5632   |

**Variants:** 1029 mutations, 1029 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name             | Length  | 5' OH | 3' OH |
| --- | --------------- | --------------------- | ------- | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile14_sub1  | 1493 nt | ATGG  | AAAA  |
| 2   | 5'WT gene block | bsai_5wt_tile22_sub2  | 1668 nt | AAAA  | TCAA  |
| 3   | 5'WT gene block | bsai_5wt_tile23_sub3  | 1672 nt | TCAA  | GAAC  |
| 4   | Oligo pool      | Tile 23 (1029 oligos) | 215 nt  | GAAC  | AGAA  |
| 5   | Helper plasmid  | helper_plasmid_insert | --      | --    | --    |
| 6   | Enzyme + buffer | BsaI-HFv2 + CutSmart  | --      | --    | --    |

```
  [ATGG]----5'WT sub1----[AAAA]----5'WT sub2----[TCAA]----5'WT sub3----[GAAC]----oligo+BC----[AGAA]
   ATGG                   AAAA                   TCAA                   GAAC                  AGAA 
```

**Set fidelity:** 0.9907 (5 overhangs)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------ | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)      | --      | --    | --    |
| 2   | 3'WT block        | bsmbi_3wt_tile23_sub1    | 345 nt  | GCTT  | TCTA  |
| 3   | 3'WT+PolIII block | bsmbi_3wt_tile19_sub3    | 1553 nt | TCTA  | CACC  |
| 4   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1 | --      | --    | --    |

```
  [GCTT]----3'WT sub1----[TCTA]----3'WT+PolIII sub2----[CACC]
   GCTT                   TCTA                          CACC 
```

**Set fidelity:** 1.0000 (3 overhangs)

---

### Tile 24 of 27 -- Codons 1647-1710 (192 nt)

**Boundary overhangs:**

| Position          | Sequence | Fidelity |
| ----------------- | -------- | -------- |
| oh1 (5' boundary) | AAGG     | 0.6552   |
| oh2 (3' boundary) | TCAG     | 0.7814   |

**Variants:** 1260 mutations, 1260 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name             | Length  | 5' OH | 3' OH |
| --- | --------------- | --------------------- | ------- | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile24_sub1  | 1622 nt | ATGG  | AAAA  |
| 2   | 5'WT gene block | bsai_5wt_tile24_sub2  | 1674 nt | AAAA  | TAAA  |
| 3   | 5'WT gene block | bsai_5wt_tile24_sub3  | 1696 nt | TAAA  | AAGG  |
| 4   | Oligo pool      | Tile 24 (1260 oligos) | 248 nt  | AAGG  | AGAA  |
| 5   | Helper plasmid  | helper_plasmid_insert | --      | --    | --    |
| 6   | Enzyme + buffer | BsaI-HFv2 + CutSmart  | --      | --    | --    |

```
  [ATGG]----5'WT sub1----[AAAA]----5'WT sub2----[TAAA]----5'WT sub3----[AAGG]----oligo+BC----[AGAA]
   ATGG                   AAAA                   TAAA                   AAGG                  AGAA 
```

**Set fidelity:** 0.8534 (5 overhangs)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------ | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)      | --      | --    | --    |
| 2   | 3'WT+PolIII block | bsmbi_3wt_tile24         | 1688 nt | TCAG  | CACC  |
| 3   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1 | --      | --    | --    |

```
  [TCAG]----3'WT+PolIII----[CACC]
   TCAG                     CACC 
```

**Set fidelity:** 1.0000 (2 overhangs)

---

### Tile 25 of 27 -- Codons 1711-1779 (207 nt)

**Boundary overhangs:**

| Position          | Sequence | Fidelity |
| ----------------- | -------- | -------- |
| oh1 (5' boundary) | GAAG     | 0.6752   |
| oh2 (3' boundary) | AACA     | 0.8032   |

**Variants:** 1365 mutations, 1365 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name             | Length  | 5' OH | 3' OH |
| --- | --------------- | --------------------- | ------- | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile24_sub1  | 1622 nt | ATGG  | AAAA  |
| 2   | 5'WT gene block | bsai_5wt_tile25_sub2  | 1776 nt | AAAA  | TAAA  |
| 3   | 5'WT gene block | bsai_5wt_tile25_sub3  | 1786 nt | TAAA  | GAAG  |
| 4   | Oligo pool      | Tile 25 (1365 oligos) | 263 nt  | GAAG  | AGAA  |
| 5   | Helper plasmid  | helper_plasmid_insert | --      | --    | --    |
| 6   | Enzyme + buffer | BsaI-HFv2 + CutSmart  | --      | --    | --    |

```
  [ATGG]----5'WT sub1----[AAAA]----5'WT sub2----[TAAA]----5'WT sub3----[GAAG]----oligo+BC----[AGAA]
   ATGG                   AAAA                   TAAA                   GAAG                  AGAA 
```

**Set fidelity:** 0.9764 (5 overhangs)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------ | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)      | --      | --    | --    |
| 2   | 3'WT+PolIII block | bsmbi_3wt_tile25         | 1481 nt | AACA  | CACC  |
| 3   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1 | --      | --    | --    |

```
  [AACA]----3'WT+PolIII----[CACC]
   AACA                     CACC 
```

**Set fidelity:** 1.0000 (2 overhangs)

---

### Tile 26 of 27 -- Codons 1780-1830 (153 nt)

**Boundary overhangs:**

| Position          | Sequence | Fidelity |
| ----------------- | -------- | -------- |
| oh1 (5' boundary) | TCCT     | 0.7573   |
| oh2 (3' boundary) | CATT     | 0.6770   |

**Variants:** 987 mutations, 987 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name             | Length  | 5' OH | 3' OH |
| --- | --------------- | --------------------- | ------- | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile12_sub1  | 1214 nt | ATGG  | AAAA  |
| 2   | 5'WT gene block | bsai_5wt_tile18_sub2  | 1371 nt | AAAA  | TAAA  |
| 3   | 5'WT gene block | bsai_5wt_tile26_sub3  | 1404 nt | TAAA  | AAGA  |
| 4   | 5'WT gene block | bsai_5wt_tile26_sub4  | 1420 nt | AAGA  | TCCT  |
| 5   | Oligo pool      | Tile 26 (987 oligos)  | 209 nt  | TCCT  | AGAA  |
| 6   | Helper plasmid  | helper_plasmid_insert | --      | --    | --    |
| 7   | Enzyme + buffer | BsaI-HFv2 + CutSmart  | --      | --    | --    |

```
  [ATGG]----5'WT sub1----[AAAA]----5'WT sub2----[TAAA]----5'WT sub3----[AAGA]----5'WT sub4----[TCCT]----oligo+BC----[AGAA]
   ATGG                   AAAA                   TAAA                   AAGA                   TCCT                  AGAA 
```

**Set fidelity:** 0.9676 (6 overhangs)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------ | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)      | --      | --    | --    |
| 2   | 3'WT+PolIII block | bsmbi_3wt_tile26         | 1328 nt | CATT  | CACC  |
| 3   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1 | --      | --    | --    |

```
  [CATT]----3'WT+PolIII----[CACC]
   CATT                     CACC 
```

**Set fidelity:** 1.0000 (2 overhangs)

---

### Tile 27 of 27 -- Codons 1831-1902 (216 nt)

**Boundary overhangs:**

| Position          | Sequence | Fidelity |
| ----------------- | -------- | -------- |
| oh1 (5' boundary) | CAGT     | 0.6512   |
| oh2 (3' boundary) | ATAG     | 0.7330   |

**Variants:** 1428 mutations, 1428 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name             | Length  | 5' OH | 3' OH |
| --- | --------------- | --------------------- | ------- | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile14_sub1  | 1493 nt | ATGG  | AAAA  |
| 2   | 5'WT gene block | bsai_5wt_tile20_sub2  | 1266 nt | AAAA  | TAAA  |
| 3   | 5'WT gene block | bsai_5wt_tile27_sub3  | 1473 nt | TAAA  | AAGA  |
| 4   | 5'WT gene block | bsai_5wt_tile27_sub4  | 1330 nt | AAGA  | CAGT  |
| 5   | Oligo pool      | Tile 27 (1428 oligos) | 272 nt  | CAGT  | AGAA  |
| 6   | Helper plasmid  | helper_plasmid_insert | --      | --    | --    |
| 7   | Enzyme + buffer | BsaI-HFv2 + CutSmart  | --      | --    | --    |

```
  [ATGG]----5'WT sub1----[AAAA]----5'WT sub2----[TAAA]----5'WT sub3----[AAGA]----5'WT sub4----[CAGT]----oligo+BC----[AGAA]
   ATGG                   AAAA                   TAAA                   AAGA                   CAGT                  AGAA 
```

**Set fidelity:** 0.9676 (6 overhangs)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component            | Part name                | Length  | 5' OH | 3' OH |
| --- | -------------------- | ------------------------ | ------- | ----- | ----- |
| 1   | BsaI product         | (in helper plasmid)      | --      | --    | --    |
| 2   | PolIII-only fragment | bsmbi_polIII_tile27      | 1112 nt | ATAG  | CACC  |
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

**Total blocks:** 119

| Block name            | Length (nt) | Enzyme type | Gene region                                                                                                                                                                             |
| --------------------- | ----------- | ----------- | --------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| bsai_5wt_tile10_sub2  | 1072        | BsaI        | 5wt_tile10_sub2                                                                                                                                                                         |
| bsai_5wt_tile11_sub2  | 1291        | BsaI        | 5wt_tile11_sub2                                                                                                                                                                         |
| bsai_5wt_tile12_sub1  | 1214        | BsaI        | 5wt_tile12_sub1;5wt_tile13_sub1;5wt_tile17_sub1;5wt_tile18_sub1;5wt_tile19_sub1;5wt_tile26_sub1                                                                                         |
| bsai_5wt_tile12_sub2  | 1195        | BsaI        | 5wt_tile12_sub2                                                                                                                                                                         |
| bsai_5wt_tile13_sub2  | 1426        | BsaI        | 5wt_tile13_sub2                                                                                                                                                                         |
| bsai_5wt_tile14_sub1  | 1493        | BsaI        | 5wt_tile14_sub1;5wt_tile15_sub1;5wt_tile16_sub1;5wt_tile20_sub1;5wt_tile21_sub1;5wt_tile22_sub1;5wt_tile23_sub1;5wt_tile27_sub1                                                         |
| bsai_5wt_tile14_sub2  | 1366        | BsaI        | 5wt_tile14_sub2                                                                                                                                                                         |
| bsai_5wt_tile15_sub2  | 1579        | BsaI        | 5wt_tile15_sub2                                                                                                                                                                         |
| bsai_5wt_tile16_sub2  | 1789        | BsaI        | 5wt_tile16_sub2                                                                                                                                                                         |
| bsai_5wt_tile17_sub2  | 1065        | BsaI        | 5wt_tile17_sub2                                                                                                                                                                         |
| bsai_5wt_tile17_sub3  | 1225        | BsaI        | 5wt_tile17_sub3                                                                                                                                                                         |
| bsai_5wt_tile18_sub2  | 1371        | BsaI        | 5wt_tile18_sub2;5wt_tile19_sub2;5wt_tile26_sub2                                                                                                                                         |
| bsai_5wt_tile18_sub3  | 1150        | BsaI        | 5wt_tile18_sub3                                                                                                                                                                         |
| bsai_5wt_tile19_sub3  | 1384        | BsaI        | 5wt_tile19_sub3                                                                                                                                                                         |
| bsai_5wt_tile2        | 237         | BsaI        | 5wt_tile2                                                                                                                                                                               |
| bsai_5wt_tile20_sub2  | 1266        | BsaI        | 5wt_tile20_sub2;5wt_tile27_sub2                                                                                                                                                         |
| bsai_5wt_tile20_sub3  | 1414        | BsaI        | 5wt_tile20_sub3                                                                                                                                                                         |
| bsai_5wt_tile21_sub2  | 1371        | BsaI        | 5wt_tile21_sub2                                                                                                                                                                         |
| bsai_5wt_tile21_sub3  | 1543        | BsaI        | 5wt_tile21_sub3                                                                                                                                                                         |
| bsai_5wt_tile22_sub2  | 1668        | BsaI        | 5wt_tile22_sub2;5wt_tile23_sub2                                                                                                                                                         |
| bsai_5wt_tile22_sub3  | 1480        | BsaI        | 5wt_tile22_sub3                                                                                                                                                                         |
| bsai_5wt_tile23_sub3  | 1672        | BsaI        | 5wt_tile23_sub3                                                                                                                                                                         |
| bsai_5wt_tile24_sub1  | 1622        | BsaI        | 5wt_tile24_sub1;5wt_tile25_sub1                                                                                                                                                         |
| bsai_5wt_tile24_sub2  | 1674        | BsaI        | 5wt_tile24_sub2                                                                                                                                                                         |
| bsai_5wt_tile24_sub3  | 1696        | BsaI        | 5wt_tile24_sub3                                                                                                                                                                         |
| bsai_5wt_tile25_sub2  | 1776        | BsaI        | 5wt_tile25_sub2                                                                                                                                                                         |
| bsai_5wt_tile25_sub3  | 1786        | BsaI        | 5wt_tile25_sub3                                                                                                                                                                         |
| bsai_5wt_tile26_sub3  | 1404        | BsaI        | 5wt_tile26_sub3                                                                                                                                                                         |
| bsai_5wt_tile26_sub4  | 1420        | BsaI        | 5wt_tile26_sub4                                                                                                                                                                         |
| bsai_5wt_tile27_sub3  | 1473        | BsaI        | 5wt_tile27_sub3                                                                                                                                                                         |
| bsai_5wt_tile27_sub4  | 1330        | BsaI        | 5wt_tile27_sub4                                                                                                                                                                         |
| bsai_5wt_tile3        | 444         | BsaI        | 5wt_tile3                                                                                                                                                                               |
| bsai_5wt_tile4        | 678         | BsaI        | 5wt_tile4                                                                                                                                                                               |
| bsai_5wt_tile5        | 906         | BsaI        | 5wt_tile5                                                                                                                                                                               |
| bsai_5wt_tile6        | 1134        | BsaI        | 5wt_tile6                                                                                                                                                                               |
| bsai_5wt_tile7        | 1365        | BsaI        | 5wt_tile7                                                                                                                                                                               |
| bsai_5wt_tile8        | 1593        | BsaI        | 5wt_tile8                                                                                                                                                                               |
| bsai_5wt_tile9_sub1   | 995         | BsaI        | 5wt_tile9_sub1;5wt_tile10_sub1;5wt_tile11_sub1                                                                                                                                          |
| bsai_5wt_tile9_sub2   | 850         | BsaI        | 5wt_tile9_sub2                                                                                                                                                                          |
| bsmbi_3wt_tile1_sub1  | 789         | BsmBI       | 3wt_tile1_sub1                                                                                                                                                                          |
| bsmbi_3wt_tile1_sub2  | 1035        | BsmBI       | 3wt_tile1_sub2                                                                                                                                                                          |
| bsmbi_3wt_tile1_sub3  | 939         | BsmBI       | 3wt_tile1_sub3                                                                                                                                                                          |
| bsmbi_3wt_tile1_sub4  | 1029        | BsmBI       | 3wt_tile1_sub4;3wt_tile2_sub4                                                                                                                                                           |
| bsmbi_3wt_tile1_sub5  | 735         | BsmBI       | 3wt_tile1_sub5                                                                                                                                                                          |
| bsmbi_3wt_tile1_sub6  | 2162        | BsmBI       | 3wt_polIII_tile1_sub6                                                                                                                                                                   |
| bsmbi_3wt_tile10_sub1 | 696         | BsmBI       | 3wt_tile10_sub1                                                                                                                                                                         |
| bsmbi_3wt_tile10_sub3 | 747         | BsmBI       | 3wt_tile10_sub3                                                                                                                                                                         |
| bsmbi_3wt_tile10_sub4 | 504         | BsmBI       | 3wt_tile10_sub4                                                                                                                                                                         |
| bsmbi_3wt_tile11_sub1 | 774         | BsmBI       | 3wt_tile11_sub1                                                                                                                                                                         |
| bsmbi_3wt_tile11_sub2 | 717         | BsmBI       | 3wt_tile11_sub2;3wt_tile12_sub2                                                                                                                                                         |
| bsmbi_3wt_tile11_sub3 | 477         | BsmBI       | 3wt_tile11_sub3                                                                                                                                                                         |
| bsmbi_3wt_tile11_sub4 | 804         | BsmBI       | 3wt_tile11_sub4                                                                                                                                                                         |
| bsmbi_3wt_tile11_sub5 | 1745        | BsmBI       | 3wt_polIII_tile11_sub5;3wt_polIII_tile12_sub5;3wt_polIII_tile13_sub4;3wt_polIII_tile14_sub4;3wt_polIII_tile15_sub4;3wt_polIII_tile16_sub3;3wt_polIII_tile17_sub3;3wt_polIII_tile18_sub3 |
| bsmbi_3wt_tile12_sub1 | 543         | BsmBI       | 3wt_tile12_sub1                                                                                                                                                                         |
| bsmbi_3wt_tile12_sub3 | 534         | BsmBI       | 3wt_tile12_sub3                                                                                                                                                                         |
| bsmbi_3wt_tile12_sub4 | 747         | BsmBI       | 3wt_tile12_sub4                                                                                                                                                                         |
| bsmbi_3wt_tile13_sub1 | 672         | BsmBI       | 3wt_tile13_sub1                                                                                                                                                                         |
| bsmbi_3wt_tile13_sub2 | 855         | BsmBI       | 3wt_tile13_sub2                                                                                                                                                                         |
| bsmbi_3wt_tile13_sub3 | 777         | BsmBI       | 3wt_tile13_sub3;3wt_tile14_sub3                                                                                                                                                         |
| bsmbi_3wt_tile14_sub1 | 810         | BsmBI       | 3wt_tile14_sub1                                                                                                                                                                         |
| bsmbi_3wt_tile14_sub2 | 504         | BsmBI       | 3wt_tile14_sub2                                                                                                                                                                         |
| bsmbi_3wt_tile15_sub1 | 600         | BsmBI       | 3wt_tile15_sub1                                                                                                                                                                         |
| bsmbi_3wt_tile15_sub2 | 804         | BsmBI       | 3wt_tile15_sub2                                                                                                                                                                         |
| bsmbi_3wt_tile15_sub3 | 477         | BsmBI       | 3wt_tile15_sub3                                                                                                                                                                         |
| bsmbi_3wt_tile16_sub1 | 630         | BsmBI       | 3wt_tile16_sub1                                                                                                                                                                         |
| bsmbi_3wt_tile16_sub2 | 1029        | BsmBI       | 3wt_tile16_sub2                                                                                                                                                                         |
| bsmbi_3wt_tile17_sub1 | 738         | BsmBI       | 3wt_tile17_sub1                                                                                                                                                                         |
| bsmbi_3wt_tile17_sub2 | 690         | BsmBI       | 3wt_tile17_sub2;3wt_tile18_sub2                                                                                                                                                         |
| bsmbi_3wt_tile18_sub1 | 504         | BsmBI       | 3wt_tile18_sub1                                                                                                                                                                         |
| bsmbi_3wt_tile19_sub1 | 537         | BsmBI       | 3wt_tile19_sub1                                                                                                                                                                         |
| bsmbi_3wt_tile19_sub2 | 645         | BsmBI       | 3wt_tile19_sub2                                                                                                                                                                         |
| bsmbi_3wt_tile19_sub3 | 1553        | BsmBI       | 3wt_polIII_tile19_sub3;3wt_polIII_tile20_sub3;3wt_polIII_tile23_sub2                                                                                                                    |
| bsmbi_3wt_tile2_sub1  | 792         | BsmBI       | 3wt_tile2_sub1                                                                                                                                                                          |
| bsmbi_3wt_tile2_sub2  | 1065        | BsmBI       | 3wt_tile2_sub2                                                                                                                                                                          |
| bsmbi_3wt_tile2_sub3  | 699         | BsmBI       | 3wt_tile2_sub3                                                                                                                                                                          |
| bsmbi_3wt_tile2_sub5  | 966         | BsmBI       | 3wt_tile2_sub5                                                                                                                                                                          |
| bsmbi_3wt_tile2_sub6  | 1931        | BsmBI       | 3wt_polIII_tile2_sub6;3wt_polIII_tile5_sub6;3wt_polIII_tile6_sub6;3wt_polIII_tile9_sub5;3wt_polIII_tile10_sub5                                                                          |
| bsmbi_3wt_tile20_sub1 | 369         | BsmBI       | 3wt_tile20_sub1                                                                                                                                                                         |
| bsmbi_3wt_tile20_sub2 | 579         | BsmBI       | 3wt_tile20_sub2                                                                                                                                                                         |
| bsmbi_3wt_tile21_sub1 | 555         | BsmBI       | 3wt_tile21_sub1                                                                                                                                                                         |
| bsmbi_3wt_tile21_sub2 | 1694        | BsmBI       | 3wt_polIII_tile21_sub2;3wt_polIII_tile22_sub2                                                                                                                                           |
| bsmbi_3wt_tile22_sub1 | 363         | BsmBI       | 3wt_tile22_sub1                                                                                                                                                                         |
| bsmbi_3wt_tile23_sub1 | 345         | BsmBI       | 3wt_tile23_sub1                                                                                                                                                                         |
| bsmbi_3wt_tile24      | 1688        | BsmBI       | 3wt_polIII_tile24                                                                                                                                                                       |
| bsmbi_3wt_tile25      | 1481        | BsmBI       | 3wt_polIII_tile25                                                                                                                                                                       |
| bsmbi_3wt_tile26      | 1328        | BsmBI       | 3wt_polIII_tile26                                                                                                                                                                       |
| bsmbi_3wt_tile3_sub1  | 837         | BsmBI       | 3wt_tile3_sub1                                                                                                                                                                          |
| bsmbi_3wt_tile3_sub2  | 786         | BsmBI       | 3wt_tile3_sub2                                                                                                                                                                          |
| bsmbi_3wt_tile3_sub3  | 1089        | BsmBI       | 3wt_tile3_sub3                                                                                                                                                                          |
| bsmbi_3wt_tile3_sub4  | 639         | BsmBI       | 3wt_tile3_sub4                                                                                                                                                                          |
| bsmbi_3wt_tile3_sub5  | 810         | BsmBI       | 3wt_tile3_sub5;3wt_tile7_sub4                                                                                                                                                           |
| bsmbi_3wt_tile3_sub6  | 2087        | BsmBI       | 3wt_polIII_tile3_sub6;3wt_polIII_tile7_sub5                                                                                                                                             |
| bsmbi_3wt_tile4_sub1  | 738         | BsmBI       | 3wt_tile4_sub1                                                                                                                                                                          |
| bsmbi_3wt_tile4_sub2  | 891         | BsmBI       | 3wt_tile4_sub2                                                                                                                                                                          |
| bsmbi_3wt_tile4_sub3  | 855         | BsmBI       | 3wt_tile4_sub3                                                                                                                                                                          |
| bsmbi_3wt_tile4_sub4  | 882         | BsmBI       | 3wt_tile4_sub4;3wt_tile8_sub3                                                                                                                                                           |
| bsmbi_3wt_tile4_sub5  | 591         | BsmBI       | 3wt_tile4_sub5                                                                                                                                                                          |
| bsmbi_3wt_tile4_sub6  | 2063        | BsmBI       | 3wt_polIII_tile4_sub6                                                                                                                                                                   |
| bsmbi_3wt_tile5_sub1  | 726         | BsmBI       | 3wt_tile5_sub1                                                                                                                                                                          |
| bsmbi_3wt_tile5_sub2  | 717         | BsmBI       | 3wt_tile5_sub2                                                                                                                                                                          |
| bsmbi_3wt_tile5_sub3  | 813         | BsmBI       | 3wt_tile5_sub3                                                                                                                                                                          |
| bsmbi_3wt_tile5_sub4  | 1014        | BsmBI       | 3wt_tile5_sub4                                                                                                                                                                          |
| bsmbi_3wt_tile5_sub5  | 591         | BsmBI       | 3wt_tile5_sub5;3wt_tile9_sub4                                                                                                                                                           |
| bsmbi_3wt_tile6_sub1  | 744         | BsmBI       | 3wt_tile6_sub1                                                                                                                                                                          |
| bsmbi_3wt_tile6_sub2  | 873         | BsmBI       | 3wt_tile6_sub2                                                                                                                                                                          |
| bsmbi_3wt_tile6_sub3  | 762         | BsmBI       | 3wt_tile6_sub3;3wt_tile10_sub2                                                                                                                                                          |
| bsmbi_3wt_tile6_sub4  | 528         | BsmBI       | 3wt_tile6_sub4                                                                                                                                                                          |
| bsmbi_3wt_tile6_sub5  | 723         | BsmBI       | 3wt_tile6_sub5                                                                                                                                                                          |
| bsmbi_3wt_tile7_sub1  | 708         | BsmBI       | 3wt_tile7_sub1                                                                                                                                                                          |
| bsmbi_3wt_tile7_sub2  | 882         | BsmBI       | 3wt_tile7_sub2                                                                                                                                                                          |
| bsmbi_3wt_tile7_sub3  | 828         | BsmBI       | 3wt_tile7_sub3                                                                                                                                                                          |
| bsmbi_3wt_tile8_sub1  | 681         | BsmBI       | 3wt_tile8_sub1                                                                                                                                                                          |
| bsmbi_3wt_tile8_sub2  | 864         | BsmBI       | 3wt_tile8_sub2                                                                                                                                                                          |
| bsmbi_3wt_tile8_sub4  | 618         | BsmBI       | 3wt_tile8_sub4                                                                                                                                                                          |
| bsmbi_3wt_tile8_sub5  | 2036        | BsmBI       | 3wt_polIII_tile8_sub5                                                                                                                                                                   |
| bsmbi_3wt_tile9_sub1  | 681         | BsmBI       | 3wt_tile9_sub1                                                                                                                                                                          |
| bsmbi_3wt_tile9_sub2  | 705         | BsmBI       | 3wt_tile9_sub2                                                                                                                                                                          |
| bsmbi_3wt_tile9_sub3  | 951         | BsmBI       | 3wt_tile9_sub3                                                                                                                                                                          |
| bsmbi_polIII_tile27   | 1112        | BsmBI       | polIII_tile27                                                                                                                                                                           |

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
| barcodes_per_variant  | 1              |
| boundary_method       | oogga_two_pass |
| multi_k_search        | TRUE           |
| auto_domesticate      | TRUE           |

