# DMS-GG Assembly Report: GRIN2A

Generated: 2026-03-07 18:26:00
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
| Oligo length range   | 179-290 nt                                                                     |
| Gene blocks to order | 54                                                                             |
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

**Total oligos:** 306810 | **Length range:** 179-290 nt

| Tile | Codons    | Oligos | Length |
| ---- | --------- | ------ | ------ |
| 1    | 1-77      | 15330  | 287 nt |
| 2    | 74-148    | 14910  | 281 nt |
| 3    | 145-217   | 14490  | 275 nt |
| 4    | 214-283   | 13860  | 266 nt |
| 5    | 280-353   | 14700  | 278 nt |
| 6    | 350-399   | 9660   | 206 nt |
| 7    | 396-468   | 14490  | 275 nt |
| 8    | 465-533   | 13650  | 263 nt |
| 9    | 530-600   | 14070  | 269 nt |
| 10   | 597-672   | 15120  | 284 nt |
| 11   | 669-713   | 8610   | 191 nt |
| 12   | 710-770   | 11970  | 239 nt |
| 13   | 767-844   | 15540  | 290 nt |
| 14   | 841-883   | 8190   | 185 nt |
| 15   | 880-927   | 9240   | 200 nt |
| 16   | 924-983   | 11760  | 236 nt |
| 17   | 980-1020  | 7770   | 179 nt |
| 18   | 1017-1081 | 12810  | 251 nt |
| 19   | 1078-1131 | 10500  | 218 nt |
| 20   | 1128-1175 | 9240   | 200 nt |
| 21   | 1172-1218 | 9030   | 197 nt |
| 22   | 1215-1284 | 13860  | 266 nt |
| 23   | 1281-1355 | 14910  | 281 nt |
| 24   | 1352-1413 | 12180  | 242 nt |
| 25   | 1410-1465 | 10920  | 224 nt |

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
| oligo_lengths          | All oligos within synthesis length limit                      | PASS   | Range: 179-290 nt (limit: 300)                                                                                                                      |
| block_lengths          | All gene blocks within synthesis length limit                 | FAIL   | Range: 150-1987 nt (limit: 1800)                                                                                                                    |
| barcode_junction_sites | No enzyme sites at barcode-context junctions                  | PASS   | 0 barcode(s) with junction enzyme sites (left='CAAGAA', right='AAATTG')                                                                             |
| barcode_uniqueness     | All barcodes are unique                                       | PASS   | 306810 unique / 306810 total                                                                                                                        |
| tile_coverage          | Tiles cover entire gene without gaps                          | PASS   | 4395 / 4395 nt covered                                                                                                                              |
| variant_count          | Expected number of variants generated                         | PASS   | 30681 unique variants (expected: 30681 across 1461/1463 mutable positions; 27759 missense + 1461 nonsense + 1461 wt_control; 2 position(s) skipped) |
| single_codon_change    | Each non-control variant differs by exactly one codon from WT | PASS   | 292200 / 292200 variants confirmed (WT controls excluded)                                                                                           |
| oligo_gc_content       | Oligo GC content within reasonable range (25-75%)             | PASS   | GC range: 38.7-66.2% | 0 oligo(s) with extreme GC                                                                                                   |
| domestication_complete | Gene domesticated for all 3 enzymes (BsaI, BsmBI, PaqCI)      | PASS   | No enzyme sites in gene                                                                                                                             |
| overhang_fidelity      | Tile boundary overhangs have adequate fidelity                | FAIL   | 21 tile(s) with low-fidelity boundary overhangs (<0.80)                                                                                             |
| tile_manifests         | Per-tile assembly manifests complete                          | PASS   | 25 tile manifest(s) generated                                                                                                                       |
| helper_plasmid         | Helper plasmid free of unintended BsmBI sites                 | PASS   | OK                                                                                                                                                  |
| reaction_fidelity      | Per-reaction set-level overhang fidelity                      | PASS   | Min set fidelity: 0.8746 across 50 reactions | 3 reaction(s) below 0.90                                                                             |
| barcode_poliii_term    | No barcodes contain PolIII terminator signal (TTTT)           | PASS   | 0 / 306810 barcode(s) contain TTTT                                                                                                                  |
| block_min_length       | All gene blocks above synthesis minimum length                | FAIL   | 3 block(s) below 300 nt minimum. Range: 150-1987 nt                                                                                                 |
| sb_overhang_collisions | Superblock boundary overhangs are unique (no collisions)      | PASS   | 3 SB boundary OH(s), all unique                                                                                                                     |

## 5b. Reaction Fidelity Summary

Set fidelity for each tile's BsaI and BsmBI reactions,
computed from the actual block overhangs after construction:

| Tile | BsaI OHs | BsaI Set Fidelity | BsmBI OHs | BsmBI Set Fidelity |
| ---- | -------- | ----------------- | --------- | ------------------ |
| 1    | 2        | 1.0000            | 5         | 0.9628             |
| 2    | 3        | 0.8940            | 5         | 0.9468             |
| 3    | 3        | 1.0000            | 5         | 0.8853             |
| 4    | 3        | 1.0000            | 5         | 0.9384             |
| 5    | 3        | 1.0000            | 5         | 0.9048             |
| 6    | 3        | 1.0000            | 5         | 0.9628             |
| 7    | 3        | 1.0000            | 4         | 0.9628             |
| 8    | 3        | 1.0000            | 4         | 0.9628             |
| 9    | 3        | 1.0000            | 4         | 0.9628             |
| 10   | 4        | 1.0000            | 4         | 0.9628             |
| 11   | 4        | 0.9837            | 3         | 0.9380             |
| 12   | 4        | 1.0000            | 3         | 0.9628             |
| 13   | 4        | 0.9952            | 3         | 0.9628             |
| 14   | 4        | 1.0000            | 3         | 0.9628             |
| 15   | 5        | 1.0000            | 3         | 0.9628             |
| 16   | 5        | 1.0000            | 3         | 0.9524             |
| 17   | 5        | 1.0000            | 3         | 0.9628             |
| 18   | 5        | 0.9755            | 3         | 0.9628             |
| 19   | 5        | 1.0000            | 3         | 0.8746             |
| 20   | 5        | 1.0000            | 3         | 0.9543             |
| 21   | 5        | 1.0000            | 3         | 0.9911             |
| 22   | 5        | 1.0000            | 2         | 1.0000             |
| 23   | 6        | 1.0000            | 2         | 1.0000             |
| 24   | 6        | 1.0000            | 2         | 1.0000             |
| 25   | 6        | 0.9852            | 2         | 1.0000             |

**Min:** 0.8746 | **Max:** 1.0000 | **Mean:** 0.9755

**Warning:** 3 reaction(s) below 0.90 fidelity — consider alternative split points or overhang reassignment.
## 6. Fixed Overhangs & Helper Plasmid

These overhangs are the same across all tile reactions:

| Overhang    | Sequence | Role                                                    |
| ----------- | -------- | ------------------------------------------------------- |
| oh_L        | ATGG     | Gene start (BsaI, all tiles)                            |
| oh3         | AGAA     | Downstream cassette-barcode junction (BsmBI, all tiles) |
| oh4         | AAAT     | Barcode-helper junction (BsaI, all tiles)               |
| paqci_star2 | AATG     | PaqCI 5' end of insert (Level 2)                        |
| paqci_star1 | GCTA     | PaqCI 3' end of insert (Level 2)                        |

### Helper Plasmid Insert

The helper plasmid provides the backbone for each BsaI Level 1 reaction.

```
[PaqCI**]--[BsaI>>ATGG]--STUFFER--[AAAT<<BsaI]--[PaqCI*]
```

Insert length: 72 nt
oh_L = ATGG (first 4 nt of gene)
oh_R = AAAT (= oh4, barcode-helper junction)

## 7. Per-Tile Assembly Guide

### Tile 1 of 25 -- Codons 1-77 (231 nt)

**Boundary overhangs:**

| Position          | Sequence | Fidelity |
| ----------------- | -------- | -------- |
| oh1 (5' boundary) | ATGG     | 0.5393   |
| oh2 (3' boundary) | CACC     | 0.4172   |

**Variants:** 15330 mutations, 15330 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name                          | Length | 5' OH | 3' OH |
| --- | --------------- | ---------------------------------- | ------ | ----- | ----- |
| 1   | 5'WT gene block | (none -- tile starts at gene nt 1) | --     | --    | --    |
| 2   | Oligo pool      | Tile 1 (15330 oligos)              | 287 nt | ATGG  | AAAT  |
| 3   | Helper plasmid  | helper_plasmid_insert              | --     | --    | --    |
| 4   | Enzyme + buffer | BsaI-HFv2 + CutSmart               | --     | --    | --    |

```
  [ATGG]----oligo+BC----[AAAT]
   ATGG                  AAAT 
```

**Set fidelity:** 1.0000 (2 overhangs)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------ | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)      | --      | --    | --    |
| 2   | 3'WT block        | bsmbi_3wt_tile1_sub1     | 1386 nt | CACC  | AATC  |
| 3   | 3'WT block        | bsmbi_3wt_tile1_sub2     | 729 nt  | AATC  | TCCT  |
| 4   | 3'WT block        | bsmbi_3wt_tile1_sub3     | 1233 nt | TCCT  | TGAA  |
| 5   | 3'WT+PolIII block | bsmbi_3wt_tile1_sub4     | 1987 nt | TGAA  | AGAA  |
| 6   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1 | --      | --    | --    |

```
  [CACC]----3'WT sub1----[AATC]----3'WT sub2----[TCCT]----3'WT sub3----[TGAA]----3'WT+PolIII sub4----[AGAA]
   CACC                   AATC                   TCCT                   TGAA                          AGAA 
```

**Set fidelity:** 0.9628 (5 overhangs)

---

### Tile 2 of 25 -- Codons 74-148 (225 nt)

**Boundary overhangs:**

| Position          | Sequence | Fidelity |
| ----------------- | -------- | -------- |
| oh1 (5' boundary) | ATGA     | 0.7549   |
| oh2 (3' boundary) | TGGA     | 0.7377   |

**Variants:** 14910 mutations, 14910 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name             | Length | 5' OH | 3' OH |
| --- | --------------- | --------------------- | ------ | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile2        | 237 nt | ATGG  | ATGA  |
| 2   | Oligo pool      | Tile 2 (14910 oligos) | 281 nt | ATGA  | AAAT  |
| 3   | Helper plasmid  | helper_plasmid_insert | --     | --    | --    |
| 4   | Enzyme + buffer | BsaI-HFv2 + CutSmart  | --     | --    | --    |

```
  [ATGG]----5'WT block----[ATGA]----oligo+BC----[AAAT]
   ATGG                    ATGA                  AAAT 
```

**Set fidelity:** 0.8940 (3 overhangs)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------ | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)      | --      | --    | --    |
| 2   | 3'WT block        | bsmbi_3wt_tile2_sub1     | 1173 nt | TGGA  | AATC  |
| 3   | 3'WT block        | bsmbi_3wt_tile1_sub2     | 729 nt  | AATC  | TCCT  |
| 4   | 3'WT block        | bsmbi_3wt_tile1_sub3     | 1233 nt | TCCT  | TGAA  |
| 5   | 3'WT+PolIII block | bsmbi_3wt_tile1_sub4     | 1987 nt | TGAA  | AGAA  |
| 6   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1 | --      | --    | --    |

```
  [TGGA]----3'WT sub1----[AATC]----3'WT sub2----[TCCT]----3'WT sub3----[TGAA]----3'WT+PolIII sub4----[AGAA]
   TGGA                   AATC                   TCCT                   TGAA                          AGAA 
```

**Set fidelity:** 0.9468 (5 overhangs)

---

### Tile 3 of 25 -- Codons 145-217 (219 nt)

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
| 1   | 5'WT gene block | bsai_5wt_tile3        | 450 nt | ATGG  | TTCC  |
| 2   | Oligo pool      | Tile 3 (14490 oligos) | 275 nt | TTCC  | AAAT  |
| 3   | Helper plasmid  | helper_plasmid_insert | --     | --    | --    |
| 4   | Enzyme + buffer | BsaI-HFv2 + CutSmart  | --     | --    | --    |

```
  [ATGG]----5'WT block----[TTCC]----oligo+BC----[AAAT]
   ATGG                    TTCC                  AAAT 
```

**Set fidelity:** 1.0000 (3 overhangs)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------ | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)      | --      | --    | --    |
| 2   | 3'WT block        | bsmbi_3wt_tile3_sub1     | 966 nt  | AGTC  | AATC  |
| 3   | 3'WT block        | bsmbi_3wt_tile1_sub2     | 729 nt  | AATC  | TCCT  |
| 4   | 3'WT block        | bsmbi_3wt_tile1_sub3     | 1233 nt | TCCT  | TGAA  |
| 5   | 3'WT+PolIII block | bsmbi_3wt_tile1_sub4     | 1987 nt | TGAA  | AGAA  |
| 6   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1 | --      | --    | --    |

```
  [AGTC]----3'WT sub1----[AATC]----3'WT sub2----[TCCT]----3'WT sub3----[TGAA]----3'WT+PolIII sub4----[AGAA]
   AGTC                   AATC                   TCCT                   TGAA                          AGAA 
```

**Set fidelity:** 0.8853 (5 overhangs)

---

### Tile 4 of 25 -- Codons 214-283 (210 nt)

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
| 1   | 5'WT gene block | bsai_5wt_tile4        | 657 nt | ATGG  | AAGA  |
| 2   | Oligo pool      | Tile 4 (13860 oligos) | 266 nt | AAGA  | AAAT  |
| 3   | Helper plasmid  | helper_plasmid_insert | --     | --    | --    |
| 4   | Enzyme + buffer | BsaI-HFv2 + CutSmart  | --     | --    | --    |

```
  [ATGG]----5'WT block----[AAGA]----oligo+BC----[AAAT]
   ATGG                    AAGA                  AAAT 
```

**Set fidelity:** 1.0000 (3 overhangs)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------ | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)      | --      | --    | --    |
| 2   | 3'WT block        | bsmbi_3wt_tile4_sub1     | 768 nt  | TGAC  | AATC  |
| 3   | 3'WT block        | bsmbi_3wt_tile1_sub2     | 729 nt  | AATC  | TCCT  |
| 4   | 3'WT block        | bsmbi_3wt_tile1_sub3     | 1233 nt | TCCT  | TGAA  |
| 5   | 3'WT+PolIII block | bsmbi_3wt_tile1_sub4     | 1987 nt | TGAA  | AGAA  |
| 6   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1 | --      | --    | --    |

```
  [TGAC]----3'WT sub1----[AATC]----3'WT sub2----[TCCT]----3'WT sub3----[TGAA]----3'WT+PolIII sub4----[AGAA]
   TGAC                   AATC                   TCCT                   TGAA                          AGAA 
```

**Set fidelity:** 0.9384 (5 overhangs)

---

### Tile 5 of 25 -- Codons 280-353 (222 nt)

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
| 1   | 5'WT gene block | bsai_5wt_tile5        | 855 nt | ATGG  | TCCT  |
| 2   | Oligo pool      | Tile 5 (14700 oligos) | 278 nt | TCCT  | AAAT  |
| 3   | Helper plasmid  | helper_plasmid_insert | --     | --    | --    |
| 4   | Enzyme + buffer | BsaI-HFv2 + CutSmart  | --     | --    | --    |

```
  [ATGG]----5'WT block----[TCCT]----oligo+BC----[AAAT]
   ATGG                    TCCT                  AAAT 
```

**Set fidelity:** 1.0000 (3 overhangs)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------ | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)      | --      | --    | --    |
| 2   | 3'WT block        | bsmbi_3wt_tile5_sub1     | 558 nt  | GGAA  | AATC  |
| 3   | 3'WT block        | bsmbi_3wt_tile1_sub2     | 729 nt  | AATC  | TCCT  |
| 4   | 3'WT block        | bsmbi_3wt_tile1_sub3     | 1233 nt | TCCT  | TGAA  |
| 5   | 3'WT+PolIII block | bsmbi_3wt_tile1_sub4     | 1987 nt | TGAA  | AGAA  |
| 6   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1 | --      | --    | --    |

```
  [GGAA]----3'WT sub1----[AATC]----3'WT sub2----[TCCT]----3'WT sub3----[TGAA]----3'WT+PolIII sub4----[AGAA]
   GGAA                   AATC                   TCCT                   TGAA                          AGAA 
```

**Set fidelity:** 0.9048 (5 overhangs)

---

### Tile 6 of 25 -- Codons 350-399 (150 nt)

**Boundary overhangs:**

| Position          | Sequence | Fidelity |
| ----------------- | -------- | -------- |
| oh1 (5' boundary) | TTCA     | 0.8824   |
| oh2 (3' boundary) | CTGT     | 0.6476   |

**Variants:** 9660 mutations, 9660 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name             | Length  | 5' OH | 3' OH |
| --- | --------------- | --------------------- | ------- | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile6        | 1065 nt | ATGG  | TTCA  |
| 2   | Oligo pool      | Tile 6 (9660 oligos)  | 206 nt  | TTCA  | AAAT  |
| 3   | Helper plasmid  | helper_plasmid_insert | --      | --    | --    |
| 4   | Enzyme + buffer | BsaI-HFv2 + CutSmart  | --      | --    | --    |

```
  [ATGG]----5'WT block----[TTCA]----oligo+BC----[AAAT]
   ATGG                    TTCA                  AAAT 
```

**Set fidelity:** 1.0000 (3 overhangs)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------ | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)      | --      | --    | --    |
| 2   | 3'WT block        | bsmbi_3wt_tile6_sub1     | 420 nt  | CTGT  | AATC  |
| 3   | 3'WT block        | bsmbi_3wt_tile1_sub2     | 729 nt  | AATC  | TCCT  |
| 4   | 3'WT block        | bsmbi_3wt_tile1_sub3     | 1233 nt | TCCT  | TGAA  |
| 5   | 3'WT+PolIII block | bsmbi_3wt_tile1_sub4     | 1987 nt | TGAA  | AGAA  |
| 6   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1 | --      | --    | --    |

```
  [CTGT]----3'WT sub1----[AATC]----3'WT sub2----[TCCT]----3'WT sub3----[TGAA]----3'WT+PolIII sub4----[AGAA]
   CTGT                   AATC                   TCCT                   TGAA                          AGAA 
```

**Set fidelity:** 0.9628 (5 overhangs)

---

### Tile 7 of 25 -- Codons 396-468 (219 nt)

**Boundary overhangs:**

| Position          | Sequence | Fidelity |
| ----------------- | -------- | -------- |
| oh1 (5' boundary) | TTCT     | 0.8181   |
| oh2 (3' boundary) | TTCC     | 0.7958   |

**Variants:** 14490 mutations, 14490 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name             | Length  | 5' OH | 3' OH |
| --- | --------------- | --------------------- | ------- | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile7        | 1203 nt | ATGG  | TTCT  |
| 2   | Oligo pool      | Tile 7 (14490 oligos) | 275 nt  | TTCT  | AAAT  |
| 3   | Helper plasmid  | helper_plasmid_insert | --      | --    | --    |
| 4   | Enzyme + buffer | BsaI-HFv2 + CutSmart  | --      | --    | --    |

```
  [ATGG]----5'WT block----[TTCT]----oligo+BC----[AAAT]
   ATGG                    TTCT                  AAAT 
```

**Set fidelity:** 1.0000 (3 overhangs)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------ | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)      | --      | --    | --    |
| 2   | 3'WT block        | bsmbi_3wt_tile7_sub1     | 924 nt  | TTCC  | TCCT  |
| 3   | 3'WT block        | bsmbi_3wt_tile1_sub3     | 1233 nt | TCCT  | TGAA  |
| 4   | 3'WT+PolIII block | bsmbi_3wt_tile1_sub4     | 1987 nt | TGAA  | AGAA  |
| 5   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1 | --      | --    | --    |

```
  [TTCC]----3'WT sub1----[TCCT]----3'WT sub2----[TGAA]----3'WT+PolIII sub3----[AGAA]
   TTCC                   TCCT                   TGAA                          AGAA 
```

**Set fidelity:** 0.9628 (4 overhangs)

---

### Tile 8 of 25 -- Codons 465-533 (207 nt)

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
| 1   | 5'WT gene block | bsai_5wt_tile8        | 1410 nt | ATGG  | AAGA  |
| 2   | Oligo pool      | Tile 8 (13650 oligos) | 263 nt  | AAGA  | AAAT  |
| 3   | Helper plasmid  | helper_plasmid_insert | --      | --    | --    |
| 4   | Enzyme + buffer | BsaI-HFv2 + CutSmart  | --      | --    | --    |

```
  [ATGG]----5'WT block----[AAGA]----oligo+BC----[AAAT]
   ATGG                    AAGA                  AAAT 
```

**Set fidelity:** 1.0000 (3 overhangs)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------ | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)      | --      | --    | --    |
| 2   | 3'WT block        | bsmbi_3wt_tile1_sub2     | 729 nt  | AATC  | TCCT  |
| 3   | 3'WT block        | bsmbi_3wt_tile1_sub3     | 1233 nt | TCCT  | TGAA  |
| 4   | 3'WT+PolIII block | bsmbi_3wt_tile1_sub4     | 1987 nt | TGAA  | AGAA  |
| 5   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1 | --      | --    | --    |

```
  [AATC]----3'WT sub1----[TCCT]----3'WT sub2----[TGAA]----3'WT+PolIII sub3----[AGAA]
   AATC                   TCCT                   TGAA                          AGAA 
```

**Set fidelity:** 0.9628 (4 overhangs)

---

### Tile 9 of 25 -- Codons 530-600 (213 nt)

**Boundary overhangs:**

| Position          | Sequence | Fidelity |
| ----------------- | -------- | -------- |
| oh1 (5' boundary) | GAAA     | 0.8745   |
| oh2 (3' boundary) | TACA     | 0.8652   |

**Variants:** 14070 mutations, 14070 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name             | Length  | 5' OH | 3' OH |
| --- | --------------- | --------------------- | ------- | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile9        | 1605 nt | ATGG  | GAAA  |
| 2   | Oligo pool      | Tile 9 (14070 oligos) | 269 nt  | GAAA  | AAAT  |
| 3   | Helper plasmid  | helper_plasmid_insert | --      | --    | --    |
| 4   | Enzyme + buffer | BsaI-HFv2 + CutSmart  | --      | --    | --    |

```
  [ATGG]----5'WT block----[GAAA]----oligo+BC----[AAAT]
   ATGG                    GAAA                  AAAT 
```

**Set fidelity:** 1.0000 (3 overhangs)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------ | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)      | --      | --    | --    |
| 2   | 3'WT block        | bsmbi_3wt_tile9_sub1     | 528 nt  | TACA  | TCCT  |
| 3   | 3'WT block        | bsmbi_3wt_tile1_sub3     | 1233 nt | TCCT  | TGAA  |
| 4   | 3'WT+PolIII block | bsmbi_3wt_tile1_sub4     | 1987 nt | TGAA  | AGAA  |
| 5   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1 | --      | --    | --    |

```
  [TACA]----3'WT sub1----[TCCT]----3'WT sub2----[TGAA]----3'WT+PolIII sub3----[AGAA]
   TACA                   TCCT                   TGAA                          AGAA 
```

**Set fidelity:** 0.9628 (4 overhangs)

---

### Tile 10 of 25 -- Codons 597-672 (228 nt)

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
| 1   | 5'WT gene block | bsai_5wt_tile10_sub1   | 1613 nt | ATGG  | AATC  |
| 2   | 5'WT gene block | bsai_5wt_tile10_sub2   | 211 nt  | AATC  | CCTT  |
| 3   | Oligo pool      | Tile 10 (15120 oligos) | 284 nt  | CCTT  | AAAT  |
| 4   | Helper plasmid  | helper_plasmid_insert  | --      | --    | --    |
| 5   | Enzyme + buffer | BsaI-HFv2 + CutSmart   | --      | --    | --    |

```
  [ATGG]----5'WT sub1----[AATC]----5'WT sub2----[CCTT]----oligo+BC----[AAAT]
   ATGG                   AATC                   CCTT                  AAAT 
```

**Set fidelity:** 1.0000 (4 overhangs)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------ | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)      | --      | --    | --    |
| 2   | 3'WT block        | bsmbi_3wt_tile10_sub1    | 312 nt  | AAGA  | TCCT  |
| 3   | 3'WT block        | bsmbi_3wt_tile1_sub3     | 1233 nt | TCCT  | TGAA  |
| 4   | 3'WT+PolIII block | bsmbi_3wt_tile1_sub4     | 1987 nt | TGAA  | AGAA  |
| 5   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1 | --      | --    | --    |

```
  [AAGA]----3'WT sub1----[TCCT]----3'WT sub2----[TGAA]----3'WT+PolIII sub3----[AGAA]
   AAGA                   TCCT                   TGAA                          AGAA 
```

**Set fidelity:** 0.9628 (4 overhangs)

---

### Tile 11 of 25 -- Codons 669-713 (135 nt)

**Boundary overhangs:**

| Position          | Sequence | Fidelity |
| ----------------- | -------- | -------- |
| oh1 (5' boundary) | AAGT     | 0.7629   |
| oh2 (3' boundary) | AGTA     | 0.7286   |

**Variants:** 8610 mutations, 8610 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name             | Length  | 5' OH | 3' OH |
| --- | --------------- | --------------------- | ------- | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile10_sub1  | 1613 nt | ATGG  | AATC  |
| 2   | 5'WT gene block | bsai_5wt_tile11_sub2  | 427 nt  | AATC  | AAGT  |
| 3   | Oligo pool      | Tile 11 (8610 oligos) | 191 nt  | AAGT  | AAAT  |
| 4   | Helper plasmid  | helper_plasmid_insert | --      | --    | --    |
| 5   | Enzyme + buffer | BsaI-HFv2 + CutSmart  | --      | --    | --    |

```
  [ATGG]----5'WT sub1----[AATC]----5'WT sub2----[AAGT]----oligo+BC----[AAAT]
   ATGG                   AATC                   AAGT                  AAAT 
```

**Set fidelity:** 0.9837 (4 overhangs)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------ | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)      | --      | --    | --    |
| 2   | 3'WT block        | bsmbi_3wt_tile11_sub1    | 1404 nt | AGTA  | TGAA  |
| 3   | 3'WT+PolIII block | bsmbi_3wt_tile1_sub4     | 1987 nt | TGAA  | AGAA  |
| 4   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1 | --      | --    | --    |

```
  [AGTA]----3'WT sub1----[TGAA]----3'WT+PolIII sub2----[AGAA]
   AGTA                   TGAA                          AGAA 
```

**Set fidelity:** 0.9380 (3 overhangs)

---

### Tile 12 of 25 -- Codons 710-770 (183 nt)

**Boundary overhangs:**

| Position          | Sequence | Fidelity |
| ----------------- | -------- | -------- |
| oh1 (5' boundary) | CAGA     | 0.8175   |
| oh2 (3' boundary) | TCCT     | 0.7573   |

**Variants:** 11970 mutations, 11970 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name              | Length  | 5' OH | 3' OH |
| --- | --------------- | ---------------------- | ------- | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile10_sub1   | 1613 nt | ATGG  | AATC  |
| 2   | 5'WT gene block | bsai_5wt_tile12_sub2   | 550 nt  | AATC  | CAGA  |
| 3   | Oligo pool      | Tile 12 (11970 oligos) | 239 nt  | CAGA  | AAAT  |
| 4   | Helper plasmid  | helper_plasmid_insert  | --      | --    | --    |
| 5   | Enzyme + buffer | BsaI-HFv2 + CutSmart   | --      | --    | --    |

```
  [ATGG]----5'WT sub1----[AATC]----5'WT sub2----[CAGA]----oligo+BC----[AAAT]
   ATGG                   AATC                   CAGA                  AAAT 
```

**Set fidelity:** 1.0000 (4 overhangs)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------ | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)      | --      | --    | --    |
| 2   | 3'WT block        | bsmbi_3wt_tile1_sub3     | 1233 nt | TCCT  | TGAA  |
| 3   | 3'WT+PolIII block | bsmbi_3wt_tile1_sub4     | 1987 nt | TGAA  | AGAA  |
| 4   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1 | --      | --    | --    |

```
  [TCCT]----3'WT sub1----[TGAA]----3'WT+PolIII sub2----[AGAA]
   TCCT                   TGAA                          AGAA 
```

**Set fidelity:** 0.9628 (3 overhangs)

---

### Tile 13 of 25 -- Codons 767-844 (234 nt)

**Boundary overhangs:**

| Position          | Sequence | Fidelity |
| ----------------- | -------- | -------- |
| oh1 (5' boundary) | AAAG     | 0.7511   |
| oh2 (3' boundary) | GAAG     | 0.6752   |

**Variants:** 15540 mutations, 15540 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name              | Length  | 5' OH | 3' OH |
| --- | --------------- | ---------------------- | ------- | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile10_sub1   | 1613 nt | ATGG  | AATC  |
| 2   | 5'WT gene block | bsai_5wt_tile13_sub2   | 721 nt  | AATC  | AAAG  |
| 3   | Oligo pool      | Tile 13 (15540 oligos) | 290 nt  | AAAG  | AAAT  |
| 4   | Helper plasmid  | helper_plasmid_insert  | --      | --    | --    |
| 5   | Enzyme + buffer | BsaI-HFv2 + CutSmart   | --      | --    | --    |

```
  [ATGG]----5'WT sub1----[AATC]----5'WT sub2----[AAAG]----oligo+BC----[AAAT]
   ATGG                   AATC                   AAAG                  AAAT 
```

**Set fidelity:** 0.9952 (4 overhangs)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------ | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)      | --      | --    | --    |
| 2   | 3'WT block        | bsmbi_3wt_tile13_sub1    | 1011 nt | GAAG  | TGAA  |
| 3   | 3'WT+PolIII block | bsmbi_3wt_tile1_sub4     | 1987 nt | TGAA  | AGAA  |
| 4   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1 | --      | --    | --    |

```
  [GAAG]----3'WT sub1----[TGAA]----3'WT+PolIII sub2----[AGAA]
   GAAG                   TGAA                          AGAA 
```

**Set fidelity:** 0.9628 (3 overhangs)

---

### Tile 14 of 25 -- Codons 841-883 (129 nt)

**Boundary overhangs:**

| Position          | Sequence | Fidelity |
| ----------------- | -------- | -------- |
| oh1 (5' boundary) | TTCT     | 0.8181   |
| oh2 (3' boundary) | TCCA     | 0.8519   |

**Variants:** 8190 mutations, 8190 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name             | Length  | 5' OH | 3' OH |
| --- | --------------- | --------------------- | ------- | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile10_sub1  | 1613 nt | ATGG  | AATC  |
| 2   | 5'WT gene block | bsai_5wt_tile14_sub2  | 943 nt  | AATC  | TTCT  |
| 3   | Oligo pool      | Tile 14 (8190 oligos) | 185 nt  | TTCT  | AAAT  |
| 4   | Helper plasmid  | helper_plasmid_insert | --      | --    | --    |
| 5   | Enzyme + buffer | BsaI-HFv2 + CutSmart  | --      | --    | --    |

```
  [ATGG]----5'WT sub1----[AATC]----5'WT sub2----[TTCT]----oligo+BC----[AAAT]
   ATGG                   AATC                   TTCT                  AAAT 
```

**Set fidelity:** 1.0000 (4 overhangs)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------ | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)      | --      | --    | --    |
| 2   | 3'WT block        | bsmbi_3wt_tile14_sub1    | 894 nt  | TCCA  | TGAA  |
| 3   | 3'WT+PolIII block | bsmbi_3wt_tile1_sub4     | 1987 nt | TGAA  | AGAA  |
| 4   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1 | --      | --    | --    |

```
  [TCCA]----3'WT sub1----[TGAA]----3'WT+PolIII sub2----[AGAA]
   TCCA                   TGAA                          AGAA 
```

**Set fidelity:** 0.9628 (3 overhangs)

---

### Tile 15 of 25 -- Codons 880-927 (144 nt)

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
| 1   | 5'WT gene block | bsai_5wt_tile10_sub1  | 1613 nt | ATGG  | AATC  |
| 2   | 5'WT gene block | bsai_5wt_tile15_sub2  | 729 nt  | AATC  | TCCT  |
| 3   | 5'WT gene block | bsai_5wt_tile15_sub3  | 349 nt  | TCCT  | AAGA  |
| 4   | Oligo pool      | Tile 15 (9240 oligos) | 200 nt  | AAGA  | AAAT  |
| 5   | Helper plasmid  | helper_plasmid_insert | --      | --    | --    |
| 6   | Enzyme + buffer | BsaI-HFv2 + CutSmart  | --      | --    | --    |

```
  [ATGG]----5'WT sub1----[AATC]----5'WT sub2----[TCCT]----5'WT sub3----[AAGA]----oligo+BC----[AAAT]
   ATGG                   AATC                   TCCT                   AAGA                  AAAT 
```

**Set fidelity:** 1.0000 (5 overhangs)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------ | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)      | --      | --    | --    |
| 2   | 3'WT block        | bsmbi_3wt_tile15_sub1    | 762 nt  | AAGA  | TGAA  |
| 3   | 3'WT+PolIII block | bsmbi_3wt_tile1_sub4     | 1987 nt | TGAA  | AGAA  |
| 4   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1 | --      | --    | --    |

```
  [AAGA]----3'WT sub1----[TGAA]----3'WT+PolIII sub2----[AGAA]
   AAGA                   TGAA                          AGAA 
```

**Set fidelity:** 0.9628 (3 overhangs)

---

### Tile 16 of 25 -- Codons 924-983 (180 nt)

**Boundary overhangs:**

| Position          | Sequence | Fidelity |
| ----------------- | -------- | -------- |
| oh1 (5' boundary) | TTCA     | 0.8824   |
| oh2 (3' boundary) | ACAA     | 0.8919   |

**Variants:** 11760 mutations, 11760 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name              | Length  | 5' OH | 3' OH |
| --- | --------------- | ---------------------- | ------- | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile10_sub1   | 1613 nt | ATGG  | AATC  |
| 2   | 5'WT gene block | bsai_5wt_tile15_sub2   | 729 nt  | AATC  | TCCT  |
| 3   | 5'WT gene block | bsai_5wt_tile16_sub3   | 481 nt  | TCCT  | TTCA  |
| 4   | Oligo pool      | Tile 16 (11760 oligos) | 236 nt  | TTCA  | AAAT  |
| 5   | Helper plasmid  | helper_plasmid_insert  | --      | --    | --    |
| 6   | Enzyme + buffer | BsaI-HFv2 + CutSmart   | --      | --    | --    |

```
  [ATGG]----5'WT sub1----[AATC]----5'WT sub2----[TCCT]----5'WT sub3----[TTCA]----oligo+BC----[AAAT]
   ATGG                   AATC                   TCCT                   TTCA                  AAAT 
```

**Set fidelity:** 1.0000 (5 overhangs)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------ | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)      | --      | --    | --    |
| 2   | 3'WT block        | bsmbi_3wt_tile16_sub1    | 594 nt  | ACAA  | TGAA  |
| 3   | 3'WT+PolIII block | bsmbi_3wt_tile1_sub4     | 1987 nt | TGAA  | AGAA  |
| 4   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1 | --      | --    | --    |

```
  [ACAA]----3'WT sub1----[TGAA]----3'WT+PolIII sub2----[AGAA]
   ACAA                   TGAA                          AGAA 
```

**Set fidelity:** 0.9524 (3 overhangs)

---

### Tile 17 of 25 -- Codons 980-1020 (123 nt)

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
| 1   | 5'WT gene block | bsai_5wt_tile10_sub1  | 1613 nt | ATGG  | AATC  |
| 2   | 5'WT gene block | bsai_5wt_tile15_sub2  | 729 nt  | AATC  | TCCT  |
| 3   | 5'WT gene block | bsai_5wt_tile17_sub3  | 649 nt  | TCCT  | TTCC  |
| 4   | Oligo pool      | Tile 17 (7770 oligos) | 179 nt  | TTCC  | AAAT  |
| 5   | Helper plasmid  | helper_plasmid_insert | --      | --    | --    |
| 6   | Enzyme + buffer | BsaI-HFv2 + CutSmart  | --      | --    | --    |

```
  [ATGG]----5'WT sub1----[AATC]----5'WT sub2----[TCCT]----5'WT sub3----[TTCC]----oligo+BC----[AAAT]
   ATGG                   AATC                   TCCT                   TTCC                  AAAT 
```

**Set fidelity:** 1.0000 (5 overhangs)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------ | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)      | --      | --    | --    |
| 2   | 3'WT block        | bsmbi_3wt_tile17_sub1    | 483 nt  | TTCC  | TGAA  |
| 3   | 3'WT+PolIII block | bsmbi_3wt_tile1_sub4     | 1987 nt | TGAA  | AGAA  |
| 4   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1 | --      | --    | --    |

```
  [TTCC]----3'WT sub1----[TGAA]----3'WT+PolIII sub2----[AGAA]
   TTCC                   TGAA                          AGAA 
```

**Set fidelity:** 0.9628 (3 overhangs)

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
| 1   | 5'WT gene block | bsai_5wt_tile10_sub1   | 1613 nt | ATGG  | AATC  |
| 2   | 5'WT gene block | bsai_5wt_tile15_sub2   | 729 nt  | AATC  | TCCT  |
| 3   | 5'WT gene block | bsai_5wt_tile18_sub3   | 760 nt  | TCCT  | TCCG  |
| 4   | Oligo pool      | Tile 18 (12810 oligos) | 251 nt  | TCCG  | AAAT  |
| 5   | Helper plasmid  | helper_plasmid_insert  | --      | --    | --    |
| 6   | Enzyme + buffer | BsaI-HFv2 + CutSmart   | --      | --    | --    |

```
  [ATGG]----5'WT sub1----[AATC]----5'WT sub2----[TCCT]----5'WT sub3----[TCCG]----oligo+BC----[AAAT]
   ATGG                   AATC                   TCCT                   TCCG                  AAAT 
```

**Set fidelity:** 0.9755 (5 overhangs)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------ | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)      | --      | --    | --    |
| 2   | 3'WT block        | bsmbi_3wt_tile18_sub1    | 300 nt  | CAAA  | TGAA  |
| 3   | 3'WT+PolIII block | bsmbi_3wt_tile1_sub4     | 1987 nt | TGAA  | AGAA  |
| 4   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1 | --      | --    | --    |

```
  [CAAA]----3'WT sub1----[TGAA]----3'WT+PolIII sub2----[AGAA]
   CAAA                   TGAA                          AGAA 
```

**Set fidelity:** 0.9628 (3 overhangs)

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
| 1   | 5'WT gene block | bsai_5wt_tile10_sub1   | 1613 nt | ATGG  | AATC  |
| 2   | 5'WT gene block | bsai_5wt_tile15_sub2   | 729 nt  | AATC  | TCCT  |
| 3   | 5'WT gene block | bsai_5wt_tile19_sub3   | 943 nt  | TCCT  | AAGA  |
| 4   | Oligo pool      | Tile 19 (10500 oligos) | 218 nt  | AAGA  | AAAT  |
| 5   | Helper plasmid  | helper_plasmid_insert  | --      | --    | --    |
| 6   | Enzyme + buffer | BsaI-HFv2 + CutSmart   | --      | --    | --    |

```
  [ATGG]----5'WT sub1----[AATC]----5'WT sub2----[TCCT]----5'WT sub3----[AAGA]----oligo+BC----[AAAT]
   ATGG                   AATC                   TCCT                   AAGA                  AAAT 
```

**Set fidelity:** 1.0000 (5 overhangs)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------ | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)      | --      | --    | --    |
| 2   | 3'WT block        | bsmbi_3wt_tile19_sub1    | 150 nt  | AGAT  | TGAA  |
| 3   | 3'WT+PolIII block | bsmbi_3wt_tile1_sub4     | 1987 nt | TGAA  | AGAA  |
| 4   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1 | --      | --    | --    |

```
  [AGAT]----3'WT sub1----[TGAA]----3'WT+PolIII sub2----[AGAA]
   AGAT                   TGAA                          AGAA 
```

**Set fidelity:** 0.8746 (3 overhangs)

---

### Tile 20 of 25 -- Codons 1128-1175 (144 nt)

**Boundary overhangs:**

| Position          | Sequence | Fidelity |
| ----------------- | -------- | -------- |
| oh1 (5' boundary) | TTCC     | 0.7958   |
| oh2 (3' boundary) | TGAA     | 0.8621   |

**Variants:** 9240 mutations, 9240 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name             | Length  | 5' OH | 3' OH |
| --- | --------------- | --------------------- | ------- | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile10_sub1  | 1613 nt | ATGG  | AATC  |
| 2   | 5'WT gene block | bsai_5wt_tile15_sub2  | 729 nt  | AATC  | TCCT  |
| 3   | 5'WT gene block | bsai_5wt_tile20_sub3  | 1093 nt | TCCT  | TTCC  |
| 4   | Oligo pool      | Tile 20 (9240 oligos) | 200 nt  | TTCC  | AAAT  |
| 5   | Helper plasmid  | helper_plasmid_insert | --      | --    | --    |
| 6   | Enzyme + buffer | BsaI-HFv2 + CutSmart  | --      | --    | --    |

```
  [ATGG]----5'WT sub1----[AATC]----5'WT sub2----[TCCT]----5'WT sub3----[TTCC]----oligo+BC----[AAAT]
   ATGG                   AATC                   TCCT                   TTCC                  AAAT 
```

**Set fidelity:** 1.0000 (5 overhangs)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------ | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)      | --      | --    | --    |
| 2   | 3'WT block        | bsmbi_3wt_tile20_sub1    | 513 nt  | TGAA  | AAAA  |
| 3   | 3'WT+PolIII block | bsmbi_3wt_tile20_sub2    | 1492 nt | AAAA  | AGAA  |
| 4   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1 | --      | --    | --    |

```
  [TGAA]----3'WT sub1----[AAAA]----3'WT+PolIII sub2----[AGAA]
   TGAA                   AAAA                          AGAA 
```

**Set fidelity:** 0.9543 (3 overhangs)

---

### Tile 21 of 25 -- Codons 1172-1218 (141 nt)

**Boundary overhangs:**

| Position          | Sequence | Fidelity |
| ----------------- | -------- | -------- |
| oh1 (5' boundary) | TTGC     | 0.7336   |
| oh2 (3' boundary) | CCTT     | 0.6891   |

**Variants:** 9030 mutations, 9030 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name             | Length  | 5' OH | 3' OH |
| --- | --------------- | --------------------- | ------- | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile10_sub1  | 1613 nt | ATGG  | AATC  |
| 2   | 5'WT gene block | bsai_5wt_tile15_sub2  | 729 nt  | AATC  | TCCT  |
| 3   | 5'WT gene block | bsai_5wt_tile21_sub3  | 1225 nt | TCCT  | TTGC  |
| 4   | Oligo pool      | Tile 21 (9030 oligos) | 197 nt  | TTGC  | AAAT  |
| 5   | Helper plasmid  | helper_plasmid_insert | --      | --    | --    |
| 6   | Enzyme + buffer | BsaI-HFv2 + CutSmart  | --      | --    | --    |

```
  [ATGG]----5'WT sub1----[AATC]----5'WT sub2----[TCCT]----5'WT sub3----[TTGC]----oligo+BC----[AAAT]
   ATGG                   AATC                   TCCT                   TTGC                  AAAT 
```

**Set fidelity:** 1.0000 (5 overhangs)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------ | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)      | --      | --    | --    |
| 2   | 3'WT block        | bsmbi_3wt_tile21_sub1    | 384 nt  | CCTT  | AAAA  |
| 3   | 3'WT+PolIII block | bsmbi_3wt_tile20_sub2    | 1492 nt | AAAA  | AGAA  |
| 4   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1 | --      | --    | --    |

```
  [CCTT]----3'WT sub1----[AAAA]----3'WT+PolIII sub2----[AGAA]
   CCTT                   AAAA                          AGAA 
```

**Set fidelity:** 0.9911 (3 overhangs)

---

### Tile 22 of 25 -- Codons 1215-1284 (210 nt)

**Boundary overhangs:**

| Position          | Sequence | Fidelity |
| ----------------- | -------- | -------- |
| oh1 (5' boundary) | AGAA     | 0.8847   |
| oh2 (3' boundary) | GCTA     | 0.5810   |

**Variants:** 13860 mutations, 13860 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name              | Length  | 5' OH | 3' OH |
| --- | --------------- | ---------------------- | ------- | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile10_sub1   | 1613 nt | ATGG  | AATC  |
| 2   | 5'WT gene block | bsai_5wt_tile15_sub2   | 729 nt  | AATC  | TCCT  |
| 3   | 5'WT gene block | bsai_5wt_tile22_sub3   | 1354 nt | TCCT  | AGAA  |
| 4   | Oligo pool      | Tile 22 (13860 oligos) | 266 nt  | AGAA  | AAAT  |
| 5   | Helper plasmid  | helper_plasmid_insert  | --      | --    | --    |
| 6   | Enzyme + buffer | BsaI-HFv2 + CutSmart   | --      | --    | --    |

```
  [ATGG]----5'WT sub1----[AATC]----5'WT sub2----[TCCT]----5'WT sub3----[AGAA]----oligo+BC----[AAAT]
   ATGG                   AATC                   TCCT                   AGAA                  AAAT 
```

**Set fidelity:** 1.0000 (5 overhangs)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------ | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)      | --      | --    | --    |
| 2   | 3'WT+PolIII block | bsmbi_3wt_tile22         | 1660 nt | GCTA  | AGAA  |
| 3   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1 | --      | --    | --    |

```
  [GCTA]----3'WT+PolIII----[AGAA]
   GCTA                     AGAA 
```

**Set fidelity:** 1.0000 (2 overhangs)

---

### Tile 23 of 25 -- Codons 1281-1355 (225 nt)

**Boundary overhangs:**

| Position          | Sequence | Fidelity |
| ----------------- | -------- | -------- |
| oh1 (5' boundary) | AAGA     | 0.9209   |
| oh2 (3' boundary) | CAAG     | 0.6640   |

**Variants:** 14910 mutations, 14910 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name              | Length  | 5' OH | 3' OH |
| --- | --------------- | ---------------------- | ------- | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile10_sub1   | 1613 nt | ATGG  | AATC  |
| 2   | 5'WT gene block | bsai_5wt_tile15_sub2   | 729 nt  | AATC  | TCCT  |
| 3   | 5'WT gene block | bsai_5wt_tile23_sub3   | 1233 nt | TCCT  | TGAA  |
| 4   | 5'WT gene block | bsai_5wt_tile23_sub4   | 337 nt  | TGAA  | AAGA  |
| 5   | Oligo pool      | Tile 23 (14910 oligos) | 281 nt  | AAGA  | AAAT  |
| 6   | Helper plasmid  | helper_plasmid_insert  | --      | --    | --    |
| 7   | Enzyme + buffer | BsaI-HFv2 + CutSmart   | --      | --    | --    |

```
  [ATGG]----5'WT sub1----[AATC]----5'WT sub2----[TCCT]----5'WT sub3----[TGAA]----5'WT sub4----[AAGA]----oligo+BC----[AAAT]
   ATGG                   AATC                   TCCT                   TGAA                   AAGA                  AAAT 
```

**Set fidelity:** 1.0000 (6 overhangs)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------ | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)      | --      | --    | --    |
| 2   | 3'WT+PolIII block | bsmbi_3wt_tile23         | 1447 nt | CAAG  | AGAA  |
| 3   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1 | --      | --    | --    |

```
  [CAAG]----3'WT+PolIII----[AGAA]
   CAAG                     AGAA 
```

**Set fidelity:** 1.0000 (2 overhangs)

---

### Tile 24 of 25 -- Codons 1352-1413 (186 nt)

**Boundary overhangs:**

| Position          | Sequence | Fidelity |
| ----------------- | -------- | -------- |
| oh1 (5' boundary) | AAGA     | 0.9209   |
| oh2 (3' boundary) | TTCC     | 0.7958   |

**Variants:** 12180 mutations, 12180 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name              | Length  | 5' OH | 3' OH |
| --- | --------------- | ---------------------- | ------- | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile10_sub1   | 1613 nt | ATGG  | AATC  |
| 2   | 5'WT gene block | bsai_5wt_tile15_sub2   | 729 nt  | AATC  | TCCT  |
| 3   | 5'WT gene block | bsai_5wt_tile23_sub3   | 1233 nt | TCCT  | TGAA  |
| 4   | 5'WT gene block | bsai_5wt_tile24_sub4   | 550 nt  | TGAA  | AAGA  |
| 5   | Oligo pool      | Tile 24 (12180 oligos) | 242 nt  | AAGA  | AAAT  |
| 6   | Helper plasmid  | helper_plasmid_insert  | --      | --    | --    |
| 7   | Enzyme + buffer | BsaI-HFv2 + CutSmart   | --      | --    | --    |

```
  [ATGG]----5'WT sub1----[AATC]----5'WT sub2----[TCCT]----5'WT sub3----[TGAA]----5'WT sub4----[AAGA]----oligo+BC----[AAAT]
   ATGG                   AATC                   TCCT                   TGAA                   AAGA                  AAAT 
```

**Set fidelity:** 1.0000 (6 overhangs)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------ | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)      | --      | --    | --    |
| 2   | 3'WT+PolIII block | bsmbi_3wt_tile24         | 1273 nt | TTCC  | AGAA  |
| 3   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1 | --      | --    | --    |

```
  [TTCC]----3'WT+PolIII----[AGAA]
   TTCC                     AGAA 
```

**Set fidelity:** 1.0000 (2 overhangs)

---

### Tile 25 of 25 -- Codons 1410-1465 (168 nt)

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
| 1   | 5'WT gene block | bsai_5wt_tile10_sub1   | 1613 nt | ATGG  | AATC  |
| 2   | 5'WT gene block | bsai_5wt_tile15_sub2   | 729 nt  | AATC  | TCCT  |
| 3   | 5'WT gene block | bsai_5wt_tile23_sub3   | 1233 nt | TCCT  | TGAA  |
| 4   | 5'WT gene block | bsai_5wt_tile25_sub4   | 724 nt  | TGAA  | TCGT  |
| 5   | Oligo pool      | Tile 25 (10920 oligos) | 224 nt  | TCGT  | AAAT  |
| 6   | Helper plasmid  | helper_plasmid_insert  | --      | --    | --    |
| 7   | Enzyme + buffer | BsaI-HFv2 + CutSmart   | --      | --    | --    |

```
  [ATGG]----5'WT sub1----[AATC]----5'WT sub2----[TCCT]----5'WT sub3----[TGAA]----5'WT sub4----[TCGT]----oligo+BC----[AAAT]
   ATGG                   AATC                   TCCT                   TGAA                   TCGT                  AAAT 
```

**Set fidelity:** 0.9852 (6 overhangs)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component            | Part name                | Length  | 5' OH | 3' OH |
| --- | -------------------- | ------------------------ | ------- | ----- | ----- |
| 1   | BsaI product         | (in helper plasmid)      | --      | --    | --    |
| 2   | PolIII-only fragment | bsmbi_polIII_tile25      | 1117 nt | TTAA  | AGAA  |
| 3   | Enzyme + buffer      | BsmBI-v2 + NEBuffer r3.1 | --      | --    | --    |

```
  [TTAA]----PolIII----[AGAA]
   TTAA                AGAA 
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

**Total blocks:** 54

| Block name            | Length (nt) | Enzyme type | Gene region                                                                                                                                                                                                                                                                                                                                                                                                                                 |
| --------------------- | ----------- | ----------- | ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| bsai_5wt_tile10_sub1  | 1613        | BsaI        | 5wt_tile10_sub1;5wt_tile11_sub1;5wt_tile12_sub1;5wt_tile13_sub1;5wt_tile14_sub1;5wt_tile15_sub1;5wt_tile16_sub1;5wt_tile17_sub1;5wt_tile18_sub1;5wt_tile19_sub1;5wt_tile20_sub1;5wt_tile21_sub1;5wt_tile22_sub1;5wt_tile23_sub1;5wt_tile24_sub1;5wt_tile25_sub1                                                                                                                                                                             |
| bsai_5wt_tile10_sub2  | 211         | BsaI        | 5wt_tile10_sub2                                                                                                                                                                                                                                                                                                                                                                                                                             |
| bsai_5wt_tile11_sub2  | 427         | BsaI        | 5wt_tile11_sub2                                                                                                                                                                                                                                                                                                                                                                                                                             |
| bsai_5wt_tile12_sub2  | 550         | BsaI        | 5wt_tile12_sub2                                                                                                                                                                                                                                                                                                                                                                                                                             |
| bsai_5wt_tile13_sub2  | 721         | BsaI        | 5wt_tile13_sub2                                                                                                                                                                                                                                                                                                                                                                                                                             |
| bsai_5wt_tile14_sub2  | 943         | BsaI        | 5wt_tile14_sub2                                                                                                                                                                                                                                                                                                                                                                                                                             |
| bsai_5wt_tile15_sub2  | 729         | BsaI        | 5wt_tile15_sub2;5wt_tile16_sub2;5wt_tile17_sub2;5wt_tile18_sub2;5wt_tile19_sub2;5wt_tile20_sub2;5wt_tile21_sub2;5wt_tile22_sub2;5wt_tile23_sub2;5wt_tile24_sub2;5wt_tile25_sub2                                                                                                                                                                                                                                                             |
| bsai_5wt_tile15_sub3  | 349         | BsaI        | 5wt_tile15_sub3                                                                                                                                                                                                                                                                                                                                                                                                                             |
| bsai_5wt_tile16_sub3  | 481         | BsaI        | 5wt_tile16_sub3                                                                                                                                                                                                                                                                                                                                                                                                                             |
| bsai_5wt_tile17_sub3  | 649         | BsaI        | 5wt_tile17_sub3                                                                                                                                                                                                                                                                                                                                                                                                                             |
| bsai_5wt_tile18_sub3  | 760         | BsaI        | 5wt_tile18_sub3                                                                                                                                                                                                                                                                                                                                                                                                                             |
| bsai_5wt_tile19_sub3  | 943         | BsaI        | 5wt_tile19_sub3                                                                                                                                                                                                                                                                                                                                                                                                                             |
| bsai_5wt_tile2        | 237         | BsaI        | 5wt_tile2                                                                                                                                                                                                                                                                                                                                                                                                                                   |
| bsai_5wt_tile20_sub3  | 1093        | BsaI        | 5wt_tile20_sub3                                                                                                                                                                                                                                                                                                                                                                                                                             |
| bsai_5wt_tile21_sub3  | 1225        | BsaI        | 5wt_tile21_sub3                                                                                                                                                                                                                                                                                                                                                                                                                             |
| bsai_5wt_tile22_sub3  | 1354        | BsaI        | 5wt_tile22_sub3                                                                                                                                                                                                                                                                                                                                                                                                                             |
| bsai_5wt_tile23_sub3  | 1233        | BsaI        | 5wt_tile23_sub3;5wt_tile24_sub3;5wt_tile25_sub3                                                                                                                                                                                                                                                                                                                                                                                             |
| bsai_5wt_tile23_sub4  | 337         | BsaI        | 5wt_tile23_sub4                                                                                                                                                                                                                                                                                                                                                                                                                             |
| bsai_5wt_tile24_sub4  | 550         | BsaI        | 5wt_tile24_sub4                                                                                                                                                                                                                                                                                                                                                                                                                             |
| bsai_5wt_tile25_sub4  | 724         | BsaI        | 5wt_tile25_sub4                                                                                                                                                                                                                                                                                                                                                                                                                             |
| bsai_5wt_tile3        | 450         | BsaI        | 5wt_tile3                                                                                                                                                                                                                                                                                                                                                                                                                                   |
| bsai_5wt_tile4        | 657         | BsaI        | 5wt_tile4                                                                                                                                                                                                                                                                                                                                                                                                                                   |
| bsai_5wt_tile5        | 855         | BsaI        | 5wt_tile5                                                                                                                                                                                                                                                                                                                                                                                                                                   |
| bsai_5wt_tile6        | 1065        | BsaI        | 5wt_tile6                                                                                                                                                                                                                                                                                                                                                                                                                                   |
| bsai_5wt_tile7        | 1203        | BsaI        | 5wt_tile7                                                                                                                                                                                                                                                                                                                                                                                                                                   |
| bsai_5wt_tile8        | 1410        | BsaI        | 5wt_tile8                                                                                                                                                                                                                                                                                                                                                                                                                                   |
| bsai_5wt_tile9        | 1605        | BsaI        | 5wt_tile9                                                                                                                                                                                                                                                                                                                                                                                                                                   |
| bsmbi_3wt_tile1_sub1  | 1386        | BsmBI       | 3wt_tile1_sub1                                                                                                                                                                                                                                                                                                                                                                                                                              |
| bsmbi_3wt_tile1_sub2  | 729         | BsmBI       | 3wt_tile1_sub2;3wt_tile2_sub2;3wt_tile3_sub2;3wt_tile4_sub2;3wt_tile5_sub2;3wt_tile6_sub2;3wt_tile8_sub1                                                                                                                                                                                                                                                                                                                                    |
| bsmbi_3wt_tile1_sub3  | 1233        | BsmBI       | 3wt_tile1_sub3;3wt_tile2_sub3;3wt_tile3_sub3;3wt_tile4_sub3;3wt_tile5_sub3;3wt_tile6_sub3;3wt_tile7_sub2;3wt_tile8_sub2;3wt_tile9_sub2;3wt_tile10_sub2;3wt_tile12_sub1                                                                                                                                                                                                                                                                      |
| bsmbi_3wt_tile1_sub4  | 1987        | BsmBI       | 3wt_polIII_tile1_sub4;3wt_polIII_tile2_sub4;3wt_polIII_tile3_sub4;3wt_polIII_tile4_sub4;3wt_polIII_tile5_sub4;3wt_polIII_tile6_sub4;3wt_polIII_tile7_sub3;3wt_polIII_tile8_sub3;3wt_polIII_tile9_sub3;3wt_polIII_tile10_sub3;3wt_polIII_tile11_sub2;3wt_polIII_tile12_sub2;3wt_polIII_tile13_sub2;3wt_polIII_tile14_sub2;3wt_polIII_tile15_sub2;3wt_polIII_tile16_sub2;3wt_polIII_tile17_sub2;3wt_polIII_tile18_sub2;3wt_polIII_tile19_sub2 |
| bsmbi_3wt_tile10_sub1 | 312         | BsmBI       | 3wt_tile10_sub1                                                                                                                                                                                                                                                                                                                                                                                                                             |
| bsmbi_3wt_tile11_sub1 | 1404        | BsmBI       | 3wt_tile11_sub1                                                                                                                                                                                                                                                                                                                                                                                                                             |
| bsmbi_3wt_tile13_sub1 | 1011        | BsmBI       | 3wt_tile13_sub1                                                                                                                                                                                                                                                                                                                                                                                                                             |
| bsmbi_3wt_tile14_sub1 | 894         | BsmBI       | 3wt_tile14_sub1                                                                                                                                                                                                                                                                                                                                                                                                                             |
| bsmbi_3wt_tile15_sub1 | 762         | BsmBI       | 3wt_tile15_sub1                                                                                                                                                                                                                                                                                                                                                                                                                             |
| bsmbi_3wt_tile16_sub1 | 594         | BsmBI       | 3wt_tile16_sub1                                                                                                                                                                                                                                                                                                                                                                                                                             |
| bsmbi_3wt_tile17_sub1 | 483         | BsmBI       | 3wt_tile17_sub1                                                                                                                                                                                                                                                                                                                                                                                                                             |
| bsmbi_3wt_tile18_sub1 | 300         | BsmBI       | 3wt_tile18_sub1                                                                                                                                                                                                                                                                                                                                                                                                                             |
| bsmbi_3wt_tile19_sub1 | 150         | BsmBI       | 3wt_tile19_sub1                                                                                                                                                                                                                                                                                                                                                                                                                             |
| bsmbi_3wt_tile2_sub1  | 1173        | BsmBI       | 3wt_tile2_sub1                                                                                                                                                                                                                                                                                                                                                                                                                              |
| bsmbi_3wt_tile20_sub1 | 513         | BsmBI       | 3wt_tile20_sub1                                                                                                                                                                                                                                                                                                                                                                                                                             |
| bsmbi_3wt_tile20_sub2 | 1492        | BsmBI       | 3wt_polIII_tile20_sub2;3wt_polIII_tile21_sub2                                                                                                                                                                                                                                                                                                                                                                                               |
| bsmbi_3wt_tile21_sub1 | 384         | BsmBI       | 3wt_tile21_sub1                                                                                                                                                                                                                                                                                                                                                                                                                             |
| bsmbi_3wt_tile22      | 1660        | BsmBI       | 3wt_polIII_tile22                                                                                                                                                                                                                                                                                                                                                                                                                           |
| bsmbi_3wt_tile23      | 1447        | BsmBI       | 3wt_polIII_tile23                                                                                                                                                                                                                                                                                                                                                                                                                           |
| bsmbi_3wt_tile24      | 1273        | BsmBI       | 3wt_polIII_tile24                                                                                                                                                                                                                                                                                                                                                                                                                           |
| bsmbi_3wt_tile3_sub1  | 966         | BsmBI       | 3wt_tile3_sub1                                                                                                                                                                                                                                                                                                                                                                                                                              |
| bsmbi_3wt_tile4_sub1  | 768         | BsmBI       | 3wt_tile4_sub1                                                                                                                                                                                                                                                                                                                                                                                                                              |
| bsmbi_3wt_tile5_sub1  | 558         | BsmBI       | 3wt_tile5_sub1                                                                                                                                                                                                                                                                                                                                                                                                                              |
| bsmbi_3wt_tile6_sub1  | 420         | BsmBI       | 3wt_tile6_sub1                                                                                                                                                                                                                                                                                                                                                                                                                              |
| bsmbi_3wt_tile7_sub1  | 924         | BsmBI       | 3wt_tile7_sub1                                                                                                                                                                                                                                                                                                                                                                                                                              |
| bsmbi_3wt_tile9_sub1  | 528         | BsmBI       | 3wt_tile9_sub1                                                                                                                                                                                                                                                                                                                                                                                                                              |
| bsmbi_polIII_tile25   | 1117        | BsmBI       | polIII_tile25                                                                                                                                                                                                                                                                                                                                                                                                                               |

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

