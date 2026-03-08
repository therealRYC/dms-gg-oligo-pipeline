# DMS-GG Assembly Report: AKAP11

Generated: 2026-03-08 14:32:46
Pipeline: dms-gg-oligo-pipeline (3-Enzyme Architecture: BsaI + BsmBI + PaqCI)

---

## 1. Gene Summary

| Property             | Value                                                                          |
| -------------------- | ------------------------------------------------------------------------------ |
| Gene name            | AKAP11_NM_016248.4_CDS Homo sapiens A-kinase anchoring protein 11 (AKAP11) CDS |
| CDS length           | 5706 nt (1902 codons)                                                          |
| Protein length       | 1901 aa                                                                        |
| Number of tiles      | 28                                                                             |
| Total variants       | 39858                                                                          |
| Total oligos         | 398580                                                                         |
| Oligo length range   | 149-290 nt                                                                     |
| Gene blocks to order | 58                                                                             |
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

**Total oligos:** 398580 | **Length range:** 149-290 nt

| Tile | Codons    | Oligos | Length |
| ---- | --------- | ------ | ------ |
| 1    | 1-50      | 9660   | 206 nt |
| 2    | 47-124    | 15540  | 290 nt |
| 3    | 121-197   | 15330  | 287 nt |
| 4    | 194-271   | 15540  | 290 nt |
| 5    | 268-343   | 15120  | 284 nt |
| 6    | 340-417   | 15540  | 290 nt |
| 7    | 414-491   | 15540  | 290 nt |
| 8    | 488-565   | 15540  | 290 nt |
| 9    | 562-592   | 5670   | 149 nt |
| 10   | 589-661   | 14490  | 275 nt |
| 11   | 658-733   | 15120  | 284 nt |
| 12   | 730-807   | 15540  | 290 nt |
| 13   | 804-881   | 15540  | 290 nt |
| 14   | 878-955   | 15540  | 290 nt |
| 15   | 952-1029  | 15540  | 290 nt |
| 16   | 1026-1101 | 15120  | 284 nt |
| 17   | 1098-1172 | 14910  | 281 nt |
| 18   | 1169-1246 | 15540  | 290 nt |
| 19   | 1243-1320 | 15540  | 290 nt |
| 20   | 1317-1390 | 14700  | 278 nt |
| 21   | 1387-1463 | 15330  | 287 nt |
| 22   | 1460-1537 | 15540  | 290 nt |
| 23   | 1534-1610 | 15330  | 287 nt |
| 24   | 1607-1681 | 14910  | 281 nt |
| 25   | 1678-1709 | 5880   | 152 nt |
| 26   | 1706-1760 | 10710  | 221 nt |
| 27   | 1757-1832 | 15120  | 284 nt |
| 28   | 1829-1902 | 14700  | 278 nt |

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
| Total barcodes    | 398580                             |
| Unique barcodes   | 398580                             |
| GC content range  | 25% - 75%                          |
| GC content mean   | 48.4%                              |
| Hamming guarantee | 100% cross-variant (prefix d >= 3) |

## 5. QC Summary

**Overall:** ISSUES FOUND

| Check                  | Description                                                   | Result | Detail                                                                                                                                              |
| ---------------------- | ------------------------------------------------------------- | ------ | --------------------------------------------------------------------------------------------------------------------------------------------------- |
| oligo_lengths          | All oligos within synthesis length limit                      | PASS   | Range: 149-290 nt (limit: 300)                                                                                                                      |
| block_lengths          | All gene blocks within synthesis length limit                 | PASS   | Range: 94-1782 nt (limit: 1800)                                                                                                                     |
| barcode_junction_sites | No enzyme sites at barcode-context junctions                  | PASS   | 0 barcode(s) with junction enzyme sites (left='CACACC', right='AGAATG')                                                                             |
| barcode_uniqueness     | All barcodes are unique                                       | PASS   | 398580 unique / 398580 total                                                                                                                        |
| tile_coverage          | Tiles cover entire gene without gaps                          | PASS   | 5706 / 5706 nt covered                                                                                                                              |
| variant_count          | Expected number of variants generated                         | PASS   | 39858 unique variants (expected: 39858 across 1898/1900 mutable positions; 36062 missense + 1898 nonsense + 1898 wt_control; 2 position(s) skipped) |
| single_codon_change    | Each non-control variant differs by exactly one codon from WT | PASS   | 379600 / 379600 variants confirmed (WT controls excluded)                                                                                           |
| oligo_gc_content       | Oligo GC content within reasonable range (25-75%)             | PASS   | GC range: 32.1-55.9% | 0 oligo(s) with extreme GC                                                                                                   |
| domestication_complete | Gene domesticated for all 3 enzymes (BsaI, BsmBI, PaqCI)      | PASS   | No enzyme sites in gene                                                                                                                             |
| overhang_fidelity      | Tile boundary overhangs have adequate fidelity                | FAIL   | 27 tile(s) with low-fidelity boundary overhangs (<0.80)                                                                                             |
| tile_manifests         | Per-tile assembly manifests complete                          | PASS   | 28 tile manifest(s) generated                                                                                                                       |
| helper_plasmid         | Helper plasmid free of unintended BsmBI sites                 | PASS   | OK                                                                                                                                                  |
| reaction_fidelity      | Per-reaction set-level overhang fidelity                      | PASS   | Min set fidelity: 0.9318 across 56 reactions | 0 reaction(s) below 0.90                                                                             |
| barcode_poliii_term    | No barcodes contain PolIII terminator signal (TTTT)           | PASS   | 0 / 398580 barcode(s) contain TTTT                                                                                                                  |
| block_min_length       | All gene blocks above synthesis minimum length                | FAIL   | 8 block(s) below 300 nt minimum. Range: 94-1782 nt                                                                                                  |
| sb_overhang_collisions | Superblock boundary overhangs are unique (no collisions)      | PASS   | 3 SB boundary OH(s), all unique                                                                                                                     |

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
| 6    | 3        | 1.0000            | 4         | 1.0000             |
| 7    | 3        | 1.0000            | 5         | 1.0000             |
| 8    | 3        | 1.0000            | 4         | 1.0000             |
| 9    | 3        | 1.0000            | 4         | 1.0000             |
| 10   | 3        | 1.0000            | 4         | 1.0000             |
| 11   | 4        | 0.9318            | 4         | 1.0000             |
| 12   | 4        | 1.0000            | 4         | 0.9987             |
| 13   | 4        | 1.0000            | 4         | 1.0000             |
| 14   | 4        | 1.0000            | 4         | 1.0000             |
| 15   | 4        | 1.0000            | 4         | 1.0000             |
| 16   | 4        | 1.0000            | 3         | 1.0000             |
| 17   | 4        | 1.0000            | 3         | 1.0000             |
| 18   | 5        | 1.0000            | 3         | 1.0000             |
| 19   | 5        | 1.0000            | 3         | 1.0000             |
| 20   | 5        | 1.0000            | 3         | 1.0000             |
| 21   | 5        | 1.0000            | 3         | 1.0000             |
| 22   | 5        | 1.0000            | 3         | 1.0000             |
| 23   | 5        | 1.0000            | 2         | 1.0000             |
| 24   | 5        | 0.9962            | 2         | 1.0000             |
| 25   | 5        | 1.0000            | 2         | 1.0000             |
| 26   | 6        | 1.0000            | 2         | 1.0000             |
| 27   | 6        | 1.0000            | 2         | 1.0000             |
| 28   | 6        | 1.0000            | 2         | 1.0000             |

**Min:** 0.9318 | **Max:** 1.0000 | **Mean:** 0.9987

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

### Tile 1 of 28 -- Codons 1-50 (150 nt)

**Boundary overhangs:**

| Position          | Sequence | Fidelity |
| ----------------- | -------- | -------- |
| oh1 (5' boundary) | ATGG     | 0.5393   |
| oh2 (3' boundary) | TGAG     | 0.6546   |

**Variants:** 9660 mutations, 9660 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name                          | Length | 5' OH | 3' OH |
| --- | --------------- | ---------------------------------- | ------ | ----- | ----- |
| 1   | 5'WT gene block | (none -- tile starts at gene nt 1) | --     | --    | --    |
| 2   | Oligo pool      | Tile 1 (9660 oligos)               | 206 nt | ATGG  | AGAA  |
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
| 2   | 3'WT block        | bsmbi_3wt_tile1_sub1     | 1563 nt | TGAG  | TGCA  |
| 3   | 3'WT block        | bsmbi_3wt_tile1_sub2     | 1626 nt | TGCA  | TCCT  |
| 4   | 3'WT block        | bsmbi_3wt_tile1_sub3     | 1758 nt | TCCT  | GGGT  |
| 5   | 3'WT+PolIII block | bsmbi_3wt_tile1_sub4     | 1775 nt | GGGT  | CACC  |
| 6   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1 | --      | --    | --    |

```
  [TGAG]----3'WT sub1----[TGCA]----3'WT sub2----[TCCT]----3'WT sub3----[GGGT]----3'WT+PolIII sub4----[CACC]
   TGAG                   TGCA                   TCCT                   GGGT                          CACC 
```

**Set fidelity:** 1.0000 (5 overhangs)

---

### Tile 2 of 28 -- Codons 47-124 (234 nt)

**Boundary overhangs:**

| Position          | Sequence | Fidelity |
| ----------------- | -------- | -------- |
| oh1 (5' boundary) | CAGC     | 0.4815   |
| oh2 (3' boundary) | GCTT     | 0.5632   |

**Variants:** 15540 mutations, 15540 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name             | Length | 5' OH | 3' OH |
| --- | --------------- | --------------------- | ------ | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile2        | 156 nt | ATGG  | CAGC  |
| 2   | Oligo pool      | Tile 2 (15540 oligos) | 290 nt | CAGC  | AGAA  |
| 3   | Helper plasmid  | helper_plasmid_insert | --     | --    | --    |
| 4   | Enzyme + buffer | BsaI-HFv2 + CutSmart  | --     | --    | --    |

```
  [ATGG]----5'WT block----[CAGC]----oligo+BC----[AGAA]
   ATGG                    CAGC                  AGAA 
```

**Set fidelity:** 1.0000 (3 overhangs)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------ | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)      | --      | --    | --    |
| 2   | 3'WT block        | bsmbi_3wt_tile2_sub1     | 1341 nt | GCTT  | TGCA  |
| 3   | 3'WT block        | bsmbi_3wt_tile1_sub2     | 1626 nt | TGCA  | TCCT  |
| 4   | 3'WT block        | bsmbi_3wt_tile1_sub3     | 1758 nt | TCCT  | GGGT  |
| 5   | 3'WT+PolIII block | bsmbi_3wt_tile1_sub4     | 1775 nt | GGGT  | CACC  |
| 6   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1 | --      | --    | --    |

```
  [GCTT]----3'WT sub1----[TGCA]----3'WT sub2----[TCCT]----3'WT sub3----[GGGT]----3'WT+PolIII sub4----[CACC]
   GCTT                   TGCA                   TCCT                   GGGT                          CACC 
```

**Set fidelity:** 1.0000 (5 overhangs)

---

### Tile 3 of 28 -- Codons 121-197 (231 nt)

**Boundary overhangs:**

| Position          | Sequence | Fidelity |
| ----------------- | -------- | -------- |
| oh1 (5' boundary) | TCTG     | 0.6684   |
| oh2 (3' boundary) | GGAA     | 0.7463   |

**Variants:** 15330 mutations, 15330 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name             | Length | 5' OH | 3' OH |
| --- | --------------- | --------------------- | ------ | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile3        | 378 nt | ATGG  | TCTG  |
| 2   | Oligo pool      | Tile 3 (15330 oligos) | 287 nt | TCTG  | AGAA  |
| 3   | Helper plasmid  | helper_plasmid_insert | --     | --    | --    |
| 4   | Enzyme + buffer | BsaI-HFv2 + CutSmart  | --     | --    | --    |

```
  [ATGG]----5'WT block----[TCTG]----oligo+BC----[AGAA]
   ATGG                    TCTG                  AGAA 
```

**Set fidelity:** 1.0000 (3 overhangs)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------ | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)      | --      | --    | --    |
| 2   | 3'WT block        | bsmbi_3wt_tile3_sub1     | 1122 nt | GGAA  | TGCA  |
| 3   | 3'WT block        | bsmbi_3wt_tile1_sub2     | 1626 nt | TGCA  | TCCT  |
| 4   | 3'WT block        | bsmbi_3wt_tile1_sub3     | 1758 nt | TCCT  | GGGT  |
| 5   | 3'WT+PolIII block | bsmbi_3wt_tile1_sub4     | 1775 nt | GGGT  | CACC  |
| 6   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1 | --      | --    | --    |

```
  [GGAA]----3'WT sub1----[TGCA]----3'WT sub2----[TCCT]----3'WT sub3----[GGGT]----3'WT+PolIII sub4----[CACC]
   GGAA                   TGCA                   TCCT                   GGGT                          CACC 
```

**Set fidelity:** 1.0000 (5 overhangs)

---

### Tile 4 of 28 -- Codons 194-271 (234 nt)

**Boundary overhangs:**

| Position          | Sequence | Fidelity |
| ----------------- | -------- | -------- |
| oh1 (5' boundary) | TTAG     | 0.8480   |
| oh2 (3' boundary) | ATCA     | 0.7483   |

**Variants:** 15540 mutations, 15540 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name             | Length | 5' OH | 3' OH |
| --- | --------------- | --------------------- | ------ | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile4        | 597 nt | ATGG  | TTAG  |
| 2   | Oligo pool      | Tile 4 (15540 oligos) | 290 nt | TTAG  | AGAA  |
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
| 2   | 3'WT block        | bsmbi_3wt_tile4_sub1     | 900 nt  | ATCA  | TGCA  |
| 3   | 3'WT block        | bsmbi_3wt_tile1_sub2     | 1626 nt | TGCA  | TCCT  |
| 4   | 3'WT block        | bsmbi_3wt_tile1_sub3     | 1758 nt | TCCT  | GGGT  |
| 5   | 3'WT+PolIII block | bsmbi_3wt_tile1_sub4     | 1775 nt | GGGT  | CACC  |
| 6   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1 | --      | --    | --    |

```
  [ATCA]----3'WT sub1----[TGCA]----3'WT sub2----[TCCT]----3'WT sub3----[GGGT]----3'WT+PolIII sub4----[CACC]
   ATCA                   TGCA                   TCCT                   GGGT                          CACC 
```

**Set fidelity:** 1.0000 (5 overhangs)

---

### Tile 5 of 28 -- Codons 268-343 (228 nt)

**Boundary overhangs:**

| Position          | Sequence | Fidelity |
| ----------------- | -------- | -------- |
| oh1 (5' boundary) | GTCA     | 0.5915   |
| oh2 (3' boundary) | AGAT     | 0.6825   |

**Variants:** 15120 mutations, 15120 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name             | Length | 5' OH | 3' OH |
| --- | --------------- | --------------------- | ------ | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile5        | 819 nt | ATGG  | GTCA  |
| 2   | Oligo pool      | Tile 5 (15120 oligos) | 284 nt | GTCA  | AGAA  |
| 3   | Helper plasmid  | helper_plasmid_insert | --     | --    | --    |
| 4   | Enzyme + buffer | BsaI-HFv2 + CutSmart  | --     | --    | --    |

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
| 2   | 3'WT block        | bsmbi_3wt_tile5_sub1     | 684 nt  | AGAT  | TGCA  |
| 3   | 3'WT block        | bsmbi_3wt_tile1_sub2     | 1626 nt | TGCA  | TCCT  |
| 4   | 3'WT block        | bsmbi_3wt_tile1_sub3     | 1758 nt | TCCT  | GGGT  |
| 5   | 3'WT+PolIII block | bsmbi_3wt_tile1_sub4     | 1775 nt | GGGT  | CACC  |
| 6   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1 | --      | --    | --    |

```
  [AGAT]----3'WT sub1----[TGCA]----3'WT sub2----[TCCT]----3'WT sub3----[GGGT]----3'WT+PolIII sub4----[CACC]
   AGAT                   TGCA                   TCCT                   GGGT                          CACC 
```

**Set fidelity:** 1.0000 (5 overhangs)

---

### Tile 6 of 28 -- Codons 340-417 (234 nt)

**Boundary overhangs:**

| Position          | Sequence | Fidelity |
| ----------------- | -------- | -------- |
| oh1 (5' boundary) | GTGA     | 0.5613   |
| oh2 (3' boundary) | TCCT     | 0.7573   |

**Variants:** 15540 mutations, 15540 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name             | Length  | 5' OH | 3' OH |
| --- | --------------- | --------------------- | ------- | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile6        | 1035 nt | ATGG  | GTGA  |
| 2   | Oligo pool      | Tile 6 (15540 oligos) | 290 nt  | GTGA  | AGAA  |
| 3   | Helper plasmid  | helper_plasmid_insert | --      | --    | --    |
| 4   | Enzyme + buffer | BsaI-HFv2 + CutSmart  | --      | --    | --    |

```
  [ATGG]----5'WT block----[GTGA]----oligo+BC----[AGAA]
   ATGG                    GTGA                  AGAA 
```

**Set fidelity:** 1.0000 (3 overhangs)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------ | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)      | --      | --    | --    |
| 2   | 3'WT block        | bsmbi_3wt_tile6_sub1     | 462 nt  | TCCT  | TGCA  |
| 3   | 3'WT block        | bsmbi_3wt_tile1_sub2     | 1626 nt | TGCA  | TCCT  |
| 4   | 3'WT block        | bsmbi_3wt_tile1_sub3     | 1758 nt | TCCT  | GGGT  |
| 5   | 3'WT+PolIII block | bsmbi_3wt_tile1_sub4     | 1775 nt | GGGT  | CACC  |
| 6   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1 | --      | --    | --    |

```
  [TCCT]----3'WT sub1----[TGCA]----3'WT sub2----[TCCT]----3'WT sub3----[GGGT]----3'WT+PolIII sub4----[CACC]
   TCCT                   TGCA                   TCCT                   GGGT                          CACC 
```

**Set fidelity:** 1.0000 (4 overhangs)

---

### Tile 7 of 28 -- Codons 414-491 (234 nt)

**Boundary overhangs:**

| Position          | Sequence | Fidelity |
| ----------------- | -------- | -------- |
| oh1 (5' boundary) | AAGC     | 0.5900   |
| oh2 (3' boundary) | CTAT     | 0.7299   |

**Variants:** 15540 mutations, 15540 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name             | Length  | 5' OH | 3' OH |
| --- | --------------- | --------------------- | ------- | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile7        | 1257 nt | ATGG  | AAGC  |
| 2   | Oligo pool      | Tile 7 (15540 oligos) | 290 nt  | AAGC  | AGAA  |
| 3   | Helper plasmid  | helper_plasmid_insert | --      | --    | --    |
| 4   | Enzyme + buffer | BsaI-HFv2 + CutSmart  | --      | --    | --    |

```
  [ATGG]----5'WT block----[AAGC]----oligo+BC----[AGAA]
   ATGG                    AAGC                  AGAA 
```

**Set fidelity:** 1.0000 (3 overhangs)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------ | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)      | --      | --    | --    |
| 2   | 3'WT block        | bsmbi_3wt_tile7_sub1     | 240 nt  | CTAT  | TGCA  |
| 3   | 3'WT block        | bsmbi_3wt_tile1_sub2     | 1626 nt | TGCA  | TCCT  |
| 4   | 3'WT block        | bsmbi_3wt_tile1_sub3     | 1758 nt | TCCT  | GGGT  |
| 5   | 3'WT+PolIII block | bsmbi_3wt_tile1_sub4     | 1775 nt | GGGT  | CACC  |
| 6   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1 | --      | --    | --    |

```
  [CTAT]----3'WT sub1----[TGCA]----3'WT sub2----[TCCT]----3'WT sub3----[GGGT]----3'WT+PolIII sub4----[CACC]
   CTAT                   TGCA                   TCCT                   GGGT                          CACC 
```

**Set fidelity:** 1.0000 (5 overhangs)

---

### Tile 8 of 28 -- Codons 488-565 (234 nt)

**Boundary overhangs:**

| Position          | Sequence | Fidelity |
| ----------------- | -------- | -------- |
| oh1 (5' boundary) | TATG     | 0.7006   |
| oh2 (3' boundary) | TGCA     | 0.6831   |

**Variants:** 15540 mutations, 15540 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name             | Length  | 5' OH | 3' OH |
| --- | --------------- | --------------------- | ------- | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile8        | 1479 nt | ATGG  | TATG  |
| 2   | Oligo pool      | Tile 8 (15540 oligos) | 290 nt  | TATG  | AGAA  |
| 3   | Helper plasmid  | helper_plasmid_insert | --      | --    | --    |
| 4   | Enzyme + buffer | BsaI-HFv2 + CutSmart  | --      | --    | --    |

```
  [ATGG]----5'WT block----[TATG]----oligo+BC----[AGAA]
   ATGG                    TATG                  AGAA 
```

**Set fidelity:** 1.0000 (3 overhangs)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------ | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)      | --      | --    | --    |
| 2   | 3'WT block        | bsmbi_3wt_tile1_sub2     | 1626 nt | TGCA  | TCCT  |
| 3   | 3'WT block        | bsmbi_3wt_tile1_sub3     | 1758 nt | TCCT  | GGGT  |
| 4   | 3'WT+PolIII block | bsmbi_3wt_tile1_sub4     | 1775 nt | GGGT  | CACC  |
| 5   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1 | --      | --    | --    |

```
  [TGCA]----3'WT sub1----[TCCT]----3'WT sub2----[GGGT]----3'WT+PolIII sub3----[CACC]
   TGCA                   TCCT                   GGGT                          CACC 
```

**Set fidelity:** 1.0000 (4 overhangs)

---

### Tile 9 of 28 -- Codons 562-592 (93 nt)

**Boundary overhangs:**

| Position          | Sequence | Fidelity |
| ----------------- | -------- | -------- |
| oh1 (5' boundary) | TTTG     | 0.7063   |
| oh2 (3' boundary) | TTTG     | 0.7063   |

**Variants:** 5670 mutations, 5670 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name             | Length  | 5' OH | 3' OH |
| --- | --------------- | --------------------- | ------- | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile9        | 1701 nt | ATGG  | TTTG  |
| 2   | Oligo pool      | Tile 9 (5670 oligos)  | 149 nt  | TTTG  | AGAA  |
| 3   | Helper plasmid  | helper_plasmid_insert | --      | --    | --    |
| 4   | Enzyme + buffer | BsaI-HFv2 + CutSmart  | --      | --    | --    |

```
  [ATGG]----5'WT block----[TTTG]----oligo+BC----[AGAA]
   ATGG                    TTTG                  AGAA 
```

**Set fidelity:** 1.0000 (3 overhangs)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------ | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)      | --      | --    | --    |
| 2   | 3'WT block        | bsmbi_3wt_tile9_sub1     | 1545 nt | TTTG  | TCCT  |
| 3   | 3'WT block        | bsmbi_3wt_tile1_sub3     | 1758 nt | TCCT  | GGGT  |
| 4   | 3'WT+PolIII block | bsmbi_3wt_tile1_sub4     | 1775 nt | GGGT  | CACC  |
| 5   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1 | --      | --    | --    |

```
  [TTTG]----3'WT sub1----[TCCT]----3'WT sub2----[GGGT]----3'WT+PolIII sub3----[CACC]
   TTTG                   TCCT                   GGGT                          CACC 
```

**Set fidelity:** 1.0000 (4 overhangs)

---

### Tile 10 of 28 -- Codons 589-661 (219 nt)

**Boundary overhangs:**

| Position          | Sequence | Fidelity |
| ----------------- | -------- | -------- |
| oh1 (5' boundary) | TCAT     | 0.8102   |
| oh2 (3' boundary) | GGAG     | 0.5228   |

**Variants:** 14490 mutations, 14490 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name              | Length  | 5' OH | 3' OH |
| --- | --------------- | ---------------------- | ------- | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile10_sub1   | 1782 nt | ATGG  | TCAT  |
| 2   | Oligo pool      | Tile 10 (14490 oligos) | 275 nt  | TCAT  | AGAA  |
| 3   | Helper plasmid  | helper_plasmid_insert  | --      | --    | --    |
| 4   | Enzyme + buffer | BsaI-HFv2 + CutSmart   | --      | --    | --    |

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
| 2   | 3'WT block        | bsmbi_3wt_tile10_sub1    | 1338 nt | GGAG  | TCCT  |
| 3   | 3'WT block        | bsmbi_3wt_tile1_sub3     | 1758 nt | TCCT  | GGGT  |
| 4   | 3'WT+PolIII block | bsmbi_3wt_tile1_sub4     | 1775 nt | GGGT  | CACC  |
| 5   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1 | --      | --    | --    |

```
  [GGAG]----3'WT sub1----[TCCT]----3'WT sub2----[GGGT]----3'WT+PolIII sub3----[CACC]
   GGAG                   TCCT                   GGGT                          CACC 
```

**Set fidelity:** 1.0000 (4 overhangs)

---

### Tile 11 of 28 -- Codons 658-733 (228 nt)

**Boundary overhangs:**

| Position          | Sequence | Fidelity |
| ----------------- | -------- | -------- |
| oh1 (5' boundary) | GGCA     | 0.5273   |
| oh2 (3' boundary) | TGTA     | 0.7693   |

**Variants:** 15120 mutations, 15120 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name              | Length  | 5' OH | 3' OH |
| --- | --------------- | ---------------------- | ------- | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile11_sub1   | 1709 nt | ATGG  | TGCA  |
| 2   | 5'WT gene block | bsai_5wt_tile11_sub2   | 298 nt  | TGCA  | GGCA  |
| 3   | Oligo pool      | Tile 11 (15120 oligos) | 284 nt  | GGCA  | AGAA  |
| 4   | Helper plasmid  | helper_plasmid_insert  | --      | --    | --    |
| 5   | Enzyme + buffer | BsaI-HFv2 + CutSmart   | --      | --    | --    |

```
  [ATGG]----5'WT sub1----[TGCA]----5'WT sub2----[GGCA]----oligo+BC----[AGAA]
   ATGG                   TGCA                   GGCA                  AGAA 
```

**Set fidelity:** 0.9318 (4 overhangs)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------ | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)      | --      | --    | --    |
| 2   | 3'WT block        | bsmbi_3wt_tile11_sub1    | 1122 nt | TGTA  | TCCT  |
| 3   | 3'WT block        | bsmbi_3wt_tile1_sub3     | 1758 nt | TCCT  | GGGT  |
| 4   | 3'WT+PolIII block | bsmbi_3wt_tile1_sub4     | 1775 nt | GGGT  | CACC  |
| 5   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1 | --      | --    | --    |

```
  [TGTA]----3'WT sub1----[TCCT]----3'WT sub2----[GGGT]----3'WT+PolIII sub3----[CACC]
   TGTA                   TCCT                   GGGT                          CACC 
```

**Set fidelity:** 1.0000 (4 overhangs)

---

### Tile 12 of 28 -- Codons 730-807 (234 nt)

**Boundary overhangs:**

| Position          | Sequence | Fidelity |
| ----------------- | -------- | -------- |
| oh1 (5' boundary) | GCAG     | 0.5118   |
| oh2 (3' boundary) | ATCT     | 0.7151   |

**Variants:** 15540 mutations, 15540 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name              | Length  | 5' OH | 3' OH |
| --- | --------------- | ---------------------- | ------- | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile11_sub1   | 1709 nt | ATGG  | TGCA  |
| 2   | 5'WT gene block | bsai_5wt_tile12_sub2   | 514 nt  | TGCA  | GCAG  |
| 3   | Oligo pool      | Tile 12 (15540 oligos) | 290 nt  | GCAG  | AGAA  |
| 4   | Helper plasmid  | helper_plasmid_insert  | --      | --    | --    |
| 5   | Enzyme + buffer | BsaI-HFv2 + CutSmart   | --      | --    | --    |

```
  [ATGG]----5'WT sub1----[TGCA]----5'WT sub2----[GCAG]----oligo+BC----[AGAA]
   ATGG                   TGCA                   GCAG                  AGAA 
```

**Set fidelity:** 1.0000 (4 overhangs)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------ | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)      | --      | --    | --    |
| 2   | 3'WT block        | bsmbi_3wt_tile12_sub1    | 900 nt  | ATCT  | TCCT  |
| 3   | 3'WT block        | bsmbi_3wt_tile1_sub3     | 1758 nt | TCCT  | GGGT  |
| 4   | 3'WT+PolIII block | bsmbi_3wt_tile1_sub4     | 1775 nt | GGGT  | CACC  |
| 5   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1 | --      | --    | --    |

```
  [ATCT]----3'WT sub1----[TCCT]----3'WT sub2----[GGGT]----3'WT+PolIII sub3----[CACC]
   ATCT                   TCCT                   GGGT                          CACC 
```

**Set fidelity:** 0.9987 (4 overhangs)

---

### Tile 13 of 28 -- Codons 804-881 (234 nt)

**Boundary overhangs:**

| Position          | Sequence | Fidelity |
| ----------------- | -------- | -------- |
| oh1 (5' boundary) | CATC     | 0.5216   |
| oh2 (3' boundary) | GCAT     | 0.5827   |

**Variants:** 15540 mutations, 15540 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name              | Length  | 5' OH | 3' OH |
| --- | --------------- | ---------------------- | ------- | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile11_sub1   | 1709 nt | ATGG  | TGCA  |
| 2   | 5'WT gene block | bsai_5wt_tile13_sub2   | 736 nt  | TGCA  | CATC  |
| 3   | Oligo pool      | Tile 13 (15540 oligos) | 290 nt  | CATC  | AGAA  |
| 4   | Helper plasmid  | helper_plasmid_insert  | --      | --    | --    |
| 5   | Enzyme + buffer | BsaI-HFv2 + CutSmart   | --      | --    | --    |

```
  [ATGG]----5'WT sub1----[TGCA]----5'WT sub2----[CATC]----oligo+BC----[AGAA]
   ATGG                   TGCA                   CATC                  AGAA 
```

**Set fidelity:** 1.0000 (4 overhangs)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------ | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)      | --      | --    | --    |
| 2   | 3'WT block        | bsmbi_3wt_tile13_sub1    | 678 nt  | GCAT  | TCCT  |
| 3   | 3'WT block        | bsmbi_3wt_tile1_sub3     | 1758 nt | TCCT  | GGGT  |
| 4   | 3'WT+PolIII block | bsmbi_3wt_tile1_sub4     | 1775 nt | GGGT  | CACC  |
| 5   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1 | --      | --    | --    |

```
  [GCAT]----3'WT sub1----[TCCT]----3'WT sub2----[GGGT]----3'WT+PolIII sub3----[CACC]
   GCAT                   TCCT                   GGGT                          CACC 
```

**Set fidelity:** 1.0000 (4 overhangs)

---

### Tile 14 of 28 -- Codons 878-955 (234 nt)

**Boundary overhangs:**

| Position          | Sequence | Fidelity |
| ----------------- | -------- | -------- |
| oh1 (5' boundary) | GCAG     | 0.5118   |
| oh2 (3' boundary) | CAAA     | 0.8948   |

**Variants:** 15540 mutations, 15540 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name              | Length  | 5' OH | 3' OH |
| --- | --------------- | ---------------------- | ------- | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile11_sub1   | 1709 nt | ATGG  | TGCA  |
| 2   | 5'WT gene block | bsai_5wt_tile14_sub2   | 958 nt  | TGCA  | GCAG  |
| 3   | Oligo pool      | Tile 14 (15540 oligos) | 290 nt  | GCAG  | AGAA  |
| 4   | Helper plasmid  | helper_plasmid_insert  | --      | --    | --    |
| 5   | Enzyme + buffer | BsaI-HFv2 + CutSmart   | --      | --    | --    |

```
  [ATGG]----5'WT sub1----[TGCA]----5'WT sub2----[GCAG]----oligo+BC----[AGAA]
   ATGG                   TGCA                   GCAG                  AGAA 
```

**Set fidelity:** 1.0000 (4 overhangs)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------ | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)      | --      | --    | --    |
| 2   | 3'WT block        | bsmbi_3wt_tile14_sub1    | 456 nt  | CAAA  | TCCT  |
| 3   | 3'WT block        | bsmbi_3wt_tile1_sub3     | 1758 nt | TCCT  | GGGT  |
| 4   | 3'WT+PolIII block | bsmbi_3wt_tile1_sub4     | 1775 nt | GGGT  | CACC  |
| 5   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1 | --      | --    | --    |

```
  [CAAA]----3'WT sub1----[TCCT]----3'WT sub2----[GGGT]----3'WT+PolIII sub3----[CACC]
   CAAA                   TCCT                   GGGT                          CACC 
```

**Set fidelity:** 1.0000 (4 overhangs)

---

### Tile 15 of 28 -- Codons 952-1029 (234 nt)

**Boundary overhangs:**

| Position          | Sequence | Fidelity |
| ----------------- | -------- | -------- |
| oh1 (5' boundary) | GATA     | 0.7029   |
| oh2 (3' boundary) | TGTG     | 0.5408   |

**Variants:** 15540 mutations, 15540 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name              | Length  | 5' OH | 3' OH |
| --- | --------------- | ---------------------- | ------- | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile11_sub1   | 1709 nt | ATGG  | TGCA  |
| 2   | 5'WT gene block | bsai_5wt_tile15_sub2   | 1180 nt | TGCA  | GATA  |
| 3   | Oligo pool      | Tile 15 (15540 oligos) | 290 nt  | GATA  | AGAA  |
| 4   | Helper plasmid  | helper_plasmid_insert  | --      | --    | --    |
| 5   | Enzyme + buffer | BsaI-HFv2 + CutSmart   | --      | --    | --    |

```
  [ATGG]----5'WT sub1----[TGCA]----5'WT sub2----[GATA]----oligo+BC----[AGAA]
   ATGG                   TGCA                   GATA                  AGAA 
```

**Set fidelity:** 1.0000 (4 overhangs)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------ | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)      | --      | --    | --    |
| 2   | 3'WT block        | bsmbi_3wt_tile15_sub1    | 234 nt  | TGTG  | TCCT  |
| 3   | 3'WT block        | bsmbi_3wt_tile1_sub3     | 1758 nt | TCCT  | GGGT  |
| 4   | 3'WT+PolIII block | bsmbi_3wt_tile1_sub4     | 1775 nt | GGGT  | CACC  |
| 5   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1 | --      | --    | --    |

```
  [TGTG]----3'WT sub1----[TCCT]----3'WT sub2----[GGGT]----3'WT+PolIII sub3----[CACC]
   TGTG                   TCCT                   GGGT                          CACC 
```

**Set fidelity:** 1.0000 (4 overhangs)

---

### Tile 16 of 28 -- Codons 1026-1101 (228 nt)

**Boundary overhangs:**

| Position          | Sequence | Fidelity |
| ----------------- | -------- | -------- |
| oh1 (5' boundary) | TGTC     | 0.6650   |
| oh2 (3' boundary) | TCCT     | 0.7573   |

**Variants:** 15120 mutations, 15120 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name              | Length  | 5' OH | 3' OH |
| --- | --------------- | ---------------------- | ------- | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile11_sub1   | 1709 nt | ATGG  | TGCA  |
| 2   | 5'WT gene block | bsai_5wt_tile16_sub2   | 1402 nt | TGCA  | TGTC  |
| 3   | Oligo pool      | Tile 16 (15120 oligos) | 284 nt  | TGTC  | AGAA  |
| 4   | Helper plasmid  | helper_plasmid_insert  | --      | --    | --    |
| 5   | Enzyme + buffer | BsaI-HFv2 + CutSmart   | --      | --    | --    |

```
  [ATGG]----5'WT sub1----[TGCA]----5'WT sub2----[TGTC]----oligo+BC----[AGAA]
   ATGG                   TGCA                   TGTC                  AGAA 
```

**Set fidelity:** 1.0000 (4 overhangs)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------ | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)      | --      | --    | --    |
| 2   | 3'WT block        | bsmbi_3wt_tile1_sub3     | 1758 nt | TCCT  | GGGT  |
| 3   | 3'WT+PolIII block | bsmbi_3wt_tile1_sub4     | 1775 nt | GGGT  | CACC  |
| 4   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1 | --      | --    | --    |

```
  [TCCT]----3'WT sub1----[GGGT]----3'WT+PolIII sub2----[CACC]
   TCCT                   GGGT                          CACC 
```

**Set fidelity:** 1.0000 (3 overhangs)

---

### Tile 17 of 28 -- Codons 1098-1172 (225 nt)

**Boundary overhangs:**

| Position          | Sequence | Fidelity |
| ----------------- | -------- | -------- |
| oh1 (5' boundary) | CCTG     | 0.6383   |
| oh2 (3' boundary) | TGAA     | 0.8621   |

**Variants:** 14910 mutations, 14910 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name              | Length  | 5' OH | 3' OH |
| --- | --------------- | ---------------------- | ------- | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile11_sub1   | 1709 nt | ATGG  | TGCA  |
| 2   | 5'WT gene block | bsai_5wt_tile17_sub2   | 1618 nt | TGCA  | CCTG  |
| 3   | Oligo pool      | Tile 17 (14910 oligos) | 281 nt  | CCTG  | AGAA  |
| 4   | Helper plasmid  | helper_plasmid_insert  | --      | --    | --    |
| 5   | Enzyme + buffer | BsaI-HFv2 + CutSmart   | --      | --    | --    |

```
  [ATGG]----5'WT sub1----[TGCA]----5'WT sub2----[CCTG]----oligo+BC----[AGAA]
   ATGG                   TGCA                   CCTG                  AGAA 
```

**Set fidelity:** 1.0000 (4 overhangs)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------ | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)      | --      | --    | --    |
| 2   | 3'WT block        | bsmbi_3wt_tile17_sub1    | 1545 nt | TGAA  | GGGT  |
| 3   | 3'WT+PolIII block | bsmbi_3wt_tile1_sub4     | 1775 nt | GGGT  | CACC  |
| 4   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1 | --      | --    | --    |

```
  [TGAA]----3'WT sub1----[GGGT]----3'WT+PolIII sub2----[CACC]
   TGAA                   GGGT                          CACC 
```

**Set fidelity:** 1.0000 (3 overhangs)

---

### Tile 18 of 28 -- Codons 1169-1246 (234 nt)

**Boundary overhangs:**

| Position          | Sequence | Fidelity |
| ----------------- | -------- | -------- |
| oh1 (5' boundary) | TCTC     | 0.8105   |
| oh2 (3' boundary) | TTTA     | 0.9147   |

**Variants:** 15540 mutations, 15540 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name              | Length  | 5' OH | 3' OH |
| --- | --------------- | ---------------------- | ------- | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile11_sub1   | 1709 nt | ATGG  | TGCA  |
| 2   | 5'WT gene block | bsai_5wt_tile18_sub2   | 1626 nt | TGCA  | TCCT  |
| 3   | 5'WT gene block | bsai_5wt_tile18_sub3   | 223 nt  | TCCT  | TCTC  |
| 4   | Oligo pool      | Tile 18 (15540 oligos) | 290 nt  | TCTC  | AGAA  |
| 5   | Helper plasmid  | helper_plasmid_insert  | --      | --    | --    |
| 6   | Enzyme + buffer | BsaI-HFv2 + CutSmart   | --      | --    | --    |

```
  [ATGG]----5'WT sub1----[TGCA]----5'WT sub2----[TCCT]----5'WT sub3----[TCTC]----oligo+BC----[AGAA]
   ATGG                   TGCA                   TCCT                   TCTC                  AGAA 
```

**Set fidelity:** 1.0000 (5 overhangs)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------ | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)      | --      | --    | --    |
| 2   | 3'WT block        | bsmbi_3wt_tile18_sub1    | 1323 nt | TTTA  | GGGT  |
| 3   | 3'WT+PolIII block | bsmbi_3wt_tile1_sub4     | 1775 nt | GGGT  | CACC  |
| 4   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1 | --      | --    | --    |

```
  [TTTA]----3'WT sub1----[GGGT]----3'WT+PolIII sub2----[CACC]
   TTTA                   GGGT                          CACC 
```

**Set fidelity:** 1.0000 (3 overhangs)

---

### Tile 19 of 28 -- Codons 1243-1320 (234 nt)

**Boundary overhangs:**

| Position          | Sequence | Fidelity |
| ----------------- | -------- | -------- |
| oh1 (5' boundary) | CCTA     | 0.6679   |
| oh2 (3' boundary) | TCTT     | 0.7985   |

**Variants:** 15540 mutations, 15540 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name              | Length  | 5' OH | 3' OH |
| --- | --------------- | ---------------------- | ------- | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile11_sub1   | 1709 nt | ATGG  | TGCA  |
| 2   | 5'WT gene block | bsai_5wt_tile18_sub2   | 1626 nt | TGCA  | TCCT  |
| 3   | 5'WT gene block | bsai_5wt_tile19_sub3   | 445 nt  | TCCT  | CCTA  |
| 4   | Oligo pool      | Tile 19 (15540 oligos) | 290 nt  | CCTA  | AGAA  |
| 5   | Helper plasmid  | helper_plasmid_insert  | --      | --    | --    |
| 6   | Enzyme + buffer | BsaI-HFv2 + CutSmart   | --      | --    | --    |

```
  [ATGG]----5'WT sub1----[TGCA]----5'WT sub2----[TCCT]----5'WT sub3----[CCTA]----oligo+BC----[AGAA]
   ATGG                   TGCA                   TCCT                   CCTA                  AGAA 
```

**Set fidelity:** 1.0000 (5 overhangs)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------ | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)      | --      | --    | --    |
| 2   | 3'WT block        | bsmbi_3wt_tile19_sub1    | 1101 nt | TCTT  | GGGT  |
| 3   | 3'WT+PolIII block | bsmbi_3wt_tile1_sub4     | 1775 nt | GGGT  | CACC  |
| 4   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1 | --      | --    | --    |

```
  [TCTT]----3'WT sub1----[GGGT]----3'WT+PolIII sub2----[CACC]
   TCTT                   GGGT                          CACC 
```

**Set fidelity:** 1.0000 (3 overhangs)

---

### Tile 20 of 28 -- Codons 1317-1390 (222 nt)

**Boundary overhangs:**

| Position          | Sequence | Fidelity |
| ----------------- | -------- | -------- |
| oh1 (5' boundary) | CCGT     | 0.6076   |
| oh2 (3' boundary) | GCAG     | 0.5118   |

**Variants:** 14700 mutations, 14700 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name              | Length  | 5' OH | 3' OH |
| --- | --------------- | ---------------------- | ------- | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile11_sub1   | 1709 nt | ATGG  | TGCA  |
| 2   | 5'WT gene block | bsai_5wt_tile18_sub2   | 1626 nt | TGCA  | TCCT  |
| 3   | 5'WT gene block | bsai_5wt_tile20_sub3   | 667 nt  | TCCT  | CCGT  |
| 4   | Oligo pool      | Tile 20 (14700 oligos) | 278 nt  | CCGT  | AGAA  |
| 5   | Helper plasmid  | helper_plasmid_insert  | --      | --    | --    |
| 6   | Enzyme + buffer | BsaI-HFv2 + CutSmart   | --      | --    | --    |

```
  [ATGG]----5'WT sub1----[TGCA]----5'WT sub2----[TCCT]----5'WT sub3----[CCGT]----oligo+BC----[AGAA]
   ATGG                   TGCA                   TCCT                   CCGT                  AGAA 
```

**Set fidelity:** 1.0000 (5 overhangs)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------ | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)      | --      | --    | --    |
| 2   | 3'WT block        | bsmbi_3wt_tile20_sub1    | 891 nt  | GCAG  | GGGT  |
| 3   | 3'WT+PolIII block | bsmbi_3wt_tile1_sub4     | 1775 nt | GGGT  | CACC  |
| 4   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1 | --      | --    | --    |

```
  [GCAG]----3'WT sub1----[GGGT]----3'WT+PolIII sub2----[CACC]
   GCAG                   GGGT                          CACC 
```

**Set fidelity:** 1.0000 (3 overhangs)

---

### Tile 21 of 28 -- Codons 1387-1463 (231 nt)

**Boundary overhangs:**

| Position          | Sequence | Fidelity |
| ----------------- | -------- | -------- |
| oh1 (5' boundary) | ACCA     | 0.7200   |
| oh2 (3' boundary) | TCAC     | 0.7626   |

**Variants:** 15330 mutations, 15330 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name              | Length  | 5' OH | 3' OH |
| --- | --------------- | ---------------------- | ------- | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile11_sub1   | 1709 nt | ATGG  | TGCA  |
| 2   | 5'WT gene block | bsai_5wt_tile18_sub2   | 1626 nt | TGCA  | TCCT  |
| 3   | 5'WT gene block | bsai_5wt_tile21_sub3   | 877 nt  | TCCT  | ACCA  |
| 4   | Oligo pool      | Tile 21 (15330 oligos) | 287 nt  | ACCA  | AGAA  |
| 5   | Helper plasmid  | helper_plasmid_insert  | --      | --    | --    |
| 6   | Enzyme + buffer | BsaI-HFv2 + CutSmart   | --      | --    | --    |

```
  [ATGG]----5'WT sub1----[TGCA]----5'WT sub2----[TCCT]----5'WT sub3----[ACCA]----oligo+BC----[AGAA]
   ATGG                   TGCA                   TCCT                   ACCA                  AGAA 
```

**Set fidelity:** 1.0000 (5 overhangs)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------ | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)      | --      | --    | --    |
| 2   | 3'WT block        | bsmbi_3wt_tile21_sub1    | 672 nt  | TCAC  | GGGT  |
| 3   | 3'WT+PolIII block | bsmbi_3wt_tile1_sub4     | 1775 nt | GGGT  | CACC  |
| 4   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1 | --      | --    | --    |

```
  [TCAC]----3'WT sub1----[GGGT]----3'WT+PolIII sub2----[CACC]
   TCAC                   GGGT                          CACC 
```

**Set fidelity:** 1.0000 (3 overhangs)

---

### Tile 22 of 28 -- Codons 1460-1537 (234 nt)

**Boundary overhangs:**

| Position          | Sequence | Fidelity |
| ----------------- | -------- | -------- |
| oh1 (5' boundary) | TCTC     | 0.8105   |
| oh2 (3' boundary) | TGTT     | 0.6450   |

**Variants:** 15540 mutations, 15540 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name              | Length  | 5' OH | 3' OH |
| --- | --------------- | ---------------------- | ------- | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile11_sub1   | 1709 nt | ATGG  | TGCA  |
| 2   | 5'WT gene block | bsai_5wt_tile18_sub2   | 1626 nt | TGCA  | TCCT  |
| 3   | 5'WT gene block | bsai_5wt_tile22_sub3   | 1096 nt | TCCT  | TCTC  |
| 4   | Oligo pool      | Tile 22 (15540 oligos) | 290 nt  | TCTC  | AGAA  |
| 5   | Helper plasmid  | helper_plasmid_insert  | --      | --    | --    |
| 6   | Enzyme + buffer | BsaI-HFv2 + CutSmart   | --      | --    | --    |

```
  [ATGG]----5'WT sub1----[TGCA]----5'WT sub2----[TCCT]----5'WT sub3----[TCTC]----oligo+BC----[AGAA]
   ATGG                   TGCA                   TCCT                   TCTC                  AGAA 
```

**Set fidelity:** 1.0000 (5 overhangs)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------ | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)      | --      | --    | --    |
| 2   | 3'WT block        | bsmbi_3wt_tile22_sub1    | 450 nt  | TGTT  | GGGT  |
| 3   | 3'WT+PolIII block | bsmbi_3wt_tile1_sub4     | 1775 nt | GGGT  | CACC  |
| 4   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1 | --      | --    | --    |

```
  [TGTT]----3'WT sub1----[GGGT]----3'WT+PolIII sub2----[CACC]
   TGTT                   GGGT                          CACC 
```

**Set fidelity:** 1.0000 (3 overhangs)

---

### Tile 23 of 28 -- Codons 1534-1610 (231 nt)

**Boundary overhangs:**

| Position          | Sequence | Fidelity |
| ----------------- | -------- | -------- |
| oh1 (5' boundary) | GACA     | 0.6127   |
| oh2 (3' boundary) | GGGT     | 0.5294   |

**Variants:** 15330 mutations, 15330 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name              | Length  | 5' OH | 3' OH |
| --- | --------------- | ---------------------- | ------- | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile11_sub1   | 1709 nt | ATGG  | TGCA  |
| 2   | 5'WT gene block | bsai_5wt_tile18_sub2   | 1626 nt | TGCA  | TCCT  |
| 3   | 5'WT gene block | bsai_5wt_tile23_sub3   | 1318 nt | TCCT  | GACA  |
| 4   | Oligo pool      | Tile 23 (15330 oligos) | 287 nt  | GACA  | AGAA  |
| 5   | Helper plasmid  | helper_plasmid_insert  | --      | --    | --    |
| 6   | Enzyme + buffer | BsaI-HFv2 + CutSmart   | --      | --    | --    |

```
  [ATGG]----5'WT sub1----[TGCA]----5'WT sub2----[TCCT]----5'WT sub3----[GACA]----oligo+BC----[AGAA]
   ATGG                   TGCA                   TCCT                   GACA                  AGAA 
```

**Set fidelity:** 1.0000 (5 overhangs)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------ | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)      | --      | --    | --    |
| 2   | 3'WT block        | bsmbi_3wt_tile23_sub1    | 231 nt  | GGGT  | GGGT  |
| 3   | 3'WT+PolIII block | bsmbi_3wt_tile1_sub4     | 1775 nt | GGGT  | CACC  |
| 4   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1 | --      | --    | --    |

```
  [GGGT]----3'WT sub1----[GGGT]----3'WT+PolIII sub2----[CACC]
   GGGT                   GGGT                          CACC 
```

**Set fidelity:** 1.0000 (2 overhangs)

---

### Tile 24 of 28 -- Codons 1607-1681 (225 nt)

**Boundary overhangs:**

| Position          | Sequence | Fidelity |
| ----------------- | -------- | -------- |
| oh1 (5' boundary) | TTCA     | 0.8824   |
| oh2 (3' boundary) | GGGT     | 0.5294   |

**Variants:** 14910 mutations, 14910 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name              | Length  | 5' OH | 3' OH |
| --- | --------------- | ---------------------- | ------- | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile11_sub1   | 1709 nt | ATGG  | TGCA  |
| 2   | 5'WT gene block | bsai_5wt_tile18_sub2   | 1626 nt | TGCA  | TCCT  |
| 3   | 5'WT gene block | bsai_5wt_tile24_sub3   | 1537 nt | TCCT  | TTCA  |
| 4   | Oligo pool      | Tile 24 (14910 oligos) | 281 nt  | TTCA  | AGAA  |
| 5   | Helper plasmid  | helper_plasmid_insert  | --      | --    | --    |
| 6   | Enzyme + buffer | BsaI-HFv2 + CutSmart   | --      | --    | --    |

```
  [ATGG]----5'WT sub1----[TGCA]----5'WT sub2----[TCCT]----5'WT sub3----[TTCA]----oligo+BC----[AGAA]
   ATGG                   TGCA                   TCCT                   TTCA                  AGAA 
```

**Set fidelity:** 0.9962 (5 overhangs)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------ | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)      | --      | --    | --    |
| 2   | 3'WT+PolIII block | bsmbi_3wt_tile1_sub4     | 1775 nt | GGGT  | CACC  |
| 3   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1 | --      | --    | --    |

```
  [GGGT]----3'WT+PolIII----[CACC]
   GGGT                     CACC 
```

**Set fidelity:** 1.0000 (2 overhangs)

---

### Tile 25 of 28 -- Codons 1678-1709 (96 nt)

**Boundary overhangs:**

| Position          | Sequence | Fidelity |
| ----------------- | -------- | -------- |
| oh1 (5' boundary) | GGAC     | 0.5754   |
| oh2 (3' boundary) | AGAA     | 0.8847   |

**Variants:** 5880 mutations, 5880 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name             | Length  | 5' OH | 3' OH |
| --- | --------------- | --------------------- | ------- | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile11_sub1  | 1709 nt | ATGG  | TGCA  |
| 2   | 5'WT gene block | bsai_5wt_tile18_sub2  | 1626 nt | TGCA  | TCCT  |
| 3   | 5'WT gene block | bsai_5wt_tile25_sub3  | 1750 nt | TCCT  | GGAC  |
| 4   | Oligo pool      | Tile 25 (5880 oligos) | 152 nt  | GGAC  | AGAA  |
| 5   | Helper plasmid  | helper_plasmid_insert | --      | --    | --    |
| 6   | Enzyme + buffer | BsaI-HFv2 + CutSmart  | --      | --    | --    |

```
  [ATGG]----5'WT sub1----[TGCA]----5'WT sub2----[TCCT]----5'WT sub3----[GGAC]----oligo+BC----[AGAA]
   ATGG                   TGCA                   TCCT                   GGAC                  AGAA 
```

**Set fidelity:** 1.0000 (5 overhangs)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------ | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)      | --      | --    | --    |
| 2   | 3'WT+PolIII block | bsmbi_3wt_tile25         | 1691 nt | AGAA  | CACC  |
| 3   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1 | --      | --    | --    |

```
  [AGAA]----3'WT+PolIII----[CACC]
   AGAA                     CACC 
```

**Set fidelity:** 1.0000 (2 overhangs)

---

### Tile 26 of 28 -- Codons 1706-1760 (165 nt)

**Boundary overhangs:**

| Position          | Sequence | Fidelity |
| ----------------- | -------- | -------- |
| oh1 (5' boundary) | AGTT     | 0.6748   |
| oh2 (3' boundary) | TGGT     | 0.5839   |

**Variants:** 10710 mutations, 10710 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name              | Length  | 5' OH | 3' OH |
| --- | --------------- | ---------------------- | ------- | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile11_sub1   | 1709 nt | ATGG  | TGCA  |
| 2   | 5'WT gene block | bsai_5wt_tile18_sub2   | 1626 nt | TGCA  | TCCT  |
| 3   | 5'WT gene block | bsai_5wt_tile26_sub3   | 1758 nt | TCCT  | GGGT  |
| 4   | 5'WT gene block | bsai_5wt_tile26_sub4   | 94 nt   | GGGT  | AGTT  |
| 5   | Oligo pool      | Tile 26 (10710 oligos) | 221 nt  | AGTT  | AGAA  |
| 6   | Helper plasmid  | helper_plasmid_insert  | --      | --    | --    |
| 7   | Enzyme + buffer | BsaI-HFv2 + CutSmart   | --      | --    | --    |

```
  [ATGG]----5'WT sub1----[TGCA]----5'WT sub2----[TCCT]----5'WT sub3----[GGGT]----5'WT sub4----[AGTT]----oligo+BC----[AGAA]
   ATGG                   TGCA                   TCCT                   GGGT                   AGTT                  AGAA 
```

**Set fidelity:** 1.0000 (6 overhangs)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------ | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)      | --      | --    | --    |
| 2   | 3'WT+PolIII block | bsmbi_3wt_tile26         | 1538 nt | TGGT  | CACC  |
| 3   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1 | --      | --    | --    |

```
  [TGGT]----3'WT+PolIII----[CACC]
   TGGT                     CACC 
```

**Set fidelity:** 1.0000 (2 overhangs)

---

### Tile 27 of 28 -- Codons 1757-1832 (228 nt)

**Boundary overhangs:**

| Position          | Sequence | Fidelity |
| ----------------- | -------- | -------- |
| oh1 (5' boundary) | GAAA     | 0.8745   |
| oh2 (3' boundary) | GTGG     | 0.4666   |

**Variants:** 15120 mutations, 15120 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name              | Length  | 5' OH | 3' OH |
| --- | --------------- | ---------------------- | ------- | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile11_sub1   | 1709 nt | ATGG  | TGCA  |
| 2   | 5'WT gene block | bsai_5wt_tile18_sub2   | 1626 nt | TGCA  | TCCT  |
| 3   | 5'WT gene block | bsai_5wt_tile26_sub3   | 1758 nt | TCCT  | GGGT  |
| 4   | 5'WT gene block | bsai_5wt_tile27_sub4   | 247 nt  | GGGT  | GAAA  |
| 5   | Oligo pool      | Tile 27 (15120 oligos) | 284 nt  | GAAA  | AGAA  |
| 6   | Helper plasmid  | helper_plasmid_insert  | --      | --    | --    |
| 7   | Enzyme + buffer | BsaI-HFv2 + CutSmart   | --      | --    | --    |

```
  [ATGG]----5'WT sub1----[TGCA]----5'WT sub2----[TCCT]----5'WT sub3----[GGGT]----5'WT sub4----[GAAA]----oligo+BC----[AGAA]
   ATGG                   TGCA                   TCCT                   GGGT                   GAAA                  AGAA 
```

**Set fidelity:** 1.0000 (6 overhangs)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------ | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)      | --      | --    | --    |
| 2   | 3'WT+PolIII block | bsmbi_3wt_tile27         | 1322 nt | GTGG  | CACC  |
| 3   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1 | --      | --    | --    |

```
  [GTGG]----3'WT+PolIII----[CACC]
   GTGG                     CACC 
```

**Set fidelity:** 1.0000 (2 overhangs)

---

### Tile 28 of 28 -- Codons 1829-1902 (222 nt)

**Boundary overhangs:**

| Position          | Sequence | Fidelity |
| ----------------- | -------- | -------- |
| oh1 (5' boundary) | ATTC     | 0.7084   |
| oh2 (3' boundary) | ATAG     | 0.7330   |

**Variants:** 14700 mutations, 14700 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name              | Length  | 5' OH | 3' OH |
| --- | --------------- | ---------------------- | ------- | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile11_sub1   | 1709 nt | ATGG  | TGCA  |
| 2   | 5'WT gene block | bsai_5wt_tile18_sub2   | 1626 nt | TGCA  | TCCT  |
| 3   | 5'WT gene block | bsai_5wt_tile26_sub3   | 1758 nt | TCCT  | GGGT  |
| 4   | 5'WT gene block | bsai_5wt_tile28_sub4   | 463 nt  | GGGT  | ATTC  |
| 5   | Oligo pool      | Tile 28 (14700 oligos) | 278 nt  | ATTC  | AGAA  |
| 6   | Helper plasmid  | helper_plasmid_insert  | --      | --    | --    |
| 7   | Enzyme + buffer | BsaI-HFv2 + CutSmart   | --      | --    | --    |

```
  [ATGG]----5'WT sub1----[TGCA]----5'WT sub2----[TCCT]----5'WT sub3----[GGGT]----5'WT sub4----[ATTC]----oligo+BC----[AGAA]
   ATGG                   TGCA                   TCCT                   GGGT                   ATTC                  AGAA 
```

**Set fidelity:** 1.0000 (6 overhangs)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component            | Part name                | Length  | 5' OH | 3' OH |
| --- | -------------------- | ------------------------ | ------- | ----- | ----- |
| 1   | BsaI product         | (in helper plasmid)      | --      | --    | --    |
| 2   | PolIII-only fragment | bsmbi_polIII_tile28      | 1112 nt | ATAG  | CACC  |
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

**Total blocks:** 58

| Block name            | Length (nt) | Enzyme type | Gene region                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                               |
| --------------------- | ----------- | ----------- | --------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| bsai_5wt_tile10_sub1  | 1782        | BsaI        | 5wt_tile10_sub1                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                           |
| bsai_5wt_tile11_sub1  | 1709        | BsaI        | 5wt_tile11_sub1;5wt_tile12_sub1;5wt_tile13_sub1;5wt_tile14_sub1;5wt_tile15_sub1;5wt_tile16_sub1;5wt_tile17_sub1;5wt_tile18_sub1;5wt_tile19_sub1;5wt_tile20_sub1;5wt_tile21_sub1;5wt_tile22_sub1;5wt_tile23_sub1;5wt_tile24_sub1;5wt_tile25_sub1;5wt_tile26_sub1;5wt_tile27_sub1;5wt_tile28_sub1                                                                                                                                                                                                                                                           |
| bsai_5wt_tile11_sub2  | 298         | BsaI        | 5wt_tile11_sub2                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                           |
| bsai_5wt_tile12_sub2  | 514         | BsaI        | 5wt_tile12_sub2                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                           |
| bsai_5wt_tile13_sub2  | 736         | BsaI        | 5wt_tile13_sub2                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                           |
| bsai_5wt_tile14_sub2  | 958         | BsaI        | 5wt_tile14_sub2                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                           |
| bsai_5wt_tile15_sub2  | 1180        | BsaI        | 5wt_tile15_sub2                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                           |
| bsai_5wt_tile16_sub2  | 1402        | BsaI        | 5wt_tile16_sub2                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                           |
| bsai_5wt_tile17_sub2  | 1618        | BsaI        | 5wt_tile17_sub2                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                           |
| bsai_5wt_tile18_sub2  | 1626        | BsaI        | 5wt_tile18_sub2;5wt_tile19_sub2;5wt_tile20_sub2;5wt_tile21_sub2;5wt_tile22_sub2;5wt_tile23_sub2;5wt_tile24_sub2;5wt_tile25_sub2;5wt_tile26_sub2;5wt_tile27_sub2;5wt_tile28_sub2                                                                                                                                                                                                                                                                                                                                                                           |
| bsai_5wt_tile18_sub3  | 223         | BsaI        | 5wt_tile18_sub3                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                           |
| bsai_5wt_tile19_sub3  | 445         | BsaI        | 5wt_tile19_sub3                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                           |
| bsai_5wt_tile2        | 156         | BsaI        | 5wt_tile2                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                 |
| bsai_5wt_tile20_sub3  | 667         | BsaI        | 5wt_tile20_sub3                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                           |
| bsai_5wt_tile21_sub3  | 877         | BsaI        | 5wt_tile21_sub3                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                           |
| bsai_5wt_tile22_sub3  | 1096        | BsaI        | 5wt_tile22_sub3                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                           |
| bsai_5wt_tile23_sub3  | 1318        | BsaI        | 5wt_tile23_sub3                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                           |
| bsai_5wt_tile24_sub3  | 1537        | BsaI        | 5wt_tile24_sub3                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                           |
| bsai_5wt_tile25_sub3  | 1750        | BsaI        | 5wt_tile25_sub3                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                           |
| bsai_5wt_tile26_sub3  | 1758        | BsaI        | 5wt_tile26_sub3;5wt_tile27_sub3;5wt_tile28_sub3                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                           |
| bsai_5wt_tile26_sub4  | 94          | BsaI        | 5wt_tile26_sub4                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                           |
| bsai_5wt_tile27_sub4  | 247         | BsaI        | 5wt_tile27_sub4                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                           |
| bsai_5wt_tile28_sub4  | 463         | BsaI        | 5wt_tile28_sub4                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                           |
| bsai_5wt_tile3        | 378         | BsaI        | 5wt_tile3                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                 |
| bsai_5wt_tile4        | 597         | BsaI        | 5wt_tile4                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                 |
| bsai_5wt_tile5        | 819         | BsaI        | 5wt_tile5                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                 |
| bsai_5wt_tile6        | 1035        | BsaI        | 5wt_tile6                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                 |
| bsai_5wt_tile7        | 1257        | BsaI        | 5wt_tile7                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                 |
| bsai_5wt_tile8        | 1479        | BsaI        | 5wt_tile8                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                 |
| bsai_5wt_tile9        | 1701        | BsaI        | 5wt_tile9                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                 |
| bsmbi_3wt_tile1_sub1  | 1563        | BsmBI       | 3wt_tile1_sub1                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                            |
| bsmbi_3wt_tile1_sub2  | 1626        | BsmBI       | 3wt_tile1_sub2;3wt_tile2_sub2;3wt_tile3_sub2;3wt_tile4_sub2;3wt_tile5_sub2;3wt_tile6_sub2;3wt_tile7_sub2;3wt_tile8_sub1                                                                                                                                                                                                                                                                                                                                                                                                                                   |
| bsmbi_3wt_tile1_sub3  | 1758        | BsmBI       | 3wt_tile1_sub3;3wt_tile2_sub3;3wt_tile3_sub3;3wt_tile4_sub3;3wt_tile5_sub3;3wt_tile6_sub3;3wt_tile7_sub3;3wt_tile8_sub2;3wt_tile9_sub2;3wt_tile10_sub2;3wt_tile11_sub2;3wt_tile12_sub2;3wt_tile13_sub2;3wt_tile14_sub2;3wt_tile15_sub2;3wt_tile16_sub1                                                                                                                                                                                                                                                                                                    |
| bsmbi_3wt_tile1_sub4  | 1775        | BsmBI       | 3wt_polIII_tile1_sub4;3wt_polIII_tile2_sub4;3wt_polIII_tile3_sub4;3wt_polIII_tile4_sub4;3wt_polIII_tile5_sub4;3wt_polIII_tile6_sub4;3wt_polIII_tile7_sub4;3wt_polIII_tile8_sub3;3wt_polIII_tile9_sub3;3wt_polIII_tile10_sub3;3wt_polIII_tile11_sub3;3wt_polIII_tile12_sub3;3wt_polIII_tile13_sub3;3wt_polIII_tile14_sub3;3wt_polIII_tile15_sub3;3wt_polIII_tile16_sub2;3wt_polIII_tile17_sub2;3wt_polIII_tile18_sub2;3wt_polIII_tile19_sub2;3wt_polIII_tile20_sub2;3wt_polIII_tile21_sub2;3wt_polIII_tile22_sub2;3wt_polIII_tile23_sub2;3wt_polIII_tile24 |
| bsmbi_3wt_tile10_sub1 | 1338        | BsmBI       | 3wt_tile10_sub1                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                           |
| bsmbi_3wt_tile11_sub1 | 1122        | BsmBI       | 3wt_tile11_sub1                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                           |
| bsmbi_3wt_tile12_sub1 | 900         | BsmBI       | 3wt_tile12_sub1                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                           |
| bsmbi_3wt_tile13_sub1 | 678         | BsmBI       | 3wt_tile13_sub1                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                           |
| bsmbi_3wt_tile14_sub1 | 456         | BsmBI       | 3wt_tile14_sub1                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                           |
| bsmbi_3wt_tile15_sub1 | 234         | BsmBI       | 3wt_tile15_sub1                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                           |
| bsmbi_3wt_tile17_sub1 | 1545        | BsmBI       | 3wt_tile17_sub1                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                           |
| bsmbi_3wt_tile18_sub1 | 1323        | BsmBI       | 3wt_tile18_sub1                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                           |
| bsmbi_3wt_tile19_sub1 | 1101        | BsmBI       | 3wt_tile19_sub1                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                           |
| bsmbi_3wt_tile2_sub1  | 1341        | BsmBI       | 3wt_tile2_sub1                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                            |
| bsmbi_3wt_tile20_sub1 | 891         | BsmBI       | 3wt_tile20_sub1                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                           |
| bsmbi_3wt_tile21_sub1 | 672         | BsmBI       | 3wt_tile21_sub1                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                           |
| bsmbi_3wt_tile22_sub1 | 450         | BsmBI       | 3wt_tile22_sub1                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                           |
| bsmbi_3wt_tile23_sub1 | 231         | BsmBI       | 3wt_tile23_sub1                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                           |
| bsmbi_3wt_tile25      | 1691        | BsmBI       | 3wt_polIII_tile25                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                         |
| bsmbi_3wt_tile26      | 1538        | BsmBI       | 3wt_polIII_tile26                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                         |
| bsmbi_3wt_tile27      | 1322        | BsmBI       | 3wt_polIII_tile27                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                         |
| bsmbi_3wt_tile3_sub1  | 1122        | BsmBI       | 3wt_tile3_sub1                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                            |
| bsmbi_3wt_tile4_sub1  | 900         | BsmBI       | 3wt_tile4_sub1                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                            |
| bsmbi_3wt_tile5_sub1  | 684         | BsmBI       | 3wt_tile5_sub1                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                            |
| bsmbi_3wt_tile6_sub1  | 462         | BsmBI       | 3wt_tile6_sub1                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                            |
| bsmbi_3wt_tile7_sub1  | 240         | BsmBI       | 3wt_tile7_sub1                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                            |
| bsmbi_3wt_tile9_sub1  | 1545        | BsmBI       | 3wt_tile9_sub1                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                            |
| bsmbi_polIII_tile28   | 1112        | BsmBI       | polIII_tile28                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                             |

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

