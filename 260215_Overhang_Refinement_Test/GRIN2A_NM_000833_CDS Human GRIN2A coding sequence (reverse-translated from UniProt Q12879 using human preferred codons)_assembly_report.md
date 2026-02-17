# DMS-GG Assembly Report: GRIN2A_NM_000833_CDS Human GRIN2A coding sequence (reverse-translated from UniProt Q12879 using human preferred codons)

Generated: 2026-02-16 19:28:10
Pipeline: dms-gg-oligo-pipeline (3-Enzyme Architecture: BsaI + BsmBI + PaqCI)

---

## 1. Gene Summary

| Property             | Value                                                                                                                   |
| -------------------- | ----------------------------------------------------------------------------------------------------------------------- |
| Gene name            | GRIN2A_NM_000833_CDS Human GRIN2A coding sequence (reverse-translated from UniProt Q12879 using human preferred codons) |
| CDS length           | 4344 nt (1448 codons)                                                                                                   |
| Protein length       | 1447 aa                                                                                                                 |
| Number of tiles      | 21                                                                                                                      |
| Total variants       | 28960                                                                                                                   |
| Total oligos         | 28960                                                                                                                   |
| Oligo length range   | 168-291 nt                                                                                                              |
| Gene blocks to order | 57                                                                                                                      |
| Barcodes per variant | 1                                                                                                                       |

## 2. Assembly Architecture Overview

This pipeline uses a **3-enzyme Golden Gate Assembly** strategy:

1. **BsaI Level 1** (37C): Inserts the oligo (mutant tile + barcode) and 5'WT gene block(s) into a helper plasmid.
2. **BsmBI Level 1b** (42C): Inserts 3'WT+PolIII gene block(s) between the tile and barcode.
3. **PaqCI Level 2** (37C): Moves the complete insert from helper plasmid into the destination backbone.

### Universal Oligo Structure

Every oligo in the pool has the same layout regardless of tile position:

```
5'--[BsaI>>]--oh1--[mutable region]--[<<BsmBI]--[BsmBI>>]--barcode--[<<BsaI]--3'
     7 nt     4 nt    variable          11 nt      11 nt    15 nt    11 nt
```

### Final Assembled Construct

```
[PaqCI**]--[full gene with 1 mutation]--[PolIII promoter]--[barcode]--[PaqCI*]
```

## 3. Oligo Pool Summary

**Total oligos:** 28960 | **Length range:** 168-291 nt

| Tile | Codons    | Oligos | Length range |
| ---- | --------- | ------ | ------------ |
| 1    | 1-62      | 1240   | 237-237 nt   |
| 2    | 63-133    | 1420   | 264-264 nt   |
| 3    | 134-212   | 1580   | 288-288 nt   |
| 4    | 213-290   | 1560   | 285-285 nt   |
| 5    | 291-366   | 1520   | 279-279 nt   |
| 6    | 367-405   | 780    | 168-168 nt   |
| 7    | 406-473   | 1360   | 255-255 nt   |
| 8    | 474-544   | 1420   | 264-264 nt   |
| 9    | 545-622   | 1560   | 285-285 nt   |
| 10   | 623-669   | 940    | 192-192 nt   |
| 11   | 670-748   | 1580   | 288-288 nt   |
| 12   | 749-824   | 1520   | 279-279 nt   |
| 13   | 825-902   | 1560   | 285-285 nt   |
| 14   | 903-955   | 1060   | 210-210 nt   |
| 15   | 956-1035  | 1600   | 291-291 nt   |
| 16   | 1036-1115 | 1600   | 291-291 nt   |
| 17   | 1116-1185 | 1400   | 261-261 nt   |
| 18   | 1186-1256 | 1420   | 264-264 nt   |
| 19   | 1257-1325 | 1380   | 258-258 nt   |
| 20   | 1326-1377 | 1040   | 207-207 nt   |
| 21   | 1378-1448 | 1420   | 264-264 nt   |

## 4. QC Summary

**Overall:** ALL CHECKS PASSED

| Check                  | Description                                              | Result | Detail                                                                                                          |
| ---------------------- | -------------------------------------------------------- | ------ | --------------------------------------------------------------------------------------------------------------- |
| oligo_lengths          | All oligos within synthesis length limit                 | PASS   | Range: 168-291 nt (limit: 300)                                                                                  |
| block_lengths          | All gene blocks within synthesis length limit            | PASS   | Range: 208-1798 nt (limit: 1800)                                                                                |
| oligo_enzyme_sites     | Oligo sequences checked for enzyme sites                 | PASS   | Note: Oligos contain intentional BsaI/BsmBI sites for cloning. Internal site check done during mutation design. |
| barcode_uniqueness     | All barcodes are unique                                  | PASS   | 28960 unique / 28960 total                                                                                      |
| tile_coverage          | Tiles cover entire gene without gaps                     | PASS   | 4344 / 4344 nt covered                                                                                          |
| variant_count          | Expected number of variants generated                    | PASS   | 28960 variants (expected: 28960 = 1448 positions x 20 mutations)                                                |
| single_codon_change    | Each variant differs by exactly one codon from WT        | PASS   | 28960 / 28960 variants confirmed                                                                                |
| oligo_gc_content       | Oligo GC content within reasonable range (25-75%)        | PASS   | GC range: 48.6-65.5% | 0 oligo(s) with extreme GC                                                               |
| domestication_complete | Gene domesticated for all 3 enzymes (BsaI, BsmBI, PaqCI) | PASS   | No enzyme sites in gene                                                                                         |
| overhang_fidelity      | Tile boundary overhangs have adequate fidelity           | PASS   | 0 tile(s) with low-fidelity boundary overhangs (<0.80)                                                          |
| tile_manifests         | Per-tile assembly manifests complete                     | PASS   | 21 tile manifest(s) generated                                                                                   |
| helper_plasmid         | Helper plasmid free of unintended BsmBI sites            | PASS   | OK                                                                                                              |
| reaction_fidelity      | Per-reaction set-level overhang fidelity                 | PASS   | Min set fidelity: 0.9902 across 42 reactions | 0 reaction(s) below 0.90                                         |

## 5. Fixed Overhangs & Helper Plasmid

These overhangs are the same across all tile reactions:

| Overhang    | Sequence | Role                                       | In HF Set |
| ----------- | -------- | ------------------------------------------ | --------- |
| oh_L        | ATGG     | Gene start (BsaI, all tiles)               | No        |
| oh3         | AACA     | PolIII-barcode junction (BsmBI, all tiles) | Yes       |
| oh4         | AAAA     | Barcode-helper junction (BsaI, all tiles)  | Yes       |
| paqci_star2 | AGTC     | PaqCI 5' end of insert (Level 2)           | --        |
| paqci_star1 | TCGA     | PaqCI 3' end of insert (Level 2)           | --        |

### Helper Plasmid Insert

The helper plasmid provides the backbone for each BsaI Level 1 reaction.

```
[PaqCI**]--[BsaI>>ATGG]--STUFFER--[AAAA<<BsaI]--[PaqCI*]
```

Insert length: 72 nt
oh_L = ATGG (first 4 nt of gene)
oh_R = AAAA (= oh4, barcode-helper junction)

## 6. Per-Tile Assembly Guide

### Tile 1 of 21 -- Codons 1-62 (186 nt)

**Boundary overhangs:**

| Position          | Sequence | In HF Set | Fidelity |
| ----------------- | -------- | --------- | -------- |
| oh1 (5' boundary) | ATGG     | No        | 0.9459   |
| oh2 (3' boundary) | ATAC     | No        | 0.9738   |

**Variants:** 1240 mutations, 1240 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name                          | Length     |
| --- | --------------- | ---------------------------------- | ---------- |
| 1   | Oligo pool      | Tile 1 (1240 oligos)               | 237-237 nt |
| 2   | 5'WT gene block | (none -- tile starts at gene nt 1) | --         |
| 3   | Helper plasmid  | helper_plasmid_insert              | --         |
| 4   | Enzyme + buffer | BsaI-HFv2 + CutSmart               | --         |

```
  [ATGG]----oligo+BC----[AAAA]
   ATGG                  AAAA 
   (--)                  (HF) 
```

**Set fidelity:** 0.9995 (2 overhangs, 1 in HF set)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                | Length  |
| --- | ----------------- | ------------------------ | ------- |
| 1   | BsaI product      | (in helper plasmid)      | --      |
| 2   | 3'WT+PolIII block | bsmbi_3wt_tile1_sub1     | 1324 nt |
| 3   | 3'WT+PolIII block | bsmbi_3wt_tile1_sub2     | 1639 nt |
| 4   | 3'WT+PolIII block | bsmbi_3wt_tile1_sub3     | 1511 nt |
| 5   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1 | --      |

```
  [ATAC]----3'WT+PolIII sub1----[AATC]----3'WT+PolIII sub2----[AAAC]----3'WT+PolIII sub3----[AACA]
   ATAC                          AATC                          AAAC                          AACA 
   (--)                          (--)                          (HF)                          (HF) 
```

**Set fidelity:** 0.9982 (4 overhangs, 2 in HF set)

---

### Tile 2 of 21 -- Codons 63-133 (213 nt)

**Boundary overhangs:**

| Position          | Sequence | In HF Set | Fidelity |
| ----------------- | -------- | --------- | -------- |
| oh1 (5' boundary) | ATCA     | Yes       | 0.9919   |
| oh2 (3' boundary) | CAAC     | No        | 0.9873   |

**Variants:** 1420 mutations, 1420 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name             | Length     |
| --- | --------------- | --------------------- | ---------- |
| 1   | Oligo pool      | Tile 2 (1420 oligos)  | 264-264 nt |
| 2   | 5'WT gene block | bsai_5wt_tile2        | 208 nt     |
| 3   | Helper plasmid  | helper_plasmid_insert | --         |
| 4   | Enzyme + buffer | BsaI-HFv2 + CutSmart  | --         |

```
  [ATGG]----5'WT block----[ATCA]----oligo+BC----[AAAA]
   ATGG                    ATCA                  AAAA 
   (--)                    (HF)                  (HF) 
```

**Set fidelity:** 0.9992 (3 overhangs, 2 in HF set)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                | Length  |
| --- | ----------------- | ------------------------ | ------- |
| 1   | BsaI product      | (in helper plasmid)      | --      |
| 2   | 3'WT+PolIII block | bsmbi_3wt_tile2_sub1     | 1480 nt |
| 3   | 3'WT+PolIII block | bsmbi_3wt_tile2_sub2     | 1270 nt |
| 4   | 3'WT+PolIII block | bsmbi_3wt_tile1_sub3     | 1511 nt |
| 5   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1 | --      |

```
  [CAAC]----3'WT+PolIII sub1----[AAGA]----3'WT+PolIII sub2----[AAAC]----3'WT+PolIII sub3----[AACA]
   CAAC                          AAGA                          AAAC                          AACA 
   (--)                          (HF)                          (HF)                          (HF) 
```

**Set fidelity:** 0.9996 (4 overhangs, 3 in HF set)

---

### Tile 3 of 21 -- Codons 134-212 (237 nt)

**Boundary overhangs:**

| Position          | Sequence | In HF Set | Fidelity |
| ----------------- | -------- | --------- | -------- |
| oh1 (5' boundary) | AACA     | Yes       | 0.9975   |
| oh2 (3' boundary) | GAGA     | Yes       | 0.9949   |

**Variants:** 1580 mutations, 1580 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name             | Length     |
| --- | --------------- | --------------------- | ---------- |
| 1   | Oligo pool      | Tile 3 (1580 oligos)  | 288-288 nt |
| 2   | 5'WT gene block | bsai_5wt_tile3        | 421 nt     |
| 3   | Helper plasmid  | helper_plasmid_insert | --         |
| 4   | Enzyme + buffer | BsaI-HFv2 + CutSmart  | --         |

```
  [ATGG]----5'WT block----[AACA]----oligo+BC----[AAAA]
   ATGG                    AACA                  AAAA 
   (--)                    (HF)                  (HF) 
```

**Set fidelity:** 0.9994 (3 overhangs, 2 in HF set)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                | Length  |
| --- | ----------------- | ------------------------ | ------- |
| 1   | BsaI product      | (in helper plasmid)      | --      |
| 2   | 3'WT+PolIII block | bsmbi_3wt_tile3_sub1     | 1243 nt |
| 3   | 3'WT+PolIII block | bsmbi_3wt_tile2_sub2     | 1270 nt |
| 4   | 3'WT+PolIII block | bsmbi_3wt_tile1_sub3     | 1511 nt |
| 5   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1 | --      |

```
  [GAGA]----3'WT+PolIII sub1----[AAGA]----3'WT+PolIII sub2----[AAAC]----3'WT+PolIII sub3----[AACA]
   GAGA                          AAGA                          AAAC                          AACA 
   (HF)                          (HF)                          (HF)                          (HF) 
```

**Set fidelity:** 0.9992 (4 overhangs, 4 in HF set)

---

### Tile 4 of 21 -- Codons 213-290 (234 nt)

**Boundary overhangs:**

| Position          | Sequence | In HF Set | Fidelity |
| ----------------- | -------- | --------- | -------- |
| oh1 (5' boundary) | GTGA     | No        | 0.9687   |
| oh2 (3' boundary) | CATC     | No        | 0.9199   |

**Variants:** 1560 mutations, 1560 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name             | Length     |
| --- | --------------- | --------------------- | ---------- |
| 1   | Oligo pool      | Tile 4 (1560 oligos)  | 285-285 nt |
| 2   | 5'WT gene block | bsai_5wt_tile4        | 658 nt     |
| 3   | Helper plasmid  | helper_plasmid_insert | --         |
| 4   | Enzyme + buffer | BsaI-HFv2 + CutSmart  | --         |

```
  [ATGG]----5'WT block----[GTGA]----oligo+BC----[AAAA]
   ATGG                    GTGA                  AAAA 
   (--)                    (--)                  (HF) 
```

**Set fidelity:** 0.9989 (3 overhangs, 1 in HF set)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                | Length  |
| --- | ----------------- | ------------------------ | ------- |
| 1   | BsaI product      | (in helper plasmid)      | --      |
| 2   | 3'WT+PolIII block | bsmbi_3wt_tile4_sub1     | 1129 nt |
| 3   | 3'WT+PolIII block | bsmbi_3wt_tile4_sub2     | 1150 nt |
| 4   | 3'WT+PolIII block | bsmbi_3wt_tile1_sub3     | 1511 nt |
| 5   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1 | --      |

```
  [CATC]----3'WT+PolIII sub1----[GAGA]----3'WT+PolIII sub2----[AAAC]----3'WT+PolIII sub3----[AACA]
   CATC                          GAGA                          AAAC                          AACA 
   (--)                          (HF)                          (HF)                          (HF) 
```

**Set fidelity:** 0.9918 (4 overhangs, 3 in HF set)

---

### Tile 5 of 21 -- Codons 291-366 (228 nt)

**Boundary overhangs:**

| Position          | Sequence | In HF Set | Fidelity |
| ----------------- | -------- | --------- | -------- |
| oh1 (5' boundary) | ACCA     | Yes       | 0.9920   |
| oh2 (3' boundary) | CAAG     | No        | 0.9751   |

**Variants:** 1520 mutations, 1520 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name             | Length     |
| --- | --------------- | --------------------- | ---------- |
| 1   | Oligo pool      | Tile 5 (1520 oligos)  | 279-279 nt |
| 2   | 5'WT gene block | bsai_5wt_tile5        | 892 nt     |
| 3   | Helper plasmid  | helper_plasmid_insert | --         |
| 4   | Enzyme + buffer | BsaI-HFv2 + CutSmart  | --         |

```
  [ATGG]----5'WT block----[ACCA]----oligo+BC----[AAAA]
   ATGG                    ACCA                  AAAA 
   (--)                    (HF)                  (HF) 
```

**Set fidelity:** 0.9989 (3 overhangs, 2 in HF set)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                | Length  |
| --- | ----------------- | ------------------------ | ------- |
| 1   | BsaI product      | (in helper plasmid)      | --      |
| 2   | 3'WT+PolIII block | bsmbi_3wt_tile5_sub1     | 1135 nt |
| 3   | 3'WT+PolIII block | bsmbi_3wt_tile5_sub2     | 1003 nt |
| 4   | 3'WT+PolIII block | bsmbi_3wt_tile5_sub3     | 1424 nt |
| 5   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1 | --      |

```
  [CAAG]----3'WT+PolIII sub1----[CAGA]----3'WT+PolIII sub2----[GAGA]----3'WT+PolIII sub3----[AACA]
   CAAG                          CAGA                          GAGA                          AACA 
   (--)                          (--)                          (HF)                          (HF) 
```

**Set fidelity:** 0.9993 (4 overhangs, 2 in HF set)

---

### Tile 6 of 21 -- Codons 367-405 (117 nt)

**Boundary overhangs:**

| Position          | Sequence | In HF Set | Fidelity |
| ----------------- | -------- | --------- | -------- |
| oh1 (5' boundary) | GAGA     | Yes       | 0.9949   |
| oh2 (3' boundary) | CGAA     | Yes       | 0.9924   |

**Variants:** 780 mutations, 780 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name             | Length     |
| --- | --------------- | --------------------- | ---------- |
| 1   | Oligo pool      | Tile 6 (780 oligos)   | 168-168 nt |
| 2   | 5'WT gene block | bsai_5wt_tile6        | 1120 nt    |
| 3   | Helper plasmid  | helper_plasmid_insert | --         |
| 4   | Enzyme + buffer | BsaI-HFv2 + CutSmart  | --         |

```
  [ATGG]----5'WT block----[GAGA]----oligo+BC----[AAAA]
   ATGG                    GAGA                  AAAA 
   (--)                    (HF)                  (HF) 
```

**Set fidelity:** 0.9994 (3 overhangs, 2 in HF set)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                | Length  |
| --- | ----------------- | ------------------------ | ------- |
| 1   | BsaI product      | (in helper plasmid)      | --      |
| 2   | 3'WT+PolIII block | bsmbi_3wt_tile6_sub1     | 1729 nt |
| 3   | 3'WT+PolIII block | bsmbi_3wt_tile6_sub2     | 1694 nt |
| 4   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1 | --      |

```
  [CGAA]----3'WT+PolIII sub1----[CAGA]----3'WT+PolIII sub2----[AACA]
   CGAA                          CAGA                          AACA 
   (HF)                          (--)                          (HF) 
```

**Set fidelity:** 0.9995 (3 overhangs, 2 in HF set)

---

### Tile 7 of 21 -- Codons 406-473 (204 nt)

**Boundary overhangs:**

| Position          | Sequence | In HF Set | Fidelity |
| ----------------- | -------- | --------- | -------- |
| oh1 (5' boundary) | ACCA     | Yes       | 0.9920   |
| oh2 (3' boundary) | GAGA     | Yes       | 0.9949   |

**Variants:** 1360 mutations, 1360 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name             | Length     |
| --- | --------------- | --------------------- | ---------- |
| 1   | Oligo pool      | Tile 7 (1360 oligos)  | 255-255 nt |
| 2   | 5'WT gene block | bsai_5wt_tile7        | 1237 nt    |
| 3   | Helper plasmid  | helper_plasmid_insert | --         |
| 4   | Enzyme + buffer | BsaI-HFv2 + CutSmart  | --         |

```
  [ATGG]----5'WT block----[ACCA]----oligo+BC----[AAAA]
   ATGG                    ACCA                  AAAA 
   (--)                    (HF)                  (HF) 
```

**Set fidelity:** 0.9989 (3 overhangs, 2 in HF set)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                | Length  |
| --- | ----------------- | ------------------------ | ------- |
| 1   | BsaI product      | (in helper plasmid)      | --      |
| 2   | 3'WT+PolIII block | bsmbi_3wt_tile7_sub1     | 1525 nt |
| 3   | 3'WT+PolIII block | bsmbi_3wt_tile6_sub2     | 1694 nt |
| 4   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1 | --      |

```
  [GAGA]----3'WT+PolIII sub1----[CAGA]----3'WT+PolIII sub2----[AACA]
   GAGA                          CAGA                          AACA 
   (HF)                          (--)                          (HF) 
```

**Set fidelity:** 0.9999 (3 overhangs, 2 in HF set)

---

### Tile 8 of 21 -- Codons 474-544 (213 nt)

**Boundary overhangs:**

| Position          | Sequence | In HF Set | Fidelity |
| ----------------- | -------- | --------- | -------- |
| oh1 (5' boundary) | GCCA     | No        | 0.9338   |
| oh2 (3' boundary) | CCAG     | No        | 0.9743   |

**Variants:** 1420 mutations, 1420 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name             | Length     |
| --- | --------------- | --------------------- | ---------- |
| 1   | Oligo pool      | Tile 8 (1420 oligos)  | 264-264 nt |
| 2   | 5'WT gene block | bsai_5wt_tile8        | 1441 nt    |
| 3   | Helper plasmid  | helper_plasmid_insert | --         |
| 4   | Enzyme + buffer | BsaI-HFv2 + CutSmart  | --         |

```
  [ATGG]----5'WT block----[GCCA]----oligo+BC----[AAAA]
   ATGG                    GCCA                  AAAA 
   (--)                    (--)                  (HF) 
```

**Set fidelity:** 0.9985 (3 overhangs, 1 in HF set)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                | Length  |
| --- | ----------------- | ------------------------ | ------- |
| 1   | BsaI product      | (in helper plasmid)      | --      |
| 2   | 3'WT+PolIII block | bsmbi_3wt_tile8_sub1     | 1495 nt |
| 3   | 3'WT+PolIII block | bsmbi_3wt_tile1_sub3     | 1511 nt |
| 4   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1 | --      |

```
  [CCAG]----3'WT+PolIII sub1----[AAAC]----3'WT+PolIII sub2----[AACA]
   CCAG                          AAAC                          AACA 
   (--)                          (HF)                          (HF) 
```

**Set fidelity:** 0.9998 (3 overhangs, 2 in HF set)

---

### Tile 9 of 21 -- Codons 545-622 (234 nt)

**Boundary overhangs:**

| Position          | Sequence | In HF Set | Fidelity |
| ----------------- | -------- | --------- | -------- |
| oh1 (5' boundary) | AACA     | Yes       | 0.9975   |
| oh2 (3' boundary) | AAGC     | Yes       | 0.9916   |

**Variants:** 1560 mutations, 1560 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name             | Length     |
| --- | --------------- | --------------------- | ---------- |
| 1   | Oligo pool      | Tile 9 (1560 oligos)  | 285-285 nt |
| 2   | 5'WT gene block | bsai_5wt_tile9        | 1654 nt    |
| 3   | Helper plasmid  | helper_plasmid_insert | --         |
| 4   | Enzyme + buffer | BsaI-HFv2 + CutSmart  | --         |

```
  [ATGG]----5'WT block----[AACA]----oligo+BC----[AAAA]
   ATGG                    AACA                  AAAA 
   (--)                    (HF)                  (HF) 
```

**Set fidelity:** 0.9994 (3 overhangs, 2 in HF set)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                | Length  |
| --- | ----------------- | ------------------------ | ------- |
| 1   | BsaI product      | (in helper plasmid)      | --      |
| 2   | 3'WT+PolIII block | bsmbi_3wt_tile9_sub1     | 1348 nt |
| 3   | 3'WT+PolIII block | bsmbi_3wt_tile5_sub3     | 1424 nt |
| 4   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1 | --      |

```
  [AAGC]----3'WT+PolIII sub1----[GAGA]----3'WT+PolIII sub2----[AACA]
   AAGC                          GAGA                          AACA 
   (HF)                          (HF)                          (HF) 
```

**Set fidelity:** 0.9992 (3 overhangs, 3 in HF set)

---

### Tile 10 of 21 -- Codons 623-669 (141 nt)

**Boundary overhangs:**

| Position          | Sequence | In HF Set | Fidelity |
| ----------------- | -------- | --------- | -------- |
| oh1 (5' boundary) | GAGA     | Yes       | 0.9949   |
| oh2 (3' boundary) | CAGC     | No        | 0.9741   |

**Variants:** 940 mutations, 940 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name             | Length     |
| --- | --------------- | --------------------- | ---------- |
| 1   | Oligo pool      | Tile 10 (940 oligos)  | 192-192 nt |
| 2   | 5'WT gene block | bsai_5wt_tile10_sub1  | 817 nt     |
| 3   | 5'WT gene block | bsai_5wt_tile10_sub2  | 1093 nt    |
| 4   | Helper plasmid  | helper_plasmid_insert | --         |
| 5   | Enzyme + buffer | BsaI-HFv2 + CutSmart  | --         |

```
  [ATGG]----5'WT sub1----[CAGA]----5'WT sub2----[GAGA]----oligo+BC----[AAAA]
   ATGG                   CAGA                   GAGA                  AAAA 
   (--)                   (--)                   (HF)                  (HF) 
```

**Set fidelity:** 0.9988 (4 overhangs, 2 in HF set)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                | Length  |
| --- | ----------------- | ------------------------ | ------- |
| 1   | BsaI product      | (in helper plasmid)      | --      |
| 2   | 3'WT+PolIII block | bsmbi_3wt_tile10_sub1    | 1207 nt |
| 3   | 3'WT+PolIII block | bsmbi_3wt_tile5_sub3     | 1424 nt |
| 4   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1 | --      |

```
  [CAGC]----3'WT+PolIII sub1----[GAGA]----3'WT+PolIII sub2----[AACA]
   CAGC                          GAGA                          AACA 
   (--)                          (HF)                          (HF) 
```

**Set fidelity:** 0.9989 (3 overhangs, 2 in HF set)

---

### Tile 11 of 21 -- Codons 670-748 (237 nt)

**Boundary overhangs:**

| Position          | Sequence | In HF Set | Fidelity |
| ----------------- | -------- | --------- | -------- |
| oh1 (5' boundary) | ATCA     | Yes       | 0.9919   |
| oh2 (3' boundary) | CTTC     | No        | 0.8974   |

**Variants:** 1580 mutations, 1580 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name             | Length     |
| --- | --------------- | --------------------- | ---------- |
| 1   | Oligo pool      | Tile 11 (1580 oligos) | 288-288 nt |
| 2   | 5'WT gene block | bsai_5wt_tile11_sub1  | 961 nt     |
| 3   | 5'WT gene block | bsai_5wt_tile11_sub2  | 1090 nt    |
| 4   | Helper plasmid  | helper_plasmid_insert | --         |
| 5   | Enzyme + buffer | BsaI-HFv2 + CutSmart  | --         |

```
  [ATGG]----5'WT sub1----[CAAC]----5'WT sub2----[ATCA]----oligo+BC----[AAAA]
   ATGG                   CAAC                   ATCA                  AAAA 
   (--)                   (--)                   (HF)                  (HF) 
```

**Set fidelity:** 0.9918 (4 overhangs, 2 in HF set)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                | Length  |
| --- | ----------------- | ------------------------ | ------- |
| 1   | BsaI product      | (in helper plasmid)      | --      |
| 2   | 3'WT+PolIII block | bsmbi_3wt_tile11_sub1    | 970 nt  |
| 3   | 3'WT+PolIII block | bsmbi_3wt_tile5_sub3     | 1424 nt |
| 4   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1 | --      |

```
  [CTTC]----3'WT+PolIII sub1----[GAGA]----3'WT+PolIII sub2----[AACA]
   CTTC                          GAGA                          AACA 
   (--)                          (HF)                          (HF) 
```

**Set fidelity:** 0.9952 (3 overhangs, 2 in HF set)

---

### Tile 12 of 21 -- Codons 749-824 (228 nt)

**Boundary overhangs:**

| Position          | Sequence | In HF Set | Fidelity |
| ----------------- | -------- | --------- | -------- |
| oh1 (5' boundary) | ATCA     | Yes       | 0.9919   |
| oh2 (3' boundary) | AAAC     | Yes       | 0.9917   |

**Variants:** 1520 mutations, 1520 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name             | Length     |
| --- | --------------- | --------------------- | ---------- |
| 1   | Oligo pool      | Tile 12 (1520 oligos) | 279-279 nt |
| 2   | 5'WT gene block | bsai_5wt_tile12_sub1  | 1237 nt    |
| 3   | 5'WT gene block | bsai_5wt_tile12_sub2  | 1051 nt    |
| 4   | Helper plasmid  | helper_plasmid_insert | --         |
| 5   | Enzyme + buffer | BsaI-HFv2 + CutSmart  | --         |

```
  [ATGG]----5'WT sub1----[CGAA]----5'WT sub2----[ATCA]----oligo+BC----[AAAA]
   ATGG                   CGAA                   ATCA                  AAAA 
   (--)                   (HF)                   (HF)                  (HF) 
```

**Set fidelity:** 0.9920 (4 overhangs, 3 in HF set)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                | Length  |
| --- | ----------------- | ------------------------ | ------- |
| 1   | BsaI product      | (in helper plasmid)      | --      |
| 2   | 3'WT+PolIII block | bsmbi_3wt_tile12_sub1    | 1006 nt |
| 3   | 3'WT+PolIII block | bsmbi_3wt_tile12_sub2    | 1160 nt |
| 4   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1 | --      |

```
  [AAAC]----3'WT+PolIII sub1----[CAAC]----3'WT+PolIII sub2----[AACA]
   AAAC                          CAAC                          AACA 
   (HF)                          (--)                          (HF) 
```

**Set fidelity:** 0.9997 (3 overhangs, 2 in HF set)

---

### Tile 13 of 21 -- Codons 825-902 (234 nt)

**Boundary overhangs:**

| Position          | Sequence | In HF Set | Fidelity |
| ----------------- | -------- | --------- | -------- |
| oh1 (5' boundary) | AAGC     | Yes       | 0.9916   |
| oh2 (3' boundary) | CAAG     | No        | 0.9751   |

**Variants:** 1560 mutations, 1560 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name             | Length     |
| --- | --------------- | --------------------- | ---------- |
| 1   | Oligo pool      | Tile 13 (1560 oligos) | 285-285 nt |
| 2   | 5'WT gene block | bsai_5wt_tile12_sub1  | 1237 nt    |
| 3   | 5'WT gene block | bsai_5wt_tile13_sub2  | 1279 nt    |
| 4   | Helper plasmid  | helper_plasmid_insert | --         |
| 5   | Enzyme + buffer | BsaI-HFv2 + CutSmart  | --         |

```
  [ATGG]----5'WT sub1----[CGAA]----5'WT sub2----[AAGC]----oligo+BC----[AAAA]
   ATGG                   CGAA                   AAGC                  AAAA 
   (--)                   (HF)                   (HF)                  (HF) 
```

**Set fidelity:** 0.9949 (4 overhangs, 3 in HF set)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                | Length  |
| --- | ----------------- | ------------------------ | ------- |
| 1   | BsaI product      | (in helper plasmid)      | --      |
| 2   | 3'WT+PolIII block | bsmbi_3wt_tile13_sub1    | 895 nt  |
| 3   | 3'WT+PolIII block | bsmbi_3wt_tile13_sub2    | 1037 nt |
| 4   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1 | --      |

```
  [CAAG]----3'WT+PolIII sub1----[CAGA]----3'WT+PolIII sub2----[AACA]
   CAAG                          CAGA                          AACA 
   (--)                          (--)                          (HF) 
```

**Set fidelity:** 0.9994 (3 overhangs, 1 in HF set)

---

### Tile 14 of 21 -- Codons 903-955 (159 nt)

**Boundary overhangs:**

| Position          | Sequence | In HF Set | Fidelity |
| ----------------- | -------- | --------- | -------- |
| oh1 (5' boundary) | ATCA     | Yes       | 0.9919   |
| oh2 (3' boundary) | CTGG     | No        | 0.8762   |

**Variants:** 1060 mutations, 1060 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name             | Length     |
| --- | --------------- | --------------------- | ---------- |
| 1   | Oligo pool      | Tile 14 (1060 oligos) | 210-210 nt |
| 2   | 5'WT gene block | bsai_5wt_tile14_sub1  | 1441 nt    |
| 3   | 5'WT gene block | bsai_5wt_tile14_sub2  | 1309 nt    |
| 4   | Helper plasmid  | helper_plasmid_insert | --         |
| 5   | Enzyme + buffer | BsaI-HFv2 + CutSmart  | --         |

```
  [ATGG]----5'WT sub1----[GAGA]----5'WT sub2----[ATCA]----oligo+BC----[AAAA]
   ATGG                   GAGA                   ATCA                  AAAA 
   (--)                   (HF)                   (HF)                  (HF) 
```

**Set fidelity:** 0.9991 (4 overhangs, 3 in HF set)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                | Length  |
| --- | ----------------- | ------------------------ | ------- |
| 1   | BsaI product      | (in helper plasmid)      | --      |
| 2   | 3'WT+PolIII block | bsmbi_3wt_tile14         | 1751 nt |
| 3   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1 | --      |

```
  [CTGG]----3'WT+PolIII----[AACA]
   CTGG                     AACA 
   (--)                     (HF) 
```

**Set fidelity:** 0.9999 (2 overhangs, 1 in HF set)

---

### Tile 15 of 21 -- Codons 956-1035 (240 nt)

**Boundary overhangs:**

| Position          | Sequence | In HF Set | Fidelity |
| ----------------- | -------- | --------- | -------- |
| oh1 (5' boundary) | AACA     | Yes       | 0.9975   |
| oh2 (3' boundary) | AAAC     | Yes       | 0.9917   |

**Variants:** 1600 mutations, 1600 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name             | Length     |
| --- | --------------- | --------------------- | ---------- |
| 1   | Oligo pool      | Tile 15 (1600 oligos) | 291-291 nt |
| 2   | 5'WT gene block | bsai_5wt_tile14_sub1  | 1441 nt    |
| 3   | 5'WT gene block | bsai_5wt_tile15_sub2  | 1468 nt    |
| 4   | Helper plasmid  | helper_plasmid_insert | --         |
| 5   | Enzyme + buffer | BsaI-HFv2 + CutSmart  | --         |

```
  [ATGG]----5'WT sub1----[GAGA]----5'WT sub2----[AACA]----oligo+BC----[AAAA]
   ATGG                   GAGA                   AACA                  AAAA 
   (--)                   (HF)                   (HF)                  (HF) 
```

**Set fidelity:** 0.9993 (4 overhangs, 3 in HF set)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                | Length  |
| --- | ----------------- | ------------------------ | ------- |
| 1   | BsaI product      | (in helper plasmid)      | --      |
| 2   | 3'WT+PolIII block | bsmbi_3wt_tile1_sub3     | 1511 nt |
| 3   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1 | --      |

```
  [AAAC]----3'WT+PolIII----[AACA]
   AAAC                     AACA 
   (HF)                     (HF) 
```

**Set fidelity:** 0.9999 (2 overhangs, 2 in HF set)

---

### Tile 16 of 21 -- Codons 1036-1115 (240 nt)

**Boundary overhangs:**

| Position          | Sequence | In HF Set | Fidelity |
| ----------------- | -------- | --------- | -------- |
| oh1 (5' boundary) | AACA     | Yes       | 0.9975   |
| oh2 (3' boundary) | GACC     | No        | 0.9377   |

**Variants:** 1600 mutations, 1600 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name             | Length     |
| --- | --------------- | --------------------- | ---------- |
| 1   | Oligo pool      | Tile 16 (1600 oligos) | 291-291 nt |
| 2   | 5'WT gene block | bsai_5wt_tile14_sub1  | 1441 nt    |
| 3   | 5'WT gene block | bsai_5wt_tile16_sub2  | 1708 nt    |
| 4   | Helper plasmid  | helper_plasmid_insert | --         |
| 5   | Enzyme + buffer | BsaI-HFv2 + CutSmart  | --         |

```
  [ATGG]----5'WT sub1----[GAGA]----5'WT sub2----[AACA]----oligo+BC----[AAAA]
   ATGG                   GAGA                   AACA                  AAAA 
   (--)                   (HF)                   (HF)                  (HF) 
```

**Set fidelity:** 0.9993 (4 overhangs, 3 in HF set)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                | Length  |
| --- | ----------------- | ------------------------ | ------- |
| 1   | BsaI product      | (in helper plasmid)      | --      |
| 2   | 3'WT+PolIII block | bsmbi_3wt_tile16         | 1271 nt |
| 3   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1 | --      |

```
  [GACC]----3'WT+PolIII----[AACA]
   GACC                     AACA 
   (--)                     (HF) 
```

**Set fidelity:** 0.9999 (2 overhangs, 1 in HF set)

---

### Tile 17 of 21 -- Codons 1116-1185 (210 nt)

**Boundary overhangs:**

| Position          | Sequence | In HF Set | Fidelity |
| ----------------- | -------- | --------- | -------- |
| oh1 (5' boundary) | GAGA     | Yes       | 0.9949   |
| oh2 (3' boundary) | CAAG     | No        | 0.9751   |

**Variants:** 1400 mutations, 1400 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name             | Length     |
| --- | --------------- | --------------------- | ---------- |
| 1   | Oligo pool      | Tile 17 (1400 oligos) | 261-261 nt |
| 2   | 5'WT gene block | bsai_5wt_tile17_sub1  | 1591 nt    |
| 3   | 5'WT gene block | bsai_5wt_tile17_sub2  | 1798 nt    |
| 4   | Helper plasmid  | helper_plasmid_insert | --         |
| 5   | Enzyme + buffer | BsaI-HFv2 + CutSmart  | --         |

```
  [ATGG]----5'WT sub1----[CAGA]----5'WT sub2----[GAGA]----oligo+BC----[AAAA]
   ATGG                   CAGA                   GAGA                  AAAA 
   (--)                   (--)                   (HF)                  (HF) 
```

**Set fidelity:** 0.9988 (4 overhangs, 2 in HF set)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                | Length  |
| --- | ----------------- | ------------------------ | ------- |
| 1   | BsaI product      | (in helper plasmid)      | --      |
| 2   | 3'WT+PolIII block | bsmbi_3wt_tile17         | 1061 nt |
| 3   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1 | --      |

```
  [CAAG]----3'WT+PolIII----[AACA]
   CAAG                     AACA 
   (--)                     (HF) 
```

**Set fidelity:** 0.9999 (2 overhangs, 1 in HF set)

---

### Tile 18 of 21 -- Codons 1186-1256 (213 nt)

**Boundary overhangs:**

| Position          | Sequence | In HF Set | Fidelity |
| ----------------- | -------- | --------- | -------- |
| oh1 (5' boundary) | GAGA     | Yes       | 0.9949   |
| oh2 (3' boundary) | CAGA     | No        | 0.9888   |

**Variants:** 1420 mutations, 1420 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name             | Length     |
| --- | --------------- | --------------------- | ---------- |
| 1   | Oligo pool      | Tile 18 (1420 oligos) | 264-264 nt |
| 2   | 5'WT gene block | bsai_5wt_tile12_sub1  | 1237 nt    |
| 3   | 5'WT gene block | bsai_5wt_tile18_sub2  | 1279 nt    |
| 4   | 5'WT gene block | bsai_5wt_tile18_sub3  | 1105 nt    |
| 5   | Helper plasmid  | helper_plasmid_insert | --         |
| 6   | Enzyme + buffer | BsaI-HFv2 + CutSmart  | --         |

```
  [ATGG]----5'WT sub1----[CGAA]----5'WT sub2----[AAAC]----5'WT sub3----[GAGA]----oligo+BC----[AAAA]
   ATGG                   CGAA                   AAAC                   GAGA                  AAAA 
   (--)                   (HF)                   (HF)                   (HF)                  (HF) 
```

**Set fidelity:** 0.9937 (5 overhangs, 4 in HF set)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                | Length |
| --- | ----------------- | ------------------------ | ------ |
| 1   | BsaI product      | (in helper plasmid)      | --     |
| 2   | 3'WT+PolIII block | bsmbi_3wt_tile18         | 848 nt |
| 3   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1 | --     |

```
  [CAGA]----3'WT+PolIII----[AACA]
   CAGA                     AACA 
   (--)                     (HF) 
```

**Set fidelity:** 1.0000 (2 overhangs, 1 in HF set)

---

### Tile 19 of 21 -- Codons 1257-1325 (207 nt)

**Boundary overhangs:**

| Position          | Sequence | In HF Set | Fidelity |
| ----------------- | -------- | --------- | -------- |
| oh1 (5' boundary) | GAGA     | Yes       | 0.9949   |
| oh2 (3' boundary) | AAAC     | Yes       | 0.9917   |

**Variants:** 1380 mutations, 1380 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name             | Length     |
| --- | --------------- | --------------------- | ---------- |
| 1   | Oligo pool      | Tile 19 (1380 oligos) | 258-258 nt |
| 2   | 5'WT gene block | bsai_5wt_tile12_sub1  | 1237 nt    |
| 3   | 5'WT gene block | bsai_5wt_tile18_sub2  | 1279 nt    |
| 4   | 5'WT gene block | bsai_5wt_tile19_sub3  | 1318 nt    |
| 5   | Helper plasmid  | helper_plasmid_insert | --         |
| 6   | Enzyme + buffer | BsaI-HFv2 + CutSmart  | --         |

```
  [ATGG]----5'WT sub1----[CGAA]----5'WT sub2----[AAAC]----5'WT sub3----[GAGA]----oligo+BC----[AAAA]
   ATGG                   CGAA                   AAAC                   GAGA                  AAAA 
   (--)                   (HF)                   (HF)                   (HF)                  (HF) 
```

**Set fidelity:** 0.9937 (5 overhangs, 4 in HF set)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                | Length |
| --- | ----------------- | ------------------------ | ------ |
| 1   | BsaI product      | (in helper plasmid)      | --     |
| 2   | 3'WT+PolIII block | bsmbi_3wt_tile19         | 641 nt |
| 3   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1 | --     |

```
  [AAAC]----3'WT+PolIII----[AACA]
   AAAC                     AACA 
   (HF)                     (HF) 
```

**Set fidelity:** 0.9999 (2 overhangs, 2 in HF set)

---

### Tile 20 of 21 -- Codons 1326-1377 (156 nt)

**Boundary overhangs:**

| Position          | Sequence | In HF Set | Fidelity |
| ----------------- | -------- | --------- | -------- |
| oh1 (5' boundary) | CTGA     | No        | 0.9566   |
| oh2 (3' boundary) | GAGA     | Yes       | 0.9949   |

**Variants:** 1040 mutations, 1040 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name             | Length     |
| --- | --------------- | --------------------- | ---------- |
| 1   | Oligo pool      | Tile 20 (1040 oligos) | 207-207 nt |
| 2   | 5'WT gene block | bsai_5wt_tile14_sub1  | 1441 nt    |
| 3   | 5'WT gene block | bsai_5wt_tile20_sub2  | 1159 nt    |
| 4   | 5'WT gene block | bsai_5wt_tile20_sub3  | 1441 nt    |
| 5   | Helper plasmid  | helper_plasmid_insert | --         |
| 6   | Enzyme + buffer | BsaI-HFv2 + CutSmart  | --         |

```
  [ATGG]----5'WT sub1----[GAGA]----5'WT sub2----[CAAC]----5'WT sub3----[CTGA]----oligo+BC----[AAAA]
   ATGG                   GAGA                   CAAC                   CTGA                  AAAA 
   (--)                   (HF)                   (--)                   (--)                  (HF) 
```

**Set fidelity:** 0.9903 (5 overhangs, 2 in HF set)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                | Length |
| --- | ----------------- | ------------------------ | ------ |
| 1   | BsaI product      | (in helper plasmid)      | --     |
| 2   | 3'WT+PolIII block | bsmbi_3wt_tile20         | 485 nt |
| 3   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1 | --     |

```
  [GAGA]----3'WT+PolIII----[AACA]
   GAGA                     AACA 
   (HF)                     (HF) 
```

**Set fidelity:** 0.9999 (2 overhangs, 2 in HF set)

---

### Tile 21 of 21 -- Codons 1378-1448 (213 nt)

**Boundary overhangs:**

| Position          | Sequence | In HF Set | Fidelity |
| ----------------- | -------- | --------- | -------- |
| oh1 (5' boundary) | TACG     | No        | 0.8873   |
| oh2 (3' boundary) | GTGA     | No        | 0.9687   |

**Variants:** 1420 mutations, 1420 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name             | Length     |
| --- | --------------- | --------------------- | ---------- |
| 1   | Oligo pool      | Tile 21 (1420 oligos) | 264-264 nt |
| 2   | 5'WT gene block | bsai_5wt_tile14_sub1  | 1441 nt    |
| 3   | 5'WT gene block | bsai_5wt_tile21_sub2  | 1315 nt    |
| 4   | 5'WT gene block | bsai_5wt_tile21_sub3  | 1441 nt    |
| 5   | Helper plasmid  | helper_plasmid_insert | --         |
| 6   | Enzyme + buffer | BsaI-HFv2 + CutSmart  | --         |

```
  [ATGG]----5'WT sub1----[GAGA]----5'WT sub2----[CAAC]----5'WT sub3----[TACG]----oligo+BC----[AAAA]
   ATGG                   GAGA                   CAAC                   TACG                  AAAA 
   (--)                   (HF)                   (--)                   (--)                  (HF) 
```

**Set fidelity:** 0.9902 (5 overhangs, 2 in HF set)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component            | Part name                | Length |
| --- | -------------------- | ------------------------ | ------ |
| 1   | BsaI product         | (in helper plasmid)      | --     |
| 2   | PolIII-only fragment | bsmbi_polIII_tile21      | 272 nt |
| 3   | Enzyme + buffer      | BsmBI-v2 + NEBuffer r3.1 | --     |

```
  [GTGA]----PolIII----[AACA]
   GTGA                AACA 
   (--)                (HF) 
```

**Set fidelity:** 0.9999 (2 overhangs, 1 in HF set)

---

## 7. PaqCI Level 2 Reaction (37C)

The final cloning step transfers the complete insert from the helper plasmid
into the destination backbone.

**Components per reaction:**

| # | Component | Detail |
| --- | --- | --- |
| 1 | BsmBI product | Complete insert in helper plasmid |
| 2 | Destination backbone | PaqCI-compatible receiving vector |
| 3 | Enzyme + buffer | PaqCI + CutSmart (37C) |

**PaqCI overhangs:**

- paqci_star2 (5'): `AGTC`
- paqci_star1 (3'): `TCGA`

```
[PaqCI** AGTC]--[gene+mutation]--[PolIII]--[barcode]--[PaqCI* TCGA]
```

## 8. Gene Block Order Sheet

Order these gene blocks as synthesized gene fragments (e.g., Twist gene fragments, IDT gBlocks).
Gene blocks are synthesized once and reused across experiments.

**Total blocks:** 57

| Block name            | Length (nt) | Enzyme type | Gene region                                                                                                                     |
| --------------------- | ----------- | ----------- | ------------------------------------------------------------------------------------------------------------------------------- |
| bsai_5wt_tile10_sub1  | 817         | BsaI        | 5wt_tile10_sub1                                                                                                                 |
| bsai_5wt_tile10_sub2  | 1093        | BsaI        | 5wt_tile10_sub2                                                                                                                 |
| bsai_5wt_tile11_sub1  | 961         | BsaI        | 5wt_tile11_sub1                                                                                                                 |
| bsai_5wt_tile11_sub2  | 1090        | BsaI        | 5wt_tile11_sub2                                                                                                                 |
| bsai_5wt_tile12_sub1  | 1237        | BsaI        | 5wt_tile12_sub1;5wt_tile13_sub1;5wt_tile18_sub1;5wt_tile19_sub1                                                                 |
| bsai_5wt_tile12_sub2  | 1051        | BsaI        | 5wt_tile12_sub2                                                                                                                 |
| bsai_5wt_tile13_sub2  | 1279        | BsaI        | 5wt_tile13_sub2                                                                                                                 |
| bsai_5wt_tile14_sub1  | 1441        | BsaI        | 5wt_tile14_sub1;5wt_tile15_sub1;5wt_tile16_sub1;5wt_tile20_sub1;5wt_tile21_sub1                                                 |
| bsai_5wt_tile14_sub2  | 1309        | BsaI        | 5wt_tile14_sub2                                                                                                                 |
| bsai_5wt_tile15_sub2  | 1468        | BsaI        | 5wt_tile15_sub2                                                                                                                 |
| bsai_5wt_tile16_sub2  | 1708        | BsaI        | 5wt_tile16_sub2                                                                                                                 |
| bsai_5wt_tile17_sub1  | 1591        | BsaI        | 5wt_tile17_sub1                                                                                                                 |
| bsai_5wt_tile17_sub2  | 1798        | BsaI        | 5wt_tile17_sub2                                                                                                                 |
| bsai_5wt_tile18_sub2  | 1279        | BsaI        | 5wt_tile18_sub2;5wt_tile19_sub2                                                                                                 |
| bsai_5wt_tile18_sub3  | 1105        | BsaI        | 5wt_tile18_sub3                                                                                                                 |
| bsai_5wt_tile19_sub3  | 1318        | BsaI        | 5wt_tile19_sub3                                                                                                                 |
| bsai_5wt_tile2        | 208         | BsaI        | 5wt_tile2                                                                                                                       |
| bsai_5wt_tile20_sub2  | 1159        | BsaI        | 5wt_tile20_sub2                                                                                                                 |
| bsai_5wt_tile20_sub3  | 1441        | BsaI        | 5wt_tile20_sub3                                                                                                                 |
| bsai_5wt_tile21_sub2  | 1315        | BsaI        | 5wt_tile21_sub2                                                                                                                 |
| bsai_5wt_tile21_sub3  | 1441        | BsaI        | 5wt_tile21_sub3                                                                                                                 |
| bsai_5wt_tile3        | 421         | BsaI        | 5wt_tile3                                                                                                                       |
| bsai_5wt_tile4        | 658         | BsaI        | 5wt_tile4                                                                                                                       |
| bsai_5wt_tile5        | 892         | BsaI        | 5wt_tile5                                                                                                                       |
| bsai_5wt_tile6        | 1120        | BsaI        | 5wt_tile6                                                                                                                       |
| bsai_5wt_tile7        | 1237        | BsaI        | 5wt_tile7                                                                                                                       |
| bsai_5wt_tile8        | 1441        | BsaI        | 5wt_tile8                                                                                                                       |
| bsai_5wt_tile9        | 1654        | BsaI        | 5wt_tile9                                                                                                                       |
| bsmbi_3wt_tile10_sub1 | 1207        | BsmBI       | 3wt_polIII_tile10_sub1                                                                                                          |
| bsmbi_3wt_tile11_sub1 | 970         | BsmBI       | 3wt_polIII_tile11_sub1                                                                                                          |
| bsmbi_3wt_tile12_sub1 | 1006        | BsmBI       | 3wt_polIII_tile12_sub1                                                                                                          |
| bsmbi_3wt_tile12_sub2 | 1160        | BsmBI       | 3wt_polIII_tile12_sub2                                                                                                          |
| bsmbi_3wt_tile13_sub1 | 895         | BsmBI       | 3wt_polIII_tile13_sub1                                                                                                          |
| bsmbi_3wt_tile13_sub2 | 1037        | BsmBI       | 3wt_polIII_tile13_sub2                                                                                                          |
| bsmbi_3wt_tile14      | 1751        | BsmBI       | 3wt_polIII_tile14                                                                                                               |
| bsmbi_3wt_tile16      | 1271        | BsmBI       | 3wt_polIII_tile16                                                                                                               |
| bsmbi_3wt_tile17      | 1061        | BsmBI       | 3wt_polIII_tile17                                                                                                               |
| bsmbi_3wt_tile18      | 848         | BsmBI       | 3wt_polIII_tile18                                                                                                               |
| bsmbi_3wt_tile19      | 641         | BsmBI       | 3wt_polIII_tile19                                                                                                               |
| bsmbi_3wt_tile1_sub1  | 1324        | BsmBI       | 3wt_polIII_tile1_sub1                                                                                                           |
| bsmbi_3wt_tile1_sub2  | 1639        | BsmBI       | 3wt_polIII_tile1_sub2                                                                                                           |
| bsmbi_3wt_tile1_sub3  | 1511        | BsmBI       | 3wt_polIII_tile1_sub3;3wt_polIII_tile2_sub3;3wt_polIII_tile3_sub3;3wt_polIII_tile4_sub3;3wt_polIII_tile8_sub2;3wt_polIII_tile15 |
| bsmbi_3wt_tile20      | 485         | BsmBI       | 3wt_polIII_tile20                                                                                                               |
| bsmbi_3wt_tile2_sub1  | 1480        | BsmBI       | 3wt_polIII_tile2_sub1                                                                                                           |
| bsmbi_3wt_tile2_sub2  | 1270        | BsmBI       | 3wt_polIII_tile2_sub2;3wt_polIII_tile3_sub2                                                                                     |
| bsmbi_3wt_tile3_sub1  | 1243        | BsmBI       | 3wt_polIII_tile3_sub1                                                                                                           |
| bsmbi_3wt_tile4_sub1  | 1129        | BsmBI       | 3wt_polIII_tile4_sub1                                                                                                           |
| bsmbi_3wt_tile4_sub2  | 1150        | BsmBI       | 3wt_polIII_tile4_sub2                                                                                                           |
| bsmbi_3wt_tile5_sub1  | 1135        | BsmBI       | 3wt_polIII_tile5_sub1                                                                                                           |
| bsmbi_3wt_tile5_sub2  | 1003        | BsmBI       | 3wt_polIII_tile5_sub2                                                                                                           |
| bsmbi_3wt_tile5_sub3  | 1424        | BsmBI       | 3wt_polIII_tile5_sub3;3wt_polIII_tile9_sub2;3wt_polIII_tile10_sub2;3wt_polIII_tile11_sub2                                       |
| bsmbi_3wt_tile6_sub1  | 1729        | BsmBI       | 3wt_polIII_tile6_sub1                                                                                                           |
| bsmbi_3wt_tile6_sub2  | 1694        | BsmBI       | 3wt_polIII_tile6_sub2;3wt_polIII_tile7_sub2                                                                                     |
| bsmbi_3wt_tile7_sub1  | 1525        | BsmBI       | 3wt_polIII_tile7_sub1                                                                                                           |
| bsmbi_3wt_tile8_sub1  | 1495        | BsmBI       | 3wt_polIII_tile8_sub1                                                                                                           |
| bsmbi_3wt_tile9_sub1  | 1348        | BsmBI       | 3wt_polIII_tile9_sub1                                                                                                           |
| bsmbi_polIII_tile21   | 272         | BsmBI       | polIII_tile21                                                                                                                   |

## 9. Domestication Log

7 endogenous enzyme site(s) were removed via silent mutations:

| site_start | enzyme | strand | codon_pos | original_codon | new_codon | aa  |
| ---------- | ------ | ------ | --------- | -------------- | --------- | --- |
| 1213       | BsaI   | -      | 405       | GAG            | GAA       | E   |
| 1759       | BsaI   | -      | 587       | GAG            | GAA       | E   |
| 2030       | BsaI   | -      | 677       | AGA            | AGG       | R   |
| 404        | BsmBI  | -      | 135       | AGA            | AGG       | R   |
| 2609       | BsmBI  | -      | 870       | AGA            | AGG       | R   |
| 3914       | BsmBI  | -      | 1305      | AGA            | AGG       | R   |
| 3595       | PaqCI  | +      | 1199      | CAC            | CAT       | H   |

## 10. Configuration Parameters

| Parameter                   | Value |
| --------------------------- | ----- |
| max_oligo_length            | 300   |
| max_geneblock_length        | 1800  |
| barcode_length              | 15    |
| min_hamming_distance        | 3     |
| barcode_prefix_length       | 8     |
| barcodes_per_variant        | 1     |
| overhang_fidelity_threshold | 0.95  |
| boundary_method             | dp    |
| multi_k_search              | TRUE  |
| auto_domesticate            | TRUE  |

