# DMS-GG Assembly Report: GRIN2A

Generated: 2026-03-08 14:19:41
Pipeline: dms-gg-oligo-pipeline (3-Enzyme Architecture: BsaI + BsmBI + PaqCI)

---

## 1. Gene Summary

| Property             | Value                                                                          |
| -------------------- | ------------------------------------------------------------------------------ |
| Gene name            | GRIN2A_NM_000833.5 Human GRIN2A native CDS (NM_000833.5, NP_000824.1, 1464 aa) |
| CDS length           | 4395 nt (1465 codons)                                                          |
| Protein length       | 1464 aa                                                                        |
| Number of tiles      | 23                                                                             |
| Total variants       | 30681                                                                          |
| Total oligos         | 306810                                                                         |
| Oligo length range   | 149-290 nt                                                                     |
| Gene blocks to order | 47                                                                             |
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

**Total oligos:** 306810 | **Length range:** 149-290 nt

| Tile | Codons    | Oligos | Length |
| ---- | --------- | ------ | ------ |
| 1    | 1-31      | 5670   | 149 nt |
| 2    | 28-85     | 11340  | 230 nt |
| 3    | 82-157    | 15120  | 284 nt |
| 4    | 154-230   | 15330  | 287 nt |
| 5    | 227-304   | 15540  | 290 nt |
| 6    | 301-376   | 15120  | 284 nt |
| 7    | 373-450   | 15540  | 290 nt |
| 8    | 447-520   | 14700  | 278 nt |
| 9    | 517-594   | 15540  | 290 nt |
| 10   | 591-624   | 6300   | 158 nt |
| 11   | 621-698   | 15540  | 290 nt |
| 12   | 695-771   | 15330  | 287 nt |
| 13   | 768-845   | 15540  | 290 nt |
| 14   | 842-918   | 15330  | 287 nt |
| 15   | 915-948   | 6300   | 158 nt |
| 16   | 945-1022  | 15540  | 290 nt |
| 17   | 1019-1094 | 15120  | 284 nt |
| 18   | 1091-1167 | 15330  | 287 nt |
| 19   | 1164-1241 | 15540  | 290 nt |
| 20   | 1238-1315 | 15540  | 290 nt |
| 21   | 1312-1388 | 15330  | 287 nt |
| 22   | 1385-1415 | 5670   | 149 nt |
| 23   | 1412-1465 | 10500  | 218 nt |

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
| GC content mean   | 48%                                |
| Hamming guarantee | 100% cross-variant (prefix d >= 3) |

## 5. QC Summary

**Overall:** ISSUES FOUND

| Check                  | Description                                                   | Result | Detail                                                                                                                                              |
| ---------------------- | ------------------------------------------------------------- | ------ | --------------------------------------------------------------------------------------------------------------------------------------------------- |
| oligo_lengths          | All oligos within synthesis length limit                      | PASS   | Range: 149-290 nt (limit: 300)                                                                                                                      |
| block_lengths          | All gene blocks within synthesis length limit                 | PASS   | Range: 99-1796 nt (limit: 1800)                                                                                                                     |
| barcode_junction_sites | No enzyme sites at barcode-context junctions                  | PASS   | 0 barcode(s) with junction enzyme sites (left='CACACC', right='AGAATG')                                                                             |
| barcode_uniqueness     | All barcodes are unique                                       | PASS   | 306810 unique / 306810 total                                                                                                                        |
| tile_coverage          | Tiles cover entire gene without gaps                          | PASS   | 4395 / 4395 nt covered                                                                                                                              |
| variant_count          | Expected number of variants generated                         | PASS   | 30681 unique variants (expected: 30681 across 1461/1463 mutable positions; 27759 missense + 1461 nonsense + 1461 wt_control; 2 position(s) skipped) |
| single_codon_change    | Each non-control variant differs by exactly one codon from WT | PASS   | 292200 / 292200 variants confirmed (WT controls excluded)                                                                                           |
| oligo_gc_content       | Oligo GC content within reasonable range (25-75%)             | PASS   | GC range: 41.3-69.1% | 0 oligo(s) with extreme GC                                                                                                   |
| domestication_complete | Gene domesticated for all 3 enzymes (BsaI, BsmBI, PaqCI)      | PASS   | No enzyme sites in gene                                                                                                                             |
| overhang_fidelity      | Tile boundary overhangs have adequate fidelity                | FAIL   | 23 tile(s) with low-fidelity boundary overhangs (<0.80)                                                                                             |
| tile_manifests         | Per-tile assembly manifests complete                          | PASS   | 23 tile manifest(s) generated                                                                                                                       |
| helper_plasmid         | Helper plasmid free of unintended BsmBI sites                 | PASS   | OK                                                                                                                                                  |
| reaction_fidelity      | Per-reaction set-level overhang fidelity                      | PASS   | Min set fidelity: 0.8039 across 46 reactions | 1 reaction(s) below 0.90                                                                             |
| barcode_poliii_term    | No barcodes contain PolIII terminator signal (TTTT)           | PASS   | 0 / 306810 barcode(s) contain TTTT                                                                                                                  |
| block_min_length       | All gene blocks above synthesis minimum length                | FAIL   | 3 block(s) below 300 nt minimum. Range: 99-1796 nt                                                                                                  |
| sb_overhang_collisions | Superblock boundary overhangs are unique (no collisions)      | PASS   | 3 SB boundary OH(s), all unique                                                                                                                     |

## 5b. Reaction Fidelity Summary

Set fidelity for each tile's BsaI and BsmBI reactions,
computed from the actual block overhangs after construction:

| Tile | BsaI OHs | BsaI Set Fidelity | BsmBI OHs | BsmBI Set Fidelity |
| ---- | -------- | ----------------- | --------- | ------------------ |
| 1    | 2        | 1.0000            | 4         | 0.8039             |
| 2    | 3        | 1.0000            | 4         | 0.9975             |
| 3    | 3        | 1.0000            | 4         | 1.0000             |
| 4    | 3        | 1.0000            | 4         | 1.0000             |
| 5    | 3        | 1.0000            | 4         | 1.0000             |
| 6    | 3        | 1.0000            | 4         | 1.0000             |
| 7    | 3        | 1.0000            | 4         | 1.0000             |
| 8    | 3        | 1.0000            | 4         | 1.0000             |
| 9    | 3        | 1.0000            | 3         | 1.0000             |
| 10   | 3        | 1.0000            | 4         | 1.0000             |
| 11   | 4        | 1.0000            | 4         | 1.0000             |
| 12   | 4        | 1.0000            | 4         | 1.0000             |
| 13   | 4        | 1.0000            | 3         | 1.0000             |
| 14   | 4        | 1.0000            | 3         | 1.0000             |
| 15   | 3        | 1.0000            | 3         | 1.0000             |
| 16   | 4        | 1.0000            | 3         | 1.0000             |
| 17   | 4        | 1.0000            | 3         | 1.0000             |
| 18   | 4        | 0.9951            | 3         | 1.0000             |
| 19   | 4        | 0.9496            | 3         | 1.0000             |
| 20   | 4        | 0.9951            | 2         | 1.0000             |
| 21   | 4        | 0.9192            | 2         | 1.0000             |
| 22   | 4        | 1.0000            | 2         | 1.0000             |
| 23   | 4        | 1.0000            | 2         | 1.0000             |

**Min:** 0.8039 | **Max:** 1.0000 | **Mean:** 0.9926

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

### Tile 1 of 23 -- Codons 1-31 (93 nt)

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
| 2   | 3'WT block        | bsmbi_3wt_tile1_sub1     | 1707 nt | TCCC  | ACCC  |
| 3   | 3'WT block        | bsmbi_3wt_tile1_sub2     | 990 nt  | ACCC  | ACCC  |
| 4   | 3'WT block        | bsmbi_3wt_tile1_sub3     | 1428 nt | ACCC  | CAAA  |
| 5   | 3'WT+PolIII block | bsmbi_3wt_tile1_sub4     | 1343 nt | CAAA  | CACC  |
| 6   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1 | --      | --    | --    |

```
  [TCCC]----3'WT sub1----[ACCC]----3'WT sub2----[ACCC]----3'WT sub3----[CAAA]----3'WT+PolIII sub4----[CACC]
   TCCC                   ACCC                   ACCC                   CAAA                          CACC 
```

**Set fidelity:** 0.8039 (4 overhangs)

---

### Tile 2 of 23 -- Codons 28-85 (174 nt)

**Boundary overhangs:**

| Position          | Sequence | Fidelity |
| ----------------- | -------- | -------- |
| oh1 (5' boundary) | GAGA     | 0.7444   |
| oh2 (3' boundary) | GCAC     | 0.5057   |

**Variants:** 11340 mutations, 11340 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name             | Length | 5' OH | 3' OH |
| --- | --------------- | --------------------- | ------ | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile2        | 99 nt  | ATGG  | GAGA  |
| 2   | Oligo pool      | Tile 2 (11340 oligos) | 230 nt | GAGA  | AGAA  |
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
| 2   | 3'WT block        | bsmbi_3wt_tile2_sub1     | 1545 nt | GCAC  | ACCC  |
| 3   | 3'WT block        | bsmbi_3wt_tile1_sub2     | 990 nt  | ACCC  | ACCC  |
| 4   | 3'WT block        | bsmbi_3wt_tile1_sub3     | 1428 nt | ACCC  | CAAA  |
| 5   | 3'WT+PolIII block | bsmbi_3wt_tile1_sub4     | 1343 nt | CAAA  | CACC  |
| 6   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1 | --      | --    | --    |

```
  [GCAC]----3'WT sub1----[ACCC]----3'WT sub2----[ACCC]----3'WT sub3----[CAAA]----3'WT+PolIII sub4----[CACC]
   GCAC                   ACCC                   ACCC                   CAAA                          CACC 
```

**Set fidelity:** 0.9975 (4 overhangs)

---

### Tile 3 of 23 -- Codons 82-157 (228 nt)

**Boundary overhangs:**

| Position          | Sequence | Fidelity |
| ----------------- | -------- | -------- |
| oh1 (5' boundary) | CTCA     | 0.6872   |
| oh2 (3' boundary) | GGTC     | 0.5144   |

**Variants:** 15120 mutations, 15120 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name             | Length | 5' OH | 3' OH |
| --- | --------------- | --------------------- | ------ | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile3        | 261 nt | ATGG  | CTCA  |
| 2   | Oligo pool      | Tile 3 (15120 oligos) | 284 nt | CTCA  | AGAA  |
| 3   | Helper plasmid  | helper_plasmid_insert | --     | --    | --    |
| 4   | Enzyme + buffer | BsaI-HFv2 + CutSmart  | --     | --    | --    |

```
  [ATGG]----5'WT block----[CTCA]----oligo+BC----[AGAA]
   ATGG                    CTCA                  AGAA 
```

**Set fidelity:** 1.0000 (3 overhangs)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------ | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)      | --      | --    | --    |
| 2   | 3'WT block        | bsmbi_3wt_tile3_sub1     | 1329 nt | GGTC  | ACCC  |
| 3   | 3'WT block        | bsmbi_3wt_tile1_sub2     | 990 nt  | ACCC  | ACCC  |
| 4   | 3'WT block        | bsmbi_3wt_tile1_sub3     | 1428 nt | ACCC  | CAAA  |
| 5   | 3'WT+PolIII block | bsmbi_3wt_tile1_sub4     | 1343 nt | CAAA  | CACC  |
| 6   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1 | --      | --    | --    |

```
  [GGTC]----3'WT sub1----[ACCC]----3'WT sub2----[ACCC]----3'WT sub3----[CAAA]----3'WT+PolIII sub4----[CACC]
   GGTC                   ACCC                   ACCC                   CAAA                          CACC 
```

**Set fidelity:** 1.0000 (4 overhangs)

---

### Tile 4 of 23 -- Codons 154-230 (231 nt)

**Boundary overhangs:**

| Position          | Sequence | Fidelity |
| ----------------- | -------- | -------- |
| oh1 (5' boundary) | CAAG     | 0.6640   |
| oh2 (3' boundary) | CTAC     | 0.6583   |

**Variants:** 15330 mutations, 15330 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name             | Length | 5' OH | 3' OH |
| --- | --------------- | --------------------- | ------ | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile4        | 477 nt | ATGG  | CAAG  |
| 2   | Oligo pool      | Tile 4 (15330 oligos) | 287 nt | CAAG  | AGAA  |
| 3   | Helper plasmid  | helper_plasmid_insert | --     | --    | --    |
| 4   | Enzyme + buffer | BsaI-HFv2 + CutSmart  | --     | --    | --    |

```
  [ATGG]----5'WT block----[CAAG]----oligo+BC----[AGAA]
   ATGG                    CAAG                  AGAA 
```

**Set fidelity:** 1.0000 (3 overhangs)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------ | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)      | --      | --    | --    |
| 2   | 3'WT block        | bsmbi_3wt_tile4_sub1     | 1110 nt | CTAC  | ACCC  |
| 3   | 3'WT block        | bsmbi_3wt_tile1_sub2     | 990 nt  | ACCC  | ACCC  |
| 4   | 3'WT block        | bsmbi_3wt_tile1_sub3     | 1428 nt | ACCC  | CAAA  |
| 5   | 3'WT+PolIII block | bsmbi_3wt_tile1_sub4     | 1343 nt | CAAA  | CACC  |
| 6   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1 | --      | --    | --    |

```
  [CTAC]----3'WT sub1----[ACCC]----3'WT sub2----[ACCC]----3'WT sub3----[CAAA]----3'WT+PolIII sub4----[CACC]
   CTAC                   ACCC                   ACCC                   CAAA                          CACC 
```

**Set fidelity:** 1.0000 (4 overhangs)

---

### Tile 5 of 23 -- Codons 227-304 (234 nt)

**Boundary overhangs:**

| Position          | Sequence | Fidelity |
| ----------------- | -------- | -------- |
| oh1 (5' boundary) | ATCT     | 0.7151   |
| oh2 (3' boundary) | ATCT     | 0.7151   |

**Variants:** 15540 mutations, 15540 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name             | Length | 5' OH | 3' OH |
| --- | --------------- | --------------------- | ------ | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile5        | 696 nt | ATGG  | ATCT  |
| 2   | Oligo pool      | Tile 5 (15540 oligos) | 290 nt | ATCT  | AGAA  |
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
| 2   | 3'WT block        | bsmbi_3wt_tile5_sub1     | 888 nt  | ATCT  | ACCC  |
| 3   | 3'WT block        | bsmbi_3wt_tile1_sub2     | 990 nt  | ACCC  | ACCC  |
| 4   | 3'WT block        | bsmbi_3wt_tile1_sub3     | 1428 nt | ACCC  | CAAA  |
| 5   | 3'WT+PolIII block | bsmbi_3wt_tile1_sub4     | 1343 nt | CAAA  | CACC  |
| 6   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1 | --      | --    | --    |

```
  [ATCT]----3'WT sub1----[ACCC]----3'WT sub2----[ACCC]----3'WT sub3----[CAAA]----3'WT+PolIII sub4----[CACC]
   ATCT                   ACCC                   ACCC                   CAAA                          CACC 
```

**Set fidelity:** 1.0000 (4 overhangs)

---

### Tile 6 of 23 -- Codons 301-376 (228 nt)

**Boundary overhangs:**

| Position          | Sequence | Fidelity |
| ----------------- | -------- | -------- |
| oh1 (5' boundary) | ACCG     | 0.5169   |
| oh2 (3' boundary) | GGGC     | 0.4951   |

**Variants:** 15120 mutations, 15120 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name             | Length | 5' OH | 3' OH |
| --- | --------------- | --------------------- | ------ | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile6        | 918 nt | ATGG  | ACCG  |
| 2   | Oligo pool      | Tile 6 (15120 oligos) | 284 nt | ACCG  | AGAA  |
| 3   | Helper plasmid  | helper_plasmid_insert | --     | --    | --    |
| 4   | Enzyme + buffer | BsaI-HFv2 + CutSmart  | --     | --    | --    |

```
  [ATGG]----5'WT block----[ACCG]----oligo+BC----[AGAA]
   ATGG                    ACCG                  AGAA 
```

**Set fidelity:** 1.0000 (3 overhangs)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------ | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)      | --      | --    | --    |
| 2   | 3'WT block        | bsmbi_3wt_tile6_sub1     | 672 nt  | GGGC  | ACCC  |
| 3   | 3'WT block        | bsmbi_3wt_tile1_sub2     | 990 nt  | ACCC  | ACCC  |
| 4   | 3'WT block        | bsmbi_3wt_tile1_sub3     | 1428 nt | ACCC  | CAAA  |
| 5   | 3'WT+PolIII block | bsmbi_3wt_tile1_sub4     | 1343 nt | CAAA  | CACC  |
| 6   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1 | --      | --    | --    |

```
  [GGGC]----3'WT sub1----[ACCC]----3'WT sub2----[ACCC]----3'WT sub3----[CAAA]----3'WT+PolIII sub4----[CACC]
   GGGC                   ACCC                   ACCC                   CAAA                          CACC 
```

**Set fidelity:** 1.0000 (4 overhangs)

---

### Tile 7 of 23 -- Codons 373-450 (234 nt)

**Boundary overhangs:**

| Position          | Sequence | Fidelity |
| ----------------- | -------- | -------- |
| oh1 (5' boundary) | GAAA     | 0.8745   |
| oh2 (3' boundary) | GATG     | 0.4742   |

**Variants:** 15540 mutations, 15540 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name             | Length  | 5' OH | 3' OH |
| --- | --------------- | --------------------- | ------- | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile7        | 1134 nt | ATGG  | GAAA  |
| 2   | Oligo pool      | Tile 7 (15540 oligos) | 290 nt  | GAAA  | AGAA  |
| 3   | Helper plasmid  | helper_plasmid_insert | --      | --    | --    |
| 4   | Enzyme + buffer | BsaI-HFv2 + CutSmart  | --      | --    | --    |

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
| 2   | 3'WT block        | bsmbi_3wt_tile7_sub1     | 450 nt  | GATG  | ACCC  |
| 3   | 3'WT block        | bsmbi_3wt_tile1_sub2     | 990 nt  | ACCC  | ACCC  |
| 4   | 3'WT block        | bsmbi_3wt_tile1_sub3     | 1428 nt | ACCC  | CAAA  |
| 5   | 3'WT+PolIII block | bsmbi_3wt_tile1_sub4     | 1343 nt | CAAA  | CACC  |
| 6   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1 | --      | --    | --    |

```
  [GATG]----3'WT sub1----[ACCC]----3'WT sub2----[ACCC]----3'WT sub3----[CAAA]----3'WT+PolIII sub4----[CACC]
   GATG                   ACCC                   ACCC                   CAAA                          CACC 
```

**Set fidelity:** 1.0000 (4 overhangs)

---

### Tile 8 of 23 -- Codons 447-520 (222 nt)

**Boundary overhangs:**

| Position          | Sequence | Fidelity |
| ----------------- | -------- | -------- |
| oh1 (5' boundary) | AATG     | 0.6412   |
| oh2 (3' boundary) | TGAA     | 0.8621   |

**Variants:** 14700 mutations, 14700 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name             | Length  | 5' OH | 3' OH |
| --- | --------------- | --------------------- | ------- | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile8        | 1356 nt | ATGG  | AATG  |
| 2   | Oligo pool      | Tile 8 (14700 oligos) | 278 nt  | AATG  | AGAA  |
| 3   | Helper plasmid  | helper_plasmid_insert | --      | --    | --    |
| 4   | Enzyme + buffer | BsaI-HFv2 + CutSmart  | --      | --    | --    |

```
  [ATGG]----5'WT block----[AATG]----oligo+BC----[AGAA]
   ATGG                    AATG                  AGAA 
```

**Set fidelity:** 1.0000 (3 overhangs)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------ | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)      | --      | --    | --    |
| 2   | 3'WT block        | bsmbi_3wt_tile8_sub1     | 1212 nt | TGAA  | ACCC  |
| 3   | 3'WT block        | bsmbi_3wt_tile1_sub3     | 1428 nt | ACCC  | CAAA  |
| 4   | 3'WT+PolIII block | bsmbi_3wt_tile1_sub4     | 1343 nt | CAAA  | CACC  |
| 5   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1 | --      | --    | --    |

```
  [TGAA]----3'WT sub1----[ACCC]----3'WT sub2----[CAAA]----3'WT+PolIII sub3----[CACC]
   TGAA                   ACCC                   CAAA                          CACC 
```

**Set fidelity:** 1.0000 (4 overhangs)

---

### Tile 9 of 23 -- Codons 517-594 (234 nt)

**Boundary overhangs:**

| Position          | Sequence | Fidelity |
| ----------------- | -------- | -------- |
| oh1 (5' boundary) | GAAC     | 0.6079   |
| oh2 (3' boundary) | ACCC     | 0.5528   |

**Variants:** 15540 mutations, 15540 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name             | Length  | 5' OH | 3' OH |
| --- | --------------- | --------------------- | ------- | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile9        | 1566 nt | ATGG  | GAAC  |
| 2   | Oligo pool      | Tile 9 (15540 oligos) | 290 nt  | GAAC  | AGAA  |
| 3   | Helper plasmid  | helper_plasmid_insert | --      | --    | --    |
| 4   | Enzyme + buffer | BsaI-HFv2 + CutSmart  | --      | --    | --    |

```
  [ATGG]----5'WT block----[GAAC]----oligo+BC----[AGAA]
   ATGG                    GAAC                  AGAA 
```

**Set fidelity:** 1.0000 (3 overhangs)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------ | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)      | --      | --    | --    |
| 2   | 3'WT block        | bsmbi_3wt_tile1_sub2     | 990 nt  | ACCC  | ACCC  |
| 3   | 3'WT block        | bsmbi_3wt_tile1_sub3     | 1428 nt | ACCC  | CAAA  |
| 4   | 3'WT+PolIII block | bsmbi_3wt_tile1_sub4     | 1343 nt | CAAA  | CACC  |
| 5   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1 | --      | --    | --    |

```
  [ACCC]----3'WT sub1----[ACCC]----3'WT sub2----[CAAA]----3'WT+PolIII sub3----[CACC]
   ACCC                   ACCC                   CAAA                          CACC 
```

**Set fidelity:** 1.0000 (3 overhangs)

---

### Tile 10 of 23 -- Codons 591-624 (102 nt)

**Boundary overhangs:**

| Position          | Sequence | Fidelity |
| ----------------- | -------- | -------- |
| oh1 (5' boundary) | GGGA     | 0.6194   |
| oh2 (3' boundary) | AGGG     | 0.5185   |

**Variants:** 6300 mutations, 6300 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name             | Length  | 5' OH | 3' OH |
| --- | --------------- | --------------------- | ------- | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile10       | 1788 nt | ATGG  | GGGA  |
| 2   | Oligo pool      | Tile 10 (6300 oligos) | 158 nt  | GGGA  | AGAA  |
| 3   | Helper plasmid  | helper_plasmid_insert | --      | --    | --    |
| 4   | Enzyme + buffer | BsaI-HFv2 + CutSmart  | --      | --    | --    |

```
  [ATGG]----5'WT block----[GGGA]----oligo+BC----[AGAA]
   ATGG                    GGGA                  AGAA 
```

**Set fidelity:** 1.0000 (3 overhangs)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------ | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)      | --      | --    | --    |
| 2   | 3'WT block        | bsmbi_3wt_tile10_sub1    | 900 nt  | AGGG  | ACCC  |
| 3   | 3'WT block        | bsmbi_3wt_tile1_sub3     | 1428 nt | ACCC  | CAAA  |
| 4   | 3'WT+PolIII block | bsmbi_3wt_tile1_sub4     | 1343 nt | CAAA  | CACC  |
| 5   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1 | --      | --    | --    |

```
  [AGGG]----3'WT sub1----[ACCC]----3'WT sub2----[CAAA]----3'WT+PolIII sub3----[CACC]
   AGGG                   ACCC                   CAAA                          CACC 
```

**Set fidelity:** 1.0000 (4 overhangs)

---

### Tile 11 of 23 -- Codons 621-698 (234 nt)

**Boundary overhangs:**

| Position          | Sequence | Fidelity |
| ----------------- | -------- | -------- |
| oh1 (5' boundary) | AATC     | 0.7116   |
| oh2 (3' boundary) | CTAT     | 0.7299   |

**Variants:** 15540 mutations, 15540 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name              | Length  | 5' OH | 3' OH |
| --- | --------------- | ---------------------- | ------- | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile11_sub1   | 1796 nt | ATGG  | ACCC  |
| 2   | 5'WT gene block | bsai_5wt_tile11_sub2   | 100 nt  | ACCC  | AATC  |
| 3   | Oligo pool      | Tile 11 (15540 oligos) | 290 nt  | AATC  | AGAA  |
| 4   | Helper plasmid  | helper_plasmid_insert  | --      | --    | --    |
| 5   | Enzyme + buffer | BsaI-HFv2 + CutSmart   | --      | --    | --    |

```
  [ATGG]----5'WT sub1----[ACCC]----5'WT sub2----[AATC]----oligo+BC----[AGAA]
   ATGG                   ACCC                   AATC                  AGAA 
```

**Set fidelity:** 1.0000 (4 overhangs)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------ | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)      | --      | --    | --    |
| 2   | 3'WT block        | bsmbi_3wt_tile11_sub1    | 678 nt  | CTAT  | ACCC  |
| 3   | 3'WT block        | bsmbi_3wt_tile1_sub3     | 1428 nt | ACCC  | CAAA  |
| 4   | 3'WT+PolIII block | bsmbi_3wt_tile1_sub4     | 1343 nt | CAAA  | CACC  |
| 5   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1 | --      | --    | --    |

```
  [CTAT]----3'WT sub1----[ACCC]----3'WT sub2----[CAAA]----3'WT+PolIII sub3----[CACC]
   CTAT                   ACCC                   CAAA                          CACC 
```

**Set fidelity:** 1.0000 (4 overhangs)

---

### Tile 12 of 23 -- Codons 695-771 (231 nt)

**Boundary overhangs:**

| Position          | Sequence | Fidelity |
| ----------------- | -------- | -------- |
| oh1 (5' boundary) | CGGA     | 0.6609   |
| oh2 (3' boundary) | TTGG     | 0.6005   |

**Variants:** 15330 mutations, 15330 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name              | Length  | 5' OH | 3' OH |
| --- | --------------- | ---------------------- | ------- | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile11_sub1   | 1796 nt | ATGG  | ACCC  |
| 2   | 5'WT gene block | bsai_5wt_tile12_sub2   | 322 nt  | ACCC  | CGGA  |
| 3   | Oligo pool      | Tile 12 (15330 oligos) | 287 nt  | CGGA  | AGAA  |
| 4   | Helper plasmid  | helper_plasmid_insert  | --      | --    | --    |
| 5   | Enzyme + buffer | BsaI-HFv2 + CutSmart   | --      | --    | --    |

```
  [ATGG]----5'WT sub1----[ACCC]----5'WT sub2----[CGGA]----oligo+BC----[AGAA]
   ATGG                   ACCC                   CGGA                  AGAA 
```

**Set fidelity:** 1.0000 (4 overhangs)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------ | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)      | --      | --    | --    |
| 2   | 3'WT block        | bsmbi_3wt_tile12_sub1    | 459 nt  | TTGG  | ACCC  |
| 3   | 3'WT block        | bsmbi_3wt_tile1_sub3     | 1428 nt | ACCC  | CAAA  |
| 4   | 3'WT+PolIII block | bsmbi_3wt_tile1_sub4     | 1343 nt | CAAA  | CACC  |
| 5   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1 | --      | --    | --    |

```
  [TTGG]----3'WT sub1----[ACCC]----3'WT sub2----[CAAA]----3'WT+PolIII sub3----[CACC]
   TTGG                   ACCC                   CAAA                          CACC 
```

**Set fidelity:** 1.0000 (4 overhangs)

---

### Tile 13 of 23 -- Codons 768-845 (234 nt)

**Boundary overhangs:**

| Position          | Sequence | Fidelity |
| ----------------- | -------- | -------- |
| oh1 (5' boundary) | GGCT     | 0.4697   |
| oh2 (3' boundary) | GCTG     | 0.4520   |

**Variants:** 15540 mutations, 15540 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name              | Length  | 5' OH | 3' OH |
| --- | --------------- | ---------------------- | ------- | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile11_sub1   | 1796 nt | ATGG  | ACCC  |
| 2   | 5'WT gene block | bsai_5wt_tile13_sub2   | 541 nt  | ACCC  | GGCT  |
| 3   | Oligo pool      | Tile 13 (15540 oligos) | 290 nt  | GGCT  | AGAA  |
| 4   | Helper plasmid  | helper_plasmid_insert  | --      | --    | --    |
| 5   | Enzyme + buffer | BsaI-HFv2 + CutSmart   | --      | --    | --    |

```
  [ATGG]----5'WT sub1----[ACCC]----5'WT sub2----[GGCT]----oligo+BC----[AGAA]
   ATGG                   ACCC                   GGCT                  AGAA 
```

**Set fidelity:** 1.0000 (4 overhangs)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------ | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)      | --      | --    | --    |
| 2   | 3'WT block        | bsmbi_3wt_tile13_sub1    | 1647 nt | GCTG  | CAAA  |
| 3   | 3'WT+PolIII block | bsmbi_3wt_tile1_sub4     | 1343 nt | CAAA  | CACC  |
| 4   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1 | --      | --    | --    |

```
  [GCTG]----3'WT sub1----[CAAA]----3'WT+PolIII sub2----[CACC]
   GCTG                   CAAA                          CACC 
```

**Set fidelity:** 1.0000 (3 overhangs)

---

### Tile 14 of 23 -- Codons 842-918 (231 nt)

**Boundary overhangs:**

| Position          | Sequence | Fidelity |
| ----------------- | -------- | -------- |
| oh1 (5' boundary) | TACT     | 0.7445   |
| oh2 (3' boundary) | ACCC     | 0.5528   |

**Variants:** 15330 mutations, 15330 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name              | Length  | 5' OH | 3' OH |
| --- | --------------- | ---------------------- | ------- | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile11_sub1   | 1796 nt | ATGG  | ACCC  |
| 2   | 5'WT gene block | bsai_5wt_tile14_sub2   | 763 nt  | ACCC  | TACT  |
| 3   | Oligo pool      | Tile 14 (15330 oligos) | 287 nt  | TACT  | AGAA  |
| 4   | Helper plasmid  | helper_plasmid_insert  | --      | --    | --    |
| 5   | Enzyme + buffer | BsaI-HFv2 + CutSmart   | --      | --    | --    |

```
  [ATGG]----5'WT sub1----[ACCC]----5'WT sub2----[TACT]----oligo+BC----[AGAA]
   ATGG                   ACCC                   TACT                  AGAA 
```

**Set fidelity:** 1.0000 (4 overhangs)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------ | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)      | --      | --    | --    |
| 2   | 3'WT block        | bsmbi_3wt_tile1_sub3     | 1428 nt | ACCC  | CAAA  |
| 3   | 3'WT+PolIII block | bsmbi_3wt_tile1_sub4     | 1343 nt | CAAA  | CACC  |
| 4   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1 | --      | --    | --    |

```
  [ACCC]----3'WT sub1----[CAAA]----3'WT+PolIII sub2----[CACC]
   ACCC                   CAAA                          CACC 
```

**Set fidelity:** 1.0000 (3 overhangs)

---

### Tile 15 of 23 -- Codons 915-948 (102 nt)

**Boundary overhangs:**

| Position          | Sequence | Fidelity |
| ----------------- | -------- | -------- |
| oh1 (5' boundary) | ATGG     | 0.5393   |
| oh2 (3' boundary) | GTCC     | 0.5806   |

**Variants:** 6300 mutations, 6300 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name             | Length  | 5' OH | 3' OH |
| --- | --------------- | --------------------- | ------- | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile11_sub1  | 1796 nt | ATGG  | ACCC  |
| 2   | 5'WT gene block | bsai_5wt_tile15_sub2  | 982 nt  | ACCC  | ATGG  |
| 3   | Oligo pool      | Tile 15 (6300 oligos) | 158 nt  | ATGG  | AGAA  |
| 4   | Helper plasmid  | helper_plasmid_insert | --      | --    | --    |
| 5   | Enzyme + buffer | BsaI-HFv2 + CutSmart  | --      | --    | --    |

```
  [ATGG]----5'WT sub1----[ACCC]----5'WT sub2----[ATGG]----oligo+BC----[AGAA]
   ATGG                   ACCC                   ATGG                  AGAA 
```

**Set fidelity:** 1.0000 (3 overhangs)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------ | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)      | --      | --    | --    |
| 2   | 3'WT block        | bsmbi_3wt_tile15_sub1    | 1338 nt | GTCC  | CAAA  |
| 3   | 3'WT+PolIII block | bsmbi_3wt_tile1_sub4     | 1343 nt | CAAA  | CACC  |
| 4   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1 | --      | --    | --    |

```
  [GTCC]----3'WT sub1----[CAAA]----3'WT+PolIII sub2----[CACC]
   GTCC                   CAAA                          CACC 
```

**Set fidelity:** 1.0000 (3 overhangs)

---

### Tile 16 of 23 -- Codons 945-1022 (234 nt)

**Boundary overhangs:**

| Position          | Sequence | Fidelity |
| ----------------- | -------- | -------- |
| oh1 (5' boundary) | GACA     | 0.6127   |
| oh2 (3' boundary) | ACGC     | 0.4481   |

**Variants:** 15540 mutations, 15540 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name              | Length  | 5' OH | 3' OH |
| --- | --------------- | ---------------------- | ------- | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile11_sub1   | 1796 nt | ATGG  | ACCC  |
| 2   | 5'WT gene block | bsai_5wt_tile16_sub2   | 1072 nt | ACCC  | GACA  |
| 3   | Oligo pool      | Tile 16 (15540 oligos) | 290 nt  | GACA  | AGAA  |
| 4   | Helper plasmid  | helper_plasmid_insert  | --      | --    | --    |
| 5   | Enzyme + buffer | BsaI-HFv2 + CutSmart   | --      | --    | --    |

```
  [ATGG]----5'WT sub1----[ACCC]----5'WT sub2----[GACA]----oligo+BC----[AGAA]
   ATGG                   ACCC                   GACA                  AGAA 
```

**Set fidelity:** 1.0000 (4 overhangs)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------ | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)      | --      | --    | --    |
| 2   | 3'WT block        | bsmbi_3wt_tile16_sub1    | 1116 nt | ACGC  | CAAA  |
| 3   | 3'WT+PolIII block | bsmbi_3wt_tile1_sub4     | 1343 nt | CAAA  | CACC  |
| 4   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1 | --      | --    | --    |

```
  [ACGC]----3'WT sub1----[CAAA]----3'WT+PolIII sub2----[CACC]
   ACGC                   CAAA                          CACC 
```

**Set fidelity:** 1.0000 (3 overhangs)

---

### Tile 17 of 23 -- Codons 1019-1094 (228 nt)

**Boundary overhangs:**

| Position          | Sequence | Fidelity |
| ----------------- | -------- | -------- |
| oh1 (5' boundary) | GATT     | 0.6417   |
| oh2 (3' boundary) | ATAC     | 0.6804   |

**Variants:** 15120 mutations, 15120 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name              | Length  | 5' OH | 3' OH |
| --- | --------------- | ---------------------- | ------- | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile11_sub1   | 1796 nt | ATGG  | ACCC  |
| 2   | 5'WT gene block | bsai_5wt_tile17_sub2   | 990 nt  | ACCC  | ACCC  |
| 3   | 5'WT gene block | bsai_5wt_tile17_sub3   | 322 nt  | ACCC  | GATT  |
| 4   | Oligo pool      | Tile 17 (15120 oligos) | 284 nt  | GATT  | AGAA  |
| 5   | Helper plasmid  | helper_plasmid_insert  | --      | --    | --    |
| 6   | Enzyme + buffer | BsaI-HFv2 + CutSmart   | --      | --    | --    |

```
  [ATGG]----5'WT sub1----[ACCC]----5'WT sub2----[ACCC]----5'WT sub3----[GATT]----oligo+BC----[AGAA]
   ATGG                   ACCC                   ACCC                   GATT                  AGAA 
```

**Set fidelity:** 1.0000 (4 overhangs)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------ | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)      | --      | --    | --    |
| 2   | 3'WT block        | bsmbi_3wt_tile17_sub1    | 900 nt  | ATAC  | CAAA  |
| 3   | 3'WT+PolIII block | bsmbi_3wt_tile1_sub4     | 1343 nt | CAAA  | CACC  |
| 4   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1 | --      | --    | --    |

```
  [ATAC]----3'WT sub1----[CAAA]----3'WT+PolIII sub2----[CACC]
   ATAC                   CAAA                          CACC 
```

**Set fidelity:** 1.0000 (3 overhangs)

---

### Tile 18 of 23 -- Codons 1091-1167 (231 nt)

**Boundary overhangs:**

| Position          | Sequence | Fidelity |
| ----------------- | -------- | -------- |
| oh1 (5' boundary) | GCCT     | 0.5289   |
| oh2 (3' boundary) | AATG     | 0.6412   |

**Variants:** 15330 mutations, 15330 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name              | Length  | 5' OH | 3' OH |
| --- | --------------- | ---------------------- | ------- | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile11_sub1   | 1796 nt | ATGG  | ACCC  |
| 2   | 5'WT gene block | bsai_5wt_tile17_sub2   | 990 nt  | ACCC  | ACCC  |
| 3   | 5'WT gene block | bsai_5wt_tile18_sub3   | 538 nt  | ACCC  | GCCT  |
| 4   | Oligo pool      | Tile 18 (15330 oligos) | 287 nt  | GCCT  | AGAA  |
| 5   | Helper plasmid  | helper_plasmid_insert  | --      | --    | --    |
| 6   | Enzyme + buffer | BsaI-HFv2 + CutSmart   | --      | --    | --    |

```
  [ATGG]----5'WT sub1----[ACCC]----5'WT sub2----[ACCC]----5'WT sub3----[GCCT]----oligo+BC----[AGAA]
   ATGG                   ACCC                   ACCC                   GCCT                  AGAA 
```

**Set fidelity:** 0.9951 (4 overhangs)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------ | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)      | --      | --    | --    |
| 2   | 3'WT block        | bsmbi_3wt_tile18_sub1    | 681 nt  | AATG  | CAAA  |
| 3   | 3'WT+PolIII block | bsmbi_3wt_tile1_sub4     | 1343 nt | CAAA  | CACC  |
| 4   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1 | --      | --    | --    |

```
  [AATG]----3'WT sub1----[CAAA]----3'WT+PolIII sub2----[CACC]
   AATG                   CAAA                          CACC 
```

**Set fidelity:** 1.0000 (3 overhangs)

---

### Tile 19 of 23 -- Codons 1164-1241 (234 nt)

**Boundary overhangs:**

| Position          | Sequence | Fidelity |
| ----------------- | -------- | -------- |
| oh1 (5' boundary) | ACGC     | 0.4481   |
| oh2 (3' boundary) | GCGG     | 0.4337   |

**Variants:** 15540 mutations, 15540 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name              | Length  | 5' OH | 3' OH |
| --- | --------------- | ---------------------- | ------- | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile11_sub1   | 1796 nt | ATGG  | ACCC  |
| 2   | 5'WT gene block | bsai_5wt_tile17_sub2   | 990 nt  | ACCC  | ACCC  |
| 3   | 5'WT gene block | bsai_5wt_tile19_sub3   | 757 nt  | ACCC  | ACGC  |
| 4   | Oligo pool      | Tile 19 (15540 oligos) | 290 nt  | ACGC  | AGAA  |
| 5   | Helper plasmid  | helper_plasmid_insert  | --      | --    | --    |
| 6   | Enzyme + buffer | BsaI-HFv2 + CutSmart   | --      | --    | --    |

```
  [ATGG]----5'WT sub1----[ACCC]----5'WT sub2----[ACCC]----5'WT sub3----[ACGC]----oligo+BC----[AGAA]
   ATGG                   ACCC                   ACCC                   ACGC                  AGAA 
```

**Set fidelity:** 0.9496 (4 overhangs)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------ | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)      | --      | --    | --    |
| 2   | 3'WT block        | bsmbi_3wt_tile19_sub1    | 459 nt  | GCGG  | CAAA  |
| 3   | 3'WT+PolIII block | bsmbi_3wt_tile1_sub4     | 1343 nt | CAAA  | CACC  |
| 4   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1 | --      | --    | --    |

```
  [GCGG]----3'WT sub1----[CAAA]----3'WT+PolIII sub2----[CACC]
   GCGG                   CAAA                          CACC 
```

**Set fidelity:** 1.0000 (3 overhangs)

---

### Tile 20 of 23 -- Codons 1238-1315 (234 nt)

**Boundary overhangs:**

| Position          | Sequence | Fidelity |
| ----------------- | -------- | -------- |
| oh1 (5' boundary) | GCCT     | 0.5289   |
| oh2 (3' boundary) | GGAC     | 0.5754   |

**Variants:** 15540 mutations, 15540 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name              | Length  | 5' OH | 3' OH |
| --- | --------------- | ---------------------- | ------- | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile11_sub1   | 1796 nt | ATGG  | ACCC  |
| 2   | 5'WT gene block | bsai_5wt_tile17_sub2   | 990 nt  | ACCC  | ACCC  |
| 3   | 5'WT gene block | bsai_5wt_tile20_sub3   | 979 nt  | ACCC  | GCCT  |
| 4   | Oligo pool      | Tile 20 (15540 oligos) | 290 nt  | GCCT  | AGAA  |
| 5   | Helper plasmid  | helper_plasmid_insert  | --      | --    | --    |
| 6   | Enzyme + buffer | BsaI-HFv2 + CutSmart   | --      | --    | --    |

```
  [ATGG]----5'WT sub1----[ACCC]----5'WT sub2----[ACCC]----5'WT sub3----[GCCT]----oligo+BC----[AGAA]
   ATGG                   ACCC                   ACCC                   GCCT                  AGAA 
```

**Set fidelity:** 0.9951 (4 overhangs)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------ | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)      | --      | --    | --    |
| 2   | 3'WT+PolIII block | bsmbi_3wt_tile20_sub1    | 1562 nt | GGAC  | CACC  |
| 3   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1 | --      | --    | --    |

```
  [GGAC]----3'WT+PolIII----[CACC]
   GGAC                     CACC 
```

**Set fidelity:** 1.0000 (2 overhangs)

---

### Tile 21 of 23 -- Codons 1312-1388 (231 nt)

**Boundary overhangs:**

| Position          | Sequence | Fidelity |
| ----------------- | -------- | -------- |
| oh1 (5' boundary) | AGCC     | 0.4644   |
| oh2 (3' boundary) | CAAA     | 0.8948   |

**Variants:** 15330 mutations, 15330 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name              | Length  | 5' OH | 3' OH |
| --- | --------------- | ---------------------- | ------- | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile11_sub1   | 1796 nt | ATGG  | ACCC  |
| 2   | 5'WT gene block | bsai_5wt_tile17_sub2   | 990 nt  | ACCC  | ACCC  |
| 3   | 5'WT gene block | bsai_5wt_tile21_sub3   | 1201 nt | ACCC  | AGCC  |
| 4   | Oligo pool      | Tile 21 (15330 oligos) | 287 nt  | AGCC  | AGAA  |
| 5   | Helper plasmid  | helper_plasmid_insert  | --      | --    | --    |
| 6   | Enzyme + buffer | BsaI-HFv2 + CutSmart   | --      | --    | --    |

```
  [ATGG]----5'WT sub1----[ACCC]----5'WT sub2----[ACCC]----5'WT sub3----[AGCC]----oligo+BC----[AGAA]
   ATGG                   ACCC                   ACCC                   AGCC                  AGAA 
```

**Set fidelity:** 0.9192 (4 overhangs)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------ | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)      | --      | --    | --    |
| 2   | 3'WT+PolIII block | bsmbi_3wt_tile1_sub4     | 1343 nt | CAAA  | CACC  |
| 3   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1 | --      | --    | --    |

```
  [CAAA]----3'WT+PolIII----[CACC]
   CAAA                     CACC 
```

**Set fidelity:** 1.0000 (2 overhangs)

---

### Tile 22 of 23 -- Codons 1385-1415 (93 nt)

**Boundary overhangs:**

| Position          | Sequence | Fidelity |
| ----------------- | -------- | -------- |
| oh1 (5' boundary) | GACC     | 0.5155   |
| oh2 (3' boundary) | GGAC     | 0.5754   |

**Variants:** 5670 mutations, 5670 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name             | Length  | 5' OH | 3' OH |
| --- | --------------- | --------------------- | ------- | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile11_sub1  | 1796 nt | ATGG  | ACCC  |
| 2   | 5'WT gene block | bsai_5wt_tile17_sub2  | 990 nt  | ACCC  | ACCC  |
| 3   | 5'WT gene block | bsai_5wt_tile22_sub3  | 1420 nt | ACCC  | GACC  |
| 4   | Oligo pool      | Tile 22 (5670 oligos) | 149 nt  | GACC  | AGAA  |
| 5   | Helper plasmid  | helper_plasmid_insert | --      | --    | --    |
| 6   | Enzyme + buffer | BsaI-HFv2 + CutSmart  | --      | --    | --    |

```
  [ATGG]----5'WT sub1----[ACCC]----5'WT sub2----[ACCC]----5'WT sub3----[GACC]----oligo+BC----[AGAA]
   ATGG                   ACCC                   ACCC                   GACC                  AGAA 
```

**Set fidelity:** 1.0000 (4 overhangs)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------ | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)      | --      | --    | --    |
| 2   | 3'WT+PolIII block | bsmbi_3wt_tile22         | 1262 nt | GGAC  | CACC  |
| 3   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1 | --      | --    | --    |

```
  [GGAC]----3'WT+PolIII----[CACC]
   GGAC                     CACC 
```

**Set fidelity:** 1.0000 (2 overhangs)

---

### Tile 23 of 23 -- Codons 1412-1465 (162 nt)

**Boundary overhangs:**

| Position          | Sequence | Fidelity |
| ----------------- | -------- | -------- |
| oh1 (5' boundary) | TGTT     | 0.6450   |
| oh2 (3' boundary) | TTAA     | 0.9448   |

**Variants:** 10500 mutations, 10500 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name              | Length  | 5' OH | 3' OH |
| --- | --------------- | ---------------------- | ------- | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile11_sub1   | 1796 nt | ATGG  | ACCC  |
| 2   | 5'WT gene block | bsai_5wt_tile17_sub2   | 990 nt  | ACCC  | ACCC  |
| 3   | 5'WT gene block | bsai_5wt_tile23_sub3   | 1501 nt | ACCC  | TGTT  |
| 4   | Oligo pool      | Tile 23 (10500 oligos) | 218 nt  | TGTT  | AGAA  |
| 5   | Helper plasmid  | helper_plasmid_insert  | --      | --    | --    |
| 6   | Enzyme + buffer | BsaI-HFv2 + CutSmart   | --      | --    | --    |

```
  [ATGG]----5'WT sub1----[ACCC]----5'WT sub2----[ACCC]----5'WT sub3----[TGTT]----oligo+BC----[AGAA]
   ATGG                   ACCC                   ACCC                   TGTT                  AGAA 
```

**Set fidelity:** 1.0000 (4 overhangs)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component            | Part name                | Length  | 5' OH | 3' OH |
| --- | -------------------- | ------------------------ | ------- | ----- | ----- |
| 1   | BsaI product         | (in helper plasmid)      | --      | --    | --    |
| 2   | PolIII-only fragment | bsmbi_polIII_tile23      | 1112 nt | TTAA  | CACC  |
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

**Total blocks:** 47

| Block name            | Length (nt) | Enzyme type | Gene region                                                                                                                                                                                                                                                                                                                                                                                                                                                   |
| --------------------- | ----------- | ----------- | ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| bsai_5wt_tile10       | 1788        | BsaI        | 5wt_tile10                                                                                                                                                                                                                                                                                                                                                                                                                                                    |
| bsai_5wt_tile11_sub1  | 1796        | BsaI        | 5wt_tile11_sub1;5wt_tile12_sub1;5wt_tile13_sub1;5wt_tile14_sub1;5wt_tile15_sub1;5wt_tile16_sub1;5wt_tile17_sub1;5wt_tile18_sub1;5wt_tile19_sub1;5wt_tile20_sub1;5wt_tile21_sub1;5wt_tile22_sub1;5wt_tile23_sub1                                                                                                                                                                                                                                               |
| bsai_5wt_tile11_sub2  | 100         | BsaI        | 5wt_tile11_sub2                                                                                                                                                                                                                                                                                                                                                                                                                                               |
| bsai_5wt_tile12_sub2  | 322         | BsaI        | 5wt_tile12_sub2                                                                                                                                                                                                                                                                                                                                                                                                                                               |
| bsai_5wt_tile13_sub2  | 541         | BsaI        | 5wt_tile13_sub2                                                                                                                                                                                                                                                                                                                                                                                                                                               |
| bsai_5wt_tile14_sub2  | 763         | BsaI        | 5wt_tile14_sub2                                                                                                                                                                                                                                                                                                                                                                                                                                               |
| bsai_5wt_tile15_sub2  | 982         | BsaI        | 5wt_tile15_sub2                                                                                                                                                                                                                                                                                                                                                                                                                                               |
| bsai_5wt_tile16_sub2  | 1072        | BsaI        | 5wt_tile16_sub2                                                                                                                                                                                                                                                                                                                                                                                                                                               |
| bsai_5wt_tile17_sub2  | 990         | BsaI        | 5wt_tile17_sub2;5wt_tile18_sub2;5wt_tile19_sub2;5wt_tile20_sub2;5wt_tile21_sub2;5wt_tile22_sub2;5wt_tile23_sub2                                                                                                                                                                                                                                                                                                                                               |
| bsai_5wt_tile17_sub3  | 322         | BsaI        | 5wt_tile17_sub3                                                                                                                                                                                                                                                                                                                                                                                                                                               |
| bsai_5wt_tile18_sub3  | 538         | BsaI        | 5wt_tile18_sub3                                                                                                                                                                                                                                                                                                                                                                                                                                               |
| bsai_5wt_tile19_sub3  | 757         | BsaI        | 5wt_tile19_sub3                                                                                                                                                                                                                                                                                                                                                                                                                                               |
| bsai_5wt_tile2        | 99          | BsaI        | 5wt_tile2                                                                                                                                                                                                                                                                                                                                                                                                                                                     |
| bsai_5wt_tile20_sub3  | 979         | BsaI        | 5wt_tile20_sub3                                                                                                                                                                                                                                                                                                                                                                                                                                               |
| bsai_5wt_tile21_sub3  | 1201        | BsaI        | 5wt_tile21_sub3                                                                                                                                                                                                                                                                                                                                                                                                                                               |
| bsai_5wt_tile22_sub3  | 1420        | BsaI        | 5wt_tile22_sub3                                                                                                                                                                                                                                                                                                                                                                                                                                               |
| bsai_5wt_tile23_sub3  | 1501        | BsaI        | 5wt_tile23_sub3                                                                                                                                                                                                                                                                                                                                                                                                                                               |
| bsai_5wt_tile3        | 261         | BsaI        | 5wt_tile3                                                                                                                                                                                                                                                                                                                                                                                                                                                     |
| bsai_5wt_tile4        | 477         | BsaI        | 5wt_tile4                                                                                                                                                                                                                                                                                                                                                                                                                                                     |
| bsai_5wt_tile5        | 696         | BsaI        | 5wt_tile5                                                                                                                                                                                                                                                                                                                                                                                                                                                     |
| bsai_5wt_tile6        | 918         | BsaI        | 5wt_tile6                                                                                                                                                                                                                                                                                                                                                                                                                                                     |
| bsai_5wt_tile7        | 1134        | BsaI        | 5wt_tile7                                                                                                                                                                                                                                                                                                                                                                                                                                                     |
| bsai_5wt_tile8        | 1356        | BsaI        | 5wt_tile8                                                                                                                                                                                                                                                                                                                                                                                                                                                     |
| bsai_5wt_tile9        | 1566        | BsaI        | 5wt_tile9                                                                                                                                                                                                                                                                                                                                                                                                                                                     |
| bsmbi_3wt_tile1_sub1  | 1707        | BsmBI       | 3wt_tile1_sub1                                                                                                                                                                                                                                                                                                                                                                                                                                                |
| bsmbi_3wt_tile1_sub2  | 990         | BsmBI       | 3wt_tile1_sub2;3wt_tile2_sub2;3wt_tile3_sub2;3wt_tile4_sub2;3wt_tile5_sub2;3wt_tile6_sub2;3wt_tile7_sub2;3wt_tile9_sub1                                                                                                                                                                                                                                                                                                                                       |
| bsmbi_3wt_tile1_sub3  | 1428        | BsmBI       | 3wt_tile1_sub3;3wt_tile2_sub3;3wt_tile3_sub3;3wt_tile4_sub3;3wt_tile5_sub3;3wt_tile6_sub3;3wt_tile7_sub3;3wt_tile8_sub2;3wt_tile9_sub2;3wt_tile10_sub2;3wt_tile11_sub2;3wt_tile12_sub2;3wt_tile14_sub1                                                                                                                                                                                                                                                        |
| bsmbi_3wt_tile1_sub4  | 1343        | BsmBI       | 3wt_polIII_tile1_sub4;3wt_polIII_tile2_sub4;3wt_polIII_tile3_sub4;3wt_polIII_tile4_sub4;3wt_polIII_tile5_sub4;3wt_polIII_tile6_sub4;3wt_polIII_tile7_sub4;3wt_polIII_tile8_sub3;3wt_polIII_tile9_sub3;3wt_polIII_tile10_sub3;3wt_polIII_tile11_sub3;3wt_polIII_tile12_sub3;3wt_polIII_tile13_sub2;3wt_polIII_tile14_sub2;3wt_polIII_tile15_sub2;3wt_polIII_tile16_sub2;3wt_polIII_tile17_sub2;3wt_polIII_tile18_sub2;3wt_polIII_tile19_sub2;3wt_polIII_tile21 |
| bsmbi_3wt_tile10_sub1 | 900         | BsmBI       | 3wt_tile10_sub1                                                                                                                                                                                                                                                                                                                                                                                                                                               |
| bsmbi_3wt_tile11_sub1 | 678         | BsmBI       | 3wt_tile11_sub1                                                                                                                                                                                                                                                                                                                                                                                                                                               |
| bsmbi_3wt_tile12_sub1 | 459         | BsmBI       | 3wt_tile12_sub1                                                                                                                                                                                                                                                                                                                                                                                                                                               |
| bsmbi_3wt_tile13_sub1 | 1647        | BsmBI       | 3wt_tile13_sub1                                                                                                                                                                                                                                                                                                                                                                                                                                               |
| bsmbi_3wt_tile15_sub1 | 1338        | BsmBI       | 3wt_tile15_sub1                                                                                                                                                                                                                                                                                                                                                                                                                                               |
| bsmbi_3wt_tile16_sub1 | 1116        | BsmBI       | 3wt_tile16_sub1                                                                                                                                                                                                                                                                                                                                                                                                                                               |
| bsmbi_3wt_tile17_sub1 | 900         | BsmBI       | 3wt_tile17_sub1                                                                                                                                                                                                                                                                                                                                                                                                                                               |
| bsmbi_3wt_tile18_sub1 | 681         | BsmBI       | 3wt_tile18_sub1                                                                                                                                                                                                                                                                                                                                                                                                                                               |
| bsmbi_3wt_tile19_sub1 | 459         | BsmBI       | 3wt_tile19_sub1                                                                                                                                                                                                                                                                                                                                                                                                                                               |
| bsmbi_3wt_tile2_sub1  | 1545        | BsmBI       | 3wt_tile2_sub1                                                                                                                                                                                                                                                                                                                                                                                                                                                |
| bsmbi_3wt_tile20_sub1 | 1562        | BsmBI       | 3wt_polIII_tile20_sub1                                                                                                                                                                                                                                                                                                                                                                                                                                        |
| bsmbi_3wt_tile22      | 1262        | BsmBI       | 3wt_polIII_tile22                                                                                                                                                                                                                                                                                                                                                                                                                                             |
| bsmbi_3wt_tile3_sub1  | 1329        | BsmBI       | 3wt_tile3_sub1                                                                                                                                                                                                                                                                                                                                                                                                                                                |
| bsmbi_3wt_tile4_sub1  | 1110        | BsmBI       | 3wt_tile4_sub1                                                                                                                                                                                                                                                                                                                                                                                                                                                |
| bsmbi_3wt_tile5_sub1  | 888         | BsmBI       | 3wt_tile5_sub1                                                                                                                                                                                                                                                                                                                                                                                                                                                |
| bsmbi_3wt_tile6_sub1  | 672         | BsmBI       | 3wt_tile6_sub1                                                                                                                                                                                                                                                                                                                                                                                                                                                |
| bsmbi_3wt_tile7_sub1  | 450         | BsmBI       | 3wt_tile7_sub1                                                                                                                                                                                                                                                                                                                                                                                                                                                |
| bsmbi_3wt_tile8_sub1  | 1212        | BsmBI       | 3wt_tile8_sub1                                                                                                                                                                                                                                                                                                                                                                                                                                                |
| bsmbi_polIII_tile23   | 1112        | BsmBI       | polIII_tile23                                                                                                                                                                                                                                                                                                                                                                                                                                                 |

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

