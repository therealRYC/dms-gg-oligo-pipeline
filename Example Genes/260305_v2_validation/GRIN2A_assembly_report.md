# DMS-GG Assembly Report: GRIN2A

Generated: 2026-03-05 14:25:14
Pipeline: dms-gg-oligo-pipeline (3-Enzyme Architecture: BsaI + BsmBI + PaqCI)

---

## 1. Gene Summary

| Property             | Value                                                                          |
| -------------------- | ------------------------------------------------------------------------------ |
| Gene name            | GRIN2A_NM_000833.5 Human GRIN2A native CDS (NM_000833.5, NP_000824.1, 1464 aa) |
| CDS length           | 4395 nt (1465 codons)                                                          |
| Protein length       | 1464 aa                                                                        |
| Number of tiles      | 30                                                                             |
| Total variants       | 30681                                                                          |
| Total oligos         | 306810                                                                         |
| Oligo length range   | 149-284 nt                                                                     |
| Gene blocks to order | 65                                                                             |
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
| 1    | 1-51      | 9870   | 209 nt |
| 2    | 48-115    | 13440  | 260 nt |
| 3    | 112-148   | 6930   | 167 nt |
| 4    | 145-183   | 7350   | 173 nt |
| 5    | 180-217   | 7140   | 170 nt |
| 6    | 214-270   | 11130  | 227 nt |
| 7    | 267-337   | 14070  | 269 nt |
| 8    | 334-371   | 7140   | 170 nt |
| 9    | 368-420   | 10290  | 215 nt |
| 10   | 417-458   | 7980   | 182 nt |
| 11   | 455-499   | 8610   | 191 nt |
| 12   | 496-549   | 10500  | 218 nt |
| 13   | 546-603   | 11340  | 230 nt |
| 14   | 600-671   | 14280  | 272 nt |
| 15   | 668-708   | 7770   | 179 nt |
| 16   | 705-771   | 13230  | 257 nt |
| 17   | 768-811   | 8400   | 188 nt |
| 18   | 808-883   | 15120  | 284 nt |
| 19   | 880-927   | 9240   | 200 nt |
| 20   | 924-956   | 6090   | 155 nt |
| 21   | 953-983   | 5670   | 149 nt |
| 22   | 980-1020  | 7770   | 179 nt |
| 23   | 1017-1081 | 12810  | 251 nt |
| 24   | 1078-1110 | 6090   | 155 nt |
| 25   | 1107-1175 | 13650  | 263 nt |
| 26   | 1172-1237 | 13020  | 254 nt |
| 27   | 1234-1278 | 8610   | 191 nt |
| 28   | 1275-1343 | 13650  | 263 nt |
| 29   | 1340-1413 | 14700  | 278 nt |
| 30   | 1410-1465 | 10920  | 224 nt |

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
| oligo_lengths          | All oligos within synthesis length limit                      | PASS   | Range: 149-284 nt (limit: 300)                                                                                                                      |
| block_lengths          | All gene blocks within synthesis length limit                 | PASS   | Range: 159-1738 nt (limit: 1800)                                                                                                                    |
| barcode_junction_sites | No enzyme sites at barcode-context junctions                  | PASS   | 0 barcode(s) with junction enzyme sites (left='CACACC', right='AGAATG')                                                                             |
| barcode_uniqueness     | All barcodes are unique                                       | PASS   | 306810 unique / 306810 total                                                                                                                        |
| tile_coverage          | Tiles cover entire gene without gaps                          | PASS   | 4395 / 4395 nt covered                                                                                                                              |
| variant_count          | Expected number of variants generated                         | PASS   | 30681 unique variants (expected: 30681 across 1461/1463 mutable positions; 27759 missense + 1461 nonsense + 1461 wt_control; 2 position(s) skipped) |
| single_codon_change    | Each non-control variant differs by exactly one codon from WT | PASS   | 292200 / 292200 variants confirmed (WT controls excluded)                                                                                           |
| oligo_gc_content       | Oligo GC content within reasonable range (25-75%)             | PASS   | GC range: 40.2-66% | 0 oligo(s) with extreme GC                                                                                                     |
| domestication_complete | Gene domesticated for all 3 enzymes (BsaI, BsmBI, PaqCI)      | PASS   | No enzyme sites in gene                                                                                                                             |
| overhang_fidelity      | Tile boundary overhangs have adequate fidelity                | FAIL   | 24 tile(s) with low-fidelity boundary overhangs (<0.80)                                                                                             |
| tile_manifests         | Per-tile assembly manifests complete                          | PASS   | 30 tile manifest(s) generated                                                                                                                       |
| helper_plasmid         | Helper plasmid free of unintended BsmBI sites                 | PASS   | OK                                                                                                                                                  |
| reaction_fidelity      | Per-reaction set-level overhang fidelity                      | PASS   | Min set fidelity: 0.894 across 60 reactions | 3 reaction(s) below 0.90                                                                              |
| barcode_poliii_term    | No barcodes contain PolIII terminator signal (TTTT)           | PASS   | 0 / 306810 barcode(s) contain TTTT                                                                                                                  |
| block_min_length       | All gene blocks above synthesis minimum length                | FAIL   | 3 block(s) below 300 nt minimum. Range: 159-1738 nt                                                                                                 |

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

### Tile 1 of 30 -- Codons 1-51 (153 nt)

**Boundary overhangs:**

| Position          | Sequence | Fidelity |
| ----------------- | -------- | -------- |
| oh1 (5' boundary) | ATGG     | 0.5393   |
| oh2 (3' boundary) | ACTT     | 0.7315   |

**Variants:** 9870 mutations, 9870 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name                          | Length | 5' OH | 3' OH |
| --- | --------------- | ---------------------------------- | ------ | ----- | ----- |
| 1   | 5'WT gene block | (none -- tile starts at gene nt 1) | --     | --    | --    |
| 2   | Oligo pool      | Tile 1 (9870 oligos)               | 209 nt | ATGG  | AGAA  |
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
| 2   | 3'WT block        | bsmbi_3wt_tile1_sub1     | 1227 nt | ACTT  | GAAA  |
| 3   | 3'WT block        | bsmbi_3wt_tile1_sub2     | 957 nt  | GAAA  | GAAA  |
| 4   | 3'WT block        | bsmbi_3wt_tile1_sub3     | 1734 nt | GAAA  | GAAA  |
| 5   | 3'WT+PolIII block | bsmbi_3wt_tile1_sub4     | 1490 nt | GAAA  | CACC  |
| 6   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1 | --      | --    | --    |

```
  [ACTT]----3'WT sub1----[GAAA]----3'WT sub2----[GAAA]----3'WT sub3----[GAAA]----3'WT+PolIII sub4----[CACC]
   ACTT                   GAAA                   GAAA                   GAAA                          CACC 
```

**Set fidelity:** 1.0000 (3 overhangs)

---

### Tile 2 of 30 -- Codons 48-115 (204 nt)

**Boundary overhangs:**

| Position          | Sequence | Fidelity |
| ----------------- | -------- | -------- |
| oh1 (5' boundary) | GAGC     | 0.5446   |
| oh2 (3' boundary) | TTTT     | 0.8623   |

**Variants:** 13440 mutations, 13440 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name             | Length | 5' OH | 3' OH |
| --- | --------------- | --------------------- | ------ | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile2        | 159 nt | ATGG  | GAGC  |
| 2   | Oligo pool      | Tile 2 (13440 oligos) | 260 nt | GAGC  | AGAA  |
| 3   | Helper plasmid  | helper_plasmid_insert | --     | --    | --    |
| 4   | Enzyme + buffer | BsaI-HFv2 + CutSmart  | --     | --    | --    |

```
  [ATGG]----5'WT block----[GAGC]----oligo+BC----[AGAA]
   ATGG                    GAGC                  AGAA 
```

**Set fidelity:** 1.0000 (3 overhangs)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------ | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)      | --      | --    | --    |
| 2   | 3'WT block        | bsmbi_3wt_tile2_sub1     | 1035 nt | TTTT  | GAAA  |
| 3   | 3'WT block        | bsmbi_3wt_tile1_sub2     | 957 nt  | GAAA  | GAAA  |
| 4   | 3'WT block        | bsmbi_3wt_tile1_sub3     | 1734 nt | GAAA  | GAAA  |
| 5   | 3'WT+PolIII block | bsmbi_3wt_tile1_sub4     | 1490 nt | GAAA  | CACC  |
| 6   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1 | --      | --    | --    |

```
  [TTTT]----3'WT sub1----[GAAA]----3'WT sub2----[GAAA]----3'WT sub3----[GAAA]----3'WT+PolIII sub4----[CACC]
   TTTT                   GAAA                   GAAA                   GAAA                          CACC 
```

**Set fidelity:** 1.0000 (3 overhangs)

---

### Tile 3 of 30 -- Codons 112-148 (111 nt)

**Boundary overhangs:**

| Position          | Sequence | Fidelity |
| ----------------- | -------- | -------- |
| oh1 (5' boundary) | ATGC     | 0.6171   |
| oh2 (3' boundary) | TGGA     | 0.7377   |

**Variants:** 6930 mutations, 6930 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name             | Length | 5' OH | 3' OH |
| --- | --------------- | --------------------- | ------ | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile3        | 351 nt | ATGG  | ATGC  |
| 2   | Oligo pool      | Tile 3 (6930 oligos)  | 167 nt | ATGC  | AGAA  |
| 3   | Helper plasmid  | helper_plasmid_insert | --     | --    | --    |
| 4   | Enzyme + buffer | BsaI-HFv2 + CutSmart  | --     | --    | --    |

```
  [ATGG]----5'WT block----[ATGC]----oligo+BC----[AGAA]
   ATGG                    ATGC                  AGAA 
```

**Set fidelity:** 0.9866 (3 overhangs)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------ | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)      | --      | --    | --    |
| 2   | 3'WT block        | bsmbi_3wt_tile3_sub1     | 936 nt  | TGGA  | GAAA  |
| 3   | 3'WT block        | bsmbi_3wt_tile1_sub2     | 957 nt  | GAAA  | GAAA  |
| 4   | 3'WT block        | bsmbi_3wt_tile1_sub3     | 1734 nt | GAAA  | GAAA  |
| 5   | 3'WT+PolIII block | bsmbi_3wt_tile1_sub4     | 1490 nt | GAAA  | CACC  |
| 6   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1 | --      | --    | --    |

```
  [TGGA]----3'WT sub1----[GAAA]----3'WT sub2----[GAAA]----3'WT sub3----[GAAA]----3'WT+PolIII sub4----[CACC]
   TGGA                   GAAA                   GAAA                   GAAA                          CACC 
```

**Set fidelity:** 1.0000 (3 overhangs)

---

### Tile 4 of 30 -- Codons 145-183 (117 nt)

**Boundary overhangs:**

| Position          | Sequence | Fidelity |
| ----------------- | -------- | -------- |
| oh1 (5' boundary) | TTCC     | 0.7958   |
| oh2 (3' boundary) | ATTC     | 0.7084   |

**Variants:** 7350 mutations, 7350 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name             | Length | 5' OH | 3' OH |
| --- | --------------- | --------------------- | ------ | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile4        | 450 nt | ATGG  | TTCC  |
| 2   | Oligo pool      | Tile 4 (7350 oligos)  | 173 nt | TTCC  | AGAA  |
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
| 2   | 3'WT block        | bsmbi_3wt_tile4_sub1     | 831 nt  | ATTC  | GAAA  |
| 3   | 3'WT block        | bsmbi_3wt_tile1_sub2     | 957 nt  | GAAA  | GAAA  |
| 4   | 3'WT block        | bsmbi_3wt_tile1_sub3     | 1734 nt | GAAA  | GAAA  |
| 5   | 3'WT+PolIII block | bsmbi_3wt_tile1_sub4     | 1490 nt | GAAA  | CACC  |
| 6   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1 | --      | --    | --    |

```
  [ATTC]----3'WT sub1----[GAAA]----3'WT sub2----[GAAA]----3'WT sub3----[GAAA]----3'WT+PolIII sub4----[CACC]
   ATTC                   GAAA                   GAAA                   GAAA                          CACC 
```

**Set fidelity:** 1.0000 (3 overhangs)

---

### Tile 5 of 30 -- Codons 180-217 (114 nt)

**Boundary overhangs:**

| Position          | Sequence | Fidelity |
| ----------------- | -------- | -------- |
| oh1 (5' boundary) | TACA     | 0.8652   |
| oh2 (3' boundary) | AGTC     | 0.5938   |

**Variants:** 7140 mutations, 7140 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name             | Length | 5' OH | 3' OH |
| --- | --------------- | --------------------- | ------ | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile5        | 555 nt | ATGG  | TACA  |
| 2   | Oligo pool      | Tile 5 (7140 oligos)  | 170 nt | TACA  | AGAA  |
| 3   | Helper plasmid  | helper_plasmid_insert | --     | --    | --    |
| 4   | Enzyme + buffer | BsaI-HFv2 + CutSmart  | --     | --    | --    |

```
  [ATGG]----5'WT block----[TACA]----oligo+BC----[AGAA]
   ATGG                    TACA                  AGAA 
```

**Set fidelity:** 1.0000 (3 overhangs)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------ | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)      | --      | --    | --    |
| 2   | 3'WT block        | bsmbi_3wt_tile5_sub1     | 729 nt  | AGTC  | GAAA  |
| 3   | 3'WT block        | bsmbi_3wt_tile1_sub2     | 957 nt  | GAAA  | GAAA  |
| 4   | 3'WT block        | bsmbi_3wt_tile1_sub3     | 1734 nt | GAAA  | GAAA  |
| 5   | 3'WT+PolIII block | bsmbi_3wt_tile1_sub4     | 1490 nt | GAAA  | CACC  |
| 6   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1 | --      | --    | --    |

```
  [AGTC]----3'WT sub1----[GAAA]----3'WT sub2----[GAAA]----3'WT sub3----[GAAA]----3'WT+PolIII sub4----[CACC]
   AGTC                   GAAA                   GAAA                   GAAA                          CACC 
```

**Set fidelity:** 1.0000 (3 overhangs)

---

### Tile 6 of 30 -- Codons 214-270 (171 nt)

**Boundary overhangs:**

| Position          | Sequence | Fidelity |
| ----------------- | -------- | -------- |
| oh1 (5' boundary) | AAGA     | 0.9209   |
| oh2 (3' boundary) | AAAA     | 0.9502   |

**Variants:** 11130 mutations, 11130 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name             | Length | 5' OH | 3' OH |
| --- | --------------- | --------------------- | ------ | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile6        | 657 nt | ATGG  | AAGA  |
| 2   | Oligo pool      | Tile 6 (11130 oligos) | 227 nt | AAGA  | AGAA  |
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
| 2   | 3'WT block        | bsmbi_3wt_tile6_sub1     | 570 nt  | AAAA  | GAAA  |
| 3   | 3'WT block        | bsmbi_3wt_tile1_sub2     | 957 nt  | GAAA  | GAAA  |
| 4   | 3'WT block        | bsmbi_3wt_tile1_sub3     | 1734 nt | GAAA  | GAAA  |
| 5   | 3'WT+PolIII block | bsmbi_3wt_tile1_sub4     | 1490 nt | GAAA  | CACC  |
| 6   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1 | --      | --    | --    |

```
  [AAAA]----3'WT sub1----[GAAA]----3'WT sub2----[GAAA]----3'WT sub3----[GAAA]----3'WT+PolIII sub4----[CACC]
   AAAA                   GAAA                   GAAA                   GAAA                          CACC 
```

**Set fidelity:** 0.9814 (3 overhangs)

---

### Tile 7 of 30 -- Codons 267-337 (213 nt)

**Boundary overhangs:**

| Position          | Sequence | Fidelity |
| ----------------- | -------- | -------- |
| oh1 (5' boundary) | CTCA     | 0.6872   |
| oh2 (3' boundary) | ATTT     | 0.7664   |

**Variants:** 14070 mutations, 14070 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name             | Length | 5' OH | 3' OH |
| --- | --------------- | --------------------- | ------ | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile7        | 816 nt | ATGG  | CTCA  |
| 2   | Oligo pool      | Tile 7 (14070 oligos) | 269 nt | CTCA  | AGAA  |
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
| 2   | 3'WT block        | bsmbi_3wt_tile7_sub1     | 369 nt  | ATTT  | GAAA  |
| 3   | 3'WT block        | bsmbi_3wt_tile1_sub2     | 957 nt  | GAAA  | GAAA  |
| 4   | 3'WT block        | bsmbi_3wt_tile1_sub3     | 1734 nt | GAAA  | GAAA  |
| 5   | 3'WT+PolIII block | bsmbi_3wt_tile1_sub4     | 1490 nt | GAAA  | CACC  |
| 6   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1 | --      | --    | --    |

```
  [ATTT]----3'WT sub1----[GAAA]----3'WT sub2----[GAAA]----3'WT sub3----[GAAA]----3'WT+PolIII sub4----[CACC]
   ATTT                   GAAA                   GAAA                   GAAA                          CACC 
```

**Set fidelity:** 1.0000 (3 overhangs)

---

### Tile 8 of 30 -- Codons 334-371 (114 nt)

**Boundary overhangs:**

| Position          | Sequence | Fidelity |
| ----------------- | -------- | -------- |
| oh1 (5' boundary) | TTGC     | 0.7336   |
| oh2 (3' boundary) | GGAA     | 0.7463   |

**Variants:** 7140 mutations, 7140 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name             | Length  | 5' OH | 3' OH |
| --- | --------------- | --------------------- | ------- | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile8        | 1017 nt | ATGG  | TTGC  |
| 2   | Oligo pool      | Tile 8 (7140 oligos)  | 170 nt  | TTGC  | AGAA  |
| 3   | Helper plasmid  | helper_plasmid_insert | --      | --    | --    |
| 4   | Enzyme + buffer | BsaI-HFv2 + CutSmart  | --      | --    | --    |

```
  [ATGG]----5'WT block----[TTGC]----oligo+BC----[AGAA]
   ATGG                    TTGC                  AGAA 
```

**Set fidelity:** 1.0000 (3 overhangs)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------ | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)      | --      | --    | --    |
| 2   | 3'WT block        | bsmbi_3wt_tile8_sub1     | 1206 nt | GGAA  | GAAA  |
| 3   | 3'WT block        | bsmbi_3wt_tile1_sub3     | 1734 nt | GAAA  | GAAA  |
| 4   | 3'WT+PolIII block | bsmbi_3wt_tile1_sub4     | 1490 nt | GAAA  | CACC  |
| 5   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1 | --      | --    | --    |

```
  [GGAA]----3'WT sub1----[GAAA]----3'WT sub2----[GAAA]----3'WT+PolIII sub3----[GAAA][CACC]
   GGAA                   GAAA                   GAAA                          GAAA  CACC 
```

**Set fidelity:** 0.9596 (3 overhangs)

---

### Tile 9 of 30 -- Codons 368-420 (159 nt)

**Boundary overhangs:**

| Position          | Sequence | Fidelity |
| ----------------- | -------- | -------- |
| oh1 (5' boundary) | AAAG     | 0.7511   |
| oh2 (3' boundary) | GGAA     | 0.7463   |

**Variants:** 10290 mutations, 10290 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name             | Length  | 5' OH | 3' OH |
| --- | --------------- | --------------------- | ------- | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile9        | 1119 nt | ATGG  | AAAG  |
| 2   | Oligo pool      | Tile 9 (10290 oligos) | 215 nt  | AAAG  | AGAA  |
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
| 2   | 3'WT block        | bsmbi_3wt_tile9_sub1     | 1059 nt | GGAA  | GAAA  |
| 3   | 3'WT block        | bsmbi_3wt_tile1_sub3     | 1734 nt | GAAA  | GAAA  |
| 4   | 3'WT+PolIII block | bsmbi_3wt_tile1_sub4     | 1490 nt | GAAA  | CACC  |
| 5   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1 | --      | --    | --    |

```
  [GGAA]----3'WT sub1----[GAAA]----3'WT sub2----[GAAA]----3'WT+PolIII sub3----[GAAA][CACC]
   GGAA                   GAAA                   GAAA                          GAAA  CACC 
```

**Set fidelity:** 0.9596 (3 overhangs)

---

### Tile 10 of 30 -- Codons 417-458 (126 nt)

**Boundary overhangs:**

| Position          | Sequence | Fidelity |
| ----------------- | -------- | -------- |
| oh1 (5' boundary) | GTCA     | 0.5915   |
| oh2 (3' boundary) | GGGG     | 0.5299   |

**Variants:** 7980 mutations, 7980 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name             | Length  | 5' OH | 3' OH |
| --- | --------------- | --------------------- | ------- | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile10       | 1266 nt | ATGG  | GTCA  |
| 2   | Oligo pool      | Tile 10 (7980 oligos) | 182 nt  | GTCA  | AGAA  |
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
| 2   | 3'WT block        | bsmbi_3wt_tile10_sub1    | 945 nt  | GGGG  | GAAA  |
| 3   | 3'WT block        | bsmbi_3wt_tile1_sub3     | 1734 nt | GAAA  | GAAA  |
| 4   | 3'WT+PolIII block | bsmbi_3wt_tile1_sub4     | 1490 nt | GAAA  | CACC  |
| 5   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1 | --      | --    | --    |

```
  [GGGG]----3'WT sub1----[GAAA]----3'WT sub2----[GAAA]----3'WT+PolIII sub3----[CACC]
   GGGG                   GAAA                   GAAA                          CACC 
```

**Set fidelity:** 1.0000 (3 overhangs)

---

### Tile 11 of 30 -- Codons 455-499 (135 nt)

**Boundary overhangs:**

| Position          | Sequence | Fidelity |
| ----------------- | -------- | -------- |
| oh1 (5' boundary) | TGCT     | 0.5975   |
| oh2 (3' boundary) | TGAA     | 0.8621   |

**Variants:** 8610 mutations, 8610 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name             | Length  | 5' OH | 3' OH |
| --- | --------------- | --------------------- | ------- | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile11_sub1  | 1380 nt | ATGG  | TGCT  |
| 2   | Oligo pool      | Tile 11 (8610 oligos) | 191 nt  | TGCT  | AGAA  |
| 3   | Helper plasmid  | helper_plasmid_insert | --      | --    | --    |
| 4   | Enzyme + buffer | BsaI-HFv2 + CutSmart  | --      | --    | --    |

```
  [ATGG]----5'WT sub1----[GAAA]----oligo+BC----[TGCT][AGAA]
   ATGG                   GAAA                  TGCT  AGAA 
```

**Set fidelity:** 1.0000 (4 overhangs)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------ | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)      | --      | --    | --    |
| 2   | 3'WT block        | bsmbi_3wt_tile11_sub1    | 822 nt  | TGAA  | GAAA  |
| 3   | 3'WT block        | bsmbi_3wt_tile1_sub3     | 1734 nt | GAAA  | GAAA  |
| 4   | 3'WT+PolIII block | bsmbi_3wt_tile1_sub4     | 1490 nt | GAAA  | CACC  |
| 5   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1 | --      | --    | --    |

```
  [TGAA]----3'WT sub1----[GAAA]----3'WT sub2----[GAAA]----3'WT+PolIII sub3----[CACC]
   TGAA                   GAAA                   GAAA                          CACC 
```

**Set fidelity:** 1.0000 (3 overhangs)

---

### Tile 12 of 30 -- Codons 496-549 (162 nt)

**Boundary overhangs:**

| Position          | Sequence | Fidelity |
| ----------------- | -------- | -------- |
| oh1 (5' boundary) | ATGA     | 0.7549   |
| oh2 (3' boundary) | TTTT     | 0.8623   |

**Variants:** 10500 mutations, 10500 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name              | Length  | 5' OH | 3' OH |
| --- | --------------- | ---------------------- | ------- | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile12_sub1   | 1503 nt | ATGG  | ATGA  |
| 2   | Oligo pool      | Tile 12 (10500 oligos) | 218 nt  | ATGA  | AGAA  |
| 3   | Helper plasmid  | helper_plasmid_insert  | --      | --    | --    |
| 4   | Enzyme + buffer | BsaI-HFv2 + CutSmart   | --      | --    | --    |

```
  [ATGG]----5'WT sub1----[GAAA]----oligo+BC----[ATGA][AGAA]
   ATGG                   GAAA                  ATGA  AGAA 
```

**Set fidelity:** 0.8940 (4 overhangs)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------ | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)      | --      | --    | --    |
| 2   | 3'WT block        | bsmbi_3wt_tile12_sub1    | 672 nt  | TTTT  | GAAA  |
| 3   | 3'WT block        | bsmbi_3wt_tile1_sub3     | 1734 nt | GAAA  | GAAA  |
| 4   | 3'WT+PolIII block | bsmbi_3wt_tile1_sub4     | 1490 nt | GAAA  | CACC  |
| 5   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1 | --      | --    | --    |

```
  [TTTT]----3'WT sub1----[GAAA]----3'WT sub2----[GAAA]----3'WT+PolIII sub3----[CACC]
   TTTT                   GAAA                   GAAA                          CACC 
```

**Set fidelity:** 1.0000 (3 overhangs)

---

### Tile 13 of 30 -- Codons 546-603 (174 nt)

**Boundary overhangs:**

| Position          | Sequence | Fidelity |
| ----------------- | -------- | -------- |
| oh1 (5' boundary) | CCTT     | 0.6891   |
| oh2 (3' boundary) | AAAA     | 0.9502   |

**Variants:** 11340 mutations, 11340 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name              | Length  | 5' OH | 3' OH |
| --- | --------------- | ---------------------- | ------- | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile13_sub1   | 1653 nt | ATGG  | CCTT  |
| 2   | Oligo pool      | Tile 13 (11340 oligos) | 230 nt  | CCTT  | AGAA  |
| 3   | Helper plasmid  | helper_plasmid_insert  | --      | --    | --    |
| 4   | Enzyme + buffer | BsaI-HFv2 + CutSmart   | --      | --    | --    |

```
  [ATGG]----5'WT sub1----[GAAA]----oligo+BC----[CCTT][AGAA]
   ATGG                   GAAA                  CCTT  AGAA 
```

**Set fidelity:** 1.0000 (4 overhangs)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------ | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)      | --      | --    | --    |
| 2   | 3'WT block        | bsmbi_3wt_tile13_sub1    | 510 nt  | AAAA  | GAAA  |
| 3   | 3'WT block        | bsmbi_3wt_tile1_sub3     | 1734 nt | GAAA  | GAAA  |
| 4   | 3'WT+PolIII block | bsmbi_3wt_tile1_sub4     | 1490 nt | GAAA  | CACC  |
| 5   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1 | --      | --    | --    |

```
  [AAAA]----3'WT sub1----[GAAA]----3'WT sub2----[GAAA]----3'WT+PolIII sub3----[CACC]
   AAAA                   GAAA                   GAAA                          CACC 
```

**Set fidelity:** 0.9814 (3 overhangs)

---

### Tile 14 of 30 -- Codons 600-671 (216 nt)

**Boundary overhangs:**

| Position          | Sequence | Fidelity |
| ----------------- | -------- | -------- |
| oh1 (5' boundary) | ACAA     | 0.8919   |
| oh2 (3' boundary) | TCAA     | 0.9425   |

**Variants:** 14280 mutations, 14280 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name              | Length  | 5' OH | 3' OH |
| --- | --------------- | ---------------------- | ------- | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile14_sub1   | 1376 nt | ATGG  | GAAA  |
| 2   | 5'WT gene block | bsai_5wt_tile14_sub2   | 457 nt  | GAAA  | ACAA  |
| 3   | Oligo pool      | Tile 14 (14280 oligos) | 272 nt  | ACAA  | AGAA  |
| 4   | Helper plasmid  | helper_plasmid_insert  | --      | --    | --    |
| 5   | Enzyme + buffer | BsaI-HFv2 + CutSmart   | --      | --    | --    |

```
  [ATGG]----5'WT sub1----[GAAA]----5'WT sub2----[ACAA]----oligo+BC----[AGAA]
   ATGG                   GAAA                   ACAA                  AGAA 
```

**Set fidelity:** 0.9907 (4 overhangs)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------ | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)      | --      | --    | --    |
| 2   | 3'WT block        | bsmbi_3wt_tile14_sub1    | 306 nt  | TCAA  | GAAA  |
| 3   | 3'WT block        | bsmbi_3wt_tile1_sub3     | 1734 nt | GAAA  | GAAA  |
| 4   | 3'WT+PolIII block | bsmbi_3wt_tile1_sub4     | 1490 nt | GAAA  | CACC  |
| 5   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1 | --      | --    | --    |

```
  [TCAA]----3'WT sub1----[GAAA]----3'WT sub2----[GAAA]----3'WT+PolIII sub3----[CACC]
   TCAA                   GAAA                   GAAA                          CACC 
```

**Set fidelity:** 1.0000 (3 overhangs)

---

### Tile 15 of 30 -- Codons 668-708 (123 nt)

**Boundary overhangs:**

| Position          | Sequence | Fidelity |
| ----------------- | -------- | -------- |
| oh1 (5' boundary) | AAAA     | 0.9502   |
| oh2 (3' boundary) | ATTT     | 0.7664   |

**Variants:** 7770 mutations, 7770 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name             | Length  | 5' OH | 3' OH |
| --- | --------------- | --------------------- | ------- | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile14_sub1  | 1376 nt | ATGG  | GAAA  |
| 2   | 5'WT gene block | bsai_5wt_tile15_sub2  | 661 nt  | GAAA  | AAAA  |
| 3   | Oligo pool      | Tile 15 (7770 oligos) | 179 nt  | AAAA  | AGAA  |
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
| 2   | 3'WT block        | bsmbi_3wt_tile15_sub1    | 195 nt  | ATTT  | GAAA  |
| 3   | 3'WT block        | bsmbi_3wt_tile1_sub3     | 1734 nt | GAAA  | GAAA  |
| 4   | 3'WT+PolIII block | bsmbi_3wt_tile1_sub4     | 1490 nt | GAAA  | CACC  |
| 5   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1 | --      | --    | --    |

```
  [ATTT]----3'WT sub1----[GAAA]----3'WT sub2----[GAAA]----3'WT+PolIII sub3----[CACC]
   ATTT                   GAAA                   GAAA                          CACC 
```

**Set fidelity:** 1.0000 (3 overhangs)

---

### Tile 16 of 30 -- Codons 705-771 (201 nt)

**Boundary overhangs:**

| Position          | Sequence | Fidelity |
| ----------------- | -------- | -------- |
| oh1 (5' boundary) | ATGA     | 0.7549   |
| oh2 (3' boundary) | TTGG     | 0.6005   |

**Variants:** 13230 mutations, 13230 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name              | Length  | 5' OH | 3' OH |
| --- | --------------- | ---------------------- | ------- | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile14_sub1   | 1376 nt | ATGG  | GAAA  |
| 2   | 5'WT gene block | bsai_5wt_tile16_sub2   | 772 nt  | GAAA  | ATGA  |
| 3   | Oligo pool      | Tile 16 (13230 oligos) | 257 nt  | ATGA  | AGAA  |
| 4   | Helper plasmid  | helper_plasmid_insert  | --      | --    | --    |
| 5   | Enzyme + buffer | BsaI-HFv2 + CutSmart   | --      | --    | --    |

```
  [ATGG]----5'WT sub1----[GAAA]----5'WT sub2----[ATGA]----oligo+BC----[AGAA]
   ATGG                   GAAA                   ATGA                  AGAA 
```

**Set fidelity:** 0.8940 (4 overhangs)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------ | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)      | --      | --    | --    |
| 2   | 3'WT block        | bsmbi_3wt_tile16_sub1    | 1722 nt | TTGG  | GAAA  |
| 3   | 3'WT+PolIII block | bsmbi_3wt_tile1_sub4     | 1490 nt | GAAA  | CACC  |
| 4   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1 | --      | --    | --    |

```
  [TTGG]----3'WT sub1----[GAAA]----3'WT+PolIII sub2----[CACC]
   TTGG                   GAAA                          CACC 
```

**Set fidelity:** 1.0000 (3 overhangs)

---

### Tile 17 of 30 -- Codons 768-811 (132 nt)

**Boundary overhangs:**

| Position          | Sequence | Fidelity |
| ----------------- | -------- | -------- |
| oh1 (5' boundary) | GGCT     | 0.4697   |
| oh2 (3' boundary) | CCAG     | 0.6122   |

**Variants:** 8400 mutations, 8400 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name             | Length  | 5' OH | 3' OH |
| --- | --------------- | --------------------- | ------- | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile14_sub1  | 1376 nt | ATGG  | GAAA  |
| 2   | 5'WT gene block | bsai_5wt_tile17_sub2  | 961 nt  | GAAA  | GGCT  |
| 3   | Oligo pool      | Tile 17 (8400 oligos) | 188 nt  | GGCT  | AGAA  |
| 4   | Helper plasmid  | helper_plasmid_insert | --      | --    | --    |
| 5   | Enzyme + buffer | BsaI-HFv2 + CutSmart  | --      | --    | --    |

```
  [ATGG]----5'WT sub1----[GAAA]----5'WT sub2----[GAAA]----oligo+BC----[GGCT][AGAA]
   ATGG                   GAAA                   GAAA                  GGCT  AGAA 
```

**Set fidelity:** 1.0000 (4 overhangs)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------ | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)      | --      | --    | --    |
| 2   | 3'WT block        | bsmbi_3wt_tile17_sub1    | 1602 nt | CCAG  | GAAA  |
| 3   | 3'WT+PolIII block | bsmbi_3wt_tile1_sub4     | 1490 nt | GAAA  | CACC  |
| 4   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1 | --      | --    | --    |

```
  [CCAG]----3'WT sub1----[GAAA]----3'WT+PolIII sub2----[CACC]
   CCAG                   GAAA                          CACC 
```

**Set fidelity:** 1.0000 (3 overhangs)

---

### Tile 18 of 30 -- Codons 808-883 (228 nt)

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
| 1   | 5'WT gene block | bsai_5wt_tile14_sub1   | 1376 nt | ATGG  | GAAA  |
| 2   | 5'WT gene block | bsai_5wt_tile18_sub2   | 1081 nt | GAAA  | ATGA  |
| 3   | Oligo pool      | Tile 18 (15120 oligos) | 284 nt  | ATGA  | AGAA  |
| 4   | Helper plasmid  | helper_plasmid_insert  | --      | --    | --    |
| 5   | Enzyme + buffer | BsaI-HFv2 + CutSmart   | --      | --    | --    |

```
  [ATGG]----5'WT sub1----[GAAA]----5'WT sub2----[GAAA]----oligo+BC----[ATGA][AGAA]
   ATGG                   GAAA                   GAAA                  ATGA  AGAA 
```

**Set fidelity:** 0.8940 (4 overhangs)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------ | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)      | --      | --    | --    |
| 2   | 3'WT block        | bsmbi_3wt_tile18_sub1    | 1386 nt | TCCA  | GAAA  |
| 3   | 3'WT+PolIII block | bsmbi_3wt_tile1_sub4     | 1490 nt | GAAA  | CACC  |
| 4   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1 | --      | --    | --    |

```
  [TCCA]----3'WT sub1----[GAAA]----3'WT+PolIII sub2----[CACC]
   TCCA                   GAAA                          CACC 
```

**Set fidelity:** 1.0000 (3 overhangs)

---

### Tile 19 of 30 -- Codons 880-927 (144 nt)

**Boundary overhangs:**

| Position          | Sequence | Fidelity |
| ----------------- | -------- | -------- |
| oh1 (5' boundary) | AAGA     | 0.9209   |
| oh2 (3' boundary) | AAGA     | 0.9209   |

**Variants:** 9240 mutations, 9240 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name             | Length  | 5' OH | 3' OH |
| --- | --------------- | --------------------- | ------- | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile14_sub1  | 1376 nt | ATGG  | GAAA  |
| 2   | 5'WT gene block | bsai_5wt_tile19_sub2  | 957 nt  | GAAA  | GAAA  |
| 3   | 5'WT gene block | bsai_5wt_tile19_sub3  | 358 nt  | GAAA  | AAGA  |
| 4   | Oligo pool      | Tile 19 (9240 oligos) | 200 nt  | AAGA  | AGAA  |
| 5   | Helper plasmid  | helper_plasmid_insert | --      | --    | --    |
| 6   | Enzyme + buffer | BsaI-HFv2 + CutSmart  | --      | --    | --    |

```
  [ATGG]----5'WT sub1----[GAAA]----5'WT sub2----[GAAA]----5'WT sub3----[AAGA]----oligo+BC----[AGAA]
   ATGG                   GAAA                   GAAA                   AAGA                  AGAA 
```

**Set fidelity:** 1.0000 (4 overhangs)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------ | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)      | --      | --    | --    |
| 2   | 3'WT block        | bsmbi_3wt_tile19_sub1    | 1254 nt | AAGA  | GAAA  |
| 3   | 3'WT+PolIII block | bsmbi_3wt_tile1_sub4     | 1490 nt | GAAA  | CACC  |
| 4   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1 | --      | --    | --    |

```
  [AAGA]----3'WT sub1----[GAAA]----3'WT+PolIII sub2----[CACC]
   AAGA                   GAAA                          CACC 
```

**Set fidelity:** 1.0000 (3 overhangs)

---

### Tile 20 of 30 -- Codons 924-956 (99 nt)

**Boundary overhangs:**

| Position          | Sequence | Fidelity |
| ----------------- | -------- | -------- |
| oh1 (5' boundary) | TTCA     | 0.8824   |
| oh2 (3' boundary) | TTTT     | 0.8623   |

**Variants:** 6090 mutations, 6090 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name             | Length  | 5' OH | 3' OH |
| --- | --------------- | --------------------- | ------- | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile14_sub1  | 1376 nt | ATGG  | GAAA  |
| 2   | 5'WT gene block | bsai_5wt_tile19_sub2  | 957 nt  | GAAA  | GAAA  |
| 3   | 5'WT gene block | bsai_5wt_tile20_sub3  | 490 nt  | GAAA  | TTCA  |
| 4   | Oligo pool      | Tile 20 (6090 oligos) | 155 nt  | TTCA  | AGAA  |
| 5   | Helper plasmid  | helper_plasmid_insert | --      | --    | --    |
| 6   | Enzyme + buffer | BsaI-HFv2 + CutSmart  | --      | --    | --    |

```
  [ATGG]----5'WT sub1----[GAAA]----5'WT sub2----[GAAA]----5'WT sub3----[TTCA]----oligo+BC----[AGAA]
   ATGG                   GAAA                   GAAA                   TTCA                  AGAA 
```

**Set fidelity:** 1.0000 (4 overhangs)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------ | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)      | --      | --    | --    |
| 2   | 3'WT block        | bsmbi_3wt_tile20_sub1    | 1167 nt | TTTT  | GAAA  |
| 3   | 3'WT+PolIII block | bsmbi_3wt_tile1_sub4     | 1490 nt | GAAA  | CACC  |
| 4   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1 | --      | --    | --    |

```
  [TTTT]----3'WT sub1----[GAAA]----3'WT+PolIII sub2----[CACC]
   TTTT                   GAAA                          CACC 
```

**Set fidelity:** 1.0000 (3 overhangs)

---

### Tile 21 of 30 -- Codons 953-983 (93 nt)

**Boundary overhangs:**

| Position          | Sequence | Fidelity |
| ----------------- | -------- | -------- |
| oh1 (5' boundary) | GAGA     | 0.7444   |
| oh2 (3' boundary) | ACAA     | 0.8919   |

**Variants:** 5670 mutations, 5670 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name             | Length  | 5' OH | 3' OH |
| --- | --------------- | --------------------- | ------- | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile14_sub1  | 1376 nt | ATGG  | GAAA  |
| 2   | 5'WT gene block | bsai_5wt_tile19_sub2  | 957 nt  | GAAA  | GAAA  |
| 3   | 5'WT gene block | bsai_5wt_tile21_sub3  | 577 nt  | GAAA  | GAGA  |
| 4   | Oligo pool      | Tile 21 (5670 oligos) | 149 nt  | GAGA  | AGAA  |
| 5   | Helper plasmid  | helper_plasmid_insert | --      | --    | --    |
| 6   | Enzyme + buffer | BsaI-HFv2 + CutSmart  | --      | --    | --    |

```
  [ATGG]----5'WT sub1----[GAAA]----5'WT sub2----[GAAA]----5'WT sub3----[GAGA]----oligo+BC----[AGAA]
   ATGG                   GAAA                   GAAA                   GAGA                  AGAA 
```

**Set fidelity:** 0.9778 (4 overhangs)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------ | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)      | --      | --    | --    |
| 2   | 3'WT block        | bsmbi_3wt_tile21_sub1    | 1086 nt | ACAA  | GAAA  |
| 3   | 3'WT+PolIII block | bsmbi_3wt_tile1_sub4     | 1490 nt | GAAA  | CACC  |
| 4   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1 | --      | --    | --    |

```
  [ACAA]----3'WT sub1----[GAAA]----3'WT+PolIII sub2----[CACC]
   ACAA                   GAAA                          CACC 
```

**Set fidelity:** 1.0000 (3 overhangs)

---

### Tile 22 of 30 -- Codons 980-1020 (123 nt)

**Boundary overhangs:**

| Position          | Sequence | Fidelity |
| ----------------- | -------- | -------- |
| oh1 (5' boundary) | TTCC     | 0.7958   |
| oh2 (3' boundary) | TTCC     | 0.7958   |

**Variants:** 7770 mutations, 7770 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name             | Length  | 5' OH | 3' OH |
| --- | --------------- | --------------------- | ------- | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile14_sub1  | 1376 nt | ATGG  | GAAA  |
| 2   | 5'WT gene block | bsai_5wt_tile19_sub2  | 957 nt  | GAAA  | GAAA  |
| 3   | 5'WT gene block | bsai_5wt_tile22_sub3  | 658 nt  | GAAA  | TTCC  |
| 4   | Oligo pool      | Tile 22 (7770 oligos) | 179 nt  | TTCC  | AGAA  |
| 5   | Helper plasmid  | helper_plasmid_insert | --      | --    | --    |
| 6   | Enzyme + buffer | BsaI-HFv2 + CutSmart  | --      | --    | --    |

```
  [ATGG]----5'WT sub1----[GAAA]----5'WT sub2----[GAAA]----5'WT sub3----[TTCC]----oligo+BC----[AGAA]
   ATGG                   GAAA                   GAAA                   TTCC                  AGAA 
```

**Set fidelity:** 1.0000 (4 overhangs)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------ | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)      | --      | --    | --    |
| 2   | 3'WT block        | bsmbi_3wt_tile22_sub1    | 975 nt  | TTCC  | GAAA  |
| 3   | 3'WT+PolIII block | bsmbi_3wt_tile1_sub4     | 1490 nt | GAAA  | CACC  |
| 4   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1 | --      | --    | --    |

```
  [TTCC]----3'WT sub1----[GAAA]----3'WT+PolIII sub2----[CACC]
   TTCC                   GAAA                          CACC 
```

**Set fidelity:** 0.9988 (3 overhangs)

---

### Tile 23 of 30 -- Codons 1017-1081 (195 nt)

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
| 1   | 5'WT gene block | bsai_5wt_tile14_sub1   | 1376 nt | ATGG  | GAAA  |
| 2   | 5'WT gene block | bsai_5wt_tile19_sub2   | 957 nt  | GAAA  | GAAA  |
| 3   | 5'WT gene block | bsai_5wt_tile23_sub3   | 769 nt  | GAAA  | TCCG  |
| 4   | Oligo pool      | Tile 23 (12810 oligos) | 251 nt  | TCCG  | AGAA  |
| 5   | Helper plasmid  | helper_plasmid_insert  | --      | --    | --    |
| 6   | Enzyme + buffer | BsaI-HFv2 + CutSmart   | --      | --    | --    |

```
  [ATGG]----5'WT sub1----[GAAA]----5'WT sub2----[GAAA]----5'WT sub3----[TCCG]----oligo+BC----[AGAA]
   ATGG                   GAAA                   GAAA                   TCCG                  AGAA 
```

**Set fidelity:** 1.0000 (4 overhangs)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------ | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)      | --      | --    | --    |
| 2   | 3'WT block        | bsmbi_3wt_tile23_sub1    | 792 nt  | CAAA  | GAAA  |
| 3   | 3'WT+PolIII block | bsmbi_3wt_tile1_sub4     | 1490 nt | GAAA  | CACC  |
| 4   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1 | --      | --    | --    |

```
  [CAAA]----3'WT sub1----[GAAA]----3'WT+PolIII sub2----[CACC]
   CAAA                   GAAA                          CACC 
```

**Set fidelity:** 0.9988 (3 overhangs)

---

### Tile 24 of 30 -- Codons 1078-1110 (99 nt)

**Boundary overhangs:**

| Position          | Sequence | Fidelity |
| ----------------- | -------- | -------- |
| oh1 (5' boundary) | AAGA     | 0.9209   |
| oh2 (3' boundary) | ATCA     | 0.7483   |

**Variants:** 6090 mutations, 6090 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name             | Length  | 5' OH | 3' OH |
| --- | --------------- | --------------------- | ------- | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile14_sub1  | 1376 nt | ATGG  | GAAA  |
| 2   | 5'WT gene block | bsai_5wt_tile19_sub2  | 957 nt  | GAAA  | GAAA  |
| 3   | 5'WT gene block | bsai_5wt_tile24_sub3  | 952 nt  | GAAA  | AAGA  |
| 4   | Oligo pool      | Tile 24 (6090 oligos) | 155 nt  | AAGA  | AGAA  |
| 5   | Helper plasmid  | helper_plasmid_insert | --      | --    | --    |
| 6   | Enzyme + buffer | BsaI-HFv2 + CutSmart  | --      | --    | --    |

```
  [ATGG]----5'WT sub1----[GAAA]----5'WT sub2----[GAAA]----5'WT sub3----[AAGA]----oligo+BC----[AGAA]
   ATGG                   GAAA                   GAAA                   AAGA                  AGAA 
```

**Set fidelity:** 1.0000 (4 overhangs)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------ | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)      | --      | --    | --    |
| 2   | 3'WT block        | bsmbi_3wt_tile24_sub1    | 705 nt  | ATCA  | GAAA  |
| 3   | 3'WT+PolIII block | bsmbi_3wt_tile1_sub4     | 1490 nt | GAAA  | CACC  |
| 4   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1 | --      | --    | --    |

```
  [ATCA]----3'WT sub1----[GAAA]----3'WT+PolIII sub2----[CACC]
   ATCA                   GAAA                          CACC 
```

**Set fidelity:** 1.0000 (3 overhangs)

---

### Tile 25 of 30 -- Codons 1107-1175 (207 nt)

**Boundary overhangs:**

| Position          | Sequence | Fidelity |
| ----------------- | -------- | -------- |
| oh1 (5' boundary) | AAAA     | 0.9502   |
| oh2 (3' boundary) | TGAA     | 0.8621   |

**Variants:** 13650 mutations, 13650 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name              | Length  | 5' OH | 3' OH |
| --- | --------------- | ---------------------- | ------- | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile14_sub1   | 1376 nt | ATGG  | GAAA  |
| 2   | 5'WT gene block | bsai_5wt_tile19_sub2   | 957 nt  | GAAA  | GAAA  |
| 3   | 5'WT gene block | bsai_5wt_tile25_sub3   | 1039 nt | GAAA  | AAAA  |
| 4   | Oligo pool      | Tile 25 (13650 oligos) | 263 nt  | AAAA  | AGAA  |
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
| 2   | 3'WT block        | bsmbi_3wt_tile25_sub1    | 510 nt  | TGAA  | GAAA  |
| 3   | 3'WT+PolIII block | bsmbi_3wt_tile1_sub4     | 1490 nt | GAAA  | CACC  |
| 4   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1 | --      | --    | --    |

```
  [TGAA]----3'WT sub1----[GAAA]----3'WT+PolIII sub2----[CACC]
   TGAA                   GAAA                          CACC 
```

**Set fidelity:** 1.0000 (3 overhangs)

---

### Tile 26 of 30 -- Codons 1172-1237 (198 nt)

**Boundary overhangs:**

| Position          | Sequence | Fidelity |
| ----------------- | -------- | -------- |
| oh1 (5' boundary) | TTGC     | 0.7336   |
| oh2 (3' boundary) | CGAT     | 0.6118   |

**Variants:** 13020 mutations, 13020 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name              | Length  | 5' OH | 3' OH |
| --- | --------------- | ---------------------- | ------- | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile14_sub1   | 1376 nt | ATGG  | GAAA  |
| 2   | 5'WT gene block | bsai_5wt_tile19_sub2   | 957 nt  | GAAA  | GAAA  |
| 3   | 5'WT gene block | bsai_5wt_tile26_sub3   | 1234 nt | GAAA  | TTGC  |
| 4   | Oligo pool      | Tile 26 (13020 oligos) | 254 nt  | TTGC  | AGAA  |
| 5   | Helper plasmid  | helper_plasmid_insert  | --      | --    | --    |
| 6   | Enzyme + buffer | BsaI-HFv2 + CutSmart   | --      | --    | --    |

```
  [ATGG]----5'WT sub1----[GAAA]----5'WT sub2----[GAAA]----5'WT sub3----[TTGC]----oligo+BC----[AGAA]
   ATGG                   GAAA                   GAAA                   TTGC                  AGAA 
```

**Set fidelity:** 1.0000 (4 overhangs)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------ | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)      | --      | --    | --    |
| 2   | 3'WT block        | bsmbi_3wt_tile26_sub1    | 324 nt  | CGAT  | GAAA  |
| 3   | 3'WT+PolIII block | bsmbi_3wt_tile1_sub4     | 1490 nt | GAAA  | CACC  |
| 4   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1 | --      | --    | --    |

```
  [CGAT]----3'WT sub1----[GAAA]----3'WT+PolIII sub2----[CACC]
   CGAT                   GAAA                          CACC 
```

**Set fidelity:** 1.0000 (3 overhangs)

---

### Tile 27 of 30 -- Codons 1234-1278 (135 nt)

**Boundary overhangs:**

| Position          | Sequence | Fidelity |
| ----------------- | -------- | -------- |
| oh1 (5' boundary) | TTCA     | 0.8824   |
| oh2 (3' boundary) | TCAA     | 0.9425   |

**Variants:** 8610 mutations, 8610 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name             | Length  | 5' OH | 3' OH |
| --- | --------------- | --------------------- | ------- | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile14_sub1  | 1376 nt | ATGG  | GAAA  |
| 2   | 5'WT gene block | bsai_5wt_tile19_sub2  | 957 nt  | GAAA  | GAAA  |
| 3   | 5'WT gene block | bsai_5wt_tile27_sub3  | 1420 nt | GAAA  | TTCA  |
| 4   | Oligo pool      | Tile 27 (8610 oligos) | 191 nt  | TTCA  | AGAA  |
| 5   | Helper plasmid  | helper_plasmid_insert | --      | --    | --    |
| 6   | Enzyme + buffer | BsaI-HFv2 + CutSmart  | --      | --    | --    |

```
  [ATGG]----5'WT sub1----[GAAA]----5'WT sub2----[GAAA]----5'WT sub3----[TTCA]----oligo+BC----[AGAA]
   ATGG                   GAAA                   GAAA                   TTCA                  AGAA 
```

**Set fidelity:** 1.0000 (4 overhangs)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------ | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)      | --      | --    | --    |
| 2   | 3'WT+PolIII block | bsmbi_3wt_tile27_sub1    | 1673 nt | TCAA  | CACC  |
| 3   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1 | --      | --    | --    |

```
  [TCAA]----3'WT+PolIII sub1----[GAAA][CACC]
   TCAA                          GAAA  CACC 
```

**Set fidelity:** 1.0000 (3 overhangs)

---

### Tile 28 of 30 -- Codons 1275-1343 (207 nt)

**Boundary overhangs:**

| Position          | Sequence | Fidelity |
| ----------------- | -------- | -------- |
| oh1 (5' boundary) | AATG     | 0.6412   |
| oh2 (3' boundary) | CCTT     | 0.6891   |

**Variants:** 13650 mutations, 13650 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name              | Length  | 5' OH | 3' OH |
| --- | --------------- | ---------------------- | ------- | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile14_sub1   | 1376 nt | ATGG  | GAAA  |
| 2   | 5'WT gene block | bsai_5wt_tile19_sub2   | 957 nt  | GAAA  | GAAA  |
| 3   | 5'WT gene block | bsai_5wt_tile28_sub3   | 1543 nt | GAAA  | AATG  |
| 4   | Oligo pool      | Tile 28 (13650 oligos) | 263 nt  | AATG  | AGAA  |
| 5   | Helper plasmid  | helper_plasmid_insert  | --      | --    | --    |
| 6   | Enzyme + buffer | BsaI-HFv2 + CutSmart   | --      | --    | --    |

```
  [ATGG]----5'WT sub1----[GAAA]----5'WT sub2----[GAAA]----5'WT sub3----[AATG]----oligo+BC----[AGAA]
   ATGG                   GAAA                   GAAA                   AATG                  AGAA 
```

**Set fidelity:** 1.0000 (4 overhangs)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------ | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)      | --      | --    | --    |
| 2   | 3'WT+PolIII block | bsmbi_3wt_tile28         | 1478 nt | CCTT  | CACC  |
| 3   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1 | --      | --    | --    |

```
  [CCTT]----3'WT+PolIII----[CACC]
   CCTT                     CACC 
```

**Set fidelity:** 1.0000 (2 overhangs)

---

### Tile 29 of 30 -- Codons 1340-1413 (222 nt)

**Boundary overhangs:**

| Position          | Sequence | Fidelity |
| ----------------- | -------- | -------- |
| oh1 (5' boundary) | AAAA     | 0.9502   |
| oh2 (3' boundary) | TTCC     | 0.7958   |

**Variants:** 14700 mutations, 14700 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name              | Length  | 5' OH | 3' OH |
| --- | --------------- | ---------------------- | ------- | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile14_sub1   | 1376 nt | ATGG  | GAAA  |
| 2   | 5'WT gene block | bsai_5wt_tile19_sub2   | 957 nt  | GAAA  | GAAA  |
| 3   | 5'WT gene block | bsai_5wt_tile29_sub3   | 1738 nt | GAAA  | AAAA  |
| 4   | Oligo pool      | Tile 29 (14700 oligos) | 278 nt  | AAAA  | AGAA  |
| 5   | Helper plasmid  | helper_plasmid_insert  | --      | --    | --    |
| 6   | Enzyme + buffer | BsaI-HFv2 + CutSmart   | --      | --    | --    |

```
  [ATGG]----5'WT sub1----[GAAA]----5'WT sub2----[GAAA]----5'WT sub3----[GAAA]----oligo+BC----[AAAA][AGAA]
   ATGG                   GAAA                   GAAA                   GAAA                  AAAA  AGAA 
```

**Set fidelity:** 0.9605 (4 overhangs)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------ | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)      | --      | --    | --    |
| 2   | 3'WT+PolIII block | bsmbi_3wt_tile29         | 1268 nt | TTCC  | CACC  |
| 3   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1 | --      | --    | --    |

```
  [TTCC]----3'WT+PolIII----[CACC]
   TTCC                     CACC 
```

**Set fidelity:** 0.9988 (2 overhangs)

---

### Tile 30 of 30 -- Codons 1410-1465 (168 nt)

**Boundary overhangs:**

| Position          | Sequence | Fidelity |
| ----------------- | -------- | -------- |
| oh1 (5' boundary) | TCGT     | 0.7335   |
| oh2 (3' boundary) | TTAA     | 0.9448   |

**Variants:** 10920 mutations, 10920 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name              | Length  | 5' OH | 3' OH |
| --- | --------------- | ---------------------- | ------- | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile14_sub1   | 1376 nt | ATGG  | GAAA  |
| 2   | 5'WT gene block | bsai_5wt_tile19_sub2   | 957 nt  | GAAA  | GAAA  |
| 3   | 5'WT gene block | bsai_5wt_tile30_sub3   | 1734 nt | GAAA  | GAAA  |
| 4   | 5'WT gene block | bsai_5wt_tile30_sub4   | 232 nt  | GAAA  | TCGT  |
| 5   | Oligo pool      | Tile 30 (10920 oligos) | 224 nt  | TCGT  | AGAA  |
| 6   | Helper plasmid  | helper_plasmid_insert  | --      | --    | --    |
| 7   | Enzyme + buffer | BsaI-HFv2 + CutSmart   | --      | --    | --    |

```
  [ATGG]----5'WT sub1----[GAAA]----5'WT sub2----[GAAA]----5'WT sub3----[GAAA]----5'WT sub4----[TCGT]----oligo+BC----[AGAA]
   ATGG                   GAAA                   GAAA                   GAAA                   TCGT                  AGAA 
```

**Set fidelity:** 1.0000 (4 overhangs)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component            | Part name                | Length  | 5' OH | 3' OH |
| --- | -------------------- | ------------------------ | ------- | ----- | ----- |
| 1   | BsaI product         | (in helper plasmid)      | --      | --    | --    |
| 2   | PolIII-only fragment | bsmbi_polIII_tile30      | 1112 nt | TTAA  | CACC  |
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

**Total blocks:** 65

| Block name            | Length (nt) | Enzyme type | Gene region                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                  |
| --------------------- | ----------- | ----------- | ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------ |
| bsai_5wt_tile10       | 1266        | BsaI        | 5wt_tile10                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                   |
| bsai_5wt_tile11_sub1  | 1380        | BsaI        | 5wt_tile11_sub1                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                              |
| bsai_5wt_tile12_sub1  | 1503        | BsaI        | 5wt_tile12_sub1                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                              |
| bsai_5wt_tile13_sub1  | 1653        | BsaI        | 5wt_tile13_sub1                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                              |
| bsai_5wt_tile14_sub1  | 1376        | BsaI        | 5wt_tile14_sub1;5wt_tile15_sub1;5wt_tile16_sub1;5wt_tile17_sub1;5wt_tile18_sub1;5wt_tile19_sub1;5wt_tile20_sub1;5wt_tile21_sub1;5wt_tile22_sub1;5wt_tile23_sub1;5wt_tile24_sub1;5wt_tile25_sub1;5wt_tile26_sub1;5wt_tile27_sub1;5wt_tile28_sub1;5wt_tile29_sub1;5wt_tile30_sub1                                                                                                                                                                                                                                                                                                                              |
| bsai_5wt_tile14_sub2  | 457         | BsaI        | 5wt_tile14_sub2                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                              |
| bsai_5wt_tile15_sub2  | 661         | BsaI        | 5wt_tile15_sub2                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                              |
| bsai_5wt_tile16_sub2  | 772         | BsaI        | 5wt_tile16_sub2                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                              |
| bsai_5wt_tile17_sub2  | 961         | BsaI        | 5wt_tile17_sub2                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                              |
| bsai_5wt_tile18_sub2  | 1081        | BsaI        | 5wt_tile18_sub2                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                              |
| bsai_5wt_tile19_sub2  | 957         | BsaI        | 5wt_tile19_sub2;5wt_tile20_sub2;5wt_tile21_sub2;5wt_tile22_sub2;5wt_tile23_sub2;5wt_tile24_sub2;5wt_tile25_sub2;5wt_tile26_sub2;5wt_tile27_sub2;5wt_tile28_sub2;5wt_tile29_sub2;5wt_tile30_sub2                                                                                                                                                                                                                                                                                                                                                                                                              |
| bsai_5wt_tile19_sub3  | 358         | BsaI        | 5wt_tile19_sub3                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                              |
| bsai_5wt_tile2        | 159         | BsaI        | 5wt_tile2                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                    |
| bsai_5wt_tile20_sub3  | 490         | BsaI        | 5wt_tile20_sub3                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                              |
| bsai_5wt_tile21_sub3  | 577         | BsaI        | 5wt_tile21_sub3                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                              |
| bsai_5wt_tile22_sub3  | 658         | BsaI        | 5wt_tile22_sub3                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                              |
| bsai_5wt_tile23_sub3  | 769         | BsaI        | 5wt_tile23_sub3                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                              |
| bsai_5wt_tile24_sub3  | 952         | BsaI        | 5wt_tile24_sub3                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                              |
| bsai_5wt_tile25_sub3  | 1039        | BsaI        | 5wt_tile25_sub3                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                              |
| bsai_5wt_tile26_sub3  | 1234        | BsaI        | 5wt_tile26_sub3                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                              |
| bsai_5wt_tile27_sub3  | 1420        | BsaI        | 5wt_tile27_sub3                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                              |
| bsai_5wt_tile28_sub3  | 1543        | BsaI        | 5wt_tile28_sub3                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                              |
| bsai_5wt_tile29_sub3  | 1738        | BsaI        | 5wt_tile29_sub3                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                              |
| bsai_5wt_tile3        | 351         | BsaI        | 5wt_tile3                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                    |
| bsai_5wt_tile30_sub3  | 1734        | BsaI        | 5wt_tile30_sub3                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                              |
| bsai_5wt_tile30_sub4  | 232         | BsaI        | 5wt_tile30_sub4                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                              |
| bsai_5wt_tile4        | 450         | BsaI        | 5wt_tile4                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                    |
| bsai_5wt_tile5        | 555         | BsaI        | 5wt_tile5                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                    |
| bsai_5wt_tile6        | 657         | BsaI        | 5wt_tile6                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                    |
| bsai_5wt_tile7        | 816         | BsaI        | 5wt_tile7                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                    |
| bsai_5wt_tile8        | 1017        | BsaI        | 5wt_tile8                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                    |
| bsai_5wt_tile9        | 1119        | BsaI        | 5wt_tile9                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                    |
| bsmbi_3wt_tile1_sub1  | 1227        | BsmBI       | 3wt_tile1_sub1                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                               |
| bsmbi_3wt_tile1_sub2  | 957         | BsmBI       | 3wt_tile1_sub2;3wt_tile2_sub2;3wt_tile3_sub2;3wt_tile4_sub2;3wt_tile5_sub2;3wt_tile6_sub2;3wt_tile7_sub2                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                     |
| bsmbi_3wt_tile1_sub3  | 1734        | BsmBI       | 3wt_tile1_sub3;3wt_tile2_sub3;3wt_tile3_sub3;3wt_tile4_sub3;3wt_tile5_sub3;3wt_tile6_sub3;3wt_tile7_sub3;3wt_tile8_sub2;3wt_tile9_sub2;3wt_tile10_sub2;3wt_tile11_sub2;3wt_tile12_sub2;3wt_tile13_sub2;3wt_tile14_sub2;3wt_tile15_sub2                                                                                                                                                                                                                                                                                                                                                                       |
| bsmbi_3wt_tile1_sub4  | 1490        | BsmBI       | 3wt_polIII_tile1_sub4;3wt_polIII_tile2_sub4;3wt_polIII_tile3_sub4;3wt_polIII_tile4_sub4;3wt_polIII_tile5_sub4;3wt_polIII_tile6_sub4;3wt_polIII_tile7_sub4;3wt_polIII_tile8_sub3;3wt_polIII_tile9_sub3;3wt_polIII_tile10_sub3;3wt_polIII_tile11_sub3;3wt_polIII_tile12_sub3;3wt_polIII_tile13_sub3;3wt_polIII_tile14_sub3;3wt_polIII_tile15_sub3;3wt_polIII_tile16_sub2;3wt_polIII_tile17_sub2;3wt_polIII_tile18_sub2;3wt_polIII_tile19_sub2;3wt_polIII_tile20_sub2;3wt_polIII_tile21_sub2;3wt_polIII_tile22_sub2;3wt_polIII_tile23_sub2;3wt_polIII_tile24_sub2;3wt_polIII_tile25_sub2;3wt_polIII_tile26_sub2 |
| bsmbi_3wt_tile10_sub1 | 945         | BsmBI       | 3wt_tile10_sub1                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                              |
| bsmbi_3wt_tile11_sub1 | 822         | BsmBI       | 3wt_tile11_sub1                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                              |
| bsmbi_3wt_tile12_sub1 | 672         | BsmBI       | 3wt_tile12_sub1                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                              |
| bsmbi_3wt_tile13_sub1 | 510         | BsmBI       | 3wt_tile13_sub1                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                              |
| bsmbi_3wt_tile14_sub1 | 306         | BsmBI       | 3wt_tile14_sub1                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                              |
| bsmbi_3wt_tile15_sub1 | 195         | BsmBI       | 3wt_tile15_sub1                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                              |
| bsmbi_3wt_tile16_sub1 | 1722        | BsmBI       | 3wt_tile16_sub1                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                              |
| bsmbi_3wt_tile17_sub1 | 1602        | BsmBI       | 3wt_tile17_sub1                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                              |
| bsmbi_3wt_tile18_sub1 | 1386        | BsmBI       | 3wt_tile18_sub1                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                              |
| bsmbi_3wt_tile19_sub1 | 1254        | BsmBI       | 3wt_tile19_sub1                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                              |
| bsmbi_3wt_tile2_sub1  | 1035        | BsmBI       | 3wt_tile2_sub1                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                               |
| bsmbi_3wt_tile20_sub1 | 1167        | BsmBI       | 3wt_tile20_sub1                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                              |
| bsmbi_3wt_tile21_sub1 | 1086        | BsmBI       | 3wt_tile21_sub1                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                              |
| bsmbi_3wt_tile22_sub1 | 975         | BsmBI       | 3wt_tile22_sub1                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                              |
| bsmbi_3wt_tile23_sub1 | 792         | BsmBI       | 3wt_tile23_sub1                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                              |
| bsmbi_3wt_tile24_sub1 | 705         | BsmBI       | 3wt_tile24_sub1                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                              |
| bsmbi_3wt_tile25_sub1 | 510         | BsmBI       | 3wt_tile25_sub1                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                              |
| bsmbi_3wt_tile26_sub1 | 324         | BsmBI       | 3wt_tile26_sub1                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                              |
| bsmbi_3wt_tile27_sub1 | 1673        | BsmBI       | 3wt_polIII_tile27_sub1                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                       |
| bsmbi_3wt_tile28      | 1478        | BsmBI       | 3wt_polIII_tile28                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                            |
| bsmbi_3wt_tile29      | 1268        | BsmBI       | 3wt_polIII_tile29                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                            |
| bsmbi_3wt_tile3_sub1  | 936         | BsmBI       | 3wt_tile3_sub1                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                               |
| bsmbi_3wt_tile4_sub1  | 831         | BsmBI       | 3wt_tile4_sub1                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                               |
| bsmbi_3wt_tile5_sub1  | 729         | BsmBI       | 3wt_tile5_sub1                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                               |
| bsmbi_3wt_tile6_sub1  | 570         | BsmBI       | 3wt_tile6_sub1                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                               |
| bsmbi_3wt_tile7_sub1  | 369         | BsmBI       | 3wt_tile7_sub1                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                               |
| bsmbi_3wt_tile8_sub1  | 1206        | BsmBI       | 3wt_tile8_sub1                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                               |
| bsmbi_3wt_tile9_sub1  | 1059        | BsmBI       | 3wt_tile9_sub1                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                               |
| bsmbi_polIII_tile30   | 1112        | BsmBI       | polIII_tile30                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                |

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

