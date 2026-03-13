# DMS-GG Assembly Report: AKAP11

Generated: 2026-03-13 15:02:54
Pipeline: dms-gg-oligo-pipeline (3-Enzyme Architecture: BsaI + BsmBI + PaqCI)

---

## 1. Gene Summary

| Property             | Value                                                                          |
| -------------------- | ------------------------------------------------------------------------------ |
| Gene name            | AKAP11_NM_016248.4_CDS Homo sapiens A-kinase anchoring protein 11 (AKAP11) CDS |
| CDS length           | 5706 nt (1902 codons)                                                          |
| Protein length       | 1901 aa                                                                        |
| Number of tiles      | 35                                                                             |
| Total variants       | 39522                                                                          |
| Total oligos         | 395220                                                                         |
| Oligo length range   | 140-290 nt                                                                     |
| Gene blocks to order | 73                                                                             |
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

**Total oligos:** 395220 | **Length range:** 140-290 nt

| Tile | Codons    | Oligos | Length |
| ---- | --------- | ------ | ------ |
| 1    | 1-34      | 6300   | 158 nt |
| 2    | 31-86     | 10920  | 224 nt |
| 3    | 83-144    | 12180  | 242 nt |
| 4    | 141-210   | 13860  | 266 nt |
| 5    | 207-237   | 5670   | 149 nt |
| 6    | 234-288   | 10710  | 221 nt |
| 7    | 285-333   | 9450   | 203 nt |
| 8    | 330-395   | 13020  | 254 nt |
| 9    | 392-449   | 11340  | 230 nt |
| 10   | 446-491   | 8820   | 194 nt |
| 11   | 488-529   | 7980   | 182 nt |
| 12   | 526-592   | 13230  | 257 nt |
| 13   | 593-638   | 8820   | 194 nt |
| 14   | 635-700   | 13020  | 254 nt |
| 15   | 697-762   | 13020  | 254 nt |
| 16   | 759-796   | 7140   | 170 nt |
| 17   | 793-865   | 14490  | 275 nt |
| 18   | 862-889   | 5040   | 140 nt |
| 19   | 890-950   | 11970  | 239 nt |
| 20   | 947-1016  | 13860  | 266 nt |
| 21   | 1013-1074 | 12180  | 242 nt |
| 22   | 1071-1117 | 9030   | 197 nt |
| 23   | 1114-1172 | 11550  | 233 nt |
| 24   | 1169-1239 | 14070  | 269 nt |
| 25   | 1236-1279 | 8400   | 188 nt |
| 26   | 1280-1353 | 14700  | 278 nt |
| 27   | 1350-1427 | 15540  | 290 nt |
| 28   | 1424-1470 | 9030   | 197 nt |
| 29   | 1467-1533 | 13230  | 257 nt |
| 30   | 1530-1603 | 14700  | 278 nt |
| 31   | 1600-1657 | 11340  | 230 nt |
| 32   | 1654-1714 | 11970  | 239 nt |
| 33   | 1711-1783 | 14490  | 275 nt |
| 34   | 1780-1825 | 8820   | 194 nt |
| 35   | 1826-1902 | 15330  | 287 nt |

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
| Total barcodes    | 395220                             |
| Unique barcodes   | 395220                             |
| GC content range  | 25% - 75%                          |
| GC content mean   | 48.4%                              |
| Hamming guarantee | 100% cross-variant (prefix d >= 3) |

## 5. QC Summary

**Overall:** ISSUES FOUND

| Check                  | Description                                                   | Result | Detail                                                                                                                                               |
| ---------------------- | ------------------------------------------------------------- | ------ | ---------------------------------------------------------------------------------------------------------------------------------------------------- |
| oligo_lengths          | All oligos within synthesis length limit                      | PASS   | Range: 140-290 nt (limit: 300)                                                                                                                       |
| block_lengths          | All gene blocks within synthesis length limit                 | PASS   | Range: 108-1794 nt (limit: 1800)                                                                                                                     |
| barcode_junction_sites | No enzyme sites at barcode-context junctions                  | PASS   | 0 barcode(s) with junction enzyme sites (left='CACACC', right='AGAATG')                                                                              |
| barcode_uniqueness     | All barcodes are unique                                       | PASS   | 395220 unique / 395220 total                                                                                                                         |
| tile_coverage          | Tiles cover entire gene without gaps                          | PASS   | 5706 / 5706 nt covered                                                                                                                               |
| variant_count          | Expected number of variants generated                         | PASS   | 39522 unique variants (expected: 39522 across 1882/1900 mutable positions; 35758 missense + 1882 nonsense + 1882 wt_control; 18 position(s) skipped) |
| single_codon_change    | Each non-control variant differs by exactly one codon from WT | PASS   | 376400 / 376400 variants confirmed (WT controls excluded)                                                                                            |
| oligo_gc_content       | Oligo GC content within reasonable range (25-75%)             | PASS   | GC range: 32.7-54% | 0 oligo(s) with extreme GC                                                                                                      |
| domestication_complete | Gene domesticated for all 3 enzymes (BsaI, BsmBI, PaqCI)      | PASS   | No enzyme sites in gene                                                                                                                              |
| overhang_fidelity      | Tile boundary overhangs have adequate fidelity                | FAIL   | 33 tile(s) with low-fidelity boundary overhangs (<0.80)                                                                                              |
| tile_manifests         | Per-tile assembly manifests complete                          | PASS   | 35 tile manifest(s) generated                                                                                                                        |
| helper_plasmid         | Helper plasmid free of unintended BsmBI sites                 | PASS   | OK                                                                                                                                                   |
| reaction_fidelity      | Per-reaction set-level overhang fidelity                      | FAIL   | Min set fidelity: 0.7487 across 70 reactions | 3 reaction(s) below 0.90                                                                              |
| barcode_poliii_term    | No barcodes contain PolIII terminator signal (TTTT)           | PASS   | 0 / 395220 barcode(s) contain TTTT                                                                                                                   |
| block_min_length       | All gene blocks above synthesis minimum length                | FAIL   | 3 block(s) below 300 nt minimum. Range: 108-1794 nt                                                                                                  |
| sb_overhang_collisions | Superblock boundary overhangs are unique (no collisions)      | PASS   | 8 SB boundary OH(s), all unique                                                                                                                      |

## 5b. Reaction Fidelity Summary

Set fidelity for each tile's BsaI and BsmBI reactions,
computed from the actual block overhangs after construction:

| Tile | BsaI OHs | BsaI Set Fidelity | BsmBI OHs | BsmBI Set Fidelity |
| ---- | -------- | ----------------- | --------- | ------------------ |
| 1    | 2        | 1.0000            | 6         | 0.9988             |
| 2    | 3        | 1.0000            | 6         | 0.9386             |
| 3    | 3        | 1.0000            | 6         | 0.9128             |
| 4    | 3        | 1.0000            | 6         | 1.0000             |
| 5    | 3        | 0.8940            | 6         | 1.0000             |
| 6    | 3        | 1.0000            | 6         | 0.9971             |
| 7    | 3        | 1.0000            | 6         | 0.9986             |
| 8    | 3        | 1.0000            | 6         | 1.0000             |
| 9    | 3        | 0.9472            | 6         | 0.9927             |
| 10   | 3        | 1.0000            | 6         | 0.9172             |
| 11   | 3        | 1.0000            | 5         | 1.0000             |
| 12   | 3        | 1.0000            | 5         | 1.0000             |
| 13   | 3        | 1.0000            | 5         | 0.8328             |
| 14   | 4        | 0.9926            | 5         | 1.0000             |
| 15   | 4        | 1.0000            | 5         | 1.0000             |
| 16   | 4        | 1.0000            | 5         | 1.0000             |
| 17   | 4        | 0.9913            | 4         | 1.0000             |
| 18   | 4        | 1.0000            | 4         | 1.0000             |
| 19   | 4        | 1.0000            | 4         | 1.0000             |
| 20   | 4        | 1.0000            | 4         | 1.0000             |
| 21   | 5        | 0.9786            | 4         | 0.7487             |
| 22   | 5        | 1.0000            | 4         | 1.0000             |
| 23   | 5        | 1.0000            | 4         | 1.0000             |
| 24   | 5        | 1.0000            | 3         | 1.0000             |
| 25   | 5        | 0.9718            | 3         | 1.0000             |
| 26   | 5        | 1.0000            | 3         | 1.0000             |
| 27   | 5        | 1.0000            | 3         | 1.0000             |
| 28   | 6        | 0.9926            | 3         | 1.0000             |
| 29   | 6        | 1.0000            | 3         | 0.9770             |
| 30   | 6        | 1.0000            | 3         | 1.0000             |
| 31   | 6        | 0.9472            | 3         | 1.0000             |
| 32   | 6        | 0.9376            | 3         | 1.0000             |
| 33   | 6        | 1.0000            | 2         | 1.0000             |
| 34   | 6        | 1.0000            | 2         | 1.0000             |
| 35   | 6        | 1.0000            | 2         | 1.0000             |

**Min:** 0.7487 | **Max:** 1.0000 | **Mean:** 0.9852

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

### Tile 1 of 35 -- Codons 1-34 (102 nt)

**Boundary overhangs:**

| Position          | Sequence | Fidelity |
| ----------------- | -------- | -------- |
| oh1 (5' boundary) | ATGG     | 0.5393   |
| oh2 (3' boundary) | ATGC     | 0.6171   |

**Variants:** 6300 mutations, 6300 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name                          | Length | 5' OH | 3' OH |
| --- | --------------- | ---------------------------------- | ------ | ----- | ----- |
| 1   | 5'WT gene block | (none -- tile starts at gene nt 1) | --     | --    | --    |
| 2   | Oligo pool      | Tile 1 (6300 oligos)               | 158 nt | ATGG  | AGAA  |
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
| 2   | 3'WT block        | bsmbi_3wt_tile1_sub1     | 1704 nt | ATGC  | ATTT  |
| 3   | 3'WT block        | bsmbi_3wt_tile1_sub2     | 909 nt  | ATTT  | ATCA  |
| 4   | 3'WT block        | bsmbi_3wt_tile1_sub3     | 1188 nt | ATCA  | TTTC  |
| 5   | 3'WT block        | bsmbi_3wt_tile1_sub4     | 1656 nt | TTTC  | TATT  |
| 6   | 3'WT+PolIII block | bsmbi_3wt_tile1_sub5     | 1331 nt | TATT  | CACC  |
| 7   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1 | --      | --    | --    |

```
  [ATGC]----3'WT sub1----[ATTT]----3'WT sub2----[ATCA]----3'WT sub3----[TTTC]----3'WT sub4----[TATT]----3'WT+PolIII sub5----[CACC]
   ATGC                   ATTT                   ATCA                   TTTC                   TATT                          CACC 
```

**Set fidelity:** 0.9988 (6 overhangs)

---

### Tile 2 of 35 -- Codons 31-86 (168 nt)

**Boundary overhangs:**

| Position          | Sequence | Fidelity |
| ----------------- | -------- | -------- |
| oh1 (5' boundary) | TTGC     | 0.7336   |
| oh2 (3' boundary) | CTTC     | 0.6384   |

**Variants:** 10920 mutations, 10920 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name             | Length | 5' OH | 3' OH |
| --- | --------------- | --------------------- | ------ | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile2        | 108 nt | ATGG  | TTGC  |
| 2   | Oligo pool      | Tile 2 (10920 oligos) | 224 nt | TTGC  | AGAA  |
| 3   | Helper plasmid  | helper_plasmid_insert | --     | --    | --    |
| 4   | Enzyme + buffer | BsaI-HFv2 + CutSmart  | --     | --    | --    |

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
| 2   | 3'WT block        | bsmbi_3wt_tile2_sub1     | 1548 nt | CTTC  | ATTT  |
| 3   | 3'WT block        | bsmbi_3wt_tile1_sub2     | 909 nt  | ATTT  | ATCA  |
| 4   | 3'WT block        | bsmbi_3wt_tile1_sub3     | 1188 nt | ATCA  | TTTC  |
| 5   | 3'WT block        | bsmbi_3wt_tile1_sub4     | 1656 nt | TTTC  | TATT  |
| 6   | 3'WT+PolIII block | bsmbi_3wt_tile1_sub5     | 1331 nt | TATT  | CACC  |
| 7   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1 | --      | --    | --    |

```
  [CTTC]----3'WT sub1----[ATTT]----3'WT sub2----[ATCA]----3'WT sub3----[TTTC]----3'WT sub4----[TATT]----3'WT+PolIII sub5----[CACC]
   CTTC                   ATTT                   ATCA                   TTTC                   TATT                          CACC 
```

**Set fidelity:** 0.9386 (6 overhangs)

---

### Tile 3 of 35 -- Codons 83-144 (186 nt)

**Boundary overhangs:**

| Position          | Sequence | Fidelity |
| ----------------- | -------- | -------- |
| oh1 (5' boundary) | GATA     | 0.7029   |
| oh2 (3' boundary) | ATAT     | 0.7934   |

**Variants:** 12180 mutations, 12180 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name             | Length | 5' OH | 3' OH |
| --- | --------------- | --------------------- | ------ | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile3        | 264 nt | ATGG  | GATA  |
| 2   | Oligo pool      | Tile 3 (12180 oligos) | 242 nt | GATA  | AGAA  |
| 3   | Helper plasmid  | helper_plasmid_insert | --     | --    | --    |
| 4   | Enzyme + buffer | BsaI-HFv2 + CutSmart  | --     | --    | --    |

```
  [ATGG]----5'WT block----[GATA]----oligo+BC----[AGAA]
   ATGG                    GATA                  AGAA 
```

**Set fidelity:** 1.0000 (3 overhangs)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------ | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)      | --      | --    | --    |
| 2   | 3'WT block        | bsmbi_3wt_tile3_sub1     | 1374 nt | ATAT  | ATTT  |
| 3   | 3'WT block        | bsmbi_3wt_tile1_sub2     | 909 nt  | ATTT  | ATCA  |
| 4   | 3'WT block        | bsmbi_3wt_tile1_sub3     | 1188 nt | ATCA  | TTTC  |
| 5   | 3'WT block        | bsmbi_3wt_tile1_sub4     | 1656 nt | TTTC  | TATT  |
| 6   | 3'WT+PolIII block | bsmbi_3wt_tile1_sub5     | 1331 nt | TATT  | CACC  |
| 7   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1 | --      | --    | --    |

```
  [ATAT]----3'WT sub1----[ATTT]----3'WT sub2----[ATCA]----3'WT sub3----[TTTC]----3'WT sub4----[TATT]----3'WT+PolIII sub5----[CACC]
   ATAT                   ATTT                   ATCA                   TTTC                   TATT                          CACC 
```

**Set fidelity:** 0.9128 (6 overhangs)

---

### Tile 4 of 35 -- Codons 141-210 (210 nt)

**Boundary overhangs:**

| Position          | Sequence | Fidelity |
| ----------------- | -------- | -------- |
| oh1 (5' boundary) | ATCT     | 0.7151   |
| oh2 (3' boundary) | GAGC     | 0.5446   |

**Variants:** 13860 mutations, 13860 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name             | Length | 5' OH | 3' OH |
| --- | --------------- | --------------------- | ------ | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile4        | 438 nt | ATGG  | ATCT  |
| 2   | Oligo pool      | Tile 4 (13860 oligos) | 266 nt | ATCT  | AGAA  |
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
| 2   | 3'WT block        | bsmbi_3wt_tile4_sub1     | 1176 nt | GAGC  | ATTT  |
| 3   | 3'WT block        | bsmbi_3wt_tile1_sub2     | 909 nt  | ATTT  | ATCA  |
| 4   | 3'WT block        | bsmbi_3wt_tile1_sub3     | 1188 nt | ATCA  | TTTC  |
| 5   | 3'WT block        | bsmbi_3wt_tile1_sub4     | 1656 nt | TTTC  | TATT  |
| 6   | 3'WT+PolIII block | bsmbi_3wt_tile1_sub5     | 1331 nt | TATT  | CACC  |
| 7   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1 | --      | --    | --    |

```
  [GAGC]----3'WT sub1----[ATTT]----3'WT sub2----[ATCA]----3'WT sub3----[TTTC]----3'WT sub4----[TATT]----3'WT+PolIII sub5----[CACC]
   GAGC                   ATTT                   ATCA                   TTTC                   TATT                          CACC 
```

**Set fidelity:** 1.0000 (6 overhangs)

---

### Tile 5 of 35 -- Codons 207-237 (93 nt)

**Boundary overhangs:**

| Position          | Sequence | Fidelity |
| ----------------- | -------- | -------- |
| oh1 (5' boundary) | ATGA     | 0.7549   |
| oh2 (3' boundary) | ACAG     | 0.5793   |

**Variants:** 5670 mutations, 5670 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name             | Length | 5' OH | 3' OH |
| --- | --------------- | --------------------- | ------ | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile5        | 636 nt | ATGG  | ATGA  |
| 2   | Oligo pool      | Tile 5 (5670 oligos)  | 149 nt | ATGA  | AGAA  |
| 3   | Helper plasmid  | helper_plasmid_insert | --     | --    | --    |
| 4   | Enzyme + buffer | BsaI-HFv2 + CutSmart  | --     | --    | --    |

```
  [ATGG]----5'WT block----[ATGA]----oligo+BC----[AGAA]
   ATGG                    ATGA                  AGAA 
```

**Set fidelity:** 0.8940 (3 overhangs)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------ | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)      | --      | --    | --    |
| 2   | 3'WT block        | bsmbi_3wt_tile5_sub1     | 1095 nt | ACAG  | ATTT  |
| 3   | 3'WT block        | bsmbi_3wt_tile1_sub2     | 909 nt  | ATTT  | ATCA  |
| 4   | 3'WT block        | bsmbi_3wt_tile1_sub3     | 1188 nt | ATCA  | TTTC  |
| 5   | 3'WT block        | bsmbi_3wt_tile1_sub4     | 1656 nt | TTTC  | TATT  |
| 6   | 3'WT+PolIII block | bsmbi_3wt_tile1_sub5     | 1331 nt | TATT  | CACC  |
| 7   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1 | --      | --    | --    |

```
  [ACAG]----3'WT sub1----[ATTT]----3'WT sub2----[ATCA]----3'WT sub3----[TTTC]----3'WT sub4----[TATT]----3'WT+PolIII sub5----[CACC]
   ACAG                   ATTT                   ATCA                   TTTC                   TATT                          CACC 
```

**Set fidelity:** 1.0000 (6 overhangs)

---

### Tile 6 of 35 -- Codons 234-288 (165 nt)

**Boundary overhangs:**

| Position          | Sequence | Fidelity |
| ----------------- | -------- | -------- |
| oh1 (5' boundary) | AAGA     | 0.9209   |
| oh2 (3' boundary) | TAGT     | 0.7437   |

**Variants:** 10710 mutations, 10710 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name             | Length | 5' OH | 3' OH |
| --- | --------------- | --------------------- | ------ | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile6        | 717 nt | ATGG  | AAGA  |
| 2   | Oligo pool      | Tile 6 (10710 oligos) | 221 nt | AAGA  | AGAA  |
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
| 2   | 3'WT block        | bsmbi_3wt_tile6_sub1     | 942 nt  | TAGT  | ATTT  |
| 3   | 3'WT block        | bsmbi_3wt_tile1_sub2     | 909 nt  | ATTT  | ATCA  |
| 4   | 3'WT block        | bsmbi_3wt_tile1_sub3     | 1188 nt | ATCA  | TTTC  |
| 5   | 3'WT block        | bsmbi_3wt_tile1_sub4     | 1656 nt | TTTC  | TATT  |
| 6   | 3'WT+PolIII block | bsmbi_3wt_tile1_sub5     | 1331 nt | TATT  | CACC  |
| 7   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1 | --      | --    | --    |

```
  [TAGT]----3'WT sub1----[ATTT]----3'WT sub2----[ATCA]----3'WT sub3----[TTTC]----3'WT sub4----[TATT]----3'WT+PolIII sub5----[CACC]
   TAGT                   ATTT                   ATCA                   TTTC                   TATT                          CACC 
```

**Set fidelity:** 0.9971 (6 overhangs)

---

### Tile 7 of 35 -- Codons 285-333 (147 nt)

**Boundary overhangs:**

| Position          | Sequence | Fidelity |
| ----------------- | -------- | -------- |
| oh1 (5' boundary) | TCTA     | 0.8892   |
| oh2 (3' boundary) | TAAA     | 0.9392   |

**Variants:** 9450 mutations, 9450 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name             | Length | 5' OH | 3' OH |
| --- | --------------- | --------------------- | ------ | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile7        | 870 nt | ATGG  | TCTA  |
| 2   | Oligo pool      | Tile 7 (9450 oligos)  | 203 nt | TCTA  | AGAA  |
| 3   | Helper plasmid  | helper_plasmid_insert | --     | --    | --    |
| 4   | Enzyme + buffer | BsaI-HFv2 + CutSmart  | --     | --    | --    |

```
  [ATGG]----5'WT block----[TCTA]----oligo+BC----[AGAA]
   ATGG                    TCTA                  AGAA 
```

**Set fidelity:** 1.0000 (3 overhangs)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------ | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)      | --      | --    | --    |
| 2   | 3'WT block        | bsmbi_3wt_tile7_sub1     | 807 nt  | TAAA  | ATTT  |
| 3   | 3'WT block        | bsmbi_3wt_tile1_sub2     | 909 nt  | ATTT  | ATCA  |
| 4   | 3'WT block        | bsmbi_3wt_tile1_sub3     | 1188 nt | ATCA  | TTTC  |
| 5   | 3'WT block        | bsmbi_3wt_tile1_sub4     | 1656 nt | TTTC  | TATT  |
| 6   | 3'WT+PolIII block | bsmbi_3wt_tile1_sub5     | 1331 nt | TATT  | CACC  |
| 7   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1 | --      | --    | --    |

```
  [TAAA]----3'WT sub1----[ATTT]----3'WT sub2----[ATCA]----3'WT sub3----[TTTC]----3'WT sub4----[TATT]----3'WT+PolIII sub5----[CACC]
   TAAA                   ATTT                   ATCA                   TTTC                   TATT                          CACC 
```

**Set fidelity:** 0.9986 (6 overhangs)

---

### Tile 8 of 35 -- Codons 330-395 (198 nt)

**Boundary overhangs:**

| Position          | Sequence | Fidelity |
| ----------------- | -------- | -------- |
| oh1 (5' boundary) | AAAG     | 0.7511   |
| oh2 (3' boundary) | TCAA     | 0.9425   |

**Variants:** 13020 mutations, 13020 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name             | Length  | 5' OH | 3' OH |
| --- | --------------- | --------------------- | ------- | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile8        | 1005 nt | ATGG  | AAAG  |
| 2   | Oligo pool      | Tile 8 (13020 oligos) | 254 nt  | AAAG  | AGAA  |
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
| 2   | 3'WT block        | bsmbi_3wt_tile8_sub1     | 621 nt  | TCAA  | ATTT  |
| 3   | 3'WT block        | bsmbi_3wt_tile1_sub2     | 909 nt  | ATTT  | ATCA  |
| 4   | 3'WT block        | bsmbi_3wt_tile1_sub3     | 1188 nt | ATCA  | TTTC  |
| 5   | 3'WT block        | bsmbi_3wt_tile1_sub4     | 1656 nt | TTTC  | TATT  |
| 6   | 3'WT+PolIII block | bsmbi_3wt_tile1_sub5     | 1331 nt | TATT  | CACC  |
| 7   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1 | --      | --    | --    |

```
  [TCAA]----3'WT sub1----[ATTT]----3'WT sub2----[ATCA]----3'WT sub3----[TTTC]----3'WT sub4----[TATT]----3'WT+PolIII sub5----[CACC]
   TCAA                   ATTT                   ATCA                   TTTC                   TATT                          CACC 
```

**Set fidelity:** 1.0000 (6 overhangs)

---

### Tile 9 of 35 -- Codons 392-449 (174 nt)

**Boundary overhangs:**

| Position          | Sequence | Fidelity |
| ----------------- | -------- | -------- |
| oh1 (5' boundary) | GGAA     | 0.7463   |
| oh2 (3' boundary) | CTCT     | 0.6347   |

**Variants:** 11340 mutations, 11340 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name             | Length  | 5' OH | 3' OH |
| --- | --------------- | --------------------- | ------- | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile9        | 1191 nt | ATGG  | GGAA  |
| 2   | Oligo pool      | Tile 9 (11340 oligos) | 230 nt  | GGAA  | AGAA  |
| 3   | Helper plasmid  | helper_plasmid_insert | --      | --    | --    |
| 4   | Enzyme + buffer | BsaI-HFv2 + CutSmart  | --      | --    | --    |

```
  [ATGG]----5'WT block----[GGAA]----oligo+BC----[AGAA]
   ATGG                    GGAA                  AGAA 
```

**Set fidelity:** 0.9472 (3 overhangs)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------ | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)      | --      | --    | --    |
| 2   | 3'WT block        | bsmbi_3wt_tile9_sub1     | 459 nt  | CTCT  | ATTT  |
| 3   | 3'WT block        | bsmbi_3wt_tile1_sub2     | 909 nt  | ATTT  | ATCA  |
| 4   | 3'WT block        | bsmbi_3wt_tile1_sub3     | 1188 nt | ATCA  | TTTC  |
| 5   | 3'WT block        | bsmbi_3wt_tile1_sub4     | 1656 nt | TTTC  | TATT  |
| 6   | 3'WT+PolIII block | bsmbi_3wt_tile1_sub5     | 1331 nt | TATT  | CACC  |
| 7   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1 | --      | --    | --    |

```
  [CTCT]----3'WT sub1----[ATTT]----3'WT sub2----[ATCA]----3'WT sub3----[TTTC]----3'WT sub4----[TATT]----3'WT+PolIII sub5----[CACC]
   CTCT                   ATTT                   ATCA                   TTTC                   TATT                          CACC 
```

**Set fidelity:** 0.9927 (6 overhangs)

---

### Tile 10 of 35 -- Codons 446-491 (138 nt)

**Boundary overhangs:**

| Position          | Sequence | Fidelity |
| ----------------- | -------- | -------- |
| oh1 (5' boundary) | TTAT     | 0.8673   |
| oh2 (3' boundary) | CATT     | 0.6770   |

**Variants:** 8820 mutations, 8820 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name             | Length  | 5' OH | 3' OH |
| --- | --------------- | --------------------- | ------- | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile10       | 1353 nt | ATGG  | TTAT  |
| 2   | Oligo pool      | Tile 10 (8820 oligos) | 194 nt  | TTAT  | AGAA  |
| 3   | Helper plasmid  | helper_plasmid_insert | --      | --    | --    |
| 4   | Enzyme + buffer | BsaI-HFv2 + CutSmart  | --      | --    | --    |

```
  [ATGG]----5'WT block----[TTAT]----oligo+BC----[AGAA]
   ATGG                    TTAT                  AGAA 
```

**Set fidelity:** 1.0000 (3 overhangs)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------ | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)      | --      | --    | --    |
| 2   | 3'WT block        | bsmbi_3wt_tile10_sub1    | 333 nt  | CATT  | ATTT  |
| 3   | 3'WT block        | bsmbi_3wt_tile1_sub2     | 909 nt  | ATTT  | ATCA  |
| 4   | 3'WT block        | bsmbi_3wt_tile1_sub3     | 1188 nt | ATCA  | TTTC  |
| 5   | 3'WT block        | bsmbi_3wt_tile1_sub4     | 1656 nt | TTTC  | TATT  |
| 6   | 3'WT+PolIII block | bsmbi_3wt_tile1_sub5     | 1331 nt | TATT  | CACC  |
| 7   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1 | --      | --    | --    |

```
  [CATT]----3'WT sub1----[ATTT]----3'WT sub2----[ATCA]----3'WT sub3----[TTTC]----3'WT sub4----[TATT]----3'WT+PolIII sub5----[CACC]
   CATT                   ATTT                   ATCA                   TTTC                   TATT                          CACC 
```

**Set fidelity:** 0.9172 (6 overhangs)

---

### Tile 11 of 35 -- Codons 488-529 (126 nt)

**Boundary overhangs:**

| Position          | Sequence | Fidelity |
| ----------------- | -------- | -------- |
| oh1 (5' boundary) | TATG     | 0.7006   |
| oh2 (3' boundary) | CCTT     | 0.6891   |

**Variants:** 7980 mutations, 7980 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name             | Length  | 5' OH | 3' OH |
| --- | --------------- | --------------------- | ------- | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile11       | 1479 nt | ATGG  | TATG  |
| 2   | Oligo pool      | Tile 11 (7980 oligos) | 182 nt  | TATG  | AGAA  |
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
| 2   | 3'WT block        | bsmbi_3wt_tile11_sub1    | 1110 nt | CCTT  | ATCA  |
| 3   | 3'WT block        | bsmbi_3wt_tile1_sub3     | 1188 nt | ATCA  | TTTC  |
| 4   | 3'WT block        | bsmbi_3wt_tile1_sub4     | 1656 nt | TTTC  | TATT  |
| 5   | 3'WT+PolIII block | bsmbi_3wt_tile1_sub5     | 1331 nt | TATT  | CACC  |
| 6   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1 | --      | --    | --    |

```
  [CCTT]----3'WT sub1----[ATCA]----3'WT sub2----[TTTC]----3'WT sub3----[TATT]----3'WT+PolIII sub4----[CACC]
   CCTT                   ATCA                   TTTC                   TATT                          CACC 
```

**Set fidelity:** 1.0000 (5 overhangs)

---

### Tile 12 of 35 -- Codons 526-592 (201 nt)

**Boundary overhangs:**

| Position          | Sequence | Fidelity |
| ----------------- | -------- | -------- |
| oh1 (5' boundary) | GTAA     | 0.8029   |
| oh2 (3' boundary) | ATTT     | 0.7664   |

**Variants:** 13230 mutations, 13230 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name              | Length  | 5' OH | 3' OH |
| --- | --------------- | ---------------------- | ------- | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile12        | 1593 nt | ATGG  | GTAA  |
| 2   | Oligo pool      | Tile 12 (13230 oligos) | 257 nt  | GTAA  | AGAA  |
| 3   | Helper plasmid  | helper_plasmid_insert  | --      | --    | --    |
| 4   | Enzyme + buffer | BsaI-HFv2 + CutSmart   | --      | --    | --    |

```
  [ATGG]----5'WT block----[GTAA]----oligo+BC----[AGAA]
   ATGG                    GTAA                  AGAA 
```

**Set fidelity:** 1.0000 (3 overhangs)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------ | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)      | --      | --    | --    |
| 2   | 3'WT block        | bsmbi_3wt_tile12_sub1    | 921 nt  | ATTT  | ATCA  |
| 3   | 3'WT block        | bsmbi_3wt_tile1_sub3     | 1188 nt | ATCA  | TTTC  |
| 4   | 3'WT block        | bsmbi_3wt_tile1_sub4     | 1656 nt | TTTC  | TATT  |
| 5   | 3'WT+PolIII block | bsmbi_3wt_tile1_sub5     | 1331 nt | TATT  | CACC  |
| 6   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1 | --      | --    | --    |

```
  [ATTT]----3'WT sub1----[ATCA]----3'WT sub2----[TTTC]----3'WT sub3----[TATT]----3'WT+PolIII sub4----[CACC]
   ATTT                   ATCA                   TTTC                   TATT                          CACC 
```

**Set fidelity:** 1.0000 (5 overhangs)

---

### Tile 13 of 35 -- Codons 593-638 (138 nt)

**Boundary overhangs:**

| Position          | Sequence | Fidelity |
| ----------------- | -------- | -------- |
| oh1 (5' boundary) | CAGA     | 0.8175   |
| oh2 (3' boundary) | CACA     | 0.6141   |

**Variants:** 8820 mutations, 8820 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name             | Length  | 5' OH | 3' OH |
| --- | --------------- | --------------------- | ------- | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile13       | 1794 nt | ATGG  | CAGA  |
| 2   | Oligo pool      | Tile 13 (8820 oligos) | 194 nt  | CAGA  | AGAA  |
| 3   | Helper plasmid  | helper_plasmid_insert | --      | --    | --    |
| 4   | Enzyme + buffer | BsaI-HFv2 + CutSmart  | --      | --    | --    |

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
| 2   | 3'WT block        | bsmbi_3wt_tile13_sub1    | 783 nt  | CACA  | ATCA  |
| 3   | 3'WT block        | bsmbi_3wt_tile1_sub3     | 1188 nt | ATCA  | TTTC  |
| 4   | 3'WT block        | bsmbi_3wt_tile1_sub4     | 1656 nt | TTTC  | TATT  |
| 5   | 3'WT+PolIII block | bsmbi_3wt_tile1_sub5     | 1331 nt | TATT  | CACC  |
| 6   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1 | --      | --    | --    |

```
  [CACA]----3'WT sub1----[ATCA]----3'WT sub2----[TTTC]----3'WT sub3----[TATT]----3'WT+PolIII sub4----[CACC]
   CACA                   ATCA                   TTTC                   TATT                          CACC 
```

**Set fidelity:** 0.8328 (5 overhangs)

---

### Tile 14 of 35 -- Codons 635-700 (198 nt)

**Boundary overhangs:**

| Position          | Sequence | Fidelity |
| ----------------- | -------- | -------- |
| oh1 (5' boundary) | AAGA     | 0.9209   |
| oh2 (3' boundary) | TGAG     | 0.6546   |

**Variants:** 13020 mutations, 13020 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name              | Length  | 5' OH | 3' OH |
| --- | --------------- | ---------------------- | ------- | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile13        | 1794 nt | ATGG  | CAGA  |
| 2   | 5'WT gene block | bsai_5wt_tile14_sub2   | 144 nt  | CAGA  | AAGA  |
| 3   | Oligo pool      | Tile 14 (13020 oligos) | 254 nt  | AAGA  | AGAA  |
| 4   | Helper plasmid  | helper_plasmid_insert  | --      | --    | --    |
| 5   | Enzyme + buffer | BsaI-HFv2 + CutSmart   | --      | --    | --    |

```
  [ATGG]----5'WT sub1----[CAGA]----5'WT sub2----[AAGA]----oligo+BC----[AGAA]
   ATGG                   CAGA                   AAGA                  AGAA 
```

**Set fidelity:** 0.9926 (4 overhangs)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------ | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)      | --      | --    | --    |
| 2   | 3'WT block        | bsmbi_3wt_tile14_sub1    | 597 nt  | TGAG  | ATCA  |
| 3   | 3'WT block        | bsmbi_3wt_tile1_sub3     | 1188 nt | ATCA  | TTTC  |
| 4   | 3'WT block        | bsmbi_3wt_tile1_sub4     | 1656 nt | TTTC  | TATT  |
| 5   | 3'WT+PolIII block | bsmbi_3wt_tile1_sub5     | 1331 nt | TATT  | CACC  |
| 6   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1 | --      | --    | --    |

```
  [TGAG]----3'WT sub1----[ATCA]----3'WT sub2----[TTTC]----3'WT sub3----[TATT]----3'WT+PolIII sub4----[CACC]
   TGAG                   ATCA                   TTTC                   TATT                          CACC 
```

**Set fidelity:** 1.0000 (5 overhangs)

---

### Tile 15 of 35 -- Codons 697-762 (198 nt)

**Boundary overhangs:**

| Position          | Sequence | Fidelity |
| ----------------- | -------- | -------- |
| oh1 (5' boundary) | GTAA     | 0.8029   |
| oh2 (3' boundary) | AGTG     | 0.5190   |

**Variants:** 13020 mutations, 13020 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name              | Length  | 5' OH | 3' OH |
| --- | --------------- | ---------------------- | ------- | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile13        | 1794 nt | ATGG  | CAGA  |
| 2   | 5'WT gene block | bsai_5wt_tile15_sub2   | 330 nt  | CAGA  | GTAA  |
| 3   | Oligo pool      | Tile 15 (13020 oligos) | 254 nt  | GTAA  | AGAA  |
| 4   | Helper plasmid  | helper_plasmid_insert  | --      | --    | --    |
| 5   | Enzyme + buffer | BsaI-HFv2 + CutSmart   | --      | --    | --    |

```
  [ATGG]----5'WT sub1----[CAGA]----5'WT sub2----[GTAA]----oligo+BC----[AGAA]
   ATGG                   CAGA                   GTAA                  AGAA 
```

**Set fidelity:** 1.0000 (4 overhangs)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------ | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)      | --      | --    | --    |
| 2   | 3'WT block        | bsmbi_3wt_tile15_sub1    | 411 nt  | AGTG  | ATCA  |
| 3   | 3'WT block        | bsmbi_3wt_tile1_sub3     | 1188 nt | ATCA  | TTTC  |
| 4   | 3'WT block        | bsmbi_3wt_tile1_sub4     | 1656 nt | TTTC  | TATT  |
| 5   | 3'WT+PolIII block | bsmbi_3wt_tile1_sub5     | 1331 nt | TATT  | CACC  |
| 6   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1 | --      | --    | --    |

```
  [AGTG]----3'WT sub1----[ATCA]----3'WT sub2----[TTTC]----3'WT sub3----[TATT]----3'WT+PolIII sub4----[CACC]
   AGTG                   ATCA                   TTTC                   TATT                          CACC 
```

**Set fidelity:** 1.0000 (5 overhangs)

---

### Tile 16 of 35 -- Codons 759-796 (114 nt)

**Boundary overhangs:**

| Position          | Sequence | Fidelity |
| ----------------- | -------- | -------- |
| oh1 (5' boundary) | GAAT     | 0.7246   |
| oh2 (3' boundary) | TCAG     | 0.7814   |

**Variants:** 7140 mutations, 7140 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name             | Length  | 5' OH | 3' OH |
| --- | --------------- | --------------------- | ------- | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile13       | 1794 nt | ATGG  | CAGA  |
| 2   | 5'WT gene block | bsai_5wt_tile16_sub2  | 516 nt  | CAGA  | GAAT  |
| 3   | Oligo pool      | Tile 16 (7140 oligos) | 170 nt  | GAAT  | AGAA  |
| 4   | Helper plasmid  | helper_plasmid_insert | --      | --    | --    |
| 5   | Enzyme + buffer | BsaI-HFv2 + CutSmart  | --      | --    | --    |

```
  [ATGG]----5'WT sub1----[CAGA]----5'WT sub2----[GAAT]----oligo+BC----[AGAA]
   ATGG                   CAGA                   GAAT                  AGAA 
```

**Set fidelity:** 1.0000 (4 overhangs)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------ | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)      | --      | --    | --    |
| 2   | 3'WT block        | bsmbi_3wt_tile16_sub1    | 309 nt  | TCAG  | ATCA  |
| 3   | 3'WT block        | bsmbi_3wt_tile1_sub3     | 1188 nt | ATCA  | TTTC  |
| 4   | 3'WT block        | bsmbi_3wt_tile1_sub4     | 1656 nt | TTTC  | TATT  |
| 5   | 3'WT+PolIII block | bsmbi_3wt_tile1_sub5     | 1331 nt | TATT  | CACC  |
| 6   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1 | --      | --    | --    |

```
  [TCAG]----3'WT sub1----[ATCA]----3'WT sub2----[TTTC]----3'WT sub3----[TATT]----3'WT+PolIII sub4----[CACC]
   TCAG                   ATCA                   TTTC                   TATT                          CACC 
```

**Set fidelity:** 1.0000 (5 overhangs)

---

### Tile 17 of 35 -- Codons 793-865 (219 nt)

**Boundary overhangs:**

| Position          | Sequence | Fidelity |
| ----------------- | -------- | -------- |
| oh1 (5' boundary) | CATA     | 0.7540   |
| oh2 (3' boundary) | TCCT     | 0.7573   |

**Variants:** 14490 mutations, 14490 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name              | Length  | 5' OH | 3' OH |
| --- | --------------- | ---------------------- | ------- | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile13        | 1794 nt | ATGG  | CAGA  |
| 2   | 5'WT gene block | bsai_5wt_tile17_sub2   | 618 nt  | CAGA  | CATA  |
| 3   | Oligo pool      | Tile 17 (14490 oligos) | 275 nt  | CATA  | AGAA  |
| 4   | Helper plasmid  | helper_plasmid_insert  | --      | --    | --    |
| 5   | Enzyme + buffer | BsaI-HFv2 + CutSmart   | --      | --    | --    |

```
  [ATGG]----5'WT sub1----[CAGA]----5'WT sub2----[CATA]----oligo+BC----[AGAA]
   ATGG                   CAGA                   CATA                  AGAA 
```

**Set fidelity:** 0.9913 (4 overhangs)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------ | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)      | --      | --    | --    |
| 2   | 3'WT block        | bsmbi_3wt_tile17_sub1    | 1272 nt | TCCT  | TTTC  |
| 3   | 3'WT block        | bsmbi_3wt_tile1_sub4     | 1656 nt | TTTC  | TATT  |
| 4   | 3'WT+PolIII block | bsmbi_3wt_tile1_sub5     | 1331 nt | TATT  | CACC  |
| 5   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1 | --      | --    | --    |

```
  [TCCT]----3'WT sub1----[TTTC]----3'WT sub2----[TATT]----3'WT+PolIII sub3----[CACC]
   TCCT                   TTTC                   TATT                          CACC 
```

**Set fidelity:** 1.0000 (4 overhangs)

---

### Tile 18 of 35 -- Codons 862-889 (84 nt)

**Boundary overhangs:**

| Position          | Sequence | Fidelity |
| ----------------- | -------- | -------- |
| oh1 (5' boundary) | TCCT     | 0.7573   |
| oh2 (3' boundary) | ATCA     | 0.7483   |

**Variants:** 5040 mutations, 5040 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name             | Length  | 5' OH | 3' OH |
| --- | --------------- | --------------------- | ------- | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile13       | 1794 nt | ATGG  | CAGA  |
| 2   | 5'WT gene block | bsai_5wt_tile18_sub2  | 825 nt  | CAGA  | TCCT  |
| 3   | Oligo pool      | Tile 18 (5040 oligos) | 140 nt  | TCCT  | AGAA  |
| 4   | Helper plasmid  | helper_plasmid_insert | --      | --    | --    |
| 5   | Enzyme + buffer | BsaI-HFv2 + CutSmart  | --      | --    | --    |

```
  [ATGG]----5'WT sub1----[CAGA]----5'WT sub2----[TCCT]----oligo+BC----[AGAA]
   ATGG                   CAGA                   TCCT                  AGAA 
```

**Set fidelity:** 1.0000 (4 overhangs)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------ | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)      | --      | --    | --    |
| 2   | 3'WT block        | bsmbi_3wt_tile18_sub1    | 1200 nt | ATCA  | TTTC  |
| 3   | 3'WT block        | bsmbi_3wt_tile1_sub4     | 1656 nt | TTTC  | TATT  |
| 4   | 3'WT+PolIII block | bsmbi_3wt_tile1_sub5     | 1331 nt | TATT  | CACC  |
| 5   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1 | --      | --    | --    |

```
  [ATCA]----3'WT sub1----[TTTC]----3'WT sub2----[TATT]----3'WT+PolIII sub3----[CACC]
   ATCA                   TTTC                   TATT                          CACC 
```

**Set fidelity:** 1.0000 (4 overhangs)

---

### Tile 19 of 35 -- Codons 890-950 (183 nt)

**Boundary overhangs:**

| Position          | Sequence | Fidelity |
| ----------------- | -------- | -------- |
| oh1 (5' boundary) | TCAA     | 0.9425   |
| oh2 (3' boundary) | GAGC     | 0.5446   |

**Variants:** 11970 mutations, 11970 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name              | Length  | 5' OH | 3' OH |
| --- | --------------- | ---------------------- | ------- | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile13        | 1794 nt | ATGG  | CAGA  |
| 2   | 5'WT gene block | bsai_5wt_tile19_sub2   | 909 nt  | CAGA  | TCAA  |
| 3   | Oligo pool      | Tile 19 (11970 oligos) | 239 nt  | TCAA  | AGAA  |
| 4   | Helper plasmid  | helper_plasmid_insert  | --      | --    | --    |
| 5   | Enzyme + buffer | BsaI-HFv2 + CutSmart   | --      | --    | --    |

```
  [ATGG]----5'WT sub1----[CAGA]----5'WT sub2----[TCAA]----oligo+BC----[AGAA]
   ATGG                   CAGA                   TCAA                  AGAA 
```

**Set fidelity:** 1.0000 (4 overhangs)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------ | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)      | --      | --    | --    |
| 2   | 3'WT block        | bsmbi_3wt_tile19_sub1    | 1017 nt | GAGC  | TTTC  |
| 3   | 3'WT block        | bsmbi_3wt_tile1_sub4     | 1656 nt | TTTC  | TATT  |
| 4   | 3'WT+PolIII block | bsmbi_3wt_tile1_sub5     | 1331 nt | TATT  | CACC  |
| 5   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1 | --      | --    | --    |

```
  [GAGC]----3'WT sub1----[TTTC]----3'WT sub2----[TATT]----3'WT+PolIII sub3----[CACC]
   GAGC                   TTTC                   TATT                          CACC 
```

**Set fidelity:** 1.0000 (4 overhangs)

---

### Tile 20 of 35 -- Codons 947-1016 (210 nt)

**Boundary overhangs:**

| Position          | Sequence | Fidelity |
| ----------------- | -------- | -------- |
| oh1 (5' boundary) | ATTA     | 0.7818   |
| oh2 (3' boundary) | CCTA     | 0.6679   |

**Variants:** 13860 mutations, 13860 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name              | Length  | 5' OH | 3' OH |
| --- | --------------- | ---------------------- | ------- | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile13        | 1794 nt | ATGG  | CAGA  |
| 2   | 5'WT gene block | bsai_5wt_tile20_sub2   | 1080 nt | CAGA  | ATTA  |
| 3   | Oligo pool      | Tile 20 (13860 oligos) | 266 nt  | ATTA  | AGAA  |
| 4   | Helper plasmid  | helper_plasmid_insert  | --      | --    | --    |
| 5   | Enzyme + buffer | BsaI-HFv2 + CutSmart   | --      | --    | --    |

```
  [ATGG]----5'WT sub1----[CAGA]----5'WT sub2----[ATTA]----oligo+BC----[AGAA]
   ATGG                   CAGA                   ATTA                  AGAA 
```

**Set fidelity:** 1.0000 (4 overhangs)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------ | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)      | --      | --    | --    |
| 2   | 3'WT block        | bsmbi_3wt_tile20_sub1    | 819 nt  | CCTA  | TTTC  |
| 3   | 3'WT block        | bsmbi_3wt_tile1_sub4     | 1656 nt | TTTC  | TATT  |
| 4   | 3'WT+PolIII block | bsmbi_3wt_tile1_sub5     | 1331 nt | TATT  | CACC  |
| 5   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1 | --      | --    | --    |

```
  [CCTA]----3'WT sub1----[TTTC]----3'WT sub2----[TATT]----3'WT+PolIII sub3----[CACC]
   CCTA                   TTTC                   TATT                          CACC 
```

**Set fidelity:** 1.0000 (4 overhangs)

---

### Tile 21 of 35 -- Codons 1013-1074 (186 nt)

**Boundary overhangs:**

| Position          | Sequence | Fidelity |
| ----------------- | -------- | -------- |
| oh1 (5' boundary) | TCTA     | 0.8892   |
| oh2 (3' boundary) | TACC     | 0.7054   |

**Variants:** 12180 mutations, 12180 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name              | Length  | 5' OH | 3' OH |
| --- | --------------- | ---------------------- | ------- | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile13        | 1794 nt | ATGG  | CAGA  |
| 2   | 5'WT gene block | bsai_5wt_tile19_sub2   | 909 nt  | CAGA  | TCAA  |
| 3   | 5'WT gene block | bsai_5wt_tile21_sub3   | 387 nt  | TCAA  | TCTA  |
| 4   | Oligo pool      | Tile 21 (12180 oligos) | 242 nt  | TCTA  | AGAA  |
| 5   | Helper plasmid  | helper_plasmid_insert  | --      | --    | --    |
| 6   | Enzyme + buffer | BsaI-HFv2 + CutSmart   | --      | --    | --    |

```
  [ATGG]----5'WT sub1----[CAGA]----5'WT sub2----[TCAA]----5'WT sub3----[TCTA]----oligo+BC----[AGAA]
   ATGG                   CAGA                   TCAA                   TCTA                  AGAA 
```

**Set fidelity:** 0.9786 (5 overhangs)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------ | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)      | --      | --    | --    |
| 2   | 3'WT block        | bsmbi_3wt_tile21_sub1    | 645 nt  | TACC  | TTTC  |
| 3   | 3'WT block        | bsmbi_3wt_tile1_sub4     | 1656 nt | TTTC  | TATT  |
| 4   | 3'WT+PolIII block | bsmbi_3wt_tile1_sub5     | 1331 nt | TATT  | CACC  |
| 5   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1 | --      | --    | --    |

```
  [TACC]----3'WT sub1----[TTTC]----3'WT sub2----[TATT]----3'WT+PolIII sub3----[CACC]
   TACC                   TTTC                   TATT                          CACC 
```

**Set fidelity:** 0.7487 (4 overhangs)

---

### Tile 22 of 35 -- Codons 1071-1117 (141 nt)

**Boundary overhangs:**

| Position          | Sequence | Fidelity |
| ----------------- | -------- | -------- |
| oh1 (5' boundary) | ACTT     | 0.7315   |
| oh2 (3' boundary) | AACT     | 0.6635   |

**Variants:** 9030 mutations, 9030 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name             | Length  | 5' OH | 3' OH |
| --- | --------------- | --------------------- | ------- | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile13       | 1794 nt | ATGG  | CAGA  |
| 2   | 5'WT gene block | bsai_5wt_tile19_sub2  | 909 nt  | CAGA  | TCAA  |
| 3   | 5'WT gene block | bsai_5wt_tile22_sub3  | 561 nt  | TCAA  | ACTT  |
| 4   | Oligo pool      | Tile 22 (9030 oligos) | 197 nt  | ACTT  | AGAA  |
| 5   | Helper plasmid  | helper_plasmid_insert | --      | --    | --    |
| 6   | Enzyme + buffer | BsaI-HFv2 + CutSmart  | --      | --    | --    |

```
  [ATGG]----5'WT sub1----[CAGA]----5'WT sub2----[TCAA]----5'WT sub3----[ACTT]----oligo+BC----[AGAA]
   ATGG                   CAGA                   TCAA                   ACTT                  AGAA 
```

**Set fidelity:** 1.0000 (5 overhangs)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------ | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)      | --      | --    | --    |
| 2   | 3'WT block        | bsmbi_3wt_tile22_sub1    | 516 nt  | AACT  | TTTC  |
| 3   | 3'WT block        | bsmbi_3wt_tile1_sub4     | 1656 nt | TTTC  | TATT  |
| 4   | 3'WT+PolIII block | bsmbi_3wt_tile1_sub5     | 1331 nt | TATT  | CACC  |
| 5   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1 | --      | --    | --    |

```
  [AACT]----3'WT sub1----[TTTC]----3'WT sub2----[TATT]----3'WT+PolIII sub3----[CACC]
   AACT                   TTTC                   TATT                          CACC 
```

**Set fidelity:** 1.0000 (4 overhangs)

---

### Tile 23 of 35 -- Codons 1114-1172 (177 nt)

**Boundary overhangs:**

| Position          | Sequence | Fidelity |
| ----------------- | -------- | -------- |
| oh1 (5' boundary) | GAAT     | 0.7246   |
| oh2 (3' boundary) | GAGT     | 0.6209   |

**Variants:** 11550 mutations, 11550 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name              | Length  | 5' OH | 3' OH |
| --- | --------------- | ---------------------- | ------- | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile13        | 1794 nt | ATGG  | CAGA  |
| 2   | 5'WT gene block | bsai_5wt_tile19_sub2   | 909 nt  | CAGA  | TCAA  |
| 3   | 5'WT gene block | bsai_5wt_tile23_sub3   | 690 nt  | TCAA  | GAAT  |
| 4   | Oligo pool      | Tile 23 (11550 oligos) | 233 nt  | GAAT  | AGAA  |
| 5   | Helper plasmid  | helper_plasmid_insert  | --      | --    | --    |
| 6   | Enzyme + buffer | BsaI-HFv2 + CutSmart   | --      | --    | --    |

```
  [ATGG]----5'WT sub1----[CAGA]----5'WT sub2----[TCAA]----5'WT sub3----[GAAT]----oligo+BC----[AGAA]
   ATGG                   CAGA                   TCAA                   GAAT                  AGAA 
```

**Set fidelity:** 1.0000 (5 overhangs)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------ | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)      | --      | --    | --    |
| 2   | 3'WT block        | bsmbi_3wt_tile23_sub1    | 351 nt  | GAGT  | TTTC  |
| 3   | 3'WT block        | bsmbi_3wt_tile1_sub4     | 1656 nt | TTTC  | TATT  |
| 4   | 3'WT+PolIII block | bsmbi_3wt_tile1_sub5     | 1331 nt | TATT  | CACC  |
| 5   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1 | --      | --    | --    |

```
  [GAGT]----3'WT sub1----[TTTC]----3'WT sub2----[TATT]----3'WT+PolIII sub3----[CACC]
   GAGT                   TTTC                   TATT                          CACC 
```

**Set fidelity:** 1.0000 (4 overhangs)

---

### Tile 24 of 35 -- Codons 1169-1239 (213 nt)

**Boundary overhangs:**

| Position          | Sequence | Fidelity |
| ----------------- | -------- | -------- |
| oh1 (5' boundary) | TCTC     | 0.8105   |
| oh2 (3' boundary) | GCCT     | 0.5289   |

**Variants:** 14070 mutations, 14070 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name              | Length  | 5' OH | 3' OH |
| --- | --------------- | ---------------------- | ------- | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile13        | 1794 nt | ATGG  | CAGA  |
| 2   | 5'WT gene block | bsai_5wt_tile19_sub2   | 909 nt  | CAGA  | TCAA  |
| 3   | 5'WT gene block | bsai_5wt_tile24_sub3   | 855 nt  | TCAA  | TCTC  |
| 4   | Oligo pool      | Tile 24 (14070 oligos) | 269 nt  | TCTC  | AGAA  |
| 5   | Helper plasmid  | helper_plasmid_insert  | --      | --    | --    |
| 6   | Enzyme + buffer | BsaI-HFv2 + CutSmart   | --      | --    | --    |

```
  [ATGG]----5'WT sub1----[CAGA]----5'WT sub2----[TCAA]----5'WT sub3----[TCTC]----oligo+BC----[AGAA]
   ATGG                   CAGA                   TCAA                   TCTC                  AGAA 
```

**Set fidelity:** 1.0000 (5 overhangs)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------ | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)      | --      | --    | --    |
| 2   | 3'WT block        | bsmbi_3wt_tile24_sub1    | 1788 nt | GCCT  | TATT  |
| 3   | 3'WT+PolIII block | bsmbi_3wt_tile1_sub5     | 1331 nt | TATT  | CACC  |
| 4   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1 | --      | --    | --    |

```
  [GCCT]----3'WT sub1----[TATT]----3'WT+PolIII sub2----[CACC]
   GCCT                   TATT                          CACC 
```

**Set fidelity:** 1.0000 (3 overhangs)

---

### Tile 25 of 35 -- Codons 1236-1279 (132 nt)

**Boundary overhangs:**

| Position          | Sequence | Fidelity |
| ----------------- | -------- | -------- |
| oh1 (5' boundary) | CAAA     | 0.8948   |
| oh2 (3' boundary) | TTTC     | 0.8348   |

**Variants:** 8400 mutations, 8400 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name             | Length  | 5' OH | 3' OH |
| --- | --------------- | --------------------- | ------- | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile13       | 1794 nt | ATGG  | CAGA  |
| 2   | 5'WT gene block | bsai_5wt_tile19_sub2  | 909 nt  | CAGA  | TCAA  |
| 3   | 5'WT gene block | bsai_5wt_tile25_sub3  | 1056 nt | TCAA  | CAAA  |
| 4   | Oligo pool      | Tile 25 (8400 oligos) | 188 nt  | CAAA  | AGAA  |
| 5   | Helper plasmid  | helper_plasmid_insert | --      | --    | --    |
| 6   | Enzyme + buffer | BsaI-HFv2 + CutSmart  | --      | --    | --    |

```
  [ATGG]----5'WT sub1----[CAGA]----5'WT sub2----[TCAA]----5'WT sub3----[CAAA]----oligo+BC----[AGAA]
   ATGG                   CAGA                   TCAA                   CAAA                  AGAA 
```

**Set fidelity:** 0.9718 (5 overhangs)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------ | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)      | --      | --    | --    |
| 2   | 3'WT block        | bsmbi_3wt_tile25_sub1    | 1668 nt | TTTC  | TATT  |
| 3   | 3'WT+PolIII block | bsmbi_3wt_tile1_sub5     | 1331 nt | TATT  | CACC  |
| 4   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1 | --      | --    | --    |

```
  [TTTC]----3'WT sub1----[TATT]----3'WT+PolIII sub2----[CACC]
   TTTC                   TATT                          CACC 
```

**Set fidelity:** 1.0000 (3 overhangs)

---

### Tile 26 of 35 -- Codons 1280-1353 (222 nt)

**Boundary overhangs:**

| Position          | Sequence | Fidelity |
| ----------------- | -------- | -------- |
| oh1 (5' boundary) | TGTA     | 0.7693   |
| oh2 (3' boundary) | AGGT     | 0.6250   |

**Variants:** 14700 mutations, 14700 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name              | Length  | 5' OH | 3' OH |
| --- | --------------- | ---------------------- | ------- | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile13        | 1794 nt | ATGG  | CAGA  |
| 2   | 5'WT gene block | bsai_5wt_tile19_sub2   | 909 nt  | CAGA  | TCAA  |
| 3   | 5'WT gene block | bsai_5wt_tile26_sub3   | 1188 nt | TCAA  | TGTA  |
| 4   | Oligo pool      | Tile 26 (14700 oligos) | 278 nt  | TGTA  | AGAA  |
| 5   | Helper plasmid  | helper_plasmid_insert  | --      | --    | --    |
| 6   | Enzyme + buffer | BsaI-HFv2 + CutSmart   | --      | --    | --    |

```
  [ATGG]----5'WT sub1----[CAGA]----5'WT sub2----[TCAA]----5'WT sub3----[TGTA]----oligo+BC----[AGAA]
   ATGG                   CAGA                   TCAA                   TGTA                  AGAA 
```

**Set fidelity:** 1.0000 (5 overhangs)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------ | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)      | --      | --    | --    |
| 2   | 3'WT block        | bsmbi_3wt_tile26_sub1    | 1446 nt | AGGT  | TATT  |
| 3   | 3'WT+PolIII block | bsmbi_3wt_tile1_sub5     | 1331 nt | TATT  | CACC  |
| 4   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1 | --      | --    | --    |

```
  [AGGT]----3'WT sub1----[TATT]----3'WT+PolIII sub2----[CACC]
   AGGT                   TATT                          CACC 
```

**Set fidelity:** 1.0000 (3 overhangs)

---

### Tile 27 of 35 -- Codons 1350-1427 (234 nt)

**Boundary overhangs:**

| Position          | Sequence | Fidelity |
| ----------------- | -------- | -------- |
| oh1 (5' boundary) | ATTC     | 0.7084   |
| oh2 (3' boundary) | TGAA     | 0.8621   |

**Variants:** 15540 mutations, 15540 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name              | Length  | 5' OH | 3' OH |
| --- | --------------- | ---------------------- | ------- | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile13        | 1794 nt | ATGG  | CAGA  |
| 2   | 5'WT gene block | bsai_5wt_tile19_sub2   | 909 nt  | CAGA  | TCAA  |
| 3   | 5'WT gene block | bsai_5wt_tile27_sub3   | 1398 nt | TCAA  | ATTC  |
| 4   | Oligo pool      | Tile 27 (15540 oligos) | 290 nt  | ATTC  | AGAA  |
| 5   | Helper plasmid  | helper_plasmid_insert  | --      | --    | --    |
| 6   | Enzyme + buffer | BsaI-HFv2 + CutSmart   | --      | --    | --    |

```
  [ATGG]----5'WT sub1----[CAGA]----5'WT sub2----[TCAA]----5'WT sub3----[ATTC]----oligo+BC----[AGAA]
   ATGG                   CAGA                   TCAA                   ATTC                  AGAA 
```

**Set fidelity:** 1.0000 (5 overhangs)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------ | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)      | --      | --    | --    |
| 2   | 3'WT block        | bsmbi_3wt_tile27_sub1    | 1224 nt | TGAA  | TATT  |
| 3   | 3'WT+PolIII block | bsmbi_3wt_tile1_sub5     | 1331 nt | TATT  | CACC  |
| 4   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1 | --      | --    | --    |

```
  [TGAA]----3'WT sub1----[TATT]----3'WT+PolIII sub2----[CACC]
   TGAA                   TATT                          CACC 
```

**Set fidelity:** 1.0000 (3 overhangs)

---

### Tile 28 of 35 -- Codons 1424-1470 (141 nt)

**Boundary overhangs:**

| Position          | Sequence | Fidelity |
| ----------------- | -------- | -------- |
| oh1 (5' boundary) | AAGA     | 0.9209   |
| oh2 (3' boundary) | GACA     | 0.6127   |

**Variants:** 9030 mutations, 9030 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name             | Length  | 5' OH | 3' OH |
| --- | --------------- | --------------------- | ------- | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile13       | 1794 nt | ATGG  | CAGA  |
| 2   | 5'WT gene block | bsai_5wt_tile19_sub2  | 909 nt  | CAGA  | TCAA  |
| 3   | 5'WT gene block | bsai_5wt_tile26_sub3  | 1188 nt | TCAA  | TGTA  |
| 4   | 5'WT gene block | bsai_5wt_tile28_sub4  | 450 nt  | TGTA  | AAGA  |
| 5   | Oligo pool      | Tile 28 (9030 oligos) | 197 nt  | AAGA  | AGAA  |
| 6   | Helper plasmid  | helper_plasmid_insert | --      | --    | --    |
| 7   | Enzyme + buffer | BsaI-HFv2 + CutSmart  | --      | --    | --    |

```
  [ATGG]----5'WT sub1----[CAGA]----5'WT sub2----[TCAA]----5'WT sub3----[TGTA]----5'WT sub4----[AAGA]----oligo+BC----[AGAA]
   ATGG                   CAGA                   TCAA                   TGTA                   AAGA                  AGAA 
```

**Set fidelity:** 0.9926 (6 overhangs)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------ | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)      | --      | --    | --    |
| 2   | 3'WT block        | bsmbi_3wt_tile28_sub1    | 1095 nt | GACA  | TATT  |
| 3   | 3'WT+PolIII block | bsmbi_3wt_tile1_sub5     | 1331 nt | TATT  | CACC  |
| 4   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1 | --      | --    | --    |

```
  [GACA]----3'WT sub1----[TATT]----3'WT+PolIII sub2----[CACC]
   GACA                   TATT                          CACC 
```

**Set fidelity:** 1.0000 (3 overhangs)

---

### Tile 29 of 35 -- Codons 1467-1533 (201 nt)

**Boundary overhangs:**

| Position          | Sequence | Fidelity |
| ----------------- | -------- | -------- |
| oh1 (5' boundary) | AAAG     | 0.7511   |
| oh2 (3' boundary) | TGTT     | 0.6450   |

**Variants:** 13230 mutations, 13230 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name              | Length  | 5' OH | 3' OH |
| --- | --------------- | ---------------------- | ------- | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile13        | 1794 nt | ATGG  | CAGA  |
| 2   | 5'WT gene block | bsai_5wt_tile19_sub2   | 909 nt  | CAGA  | TCAA  |
| 3   | 5'WT gene block | bsai_5wt_tile26_sub3   | 1188 nt | TCAA  | TGTA  |
| 4   | 5'WT gene block | bsai_5wt_tile29_sub4   | 579 nt  | TGTA  | AAAG  |
| 5   | Oligo pool      | Tile 29 (13230 oligos) | 257 nt  | AAAG  | AGAA  |
| 6   | Helper plasmid  | helper_plasmid_insert  | --      | --    | --    |
| 7   | Enzyme + buffer | BsaI-HFv2 + CutSmart   | --      | --    | --    |

```
  [ATGG]----5'WT sub1----[CAGA]----5'WT sub2----[TCAA]----5'WT sub3----[TGTA]----5'WT sub4----[AAAG]----oligo+BC----[AGAA]
   ATGG                   CAGA                   TCAA                   TGTA                   AAAG                  AGAA 
```

**Set fidelity:** 1.0000 (6 overhangs)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------ | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)      | --      | --    | --    |
| 2   | 3'WT block        | bsmbi_3wt_tile29_sub1    | 906 nt  | TGTT  | TATT  |
| 3   | 3'WT+PolIII block | bsmbi_3wt_tile1_sub5     | 1331 nt | TATT  | CACC  |
| 4   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1 | --      | --    | --    |

```
  [TGTT]----3'WT sub1----[TATT]----3'WT+PolIII sub2----[CACC]
   TGTT                   TATT                          CACC 
```

**Set fidelity:** 0.9770 (3 overhangs)

---

### Tile 30 of 35 -- Codons 1530-1603 (222 nt)

**Boundary overhangs:**

| Position          | Sequence | Fidelity |
| ----------------- | -------- | -------- |
| oh1 (5' boundary) | TATG     | 0.7006   |
| oh2 (3' boundary) | TTTC     | 0.8348   |

**Variants:** 14700 mutations, 14700 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name              | Length  | 5' OH | 3' OH |
| --- | --------------- | ---------------------- | ------- | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile13        | 1794 nt | ATGG  | CAGA  |
| 2   | 5'WT gene block | bsai_5wt_tile19_sub2   | 909 nt  | CAGA  | TCAA  |
| 3   | 5'WT gene block | bsai_5wt_tile26_sub3   | 1188 nt | TCAA  | TGTA  |
| 4   | 5'WT gene block | bsai_5wt_tile30_sub4   | 768 nt  | TGTA  | TATG  |
| 5   | Oligo pool      | Tile 30 (14700 oligos) | 278 nt  | TATG  | AGAA  |
| 6   | Helper plasmid  | helper_plasmid_insert  | --      | --    | --    |
| 7   | Enzyme + buffer | BsaI-HFv2 + CutSmart   | --      | --    | --    |

```
  [ATGG]----5'WT sub1----[CAGA]----5'WT sub2----[TCAA]----5'WT sub3----[TGTA]----5'WT sub4----[TATG]----oligo+BC----[AGAA]
   ATGG                   CAGA                   TCAA                   TGTA                   TATG                  AGAA 
```

**Set fidelity:** 1.0000 (6 overhangs)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------ | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)      | --      | --    | --    |
| 2   | 3'WT block        | bsmbi_3wt_tile30_sub1    | 696 nt  | TTTC  | TATT  |
| 3   | 3'WT+PolIII block | bsmbi_3wt_tile1_sub5     | 1331 nt | TATT  | CACC  |
| 4   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1 | --      | --    | --    |

```
  [TTTC]----3'WT sub1----[TATT]----3'WT+PolIII sub2----[CACC]
   TTTC                   TATT                          CACC 
```

**Set fidelity:** 1.0000 (3 overhangs)

---

### Tile 31 of 35 -- Codons 1600-1657 (174 nt)

**Boundary overhangs:**

| Position          | Sequence | Fidelity |
| ----------------- | -------- | -------- |
| oh1 (5' boundary) | GGAA     | 0.7463   |
| oh2 (3' boundary) | AAAA     | 0.9502   |

**Variants:** 11340 mutations, 11340 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name              | Length  | 5' OH | 3' OH |
| --- | --------------- | ---------------------- | ------- | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile13        | 1794 nt | ATGG  | CAGA  |
| 2   | 5'WT gene block | bsai_5wt_tile19_sub2   | 909 nt  | CAGA  | TCAA  |
| 3   | 5'WT gene block | bsai_5wt_tile26_sub3   | 1188 nt | TCAA  | TGTA  |
| 4   | 5'WT gene block | bsai_5wt_tile31_sub4   | 978 nt  | TGTA  | GGAA  |
| 5   | Oligo pool      | Tile 31 (11340 oligos) | 230 nt  | GGAA  | AGAA  |
| 6   | Helper plasmid  | helper_plasmid_insert  | --      | --    | --    |
| 7   | Enzyme + buffer | BsaI-HFv2 + CutSmart   | --      | --    | --    |

```
  [ATGG]----5'WT sub1----[CAGA]----5'WT sub2----[TCAA]----5'WT sub3----[TGTA]----5'WT sub4----[GGAA]----oligo+BC----[AGAA]
   ATGG                   CAGA                   TCAA                   TGTA                   GGAA                  AGAA 
```

**Set fidelity:** 0.9472 (6 overhangs)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------ | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)      | --      | --    | --    |
| 2   | 3'WT block        | bsmbi_3wt_tile31_sub1    | 534 nt  | AAAA  | TATT  |
| 3   | 3'WT+PolIII block | bsmbi_3wt_tile1_sub5     | 1331 nt | TATT  | CACC  |
| 4   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1 | --      | --    | --    |

```
  [AAAA]----3'WT sub1----[TATT]----3'WT+PolIII sub2----[CACC]
   AAAA                   TATT                          CACC 
```

**Set fidelity:** 1.0000 (3 overhangs)

---

### Tile 32 of 35 -- Codons 1654-1714 (183 nt)

**Boundary overhangs:**

| Position          | Sequence | Fidelity |
| ----------------- | -------- | -------- |
| oh1 (5' boundary) | ATAG     | 0.7330   |
| oh2 (3' boundary) | GTCT     | 0.5601   |

**Variants:** 11970 mutations, 11970 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name              | Length  | 5' OH | 3' OH |
| --- | --------------- | ---------------------- | ------- | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile13        | 1794 nt | ATGG  | CAGA  |
| 2   | 5'WT gene block | bsai_5wt_tile19_sub2   | 909 nt  | CAGA  | TCAA  |
| 3   | 5'WT gene block | bsai_5wt_tile26_sub3   | 1188 nt | TCAA  | TGTA  |
| 4   | 5'WT gene block | bsai_5wt_tile32_sub4   | 1140 nt | TGTA  | ATAG  |
| 5   | Oligo pool      | Tile 32 (11970 oligos) | 239 nt  | ATAG  | AGAA  |
| 6   | Helper plasmid  | helper_plasmid_insert  | --      | --    | --    |
| 7   | Enzyme + buffer | BsaI-HFv2 + CutSmart   | --      | --    | --    |

```
  [ATGG]----5'WT sub1----[CAGA]----5'WT sub2----[TCAA]----5'WT sub3----[TGTA]----5'WT sub4----[ATAG]----oligo+BC----[AGAA]
   ATGG                   CAGA                   TCAA                   TGTA                   ATAG                  AGAA 
```

**Set fidelity:** 0.9376 (6 overhangs)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------ | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)      | --      | --    | --    |
| 2   | 3'WT block        | bsmbi_3wt_tile32_sub1    | 363 nt  | GTCT  | TATT  |
| 3   | 3'WT+PolIII block | bsmbi_3wt_tile1_sub5     | 1331 nt | TATT  | CACC  |
| 4   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1 | --      | --    | --    |

```
  [GTCT]----3'WT sub1----[TATT]----3'WT+PolIII sub2----[CACC]
   GTCT                   TATT                          CACC 
```

**Set fidelity:** 1.0000 (3 overhangs)

---

### Tile 33 of 35 -- Codons 1711-1783 (219 nt)

**Boundary overhangs:**

| Position          | Sequence | Fidelity |
| ----------------- | -------- | -------- |
| oh1 (5' boundary) | GAAG     | 0.6752   |
| oh2 (3' boundary) | TGAT     | 0.6933   |

**Variants:** 14490 mutations, 14490 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name              | Length  | 5' OH | 3' OH |
| --- | --------------- | ---------------------- | ------- | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile13        | 1794 nt | ATGG  | CAGA  |
| 2   | 5'WT gene block | bsai_5wt_tile19_sub2   | 909 nt  | CAGA  | TCAA  |
| 3   | 5'WT gene block | bsai_5wt_tile26_sub3   | 1188 nt | TCAA  | TGTA  |
| 4   | 5'WT gene block | bsai_5wt_tile33_sub4   | 1311 nt | TGTA  | GAAG  |
| 5   | Oligo pool      | Tile 33 (14490 oligos) | 275 nt  | GAAG  | AGAA  |
| 6   | Helper plasmid  | helper_plasmid_insert  | --      | --    | --    |
| 7   | Enzyme + buffer | BsaI-HFv2 + CutSmart   | --      | --    | --    |

```
  [ATGG]----5'WT sub1----[CAGA]----5'WT sub2----[TCAA]----5'WT sub3----[TGTA]----5'WT sub4----[GAAG]----oligo+BC----[AGAA]
   ATGG                   CAGA                   TCAA                   TGTA                   GAAG                  AGAA 
```

**Set fidelity:** 1.0000 (6 overhangs)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------ | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)      | --      | --    | --    |
| 2   | 3'WT+PolIII block | bsmbi_3wt_tile33_sub1    | 1469 nt | TGAT  | CACC  |
| 3   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1 | --      | --    | --    |

```
  [TGAT]----3'WT+PolIII----[CACC]
   TGAT                     CACC 
```

**Set fidelity:** 1.0000 (2 overhangs)

---

### Tile 34 of 35 -- Codons 1780-1825 (138 nt)

**Boundary overhangs:**

| Position          | Sequence | Fidelity |
| ----------------- | -------- | -------- |
| oh1 (5' boundary) | TCCT     | 0.7573   |
| oh2 (3' boundary) | TATT     | 0.8134   |

**Variants:** 8820 mutations, 8820 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name             | Length  | 5' OH | 3' OH |
| --- | --------------- | --------------------- | ------- | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile13       | 1794 nt | ATGG  | CAGA  |
| 2   | 5'WT gene block | bsai_5wt_tile19_sub2  | 909 nt  | CAGA  | TCAA  |
| 3   | 5'WT gene block | bsai_5wt_tile26_sub3  | 1188 nt | TCAA  | TGTA  |
| 4   | 5'WT gene block | bsai_5wt_tile34_sub4  | 1518 nt | TGTA  | TCCT  |
| 5   | Oligo pool      | Tile 34 (8820 oligos) | 194 nt  | TCCT  | AGAA  |
| 6   | Helper plasmid  | helper_plasmid_insert | --      | --    | --    |
| 7   | Enzyme + buffer | BsaI-HFv2 + CutSmart  | --      | --    | --    |

```
  [ATGG]----5'WT sub1----[CAGA]----5'WT sub2----[TCAA]----5'WT sub3----[TGTA]----5'WT sub4----[TCCT]----oligo+BC----[AGAA]
   ATGG                   CAGA                   TCAA                   TGTA                   TCCT                  AGAA 
```

**Set fidelity:** 1.0000 (6 overhangs)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------ | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)      | --      | --    | --    |
| 2   | 3'WT+PolIII block | bsmbi_3wt_tile34_sub1    | 1343 nt | TATT  | CACC  |
| 3   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1 | --      | --    | --    |

```
  [TATT]----3'WT+PolIII----[CACC]
   TATT                     CACC 
```

**Set fidelity:** 1.0000 (2 overhangs)

---

### Tile 35 of 35 -- Codons 1826-1902 (231 nt)

**Boundary overhangs:**

| Position          | Sequence | Fidelity |
| ----------------- | -------- | -------- |
| oh1 (5' boundary) | CTAA     | 0.8691   |
| oh2 (3' boundary) | ATAG     | 0.7330   |

**Variants:** 15330 mutations, 15330 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name              | Length  | 5' OH | 3' OH |
| --- | --------------- | ---------------------- | ------- | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile13        | 1794 nt | ATGG  | CAGA  |
| 2   | 5'WT gene block | bsai_5wt_tile19_sub2   | 909 nt  | CAGA  | TCAA  |
| 3   | 5'WT gene block | bsai_5wt_tile26_sub3   | 1188 nt | TCAA  | TGTA  |
| 4   | 5'WT gene block | bsai_5wt_tile35_sub4   | 1656 nt | TGTA  | CTAA  |
| 5   | Oligo pool      | Tile 35 (15330 oligos) | 287 nt  | CTAA  | AGAA  |
| 6   | Helper plasmid  | helper_plasmid_insert  | --      | --    | --    |
| 7   | Enzyme + buffer | BsaI-HFv2 + CutSmart   | --      | --    | --    |

```
  [ATGG]----5'WT sub1----[CAGA]----5'WT sub2----[TCAA]----5'WT sub3----[TGTA]----5'WT sub4----[CTAA]----oligo+BC----[AGAA]
   ATGG                   CAGA                   TCAA                   TGTA                   CTAA                  AGAA 
```

**Set fidelity:** 1.0000 (6 overhangs)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component            | Part name                | Length  | 5' OH | 3' OH |
| --- | -------------------- | ------------------------ | ------- | ----- | ----- |
| 1   | BsaI product         | (in helper plasmid)      | --      | --    | --    |
| 2   | PolIII-only fragment | bsmbi_polIII_tile35      | 1112 nt | ATAG  | CACC  |
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

**Total blocks:** 73

| Block name            | Length (nt) | Enzyme type | Gene region                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                            |
| --------------------- | ----------- | ----------- | ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------ |
| bsai_5wt_tile10       | 1353        | BsaI        | 5wt_tile10                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                             |
| bsai_5wt_tile11       | 1479        | BsaI        | 5wt_tile11                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                             |
| bsai_5wt_tile12       | 1593        | BsaI        | 5wt_tile12                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                             |
| bsai_5wt_tile13       | 1794        | BsaI        | 5wt_tile13;5wt_tile14_sub1;5wt_tile15_sub1;5wt_tile16_sub1;5wt_tile17_sub1;5wt_tile18_sub1;5wt_tile19_sub1;5wt_tile20_sub1;5wt_tile21_sub1;5wt_tile22_sub1;5wt_tile23_sub1;5wt_tile24_sub1;5wt_tile25_sub1;5wt_tile26_sub1;5wt_tile27_sub1;5wt_tile28_sub1;5wt_tile29_sub1;5wt_tile30_sub1;5wt_tile31_sub1;5wt_tile32_sub1;5wt_tile33_sub1;5wt_tile34_sub1;5wt_tile35_sub1                                                                                                                                                                                                                                                                                                                                                                             |
| bsai_5wt_tile14_sub2  | 144         | BsaI        | 5wt_tile14_sub2                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                        |
| bsai_5wt_tile15_sub2  | 330         | BsaI        | 5wt_tile15_sub2                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                        |
| bsai_5wt_tile16_sub2  | 516         | BsaI        | 5wt_tile16_sub2                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                        |
| bsai_5wt_tile17_sub2  | 618         | BsaI        | 5wt_tile17_sub2                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                        |
| bsai_5wt_tile18_sub2  | 825         | BsaI        | 5wt_tile18_sub2                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                        |
| bsai_5wt_tile19_sub2  | 909         | BsaI        | 5wt_tile19_sub2;5wt_tile21_sub2;5wt_tile22_sub2;5wt_tile23_sub2;5wt_tile24_sub2;5wt_tile25_sub2;5wt_tile26_sub2;5wt_tile27_sub2;5wt_tile28_sub2;5wt_tile29_sub2;5wt_tile30_sub2;5wt_tile31_sub2;5wt_tile32_sub2;5wt_tile33_sub2;5wt_tile34_sub2;5wt_tile35_sub2                                                                                                                                                                                                                                                                                                                                                                                                                                                                                        |
| bsai_5wt_tile2        | 108         | BsaI        | 5wt_tile2                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                              |
| bsai_5wt_tile20_sub2  | 1080        | BsaI        | 5wt_tile20_sub2                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                        |
| bsai_5wt_tile21_sub3  | 387         | BsaI        | 5wt_tile21_sub3                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                        |
| bsai_5wt_tile22_sub3  | 561         | BsaI        | 5wt_tile22_sub3                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                        |
| bsai_5wt_tile23_sub3  | 690         | BsaI        | 5wt_tile23_sub3                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                        |
| bsai_5wt_tile24_sub3  | 855         | BsaI        | 5wt_tile24_sub3                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                        |
| bsai_5wt_tile25_sub3  | 1056        | BsaI        | 5wt_tile25_sub3                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                        |
| bsai_5wt_tile26_sub3  | 1188        | BsaI        | 5wt_tile26_sub3;5wt_tile28_sub3;5wt_tile29_sub3;5wt_tile30_sub3;5wt_tile31_sub3;5wt_tile32_sub3;5wt_tile33_sub3;5wt_tile34_sub3;5wt_tile35_sub3                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                        |
| bsai_5wt_tile27_sub3  | 1398        | BsaI        | 5wt_tile27_sub3                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                        |
| bsai_5wt_tile28_sub4  | 450         | BsaI        | 5wt_tile28_sub4                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                        |
| bsai_5wt_tile29_sub4  | 579         | BsaI        | 5wt_tile29_sub4                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                        |
| bsai_5wt_tile3        | 264         | BsaI        | 5wt_tile3                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                              |
| bsai_5wt_tile30_sub4  | 768         | BsaI        | 5wt_tile30_sub4                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                        |
| bsai_5wt_tile31_sub4  | 978         | BsaI        | 5wt_tile31_sub4                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                        |
| bsai_5wt_tile32_sub4  | 1140        | BsaI        | 5wt_tile32_sub4                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                        |
| bsai_5wt_tile33_sub4  | 1311        | BsaI        | 5wt_tile33_sub4                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                        |
| bsai_5wt_tile34_sub4  | 1518        | BsaI        | 5wt_tile34_sub4                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                        |
| bsai_5wt_tile35_sub4  | 1656        | BsaI        | 5wt_tile35_sub4                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                        |
| bsai_5wt_tile4        | 438         | BsaI        | 5wt_tile4                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                              |
| bsai_5wt_tile5        | 636         | BsaI        | 5wt_tile5                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                              |
| bsai_5wt_tile6        | 717         | BsaI        | 5wt_tile6                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                              |
| bsai_5wt_tile7        | 870         | BsaI        | 5wt_tile7                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                              |
| bsai_5wt_tile8        | 1005        | BsaI        | 5wt_tile8                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                              |
| bsai_5wt_tile9        | 1191        | BsaI        | 5wt_tile9                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                              |
| bsmbi_3wt_tile1_sub1  | 1704        | BsmBI       | 3wt_tile1_sub1                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                         |
| bsmbi_3wt_tile1_sub2  | 909         | BsmBI       | 3wt_tile1_sub2;3wt_tile2_sub2;3wt_tile3_sub2;3wt_tile4_sub2;3wt_tile5_sub2;3wt_tile6_sub2;3wt_tile7_sub2;3wt_tile8_sub2;3wt_tile9_sub2;3wt_tile10_sub2                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                 |
| bsmbi_3wt_tile1_sub3  | 1188        | BsmBI       | 3wt_tile1_sub3;3wt_tile2_sub3;3wt_tile3_sub3;3wt_tile4_sub3;3wt_tile5_sub3;3wt_tile6_sub3;3wt_tile7_sub3;3wt_tile8_sub3;3wt_tile9_sub3;3wt_tile10_sub3;3wt_tile11_sub2;3wt_tile12_sub2;3wt_tile13_sub2;3wt_tile14_sub2;3wt_tile15_sub2;3wt_tile16_sub2                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                 |
| bsmbi_3wt_tile1_sub4  | 1656        | BsmBI       | 3wt_tile1_sub4;3wt_tile2_sub4;3wt_tile3_sub4;3wt_tile4_sub4;3wt_tile5_sub4;3wt_tile6_sub4;3wt_tile7_sub4;3wt_tile8_sub4;3wt_tile9_sub4;3wt_tile10_sub4;3wt_tile11_sub3;3wt_tile12_sub3;3wt_tile13_sub3;3wt_tile14_sub3;3wt_tile15_sub3;3wt_tile16_sub3;3wt_tile17_sub2;3wt_tile18_sub2;3wt_tile19_sub2;3wt_tile20_sub2;3wt_tile21_sub2;3wt_tile22_sub2;3wt_tile23_sub2                                                                                                                                                                                                                                                                                                                                                                                 |
| bsmbi_3wt_tile1_sub5  | 1331        | BsmBI       | 3wt_polIII_tile1_sub5;3wt_polIII_tile2_sub5;3wt_polIII_tile3_sub5;3wt_polIII_tile4_sub5;3wt_polIII_tile5_sub5;3wt_polIII_tile6_sub5;3wt_polIII_tile7_sub5;3wt_polIII_tile8_sub5;3wt_polIII_tile9_sub5;3wt_polIII_tile10_sub5;3wt_polIII_tile11_sub4;3wt_polIII_tile12_sub4;3wt_polIII_tile13_sub4;3wt_polIII_tile14_sub4;3wt_polIII_tile15_sub4;3wt_polIII_tile16_sub4;3wt_polIII_tile17_sub3;3wt_polIII_tile18_sub3;3wt_polIII_tile19_sub3;3wt_polIII_tile20_sub3;3wt_polIII_tile21_sub3;3wt_polIII_tile22_sub3;3wt_polIII_tile23_sub3;3wt_polIII_tile24_sub2;3wt_polIII_tile25_sub2;3wt_polIII_tile26_sub2;3wt_polIII_tile27_sub2;3wt_polIII_tile28_sub2;3wt_polIII_tile29_sub2;3wt_polIII_tile30_sub2;3wt_polIII_tile31_sub2;3wt_polIII_tile32_sub2 |
| bsmbi_3wt_tile10_sub1 | 333         | BsmBI       | 3wt_tile10_sub1                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                        |
| bsmbi_3wt_tile11_sub1 | 1110        | BsmBI       | 3wt_tile11_sub1                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                        |
| bsmbi_3wt_tile12_sub1 | 921         | BsmBI       | 3wt_tile12_sub1                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                        |
| bsmbi_3wt_tile13_sub1 | 783         | BsmBI       | 3wt_tile13_sub1                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                        |
| bsmbi_3wt_tile14_sub1 | 597         | BsmBI       | 3wt_tile14_sub1                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                        |
| bsmbi_3wt_tile15_sub1 | 411         | BsmBI       | 3wt_tile15_sub1                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                        |
| bsmbi_3wt_tile16_sub1 | 309         | BsmBI       | 3wt_tile16_sub1                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                        |
| bsmbi_3wt_tile17_sub1 | 1272        | BsmBI       | 3wt_tile17_sub1                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                        |
| bsmbi_3wt_tile18_sub1 | 1200        | BsmBI       | 3wt_tile18_sub1                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                        |
| bsmbi_3wt_tile19_sub1 | 1017        | BsmBI       | 3wt_tile19_sub1                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                        |
| bsmbi_3wt_tile2_sub1  | 1548        | BsmBI       | 3wt_tile2_sub1                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                         |
| bsmbi_3wt_tile20_sub1 | 819         | BsmBI       | 3wt_tile20_sub1                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                        |
| bsmbi_3wt_tile21_sub1 | 645         | BsmBI       | 3wt_tile21_sub1                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                        |
| bsmbi_3wt_tile22_sub1 | 516         | BsmBI       | 3wt_tile22_sub1                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                        |
| bsmbi_3wt_tile23_sub1 | 351         | BsmBI       | 3wt_tile23_sub1                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                        |
| bsmbi_3wt_tile24_sub1 | 1788        | BsmBI       | 3wt_tile24_sub1                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                        |
| bsmbi_3wt_tile25_sub1 | 1668        | BsmBI       | 3wt_tile25_sub1                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                        |
| bsmbi_3wt_tile26_sub1 | 1446        | BsmBI       | 3wt_tile26_sub1                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                        |
| bsmbi_3wt_tile27_sub1 | 1224        | BsmBI       | 3wt_tile27_sub1                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                        |
| bsmbi_3wt_tile28_sub1 | 1095        | BsmBI       | 3wt_tile28_sub1                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                        |
| bsmbi_3wt_tile29_sub1 | 906         | BsmBI       | 3wt_tile29_sub1                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                        |
| bsmbi_3wt_tile3_sub1  | 1374        | BsmBI       | 3wt_tile3_sub1                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                         |
| bsmbi_3wt_tile30_sub1 | 696         | BsmBI       | 3wt_tile30_sub1                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                        |
| bsmbi_3wt_tile31_sub1 | 534         | BsmBI       | 3wt_tile31_sub1                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                        |
| bsmbi_3wt_tile32_sub1 | 363         | BsmBI       | 3wt_tile32_sub1                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                        |
| bsmbi_3wt_tile33_sub1 | 1469        | BsmBI       | 3wt_polIII_tile33_sub1                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                 |
| bsmbi_3wt_tile34_sub1 | 1343        | BsmBI       | 3wt_polIII_tile34_sub1                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                 |
| bsmbi_3wt_tile4_sub1  | 1176        | BsmBI       | 3wt_tile4_sub1                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                         |
| bsmbi_3wt_tile5_sub1  | 1095        | BsmBI       | 3wt_tile5_sub1                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                         |
| bsmbi_3wt_tile6_sub1  | 942         | BsmBI       | 3wt_tile6_sub1                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                         |
| bsmbi_3wt_tile7_sub1  | 807         | BsmBI       | 3wt_tile7_sub1                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                         |
| bsmbi_3wt_tile8_sub1  | 621         | BsmBI       | 3wt_tile8_sub1                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                         |
| bsmbi_3wt_tile9_sub1  | 459         | BsmBI       | 3wt_tile9_sub1                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                         |
| bsmbi_polIII_tile35   | 1112        | BsmBI       | polIII_tile35                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                          |

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

| Parameter             | Value          |
| --------------------- | -------------- |
| max_oligo_length      | 300            |
| max_geneblock_length  | 1800           |
| barcode_length        | 20             |
| min_hamming_distance  | 3              |
| barcode_prefix_length | 12             |
| barcodes_per_variant  | 10             |
| boundary_method       | oogga_two_pass |
| multi_k_search        | TRUE           |
| auto_domesticate      | TRUE           |

