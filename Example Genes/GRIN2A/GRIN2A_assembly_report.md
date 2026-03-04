# DMS-GG Assembly Report: GRIN2A

Generated: 2026-03-03 20:21:12
Pipeline: dms-gg-oligo-pipeline (3-Enzyme Architecture: BsaI + BsmBI + PaqCI)

---

## 1. Gene Summary

| Property             | Value                                                                          |
| -------------------- | ------------------------------------------------------------------------------ |
| Gene name            | GRIN2A_NM_000833.5 Human GRIN2A native CDS (NM_000833.5, NP_000824.1, 1464 aa) |
| CDS length           | 4395 nt (1465 codons)                                                          |
| Protein length       | 1464 aa                                                                        |
| Number of tiles      | 25                                                                             |
| Total variants       | 29220                                                                          |
| Total oligos         | 292200                                                                         |
| Oligo length range   | 170-290 nt                                                                     |
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

**Total oligos:** 292200 | **Length range:** 170-290 nt

| Tile | Codons    | Oligos | Length |
| ---- | --------- | ------ | ------ |
| 1    | 1-51      | 9400   | 209 nt |
| 2    | 48-115    | 12800  | 260 nt |
| 3    | 112-183   | 13600  | 272 nt |
| 4    | 180-257   | 14800  | 290 nt |
| 5    | 254-313   | 11200  | 236 nt |
| 6    | 310-353   | 8000   | 188 nt |
| 7    | 350-399   | 9200   | 206 nt |
| 8    | 396-468   | 13800  | 275 nt |
| 9    | 465-541   | 14600  | 287 nt |
| 10   | 538-603   | 12400  | 254 nt |
| 11   | 600-672   | 13800  | 275 nt |
| 12   | 669-724   | 10400  | 224 nt |
| 13   | 721-770   | 9200   | 206 nt |
| 14   | 767-844   | 14800  | 290 nt |
| 15   | 841-905   | 12200  | 251 nt |
| 16   | 902-952   | 9400   | 209 nt |
| 17   | 949-1020  | 13600  | 272 nt |
| 18   | 1017-1054 | 6800   | 170 nt |
| 19   | 1051-1110 | 11200  | 236 nt |
| 20   | 1107-1175 | 13000  | 263 nt |
| 21   | 1172-1218 | 8600   | 197 nt |
| 22   | 1215-1284 | 13200  | 266 nt |
| 23   | 1281-1343 | 11800  | 245 nt |
| 24   | 1340-1413 | 14000  | 278 nt |
| 25   | 1410-1465 | 10400  | 224 nt |

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
| Total barcodes    | 292200                             |
| Unique barcodes   | 292200                             |
| GC content range  | 25% - 75%                          |
| GC content mean   | 47.9%                              |
| Hamming guarantee | 100% cross-variant (prefix d >= 3) |

## 5. QC Summary

**Overall:** ISSUES FOUND

| Check                  | Description                                              | Result | Detail                                                                          |
| ---------------------- | -------------------------------------------------------- | ------ | ------------------------------------------------------------------------------- |
| oligo_lengths          | All oligos within synthesis length limit                 | PASS   | Range: 170-290 nt (limit: 300)                                                  |
| block_lengths          | All gene blocks within synthesis length limit            | PASS   | Range: 159-1725 nt (limit: 1800)                                                |
| barcode_junction_sites | No enzyme sites at barcode-context junctions             | PASS   | 0 barcode(s) with junction enzyme sites (left='CACACC', right='TTCCTG')         |
| barcode_uniqueness     | All barcodes are unique                                  | PASS   | 292200 unique / 292200 total                                                    |
| tile_coverage          | Tiles cover entire gene without gaps                     | PASS   | 4395 / 4395 nt covered                                                          |
| variant_count          | Expected number of variants generated                    | FAIL   | 29220 unique variants (expected: 29260 = 1463 mutable positions x 20 mutations) |
| single_codon_change    | Each variant differs by exactly one codon from WT        | PASS   | 292200 / 292200 variants confirmed                                              |
| oligo_gc_content       | Oligo GC content within reasonable range (25-75%)        | PASS   | GC range: 42-67% | 0 oligo(s) with extreme GC                                   |
| domestication_complete | Gene domesticated for all 3 enzymes (BsaI, BsmBI, PaqCI) | PASS   | No enzyme sites in gene                                                         |
| overhang_fidelity      | Tile boundary overhangs have adequate fidelity           | FAIL   | 20 tile(s) with low-fidelity boundary overhangs (<0.80)                         |
| tile_manifests         | Per-tile assembly manifests complete                     | PASS   | 25 tile manifest(s) generated                                                   |
| helper_plasmid         | Helper plasmid free of unintended BsmBI sites            | PASS   | OK                                                                              |
| reaction_fidelity      | Per-reaction set-level overhang fidelity                 | PASS   | Min set fidelity: 0.9439 across 50 reactions | 0 reaction(s) below 0.90         |
| barcode_poliii_term    | No barcodes contain PolIII terminator signal (TTTT)      | PASS   | 0 / 292200 barcode(s) contain TTTT                                              |
| block_min_length       | All gene blocks above synthesis minimum length           | FAIL   | 5 block(s) below 300 nt minimum. Range: 159-1725 nt                             |

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

### Tile 1 of 25 -- Codons 1-51 (153 nt)

**Boundary overhangs:**

| Position          | Sequence | In HF Set | Fidelity |
| ----------------- | -------- | --------- | -------- |
| oh1 (5' boundary) | ATGG     | No        | 0.5393   |
| oh2 (3' boundary) | ACTT     | No        | 0.7315   |

**Variants:** 9400 mutations, 9400 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name                          | Length | 5' OH | 3' OH |
| --- | --------------- | ---------------------------------- | ------ | ----- | ----- |
| 1   | 5'WT gene block | (none -- tile starts at gene nt 1) | --     | --    | --    |
| 2   | Oligo pool      | Tile 1 (9400 oligos)               | 209 nt | ATGG  | TTCC  |
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
| 2   | 3'WT block        | bsmbi_3wt_tile1_sub1     | 1488 nt | ACTT  | TAAT  |
| 3   | 3'WT block        | bsmbi_3wt_tile1_sub2     | 1725 nt | TAAT  | ATCA  |
| 4   | 3'WT block        | bsmbi_3wt_tile1_sub3     | 540 nt  | ATCA  | GCTA  |
| 5   | 3'WT+PolIII block | bsmbi_3wt_tile1_sub4     | 1655 nt | GCTA  | CACC  |
| 6   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1 | --      | --    | --    |

```
  [ACTT]----3'WT sub1----[TAAT]----3'WT sub2----[ATCA]----3'WT sub3----[GCTA]----3'WT+PolIII sub4----[CACC]
   ACTT                   TAAT                   ATCA                   GCTA                          CACC 
   (--)                   (--)                   (--)                   (--)                          (--) 
```

**Set fidelity:** 0.9623 (5 overhangs, 0 in HF set)

---

### Tile 2 of 25 -- Codons 48-115 (204 nt)

**Boundary overhangs:**

| Position          | Sequence | In HF Set | Fidelity |
| ----------------- | -------- | --------- | -------- |
| oh1 (5' boundary) | GAGC     | No        | 0.5446   |
| oh2 (3' boundary) | TTTT     | No        | 0.8623   |

**Variants:** 12800 mutations, 12800 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name             | Length | 5' OH | 3' OH |
| --- | --------------- | --------------------- | ------ | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile2        | 159 nt | ATGG  | GAGC  |
| 2   | Oligo pool      | Tile 2 (12800 oligos) | 260 nt | GAGC  | TTCC  |
| 3   | Helper plasmid  | helper_plasmid_insert | --     | --    | --    |
| 4   | Enzyme + buffer | BsaI-HFv2 + CutSmart  | --     | --    | --    |

```
  [ATGG]----5'WT block----[GAGC]----oligo+BC----[TTCC]
   ATGG                    GAGC                  TTCC 
   (--)                    (--)                  (--) 
```

**Set fidelity:** 0.9991 (3 overhangs, 0 in HF set)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------ | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)      | --      | --    | --    |
| 2   | 3'WT block        | bsmbi_3wt_tile2_sub1     | 1296 nt | TTTT  | TAAT  |
| 3   | 3'WT block        | bsmbi_3wt_tile1_sub2     | 1725 nt | TAAT  | ATCA  |
| 4   | 3'WT block        | bsmbi_3wt_tile1_sub3     | 540 nt  | ATCA  | GCTA  |
| 5   | 3'WT+PolIII block | bsmbi_3wt_tile1_sub4     | 1655 nt | GCTA  | CACC  |
| 6   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1 | --      | --    | --    |

```
  [TTTT]----3'WT sub1----[TAAT]----3'WT sub2----[ATCA]----3'WT sub3----[GCTA]----3'WT+PolIII sub4----[CACC]
   TTTT                   TAAT                   ATCA                   GCTA                          CACC 
   (--)                   (--)                   (--)                   (--)                          (--) 
```

**Set fidelity:** 0.9611 (5 overhangs, 0 in HF set)

---

### Tile 3 of 25 -- Codons 112-183 (216 nt)

**Boundary overhangs:**

| Position          | Sequence | In HF Set | Fidelity |
| ----------------- | -------- | --------- | -------- |
| oh1 (5' boundary) | ATGC     | No        | 0.6171   |
| oh2 (3' boundary) | ATTC     | No        | 0.7084   |

**Variants:** 13600 mutations, 13600 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name             | Length | 5' OH | 3' OH |
| --- | --------------- | --------------------- | ------ | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile3        | 351 nt | ATGG  | ATGC  |
| 2   | Oligo pool      | Tile 3 (13600 oligos) | 272 nt | ATGC  | TTCC  |
| 3   | Helper plasmid  | helper_plasmid_insert | --     | --    | --    |
| 4   | Enzyme + buffer | BsaI-HFv2 + CutSmart  | --     | --    | --    |

```
  [ATGG]----5'WT block----[ATGC]----oligo+BC----[TTCC]
   ATGG                    ATGC                  TTCC 
   (--)                    (--)                  (--) 
```

**Set fidelity:** 0.9997 (3 overhangs, 0 in HF set)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------ | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)      | --      | --    | --    |
| 2   | 3'WT block        | bsmbi_3wt_tile3_sub1     | 1092 nt | ATTC  | TAAT  |
| 3   | 3'WT block        | bsmbi_3wt_tile1_sub2     | 1725 nt | TAAT  | ATCA  |
| 4   | 3'WT block        | bsmbi_3wt_tile1_sub3     | 540 nt  | ATCA  | GCTA  |
| 5   | 3'WT+PolIII block | bsmbi_3wt_tile1_sub4     | 1655 nt | GCTA  | CACC  |
| 6   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1 | --      | --    | --    |

```
  [ATTC]----3'WT sub1----[TAAT]----3'WT sub2----[ATCA]----3'WT sub3----[GCTA]----3'WT+PolIII sub4----[CACC]
   ATTC                   TAAT                   ATCA                   GCTA                          CACC 
   (--)                   (--)                   (--)                   (--)                          (--) 
```

**Set fidelity:** 0.9439 (5 overhangs, 0 in HF set)

---

### Tile 4 of 25 -- Codons 180-257 (234 nt)

**Boundary overhangs:**

| Position          | Sequence | In HF Set | Fidelity |
| ----------------- | -------- | --------- | -------- |
| oh1 (5' boundary) | TACA     | No        | 0.8652   |
| oh2 (3' boundary) | TGTC     | No        | 0.6650   |

**Variants:** 14800 mutations, 14800 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name             | Length | 5' OH | 3' OH |
| --- | --------------- | --------------------- | ------ | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile4        | 555 nt | ATGG  | TACA  |
| 2   | Oligo pool      | Tile 4 (14800 oligos) | 290 nt | TACA  | TTCC  |
| 3   | Helper plasmid  | helper_plasmid_insert | --     | --    | --    |
| 4   | Enzyme + buffer | BsaI-HFv2 + CutSmart  | --     | --    | --    |

```
  [ATGG]----5'WT block----[TACA]----oligo+BC----[TTCC]
   ATGG                    TACA                  TTCC 
   (--)                    (--)                  (--) 
```

**Set fidelity:** 0.9996 (3 overhangs, 0 in HF set)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------ | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)      | --      | --    | --    |
| 2   | 3'WT block        | bsmbi_3wt_tile4_sub1     | 870 nt  | TGTC  | TAAT  |
| 3   | 3'WT block        | bsmbi_3wt_tile1_sub2     | 1725 nt | TAAT  | ATCA  |
| 4   | 3'WT block        | bsmbi_3wt_tile1_sub3     | 540 nt  | ATCA  | GCTA  |
| 5   | 3'WT+PolIII block | bsmbi_3wt_tile1_sub4     | 1655 nt | GCTA  | CACC  |
| 6   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1 | --      | --    | --    |

```
  [TGTC]----3'WT sub1----[TAAT]----3'WT sub2----[ATCA]----3'WT sub3----[GCTA]----3'WT+PolIII sub4----[CACC]
   TGTC                   TAAT                   ATCA                   GCTA                          CACC 
   (--)                   (--)                   (--)                   (--)                          (--) 
```

**Set fidelity:** 0.9484 (5 overhangs, 0 in HF set)

---

### Tile 5 of 25 -- Codons 254-313 (180 nt)

**Boundary overhangs:**

| Position          | Sequence | In HF Set | Fidelity |
| ----------------- | -------- | --------- | -------- |
| oh1 (5' boundary) | TTCT     | No        | 0.8181   |
| oh2 (3' boundary) | CATC     | No        | 0.5216   |

**Variants:** 11200 mutations, 11200 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name             | Length | 5' OH | 3' OH |
| --- | --------------- | --------------------- | ------ | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile5        | 777 nt | ATGG  | TTCT  |
| 2   | Oligo pool      | Tile 5 (11200 oligos) | 236 nt | TTCT  | TTCC  |
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
| 2   | 3'WT block        | bsmbi_3wt_tile5_sub1     | 702 nt  | CATC  | TAAT  |
| 3   | 3'WT block        | bsmbi_3wt_tile1_sub2     | 1725 nt | TAAT  | ATCA  |
| 4   | 3'WT block        | bsmbi_3wt_tile1_sub3     | 540 nt  | ATCA  | GCTA  |
| 5   | 3'WT+PolIII block | bsmbi_3wt_tile1_sub4     | 1655 nt | GCTA  | CACC  |
| 6   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1 | --      | --    | --    |

```
  [CATC]----3'WT sub1----[TAAT]----3'WT sub2----[ATCA]----3'WT sub3----[GCTA]----3'WT+PolIII sub4----[CACC]
   CATC                   TAAT                   ATCA                   GCTA                          CACC 
   (--)                   (--)                   (--)                   (--)                          (--) 
```

**Set fidelity:** 0.9570 (5 overhangs, 0 in HF set)

---

### Tile 6 of 25 -- Codons 310-353 (132 nt)

**Boundary overhangs:**

| Position          | Sequence | In HF Set | Fidelity |
| ----------------- | -------- | --------- | -------- |
| oh1 (5' boundary) | TTCT     | No        | 0.8181   |
| oh2 (3' boundary) | GGAA     | No        | 0.7463   |

**Variants:** 8000 mutations, 8000 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name             | Length | 5' OH | 3' OH |
| --- | --------------- | --------------------- | ------ | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile6        | 945 nt | ATGG  | TTCT  |
| 2   | Oligo pool      | Tile 6 (8000 oligos)  | 188 nt | TTCT  | TTCC  |
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
| 2   | 3'WT block        | bsmbi_3wt_tile6_sub1     | 582 nt  | GGAA  | TAAT  |
| 3   | 3'WT block        | bsmbi_3wt_tile1_sub2     | 1725 nt | TAAT  | ATCA  |
| 4   | 3'WT block        | bsmbi_3wt_tile1_sub3     | 540 nt  | ATCA  | GCTA  |
| 5   | 3'WT+PolIII block | bsmbi_3wt_tile1_sub4     | 1655 nt | GCTA  | CACC  |
| 6   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1 | --      | --    | --    |

```
  [GGAA]----3'WT sub1----[TAAT]----3'WT sub2----[ATCA]----3'WT sub3----[GCTA]----3'WT+PolIII sub4----[CACC]
   GGAA                   TAAT                   ATCA                   GCTA                          CACC 
   (--)                   (--)                   (--)                   (--)                          (--) 
```

**Set fidelity:** 0.9553 (5 overhangs, 0 in HF set)

---

### Tile 7 of 25 -- Codons 350-399 (150 nt)

**Boundary overhangs:**

| Position          | Sequence | In HF Set | Fidelity |
| ----------------- | -------- | --------- | -------- |
| oh1 (5' boundary) | TTCA     | No        | 0.8824   |
| oh2 (3' boundary) | CTGT     | No        | 0.6476   |

**Variants:** 9200 mutations, 9200 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name             | Length  | 5' OH | 3' OH |
| --- | --------------- | --------------------- | ------- | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile7        | 1065 nt | ATGG  | TTCA  |
| 2   | Oligo pool      | Tile 7 (9200 oligos)  | 206 nt  | TTCA  | TTCC  |
| 3   | Helper plasmid  | helper_plasmid_insert | --      | --    | --    |
| 4   | Enzyme + buffer | BsaI-HFv2 + CutSmart  | --      | --    | --    |

```
  [ATGG]----5'WT block----[TTCA]----oligo+BC----[TTCC]
   ATGG                    TTCA                  TTCC 
   (--)                    (--)                  (--) 
```

**Set fidelity:** 0.9996 (3 overhangs, 0 in HF set)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------ | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)      | --      | --    | --    |
| 2   | 3'WT block        | bsmbi_3wt_tile7_sub1     | 444 nt  | CTGT  | TAAT  |
| 3   | 3'WT block        | bsmbi_3wt_tile1_sub2     | 1725 nt | TAAT  | ATCA  |
| 4   | 3'WT block        | bsmbi_3wt_tile1_sub3     | 540 nt  | ATCA  | GCTA  |
| 5   | 3'WT+PolIII block | bsmbi_3wt_tile1_sub4     | 1655 nt | GCTA  | CACC  |
| 6   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1 | --      | --    | --    |

```
  [CTGT]----3'WT sub1----[TAAT]----3'WT sub2----[ATCA]----3'WT sub3----[GCTA]----3'WT+PolIII sub4----[CACC]
   CTGT                   TAAT                   ATCA                   GCTA                          CACC 
   (--)                   (--)                   (--)                   (--)                          (--) 
```

**Set fidelity:** 0.9646 (5 overhangs, 0 in HF set)

---

### Tile 8 of 25 -- Codons 396-468 (219 nt)

**Boundary overhangs:**

| Position          | Sequence | In HF Set | Fidelity |
| ----------------- | -------- | --------- | -------- |
| oh1 (5' boundary) | TTCT     | No        | 0.8181   |
| oh2 (3' boundary) | TTCC     | No        | 0.7958   |

**Variants:** 13800 mutations, 13800 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name             | Length  | 5' OH | 3' OH |
| --- | --------------- | --------------------- | ------- | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile8        | 1203 nt | ATGG  | TTCT  |
| 2   | Oligo pool      | Tile 8 (13800 oligos) | 275 nt  | TTCT  | TTCC  |
| 3   | Helper plasmid  | helper_plasmid_insert | --      | --    | --    |
| 4   | Enzyme + buffer | BsaI-HFv2 + CutSmart  | --      | --    | --    |

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
| 2   | 3'WT block        | bsmbi_3wt_tile8_sub1     | 237 nt  | TTCC  | TAAT  |
| 3   | 3'WT block        | bsmbi_3wt_tile1_sub2     | 1725 nt | TAAT  | ATCA  |
| 4   | 3'WT block        | bsmbi_3wt_tile1_sub3     | 540 nt  | ATCA  | GCTA  |
| 5   | 3'WT+PolIII block | bsmbi_3wt_tile1_sub4     | 1655 nt | GCTA  | CACC  |
| 6   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1 | --      | --    | --    |

```
  [TTCC]----3'WT sub1----[TAAT]----3'WT sub2----[ATCA]----3'WT sub3----[GCTA]----3'WT+PolIII sub4----[CACC]
   TTCC                   TAAT                   ATCA                   GCTA                          CACC 
   (--)                   (--)                   (--)                   (--)                          (--) 
```

**Set fidelity:** 0.9614 (5 overhangs, 0 in HF set)

---

### Tile 9 of 25 -- Codons 465-541 (231 nt)

**Boundary overhangs:**

| Position          | Sequence | In HF Set | Fidelity |
| ----------------- | -------- | --------- | -------- |
| oh1 (5' boundary) | AAGA     | No        | 0.9209   |
| oh2 (3' boundary) | TAAT     | No        | 0.8165   |

**Variants:** 14600 mutations, 14600 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name             | Length  | 5' OH | 3' OH |
| --- | --------------- | --------------------- | ------- | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile9        | 1410 nt | ATGG  | AAGA  |
| 2   | Oligo pool      | Tile 9 (14600 oligos) | 287 nt  | AAGA  | TTCC  |
| 3   | Helper plasmid  | helper_plasmid_insert | --      | --    | --    |
| 4   | Enzyme + buffer | BsaI-HFv2 + CutSmart  | --      | --    | --    |

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
| 2   | 3'WT block        | bsmbi_3wt_tile1_sub2     | 1725 nt | TAAT  | ATCA  |
| 3   | 3'WT block        | bsmbi_3wt_tile1_sub3     | 540 nt  | ATCA  | GCTA  |
| 4   | 3'WT+PolIII block | bsmbi_3wt_tile1_sub4     | 1655 nt | GCTA  | CACC  |
| 5   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1 | --      | --    | --    |

```
  [TAAT]----3'WT sub1----[ATCA]----3'WT sub2----[GCTA]----3'WT+PolIII sub3----[CACC]
   TAAT                   ATCA                   GCTA                          CACC 
   (--)                   (--)                   (--)                          (--) 
```

**Set fidelity:** 0.9665 (4 overhangs, 0 in HF set)

---

### Tile 10 of 25 -- Codons 538-603 (198 nt)

**Boundary overhangs:**

| Position          | Sequence | In HF Set | Fidelity |
| ----------------- | -------- | --------- | -------- |
| oh1 (5' boundary) | TCAA     | No        | 0.9425   |
| oh2 (3' boundary) | AAAA     | Yes       | 0.9502   |

**Variants:** 12400 mutations, 12400 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name              | Length  | 5' OH | 3' OH |
| --- | --------------- | ---------------------- | ------- | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile10        | 1629 nt | ATGG  | TCAA  |
| 2   | Oligo pool      | Tile 10 (12400 oligos) | 254 nt  | TCAA  | TTCC  |
| 3   | Helper plasmid  | helper_plasmid_insert  | --      | --    | --    |
| 4   | Enzyme + buffer | BsaI-HFv2 + CutSmart   | --      | --    | --    |

```
  [ATGG]----5'WT block----[TCAA]----oligo+BC----[TTCC]
   ATGG                    TCAA                  TTCC 
   (--)                    (--)                  (--) 
```

**Set fidelity:** 0.9949 (3 overhangs, 0 in HF set)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------ | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)      | --      | --    | --    |
| 2   | 3'WT block        | bsmbi_3wt_tile10_sub1    | 1539 nt | AAAA  | ATCA  |
| 3   | 3'WT block        | bsmbi_3wt_tile1_sub3     | 540 nt  | ATCA  | GCTA  |
| 4   | 3'WT+PolIII block | bsmbi_3wt_tile1_sub4     | 1655 nt | GCTA  | CACC  |
| 5   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1 | --      | --    | --    |

```
  [AAAA]----3'WT sub1----[ATCA]----3'WT sub2----[GCTA]----3'WT+PolIII sub3----[CACC]
   AAAA                   ATCA                   GCTA                          CACC 
   (HF)                   (--)                   (--)                          (--) 
```

**Set fidelity:** 0.9891 (4 overhangs, 1 in HF set)

---

### Tile 11 of 25 -- Codons 600-672 (219 nt)

**Boundary overhangs:**

| Position          | Sequence | In HF Set | Fidelity |
| ----------------- | -------- | --------- | -------- |
| oh1 (5' boundary) | ACAA     | Yes       | 0.8919   |
| oh2 (3' boundary) | AAGA     | No        | 0.9209   |

**Variants:** 13800 mutations, 13800 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name              | Length  | 5' OH | 3' OH |
| --- | --------------- | ---------------------- | ------- | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile11_sub1   | 1637 nt | ATGG  | TAAT  |
| 2   | 5'WT gene block | bsai_5wt_tile11_sub2   | 196 nt  | TAAT  | ACAA  |
| 3   | Oligo pool      | Tile 11 (13800 oligos) | 275 nt  | ACAA  | TTCC  |
| 4   | Helper plasmid  | helper_plasmid_insert  | --      | --    | --    |
| 5   | Enzyme + buffer | BsaI-HFv2 + CutSmart   | --      | --    | --    |

```
  [ATGG]----5'WT sub1----[TAAT]----5'WT sub2----[ACAA]----oligo+BC----[TTCC]
   ATGG                   TAAT                   ACAA                  TTCC 
   (--)                   (--)                   (HF)                  (--) 
```

**Set fidelity:** 0.9893 (4 overhangs, 1 in HF set)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------ | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)      | --      | --    | --    |
| 2   | 3'WT block        | bsmbi_3wt_tile11_sub1    | 1332 nt | AAGA  | ATCA  |
| 3   | 3'WT block        | bsmbi_3wt_tile1_sub3     | 540 nt  | ATCA  | GCTA  |
| 4   | 3'WT+PolIII block | bsmbi_3wt_tile1_sub4     | 1655 nt | GCTA  | CACC  |
| 5   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1 | --      | --    | --    |

```
  [AAGA]----3'WT sub1----[ATCA]----3'WT sub2----[GCTA]----3'WT+PolIII sub3----[CACC]
   AAGA                   ATCA                   GCTA                          CACC 
   (--)                   (--)                   (--)                          (--) 
```

**Set fidelity:** 0.9860 (4 overhangs, 0 in HF set)

---

### Tile 12 of 25 -- Codons 669-724 (168 nt)

**Boundary overhangs:**

| Position          | Sequence | In HF Set | Fidelity |
| ----------------- | -------- | --------- | -------- |
| oh1 (5' boundary) | AAGT     | Yes       | 0.7629   |
| oh2 (3' boundary) | GAAG     | No        | 0.6752   |

**Variants:** 10400 mutations, 10400 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name              | Length  | 5' OH | 3' OH |
| --- | --------------- | ---------------------- | ------- | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile11_sub1   | 1637 nt | ATGG  | TAAT  |
| 2   | 5'WT gene block | bsai_5wt_tile12_sub2   | 403 nt  | TAAT  | AAGT  |
| 3   | Oligo pool      | Tile 12 (10400 oligos) | 224 nt  | AAGT  | TTCC  |
| 4   | Helper plasmid  | helper_plasmid_insert  | --      | --    | --    |
| 5   | Enzyme + buffer | BsaI-HFv2 + CutSmart   | --      | --    | --    |

```
  [ATGG]----5'WT sub1----[TAAT]----5'WT sub2----[AAGT]----oligo+BC----[TTCC]
   ATGG                   TAAT                   AAGT                  TTCC 
   (--)                   (--)                   (HF)                  (--) 
```

**Set fidelity:** 0.9947 (4 overhangs, 1 in HF set)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------ | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)      | --      | --    | --    |
| 2   | 3'WT block        | bsmbi_3wt_tile12_sub1    | 1176 nt | GAAG  | ATCA  |
| 3   | 3'WT block        | bsmbi_3wt_tile1_sub3     | 540 nt  | ATCA  | GCTA  |
| 4   | 3'WT+PolIII block | bsmbi_3wt_tile1_sub4     | 1655 nt | GCTA  | CACC  |
| 5   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1 | --      | --    | --    |

```
  [GAAG]----3'WT sub1----[ATCA]----3'WT sub2----[GCTA]----3'WT+PolIII sub3----[CACC]
   GAAG                   ATCA                   GCTA                          CACC 
   (--)                   (--)                   (--)                          (--) 
```

**Set fidelity:** 0.9801 (4 overhangs, 0 in HF set)

---

### Tile 13 of 25 -- Codons 721-770 (150 nt)

**Boundary overhangs:**

| Position          | Sequence | In HF Set | Fidelity |
| ----------------- | -------- | --------- | -------- |
| oh1 (5' boundary) | AAAA     | Yes       | 0.9502   |
| oh2 (3' boundary) | TCCT     | No        | 0.7573   |

**Variants:** 9200 mutations, 9200 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name             | Length  | 5' OH | 3' OH |
| --- | --------------- | --------------------- | ------- | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile11_sub1  | 1637 nt | ATGG  | TAAT  |
| 2   | 5'WT gene block | bsai_5wt_tile13_sub2  | 559 nt  | TAAT  | AAAA  |
| 3   | Oligo pool      | Tile 13 (9200 oligos) | 206 nt  | AAAA  | TTCC  |
| 4   | Helper plasmid  | helper_plasmid_insert | --      | --    | --    |
| 5   | Enzyme + buffer | BsaI-HFv2 + CutSmart  | --      | --    | --    |

```
  [ATGG]----5'WT sub1----[TAAT]----5'WT sub2----[AAAA]----oligo+BC----[TTCC]
   ATGG                   TAAT                   AAAA                  TTCC 
   (--)                   (--)                   (HF)                  (--) 
```

**Set fidelity:** 0.9929 (4 overhangs, 1 in HF set)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------ | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)      | --      | --    | --    |
| 2   | 3'WT block        | bsmbi_3wt_tile13_sub1    | 1038 nt | TCCT  | ATCA  |
| 3   | 3'WT block        | bsmbi_3wt_tile1_sub3     | 540 nt  | ATCA  | GCTA  |
| 4   | 3'WT+PolIII block | bsmbi_3wt_tile1_sub4     | 1655 nt | GCTA  | CACC  |
| 5   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1 | --      | --    | --    |

```
  [TCCT]----3'WT sub1----[ATCA]----3'WT sub2----[GCTA]----3'WT+PolIII sub3----[CACC]
   TCCT                   ATCA                   GCTA                          CACC 
   (--)                   (--)                   (--)                          (--) 
```

**Set fidelity:** 0.9861 (4 overhangs, 0 in HF set)

---

### Tile 14 of 25 -- Codons 767-844 (234 nt)

**Boundary overhangs:**

| Position          | Sequence | In HF Set | Fidelity |
| ----------------- | -------- | --------- | -------- |
| oh1 (5' boundary) | AAAG     | No        | 0.7511   |
| oh2 (3' boundary) | GAAG     | No        | 0.6752   |

**Variants:** 14800 mutations, 14800 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name              | Length  | 5' OH | 3' OH |
| --- | --------------- | ---------------------- | ------- | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile11_sub1   | 1637 nt | ATGG  | TAAT  |
| 2   | 5'WT gene block | bsai_5wt_tile14_sub2   | 697 nt  | TAAT  | AAAG  |
| 3   | Oligo pool      | Tile 14 (14800 oligos) | 290 nt  | AAAG  | TTCC  |
| 4   | Helper plasmid  | helper_plasmid_insert  | --      | --    | --    |
| 5   | Enzyme + buffer | BsaI-HFv2 + CutSmart   | --      | --    | --    |

```
  [ATGG]----5'WT sub1----[TAAT]----5'WT sub2----[AAAG]----oligo+BC----[TTCC]
   ATGG                   TAAT                   AAAG                  TTCC 
   (--)                   (--)                   (--)                  (--) 
```

**Set fidelity:** 0.9943 (4 overhangs, 0 in HF set)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------ | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)      | --      | --    | --    |
| 2   | 3'WT block        | bsmbi_3wt_tile14_sub1    | 816 nt  | GAAG  | ATCA  |
| 3   | 3'WT block        | bsmbi_3wt_tile1_sub3     | 540 nt  | ATCA  | GCTA  |
| 4   | 3'WT+PolIII block | bsmbi_3wt_tile1_sub4     | 1655 nt | GCTA  | CACC  |
| 5   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1 | --      | --    | --    |

```
  [GAAG]----3'WT sub1----[ATCA]----3'WT sub2----[GCTA]----3'WT+PolIII sub3----[CACC]
   GAAG                   ATCA                   GCTA                          CACC 
   (--)                   (--)                   (--)                          (--) 
```

**Set fidelity:** 0.9801 (4 overhangs, 0 in HF set)

---

### Tile 15 of 25 -- Codons 841-905 (195 nt)

**Boundary overhangs:**

| Position          | Sequence | In HF Set | Fidelity |
| ----------------- | -------- | --------- | -------- |
| oh1 (5' boundary) | TTCT     | No        | 0.8181   |
| oh2 (3' boundary) | TTCC     | No        | 0.7958   |

**Variants:** 12200 mutations, 12200 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name              | Length  | 5' OH | 3' OH |
| --- | --------------- | ---------------------- | ------- | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile11_sub1   | 1637 nt | ATGG  | TAAT  |
| 2   | 5'WT gene block | bsai_5wt_tile15_sub2   | 919 nt  | TAAT  | TTCT  |
| 3   | Oligo pool      | Tile 15 (12200 oligos) | 251 nt  | TTCT  | TTCC  |
| 4   | Helper plasmid  | helper_plasmid_insert  | --      | --    | --    |
| 5   | Enzyme + buffer | BsaI-HFv2 + CutSmart   | --      | --    | --    |

```
  [ATGG]----5'WT sub1----[TAAT]----5'WT sub2----[TTCT]----oligo+BC----[TTCC]
   ATGG                   TAAT                   TTCT                  TTCC 
   (--)                   (--)                   (--)                  (--) 
```

**Set fidelity:** 0.9948 (4 overhangs, 0 in HF set)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------ | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)      | --      | --    | --    |
| 2   | 3'WT block        | bsmbi_3wt_tile15_sub1    | 633 nt  | TTCC  | ATCA  |
| 3   | 3'WT block        | bsmbi_3wt_tile1_sub3     | 540 nt  | ATCA  | GCTA  |
| 4   | 3'WT+PolIII block | bsmbi_3wt_tile1_sub4     | 1655 nt | GCTA  | CACC  |
| 5   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1 | --      | --    | --    |

```
  [TTCC]----3'WT sub1----[ATCA]----3'WT sub2----[GCTA]----3'WT+PolIII sub3----[CACC]
   TTCC                   ATCA                   GCTA                          CACC 
   (--)                   (--)                   (--)                          (--) 
```

**Set fidelity:** 0.9849 (4 overhangs, 0 in HF set)

---

### Tile 16 of 25 -- Codons 902-952 (153 nt)

**Boundary overhangs:**

| Position          | Sequence | In HF Set | Fidelity |
| ----------------- | -------- | --------- | -------- |
| oh1 (5' boundary) | AAAA     | Yes       | 0.9502   |
| oh2 (3' boundary) | GAAA     | No        | 0.8745   |

**Variants:** 9400 mutations, 9400 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name             | Length  | 5' OH | 3' OH |
| --- | --------------- | --------------------- | ------- | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile11_sub1  | 1637 nt | ATGG  | TAAT  |
| 2   | 5'WT gene block | bsai_5wt_tile16_sub2  | 1102 nt | TAAT  | AAAA  |
| 3   | Oligo pool      | Tile 16 (9400 oligos) | 209 nt  | AAAA  | TTCC  |
| 4   | Helper plasmid  | helper_plasmid_insert | --      | --    | --    |
| 5   | Enzyme + buffer | BsaI-HFv2 + CutSmart  | --      | --    | --    |

```
  [ATGG]----5'WT sub1----[TAAT]----5'WT sub2----[AAAA]----oligo+BC----[TTCC]
   ATGG                   TAAT                   AAAA                  TTCC 
   (--)                   (--)                   (HF)                  (--) 
```

**Set fidelity:** 0.9929 (4 overhangs, 1 in HF set)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------ | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)      | --      | --    | --    |
| 2   | 3'WT block        | bsmbi_3wt_tile16_sub1    | 492 nt  | GAAA  | ATCA  |
| 3   | 3'WT block        | bsmbi_3wt_tile1_sub3     | 540 nt  | ATCA  | GCTA  |
| 4   | 3'WT+PolIII block | bsmbi_3wt_tile1_sub4     | 1655 nt | GCTA  | CACC  |
| 5   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1 | --      | --    | --    |

```
  [GAAA]----3'WT sub1----[ATCA]----3'WT sub2----[GCTA]----3'WT+PolIII sub3----[CACC]
   GAAA                   ATCA                   GCTA                          CACC 
   (--)                   (--)                   (--)                          (--) 
```

**Set fidelity:** 0.9881 (4 overhangs, 0 in HF set)

---

### Tile 17 of 25 -- Codons 949-1020 (216 nt)

**Boundary overhangs:**

| Position          | Sequence | In HF Set | Fidelity |
| ----------------- | -------- | --------- | -------- |
| oh1 (5' boundary) | TTTC     | No        | 0.8348   |
| oh2 (3' boundary) | TTCC     | No        | 0.7958   |

**Variants:** 13600 mutations, 13600 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name              | Length  | 5' OH | 3' OH |
| --- | --------------- | ---------------------- | ------- | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile11_sub1   | 1637 nt | ATGG  | TAAT  |
| 2   | 5'WT gene block | bsai_5wt_tile17_sub2   | 1243 nt | TAAT  | TTTC  |
| 3   | Oligo pool      | Tile 17 (13600 oligos) | 272 nt  | TTTC  | TTCC  |
| 4   | Helper plasmid  | helper_plasmid_insert  | --      | --    | --    |
| 5   | Enzyme + buffer | BsaI-HFv2 + CutSmart   | --      | --    | --    |

```
  [ATGG]----5'WT sub1----[TAAT]----5'WT sub2----[TTTC]----oligo+BC----[TTCC]
   ATGG                   TAAT                   TTTC                  TTCC 
   (--)                   (--)                   (--)                  (--) 
```

**Set fidelity:** 0.9937 (4 overhangs, 0 in HF set)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------ | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)      | --      | --    | --    |
| 2   | 3'WT block        | bsmbi_3wt_tile17_sub1    | 810 nt  | TTCC  | ATCA  |
| 3   | 3'WT+PolIII block | bsmbi_3wt_tile1_sub4     | 1655 nt | ATCA  | CACC  |
| 4   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1 | --      | --    | --    |

```
  [TTCC]----3'WT sub1----[ATCA]----3'WT+PolIII sub2----[GCTA][CACC]
   TTCC                   ATCA                          GCTA  CACC 
   (--)                   (--)                          (--)  (--) 
```

**Set fidelity:** 0.9849 (4 overhangs, 0 in HF set)

---

### Tile 18 of 25 -- Codons 1017-1054 (114 nt)

**Boundary overhangs:**

| Position          | Sequence | In HF Set | Fidelity |
| ----------------- | -------- | --------- | -------- |
| oh1 (5' boundary) | TCCG     | No        | 0.7234   |
| oh2 (3' boundary) | AGAA     | No        | 0.8847   |

**Variants:** 6800 mutations, 6800 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name             | Length  | 5' OH | 3' OH |
| --- | --------------- | --------------------- | ------- | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile11_sub1  | 1637 nt | ATGG  | TAAT  |
| 2   | 5'WT gene block | bsai_5wt_tile18_sub2  | 1447 nt | TAAT  | TCCG  |
| 3   | Oligo pool      | Tile 18 (6800 oligos) | 170 nt  | TCCG  | TTCC  |
| 4   | Helper plasmid  | helper_plasmid_insert | --      | --    | --    |
| 5   | Enzyme + buffer | BsaI-HFv2 + CutSmart  | --      | --    | --    |

```
  [ATGG]----5'WT sub1----[TAAT]----5'WT sub2----[TCCG]----oligo+BC----[TTCC]
   ATGG                   TAAT                   TCCG                  TTCC 
   (--)                   (--)                   (--)                  (--) 
```

**Set fidelity:** 0.9949 (4 overhangs, 0 in HF set)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------ | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)      | --      | --    | --    |
| 2   | 3'WT block        | bsmbi_3wt_tile18_sub1    | 708 nt  | AGAA  | ATCA  |
| 3   | 3'WT+PolIII block | bsmbi_3wt_tile1_sub4     | 1655 nt | ATCA  | CACC  |
| 4   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1 | --      | --    | --    |

```
  [AGAA]----3'WT sub1----[ATCA]----3'WT+PolIII sub2----[GCTA][CACC]
   AGAA                   ATCA                          GCTA  CACC 
   (--)                   (--)                          (--)  (--) 
```

**Set fidelity:** 0.9867 (4 overhangs, 0 in HF set)

---

### Tile 19 of 25 -- Codons 1051-1110 (180 nt)

**Boundary overhangs:**

| Position          | Sequence | In HF Set | Fidelity |
| ----------------- | -------- | --------- | -------- |
| oh1 (5' boundary) | TATC     | No        | 0.8041   |
| oh2 (3' boundary) | ATCA     | No        | 0.7483   |

**Variants:** 11200 mutations, 11200 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name              | Length  | 5' OH | 3' OH |
| --- | --------------- | ---------------------- | ------- | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile11_sub1   | 1637 nt | ATGG  | TAAT  |
| 2   | 5'WT gene block | bsai_5wt_tile19_sub2   | 1549 nt | TAAT  | TATC  |
| 3   | Oligo pool      | Tile 19 (11200 oligos) | 236 nt  | TATC  | TTCC  |
| 4   | Helper plasmid  | helper_plasmid_insert  | --      | --    | --    |
| 5   | Enzyme + buffer | BsaI-HFv2 + CutSmart   | --      | --    | --    |

```
  [ATGG]----5'WT sub1----[TAAT]----5'WT sub2----[TATC]----oligo+BC----[TTCC]
   ATGG                   TAAT                   TATC                  TTCC 
   (--)                   (--)                   (--)                  (--) 
```

**Set fidelity:** 0.9952 (4 overhangs, 0 in HF set)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------ | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)      | --      | --    | --    |
| 2   | 3'WT block        | bsmbi_3wt_tile1_sub3     | 540 nt  | ATCA  | GCTA  |
| 3   | 3'WT+PolIII block | bsmbi_3wt_tile1_sub4     | 1655 nt | GCTA  | CACC  |
| 4   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1 | --      | --    | --    |

```
  [ATCA]----3'WT sub1----[GCTA]----3'WT+PolIII sub2----[CACC]
   ATCA                   GCTA                          CACC 
   (--)                   (--)                          (--) 
```

**Set fidelity:** 0.9899 (3 overhangs, 0 in HF set)

---

### Tile 20 of 25 -- Codons 1107-1175 (207 nt)

**Boundary overhangs:**

| Position          | Sequence | In HF Set | Fidelity |
| ----------------- | -------- | --------- | -------- |
| oh1 (5' boundary) | AAAA     | Yes       | 0.9502   |
| oh2 (3' boundary) | TGAA     | Yes       | 0.8621   |

**Variants:** 13000 mutations, 13000 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name              | Length  | 5' OH | 3' OH |
| --- | --------------- | ---------------------- | ------- | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile11_sub1   | 1637 nt | ATGG  | TAAT  |
| 2   | 5'WT gene block | bsai_5wt_tile20_sub2   | 1717 nt | TAAT  | AAAA  |
| 3   | Oligo pool      | Tile 20 (13000 oligos) | 263 nt  | AAAA  | TTCC  |
| 4   | Helper plasmid  | helper_plasmid_insert  | --      | --    | --    |
| 5   | Enzyme + buffer | BsaI-HFv2 + CutSmart   | --      | --    | --    |

```
  [ATGG]----5'WT sub1----[TAAT]----5'WT sub2----[AAAA]----oligo+BC----[TTCC]
   ATGG                   TAAT                   AAAA                  TTCC 
   (--)                   (--)                   (HF)                  (--) 
```

**Set fidelity:** 0.9929 (4 overhangs, 1 in HF set)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------ | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)      | --      | --    | --    |
| 2   | 3'WT block        | bsmbi_3wt_tile20_sub1    | 345 nt  | TGAA  | GCTA  |
| 3   | 3'WT+PolIII block | bsmbi_3wt_tile1_sub4     | 1655 nt | GCTA  | CACC  |
| 4   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1 | --      | --    | --    |

```
  [TGAA]----3'WT sub1----[GCTA]----3'WT+PolIII sub2----[CACC]
   TGAA                   GCTA                          CACC 
   (HF)                   (--)                          (--) 
```

**Set fidelity:** 0.9886 (3 overhangs, 1 in HF set)

---

### Tile 21 of 25 -- Codons 1172-1218 (141 nt)

**Boundary overhangs:**

| Position          | Sequence | In HF Set | Fidelity |
| ----------------- | -------- | --------- | -------- |
| oh1 (5' boundary) | TTGC     | No        | 0.7336   |
| oh2 (3' boundary) | CCTT     | No        | 0.6891   |

**Variants:** 8600 mutations, 8600 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name             | Length  | 5' OH | 3' OH |
| --- | --------------- | --------------------- | ------- | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile11_sub1  | 1637 nt | ATGG  | TAAT  |
| 2   | 5'WT gene block | bsai_5wt_tile21_sub2  | 1725 nt | TAAT  | ATCA  |
| 3   | 5'WT gene block | bsai_5wt_tile21_sub3  | 205 nt  | ATCA  | TTGC  |
| 4   | Oligo pool      | Tile 21 (8600 oligos) | 197 nt  | TTGC  | TTCC  |
| 5   | Helper plasmid  | helper_plasmid_insert | --      | --    | --    |
| 6   | Enzyme + buffer | BsaI-HFv2 + CutSmart  | --      | --    | --    |

```
  [ATGG]----5'WT sub1----[TAAT]----5'WT sub2----[ATCA]----5'WT sub3----[TTGC]----oligo+BC----[TTCC]
   ATGG                   TAAT                   ATCA                   TTGC                  TTCC 
   (--)                   (--)                   (--)                   (--)                  (--) 
```

**Set fidelity:** 0.9771 (5 overhangs, 0 in HF set)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------ | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)      | --      | --    | --    |
| 2   | 3'WT block        | bsmbi_3wt_tile21_sub1    | 216 nt  | CCTT  | GCTA  |
| 3   | 3'WT+PolIII block | bsmbi_3wt_tile1_sub4     | 1655 nt | GCTA  | CACC  |
| 4   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1 | --      | --    | --    |

```
  [CCTT]----3'WT sub1----[GCTA]----3'WT+PolIII sub2----[CACC]
   CCTT                   GCTA                          CACC 
   (--)                   (--)                          (--) 
```

**Set fidelity:** 0.9889 (3 overhangs, 0 in HF set)

---

### Tile 22 of 25 -- Codons 1215-1284 (210 nt)

**Boundary overhangs:**

| Position          | Sequence | In HF Set | Fidelity |
| ----------------- | -------- | --------- | -------- |
| oh1 (5' boundary) | AGAA     | No        | 0.8847   |
| oh2 (3' boundary) | GCTA     | No        | 0.5810   |

**Variants:** 13200 mutations, 13200 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name              | Length  | 5' OH | 3' OH |
| --- | --------------- | ---------------------- | ------- | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile11_sub1   | 1637 nt | ATGG  | TAAT  |
| 2   | 5'WT gene block | bsai_5wt_tile21_sub2   | 1725 nt | TAAT  | ATCA  |
| 3   | 5'WT gene block | bsai_5wt_tile22_sub3   | 334 nt  | ATCA  | AGAA  |
| 4   | Oligo pool      | Tile 22 (13200 oligos) | 266 nt  | AGAA  | TTCC  |
| 5   | Helper plasmid  | helper_plasmid_insert  | --      | --    | --    |
| 6   | Enzyme + buffer | BsaI-HFv2 + CutSmart   | --      | --    | --    |

```
  [ATGG]----5'WT sub1----[TAAT]----5'WT sub2----[ATCA]----5'WT sub3----[AGAA]----oligo+BC----[TTCC]
   ATGG                   TAAT                   ATCA                   AGAA                  TTCC 
   (--)                   (--)                   (--)                   (--)                  (--) 
```

**Set fidelity:** 0.9618 (5 overhangs, 0 in HF set)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------ | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)      | --      | --    | --    |
| 2   | 3'WT+PolIII block | bsmbi_3wt_tile1_sub4     | 1655 nt | GCTA  | CACC  |
| 3   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1 | --      | --    | --    |

```
  [GCTA]----3'WT+PolIII----[CACC]
   GCTA                     CACC 
   (--)                     (--) 
```

**Set fidelity:** 0.9901 (2 overhangs, 0 in HF set)

---

### Tile 23 of 25 -- Codons 1281-1343 (189 nt)

**Boundary overhangs:**

| Position          | Sequence | In HF Set | Fidelity |
| ----------------- | -------- | --------- | -------- |
| oh1 (5' boundary) | AAGA     | No        | 0.9209   |
| oh2 (3' boundary) | CCTT     | No        | 0.6891   |

**Variants:** 11800 mutations, 11800 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name              | Length  | 5' OH | 3' OH |
| --- | --------------- | ---------------------- | ------- | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile11_sub1   | 1637 nt | ATGG  | TAAT  |
| 2   | 5'WT gene block | bsai_5wt_tile21_sub2   | 1725 nt | TAAT  | ATCA  |
| 3   | 5'WT gene block | bsai_5wt_tile23_sub3   | 532 nt  | ATCA  | AAGA  |
| 4   | Oligo pool      | Tile 23 (11800 oligos) | 245 nt  | AAGA  | TTCC  |
| 5   | Helper plasmid  | helper_plasmid_insert  | --      | --    | --    |
| 6   | Enzyme + buffer | BsaI-HFv2 + CutSmart   | --      | --    | --    |

```
  [ATGG]----5'WT sub1----[TAAT]----5'WT sub2----[ATCA]----5'WT sub3----[AAGA]----oligo+BC----[TTCC]
   ATGG                   TAAT                   ATCA                   AAGA                  TTCC 
   (--)                   (--)                   (--)                   (--)                  (--) 
```

**Set fidelity:** 0.9765 (5 overhangs, 0 in HF set)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------ | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)      | --      | --    | --    |
| 2   | 3'WT+PolIII block | bsmbi_3wt_tile23         | 1478 nt | CCTT  | CACC  |
| 3   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1 | --      | --    | --    |

```
  [CCTT]----3'WT+PolIII----[CACC]
   CCTT                     CACC 
   (--)                     (--) 
```

**Set fidelity:** 0.9988 (2 overhangs, 0 in HF set)

---

### Tile 24 of 25 -- Codons 1340-1413 (222 nt)

**Boundary overhangs:**

| Position          | Sequence | In HF Set | Fidelity |
| ----------------- | -------- | --------- | -------- |
| oh1 (5' boundary) | AAAA     | Yes       | 0.9502   |
| oh2 (3' boundary) | TTCC     | No        | 0.7958   |

**Variants:** 14000 mutations, 14000 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name              | Length  | 5' OH | 3' OH |
| --- | --------------- | ---------------------- | ------- | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile11_sub1   | 1637 nt | ATGG  | TAAT  |
| 2   | 5'WT gene block | bsai_5wt_tile21_sub2   | 1725 nt | TAAT  | ATCA  |
| 3   | 5'WT gene block | bsai_5wt_tile24_sub3   | 709 nt  | ATCA  | AAAA  |
| 4   | Oligo pool      | Tile 24 (14000 oligos) | 278 nt  | AAAA  | TTCC  |
| 5   | Helper plasmid  | helper_plasmid_insert  | --      | --    | --    |
| 6   | Enzyme + buffer | BsaI-HFv2 + CutSmart   | --      | --    | --    |

```
  [ATGG]----5'WT sub1----[TAAT]----5'WT sub2----[ATCA]----5'WT sub3----[GCTA]----oligo+BC----[AAAA][TTCC]
   ATGG                   TAAT                   ATCA                   GCTA                  AAAA  TTCC 
   (--)                   (--)                   (--)                   (--)                  (HF)  (--) 
```

**Set fidelity:** 0.9664 (6 overhangs, 1 in HF set)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------ | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)      | --      | --    | --    |
| 2   | 3'WT+PolIII block | bsmbi_3wt_tile24         | 1268 nt | TTCC  | CACC  |
| 3   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1 | --      | --    | --    |

```
  [TTCC]----3'WT+PolIII----[CACC]
   TTCC                     CACC 
   (--)                     (--) 
```

**Set fidelity:** 0.9999 (2 overhangs, 0 in HF set)

---

### Tile 25 of 25 -- Codons 1410-1465 (168 nt)

**Boundary overhangs:**

| Position          | Sequence | In HF Set | Fidelity |
| ----------------- | -------- | --------- | -------- |
| oh1 (5' boundary) | TCGT     | No        | 0.7335   |
| oh2 (3' boundary) | TTAA     | No        | 0.9448   |

**Variants:** 10400 mutations, 10400 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name              | Length  | 5' OH | 3' OH |
| --- | --------------- | ---------------------- | ------- | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile11_sub1   | 1637 nt | ATGG  | TAAT  |
| 2   | 5'WT gene block | bsai_5wt_tile21_sub2   | 1725 nt | TAAT  | ATCA  |
| 3   | 5'WT gene block | bsai_5wt_tile25_sub3   | 540 nt  | ATCA  | GCTA  |
| 4   | 5'WT gene block | bsai_5wt_tile25_sub4   | 397 nt  | GCTA  | TCGT  |
| 5   | Oligo pool      | Tile 25 (10400 oligos) | 224 nt  | TCGT  | TTCC  |
| 6   | Helper plasmid  | helper_plasmid_insert  | --      | --    | --    |
| 7   | Enzyme + buffer | BsaI-HFv2 + CutSmart   | --      | --    | --    |

```
  [ATGG]----5'WT sub1----[TAAT]----5'WT sub2----[ATCA]----5'WT sub3----[GCTA]----5'WT sub4----[TCGT]----oligo+BC----[TTCC]
   ATGG                   TAAT                   ATCA                   GCTA                   TCGT                  TTCC 
   (--)                   (--)                   (--)                   (--)                   (--)                  (--) 
```

**Set fidelity:** 0.9581 (6 overhangs, 0 in HF set)

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
   (--)                (--) 
```

**Set fidelity:** 0.9999 (2 overhangs, 0 in HF set)

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

| Block name            | Length (nt) | Enzyme type | Gene region                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                 |
| --------------------- | ----------- | ----------- | ----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| bsai_5wt_tile10       | 1629        | BsaI        | 5wt_tile10                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                  |
| bsai_5wt_tile11_sub1  | 1637        | BsaI        | 5wt_tile11_sub1;5wt_tile12_sub1;5wt_tile13_sub1;5wt_tile14_sub1;5wt_tile15_sub1;5wt_tile16_sub1;5wt_tile17_sub1;5wt_tile18_sub1;5wt_tile19_sub1;5wt_tile20_sub1;5wt_tile21_sub1;5wt_tile22_sub1;5wt_tile23_sub1;5wt_tile24_sub1;5wt_tile25_sub1                                                                                                                                                                                                                                                             |
| bsai_5wt_tile11_sub2  | 196         | BsaI        | 5wt_tile11_sub2                                                                                                                                                                                                                                                                                                                                                                                                                                                                                             |
| bsai_5wt_tile12_sub2  | 403         | BsaI        | 5wt_tile12_sub2                                                                                                                                                                                                                                                                                                                                                                                                                                                                                             |
| bsai_5wt_tile13_sub2  | 559         | BsaI        | 5wt_tile13_sub2                                                                                                                                                                                                                                                                                                                                                                                                                                                                                             |
| bsai_5wt_tile14_sub2  | 697         | BsaI        | 5wt_tile14_sub2                                                                                                                                                                                                                                                                                                                                                                                                                                                                                             |
| bsai_5wt_tile15_sub2  | 919         | BsaI        | 5wt_tile15_sub2                                                                                                                                                                                                                                                                                                                                                                                                                                                                                             |
| bsai_5wt_tile16_sub2  | 1102        | BsaI        | 5wt_tile16_sub2                                                                                                                                                                                                                                                                                                                                                                                                                                                                                             |
| bsai_5wt_tile17_sub2  | 1243        | BsaI        | 5wt_tile17_sub2                                                                                                                                                                                                                                                                                                                                                                                                                                                                                             |
| bsai_5wt_tile18_sub2  | 1447        | BsaI        | 5wt_tile18_sub2                                                                                                                                                                                                                                                                                                                                                                                                                                                                                             |
| bsai_5wt_tile19_sub2  | 1549        | BsaI        | 5wt_tile19_sub2                                                                                                                                                                                                                                                                                                                                                                                                                                                                                             |
| bsai_5wt_tile2        | 159         | BsaI        | 5wt_tile2                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                   |
| bsai_5wt_tile20_sub2  | 1717        | BsaI        | 5wt_tile20_sub2                                                                                                                                                                                                                                                                                                                                                                                                                                                                                             |
| bsai_5wt_tile21_sub2  | 1725        | BsaI        | 5wt_tile21_sub2;5wt_tile22_sub2;5wt_tile23_sub2;5wt_tile24_sub2;5wt_tile25_sub2                                                                                                                                                                                                                                                                                                                                                                                                                             |
| bsai_5wt_tile21_sub3  | 205         | BsaI        | 5wt_tile21_sub3                                                                                                                                                                                                                                                                                                                                                                                                                                                                                             |
| bsai_5wt_tile22_sub3  | 334         | BsaI        | 5wt_tile22_sub3                                                                                                                                                                                                                                                                                                                                                                                                                                                                                             |
| bsai_5wt_tile23_sub3  | 532         | BsaI        | 5wt_tile23_sub3                                                                                                                                                                                                                                                                                                                                                                                                                                                                                             |
| bsai_5wt_tile24_sub3  | 709         | BsaI        | 5wt_tile24_sub3                                                                                                                                                                                                                                                                                                                                                                                                                                                                                             |
| bsai_5wt_tile25_sub3  | 540         | BsaI        | 5wt_tile25_sub3                                                                                                                                                                                                                                                                                                                                                                                                                                                                                             |
| bsai_5wt_tile25_sub4  | 397         | BsaI        | 5wt_tile25_sub4                                                                                                                                                                                                                                                                                                                                                                                                                                                                                             |
| bsai_5wt_tile3        | 351         | BsaI        | 5wt_tile3                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                   |
| bsai_5wt_tile4        | 555         | BsaI        | 5wt_tile4                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                   |
| bsai_5wt_tile5        | 777         | BsaI        | 5wt_tile5                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                   |
| bsai_5wt_tile6        | 945         | BsaI        | 5wt_tile6                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                   |
| bsai_5wt_tile7        | 1065        | BsaI        | 5wt_tile7                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                   |
| bsai_5wt_tile8        | 1203        | BsaI        | 5wt_tile8                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                   |
| bsai_5wt_tile9        | 1410        | BsaI        | 5wt_tile9                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                   |
| bsmbi_3wt_tile1_sub1  | 1488        | BsmBI       | 3wt_tile1_sub1                                                                                                                                                                                                                                                                                                                                                                                                                                                                                              |
| bsmbi_3wt_tile1_sub2  | 1725        | BsmBI       | 3wt_tile1_sub2;3wt_tile2_sub2;3wt_tile3_sub2;3wt_tile4_sub2;3wt_tile5_sub2;3wt_tile6_sub2;3wt_tile7_sub2;3wt_tile8_sub2;3wt_tile9_sub1                                                                                                                                                                                                                                                                                                                                                                      |
| bsmbi_3wt_tile1_sub3  | 540         | BsmBI       | 3wt_tile1_sub3;3wt_tile2_sub3;3wt_tile3_sub3;3wt_tile4_sub3;3wt_tile5_sub3;3wt_tile6_sub3;3wt_tile7_sub3;3wt_tile8_sub3;3wt_tile9_sub2;3wt_tile10_sub2;3wt_tile11_sub2;3wt_tile12_sub2;3wt_tile13_sub2;3wt_tile14_sub2;3wt_tile15_sub2;3wt_tile16_sub2;3wt_tile19_sub1                                                                                                                                                                                                                                      |
| bsmbi_3wt_tile1_sub4  | 1655        | BsmBI       | 3wt_polIII_tile1_sub4;3wt_polIII_tile2_sub4;3wt_polIII_tile3_sub4;3wt_polIII_tile4_sub4;3wt_polIII_tile5_sub4;3wt_polIII_tile6_sub4;3wt_polIII_tile7_sub4;3wt_polIII_tile8_sub4;3wt_polIII_tile9_sub3;3wt_polIII_tile10_sub3;3wt_polIII_tile11_sub3;3wt_polIII_tile12_sub3;3wt_polIII_tile13_sub3;3wt_polIII_tile14_sub3;3wt_polIII_tile15_sub3;3wt_polIII_tile16_sub3;3wt_polIII_tile17_sub2;3wt_polIII_tile18_sub2;3wt_polIII_tile19_sub2;3wt_polIII_tile20_sub2;3wt_polIII_tile21_sub2;3wt_polIII_tile22 |
| bsmbi_3wt_tile10_sub1 | 1539        | BsmBI       | 3wt_tile10_sub1                                                                                                                                                                                                                                                                                                                                                                                                                                                                                             |
| bsmbi_3wt_tile11_sub1 | 1332        | BsmBI       | 3wt_tile11_sub1                                                                                                                                                                                                                                                                                                                                                                                                                                                                                             |
| bsmbi_3wt_tile12_sub1 | 1176        | BsmBI       | 3wt_tile12_sub1                                                                                                                                                                                                                                                                                                                                                                                                                                                                                             |
| bsmbi_3wt_tile13_sub1 | 1038        | BsmBI       | 3wt_tile13_sub1                                                                                                                                                                                                                                                                                                                                                                                                                                                                                             |
| bsmbi_3wt_tile14_sub1 | 816         | BsmBI       | 3wt_tile14_sub1                                                                                                                                                                                                                                                                                                                                                                                                                                                                                             |
| bsmbi_3wt_tile15_sub1 | 633         | BsmBI       | 3wt_tile15_sub1                                                                                                                                                                                                                                                                                                                                                                                                                                                                                             |
| bsmbi_3wt_tile16_sub1 | 492         | BsmBI       | 3wt_tile16_sub1                                                                                                                                                                                                                                                                                                                                                                                                                                                                                             |
| bsmbi_3wt_tile17_sub1 | 810         | BsmBI       | 3wt_tile17_sub1                                                                                                                                                                                                                                                                                                                                                                                                                                                                                             |
| bsmbi_3wt_tile18_sub1 | 708         | BsmBI       | 3wt_tile18_sub1                                                                                                                                                                                                                                                                                                                                                                                                                                                                                             |
| bsmbi_3wt_tile2_sub1  | 1296        | BsmBI       | 3wt_tile2_sub1                                                                                                                                                                                                                                                                                                                                                                                                                                                                                              |
| bsmbi_3wt_tile20_sub1 | 345         | BsmBI       | 3wt_tile20_sub1                                                                                                                                                                                                                                                                                                                                                                                                                                                                                             |
| bsmbi_3wt_tile21_sub1 | 216         | BsmBI       | 3wt_tile21_sub1                                                                                                                                                                                                                                                                                                                                                                                                                                                                                             |
| bsmbi_3wt_tile23      | 1478        | BsmBI       | 3wt_polIII_tile23                                                                                                                                                                                                                                                                                                                                                                                                                                                                                           |
| bsmbi_3wt_tile24      | 1268        | BsmBI       | 3wt_polIII_tile24                                                                                                                                                                                                                                                                                                                                                                                                                                                                                           |
| bsmbi_3wt_tile3_sub1  | 1092        | BsmBI       | 3wt_tile3_sub1                                                                                                                                                                                                                                                                                                                                                                                                                                                                                              |
| bsmbi_3wt_tile4_sub1  | 870         | BsmBI       | 3wt_tile4_sub1                                                                                                                                                                                                                                                                                                                                                                                                                                                                                              |
| bsmbi_3wt_tile5_sub1  | 702         | BsmBI       | 3wt_tile5_sub1                                                                                                                                                                                                                                                                                                                                                                                                                                                                                              |
| bsmbi_3wt_tile6_sub1  | 582         | BsmBI       | 3wt_tile6_sub1                                                                                                                                                                                                                                                                                                                                                                                                                                                                                              |
| bsmbi_3wt_tile7_sub1  | 444         | BsmBI       | 3wt_tile7_sub1                                                                                                                                                                                                                                                                                                                                                                                                                                                                                              |
| bsmbi_3wt_tile8_sub1  | 237         | BsmBI       | 3wt_tile8_sub1                                                                                                                                                                                                                                                                                                                                                                                                                                                                                              |
| bsmbi_polIII_tile25   | 1112        | BsmBI       | polIII_tile25                                                                                                                                                                                                                                                                                                                                                                                                                                                                                               |

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

