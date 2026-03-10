# DMS-GG Assembly Report: GRIN2A

Generated: 2026-03-10 10:41:18
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
| Oligo length range   | 149-284 nt                                                                     |
| Gene blocks to order | 52                                                                             |
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

**Total oligos:** 306810 | **Length range:** 149-284 nt

| Tile | Codons    | Oligos | Length |
| ---- | --------- | ------ | ------ |
| 1    | 1-31      | 5670   | 149 nt |
| 2    | 28-83     | 10920  | 224 nt |
| 3    | 80-148    | 13650  | 263 nt |
| 4    | 145-217   | 14490  | 275 nt |
| 5    | 214-283   | 13860  | 266 nt |
| 6    | 280-353   | 14700  | 278 nt |
| 7    | 350-420   | 14070  | 269 nt |
| 8    | 417-468   | 10080  | 212 nt |
| 9    | 465-533   | 13650  | 263 nt |
| 10   | 530-600   | 14070  | 269 nt |
| 11   | 597-672   | 15120  | 284 nt |
| 12   | 669-721   | 10290  | 215 nt |
| 13   | 718-770   | 10290  | 215 nt |
| 14   | 767-811   | 8610   | 191 nt |
| 15   | 808-883   | 15120  | 284 nt |
| 16   | 880-952   | 14490  | 275 nt |
| 17   | 949-1020  | 14280  | 272 nt |
| 18   | 1017-1081 | 12810  | 251 nt |
| 19   | 1078-1131 | 10500  | 218 nt |
| 20   | 1128-1194 | 13230  | 257 nt |
| 21   | 1191-1259 | 13650  | 263 nt |
| 22   | 1256-1325 | 13860  | 266 nt |
| 23   | 1322-1367 | 8820   | 194 nt |
| 24   | 1364-1437 | 14700  | 278 nt |
| 25   | 1434-1465 | 5880   | 152 nt |

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

| Check                  | Description                                                   | Result | Detail                                                                                                                                              |
| ---------------------- | ------------------------------------------------------------- | ------ | --------------------------------------------------------------------------------------------------------------------------------------------------- |
| oligo_lengths          | All oligos within synthesis length limit                      | PASS   | Range: 149-284 nt (limit: 300)                                                                                                                      |
| block_lengths          | All gene blocks within synthesis length limit                 | PASS   | Range: 99-1730 nt (limit: 1800)                                                                                                                     |
| barcode_junction_sites | No enzyme sites at barcode-context junctions                  | PASS   | 0 barcode(s) with junction enzyme sites (left='CACACC', right='AGAATG')                                                                             |
| barcode_uniqueness     | All barcodes are unique                                       | PASS   | 306810 unique / 306810 total                                                                                                                        |
| tile_coverage          | Tiles cover entire gene without gaps                          | PASS   | 4395 / 4395 nt covered                                                                                                                              |
| variant_count          | Expected number of variants generated                         | PASS   | 30681 unique variants (expected: 30681 across 1461/1463 mutable positions; 27759 missense + 1461 nonsense + 1461 wt_control; 2 position(s) skipped) |
| single_codon_change    | Each non-control variant differs by exactly one codon from WT | PASS   | 292200 / 292200 variants confirmed (WT controls excluded)                                                                                           |
| oligo_gc_content       | Oligo GC content within reasonable range (25-75%)             | PASS   | GC range: 38.2-69.1% | 0 oligo(s) with extreme GC                                                                                                   |
| domestication_complete | Gene domesticated for all 3 enzymes (BsaI, BsmBI, PaqCI)      | PASS   | No enzyme sites in gene                                                                                                                             |
| overhang_fidelity      | Tile boundary overhangs have adequate fidelity                | FAIL   | 22 tile(s) with low-fidelity boundary overhangs (<0.80)                                                                                             |
| tile_manifests         | Per-tile assembly manifests complete                          | PASS   | 25 tile manifest(s) generated                                                                                                                       |
| helper_plasmid         | Helper plasmid free of unintended BsmBI sites                 | PASS   | OK                                                                                                                                                  |
| reaction_fidelity      | Per-reaction set-level overhang fidelity                      | FAIL   | Min set fidelity: 0.7402 across 50 reactions | 3 reaction(s) below 0.90                                                                             |
| barcode_poliii_term    | No barcodes contain PolIII terminator signal (TTTT)           | PASS   | 0 / 306810 barcode(s) contain TTTT                                                                                                                  |
| block_min_length       | All gene blocks above synthesis minimum length                | FAIL   | 5 block(s) below 300 nt minimum. Range: 99-1730 nt                                                                                                  |
| sb_overhang_collisions | Superblock boundary overhangs are unique (no collisions)      | PASS   | 5 SB boundary OH(s), all unique                                                                                                                     |

## 5b. Reaction Fidelity Summary

Set fidelity for each tile's BsaI and BsmBI reactions,
computed from the actual block overhangs after construction:

| Tile | BsaI OHs | BsaI Set Fidelity | BsmBI OHs | BsmBI Set Fidelity |
| ---- | -------- | ----------------- | --------- | ------------------ |
| 1    | 2        | 1.0000            | 5         | 0.8916             |
| 2    | 3        | 1.0000            | 5         | 0.7402             |
| 3    | 3        | 1.0000            | 5         | 1.0000             |
| 4    | 3        | 1.0000            | 5         | 0.9194             |
| 5    | 3        | 1.0000            | 5         | 0.9777             |
| 6    | 3        | 1.0000            | 5         | 1.0000             |
| 7    | 3        | 1.0000            | 5         | 1.0000             |
| 8    | 3        | 1.0000            | 4         | 0.9658             |
| 9    | 3        | 1.0000            | 4         | 1.0000             |
| 10   | 3        | 1.0000            | 4         | 1.0000             |
| 11   | 4        | 1.0000            | 4         | 1.0000             |
| 12   | 4        | 1.0000            | 4         | 1.0000             |
| 13   | 4        | 1.0000            | 3         | 1.0000             |
| 14   | 4        | 1.0000            | 3         | 1.0000             |
| 15   | 4        | 0.8940            | 3         | 1.0000             |
| 16   | 5        | 1.0000            | 3         | 1.0000             |
| 17   | 5        | 0.9986            | 3         | 0.9658             |
| 18   | 5        | 0.9755            | 3         | 1.0000             |
| 19   | 5        | 1.0000            | 3         | 1.0000             |
| 20   | 5        | 1.0000            | 3         | 1.0000             |
| 21   | 5        | 1.0000            | 2         | 0.9983             |
| 22   | 5        | 1.0000            | 2         | 1.0000             |
| 23   | 5        | 0.9472            | 2         | 1.0000             |
| 24   | 6        | 1.0000            | 2         | 1.0000             |
| 25   | 6        | 0.9510            | 2         | 1.0000             |

**Min:** 0.7402 | **Max:** 1.0000 | **Mean:** 0.9845

**Warning:** 3 reaction(s) below 0.90 fidelity — consider alternative split points or overhang reassignment.
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

### Tile 1 of 25 -- Codons 1-31 (93 nt)

**Boundary overhangs:**

| Position          | Sequence | Fidelity |
| ----------------- | -------- | -------- |
| oh1 (5' boundary) | ATGG     | 0.5393   |
| oh2 (3' boundary) | TCCC     | 0.7759   |

**Variants:** 5670 mutations, 5670 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name                          | Length | 5' OH | 3' OH |
| --- | --------------- | ---------------------------------- | ------ | ----- | ----- |
| 1   | 5'WT gene block | (none -- tile starts at gene nt 1) | --     | --    | --    |
| 2   | Oligo pool      | Tile 1 (5670 oligos)               | 149 nt | ATGG  | AGAA  |
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
| 2   | 3'WT block        | bsmbi_3wt_tile1_sub1     | 1524 nt | TCCC  | AATC  |
| 3   | 3'WT block        | bsmbi_3wt_tile1_sub2     | 729 nt  | AATC  | TCCT  |
| 4   | 3'WT block        | bsmbi_3wt_tile1_sub3     | 1683 nt | TCCT  | TTAC  |
| 5   | 3'WT+PolIII block | bsmbi_3wt_tile1_sub4     | 1532 nt | TTAC  | CACC  |
| 6   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1 | --      | --    | --    |

```
  [TCCC]----3'WT sub1----[AATC]----3'WT sub2----[TCCT]----3'WT sub3----[TTAC]----3'WT+PolIII sub4----[CACC]
   TCCC                   AATC                   TCCT                   TTAC                          CACC 
```

**Set fidelity:** 0.8916 (5 overhangs)

---

### Tile 2 of 25 -- Codons 28-83 (168 nt)

**Boundary overhangs:**

| Position          | Sequence | Fidelity |
| ----------------- | -------- | -------- |
| oh1 (5' boundary) | GAGA     | 0.7444   |
| oh2 (3' boundary) | CATC     | 0.5216   |

**Variants:** 10920 mutations, 10920 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name             | Length | 5' OH | 3' OH |
| --- | --------------- | --------------------- | ------ | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile2        | 99 nt  | ATGG  | GAGA  |
| 2   | Oligo pool      | Tile 2 (10920 oligos) | 224 nt | GAGA  | AGAA  |
| 3   | Helper plasmid  | helper_plasmid_insert | --     | --    | --    |
| 4   | Enzyme + buffer | BsaI-HFv2 + CutSmart  | --     | --    | --    |

```
  [ATGG]----5'WT block----[GAGA]----oligo+BC----[AGAA]
   ATGG                    GAGA                  AGAA 
```

**Set fidelity:** 1.0000 (3 overhangs)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------ | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)      | --      | --    | --    |
| 2   | 3'WT block        | bsmbi_3wt_tile2_sub1     | 1368 nt | CATC  | AATC  |
| 3   | 3'WT block        | bsmbi_3wt_tile1_sub2     | 729 nt  | AATC  | TCCT  |
| 4   | 3'WT block        | bsmbi_3wt_tile1_sub3     | 1683 nt | TCCT  | TTAC  |
| 5   | 3'WT+PolIII block | bsmbi_3wt_tile1_sub4     | 1532 nt | TTAC  | CACC  |
| 6   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1 | --      | --    | --    |

```
  [CATC]----3'WT sub1----[AATC]----3'WT sub2----[TCCT]----3'WT sub3----[TTAC]----3'WT+PolIII sub4----[CACC]
   CATC                   AATC                   TCCT                   TTAC                          CACC 
```

**Set fidelity:** 0.7402 (5 overhangs)

---

### Tile 3 of 25 -- Codons 80-148 (207 nt)

**Boundary overhangs:**

| Position          | Sequence | Fidelity |
| ----------------- | -------- | -------- |
| oh1 (5' boundary) | AAGA     | 0.9209   |
| oh2 (3' boundary) | TGGA     | 0.7377   |

**Variants:** 13650 mutations, 13650 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name             | Length | 5' OH | 3' OH |
| --- | --------------- | --------------------- | ------ | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile3        | 255 nt | ATGG  | AAGA  |
| 2   | Oligo pool      | Tile 3 (13650 oligos) | 263 nt | AAGA  | AGAA  |
| 3   | Helper plasmid  | helper_plasmid_insert | --     | --    | --    |
| 4   | Enzyme + buffer | BsaI-HFv2 + CutSmart  | --     | --    | --    |

```
  [ATGG]----5'WT block----[AAGA]----oligo+BC----[AGAA]
   ATGG                    AAGA                  AGAA 
```

**Set fidelity:** 1.0000 (3 overhangs)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------ | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)      | --      | --    | --    |
| 2   | 3'WT block        | bsmbi_3wt_tile3_sub1     | 1173 nt | TGGA  | AATC  |
| 3   | 3'WT block        | bsmbi_3wt_tile1_sub2     | 729 nt  | AATC  | TCCT  |
| 4   | 3'WT block        | bsmbi_3wt_tile1_sub3     | 1683 nt | TCCT  | TTAC  |
| 5   | 3'WT+PolIII block | bsmbi_3wt_tile1_sub4     | 1532 nt | TTAC  | CACC  |
| 6   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1 | --      | --    | --    |

```
  [TGGA]----3'WT sub1----[AATC]----3'WT sub2----[TCCT]----3'WT sub3----[TTAC]----3'WT+PolIII sub4----[CACC]
   TGGA                   AATC                   TCCT                   TTAC                          CACC 
```

**Set fidelity:** 1.0000 (5 overhangs)

---

### Tile 4 of 25 -- Codons 145-217 (219 nt)

**Boundary overhangs:**

| Position          | Sequence | Fidelity |
| ----------------- | -------- | -------- |
| oh1 (5' boundary) | TTCC     | 0.7958   |
| oh2 (3' boundary) | AGTC     | 0.5938   |

**Variants:** 14490 mutations, 14490 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name             | Length | 5' OH | 3' OH |
| --- | --------------- | --------------------- | ------ | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile4        | 450 nt | ATGG  | TTCC  |
| 2   | Oligo pool      | Tile 4 (14490 oligos) | 275 nt | TTCC  | AGAA  |
| 3   | Helper plasmid  | helper_plasmid_insert | --     | --    | --    |
| 4   | Enzyme + buffer | BsaI-HFv2 + CutSmart  | --     | --    | --    |

```
  [ATGG]----5'WT block----[TTCC]----oligo+BC----[AGAA]
   ATGG                    TTCC                  AGAA 
```

**Set fidelity:** 1.0000 (3 overhangs)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------ | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)      | --      | --    | --    |
| 2   | 3'WT block        | bsmbi_3wt_tile4_sub1     | 966 nt  | AGTC  | AATC  |
| 3   | 3'WT block        | bsmbi_3wt_tile1_sub2     | 729 nt  | AATC  | TCCT  |
| 4   | 3'WT block        | bsmbi_3wt_tile1_sub3     | 1683 nt | TCCT  | TTAC  |
| 5   | 3'WT+PolIII block | bsmbi_3wt_tile1_sub4     | 1532 nt | TTAC  | CACC  |
| 6   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1 | --      | --    | --    |

```
  [AGTC]----3'WT sub1----[AATC]----3'WT sub2----[TCCT]----3'WT sub3----[TTAC]----3'WT+PolIII sub4----[CACC]
   AGTC                   AATC                   TCCT                   TTAC                          CACC 
```

**Set fidelity:** 0.9194 (5 overhangs)

---

### Tile 5 of 25 -- Codons 214-283 (210 nt)

**Boundary overhangs:**

| Position          | Sequence | Fidelity |
| ----------------- | -------- | -------- |
| oh1 (5' boundary) | AAGA     | 0.9209   |
| oh2 (3' boundary) | TGAC     | 0.6485   |

**Variants:** 13860 mutations, 13860 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name             | Length | 5' OH | 3' OH |
| --- | --------------- | --------------------- | ------ | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile5        | 657 nt | ATGG  | AAGA  |
| 2   | Oligo pool      | Tile 5 (13860 oligos) | 266 nt | AAGA  | AGAA  |
| 3   | Helper plasmid  | helper_plasmid_insert | --     | --    | --    |
| 4   | Enzyme + buffer | BsaI-HFv2 + CutSmart  | --     | --    | --    |

```
  [ATGG]----5'WT block----[AAGA]----oligo+BC----[AGAA]
   ATGG                    AAGA                  AGAA 
```

**Set fidelity:** 1.0000 (3 overhangs)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------ | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)      | --      | --    | --    |
| 2   | 3'WT block        | bsmbi_3wt_tile5_sub1     | 768 nt  | TGAC  | AATC  |
| 3   | 3'WT block        | bsmbi_3wt_tile1_sub2     | 729 nt  | AATC  | TCCT  |
| 4   | 3'WT block        | bsmbi_3wt_tile1_sub3     | 1683 nt | TCCT  | TTAC  |
| 5   | 3'WT+PolIII block | bsmbi_3wt_tile1_sub4     | 1532 nt | TTAC  | CACC  |
| 6   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1 | --      | --    | --    |

```
  [TGAC]----3'WT sub1----[AATC]----3'WT sub2----[TCCT]----3'WT sub3----[TTAC]----3'WT+PolIII sub4----[CACC]
   TGAC                   AATC                   TCCT                   TTAC                          CACC 
```

**Set fidelity:** 0.9777 (5 overhangs)

---

### Tile 6 of 25 -- Codons 280-353 (222 nt)

**Boundary overhangs:**

| Position          | Sequence | Fidelity |
| ----------------- | -------- | -------- |
| oh1 (5' boundary) | TCCT     | 0.7573   |
| oh2 (3' boundary) | GGAA     | 0.7463   |

**Variants:** 14700 mutations, 14700 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name             | Length | 5' OH | 3' OH |
| --- | --------------- | --------------------- | ------ | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile6        | 855 nt | ATGG  | TCCT  |
| 2   | Oligo pool      | Tile 6 (14700 oligos) | 278 nt | TCCT  | AGAA  |
| 3   | Helper plasmid  | helper_plasmid_insert | --     | --    | --    |
| 4   | Enzyme + buffer | BsaI-HFv2 + CutSmart  | --     | --    | --    |

```
  [ATGG]----5'WT block----[TCCT]----oligo+BC----[AGAA]
   ATGG                    TCCT                  AGAA 
```

**Set fidelity:** 1.0000 (3 overhangs)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------ | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)      | --      | --    | --    |
| 2   | 3'WT block        | bsmbi_3wt_tile6_sub1     | 558 nt  | GGAA  | AATC  |
| 3   | 3'WT block        | bsmbi_3wt_tile1_sub2     | 729 nt  | AATC  | TCCT  |
| 4   | 3'WT block        | bsmbi_3wt_tile1_sub3     | 1683 nt | TCCT  | TTAC  |
| 5   | 3'WT+PolIII block | bsmbi_3wt_tile1_sub4     | 1532 nt | TTAC  | CACC  |
| 6   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1 | --      | --    | --    |

```
  [GGAA]----3'WT sub1----[AATC]----3'WT sub2----[TCCT]----3'WT sub3----[TTAC]----3'WT+PolIII sub4----[CACC]
   GGAA                   AATC                   TCCT                   TTAC                          CACC 
```

**Set fidelity:** 1.0000 (5 overhangs)

---

### Tile 7 of 25 -- Codons 350-420 (213 nt)

**Boundary overhangs:**

| Position          | Sequence | Fidelity |
| ----------------- | -------- | -------- |
| oh1 (5' boundary) | TTCA     | 0.8824   |
| oh2 (3' boundary) | GGAA     | 0.7463   |

**Variants:** 14070 mutations, 14070 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name             | Length  | 5' OH | 3' OH |
| --- | --------------- | --------------------- | ------- | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile7        | 1065 nt | ATGG  | TTCA  |
| 2   | Oligo pool      | Tile 7 (14070 oligos) | 269 nt  | TTCA  | AGAA  |
| 3   | Helper plasmid  | helper_plasmid_insert | --      | --    | --    |
| 4   | Enzyme + buffer | BsaI-HFv2 + CutSmart  | --      | --    | --    |

```
  [ATGG]----5'WT block----[TTCA]----oligo+BC----[AGAA]
   ATGG                    TTCA                  AGAA 
```

**Set fidelity:** 1.0000 (3 overhangs)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------ | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)      | --      | --    | --    |
| 2   | 3'WT block        | bsmbi_3wt_tile7_sub1     | 357 nt  | GGAA  | AATC  |
| 3   | 3'WT block        | bsmbi_3wt_tile1_sub2     | 729 nt  | AATC  | TCCT  |
| 4   | 3'WT block        | bsmbi_3wt_tile1_sub3     | 1683 nt | TCCT  | TTAC  |
| 5   | 3'WT+PolIII block | bsmbi_3wt_tile1_sub4     | 1532 nt | TTAC  | CACC  |
| 6   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1 | --      | --    | --    |

```
  [GGAA]----3'WT sub1----[AATC]----3'WT sub2----[TCCT]----3'WT sub3----[TTAC]----3'WT+PolIII sub4----[CACC]
   GGAA                   AATC                   TCCT                   TTAC                          CACC 
```

**Set fidelity:** 1.0000 (5 overhangs)

---

### Tile 8 of 25 -- Codons 417-468 (156 nt)

**Boundary overhangs:**

| Position          | Sequence | Fidelity |
| ----------------- | -------- | -------- |
| oh1 (5' boundary) | GTCA     | 0.5915   |
| oh2 (3' boundary) | TTCC     | 0.7958   |

**Variants:** 10080 mutations, 10080 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name             | Length  | 5' OH | 3' OH |
| --- | --------------- | --------------------- | ------- | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile8        | 1266 nt | ATGG  | GTCA  |
| 2   | Oligo pool      | Tile 8 (10080 oligos) | 212 nt  | GTCA  | AGAA  |
| 3   | Helper plasmid  | helper_plasmid_insert | --      | --    | --    |
| 4   | Enzyme + buffer | BsaI-HFv2 + CutSmart  | --      | --    | --    |

```
  [ATGG]----5'WT block----[GTCA]----oligo+BC----[AGAA]
   ATGG                    GTCA                  AGAA 
```

**Set fidelity:** 1.0000 (3 overhangs)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------ | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)      | --      | --    | --    |
| 2   | 3'WT block        | bsmbi_3wt_tile8_sub1     | 924 nt  | TTCC  | TCCT  |
| 3   | 3'WT block        | bsmbi_3wt_tile1_sub3     | 1683 nt | TCCT  | TTAC  |
| 4   | 3'WT+PolIII block | bsmbi_3wt_tile1_sub4     | 1532 nt | TTAC  | CACC  |
| 5   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1 | --      | --    | --    |

```
  [TTCC]----3'WT sub1----[TCCT]----3'WT sub2----[TTAC]----3'WT+PolIII sub3----[CACC]
   TTCC                   TCCT                   TTAC                          CACC 
```

**Set fidelity:** 0.9658 (4 overhangs)

---

### Tile 9 of 25 -- Codons 465-533 (207 nt)

**Boundary overhangs:**

| Position          | Sequence | Fidelity |
| ----------------- | -------- | -------- |
| oh1 (5' boundary) | AAGA     | 0.9209   |
| oh2 (3' boundary) | AATC     | 0.7116   |

**Variants:** 13650 mutations, 13650 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name             | Length  | 5' OH | 3' OH |
| --- | --------------- | --------------------- | ------- | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile9        | 1410 nt | ATGG  | AAGA  |
| 2   | Oligo pool      | Tile 9 (13650 oligos) | 263 nt  | AAGA  | AGAA  |
| 3   | Helper plasmid  | helper_plasmid_insert | --      | --    | --    |
| 4   | Enzyme + buffer | BsaI-HFv2 + CutSmart  | --      | --    | --    |

```
  [ATGG]----5'WT block----[AAGA]----oligo+BC----[AGAA]
   ATGG                    AAGA                  AGAA 
```

**Set fidelity:** 1.0000 (3 overhangs)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------ | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)      | --      | --    | --    |
| 2   | 3'WT block        | bsmbi_3wt_tile1_sub2     | 729 nt  | AATC  | TCCT  |
| 3   | 3'WT block        | bsmbi_3wt_tile1_sub3     | 1683 nt | TCCT  | TTAC  |
| 4   | 3'WT+PolIII block | bsmbi_3wt_tile1_sub4     | 1532 nt | TTAC  | CACC  |
| 5   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1 | --      | --    | --    |

```
  [AATC]----3'WT sub1----[TCCT]----3'WT sub2----[TTAC]----3'WT+PolIII sub3----[CACC]
   AATC                   TCCT                   TTAC                          CACC 
```

**Set fidelity:** 1.0000 (4 overhangs)

---

### Tile 10 of 25 -- Codons 530-600 (213 nt)

**Boundary overhangs:**

| Position          | Sequence | Fidelity |
| ----------------- | -------- | -------- |
| oh1 (5' boundary) | GAAA     | 0.8745   |
| oh2 (3' boundary) | TACA     | 0.8652   |

**Variants:** 14070 mutations, 14070 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name              | Length  | 5' OH | 3' OH |
| --- | --------------- | ---------------------- | ------- | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile10        | 1605 nt | ATGG  | GAAA  |
| 2   | Oligo pool      | Tile 10 (14070 oligos) | 269 nt  | GAAA  | AGAA  |
| 3   | Helper plasmid  | helper_plasmid_insert  | --      | --    | --    |
| 4   | Enzyme + buffer | BsaI-HFv2 + CutSmart   | --      | --    | --    |

```
  [ATGG]----5'WT block----[GAAA]----oligo+BC----[AGAA]
   ATGG                    GAAA                  AGAA 
```

**Set fidelity:** 1.0000 (3 overhangs)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------ | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)      | --      | --    | --    |
| 2   | 3'WT block        | bsmbi_3wt_tile10_sub1    | 528 nt  | TACA  | TCCT  |
| 3   | 3'WT block        | bsmbi_3wt_tile1_sub3     | 1683 nt | TCCT  | TTAC  |
| 4   | 3'WT+PolIII block | bsmbi_3wt_tile1_sub4     | 1532 nt | TTAC  | CACC  |
| 5   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1 | --      | --    | --    |

```
  [TACA]----3'WT sub1----[TCCT]----3'WT sub2----[TTAC]----3'WT+PolIII sub3----[CACC]
   TACA                   TCCT                   TTAC                          CACC 
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
| 1   | 5'WT gene block | bsai_5wt_tile11_sub1   | 1613 nt | ATGG  | AATC  |
| 2   | 5'WT gene block | bsai_5wt_tile11_sub2   | 211 nt  | AATC  | CCTT  |
| 3   | Oligo pool      | Tile 11 (15120 oligos) | 284 nt  | CCTT  | AGAA  |
| 4   | Helper plasmid  | helper_plasmid_insert  | --      | --    | --    |
| 5   | Enzyme + buffer | BsaI-HFv2 + CutSmart   | --      | --    | --    |

```
  [ATGG]----5'WT sub1----[AATC]----5'WT sub2----[CCTT]----oligo+BC----[AGAA]
   ATGG                   AATC                   CCTT                  AGAA 
```

**Set fidelity:** 1.0000 (4 overhangs)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------ | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)      | --      | --    | --    |
| 2   | 3'WT block        | bsmbi_3wt_tile11_sub1    | 312 nt  | AAGA  | TCCT  |
| 3   | 3'WT block        | bsmbi_3wt_tile1_sub3     | 1683 nt | TCCT  | TTAC  |
| 4   | 3'WT+PolIII block | bsmbi_3wt_tile1_sub4     | 1532 nt | TTAC  | CACC  |
| 5   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1 | --      | --    | --    |

```
  [AAGA]----3'WT sub1----[TCCT]----3'WT sub2----[TTAC]----3'WT+PolIII sub3----[CACC]
   AAGA                   TCCT                   TTAC                          CACC 
```

**Set fidelity:** 1.0000 (4 overhangs)

---

### Tile 12 of 25 -- Codons 669-721 (159 nt)

**Boundary overhangs:**

| Position          | Sequence | Fidelity |
| ----------------- | -------- | -------- |
| oh1 (5' boundary) | AAGT     | 0.7629   |
| oh2 (3' boundary) | GAAA     | 0.8745   |

**Variants:** 10290 mutations, 10290 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name              | Length  | 5' OH | 3' OH |
| --- | --------------- | ---------------------- | ------- | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile11_sub1   | 1613 nt | ATGG  | AATC  |
| 2   | 5'WT gene block | bsai_5wt_tile12_sub2   | 427 nt  | AATC  | AAGT  |
| 3   | Oligo pool      | Tile 12 (10290 oligos) | 215 nt  | AAGT  | AGAA  |
| 4   | Helper plasmid  | helper_plasmid_insert  | --      | --    | --    |
| 5   | Enzyme + buffer | BsaI-HFv2 + CutSmart   | --      | --    | --    |

```
  [ATGG]----5'WT sub1----[AATC]----5'WT sub2----[AAGT]----oligo+BC----[AGAA]
   ATGG                   AATC                   AAGT                  AGAA 
```

**Set fidelity:** 1.0000 (4 overhangs)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------ | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)      | --      | --    | --    |
| 2   | 3'WT block        | bsmbi_3wt_tile12_sub1    | 165 nt  | GAAA  | TCCT  |
| 3   | 3'WT block        | bsmbi_3wt_tile1_sub3     | 1683 nt | TCCT  | TTAC  |
| 4   | 3'WT+PolIII block | bsmbi_3wt_tile1_sub4     | 1532 nt | TTAC  | CACC  |
| 5   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1 | --      | --    | --    |

```
  [GAAA]----3'WT sub1----[TCCT]----3'WT sub2----[TTAC]----3'WT+PolIII sub3----[CACC]
   GAAA                   TCCT                   TTAC                          CACC 
```

**Set fidelity:** 1.0000 (4 overhangs)

---

### Tile 13 of 25 -- Codons 718-770 (159 nt)

**Boundary overhangs:**

| Position          | Sequence | Fidelity |
| ----------------- | -------- | -------- |
| oh1 (5' boundary) | GTCA     | 0.5915   |
| oh2 (3' boundary) | TCCT     | 0.7573   |

**Variants:** 10290 mutations, 10290 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name              | Length  | 5' OH | 3' OH |
| --- | --------------- | ---------------------- | ------- | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile11_sub1   | 1613 nt | ATGG  | AATC  |
| 2   | 5'WT gene block | bsai_5wt_tile13_sub2   | 574 nt  | AATC  | GTCA  |
| 3   | Oligo pool      | Tile 13 (10290 oligos) | 215 nt  | GTCA  | AGAA  |
| 4   | Helper plasmid  | helper_plasmid_insert  | --      | --    | --    |
| 5   | Enzyme + buffer | BsaI-HFv2 + CutSmart   | --      | --    | --    |

```
  [ATGG]----5'WT sub1----[AATC]----5'WT sub2----[GTCA]----oligo+BC----[AGAA]
   ATGG                   AATC                   GTCA                  AGAA 
```

**Set fidelity:** 1.0000 (4 overhangs)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------ | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)      | --      | --    | --    |
| 2   | 3'WT block        | bsmbi_3wt_tile1_sub3     | 1683 nt | TCCT  | TTAC  |
| 3   | 3'WT+PolIII block | bsmbi_3wt_tile1_sub4     | 1532 nt | TTAC  | CACC  |
| 4   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1 | --      | --    | --    |

```
  [TCCT]----3'WT sub1----[TTAC]----3'WT+PolIII sub2----[CACC]
   TCCT                   TTAC                          CACC 
```

**Set fidelity:** 1.0000 (3 overhangs)

---

### Tile 14 of 25 -- Codons 767-811 (135 nt)

**Boundary overhangs:**

| Position          | Sequence | Fidelity |
| ----------------- | -------- | -------- |
| oh1 (5' boundary) | AAAG     | 0.7511   |
| oh2 (3' boundary) | CCAG     | 0.6122   |

**Variants:** 8610 mutations, 8610 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name             | Length  | 5' OH | 3' OH |
| --- | --------------- | --------------------- | ------- | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile11_sub1  | 1613 nt | ATGG  | AATC  |
| 2   | 5'WT gene block | bsai_5wt_tile14_sub2  | 721 nt  | AATC  | AAAG  |
| 3   | Oligo pool      | Tile 14 (8610 oligos) | 191 nt  | AAAG  | AGAA  |
| 4   | Helper plasmid  | helper_plasmid_insert | --      | --    | --    |
| 5   | Enzyme + buffer | BsaI-HFv2 + CutSmart  | --      | --    | --    |

```
  [ATGG]----5'WT sub1----[AATC]----5'WT sub2----[AAAG]----oligo+BC----[AGAA]
   ATGG                   AATC                   AAAG                  AGAA 
```

**Set fidelity:** 1.0000 (4 overhangs)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------ | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)      | --      | --    | --    |
| 2   | 3'WT block        | bsmbi_3wt_tile14_sub1    | 1560 nt | CCAG  | TTAC  |
| 3   | 3'WT+PolIII block | bsmbi_3wt_tile1_sub4     | 1532 nt | TTAC  | CACC  |
| 4   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1 | --      | --    | --    |

```
  [CCAG]----3'WT sub1----[TTAC]----3'WT+PolIII sub2----[CACC]
   CCAG                   TTAC                          CACC 
```

**Set fidelity:** 1.0000 (3 overhangs)

---

### Tile 15 of 25 -- Codons 808-883 (228 nt)

**Boundary overhangs:**

| Position          | Sequence | Fidelity |
| ----------------- | -------- | -------- |
| oh1 (5' boundary) | ATGA     | 0.7549   |
| oh2 (3' boundary) | TCCA     | 0.8519   |

**Variants:** 15120 mutations, 15120 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name              | Length  | 5' OH | 3' OH |
| --- | --------------- | ---------------------- | ------- | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile11_sub1   | 1613 nt | ATGG  | AATC  |
| 2   | 5'WT gene block | bsai_5wt_tile15_sub2   | 844 nt  | AATC  | ATGA  |
| 3   | Oligo pool      | Tile 15 (15120 oligos) | 284 nt  | ATGA  | AGAA  |
| 4   | Helper plasmid  | helper_plasmid_insert  | --      | --    | --    |
| 5   | Enzyme + buffer | BsaI-HFv2 + CutSmart   | --      | --    | --    |

```
  [ATGG]----5'WT sub1----[AATC]----5'WT sub2----[ATGA]----oligo+BC----[AGAA]
   ATGG                   AATC                   ATGA                  AGAA 
```

**Set fidelity:** 0.8940 (4 overhangs)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------ | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)      | --      | --    | --    |
| 2   | 3'WT block        | bsmbi_3wt_tile15_sub1    | 1344 nt | TCCA  | TTAC  |
| 3   | 3'WT+PolIII block | bsmbi_3wt_tile1_sub4     | 1532 nt | TTAC  | CACC  |
| 4   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1 | --      | --    | --    |

```
  [TCCA]----3'WT sub1----[TTAC]----3'WT+PolIII sub2----[CACC]
   TCCA                   TTAC                          CACC 
```

**Set fidelity:** 1.0000 (3 overhangs)

---

### Tile 16 of 25 -- Codons 880-952 (219 nt)

**Boundary overhangs:**

| Position          | Sequence | Fidelity |
| ----------------- | -------- | -------- |
| oh1 (5' boundary) | AAGA     | 0.9209   |
| oh2 (3' boundary) | GAAA     | 0.8745   |

**Variants:** 14490 mutations, 14490 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name              | Length  | 5' OH | 3' OH |
| --- | --------------- | ---------------------- | ------- | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile11_sub1   | 1613 nt | ATGG  | AATC  |
| 2   | 5'WT gene block | bsai_5wt_tile16_sub2   | 729 nt  | AATC  | TCCT  |
| 3   | 5'WT gene block | bsai_5wt_tile16_sub3   | 349 nt  | TCCT  | AAGA  |
| 4   | Oligo pool      | Tile 16 (14490 oligos) | 275 nt  | AAGA  | AGAA  |
| 5   | Helper plasmid  | helper_plasmid_insert  | --      | --    | --    |
| 6   | Enzyme + buffer | BsaI-HFv2 + CutSmart   | --      | --    | --    |

```
  [ATGG]----5'WT sub1----[AATC]----5'WT sub2----[TCCT]----5'WT sub3----[AAGA]----oligo+BC----[AGAA]
   ATGG                   AATC                   TCCT                   AAGA                  AGAA 
```

**Set fidelity:** 1.0000 (5 overhangs)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------ | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)      | --      | --    | --    |
| 2   | 3'WT block        | bsmbi_3wt_tile16_sub1    | 1137 nt | GAAA  | TTAC  |
| 3   | 3'WT+PolIII block | bsmbi_3wt_tile1_sub4     | 1532 nt | TTAC  | CACC  |
| 4   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1 | --      | --    | --    |

```
  [GAAA]----3'WT sub1----[TTAC]----3'WT+PolIII sub2----[CACC]
   GAAA                   TTAC                          CACC 
```

**Set fidelity:** 1.0000 (3 overhangs)

---

### Tile 17 of 25 -- Codons 949-1020 (216 nt)

**Boundary overhangs:**

| Position          | Sequence | Fidelity |
| ----------------- | -------- | -------- |
| oh1 (5' boundary) | TTTC     | 0.8348   |
| oh2 (3' boundary) | TTCC     | 0.7958   |

**Variants:** 14280 mutations, 14280 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name              | Length  | 5' OH | 3' OH |
| --- | --------------- | ---------------------- | ------- | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile11_sub1   | 1613 nt | ATGG  | AATC  |
| 2   | 5'WT gene block | bsai_5wt_tile16_sub2   | 729 nt  | AATC  | TCCT  |
| 3   | 5'WT gene block | bsai_5wt_tile17_sub3   | 556 nt  | TCCT  | TTTC  |
| 4   | Oligo pool      | Tile 17 (14280 oligos) | 272 nt  | TTTC  | AGAA  |
| 5   | Helper plasmid  | helper_plasmid_insert  | --      | --    | --    |
| 6   | Enzyme + buffer | BsaI-HFv2 + CutSmart   | --      | --    | --    |

```
  [ATGG]----5'WT sub1----[AATC]----5'WT sub2----[TCCT]----5'WT sub3----[TTTC]----oligo+BC----[AGAA]
   ATGG                   AATC                   TCCT                   TTTC                  AGAA 
```

**Set fidelity:** 0.9986 (5 overhangs)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------ | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)      | --      | --    | --    |
| 2   | 3'WT block        | bsmbi_3wt_tile17_sub1    | 933 nt  | TTCC  | TTAC  |
| 3   | 3'WT+PolIII block | bsmbi_3wt_tile1_sub4     | 1532 nt | TTAC  | CACC  |
| 4   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1 | --      | --    | --    |

```
  [TTCC]----3'WT sub1----[TTAC]----3'WT+PolIII sub2----[CACC]
   TTCC                   TTAC                          CACC 
```

**Set fidelity:** 0.9658 (3 overhangs)

---

### Tile 18 of 25 -- Codons 1017-1081 (195 nt)

**Boundary overhangs:**

| Position          | Sequence | Fidelity |
| ----------------- | -------- | -------- |
| oh1 (5' boundary) | TCCG     | 0.7234   |
| oh2 (3' boundary) | CAAA     | 0.8948   |

**Variants:** 12810 mutations, 12810 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name              | Length  | 5' OH | 3' OH |
| --- | --------------- | ---------------------- | ------- | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile11_sub1   | 1613 nt | ATGG  | AATC  |
| 2   | 5'WT gene block | bsai_5wt_tile16_sub2   | 729 nt  | AATC  | TCCT  |
| 3   | 5'WT gene block | bsai_5wt_tile18_sub3   | 760 nt  | TCCT  | TCCG  |
| 4   | Oligo pool      | Tile 18 (12810 oligos) | 251 nt  | TCCG  | AGAA  |
| 5   | Helper plasmid  | helper_plasmid_insert  | --      | --    | --    |
| 6   | Enzyme + buffer | BsaI-HFv2 + CutSmart   | --      | --    | --    |

```
  [ATGG]----5'WT sub1----[AATC]----5'WT sub2----[TCCT]----5'WT sub3----[TCCG]----oligo+BC----[AGAA]
   ATGG                   AATC                   TCCT                   TCCG                  AGAA 
```

**Set fidelity:** 0.9755 (5 overhangs)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------ | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)      | --      | --    | --    |
| 2   | 3'WT block        | bsmbi_3wt_tile18_sub1    | 750 nt  | CAAA  | TTAC  |
| 3   | 3'WT+PolIII block | bsmbi_3wt_tile1_sub4     | 1532 nt | TTAC  | CACC  |
| 4   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1 | --      | --    | --    |

```
  [CAAA]----3'WT sub1----[TTAC]----3'WT+PolIII sub2----[CACC]
   CAAA                   TTAC                          CACC 
```

**Set fidelity:** 1.0000 (3 overhangs)

---

### Tile 19 of 25 -- Codons 1078-1131 (162 nt)

**Boundary overhangs:**

| Position          | Sequence | Fidelity |
| ----------------- | -------- | -------- |
| oh1 (5' boundary) | AAGA     | 0.9209   |
| oh2 (3' boundary) | AGAT     | 0.6825   |

**Variants:** 10500 mutations, 10500 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name              | Length  | 5' OH | 3' OH |
| --- | --------------- | ---------------------- | ------- | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile11_sub1   | 1613 nt | ATGG  | AATC  |
| 2   | 5'WT gene block | bsai_5wt_tile16_sub2   | 729 nt  | AATC  | TCCT  |
| 3   | 5'WT gene block | bsai_5wt_tile19_sub3   | 943 nt  | TCCT  | AAGA  |
| 4   | Oligo pool      | Tile 19 (10500 oligos) | 218 nt  | AAGA  | AGAA  |
| 5   | Helper plasmid  | helper_plasmid_insert  | --      | --    | --    |
| 6   | Enzyme + buffer | BsaI-HFv2 + CutSmart   | --      | --    | --    |

```
  [ATGG]----5'WT sub1----[AATC]----5'WT sub2----[TCCT]----5'WT sub3----[AAGA]----oligo+BC----[AGAA]
   ATGG                   AATC                   TCCT                   AAGA                  AGAA 
```

**Set fidelity:** 1.0000 (5 overhangs)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------ | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)      | --      | --    | --    |
| 2   | 3'WT block        | bsmbi_3wt_tile19_sub1    | 600 nt  | AGAT  | TTAC  |
| 3   | 3'WT+PolIII block | bsmbi_3wt_tile1_sub4     | 1532 nt | TTAC  | CACC  |
| 4   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1 | --      | --    | --    |

```
  [AGAT]----3'WT sub1----[TTAC]----3'WT+PolIII sub2----[CACC]
   AGAT                   TTAC                          CACC 
```

**Set fidelity:** 1.0000 (3 overhangs)

---

### Tile 20 of 25 -- Codons 1128-1194 (201 nt)

**Boundary overhangs:**

| Position          | Sequence | Fidelity |
| ----------------- | -------- | -------- |
| oh1 (5' boundary) | TTCC     | 0.7958   |
| oh2 (3' boundary) | GAAA     | 0.8745   |

**Variants:** 13230 mutations, 13230 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name              | Length  | 5' OH | 3' OH |
| --- | --------------- | ---------------------- | ------- | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile11_sub1   | 1613 nt | ATGG  | AATC  |
| 2   | 5'WT gene block | bsai_5wt_tile16_sub2   | 729 nt  | AATC  | TCCT  |
| 3   | 5'WT gene block | bsai_5wt_tile20_sub3   | 1093 nt | TCCT  | TTCC  |
| 4   | Oligo pool      | Tile 20 (13230 oligos) | 257 nt  | TTCC  | AGAA  |
| 5   | Helper plasmid  | helper_plasmid_insert  | --      | --    | --    |
| 6   | Enzyme + buffer | BsaI-HFv2 + CutSmart   | --      | --    | --    |

```
  [ATGG]----5'WT sub1----[AATC]----5'WT sub2----[TCCT]----5'WT sub3----[TTCC]----oligo+BC----[AGAA]
   ATGG                   AATC                   TCCT                   TTCC                  AGAA 
```

**Set fidelity:** 1.0000 (5 overhangs)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------ | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)      | --      | --    | --    |
| 2   | 3'WT block        | bsmbi_3wt_tile20_sub1    | 411 nt  | GAAA  | TTAC  |
| 3   | 3'WT+PolIII block | bsmbi_3wt_tile1_sub4     | 1532 nt | TTAC  | CACC  |
| 4   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1 | --      | --    | --    |

```
  [GAAA]----3'WT sub1----[TTAC]----3'WT+PolIII sub2----[CACC]
   GAAA                   TTAC                          CACC 
```

**Set fidelity:** 1.0000 (3 overhangs)

---

### Tile 21 of 25 -- Codons 1191-1259 (207 nt)

**Boundary overhangs:**

| Position          | Sequence | Fidelity |
| ----------------- | -------- | -------- |
| oh1 (5' boundary) | TTCA     | 0.8824   |
| oh2 (3' boundary) | TAAC     | 0.7715   |

**Variants:** 13650 mutations, 13650 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name              | Length  | 5' OH | 3' OH |
| --- | --------------- | ---------------------- | ------- | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile11_sub1   | 1613 nt | ATGG  | AATC  |
| 2   | 5'WT gene block | bsai_5wt_tile16_sub2   | 729 nt  | AATC  | TCCT  |
| 3   | 5'WT gene block | bsai_5wt_tile21_sub3   | 1282 nt | TCCT  | TTCA  |
| 4   | Oligo pool      | Tile 21 (13650 oligos) | 263 nt  | TTCA  | AGAA  |
| 5   | Helper plasmid  | helper_plasmid_insert  | --      | --    | --    |
| 6   | Enzyme + buffer | BsaI-HFv2 + CutSmart   | --      | --    | --    |

```
  [ATGG]----5'WT sub1----[AATC]----5'WT sub2----[TCCT]----5'WT sub3----[TTCA]----oligo+BC----[AGAA]
   ATGG                   AATC                   TCCT                   TTCA                  AGAA 
```

**Set fidelity:** 1.0000 (5 overhangs)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------ | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)      | --      | --    | --    |
| 2   | 3'WT+PolIII block | bsmbi_3wt_tile21_sub1    | 1730 nt | TAAC  | CACC  |
| 3   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1 | --      | --    | --    |

```
  [TAAC]----3'WT+PolIII----[CACC]
   TAAC                     CACC 
```

**Set fidelity:** 0.9983 (2 overhangs)

---

### Tile 22 of 25 -- Codons 1256-1325 (210 nt)

**Boundary overhangs:**

| Position          | Sequence | Fidelity |
| ----------------- | -------- | -------- |
| oh1 (5' boundary) | GAGA     | 0.7444   |
| oh2 (3' boundary) | TTAC     | 0.8333   |

**Variants:** 13860 mutations, 13860 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name              | Length  | 5' OH | 3' OH |
| --- | --------------- | ---------------------- | ------- | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile11_sub1   | 1613 nt | ATGG  | AATC  |
| 2   | 5'WT gene block | bsai_5wt_tile16_sub2   | 729 nt  | AATC  | TCCT  |
| 3   | 5'WT gene block | bsai_5wt_tile22_sub3   | 1477 nt | TCCT  | GAGA  |
| 4   | Oligo pool      | Tile 22 (13860 oligos) | 266 nt  | GAGA  | AGAA  |
| 5   | Helper plasmid  | helper_plasmid_insert  | --      | --    | --    |
| 6   | Enzyme + buffer | BsaI-HFv2 + CutSmart   | --      | --    | --    |

```
  [ATGG]----5'WT sub1----[AATC]----5'WT sub2----[TCCT]----5'WT sub3----[GAGA]----oligo+BC----[AGAA]
   ATGG                   AATC                   TCCT                   GAGA                  AGAA 
```

**Set fidelity:** 1.0000 (5 overhangs)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------ | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)      | --      | --    | --    |
| 2   | 3'WT+PolIII block | bsmbi_3wt_tile1_sub4     | 1532 nt | TTAC  | CACC  |
| 3   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1 | --      | --    | --    |

```
  [TTAC]----3'WT+PolIII----[CACC]
   TTAC                     CACC 
```

**Set fidelity:** 1.0000 (2 overhangs)

---

### Tile 23 of 25 -- Codons 1322-1367 (138 nt)

**Boundary overhangs:**

| Position          | Sequence | Fidelity |
| ----------------- | -------- | -------- |
| oh1 (5' boundary) | GGAA     | 0.7463   |
| oh2 (3' boundary) | TTTC     | 0.8348   |

**Variants:** 8820 mutations, 8820 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name             | Length  | 5' OH | 3' OH |
| --- | --------------- | --------------------- | ------- | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile11_sub1  | 1613 nt | ATGG  | AATC  |
| 2   | 5'WT gene block | bsai_5wt_tile16_sub2  | 729 nt  | AATC  | TCCT  |
| 3   | 5'WT gene block | bsai_5wt_tile23_sub3  | 1675 nt | TCCT  | GGAA  |
| 4   | Oligo pool      | Tile 23 (8820 oligos) | 194 nt  | GGAA  | AGAA  |
| 5   | Helper plasmid  | helper_plasmid_insert | --      | --    | --    |
| 6   | Enzyme + buffer | BsaI-HFv2 + CutSmart  | --      | --    | --    |

```
  [ATGG]----5'WT sub1----[AATC]----5'WT sub2----[TCCT]----5'WT sub3----[GGAA]----oligo+BC----[AGAA]
   ATGG                   AATC                   TCCT                   GGAA                  AGAA 
```

**Set fidelity:** 0.9472 (5 overhangs)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------ | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)      | --      | --    | --    |
| 2   | 3'WT+PolIII block | bsmbi_3wt_tile23         | 1406 nt | TTTC  | CACC  |
| 3   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1 | --      | --    | --    |

```
  [TTTC]----3'WT+PolIII----[CACC]
   TTTC                     CACC 
```

**Set fidelity:** 1.0000 (2 overhangs)

---

### Tile 24 of 25 -- Codons 1364-1437 (222 nt)

**Boundary overhangs:**

| Position          | Sequence | Fidelity |
| ----------------- | -------- | -------- |
| oh1 (5' boundary) | GATA     | 0.7029   |
| oh2 (3' boundary) | TAAT     | 0.8165   |

**Variants:** 14700 mutations, 14700 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name              | Length  | 5' OH | 3' OH |
| --- | --------------- | ---------------------- | ------- | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile11_sub1   | 1613 nt | ATGG  | AATC  |
| 2   | 5'WT gene block | bsai_5wt_tile16_sub2   | 729 nt  | AATC  | TCCT  |
| 3   | 5'WT gene block | bsai_5wt_tile24_sub3   | 1683 nt | TCCT  | TTAC  |
| 4   | 5'WT gene block | bsai_5wt_tile24_sub4   | 136 nt  | TTAC  | GATA  |
| 5   | Oligo pool      | Tile 24 (14700 oligos) | 278 nt  | GATA  | AGAA  |
| 6   | Helper plasmid  | helper_plasmid_insert  | --      | --    | --    |
| 7   | Enzyme + buffer | BsaI-HFv2 + CutSmart   | --      | --    | --    |

```
  [ATGG]----5'WT sub1----[AATC]----5'WT sub2----[TCCT]----5'WT sub3----[TTAC]----5'WT sub4----[GATA]----oligo+BC----[AGAA]
   ATGG                   AATC                   TCCT                   TTAC                   GATA                  AGAA 
```

**Set fidelity:** 1.0000 (6 overhangs)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------ | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)      | --      | --    | --    |
| 2   | 3'WT+PolIII block | bsmbi_3wt_tile24         | 1196 nt | TAAT  | CACC  |
| 3   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1 | --      | --    | --    |

```
  [TAAT]----3'WT+PolIII----[CACC]
   TAAT                     CACC 
```

**Set fidelity:** 1.0000 (2 overhangs)

---

### Tile 25 of 25 -- Codons 1434-1465 (96 nt)

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
| 1   | 5'WT gene block | bsai_5wt_tile11_sub1  | 1613 nt | ATGG  | AATC  |
| 2   | 5'WT gene block | bsai_5wt_tile16_sub2  | 729 nt  | AATC  | TCCT  |
| 3   | 5'WT gene block | bsai_5wt_tile24_sub3  | 1683 nt | TCCT  | TTAC  |
| 4   | 5'WT gene block | bsai_5wt_tile25_sub4  | 346 nt  | TTAC  | AATA  |
| 5   | Oligo pool      | Tile 25 (5880 oligos) | 152 nt  | AATA  | AGAA  |
| 6   | Helper plasmid  | helper_plasmid_insert | --      | --    | --    |
| 7   | Enzyme + buffer | BsaI-HFv2 + CutSmart  | --      | --    | --    |

```
  [ATGG]----5'WT sub1----[AATC]----5'WT sub2----[TCCT]----5'WT sub3----[TTAC]----5'WT sub4----[AATA]----oligo+BC----[AGAA]
   ATGG                   AATC                   TCCT                   TTAC                   AATA                  AGAA 
```

**Set fidelity:** 0.9510 (6 overhangs)

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

**Total blocks:** 52

| Block name            | Length (nt) | Enzyme type | Gene region                                                                                                                                                                                                                                                                                                                                                                                                                                                                          |
| --------------------- | ----------- | ----------- | ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------ |
| bsai_5wt_tile10       | 1605        | BsaI        | 5wt_tile10                                                                                                                                                                                                                                                                                                                                                                                                                                                                           |
| bsai_5wt_tile11_sub1  | 1613        | BsaI        | 5wt_tile11_sub1;5wt_tile12_sub1;5wt_tile13_sub1;5wt_tile14_sub1;5wt_tile15_sub1;5wt_tile16_sub1;5wt_tile17_sub1;5wt_tile18_sub1;5wt_tile19_sub1;5wt_tile20_sub1;5wt_tile21_sub1;5wt_tile22_sub1;5wt_tile23_sub1;5wt_tile24_sub1;5wt_tile25_sub1                                                                                                                                                                                                                                      |
| bsai_5wt_tile11_sub2  | 211         | BsaI        | 5wt_tile11_sub2                                                                                                                                                                                                                                                                                                                                                                                                                                                                      |
| bsai_5wt_tile12_sub2  | 427         | BsaI        | 5wt_tile12_sub2                                                                                                                                                                                                                                                                                                                                                                                                                                                                      |
| bsai_5wt_tile13_sub2  | 574         | BsaI        | 5wt_tile13_sub2                                                                                                                                                                                                                                                                                                                                                                                                                                                                      |
| bsai_5wt_tile14_sub2  | 721         | BsaI        | 5wt_tile14_sub2                                                                                                                                                                                                                                                                                                                                                                                                                                                                      |
| bsai_5wt_tile15_sub2  | 844         | BsaI        | 5wt_tile15_sub2                                                                                                                                                                                                                                                                                                                                                                                                                                                                      |
| bsai_5wt_tile16_sub2  | 729         | BsaI        | 5wt_tile16_sub2;5wt_tile17_sub2;5wt_tile18_sub2;5wt_tile19_sub2;5wt_tile20_sub2;5wt_tile21_sub2;5wt_tile22_sub2;5wt_tile23_sub2;5wt_tile24_sub2;5wt_tile25_sub2                                                                                                                                                                                                                                                                                                                      |
| bsai_5wt_tile16_sub3  | 349         | BsaI        | 5wt_tile16_sub3                                                                                                                                                                                                                                                                                                                                                                                                                                                                      |
| bsai_5wt_tile17_sub3  | 556         | BsaI        | 5wt_tile17_sub3                                                                                                                                                                                                                                                                                                                                                                                                                                                                      |
| bsai_5wt_tile18_sub3  | 760         | BsaI        | 5wt_tile18_sub3                                                                                                                                                                                                                                                                                                                                                                                                                                                                      |
| bsai_5wt_tile19_sub3  | 943         | BsaI        | 5wt_tile19_sub3                                                                                                                                                                                                                                                                                                                                                                                                                                                                      |
| bsai_5wt_tile2        | 99          | BsaI        | 5wt_tile2                                                                                                                                                                                                                                                                                                                                                                                                                                                                            |
| bsai_5wt_tile20_sub3  | 1093        | BsaI        | 5wt_tile20_sub3                                                                                                                                                                                                                                                                                                                                                                                                                                                                      |
| bsai_5wt_tile21_sub3  | 1282        | BsaI        | 5wt_tile21_sub3                                                                                                                                                                                                                                                                                                                                                                                                                                                                      |
| bsai_5wt_tile22_sub3  | 1477        | BsaI        | 5wt_tile22_sub3                                                                                                                                                                                                                                                                                                                                                                                                                                                                      |
| bsai_5wt_tile23_sub3  | 1675        | BsaI        | 5wt_tile23_sub3                                                                                                                                                                                                                                                                                                                                                                                                                                                                      |
| bsai_5wt_tile24_sub3  | 1683        | BsaI        | 5wt_tile24_sub3;5wt_tile25_sub3                                                                                                                                                                                                                                                                                                                                                                                                                                                      |
| bsai_5wt_tile24_sub4  | 136         | BsaI        | 5wt_tile24_sub4                                                                                                                                                                                                                                                                                                                                                                                                                                                                      |
| bsai_5wt_tile25_sub4  | 346         | BsaI        | 5wt_tile25_sub4                                                                                                                                                                                                                                                                                                                                                                                                                                                                      |
| bsai_5wt_tile3        | 255         | BsaI        | 5wt_tile3                                                                                                                                                                                                                                                                                                                                                                                                                                                                            |
| bsai_5wt_tile4        | 450         | BsaI        | 5wt_tile4                                                                                                                                                                                                                                                                                                                                                                                                                                                                            |
| bsai_5wt_tile5        | 657         | BsaI        | 5wt_tile5                                                                                                                                                                                                                                                                                                                                                                                                                                                                            |
| bsai_5wt_tile6        | 855         | BsaI        | 5wt_tile6                                                                                                                                                                                                                                                                                                                                                                                                                                                                            |
| bsai_5wt_tile7        | 1065        | BsaI        | 5wt_tile7                                                                                                                                                                                                                                                                                                                                                                                                                                                                            |
| bsai_5wt_tile8        | 1266        | BsaI        | 5wt_tile8                                                                                                                                                                                                                                                                                                                                                                                                                                                                            |
| bsai_5wt_tile9        | 1410        | BsaI        | 5wt_tile9                                                                                                                                                                                                                                                                                                                                                                                                                                                                            |
| bsmbi_3wt_tile1_sub1  | 1524        | BsmBI       | 3wt_tile1_sub1                                                                                                                                                                                                                                                                                                                                                                                                                                                                       |
| bsmbi_3wt_tile1_sub2  | 729         | BsmBI       | 3wt_tile1_sub2;3wt_tile2_sub2;3wt_tile3_sub2;3wt_tile4_sub2;3wt_tile5_sub2;3wt_tile6_sub2;3wt_tile7_sub2;3wt_tile9_sub1                                                                                                                                                                                                                                                                                                                                                              |
| bsmbi_3wt_tile1_sub3  | 1683        | BsmBI       | 3wt_tile1_sub3;3wt_tile2_sub3;3wt_tile3_sub3;3wt_tile4_sub3;3wt_tile5_sub3;3wt_tile6_sub3;3wt_tile7_sub3;3wt_tile8_sub2;3wt_tile9_sub2;3wt_tile10_sub2;3wt_tile11_sub2;3wt_tile12_sub2;3wt_tile13_sub1                                                                                                                                                                                                                                                                               |
| bsmbi_3wt_tile1_sub4  | 1532        | BsmBI       | 3wt_polIII_tile1_sub4;3wt_polIII_tile2_sub4;3wt_polIII_tile3_sub4;3wt_polIII_tile4_sub4;3wt_polIII_tile5_sub4;3wt_polIII_tile6_sub4;3wt_polIII_tile7_sub4;3wt_polIII_tile8_sub3;3wt_polIII_tile9_sub3;3wt_polIII_tile10_sub3;3wt_polIII_tile11_sub3;3wt_polIII_tile12_sub3;3wt_polIII_tile13_sub2;3wt_polIII_tile14_sub2;3wt_polIII_tile15_sub2;3wt_polIII_tile16_sub2;3wt_polIII_tile17_sub2;3wt_polIII_tile18_sub2;3wt_polIII_tile19_sub2;3wt_polIII_tile20_sub2;3wt_polIII_tile22 |
| bsmbi_3wt_tile10_sub1 | 528         | BsmBI       | 3wt_tile10_sub1                                                                                                                                                                                                                                                                                                                                                                                                                                                                      |
| bsmbi_3wt_tile11_sub1 | 312         | BsmBI       | 3wt_tile11_sub1                                                                                                                                                                                                                                                                                                                                                                                                                                                                      |
| bsmbi_3wt_tile12_sub1 | 165         | BsmBI       | 3wt_tile12_sub1                                                                                                                                                                                                                                                                                                                                                                                                                                                                      |
| bsmbi_3wt_tile14_sub1 | 1560        | BsmBI       | 3wt_tile14_sub1                                                                                                                                                                                                                                                                                                                                                                                                                                                                      |
| bsmbi_3wt_tile15_sub1 | 1344        | BsmBI       | 3wt_tile15_sub1                                                                                                                                                                                                                                                                                                                                                                                                                                                                      |
| bsmbi_3wt_tile16_sub1 | 1137        | BsmBI       | 3wt_tile16_sub1                                                                                                                                                                                                                                                                                                                                                                                                                                                                      |
| bsmbi_3wt_tile17_sub1 | 933         | BsmBI       | 3wt_tile17_sub1                                                                                                                                                                                                                                                                                                                                                                                                                                                                      |
| bsmbi_3wt_tile18_sub1 | 750         | BsmBI       | 3wt_tile18_sub1                                                                                                                                                                                                                                                                                                                                                                                                                                                                      |
| bsmbi_3wt_tile19_sub1 | 600         | BsmBI       | 3wt_tile19_sub1                                                                                                                                                                                                                                                                                                                                                                                                                                                                      |
| bsmbi_3wt_tile2_sub1  | 1368        | BsmBI       | 3wt_tile2_sub1                                                                                                                                                                                                                                                                                                                                                                                                                                                                       |
| bsmbi_3wt_tile20_sub1 | 411         | BsmBI       | 3wt_tile20_sub1                                                                                                                                                                                                                                                                                                                                                                                                                                                                      |
| bsmbi_3wt_tile21_sub1 | 1730        | BsmBI       | 3wt_polIII_tile21_sub1                                                                                                                                                                                                                                                                                                                                                                                                                                                               |
| bsmbi_3wt_tile23      | 1406        | BsmBI       | 3wt_polIII_tile23                                                                                                                                                                                                                                                                                                                                                                                                                                                                    |
| bsmbi_3wt_tile24      | 1196        | BsmBI       | 3wt_polIII_tile24                                                                                                                                                                                                                                                                                                                                                                                                                                                                    |
| bsmbi_3wt_tile3_sub1  | 1173        | BsmBI       | 3wt_tile3_sub1                                                                                                                                                                                                                                                                                                                                                                                                                                                                       |
| bsmbi_3wt_tile4_sub1  | 966         | BsmBI       | 3wt_tile4_sub1                                                                                                                                                                                                                                                                                                                                                                                                                                                                       |
| bsmbi_3wt_tile5_sub1  | 768         | BsmBI       | 3wt_tile5_sub1                                                                                                                                                                                                                                                                                                                                                                                                                                                                       |
| bsmbi_3wt_tile6_sub1  | 558         | BsmBI       | 3wt_tile6_sub1                                                                                                                                                                                                                                                                                                                                                                                                                                                                       |
| bsmbi_3wt_tile7_sub1  | 357         | BsmBI       | 3wt_tile7_sub1                                                                                                                                                                                                                                                                                                                                                                                                                                                                       |
| bsmbi_3wt_tile8_sub1  | 924         | BsmBI       | 3wt_tile8_sub1                                                                                                                                                                                                                                                                                                                                                                                                                                                                       |
| bsmbi_polIII_tile25   | 1112        | BsmBI       | polIII_tile25                                                                                                                                                                                                                                                                                                                                                                                                                                                                        |

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

| Parameter             | Value |
| --------------------- | ----- |
| max_oligo_length      | 300   |
| max_geneblock_length  | 1800  |
| barcode_length        | 20    |
| min_hamming_distance  | 3     |
| barcode_prefix_length | 12    |
| barcodes_per_variant  | 10    |
| boundary_method       | dp    |
| multi_k_search        | TRUE  |
| auto_domesticate      | TRUE  |

