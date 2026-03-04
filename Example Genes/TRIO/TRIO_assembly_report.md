# DMS-GG Assembly Report: TRIO

Generated: 2026-03-03 20:30:40
Pipeline: dms-gg-oligo-pipeline (3-Enzyme Architecture: BsaI + BsmBI + PaqCI)

---

## 1. Gene Summary

| Property             | Value                                                                         |
| -------------------- | ----------------------------------------------------------------------------- |
| Gene name            | TRIO_NM_007118.4_CDS Homo sapiens triple functional domain protein (TRIO) CDS |
| CDS length           | 9294 nt (3098 codons)                                                         |
| Protein length       | 3097 aa                                                                       |
| Number of tiles      | 47                                                                            |
| Total variants       | 61880                                                                         |
| Total oligos         | 618800                                                                        |
| Oligo length range   | 173-290 nt                                                                    |
| Gene blocks to order | 99                                                                            |
| Barcodes per variant | 10                                                                            |

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

**Total oligos:** 618800 | **Length range:** 173-290 nt

| Tile | Codons    | Oligos | Length |
| ---- | --------- | ------ | ------ |
| 1    | 1-72      | 13600  | 272 nt |
| 2    | 69-146    | 14800  | 290 nt |
| 3    | 143-218   | 14400  | 284 nt |
| 4    | 215-268   | 10000  | 218 nt |
| 5    | 265-335   | 13400  | 269 nt |
| 6    | 332-399   | 12800  | 260 nt |
| 7    | 396-458   | 11800  | 245 nt |
| 8    | 455-527   | 13800  | 275 nt |
| 9    | 524-601   | 14800  | 290 nt |
| 10   | 598-675   | 14800  | 290 nt |
| 11   | 672-746   | 14200  | 281 nt |
| 12   | 743-820   | 14800  | 290 nt |
| 13   | 817-888   | 13600  | 272 nt |
| 14   | 885-962   | 14800  | 290 nt |
| 15   | 959-1005  | 8600   | 197 nt |
| 16   | 1002-1074 | 13800  | 275 nt |
| 17   | 1071-1148 | 14800  | 290 nt |
| 18   | 1145-1209 | 12200  | 251 nt |
| 19   | 1206-1244 | 7000   | 173 nt |
| 20   | 1241-1307 | 12600  | 257 nt |
| 21   | 1304-1349 | 8400   | 194 nt |
| 22   | 1346-1423 | 14800  | 290 nt |
| 23   | 1420-1481 | 11600  | 242 nt |
| 24   | 1478-1555 | 14800  | 290 nt |
| 25   | 1552-1622 | 13400  | 269 nt |
| 26   | 1619-1687 | 13000  | 263 nt |
| 27   | 1684-1761 | 14800  | 290 nt |
| 28   | 1758-1831 | 14000  | 278 nt |
| 29   | 1828-1905 | 14800  | 290 nt |
| 30   | 1902-1972 | 13400  | 269 nt |
| 31   | 1969-2045 | 14600  | 287 nt |
| 32   | 2042-2106 | 12200  | 251 nt |
| 33   | 2103-2160 | 10800  | 230 nt |
| 34   | 2157-2218 | 11600  | 242 nt |
| 35   | 2215-2279 | 12200  | 251 nt |
| 36   | 2276-2353 | 14800  | 290 nt |
| 37   | 2350-2419 | 13200  | 266 nt |
| 38   | 2416-2488 | 13800  | 275 nt |
| 39   | 2485-2559 | 14200  | 281 nt |
| 40   | 2556-2631 | 14400  | 284 nt |
| 41   | 2628-2703 | 14400  | 284 nt |
| 42   | 2700-2770 | 13400  | 269 nt |
| 43   | 2767-2815 | 9000   | 203 nt |
| 44   | 2812-2888 | 14600  | 287 nt |
| 45   | 2885-2955 | 13400  | 269 nt |
| 46   | 2952-3029 | 14800  | 290 nt |
| 47   | 3026-3098 | 13800  | 275 nt |

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
| Total barcodes    | 618800                             |
| Unique barcodes   | 618800                             |
| GC content range  | 25% - 75%                          |
| GC content mean   | 47.9%                              |
| Hamming guarantee | 100% cross-variant (prefix d >= 3) |

## 5. QC Summary

**Overall:** ISSUES FOUND

| Check                  | Description                                              | Result | Detail                                                                          |
| ---------------------- | -------------------------------------------------------- | ------ | ------------------------------------------------------------------------------- |
| oligo_lengths          | All oligos within synthesis length limit                 | PASS   | Range: 173-290 nt (limit: 300)                                                  |
| block_lengths          | All gene blocks within synthesis length limit            | PASS   | Range: 180-1798 nt (limit: 1800)                                                |
| barcode_junction_sites | No enzyme sites at barcode-context junctions             | PASS   | 0 barcode(s) with junction enzyme sites (left='CACACC', right='AATATG')         |
| barcode_uniqueness     | All barcodes are unique                                  | PASS   | 618800 unique / 618800 total                                                    |
| tile_coverage          | Tiles cover entire gene without gaps                     | PASS   | 9294 / 9294 nt covered                                                          |
| variant_count          | Expected number of variants generated                    | FAIL   | 61880 unique variants (expected: 61920 = 3096 mutable positions x 20 mutations) |
| single_codon_change    | Each variant differs by exactly one codon from WT        | PASS   | 618800 / 618800 variants confirmed                                              |
| oligo_gc_content       | Oligo GC content within reasonable range (25-75%)        | PASS   | GC range: 37.6-73.8% | 0 oligo(s) with extreme GC                               |
| domestication_complete | Gene domesticated for all 3 enzymes (BsaI, BsmBI, PaqCI) | PASS   | No enzyme sites in gene                                                         |
| overhang_fidelity      | Tile boundary overhangs have adequate fidelity           | FAIL   | 44 tile(s) with low-fidelity boundary overhangs (<0.80)                         |
| tile_manifests         | Per-tile assembly manifests complete                     | PASS   | 47 tile manifest(s) generated                                                   |
| helper_plasmid         | Helper plasmid free of unintended BsmBI sites            | PASS   | OK                                                                              |
| reaction_fidelity      | Per-reaction set-level overhang fidelity                 | PASS   | Min set fidelity: 0.8933 across 94 reactions | 1 reaction(s) below 0.90         |
| barcode_poliii_term    | No barcodes contain PolIII terminator signal (TTTT)      | PASS   | 0 / 618800 barcode(s) contain TTTT                                              |
| block_min_length       | All gene blocks above synthesis minimum length           | FAIL   | 10 block(s) below 300 nt minimum. Range: 180-1798 nt                            |

## 6. Fixed Overhangs & Helper Plasmid

These overhangs are the same across all tile reactions:

| Overhang    | Sequence | Role                                                    | In HF Set |
| ----------- | -------- | ------------------------------------------------------- | --------- |
| oh_L        | ATGA     | Gene start (BsaI, all tiles)                            | Yes       |
| oh3         | CACC     | Downstream cassette-barcode junction (BsmBI, all tiles) | No        |
| oh4         | AATA     | Barcode-helper junction (BsaI, all tiles)               | No        |
| paqci_star2 | AATG     | PaqCI 5' end of insert (Level 2)                        | --        |
| paqci_star1 | GCTA     | PaqCI 3' end of insert (Level 2)                        | --        |

### Helper Plasmid Insert

The helper plasmid provides the backbone for each BsaI Level 1 reaction.

```
[PaqCI**]--[BsaI>>ATGA]--STUFFER--[AATA<<BsaI]--[PaqCI*]
```

Insert length: 72 nt
oh_L = ATGA (first 4 nt of gene)
oh_R = AATA (= oh4, barcode-helper junction)

## 7. Per-Tile Assembly Guide

### Tile 1 of 47 -- Codons 1-72 (216 nt)

**Boundary overhangs:**

| Position          | Sequence | In HF Set | Fidelity |
| ----------------- | -------- | --------- | -------- |
| oh1 (5' boundary) | ATGA     | Yes       | 0.7549   |
| oh2 (3' boundary) | AAAA     | Yes       | 0.9502   |

**Variants:** 13600 mutations, 13600 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name                          | Length | 5' OH | 3' OH |
| --- | --------------- | ---------------------------------- | ------ | ----- | ----- |
| 1   | 5'WT gene block | (none -- tile starts at gene nt 1) | --     | --    | --    |
| 2   | Oligo pool      | Tile 1 (13600 oligos)              | 272 nt | ATGA  | AATA  |
| 3   | Helper plasmid  | helper_plasmid_insert              | --     | --    | --    |
| 4   | Enzyme + buffer | BsaI-HFv2 + CutSmart               | --     | --    | --    |

```
  [ATGA]----oligo+BC----[AATA]
   ATGA                  AATA 
   (HF)                  (--) 
```

**Set fidelity:** 1.0000 (2 overhangs, 1 in HF set)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------ | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)      | --      | --    | --    |
| 2   | 3'WT block        | bsmbi_3wt_tile1_sub1     | 1383 nt | AAAA  | CTCT  |
| 3   | 3'WT block        | bsmbi_3wt_tile1_sub2     | 1659 nt | CTCT  | TTGC  |
| 4   | 3'WT block        | bsmbi_3wt_tile1_sub3     | 1662 nt | TTGC  | TGGA  |
| 5   | 3'WT block        | bsmbi_3wt_tile1_sub4     | 1632 nt | TGGA  | TGCC  |
| 6   | 3'WT block        | bsmbi_3wt_tile1_sub5     | 1647 nt | TGCC  | TGTT  |
| 7   | 3'WT block        | bsmbi_3wt_tile1_sub6     | 573 nt  | TGTT  | CACT  |
| 8   | 3'WT+PolIII block | bsmbi_3wt_tile1_sub7     | 1742 nt | CACT  | CACC  |
| 9   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1 | --      | --    | --    |

```
  [AAAA]----3'WT sub1----[CTCT]----3'WT sub2----[TTGC]----3'WT sub3----[TGGA]----3'WT sub4----[TGCC]----3'WT sub5----[TGTT]----3'WT sub6----[CACT]----3'WT+PolIII sub7----[CACC]
   AAAA                   CTCT                   TTGC                   TGGA                   TGCC                   TGTT                   CACT                          CACC 
   (HF)                   (--)                   (--)                   (--)                   (--)                   (--)                   (--)                          (--) 
```

**Set fidelity:** 0.9448 (8 overhangs, 1 in HF set)

---

### Tile 2 of 47 -- Codons 69-146 (234 nt)

**Boundary overhangs:**

| Position          | Sequence | In HF Set | Fidelity |
| ----------------- | -------- | --------- | -------- |
| oh1 (5' boundary) | TTGA     | No        | 0.8853   |
| oh2 (3' boundary) | GCAG     | No        | 0.5118   |

**Variants:** 14800 mutations, 14800 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name             | Length | 5' OH | 3' OH |
| --- | --------------- | --------------------- | ------ | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile2        | 222 nt | ATGA  | TTGA  |
| 2   | Oligo pool      | Tile 2 (14800 oligos) | 290 nt | TTGA  | AATA  |
| 3   | Helper plasmid  | helper_plasmid_insert | --     | --    | --    |
| 4   | Enzyme + buffer | BsaI-HFv2 + CutSmart  | --     | --    | --    |

```
  [ATGA]----5'WT block----[TTGA]----oligo+BC----[AATA]
   ATGA                    TTGA                  AATA 
   (HF)                    (--)                  (--) 
```

**Set fidelity:** 0.9994 (3 overhangs, 1 in HF set)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------ | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)      | --      | --    | --    |
| 2   | 3'WT block        | bsmbi_3wt_tile2_sub1     | 1161 nt | GCAG  | CTCT  |
| 3   | 3'WT block        | bsmbi_3wt_tile1_sub2     | 1659 nt | CTCT  | TTGC  |
| 4   | 3'WT block        | bsmbi_3wt_tile1_sub3     | 1662 nt | TTGC  | TGGA  |
| 5   | 3'WT block        | bsmbi_3wt_tile1_sub4     | 1632 nt | TGGA  | TGCC  |
| 6   | 3'WT block        | bsmbi_3wt_tile1_sub5     | 1647 nt | TGCC  | TGTT  |
| 7   | 3'WT block        | bsmbi_3wt_tile1_sub6     | 573 nt  | TGTT  | CACT  |
| 8   | 3'WT+PolIII block | bsmbi_3wt_tile1_sub7     | 1742 nt | CACT  | CACC  |
| 9   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1 | --      | --    | --    |

```
  [GCAG]----3'WT sub1----[CTCT]----3'WT sub2----[TTGC]----3'WT sub3----[TGGA]----3'WT sub4----[TGCC]----3'WT sub5----[TGTT]----3'WT sub6----[CACT]----3'WT+PolIII sub7----[CACC]
   GCAG                   CTCT                   TTGC                   TGGA                   TGCC                   TGTT                   CACT                          CACC 
   (--)                   (--)                   (--)                   (--)                   (--)                   (--)                   (--)                          (--) 
```

**Set fidelity:** 0.9087 (8 overhangs, 0 in HF set)

---

### Tile 3 of 47 -- Codons 143-218 (228 nt)

**Boundary overhangs:**

| Position          | Sequence | In HF Set | Fidelity |
| ----------------- | -------- | --------- | -------- |
| oh1 (5' boundary) | AAGA     | No        | 0.9209   |
| oh2 (3' boundary) | AGTT     | No        | 0.6748   |

**Variants:** 14400 mutations, 14400 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name             | Length | 5' OH | 3' OH |
| --- | --------------- | --------------------- | ------ | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile3        | 444 nt | ATGA  | AAGA  |
| 2   | Oligo pool      | Tile 3 (14400 oligos) | 284 nt | AAGA  | AATA  |
| 3   | Helper plasmid  | helper_plasmid_insert | --     | --    | --    |
| 4   | Enzyme + buffer | BsaI-HFv2 + CutSmart  | --     | --    | --    |

```
  [ATGA]----5'WT block----[AAGA]----oligo+BC----[AATA]
   ATGA                    AAGA                  AATA 
   (HF)                    (--)                  (--) 
```

**Set fidelity:** 0.9998 (3 overhangs, 1 in HF set)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------ | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)      | --      | --    | --    |
| 2   | 3'WT block        | bsmbi_3wt_tile3_sub1     | 945 nt  | AGTT  | CTCT  |
| 3   | 3'WT block        | bsmbi_3wt_tile1_sub2     | 1659 nt | CTCT  | TTGC  |
| 4   | 3'WT block        | bsmbi_3wt_tile1_sub3     | 1662 nt | TTGC  | TGGA  |
| 5   | 3'WT block        | bsmbi_3wt_tile1_sub4     | 1632 nt | TGGA  | TGCC  |
| 6   | 3'WT block        | bsmbi_3wt_tile1_sub5     | 1647 nt | TGCC  | TGTT  |
| 7   | 3'WT block        | bsmbi_3wt_tile1_sub6     | 573 nt  | TGTT  | CACT  |
| 8   | 3'WT+PolIII block | bsmbi_3wt_tile1_sub7     | 1742 nt | CACT  | CACC  |
| 9   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1 | --      | --    | --    |

```
  [AGTT]----3'WT sub1----[CTCT]----3'WT sub2----[TTGC]----3'WT sub3----[TGGA]----3'WT sub4----[TGCC]----3'WT sub5----[TGTT]----3'WT sub6----[CACT]----3'WT+PolIII sub7----[CACC]
   AGTT                   CTCT                   TTGC                   TGGA                   TGCC                   TGTT                   CACT                          CACC 
   (--)                   (--)                   (--)                   (--)                   (--)                   (--)                   (--)                          (--) 
```

**Set fidelity:** 0.9127 (8 overhangs, 0 in HF set)

---

### Tile 4 of 47 -- Codons 215-268 (162 nt)

**Boundary overhangs:**

| Position          | Sequence | In HF Set | Fidelity |
| ----------------- | -------- | --------- | -------- |
| oh1 (5' boundary) | GAAA     | No        | 0.8745   |
| oh2 (3' boundary) | GATT     | No        | 0.6417   |

**Variants:** 10000 mutations, 10000 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name             | Length | 5' OH | 3' OH |
| --- | --------------- | --------------------- | ------ | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile4        | 660 nt | ATGA  | GAAA  |
| 2   | Oligo pool      | Tile 4 (10000 oligos) | 218 nt | GAAA  | AATA  |
| 3   | Helper plasmid  | helper_plasmid_insert | --     | --    | --    |
| 4   | Enzyme + buffer | BsaI-HFv2 + CutSmart  | --     | --    | --    |

```
  [ATGA]----5'WT block----[GAAA]----oligo+BC----[AATA]
   ATGA                    GAAA                  AATA 
   (HF)                    (--)                  (--) 
```

**Set fidelity:** 0.9995 (3 overhangs, 1 in HF set)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------ | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)      | --      | --    | --    |
| 2   | 3'WT block        | bsmbi_3wt_tile4_sub1     | 795 nt  | GATT  | CTCT  |
| 3   | 3'WT block        | bsmbi_3wt_tile1_sub2     | 1659 nt | CTCT  | TTGC  |
| 4   | 3'WT block        | bsmbi_3wt_tile1_sub3     | 1662 nt | TTGC  | TGGA  |
| 5   | 3'WT block        | bsmbi_3wt_tile1_sub4     | 1632 nt | TGGA  | TGCC  |
| 6   | 3'WT block        | bsmbi_3wt_tile1_sub5     | 1647 nt | TGCC  | TGTT  |
| 7   | 3'WT block        | bsmbi_3wt_tile1_sub6     | 573 nt  | TGTT  | CACT  |
| 8   | 3'WT+PolIII block | bsmbi_3wt_tile1_sub7     | 1742 nt | CACT  | CACC  |
| 9   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1 | --      | --    | --    |

```
  [GATT]----3'WT sub1----[CTCT]----3'WT sub2----[TTGC]----3'WT sub3----[TGGA]----3'WT sub4----[TGCC]----3'WT sub5----[TGTT]----3'WT sub6----[CACT]----3'WT+PolIII sub7----[CACC]
   GATT                   CTCT                   TTGC                   TGGA                   TGCC                   TGTT                   CACT                          CACC 
   (--)                   (--)                   (--)                   (--)                   (--)                   (--)                   (--)                          (--) 
```

**Set fidelity:** 0.9587 (8 overhangs, 0 in HF set)

---

### Tile 5 of 47 -- Codons 265-335 (213 nt)

**Boundary overhangs:**

| Position          | Sequence | In HF Set | Fidelity |
| ----------------- | -------- | --------- | -------- |
| oh1 (5' boundary) | AAGA     | No        | 0.9209   |
| oh2 (3' boundary) | GAAG     | No        | 0.6752   |

**Variants:** 13400 mutations, 13400 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name             | Length | 5' OH | 3' OH |
| --- | --------------- | --------------------- | ------ | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile5        | 810 nt | ATGA  | AAGA  |
| 2   | Oligo pool      | Tile 5 (13400 oligos) | 269 nt | AAGA  | AATA  |
| 3   | Helper plasmid  | helper_plasmid_insert | --     | --    | --    |
| 4   | Enzyme + buffer | BsaI-HFv2 + CutSmart  | --     | --    | --    |

```
  [ATGA]----5'WT block----[AAGA]----oligo+BC----[AATA]
   ATGA                    AAGA                  AATA 
   (HF)                    (--)                  (--) 
```

**Set fidelity:** 0.9998 (3 overhangs, 1 in HF set)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------ | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)      | --      | --    | --    |
| 2   | 3'WT block        | bsmbi_3wt_tile5_sub1     | 594 nt  | GAAG  | CTCT  |
| 3   | 3'WT block        | bsmbi_3wt_tile1_sub2     | 1659 nt | CTCT  | TTGC  |
| 4   | 3'WT block        | bsmbi_3wt_tile1_sub3     | 1662 nt | TTGC  | TGGA  |
| 5   | 3'WT block        | bsmbi_3wt_tile1_sub4     | 1632 nt | TGGA  | TGCC  |
| 6   | 3'WT block        | bsmbi_3wt_tile1_sub5     | 1647 nt | TGCC  | TGTT  |
| 7   | 3'WT block        | bsmbi_3wt_tile1_sub6     | 573 nt  | TGTT  | CACT  |
| 8   | 3'WT+PolIII block | bsmbi_3wt_tile1_sub7     | 1742 nt | CACT  | CACC  |
| 9   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1 | --      | --    | --    |

```
  [GAAG]----3'WT sub1----[CTCT]----3'WT sub2----[TTGC]----3'WT sub3----[TGGA]----3'WT sub4----[TGCC]----3'WT sub5----[TGTT]----3'WT sub6----[CACT]----3'WT+PolIII sub7----[CACC]
   GAAG                   CTCT                   TTGC                   TGGA                   TGCC                   TGTT                   CACT                          CACC 
   (--)                   (--)                   (--)                   (--)                   (--)                   (--)                   (--)                          (--) 
```

**Set fidelity:** 0.9514 (8 overhangs, 0 in HF set)

---

### Tile 6 of 47 -- Codons 332-399 (204 nt)

**Boundary overhangs:**

| Position          | Sequence | In HF Set | Fidelity |
| ----------------- | -------- | --------- | -------- |
| oh1 (5' boundary) | AGGA     | Yes       | 0.7515   |
| oh2 (3' boundary) | AAAC     | No        | 0.6694   |

**Variants:** 12800 mutations, 12800 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name             | Length  | 5' OH | 3' OH |
| --- | --------------- | --------------------- | ------- | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile6        | 1011 nt | ATGA  | AGGA  |
| 2   | Oligo pool      | Tile 6 (12800 oligos) | 260 nt  | AGGA  | AATA  |
| 3   | Helper plasmid  | helper_plasmid_insert | --      | --    | --    |
| 4   | Enzyme + buffer | BsaI-HFv2 + CutSmart  | --      | --    | --    |

```
  [ATGA]----5'WT block----[AGGA]----oligo+BC----[AATA]
   ATGA                    AGGA                  AATA 
   (HF)                    (HF)                  (--) 
```

**Set fidelity:** 0.9999 (3 overhangs, 2 in HF set)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------ | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)      | --      | --    | --    |
| 2   | 3'WT block        | bsmbi_3wt_tile6_sub1     | 402 nt  | AAAC  | CTCT  |
| 3   | 3'WT block        | bsmbi_3wt_tile1_sub2     | 1659 nt | CTCT  | TTGC  |
| 4   | 3'WT block        | bsmbi_3wt_tile1_sub3     | 1662 nt | TTGC  | TGGA  |
| 5   | 3'WT block        | bsmbi_3wt_tile1_sub4     | 1632 nt | TGGA  | TGCC  |
| 6   | 3'WT block        | bsmbi_3wt_tile1_sub5     | 1647 nt | TGCC  | TGTT  |
| 7   | 3'WT block        | bsmbi_3wt_tile1_sub6     | 573 nt  | TGTT  | CACT  |
| 8   | 3'WT+PolIII block | bsmbi_3wt_tile1_sub7     | 1742 nt | CACT  | CACC  |
| 9   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1 | --      | --    | --    |

```
  [AAAC]----3'WT sub1----[CTCT]----3'WT sub2----[TTGC]----3'WT sub3----[TGGA]----3'WT sub4----[TGCC]----3'WT sub5----[TGTT]----3'WT sub6----[CACT]----3'WT+PolIII sub7----[CACC]
   AAAC                   CTCT                   TTGC                   TGGA                   TGCC                   TGTT                   CACT                          CACC 
   (--)                   (--)                   (--)                   (--)                   (--)                   (--)                   (--)                          (--) 
```

**Set fidelity:** 0.9594 (8 overhangs, 0 in HF set)

---

### Tile 7 of 47 -- Codons 396-458 (189 nt)

**Boundary overhangs:**

| Position          | Sequence | In HF Set | Fidelity |
| ----------------- | -------- | --------- | -------- |
| oh1 (5' boundary) | GTAA     | Yes       | 0.8029   |
| oh2 (3' boundary) | TATG     | No        | 0.7006   |

**Variants:** 11800 mutations, 11800 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name             | Length  | 5' OH | 3' OH |
| --- | --------------- | --------------------- | ------- | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile7        | 1203 nt | ATGA  | GTAA  |
| 2   | Oligo pool      | Tile 7 (11800 oligos) | 245 nt  | GTAA  | AATA  |
| 3   | Helper plasmid  | helper_plasmid_insert | --      | --    | --    |
| 4   | Enzyme + buffer | BsaI-HFv2 + CutSmart  | --      | --    | --    |

```
  [ATGA]----5'WT block----[GTAA]----oligo+BC----[AATA]
   ATGA                    GTAA                  AATA 
   (HF)                    (HF)                  (--) 
```

**Set fidelity:** 0.9996 (3 overhangs, 2 in HF set)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------ | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)      | --      | --    | --    |
| 2   | 3'WT block        | bsmbi_3wt_tile7_sub1     | 225 nt  | TATG  | CTCT  |
| 3   | 3'WT block        | bsmbi_3wt_tile1_sub2     | 1659 nt | CTCT  | TTGC  |
| 4   | 3'WT block        | bsmbi_3wt_tile1_sub3     | 1662 nt | TTGC  | TGGA  |
| 5   | 3'WT block        | bsmbi_3wt_tile1_sub4     | 1632 nt | TGGA  | TGCC  |
| 6   | 3'WT block        | bsmbi_3wt_tile1_sub5     | 1647 nt | TGCC  | TGTT  |
| 7   | 3'WT block        | bsmbi_3wt_tile1_sub6     | 573 nt  | TGTT  | CACT  |
| 8   | 3'WT+PolIII block | bsmbi_3wt_tile1_sub7     | 1742 nt | CACT  | CACC  |
| 9   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1 | --      | --    | --    |

```
  [TATG]----3'WT sub1----[CTCT]----3'WT sub2----[TTGC]----3'WT sub3----[TGGA]----3'WT sub4----[TGCC]----3'WT sub5----[TGTT]----3'WT sub6----[CACT]----3'WT+PolIII sub7----[CACC]
   TATG                   CTCT                   TTGC                   TGGA                   TGCC                   TGTT                   CACT                          CACC 
   (--)                   (--)                   (--)                   (--)                   (--)                   (--)                   (--)                          (--) 
```

**Set fidelity:** 0.9547 (8 overhangs, 0 in HF set)

---

### Tile 8 of 47 -- Codons 455-527 (219 nt)

**Boundary overhangs:**

| Position          | Sequence | In HF Set | Fidelity |
| ----------------- | -------- | --------- | -------- |
| oh1 (5' boundary) | GAAA     | No        | 0.8745   |
| oh2 (3' boundary) | CTCT     | No        | 0.6347   |

**Variants:** 13800 mutations, 13800 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name             | Length  | 5' OH | 3' OH |
| --- | --------------- | --------------------- | ------- | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile8        | 1380 nt | ATGA  | GAAA  |
| 2   | Oligo pool      | Tile 8 (13800 oligos) | 275 nt  | GAAA  | AATA  |
| 3   | Helper plasmid  | helper_plasmid_insert | --      | --    | --    |
| 4   | Enzyme + buffer | BsaI-HFv2 + CutSmart  | --      | --    | --    |

```
  [ATGA]----5'WT block----[GAAA]----oligo+BC----[AATA]
   ATGA                    GAAA                  AATA 
   (HF)                    (--)                  (--) 
```

**Set fidelity:** 0.9995 (3 overhangs, 1 in HF set)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------ | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)      | --      | --    | --    |
| 2   | 3'WT block        | bsmbi_3wt_tile1_sub2     | 1659 nt | CTCT  | TTGC  |
| 3   | 3'WT block        | bsmbi_3wt_tile1_sub3     | 1662 nt | TTGC  | TGGA  |
| 4   | 3'WT block        | bsmbi_3wt_tile1_sub4     | 1632 nt | TGGA  | TGCC  |
| 5   | 3'WT block        | bsmbi_3wt_tile1_sub5     | 1647 nt | TGCC  | TGTT  |
| 6   | 3'WT block        | bsmbi_3wt_tile1_sub6     | 573 nt  | TGTT  | CACT  |
| 7   | 3'WT+PolIII block | bsmbi_3wt_tile1_sub7     | 1742 nt | CACT  | CACC  |
| 8   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1 | --      | --    | --    |

```
  [CTCT]----3'WT sub1----[TTGC]----3'WT sub2----[TGGA]----3'WT sub3----[TGCC]----3'WT sub4----[TGTT]----3'WT sub5----[CACT]----3'WT+PolIII sub6----[CACC]
   CTCT                   TTGC                   TGGA                   TGCC                   TGTT                   CACT                          CACC 
   (--)                   (--)                   (--)                   (--)                   (--)                   (--)                          (--) 
```

**Set fidelity:** 0.9706 (7 overhangs, 0 in HF set)

---

### Tile 9 of 47 -- Codons 524-601 (234 nt)

**Boundary overhangs:**

| Position          | Sequence | In HF Set | Fidelity |
| ----------------- | -------- | --------- | -------- |
| oh1 (5' boundary) | CTGA     | No        | 0.6791   |
| oh2 (3' boundary) | TCAT     | No        | 0.8102   |

**Variants:** 14800 mutations, 14800 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name             | Length  | 5' OH | 3' OH |
| --- | --------------- | --------------------- | ------- | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile9        | 1587 nt | ATGA  | CTGA  |
| 2   | Oligo pool      | Tile 9 (14800 oligos) | 290 nt  | CTGA  | AATA  |
| 3   | Helper plasmid  | helper_plasmid_insert | --      | --    | --    |
| 4   | Enzyme + buffer | BsaI-HFv2 + CutSmart  | --      | --    | --    |

```
  [ATGA]----5'WT block----[CTGA]----oligo+BC----[AATA]
   ATGA                    CTGA                  AATA 
   (HF)                    (--)                  (--) 
```

**Set fidelity:** 0.9999 (3 overhangs, 1 in HF set)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------ | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)      | --      | --    | --    |
| 2   | 3'WT block        | bsmbi_3wt_tile9_sub1     | 1437 nt | TCAT  | TTGC  |
| 3   | 3'WT block        | bsmbi_3wt_tile1_sub3     | 1662 nt | TTGC  | TGGA  |
| 4   | 3'WT block        | bsmbi_3wt_tile1_sub4     | 1632 nt | TGGA  | TGCC  |
| 5   | 3'WT block        | bsmbi_3wt_tile1_sub5     | 1647 nt | TGCC  | TGTT  |
| 6   | 3'WT block        | bsmbi_3wt_tile1_sub6     | 573 nt  | TGTT  | CACT  |
| 7   | 3'WT+PolIII block | bsmbi_3wt_tile1_sub7     | 1742 nt | CACT  | CACC  |
| 8   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1 | --      | --    | --    |

```
  [TCAT]----3'WT sub1----[TTGC]----3'WT sub2----[TGGA]----3'WT sub3----[TGCC]----3'WT sub4----[TGTT]----3'WT sub5----[CACT]----3'WT+PolIII sub6----[CACC]
   TCAT                   TTGC                   TGGA                   TGCC                   TGTT                   CACT                          CACC 
   (--)                   (--)                   (--)                   (--)                   (--)                   (--)                          (--) 
```

**Set fidelity:** 0.9672 (7 overhangs, 0 in HF set)

---

### Tile 10 of 47 -- Codons 598-675 (234 nt)

**Boundary overhangs:**

| Position          | Sequence | In HF Set | Fidelity |
| ----------------- | -------- | --------- | -------- |
| oh1 (5' boundary) | AAAT     | No        | 0.7737   |
| oh2 (3' boundary) | GTCC     | No        | 0.5806   |

**Variants:** 14800 mutations, 14800 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name              | Length  | 5' OH | 3' OH |
| --- | --------------- | ---------------------- | ------- | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile10_sub1   | 1595 nt | ATGA  | CTCT  |
| 2   | 5'WT gene block | bsai_5wt_tile10_sub2   | 232 nt  | CTCT  | AAAT  |
| 3   | Oligo pool      | Tile 10 (14800 oligos) | 290 nt  | AAAT  | AATA  |
| 4   | Helper plasmid  | helper_plasmid_insert  | --      | --    | --    |
| 5   | Enzyme + buffer | BsaI-HFv2 + CutSmart   | --      | --    | --    |

```
  [ATGA]----5'WT sub1----[CTCT]----5'WT sub2----[AAAT]----oligo+BC----[AATA]
   ATGA                   CTCT                   AAAT                  AATA 
   (HF)                   (--)                   (--)                  (--) 
```

**Set fidelity:** 0.9909 (4 overhangs, 1 in HF set)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------ | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)      | --      | --    | --    |
| 2   | 3'WT block        | bsmbi_3wt_tile10_sub1    | 1215 nt | GTCC  | TTGC  |
| 3   | 3'WT block        | bsmbi_3wt_tile1_sub3     | 1662 nt | TTGC  | TGGA  |
| 4   | 3'WT block        | bsmbi_3wt_tile1_sub4     | 1632 nt | TGGA  | TGCC  |
| 5   | 3'WT block        | bsmbi_3wt_tile1_sub5     | 1647 nt | TGCC  | TGTT  |
| 6   | 3'WT block        | bsmbi_3wt_tile1_sub6     | 573 nt  | TGTT  | CACT  |
| 7   | 3'WT+PolIII block | bsmbi_3wt_tile1_sub7     | 1742 nt | CACT  | CACC  |
| 8   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1 | --      | --    | --    |

```
  [GTCC]----3'WT sub1----[TTGC]----3'WT sub2----[TGGA]----3'WT sub3----[TGCC]----3'WT sub4----[TGTT]----3'WT sub5----[CACT]----3'WT+PolIII sub6----[CACC]
   GTCC                   TTGC                   TGGA                   TGCC                   TGTT                   CACT                          CACC 
   (--)                   (--)                   (--)                   (--)                   (--)                   (--)                          (--) 
```

**Set fidelity:** 0.9630 (7 overhangs, 0 in HF set)

---

### Tile 11 of 47 -- Codons 672-746 (225 nt)

**Boundary overhangs:**

| Position          | Sequence | In HF Set | Fidelity |
| ----------------- | -------- | --------- | -------- |
| oh1 (5' boundary) | ATGT     | No        | 0.6822   |
| oh2 (3' boundary) | TAAC     | No        | 0.7715   |

**Variants:** 14200 mutations, 14200 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name              | Length  | 5' OH | 3' OH |
| --- | --------------- | ---------------------- | ------- | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile10_sub1   | 1595 nt | ATGA  | CTCT  |
| 2   | 5'WT gene block | bsai_5wt_tile11_sub2   | 454 nt  | CTCT  | ATGT  |
| 3   | Oligo pool      | Tile 11 (14200 oligos) | 281 nt  | ATGT  | AATA  |
| 4   | Helper plasmid  | helper_plasmid_insert  | --      | --    | --    |
| 5   | Enzyme + buffer | BsaI-HFv2 + CutSmart   | --      | --    | --    |

```
  [ATGA]----5'WT sub1----[CTCT]----5'WT sub2----[ATGT]----oligo+BC----[AATA]
   ATGA                   CTCT                   ATGT                  AATA 
   (HF)                   (--)                   (--)                  (--) 
```

**Set fidelity:** 0.9977 (4 overhangs, 1 in HF set)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------ | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)      | --      | --    | --    |
| 2   | 3'WT block        | bsmbi_3wt_tile11_sub1    | 1002 nt | TAAC  | TTGC  |
| 3   | 3'WT block        | bsmbi_3wt_tile1_sub3     | 1662 nt | TTGC  | TGGA  |
| 4   | 3'WT block        | bsmbi_3wt_tile1_sub4     | 1632 nt | TGGA  | TGCC  |
| 5   | 3'WT block        | bsmbi_3wt_tile1_sub5     | 1647 nt | TGCC  | TGTT  |
| 6   | 3'WT block        | bsmbi_3wt_tile1_sub6     | 573 nt  | TGTT  | CACT  |
| 7   | 3'WT+PolIII block | bsmbi_3wt_tile1_sub7     | 1742 nt | CACT  | CACC  |
| 8   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1 | --      | --    | --    |

```
  [TAAC]----3'WT sub1----[TTGC]----3'WT sub2----[TGGA]----3'WT sub3----[TGCC]----3'WT sub4----[TGTT]----3'WT sub5----[CACT]----3'WT+PolIII sub6----[CACC]
   TAAC                   TTGC                   TGGA                   TGCC                   TGTT                   CACT                          CACC 
   (--)                   (--)                   (--)                   (--)                   (--)                   (--)                          (--) 
```

**Set fidelity:** 0.9713 (7 overhangs, 0 in HF set)

---

### Tile 12 of 47 -- Codons 743-820 (234 nt)

**Boundary overhangs:**

| Position          | Sequence | In HF Set | Fidelity |
| ----------------- | -------- | --------- | -------- |
| oh1 (5' boundary) | ATCT     | No        | 0.7151   |
| oh2 (3' boundary) | AGAT     | Yes       | 0.6825   |

**Variants:** 14800 mutations, 14800 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name              | Length  | 5' OH | 3' OH |
| --- | --------------- | ---------------------- | ------- | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile10_sub1   | 1595 nt | ATGA  | CTCT  |
| 2   | 5'WT gene block | bsai_5wt_tile12_sub2   | 667 nt  | CTCT  | ATCT  |
| 3   | Oligo pool      | Tile 12 (14800 oligos) | 290 nt  | ATCT  | AATA  |
| 4   | Helper plasmid  | helper_plasmid_insert  | --      | --    | --    |
| 5   | Enzyme + buffer | BsaI-HFv2 + CutSmart   | --      | --    | --    |

```
  [ATGA]----5'WT sub1----[CTCT]----5'WT sub2----[ATCT]----oligo+BC----[AATA]
   ATGA                   CTCT                   ATCT                  AATA 
   (HF)                   (--)                   (--)                  (--) 
```

**Set fidelity:** 0.9977 (4 overhangs, 1 in HF set)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------ | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)      | --      | --    | --    |
| 2   | 3'WT block        | bsmbi_3wt_tile12_sub1    | 780 nt  | AGAT  | TTGC  |
| 3   | 3'WT block        | bsmbi_3wt_tile1_sub3     | 1662 nt | TTGC  | TGGA  |
| 4   | 3'WT block        | bsmbi_3wt_tile1_sub4     | 1632 nt | TGGA  | TGCC  |
| 5   | 3'WT block        | bsmbi_3wt_tile1_sub5     | 1647 nt | TGCC  | TGTT  |
| 6   | 3'WT block        | bsmbi_3wt_tile1_sub6     | 573 nt  | TGTT  | CACT  |
| 7   | 3'WT+PolIII block | bsmbi_3wt_tile1_sub7     | 1742 nt | CACT  | CACC  |
| 8   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1 | --      | --    | --    |

```
  [AGAT]----3'WT sub1----[TTGC]----3'WT sub2----[TGGA]----3'WT sub3----[TGCC]----3'WT sub4----[TGTT]----3'WT sub5----[CACT]----3'WT+PolIII sub6----[CACC]
   AGAT                   TTGC                   TGGA                   TGCC                   TGTT                   CACT                          CACC 
   (HF)                   (--)                   (--)                   (--)                   (--)                   (--)                          (--) 
```

**Set fidelity:** 0.9639 (7 overhangs, 1 in HF set)

---

### Tile 13 of 47 -- Codons 817-888 (216 nt)

**Boundary overhangs:**

| Position          | Sequence | In HF Set | Fidelity |
| ----------------- | -------- | --------- | -------- |
| oh1 (5' boundary) | GACA     | Yes       | 0.6127   |
| oh2 (3' boundary) | AAAA     | Yes       | 0.9502   |

**Variants:** 13600 mutations, 13600 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name              | Length  | 5' OH | 3' OH |
| --- | --------------- | ---------------------- | ------- | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile10_sub1   | 1595 nt | ATGA  | CTCT  |
| 2   | 5'WT gene block | bsai_5wt_tile13_sub2   | 889 nt  | CTCT  | GACA  |
| 3   | Oligo pool      | Tile 13 (13600 oligos) | 272 nt  | GACA  | AATA  |
| 4   | Helper plasmid  | helper_plasmid_insert  | --      | --    | --    |
| 5   | Enzyme + buffer | BsaI-HFv2 + CutSmart   | --      | --    | --    |

```
  [ATGA]----5'WT sub1----[CTCT]----5'WT sub2----[GACA]----oligo+BC----[AATA]
   ATGA                   CTCT                   GACA                  AATA 
   (HF)                   (--)                   (HF)                  (--) 
```

**Set fidelity:** 0.9983 (4 overhangs, 2 in HF set)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------ | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)      | --      | --    | --    |
| 2   | 3'WT block        | bsmbi_3wt_tile13_sub1    | 576 nt  | AAAA  | TTGC  |
| 3   | 3'WT block        | bsmbi_3wt_tile1_sub3     | 1662 nt | TTGC  | TGGA  |
| 4   | 3'WT block        | bsmbi_3wt_tile1_sub4     | 1632 nt | TGGA  | TGCC  |
| 5   | 3'WT block        | bsmbi_3wt_tile1_sub5     | 1647 nt | TGCC  | TGTT  |
| 6   | 3'WT block        | bsmbi_3wt_tile1_sub6     | 573 nt  | TGTT  | CACT  |
| 7   | 3'WT+PolIII block | bsmbi_3wt_tile1_sub7     | 1742 nt | CACT  | CACC  |
| 8   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1 | --      | --    | --    |

```
  [AAAA]----3'WT sub1----[TTGC]----3'WT sub2----[TGGA]----3'WT sub3----[TGCC]----3'WT sub4----[TGTT]----3'WT sub5----[CACT]----3'WT+PolIII sub6----[CACC]
   AAAA                   TTGC                   TGGA                   TGCC                   TGTT                   CACT                          CACC 
   (HF)                   (--)                   (--)                   (--)                   (--)                   (--)                          (--) 
```

**Set fidelity:** 0.9499 (7 overhangs, 1 in HF set)

---

### Tile 14 of 47 -- Codons 885-962 (234 nt)

**Boundary overhangs:**

| Position          | Sequence | In HF Set | Fidelity |
| ----------------- | -------- | --------- | -------- |
| oh1 (5' boundary) | CTTC     | No        | 0.6384   |
| oh2 (3' boundary) | TCAG     | No        | 0.7814   |

**Variants:** 14800 mutations, 14800 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name              | Length  | 5' OH | 3' OH |
| --- | --------------- | ---------------------- | ------- | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile10_sub1   | 1595 nt | ATGA  | CTCT  |
| 2   | 5'WT gene block | bsai_5wt_tile14_sub2   | 1093 nt | CTCT  | CTTC  |
| 3   | Oligo pool      | Tile 14 (14800 oligos) | 290 nt  | CTTC  | AATA  |
| 4   | Helper plasmid  | helper_plasmid_insert  | --      | --    | --    |
| 5   | Enzyme + buffer | BsaI-HFv2 + CutSmart   | --      | --    | --    |

```
  [ATGA]----5'WT sub1----[CTCT]----5'WT sub2----[CTTC]----oligo+BC----[AATA]
   ATGA                   CTCT                   CTTC                  AATA 
   (HF)                   (--)                   (--)                  (--) 
```

**Set fidelity:** 0.9985 (4 overhangs, 1 in HF set)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------ | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)      | --      | --    | --    |
| 2   | 3'WT block        | bsmbi_3wt_tile14_sub1    | 354 nt  | TCAG  | TTGC  |
| 3   | 3'WT block        | bsmbi_3wt_tile1_sub3     | 1662 nt | TTGC  | TGGA  |
| 4   | 3'WT block        | bsmbi_3wt_tile1_sub4     | 1632 nt | TGGA  | TGCC  |
| 5   | 3'WT block        | bsmbi_3wt_tile1_sub5     | 1647 nt | TGCC  | TGTT  |
| 6   | 3'WT block        | bsmbi_3wt_tile1_sub6     | 573 nt  | TGTT  | CACT  |
| 7   | 3'WT+PolIII block | bsmbi_3wt_tile1_sub7     | 1742 nt | CACT  | CACC  |
| 8   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1 | --      | --    | --    |

```
  [TCAG]----3'WT sub1----[TTGC]----3'WT sub2----[TGGA]----3'WT sub3----[TGCC]----3'WT sub4----[TGTT]----3'WT sub5----[CACT]----3'WT+PolIII sub6----[CACC]
   TCAG                   TTGC                   TGGA                   TGCC                   TGTT                   CACT                          CACC 
   (--)                   (--)                   (--)                   (--)                   (--)                   (--)                          (--) 
```

**Set fidelity:** 0.9653 (7 overhangs, 0 in HF set)

---

### Tile 15 of 47 -- Codons 959-1005 (141 nt)

**Boundary overhangs:**

| Position          | Sequence | In HF Set | Fidelity |
| ----------------- | -------- | --------- | -------- |
| oh1 (5' boundary) | AAAA     | Yes       | 0.9502   |
| oh2 (3' boundary) | AGAT     | Yes       | 0.6825   |

**Variants:** 8600 mutations, 8600 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name             | Length  | 5' OH | 3' OH |
| --- | --------------- | --------------------- | ------- | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile10_sub1  | 1595 nt | ATGA  | CTCT  |
| 2   | 5'WT gene block | bsai_5wt_tile15_sub2  | 1315 nt | CTCT  | AAAA  |
| 3   | Oligo pool      | Tile 15 (8600 oligos) | 197 nt  | AAAA  | AATA  |
| 4   | Helper plasmid  | helper_plasmid_insert | --      | --    | --    |
| 5   | Enzyme + buffer | BsaI-HFv2 + CutSmart  | --      | --    | --    |

```
  [ATGA]----5'WT sub1----[CTCT]----5'WT sub2----[AAAA]----oligo+BC----[AATA]
   ATGA                   CTCT                   AAAA                  AATA 
   (HF)                   (--)                   (HF)                  (--) 
```

**Set fidelity:** 0.9961 (4 overhangs, 2 in HF set)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------ | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)      | --      | --    | --    |
| 2   | 3'WT block        | bsmbi_3wt_tile15_sub1    | 225 nt  | AGAT  | TTGC  |
| 3   | 3'WT block        | bsmbi_3wt_tile1_sub3     | 1662 nt | TTGC  | TGGA  |
| 4   | 3'WT block        | bsmbi_3wt_tile1_sub4     | 1632 nt | TGGA  | TGCC  |
| 5   | 3'WT block        | bsmbi_3wt_tile1_sub5     | 1647 nt | TGCC  | TGTT  |
| 6   | 3'WT block        | bsmbi_3wt_tile1_sub6     | 573 nt  | TGTT  | CACT  |
| 7   | 3'WT+PolIII block | bsmbi_3wt_tile1_sub7     | 1742 nt | CACT  | CACC  |
| 8   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1 | --      | --    | --    |

```
  [AGAT]----3'WT sub1----[TTGC]----3'WT sub2----[TGGA]----3'WT sub3----[TGCC]----3'WT sub4----[TGTT]----3'WT sub5----[CACT]----3'WT+PolIII sub6----[CACC]
   AGAT                   TTGC                   TGGA                   TGCC                   TGTT                   CACT                          CACC 
   (HF)                   (--)                   (--)                   (--)                   (--)                   (--)                          (--) 
```

**Set fidelity:** 0.9639 (7 overhangs, 1 in HF set)

---

### Tile 16 of 47 -- Codons 1002-1074 (219 nt)

**Boundary overhangs:**

| Position          | Sequence | In HF Set | Fidelity |
| ----------------- | -------- | --------- | -------- |
| oh1 (5' boundary) | AAGA     | No        | 0.9209   |
| oh2 (3' boundary) | TTGC     | No        | 0.7336   |

**Variants:** 13800 mutations, 13800 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name              | Length  | 5' OH | 3' OH |
| --- | --------------- | ---------------------- | ------- | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile10_sub1   | 1595 nt | ATGA  | CTCT  |
| 2   | 5'WT gene block | bsai_5wt_tile16_sub2   | 1444 nt | CTCT  | AAGA  |
| 3   | Oligo pool      | Tile 16 (13800 oligos) | 275 nt  | AAGA  | AATA  |
| 4   | Helper plasmid  | helper_plasmid_insert  | --      | --    | --    |
| 5   | Enzyme + buffer | BsaI-HFv2 + CutSmart   | --      | --    | --    |

```
  [ATGA]----5'WT sub1----[CTCT]----5'WT sub2----[AAGA]----oligo+BC----[AATA]
   ATGA                   CTCT                   AAGA                  AATA 
   (HF)                   (--)                   (--)                  (--) 
```

**Set fidelity:** 0.9985 (4 overhangs, 1 in HF set)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------ | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)      | --      | --    | --    |
| 2   | 3'WT block        | bsmbi_3wt_tile1_sub3     | 1662 nt | TTGC  | TGGA  |
| 3   | 3'WT block        | bsmbi_3wt_tile1_sub4     | 1632 nt | TGGA  | TGCC  |
| 4   | 3'WT block        | bsmbi_3wt_tile1_sub5     | 1647 nt | TGCC  | TGTT  |
| 5   | 3'WT block        | bsmbi_3wt_tile1_sub6     | 573 nt  | TGTT  | CACT  |
| 6   | 3'WT+PolIII block | bsmbi_3wt_tile1_sub7     | 1742 nt | CACT  | CACC  |
| 7   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1 | --      | --    | --    |

```
  [TTGC]----3'WT sub1----[TGGA]----3'WT sub2----[TGCC]----3'WT sub3----[TGTT]----3'WT sub4----[CACT]----3'WT+PolIII sub5----[CACC]
   TTGC                   TGGA                   TGCC                   TGTT                   CACT                          CACC 
   (--)                   (--)                   (--)                   (--)                   (--)                          (--) 
```

**Set fidelity:** 0.9730 (6 overhangs, 0 in HF set)

---

### Tile 17 of 47 -- Codons 1071-1148 (234 nt)

**Boundary overhangs:**

| Position          | Sequence | In HF Set | Fidelity |
| ----------------- | -------- | --------- | -------- |
| oh1 (5' boundary) | CTGA     | No        | 0.6791   |
| oh2 (3' boundary) | CAAG     | No        | 0.6640   |

**Variants:** 14800 mutations, 14800 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name              | Length  | 5' OH | 3' OH |
| --- | --------------- | ---------------------- | ------- | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile10_sub1   | 1595 nt | ATGA  | CTCT  |
| 2   | 5'WT gene block | bsai_5wt_tile17_sub2   | 1651 nt | CTCT  | CTGA  |
| 3   | Oligo pool      | Tile 17 (14800 oligos) | 290 nt  | CTGA  | AATA  |
| 4   | Helper plasmid  | helper_plasmid_insert  | --      | --    | --    |
| 5   | Enzyme + buffer | BsaI-HFv2 + CutSmart   | --      | --    | --    |

```
  [ATGA]----5'WT sub1----[CTCT]----5'WT sub2----[CTGA]----oligo+BC----[AATA]
   ATGA                   CTCT                   CTGA                  AATA 
   (HF)                   (--)                   (--)                  (--) 
```

**Set fidelity:** 0.9989 (4 overhangs, 1 in HF set)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------ | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)      | --      | --    | --    |
| 2   | 3'WT block        | bsmbi_3wt_tile17_sub1    | 1440 nt | CAAG  | TGGA  |
| 3   | 3'WT block        | bsmbi_3wt_tile1_sub4     | 1632 nt | TGGA  | TGCC  |
| 4   | 3'WT block        | bsmbi_3wt_tile1_sub5     | 1647 nt | TGCC  | TGTT  |
| 5   | 3'WT block        | bsmbi_3wt_tile1_sub6     | 573 nt  | TGTT  | CACT  |
| 6   | 3'WT+PolIII block | bsmbi_3wt_tile1_sub7     | 1742 nt | CACT  | CACC  |
| 7   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1 | --      | --    | --    |

```
  [CAAG]----3'WT sub1----[TGGA]----3'WT sub2----[TGCC]----3'WT sub3----[TGTT]----3'WT sub4----[CACT]----3'WT+PolIII sub5----[CACC]
   CAAG                   TGGA                   TGCC                   TGTT                   CACT                          CACC 
   (--)                   (--)                   (--)                   (--)                   (--)                          (--) 
```

**Set fidelity:** 0.9710 (6 overhangs, 0 in HF set)

---

### Tile 18 of 47 -- Codons 1145-1209 (195 nt)

**Boundary overhangs:**

| Position          | Sequence | In HF Set | Fidelity |
| ----------------- | -------- | --------- | -------- |
| oh1 (5' boundary) | AGGA     | Yes       | 0.7515   |
| oh2 (3' boundary) | AAAA     | Yes       | 0.9502   |

**Variants:** 12200 mutations, 12200 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name              | Length  | 5' OH | 3' OH |
| --- | --------------- | ---------------------- | ------- | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile10_sub1   | 1595 nt | ATGA  | CTCT  |
| 2   | 5'WT gene block | bsai_5wt_tile18_sub2   | 1659 nt | CTCT  | TTGC  |
| 3   | 5'WT gene block | bsai_5wt_tile18_sub3   | 232 nt  | TTGC  | AGGA  |
| 4   | Oligo pool      | Tile 18 (12200 oligos) | 251 nt  | AGGA  | AATA  |
| 5   | Helper plasmid  | helper_plasmid_insert  | --      | --    | --    |
| 6   | Enzyme + buffer | BsaI-HFv2 + CutSmart   | --      | --    | --    |

```
  [ATGA]----5'WT sub1----[CTCT]----5'WT sub2----[TTGC]----5'WT sub3----[AGGA]----oligo+BC----[AATA]
   ATGA                   CTCT                   TTGC                   AGGA                  AATA 
   (HF)                   (--)                   (--)                   (HF)                  (--) 
```

**Set fidelity:** 0.9940 (5 overhangs, 2 in HF set)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------ | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)      | --      | --    | --    |
| 2   | 3'WT block        | bsmbi_3wt_tile18_sub1    | 1257 nt | AAAA  | TGGA  |
| 3   | 3'WT block        | bsmbi_3wt_tile1_sub4     | 1632 nt | TGGA  | TGCC  |
| 4   | 3'WT block        | bsmbi_3wt_tile1_sub5     | 1647 nt | TGCC  | TGTT  |
| 5   | 3'WT block        | bsmbi_3wt_tile1_sub6     | 573 nt  | TGTT  | CACT  |
| 6   | 3'WT+PolIII block | bsmbi_3wt_tile1_sub7     | 1742 nt | CACT  | CACC  |
| 7   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1 | --      | --    | --    |

```
  [AAAA]----3'WT sub1----[TGGA]----3'WT sub2----[TGCC]----3'WT sub3----[TGTT]----3'WT sub4----[CACT]----3'WT+PolIII sub5----[CACC]
   AAAA                   TGGA                   TGCC                   TGTT                   CACT                          CACC 
   (HF)                   (--)                   (--)                   (--)                   (--)                          (--) 
```

**Set fidelity:** 0.9526 (6 overhangs, 1 in HF set)

---

### Tile 19 of 47 -- Codons 1206-1244 (117 nt)

**Boundary overhangs:**

| Position          | Sequence | In HF Set | Fidelity |
| ----------------- | -------- | --------- | -------- |
| oh1 (5' boundary) | TTTT     | No        | 0.8623   |
| oh2 (3' boundary) | AAAA     | Yes       | 0.9502   |

**Variants:** 7000 mutations, 7000 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name             | Length  | 5' OH | 3' OH |
| --- | --------------- | --------------------- | ------- | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile10_sub1  | 1595 nt | ATGA  | CTCT  |
| 2   | 5'WT gene block | bsai_5wt_tile18_sub2  | 1659 nt | CTCT  | TTGC  |
| 3   | 5'WT gene block | bsai_5wt_tile19_sub3  | 415 nt  | TTGC  | TTTT  |
| 4   | Oligo pool      | Tile 19 (7000 oligos) | 173 nt  | TTTT  | AATA  |
| 5   | Helper plasmid  | helper_plasmid_insert | --      | --    | --    |
| 6   | Enzyme + buffer | BsaI-HFv2 + CutSmart  | --      | --    | --    |

```
  [ATGA]----5'WT sub1----[CTCT]----5'WT sub2----[TTGC]----5'WT sub3----[TTTT]----oligo+BC----[AATA]
   ATGA                   CTCT                   TTGC                   TTTT                  AATA 
   (HF)                   (--)                   (--)                   (--)                  (--) 
```

**Set fidelity:** 0.9846 (5 overhangs, 1 in HF set)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------ | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)      | --      | --    | --    |
| 2   | 3'WT block        | bsmbi_3wt_tile19_sub1    | 1152 nt | AAAA  | TGGA  |
| 3   | 3'WT block        | bsmbi_3wt_tile1_sub4     | 1632 nt | TGGA  | TGCC  |
| 4   | 3'WT block        | bsmbi_3wt_tile1_sub5     | 1647 nt | TGCC  | TGTT  |
| 5   | 3'WT block        | bsmbi_3wt_tile1_sub6     | 573 nt  | TGTT  | CACT  |
| 6   | 3'WT+PolIII block | bsmbi_3wt_tile1_sub7     | 1742 nt | CACT  | CACC  |
| 7   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1 | --      | --    | --    |

```
  [AAAA]----3'WT sub1----[TGGA]----3'WT sub2----[TGCC]----3'WT sub3----[TGTT]----3'WT sub4----[CACT]----3'WT+PolIII sub5----[CACC]
   AAAA                   TGGA                   TGCC                   TGTT                   CACT                          CACC 
   (HF)                   (--)                   (--)                   (--)                   (--)                          (--) 
```

**Set fidelity:** 0.9526 (6 overhangs, 1 in HF set)

---

### Tile 20 of 47 -- Codons 1241-1307 (201 nt)

**Boundary overhangs:**

| Position          | Sequence | In HF Set | Fidelity |
| ----------------- | -------- | --------- | -------- |
| oh1 (5' boundary) | TCTT     | No        | 0.7985   |
| oh2 (3' boundary) | TTAT     | No        | 0.8673   |

**Variants:** 12600 mutations, 12600 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name              | Length  | 5' OH | 3' OH |
| --- | --------------- | ---------------------- | ------- | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile10_sub1   | 1595 nt | ATGA  | CTCT  |
| 2   | 5'WT gene block | bsai_5wt_tile18_sub2   | 1659 nt | CTCT  | TTGC  |
| 3   | 5'WT gene block | bsai_5wt_tile20_sub3   | 520 nt  | TTGC  | TCTT  |
| 4   | Oligo pool      | Tile 20 (12600 oligos) | 257 nt  | TCTT  | AATA  |
| 5   | Helper plasmid  | helper_plasmid_insert  | --      | --    | --    |
| 6   | Enzyme + buffer | BsaI-HFv2 + CutSmart   | --      | --    | --    |

```
  [ATGA]----5'WT sub1----[CTCT]----5'WT sub2----[TTGC]----5'WT sub3----[TCTT]----oligo+BC----[AATA]
   ATGA                   CTCT                   TTGC                   TCTT                  AATA 
   (HF)                   (--)                   (--)                   (--)                  (--) 
```

**Set fidelity:** 0.9682 (5 overhangs, 1 in HF set)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------ | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)      | --      | --    | --    |
| 2   | 3'WT block        | bsmbi_3wt_tile20_sub1    | 963 nt  | TTAT  | TGGA  |
| 3   | 3'WT block        | bsmbi_3wt_tile1_sub4     | 1632 nt | TGGA  | TGCC  |
| 4   | 3'WT block        | bsmbi_3wt_tile1_sub5     | 1647 nt | TGCC  | TGTT  |
| 5   | 3'WT block        | bsmbi_3wt_tile1_sub6     | 573 nt  | TGTT  | CACT  |
| 6   | 3'WT+PolIII block | bsmbi_3wt_tile1_sub7     | 1742 nt | CACT  | CACC  |
| 7   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1 | --      | --    | --    |

```
  [TTAT]----3'WT sub1----[TGGA]----3'WT sub2----[TGCC]----3'WT sub3----[TGTT]----3'WT sub4----[CACT]----3'WT+PolIII sub5----[CACC]
   TTAT                   TGGA                   TGCC                   TGTT                   CACT                          CACC 
   (--)                   (--)                   (--)                   (--)                   (--)                          (--) 
```

**Set fidelity:** 0.9732 (6 overhangs, 0 in HF set)

---

### Tile 21 of 47 -- Codons 1304-1349 (138 nt)

**Boundary overhangs:**

| Position          | Sequence | In HF Set | Fidelity |
| ----------------- | -------- | --------- | -------- |
| oh1 (5' boundary) | GAAA     | No        | 0.8745   |
| oh2 (3' boundary) | CGAA     | No        | 0.7461   |

**Variants:** 8400 mutations, 8400 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name             | Length  | 5' OH | 3' OH |
| --- | --------------- | --------------------- | ------- | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile10_sub1  | 1595 nt | ATGA  | CTCT  |
| 2   | 5'WT gene block | bsai_5wt_tile18_sub2  | 1659 nt | CTCT  | TTGC  |
| 3   | 5'WT gene block | bsai_5wt_tile21_sub3  | 709 nt  | TTGC  | GAAA  |
| 4   | Oligo pool      | Tile 21 (8400 oligos) | 194 nt  | GAAA  | AATA  |
| 5   | Helper plasmid  | helper_plasmid_insert | --      | --    | --    |
| 6   | Enzyme + buffer | BsaI-HFv2 + CutSmart  | --      | --    | --    |

```
  [ATGA]----5'WT sub1----[CTCT]----5'WT sub2----[TTGC]----5'WT sub3----[GAAA]----oligo+BC----[AATA]
   ATGA                   CTCT                   TTGC                   GAAA                  AATA 
   (HF)                   (--)                   (--)                   (--)                  (--) 
```

**Set fidelity:** 0.9807 (5 overhangs, 1 in HF set)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------ | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)      | --      | --    | --    |
| 2   | 3'WT block        | bsmbi_3wt_tile21_sub1    | 837 nt  | CGAA  | TGGA  |
| 3   | 3'WT block        | bsmbi_3wt_tile1_sub4     | 1632 nt | TGGA  | TGCC  |
| 4   | 3'WT block        | bsmbi_3wt_tile1_sub5     | 1647 nt | TGCC  | TGTT  |
| 5   | 3'WT block        | bsmbi_3wt_tile1_sub6     | 573 nt  | TGTT  | CACT  |
| 6   | 3'WT+PolIII block | bsmbi_3wt_tile1_sub7     | 1742 nt | CACT  | CACC  |
| 7   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1 | --      | --    | --    |

```
  [CGAA]----3'WT sub1----[TGGA]----3'WT sub2----[TGCC]----3'WT sub3----[TGTT]----3'WT sub4----[CACT]----3'WT+PolIII sub5----[CACC]
   CGAA                   TGGA                   TGCC                   TGTT                   CACT                          CACC 
   (--)                   (--)                   (--)                   (--)                   (--)                          (--) 
```

**Set fidelity:** 0.9663 (6 overhangs, 0 in HF set)

---

### Tile 22 of 47 -- Codons 1346-1423 (234 nt)

**Boundary overhangs:**

| Position          | Sequence | In HF Set | Fidelity |
| ----------------- | -------- | --------- | -------- |
| oh1 (5' boundary) | GAAA     | No        | 0.8745   |
| oh2 (3' boundary) | TATT     | No        | 0.8134   |

**Variants:** 14800 mutations, 14800 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name              | Length  | 5' OH | 3' OH |
| --- | --------------- | ---------------------- | ------- | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile10_sub1   | 1595 nt | ATGA  | CTCT  |
| 2   | 5'WT gene block | bsai_5wt_tile18_sub2   | 1659 nt | CTCT  | TTGC  |
| 3   | 5'WT gene block | bsai_5wt_tile22_sub3   | 835 nt  | TTGC  | GAAA  |
| 4   | Oligo pool      | Tile 22 (14800 oligos) | 290 nt  | GAAA  | AATA  |
| 5   | Helper plasmid  | helper_plasmid_insert  | --      | --    | --    |
| 6   | Enzyme + buffer | BsaI-HFv2 + CutSmart   | --      | --    | --    |

```
  [ATGA]----5'WT sub1----[CTCT]----5'WT sub2----[TTGC]----5'WT sub3----[GAAA]----oligo+BC----[AATA]
   ATGA                   CTCT                   TTGC                   GAAA                  AATA 
   (HF)                   (--)                   (--)                   (--)                  (--) 
```

**Set fidelity:** 0.9807 (5 overhangs, 1 in HF set)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------ | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)      | --      | --    | --    |
| 2   | 3'WT block        | bsmbi_3wt_tile22_sub1    | 615 nt  | TATT  | TGGA  |
| 3   | 3'WT block        | bsmbi_3wt_tile1_sub4     | 1632 nt | TGGA  | TGCC  |
| 4   | 3'WT block        | bsmbi_3wt_tile1_sub5     | 1647 nt | TGCC  | TGTT  |
| 5   | 3'WT block        | bsmbi_3wt_tile1_sub6     | 573 nt  | TGTT  | CACT  |
| 6   | 3'WT+PolIII block | bsmbi_3wt_tile1_sub7     | 1742 nt | CACT  | CACC  |
| 7   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1 | --      | --    | --    |

```
  [TATT]----3'WT sub1----[TGGA]----3'WT sub2----[TGCC]----3'WT sub3----[TGTT]----3'WT sub4----[CACT]----3'WT+PolIII sub5----[CACC]
   TATT                   TGGA                   TGCC                   TGTT                   CACT                          CACC 
   (--)                   (--)                   (--)                   (--)                   (--)                          (--) 
```

**Set fidelity:** 0.9712 (6 overhangs, 0 in HF set)

---

### Tile 23 of 47 -- Codons 1420-1481 (186 nt)

**Boundary overhangs:**

| Position          | Sequence | In HF Set | Fidelity |
| ----------------- | -------- | --------- | -------- |
| oh1 (5' boundary) | TCCT     | No        | 0.7573   |
| oh2 (3' boundary) | TGAG     | No        | 0.6546   |

**Variants:** 11600 mutations, 11600 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name              | Length  | 5' OH | 3' OH |
| --- | --------------- | ---------------------- | ------- | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile10_sub1   | 1595 nt | ATGA  | CTCT  |
| 2   | 5'WT gene block | bsai_5wt_tile18_sub2   | 1659 nt | CTCT  | TTGC  |
| 3   | 5'WT gene block | bsai_5wt_tile23_sub3   | 1057 nt | TTGC  | TCCT  |
| 4   | Oligo pool      | Tile 23 (11600 oligos) | 242 nt  | TCCT  | AATA  |
| 5   | Helper plasmid  | helper_plasmid_insert  | --      | --    | --    |
| 6   | Enzyme + buffer | BsaI-HFv2 + CutSmart   | --      | --    | --    |

```
  [ATGA]----5'WT sub1----[CTCT]----5'WT sub2----[TTGC]----5'WT sub3----[TCCT]----oligo+BC----[AATA]
   ATGA                   CTCT                   TTGC                   TCCT                  AATA 
   (HF)                   (--)                   (--)                   (--)                  (--) 
```

**Set fidelity:** 0.9768 (5 overhangs, 1 in HF set)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------ | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)      | --      | --    | --    |
| 2   | 3'WT block        | bsmbi_3wt_tile23_sub1    | 441 nt  | TGAG  | TGGA  |
| 3   | 3'WT block        | bsmbi_3wt_tile1_sub4     | 1632 nt | TGGA  | TGCC  |
| 4   | 3'WT block        | bsmbi_3wt_tile1_sub5     | 1647 nt | TGCC  | TGTT  |
| 5   | 3'WT block        | bsmbi_3wt_tile1_sub6     | 573 nt  | TGTT  | CACT  |
| 6   | 3'WT+PolIII block | bsmbi_3wt_tile1_sub7     | 1742 nt | CACT  | CACC  |
| 7   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1 | --      | --    | --    |

```
  [TGAG]----3'WT sub1----[TGGA]----3'WT sub2----[TGCC]----3'WT sub3----[TGTT]----3'WT sub4----[CACT]----3'WT+PolIII sub5----[CACC]
   TGAG                   TGGA                   TGCC                   TGTT                   CACT                          CACC 
   (--)                   (--)                   (--)                   (--)                   (--)                          (--) 
```

**Set fidelity:** 0.9575 (6 overhangs, 0 in HF set)

---

### Tile 24 of 47 -- Codons 1478-1555 (234 nt)

**Boundary overhangs:**

| Position          | Sequence | In HF Set | Fidelity |
| ----------------- | -------- | --------- | -------- |
| oh1 (5' boundary) | GAAA     | No        | 0.8745   |
| oh2 (3' boundary) | ATTT     | No        | 0.7664   |

**Variants:** 14800 mutations, 14800 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name              | Length  | 5' OH | 3' OH |
| --- | --------------- | ---------------------- | ------- | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile10_sub1   | 1595 nt | ATGA  | CTCT  |
| 2   | 5'WT gene block | bsai_5wt_tile18_sub2   | 1659 nt | CTCT  | TTGC  |
| 3   | 5'WT gene block | bsai_5wt_tile24_sub3   | 1231 nt | TTGC  | GAAA  |
| 4   | Oligo pool      | Tile 24 (14800 oligos) | 290 nt  | GAAA  | AATA  |
| 5   | Helper plasmid  | helper_plasmid_insert  | --      | --    | --    |
| 6   | Enzyme + buffer | BsaI-HFv2 + CutSmart   | --      | --    | --    |

```
  [ATGA]----5'WT sub1----[CTCT]----5'WT sub2----[TTGC]----5'WT sub3----[GAAA]----oligo+BC----[AATA]
   ATGA                   CTCT                   TTGC                   GAAA                  AATA 
   (HF)                   (--)                   (--)                   (--)                  (--) 
```

**Set fidelity:** 0.9807 (5 overhangs, 1 in HF set)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------ | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)      | --      | --    | --    |
| 2   | 3'WT block        | bsmbi_3wt_tile24_sub1    | 219 nt  | ATTT  | TGGA  |
| 3   | 3'WT block        | bsmbi_3wt_tile1_sub4     | 1632 nt | TGGA  | TGCC  |
| 4   | 3'WT block        | bsmbi_3wt_tile1_sub5     | 1647 nt | TGCC  | TGTT  |
| 5   | 3'WT block        | bsmbi_3wt_tile1_sub6     | 573 nt  | TGTT  | CACT  |
| 6   | 3'WT+PolIII block | bsmbi_3wt_tile1_sub7     | 1742 nt | CACT  | CACC  |
| 7   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1 | --      | --    | --    |

```
  [ATTT]----3'WT sub1----[TGGA]----3'WT sub2----[TGCC]----3'WT sub3----[TGTT]----3'WT sub4----[CACT]----3'WT+PolIII sub5----[CACC]
   ATTT                   TGGA                   TGCC                   TGTT                   CACT                          CACC 
   (--)                   (--)                   (--)                   (--)                   (--)                          (--) 
```

**Set fidelity:** 0.9668 (6 overhangs, 0 in HF set)

---

### Tile 25 of 47 -- Codons 1552-1622 (213 nt)

**Boundary overhangs:**

| Position          | Sequence | In HF Set | Fidelity |
| ----------------- | -------- | --------- | -------- |
| oh1 (5' boundary) | CCTT     | No        | 0.6891   |
| oh2 (3' boundary) | TGGA     | No        | 0.7377   |

**Variants:** 13400 mutations, 13400 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name              | Length  | 5' OH | 3' OH |
| --- | --------------- | ---------------------- | ------- | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile10_sub1   | 1595 nt | ATGA  | CTCT  |
| 2   | 5'WT gene block | bsai_5wt_tile18_sub2   | 1659 nt | CTCT  | TTGC  |
| 3   | 5'WT gene block | bsai_5wt_tile25_sub3   | 1453 nt | TTGC  | CCTT  |
| 4   | Oligo pool      | Tile 25 (13400 oligos) | 269 nt  | CCTT  | AATA  |
| 5   | Helper plasmid  | helper_plasmid_insert  | --      | --    | --    |
| 6   | Enzyme + buffer | BsaI-HFv2 + CutSmart   | --      | --    | --    |

```
  [ATGA]----5'WT sub1----[CTCT]----5'WT sub2----[TTGC]----5'WT sub3----[CCTT]----oligo+BC----[AATA]
   ATGA                   CTCT                   TTGC                   CCTT                  AATA 
   (HF)                   (--)                   (--)                   (--)                  (--) 
```

**Set fidelity:** 0.9919 (5 overhangs, 1 in HF set)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------ | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)      | --      | --    | --    |
| 2   | 3'WT block        | bsmbi_3wt_tile1_sub4     | 1632 nt | TGGA  | TGCC  |
| 3   | 3'WT block        | bsmbi_3wt_tile1_sub5     | 1647 nt | TGCC  | TGTT  |
| 4   | 3'WT block        | bsmbi_3wt_tile1_sub6     | 573 nt  | TGTT  | CACT  |
| 5   | 3'WT+PolIII block | bsmbi_3wt_tile1_sub7     | 1742 nt | CACT  | CACC  |
| 6   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1 | --      | --    | --    |

```
  [TGGA]----3'WT sub1----[TGCC]----3'WT sub2----[TGTT]----3'WT sub3----[CACT]----3'WT+PolIII sub4----[CACC]
   TGGA                   TGCC                   TGTT                   CACT                          CACC 
   (--)                   (--)                   (--)                   (--)                          (--) 
```

**Set fidelity:** 0.9738 (5 overhangs, 0 in HF set)

---

### Tile 26 of 47 -- Codons 1619-1687 (207 nt)

**Boundary overhangs:**

| Position          | Sequence | In HF Set | Fidelity |
| ----------------- | -------- | --------- | -------- |
| oh1 (5' boundary) | AGGA     | Yes       | 0.7515   |
| oh2 (3' boundary) | GGAG     | No        | 0.5228   |

**Variants:** 13000 mutations, 13000 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name              | Length  | 5' OH | 3' OH |
| --- | --------------- | ---------------------- | ------- | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile10_sub1   | 1595 nt | ATGA  | CTCT  |
| 2   | 5'WT gene block | bsai_5wt_tile18_sub2   | 1659 nt | CTCT  | TTGC  |
| 3   | 5'WT gene block | bsai_5wt_tile26_sub3   | 1654 nt | TTGC  | AGGA  |
| 4   | Oligo pool      | Tile 26 (13000 oligos) | 263 nt  | AGGA  | AATA  |
| 5   | Helper plasmid  | helper_plasmid_insert  | --      | --    | --    |
| 6   | Enzyme + buffer | BsaI-HFv2 + CutSmart   | --      | --    | --    |

```
  [ATGA]----5'WT sub1----[CTCT]----5'WT sub2----[TTGC]----5'WT sub3----[AGGA]----oligo+BC----[AATA]
   ATGA                   CTCT                   TTGC                   AGGA                  AATA 
   (HF)                   (--)                   (--)                   (HF)                  (--) 
```

**Set fidelity:** 0.9940 (5 overhangs, 2 in HF set)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------ | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)      | --      | --    | --    |
| 2   | 3'WT block        | bsmbi_3wt_tile26_sub1    | 1437 nt | GGAG  | TGCC  |
| 3   | 3'WT block        | bsmbi_3wt_tile1_sub5     | 1647 nt | TGCC  | TGTT  |
| 4   | 3'WT block        | bsmbi_3wt_tile1_sub6     | 573 nt  | TGTT  | CACT  |
| 5   | 3'WT+PolIII block | bsmbi_3wt_tile1_sub7     | 1742 nt | CACT  | CACC  |
| 6   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1 | --      | --    | --    |

```
  [GGAG]----3'WT sub1----[TGCC]----3'WT sub2----[TGTT]----3'WT sub3----[CACT]----3'WT+PolIII sub4----[CACC]
   GGAG                   TGCC                   TGTT                   CACT                          CACC 
   (--)                   (--)                   (--)                   (--)                          (--) 
```

**Set fidelity:** 0.8933 (5 overhangs, 0 in HF set)

---

### Tile 27 of 47 -- Codons 1684-1761 (234 nt)

**Boundary overhangs:**

| Position          | Sequence | In HF Set | Fidelity |
| ----------------- | -------- | --------- | -------- |
| oh1 (5' boundary) | GAAG     | No        | 0.6752   |
| oh2 (3' boundary) | CCAG     | Yes       | 0.6122   |

**Variants:** 14800 mutations, 14800 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name              | Length  | 5' OH | 3' OH |
| --- | --------------- | ---------------------- | ------- | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile10_sub1   | 1595 nt | ATGA  | CTCT  |
| 2   | 5'WT gene block | bsai_5wt_tile18_sub2   | 1659 nt | CTCT  | TTGC  |
| 3   | 5'WT gene block | bsai_5wt_tile27_sub3   | 1662 nt | TTGC  | TGGA  |
| 4   | 5'WT gene block | bsai_5wt_tile27_sub4   | 205 nt  | TGGA  | GAAG  |
| 5   | Oligo pool      | Tile 27 (14800 oligos) | 290 nt  | GAAG  | AATA  |
| 6   | Helper plasmid  | helper_plasmid_insert  | --      | --    | --    |
| 7   | Enzyme + buffer | BsaI-HFv2 + CutSmart   | --      | --    | --    |

```
  [ATGA]----5'WT sub1----[CTCT]----5'WT sub2----[TTGC]----5'WT sub3----[TGGA]----5'WT sub4----[GAAG]----oligo+BC----[AATA]
   ATGA                   CTCT                   TTGC                   TGGA                   GAAG                  AATA 
   (HF)                   (--)                   (--)                   (--)                   (--)                  (--) 
```

**Set fidelity:** 0.9870 (6 overhangs, 1 in HF set)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------ | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)      | --      | --    | --    |
| 2   | 3'WT block        | bsmbi_3wt_tile27_sub1    | 1215 nt | CCAG  | TGCC  |
| 3   | 3'WT block        | bsmbi_3wt_tile1_sub5     | 1647 nt | TGCC  | TGTT  |
| 4   | 3'WT block        | bsmbi_3wt_tile1_sub6     | 573 nt  | TGTT  | CACT  |
| 5   | 3'WT+PolIII block | bsmbi_3wt_tile1_sub7     | 1742 nt | CACT  | CACC  |
| 6   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1 | --      | --    | --    |

```
  [CCAG]----3'WT sub1----[TGCC]----3'WT sub2----[TGTT]----3'WT sub3----[CACT]----3'WT+PolIII sub4----[CACC]
   CCAG                   TGCC                   TGTT                   CACT                          CACC 
   (HF)                   (--)                   (--)                   (--)                          (--) 
```

**Set fidelity:** 0.9787 (5 overhangs, 1 in HF set)

---

### Tile 28 of 47 -- Codons 1758-1831 (222 nt)

**Boundary overhangs:**

| Position          | Sequence | In HF Set | Fidelity |
| ----------------- | -------- | --------- | -------- |
| oh1 (5' boundary) | ATCG     | No        | 0.5700   |
| oh2 (3' boundary) | CGAG     | No        | 0.5351   |

**Variants:** 14000 mutations, 14000 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name              | Length  | 5' OH | 3' OH |
| --- | --------------- | ---------------------- | ------- | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile10_sub1   | 1595 nt | ATGA  | CTCT  |
| 2   | 5'WT gene block | bsai_5wt_tile18_sub2   | 1659 nt | CTCT  | TTGC  |
| 3   | 5'WT gene block | bsai_5wt_tile27_sub3   | 1662 nt | TTGC  | TGGA  |
| 4   | 5'WT gene block | bsai_5wt_tile28_sub4   | 427 nt  | TGGA  | ATCG  |
| 5   | Oligo pool      | Tile 28 (14000 oligos) | 278 nt  | ATCG  | AATA  |
| 6   | Helper plasmid  | helper_plasmid_insert  | --      | --    | --    |
| 7   | Enzyme + buffer | BsaI-HFv2 + CutSmart   | --      | --    | --    |

```
  [ATGA]----5'WT sub1----[CTCT]----5'WT sub2----[TTGC]----5'WT sub3----[TGGA]----5'WT sub4----[ATCG]----oligo+BC----[AATA]
   ATGA                   CTCT                   TTGC                   TGGA                   ATCG                  AATA 
   (HF)                   (--)                   (--)                   (--)                   (--)                  (--) 
```

**Set fidelity:** 0.9897 (6 overhangs, 1 in HF set)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------ | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)      | --      | --    | --    |
| 2   | 3'WT block        | bsmbi_3wt_tile28_sub1    | 1005 nt | CGAG  | TGCC  |
| 3   | 3'WT block        | bsmbi_3wt_tile1_sub5     | 1647 nt | TGCC  | TGTT  |
| 4   | 3'WT block        | bsmbi_3wt_tile1_sub6     | 573 nt  | TGTT  | CACT  |
| 5   | 3'WT+PolIII block | bsmbi_3wt_tile1_sub7     | 1742 nt | CACT  | CACC  |
| 6   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1 | --      | --    | --    |

```
  [CGAG]----3'WT sub1----[TGCC]----3'WT sub2----[TGTT]----3'WT sub3----[CACT]----3'WT+PolIII sub4----[CACC]
   CGAG                   TGCC                   TGTT                   CACT                          CACC 
   (--)                   (--)                   (--)                   (--)                          (--) 
```

**Set fidelity:** 0.9619 (5 overhangs, 0 in HF set)

---

### Tile 29 of 47 -- Codons 1828-1905 (234 nt)

**Boundary overhangs:**

| Position          | Sequence | In HF Set | Fidelity |
| ----------------- | -------- | --------- | -------- |
| oh1 (5' boundary) | GAAA     | No        | 0.8745   |
| oh2 (3' boundary) | GAGT     | No        | 0.6209   |

**Variants:** 14800 mutations, 14800 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name              | Length  | 5' OH | 3' OH |
| --- | --------------- | ---------------------- | ------- | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile10_sub1   | 1595 nt | ATGA  | CTCT  |
| 2   | 5'WT gene block | bsai_5wt_tile18_sub2   | 1659 nt | CTCT  | TTGC  |
| 3   | 5'WT gene block | bsai_5wt_tile27_sub3   | 1662 nt | TTGC  | TGGA  |
| 4   | 5'WT gene block | bsai_5wt_tile29_sub4   | 637 nt  | TGGA  | GAAA  |
| 5   | Oligo pool      | Tile 29 (14800 oligos) | 290 nt  | GAAA  | AATA  |
| 6   | Helper plasmid  | helper_plasmid_insert  | --      | --    | --    |
| 7   | Enzyme + buffer | BsaI-HFv2 + CutSmart   | --      | --    | --    |

```
  [ATGA]----5'WT sub1----[CTCT]----5'WT sub2----[TTGC]----5'WT sub3----[TGGA]----5'WT sub4----[GAAA]----oligo+BC----[AATA]
   ATGA                   CTCT                   TTGC                   TGGA                   GAAA                  AATA 
   (HF)                   (--)                   (--)                   (--)                   (--)                  (--) 
```

**Set fidelity:** 0.9788 (6 overhangs, 1 in HF set)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------ | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)      | --      | --    | --    |
| 2   | 3'WT block        | bsmbi_3wt_tile29_sub1    | 783 nt  | GAGT  | TGCC  |
| 3   | 3'WT block        | bsmbi_3wt_tile1_sub5     | 1647 nt | TGCC  | TGTT  |
| 4   | 3'WT block        | bsmbi_3wt_tile1_sub6     | 573 nt  | TGTT  | CACT  |
| 5   | 3'WT+PolIII block | bsmbi_3wt_tile1_sub7     | 1742 nt | CACT  | CACC  |
| 6   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1 | --      | --    | --    |

```
  [GAGT]----3'WT sub1----[TGCC]----3'WT sub2----[TGTT]----3'WT sub3----[CACT]----3'WT+PolIII sub4----[CACC]
   GAGT                   TGCC                   TGTT                   CACT                          CACC 
   (--)                   (--)                   (--)                   (--)                          (--) 
```

**Set fidelity:** 0.9782 (5 overhangs, 0 in HF set)

---

### Tile 30 of 47 -- Codons 1902-1972 (213 nt)

**Boundary overhangs:**

| Position          | Sequence | In HF Set | Fidelity |
| ----------------- | -------- | --------- | -------- |
| oh1 (5' boundary) | GAAA     | No        | 0.8745   |
| oh2 (3' boundary) | CTAC     | No        | 0.6583   |

**Variants:** 13400 mutations, 13400 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name              | Length  | 5' OH | 3' OH |
| --- | --------------- | ---------------------- | ------- | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile10_sub1   | 1595 nt | ATGA  | CTCT  |
| 2   | 5'WT gene block | bsai_5wt_tile18_sub2   | 1659 nt | CTCT  | TTGC  |
| 3   | 5'WT gene block | bsai_5wt_tile27_sub3   | 1662 nt | TTGC  | TGGA  |
| 4   | 5'WT gene block | bsai_5wt_tile30_sub4   | 859 nt  | TGGA  | GAAA  |
| 5   | Oligo pool      | Tile 30 (13400 oligos) | 269 nt  | GAAA  | AATA  |
| 6   | Helper plasmid  | helper_plasmid_insert  | --      | --    | --    |
| 7   | Enzyme + buffer | BsaI-HFv2 + CutSmart   | --      | --    | --    |

```
  [ATGA]----5'WT sub1----[CTCT]----5'WT sub2----[TTGC]----5'WT sub3----[TGGA]----5'WT sub4----[GAAA]----oligo+BC----[AATA]
   ATGA                   CTCT                   TTGC                   TGGA                   GAAA                  AATA 
   (HF)                   (--)                   (--)                   (--)                   (--)                  (--) 
```

**Set fidelity:** 0.9788 (6 overhangs, 1 in HF set)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------ | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)      | --      | --    | --    |
| 2   | 3'WT block        | bsmbi_3wt_tile30_sub1    | 582 nt  | CTAC  | TGCC  |
| 3   | 3'WT block        | bsmbi_3wt_tile1_sub5     | 1647 nt | TGCC  | TGTT  |
| 4   | 3'WT block        | bsmbi_3wt_tile1_sub6     | 573 nt  | TGTT  | CACT  |
| 5   | 3'WT+PolIII block | bsmbi_3wt_tile1_sub7     | 1742 nt | CACT  | CACC  |
| 6   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1 | --      | --    | --    |

```
  [CTAC]----3'WT sub1----[TGCC]----3'WT sub2----[TGTT]----3'WT sub3----[CACT]----3'WT+PolIII sub4----[CACC]
   CTAC                   TGCC                   TGTT                   CACT                          CACC 
   (--)                   (--)                   (--)                   (--)                          (--) 
```

**Set fidelity:** 0.9806 (5 overhangs, 0 in HF set)

---

### Tile 31 of 47 -- Codons 1969-2045 (231 nt)

**Boundary overhangs:**

| Position          | Sequence | In HF Set | Fidelity |
| ----------------- | -------- | --------- | -------- |
| oh1 (5' boundary) | AGAA     | No        | 0.8847   |
| oh2 (3' boundary) | AGGA     | Yes       | 0.7515   |

**Variants:** 14600 mutations, 14600 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name              | Length  | 5' OH | 3' OH |
| --- | --------------- | ---------------------- | ------- | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile10_sub1   | 1595 nt | ATGA  | CTCT  |
| 2   | 5'WT gene block | bsai_5wt_tile18_sub2   | 1659 nt | CTCT  | TTGC  |
| 3   | 5'WT gene block | bsai_5wt_tile27_sub3   | 1662 nt | TTGC  | TGGA  |
| 4   | 5'WT gene block | bsai_5wt_tile31_sub4   | 1060 nt | TGGA  | AGAA  |
| 5   | Oligo pool      | Tile 31 (14600 oligos) | 287 nt  | AGAA  | AATA  |
| 6   | Helper plasmid  | helper_plasmid_insert  | --      | --    | --    |
| 7   | Enzyme + buffer | BsaI-HFv2 + CutSmart   | --      | --    | --    |

```
  [ATGA]----5'WT sub1----[CTCT]----5'WT sub2----[TTGC]----5'WT sub3----[TGGA]----5'WT sub4----[AGAA]----oligo+BC----[AATA]
   ATGA                   CTCT                   TTGC                   TGGA                   AGAA                  AATA 
   (HF)                   (--)                   (--)                   (--)                   (--)                  (--) 
```

**Set fidelity:** 0.9714 (6 overhangs, 1 in HF set)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------ | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)      | --      | --    | --    |
| 2   | 3'WT block        | bsmbi_3wt_tile31_sub1    | 363 nt  | AGGA  | TGCC  |
| 3   | 3'WT block        | bsmbi_3wt_tile1_sub5     | 1647 nt | TGCC  | TGTT  |
| 4   | 3'WT block        | bsmbi_3wt_tile1_sub6     | 573 nt  | TGTT  | CACT  |
| 5   | 3'WT+PolIII block | bsmbi_3wt_tile1_sub7     | 1742 nt | CACT  | CACC  |
| 6   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1 | --      | --    | --    |

```
  [AGGA]----3'WT sub1----[TGCC]----3'WT sub2----[TGTT]----3'WT sub3----[CACT]----3'WT+PolIII sub4----[CACC]
   AGGA                   TGCC                   TGTT                   CACT                          CACC 
   (HF)                   (--)                   (--)                   (--)                          (--) 
```

**Set fidelity:** 0.9659 (5 overhangs, 1 in HF set)

---

### Tile 32 of 47 -- Codons 2042-2106 (195 nt)

**Boundary overhangs:**

| Position          | Sequence | In HF Set | Fidelity |
| ----------------- | -------- | --------- | -------- |
| oh1 (5' boundary) | GAAA     | No        | 0.8745   |
| oh2 (3' boundary) | GAAG     | No        | 0.6752   |

**Variants:** 12200 mutations, 12200 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name              | Length  | 5' OH | 3' OH |
| --- | --------------- | ---------------------- | ------- | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile10_sub1   | 1595 nt | ATGA  | CTCT  |
| 2   | 5'WT gene block | bsai_5wt_tile18_sub2   | 1659 nt | CTCT  | TTGC  |
| 3   | 5'WT gene block | bsai_5wt_tile27_sub3   | 1662 nt | TTGC  | TGGA  |
| 4   | 5'WT gene block | bsai_5wt_tile32_sub4   | 1279 nt | TGGA  | GAAA  |
| 5   | Oligo pool      | Tile 32 (12200 oligos) | 251 nt  | GAAA  | AATA  |
| 6   | Helper plasmid  | helper_plasmid_insert  | --      | --    | --    |
| 7   | Enzyme + buffer | BsaI-HFv2 + CutSmart   | --      | --    | --    |

```
  [ATGA]----5'WT sub1----[CTCT]----5'WT sub2----[TTGC]----5'WT sub3----[TGGA]----5'WT sub4----[GAAA]----oligo+BC----[AATA]
   ATGA                   CTCT                   TTGC                   TGGA                   GAAA                  AATA 
   (HF)                   (--)                   (--)                   (--)                   (--)                  (--) 
```

**Set fidelity:** 0.9788 (6 overhangs, 1 in HF set)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------ | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)      | --      | --    | --    |
| 2   | 3'WT block        | bsmbi_3wt_tile32_sub1    | 180 nt  | GAAG  | TGCC  |
| 3   | 3'WT block        | bsmbi_3wt_tile1_sub5     | 1647 nt | TGCC  | TGTT  |
| 4   | 3'WT block        | bsmbi_3wt_tile1_sub6     | 573 nt  | TGTT  | CACT  |
| 5   | 3'WT+PolIII block | bsmbi_3wt_tile1_sub7     | 1742 nt | CACT  | CACC  |
| 6   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1 | --      | --    | --    |

```
  [GAAG]----3'WT sub1----[TGCC]----3'WT sub2----[TGTT]----3'WT sub3----[CACT]----3'WT+PolIII sub4----[CACC]
   GAAG                   TGCC                   TGTT                   CACT                          CACC 
   (--)                   (--)                   (--)                   (--)                          (--) 
```

**Set fidelity:** 0.9704 (5 overhangs, 0 in HF set)

---

### Tile 33 of 47 -- Codons 2103-2160 (174 nt)

**Boundary overhangs:**

| Position          | Sequence | In HF Set | Fidelity |
| ----------------- | -------- | --------- | -------- |
| oh1 (5' boundary) | AGAA     | No        | 0.8847   |
| oh2 (3' boundary) | TGCC     | No        | 0.5867   |

**Variants:** 10800 mutations, 10800 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name              | Length  | 5' OH | 3' OH |
| --- | --------------- | ---------------------- | ------- | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile10_sub1   | 1595 nt | ATGA  | CTCT  |
| 2   | 5'WT gene block | bsai_5wt_tile18_sub2   | 1659 nt | CTCT  | TTGC  |
| 3   | 5'WT gene block | bsai_5wt_tile27_sub3   | 1662 nt | TTGC  | TGGA  |
| 4   | 5'WT gene block | bsai_5wt_tile33_sub4   | 1462 nt | TGGA  | AGAA  |
| 5   | Oligo pool      | Tile 33 (10800 oligos) | 230 nt  | AGAA  | AATA  |
| 6   | Helper plasmid  | helper_plasmid_insert  | --      | --    | --    |
| 7   | Enzyme + buffer | BsaI-HFv2 + CutSmart   | --      | --    | --    |

```
  [ATGA]----5'WT sub1----[CTCT]----5'WT sub2----[TTGC]----5'WT sub3----[TGGA]----5'WT sub4----[AGAA]----oligo+BC----[AATA]
   ATGA                   CTCT                   TTGC                   TGGA                   AGAA                  AATA 
   (HF)                   (--)                   (--)                   (--)                   (--)                  (--) 
```

**Set fidelity:** 0.9714 (6 overhangs, 1 in HF set)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------ | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)      | --      | --    | --    |
| 2   | 3'WT block        | bsmbi_3wt_tile1_sub5     | 1647 nt | TGCC  | TGTT  |
| 3   | 3'WT block        | bsmbi_3wt_tile1_sub6     | 573 nt  | TGTT  | CACT  |
| 4   | 3'WT+PolIII block | bsmbi_3wt_tile1_sub7     | 1742 nt | CACT  | CACC  |
| 5   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1 | --      | --    | --    |

```
  [TGCC]----3'WT sub1----[TGTT]----3'WT sub2----[CACT]----3'WT+PolIII sub3----[CACC]
   TGCC                   TGTT                   CACT                          CACC 
   (--)                   (--)                   (--)                          (--) 
```

**Set fidelity:** 0.9811 (4 overhangs, 0 in HF set)

---

### Tile 34 of 47 -- Codons 2157-2218 (186 nt)

**Boundary overhangs:**

| Position          | Sequence | In HF Set | Fidelity |
| ----------------- | -------- | --------- | -------- |
| oh1 (5' boundary) | AAAA     | Yes       | 0.9502   |
| oh2 (3' boundary) | TATC     | No        | 0.8041   |

**Variants:** 11600 mutations, 11600 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name              | Length  | 5' OH | 3' OH |
| --- | --------------- | ---------------------- | ------- | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile10_sub1   | 1595 nt | ATGA  | CTCT  |
| 2   | 5'WT gene block | bsai_5wt_tile18_sub2   | 1659 nt | CTCT  | TTGC  |
| 3   | 5'WT gene block | bsai_5wt_tile27_sub3   | 1662 nt | TTGC  | TGGA  |
| 4   | 5'WT gene block | bsai_5wt_tile34_sub4   | 1624 nt | TGGA  | AAAA  |
| 5   | Oligo pool      | Tile 34 (11600 oligos) | 242 nt  | AAAA  | AATA  |
| 6   | Helper plasmid  | helper_plasmid_insert  | --      | --    | --    |
| 7   | Enzyme + buffer | BsaI-HFv2 + CutSmart   | --      | --    | --    |

```
  [ATGA]----5'WT sub1----[CTCT]----5'WT sub2----[TTGC]----5'WT sub3----[TGGA]----5'WT sub4----[AAAA]----oligo+BC----[AATA]
   ATGA                   CTCT                   TTGC                   TGGA                   AAAA                  AATA 
   (HF)                   (--)                   (--)                   (--)                   (HF)                  (--) 
```

**Set fidelity:** 0.9916 (6 overhangs, 2 in HF set)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------ | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)      | --      | --    | --    |
| 2   | 3'WT block        | bsmbi_3wt_tile34_sub1    | 1473 nt | TATC  | TGTT  |
| 3   | 3'WT block        | bsmbi_3wt_tile1_sub6     | 573 nt  | TGTT  | CACT  |
| 4   | 3'WT+PolIII block | bsmbi_3wt_tile1_sub7     | 1742 nt | CACT  | CACC  |
| 5   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1 | --      | --    | --    |

```
  [TATC]----3'WT sub1----[TGTT]----3'WT sub2----[CACT]----3'WT+PolIII sub3----[CACC]
   TATC                   TGTT                   CACT                          CACC 
   (--)                   (--)                   (--)                          (--) 
```

**Set fidelity:** 0.9820 (4 overhangs, 0 in HF set)

---

### Tile 35 of 47 -- Codons 2215-2279 (195 nt)

**Boundary overhangs:**

| Position          | Sequence | In HF Set | Fidelity |
| ----------------- | -------- | --------- | -------- |
| oh1 (5' boundary) | AAGA     | No        | 0.9209   |
| oh2 (3' boundary) | TGCC     | No        | 0.5867   |

**Variants:** 12200 mutations, 12200 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name              | Length  | 5' OH | 3' OH |
| --- | --------------- | ---------------------- | ------- | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile10_sub1   | 1595 nt | ATGA  | CTCT  |
| 2   | 5'WT gene block | bsai_5wt_tile18_sub2   | 1659 nt | CTCT  | TTGC  |
| 3   | 5'WT gene block | bsai_5wt_tile27_sub3   | 1662 nt | TTGC  | TGGA  |
| 4   | 5'WT gene block | bsai_5wt_tile35_sub4   | 1798 nt | TGGA  | AAGA  |
| 5   | Oligo pool      | Tile 35 (12200 oligos) | 251 nt  | AAGA  | AATA  |
| 6   | Helper plasmid  | helper_plasmid_insert  | --      | --    | --    |
| 7   | Enzyme + buffer | BsaI-HFv2 + CutSmart   | --      | --    | --    |

```
  [ATGA]----5'WT sub1----[CTCT]----5'WT sub2----[TTGC]----5'WT sub3----[TGGA]----5'WT sub4----[TGCC]----oligo+BC----[AAGA][AATA]
   ATGA                   CTCT                   TTGC                   TGGA                   TGCC                  AAGA  AATA 
   (HF)                   (--)                   (--)                   (--)                   (--)                  (--)  (--) 
```

**Set fidelity:** 0.9876 (7 overhangs, 1 in HF set)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------ | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)      | --      | --    | --    |
| 2   | 3'WT block        | bsmbi_3wt_tile35_sub1    | 1290 nt | TGCC  | TGTT  |
| 3   | 3'WT block        | bsmbi_3wt_tile1_sub6     | 573 nt  | TGTT  | CACT  |
| 4   | 3'WT+PolIII block | bsmbi_3wt_tile1_sub7     | 1742 nt | CACT  | CACC  |
| 5   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1 | --      | --    | --    |

```
  [TGCC]----3'WT sub1----[TGTT]----3'WT sub2----[CACT]----3'WT+PolIII sub3----[CACC]
   TGCC                   TGTT                   CACT                          CACC 
   (--)                   (--)                   (--)                          (--) 
```

**Set fidelity:** 0.9811 (4 overhangs, 0 in HF set)

---

### Tile 36 of 47 -- Codons 2276-2353 (234 nt)

**Boundary overhangs:**

| Position          | Sequence | In HF Set | Fidelity |
| ----------------- | -------- | --------- | -------- |
| oh1 (5' boundary) | TTTT     | No        | 0.8623   |
| oh2 (3' boundary) | TGTC     | No        | 0.6650   |

**Variants:** 14800 mutations, 14800 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name              | Length  | 5' OH | 3' OH |
| --- | --------------- | ---------------------- | ------- | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile10_sub1   | 1595 nt | ATGA  | CTCT  |
| 2   | 5'WT gene block | bsai_5wt_tile18_sub2   | 1659 nt | CTCT  | TTGC  |
| 3   | 5'WT gene block | bsai_5wt_tile27_sub3   | 1662 nt | TTGC  | TGGA  |
| 4   | 5'WT gene block | bsai_5wt_tile36_sub4   | 1632 nt | TGGA  | TGCC  |
| 5   | 5'WT gene block | bsai_5wt_tile36_sub5   | 367 nt  | TGCC  | TTTT  |
| 6   | Oligo pool      | Tile 36 (14800 oligos) | 290 nt  | TTTT  | AATA  |
| 7   | Helper plasmid  | helper_plasmid_insert  | --      | --    | --    |
| 8   | Enzyme + buffer | BsaI-HFv2 + CutSmart   | --      | --    | --    |

```
  [ATGA]----5'WT sub1----[CTCT]----5'WT sub2----[TTGC]----5'WT sub3----[TGGA]----5'WT sub4----[TGCC]----5'WT sub5----[TTTT]----oligo+BC----[AATA]
   ATGA                   CTCT                   TTGC                   TGGA                   TGCC                   TTTT                  AATA 
   (HF)                   (--)                   (--)                   (--)                   (--)                   (--)                  (--) 
```

**Set fidelity:** 0.9752 (7 overhangs, 1 in HF set)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------ | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)      | --      | --    | --    |
| 2   | 3'WT block        | bsmbi_3wt_tile36_sub1    | 1068 nt | TGTC  | TGTT  |
| 3   | 3'WT block        | bsmbi_3wt_tile1_sub6     | 573 nt  | TGTT  | CACT  |
| 4   | 3'WT+PolIII block | bsmbi_3wt_tile1_sub7     | 1742 nt | CACT  | CACC  |
| 5   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1 | --      | --    | --    |

```
  [TGTC]----3'WT sub1----[TGTT]----3'WT sub2----[CACT]----3'WT+PolIII sub3----[CACC]
   TGTC                   TGTT                   CACT                          CACC 
   (--)                   (--)                   (--)                          (--) 
```

**Set fidelity:** 0.9692 (4 overhangs, 0 in HF set)

---

### Tile 37 of 47 -- Codons 2350-2419 (210 nt)

**Boundary overhangs:**

| Position          | Sequence | In HF Set | Fidelity |
| ----------------- | -------- | --------- | -------- |
| oh1 (5' boundary) | CCCG     | No        | 0.5823   |
| oh2 (3' boundary) | CAGG     | No        | 0.5358   |

**Variants:** 13200 mutations, 13200 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name              | Length  | 5' OH | 3' OH |
| --- | --------------- | ---------------------- | ------- | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile10_sub1   | 1595 nt | ATGA  | CTCT  |
| 2   | 5'WT gene block | bsai_5wt_tile18_sub2   | 1659 nt | CTCT  | TTGC  |
| 3   | 5'WT gene block | bsai_5wt_tile27_sub3   | 1662 nt | TTGC  | TGGA  |
| 4   | 5'WT gene block | bsai_5wt_tile36_sub4   | 1632 nt | TGGA  | TGCC  |
| 5   | 5'WT gene block | bsai_5wt_tile37_sub5   | 589 nt  | TGCC  | CCCG  |
| 6   | Oligo pool      | Tile 37 (13200 oligos) | 266 nt  | CCCG  | AATA  |
| 7   | Helper plasmid  | helper_plasmid_insert  | --      | --    | --    |
| 8   | Enzyme + buffer | BsaI-HFv2 + CutSmart   | --      | --    | --    |

```
  [ATGA]----5'WT sub1----[CTCT]----5'WT sub2----[TTGC]----5'WT sub3----[TGGA]----5'WT sub4----[TGCC]----5'WT sub5----[CCCG]----oligo+BC----[AATA]
   ATGA                   CTCT                   TTGC                   TGGA                   TGCC                   CCCG                  AATA 
   (HF)                   (--)                   (--)                   (--)                   (--)                   (--)                  (--) 
```

**Set fidelity:** 0.9804 (7 overhangs, 1 in HF set)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------ | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)      | --      | --    | --    |
| 2   | 3'WT block        | bsmbi_3wt_tile37_sub1    | 870 nt  | CAGG  | TGTT  |
| 3   | 3'WT block        | bsmbi_3wt_tile1_sub6     | 573 nt  | TGTT  | CACT  |
| 4   | 3'WT+PolIII block | bsmbi_3wt_tile1_sub7     | 1742 nt | CACT  | CACC  |
| 5   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1 | --      | --    | --    |

```
  [CAGG]----3'WT sub1----[TGTT]----3'WT sub2----[CACT]----3'WT+PolIII sub3----[CACC]
   CAGG                   TGTT                   CACT                          CACC 
   (--)                   (--)                   (--)                          (--) 
```

**Set fidelity:** 0.9808 (4 overhangs, 0 in HF set)

---

### Tile 38 of 47 -- Codons 2416-2488 (219 nt)

**Boundary overhangs:**

| Position          | Sequence | In HF Set | Fidelity |
| ----------------- | -------- | --------- | -------- |
| oh1 (5' boundary) | GAGA     | No        | 0.7444   |
| oh2 (3' boundary) | CTCC     | Yes       | 0.5510   |

**Variants:** 13800 mutations, 13800 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name              | Length  | 5' OH | 3' OH |
| --- | --------------- | ---------------------- | ------- | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile10_sub1   | 1595 nt | ATGA  | CTCT  |
| 2   | 5'WT gene block | bsai_5wt_tile18_sub2   | 1659 nt | CTCT  | TTGC  |
| 3   | 5'WT gene block | bsai_5wt_tile27_sub3   | 1662 nt | TTGC  | TGGA  |
| 4   | 5'WT gene block | bsai_5wt_tile36_sub4   | 1632 nt | TGGA  | TGCC  |
| 5   | 5'WT gene block | bsai_5wt_tile38_sub5   | 787 nt  | TGCC  | GAGA  |
| 6   | Oligo pool      | Tile 38 (13800 oligos) | 275 nt  | GAGA  | AATA  |
| 7   | Helper plasmid  | helper_plasmid_insert  | --      | --    | --    |
| 8   | Enzyme + buffer | BsaI-HFv2 + CutSmart   | --      | --    | --    |

```
  [ATGA]----5'WT sub1----[CTCT]----5'WT sub2----[TTGC]----5'WT sub3----[TGGA]----5'WT sub4----[TGCC]----5'WT sub5----[GAGA]----oligo+BC----[AATA]
   ATGA                   CTCT                   TTGC                   TGGA                   TGCC                   GAGA                  AATA 
   (HF)                   (--)                   (--)                   (--)                   (--)                   (--)                  (--) 
```

**Set fidelity:** 0.9809 (7 overhangs, 1 in HF set)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------ | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)      | --      | --    | --    |
| 2   | 3'WT block        | bsmbi_3wt_tile38_sub1    | 663 nt  | CTCC  | TGTT  |
| 3   | 3'WT block        | bsmbi_3wt_tile1_sub6     | 573 nt  | TGTT  | CACT  |
| 4   | 3'WT+PolIII block | bsmbi_3wt_tile1_sub7     | 1742 nt | CACT  | CACC  |
| 5   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1 | --      | --    | --    |

```
  [CTCC]----3'WT sub1----[TGTT]----3'WT sub2----[CACT]----3'WT+PolIII sub3----[CACC]
   CTCC                   TGTT                   CACT                          CACC 
   (HF)                   (--)                   (--)                          (--) 
```

**Set fidelity:** 0.9830 (4 overhangs, 1 in HF set)

---

### Tile 39 of 47 -- Codons 2485-2559 (225 nt)

**Boundary overhangs:**

| Position          | Sequence | In HF Set | Fidelity |
| ----------------- | -------- | --------- | -------- |
| oh1 (5' boundary) | TTCT     | No        | 0.8181   |
| oh2 (3' boundary) | GACA     | Yes       | 0.6127   |

**Variants:** 14200 mutations, 14200 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name              | Length  | 5' OH | 3' OH |
| --- | --------------- | ---------------------- | ------- | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile10_sub1   | 1595 nt | ATGA  | CTCT  |
| 2   | 5'WT gene block | bsai_5wt_tile18_sub2   | 1659 nt | CTCT  | TTGC  |
| 3   | 5'WT gene block | bsai_5wt_tile27_sub3   | 1662 nt | TTGC  | TGGA  |
| 4   | 5'WT gene block | bsai_5wt_tile36_sub4   | 1632 nt | TGGA  | TGCC  |
| 5   | 5'WT gene block | bsai_5wt_tile39_sub5   | 994 nt  | TGCC  | TTCT  |
| 6   | Oligo pool      | Tile 39 (14200 oligos) | 281 nt  | TTCT  | AATA  |
| 7   | Helper plasmid  | helper_plasmid_insert  | --      | --    | --    |
| 8   | Enzyme + buffer | BsaI-HFv2 + CutSmart   | --      | --    | --    |

```
  [ATGA]----5'WT sub1----[CTCT]----5'WT sub2----[TTGC]----5'WT sub3----[TGGA]----5'WT sub4----[TGCC]----5'WT sub5----[TTCT]----oligo+BC----[AATA]
   ATGA                   CTCT                   TTGC                   TGGA                   TGCC                   TTCT                  AATA 
   (HF)                   (--)                   (--)                   (--)                   (--)                   (--)                  (--) 
```

**Set fidelity:** 0.9815 (7 overhangs, 1 in HF set)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------ | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)      | --      | --    | --    |
| 2   | 3'WT block        | bsmbi_3wt_tile39_sub1    | 450 nt  | GACA  | TGTT  |
| 3   | 3'WT block        | bsmbi_3wt_tile1_sub6     | 573 nt  | TGTT  | CACT  |
| 4   | 3'WT+PolIII block | bsmbi_3wt_tile1_sub7     | 1742 nt | CACT  | CACC  |
| 5   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1 | --      | --    | --    |

```
  [GACA]----3'WT sub1----[TGTT]----3'WT sub2----[CACT]----3'WT+PolIII sub3----[CACC]
   GACA                   TGTT                   CACT                          CACC 
   (HF)                   (--)                   (--)                          (--) 
```

**Set fidelity:** 0.9438 (4 overhangs, 1 in HF set)

---

### Tile 40 of 47 -- Codons 2556-2631 (228 nt)

**Boundary overhangs:**

| Position          | Sequence | In HF Set | Fidelity |
| ----------------- | -------- | --------- | -------- |
| oh1 (5' boundary) | ATGT     | No        | 0.6822   |
| oh2 (3' boundary) | ATCT     | No        | 0.7151   |

**Variants:** 14400 mutations, 14400 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name              | Length  | 5' OH | 3' OH |
| --- | --------------- | ---------------------- | ------- | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile10_sub1   | 1595 nt | ATGA  | CTCT  |
| 2   | 5'WT gene block | bsai_5wt_tile18_sub2   | 1659 nt | CTCT  | TTGC  |
| 3   | 5'WT gene block | bsai_5wt_tile27_sub3   | 1662 nt | TTGC  | TGGA  |
| 4   | 5'WT gene block | bsai_5wt_tile36_sub4   | 1632 nt | TGGA  | TGCC  |
| 5   | 5'WT gene block | bsai_5wt_tile40_sub5   | 1207 nt | TGCC  | ATGT  |
| 6   | Oligo pool      | Tile 40 (14400 oligos) | 284 nt  | ATGT  | AATA  |
| 7   | Helper plasmid  | helper_plasmid_insert  | --      | --    | --    |
| 8   | Enzyme + buffer | BsaI-HFv2 + CutSmart   | --      | --    | --    |

```
  [ATGA]----5'WT sub1----[CTCT]----5'WT sub2----[TTGC]----5'WT sub3----[TGGA]----5'WT sub4----[TGCC]----5'WT sub5----[ATGT]----oligo+BC----[AATA]
   ATGA                   CTCT                   TTGC                   TGGA                   TGCC                   ATGT                  AATA 
   (HF)                   (--)                   (--)                   (--)                   (--)                   (--)                  (--) 
```

**Set fidelity:** 0.9876 (7 overhangs, 1 in HF set)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------ | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)      | --      | --    | --    |
| 2   | 3'WT block        | bsmbi_3wt_tile40_sub1    | 789 nt  | ATCT  | TGTT  |
| 3   | 3'WT+PolIII block | bsmbi_3wt_tile1_sub7     | 1742 nt | TGTT  | CACC  |
| 4   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1 | --      | --    | --    |

```
  [ATCT]----3'WT sub1----[TGTT]----3'WT+PolIII sub2----[CACT][CACC]
   ATCT                   TGTT                          CACT  CACC 
   (--)                   (--)                          (--)  (--) 
```

**Set fidelity:** 0.9789 (4 overhangs, 0 in HF set)

---

### Tile 41 of 47 -- Codons 2628-2703 (228 nt)

**Boundary overhangs:**

| Position          | Sequence | In HF Set | Fidelity |
| ----------------- | -------- | --------- | -------- |
| oh1 (5' boundary) | AAGT     | Yes       | 0.7629   |
| oh2 (3' boundary) | TGTT     | No        | 0.6450   |

**Variants:** 14400 mutations, 14400 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name              | Length  | 5' OH | 3' OH |
| --- | --------------- | ---------------------- | ------- | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile10_sub1   | 1595 nt | ATGA  | CTCT  |
| 2   | 5'WT gene block | bsai_5wt_tile18_sub2   | 1659 nt | CTCT  | TTGC  |
| 3   | 5'WT gene block | bsai_5wt_tile27_sub3   | 1662 nt | TTGC  | TGGA  |
| 4   | 5'WT gene block | bsai_5wt_tile36_sub4   | 1632 nt | TGGA  | TGCC  |
| 5   | 5'WT gene block | bsai_5wt_tile41_sub5   | 1423 nt | TGCC  | AAGT  |
| 6   | Oligo pool      | Tile 41 (14400 oligos) | 284 nt  | AAGT  | AATA  |
| 7   | Helper plasmid  | helper_plasmid_insert  | --      | --    | --    |
| 8   | Enzyme + buffer | BsaI-HFv2 + CutSmart   | --      | --    | --    |

```
  [ATGA]----5'WT sub1----[CTCT]----5'WT sub2----[TTGC]----5'WT sub3----[TGGA]----5'WT sub4----[TGCC]----5'WT sub5----[AAGT]----oligo+BC----[AATA]
   ATGA                   CTCT                   TTGC                   TGGA                   TGCC                   AAGT                  AATA 
   (HF)                   (--)                   (--)                   (--)                   (--)                   (HF)                  (--) 
```

**Set fidelity:** 0.9859 (7 overhangs, 2 in HF set)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------ | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)      | --      | --    | --    |
| 2   | 3'WT block        | bsmbi_3wt_tile1_sub6     | 573 nt  | TGTT  | CACT  |
| 3   | 3'WT+PolIII block | bsmbi_3wt_tile1_sub7     | 1742 nt | CACT  | CACC  |
| 4   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1 | --      | --    | --    |

```
  [TGTT]----3'WT sub1----[CACT]----3'WT+PolIII sub2----[CACC]
   TGTT                   CACT                          CACC 
   (--)                   (--)                          (--) 
```

**Set fidelity:** 0.9842 (3 overhangs, 0 in HF set)

---

### Tile 42 of 47 -- Codons 2700-2770 (213 nt)

**Boundary overhangs:**

| Position          | Sequence | In HF Set | Fidelity |
| ----------------- | -------- | --------- | -------- |
| oh1 (5' boundary) | GAAA     | No        | 0.8745   |
| oh2 (3' boundary) | ATCG     | No        | 0.5700   |

**Variants:** 13400 mutations, 13400 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name              | Length  | 5' OH | 3' OH |
| --- | --------------- | ---------------------- | ------- | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile10_sub1   | 1595 nt | ATGA  | CTCT  |
| 2   | 5'WT gene block | bsai_5wt_tile18_sub2   | 1659 nt | CTCT  | TTGC  |
| 3   | 5'WT gene block | bsai_5wt_tile27_sub3   | 1662 nt | TTGC  | TGGA  |
| 4   | 5'WT gene block | bsai_5wt_tile36_sub4   | 1632 nt | TGGA  | TGCC  |
| 5   | 5'WT gene block | bsai_5wt_tile42_sub5   | 1639 nt | TGCC  | GAAA  |
| 6   | Oligo pool      | Tile 42 (13400 oligos) | 269 nt  | GAAA  | AATA  |
| 7   | Helper plasmid  | helper_plasmid_insert  | --      | --    | --    |
| 8   | Enzyme + buffer | BsaI-HFv2 + CutSmart   | --      | --    | --    |

```
  [ATGA]----5'WT sub1----[CTCT]----5'WT sub2----[TTGC]----5'WT sub3----[TGGA]----5'WT sub4----[TGCC]----5'WT sub5----[GAAA]----oligo+BC----[AATA]
   ATGA                   CTCT                   TTGC                   TGGA                   TGCC                   GAAA                  AATA 
   (HF)                   (--)                   (--)                   (--)                   (--)                   (--)                  (--) 
```

**Set fidelity:** 0.9673 (7 overhangs, 1 in HF set)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------ | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)      | --      | --    | --    |
| 2   | 3'WT block        | bsmbi_3wt_tile42_sub1    | 372 nt  | ATCG  | CACT  |
| 3   | 3'WT+PolIII block | bsmbi_3wt_tile1_sub7     | 1742 nt | CACT  | CACC  |
| 4   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1 | --      | --    | --    |

```
  [ATCG]----3'WT sub1----[CACT]----3'WT+PolIII sub2----[CACC]
   ATCG                   CACT                          CACC 
   (--)                   (--)                          (--) 
```

**Set fidelity:** 0.9909 (3 overhangs, 0 in HF set)

---

### Tile 43 of 47 -- Codons 2767-2815 (147 nt)

**Boundary overhangs:**

| Position          | Sequence | In HF Set | Fidelity |
| ----------------- | -------- | --------- | -------- |
| oh1 (5' boundary) | TCAG     | No        | 0.7814   |
| oh2 (3' boundary) | TCAG     | No        | 0.7814   |

**Variants:** 9000 mutations, 9000 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name             | Length  | 5' OH | 3' OH |
| --- | --------------- | --------------------- | ------- | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile10_sub1  | 1595 nt | ATGA  | CTCT  |
| 2   | 5'WT gene block | bsai_5wt_tile18_sub2  | 1659 nt | CTCT  | TTGC  |
| 3   | 5'WT gene block | bsai_5wt_tile27_sub3  | 1662 nt | TTGC  | TGGA  |
| 4   | 5'WT gene block | bsai_5wt_tile36_sub4  | 1632 nt | TGGA  | TGCC  |
| 5   | 5'WT gene block | bsai_5wt_tile43_sub5  | 1647 nt | TGCC  | TGTT  |
| 6   | 5'WT gene block | bsai_5wt_tile43_sub6  | 211 nt  | TGTT  | TCAG  |
| 7   | Oligo pool      | Tile 43 (9000 oligos) | 203 nt  | TCAG  | AATA  |
| 8   | Helper plasmid  | helper_plasmid_insert | --      | --    | --    |
| 9   | Enzyme + buffer | BsaI-HFv2 + CutSmart  | --      | --    | --    |

```
  [ATGA]----5'WT sub1----[CTCT]----5'WT sub2----[TTGC]----5'WT sub3----[TGGA]----5'WT sub4----[TGCC]----5'WT sub5----[TGTT]----5'WT sub6----[TCAG]----oligo+BC----[AATA]
   ATGA                   CTCT                   TTGC                   TGGA                   TGCC                   TGTT                   TCAG                  AATA 
   (HF)                   (--)                   (--)                   (--)                   (--)                   (--)                   (--)                  (--) 
```

**Set fidelity:** 0.9363 (8 overhangs, 1 in HF set)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------ | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)      | --      | --    | --    |
| 2   | 3'WT block        | bsmbi_3wt_tile43_sub1    | 237 nt  | TCAG  | CACT  |
| 3   | 3'WT+PolIII block | bsmbi_3wt_tile1_sub7     | 1742 nt | CACT  | CACC  |
| 4   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1 | --      | --    | --    |

```
  [TCAG]----3'WT sub1----[CACT]----3'WT+PolIII sub2----[CACC]
   TCAG                   CACT                          CACC 
   (--)                   (--)                          (--) 
```

**Set fidelity:** 0.9980 (3 overhangs, 0 in HF set)

---

### Tile 44 of 47 -- Codons 2812-2888 (231 nt)

**Boundary overhangs:**

| Position          | Sequence | In HF Set | Fidelity |
| ----------------- | -------- | --------- | -------- |
| oh1 (5' boundary) | AAAT     | No        | 0.7737   |
| oh2 (3' boundary) | CACT     | No        | 0.5337   |

**Variants:** 14600 mutations, 14600 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name              | Length  | 5' OH | 3' OH |
| --- | --------------- | ---------------------- | ------- | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile10_sub1   | 1595 nt | ATGA  | CTCT  |
| 2   | 5'WT gene block | bsai_5wt_tile18_sub2   | 1659 nt | CTCT  | TTGC  |
| 3   | 5'WT gene block | bsai_5wt_tile27_sub3   | 1662 nt | TTGC  | TGGA  |
| 4   | 5'WT gene block | bsai_5wt_tile36_sub4   | 1632 nt | TGGA  | TGCC  |
| 5   | 5'WT gene block | bsai_5wt_tile43_sub5   | 1647 nt | TGCC  | TGTT  |
| 6   | 5'WT gene block | bsai_5wt_tile44_sub6   | 346 nt  | TGTT  | AAAT  |
| 7   | Oligo pool      | Tile 44 (14600 oligos) | 287 nt  | AAAT  | AATA  |
| 8   | Helper plasmid  | helper_plasmid_insert  | --      | --    | --    |
| 9   | Enzyme + buffer | BsaI-HFv2 + CutSmart   | --      | --    | --    |

```
  [ATGA]----5'WT sub1----[CTCT]----5'WT sub2----[TTGC]----5'WT sub3----[TGGA]----5'WT sub4----[TGCC]----5'WT sub5----[TGTT]----5'WT sub6----[AAAT]----oligo+BC----[AATA]
   ATGA                   CTCT                   TTGC                   TGGA                   TGCC                   TGTT                   AAAT                  AATA 
   (HF)                   (--)                   (--)                   (--)                   (--)                   (--)                   (--)                  (--) 
```

**Set fidelity:** 0.9507 (8 overhangs, 1 in HF set)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------ | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)      | --      | --    | --    |
| 2   | 3'WT+PolIII block | bsmbi_3wt_tile1_sub7     | 1742 nt | CACT  | CACC  |
| 3   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1 | --      | --    | --    |

```
  [CACT]----3'WT+PolIII----[CACC]
   CACT                     CACC 
   (--)                     (--) 
```

**Set fidelity:** 0.9998 (2 overhangs, 0 in HF set)

---

### Tile 45 of 47 -- Codons 2885-2955 (213 nt)

**Boundary overhangs:**

| Position          | Sequence | In HF Set | Fidelity |
| ----------------- | -------- | --------- | -------- |
| oh1 (5' boundary) | GGAA     | No        | 0.7463   |
| oh2 (3' boundary) | GAAC     | No        | 0.6079   |

**Variants:** 13400 mutations, 13400 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name              | Length  | 5' OH | 3' OH |
| --- | --------------- | ---------------------- | ------- | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile10_sub1   | 1595 nt | ATGA  | CTCT  |
| 2   | 5'WT gene block | bsai_5wt_tile18_sub2   | 1659 nt | CTCT  | TTGC  |
| 3   | 5'WT gene block | bsai_5wt_tile27_sub3   | 1662 nt | TTGC  | TGGA  |
| 4   | 5'WT gene block | bsai_5wt_tile36_sub4   | 1632 nt | TGGA  | TGCC  |
| 5   | 5'WT gene block | bsai_5wt_tile43_sub5   | 1647 nt | TGCC  | TGTT  |
| 6   | 5'WT gene block | bsai_5wt_tile45_sub6   | 565 nt  | TGTT  | GGAA  |
| 7   | Oligo pool      | Tile 45 (13400 oligos) | 269 nt  | GGAA  | AATA  |
| 8   | Helper plasmid  | helper_plasmid_insert  | --      | --    | --    |
| 9   | Enzyme + buffer | BsaI-HFv2 + CutSmart   | --      | --    | --    |

```
  [ATGA]----5'WT sub1----[CTCT]----5'WT sub2----[TTGC]----5'WT sub3----[TGGA]----5'WT sub4----[TGCC]----5'WT sub5----[TGTT]----5'WT sub6----[GGAA]----oligo+BC----[AATA]
   ATGA                   CTCT                   TTGC                   TGGA                   TGCC                   TGTT                   GGAA                  AATA 
   (HF)                   (--)                   (--)                   (--)                   (--)                   (--)                   (--)                  (--) 
```

**Set fidelity:** 0.9049 (8 overhangs, 1 in HF set)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------ | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)      | --      | --    | --    |
| 2   | 3'WT+PolIII block | bsmbi_3wt_tile45         | 1541 nt | GAAC  | CACC  |
| 3   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1 | --      | --    | --    |

```
  [GAAC]----3'WT+PolIII----[CACC]
   GAAC                     CACC 
   (--)                     (--) 
```

**Set fidelity:** 0.9987 (2 overhangs, 0 in HF set)

---

### Tile 46 of 47 -- Codons 2952-3029 (234 nt)

**Boundary overhangs:**

| Position          | Sequence | In HF Set | Fidelity |
| ----------------- | -------- | --------- | -------- |
| oh1 (5' boundary) | TTAC     | No        | 0.8333   |
| oh2 (3' boundary) | CTTC     | No        | 0.6384   |

**Variants:** 14800 mutations, 14800 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name              | Length  | 5' OH | 3' OH |
| --- | --------------- | ---------------------- | ------- | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile10_sub1   | 1595 nt | ATGA  | CTCT  |
| 2   | 5'WT gene block | bsai_5wt_tile18_sub2   | 1659 nt | CTCT  | TTGC  |
| 3   | 5'WT gene block | bsai_5wt_tile27_sub3   | 1662 nt | TTGC  | TGGA  |
| 4   | 5'WT gene block | bsai_5wt_tile36_sub4   | 1632 nt | TGGA  | TGCC  |
| 5   | 5'WT gene block | bsai_5wt_tile43_sub5   | 1647 nt | TGCC  | TGTT  |
| 6   | 5'WT gene block | bsai_5wt_tile46_sub6   | 766 nt  | TGTT  | TTAC  |
| 7   | Oligo pool      | Tile 46 (14800 oligos) | 290 nt  | TTAC  | AATA  |
| 8   | Helper plasmid  | helper_plasmid_insert  | --      | --    | --    |
| 9   | Enzyme + buffer | BsaI-HFv2 + CutSmart   | --      | --    | --    |

```
  [ATGA]----5'WT sub1----[CTCT]----5'WT sub2----[TTGC]----5'WT sub3----[TGGA]----5'WT sub4----[TGCC]----5'WT sub5----[TGTT]----5'WT sub6----[CACT]----oligo+BC----[TTAC][AATA]
   ATGA                   CTCT                   TTGC                   TGGA                   TGCC                   TGTT                   CACT                  TTAC  AATA 
   (HF)                   (--)                   (--)                   (--)                   (--)                   (--)                   (--)                  (--)  (--) 
```

**Set fidelity:** 0.9465 (9 overhangs, 1 in HF set)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------ | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)      | --      | --    | --    |
| 2   | 3'WT+PolIII block | bsmbi_3wt_tile46         | 1319 nt | CTTC  | CACC  |
| 3   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1 | --      | --    | --    |

```
  [CTTC]----3'WT+PolIII----[CACC]
   CTTC                     CACC 
   (--)                     (--) 
```

**Set fidelity:** 0.9988 (2 overhangs, 0 in HF set)

---

### Tile 47 of 47 -- Codons 3026-3098 (219 nt)

**Boundary overhangs:**

| Position          | Sequence | In HF Set | Fidelity |
| ----------------- | -------- | --------- | -------- |
| oh1 (5' boundary) | TTCG     | No        | 0.6891   |
| oh2 (3' boundary) | TTGA     | No        | 0.8853   |

**Variants:** 13800 mutations, 13800 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name              | Length  | 5' OH | 3' OH |
| --- | --------------- | ---------------------- | ------- | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile10_sub1   | 1595 nt | ATGA  | CTCT  |
| 2   | 5'WT gene block | bsai_5wt_tile18_sub2   | 1659 nt | CTCT  | TTGC  |
| 3   | 5'WT gene block | bsai_5wt_tile27_sub3   | 1662 nt | TTGC  | TGGA  |
| 4   | 5'WT gene block | bsai_5wt_tile36_sub4   | 1632 nt | TGGA  | TGCC  |
| 5   | 5'WT gene block | bsai_5wt_tile43_sub5   | 1647 nt | TGCC  | TGTT  |
| 6   | 5'WT gene block | bsai_5wt_tile47_sub6   | 573 nt  | TGTT  | CACT  |
| 7   | 5'WT gene block | bsai_5wt_tile47_sub7   | 433 nt  | CACT  | TTCG  |
| 8   | Oligo pool      | Tile 47 (13800 oligos) | 275 nt  | TTCG  | AATA  |
| 9   | Helper plasmid  | helper_plasmid_insert  | --      | --    | --    |
| 10  | Enzyme + buffer | BsaI-HFv2 + CutSmart   | --      | --    | --    |

```
  [ATGA]----5'WT sub1----[CTCT]----5'WT sub2----[TTGC]----5'WT sub3----[TGGA]----5'WT sub4----[TGCC]----5'WT sub5----[TGTT]----5'WT sub6----[CACT]----5'WT sub7----[TTCG]----oligo+BC----[AATA]
   ATGA                   CTCT                   TTGC                   TGGA                   TGCC                   TGTT                   CACT                   TTCG                  AATA 
   (HF)                   (--)                   (--)                   (--)                   (--)                   (--)                   (--)                   (--)                  (--) 
```

**Set fidelity:** 0.9432 (9 overhangs, 1 in HF set)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component            | Part name                | Length  | 5' OH | 3' OH |
| --- | -------------------- | ------------------------ | ------- | ----- | ----- |
| 1   | BsaI product         | (in helper plasmid)      | --      | --    | --    |
| 2   | PolIII-only fragment | bsmbi_polIII_tile47      | 1112 nt | TTGA  | CACC  |
| 3   | Enzyme + buffer      | BsmBI-v2 + NEBuffer r3.1 | --      | --    | --    |

```
  [TTGA]----PolIII----[CACC]
   TTGA                CACC 
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

**Total blocks:** 99

| Block name            | Length (nt) | Enzyme type | Gene region                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                           |
| --------------------- | ----------- | ----------- | ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| bsai_5wt_tile10_sub1  | 1595        | BsaI        | 5wt_tile10_sub1;5wt_tile11_sub1;5wt_tile12_sub1;5wt_tile13_sub1;5wt_tile14_sub1;5wt_tile15_sub1;5wt_tile16_sub1;5wt_tile17_sub1;5wt_tile18_sub1;5wt_tile19_sub1;5wt_tile20_sub1;5wt_tile21_sub1;5wt_tile22_sub1;5wt_tile23_sub1;5wt_tile24_sub1;5wt_tile25_sub1;5wt_tile26_sub1;5wt_tile27_sub1;5wt_tile28_sub1;5wt_tile29_sub1;5wt_tile30_sub1;5wt_tile31_sub1;5wt_tile32_sub1;5wt_tile33_sub1;5wt_tile34_sub1;5wt_tile35_sub1;5wt_tile36_sub1;5wt_tile37_sub1;5wt_tile38_sub1;5wt_tile39_sub1;5wt_tile40_sub1;5wt_tile41_sub1;5wt_tile42_sub1;5wt_tile43_sub1;5wt_tile44_sub1;5wt_tile45_sub1;5wt_tile46_sub1;5wt_tile47_sub1                                                                                                                                                                                                                                                                                                                                                                                                       |
| bsai_5wt_tile10_sub2  | 232         | BsaI        | 5wt_tile10_sub2                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                       |
| bsai_5wt_tile11_sub2  | 454         | BsaI        | 5wt_tile11_sub2                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                       |
| bsai_5wt_tile12_sub2  | 667         | BsaI        | 5wt_tile12_sub2                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                       |
| bsai_5wt_tile13_sub2  | 889         | BsaI        | 5wt_tile13_sub2                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                       |
| bsai_5wt_tile14_sub2  | 1093        | BsaI        | 5wt_tile14_sub2                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                       |
| bsai_5wt_tile15_sub2  | 1315        | BsaI        | 5wt_tile15_sub2                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                       |
| bsai_5wt_tile16_sub2  | 1444        | BsaI        | 5wt_tile16_sub2                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                       |
| bsai_5wt_tile17_sub2  | 1651        | BsaI        | 5wt_tile17_sub2                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                       |
| bsai_5wt_tile18_sub2  | 1659        | BsaI        | 5wt_tile18_sub2;5wt_tile19_sub2;5wt_tile20_sub2;5wt_tile21_sub2;5wt_tile22_sub2;5wt_tile23_sub2;5wt_tile24_sub2;5wt_tile25_sub2;5wt_tile26_sub2;5wt_tile27_sub2;5wt_tile28_sub2;5wt_tile29_sub2;5wt_tile30_sub2;5wt_tile31_sub2;5wt_tile32_sub2;5wt_tile33_sub2;5wt_tile34_sub2;5wt_tile35_sub2;5wt_tile36_sub2;5wt_tile37_sub2;5wt_tile38_sub2;5wt_tile39_sub2;5wt_tile40_sub2;5wt_tile41_sub2;5wt_tile42_sub2;5wt_tile43_sub2;5wt_tile44_sub2;5wt_tile45_sub2;5wt_tile46_sub2;5wt_tile47_sub2                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                       |
| bsai_5wt_tile18_sub3  | 232         | BsaI        | 5wt_tile18_sub3                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                       |
| bsai_5wt_tile19_sub3  | 415         | BsaI        | 5wt_tile19_sub3                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                       |
| bsai_5wt_tile2        | 222         | BsaI        | 5wt_tile2                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                             |
| bsai_5wt_tile20_sub3  | 520         | BsaI        | 5wt_tile20_sub3                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                       |
| bsai_5wt_tile21_sub3  | 709         | BsaI        | 5wt_tile21_sub3                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                       |
| bsai_5wt_tile22_sub3  | 835         | BsaI        | 5wt_tile22_sub3                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                       |
| bsai_5wt_tile23_sub3  | 1057        | BsaI        | 5wt_tile23_sub3                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                       |
| bsai_5wt_tile24_sub3  | 1231        | BsaI        | 5wt_tile24_sub3                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                       |
| bsai_5wt_tile25_sub3  | 1453        | BsaI        | 5wt_tile25_sub3                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                       |
| bsai_5wt_tile26_sub3  | 1654        | BsaI        | 5wt_tile26_sub3                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                       |
| bsai_5wt_tile27_sub3  | 1662        | BsaI        | 5wt_tile27_sub3;5wt_tile28_sub3;5wt_tile29_sub3;5wt_tile30_sub3;5wt_tile31_sub3;5wt_tile32_sub3;5wt_tile33_sub3;5wt_tile34_sub3;5wt_tile35_sub3;5wt_tile36_sub3;5wt_tile37_sub3;5wt_tile38_sub3;5wt_tile39_sub3;5wt_tile40_sub3;5wt_tile41_sub3;5wt_tile42_sub3;5wt_tile43_sub3;5wt_tile44_sub3;5wt_tile45_sub3;5wt_tile46_sub3;5wt_tile47_sub3                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                       |
| bsai_5wt_tile27_sub4  | 205         | BsaI        | 5wt_tile27_sub4                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                       |
| bsai_5wt_tile28_sub4  | 427         | BsaI        | 5wt_tile28_sub4                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                       |
| bsai_5wt_tile29_sub4  | 637         | BsaI        | 5wt_tile29_sub4                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                       |
| bsai_5wt_tile3        | 444         | BsaI        | 5wt_tile3                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                             |
| bsai_5wt_tile30_sub4  | 859         | BsaI        | 5wt_tile30_sub4                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                       |
| bsai_5wt_tile31_sub4  | 1060        | BsaI        | 5wt_tile31_sub4                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                       |
| bsai_5wt_tile32_sub4  | 1279        | BsaI        | 5wt_tile32_sub4                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                       |
| bsai_5wt_tile33_sub4  | 1462        | BsaI        | 5wt_tile33_sub4                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                       |
| bsai_5wt_tile34_sub4  | 1624        | BsaI        | 5wt_tile34_sub4                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                       |
| bsai_5wt_tile35_sub4  | 1798        | BsaI        | 5wt_tile35_sub4                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                       |
| bsai_5wt_tile36_sub4  | 1632        | BsaI        | 5wt_tile36_sub4;5wt_tile37_sub4;5wt_tile38_sub4;5wt_tile39_sub4;5wt_tile40_sub4;5wt_tile41_sub4;5wt_tile42_sub4;5wt_tile43_sub4;5wt_tile44_sub4;5wt_tile45_sub4;5wt_tile46_sub4;5wt_tile47_sub4                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                       |
| bsai_5wt_tile36_sub5  | 367         | BsaI        | 5wt_tile36_sub5                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                       |
| bsai_5wt_tile37_sub5  | 589         | BsaI        | 5wt_tile37_sub5                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                       |
| bsai_5wt_tile38_sub5  | 787         | BsaI        | 5wt_tile38_sub5                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                       |
| bsai_5wt_tile39_sub5  | 994         | BsaI        | 5wt_tile39_sub5                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                       |
| bsai_5wt_tile4        | 660         | BsaI        | 5wt_tile4                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                             |
| bsai_5wt_tile40_sub5  | 1207        | BsaI        | 5wt_tile40_sub5                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                       |
| bsai_5wt_tile41_sub5  | 1423        | BsaI        | 5wt_tile41_sub5                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                       |
| bsai_5wt_tile42_sub5  | 1639        | BsaI        | 5wt_tile42_sub5                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                       |
| bsai_5wt_tile43_sub5  | 1647        | BsaI        | 5wt_tile43_sub5;5wt_tile44_sub5;5wt_tile45_sub5;5wt_tile46_sub5;5wt_tile47_sub5                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                       |
| bsai_5wt_tile43_sub6  | 211         | BsaI        | 5wt_tile43_sub6                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                       |
| bsai_5wt_tile44_sub6  | 346         | BsaI        | 5wt_tile44_sub6                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                       |
| bsai_5wt_tile45_sub6  | 565         | BsaI        | 5wt_tile45_sub6                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                       |
| bsai_5wt_tile46_sub6  | 766         | BsaI        | 5wt_tile46_sub6                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                       |
| bsai_5wt_tile47_sub6  | 573         | BsaI        | 5wt_tile47_sub6                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                       |
| bsai_5wt_tile47_sub7  | 433         | BsaI        | 5wt_tile47_sub7                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                       |
| bsai_5wt_tile5        | 810         | BsaI        | 5wt_tile5                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                             |
| bsai_5wt_tile6        | 1011        | BsaI        | 5wt_tile6                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                             |
| bsai_5wt_tile7        | 1203        | BsaI        | 5wt_tile7                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                             |
| bsai_5wt_tile8        | 1380        | BsaI        | 5wt_tile8                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                             |
| bsai_5wt_tile9        | 1587        | BsaI        | 5wt_tile9                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                             |
| bsmbi_3wt_tile1_sub1  | 1383        | BsmBI       | 3wt_tile1_sub1                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                        |
| bsmbi_3wt_tile1_sub2  | 1659        | BsmBI       | 3wt_tile1_sub2;3wt_tile2_sub2;3wt_tile3_sub2;3wt_tile4_sub2;3wt_tile5_sub2;3wt_tile6_sub2;3wt_tile7_sub2;3wt_tile8_sub1                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                               |
| bsmbi_3wt_tile1_sub3  | 1662        | BsmBI       | 3wt_tile1_sub3;3wt_tile2_sub3;3wt_tile3_sub3;3wt_tile4_sub3;3wt_tile5_sub3;3wt_tile6_sub3;3wt_tile7_sub3;3wt_tile8_sub2;3wt_tile9_sub2;3wt_tile10_sub2;3wt_tile11_sub2;3wt_tile12_sub2;3wt_tile13_sub2;3wt_tile14_sub2;3wt_tile15_sub2;3wt_tile16_sub1                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                |
| bsmbi_3wt_tile1_sub4  | 1632        | BsmBI       | 3wt_tile1_sub4;3wt_tile2_sub4;3wt_tile3_sub4;3wt_tile4_sub4;3wt_tile5_sub4;3wt_tile6_sub4;3wt_tile7_sub4;3wt_tile8_sub3;3wt_tile9_sub3;3wt_tile10_sub3;3wt_tile11_sub3;3wt_tile12_sub3;3wt_tile13_sub3;3wt_tile14_sub3;3wt_tile15_sub3;3wt_tile16_sub2;3wt_tile17_sub2;3wt_tile18_sub2;3wt_tile19_sub2;3wt_tile20_sub2;3wt_tile21_sub2;3wt_tile22_sub2;3wt_tile23_sub2;3wt_tile24_sub2;3wt_tile25_sub1                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                |
| bsmbi_3wt_tile1_sub5  | 1647        | BsmBI       | 3wt_tile1_sub5;3wt_tile2_sub5;3wt_tile3_sub5;3wt_tile4_sub5;3wt_tile5_sub5;3wt_tile6_sub5;3wt_tile7_sub5;3wt_tile8_sub4;3wt_tile9_sub4;3wt_tile10_sub4;3wt_tile11_sub4;3wt_tile12_sub4;3wt_tile13_sub4;3wt_tile14_sub4;3wt_tile15_sub4;3wt_tile16_sub3;3wt_tile17_sub3;3wt_tile18_sub3;3wt_tile19_sub3;3wt_tile20_sub3;3wt_tile21_sub3;3wt_tile22_sub3;3wt_tile23_sub3;3wt_tile24_sub3;3wt_tile25_sub2;3wt_tile26_sub2;3wt_tile27_sub2;3wt_tile28_sub2;3wt_tile29_sub2;3wt_tile30_sub2;3wt_tile31_sub2;3wt_tile32_sub2;3wt_tile33_sub1                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                |
| bsmbi_3wt_tile1_sub6  | 573         | BsmBI       | 3wt_tile1_sub6;3wt_tile2_sub6;3wt_tile3_sub6;3wt_tile4_sub6;3wt_tile5_sub6;3wt_tile6_sub6;3wt_tile7_sub6;3wt_tile8_sub5;3wt_tile9_sub5;3wt_tile10_sub5;3wt_tile11_sub5;3wt_tile12_sub5;3wt_tile13_sub5;3wt_tile14_sub5;3wt_tile15_sub5;3wt_tile16_sub4;3wt_tile17_sub4;3wt_tile18_sub4;3wt_tile19_sub4;3wt_tile20_sub4;3wt_tile21_sub4;3wt_tile22_sub4;3wt_tile23_sub4;3wt_tile24_sub4;3wt_tile25_sub3;3wt_tile26_sub3;3wt_tile27_sub3;3wt_tile28_sub3;3wt_tile29_sub3;3wt_tile30_sub3;3wt_tile31_sub3;3wt_tile32_sub3;3wt_tile33_sub2;3wt_tile34_sub2;3wt_tile35_sub2;3wt_tile36_sub2;3wt_tile37_sub2;3wt_tile38_sub2;3wt_tile39_sub2;3wt_tile41_sub1                                                                                                                                                                                                                                                                                                                                                                                |
| bsmbi_3wt_tile1_sub7  | 1742        | BsmBI       | 3wt_polIII_tile1_sub7;3wt_polIII_tile2_sub7;3wt_polIII_tile3_sub7;3wt_polIII_tile4_sub7;3wt_polIII_tile5_sub7;3wt_polIII_tile6_sub7;3wt_polIII_tile7_sub7;3wt_polIII_tile8_sub6;3wt_polIII_tile9_sub6;3wt_polIII_tile10_sub6;3wt_polIII_tile11_sub6;3wt_polIII_tile12_sub6;3wt_polIII_tile13_sub6;3wt_polIII_tile14_sub6;3wt_polIII_tile15_sub6;3wt_polIII_tile16_sub5;3wt_polIII_tile17_sub5;3wt_polIII_tile18_sub5;3wt_polIII_tile19_sub5;3wt_polIII_tile20_sub5;3wt_polIII_tile21_sub5;3wt_polIII_tile22_sub5;3wt_polIII_tile23_sub5;3wt_polIII_tile24_sub5;3wt_polIII_tile25_sub4;3wt_polIII_tile26_sub4;3wt_polIII_tile27_sub4;3wt_polIII_tile28_sub4;3wt_polIII_tile29_sub4;3wt_polIII_tile30_sub4;3wt_polIII_tile31_sub4;3wt_polIII_tile32_sub4;3wt_polIII_tile33_sub3;3wt_polIII_tile34_sub3;3wt_polIII_tile35_sub3;3wt_polIII_tile36_sub3;3wt_polIII_tile37_sub3;3wt_polIII_tile38_sub3;3wt_polIII_tile39_sub3;3wt_polIII_tile40_sub2;3wt_polIII_tile41_sub2;3wt_polIII_tile42_sub2;3wt_polIII_tile43_sub2;3wt_polIII_tile44 |
| bsmbi_3wt_tile10_sub1 | 1215        | BsmBI       | 3wt_tile10_sub1                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                       |
| bsmbi_3wt_tile11_sub1 | 1002        | BsmBI       | 3wt_tile11_sub1                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                       |
| bsmbi_3wt_tile12_sub1 | 780         | BsmBI       | 3wt_tile12_sub1                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                       |
| bsmbi_3wt_tile13_sub1 | 576         | BsmBI       | 3wt_tile13_sub1                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                       |
| bsmbi_3wt_tile14_sub1 | 354         | BsmBI       | 3wt_tile14_sub1                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                       |
| bsmbi_3wt_tile15_sub1 | 225         | BsmBI       | 3wt_tile15_sub1                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                       |
| bsmbi_3wt_tile17_sub1 | 1440        | BsmBI       | 3wt_tile17_sub1                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                       |
| bsmbi_3wt_tile18_sub1 | 1257        | BsmBI       | 3wt_tile18_sub1                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                       |
| bsmbi_3wt_tile19_sub1 | 1152        | BsmBI       | 3wt_tile19_sub1                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                       |
| bsmbi_3wt_tile2_sub1  | 1161        | BsmBI       | 3wt_tile2_sub1                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                        |
| bsmbi_3wt_tile20_sub1 | 963         | BsmBI       | 3wt_tile20_sub1                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                       |
| bsmbi_3wt_tile21_sub1 | 837         | BsmBI       | 3wt_tile21_sub1                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                       |
| bsmbi_3wt_tile22_sub1 | 615         | BsmBI       | 3wt_tile22_sub1                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                       |
| bsmbi_3wt_tile23_sub1 | 441         | BsmBI       | 3wt_tile23_sub1                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                       |
| bsmbi_3wt_tile24_sub1 | 219         | BsmBI       | 3wt_tile24_sub1                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                       |
| bsmbi_3wt_tile26_sub1 | 1437        | BsmBI       | 3wt_tile26_sub1                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                       |
| bsmbi_3wt_tile27_sub1 | 1215        | BsmBI       | 3wt_tile27_sub1                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                       |
| bsmbi_3wt_tile28_sub1 | 1005        | BsmBI       | 3wt_tile28_sub1                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                       |
| bsmbi_3wt_tile29_sub1 | 783         | BsmBI       | 3wt_tile29_sub1                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                       |
| bsmbi_3wt_tile3_sub1  | 945         | BsmBI       | 3wt_tile3_sub1                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                        |
| bsmbi_3wt_tile30_sub1 | 582         | BsmBI       | 3wt_tile30_sub1                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                       |
| bsmbi_3wt_tile31_sub1 | 363         | BsmBI       | 3wt_tile31_sub1                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                       |
| bsmbi_3wt_tile32_sub1 | 180         | BsmBI       | 3wt_tile32_sub1                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                       |
| bsmbi_3wt_tile34_sub1 | 1473        | BsmBI       | 3wt_tile34_sub1                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                       |
| bsmbi_3wt_tile35_sub1 | 1290        | BsmBI       | 3wt_tile35_sub1                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                       |
| bsmbi_3wt_tile36_sub1 | 1068        | BsmBI       | 3wt_tile36_sub1                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                       |
| bsmbi_3wt_tile37_sub1 | 870         | BsmBI       | 3wt_tile37_sub1                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                       |
| bsmbi_3wt_tile38_sub1 | 663         | BsmBI       | 3wt_tile38_sub1                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                       |
| bsmbi_3wt_tile39_sub1 | 450         | BsmBI       | 3wt_tile39_sub1                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                       |
| bsmbi_3wt_tile4_sub1  | 795         | BsmBI       | 3wt_tile4_sub1                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                        |
| bsmbi_3wt_tile40_sub1 | 789         | BsmBI       | 3wt_tile40_sub1                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                       |
| bsmbi_3wt_tile42_sub1 | 372         | BsmBI       | 3wt_tile42_sub1                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                       |
| bsmbi_3wt_tile43_sub1 | 237         | BsmBI       | 3wt_tile43_sub1                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                       |
| bsmbi_3wt_tile45      | 1541        | BsmBI       | 3wt_polIII_tile45                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                     |
| bsmbi_3wt_tile46      | 1319        | BsmBI       | 3wt_polIII_tile46                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                     |
| bsmbi_3wt_tile5_sub1  | 594         | BsmBI       | 3wt_tile5_sub1                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                        |
| bsmbi_3wt_tile6_sub1  | 402         | BsmBI       | 3wt_tile6_sub1                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                        |
| bsmbi_3wt_tile7_sub1  | 225         | BsmBI       | 3wt_tile7_sub1                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                        |
| bsmbi_3wt_tile9_sub1  | 1437        | BsmBI       | 3wt_tile9_sub1                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                        |
| bsmbi_polIII_tile47   | 1112        | BsmBI       | polIII_tile47                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                         |

## 10. Domestication Log

20 endogenous enzyme site(s) were removed via silent mutations:

| site_start | enzyme | strand | codon_pos | original_codon | new_codon | aa  |
| ---------- | ------ | ------ | --------- | -------------- | --------- | --- |
| 549        | BsaI   | +      | 184       | GTC            | GTG       | V   |
| 3926       | BsaI   | -      | 1309      | AGA            | AGG       | R   |
| 4649       | BsaI   | -      | 1550      | GGA            | GGC       | G   |
| 6739       | BsaI   | -      | 2247      | GAG            | GAA       | E   |
| 7056       | BsaI   | +      | 2352      | CTG            | CTT       | L   |
| 8098       | BsaI   | -      | 2700      | GAG            | GAA       | E   |
| 8578       | BsaI   | -      | 2860      | GAG            | GAA       | E   |
| 8995       | BsaI   | -      | 2999      | GAG            | GAA       | E   |
| 2272       | BsmBI  | -      | 758       | GAG            | GAA       | E   |
| 2978       | BsmBI  | +      | 993       | GCG            | GCC       | A   |
| 3154       | BsmBI  | -      | 1052      | GAG            | GAA       | E   |
| 3393       | BsmBI  | -      | 1131      | AAG            | AAA       | K   |
| 4886       | BsmBI  | -      | 1629      | GGA            | GGC       | G   |
| 4931       | BsmBI  | +      | 1644      | ACG            | ACC       | T   |
| 5214       | BsmBI  | +      | 1738      | TCC            | TCT       | S   |
| 5482       | BsmBI  | -      | 1828      | GAG            | GAA       | E   |
| 1728       | PaqCI  | -      | 576       | CAG            | CAA       | Q   |
| 2163       | PaqCI  | -      | 721       | CTG            | CTC       | L   |
| 2731       | PaqCI  | +      | 911       | CAC            | CAT       | H   |
| 2895       | PaqCI  | -      | 965       | CTG            | CTC       | L   |

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

