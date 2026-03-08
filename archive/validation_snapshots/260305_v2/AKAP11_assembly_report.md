# DMS-GG Assembly Report: AKAP11

Generated: 2026-03-05 19:54:46
Pipeline: dms-gg-oligo-pipeline (3-Enzyme Architecture: BsaI + BsmBI + PaqCI)

---

## 1. Gene Summary

| Property             | Value                                                                          |
| -------------------- | ------------------------------------------------------------------------------ |
| Gene name            | AKAP11_NM_016248.4_CDS Homo sapiens A-kinase anchoring protein 11 (AKAP11) CDS |
| CDS length           | 5706 nt (1902 codons)                                                          |
| Protein length       | 1901 aa                                                                        |
| Number of tiles      | 37                                                                             |
| Total variants       | 39858                                                                          |
| Total oligos         | 398580                                                                         |
| Oligo length range   | 155-284 nt                                                                     |
| Gene blocks to order | 80                                                                             |
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

**Total oligos:** 398580 | **Length range:** 155-284 nt

| Tile | Codons    | Oligos | Length |
| ---- | --------- | ------ | ------ |
| 1    | 1-37      | 6930   | 167 nt |
| 2    | 34-105    | 14280  | 272 nt |
| 3    | 102-140   | 7350   | 173 nt |
| 4    | 137-197   | 11970  | 239 nt |
| 5    | 194-254   | 11970  | 239 nt |
| 6    | 251-299   | 9450   | 203 nt |
| 7    | 296-346   | 9870   | 209 nt |
| 8    | 343-400   | 11340  | 230 nt |
| 9    | 397-455   | 11550  | 233 nt |
| 10   | 452-496   | 8610   | 191 nt |
| 11   | 493-539   | 9030   | 197 nt |
| 12   | 536-608   | 14490  | 275 nt |
| 13   | 605-668   | 12600  | 248 nt |
| 14   | 665-698   | 6300   | 158 nt |
| 15   | 695-764   | 13860  | 266 nt |
| 16   | 761-797   | 6930   | 167 nt |
| 17   | 794-867   | 14700  | 278 nt |
| 18   | 864-918   | 10710  | 221 nt |
| 19   | 915-988   | 14700  | 278 nt |
| 20   | 985-1049  | 12810  | 251 nt |
| 21   | 1046-1106 | 11970  | 239 nt |
| 22   | 1103-1159 | 11130  | 227 nt |
| 23   | 1156-1224 | 13650  | 263 nt |
| 24   | 1221-1277 | 11130  | 227 nt |
| 25   | 1274-1325 | 10080  | 212 nt |
| 26   | 1322-1354 | 6090   | 155 nt |
| 27   | 1351-1388 | 7140   | 170 nt |
| 28   | 1385-1431 | 9030   | 197 nt |
| 29   | 1428-1492 | 12810  | 251 nt |
| 30   | 1489-1557 | 13650  | 263 nt |
| 31   | 1554-1622 | 13650  | 263 nt |
| 32   | 1619-1661 | 8190   | 185 nt |
| 33   | 1658-1710 | 10290  | 215 nt |
| 34   | 1707-1758 | 10080  | 212 nt |
| 35   | 1755-1830 | 15120  | 284 nt |
| 36   | 1827-1867 | 7770   | 179 nt |
| 37   | 1864-1902 | 7350   | 173 nt |

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
| oligo_lengths          | All oligos within synthesis length limit                      | PASS   | Range: 155-284 nt (limit: 300)                                                                                                                      |
| block_lengths          | All gene blocks within synthesis length limit                 | PASS   | Range: 117-1792 nt (limit: 1800)                                                                                                                    |
| barcode_junction_sites | No enzyme sites at barcode-context junctions                  | PASS   | 0 barcode(s) with junction enzyme sites (left='CACACC', right='AGAATG')                                                                             |
| barcode_uniqueness     | All barcodes are unique                                       | PASS   | 398580 unique / 398580 total                                                                                                                        |
| tile_coverage          | Tiles cover entire gene without gaps                          | PASS   | 5706 / 5706 nt covered                                                                                                                              |
| variant_count          | Expected number of variants generated                         | PASS   | 39858 unique variants (expected: 39858 across 1898/1900 mutable positions; 36062 missense + 1898 nonsense + 1898 wt_control; 2 position(s) skipped) |
| single_codon_change    | Each non-control variant differs by exactly one codon from WT | PASS   | 379600 / 379600 variants confirmed (WT controls excluded)                                                                                           |
| oligo_gc_content       | Oligo GC content within reasonable range (25-75%)             | PASS   | GC range: 33.5-55.8% | 0 oligo(s) with extreme GC                                                                                                   |
| domestication_complete | Gene domesticated for all 3 enzymes (BsaI, BsmBI, PaqCI)      | PASS   | No enzyme sites in gene                                                                                                                             |
| overhang_fidelity      | Tile boundary overhangs have adequate fidelity                | FAIL   | 26 tile(s) with low-fidelity boundary overhangs (<0.80)                                                                                             |
| tile_manifests         | Per-tile assembly manifests complete                          | PASS   | 37 tile manifest(s) generated                                                                                                                       |
| helper_plasmid         | Helper plasmid free of unintended BsmBI sites                 | PASS   | OK                                                                                                                                                  |
| reaction_fidelity      | Per-reaction set-level overhang fidelity                      | PASS   | Min set fidelity: 0.9146 across 74 reactions | 0 reaction(s) below 0.90                                                                             |
| barcode_poliii_term    | No barcodes contain PolIII terminator signal (TTTT)           | PASS   | 0 / 398580 barcode(s) contain TTTT                                                                                                                  |
| block_min_length       | All gene blocks above synthesis minimum length                | FAIL   | 5 block(s) below 300 nt minimum. Range: 117-1792 nt                                                                                                 |

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

### Tile 1 of 37 -- Codons 1-37 (111 nt)

**Boundary overhangs:**

| Position          | Sequence | Fidelity |
| ----------------- | -------- | -------- |
| oh1 (5' boundary) | ATGG     | 0.5393   |
| oh2 (3' boundary) | ACTA     | 0.7946   |

**Variants:** 6930 mutations, 6930 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name                          | Length | 5' OH | 3' OH |
| --- | --------------- | ---------------------------------- | ------ | ----- | ----- |
| 1   | 5'WT gene block | (none -- tile starts at gene nt 1) | --     | --    | --    |
| 2   | Oligo pool      | Tile 1 (6930 oligos)               | 167 nt | ATGG  | AGAA  |
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
| 2   | 3'WT block        | bsmbi_3wt_tile1_sub1     | 933 nt  | ACTA  | GAAA  |
| 3   | 3'WT block        | bsmbi_3wt_tile1_sub2     | 1734 nt | GAAA  | GAAA  |
| 4   | 3'WT block        | bsmbi_3wt_tile1_sub3     | 1095 nt | GAAA  | GAAA  |
| 5   | 3'WT block        | bsmbi_3wt_tile1_sub4     | 1788 nt | GAAA  | GAAA  |
| 6   | 3'WT+PolIII block | bsmbi_3wt_tile1_sub5     | 1229 nt | GAAA  | CACC  |
| 7   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1 | --      | --    | --    |

```
  [ACTA]----3'WT sub1----[GAAA]----3'WT sub2----[GAAA]----3'WT sub3----[GAAA]----3'WT sub4----[GAAA]----3'WT+PolIII sub5----[CACC]
   ACTA                   GAAA                   GAAA                   GAAA                   GAAA                          CACC 
```

**Set fidelity:** 1.0000 (3 overhangs)

---

### Tile 2 of 37 -- Codons 34-105 (216 nt)

**Boundary overhangs:**

| Position          | Sequence | Fidelity |
| ----------------- | -------- | -------- |
| oh1 (5' boundary) | CAGA     | 0.8175   |
| oh2 (3' boundary) | AAAT     | 0.7737   |

**Variants:** 14280 mutations, 14280 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name             | Length | 5' OH | 3' OH |
| --- | --------------- | --------------------- | ------ | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile2        | 117 nt | ATGG  | CAGA  |
| 2   | Oligo pool      | Tile 2 (14280 oligos) | 272 nt | CAGA  | AGAA  |
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
| 2   | 3'WT block        | bsmbi_3wt_tile2_sub1     | 729 nt  | AAAT  | GAAA  |
| 3   | 3'WT block        | bsmbi_3wt_tile1_sub2     | 1734 nt | GAAA  | GAAA  |
| 4   | 3'WT block        | bsmbi_3wt_tile1_sub3     | 1095 nt | GAAA  | GAAA  |
| 5   | 3'WT block        | bsmbi_3wt_tile1_sub4     | 1788 nt | GAAA  | GAAA  |
| 6   | 3'WT+PolIII block | bsmbi_3wt_tile1_sub5     | 1229 nt | GAAA  | CACC  |
| 7   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1 | --      | --    | --    |

```
  [AAAT]----3'WT sub1----[GAAA]----3'WT sub2----[GAAA]----3'WT sub3----[GAAA]----3'WT sub4----[GAAA]----3'WT+PolIII sub5----[CACC]
   AAAT                   GAAA                   GAAA                   GAAA                   GAAA                          CACC 
```

**Set fidelity:** 1.0000 (3 overhangs)

---

### Tile 3 of 37 -- Codons 102-140 (117 nt)

**Boundary overhangs:**

| Position          | Sequence | Fidelity |
| ----------------- | -------- | -------- |
| oh1 (5' boundary) | AAGA     | 0.9209   |
| oh2 (3' boundary) | TTTT     | 0.8623   |

**Variants:** 7350 mutations, 7350 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name             | Length | 5' OH | 3' OH |
| --- | --------------- | --------------------- | ------ | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile3        | 321 nt | ATGG  | AAGA  |
| 2   | Oligo pool      | Tile 3 (7350 oligos)  | 173 nt | AAGA  | AGAA  |
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
| 2   | 3'WT block        | bsmbi_3wt_tile3_sub1     | 624 nt  | TTTT  | GAAA  |
| 3   | 3'WT block        | bsmbi_3wt_tile1_sub2     | 1734 nt | GAAA  | GAAA  |
| 4   | 3'WT block        | bsmbi_3wt_tile1_sub3     | 1095 nt | GAAA  | GAAA  |
| 5   | 3'WT block        | bsmbi_3wt_tile1_sub4     | 1788 nt | GAAA  | GAAA  |
| 6   | 3'WT+PolIII block | bsmbi_3wt_tile1_sub5     | 1229 nt | GAAA  | CACC  |
| 7   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1 | --      | --    | --    |

```
  [TTTT]----3'WT sub1----[GAAA]----3'WT sub2----[GAAA]----3'WT sub3----[GAAA]----3'WT sub4----[GAAA]----3'WT+PolIII sub5----[CACC]
   TTTT                   GAAA                   GAAA                   GAAA                   GAAA                          CACC 
```

**Set fidelity:** 1.0000 (3 overhangs)

---

### Tile 4 of 37 -- Codons 137-197 (183 nt)

**Boundary overhangs:**

| Position          | Sequence | Fidelity |
| ----------------- | -------- | -------- |
| oh1 (5' boundary) | AGGA     | 0.7515   |
| oh2 (3' boundary) | GGAA     | 0.7463   |

**Variants:** 11970 mutations, 11970 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name             | Length | 5' OH | 3' OH |
| --- | --------------- | --------------------- | ------ | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile4        | 426 nt | ATGG  | AGGA  |
| 2   | Oligo pool      | Tile 4 (11970 oligos) | 239 nt | AGGA  | AGAA  |
| 3   | Helper plasmid  | helper_plasmid_insert | --     | --    | --    |
| 4   | Enzyme + buffer | BsaI-HFv2 + CutSmart  | --     | --    | --    |

```
  [ATGG]----5'WT block----[AGGA]----oligo+BC----[AGAA]
   ATGG                    AGGA                  AGAA 
```

**Set fidelity:** 0.9704 (3 overhangs)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------ | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)      | --      | --    | --    |
| 2   | 3'WT block        | bsmbi_3wt_tile4_sub1     | 453 nt  | GGAA  | GAAA  |
| 3   | 3'WT block        | bsmbi_3wt_tile1_sub2     | 1734 nt | GAAA  | GAAA  |
| 4   | 3'WT block        | bsmbi_3wt_tile1_sub3     | 1095 nt | GAAA  | GAAA  |
| 5   | 3'WT block        | bsmbi_3wt_tile1_sub4     | 1788 nt | GAAA  | GAAA  |
| 6   | 3'WT+PolIII block | bsmbi_3wt_tile1_sub5     | 1229 nt | GAAA  | CACC  |
| 7   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1 | --      | --    | --    |

```
  [GGAA]----3'WT sub1----[GAAA]----3'WT sub2----[GAAA]----3'WT sub3----[GAAA]----3'WT sub4----[GAAA]----3'WT+PolIII sub5----[CACC]
   GGAA                   GAAA                   GAAA                   GAAA                   GAAA                          CACC 
```

**Set fidelity:** 0.9596 (3 overhangs)

---

### Tile 5 of 37 -- Codons 194-254 (183 nt)

**Boundary overhangs:**

| Position          | Sequence | Fidelity |
| ----------------- | -------- | -------- |
| oh1 (5' boundary) | TTAG     | 0.8480   |
| oh2 (3' boundary) | GAAT     | 0.7246   |

**Variants:** 11970 mutations, 11970 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name             | Length | 5' OH | 3' OH |
| --- | --------------- | --------------------- | ------ | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile5        | 597 nt | ATGG  | TTAG  |
| 2   | Oligo pool      | Tile 5 (11970 oligos) | 239 nt | TTAG  | AGAA  |
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
| 2   | 3'WT block        | bsmbi_3wt_tile5_sub1     | 282 nt  | GAAT  | GAAA  |
| 3   | 3'WT block        | bsmbi_3wt_tile1_sub2     | 1734 nt | GAAA  | GAAA  |
| 4   | 3'WT block        | bsmbi_3wt_tile1_sub3     | 1095 nt | GAAA  | GAAA  |
| 5   | 3'WT block        | bsmbi_3wt_tile1_sub4     | 1788 nt | GAAA  | GAAA  |
| 6   | 3'WT+PolIII block | bsmbi_3wt_tile1_sub5     | 1229 nt | GAAA  | CACC  |
| 7   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1 | --      | --    | --    |

```
  [GAAT]----3'WT sub1----[GAAA]----3'WT sub2----[GAAA]----3'WT sub3----[GAAA]----3'WT sub4----[GAAA]----3'WT+PolIII sub5----[CACC]
   GAAT                   GAAA                   GAAA                   GAAA                   GAAA                          CACC 
```

**Set fidelity:** 0.9146 (3 overhangs)

---

### Tile 6 of 37 -- Codons 251-299 (147 nt)

**Boundary overhangs:**

| Position          | Sequence | Fidelity |
| ----------------- | -------- | -------- |
| oh1 (5' boundary) | TCCT     | 0.7573   |
| oh2 (3' boundary) | TTTT     | 0.8623   |

**Variants:** 9450 mutations, 9450 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name             | Length | 5' OH | 3' OH |
| --- | --------------- | --------------------- | ------ | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile6        | 768 nt | ATGG  | TCCT  |
| 2   | Oligo pool      | Tile 6 (9450 oligos)  | 203 nt | TCCT  | AGAA  |
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
| 2   | 3'WT block        | bsmbi_3wt_tile6_sub1     | 147 nt  | TTTT  | GAAA  |
| 3   | 3'WT block        | bsmbi_3wt_tile1_sub2     | 1734 nt | GAAA  | GAAA  |
| 4   | 3'WT block        | bsmbi_3wt_tile1_sub3     | 1095 nt | GAAA  | GAAA  |
| 5   | 3'WT block        | bsmbi_3wt_tile1_sub4     | 1788 nt | GAAA  | GAAA  |
| 6   | 3'WT+PolIII block | bsmbi_3wt_tile1_sub5     | 1229 nt | GAAA  | CACC  |
| 7   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1 | --      | --    | --    |

```
  [TTTT]----3'WT sub1----[GAAA]----3'WT sub2----[GAAA]----3'WT sub3----[GAAA]----3'WT sub4----[GAAA]----3'WT+PolIII sub5----[CACC]
   TTTT                   GAAA                   GAAA                   GAAA                   GAAA                          CACC 
```

**Set fidelity:** 1.0000 (3 overhangs)

---

### Tile 7 of 37 -- Codons 296-346 (153 nt)

**Boundary overhangs:**

| Position          | Sequence | Fidelity |
| ----------------- | -------- | -------- |
| oh1 (5' boundary) | AAAA     | 0.9502   |
| oh2 (3' boundary) | AGAG     | 0.6016   |

**Variants:** 9870 mutations, 9870 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name             | Length | 5' OH | 3' OH |
| --- | --------------- | --------------------- | ------ | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile7        | 903 nt | ATGG  | AAAA  |
| 2   | Oligo pool      | Tile 7 (9870 oligos)  | 209 nt | AAAA  | AGAA  |
| 3   | Helper plasmid  | helper_plasmid_insert | --     | --    | --    |
| 4   | Enzyme + buffer | BsaI-HFv2 + CutSmart  | --     | --    | --    |

```
  [ATGG]----5'WT block----[AAAA]----oligo+BC----[AGAA]
   ATGG                    AAAA                  AGAA 
```

**Set fidelity:** 0.9907 (3 overhangs)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------ | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)      | --      | --    | --    |
| 2   | 3'WT block        | bsmbi_3wt_tile7_sub1     | 1722 nt | AGAG  | GAAA  |
| 3   | 3'WT block        | bsmbi_3wt_tile1_sub3     | 1095 nt | GAAA  | GAAA  |
| 4   | 3'WT block        | bsmbi_3wt_tile1_sub4     | 1788 nt | GAAA  | GAAA  |
| 5   | 3'WT+PolIII block | bsmbi_3wt_tile1_sub5     | 1229 nt | GAAA  | CACC  |
| 6   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1 | --      | --    | --    |

```
  [AGAG]----3'WT sub1----[GAAA]----3'WT sub2----[GAAA]----3'WT sub3----[GAAA]----3'WT+PolIII sub4----[CACC]
   AGAG                   GAAA                   GAAA                   GAAA                          CACC 
```

**Set fidelity:** 1.0000 (3 overhangs)

---

### Tile 8 of 37 -- Codons 343-400 (174 nt)

**Boundary overhangs:**

| Position          | Sequence | Fidelity |
| ----------------- | -------- | -------- |
| oh1 (5' boundary) | GATG     | 0.4742   |
| oh2 (3' boundary) | AAAA     | 0.9502   |

**Variants:** 11340 mutations, 11340 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name             | Length  | 5' OH | 3' OH |
| --- | --------------- | --------------------- | ------- | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile8_sub1   | 1044 nt | ATGG  | GATG  |
| 2   | Oligo pool      | Tile 8 (11340 oligos) | 230 nt  | GATG  | AGAA  |
| 3   | Helper plasmid  | helper_plasmid_insert | --      | --    | --    |
| 4   | Enzyme + buffer | BsaI-HFv2 + CutSmart  | --      | --    | --    |

```
  [ATGG]----5'WT sub1----[GAAA]----oligo+BC----[GATG][AGAA]
   ATGG                   GAAA                  GATG  AGAA 
```

**Set fidelity:** 0.9975 (4 overhangs)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------ | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)      | --      | --    | --    |
| 2   | 3'WT block        | bsmbi_3wt_tile8_sub1     | 1560 nt | AAAA  | GAAA  |
| 3   | 3'WT block        | bsmbi_3wt_tile1_sub3     | 1095 nt | GAAA  | GAAA  |
| 4   | 3'WT block        | bsmbi_3wt_tile1_sub4     | 1788 nt | GAAA  | GAAA  |
| 5   | 3'WT+PolIII block | bsmbi_3wt_tile1_sub5     | 1229 nt | GAAA  | CACC  |
| 6   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1 | --      | --    | --    |

```
  [AAAA]----3'WT sub1----[GAAA]----3'WT sub2----[GAAA]----3'WT sub3----[GAAA]----3'WT+PolIII sub4----[CACC]
   AAAA                   GAAA                   GAAA                   GAAA                          CACC 
```

**Set fidelity:** 0.9814 (3 overhangs)

---

### Tile 9 of 37 -- Codons 397-455 (177 nt)

**Boundary overhangs:**

| Position          | Sequence | Fidelity |
| ----------------- | -------- | -------- |
| oh1 (5' boundary) | AATC     | 0.7116   |
| oh2 (3' boundary) | TTTT     | 0.8623   |

**Variants:** 11550 mutations, 11550 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name             | Length  | 5' OH | 3' OH |
| --- | --------------- | --------------------- | ------- | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile9_sub1   | 1206 nt | ATGG  | AATC  |
| 2   | Oligo pool      | Tile 9 (11550 oligos) | 233 nt  | AATC  | AGAA  |
| 3   | Helper plasmid  | helper_plasmid_insert | --      | --    | --    |
| 4   | Enzyme + buffer | BsaI-HFv2 + CutSmart  | --      | --    | --    |

```
  [ATGG]----5'WT sub1----[GAAA]----oligo+BC----[AATC][AGAA]
   ATGG                   GAAA                  AATC  AGAA 
```

**Set fidelity:** 1.0000 (4 overhangs)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------ | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)      | --      | --    | --    |
| 2   | 3'WT block        | bsmbi_3wt_tile9_sub1     | 1395 nt | TTTT  | GAAA  |
| 3   | 3'WT block        | bsmbi_3wt_tile1_sub3     | 1095 nt | GAAA  | GAAA  |
| 4   | 3'WT block        | bsmbi_3wt_tile1_sub4     | 1788 nt | GAAA  | GAAA  |
| 5   | 3'WT+PolIII block | bsmbi_3wt_tile1_sub5     | 1229 nt | GAAA  | CACC  |
| 6   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1 | --      | --    | --    |

```
  [TTTT]----3'WT sub1----[GAAA]----3'WT sub2----[GAAA]----3'WT sub3----[GAAA]----3'WT+PolIII sub4----[CACC]
   TTTT                   GAAA                   GAAA                   GAAA                          CACC 
```

**Set fidelity:** 1.0000 (3 overhangs)

---

### Tile 10 of 37 -- Codons 452-496 (135 nt)

**Boundary overhangs:**

| Position          | Sequence | Fidelity |
| ----------------- | -------- | -------- |
| oh1 (5' boundary) | TCCT     | 0.7573   |
| oh2 (3' boundary) | TTCA     | 0.8824   |

**Variants:** 8610 mutations, 8610 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name             | Length  | 5' OH | 3' OH |
| --- | --------------- | --------------------- | ------- | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile10_sub1  | 1040 nt | ATGG  | GAAA  |
| 2   | 5'WT gene block | bsai_5wt_tile10_sub2  | 349 nt  | GAAA  | TCCT  |
| 3   | Oligo pool      | Tile 10 (8610 oligos) | 191 nt  | TCCT  | AGAA  |
| 4   | Helper plasmid  | helper_plasmid_insert | --      | --    | --    |
| 5   | Enzyme + buffer | BsaI-HFv2 + CutSmart  | --      | --    | --    |

```
  [ATGG]----5'WT sub1----[GAAA]----5'WT sub2----[TCCT]----oligo+BC----[AGAA]
   ATGG                   GAAA                   TCCT                  AGAA 
```

**Set fidelity:** 1.0000 (4 overhangs)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------ | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)      | --      | --    | --    |
| 2   | 3'WT block        | bsmbi_3wt_tile10_sub1    | 1272 nt | TTCA  | GAAA  |
| 3   | 3'WT block        | bsmbi_3wt_tile1_sub3     | 1095 nt | GAAA  | GAAA  |
| 4   | 3'WT block        | bsmbi_3wt_tile1_sub4     | 1788 nt | GAAA  | GAAA  |
| 5   | 3'WT+PolIII block | bsmbi_3wt_tile1_sub5     | 1229 nt | GAAA  | CACC  |
| 6   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1 | --      | --    | --    |

```
  [TTCA]----3'WT sub1----[GAAA]----3'WT sub2----[GAAA]----3'WT sub3----[GAAA]----3'WT+PolIII sub4----[CACC]
   TTCA                   GAAA                   GAAA                   GAAA                          CACC 
```

**Set fidelity:** 1.0000 (3 overhangs)

---

### Tile 11 of 37 -- Codons 493-539 (141 nt)

**Boundary overhangs:**

| Position          | Sequence | Fidelity |
| ----------------- | -------- | -------- |
| oh1 (5' boundary) | AAAA     | 0.9502   |
| oh2 (3' boundary) | ATCT     | 0.7151   |

**Variants:** 9030 mutations, 9030 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name             | Length  | 5' OH | 3' OH |
| --- | --------------- | --------------------- | ------- | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile10_sub1  | 1040 nt | ATGG  | GAAA  |
| 2   | 5'WT gene block | bsai_5wt_tile11_sub2  | 472 nt  | GAAA  | AAAA  |
| 3   | Oligo pool      | Tile 11 (9030 oligos) | 197 nt  | AAAA  | AGAA  |
| 4   | Helper plasmid  | helper_plasmid_insert | --      | --    | --    |
| 5   | Enzyme + buffer | BsaI-HFv2 + CutSmart  | --      | --    | --    |

```
  [ATGG]----5'WT sub1----[GAAA]----5'WT sub2----[AAAA]----oligo+BC----[AGAA]
   ATGG                   GAAA                   AAAA                  AGAA 
```

**Set fidelity:** 0.9605 (4 overhangs)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------ | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)      | --      | --    | --    |
| 2   | 3'WT block        | bsmbi_3wt_tile11_sub1    | 1143 nt | ATCT  | GAAA  |
| 3   | 3'WT block        | bsmbi_3wt_tile1_sub3     | 1095 nt | GAAA  | GAAA  |
| 4   | 3'WT block        | bsmbi_3wt_tile1_sub4     | 1788 nt | GAAA  | GAAA  |
| 5   | 3'WT+PolIII block | bsmbi_3wt_tile1_sub5     | 1229 nt | GAAA  | CACC  |
| 6   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1 | --      | --    | --    |

```
  [ATCT]----3'WT sub1----[GAAA]----3'WT sub2----[GAAA]----3'WT sub3----[GAAA]----3'WT+PolIII sub4----[CACC]
   ATCT                   GAAA                   GAAA                   GAAA                          CACC 
```

**Set fidelity:** 1.0000 (3 overhangs)

---

### Tile 12 of 37 -- Codons 536-608 (219 nt)

**Boundary overhangs:**

| Position          | Sequence | Fidelity |
| ----------------- | -------- | -------- |
| oh1 (5' boundary) | AAAA     | 0.9502   |
| oh2 (3' boundary) | AAAA     | 0.9502   |

**Variants:** 14490 mutations, 14490 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name              | Length  | 5' OH | 3' OH |
| --- | --------------- | ---------------------- | ------- | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile10_sub1   | 1040 nt | ATGG  | GAAA  |
| 2   | 5'WT gene block | bsai_5wt_tile12_sub2   | 601 nt  | GAAA  | AAAA  |
| 3   | Oligo pool      | Tile 12 (14490 oligos) | 275 nt  | AAAA  | AGAA  |
| 4   | Helper plasmid  | helper_plasmid_insert  | --      | --    | --    |
| 5   | Enzyme + buffer | BsaI-HFv2 + CutSmart   | --      | --    | --    |

```
  [ATGG]----5'WT sub1----[GAAA]----5'WT sub2----[AAAA]----oligo+BC----[AGAA]
   ATGG                   GAAA                   AAAA                  AGAA 
```

**Set fidelity:** 0.9605 (4 overhangs)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------ | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)      | --      | --    | --    |
| 2   | 3'WT block        | bsmbi_3wt_tile12_sub1    | 936 nt  | AAAA  | GAAA  |
| 3   | 3'WT block        | bsmbi_3wt_tile1_sub3     | 1095 nt | GAAA  | GAAA  |
| 4   | 3'WT block        | bsmbi_3wt_tile1_sub4     | 1788 nt | GAAA  | GAAA  |
| 5   | 3'WT+PolIII block | bsmbi_3wt_tile1_sub5     | 1229 nt | GAAA  | CACC  |
| 6   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1 | --      | --    | --    |

```
  [AAAA]----3'WT sub1----[GAAA]----3'WT sub2----[GAAA]----3'WT sub3----[GAAA]----3'WT+PolIII sub4----[CACC]
   AAAA                   GAAA                   GAAA                   GAAA                          CACC 
```

**Set fidelity:** 0.9814 (3 overhangs)

---

### Tile 13 of 37 -- Codons 605-668 (192 nt)

**Boundary overhangs:**

| Position          | Sequence | Fidelity |
| ----------------- | -------- | -------- |
| oh1 (5' boundary) | TTTT     | 0.8623   |
| oh2 (3' boundary) | TCCT     | 0.7573   |

**Variants:** 12600 mutations, 12600 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name              | Length  | 5' OH | 3' OH |
| --- | --------------- | ---------------------- | ------- | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile10_sub1   | 1040 nt | ATGG  | GAAA  |
| 2   | 5'WT gene block | bsai_5wt_tile13_sub2   | 808 nt  | GAAA  | TTTT  |
| 3   | Oligo pool      | Tile 13 (12600 oligos) | 248 nt  | TTTT  | AGAA  |
| 4   | Helper plasmid  | helper_plasmid_insert  | --      | --    | --    |
| 5   | Enzyme + buffer | BsaI-HFv2 + CutSmart   | --      | --    | --    |

```
  [ATGG]----5'WT sub1----[GAAA]----5'WT sub2----[TTTT]----oligo+BC----[AGAA]
   ATGG                   GAAA                   TTTT                  AGAA 
```

**Set fidelity:** 1.0000 (4 overhangs)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------ | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)      | --      | --    | --    |
| 2   | 3'WT block        | bsmbi_3wt_tile13_sub1    | 756 nt  | TCCT  | GAAA  |
| 3   | 3'WT block        | bsmbi_3wt_tile1_sub3     | 1095 nt | GAAA  | GAAA  |
| 4   | 3'WT block        | bsmbi_3wt_tile1_sub4     | 1788 nt | GAAA  | GAAA  |
| 5   | 3'WT+PolIII block | bsmbi_3wt_tile1_sub5     | 1229 nt | GAAA  | CACC  |
| 6   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1 | --      | --    | --    |

```
  [TCCT]----3'WT sub1----[GAAA]----3'WT sub2----[GAAA]----3'WT sub3----[GAAA]----3'WT+PolIII sub4----[CACC]
   TCCT                   GAAA                   GAAA                   GAAA                          CACC 
```

**Set fidelity:** 1.0000 (3 overhangs)

---

### Tile 14 of 37 -- Codons 665-698 (102 nt)

**Boundary overhangs:**

| Position          | Sequence | Fidelity |
| ----------------- | -------- | -------- |
| oh1 (5' boundary) | TTTT     | 0.8623   |
| oh2 (3' boundary) | AATA     | 0.8816   |

**Variants:** 6300 mutations, 6300 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name             | Length  | 5' OH | 3' OH |
| --- | --------------- | --------------------- | ------- | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile10_sub1  | 1040 nt | ATGG  | GAAA  |
| 2   | 5'WT gene block | bsai_5wt_tile14_sub2  | 988 nt  | GAAA  | TTTT  |
| 3   | Oligo pool      | Tile 14 (6300 oligos) | 158 nt  | TTTT  | AGAA  |
| 4   | Helper plasmid  | helper_plasmid_insert | --      | --    | --    |
| 5   | Enzyme + buffer | BsaI-HFv2 + CutSmart  | --      | --    | --    |

```
  [ATGG]----5'WT sub1----[GAAA]----5'WT sub2----[TTTT]----oligo+BC----[AGAA]
   ATGG                   GAAA                   TTTT                  AGAA 
```

**Set fidelity:** 1.0000 (4 overhangs)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------ | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)      | --      | --    | --    |
| 2   | 3'WT block        | bsmbi_3wt_tile14_sub1    | 666 nt  | AATA  | GAAA  |
| 3   | 3'WT block        | bsmbi_3wt_tile1_sub3     | 1095 nt | GAAA  | GAAA  |
| 4   | 3'WT block        | bsmbi_3wt_tile1_sub4     | 1788 nt | GAAA  | GAAA  |
| 5   | 3'WT+PolIII block | bsmbi_3wt_tile1_sub5     | 1229 nt | GAAA  | CACC  |
| 6   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1 | --      | --    | --    |

```
  [AATA]----3'WT sub1----[GAAA]----3'WT sub2----[GAAA]----3'WT sub3----[GAAA]----3'WT+PolIII sub4----[CACC]
   AATA                   GAAA                   GAAA                   GAAA                          CACC 
```

**Set fidelity:** 1.0000 (3 overhangs)

---

### Tile 15 of 37 -- Codons 695-764 (210 nt)

**Boundary overhangs:**

| Position          | Sequence | Fidelity |
| ----------------- | -------- | -------- |
| oh1 (5' boundary) | GAAT     | 0.7246   |
| oh2 (3' boundary) | ATAC     | 0.6804   |

**Variants:** 13860 mutations, 13860 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name              | Length  | 5' OH | 3' OH |
| --- | --------------- | ---------------------- | ------- | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile10_sub1   | 1040 nt | ATGG  | GAAA  |
| 2   | 5'WT gene block | bsai_5wt_tile15_sub2   | 1078 nt | GAAA  | GAAT  |
| 3   | Oligo pool      | Tile 15 (13860 oligos) | 266 nt  | GAAT  | AGAA  |
| 4   | Helper plasmid  | helper_plasmid_insert  | --      | --    | --    |
| 5   | Enzyme + buffer | BsaI-HFv2 + CutSmart   | --      | --    | --    |

```
  [ATGG]----5'WT sub1----[GAAA]----5'WT sub2----[GAAT]----oligo+BC----[AGAA]
   ATGG                   GAAA                   GAAT                  AGAA 
```

**Set fidelity:** 0.9218 (4 overhangs)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------ | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)      | --      | --    | --    |
| 2   | 3'WT block        | bsmbi_3wt_tile15_sub1    | 468 nt  | ATAC  | GAAA  |
| 3   | 3'WT block        | bsmbi_3wt_tile1_sub3     | 1095 nt | GAAA  | GAAA  |
| 4   | 3'WT block        | bsmbi_3wt_tile1_sub4     | 1788 nt | GAAA  | GAAA  |
| 5   | 3'WT+PolIII block | bsmbi_3wt_tile1_sub5     | 1229 nt | GAAA  | CACC  |
| 6   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1 | --      | --    | --    |

```
  [ATAC]----3'WT sub1----[GAAA]----3'WT sub2----[GAAA]----3'WT sub3----[GAAA]----3'WT+PolIII sub4----[CACC]
   ATAC                   GAAA                   GAAA                   GAAA                          CACC 
```

**Set fidelity:** 1.0000 (3 overhangs)

---

### Tile 16 of 37 -- Codons 761-797 (111 nt)

**Boundary overhangs:**

| Position          | Sequence | Fidelity |
| ----------------- | -------- | -------- |
| oh1 (5' boundary) | AAAA     | 0.9502   |
| oh2 (3' boundary) | TACT     | 0.7445   |

**Variants:** 6930 mutations, 6930 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name             | Length  | 5' OH | 3' OH |
| --- | --------------- | --------------------- | ------- | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile10_sub1  | 1040 nt | ATGG  | GAAA  |
| 2   | 5'WT gene block | bsai_5wt_tile16_sub2  | 1276 nt | GAAA  | AAAA  |
| 3   | Oligo pool      | Tile 16 (6930 oligos) | 167 nt  | AAAA  | AGAA  |
| 4   | Helper plasmid  | helper_plasmid_insert | --      | --    | --    |
| 5   | Enzyme + buffer | BsaI-HFv2 + CutSmart  | --      | --    | --    |

```
  [ATGG]----5'WT sub1----[GAAA]----5'WT sub2----[AAAA]----oligo+BC----[AGAA]
   ATGG                   GAAA                   AAAA                  AGAA 
```

**Set fidelity:** 0.9605 (4 overhangs)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------ | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)      | --      | --    | --    |
| 2   | 3'WT block        | bsmbi_3wt_tile16_sub1    | 369 nt  | TACT  | GAAA  |
| 3   | 3'WT block        | bsmbi_3wt_tile1_sub3     | 1095 nt | GAAA  | GAAA  |
| 4   | 3'WT block        | bsmbi_3wt_tile1_sub4     | 1788 nt | GAAA  | GAAA  |
| 5   | 3'WT+PolIII block | bsmbi_3wt_tile1_sub5     | 1229 nt | GAAA  | CACC  |
| 6   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1 | --      | --    | --    |

```
  [TACT]----3'WT sub1----[GAAA]----3'WT sub2----[GAAA]----3'WT sub3----[GAAA]----3'WT+PolIII sub4----[CACC]
   TACT                   GAAA                   GAAA                   GAAA                          CACC 
```

**Set fidelity:** 0.9986 (3 overhangs)

---

### Tile 17 of 37 -- Codons 794-867 (222 nt)

**Boundary overhangs:**

| Position          | Sequence | Fidelity |
| ----------------- | -------- | -------- |
| oh1 (5' boundary) | ATTT     | 0.7664   |
| oh2 (3' boundary) | AAAT     | 0.7737   |

**Variants:** 14700 mutations, 14700 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name              | Length  | 5' OH | 3' OH |
| --- | --------------- | ---------------------- | ------- | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile10_sub1   | 1040 nt | ATGG  | GAAA  |
| 2   | 5'WT gene block | bsai_5wt_tile17_sub2   | 1375 nt | GAAA  | ATTT  |
| 3   | Oligo pool      | Tile 17 (14700 oligos) | 278 nt  | ATTT  | AGAA  |
| 4   | Helper plasmid  | helper_plasmid_insert  | --      | --    | --    |
| 5   | Enzyme + buffer | BsaI-HFv2 + CutSmart   | --      | --    | --    |

```
  [ATGG]----5'WT sub1----[GAAA]----5'WT sub2----[ATTT]----oligo+BC----[AGAA]
   ATGG                   GAAA                   ATTT                  AGAA 
```

**Set fidelity:** 1.0000 (4 overhangs)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------ | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)      | --      | --    | --    |
| 2   | 3'WT block        | bsmbi_3wt_tile17_sub1    | 1236 nt | AAAT  | GAAA  |
| 3   | 3'WT block        | bsmbi_3wt_tile1_sub4     | 1788 nt | GAAA  | GAAA  |
| 4   | 3'WT+PolIII block | bsmbi_3wt_tile1_sub5     | 1229 nt | GAAA  | CACC  |
| 5   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1 | --      | --    | --    |

```
  [AAAT]----3'WT sub1----[GAAA]----3'WT sub2----[GAAA]----3'WT+PolIII sub3----[GAAA][CACC]
   AAAT                   GAAA                   GAAA                          GAAA  CACC 
```

**Set fidelity:** 1.0000 (3 overhangs)

---

### Tile 18 of 37 -- Codons 864-918 (165 nt)

**Boundary overhangs:**

| Position          | Sequence | Fidelity |
| ----------------- | -------- | -------- |
| oh1 (5' boundary) | AAAT     | 0.7737   |
| oh2 (3' boundary) | ATTT     | 0.7664   |

**Variants:** 10710 mutations, 10710 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name              | Length  | 5' OH | 3' OH |
| --- | --------------- | ---------------------- | ------- | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile10_sub1   | 1040 nt | ATGG  | GAAA  |
| 2   | 5'WT gene block | bsai_5wt_tile18_sub2   | 1585 nt | GAAA  | AAAT  |
| 3   | Oligo pool      | Tile 18 (10710 oligos) | 221 nt  | AAAT  | AGAA  |
| 4   | Helper plasmid  | helper_plasmid_insert  | --      | --    | --    |
| 5   | Enzyme + buffer | BsaI-HFv2 + CutSmart   | --      | --    | --    |

```
  [ATGG]----5'WT sub1----[GAAA]----5'WT sub2----[AAAT]----oligo+BC----[AGAA]
   ATGG                   GAAA                   AAAT                  AGAA 
```

**Set fidelity:** 1.0000 (4 overhangs)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------ | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)      | --      | --    | --    |
| 2   | 3'WT block        | bsmbi_3wt_tile18_sub1    | 1083 nt | ATTT  | GAAA  |
| 3   | 3'WT block        | bsmbi_3wt_tile1_sub4     | 1788 nt | GAAA  | GAAA  |
| 4   | 3'WT+PolIII block | bsmbi_3wt_tile1_sub5     | 1229 nt | GAAA  | CACC  |
| 5   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1 | --      | --    | --    |

```
  [ATTT]----3'WT sub1----[GAAA]----3'WT sub2----[GAAA]----3'WT+PolIII sub3----[CACC]
   ATTT                   GAAA                   GAAA                          CACC 
```

**Set fidelity:** 1.0000 (3 overhangs)

---

### Tile 19 of 37 -- Codons 915-988 (222 nt)

**Boundary overhangs:**

| Position          | Sequence | Fidelity |
| ----------------- | -------- | -------- |
| oh1 (5' boundary) | ACCC     | 0.5528   |
| oh2 (3' boundary) | ATTT     | 0.7664   |

**Variants:** 14700 mutations, 14700 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name              | Length  | 5' OH | 3' OH |
| --- | --------------- | ---------------------- | ------- | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile10_sub1   | 1040 nt | ATGG  | GAAA  |
| 2   | 5'WT gene block | bsai_5wt_tile19_sub2   | 1738 nt | GAAA  | ACCC  |
| 3   | Oligo pool      | Tile 19 (14700 oligos) | 278 nt  | ACCC  | AGAA  |
| 4   | Helper plasmid  | helper_plasmid_insert  | --      | --    | --    |
| 5   | Enzyme + buffer | BsaI-HFv2 + CutSmart   | --      | --    | --    |

```
  [ATGG]----5'WT sub1----[GAAA]----5'WT sub2----[GAAA]----oligo+BC----[ACCC][AGAA]
   ATGG                   GAAA                   GAAA                  ACCC  AGAA 
```

**Set fidelity:** 1.0000 (4 overhangs)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------ | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)      | --      | --    | --    |
| 2   | 3'WT block        | bsmbi_3wt_tile19_sub1    | 873 nt  | ATTT  | GAAA  |
| 3   | 3'WT block        | bsmbi_3wt_tile1_sub4     | 1788 nt | GAAA  | GAAA  |
| 4   | 3'WT+PolIII block | bsmbi_3wt_tile1_sub5     | 1229 nt | GAAA  | CACC  |
| 5   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1 | --      | --    | --    |

```
  [ATTT]----3'WT sub1----[GAAA]----3'WT sub2----[GAAA]----3'WT+PolIII sub3----[CACC]
   ATTT                   GAAA                   GAAA                          CACC 
```

**Set fidelity:** 1.0000 (3 overhangs)

---

### Tile 20 of 37 -- Codons 985-1049 (195 nt)

**Boundary overhangs:**

| Position          | Sequence | Fidelity |
| ----------------- | -------- | -------- |
| oh1 (5' boundary) | TCTC     | 0.8105   |
| oh2 (3' boundary) | TAAC     | 0.7715   |

**Variants:** 12810 mutations, 12810 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name              | Length  | 5' OH | 3' OH |
| --- | --------------- | ---------------------- | ------- | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile10_sub1   | 1040 nt | ATGG  | GAAA  |
| 2   | 5'WT gene block | bsai_5wt_tile20_sub2   | 1734 nt | GAAA  | GAAA  |
| 3   | 5'WT gene block | bsai_5wt_tile20_sub3   | 232 nt  | GAAA  | TCTC  |
| 4   | Oligo pool      | Tile 20 (12810 oligos) | 251 nt  | TCTC  | AGAA  |
| 5   | Helper plasmid  | helper_plasmid_insert  | --      | --    | --    |
| 6   | Enzyme + buffer | BsaI-HFv2 + CutSmart   | --      | --    | --    |

```
  [ATGG]----5'WT sub1----[GAAA]----5'WT sub2----[GAAA]----5'WT sub3----[TCTC]----oligo+BC----[AGAA]
   ATGG                   GAAA                   GAAA                   TCTC                  AGAA 
```

**Set fidelity:** 1.0000 (4 overhangs)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------ | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)      | --      | --    | --    |
| 2   | 3'WT block        | bsmbi_3wt_tile20_sub1    | 690 nt  | TAAC  | GAAA  |
| 3   | 3'WT block        | bsmbi_3wt_tile1_sub4     | 1788 nt | GAAA  | GAAA  |
| 4   | 3'WT+PolIII block | bsmbi_3wt_tile1_sub5     | 1229 nt | GAAA  | CACC  |
| 5   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1 | --      | --    | --    |

```
  [TAAC]----3'WT sub1----[GAAA]----3'WT sub2----[GAAA]----3'WT+PolIII sub3----[CACC]
   TAAC                   GAAA                   GAAA                          CACC 
```

**Set fidelity:** 0.9983 (3 overhangs)

---

### Tile 21 of 37 -- Codons 1046-1106 (183 nt)

**Boundary overhangs:**

| Position          | Sequence | Fidelity |
| ----------------- | -------- | -------- |
| oh1 (5' boundary) | AAAA     | 0.9502   |
| oh2 (3' boundary) | TCTA     | 0.8892   |

**Variants:** 11970 mutations, 11970 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name              | Length  | 5' OH | 3' OH |
| --- | --------------- | ---------------------- | ------- | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile10_sub1   | 1040 nt | ATGG  | GAAA  |
| 2   | 5'WT gene block | bsai_5wt_tile20_sub2   | 1734 nt | GAAA  | GAAA  |
| 3   | 5'WT gene block | bsai_5wt_tile21_sub3   | 415 nt  | GAAA  | AAAA  |
| 4   | Oligo pool      | Tile 21 (11970 oligos) | 239 nt  | AAAA  | AGAA  |
| 5   | Helper plasmid  | helper_plasmid_insert  | --      | --    | --    |
| 6   | Enzyme + buffer | BsaI-HFv2 + CutSmart   | --      | --    | --    |

```
  [ATGG]----5'WT sub1----[GAAA]----5'WT sub2----[GAAA]----5'WT sub3----[AAAA]----oligo+BC----[AGAA]
   ATGG                   GAAA                   GAAA                   AAAA                  AGAA 
```

**Set fidelity:** 0.9605 (4 overhangs)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------ | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)      | --      | --    | --    |
| 2   | 3'WT block        | bsmbi_3wt_tile21_sub1    | 519 nt  | TCTA  | GAAA  |
| 3   | 3'WT block        | bsmbi_3wt_tile1_sub4     | 1788 nt | GAAA  | GAAA  |
| 4   | 3'WT+PolIII block | bsmbi_3wt_tile1_sub5     | 1229 nt | GAAA  | CACC  |
| 5   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1 | --      | --    | --    |

```
  [TCTA]----3'WT sub1----[GAAA]----3'WT sub2----[GAAA]----3'WT+PolIII sub3----[CACC]
   TCTA                   GAAA                   GAAA                          CACC 
```

**Set fidelity:** 1.0000 (3 overhangs)

---

### Tile 22 of 37 -- Codons 1103-1159 (171 nt)

**Boundary overhangs:**

| Position          | Sequence | Fidelity |
| ----------------- | -------- | -------- |
| oh1 (5' boundary) | TCAA     | 0.9425   |
| oh2 (3' boundary) | AAAA     | 0.9502   |

**Variants:** 11130 mutations, 11130 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name              | Length  | 5' OH | 3' OH |
| --- | --------------- | ---------------------- | ------- | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile10_sub1   | 1040 nt | ATGG  | GAAA  |
| 2   | 5'WT gene block | bsai_5wt_tile20_sub2   | 1734 nt | GAAA  | GAAA  |
| 3   | 5'WT gene block | bsai_5wt_tile22_sub3   | 586 nt  | GAAA  | TCAA  |
| 4   | Oligo pool      | Tile 22 (11130 oligos) | 227 nt  | TCAA  | AGAA  |
| 5   | Helper plasmid  | helper_plasmid_insert  | --      | --    | --    |
| 6   | Enzyme + buffer | BsaI-HFv2 + CutSmart   | --      | --    | --    |

```
  [ATGG]----5'WT sub1----[GAAA]----5'WT sub2----[GAAA]----5'WT sub3----[TCAA]----oligo+BC----[AGAA]
   ATGG                   GAAA                   GAAA                   TCAA                  AGAA 
```

**Set fidelity:** 1.0000 (4 overhangs)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------ | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)      | --      | --    | --    |
| 2   | 3'WT block        | bsmbi_3wt_tile22_sub1    | 360 nt  | AAAA  | GAAA  |
| 3   | 3'WT block        | bsmbi_3wt_tile1_sub4     | 1788 nt | GAAA  | GAAA  |
| 4   | 3'WT+PolIII block | bsmbi_3wt_tile1_sub5     | 1229 nt | GAAA  | CACC  |
| 5   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1 | --      | --    | --    |

```
  [AAAA]----3'WT sub1----[GAAA]----3'WT sub2----[GAAA]----3'WT+PolIII sub3----[CACC]
   AAAA                   GAAA                   GAAA                          CACC 
```

**Set fidelity:** 0.9814 (3 overhangs)

---

### Tile 23 of 37 -- Codons 1156-1224 (207 nt)

**Boundary overhangs:**

| Position          | Sequence | Fidelity |
| ----------------- | -------- | -------- |
| oh1 (5' boundary) | ACTA     | 0.7946   |
| oh2 (3' boundary) | TCAA     | 0.9425   |

**Variants:** 13650 mutations, 13650 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name              | Length  | 5' OH | 3' OH |
| --- | --------------- | ---------------------- | ------- | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile10_sub1   | 1040 nt | ATGG  | GAAA  |
| 2   | 5'WT gene block | bsai_5wt_tile20_sub2   | 1734 nt | GAAA  | GAAA  |
| 3   | 5'WT gene block | bsai_5wt_tile23_sub3   | 745 nt  | GAAA  | ACTA  |
| 4   | Oligo pool      | Tile 23 (13650 oligos) | 263 nt  | ACTA  | AGAA  |
| 5   | Helper plasmid  | helper_plasmid_insert  | --      | --    | --    |
| 6   | Enzyme + buffer | BsaI-HFv2 + CutSmart   | --      | --    | --    |

```
  [ATGG]----5'WT sub1----[GAAA]----5'WT sub2----[GAAA]----5'WT sub3----[ACTA]----oligo+BC----[AGAA]
   ATGG                   GAAA                   GAAA                   ACTA                  AGAA 
```

**Set fidelity:** 1.0000 (4 overhangs)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------ | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)      | --      | --    | --    |
| 2   | 3'WT block        | bsmbi_3wt_tile23_sub1    | 165 nt  | TCAA  | GAAA  |
| 3   | 3'WT block        | bsmbi_3wt_tile1_sub4     | 1788 nt | GAAA  | GAAA  |
| 4   | 3'WT+PolIII block | bsmbi_3wt_tile1_sub5     | 1229 nt | GAAA  | CACC  |
| 5   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1 | --      | --    | --    |

```
  [TCAA]----3'WT sub1----[GAAA]----3'WT sub2----[GAAA]----3'WT+PolIII sub3----[CACC]
   TCAA                   GAAA                   GAAA                          CACC 
```

**Set fidelity:** 1.0000 (3 overhangs)

---

### Tile 24 of 37 -- Codons 1221-1277 (171 nt)

**Boundary overhangs:**

| Position          | Sequence | Fidelity |
| ----------------- | -------- | -------- |
| oh1 (5' boundary) | AAAA     | 0.9502   |
| oh2 (3' boundary) | AGTC     | 0.5938   |

**Variants:** 11130 mutations, 11130 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name              | Length  | 5' OH | 3' OH |
| --- | --------------- | ---------------------- | ------- | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile10_sub1   | 1040 nt | ATGG  | GAAA  |
| 2   | 5'WT gene block | bsai_5wt_tile20_sub2   | 1734 nt | GAAA  | GAAA  |
| 3   | 5'WT gene block | bsai_5wt_tile24_sub3   | 940 nt  | GAAA  | AAAA  |
| 4   | Oligo pool      | Tile 24 (11130 oligos) | 227 nt  | AAAA  | AGAA  |
| 5   | Helper plasmid  | helper_plasmid_insert  | --      | --    | --    |
| 6   | Enzyme + buffer | BsaI-HFv2 + CutSmart   | --      | --    | --    |

```
  [ATGG]----5'WT sub1----[GAAA]----5'WT sub2----[GAAA]----5'WT sub3----[AAAA]----oligo+BC----[AGAA]
   ATGG                   GAAA                   GAAA                   AAAA                  AGAA 
```

**Set fidelity:** 0.9605 (4 overhangs)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------ | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)      | --      | --    | --    |
| 2   | 3'WT block        | bsmbi_3wt_tile24_sub1    | 1776 nt | AGTC  | GAAA  |
| 3   | 3'WT+PolIII block | bsmbi_3wt_tile1_sub5     | 1229 nt | GAAA  | CACC  |
| 4   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1 | --      | --    | --    |

```
  [AGTC]----3'WT sub1----[GAAA]----3'WT+PolIII sub2----[CACC]
   AGTC                   GAAA                          CACC 
```

**Set fidelity:** 1.0000 (3 overhangs)

---

### Tile 25 of 37 -- Codons 1274-1325 (156 nt)

**Boundary overhangs:**

| Position          | Sequence | Fidelity |
| ----------------- | -------- | -------- |
| oh1 (5' boundary) | ATAG     | 0.7330   |
| oh2 (3' boundary) | AAGT     | 0.7629   |

**Variants:** 10080 mutations, 10080 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name              | Length  | 5' OH | 3' OH |
| --- | --------------- | ---------------------- | ------- | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile10_sub1   | 1040 nt | ATGG  | GAAA  |
| 2   | 5'WT gene block | bsai_5wt_tile20_sub2   | 1734 nt | GAAA  | GAAA  |
| 3   | 5'WT gene block | bsai_5wt_tile25_sub3   | 1099 nt | GAAA  | ATAG  |
| 4   | Oligo pool      | Tile 25 (10080 oligos) | 212 nt  | ATAG  | AGAA  |
| 5   | Helper plasmid  | helper_plasmid_insert  | --      | --    | --    |
| 6   | Enzyme + buffer | BsaI-HFv2 + CutSmart   | --      | --    | --    |

```
  [ATGG]----5'WT sub1----[GAAA]----5'WT sub2----[GAAA]----5'WT sub3----[GAAA]----oligo+BC----[ATAG][AGAA]
   ATGG                   GAAA                   GAAA                   GAAA                  ATAG  AGAA 
```

**Set fidelity:** 0.9376 (4 overhangs)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------ | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)      | --      | --    | --    |
| 2   | 3'WT block        | bsmbi_3wt_tile25_sub1    | 1632 nt | AAGT  | GAAA  |
| 3   | 3'WT+PolIII block | bsmbi_3wt_tile1_sub5     | 1229 nt | GAAA  | CACC  |
| 4   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1 | --      | --    | --    |

```
  [AAGT]----3'WT sub1----[GAAA]----3'WT+PolIII sub2----[CACC]
   AAGT                   GAAA                          CACC 
```

**Set fidelity:** 1.0000 (3 overhangs)

---

### Tile 26 of 37 -- Codons 1322-1354 (99 nt)

**Boundary overhangs:**

| Position          | Sequence | Fidelity |
| ----------------- | -------- | -------- |
| oh1 (5' boundary) | TTAC     | 0.8333   |
| oh2 (3' boundary) | AAAA     | 0.9502   |

**Variants:** 6090 mutations, 6090 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name             | Length  | 5' OH | 3' OH |
| --- | --------------- | --------------------- | ------- | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile10_sub1  | 1040 nt | ATGG  | GAAA  |
| 2   | 5'WT gene block | bsai_5wt_tile20_sub2  | 1734 nt | GAAA  | GAAA  |
| 3   | 5'WT gene block | bsai_5wt_tile26_sub3  | 1243 nt | GAAA  | TTAC  |
| 4   | Oligo pool      | Tile 26 (6090 oligos) | 155 nt  | TTAC  | AGAA  |
| 5   | Helper plasmid  | helper_plasmid_insert | --      | --    | --    |
| 6   | Enzyme + buffer | BsaI-HFv2 + CutSmart  | --      | --    | --    |

```
  [ATGG]----5'WT sub1----[GAAA]----5'WT sub2----[GAAA]----5'WT sub3----[GAAA]----oligo+BC----[TTAC][AGAA]
   ATGG                   GAAA                   GAAA                   GAAA                  TTAC  AGAA 
```

**Set fidelity:** 1.0000 (4 overhangs)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------ | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)      | --      | --    | --    |
| 2   | 3'WT block        | bsmbi_3wt_tile26_sub1    | 1545 nt | AAAA  | GAAA  |
| 3   | 3'WT+PolIII block | bsmbi_3wt_tile1_sub5     | 1229 nt | GAAA  | CACC  |
| 4   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1 | --      | --    | --    |

```
  [AAAA]----3'WT sub1----[GAAA]----3'WT+PolIII sub2----[CACC]
   AAAA                   GAAA                          CACC 
```

**Set fidelity:** 0.9814 (3 overhangs)

---

### Tile 27 of 37 -- Codons 1351-1388 (114 nt)

**Boundary overhangs:**

| Position          | Sequence | Fidelity |
| ----------------- | -------- | -------- |
| oh1 (5' boundary) | CAGA     | 0.8175   |
| oh2 (3' boundary) | CAAA     | 0.8948   |

**Variants:** 7140 mutations, 7140 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name             | Length  | 5' OH | 3' OH |
| --- | --------------- | --------------------- | ------- | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile10_sub1  | 1040 nt | ATGG  | GAAA  |
| 2   | 5'WT gene block | bsai_5wt_tile20_sub2  | 1734 nt | GAAA  | GAAA  |
| 3   | 5'WT gene block | bsai_5wt_tile27_sub3  | 1330 nt | GAAA  | CAGA  |
| 4   | Oligo pool      | Tile 27 (7140 oligos) | 170 nt  | CAGA  | AGAA  |
| 5   | Helper plasmid  | helper_plasmid_insert | --      | --    | --    |
| 6   | Enzyme + buffer | BsaI-HFv2 + CutSmart  | --      | --    | --    |

```
  [ATGG]----5'WT sub1----[GAAA]----5'WT sub2----[GAAA]----5'WT sub3----[GAAA]----oligo+BC----[CAGA][AGAA]
   ATGG                   GAAA                   GAAA                   GAAA                  CAGA  AGAA 
```

**Set fidelity:** 1.0000 (4 overhangs)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------ | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)      | --      | --    | --    |
| 2   | 3'WT block        | bsmbi_3wt_tile27_sub1    | 1443 nt | CAAA  | GAAA  |
| 3   | 3'WT+PolIII block | bsmbi_3wt_tile1_sub5     | 1229 nt | GAAA  | CACC  |
| 4   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1 | --      | --    | --    |

```
  [CAAA]----3'WT sub1----[GAAA]----3'WT+PolIII sub2----[CACC]
   CAAA                   GAAA                          CACC 
```

**Set fidelity:** 0.9988 (3 overhangs)

---

### Tile 28 of 37 -- Codons 1385-1431 (141 nt)

**Boundary overhangs:**

| Position          | Sequence | Fidelity |
| ----------------- | -------- | -------- |
| oh1 (5' boundary) | AAGA     | 0.9209   |
| oh2 (3' boundary) | TGAA     | 0.8621   |

**Variants:** 9030 mutations, 9030 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name             | Length  | 5' OH | 3' OH |
| --- | --------------- | --------------------- | ------- | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile10_sub1  | 1040 nt | ATGG  | GAAA  |
| 2   | 5'WT gene block | bsai_5wt_tile20_sub2  | 1734 nt | GAAA  | GAAA  |
| 3   | 5'WT gene block | bsai_5wt_tile28_sub3  | 1095 nt | GAAA  | GAAA  |
| 4   | 5'WT gene block | bsai_5wt_tile28_sub4  | 355 nt  | GAAA  | AAGA  |
| 5   | Oligo pool      | Tile 28 (9030 oligos) | 197 nt  | AAGA  | AGAA  |
| 6   | Helper plasmid  | helper_plasmid_insert | --      | --    | --    |
| 7   | Enzyme + buffer | BsaI-HFv2 + CutSmart  | --      | --    | --    |

```
  [ATGG]----5'WT sub1----[GAAA]----5'WT sub2----[GAAA]----5'WT sub3----[GAAA]----5'WT sub4----[AAGA]----oligo+BC----[AGAA]
   ATGG                   GAAA                   GAAA                   GAAA                   AAGA                  AGAA 
```

**Set fidelity:** 1.0000 (4 overhangs)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------ | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)      | --      | --    | --    |
| 2   | 3'WT block        | bsmbi_3wt_tile28_sub1    | 1314 nt | TGAA  | GAAA  |
| 3   | 3'WT+PolIII block | bsmbi_3wt_tile1_sub5     | 1229 nt | GAAA  | CACC  |
| 4   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1 | --      | --    | --    |

```
  [TGAA]----3'WT sub1----[GAAA]----3'WT+PolIII sub2----[CACC]
   TGAA                   GAAA                          CACC 
```

**Set fidelity:** 1.0000 (3 overhangs)

---

### Tile 29 of 37 -- Codons 1428-1492 (195 nt)

**Boundary overhangs:**

| Position          | Sequence | Fidelity |
| ----------------- | -------- | -------- |
| oh1 (5' boundary) | AAAA     | 0.9502   |
| oh2 (3' boundary) | AAAA     | 0.9502   |

**Variants:** 12810 mutations, 12810 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name              | Length  | 5' OH | 3' OH |
| --- | --------------- | ---------------------- | ------- | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile10_sub1   | 1040 nt | ATGG  | GAAA  |
| 2   | 5'WT gene block | bsai_5wt_tile20_sub2   | 1734 nt | GAAA  | GAAA  |
| 3   | 5'WT gene block | bsai_5wt_tile28_sub3   | 1095 nt | GAAA  | GAAA  |
| 4   | 5'WT gene block | bsai_5wt_tile29_sub4   | 484 nt  | GAAA  | AAAA  |
| 5   | Oligo pool      | Tile 29 (12810 oligos) | 251 nt  | AAAA  | AGAA  |
| 6   | Helper plasmid  | helper_plasmid_insert  | --      | --    | --    |
| 7   | Enzyme + buffer | BsaI-HFv2 + CutSmart   | --      | --    | --    |

```
  [ATGG]----5'WT sub1----[GAAA]----5'WT sub2----[GAAA]----5'WT sub3----[GAAA]----5'WT sub4----[AAAA]----oligo+BC----[AGAA]
   ATGG                   GAAA                   GAAA                   GAAA                   AAAA                  AGAA 
```

**Set fidelity:** 0.9605 (4 overhangs)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------ | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)      | --      | --    | --    |
| 2   | 3'WT block        | bsmbi_3wt_tile29_sub1    | 1131 nt | AAAA  | GAAA  |
| 3   | 3'WT+PolIII block | bsmbi_3wt_tile1_sub5     | 1229 nt | GAAA  | CACC  |
| 4   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1 | --      | --    | --    |

```
  [AAAA]----3'WT sub1----[GAAA]----3'WT+PolIII sub2----[CACC]
   AAAA                   GAAA                          CACC 
```

**Set fidelity:** 0.9814 (3 overhangs)

---

### Tile 30 of 37 -- Codons 1489-1557 (207 nt)

**Boundary overhangs:**

| Position          | Sequence | Fidelity |
| ----------------- | -------- | -------- |
| oh1 (5' boundary) | TTGT     | 0.7145   |
| oh2 (3' boundary) | AGGA     | 0.7515   |

**Variants:** 13650 mutations, 13650 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name              | Length  | 5' OH | 3' OH |
| --- | --------------- | ---------------------- | ------- | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile10_sub1   | 1040 nt | ATGG  | GAAA  |
| 2   | 5'WT gene block | bsai_5wt_tile20_sub2   | 1734 nt | GAAA  | GAAA  |
| 3   | 5'WT gene block | bsai_5wt_tile28_sub3   | 1095 nt | GAAA  | GAAA  |
| 4   | 5'WT gene block | bsai_5wt_tile30_sub4   | 667 nt  | GAAA  | TTGT  |
| 5   | Oligo pool      | Tile 30 (13650 oligos) | 263 nt  | TTGT  | AGAA  |
| 6   | Helper plasmid  | helper_plasmid_insert  | --      | --    | --    |
| 7   | Enzyme + buffer | BsaI-HFv2 + CutSmart   | --      | --    | --    |

```
  [ATGG]----5'WT sub1----[GAAA]----5'WT sub2----[GAAA]----5'WT sub3----[GAAA]----5'WT sub4----[TTGT]----oligo+BC----[AGAA]
   ATGG                   GAAA                   GAAA                   GAAA                   TTGT                  AGAA 
```

**Set fidelity:** 1.0000 (4 overhangs)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------ | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)      | --      | --    | --    |
| 2   | 3'WT block        | bsmbi_3wt_tile30_sub1    | 936 nt  | AGGA  | GAAA  |
| 3   | 3'WT+PolIII block | bsmbi_3wt_tile1_sub5     | 1229 nt | GAAA  | CACC  |
| 4   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1 | --      | --    | --    |

```
  [AGGA]----3'WT sub1----[GAAA]----3'WT+PolIII sub2----[CACC]
   AGGA                   GAAA                          CACC 
```

**Set fidelity:** 1.0000 (3 overhangs)

---

### Tile 31 of 37 -- Codons 1554-1622 (207 nt)

**Boundary overhangs:**

| Position          | Sequence | Fidelity |
| ----------------- | -------- | -------- |
| oh1 (5' boundary) | CTAA     | 0.8691   |
| oh2 (3' boundary) | AAAA     | 0.9502   |

**Variants:** 13650 mutations, 13650 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name              | Length  | 5' OH | 3' OH |
| --- | --------------- | ---------------------- | ------- | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile10_sub1   | 1040 nt | ATGG  | GAAA  |
| 2   | 5'WT gene block | bsai_5wt_tile20_sub2   | 1734 nt | GAAA  | GAAA  |
| 3   | 5'WT gene block | bsai_5wt_tile28_sub3   | 1095 nt | GAAA  | GAAA  |
| 4   | 5'WT gene block | bsai_5wt_tile31_sub4   | 862 nt  | GAAA  | CTAA  |
| 5   | Oligo pool      | Tile 31 (13650 oligos) | 263 nt  | CTAA  | AGAA  |
| 6   | Helper plasmid  | helper_plasmid_insert  | --      | --    | --    |
| 7   | Enzyme + buffer | BsaI-HFv2 + CutSmart   | --      | --    | --    |

```
  [ATGG]----5'WT sub1----[GAAA]----5'WT sub2----[GAAA]----5'WT sub3----[GAAA]----5'WT sub4----[CTAA]----oligo+BC----[AGAA]
   ATGG                   GAAA                   GAAA                   GAAA                   CTAA                  AGAA 
```

**Set fidelity:** 1.0000 (4 overhangs)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------ | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)      | --      | --    | --    |
| 2   | 3'WT block        | bsmbi_3wt_tile31_sub1    | 741 nt  | AAAA  | GAAA  |
| 3   | 3'WT+PolIII block | bsmbi_3wt_tile1_sub5     | 1229 nt | GAAA  | CACC  |
| 4   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1 | --      | --    | --    |

```
  [AAAA]----3'WT sub1----[GAAA]----3'WT+PolIII sub2----[CACC]
   AAAA                   GAAA                          CACC 
```

**Set fidelity:** 0.9814 (3 overhangs)

---

### Tile 32 of 37 -- Codons 1619-1661 (129 nt)

**Boundary overhangs:**

| Position          | Sequence | Fidelity |
| ----------------- | -------- | -------- |
| oh1 (5' boundary) | TCTA     | 0.8892   |
| oh2 (3' boundary) | AAAA     | 0.9502   |

**Variants:** 8190 mutations, 8190 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name             | Length  | 5' OH | 3' OH |
| --- | --------------- | --------------------- | ------- | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile10_sub1  | 1040 nt | ATGG  | GAAA  |
| 2   | 5'WT gene block | bsai_5wt_tile20_sub2  | 1734 nt | GAAA  | GAAA  |
| 3   | 5'WT gene block | bsai_5wt_tile28_sub3  | 1095 nt | GAAA  | GAAA  |
| 4   | 5'WT gene block | bsai_5wt_tile32_sub4  | 1057 nt | GAAA  | TCTA  |
| 5   | Oligo pool      | Tile 32 (8190 oligos) | 185 nt  | TCTA  | AGAA  |
| 6   | Helper plasmid  | helper_plasmid_insert | --      | --    | --    |
| 7   | Enzyme + buffer | BsaI-HFv2 + CutSmart  | --      | --    | --    |

```
  [ATGG]----5'WT sub1----[GAAA]----5'WT sub2----[GAAA]----5'WT sub3----[GAAA]----5'WT sub4----[TCTA]----oligo+BC----[AGAA]
   ATGG                   GAAA                   GAAA                   GAAA                   TCTA                  AGAA 
```

**Set fidelity:** 1.0000 (4 overhangs)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------ | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)      | --      | --    | --    |
| 2   | 3'WT block        | bsmbi_3wt_tile32_sub1    | 624 nt  | AAAA  | GAAA  |
| 3   | 3'WT+PolIII block | bsmbi_3wt_tile1_sub5     | 1229 nt | GAAA  | CACC  |
| 4   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1 | --      | --    | --    |

```
  [AAAA]----3'WT sub1----[GAAA]----3'WT+PolIII sub2----[CACC]
   AAAA                   GAAA                          CACC 
```

**Set fidelity:** 0.9814 (3 overhangs)

---

### Tile 33 of 37 -- Codons 1658-1710 (159 nt)

**Boundary overhangs:**

| Position          | Sequence | Fidelity |
| ----------------- | -------- | -------- |
| oh1 (5' boundary) | GCCA     | 0.5727   |
| oh2 (3' boundary) | AATA     | 0.8816   |

**Variants:** 10290 mutations, 10290 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name              | Length  | 5' OH | 3' OH |
| --- | --------------- | ---------------------- | ------- | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile10_sub1   | 1040 nt | ATGG  | GAAA  |
| 2   | 5'WT gene block | bsai_5wt_tile20_sub2   | 1734 nt | GAAA  | GAAA  |
| 3   | 5'WT gene block | bsai_5wt_tile28_sub3   | 1095 nt | GAAA  | GAAA  |
| 4   | 5'WT gene block | bsai_5wt_tile33_sub4   | 1174 nt | GAAA  | GCCA  |
| 5   | Oligo pool      | Tile 33 (10290 oligos) | 215 nt  | GCCA  | AGAA  |
| 6   | Helper plasmid  | helper_plasmid_insert  | --      | --    | --    |
| 7   | Enzyme + buffer | BsaI-HFv2 + CutSmart   | --      | --    | --    |

```
  [ATGG]----5'WT sub1----[GAAA]----5'WT sub2----[GAAA]----5'WT sub3----[GAAA]----5'WT sub4----[GCCA]----oligo+BC----[AGAA]
   ATGG                   GAAA                   GAAA                   GAAA                   GCCA                  AGAA 
```

**Set fidelity:** 1.0000 (4 overhangs)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------ | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)      | --      | --    | --    |
| 2   | 3'WT block        | bsmbi_3wt_tile33_sub1    | 477 nt  | AATA  | GAAA  |
| 3   | 3'WT+PolIII block | bsmbi_3wt_tile1_sub5     | 1229 nt | GAAA  | CACC  |
| 4   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1 | --      | --    | --    |

```
  [AATA]----3'WT sub1----[GAAA]----3'WT+PolIII sub2----[CACC]
   AATA                   GAAA                          CACC 
```

**Set fidelity:** 1.0000 (3 overhangs)

---

### Tile 34 of 37 -- Codons 1707-1758 (156 nt)

**Boundary overhangs:**

| Position          | Sequence | Fidelity |
| ----------------- | -------- | -------- |
| oh1 (5' boundary) | TCAA     | 0.9425   |
| oh2 (3' boundary) | AAGT     | 0.7629   |

**Variants:** 10080 mutations, 10080 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name              | Length  | 5' OH | 3' OH |
| --- | --------------- | ---------------------- | ------- | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile10_sub1   | 1040 nt | ATGG  | GAAA  |
| 2   | 5'WT gene block | bsai_5wt_tile20_sub2   | 1734 nt | GAAA  | GAAA  |
| 3   | 5'WT gene block | bsai_5wt_tile28_sub3   | 1095 nt | GAAA  | GAAA  |
| 4   | 5'WT gene block | bsai_5wt_tile34_sub4   | 1321 nt | GAAA  | TCAA  |
| 5   | Oligo pool      | Tile 34 (10080 oligos) | 212 nt  | TCAA  | AGAA  |
| 6   | Helper plasmid  | helper_plasmid_insert  | --      | --    | --    |
| 7   | Enzyme + buffer | BsaI-HFv2 + CutSmart   | --      | --    | --    |

```
  [ATGG]----5'WT sub1----[GAAA]----5'WT sub2----[GAAA]----5'WT sub3----[GAAA]----5'WT sub4----[TCAA]----oligo+BC----[AGAA]
   ATGG                   GAAA                   GAAA                   GAAA                   TCAA                  AGAA 
```

**Set fidelity:** 1.0000 (4 overhangs)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------ | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)      | --      | --    | --    |
| 2   | 3'WT block        | bsmbi_3wt_tile34_sub1    | 333 nt  | AAGT  | GAAA  |
| 3   | 3'WT+PolIII block | bsmbi_3wt_tile1_sub5     | 1229 nt | GAAA  | CACC  |
| 4   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1 | --      | --    | --    |

```
  [AAGT]----3'WT sub1----[GAAA]----3'WT+PolIII sub2----[CACC]
   AAGT                   GAAA                          CACC 
```

**Set fidelity:** 1.0000 (3 overhangs)

---

### Tile 35 of 37 -- Codons 1755-1830 (228 nt)

**Boundary overhangs:**

| Position          | Sequence | Fidelity |
| ----------------- | -------- | -------- |
| oh1 (5' boundary) | CTAA     | 0.8691   |
| oh2 (3' boundary) | TCTT     | 0.7985   |

**Variants:** 15120 mutations, 15120 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name              | Length  | 5' OH | 3' OH |
| --- | --------------- | ---------------------- | ------- | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile10_sub1   | 1040 nt | ATGG  | GAAA  |
| 2   | 5'WT gene block | bsai_5wt_tile20_sub2   | 1734 nt | GAAA  | GAAA  |
| 3   | 5'WT gene block | bsai_5wt_tile28_sub3   | 1095 nt | GAAA  | GAAA  |
| 4   | 5'WT gene block | bsai_5wt_tile35_sub4   | 1465 nt | GAAA  | CTAA  |
| 5   | Oligo pool      | Tile 35 (15120 oligos) | 284 nt  | CTAA  | AGAA  |
| 6   | Helper plasmid  | helper_plasmid_insert  | --      | --    | --    |
| 7   | Enzyme + buffer | BsaI-HFv2 + CutSmart   | --      | --    | --    |

```
  [ATGG]----5'WT sub1----[GAAA]----5'WT sub2----[GAAA]----5'WT sub3----[GAAA]----5'WT sub4----[CTAA]----oligo+BC----[AGAA]
   ATGG                   GAAA                   GAAA                   GAAA                   CTAA                  AGAA 
```

**Set fidelity:** 1.0000 (4 overhangs)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------ | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)      | --      | --    | --    |
| 2   | 3'WT+PolIII block | bsmbi_3wt_tile35_sub1    | 1328 nt | TCTT  | CACC  |
| 3   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1 | --      | --    | --    |

```
  [TCTT]----3'WT+PolIII sub1----[GAAA][CACC]
   TCTT                          GAAA  CACC 
```

**Set fidelity:** 1.0000 (3 overhangs)

---

### Tile 36 of 37 -- Codons 1827-1867 (123 nt)

**Boundary overhangs:**

| Position          | Sequence | Fidelity |
| ----------------- | -------- | -------- |
| oh1 (5' boundary) | AGGA     | 0.7515   |
| oh2 (3' boundary) | AGTG     | 0.5190   |

**Variants:** 7770 mutations, 7770 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name             | Length  | 5' OH | 3' OH |
| --- | --------------- | --------------------- | ------- | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile10_sub1  | 1040 nt | ATGG  | GAAA  |
| 2   | 5'WT gene block | bsai_5wt_tile20_sub2  | 1734 nt | GAAA  | GAAA  |
| 3   | 5'WT gene block | bsai_5wt_tile28_sub3  | 1095 nt | GAAA  | GAAA  |
| 4   | 5'WT gene block | bsai_5wt_tile36_sub4  | 1681 nt | GAAA  | AGGA  |
| 5   | Oligo pool      | Tile 36 (7770 oligos) | 179 nt  | AGGA  | AGAA  |
| 6   | Helper plasmid  | helper_plasmid_insert | --      | --    | --    |
| 7   | Enzyme + buffer | BsaI-HFv2 + CutSmart  | --      | --    | --    |

```
  [ATGG]----5'WT sub1----[GAAA]----5'WT sub2----[GAAA]----5'WT sub3----[GAAA]----5'WT sub4----[AGGA]----oligo+BC----[AGAA]
   ATGG                   GAAA                   GAAA                   GAAA                   AGGA                  AGAA 
```

**Set fidelity:** 0.9704 (4 overhangs)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------ | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)      | --      | --    | --    |
| 2   | 3'WT+PolIII block | bsmbi_3wt_tile36         | 1217 nt | AGTG  | CACC  |
| 3   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1 | --      | --    | --    |

```
  [AGTG]----3'WT+PolIII----[CACC]
   AGTG                     CACC 
```

**Set fidelity:** 1.0000 (2 overhangs)

---

### Tile 37 of 37 -- Codons 1864-1902 (117 nt)

**Boundary overhangs:**

| Position          | Sequence | Fidelity |
| ----------------- | -------- | -------- |
| oh1 (5' boundary) | GGAT     | 0.5385   |
| oh2 (3' boundary) | ATAG     | 0.7330   |

**Variants:** 7350 mutations, 7350 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name             | Length  | 5' OH | 3' OH |
| --- | --------------- | --------------------- | ------- | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile10_sub1  | 1040 nt | ATGG  | GAAA  |
| 2   | 5'WT gene block | bsai_5wt_tile20_sub2  | 1734 nt | GAAA  | GAAA  |
| 3   | 5'WT gene block | bsai_5wt_tile28_sub3  | 1095 nt | GAAA  | GAAA  |
| 4   | 5'WT gene block | bsai_5wt_tile37_sub4  | 1792 nt | GAAA  | GGAT  |
| 5   | Oligo pool      | Tile 37 (7350 oligos) | 173 nt  | GGAT  | AGAA  |
| 6   | Helper plasmid  | helper_plasmid_insert | --      | --    | --    |
| 7   | Enzyme + buffer | BsaI-HFv2 + CutSmart  | --      | --    | --    |

```
  [ATGG]----5'WT sub1----[GAAA]----5'WT sub2----[GAAA]----5'WT sub3----[GAAA]----5'WT sub4----[GAAA]----oligo+BC----[GGAT][AGAA]
   ATGG                   GAAA                   GAAA                   GAAA                   GAAA                  GGAT  AGAA 
```

**Set fidelity:** 1.0000 (4 overhangs)

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

**Total blocks:** 80

| Block name            | Length (nt) | Enzyme type | Gene region                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                          |
| --------------------- | ----------- | ----------- | ---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| bsai_5wt_tile10_sub1  | 1040        | BsaI        | 5wt_tile10_sub1;5wt_tile11_sub1;5wt_tile12_sub1;5wt_tile13_sub1;5wt_tile14_sub1;5wt_tile15_sub1;5wt_tile16_sub1;5wt_tile17_sub1;5wt_tile18_sub1;5wt_tile19_sub1;5wt_tile20_sub1;5wt_tile21_sub1;5wt_tile22_sub1;5wt_tile23_sub1;5wt_tile24_sub1;5wt_tile25_sub1;5wt_tile26_sub1;5wt_tile27_sub1;5wt_tile28_sub1;5wt_tile29_sub1;5wt_tile30_sub1;5wt_tile31_sub1;5wt_tile32_sub1;5wt_tile33_sub1;5wt_tile34_sub1;5wt_tile35_sub1;5wt_tile36_sub1;5wt_tile37_sub1                                                                                                                                                                                                                                                                                                                                      |
| bsai_5wt_tile10_sub2  | 349         | BsaI        | 5wt_tile10_sub2                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                      |
| bsai_5wt_tile11_sub2  | 472         | BsaI        | 5wt_tile11_sub2                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                      |
| bsai_5wt_tile12_sub2  | 601         | BsaI        | 5wt_tile12_sub2                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                      |
| bsai_5wt_tile13_sub2  | 808         | BsaI        | 5wt_tile13_sub2                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                      |
| bsai_5wt_tile14_sub2  | 988         | BsaI        | 5wt_tile14_sub2                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                      |
| bsai_5wt_tile15_sub2  | 1078        | BsaI        | 5wt_tile15_sub2                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                      |
| bsai_5wt_tile16_sub2  | 1276        | BsaI        | 5wt_tile16_sub2                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                      |
| bsai_5wt_tile17_sub2  | 1375        | BsaI        | 5wt_tile17_sub2                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                      |
| bsai_5wt_tile18_sub2  | 1585        | BsaI        | 5wt_tile18_sub2                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                      |
| bsai_5wt_tile19_sub2  | 1738        | BsaI        | 5wt_tile19_sub2                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                      |
| bsai_5wt_tile2        | 117         | BsaI        | 5wt_tile2                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                            |
| bsai_5wt_tile20_sub2  | 1734        | BsaI        | 5wt_tile20_sub2;5wt_tile21_sub2;5wt_tile22_sub2;5wt_tile23_sub2;5wt_tile24_sub2;5wt_tile25_sub2;5wt_tile26_sub2;5wt_tile27_sub2;5wt_tile28_sub2;5wt_tile29_sub2;5wt_tile30_sub2;5wt_tile31_sub2;5wt_tile32_sub2;5wt_tile33_sub2;5wt_tile34_sub2;5wt_tile35_sub2;5wt_tile36_sub2;5wt_tile37_sub2                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                      |
| bsai_5wt_tile20_sub3  | 232         | BsaI        | 5wt_tile20_sub3                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                      |
| bsai_5wt_tile21_sub3  | 415         | BsaI        | 5wt_tile21_sub3                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                      |
| bsai_5wt_tile22_sub3  | 586         | BsaI        | 5wt_tile22_sub3                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                      |
| bsai_5wt_tile23_sub3  | 745         | BsaI        | 5wt_tile23_sub3                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                      |
| bsai_5wt_tile24_sub3  | 940         | BsaI        | 5wt_tile24_sub3                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                      |
| bsai_5wt_tile25_sub3  | 1099        | BsaI        | 5wt_tile25_sub3                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                      |
| bsai_5wt_tile26_sub3  | 1243        | BsaI        | 5wt_tile26_sub3                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                      |
| bsai_5wt_tile27_sub3  | 1330        | BsaI        | 5wt_tile27_sub3                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                      |
| bsai_5wt_tile28_sub3  | 1095        | BsaI        | 5wt_tile28_sub3;5wt_tile29_sub3;5wt_tile30_sub3;5wt_tile31_sub3;5wt_tile32_sub3;5wt_tile33_sub3;5wt_tile34_sub3;5wt_tile35_sub3;5wt_tile36_sub3;5wt_tile37_sub3                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                      |
| bsai_5wt_tile28_sub4  | 355         | BsaI        | 5wt_tile28_sub4                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                      |
| bsai_5wt_tile29_sub4  | 484         | BsaI        | 5wt_tile29_sub4                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                      |
| bsai_5wt_tile3        | 321         | BsaI        | 5wt_tile3                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                            |
| bsai_5wt_tile30_sub4  | 667         | BsaI        | 5wt_tile30_sub4                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                      |
| bsai_5wt_tile31_sub4  | 862         | BsaI        | 5wt_tile31_sub4                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                      |
| bsai_5wt_tile32_sub4  | 1057        | BsaI        | 5wt_tile32_sub4                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                      |
| bsai_5wt_tile33_sub4  | 1174        | BsaI        | 5wt_tile33_sub4                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                      |
| bsai_5wt_tile34_sub4  | 1321        | BsaI        | 5wt_tile34_sub4                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                      |
| bsai_5wt_tile35_sub4  | 1465        | BsaI        | 5wt_tile35_sub4                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                      |
| bsai_5wt_tile36_sub4  | 1681        | BsaI        | 5wt_tile36_sub4                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                      |
| bsai_5wt_tile37_sub4  | 1792        | BsaI        | 5wt_tile37_sub4                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                      |
| bsai_5wt_tile4        | 426         | BsaI        | 5wt_tile4                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                            |
| bsai_5wt_tile5        | 597         | BsaI        | 5wt_tile5                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                            |
| bsai_5wt_tile6        | 768         | BsaI        | 5wt_tile6                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                            |
| bsai_5wt_tile7        | 903         | BsaI        | 5wt_tile7                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                            |
| bsai_5wt_tile8_sub1   | 1044        | BsaI        | 5wt_tile8_sub1                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                       |
| bsai_5wt_tile9_sub1   | 1206        | BsaI        | 5wt_tile9_sub1                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                       |
| bsmbi_3wt_tile1_sub1  | 933         | BsmBI       | 3wt_tile1_sub1                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                       |
| bsmbi_3wt_tile1_sub2  | 1734        | BsmBI       | 3wt_tile1_sub2;3wt_tile2_sub2;3wt_tile3_sub2;3wt_tile4_sub2;3wt_tile5_sub2;3wt_tile6_sub2                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                            |
| bsmbi_3wt_tile1_sub3  | 1095        | BsmBI       | 3wt_tile1_sub3;3wt_tile2_sub3;3wt_tile3_sub3;3wt_tile4_sub3;3wt_tile5_sub3;3wt_tile6_sub3;3wt_tile7_sub2;3wt_tile8_sub2;3wt_tile9_sub2;3wt_tile10_sub2;3wt_tile11_sub2;3wt_tile12_sub2;3wt_tile13_sub2;3wt_tile14_sub2;3wt_tile15_sub2;3wt_tile16_sub2                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                               |
| bsmbi_3wt_tile1_sub4  | 1788        | BsmBI       | 3wt_tile1_sub4;3wt_tile2_sub4;3wt_tile3_sub4;3wt_tile4_sub4;3wt_tile5_sub4;3wt_tile6_sub4;3wt_tile7_sub3;3wt_tile8_sub3;3wt_tile9_sub3;3wt_tile10_sub3;3wt_tile11_sub3;3wt_tile12_sub3;3wt_tile13_sub3;3wt_tile14_sub3;3wt_tile15_sub3;3wt_tile16_sub3;3wt_tile17_sub2;3wt_tile18_sub2;3wt_tile19_sub2;3wt_tile20_sub2;3wt_tile21_sub2;3wt_tile22_sub2;3wt_tile23_sub2                                                                                                                                                                                                                                                                                                                                                                                                                               |
| bsmbi_3wt_tile1_sub5  | 1229        | BsmBI       | 3wt_polIII_tile1_sub5;3wt_polIII_tile2_sub5;3wt_polIII_tile3_sub5;3wt_polIII_tile4_sub5;3wt_polIII_tile5_sub5;3wt_polIII_tile6_sub5;3wt_polIII_tile7_sub4;3wt_polIII_tile8_sub4;3wt_polIII_tile9_sub4;3wt_polIII_tile10_sub4;3wt_polIII_tile11_sub4;3wt_polIII_tile12_sub4;3wt_polIII_tile13_sub4;3wt_polIII_tile14_sub4;3wt_polIII_tile15_sub4;3wt_polIII_tile16_sub4;3wt_polIII_tile17_sub3;3wt_polIII_tile18_sub3;3wt_polIII_tile19_sub3;3wt_polIII_tile20_sub3;3wt_polIII_tile21_sub3;3wt_polIII_tile22_sub3;3wt_polIII_tile23_sub3;3wt_polIII_tile24_sub2;3wt_polIII_tile25_sub2;3wt_polIII_tile26_sub2;3wt_polIII_tile27_sub2;3wt_polIII_tile28_sub2;3wt_polIII_tile29_sub2;3wt_polIII_tile30_sub2;3wt_polIII_tile31_sub2;3wt_polIII_tile32_sub2;3wt_polIII_tile33_sub2;3wt_polIII_tile34_sub2 |
| bsmbi_3wt_tile10_sub1 | 1272        | BsmBI       | 3wt_tile10_sub1                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                      |
| bsmbi_3wt_tile11_sub1 | 1143        | BsmBI       | 3wt_tile11_sub1                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                      |
| bsmbi_3wt_tile12_sub1 | 936         | BsmBI       | 3wt_tile12_sub1                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                      |
| bsmbi_3wt_tile13_sub1 | 756         | BsmBI       | 3wt_tile13_sub1                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                      |
| bsmbi_3wt_tile14_sub1 | 666         | BsmBI       | 3wt_tile14_sub1                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                      |
| bsmbi_3wt_tile15_sub1 | 468         | BsmBI       | 3wt_tile15_sub1                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                      |
| bsmbi_3wt_tile16_sub1 | 369         | BsmBI       | 3wt_tile16_sub1                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                      |
| bsmbi_3wt_tile17_sub1 | 1236        | BsmBI       | 3wt_tile17_sub1                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                      |
| bsmbi_3wt_tile18_sub1 | 1083        | BsmBI       | 3wt_tile18_sub1                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                      |
| bsmbi_3wt_tile19_sub1 | 873         | BsmBI       | 3wt_tile19_sub1                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                      |
| bsmbi_3wt_tile2_sub1  | 729         | BsmBI       | 3wt_tile2_sub1                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                       |
| bsmbi_3wt_tile20_sub1 | 690         | BsmBI       | 3wt_tile20_sub1                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                      |
| bsmbi_3wt_tile21_sub1 | 519         | BsmBI       | 3wt_tile21_sub1                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                      |
| bsmbi_3wt_tile22_sub1 | 360         | BsmBI       | 3wt_tile22_sub1                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                      |
| bsmbi_3wt_tile23_sub1 | 165         | BsmBI       | 3wt_tile23_sub1                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                      |
| bsmbi_3wt_tile24_sub1 | 1776        | BsmBI       | 3wt_tile24_sub1                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                      |
| bsmbi_3wt_tile25_sub1 | 1632        | BsmBI       | 3wt_tile25_sub1                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                      |
| bsmbi_3wt_tile26_sub1 | 1545        | BsmBI       | 3wt_tile26_sub1                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                      |
| bsmbi_3wt_tile27_sub1 | 1443        | BsmBI       | 3wt_tile27_sub1                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                      |
| bsmbi_3wt_tile28_sub1 | 1314        | BsmBI       | 3wt_tile28_sub1                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                      |
| bsmbi_3wt_tile29_sub1 | 1131        | BsmBI       | 3wt_tile29_sub1                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                      |
| bsmbi_3wt_tile3_sub1  | 624         | BsmBI       | 3wt_tile3_sub1                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                       |
| bsmbi_3wt_tile30_sub1 | 936         | BsmBI       | 3wt_tile30_sub1                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                      |
| bsmbi_3wt_tile31_sub1 | 741         | BsmBI       | 3wt_tile31_sub1                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                      |
| bsmbi_3wt_tile32_sub1 | 624         | BsmBI       | 3wt_tile32_sub1                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                      |
| bsmbi_3wt_tile33_sub1 | 477         | BsmBI       | 3wt_tile33_sub1                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                      |
| bsmbi_3wt_tile34_sub1 | 333         | BsmBI       | 3wt_tile34_sub1                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                      |
| bsmbi_3wt_tile35_sub1 | 1328        | BsmBI       | 3wt_polIII_tile35_sub1                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                               |
| bsmbi_3wt_tile36      | 1217        | BsmBI       | 3wt_polIII_tile36                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                    |
| bsmbi_3wt_tile4_sub1  | 453         | BsmBI       | 3wt_tile4_sub1                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                       |
| bsmbi_3wt_tile5_sub1  | 282         | BsmBI       | 3wt_tile5_sub1                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                       |
| bsmbi_3wt_tile6_sub1  | 147         | BsmBI       | 3wt_tile6_sub1                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                       |
| bsmbi_3wt_tile7_sub1  | 1722        | BsmBI       | 3wt_tile7_sub1                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                       |
| bsmbi_3wt_tile8_sub1  | 1560        | BsmBI       | 3wt_tile8_sub1                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                       |
| bsmbi_3wt_tile9_sub1  | 1395        | BsmBI       | 3wt_tile9_sub1                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                       |
| bsmbi_polIII_tile37   | 1112        | BsmBI       | polIII_tile37                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                        |

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

