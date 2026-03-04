# DMS-GG Assembly Report: AKAP11

Generated: 2026-03-03 20:25:42
Pipeline: dms-gg-oligo-pipeline (3-Enzyme Architecture: BsaI + BsmBI + PaqCI)

---

## 1. Gene Summary

| Property             | Value                                                                          |
| -------------------- | ------------------------------------------------------------------------------ |
| Gene name            | AKAP11_NM_016248.4_CDS Homo sapiens A-kinase anchoring protein 11 (AKAP11) CDS |
| CDS length           | 5706 nt (1902 codons)                                                          |
| Protein length       | 1901 aa                                                                        |
| Number of tiles      | 31                                                                             |
| Total variants       | 37960                                                                          |
| Total oligos         | 379600                                                                         |
| Oligo length range   | 167-290 nt                                                                     |
| Gene blocks to order | 64                                                                             |
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

**Total oligos:** 379600 | **Length range:** 167-290 nt

| Tile | Codons    | Oligos | Length |
| ---- | --------- | ------ | ------ |
| 1    | 1-37      | 6600   | 167 nt |
| 2    | 34-105    | 13600  | 272 nt |
| 3    | 102-162   | 11400  | 239 nt |
| 4    | 159-232   | 14000  | 278 nt |
| 5    | 229-281   | 9800   | 215 nt |
| 6    | 278-355   | 14800  | 290 nt |
| 7    | 352-416   | 12200  | 251 nt |
| 8    | 413-480   | 12800  | 260 nt |
| 9    | 477-539   | 11800  | 245 nt |
| 10   | 536-596   | 11400  | 239 nt |
| 11   | 593-668   | 14400  | 284 nt |
| 12   | 665-724   | 11200  | 236 nt |
| 13   | 721-797   | 14600  | 287 nt |
| 14   | 794-867   | 14000  | 278 nt |
| 15   | 864-917   | 10000  | 218 nt |
| 16   | 914-988   | 14200  | 281 nt |
| 17   | 985-1049  | 12200  | 251 nt |
| 18   | 1046-1106 | 11400  | 239 nt |
| 19   | 1103-1165 | 11800  | 245 nt |
| 20   | 1162-1224 | 11800  | 245 nt |
| 21   | 1221-1283 | 11800  | 245 nt |
| 22   | 1280-1356 | 14600  | 287 nt |
| 23   | 1353-1427 | 14200  | 281 nt |
| 24   | 1424-1494 | 13400  | 269 nt |
| 25   | 1491-1557 | 12600  | 257 nt |
| 26   | 1554-1630 | 14600  | 287 nt |
| 27   | 1627-1694 | 12800  | 260 nt |
| 28   | 1691-1755 | 12200  | 251 nt |
| 29   | 1752-1814 | 11800  | 245 nt |
| 30   | 1811-1863 | 9800   | 215 nt |
| 31   | 1860-1902 | 7800   | 185 nt |

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
| Total barcodes    | 379600                             |
| Unique barcodes   | 379600                             |
| GC content range  | 25% - 75%                          |
| GC content mean   | 48.3%                              |
| Hamming guarantee | 100% cross-variant (prefix d >= 3) |

## 5. QC Summary

**Overall:** ISSUES FOUND

| Check                  | Description                                              | Result | Detail                                                                          |
| ---------------------- | -------------------------------------------------------- | ------ | ------------------------------------------------------------------------------- |
| oligo_lengths          | All oligos within synthesis length limit                 | PASS   | Range: 167-290 nt (limit: 300)                                                  |
| block_lengths          | All gene blocks within synthesis length limit            | PASS   | Range: 117-1794 nt (limit: 1800)                                                |
| barcode_junction_sites | No enzyme sites at barcode-context junctions             | PASS   | 0 barcode(s) with junction enzyme sites (left='CACACC', right='TTCCTG')         |
| barcode_uniqueness     | All barcodes are unique                                  | PASS   | 379600 unique / 379600 total                                                    |
| tile_coverage          | Tiles cover entire gene without gaps                     | PASS   | 5706 / 5706 nt covered                                                          |
| variant_count          | Expected number of variants generated                    | FAIL   | 37960 unique variants (expected: 38000 = 1900 mutable positions x 20 mutations) |
| single_codon_change    | Each variant differs by exactly one codon from WT        | PASS   | 379600 / 379600 variants confirmed                                              |
| oligo_gc_content       | Oligo GC content within reasonable range (25-75%)        | PASS   | GC range: 33.1-53% | 0 oligo(s) with extreme GC                                 |
| domestication_complete | Gene domesticated for all 3 enzymes (BsaI, BsmBI, PaqCI) | PASS   | No enzyme sites in gene                                                         |
| overhang_fidelity      | Tile boundary overhangs have adequate fidelity           | FAIL   | 23 tile(s) with low-fidelity boundary overhangs (<0.80)                         |
| tile_manifests         | Per-tile assembly manifests complete                     | PASS   | 31 tile manifest(s) generated                                                   |
| helper_plasmid         | Helper plasmid free of unintended BsmBI sites            | PASS   | OK                                                                              |
| reaction_fidelity      | Per-reaction set-level overhang fidelity                 | PASS   | Min set fidelity: 0.9593 across 62 reactions | 0 reaction(s) below 0.90         |
| barcode_poliii_term    | No barcodes contain PolIII terminator signal (TTTT)      | PASS   | 0 / 379600 barcode(s) contain TTTT                                              |
| block_min_length       | All gene blocks above synthesis minimum length           | FAIL   | 6 block(s) below 300 nt minimum. Range: 117-1794 nt                             |

## 6. Fixed Overhangs & Helper Plasmid

These overhangs are the same across all tile reactions:

| Overhang    | Sequence | Role                                                    | In HF Set |
| ----------- | -------- | ------------------------------------------------------- | --------- |
| oh_L        | ATGG     | Gene start (BsaI, all tiles)                            | No        |
| oh3         | CACC     | Downstream cassette-barcode junction (BsmBI, all tiles) | No        |
| oh4         | TTCC     | Barcode-helper junction (BsaI, all tiles)               | No        |
| paqci_star2 | AATG     | PaqCI 5' end of insert (Level 2)                        | --        |
| paqci_star1 | GCTA     | PaqCI 3' end of insert (Level 2)                        | --        |

### Helper Plasmid Insert

The helper plasmid provides the backbone for each BsaI Level 1 reaction.

```
[PaqCI**]--[BsaI>>ATGG]--STUFFER--[TTCC<<BsaI]--[PaqCI*]
```

Insert length: 72 nt
oh_L = ATGG (first 4 nt of gene)
oh_R = TTCC (= oh4, barcode-helper junction)

## 7. Per-Tile Assembly Guide

### Tile 1 of 31 -- Codons 1-37 (111 nt)

**Boundary overhangs:**

| Position          | Sequence | In HF Set | Fidelity |
| ----------------- | -------- | --------- | -------- |
| oh1 (5' boundary) | ATGG     | No        | 0.5393   |
| oh2 (3' boundary) | ACTA     | No        | 0.7946   |

**Variants:** 6600 mutations, 6600 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name                          | Length | 5' OH | 3' OH |
| --- | --------------- | ---------------------------------- | ------ | ----- | ----- |
| 1   | 5'WT gene block | (none -- tile starts at gene nt 1) | --     | --    | --    |
| 2   | Oligo pool      | Tile 1 (6600 oligos)               | 167 nt | ATGG  | TTCC  |
| 3   | Helper plasmid  | helper_plasmid_insert              | --     | --    | --    |
| 4   | Enzyme + buffer | BsaI-HFv2 + CutSmart               | --     | --    | --    |

```
  [ATGG]----oligo+BC----[TTCC]
   ATGG                  TTCC 
   (--)                  (--) 
```

**Set fidelity:** 0.9999 (2 overhangs, 0 in HF set)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------ | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)      | --      | --    | --    |
| 2   | 3'WT block        | bsmbi_3wt_tile1_sub1     | 1524 nt | ACTA  | ATCT  |
| 3   | 3'WT block        | bsmbi_3wt_tile1_sub2     | 1719 nt | ATCT  | TCTA  |
| 4   | 3'WT block        | bsmbi_3wt_tile1_sub3     | 1782 nt | TCTA  | GACA  |
| 5   | 3'WT+PolIII block | bsmbi_3wt_tile1_sub4     | 1736 nt | GACA  | CACC  |
| 6   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1 | --      | --    | --    |

```
  [ACTA]----3'WT sub1----[ATCT]----3'WT sub2----[TCTA]----3'WT sub3----[GACA]----3'WT+PolIII sub4----[CACC]
   ACTA                   ATCT                   TCTA                   GACA                          CACC 
   (--)                   (--)                   (--)                   (HF)                          (--) 
```

**Set fidelity:** 0.9917 (5 overhangs, 1 in HF set)

---

### Tile 2 of 31 -- Codons 34-105 (216 nt)

**Boundary overhangs:**

| Position          | Sequence | In HF Set | Fidelity |
| ----------------- | -------- | --------- | -------- |
| oh1 (5' boundary) | CAGA     | No        | 0.8175   |
| oh2 (3' boundary) | AAAT     | No        | 0.7737   |

**Variants:** 13600 mutations, 13600 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name             | Length | 5' OH | 3' OH |
| --- | --------------- | --------------------- | ------ | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile2        | 117 nt | ATGG  | CAGA  |
| 2   | Oligo pool      | Tile 2 (13600 oligos) | 272 nt | CAGA  | TTCC  |
| 3   | Helper plasmid  | helper_plasmid_insert | --     | --    | --    |
| 4   | Enzyme + buffer | BsaI-HFv2 + CutSmart  | --     | --    | --    |

```
  [ATGG]----5'WT block----[CAGA]----oligo+BC----[TTCC]
   ATGG                    CAGA                  TTCC 
   (--)                    (--)                  (--) 
```

**Set fidelity:** 0.9991 (3 overhangs, 0 in HF set)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------ | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)      | --      | --    | --    |
| 2   | 3'WT block        | bsmbi_3wt_tile2_sub1     | 1320 nt | AAAT  | ATCT  |
| 3   | 3'WT block        | bsmbi_3wt_tile1_sub2     | 1719 nt | ATCT  | TCTA  |
| 4   | 3'WT block        | bsmbi_3wt_tile1_sub3     | 1782 nt | TCTA  | GACA  |
| 5   | 3'WT+PolIII block | bsmbi_3wt_tile1_sub4     | 1736 nt | GACA  | CACC  |
| 6   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1 | --      | --    | --    |

```
  [AAAT]----3'WT sub1----[ATCT]----3'WT sub2----[TCTA]----3'WT sub3----[GACA]----3'WT+PolIII sub4----[CACC]
   AAAT                   ATCT                   TCTA                   GACA                          CACC 
   (--)                   (--)                   (--)                   (HF)                          (--) 
```

**Set fidelity:** 0.9700 (5 overhangs, 1 in HF set)

---

### Tile 3 of 31 -- Codons 102-162 (183 nt)

**Boundary overhangs:**

| Position          | Sequence | In HF Set | Fidelity |
| ----------------- | -------- | --------- | -------- |
| oh1 (5' boundary) | AAGA     | No        | 0.9209   |
| oh2 (3' boundary) | TCAG     | No        | 0.7814   |

**Variants:** 11400 mutations, 11400 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name             | Length | 5' OH | 3' OH |
| --- | --------------- | --------------------- | ------ | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile3        | 321 nt | ATGG  | AAGA  |
| 2   | Oligo pool      | Tile 3 (11400 oligos) | 239 nt | AAGA  | TTCC  |
| 3   | Helper plasmid  | helper_plasmid_insert | --     | --    | --    |
| 4   | Enzyme + buffer | BsaI-HFv2 + CutSmart  | --     | --    | --    |

```
  [ATGG]----5'WT block----[AAGA]----oligo+BC----[TTCC]
   ATGG                    AAGA                  TTCC 
   (--)                    (--)                  (--) 
```

**Set fidelity:** 0.9997 (3 overhangs, 0 in HF set)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------ | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)      | --      | --    | --    |
| 2   | 3'WT block        | bsmbi_3wt_tile3_sub1     | 1149 nt | TCAG  | ATCT  |
| 3   | 3'WT block        | bsmbi_3wt_tile1_sub2     | 1719 nt | ATCT  | TCTA  |
| 4   | 3'WT block        | bsmbi_3wt_tile1_sub3     | 1782 nt | TCTA  | GACA  |
| 5   | 3'WT+PolIII block | bsmbi_3wt_tile1_sub4     | 1736 nt | GACA  | CACC  |
| 6   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1 | --      | --    | --    |

```
  [TCAG]----3'WT sub1----[ATCT]----3'WT sub2----[TCTA]----3'WT sub3----[GACA]----3'WT+PolIII sub4----[CACC]
   TCAG                   ATCT                   TCTA                   GACA                          CACC 
   (--)                   (--)                   (--)                   (HF)                          (--) 
```

**Set fidelity:** 0.9916 (5 overhangs, 1 in HF set)

---

### Tile 4 of 31 -- Codons 159-232 (222 nt)

**Boundary overhangs:**

| Position          | Sequence | In HF Set | Fidelity |
| ----------------- | -------- | --------- | -------- |
| oh1 (5' boundary) | TTCT     | No        | 0.8181   |
| oh2 (3' boundary) | TGAT     | No        | 0.6933   |

**Variants:** 14000 mutations, 14000 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name             | Length | 5' OH | 3' OH |
| --- | --------------- | --------------------- | ------ | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile4        | 492 nt | ATGG  | TTCT  |
| 2   | Oligo pool      | Tile 4 (14000 oligos) | 278 nt | TTCT  | TTCC  |
| 3   | Helper plasmid  | helper_plasmid_insert | --     | --    | --    |
| 4   | Enzyme + buffer | BsaI-HFv2 + CutSmart  | --     | --    | --    |

```
  [ATGG]----5'WT block----[TTCT]----oligo+BC----[TTCC]
   ATGG                    TTCT                  TTCC 
   (--)                    (--)                  (--) 
```

**Set fidelity:** 0.9993 (3 overhangs, 0 in HF set)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------ | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)      | --      | --    | --    |
| 2   | 3'WT block        | bsmbi_3wt_tile4_sub1     | 939 nt  | TGAT  | ATCT  |
| 3   | 3'WT block        | bsmbi_3wt_tile1_sub2     | 1719 nt | ATCT  | TCTA  |
| 4   | 3'WT block        | bsmbi_3wt_tile1_sub3     | 1782 nt | TCTA  | GACA  |
| 5   | 3'WT+PolIII block | bsmbi_3wt_tile1_sub4     | 1736 nt | GACA  | CACC  |
| 6   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1 | --      | --    | --    |

```
  [TGAT]----3'WT sub1----[ATCT]----3'WT sub2----[TCTA]----3'WT sub3----[GACA]----3'WT+PolIII sub4----[CACC]
   TGAT                   ATCT                   TCTA                   GACA                          CACC 
   (--)                   (--)                   (--)                   (HF)                          (--) 
```

**Set fidelity:** 0.9593 (5 overhangs, 1 in HF set)

---

### Tile 5 of 31 -- Codons 229-281 (159 nt)

**Boundary overhangs:**

| Position          | Sequence | In HF Set | Fidelity |
| ----------------- | -------- | --------- | -------- |
| oh1 (5' boundary) | GAAA     | No        | 0.8745   |
| oh2 (3' boundary) | TTTC     | No        | 0.8348   |

**Variants:** 9800 mutations, 9800 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name             | Length | 5' OH | 3' OH |
| --- | --------------- | --------------------- | ------ | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile5        | 702 nt | ATGG  | GAAA  |
| 2   | Oligo pool      | Tile 5 (9800 oligos)  | 215 nt | GAAA  | TTCC  |
| 3   | Helper plasmid  | helper_plasmid_insert | --     | --    | --    |
| 4   | Enzyme + buffer | BsaI-HFv2 + CutSmart  | --     | --    | --    |

```
  [ATGG]----5'WT block----[GAAA]----oligo+BC----[TTCC]
   ATGG                    GAAA                  TTCC 
   (--)                    (--)                  (--) 
```

**Set fidelity:** 0.9868 (3 overhangs, 0 in HF set)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------ | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)      | --      | --    | --    |
| 2   | 3'WT block        | bsmbi_3wt_tile5_sub1     | 792 nt  | TTTC  | ATCT  |
| 3   | 3'WT block        | bsmbi_3wt_tile1_sub2     | 1719 nt | ATCT  | TCTA  |
| 4   | 3'WT block        | bsmbi_3wt_tile1_sub3     | 1782 nt | TCTA  | GACA  |
| 5   | 3'WT+PolIII block | bsmbi_3wt_tile1_sub4     | 1736 nt | GACA  | CACC  |
| 6   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1 | --      | --    | --    |

```
  [TTTC]----3'WT sub1----[ATCT]----3'WT sub2----[TCTA]----3'WT sub3----[GACA]----3'WT+PolIII sub4----[CACC]
   TTTC                   ATCT                   TCTA                   GACA                          CACC 
   (--)                   (--)                   (--)                   (HF)                          (--) 
```

**Set fidelity:** 0.9649 (5 overhangs, 1 in HF set)

---

### Tile 6 of 31 -- Codons 278-355 (234 nt)

**Boundary overhangs:**

| Position          | Sequence | In HF Set | Fidelity |
| ----------------- | -------- | --------- | -------- |
| oh1 (5' boundary) | CAAA     | No        | 0.8948   |
| oh2 (3' boundary) | ATTT     | No        | 0.7664   |

**Variants:** 14800 mutations, 14800 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name             | Length | 5' OH | 3' OH |
| --- | --------------- | --------------------- | ------ | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile6        | 849 nt | ATGG  | CAAA  |
| 2   | Oligo pool      | Tile 6 (14800 oligos) | 290 nt | CAAA  | TTCC  |
| 3   | Helper plasmid  | helper_plasmid_insert | --     | --    | --    |
| 4   | Enzyme + buffer | BsaI-HFv2 + CutSmart  | --     | --    | --    |

```
  [ATGG]----5'WT block----[CAAA]----oligo+BC----[TTCC]
   ATGG                    CAAA                  TTCC 
   (--)                    (--)                  (--) 
```

**Set fidelity:** 0.9947 (3 overhangs, 0 in HF set)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------ | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)      | --      | --    | --    |
| 2   | 3'WT block        | bsmbi_3wt_tile6_sub1     | 570 nt  | ATTT  | ATCT  |
| 3   | 3'WT block        | bsmbi_3wt_tile1_sub2     | 1719 nt | ATCT  | TCTA  |
| 4   | 3'WT block        | bsmbi_3wt_tile1_sub3     | 1782 nt | TCTA  | GACA  |
| 5   | 3'WT+PolIII block | bsmbi_3wt_tile1_sub4     | 1736 nt | GACA  | CACC  |
| 6   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1 | --      | --    | --    |

```
  [ATTT]----3'WT sub1----[ATCT]----3'WT sub2----[TCTA]----3'WT sub3----[GACA]----3'WT+PolIII sub4----[CACC]
   ATTT                   ATCT                   TCTA                   GACA                          CACC 
   (--)                   (--)                   (--)                   (HF)                          (--) 
```

**Set fidelity:** 0.9890 (5 overhangs, 1 in HF set)

---

### Tile 7 of 31 -- Codons 352-416 (195 nt)

**Boundary overhangs:**

| Position          | Sequence | In HF Set | Fidelity |
| ----------------- | -------- | --------- | -------- |
| oh1 (5' boundary) | GTAA     | Yes       | 0.8029   |
| oh2 (3' boundary) | AACT     | No        | 0.6635   |

**Variants:** 12200 mutations, 12200 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name             | Length  | 5' OH | 3' OH |
| --- | --------------- | --------------------- | ------- | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile7        | 1071 nt | ATGG  | GTAA  |
| 2   | Oligo pool      | Tile 7 (12200 oligos) | 251 nt  | GTAA  | TTCC  |
| 3   | Helper plasmid  | helper_plasmid_insert | --      | --    | --    |
| 4   | Enzyme + buffer | BsaI-HFv2 + CutSmart  | --      | --    | --    |

```
  [ATGG]----5'WT block----[GTAA]----oligo+BC----[TTCC]
   ATGG                    GTAA                  TTCC 
   (--)                    (HF)                  (--) 
```

**Set fidelity:** 0.9834 (3 overhangs, 1 in HF set)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------ | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)      | --      | --    | --    |
| 2   | 3'WT block        | bsmbi_3wt_tile7_sub1     | 387 nt  | AACT  | ATCT  |
| 3   | 3'WT block        | bsmbi_3wt_tile1_sub2     | 1719 nt | ATCT  | TCTA  |
| 4   | 3'WT block        | bsmbi_3wt_tile1_sub3     | 1782 nt | TCTA  | GACA  |
| 5   | 3'WT+PolIII block | bsmbi_3wt_tile1_sub4     | 1736 nt | GACA  | CACC  |
| 6   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1 | --      | --    | --    |

```
  [AACT]----3'WT sub1----[ATCT]----3'WT sub2----[TCTA]----3'WT sub3----[GACA]----3'WT+PolIII sub4----[CACC]
   AACT                   ATCT                   TCTA                   GACA                          CACC 
   (--)                   (--)                   (--)                   (HF)                          (--) 
```

**Set fidelity:** 0.9891 (5 overhangs, 1 in HF set)

---

### Tile 8 of 31 -- Codons 413-480 (204 nt)

**Boundary overhangs:**

| Position          | Sequence | In HF Set | Fidelity |
| ----------------- | -------- | --------- | -------- |
| oh1 (5' boundary) | AGAA     | No        | 0.8847   |
| oh2 (3' boundary) | AAAT     | No        | 0.7737   |

**Variants:** 12800 mutations, 12800 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name             | Length  | 5' OH | 3' OH |
| --- | --------------- | --------------------- | ------- | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile8        | 1254 nt | ATGG  | AGAA  |
| 2   | Oligo pool      | Tile 8 (12800 oligos) | 260 nt  | AGAA  | TTCC  |
| 3   | Helper plasmid  | helper_plasmid_insert | --      | --    | --    |
| 4   | Enzyme + buffer | BsaI-HFv2 + CutSmart  | --      | --    | --    |

```
  [ATGG]----5'WT block----[AGAA]----oligo+BC----[TTCC]
   ATGG                    AGAA                  TTCC 
   (--)                    (--)                  (--) 
```

**Set fidelity:** 0.9870 (3 overhangs, 0 in HF set)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------ | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)      | --      | --    | --    |
| 2   | 3'WT block        | bsmbi_3wt_tile8_sub1     | 195 nt  | AAAT  | ATCT  |
| 3   | 3'WT block        | bsmbi_3wt_tile1_sub2     | 1719 nt | ATCT  | TCTA  |
| 4   | 3'WT block        | bsmbi_3wt_tile1_sub3     | 1782 nt | TCTA  | GACA  |
| 5   | 3'WT+PolIII block | bsmbi_3wt_tile1_sub4     | 1736 nt | GACA  | CACC  |
| 6   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1 | --      | --    | --    |

```
  [AAAT]----3'WT sub1----[ATCT]----3'WT sub2----[TCTA]----3'WT sub3----[GACA]----3'WT+PolIII sub4----[CACC]
   AAAT                   ATCT                   TCTA                   GACA                          CACC 
   (--)                   (--)                   (--)                   (HF)                          (--) 
```

**Set fidelity:** 0.9700 (5 overhangs, 1 in HF set)

---

### Tile 9 of 31 -- Codons 477-539 (189 nt)

**Boundary overhangs:**

| Position          | Sequence | In HF Set | Fidelity |
| ----------------- | -------- | --------- | -------- |
| oh1 (5' boundary) | ATTC     | No        | 0.7084   |
| oh2 (3' boundary) | ATCT     | No        | 0.7151   |

**Variants:** 11800 mutations, 11800 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name             | Length  | 5' OH | 3' OH |
| --- | --------------- | --------------------- | ------- | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile9        | 1446 nt | ATGG  | ATTC  |
| 2   | Oligo pool      | Tile 9 (11800 oligos) | 245 nt  | ATTC  | TTCC  |
| 3   | Helper plasmid  | helper_plasmid_insert | --      | --    | --    |
| 4   | Enzyme + buffer | BsaI-HFv2 + CutSmart  | --      | --    | --    |

```
  [ATGG]----5'WT block----[ATTC]----oligo+BC----[TTCC]
   ATGG                    ATTC                  TTCC 
   (--)                    (--)                  (--) 
```

**Set fidelity:** 0.9998 (3 overhangs, 0 in HF set)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------ | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)      | --      | --    | --    |
| 2   | 3'WT block        | bsmbi_3wt_tile1_sub2     | 1719 nt | ATCT  | TCTA  |
| 3   | 3'WT block        | bsmbi_3wt_tile1_sub3     | 1782 nt | TCTA  | GACA  |
| 4   | 3'WT+PolIII block | bsmbi_3wt_tile1_sub4     | 1736 nt | GACA  | CACC  |
| 5   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1 | --      | --    | --    |

```
  [ATCT]----3'WT sub1----[TCTA]----3'WT sub2----[GACA]----3'WT+PolIII sub3----[CACC]
   ATCT                   TCTA                   GACA                          CACC 
   (--)                   (--)                   (HF)                          (--) 
```

**Set fidelity:** 0.9939 (4 overhangs, 1 in HF set)

---

### Tile 10 of 31 -- Codons 536-596 (183 nt)

**Boundary overhangs:**

| Position          | Sequence | In HF Set | Fidelity |
| ----------------- | -------- | --------- | -------- |
| oh1 (5' boundary) | AAAA     | Yes       | 0.9502   |
| oh2 (3' boundary) | ATTT     | No        | 0.7664   |

**Variants:** 11400 mutations, 11400 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name              | Length  | 5' OH | 3' OH |
| --- | --------------- | ---------------------- | ------- | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile10        | 1623 nt | ATGG  | AAAA  |
| 2   | Oligo pool      | Tile 10 (11400 oligos) | 239 nt  | AAAA  | TTCC  |
| 3   | Helper plasmid  | helper_plasmid_insert  | --      | --    | --    |
| 4   | Enzyme + buffer | BsaI-HFv2 + CutSmart   | --      | --    | --    |

```
  [ATGG]----5'WT block----[AAAA]----oligo+BC----[TTCC]
   ATGG                    AAAA                  TTCC 
   (--)                    (HF)                  (--) 
```

**Set fidelity:** 0.9982 (3 overhangs, 1 in HF set)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------ | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)      | --      | --    | --    |
| 2   | 3'WT block        | bsmbi_3wt_tile10_sub1    | 1548 nt | ATTT  | TCTA  |
| 3   | 3'WT block        | bsmbi_3wt_tile1_sub3     | 1782 nt | TCTA  | GACA  |
| 4   | 3'WT+PolIII block | bsmbi_3wt_tile1_sub4     | 1736 nt | GACA  | CACC  |
| 5   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1 | --      | --    | --    |

```
  [ATTT]----3'WT sub1----[TCTA]----3'WT sub2----[GACA]----3'WT+PolIII sub3----[CACC]
   ATTT                   TCTA                   GACA                          CACC 
   (--)                   (--)                   (HF)                          (--) 
```

**Set fidelity:** 0.9925 (4 overhangs, 1 in HF set)

---

### Tile 11 of 31 -- Codons 593-668 (228 nt)

**Boundary overhangs:**

| Position          | Sequence | In HF Set | Fidelity |
| ----------------- | -------- | --------- | -------- |
| oh1 (5' boundary) | CAGA     | No        | 0.8175   |
| oh2 (3' boundary) | TCCT     | No        | 0.7573   |

**Variants:** 14400 mutations, 14400 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name              | Length  | 5' OH | 3' OH |
| --- | --------------- | ---------------------- | ------- | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile11_sub1   | 1794 nt | ATGG  | CAGA  |
| 2   | Oligo pool      | Tile 11 (14400 oligos) | 284 nt  | CAGA  | TTCC  |
| 3   | Helper plasmid  | helper_plasmid_insert  | --      | --    | --    |
| 4   | Enzyme + buffer | BsaI-HFv2 + CutSmart   | --      | --    | --    |

```
  [ATGG]----5'WT sub1----[ATCT]----oligo+BC----[CAGA][TTCC]
   ATGG                   ATCT                  CAGA  TTCC 
   (--)                   (--)                  (--)  (--) 
```

**Set fidelity:** 0.9983 (4 overhangs, 0 in HF set)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------ | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)      | --      | --    | --    |
| 2   | 3'WT block        | bsmbi_3wt_tile11_sub1    | 1332 nt | TCCT  | TCTA  |
| 3   | 3'WT block        | bsmbi_3wt_tile1_sub3     | 1782 nt | TCTA  | GACA  |
| 4   | 3'WT+PolIII block | bsmbi_3wt_tile1_sub4     | 1736 nt | GACA  | CACC  |
| 5   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1 | --      | --    | --    |

```
  [TCCT]----3'WT sub1----[TCTA]----3'WT sub2----[GACA]----3'WT+PolIII sub3----[CACC]
   TCCT                   TCTA                   GACA                          CACC 
   (--)                   (--)                   (HF)                          (--) 
```

**Set fidelity:** 0.9932 (4 overhangs, 1 in HF set)

---

### Tile 12 of 31 -- Codons 665-724 (180 nt)

**Boundary overhangs:**

| Position          | Sequence | In HF Set | Fidelity |
| ----------------- | -------- | --------- | -------- |
| oh1 (5' boundary) | TTTT     | No        | 0.8623   |
| oh2 (3' boundary) | TAAT     | No        | 0.8165   |

**Variants:** 11200 mutations, 11200 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name              | Length  | 5' OH | 3' OH |
| --- | --------------- | ---------------------- | ------- | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile12_sub1   | 1631 nt | ATGG  | ATCT  |
| 2   | 5'WT gene block | bsai_5wt_tile12_sub2   | 397 nt  | ATCT  | TTTT  |
| 3   | Oligo pool      | Tile 12 (11200 oligos) | 236 nt  | TTTT  | TTCC  |
| 4   | Helper plasmid  | helper_plasmid_insert  | --      | --    | --    |
| 5   | Enzyme + buffer | BsaI-HFv2 + CutSmart   | --      | --    | --    |

```
  [ATGG]----5'WT sub1----[ATCT]----5'WT sub2----[TTTT]----oligo+BC----[TTCC]
   ATGG                   ATCT                   TTTT                  TTCC 
   (--)                   (--)                   (--)                  (--) 
```

**Set fidelity:** 0.9983 (4 overhangs, 0 in HF set)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------ | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)      | --      | --    | --    |
| 2   | 3'WT block        | bsmbi_3wt_tile12_sub1    | 1164 nt | TAAT  | TCTA  |
| 3   | 3'WT block        | bsmbi_3wt_tile1_sub3     | 1782 nt | TCTA  | GACA  |
| 4   | 3'WT+PolIII block | bsmbi_3wt_tile1_sub4     | 1736 nt | GACA  | CACC  |
| 5   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1 | --      | --    | --    |

```
  [TAAT]----3'WT sub1----[TCTA]----3'WT sub2----[GACA]----3'WT+PolIII sub3----[CACC]
   TAAT                   TCTA                   GACA                          CACC 
   (--)                   (--)                   (HF)                          (--) 
```

**Set fidelity:** 0.9919 (4 overhangs, 1 in HF set)

---

### Tile 13 of 31 -- Codons 721-797 (231 nt)

**Boundary overhangs:**

| Position          | Sequence | In HF Set | Fidelity |
| ----------------- | -------- | --------- | -------- |
| oh1 (5' boundary) | TCTA     | No        | 0.8892   |
| oh2 (3' boundary) | TACT     | No        | 0.7445   |

**Variants:** 14600 mutations, 14600 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name              | Length  | 5' OH | 3' OH |
| --- | --------------- | ---------------------- | ------- | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile12_sub1   | 1631 nt | ATGG  | ATCT  |
| 2   | 5'WT gene block | bsai_5wt_tile13_sub2   | 565 nt  | ATCT  | TCTA  |
| 3   | Oligo pool      | Tile 13 (14600 oligos) | 287 nt  | TCTA  | TTCC  |
| 4   | Helper plasmid  | helper_plasmid_insert  | --      | --    | --    |
| 5   | Enzyme + buffer | BsaI-HFv2 + CutSmart   | --      | --    | --    |

```
  [ATGG]----5'WT sub1----[ATCT]----5'WT sub2----[TCTA]----oligo+BC----[TTCC]
   ATGG                   ATCT                   TCTA                  TTCC 
   (--)                   (--)                   (--)                  (--) 
```

**Set fidelity:** 0.9984 (4 overhangs, 0 in HF set)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------ | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)      | --      | --    | --    |
| 2   | 3'WT block        | bsmbi_3wt_tile13_sub1    | 945 nt  | TACT  | TCTA  |
| 3   | 3'WT block        | bsmbi_3wt_tile1_sub3     | 1782 nt | TCTA  | GACA  |
| 4   | 3'WT+PolIII block | bsmbi_3wt_tile1_sub4     | 1736 nt | GACA  | CACC  |
| 5   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1 | --      | --    | --    |

```
  [TACT]----3'WT sub1----[TCTA]----3'WT sub2----[GACA]----3'WT+PolIII sub3----[CACC]
   TACT                   TCTA                   GACA                          CACC 
   (--)                   (--)                   (HF)                          (--) 
```

**Set fidelity:** 0.9913 (4 overhangs, 1 in HF set)

---

### Tile 14 of 31 -- Codons 794-867 (222 nt)

**Boundary overhangs:**

| Position          | Sequence | In HF Set | Fidelity |
| ----------------- | -------- | --------- | -------- |
| oh1 (5' boundary) | ATTT     | No        | 0.7664   |
| oh2 (3' boundary) | AAAT     | No        | 0.7737   |

**Variants:** 14000 mutations, 14000 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name              | Length  | 5' OH | 3' OH |
| --- | --------------- | ---------------------- | ------- | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile12_sub1   | 1631 nt | ATGG  | ATCT  |
| 2   | 5'WT gene block | bsai_5wt_tile14_sub2   | 784 nt  | ATCT  | ATTT  |
| 3   | Oligo pool      | Tile 14 (14000 oligos) | 278 nt  | ATTT  | TTCC  |
| 4   | Helper plasmid  | helper_plasmid_insert  | --      | --    | --    |
| 5   | Enzyme + buffer | BsaI-HFv2 + CutSmart   | --      | --    | --    |

```
  [ATGG]----5'WT sub1----[ATCT]----5'WT sub2----[ATTT]----oligo+BC----[TTCC]
   ATGG                   ATCT                   ATTT                  TTCC 
   (--)                   (--)                   (--)                  (--) 
```

**Set fidelity:** 0.9953 (4 overhangs, 0 in HF set)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------ | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)      | --      | --    | --    |
| 2   | 3'WT block        | bsmbi_3wt_tile14_sub1    | 735 nt  | AAAT  | TCTA  |
| 3   | 3'WT block        | bsmbi_3wt_tile1_sub3     | 1782 nt | TCTA  | GACA  |
| 4   | 3'WT+PolIII block | bsmbi_3wt_tile1_sub4     | 1736 nt | GACA  | CACC  |
| 5   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1 | --      | --    | --    |

```
  [AAAT]----3'WT sub1----[TCTA]----3'WT sub2----[GACA]----3'WT+PolIII sub3----[CACC]
   AAAT                   TCTA                   GACA                          CACC 
   (--)                   (--)                   (HF)                          (--) 
```

**Set fidelity:** 0.9937 (4 overhangs, 1 in HF set)

---

### Tile 15 of 31 -- Codons 864-917 (162 nt)

**Boundary overhangs:**

| Position          | Sequence | In HF Set | Fidelity |
| ----------------- | -------- | --------- | -------- |
| oh1 (5' boundary) | AAAT     | No        | 0.7737   |
| oh2 (3' boundary) | TCCA     | No        | 0.8519   |

**Variants:** 10000 mutations, 10000 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name              | Length  | 5' OH | 3' OH |
| --- | --------------- | ---------------------- | ------- | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile12_sub1   | 1631 nt | ATGG  | ATCT  |
| 2   | 5'WT gene block | bsai_5wt_tile15_sub2   | 994 nt  | ATCT  | AAAT  |
| 3   | Oligo pool      | Tile 15 (10000 oligos) | 218 nt  | AAAT  | TTCC  |
| 4   | Helper plasmid  | helper_plasmid_insert  | --      | --    | --    |
| 5   | Enzyme + buffer | BsaI-HFv2 + CutSmart   | --      | --    | --    |

```
  [ATGG]----5'WT sub1----[ATCT]----5'WT sub2----[AAAT]----oligo+BC----[TTCC]
   ATGG                   ATCT                   AAAT                  TTCC 
   (--)                   (--)                   (--)                  (--) 
```

**Set fidelity:** 0.9723 (4 overhangs, 0 in HF set)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------ | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)      | --      | --    | --    |
| 2   | 3'WT block        | bsmbi_3wt_tile15_sub1    | 585 nt  | TCCA  | TCTA  |
| 3   | 3'WT block        | bsmbi_3wt_tile1_sub3     | 1782 nt | TCTA  | GACA  |
| 4   | 3'WT+PolIII block | bsmbi_3wt_tile1_sub4     | 1736 nt | GACA  | CACC  |
| 5   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1 | --      | --    | --    |

```
  [TCCA]----3'WT sub1----[TCTA]----3'WT sub2----[GACA]----3'WT+PolIII sub3----[CACC]
   TCCA                   TCTA                   GACA                          CACC 
   (--)                   (--)                   (HF)                          (--) 
```

**Set fidelity:** 0.9922 (4 overhangs, 1 in HF set)

---

### Tile 16 of 31 -- Codons 914-988 (225 nt)

**Boundary overhangs:**

| Position          | Sequence | In HF Set | Fidelity |
| ----------------- | -------- | --------- | -------- |
| oh1 (5' boundary) | AAAA     | Yes       | 0.9502   |
| oh2 (3' boundary) | ATTT     | No        | 0.7664   |

**Variants:** 14200 mutations, 14200 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name              | Length  | 5' OH | 3' OH |
| --- | --------------- | ---------------------- | ------- | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile12_sub1   | 1631 nt | ATGG  | ATCT  |
| 2   | 5'WT gene block | bsai_5wt_tile16_sub2   | 1144 nt | ATCT  | AAAA  |
| 3   | Oligo pool      | Tile 16 (14200 oligos) | 281 nt  | AAAA  | TTCC  |
| 4   | Helper plasmid  | helper_plasmid_insert  | --      | --    | --    |
| 5   | Enzyme + buffer | BsaI-HFv2 + CutSmart   | --      | --    | --    |

```
  [ATGG]----5'WT sub1----[ATCT]----5'WT sub2----[AAAA]----oligo+BC----[TTCC]
   ATGG                   ATCT                   AAAA                  TTCC 
   (--)                   (--)                   (HF)                  (--) 
```

**Set fidelity:** 0.9955 (4 overhangs, 1 in HF set)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------ | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)      | --      | --    | --    |
| 2   | 3'WT block        | bsmbi_3wt_tile16_sub1    | 372 nt  | ATTT  | TCTA  |
| 3   | 3'WT block        | bsmbi_3wt_tile1_sub3     | 1782 nt | TCTA  | GACA  |
| 4   | 3'WT+PolIII block | bsmbi_3wt_tile1_sub4     | 1736 nt | GACA  | CACC  |
| 5   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1 | --      | --    | --    |

```
  [ATTT]----3'WT sub1----[TCTA]----3'WT sub2----[GACA]----3'WT+PolIII sub3----[CACC]
   ATTT                   TCTA                   GACA                          CACC 
   (--)                   (--)                   (HF)                          (--) 
```

**Set fidelity:** 0.9925 (4 overhangs, 1 in HF set)

---

### Tile 17 of 31 -- Codons 985-1049 (195 nt)

**Boundary overhangs:**

| Position          | Sequence | In HF Set | Fidelity |
| ----------------- | -------- | --------- | -------- |
| oh1 (5' boundary) | TCTC     | No        | 0.8105   |
| oh2 (3' boundary) | TAAC     | No        | 0.7715   |

**Variants:** 12200 mutations, 12200 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name              | Length  | 5' OH | 3' OH |
| --- | --------------- | ---------------------- | ------- | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile12_sub1   | 1631 nt | ATGG  | ATCT  |
| 2   | 5'WT gene block | bsai_5wt_tile17_sub2   | 1357 nt | ATCT  | TCTC  |
| 3   | Oligo pool      | Tile 17 (12200 oligos) | 251 nt  | TCTC  | TTCC  |
| 4   | Helper plasmid  | helper_plasmid_insert  | --      | --    | --    |
| 5   | Enzyme + buffer | BsaI-HFv2 + CutSmart   | --      | --    | --    |

```
  [ATGG]----5'WT sub1----[ATCT]----5'WT sub2----[TCTC]----oligo+BC----[TTCC]
   ATGG                   ATCT                   TCTC                  TTCC 
   (--)                   (--)                   (--)                  (--) 
```

**Set fidelity:** 0.9985 (4 overhangs, 0 in HF set)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------ | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)      | --      | --    | --    |
| 2   | 3'WT block        | bsmbi_3wt_tile17_sub1    | 189 nt  | TAAC  | TCTA  |
| 3   | 3'WT block        | bsmbi_3wt_tile1_sub3     | 1782 nt | TCTA  | GACA  |
| 4   | 3'WT+PolIII block | bsmbi_3wt_tile1_sub4     | 1736 nt | GACA  | CACC  |
| 5   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1 | --      | --    | --    |

```
  [TAAC]----3'WT sub1----[TCTA]----3'WT sub2----[GACA]----3'WT+PolIII sub3----[CACC]
   TAAC                   TCTA                   GACA                          CACC 
   (--)                   (--)                   (HF)                          (--) 
```

**Set fidelity:** 0.9878 (4 overhangs, 1 in HF set)

---

### Tile 18 of 31 -- Codons 1046-1106 (183 nt)

**Boundary overhangs:**

| Position          | Sequence | In HF Set | Fidelity |
| ----------------- | -------- | --------- | -------- |
| oh1 (5' boundary) | AAAA     | Yes       | 0.9502   |
| oh2 (3' boundary) | TCTA     | No        | 0.8892   |

**Variants:** 11400 mutations, 11400 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name              | Length  | 5' OH | 3' OH |
| --- | --------------- | ---------------------- | ------- | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile12_sub1   | 1631 nt | ATGG  | ATCT  |
| 2   | 5'WT gene block | bsai_5wt_tile18_sub2   | 1540 nt | ATCT  | AAAA  |
| 3   | Oligo pool      | Tile 18 (11400 oligos) | 239 nt  | AAAA  | TTCC  |
| 4   | Helper plasmid  | helper_plasmid_insert  | --      | --    | --    |
| 5   | Enzyme + buffer | BsaI-HFv2 + CutSmart   | --      | --    | --    |

```
  [ATGG]----5'WT sub1----[ATCT]----5'WT sub2----[AAAA]----oligo+BC----[TTCC]
   ATGG                   ATCT                   AAAA                  TTCC 
   (--)                   (--)                   (HF)                  (--) 
```

**Set fidelity:** 0.9955 (4 overhangs, 1 in HF set)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------ | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)      | --      | --    | --    |
| 2   | 3'WT block        | bsmbi_3wt_tile1_sub3     | 1782 nt | TCTA  | GACA  |
| 3   | 3'WT+PolIII block | bsmbi_3wt_tile1_sub4     | 1736 nt | GACA  | CACC  |
| 4   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1 | --      | --    | --    |

```
  [TCTA]----3'WT sub1----[GACA]----3'WT+PolIII sub2----[CACC]
   TCTA                   GACA                          CACC 
   (--)                   (HF)                          (--) 
```

**Set fidelity:** 0.9942 (3 overhangs, 1 in HF set)

---

### Tile 19 of 31 -- Codons 1103-1165 (189 nt)

**Boundary overhangs:**

| Position          | Sequence | In HF Set | Fidelity |
| ----------------- | -------- | --------- | -------- |
| oh1 (5' boundary) | TCAA     | No        | 0.9425   |
| oh2 (3' boundary) | GAAA     | No        | 0.8745   |

**Variants:** 11800 mutations, 11800 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name              | Length  | 5' OH | 3' OH |
| --- | --------------- | ---------------------- | ------- | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile12_sub1   | 1631 nt | ATGG  | ATCT  |
| 2   | 5'WT gene block | bsai_5wt_tile19_sub2   | 1711 nt | ATCT  | TCAA  |
| 3   | Oligo pool      | Tile 19 (11800 oligos) | 245 nt  | TCAA  | TTCC  |
| 4   | Helper plasmid  | helper_plasmid_insert  | --      | --    | --    |
| 5   | Enzyme + buffer | BsaI-HFv2 + CutSmart   | --      | --    | --    |

```
  [ATGG]----5'WT sub1----[ATCT]----5'WT sub2----[TCAA]----oligo+BC----[TTCC]
   ATGG                   ATCT                   TCAA                  TTCC 
   (--)                   (--)                   (--)                  (--) 
```

**Set fidelity:** 0.9939 (4 overhangs, 0 in HF set)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------ | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)      | --      | --    | --    |
| 2   | 3'WT block        | bsmbi_3wt_tile19_sub1    | 1605 nt | GAAA  | GACA  |
| 3   | 3'WT+PolIII block | bsmbi_3wt_tile1_sub4     | 1736 nt | GACA  | CACC  |
| 4   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1 | --      | --    | --    |

```
  [GAAA]----3'WT sub1----[GACA]----3'WT+PolIII sub2----[CACC]
   GAAA                   GACA                          CACC 
   (--)                   (HF)                          (--) 
```

**Set fidelity:** 0.9977 (3 overhangs, 1 in HF set)

---

### Tile 20 of 31 -- Codons 1162-1224 (189 nt)

**Boundary overhangs:**

| Position          | Sequence | In HF Set | Fidelity |
| ----------------- | -------- | --------- | -------- |
| oh1 (5' boundary) | TTCA     | No        | 0.8824   |
| oh2 (3' boundary) | TCAA     | No        | 0.9425   |

**Variants:** 11800 mutations, 11800 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name              | Length  | 5' OH | 3' OH |
| --- | --------------- | ---------------------- | ------- | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile12_sub1   | 1631 nt | ATGG  | ATCT  |
| 2   | 5'WT gene block | bsai_5wt_tile20_sub2   | 1719 nt | ATCT  | TCTA  |
| 3   | 5'WT gene block | bsai_5wt_tile20_sub3   | 187 nt  | TCTA  | TTCA  |
| 4   | Oligo pool      | Tile 20 (11800 oligos) | 245 nt  | TTCA  | TTCC  |
| 5   | Helper plasmid  | helper_plasmid_insert  | --      | --    | --    |
| 6   | Enzyme + buffer | BsaI-HFv2 + CutSmart   | --      | --    | --    |

```
  [ATGG]----5'WT sub1----[ATCT]----5'WT sub2----[TCTA]----5'WT sub3----[TTCA]----oligo+BC----[TTCC]
   ATGG                   ATCT                   TCTA                   TTCA                  TTCC 
   (--)                   (--)                   (--)                   (--)                  (--) 
```

**Set fidelity:** 0.9970 (5 overhangs, 0 in HF set)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------ | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)      | --      | --    | --    |
| 2   | 3'WT block        | bsmbi_3wt_tile20_sub1    | 1428 nt | TCAA  | GACA  |
| 3   | 3'WT+PolIII block | bsmbi_3wt_tile1_sub4     | 1736 nt | GACA  | CACC  |
| 4   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1 | --      | --    | --    |

```
  [TCAA]----3'WT sub1----[GACA]----3'WT+PolIII sub2----[CACC]
   TCAA                   GACA                          CACC 
   (--)                   (HF)                          (--) 
```

**Set fidelity:** 0.9982 (3 overhangs, 1 in HF set)

---

### Tile 21 of 31 -- Codons 1221-1283 (189 nt)

**Boundary overhangs:**

| Position          | Sequence | In HF Set | Fidelity |
| ----------------- | -------- | --------- | -------- |
| oh1 (5' boundary) | AAAA     | Yes       | 0.9502   |
| oh2 (3' boundary) | TTTC     | No        | 0.8348   |

**Variants:** 11800 mutations, 11800 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name              | Length  | 5' OH | 3' OH |
| --- | --------------- | ---------------------- | ------- | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile12_sub1   | 1631 nt | ATGG  | ATCT  |
| 2   | 5'WT gene block | bsai_5wt_tile20_sub2   | 1719 nt | ATCT  | TCTA  |
| 3   | 5'WT gene block | bsai_5wt_tile21_sub3   | 364 nt  | TCTA  | AAAA  |
| 4   | Oligo pool      | Tile 21 (11800 oligos) | 245 nt  | AAAA  | TTCC  |
| 5   | Helper plasmid  | helper_plasmid_insert  | --      | --    | --    |
| 6   | Enzyme + buffer | BsaI-HFv2 + CutSmart   | --      | --    | --    |

```
  [ATGG]----5'WT sub1----[ATCT]----5'WT sub2----[TCTA]----5'WT sub3----[AAAA]----oligo+BC----[TTCC]
   ATGG                   ATCT                   TCTA                   AAAA                  TTCC 
   (--)                   (--)                   (--)                   (HF)                  (--) 
```

**Set fidelity:** 0.9939 (5 overhangs, 1 in HF set)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------ | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)      | --      | --    | --    |
| 2   | 3'WT block        | bsmbi_3wt_tile21_sub1    | 1251 nt | TTTC  | GACA  |
| 3   | 3'WT+PolIII block | bsmbi_3wt_tile1_sub4     | 1736 nt | GACA  | CACC  |
| 4   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1 | --      | --    | --    |

```
  [TTTC]----3'WT sub1----[GACA]----3'WT+PolIII sub2----[CACC]
   TTTC                   GACA                          CACC 
   (--)                   (HF)                          (--) 
```

**Set fidelity:** 0.9697 (3 overhangs, 1 in HF set)

---

### Tile 22 of 31 -- Codons 1280-1356 (231 nt)

**Boundary overhangs:**

| Position          | Sequence | In HF Set | Fidelity |
| ----------------- | -------- | --------- | -------- |
| oh1 (5' boundary) | TGTA     | No        | 0.7693   |
| oh2 (3' boundary) | GGAA     | No        | 0.7463   |

**Variants:** 14600 mutations, 14600 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name              | Length  | 5' OH | 3' OH |
| --- | --------------- | ---------------------- | ------- | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile12_sub1   | 1631 nt | ATGG  | ATCT  |
| 2   | 5'WT gene block | bsai_5wt_tile20_sub2   | 1719 nt | ATCT  | TCTA  |
| 3   | 5'WT gene block | bsai_5wt_tile22_sub3   | 541 nt  | TCTA  | TGTA  |
| 4   | Oligo pool      | Tile 22 (14600 oligos) | 287 nt  | TGTA  | TTCC  |
| 5   | Helper plasmid  | helper_plasmid_insert  | --      | --    | --    |
| 6   | Enzyme + buffer | BsaI-HFv2 + CutSmart   | --      | --    | --    |

```
  [ATGG]----5'WT sub1----[ATCT]----5'WT sub2----[TCTA]----5'WT sub3----[TGTA]----oligo+BC----[TTCC]
   ATGG                   ATCT                   TCTA                   TGTA                  TTCC 
   (--)                   (--)                   (--)                   (--)                  (--) 
```

**Set fidelity:** 0.9937 (5 overhangs, 0 in HF set)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------ | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)      | --      | --    | --    |
| 2   | 3'WT block        | bsmbi_3wt_tile22_sub1    | 1032 nt | GGAA  | GACA  |
| 3   | 3'WT+PolIII block | bsmbi_3wt_tile1_sub4     | 1736 nt | GACA  | CACC  |
| 4   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1 | --      | --    | --    |

```
  [GGAA]----3'WT sub1----[GACA]----3'WT+PolIII sub2----[CACC]
   GGAA                   GACA                          CACC 
   (--)                   (HF)                          (--) 
```

**Set fidelity:** 0.9900 (3 overhangs, 1 in HF set)

---

### Tile 23 of 31 -- Codons 1353-1427 (225 nt)

**Boundary overhangs:**

| Position          | Sequence | In HF Set | Fidelity |
| ----------------- | -------- | --------- | -------- |
| oh1 (5' boundary) | CTAA     | Yes       | 0.8691   |
| oh2 (3' boundary) | AAGT     | Yes       | 0.7629   |

**Variants:** 14200 mutations, 14200 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name              | Length  | 5' OH | 3' OH |
| --- | --------------- | ---------------------- | ------- | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile12_sub1   | 1631 nt | ATGG  | ATCT  |
| 2   | 5'WT gene block | bsai_5wt_tile20_sub2   | 1719 nt | ATCT  | TCTA  |
| 3   | 5'WT gene block | bsai_5wt_tile23_sub3   | 760 nt  | TCTA  | CTAA  |
| 4   | Oligo pool      | Tile 23 (14200 oligos) | 281 nt  | CTAA  | TTCC  |
| 5   | Helper plasmid  | helper_plasmid_insert  | --      | --    | --    |
| 6   | Enzyme + buffer | BsaI-HFv2 + CutSmart   | --      | --    | --    |

```
  [ATGG]----5'WT sub1----[ATCT]----5'WT sub2----[TCTA]----5'WT sub3----[CTAA]----oligo+BC----[TTCC]
   ATGG                   ATCT                   TCTA                   CTAA                  TTCC 
   (--)                   (--)                   (--)                   (HF)                  (--) 
```

**Set fidelity:** 0.9921 (5 overhangs, 1 in HF set)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------ | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)      | --      | --    | --    |
| 2   | 3'WT block        | bsmbi_3wt_tile23_sub1    | 819 nt  | AAGT  | GACA  |
| 3   | 3'WT+PolIII block | bsmbi_3wt_tile1_sub4     | 1736 nt | GACA  | CACC  |
| 4   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1 | --      | --    | --    |

```
  [AAGT]----3'WT sub1----[GACA]----3'WT+PolIII sub2----[CACC]
   AAGT                   GACA                          CACC 
   (HF)                   (HF)                          (--) 
```

**Set fidelity:** 0.9985 (3 overhangs, 2 in HF set)

---

### Tile 24 of 31 -- Codons 1424-1494 (213 nt)

**Boundary overhangs:**

| Position          | Sequence | In HF Set | Fidelity |
| ----------------- | -------- | --------- | -------- |
| oh1 (5' boundary) | AAGA     | No        | 0.9209   |
| oh2 (3' boundary) | TGGA     | No        | 0.7377   |

**Variants:** 13400 mutations, 13400 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name              | Length  | 5' OH | 3' OH |
| --- | --------------- | ---------------------- | ------- | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile12_sub1   | 1631 nt | ATGG  | ATCT  |
| 2   | 5'WT gene block | bsai_5wt_tile20_sub2   | 1719 nt | ATCT  | TCTA  |
| 3   | 5'WT gene block | bsai_5wt_tile24_sub3   | 973 nt  | TCTA  | AAGA  |
| 4   | Oligo pool      | Tile 24 (13400 oligos) | 269 nt  | AAGA  | TTCC  |
| 5   | Helper plasmid  | helper_plasmid_insert  | --      | --    | --    |
| 6   | Enzyme + buffer | BsaI-HFv2 + CutSmart   | --      | --    | --    |

```
  [ATGG]----5'WT sub1----[ATCT]----5'WT sub2----[TCTA]----5'WT sub3----[AAGA]----oligo+BC----[TTCC]
   ATGG                   ATCT                   TCTA                   AAGA                  TTCC 
   (--)                   (--)                   (--)                   (--)                  (--) 
```

**Set fidelity:** 0.9909 (5 overhangs, 0 in HF set)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------ | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)      | --      | --    | --    |
| 2   | 3'WT block        | bsmbi_3wt_tile24_sub1    | 618 nt  | TGGA  | GACA  |
| 3   | 3'WT+PolIII block | bsmbi_3wt_tile1_sub4     | 1736 nt | GACA  | CACC  |
| 4   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1 | --      | --    | --    |

```
  [TGGA]----3'WT sub1----[GACA]----3'WT+PolIII sub2----[CACC]
   TGGA                   GACA                          CACC 
   (--)                   (HF)                          (--) 
```

**Set fidelity:** 0.9930 (3 overhangs, 1 in HF set)

---

### Tile 25 of 31 -- Codons 1491-1557 (201 nt)

**Boundary overhangs:**

| Position          | Sequence | In HF Set | Fidelity |
| ----------------- | -------- | --------- | -------- |
| oh1 (5' boundary) | GAAA     | No        | 0.8745   |
| oh2 (3' boundary) | AGGA     | Yes       | 0.7515   |

**Variants:** 12600 mutations, 12600 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name              | Length  | 5' OH | 3' OH |
| --- | --------------- | ---------------------- | ------- | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile12_sub1   | 1631 nt | ATGG  | ATCT  |
| 2   | 5'WT gene block | bsai_5wt_tile20_sub2   | 1719 nt | ATCT  | TCTA  |
| 3   | 5'WT gene block | bsai_5wt_tile25_sub3   | 1174 nt | TCTA  | GAAA  |
| 4   | Oligo pool      | Tile 25 (12600 oligos) | 257 nt  | GAAA  | TTCC  |
| 5   | Helper plasmid  | helper_plasmid_insert  | --      | --    | --    |
| 6   | Enzyme + buffer | BsaI-HFv2 + CutSmart   | --      | --    | --    |

```
  [ATGG]----5'WT sub1----[ATCT]----5'WT sub2----[TCTA]----5'WT sub3----[GAAA]----oligo+BC----[TTCC]
   ATGG                   ATCT                   TCTA                   GAAA                  TTCC 
   (--)                   (--)                   (--)                   (--)                  (--) 
```

**Set fidelity:** 0.9838 (5 overhangs, 0 in HF set)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------ | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)      | --      | --    | --    |
| 2   | 3'WT block        | bsmbi_3wt_tile25_sub1    | 429 nt  | AGGA  | GACA  |
| 3   | 3'WT+PolIII block | bsmbi_3wt_tile1_sub4     | 1736 nt | GACA  | CACC  |
| 4   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1 | --      | --    | --    |

```
  [AGGA]----3'WT sub1----[GACA]----3'WT+PolIII sub2----[CACC]
   AGGA                   GACA                          CACC 
   (HF)                   (HF)                          (--) 
```

**Set fidelity:** 0.9970 (3 overhangs, 2 in HF set)

---

### Tile 26 of 31 -- Codons 1554-1630 (231 nt)

**Boundary overhangs:**

| Position          | Sequence | In HF Set | Fidelity |
| ----------------- | -------- | --------- | -------- |
| oh1 (5' boundary) | CTAA     | Yes       | 0.8691   |
| oh2 (3' boundary) | ATCT     | No        | 0.7151   |

**Variants:** 14600 mutations, 14600 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name              | Length  | 5' OH | 3' OH |
| --- | --------------- | ---------------------- | ------- | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile12_sub1   | 1631 nt | ATGG  | ATCT  |
| 2   | 5'WT gene block | bsai_5wt_tile20_sub2   | 1719 nt | ATCT  | TCTA  |
| 3   | 5'WT gene block | bsai_5wt_tile26_sub3   | 1363 nt | TCTA  | CTAA  |
| 4   | Oligo pool      | Tile 26 (14600 oligos) | 287 nt  | CTAA  | TTCC  |
| 5   | Helper plasmid  | helper_plasmid_insert  | --      | --    | --    |
| 6   | Enzyme + buffer | BsaI-HFv2 + CutSmart   | --      | --    | --    |

```
  [ATGG]----5'WT sub1----[ATCT]----5'WT sub2----[TCTA]----5'WT sub3----[CTAA]----oligo+BC----[TTCC]
   ATGG                   ATCT                   TCTA                   CTAA                  TTCC 
   (--)                   (--)                   (--)                   (HF)                  (--) 
```

**Set fidelity:** 0.9921 (5 overhangs, 1 in HF set)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------ | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)      | --      | --    | --    |
| 2   | 3'WT block        | bsmbi_3wt_tile26_sub1    | 210 nt  | ATCT  | GACA  |
| 3   | 3'WT+PolIII block | bsmbi_3wt_tile1_sub4     | 1736 nt | GACA  | CACC  |
| 4   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1 | --      | --    | --    |

```
  [ATCT]----3'WT sub1----[GACA]----3'WT+PolIII sub2----[CACC]
   ATCT                   GACA                          CACC 
   (--)                   (HF)                          (--) 
```

**Set fidelity:** 0.9985 (3 overhangs, 1 in HF set)

---

### Tile 27 of 31 -- Codons 1627-1694 (204 nt)

**Boundary overhangs:**

| Position          | Sequence | In HF Set | Fidelity |
| ----------------- | -------- | --------- | -------- |
| oh1 (5' boundary) | TATC     | No        | 0.8041   |
| oh2 (3' boundary) | GACA     | Yes       | 0.6127   |

**Variants:** 12800 mutations, 12800 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name              | Length  | 5' OH | 3' OH |
| --- | --------------- | ---------------------- | ------- | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile12_sub1   | 1631 nt | ATGG  | ATCT  |
| 2   | 5'WT gene block | bsai_5wt_tile20_sub2   | 1719 nt | ATCT  | TCTA  |
| 3   | 5'WT gene block | bsai_5wt_tile27_sub3   | 1582 nt | TCTA  | TATC  |
| 4   | Oligo pool      | Tile 27 (12800 oligos) | 260 nt  | TATC  | TTCC  |
| 5   | Helper plasmid  | helper_plasmid_insert  | --      | --    | --    |
| 6   | Enzyme + buffer | BsaI-HFv2 + CutSmart   | --      | --    | --    |

```
  [ATGG]----5'WT sub1----[ATCT]----5'WT sub2----[TCTA]----5'WT sub3----[TATC]----oligo+BC----[TTCC]
   ATGG                   ATCT                   TCTA                   TATC                  TTCC 
   (--)                   (--)                   (--)                   (--)                  (--) 
```

**Set fidelity:** 0.9964 (5 overhangs, 0 in HF set)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------ | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)      | --      | --    | --    |
| 2   | 3'WT+PolIII block | bsmbi_3wt_tile1_sub4     | 1736 nt | GACA  | CACC  |
| 3   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1 | --      | --    | --    |

```
  [GACA]----3'WT+PolIII----[CACC]
   GACA                     CACC 
   (HF)                     (--) 
```

**Set fidelity:** 0.9987 (2 overhangs, 1 in HF set)

---

### Tile 28 of 31 -- Codons 1691-1755 (195 nt)

**Boundary overhangs:**

| Position          | Sequence | In HF Set | Fidelity |
| ----------------- | -------- | --------- | -------- |
| oh1 (5' boundary) | GAAA     | No        | 0.8745   |
| oh2 (3' boundary) | TCTA     | No        | 0.8892   |

**Variants:** 12200 mutations, 12200 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name              | Length  | 5' OH | 3' OH |
| --- | --------------- | ---------------------- | ------- | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile12_sub1   | 1631 nt | ATGG  | ATCT  |
| 2   | 5'WT gene block | bsai_5wt_tile20_sub2   | 1719 nt | ATCT  | TCTA  |
| 3   | 5'WT gene block | bsai_5wt_tile28_sub3   | 1774 nt | TCTA  | GAAA  |
| 4   | Oligo pool      | Tile 28 (12200 oligos) | 251 nt  | GAAA  | TTCC  |
| 5   | Helper plasmid  | helper_plasmid_insert  | --      | --    | --    |
| 6   | Enzyme + buffer | BsaI-HFv2 + CutSmart   | --      | --    | --    |

```
  [ATGG]----5'WT sub1----[ATCT]----5'WT sub2----[TCTA]----5'WT sub3----[GAAA]----oligo+BC----[TTCC]
   ATGG                   ATCT                   TCTA                   GAAA                  TTCC 
   (--)                   (--)                   (--)                   (--)                  (--) 
```

**Set fidelity:** 0.9838 (5 overhangs, 0 in HF set)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------ | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)      | --      | --    | --    |
| 2   | 3'WT+PolIII block | bsmbi_3wt_tile28         | 1553 nt | TCTA  | CACC  |
| 3   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1 | --      | --    | --    |

```
  [TCTA]----3'WT+PolIII----[CACC]
   TCTA                     CACC 
   (--)                     (--) 
```

**Set fidelity:** 0.9990 (2 overhangs, 0 in HF set)

---

### Tile 29 of 31 -- Codons 1752-1814 (189 nt)

**Boundary overhangs:**

| Position          | Sequence | In HF Set | Fidelity |
| ----------------- | -------- | --------- | -------- |
| oh1 (5' boundary) | TTTC     | No        | 0.8348   |
| oh2 (3' boundary) | GAAT     | No        | 0.7246   |

**Variants:** 11800 mutations, 11800 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name              | Length  | 5' OH | 3' OH |
| --- | --------------- | ---------------------- | ------- | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile12_sub1   | 1631 nt | ATGG  | ATCT  |
| 2   | 5'WT gene block | bsai_5wt_tile20_sub2   | 1719 nt | ATCT  | TCTA  |
| 3   | 5'WT gene block | bsai_5wt_tile29_sub3   | 1782 nt | TCTA  | GACA  |
| 4   | 5'WT gene block | bsai_5wt_tile29_sub4   | 193 nt  | GACA  | TTTC  |
| 5   | Oligo pool      | Tile 29 (11800 oligos) | 245 nt  | TTTC  | TTCC  |
| 6   | Helper plasmid  | helper_plasmid_insert  | --      | --    | --    |
| 7   | Enzyme + buffer | BsaI-HFv2 + CutSmart   | --      | --    | --    |

```
  [ATGG]----5'WT sub1----[ATCT]----5'WT sub2----[TCTA]----5'WT sub3----[GACA]----5'WT sub4----[TTTC]----oligo+BC----[TTCC]
   ATGG                   ATCT                   TCTA                   GACA                   TTTC                  TTCC 
   (--)                   (--)                   (--)                   (HF)                   (--)                  (--) 
```

**Set fidelity:** 0.9614 (6 overhangs, 1 in HF set)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------ | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)      | --      | --    | --    |
| 2   | 3'WT+PolIII block | bsmbi_3wt_tile29         | 1376 nt | GAAT  | CACC  |
| 3   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1 | --      | --    | --    |

```
  [GAAT]----3'WT+PolIII----[CACC]
   GAAT                     CACC 
   (--)                     (--) 
```

**Set fidelity:** 0.9989 (2 overhangs, 0 in HF set)

---

### Tile 30 of 31 -- Codons 1811-1863 (159 nt)

**Boundary overhangs:**

| Position          | Sequence | In HF Set | Fidelity |
| ----------------- | -------- | --------- | -------- |
| oh1 (5' boundary) | CTAA     | Yes       | 0.8691   |
| oh2 (3' boundary) | GAAA     | No        | 0.8745   |

**Variants:** 9800 mutations, 9800 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name             | Length  | 5' OH | 3' OH |
| --- | --------------- | --------------------- | ------- | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile12_sub1  | 1631 nt | ATGG  | ATCT  |
| 2   | 5'WT gene block | bsai_5wt_tile20_sub2  | 1719 nt | ATCT  | TCTA  |
| 3   | 5'WT gene block | bsai_5wt_tile29_sub3  | 1782 nt | TCTA  | GACA  |
| 4   | 5'WT gene block | bsai_5wt_tile30_sub4  | 370 nt  | GACA  | CTAA  |
| 5   | Oligo pool      | Tile 30 (9800 oligos) | 215 nt  | CTAA  | TTCC  |
| 6   | Helper plasmid  | helper_plasmid_insert | --      | --    | --    |
| 7   | Enzyme + buffer | BsaI-HFv2 + CutSmart  | --      | --    | --    |

```
  [ATGG]----5'WT sub1----[ATCT]----5'WT sub2----[TCTA]----5'WT sub3----[GACA]----5'WT sub4----[CTAA]----oligo+BC----[TTCC]
   ATGG                   ATCT                   TCTA                   GACA                   CTAA                  TTCC 
   (--)                   (--)                   (--)                   (HF)                   (HF)                  (--) 
```

**Set fidelity:** 0.9842 (6 overhangs, 2 in HF set)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------ | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)      | --      | --    | --    |
| 2   | 3'WT+PolIII block | bsmbi_3wt_tile30         | 1229 nt | GAAA  | CACC  |
| 3   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1 | --      | --    | --    |

```
  [GAAA]----3'WT+PolIII----[CACC]
   GAAA                     CACC 
   (--)                     (--) 
```

**Set fidelity:** 0.9990 (2 overhangs, 0 in HF set)

---

### Tile 31 of 31 -- Codons 1860-1902 (129 nt)

**Boundary overhangs:**

| Position          | Sequence | In HF Set | Fidelity |
| ----------------- | -------- | --------- | -------- |
| oh1 (5' boundary) | TTAC     | No        | 0.8333   |
| oh2 (3' boundary) | ATAG     | No        | 0.7330   |

**Variants:** 7800 mutations, 7800 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name             | Length  | 5' OH | 3' OH |
| --- | --------------- | --------------------- | ------- | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile12_sub1  | 1631 nt | ATGG  | ATCT  |
| 2   | 5'WT gene block | bsai_5wt_tile20_sub2  | 1719 nt | ATCT  | TCTA  |
| 3   | 5'WT gene block | bsai_5wt_tile29_sub3  | 1782 nt | TCTA  | GACA  |
| 4   | 5'WT gene block | bsai_5wt_tile31_sub4  | 517 nt  | GACA  | TTAC  |
| 5   | Oligo pool      | Tile 31 (7800 oligos) | 185 nt  | TTAC  | TTCC  |
| 6   | Helper plasmid  | helper_plasmid_insert | --      | --    | --    |
| 7   | Enzyme + buffer | BsaI-HFv2 + CutSmart  | --      | --    | --    |

```
  [ATGG]----5'WT sub1----[ATCT]----5'WT sub2----[TCTA]----5'WT sub3----[GACA]----5'WT sub4----[TTAC]----oligo+BC----[TTCC]
   ATGG                   ATCT                   TCTA                   GACA                   TTAC                  TTCC 
   (--)                   (--)                   (--)                   (HF)                   (--)                  (--) 
```

**Set fidelity:** 0.9853 (6 overhangs, 1 in HF set)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component            | Part name                | Length  | 5' OH | 3' OH |
| --- | -------------------- | ------------------------ | ------- | ----- | ----- |
| 1   | BsaI product         | (in helper plasmid)      | --      | --    | --    |
| 2   | PolIII-only fragment | bsmbi_polIII_tile31      | 1112 nt | ATAG  | CACC  |
| 3   | Enzyme + buffer      | BsmBI-v2 + NEBuffer r3.1 | --      | --    | --    |

```
  [ATAG]----PolIII----[CACC]
   ATAG                CACC 
   (--)                (--) 
```

**Set fidelity:** 0.9989 (2 overhangs, 0 in HF set)

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

**Total blocks:** 64

| Block name            | Length (nt) | Enzyme type | Gene region                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                    |
| --------------------- | ----------- | ----------- | ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------ |
| bsai_5wt_tile10       | 1623        | BsaI        | 5wt_tile10                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                     |
| bsai_5wt_tile11_sub1  | 1794        | BsaI        | 5wt_tile11_sub1                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                |
| bsai_5wt_tile12_sub1  | 1631        | BsaI        | 5wt_tile12_sub1;5wt_tile13_sub1;5wt_tile14_sub1;5wt_tile15_sub1;5wt_tile16_sub1;5wt_tile17_sub1;5wt_tile18_sub1;5wt_tile19_sub1;5wt_tile20_sub1;5wt_tile21_sub1;5wt_tile22_sub1;5wt_tile23_sub1;5wt_tile24_sub1;5wt_tile25_sub1;5wt_tile26_sub1;5wt_tile27_sub1;5wt_tile28_sub1;5wt_tile29_sub1;5wt_tile30_sub1;5wt_tile31_sub1                                                                                                                                                                                                                                                                                                |
| bsai_5wt_tile12_sub2  | 397         | BsaI        | 5wt_tile12_sub2                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                |
| bsai_5wt_tile13_sub2  | 565         | BsaI        | 5wt_tile13_sub2                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                |
| bsai_5wt_tile14_sub2  | 784         | BsaI        | 5wt_tile14_sub2                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                |
| bsai_5wt_tile15_sub2  | 994         | BsaI        | 5wt_tile15_sub2                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                |
| bsai_5wt_tile16_sub2  | 1144        | BsaI        | 5wt_tile16_sub2                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                |
| bsai_5wt_tile17_sub2  | 1357        | BsaI        | 5wt_tile17_sub2                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                |
| bsai_5wt_tile18_sub2  | 1540        | BsaI        | 5wt_tile18_sub2                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                |
| bsai_5wt_tile19_sub2  | 1711        | BsaI        | 5wt_tile19_sub2                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                |
| bsai_5wt_tile2        | 117         | BsaI        | 5wt_tile2                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                      |
| bsai_5wt_tile20_sub2  | 1719        | BsaI        | 5wt_tile20_sub2;5wt_tile21_sub2;5wt_tile22_sub2;5wt_tile23_sub2;5wt_tile24_sub2;5wt_tile25_sub2;5wt_tile26_sub2;5wt_tile27_sub2;5wt_tile28_sub2;5wt_tile29_sub2;5wt_tile30_sub2;5wt_tile31_sub2                                                                                                                                                                                                                                                                                                                                                                                                                                |
| bsai_5wt_tile20_sub3  | 187         | BsaI        | 5wt_tile20_sub3                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                |
| bsai_5wt_tile21_sub3  | 364         | BsaI        | 5wt_tile21_sub3                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                |
| bsai_5wt_tile22_sub3  | 541         | BsaI        | 5wt_tile22_sub3                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                |
| bsai_5wt_tile23_sub3  | 760         | BsaI        | 5wt_tile23_sub3                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                |
| bsai_5wt_tile24_sub3  | 973         | BsaI        | 5wt_tile24_sub3                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                |
| bsai_5wt_tile25_sub3  | 1174        | BsaI        | 5wt_tile25_sub3                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                |
| bsai_5wt_tile26_sub3  | 1363        | BsaI        | 5wt_tile26_sub3                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                |
| bsai_5wt_tile27_sub3  | 1582        | BsaI        | 5wt_tile27_sub3                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                |
| bsai_5wt_tile28_sub3  | 1774        | BsaI        | 5wt_tile28_sub3                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                |
| bsai_5wt_tile29_sub3  | 1782        | BsaI        | 5wt_tile29_sub3;5wt_tile30_sub3;5wt_tile31_sub3                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                |
| bsai_5wt_tile29_sub4  | 193         | BsaI        | 5wt_tile29_sub4                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                |
| bsai_5wt_tile3        | 321         | BsaI        | 5wt_tile3                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                      |
| bsai_5wt_tile30_sub4  | 370         | BsaI        | 5wt_tile30_sub4                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                |
| bsai_5wt_tile31_sub4  | 517         | BsaI        | 5wt_tile31_sub4                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                |
| bsai_5wt_tile4        | 492         | BsaI        | 5wt_tile4                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                      |
| bsai_5wt_tile5        | 702         | BsaI        | 5wt_tile5                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                      |
| bsai_5wt_tile6        | 849         | BsaI        | 5wt_tile6                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                      |
| bsai_5wt_tile7        | 1071        | BsaI        | 5wt_tile7                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                      |
| bsai_5wt_tile8        | 1254        | BsaI        | 5wt_tile8                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                      |
| bsai_5wt_tile9        | 1446        | BsaI        | 5wt_tile9                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                      |
| bsmbi_3wt_tile1_sub1  | 1524        | BsmBI       | 3wt_tile1_sub1                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                 |
| bsmbi_3wt_tile1_sub2  | 1719        | BsmBI       | 3wt_tile1_sub2;3wt_tile2_sub2;3wt_tile3_sub2;3wt_tile4_sub2;3wt_tile5_sub2;3wt_tile6_sub2;3wt_tile7_sub2;3wt_tile8_sub2;3wt_tile9_sub1                                                                                                                                                                                                                                                                                                                                                                                                                                                                                         |
| bsmbi_3wt_tile1_sub3  | 1782        | BsmBI       | 3wt_tile1_sub3;3wt_tile2_sub3;3wt_tile3_sub3;3wt_tile4_sub3;3wt_tile5_sub3;3wt_tile6_sub3;3wt_tile7_sub3;3wt_tile8_sub3;3wt_tile9_sub2;3wt_tile10_sub2;3wt_tile11_sub2;3wt_tile12_sub2;3wt_tile13_sub2;3wt_tile14_sub2;3wt_tile15_sub2;3wt_tile16_sub2;3wt_tile17_sub2;3wt_tile18_sub1                                                                                                                                                                                                                                                                                                                                         |
| bsmbi_3wt_tile1_sub4  | 1736        | BsmBI       | 3wt_polIII_tile1_sub4;3wt_polIII_tile2_sub4;3wt_polIII_tile3_sub4;3wt_polIII_tile4_sub4;3wt_polIII_tile5_sub4;3wt_polIII_tile6_sub4;3wt_polIII_tile7_sub4;3wt_polIII_tile8_sub4;3wt_polIII_tile9_sub3;3wt_polIII_tile10_sub3;3wt_polIII_tile11_sub3;3wt_polIII_tile12_sub3;3wt_polIII_tile13_sub3;3wt_polIII_tile14_sub3;3wt_polIII_tile15_sub3;3wt_polIII_tile16_sub3;3wt_polIII_tile17_sub3;3wt_polIII_tile18_sub2;3wt_polIII_tile19_sub2;3wt_polIII_tile20_sub2;3wt_polIII_tile21_sub2;3wt_polIII_tile22_sub2;3wt_polIII_tile23_sub2;3wt_polIII_tile24_sub2;3wt_polIII_tile25_sub2;3wt_polIII_tile26_sub2;3wt_polIII_tile27 |
| bsmbi_3wt_tile10_sub1 | 1548        | BsmBI       | 3wt_tile10_sub1                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                |
| bsmbi_3wt_tile11_sub1 | 1332        | BsmBI       | 3wt_tile11_sub1                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                |
| bsmbi_3wt_tile12_sub1 | 1164        | BsmBI       | 3wt_tile12_sub1                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                |
| bsmbi_3wt_tile13_sub1 | 945         | BsmBI       | 3wt_tile13_sub1                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                |
| bsmbi_3wt_tile14_sub1 | 735         | BsmBI       | 3wt_tile14_sub1                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                |
| bsmbi_3wt_tile15_sub1 | 585         | BsmBI       | 3wt_tile15_sub1                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                |
| bsmbi_3wt_tile16_sub1 | 372         | BsmBI       | 3wt_tile16_sub1                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                |
| bsmbi_3wt_tile17_sub1 | 189         | BsmBI       | 3wt_tile17_sub1                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                |
| bsmbi_3wt_tile19_sub1 | 1605        | BsmBI       | 3wt_tile19_sub1                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                |
| bsmbi_3wt_tile2_sub1  | 1320        | BsmBI       | 3wt_tile2_sub1                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                 |
| bsmbi_3wt_tile20_sub1 | 1428        | BsmBI       | 3wt_tile20_sub1                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                |
| bsmbi_3wt_tile21_sub1 | 1251        | BsmBI       | 3wt_tile21_sub1                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                |
| bsmbi_3wt_tile22_sub1 | 1032        | BsmBI       | 3wt_tile22_sub1                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                |
| bsmbi_3wt_tile23_sub1 | 819         | BsmBI       | 3wt_tile23_sub1                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                |
| bsmbi_3wt_tile24_sub1 | 618         | BsmBI       | 3wt_tile24_sub1                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                |
| bsmbi_3wt_tile25_sub1 | 429         | BsmBI       | 3wt_tile25_sub1                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                |
| bsmbi_3wt_tile26_sub1 | 210         | BsmBI       | 3wt_tile26_sub1                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                |
| bsmbi_3wt_tile28      | 1553        | BsmBI       | 3wt_polIII_tile28                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                              |
| bsmbi_3wt_tile29      | 1376        | BsmBI       | 3wt_polIII_tile29                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                              |
| bsmbi_3wt_tile3_sub1  | 1149        | BsmBI       | 3wt_tile3_sub1                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                 |
| bsmbi_3wt_tile30      | 1229        | BsmBI       | 3wt_polIII_tile30                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                              |
| bsmbi_3wt_tile4_sub1  | 939         | BsmBI       | 3wt_tile4_sub1                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                 |
| bsmbi_3wt_tile5_sub1  | 792         | BsmBI       | 3wt_tile5_sub1                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                 |
| bsmbi_3wt_tile6_sub1  | 570         | BsmBI       | 3wt_tile6_sub1                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                 |
| bsmbi_3wt_tile7_sub1  | 387         | BsmBI       | 3wt_tile7_sub1                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                 |
| bsmbi_3wt_tile8_sub1  | 195         | BsmBI       | 3wt_tile8_sub1                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                 |
| bsmbi_polIII_tile31   | 1112        | BsmBI       | polIII_tile31                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                  |

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

