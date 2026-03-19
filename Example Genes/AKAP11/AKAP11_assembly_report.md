# DMS-GG Assembly Report: AKAP11

Generated: 2026-03-19 12:07:32
Pipeline: dms-gg-oligo-pipeline (3-Enzyme Architecture: BsaI + BsmBI + PaqCI)

---

## 1. Gene Summary

| Property             | Value                                                                          |
| -------------------- | ------------------------------------------------------------------------------ |
| Gene name            | AKAP11_NM_016248.4_CDS Homo sapiens A-kinase anchoring protein 11 (AKAP11) CDS |
| CDS length           | 5706 nt (1902 codons)                                                          |
| Protein length       | 1901 aa                                                                        |
| Number of tiles      | 31                                                                             |
| Total variants       | 39711                                                                          |
| Total oligos         | 397110                                                                         |
| Oligo length range   | 191-296 nt                                                                     |
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

**Total oligos:** 397110 | **Length range:** 191-296 nt

| Tile | Codons    | Oligos | Length |
| ---- | --------- | ------ | ------ |
| 1    | 1-64      | 12600  | 252 nt |
| 2    | 59-132    | 14280  | 278 nt |
| 3    | 127-200   | 14280  | 278 nt |
| 4    | 195-263   | 13230  | 263 nt |
| 5    | 258-331   | 14280  | 278 nt |
| 6    | 326-398   | 14070  | 275 nt |
| 7    | 393-463   | 13650  | 269 nt |
| 8    | 458-531   | 14280  | 278 nt |
| 9    | 526-570   | 8400   | 191 nt |
| 10   | 571-635   | 12810  | 251 nt |
| 11   | 630-695   | 12600  | 254 nt |
| 12   | 690-764   | 14490  | 281 nt |
| 13   | 759-812   | 10080  | 218 nt |
| 14   | 807-876   | 13440  | 266 nt |
| 15   | 871-939   | 13230  | 263 nt |
| 16   | 934-983   | 9240   | 206 nt |
| 17   | 978-1053  | 14700  | 284 nt |
| 18   | 1048-1101 | 10080  | 218 nt |
| 19   | 1096-1142 | 8820   | 197 nt |
| 20   | 1143-1207 | 12810  | 251 nt |
| 21   | 1202-1256 | 10290  | 221 nt |
| 22   | 1251-1327 | 14910  | 287 nt |
| 23   | 1322-1379 | 10920  | 230 nt |
| 24   | 1374-1446 | 14070  | 275 nt |
| 25   | 1441-1511 | 13650  | 269 nt |
| 26   | 1506-1582 | 14910  | 287 nt |
| 27   | 1577-1644 | 13020  | 260 nt |
| 28   | 1639-1708 | 13650  | 266 nt |
| 29   | 1709-1778 | 13860  | 266 nt |
| 30   | 1773-1839 | 12810  | 257 nt |
| 31   | 1834-1913 | 13650  | 296 nt |

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
| Total barcodes    | 397110                             |
| Unique barcodes   | 397110                             |
| GC content range  | 35% - 65%                          |
| GC content mean   | 49%                                |
| Hamming guarantee | 100% cross-variant (prefix d >= 3) |

## 5. QC Summary

**Overall:** ISSUES FOUND

| Check                   | Description                                                   | Result | Detail                                                                                                                                              |
| ----------------------- | ------------------------------------------------------------- | ------ | --------------------------------------------------------------------------------------------------------------------------------------------------- |
| oligo_lengths           | All oligos within synthesis length limit                      | PASS   | Range: 191-296 nt (limit: 300)                                                                                                                      |
| block_lengths           | All gene blocks within synthesis length limit                 | PASS   | Range: 165-1764 nt (limit: 1800)                                                                                                                    |
| barcode_junction_sites  | No enzyme sites at barcode-context junctions                  | PASS   | 0 barcode(s) with junction enzyme sites (left='CACACC', right='AGAATG')                                                                             |
| barcode_uniqueness      | All barcodes are unique                                       | PASS   | 397110 unique / 397110 total                                                                                                                        |
| tile_coverage           | Tiles cover entire gene without gaps                          | PASS   | 5706 / 5706 nt covered                                                                                                                              |
| variant_count           | Expected number of variants generated                         | PASS   | 39711 unique variants (expected: 39711 across 1891/1900 mutable positions; 35929 missense + 1891 nonsense + 1891 wt_control; 9 position(s) skipped) |
| single_codon_change     | Each non-control variant differs by exactly one codon from WT | PASS   | 378200 / 378200 variants confirmed (WT controls excluded)                                                                                           |
| oligo_gc_content        | Oligo GC content within reasonable range (25-75%)             | PASS   | GC range: 32.5-52.6% | 0 oligo(s) with extreme GC                                                                                                   |
| domestication_complete  | Gene domesticated for all 3 enzymes (BsaI, BsmBI, PaqCI)      | PASS   | No enzyme sites in gene                                                                                                                             |
| overhang_fidelity       | Tile boundary overhangs have adequate fidelity                | FAIL   | 27 tile(s) with low-fidelity boundary overhangs (<0.80)                                                                                             |
| tile_manifests          | Per-tile assembly manifests complete                          | PASS   | 31 tile manifest(s) generated                                                                                                                       |
| helper_plasmid          | Helper plasmid free of unintended BsmBI sites                 | PASS   | OK                                                                                                                                                  |
| reaction_fidelity       | Per-reaction set-level overhang fidelity                      | PASS   | Min set fidelity: 0.8676 across 62 reactions | 1 reaction(s) below 0.90                                                                             |
| barcode_poliii_term     | No barcodes contain PolIII terminator signal (TTTT)           | PASS   | 0 / 397110 barcode(s) contain TTTT                                                                                                                  |
| barcode_hairpins        | No barcodes have hairpin stems > 3 bp                         | PASS   | 0 / 397110 barcode(s) have hairpin stems > 3 bp                                                                                                     |
| barcode_dinuc_repeats   | No barcodes have dinucleotide repeats > 4 units               | PASS   | 0 / 397110 barcode(s) exceed 4 dinuc repeat units                                                                                                   |
| barcode_tm_distribution | Barcode Tm distribution (informational)                       | PASS   | Tm: median=53.5, range=[41.7, 65.6], sd=4 C                                                                                                         |
| block_min_length        | All gene blocks above synthesis minimum length                | FAIL   | 7 block(s) below 300 nt minimum. Range: 165-1764 nt                                                                                                 |
| sb_overhang_collisions  | Superblock boundary overhangs are unique (no collisions)      | PASS   | 6 SB boundary OH(s), all unique                                                                                                                     |

## 5b. Reaction Fidelity Summary

Set fidelity for each tile's BsaI and BsmBI reactions,
computed from the actual block overhangs after construction:

| Tile | BsaI OHs | BsaI Set Fidelity | BsmBI OHs | BsmBI Set Fidelity |
| ---- | -------- | ----------------- | --------- | ------------------ |
| 1    | 2        | 0.9406            | 5         | 0.9906             |
| 2    | 3        | 0.9406            | 5         | 0.9906             |
| 3    | 3        | 0.9406            | 5         | 0.9906             |
| 4    | 3        | 0.9406            | 5         | 0.9906             |
| 5    | 3        | 0.9406            | 5         | 0.9906             |
| 6    | 3        | 0.9406            | 5         | 0.9906             |
| 7    | 3        | 0.9406            | 5         | 0.9906             |
| 8    | 3        | 0.9406            | 5         | 0.9906             |
| 9    | 3        | 0.9406            | 4         | 0.8676             |
| 10   | 3        | 0.9406            | 4         | 1.0000             |
| 11   | 4        | 0.9406            | 4         | 1.0000             |
| 12   | 4        | 0.9406            | 4         | 1.0000             |
| 13   | 4        | 0.9392            | 4         | 1.0000             |
| 14   | 4        | 0.9406            | 4         | 1.0000             |
| 15   | 4        | 0.9406            | 4         | 1.0000             |
| 16   | 4        | 0.9406            | 4         | 1.0000             |
| 17   | 4        | 0.9406            | 4         | 1.0000             |
| 18   | 4        | 0.9406            | 4         | 1.0000             |
| 19   | 4        | 0.9406            | 3         | 1.0000             |
| 20   | 4        | 0.9406            | 3         | 1.0000             |
| 21   | 5        | 0.9406            | 3         | 1.0000             |
| 22   | 5        | 0.9406            | 3         | 1.0000             |
| 23   | 5        | 0.9406            | 3         | 1.0000             |
| 24   | 5        | 0.9406            | 3         | 1.0000             |
| 25   | 5        | 0.9406            | 3         | 1.0000             |
| 26   | 5        | 0.9392            | 3         | 1.0000             |
| 27   | 5        | 0.9406            | 3         | 1.0000             |
| 28   | 5        | 0.9406            | 2         | 1.0000             |
| 29   | 5        | 0.9406            | 2         | 1.0000             |
| 30   | 6        | 0.9387            | 2         | 1.0000             |
| 31   | 6        | 0.9335            | 2         | 1.0000             |

**Min:** 0.8676 | **Max:** 1.0000 | **Mean:** 0.9668

**Warning:** 1 reaction(s) below 0.90 fidelity — consider alternative split points or overhang reassignment.
## 6. Fixed Overhangs & Helper Plasmid

These overhangs are the same across all tile reactions:

| Overhang    | Sequence | Role                                                    |
| ----------- | -------- | ------------------------------------------------------- |
| oh_L        | TGAA     | Gene start (BsaI, user-specified, upstream of ATG)      |
| oh3         | CACC     | Downstream cassette-barcode junction (BsmBI, all tiles) |
| oh4         | AGAA     | Barcode-helper junction (BsaI, all tiles)               |
| paqci_star2 | AATG     | PaqCI 5' end of insert (Level 2)                        |
| paqci_star1 | GCTA     | PaqCI 3' end of insert (Level 2)                        |

### Helper Plasmid Insert

The helper plasmid provides the backbone for each BsaI Level 1 reaction.

```
[PaqCI**]--[BsaI>>TGAA]--STUFFER--[AGAA<<BsaI]--[PaqCI*]
```

Insert length: 72 nt
oh_L = TGAA (user-specified, upstream of ATG)
oh_R = AGAA (= oh4, barcode-helper junction)
upstream_cassette = (none)

## 7. Per-Tile Assembly Guide

### Tile 1 of 31 -- Codons 1-64 (192 nt)

**Boundary overhangs:**

| Position          | Sequence | Fidelity |
| ----------------- | -------- | -------- |
| oh1 (5' boundary) | TGAA     | 0.8621   |
| oh2 (3' boundary) | TGAA     | 0.8621   |

**Variants:** 12600 mutations, 12600 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name                          | Length | 5' OH | 3' OH |
| --- | --------------- | ---------------------------------- | ------ | ----- | ----- |
| 1   | 5'WT gene block | (none -- tile starts at gene nt 1) | --     | --    | --    |
| 2   | Oligo pool      | Tile 1 (12600 oligos)              | 252 nt | TGAA  | AGAA  |
| 3   | Helper plasmid  | helper_plasmid_insert              | --     | --    | --    |
| 4   | Enzyme + buffer | BsaI-HFv2 + CutSmart               | --     | --    | --    |

```
  [TGAA]----oligo+BC----[AGAA]
   TGAA                  AGAA 
```

**Set fidelity:** 0.9406 (2 overhangs)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------ | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)      | --      | --    | --    |
| 2   | 3'WT block        | bsmbi_3wt_tile1_sub1     | 1566 nt | TGAA  | ATGT  |
| 3   | 3'WT block        | bsmbi_3wt_tile1_sub2     | 1746 nt | ATGT  | TAGT  |
| 4   | 3'WT block        | bsmbi_3wt_tile1_sub3     | 1728 nt | TAGT  | TCAG  |
| 5   | 3'WT+PolIII block | bsmbi_3wt_tile1_sub4     | 1688 nt | TCAG  | CACC  |
| 6   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1 | --      | --    | --    |

```
  [TGAA]----3'WT sub1----[ATGT]----3'WT sub2----[TAGT]----3'WT sub3----[TCAG]----3'WT+PolIII sub4----[CACC]
   TGAA                   ATGT                   TAGT                   TCAG                          CACC 
```

**Set fidelity:** 0.9906 (5 overhangs)

---

### Tile 2 of 31 -- Codons 59-132 (222 nt)

**Boundary overhangs:**

| Position          | Sequence | Fidelity |
| ----------------- | -------- | -------- |
| oh1 (5' boundary) | TTTC     | 0.8348   |
| oh2 (3' boundary) | TACA     | 0.8652   |

**Variants:** 14280 mutations, 14280 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name             | Length | 5' OH | 3' OH |
| --- | --------------- | --------------------- | ------ | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile2        | 208 nt | TGAA  | TTTC  |
| 2   | Oligo pool      | Tile 2 (14280 oligos) | 278 nt | TTTC  | AGAA  |
| 3   | Helper plasmid  | helper_plasmid_insert | --     | --    | --    |
| 4   | Enzyme + buffer | BsaI-HFv2 + CutSmart  | --     | --    | --    |

```
  [TGAA]----5'WT block----[TTTC]----oligo+BC----[AGAA]
   TGAA                    TTTC                  AGAA 
```

**Set fidelity:** 0.9406 (3 overhangs)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------ | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)      | --      | --    | --    |
| 2   | 3'WT block        | bsmbi_3wt_tile2_sub1     | 1362 nt | TACA  | ATGT  |
| 3   | 3'WT block        | bsmbi_3wt_tile1_sub2     | 1746 nt | ATGT  | TAGT  |
| 4   | 3'WT block        | bsmbi_3wt_tile1_sub3     | 1728 nt | TAGT  | TCAG  |
| 5   | 3'WT+PolIII block | bsmbi_3wt_tile1_sub4     | 1688 nt | TCAG  | CACC  |
| 6   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1 | --      | --    | --    |

```
  [TACA]----3'WT sub1----[ATGT]----3'WT sub2----[TAGT]----3'WT sub3----[TCAG]----3'WT+PolIII sub4----[CACC]
   TACA                   ATGT                   TAGT                   TCAG                          CACC 
```

**Set fidelity:** 0.9906 (5 overhangs)

---

### Tile 3 of 31 -- Codons 127-200 (222 nt)

**Boundary overhangs:**

| Position          | Sequence | Fidelity |
| ----------------- | -------- | -------- |
| oh1 (5' boundary) | ATGA     | 0.7549   |
| oh2 (3' boundary) | TTCA     | 0.8824   |

**Variants:** 14280 mutations, 14280 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name             | Length | 5' OH | 3' OH |
| --- | --------------- | --------------------- | ------ | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile3        | 412 nt | TGAA  | ATGA  |
| 2   | Oligo pool      | Tile 3 (14280 oligos) | 278 nt | ATGA  | AGAA  |
| 3   | Helper plasmid  | helper_plasmid_insert | --     | --    | --    |
| 4   | Enzyme + buffer | BsaI-HFv2 + CutSmart  | --     | --    | --    |

```
  [TGAA]----5'WT block----[ATGA]----oligo+BC----[AGAA]
   TGAA                    ATGA                  AGAA 
```

**Set fidelity:** 0.9406 (3 overhangs)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------ | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)      | --      | --    | --    |
| 2   | 3'WT block        | bsmbi_3wt_tile3_sub1     | 1158 nt | TTCA  | ATGT  |
| 3   | 3'WT block        | bsmbi_3wt_tile1_sub2     | 1746 nt | ATGT  | TAGT  |
| 4   | 3'WT block        | bsmbi_3wt_tile1_sub3     | 1728 nt | TAGT  | TCAG  |
| 5   | 3'WT+PolIII block | bsmbi_3wt_tile1_sub4     | 1688 nt | TCAG  | CACC  |
| 6   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1 | --      | --    | --    |

```
  [TTCA]----3'WT sub1----[ATGT]----3'WT sub2----[TAGT]----3'WT sub3----[TCAG]----3'WT+PolIII sub4----[CACC]
   TTCA                   ATGT                   TAGT                   TCAG                          CACC 
```

**Set fidelity:** 0.9906 (5 overhangs)

---

### Tile 4 of 31 -- Codons 195-263 (207 nt)

**Boundary overhangs:**

| Position          | Sequence | Fidelity |
| ----------------- | -------- | -------- |
| oh1 (5' boundary) | GAAG     | 0.6752   |
| oh2 (3' boundary) | TTCT     | 0.8181   |

**Variants:** 13230 mutations, 13230 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name             | Length | 5' OH | 3' OH |
| --- | --------------- | --------------------- | ------ | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile4        | 616 nt | TGAA  | GAAG  |
| 2   | Oligo pool      | Tile 4 (13230 oligos) | 263 nt | GAAG  | AGAA  |
| 3   | Helper plasmid  | helper_plasmid_insert | --     | --    | --    |
| 4   | Enzyme + buffer | BsaI-HFv2 + CutSmart  | --     | --    | --    |

```
  [TGAA]----5'WT block----[GAAG]----oligo+BC----[AGAA]
   TGAA                    GAAG                  AGAA 
```

**Set fidelity:** 0.9406 (3 overhangs)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------ | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)      | --      | --    | --    |
| 2   | 3'WT block        | bsmbi_3wt_tile4_sub1     | 969 nt  | TTCT  | ATGT  |
| 3   | 3'WT block        | bsmbi_3wt_tile1_sub2     | 1746 nt | ATGT  | TAGT  |
| 4   | 3'WT block        | bsmbi_3wt_tile1_sub3     | 1728 nt | TAGT  | TCAG  |
| 5   | 3'WT+PolIII block | bsmbi_3wt_tile1_sub4     | 1688 nt | TCAG  | CACC  |
| 6   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1 | --      | --    | --    |

```
  [TTCT]----3'WT sub1----[ATGT]----3'WT sub2----[TAGT]----3'WT sub3----[TCAG]----3'WT+PolIII sub4----[CACC]
   TTCT                   ATGT                   TAGT                   TCAG                          CACC 
```

**Set fidelity:** 0.9906 (5 overhangs)

---

### Tile 5 of 31 -- Codons 258-331 (222 nt)

**Boundary overhangs:**

| Position          | Sequence | Fidelity |
| ----------------- | -------- | -------- |
| oh1 (5' boundary) | CATA     | 0.7540   |
| oh2 (3' boundary) | AGCA     | 0.5690   |

**Variants:** 14280 mutations, 14280 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name             | Length | 5' OH | 3' OH |
| --- | --------------- | --------------------- | ------ | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile5        | 805 nt | TGAA  | CATA  |
| 2   | Oligo pool      | Tile 5 (14280 oligos) | 278 nt | CATA  | AGAA  |
| 3   | Helper plasmid  | helper_plasmid_insert | --     | --    | --    |
| 4   | Enzyme + buffer | BsaI-HFv2 + CutSmart  | --     | --    | --    |

```
  [TGAA]----5'WT block----[CATA]----oligo+BC----[AGAA]
   TGAA                    CATA                  AGAA 
```

**Set fidelity:** 0.9406 (3 overhangs)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------ | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)      | --      | --    | --    |
| 2   | 3'WT block        | bsmbi_3wt_tile5_sub1     | 765 nt  | AGCA  | ATGT  |
| 3   | 3'WT block        | bsmbi_3wt_tile1_sub2     | 1746 nt | ATGT  | TAGT  |
| 4   | 3'WT block        | bsmbi_3wt_tile1_sub3     | 1728 nt | TAGT  | TCAG  |
| 5   | 3'WT+PolIII block | bsmbi_3wt_tile1_sub4     | 1688 nt | TCAG  | CACC  |
| 6   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1 | --      | --    | --    |

```
  [AGCA]----3'WT sub1----[ATGT]----3'WT sub2----[TAGT]----3'WT sub3----[TCAG]----3'WT+PolIII sub4----[CACC]
   AGCA                   ATGT                   TAGT                   TCAG                          CACC 
```

**Set fidelity:** 0.9906 (5 overhangs)

---

### Tile 6 of 31 -- Codons 326-398 (219 nt)

**Boundary overhangs:**

| Position          | Sequence | Fidelity |
| ----------------- | -------- | -------- |
| oh1 (5' boundary) | CAAA     | 0.8948   |
| oh2 (3' boundary) | TCCT     | 0.7573   |

**Variants:** 14070 mutations, 14070 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name             | Length  | 5' OH | 3' OH |
| --- | --------------- | --------------------- | ------- | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile6        | 1009 nt | TGAA  | CAAA  |
| 2   | Oligo pool      | Tile 6 (14070 oligos) | 275 nt  | CAAA  | AGAA  |
| 3   | Helper plasmid  | helper_plasmid_insert | --      | --    | --    |
| 4   | Enzyme + buffer | BsaI-HFv2 + CutSmart  | --      | --    | --    |

```
  [TGAA]----5'WT block----[CAAA]----oligo+BC----[AGAA]
   TGAA                    CAAA                  AGAA 
```

**Set fidelity:** 0.9406 (3 overhangs)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------ | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)      | --      | --    | --    |
| 2   | 3'WT block        | bsmbi_3wt_tile6_sub1     | 564 nt  | TCCT  | ATGT  |
| 3   | 3'WT block        | bsmbi_3wt_tile1_sub2     | 1746 nt | ATGT  | TAGT  |
| 4   | 3'WT block        | bsmbi_3wt_tile1_sub3     | 1728 nt | TAGT  | TCAG  |
| 5   | 3'WT+PolIII block | bsmbi_3wt_tile1_sub4     | 1688 nt | TCAG  | CACC  |
| 6   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1 | --      | --    | --    |

```
  [TCCT]----3'WT sub1----[ATGT]----3'WT sub2----[TAGT]----3'WT sub3----[TCAG]----3'WT+PolIII sub4----[CACC]
   TCCT                   ATGT                   TAGT                   TCAG                          CACC 
```

**Set fidelity:** 0.9906 (5 overhangs)

---

### Tile 7 of 31 -- Codons 393-463 (213 nt)

**Boundary overhangs:**

| Position          | Sequence | Fidelity |
| ----------------- | -------- | -------- |
| oh1 (5' boundary) | AAGT     | 0.7629   |
| oh2 (3' boundary) | TCCA     | 0.8519   |

**Variants:** 13650 mutations, 13650 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name             | Length  | 5' OH | 3' OH |
| --- | --------------- | --------------------- | ------- | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile7        | 1210 nt | TGAA  | AAGT  |
| 2   | Oligo pool      | Tile 7 (13650 oligos) | 269 nt  | AAGT  | AGAA  |
| 3   | Helper plasmid  | helper_plasmid_insert | --      | --    | --    |
| 4   | Enzyme + buffer | BsaI-HFv2 + CutSmart  | --      | --    | --    |

```
  [TGAA]----5'WT block----[AAGT]----oligo+BC----[AGAA]
   TGAA                    AAGT                  AGAA 
```

**Set fidelity:** 0.9406 (3 overhangs)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------ | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)      | --      | --    | --    |
| 2   | 3'WT block        | bsmbi_3wt_tile7_sub1     | 369 nt  | TCCA  | ATGT  |
| 3   | 3'WT block        | bsmbi_3wt_tile1_sub2     | 1746 nt | ATGT  | TAGT  |
| 4   | 3'WT block        | bsmbi_3wt_tile1_sub3     | 1728 nt | TAGT  | TCAG  |
| 5   | 3'WT+PolIII block | bsmbi_3wt_tile1_sub4     | 1688 nt | TCAG  | CACC  |
| 6   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1 | --      | --    | --    |

```
  [TCCA]----3'WT sub1----[ATGT]----3'WT sub2----[TAGT]----3'WT sub3----[TCAG]----3'WT+PolIII sub4----[CACC]
   TCCA                   ATGT                   TAGT                   TCAG                          CACC 
```

**Set fidelity:** 0.9906 (5 overhangs)

---

### Tile 8 of 31 -- Codons 458-531 (222 nt)

**Boundary overhangs:**

| Position          | Sequence | Fidelity |
| ----------------- | -------- | -------- |
| oh1 (5' boundary) | CTTG     | 0.7594   |
| oh2 (3' boundary) | TGGA     | 0.7377   |

**Variants:** 14280 mutations, 14280 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name             | Length  | 5' OH | 3' OH |
| --- | --------------- | --------------------- | ------- | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile8        | 1405 nt | TGAA  | CTTG  |
| 2   | Oligo pool      | Tile 8 (14280 oligos) | 278 nt  | CTTG  | AGAA  |
| 3   | Helper plasmid  | helper_plasmid_insert | --      | --    | --    |
| 4   | Enzyme + buffer | BsaI-HFv2 + CutSmart  | --      | --    | --    |

```
  [TGAA]----5'WT block----[CTTG]----oligo+BC----[AGAA]
   TGAA                    CTTG                  AGAA 
```

**Set fidelity:** 0.9406 (3 overhangs)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------ | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)      | --      | --    | --    |
| 2   | 3'WT block        | bsmbi_3wt_tile8_sub1     | 165 nt  | TGGA  | ATGT  |
| 3   | 3'WT block        | bsmbi_3wt_tile1_sub2     | 1746 nt | ATGT  | TAGT  |
| 4   | 3'WT block        | bsmbi_3wt_tile1_sub3     | 1728 nt | TAGT  | TCAG  |
| 5   | 3'WT+PolIII block | bsmbi_3wt_tile1_sub4     | 1688 nt | TCAG  | CACC  |
| 6   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1 | --      | --    | --    |

```
  [TGGA]----3'WT sub1----[ATGT]----3'WT sub2----[TAGT]----3'WT sub3----[TCAG]----3'WT+PolIII sub4----[CACC]
   TGGA                   ATGT                   TAGT                   TCAG                          CACC 
```

**Set fidelity:** 0.9906 (5 overhangs)

---

### Tile 9 of 31 -- Codons 526-570 (135 nt)

**Boundary overhangs:**

| Position          | Sequence | Fidelity |
| ----------------- | -------- | -------- |
| oh1 (5' boundary) | GTAA     | 0.8029   |
| oh2 (3' boundary) | ACAG     | 0.5793   |

**Variants:** 8400 mutations, 8400 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name             | Length  | 5' OH | 3' OH |
| --- | --------------- | --------------------- | ------- | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile9        | 1609 nt | TGAA  | GTAA  |
| 2   | Oligo pool      | Tile 9 (8400 oligos)  | 191 nt  | GTAA  | AGAA  |
| 3   | Helper plasmid  | helper_plasmid_insert | --      | --    | --    |
| 4   | Enzyme + buffer | BsaI-HFv2 + CutSmart  | --      | --    | --    |

```
  [TGAA]----5'WT block----[GTAA]----oligo+BC----[AGAA]
   TGAA                    GTAA                  AGAA 
```

**Set fidelity:** 0.9406 (3 overhangs)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------ | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)      | --      | --    | --    |
| 2   | 3'WT block        | bsmbi_3wt_tile9_sub1     | 1764 nt | ACAG  | TAGT  |
| 3   | 3'WT block        | bsmbi_3wt_tile1_sub3     | 1728 nt | TAGT  | TCAG  |
| 4   | 3'WT+PolIII block | bsmbi_3wt_tile1_sub4     | 1688 nt | TCAG  | CACC  |
| 5   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1 | --      | --    | --    |

```
  [ACAG]----3'WT sub1----[TAGT]----3'WT sub2----[TCAG]----3'WT+PolIII sub3----[CACC]
   ACAG                   TAGT                   TCAG                          CACC 
```

**Set fidelity:** 0.8676 (4 overhangs)

---

### Tile 10 of 31 -- Codons 571-635 (195 nt)

**Boundary overhangs:**

| Position          | Sequence | Fidelity |
| ----------------- | -------- | -------- |
| oh1 (5' boundary) | AAAG     | 0.7511   |
| oh2 (3' boundary) | AAAG     | 0.7511   |

**Variants:** 12810 mutations, 12810 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name              | Length  | 5' OH | 3' OH |
| --- | --------------- | ---------------------- | ------- | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile10        | 1744 nt | TGAA  | AAAG  |
| 2   | Oligo pool      | Tile 10 (12810 oligos) | 251 nt  | AAAG  | AGAA  |
| 3   | Helper plasmid  | helper_plasmid_insert  | --      | --    | --    |
| 4   | Enzyme + buffer | BsaI-HFv2 + CutSmart   | --      | --    | --    |

```
  [TGAA]----5'WT block----[AAAG]----oligo+BC----[AGAA]
   TGAA                    AAAG                  AGAA 
```

**Set fidelity:** 0.9406 (3 overhangs)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------ | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)      | --      | --    | --    |
| 2   | 3'WT block        | bsmbi_3wt_tile10_sub1    | 1569 nt | AAAG  | TAGT  |
| 3   | 3'WT block        | bsmbi_3wt_tile1_sub3     | 1728 nt | TAGT  | TCAG  |
| 4   | 3'WT+PolIII block | bsmbi_3wt_tile1_sub4     | 1688 nt | TCAG  | CACC  |
| 5   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1 | --      | --    | --    |

```
  [AAAG]----3'WT sub1----[TAGT]----3'WT sub2----[TCAG]----3'WT+PolIII sub3----[CACC]
   AAAG                   TAGT                   TCAG                          CACC 
```

**Set fidelity:** 1.0000 (4 overhangs)

---

### Tile 11 of 31 -- Codons 630-695 (198 nt)

**Boundary overhangs:**

| Position          | Sequence | Fidelity |
| ----------------- | -------- | -------- |
| oh1 (5' boundary) | GATT     | 0.6417   |
| oh2 (3' boundary) | TGAA     | 0.8621   |

**Variants:** 12600 mutations, 12600 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name              | Length  | 5' OH | 3' OH |
| --- | --------------- | ---------------------- | ------- | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile10        | 1744 nt | TGAA  | AAAG  |
| 2   | 5'WT gene block | bsai_5wt_tile11_sub2   | 207 nt  | AAAG  | GATT  |
| 3   | Oligo pool      | Tile 11 (12600 oligos) | 254 nt  | GATT  | AGAA  |
| 4   | Helper plasmid  | helper_plasmid_insert  | --      | --    | --    |
| 5   | Enzyme + buffer | BsaI-HFv2 + CutSmart   | --      | --    | --    |

```
  [TGAA]----5'WT sub1----[AAAG]----5'WT sub2----[GATT]----oligo+BC----[AGAA]
   TGAA                   AAAG                   GATT                  AGAA 
```

**Set fidelity:** 0.9406 (4 overhangs)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------ | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)      | --      | --    | --    |
| 2   | 3'WT block        | bsmbi_3wt_tile11_sub1    | 1389 nt | TGAA  | TAGT  |
| 3   | 3'WT block        | bsmbi_3wt_tile1_sub3     | 1728 nt | TAGT  | TCAG  |
| 4   | 3'WT+PolIII block | bsmbi_3wt_tile1_sub4     | 1688 nt | TCAG  | CACC  |
| 5   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1 | --      | --    | --    |

```
  [TGAA]----3'WT sub1----[TAGT]----3'WT sub2----[TCAG]----3'WT+PolIII sub3----[CACC]
   TGAA                   TAGT                   TCAG                          CACC 
```

**Set fidelity:** 1.0000 (4 overhangs)

---

### Tile 12 of 31 -- Codons 690-764 (225 nt)

**Boundary overhangs:**

| Position          | Sequence | Fidelity |
| ----------------- | -------- | -------- |
| oh1 (5' boundary) | GCAA     | 0.7543   |
| oh2 (3' boundary) | ATAC     | 0.6804   |

**Variants:** 14490 mutations, 14490 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name              | Length  | 5' OH | 3' OH |
| --- | --------------- | ---------------------- | ------- | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile10        | 1744 nt | TGAA  | AAAG  |
| 2   | 5'WT gene block | bsai_5wt_tile12_sub2   | 387 nt  | AAAG  | GCAA  |
| 3   | Oligo pool      | Tile 12 (14490 oligos) | 281 nt  | GCAA  | AGAA  |
| 4   | Helper plasmid  | helper_plasmid_insert  | --      | --    | --    |
| 5   | Enzyme + buffer | BsaI-HFv2 + CutSmart   | --      | --    | --    |

```
  [TGAA]----5'WT sub1----[AAAG]----5'WT sub2----[GCAA]----oligo+BC----[AGAA]
   TGAA                   AAAG                   GCAA                  AGAA 
```

**Set fidelity:** 0.9406 (4 overhangs)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------ | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)      | --      | --    | --    |
| 2   | 3'WT block        | bsmbi_3wt_tile12_sub1    | 1182 nt | ATAC  | TAGT  |
| 3   | 3'WT block        | bsmbi_3wt_tile1_sub3     | 1728 nt | TAGT  | TCAG  |
| 4   | 3'WT+PolIII block | bsmbi_3wt_tile1_sub4     | 1688 nt | TCAG  | CACC  |
| 5   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1 | --      | --    | --    |

```
  [ATAC]----3'WT sub1----[TAGT]----3'WT sub2----[TCAG]----3'WT+PolIII sub3----[CACC]
   ATAC                   TAGT                   TCAG                          CACC 
```

**Set fidelity:** 1.0000 (4 overhangs)

---

### Tile 13 of 31 -- Codons 759-812 (162 nt)

**Boundary overhangs:**

| Position          | Sequence | Fidelity |
| ----------------- | -------- | -------- |
| oh1 (5' boundary) | GAAT     | 0.7246   |
| oh2 (3' boundary) | TTCA     | 0.8824   |

**Variants:** 10080 mutations, 10080 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name              | Length  | 5' OH | 3' OH |
| --- | --------------- | ---------------------- | ------- | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile10        | 1744 nt | TGAA  | AAAG  |
| 2   | 5'WT gene block | bsai_5wt_tile13_sub2   | 594 nt  | AAAG  | GAAT  |
| 3   | Oligo pool      | Tile 13 (10080 oligos) | 218 nt  | GAAT  | AGAA  |
| 4   | Helper plasmid  | helper_plasmid_insert  | --      | --    | --    |
| 5   | Enzyme + buffer | BsaI-HFv2 + CutSmart   | --      | --    | --    |

```
  [TGAA]----5'WT sub1----[AAAG]----5'WT sub2----[GAAT]----oligo+BC----[AGAA]
   TGAA                   AAAG                   GAAT                  AGAA 
```

**Set fidelity:** 0.9392 (4 overhangs)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------ | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)      | --      | --    | --    |
| 2   | 3'WT block        | bsmbi_3wt_tile13_sub1    | 1038 nt | TTCA  | TAGT  |
| 3   | 3'WT block        | bsmbi_3wt_tile1_sub3     | 1728 nt | TAGT  | TCAG  |
| 4   | 3'WT+PolIII block | bsmbi_3wt_tile1_sub4     | 1688 nt | TCAG  | CACC  |
| 5   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1 | --      | --    | --    |

```
  [TTCA]----3'WT sub1----[TAGT]----3'WT sub2----[TCAG]----3'WT+PolIII sub3----[CACC]
   TTCA                   TAGT                   TCAG                          CACC 
```

**Set fidelity:** 1.0000 (4 overhangs)

---

### Tile 14 of 31 -- Codons 807-876 (210 nt)

**Boundary overhangs:**

| Position          | Sequence | Fidelity |
| ----------------- | -------- | -------- |
| oh1 (5' boundary) | TCTG     | 0.6684   |
| oh2 (3' boundary) | TTCT     | 0.8181   |

**Variants:** 13440 mutations, 13440 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name              | Length  | 5' OH | 3' OH |
| --- | --------------- | ---------------------- | ------- | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile10        | 1744 nt | TGAA  | AAAG  |
| 2   | 5'WT gene block | bsai_5wt_tile14_sub2   | 738 nt  | AAAG  | TCTG  |
| 3   | Oligo pool      | Tile 14 (13440 oligos) | 266 nt  | TCTG  | AGAA  |
| 4   | Helper plasmid  | helper_plasmid_insert  | --      | --    | --    |
| 5   | Enzyme + buffer | BsaI-HFv2 + CutSmart   | --      | --    | --    |

```
  [TGAA]----5'WT sub1----[AAAG]----5'WT sub2----[TCTG]----oligo+BC----[AGAA]
   TGAA                   AAAG                   TCTG                  AGAA 
```

**Set fidelity:** 0.9406 (4 overhangs)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------ | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)      | --      | --    | --    |
| 2   | 3'WT block        | bsmbi_3wt_tile14_sub1    | 846 nt  | TTCT  | TAGT  |
| 3   | 3'WT block        | bsmbi_3wt_tile1_sub3     | 1728 nt | TAGT  | TCAG  |
| 4   | 3'WT+PolIII block | bsmbi_3wt_tile1_sub4     | 1688 nt | TCAG  | CACC  |
| 5   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1 | --      | --    | --    |

```
  [TTCT]----3'WT sub1----[TAGT]----3'WT sub2----[TCAG]----3'WT+PolIII sub3----[CACC]
   TTCT                   TAGT                   TCAG                          CACC 
```

**Set fidelity:** 1.0000 (4 overhangs)

---

### Tile 15 of 31 -- Codons 871-939 (207 nt)

**Boundary overhangs:**

| Position          | Sequence | Fidelity |
| ----------------- | -------- | -------- |
| oh1 (5' boundary) | ATTA     | 0.7818   |
| oh2 (3' boundary) | TGCT     | 0.5975   |

**Variants:** 13230 mutations, 13230 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name              | Length  | 5' OH | 3' OH |
| --- | --------------- | ---------------------- | ------- | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile10        | 1744 nt | TGAA  | AAAG  |
| 2   | 5'WT gene block | bsai_5wt_tile15_sub2   | 930 nt  | AAAG  | ATTA  |
| 3   | Oligo pool      | Tile 15 (13230 oligos) | 263 nt  | ATTA  | AGAA  |
| 4   | Helper plasmid  | helper_plasmid_insert  | --      | --    | --    |
| 5   | Enzyme + buffer | BsaI-HFv2 + CutSmart   | --      | --    | --    |

```
  [TGAA]----5'WT sub1----[AAAG]----5'WT sub2----[ATTA]----oligo+BC----[AGAA]
   TGAA                   AAAG                   ATTA                  AGAA 
```

**Set fidelity:** 0.9406 (4 overhangs)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------ | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)      | --      | --    | --    |
| 2   | 3'WT block        | bsmbi_3wt_tile15_sub1    | 657 nt  | TGCT  | TAGT  |
| 3   | 3'WT block        | bsmbi_3wt_tile1_sub3     | 1728 nt | TAGT  | TCAG  |
| 4   | 3'WT+PolIII block | bsmbi_3wt_tile1_sub4     | 1688 nt | TCAG  | CACC  |
| 5   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1 | --      | --    | --    |

```
  [TGCT]----3'WT sub1----[TAGT]----3'WT sub2----[TCAG]----3'WT+PolIII sub3----[CACC]
   TGCT                   TAGT                   TCAG                          CACC 
```

**Set fidelity:** 1.0000 (4 overhangs)

---

### Tile 16 of 31 -- Codons 934-983 (150 nt)

**Boundary overhangs:**

| Position          | Sequence | Fidelity |
| ----------------- | -------- | -------- |
| oh1 (5' boundary) | AATA     | 0.8816   |
| oh2 (3' boundary) | AGAA     | 0.8847   |

**Variants:** 9240 mutations, 9240 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name             | Length  | 5' OH | 3' OH |
| --- | --------------- | --------------------- | ------- | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile10       | 1744 nt | TGAA  | AAAG  |
| 2   | 5'WT gene block | bsai_5wt_tile16_sub2  | 1119 nt | AAAG  | AATA  |
| 3   | Oligo pool      | Tile 16 (9240 oligos) | 206 nt  | AATA  | AGAA  |
| 4   | Helper plasmid  | helper_plasmid_insert | --      | --    | --    |
| 5   | Enzyme + buffer | BsaI-HFv2 + CutSmart  | --      | --    | --    |

```
  [TGAA]----5'WT sub1----[AAAG]----5'WT sub2----[AATA]----oligo+BC----[AGAA]
   TGAA                   AAAG                   AATA                  AGAA 
```

**Set fidelity:** 0.9406 (4 overhangs)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------ | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)      | --      | --    | --    |
| 2   | 3'WT block        | bsmbi_3wt_tile16_sub1    | 525 nt  | AGAA  | TAGT  |
| 3   | 3'WT block        | bsmbi_3wt_tile1_sub3     | 1728 nt | TAGT  | TCAG  |
| 4   | 3'WT+PolIII block | bsmbi_3wt_tile1_sub4     | 1688 nt | TCAG  | CACC  |
| 5   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1 | --      | --    | --    |

```
  [AGAA]----3'WT sub1----[TAGT]----3'WT sub2----[TCAG]----3'WT+PolIII sub3----[CACC]
   AGAA                   TAGT                   TCAG                          CACC 
```

**Set fidelity:** 1.0000 (4 overhangs)

---

### Tile 17 of 31 -- Codons 978-1053 (228 nt)

**Boundary overhangs:**

| Position          | Sequence | Fidelity |
| ----------------- | -------- | -------- |
| oh1 (5' boundary) | TCAC     | 0.7626   |
| oh2 (3' boundary) | TACA     | 0.8652   |

**Variants:** 14700 mutations, 14700 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name              | Length  | 5' OH | 3' OH |
| --- | --------------- | ---------------------- | ------- | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile10        | 1744 nt | TGAA  | AAAG  |
| 2   | 5'WT gene block | bsai_5wt_tile17_sub2   | 1251 nt | AAAG  | TCAC  |
| 3   | Oligo pool      | Tile 17 (14700 oligos) | 284 nt  | TCAC  | AGAA  |
| 4   | Helper plasmid  | helper_plasmid_insert  | --      | --    | --    |
| 5   | Enzyme + buffer | BsaI-HFv2 + CutSmart   | --      | --    | --    |

```
  [TGAA]----5'WT sub1----[AAAG]----5'WT sub2----[TCAC]----oligo+BC----[AGAA]
   TGAA                   AAAG                   TCAC                  AGAA 
```

**Set fidelity:** 0.9406 (4 overhangs)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------ | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)      | --      | --    | --    |
| 2   | 3'WT block        | bsmbi_3wt_tile17_sub1    | 315 nt  | TACA  | TAGT  |
| 3   | 3'WT block        | bsmbi_3wt_tile1_sub3     | 1728 nt | TAGT  | TCAG  |
| 4   | 3'WT+PolIII block | bsmbi_3wt_tile1_sub4     | 1688 nt | TCAG  | CACC  |
| 5   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1 | --      | --    | --    |

```
  [TACA]----3'WT sub1----[TAGT]----3'WT sub2----[TCAG]----3'WT+PolIII sub3----[CACC]
   TACA                   TAGT                   TCAG                          CACC 
```

**Set fidelity:** 1.0000 (4 overhangs)

---

### Tile 18 of 31 -- Codons 1048-1101 (162 nt)

**Boundary overhangs:**

| Position          | Sequence | Fidelity |
| ----------------- | -------- | -------- |
| oh1 (5' boundary) | CATA     | 0.7540   |
| oh2 (3' boundary) | TCCT     | 0.7573   |

**Variants:** 10080 mutations, 10080 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name              | Length  | 5' OH | 3' OH |
| --- | --------------- | ---------------------- | ------- | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile10        | 1744 nt | TGAA  | AAAG  |
| 2   | 5'WT gene block | bsai_5wt_tile18_sub2   | 1461 nt | AAAG  | CATA  |
| 3   | Oligo pool      | Tile 18 (10080 oligos) | 218 nt  | CATA  | AGAA  |
| 4   | Helper plasmid  | helper_plasmid_insert  | --      | --    | --    |
| 5   | Enzyme + buffer | BsaI-HFv2 + CutSmart   | --      | --    | --    |

```
  [TGAA]----5'WT sub1----[AAAG]----5'WT sub2----[CATA]----oligo+BC----[AGAA]
   TGAA                   AAAG                   CATA                  AGAA 
```

**Set fidelity:** 0.9406 (4 overhangs)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------ | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)      | --      | --    | --    |
| 2   | 3'WT block        | bsmbi_3wt_tile18_sub1    | 171 nt  | TCCT  | TAGT  |
| 3   | 3'WT block        | bsmbi_3wt_tile1_sub3     | 1728 nt | TAGT  | TCAG  |
| 4   | 3'WT+PolIII block | bsmbi_3wt_tile1_sub4     | 1688 nt | TCAG  | CACC  |
| 5   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1 | --      | --    | --    |

```
  [TCCT]----3'WT sub1----[TAGT]----3'WT sub2----[TCAG]----3'WT+PolIII sub3----[CACC]
   TCCT                   TAGT                   TCAG                          CACC 
```

**Set fidelity:** 1.0000 (4 overhangs)

---

### Tile 19 of 31 -- Codons 1096-1142 (141 nt)

**Boundary overhangs:**

| Position          | Sequence | Fidelity |
| ----------------- | -------- | -------- |
| oh1 (5' boundary) | GTAA     | 0.8029   |
| oh2 (3' boundary) | ACAC     | 0.5629   |

**Variants:** 8820 mutations, 8820 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name             | Length  | 5' OH | 3' OH |
| --- | --------------- | --------------------- | ------- | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile10       | 1744 nt | TGAA  | AAAG  |
| 2   | 5'WT gene block | bsai_5wt_tile19_sub2  | 1605 nt | AAAG  | GTAA  |
| 3   | Oligo pool      | Tile 19 (8820 oligos) | 197 nt  | GTAA  | AGAA  |
| 4   | Helper plasmid  | helper_plasmid_insert | --      | --    | --    |
| 5   | Enzyme + buffer | BsaI-HFv2 + CutSmart  | --      | --    | --    |

```
  [TGAA]----5'WT sub1----[AAAG]----5'WT sub2----[GTAA]----oligo+BC----[AGAA]
   TGAA                   AAAG                   GTAA                  AGAA 
```

**Set fidelity:** 0.9406 (4 overhangs)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------ | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)      | --      | --    | --    |
| 2   | 3'WT block        | bsmbi_3wt_tile19_sub1    | 1746 nt | ACAC  | TCAG  |
| 3   | 3'WT+PolIII block | bsmbi_3wt_tile1_sub4     | 1688 nt | TCAG  | CACC  |
| 4   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1 | --      | --    | --    |

```
  [ACAC]----3'WT sub1----[TCAG]----3'WT+PolIII sub2----[CACC]
   ACAC                   TCAG                          CACC 
```

**Set fidelity:** 1.0000 (3 overhangs)

---

### Tile 20 of 31 -- Codons 1143-1207 (195 nt)

**Boundary overhangs:**

| Position          | Sequence | Fidelity |
| ----------------- | -------- | -------- |
| oh1 (5' boundary) | AACT     | 0.6635   |
| oh2 (3' boundary) | CCTT     | 0.6891   |

**Variants:** 12810 mutations, 12810 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name              | Length  | 5' OH | 3' OH |
| --- | --------------- | ---------------------- | ------- | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile10        | 1744 nt | TGAA  | AAAG  |
| 2   | 5'WT gene block | bsai_5wt_tile20_sub2   | 1746 nt | AAAG  | AACT  |
| 3   | Oligo pool      | Tile 20 (12810 oligos) | 251 nt  | AACT  | AGAA  |
| 4   | Helper plasmid  | helper_plasmid_insert  | --      | --    | --    |
| 5   | Enzyme + buffer | BsaI-HFv2 + CutSmart   | --      | --    | --    |

```
  [TGAA]----5'WT sub1----[AAAG]----5'WT sub2----[AACT]----oligo+BC----[AGAA]
   TGAA                   AAAG                   AACT                  AGAA 
```

**Set fidelity:** 0.9406 (4 overhangs)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------ | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)      | --      | --    | --    |
| 2   | 3'WT block        | bsmbi_3wt_tile20_sub1    | 1551 nt | CCTT  | TCAG  |
| 3   | 3'WT+PolIII block | bsmbi_3wt_tile1_sub4     | 1688 nt | TCAG  | CACC  |
| 4   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1 | --      | --    | --    |

```
  [CCTT]----3'WT sub1----[TCAG]----3'WT+PolIII sub2----[CACC]
   CCTT                   TCAG                          CACC 
```

**Set fidelity:** 1.0000 (3 overhangs)

---

### Tile 21 of 31 -- Codons 1202-1256 (165 nt)

**Boundary overhangs:**

| Position          | Sequence | Fidelity |
| ----------------- | -------- | -------- |
| oh1 (5' boundary) | TTAG     | 0.8480   |
| oh2 (3' boundary) | ATTA     | 0.7818   |

**Variants:** 10290 mutations, 10290 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name              | Length  | 5' OH | 3' OH |
| --- | --------------- | ---------------------- | ------- | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile10        | 1744 nt | TGAA  | AAAG  |
| 2   | 5'WT gene block | bsai_5wt_tile20_sub2   | 1746 nt | AAAG  | AACT  |
| 3   | 5'WT gene block | bsai_5wt_tile21_sub3   | 207 nt  | AACT  | TTAG  |
| 4   | Oligo pool      | Tile 21 (10290 oligos) | 221 nt  | TTAG  | AGAA  |
| 5   | Helper plasmid  | helper_plasmid_insert  | --      | --    | --    |
| 6   | Enzyme + buffer | BsaI-HFv2 + CutSmart   | --      | --    | --    |

```
  [TGAA]----5'WT sub1----[AAAG]----5'WT sub2----[AACT]----5'WT sub3----[TTAG]----oligo+BC----[AGAA]
   TGAA                   AAAG                   AACT                   TTAG                  AGAA 
```

**Set fidelity:** 0.9406 (5 overhangs)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------ | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)      | --      | --    | --    |
| 2   | 3'WT block        | bsmbi_3wt_tile21_sub1    | 1404 nt | ATTA  | TCAG  |
| 3   | 3'WT+PolIII block | bsmbi_3wt_tile1_sub4     | 1688 nt | TCAG  | CACC  |
| 4   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1 | --      | --    | --    |

```
  [ATTA]----3'WT sub1----[TCAG]----3'WT+PolIII sub2----[CACC]
   ATTA                   TCAG                          CACC 
```

**Set fidelity:** 1.0000 (3 overhangs)

---

### Tile 22 of 31 -- Codons 1251-1327 (231 nt)

**Boundary overhangs:**

| Position          | Sequence | Fidelity |
| ----------------- | -------- | -------- |
| oh1 (5' boundary) | GAAA     | 0.8745   |
| oh2 (3' boundary) | TTGT     | 0.7145   |

**Variants:** 14910 mutations, 14910 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name              | Length  | 5' OH | 3' OH |
| --- | --------------- | ---------------------- | ------- | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile10        | 1744 nt | TGAA  | AAAG  |
| 2   | 5'WT gene block | bsai_5wt_tile20_sub2   | 1746 nt | AAAG  | AACT  |
| 3   | 5'WT gene block | bsai_5wt_tile22_sub3   | 354 nt  | AACT  | GAAA  |
| 4   | Oligo pool      | Tile 22 (14910 oligos) | 287 nt  | GAAA  | AGAA  |
| 5   | Helper plasmid  | helper_plasmid_insert  | --      | --    | --    |
| 6   | Enzyme + buffer | BsaI-HFv2 + CutSmart   | --      | --    | --    |

```
  [TGAA]----5'WT sub1----[AAAG]----5'WT sub2----[AACT]----5'WT sub3----[GAAA]----oligo+BC----[AGAA]
   TGAA                   AAAG                   AACT                   GAAA                  AGAA 
```

**Set fidelity:** 0.9406 (5 overhangs)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------ | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)      | --      | --    | --    |
| 2   | 3'WT block        | bsmbi_3wt_tile22_sub1    | 1191 nt | TTGT  | TCAG  |
| 3   | 3'WT+PolIII block | bsmbi_3wt_tile1_sub4     | 1688 nt | TCAG  | CACC  |
| 4   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1 | --      | --    | --    |

```
  [TTGT]----3'WT sub1----[TCAG]----3'WT+PolIII sub2----[CACC]
   TTGT                   TCAG                          CACC 
```

**Set fidelity:** 1.0000 (3 overhangs)

---

### Tile 23 of 31 -- Codons 1322-1379 (174 nt)

**Boundary overhangs:**

| Position          | Sequence | Fidelity |
| ----------------- | -------- | -------- |
| oh1 (5' boundary) | TTAC     | 0.8333   |
| oh2 (3' boundary) | AGGA     | 0.7515   |

**Variants:** 10920 mutations, 10920 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name              | Length  | 5' OH | 3' OH |
| --- | --------------- | ---------------------- | ------- | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile10        | 1744 nt | TGAA  | AAAG  |
| 2   | 5'WT gene block | bsai_5wt_tile20_sub2   | 1746 nt | AAAG  | AACT  |
| 3   | 5'WT gene block | bsai_5wt_tile23_sub3   | 567 nt  | AACT  | TTAC  |
| 4   | Oligo pool      | Tile 23 (10920 oligos) | 230 nt  | TTAC  | AGAA  |
| 5   | Helper plasmid  | helper_plasmid_insert  | --      | --    | --    |
| 6   | Enzyme + buffer | BsaI-HFv2 + CutSmart   | --      | --    | --    |

```
  [TGAA]----5'WT sub1----[AAAG]----5'WT sub2----[AACT]----5'WT sub3----[TTAC]----oligo+BC----[AGAA]
   TGAA                   AAAG                   AACT                   TTAC                  AGAA 
```

**Set fidelity:** 0.9406 (5 overhangs)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------ | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)      | --      | --    | --    |
| 2   | 3'WT block        | bsmbi_3wt_tile23_sub1    | 1035 nt | AGGA  | TCAG  |
| 3   | 3'WT+PolIII block | bsmbi_3wt_tile1_sub4     | 1688 nt | TCAG  | CACC  |
| 4   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1 | --      | --    | --    |

```
  [AGGA]----3'WT sub1----[TCAG]----3'WT+PolIII sub2----[CACC]
   AGGA                   TCAG                          CACC 
```

**Set fidelity:** 1.0000 (3 overhangs)

---

### Tile 24 of 31 -- Codons 1374-1446 (219 nt)

**Boundary overhangs:**

| Position          | Sequence | Fidelity |
| ----------------- | -------- | -------- |
| oh1 (5' boundary) | CGAT     | 0.6118   |
| oh2 (3' boundary) | TCCA     | 0.8519   |

**Variants:** 14070 mutations, 14070 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name              | Length  | 5' OH | 3' OH |
| --- | --------------- | ---------------------- | ------- | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile10        | 1744 nt | TGAA  | AAAG  |
| 2   | 5'WT gene block | bsai_5wt_tile20_sub2   | 1746 nt | AAAG  | AACT  |
| 3   | 5'WT gene block | bsai_5wt_tile24_sub3   | 723 nt  | AACT  | CGAT  |
| 4   | Oligo pool      | Tile 24 (14070 oligos) | 275 nt  | CGAT  | AGAA  |
| 5   | Helper plasmid  | helper_plasmid_insert  | --      | --    | --    |
| 6   | Enzyme + buffer | BsaI-HFv2 + CutSmart   | --      | --    | --    |

```
  [TGAA]----5'WT sub1----[AAAG]----5'WT sub2----[AACT]----5'WT sub3----[CGAT]----oligo+BC----[AGAA]
   TGAA                   AAAG                   AACT                   CGAT                  AGAA 
```

**Set fidelity:** 0.9406 (5 overhangs)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------ | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)      | --      | --    | --    |
| 2   | 3'WT block        | bsmbi_3wt_tile24_sub1    | 834 nt  | TCCA  | TCAG  |
| 3   | 3'WT+PolIII block | bsmbi_3wt_tile1_sub4     | 1688 nt | TCAG  | CACC  |
| 4   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1 | --      | --    | --    |

```
  [TCCA]----3'WT sub1----[TCAG]----3'WT+PolIII sub2----[CACC]
   TCCA                   TCAG                          CACC 
```

**Set fidelity:** 1.0000 (3 overhangs)

---

### Tile 25 of 31 -- Codons 1441-1511 (213 nt)

**Boundary overhangs:**

| Position          | Sequence | Fidelity |
| ----------------- | -------- | -------- |
| oh1 (5' boundary) | GAAA     | 0.8745   |
| oh2 (3' boundary) | TCTT     | 0.7985   |

**Variants:** 13650 mutations, 13650 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name              | Length  | 5' OH | 3' OH |
| --- | --------------- | ---------------------- | ------- | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile10        | 1744 nt | TGAA  | AAAG  |
| 2   | 5'WT gene block | bsai_5wt_tile20_sub2   | 1746 nt | AAAG  | AACT  |
| 3   | 5'WT gene block | bsai_5wt_tile25_sub3   | 924 nt  | AACT  | GAAA  |
| 4   | Oligo pool      | Tile 25 (13650 oligos) | 269 nt  | GAAA  | AGAA  |
| 5   | Helper plasmid  | helper_plasmid_insert  | --      | --    | --    |
| 6   | Enzyme + buffer | BsaI-HFv2 + CutSmart   | --      | --    | --    |

```
  [TGAA]----5'WT sub1----[AAAG]----5'WT sub2----[AACT]----5'WT sub3----[GAAA]----oligo+BC----[AGAA]
   TGAA                   AAAG                   AACT                   GAAA                  AGAA 
```

**Set fidelity:** 0.9406 (5 overhangs)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------ | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)      | --      | --    | --    |
| 2   | 3'WT block        | bsmbi_3wt_tile25_sub1    | 639 nt  | TCTT  | TCAG  |
| 3   | 3'WT+PolIII block | bsmbi_3wt_tile1_sub4     | 1688 nt | TCAG  | CACC  |
| 4   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1 | --      | --    | --    |

```
  [TCTT]----3'WT sub1----[TCAG]----3'WT+PolIII sub2----[CACC]
   TCTT                   TCAG                          CACC 
```

**Set fidelity:** 1.0000 (3 overhangs)

---

### Tile 26 of 31 -- Codons 1506-1582 (231 nt)

**Boundary overhangs:**

| Position          | Sequence | Fidelity |
| ----------------- | -------- | -------- |
| oh1 (5' boundary) | GAAT     | 0.7246   |
| oh2 (3' boundary) | TCTT     | 0.7985   |

**Variants:** 14910 mutations, 14910 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name              | Length  | 5' OH | 3' OH |
| --- | --------------- | ---------------------- | ------- | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile10        | 1744 nt | TGAA  | AAAG  |
| 2   | 5'WT gene block | bsai_5wt_tile20_sub2   | 1746 nt | AAAG  | AACT  |
| 3   | 5'WT gene block | bsai_5wt_tile26_sub3   | 1119 nt | AACT  | GAAT  |
| 4   | Oligo pool      | Tile 26 (14910 oligos) | 287 nt  | GAAT  | AGAA  |
| 5   | Helper plasmid  | helper_plasmid_insert  | --      | --    | --    |
| 6   | Enzyme + buffer | BsaI-HFv2 + CutSmart   | --      | --    | --    |

```
  [TGAA]----5'WT sub1----[AAAG]----5'WT sub2----[AACT]----5'WT sub3----[GAAT]----oligo+BC----[AGAA]
   TGAA                   AAAG                   AACT                   GAAT                  AGAA 
```

**Set fidelity:** 0.9392 (5 overhangs)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------ | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)      | --      | --    | --    |
| 2   | 3'WT block        | bsmbi_3wt_tile26_sub1    | 426 nt  | TCTT  | TCAG  |
| 3   | 3'WT+PolIII block | bsmbi_3wt_tile1_sub4     | 1688 nt | TCAG  | CACC  |
| 4   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1 | --      | --    | --    |

```
  [TCTT]----3'WT sub1----[TCAG]----3'WT+PolIII sub2----[CACC]
   TCTT                   TCAG                          CACC 
```

**Set fidelity:** 1.0000 (3 overhangs)

---

### Tile 27 of 31 -- Codons 1577-1644 (204 nt)

**Boundary overhangs:**

| Position          | Sequence | Fidelity |
| ----------------- | -------- | -------- |
| oh1 (5' boundary) | GAAA     | 0.8745   |
| oh2 (3' boundary) | TCTT     | 0.7985   |

**Variants:** 13020 mutations, 13020 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name              | Length  | 5' OH | 3' OH |
| --- | --------------- | ---------------------- | ------- | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile10        | 1744 nt | TGAA  | AAAG  |
| 2   | 5'WT gene block | bsai_5wt_tile20_sub2   | 1746 nt | AAAG  | AACT  |
| 3   | 5'WT gene block | bsai_5wt_tile27_sub3   | 1332 nt | AACT  | GAAA  |
| 4   | Oligo pool      | Tile 27 (13020 oligos) | 260 nt  | GAAA  | AGAA  |
| 5   | Helper plasmid  | helper_plasmid_insert  | --      | --    | --    |
| 6   | Enzyme + buffer | BsaI-HFv2 + CutSmart   | --      | --    | --    |

```
  [TGAA]----5'WT sub1----[AAAG]----5'WT sub2----[AACT]----5'WT sub3----[GAAA]----oligo+BC----[AGAA]
   TGAA                   AAAG                   AACT                   GAAA                  AGAA 
```

**Set fidelity:** 0.9406 (5 overhangs)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------ | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)      | --      | --    | --    |
| 2   | 3'WT block        | bsmbi_3wt_tile27_sub1    | 240 nt  | TCTT  | TCAG  |
| 3   | 3'WT+PolIII block | bsmbi_3wt_tile1_sub4     | 1688 nt | TCAG  | CACC  |
| 4   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1 | --      | --    | --    |

```
  [TCTT]----3'WT sub1----[TCAG]----3'WT+PolIII sub2----[CACC]
   TCTT                   TCAG                          CACC 
```

**Set fidelity:** 1.0000 (3 overhangs)

---

### Tile 28 of 31 -- Codons 1639-1708 (210 nt)

**Boundary overhangs:**

| Position          | Sequence | Fidelity |
| ----------------- | -------- | -------- |
| oh1 (5' boundary) | CAGA     | 0.8175   |
| oh2 (3' boundary) | AAAA     | 0.9502   |

**Variants:** 13650 mutations, 13650 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name              | Length  | 5' OH | 3' OH |
| --- | --------------- | ---------------------- | ------- | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile10        | 1744 nt | TGAA  | AAAG  |
| 2   | 5'WT gene block | bsai_5wt_tile20_sub2   | 1746 nt | AAAG  | AACT  |
| 3   | 5'WT gene block | bsai_5wt_tile28_sub3   | 1518 nt | AACT  | CAGA  |
| 4   | Oligo pool      | Tile 28 (13650 oligos) | 266 nt  | CAGA  | AGAA  |
| 5   | Helper plasmid  | helper_plasmid_insert  | --      | --    | --    |
| 6   | Enzyme + buffer | BsaI-HFv2 + CutSmart   | --      | --    | --    |

```
  [TGAA]----5'WT sub1----[AAAG]----5'WT sub2----[AACT]----5'WT sub3----[CAGA]----oligo+BC----[AGAA]
   TGAA                   AAAG                   AACT                   CAGA                  AGAA 
```

**Set fidelity:** 0.9406 (5 overhangs)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------ | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)      | --      | --    | --    |
| 2   | 3'WT+PolIII block | bsmbi_3wt_tile28         | 1706 nt | AAAA  | CACC  |
| 3   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1 | --      | --    | --    |

```
  [AAAA]----3'WT+PolIII----[CACC]
   AAAA                     CACC 
```

**Set fidelity:** 1.0000 (2 overhangs)

---

### Tile 29 of 31 -- Codons 1709-1778 (210 nt)

**Boundary overhangs:**

| Position          | Sequence | Fidelity |
| ----------------- | -------- | -------- |
| oh1 (5' boundary) | GAAA     | 0.8745   |
| oh2 (3' boundary) | CAAT     | 0.7361   |

**Variants:** 13860 mutations, 13860 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name              | Length  | 5' OH | 3' OH |
| --- | --------------- | ---------------------- | ------- | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile10        | 1744 nt | TGAA  | AAAG  |
| 2   | 5'WT gene block | bsai_5wt_tile20_sub2   | 1746 nt | AAAG  | AACT  |
| 3   | 5'WT gene block | bsai_5wt_tile29_sub3   | 1728 nt | AACT  | GAAA  |
| 4   | Oligo pool      | Tile 29 (13860 oligos) | 266 nt  | GAAA  | AGAA  |
| 5   | Helper plasmid  | helper_plasmid_insert  | --      | --    | --    |
| 6   | Enzyme + buffer | BsaI-HFv2 + CutSmart   | --      | --    | --    |

```
  [TGAA]----5'WT sub1----[AAAG]----5'WT sub2----[AACT]----5'WT sub3----[GAAA]----oligo+BC----[AGAA]
   TGAA                   AAAG                   AACT                   GAAA                  AGAA 
```

**Set fidelity:** 0.9406 (5 overhangs)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------ | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)      | --      | --    | --    |
| 2   | 3'WT+PolIII block | bsmbi_3wt_tile29         | 1496 nt | CAAT  | CACC  |
| 3   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1 | --      | --    | --    |

```
  [CAAT]----3'WT+PolIII----[CACC]
   CAAT                     CACC 
```

**Set fidelity:** 1.0000 (2 overhangs)

---

### Tile 30 of 31 -- Codons 1773-1839 (201 nt)

**Boundary overhangs:**

| Position          | Sequence | Fidelity |
| ----------------- | -------- | -------- |
| oh1 (5' boundary) | GATT     | 0.6417   |
| oh2 (3' boundary) | TGAA     | 0.8621   |

**Variants:** 12810 mutations, 12810 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name              | Length  | 5' OH | 3' OH |
| --- | --------------- | ---------------------- | ------- | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile10        | 1744 nt | TGAA  | AAAG  |
| 2   | 5'WT gene block | bsai_5wt_tile20_sub2   | 1746 nt | AAAG  | AACT  |
| 3   | 5'WT gene block | bsai_5wt_tile29_sub3   | 1728 nt | AACT  | GAAA  |
| 4   | 5'WT gene block | bsai_5wt_tile30_sub4   | 222 nt  | GAAA  | GATT  |
| 5   | Oligo pool      | Tile 30 (12810 oligos) | 257 nt  | GATT  | AGAA  |
| 6   | Helper plasmid  | helper_plasmid_insert  | --      | --    | --    |
| 7   | Enzyme + buffer | BsaI-HFv2 + CutSmart   | --      | --    | --    |

```
  [TGAA]----5'WT sub1----[AAAG]----5'WT sub2----[AACT]----5'WT sub3----[GAAA]----5'WT sub4----[GATT]----oligo+BC----[AGAA]
   TGAA                   AAAG                   AACT                   GAAA                   GATT                  AGAA 
```

**Set fidelity:** 0.9387 (6 overhangs)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------ | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)      | --      | --    | --    |
| 2   | 3'WT+PolIII block | bsmbi_3wt_tile30         | 1313 nt | TGAA  | CACC  |
| 3   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1 | --      | --    | --    |

```
  [TGAA]----3'WT+PolIII----[CACC]
   TGAA                     CACC 
```

**Set fidelity:** 1.0000 (2 overhangs)

---

### Tile 31 of 31 -- Codons 1834-1913 (240 nt)

**Boundary overhangs:**

| Position          | Sequence | Fidelity |
| ----------------- | -------- | -------- |
| oh1 (5' boundary) | ATTG     | 0.6124   |
| oh2 (3' boundary) | AAGA     | 0.9209   |

**Variants:** 13650 mutations, 13650 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name              | Length  | 5' OH | 3' OH |
| --- | --------------- | ---------------------- | ------- | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile10        | 1744 nt | TGAA  | AAAG  |
| 2   | 5'WT gene block | bsai_5wt_tile20_sub2   | 1746 nt | AAAG  | AACT  |
| 3   | 5'WT gene block | bsai_5wt_tile29_sub3   | 1728 nt | AACT  | GAAA  |
| 4   | 5'WT gene block | bsai_5wt_tile31_sub4   | 405 nt  | GAAA  | ATTG  |
| 5   | Oligo pool      | Tile 31 (13650 oligos) | 296 nt  | ATTG  | AGAA  |
| 6   | Helper plasmid  | helper_plasmid_insert  | --      | --    | --    |
| 7   | Enzyme + buffer | BsaI-HFv2 + CutSmart   | --      | --    | --    |

```
  [TGAA]----5'WT sub1----[AAAG]----5'WT sub2----[AACT]----5'WT sub3----[GAAA]----5'WT sub4----[ATTG]----oligo+BC----[AGAA]
   TGAA                   AAAG                   AACT                   GAAA                   ATTG                  AGAA 
```

**Set fidelity:** 0.9335 (6 overhangs)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component            | Part name                | Length  | 5' OH | 3' OH |
| --- | -------------------- | ------------------------ | ------- | ----- | ----- |
| 1   | BsaI product         | (in helper plasmid)      | --      | --    | --    |
| 2   | PolIII-only fragment | bsmbi_polIII_tile31      | 1091 nt | AAGA  | CACC  |
| 3   | Enzyme + buffer      | BsmBI-v2 + NEBuffer r3.1 | --      | --    | --    |

```
  [AAGA]----PolIII----[CACC]
   AAGA                CACC 
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

**Total blocks:** 64

| Block name            | Length (nt) | Enzyme type | Gene region                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                         |
| --------------------- | ----------- | ----------- | ----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| bsai_5wt_tile10       | 1744        | BsaI        | 5wt_tile10;5wt_tile11_sub1;5wt_tile12_sub1;5wt_tile13_sub1;5wt_tile14_sub1;5wt_tile15_sub1;5wt_tile16_sub1;5wt_tile17_sub1;5wt_tile18_sub1;5wt_tile19_sub1;5wt_tile20_sub1;5wt_tile21_sub1;5wt_tile22_sub1;5wt_tile23_sub1;5wt_tile24_sub1;5wt_tile25_sub1;5wt_tile26_sub1;5wt_tile27_sub1;5wt_tile28_sub1;5wt_tile29_sub1;5wt_tile30_sub1;5wt_tile31_sub1                                                                                                                                                                                                                                                                          |
| bsai_5wt_tile11_sub2  | 207         | BsaI        | 5wt_tile11_sub2                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                     |
| bsai_5wt_tile12_sub2  | 387         | BsaI        | 5wt_tile12_sub2                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                     |
| bsai_5wt_tile13_sub2  | 594         | BsaI        | 5wt_tile13_sub2                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                     |
| bsai_5wt_tile14_sub2  | 738         | BsaI        | 5wt_tile14_sub2                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                     |
| bsai_5wt_tile15_sub2  | 930         | BsaI        | 5wt_tile15_sub2                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                     |
| bsai_5wt_tile16_sub2  | 1119        | BsaI        | 5wt_tile16_sub2                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                     |
| bsai_5wt_tile17_sub2  | 1251        | BsaI        | 5wt_tile17_sub2                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                     |
| bsai_5wt_tile18_sub2  | 1461        | BsaI        | 5wt_tile18_sub2                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                     |
| bsai_5wt_tile19_sub2  | 1605        | BsaI        | 5wt_tile19_sub2                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                     |
| bsai_5wt_tile2        | 208         | BsaI        | 5wt_tile2                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                           |
| bsai_5wt_tile20_sub2  | 1746        | BsaI        | 5wt_tile20_sub2;5wt_tile21_sub2;5wt_tile22_sub2;5wt_tile23_sub2;5wt_tile24_sub2;5wt_tile25_sub2;5wt_tile26_sub2;5wt_tile27_sub2;5wt_tile28_sub2;5wt_tile29_sub2;5wt_tile30_sub2;5wt_tile31_sub2                                                                                                                                                                                                                                                                                                                                                                                                                                     |
| bsai_5wt_tile21_sub3  | 207         | BsaI        | 5wt_tile21_sub3                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                     |
| bsai_5wt_tile22_sub3  | 354         | BsaI        | 5wt_tile22_sub3                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                     |
| bsai_5wt_tile23_sub3  | 567         | BsaI        | 5wt_tile23_sub3                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                     |
| bsai_5wt_tile24_sub3  | 723         | BsaI        | 5wt_tile24_sub3                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                     |
| bsai_5wt_tile25_sub3  | 924         | BsaI        | 5wt_tile25_sub3                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                     |
| bsai_5wt_tile26_sub3  | 1119        | BsaI        | 5wt_tile26_sub3                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                     |
| bsai_5wt_tile27_sub3  | 1332        | BsaI        | 5wt_tile27_sub3                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                     |
| bsai_5wt_tile28_sub3  | 1518        | BsaI        | 5wt_tile28_sub3                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                     |
| bsai_5wt_tile29_sub3  | 1728        | BsaI        | 5wt_tile29_sub3;5wt_tile30_sub3;5wt_tile31_sub3                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                     |
| bsai_5wt_tile3        | 412         | BsaI        | 5wt_tile3                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                           |
| bsai_5wt_tile30_sub4  | 222         | BsaI        | 5wt_tile30_sub4                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                     |
| bsai_5wt_tile31_sub4  | 405         | BsaI        | 5wt_tile31_sub4                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                     |
| bsai_5wt_tile4        | 616         | BsaI        | 5wt_tile4                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                           |
| bsai_5wt_tile5        | 805         | BsaI        | 5wt_tile5                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                           |
| bsai_5wt_tile6        | 1009        | BsaI        | 5wt_tile6                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                           |
| bsai_5wt_tile7        | 1210        | BsaI        | 5wt_tile7                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                           |
| bsai_5wt_tile8        | 1405        | BsaI        | 5wt_tile8                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                           |
| bsai_5wt_tile9        | 1609        | BsaI        | 5wt_tile9                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                           |
| bsmbi_3wt_tile1_sub1  | 1566        | BsmBI       | 3wt_tile1_sub1                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                      |
| bsmbi_3wt_tile1_sub2  | 1746        | BsmBI       | 3wt_tile1_sub2;3wt_tile2_sub2;3wt_tile3_sub2;3wt_tile4_sub2;3wt_tile5_sub2;3wt_tile6_sub2;3wt_tile7_sub2;3wt_tile8_sub2                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                             |
| bsmbi_3wt_tile1_sub3  | 1728        | BsmBI       | 3wt_tile1_sub3;3wt_tile2_sub3;3wt_tile3_sub3;3wt_tile4_sub3;3wt_tile5_sub3;3wt_tile6_sub3;3wt_tile7_sub3;3wt_tile8_sub3;3wt_tile9_sub2;3wt_tile10_sub2;3wt_tile11_sub2;3wt_tile12_sub2;3wt_tile13_sub2;3wt_tile14_sub2;3wt_tile15_sub2;3wt_tile16_sub2;3wt_tile17_sub2;3wt_tile18_sub2                                                                                                                                                                                                                                                                                                                                              |
| bsmbi_3wt_tile1_sub4  | 1688        | BsmBI       | 3wt_polIII_tile1_sub4;3wt_polIII_tile2_sub4;3wt_polIII_tile3_sub4;3wt_polIII_tile4_sub4;3wt_polIII_tile5_sub4;3wt_polIII_tile6_sub4;3wt_polIII_tile7_sub4;3wt_polIII_tile8_sub4;3wt_polIII_tile9_sub3;3wt_polIII_tile10_sub3;3wt_polIII_tile11_sub3;3wt_polIII_tile12_sub3;3wt_polIII_tile13_sub3;3wt_polIII_tile14_sub3;3wt_polIII_tile15_sub3;3wt_polIII_tile16_sub3;3wt_polIII_tile17_sub3;3wt_polIII_tile18_sub3;3wt_polIII_tile19_sub2;3wt_polIII_tile20_sub2;3wt_polIII_tile21_sub2;3wt_polIII_tile22_sub2;3wt_polIII_tile23_sub2;3wt_polIII_tile24_sub2;3wt_polIII_tile25_sub2;3wt_polIII_tile26_sub2;3wt_polIII_tile27_sub2 |
| bsmbi_3wt_tile10_sub1 | 1569        | BsmBI       | 3wt_tile10_sub1                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                     |
| bsmbi_3wt_tile11_sub1 | 1389        | BsmBI       | 3wt_tile11_sub1                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                     |
| bsmbi_3wt_tile12_sub1 | 1182        | BsmBI       | 3wt_tile12_sub1                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                     |
| bsmbi_3wt_tile13_sub1 | 1038        | BsmBI       | 3wt_tile13_sub1                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                     |
| bsmbi_3wt_tile14_sub1 | 846         | BsmBI       | 3wt_tile14_sub1                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                     |
| bsmbi_3wt_tile15_sub1 | 657         | BsmBI       | 3wt_tile15_sub1                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                     |
| bsmbi_3wt_tile16_sub1 | 525         | BsmBI       | 3wt_tile16_sub1                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                     |
| bsmbi_3wt_tile17_sub1 | 315         | BsmBI       | 3wt_tile17_sub1                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                     |
| bsmbi_3wt_tile18_sub1 | 171         | BsmBI       | 3wt_tile18_sub1                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                     |
| bsmbi_3wt_tile19_sub1 | 1746        | BsmBI       | 3wt_tile19_sub1                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                     |
| bsmbi_3wt_tile2_sub1  | 1362        | BsmBI       | 3wt_tile2_sub1                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                      |
| bsmbi_3wt_tile20_sub1 | 1551        | BsmBI       | 3wt_tile20_sub1                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                     |
| bsmbi_3wt_tile21_sub1 | 1404        | BsmBI       | 3wt_tile21_sub1                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                     |
| bsmbi_3wt_tile22_sub1 | 1191        | BsmBI       | 3wt_tile22_sub1                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                     |
| bsmbi_3wt_tile23_sub1 | 1035        | BsmBI       | 3wt_tile23_sub1                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                     |
| bsmbi_3wt_tile24_sub1 | 834         | BsmBI       | 3wt_tile24_sub1                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                     |
| bsmbi_3wt_tile25_sub1 | 639         | BsmBI       | 3wt_tile25_sub1                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                     |
| bsmbi_3wt_tile26_sub1 | 426         | BsmBI       | 3wt_tile26_sub1                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                     |
| bsmbi_3wt_tile27_sub1 | 240         | BsmBI       | 3wt_tile27_sub1                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                     |
| bsmbi_3wt_tile28      | 1706        | BsmBI       | 3wt_polIII_tile28                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                   |
| bsmbi_3wt_tile29      | 1496        | BsmBI       | 3wt_polIII_tile29                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                   |
| bsmbi_3wt_tile3_sub1  | 1158        | BsmBI       | 3wt_tile3_sub1                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                      |
| bsmbi_3wt_tile30      | 1313        | BsmBI       | 3wt_polIII_tile30                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                   |
| bsmbi_3wt_tile4_sub1  | 969         | BsmBI       | 3wt_tile4_sub1                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                      |
| bsmbi_3wt_tile5_sub1  | 765         | BsmBI       | 3wt_tile5_sub1                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                      |
| bsmbi_3wt_tile6_sub1  | 564         | BsmBI       | 3wt_tile6_sub1                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                      |
| bsmbi_3wt_tile7_sub1  | 369         | BsmBI       | 3wt_tile7_sub1                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                      |
| bsmbi_3wt_tile8_sub1  | 165         | BsmBI       | 3wt_tile8_sub1                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                      |
| bsmbi_3wt_tile9_sub1  | 1764        | BsmBI       | 3wt_tile9_sub1                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                      |
| bsmbi_polIII_tile31   | 1091        | BsmBI       | polIII_tile31                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                       |

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

