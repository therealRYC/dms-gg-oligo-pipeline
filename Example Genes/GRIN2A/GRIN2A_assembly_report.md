# DMS-GG Assembly Report: GRIN2A

Generated: 2026-03-21 08:12:31
Pipeline: dms-gg-oligo-pipeline (3-Enzyme Architecture: BsaI + BsmBI + PaqCI)

---

## 1. Gene Summary

| Property             | Value                                                                          |
| -------------------- | ------------------------------------------------------------------------------ |
| Gene name            | GRIN2A_NM_000833.5 Human GRIN2A native CDS (NM_000833.5, NP_000824.1, 1464 aa) |
| CDS length           | 4395 nt (1465 codons)                                                          |
| Protein length       | 1464 aa                                                                        |
| Number of tiles      | 26                                                                             |
| Total variants       | 30723                                                                          |
| Total oligos         | 307230                                                                         |
| Oligo length range   | 139-294 nt                                                                     |
| Gene blocks to order | 53                                                                             |
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

**Total oligos:** 307230 | **Length range:** 139-294 nt

| Tile | Codons    | Oligos | Length |
| ---- | --------- | ------ | ------ |
| 1    | 1-78      | 15540  | 294 nt |
| 2    | 73-139    | 12810  | 257 nt |
| 3    | 134-207   | 14280  | 278 nt |
| 4    | 202-278   | 14910  | 287 nt |
| 5    | 273-305   | 5670   | 155 nt |
| 6    | 300-376   | 14910  | 287 nt |
| 7    | 371-447   | 14910  | 287 nt |
| 8    | 442-519   | 15120  | 290 nt |
| 9    | 514-547   | 5880   | 158 nt |
| 10   | 542-592   | 9450   | 209 nt |
| 11   | 587-660   | 14280  | 278 nt |
| 12   | 655-728   | 14280  | 278 nt |
| 13   | 723-796   | 14280  | 278 nt |
| 14   | 791-868   | 15120  | 290 nt |
| 15   | 863-905   | 7770   | 185 nt |
| 16   | 900-949   | 9240   | 206 nt |
| 17   | 944-986   | 7770   | 185 nt |
| 18   | 981-1054  | 14280  | 278 nt |
| 19   | 1049-1124 | 14700  | 284 nt |
| 20   | 1119-1193 | 14490  | 281 nt |
| 21   | 1188-1224 | 6510   | 167 nt |
| 22   | 1219-1291 | 14070  | 275 nt |
| 23   | 1286-1343 | 10920  | 230 nt |
| 24   | 1338-1387 | 9240   | 206 nt |
| 25   | 1382-1459 | 15120  | 290 nt |
| 26   | 1454-1480 | 1680   | 139 nt |

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
| Total barcodes    | 307230                             |
| Unique barcodes   | 307230                             |
| GC content range  | 35% - 65%                          |
| GC content mean   | 48.4%                              |
| Hamming guarantee | 100% cross-variant (prefix d >= 3) |

## 5. QC Summary

**Overall:** ISSUES FOUND

| Check                   | Description                                                   | Result | Detail                                                                                                                       |
| ----------------------- | ------------------------------------------------------------- | ------ | ---------------------------------------------------------------------------------------------------------------------------- |
| oligo_lengths           | All oligos within synthesis length limit                      | PASS   | Range: 139-294 nt (limit: 300)                                                                                               |
| block_lengths           | All gene blocks within synthesis length limit                 | FAIL   | Range: 220-1806 nt (limit: 1800)                                                                                             |
| barcode_junction_sites  | No enzyme sites at barcode-context junctions                  | PASS   | 0 barcode(s) with junction enzyme sites (left='CACACC', right='AGAATG')                                                      |
| barcode_uniqueness      | All barcodes are unique                                       | PASS   | 307230 unique / 307230 total                                                                                                 |
| tile_coverage           | Tiles cover entire gene without gaps                          | PASS   | 4395 / 4395 nt covered                                                                                                       |
| variant_count           | Expected number of variants generated                         | PASS   | 30723 unique variants (expected: 30723 across 1463/1463 mutable positions; 27797 missense + 1463 nonsense + 1463 wt_control) |
| single_codon_change     | Each non-control variant differs by exactly one codon from WT | PASS   | 292600 / 292600 variants confirmed (WT controls excluded)                                                                    |
| oligo_gc_content        | Oligo GC content within reasonable range (25-75%)             | PASS   | GC range: 37.4-66.3% | 0 oligo(s) with extreme GC                                                                            |
| domestication_complete  | Gene domesticated for all 3 enzymes (BsaI, BsmBI, PaqCI)      | PASS   | No enzyme sites in gene                                                                                                      |
| overhang_fidelity       | Tile boundary overhangs have adequate fidelity                | FAIL   | 25 tile(s) with low-fidelity boundary overhangs (<0.80)                                                                      |
| tile_manifests          | Per-tile assembly manifests complete                          | PASS   | 26 tile manifest(s) generated                                                                                                |
| helper_plasmid          | Helper plasmid free of unintended BsmBI sites                 | PASS   | OK                                                                                                                           |
| reaction_fidelity       | Per-reaction set-level overhang fidelity                      | PASS   | Min set fidelity: 0.9943 across 52 reactions | 0 reaction(s) below 0.90                                                      |
| barcode_poliii_term     | No barcodes contain PolIII terminator signal (TTTT)           | PASS   | 0 / 307230 barcode(s) contain TTTT                                                                                           |
| barcode_hairpins        | No barcodes have hairpin stems > 3 bp                         | PASS   | 0 / 307230 barcode(s) have hairpin stems > 3 bp                                                                              |
| barcode_dinuc_repeats   | No barcodes have dinucleotide repeats > 4 units               | PASS   | 0 / 307230 barcode(s) exceed 4 dinuc repeat units                                                                            |
| barcode_tm_distribution | Barcode Tm distribution (informational)                       | PASS   | Tm: median=53.3, range=[41.6, 65.1], sd=4 C                                                                                  |
| block_min_length        | All gene blocks above synthesis minimum length                | FAIL   | 3 block(s) below 300 nt minimum. Range: 220-1806 nt                                                                          |
| sb_overhang_collisions  | Superblock boundary overhangs are unique (no collisions)      | PASS   | 6 SB boundary OH(s), all unique                                                                                              |

## 5b. Reaction Fidelity Summary

Set fidelity for each tile's BsaI and BsmBI reactions,
computed from the actual block overhangs after construction:

| Tile | BsaI OHs | BsaI Set Fidelity | BsmBI OHs | BsmBI Set Fidelity |
| ---- | -------- | ----------------- | --------- | ------------------ |
| 1    | 2        | 1.0000            | 5         | 1.0000             |
| 2    | 3        | 1.0000            | 5         | 1.0000             |
| 3    | 3        | 1.0000            | 5         | 0.9983             |
| 4    | 3        | 1.0000            | 5         | 1.0000             |
| 5    | 3        | 1.0000            | 5         | 1.0000             |
| 6    | 3        | 1.0000            | 5         | 0.9988             |
| 7    | 3        | 1.0000            | 5         | 0.9943             |
| 8    | 3        | 1.0000            | 4         | 1.0000             |
| 9    | 3        | 1.0000            | 4         | 1.0000             |
| 10   | 3        | 1.0000            | 4         | 1.0000             |
| 11   | 3        | 1.0000            | 4         | 1.0000             |
| 12   | 4        | 1.0000            | 4         | 1.0000             |
| 13   | 4        | 1.0000            | 4         | 1.0000             |
| 14   | 4        | 1.0000            | 4         | 0.9986             |
| 15   | 4        | 1.0000            | 3         | 0.9988             |
| 16   | 4        | 1.0000            | 3         | 1.0000             |
| 17   | 4        | 1.0000            | 3         | 1.0000             |
| 18   | 4        | 1.0000            | 3         | 1.0000             |
| 19   | 5        | 1.0000            | 3         | 1.0000             |
| 20   | 5        | 1.0000            | 3         | 1.0000             |
| 21   | 5        | 1.0000            | 3         | 1.0000             |
| 22   | 5        | 1.0000            | 3         | 0.9988             |
| 23   | 5        | 1.0000            | 3         | 1.0000             |
| 24   | 5        | 1.0000            | 2         | 1.0000             |
| 25   | 5        | 1.0000            | 2         | 1.0000             |
| 26   | 5        | 1.0000            | 2         | 1.0000             |

**Min:** 0.9943 | **Max:** 1.0000 | **Mean:** 0.9998

### 5c. Borderline Overhang Pairs

The following overhang pairs are at exactly the max_identity threshold (2/4). They are compatible but represent the tightest margin before collision:

| Tile | Reaction | OH A | OH B            | Identity | Type   |
| ---- | -------- | ---- | --------------- | -------- | ------ |
| 1    | BsaI     | AAGA | AGAA            | 2/4      | direct |
| 1    | BsmBI    | CACC | CGAC            | 2/4      | direct |
| 1    | BsmBI    | GAAA | CTTT (RC: AAAG) | 2/4      | RC     |
| 2    | BsaI     | AAGA | AGAA            | 2/4      | direct |
| 2    | BsaI     | AAGA | CTGA            | 2/4      | direct |
| 2    | BsmBI    | CACC | GGAT (RC: ATCC) | 2/4      | RC     |
| 2    | BsmBI    | GGAT | GAAA            | 2/4      | direct |
| 2    | BsmBI    | GAAA | CTTT (RC: AAAG) | 2/4      | RC     |
| 3    | BsaI     | AAGA | AGAA            | 2/4      | direct |
| 3    | BsaI     | AAGA | ATCA            | 2/4      | direct |
| 3    | BsaI     | AGAA | ATCA            | 2/4      | direct |
| 3    | BsaI     | AGAA | ATCA (RC: TGAT) | 2/4      | RC     |
| 3    | BsmBI    | CACC | GGAC (RC: GTCC) | 2/4      | RC     |
| 3    | BsmBI    | GGAC | GAAA            | 2/4      | direct |
| 3    | BsmBI    | GAAA | CTTT (RC: AAAG) | 2/4      | RC     |
| 4    | BsaI     | AAGA | AGAA            | 2/4      | direct |
| 4    | BsaI     | AAGA | AATG            | 2/4      | direct |
| 4    | BsmBI    | TTCT | GAAA (RC: TTTC) | 2/4      | RC     |
| 4    | BsmBI    | TTCT | CTTT            | 2/4      | direct |
| 4    | BsmBI    | TTCT | TAGT            | 2/4      | direct |
| 4    | BsmBI    | GAAA | CTTT (RC: AAAG) | 2/4      | RC     |
| 5    | BsaI     | AAGA | AGAA            | 2/4      | direct |
| 5    | BsaI     | AAGA | CCAT (RC: ATGG) | 2/4      | RC     |
| 5    | BsmBI    | TTCT | GAAA (RC: TTTC) | 2/4      | RC     |
| 5    | BsmBI    | TTCT | CTTT            | 2/4      | direct |
| 5    | BsmBI    | TTCT | TAGT            | 2/4      | direct |
| 5    | BsmBI    | GAAA | CTTT (RC: AAAG) | 2/4      | RC     |
| 6    | BsaI     | AAGA | AGAA            | 2/4      | direct |
| 6    | BsaI     | AAGA | ACCA            | 2/4      | direct |
| 6    | BsaI     | AGAA | ACCA            | 2/4      | direct |
| 6    | BsmBI    | CACC | GGGC (RC: GCCC) | 2/4      | RC     |
| 6    | BsmBI    | GAAA | CTTT (RC: AAAG) | 2/4      | RC     |
| 7    | BsaI     | AAGA | AGAA            | 2/4      | direct |
| 7    | BsmBI    | CACC | CAAT            | 2/4      | direct |
| 7    | BsmBI    | CAAT | GAAA            | 2/4      | direct |
| 7    | BsmBI    | CAAT | CTTT            | 2/4      | direct |
| 7    | BsmBI    | CAAT | CTTT (RC: AAAG) | 2/4      | RC     |
| 7    | BsmBI    | CAAT | TAGT            | 2/4      | direct |
| 7    | BsmBI    | GAAA | CTTT (RC: AAAG) | 2/4      | RC     |
| 8    | BsaI     | AAGA | AGAA            | 2/4      | direct |
| 8    | BsaI     | AAGA | ATCA            | 2/4      | direct |
| 8    | BsaI     | AGAA | ATCA            | 2/4      | direct |
| 8    | BsaI     | AGAA | ATCA (RC: TGAT) | 2/4      | RC     |
| 8    | BsmBI    | TTCT | CTTT            | 2/4      | direct |
| 8    | BsmBI    | TTCT | TAGT            | 2/4      | direct |
| 9    | BsaI     | AAGA | AGAA            | 2/4      | direct |
| 9    | BsaI     | AAGA | ATCA            | 2/4      | direct |
| 9    | BsaI     | AGAA | ATCA            | 2/4      | direct |
| 9    | BsaI     | AGAA | ATCA (RC: TGAT) | 2/4      | RC     |
| 9    | BsmBI    | TTCT | CTTT            | 2/4      | direct |
| 9    | BsmBI    | TTCT | TAGT            | 2/4      | direct |
| 10   | BsaI     | AAGA | AGAA            | 2/4      | direct |
| 10   | BsaI     | AGAA | GGCA            | 2/4      | direct |
| 10   | BsmBI    | GAAA | CTTT (RC: AAAG) | 2/4      | RC     |
| 11   | BsaI     | AAGA | AGAA            | 2/4      | direct |
| 11   | BsaI     | AAGA | AACT            | 2/4      | direct |
| 11   | BsaI     | AGAA | AACT (RC: AGTT) | 2/4      | RC     |
| 11   | BsmBI    | CACC | GGAC (RC: GTCC) | 2/4      | RC     |
| 12   | BsaI     | AAGA | AGAA            | 2/4      | direct |
| 12   | BsaI     | AAGA | GAAA            | 2/4      | direct |
| 12   | BsaI     | AGAA | GAAA            | 2/4      | direct |
| 12   | BsaI     | GAAA | CAAG            | 2/4      | direct |
| 12   | BsmBI    | TTTC | CTTT            | 2/4      | direct |
| 13   | BsaI     | AAGA | AGAA            | 2/4      | direct |
| 13   | BsaI     | AAGA | GAAA            | 2/4      | direct |
| 13   | BsaI     | AAGA | GGGA            | 2/4      | direct |
| 13   | BsaI     | AGAA | GAAA            | 2/4      | direct |
| 13   | BsaI     | AGAA | GGGA            | 2/4      | direct |
| 13   | BsaI     | GAAA | GGGA            | 2/4      | direct |
| 13   | BsmBI    | CACC | GCTC (RC: GAGC) | 2/4      | RC     |
| 13   | BsmBI    | GCTC | TAGT (RC: ACTA) | 2/4      | RC     |
| 14   | BsaI     | AAGA | AGAA            | 2/4      | direct |
| 14   | BsaI     | AAGA | GAAA            | 2/4      | direct |
| 14   | BsaI     | AGAA | GAAA            | 2/4      | direct |
| 14   | BsmBI    | CACC | CTAC            | 2/4      | direct |
| 14   | BsmBI    | CTAC | CTTT            | 2/4      | direct |
| 15   | BsaI     | AAGA | AGAA            | 2/4      | direct |
| 15   | BsaI     | AAGA | GAAA            | 2/4      | direct |
| 15   | BsaI     | AAGA | ATCA            | 2/4      | direct |
| 15   | BsaI     | AGAA | GAAA            | 2/4      | direct |
| 15   | BsaI     | AGAA | ATCA            | 2/4      | direct |
| 15   | BsaI     | AGAA | ATCA (RC: TGAT) | 2/4      | RC     |
| 15   | BsmBI    | CACC | TTCC            | 2/4      | direct |
| 16   | BsaI     | AAGA | AGAA            | 2/4      | direct |
| 16   | BsaI     | AAGA | GAAA            | 2/4      | direct |
| 16   | BsaI     | AAGA | TCAG (RC: CTGA) | 2/4      | RC     |
| 16   | BsaI     | AGAA | GAAA            | 2/4      | direct |
| 17   | BsaI     | AAGA | AGAA            | 2/4      | direct |
| 17   | BsaI     | AAGA | GAAA            | 2/4      | direct |
| 17   | BsaI     | AAGA | TCAG (RC: CTGA) | 2/4      | RC     |
| 17   | BsaI     | AGAA | GAAA            | 2/4      | direct |
| 17   | BsmBI    | TCTT | TAGT            | 2/4      | direct |
| 17   | BsmBI    | TCTT | TAGT (RC: ACTA) | 2/4      | RC     |
| 18   | BsaI     | AAGA | AGAA            | 2/4      | direct |
| 18   | BsaI     | AAGA | GAAA            | 2/4      | direct |
| 18   | BsaI     | AAGA | CAGG            | 2/4      | direct |
| 18   | BsaI     | AGAA | GAAA            | 2/4      | direct |
| 18   | BsmBI    | AGAA | TAGT (RC: ACTA) | 2/4      | RC     |
| 19   | BsaI     | AAGA | AGAA            | 2/4      | direct |
| 19   | BsaI     | AAGA | GAAA            | 2/4      | direct |
| 19   | BsaI     | AAGA | CTTT (RC: AAAG) | 2/4      | RC     |
| 19   | BsaI     | AAGA | CCTA (RC: TAGG) | 2/4      | RC     |
| 19   | BsaI     | AGAA | GAAA            | 2/4      | direct |
| 19   | BsaI     | AGAA | CTTT (RC: AAAG) | 2/4      | RC     |
| 19   | BsaI     | GAAA | CTTT (RC: AAAG) | 2/4      | RC     |
| 19   | BsaI     | CTTT | CCTA            | 2/4      | direct |
| 19   | BsmBI    | CACC | GAAG (RC: CTTC) | 2/4      | RC     |
| 20   | BsaI     | AAGA | AGAA            | 2/4      | direct |
| 20   | BsaI     | AAGA | GAAA            | 2/4      | direct |
| 20   | BsaI     | AAGA | CTTT (RC: AAAG) | 2/4      | RC     |
| 20   | BsaI     | AAGA | ACTA            | 2/4      | direct |
| 20   | BsaI     | AAGA | ACTA (RC: TAGT) | 2/4      | RC     |
| 20   | BsaI     | AGAA | GAAA            | 2/4      | direct |
| 20   | BsaI     | AGAA | CTTT (RC: AAAG) | 2/4      | RC     |
| 20   | BsaI     | AGAA | ACTA            | 2/4      | direct |
| 20   | BsaI     | GAAA | CTTT (RC: AAAG) | 2/4      | RC     |
| 20   | BsmBI    | CACC | CTTG (RC: CAAG) | 2/4      | RC     |
| 21   | BsaI     | AAGA | AGAA            | 2/4      | direct |
| 21   | BsaI     | AAGA | GAAA            | 2/4      | direct |
| 21   | BsaI     | AAGA | CTTT (RC: AAAG) | 2/4      | RC     |
| 21   | BsaI     | AAGA | TCCA (RC: TGGA) | 2/4      | RC     |
| 21   | BsaI     | AGAA | GAAA            | 2/4      | direct |
| 21   | BsaI     | AGAA | CTTT (RC: AAAG) | 2/4      | RC     |
| 21   | BsaI     | AGAA | TCCA (RC: TGGA) | 2/4      | RC     |
| 21   | BsaI     | GAAA | CTTT (RC: AAAG) | 2/4      | RC     |
| 22   | BsaI     | AAGA | AGAA            | 2/4      | direct |
| 22   | BsaI     | AAGA | GAAA            | 2/4      | direct |
| 22   | BsaI     | AAGA | CTTT (RC: AAAG) | 2/4      | RC     |
| 22   | BsaI     | AAGA | TCCA (RC: TGGA) | 2/4      | RC     |
| 22   | BsaI     | AGAA | GAAA            | 2/4      | direct |
| 22   | BsaI     | AGAA | CTTT (RC: AAAG) | 2/4      | RC     |
| 22   | BsaI     | AGAA | TCCA (RC: TGGA) | 2/4      | RC     |
| 22   | BsaI     | GAAA | CTTT (RC: AAAG) | 2/4      | RC     |
| 22   | BsmBI    | CACC | TTCC            | 2/4      | direct |
| 23   | BsaI     | AAGA | AGAA            | 2/4      | direct |
| 23   | BsaI     | AAGA | GAAA            | 2/4      | direct |
| 23   | BsaI     | AAGA | CTTT (RC: AAAG) | 2/4      | RC     |
| 23   | BsaI     | AAGA | ATTA            | 2/4      | direct |
| 23   | BsaI     | AGAA | GAAA            | 2/4      | direct |
| 23   | BsaI     | AGAA | CTTT (RC: AAAG) | 2/4      | RC     |
| 23   | BsaI     | AGAA | ATTA            | 2/4      | direct |
| 23   | BsaI     | GAAA | CTTT (RC: AAAG) | 2/4      | RC     |
| 23   | BsaI     | GAAA | ATTA (RC: TAAT) | 2/4      | RC     |
| 23   | BsaI     | CTTT | ATTA            | 2/4      | direct |
| 23   | BsmBI    | CCTT | TAGT (RC: ACTA) | 2/4      | RC     |
| 24   | BsaI     | AAGA | AGAA            | 2/4      | direct |
| 24   | BsaI     | AAGA | GAAA            | 2/4      | direct |
| 24   | BsaI     | AAGA | CTTT (RC: AAAG) | 2/4      | RC     |
| 24   | BsaI     | AAGA | GGGA            | 2/4      | direct |
| 24   | BsaI     | AGAA | GAAA            | 2/4      | direct |
| 24   | BsaI     | AGAA | CTTT (RC: AAAG) | 2/4      | RC     |
| 24   | BsaI     | AGAA | GGGA            | 2/4      | direct |
| 24   | BsaI     | GAAA | CTTT (RC: AAAG) | 2/4      | RC     |
| 24   | BsaI     | GAAA | GGGA            | 2/4      | direct |
| 25   | BsaI     | AAGA | AGAA            | 2/4      | direct |
| 25   | BsaI     | AAGA | GAAA            | 2/4      | direct |
| 25   | BsaI     | AAGA | CTTT (RC: AAAG) | 2/4      | RC     |
| 25   | BsaI     | AGAA | GAAA            | 2/4      | direct |
| 25   | BsaI     | AGAA | CTTT (RC: AAAG) | 2/4      | RC     |
| 25   | BsaI     | AGAA | TGCC (RC: GGCA) | 2/4      | RC     |
| 25   | BsaI     | GAAA | CTTT (RC: AAAG) | 2/4      | RC     |
| 25   | BsaI     | GAAA | TGCC (RC: GGCA) | 2/4      | RC     |
| 26   | BsaI     | AAGA | AGAA            | 2/4      | direct |
| 26   | BsaI     | AAGA | GAAA            | 2/4      | direct |
| 26   | BsaI     | AAGA | CTTT (RC: AAAG) | 2/4      | RC     |
| 26   | BsaI     | AAGA | TACA            | 2/4      | direct |
| 26   | BsaI     | AGAA | GAAA            | 2/4      | direct |
| 26   | BsaI     | AGAA | CTTT (RC: AAAG) | 2/4      | RC     |
| 26   | BsaI     | AGAA | TACA (RC: TGTA) | 2/4      | RC     |
| 26   | BsaI     | GAAA | CTTT (RC: AAAG) | 2/4      | RC     |
| 26   | BsaI     | GAAA | TACA            | 2/4      | direct |

## 6. Fixed Overhangs & Helper Plasmid

These overhangs are the same across all tile reactions:

| Overhang    | Sequence | Role                                                    |
| ----------- | -------- | ------------------------------------------------------- |
| oh_L        | AAGA     | Gene start (BsaI, user-specified, upstream of ATG)      |
| oh3         | CACC     | Downstream cassette-barcode junction (BsmBI, all tiles) |
| oh4         | AGAA     | Barcode-helper junction (BsaI, all tiles)               |
| paqci_star2 | auto     | PaqCI 5' end of insert (Level 2)                        |
| paqci_star1 | auto     | PaqCI 3' end of insert (Level 2)                        |

### Helper Plasmid Insert

The helper plasmid provides the backbone for each BsaI Level 1 reaction.

```
[PaqCI**]--[BsaI>>AAGA]--STUFFER--[AGAA<<BsaI]--[PaqCI*]
```

Insert length: 72 nt
oh_L = AAGA (user-specified, upstream of ATG)
oh_R = AGAA (= oh4, barcode-helper junction)
upstream_cassette = (none)

## 7. Per-Tile Assembly Guide

### Tile 1 of 26 -- Codons 1-78 (234 nt)

**Boundary overhangs:**

| Position          | Sequence | Fidelity |
| ----------------- | -------- | -------- |
| oh1 (5' boundary) | AAGA     | 0.9209   |
| oh2 (3' boundary) | CGAC     | 0.4695   |

**Variants:** 15540 mutations, 15540 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name                          | Length | 5' OH | 3' OH |
| --- | --------------- | ---------------------------------- | ------ | ----- | ----- |
| 1   | 5'WT gene block | (none -- tile starts at gene nt 1) | --     | --    | --    |
| 2   | Oligo pool      | Tile 1 (15540 oligos)              | 294 nt | AAGA  | AGAA  |
| 3   | Helper plasmid  | helper_plasmid_insert              | --     | --    | --    |
| 4   | Enzyme + buffer | BsaI-HFv2 + CutSmart               | --     | --    | --    |

```
  [AAGA]----oligo+BC----[AGAA]
   AAGA                  AGAA 
```

**Set fidelity:** 1.0000 (2 overhangs)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------ | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)      | --      | --    | --    |
| 2   | 3'WT block        | bsmbi_3wt_tile1_sub1     | 1572 nt | CGAC  | GAAA  |
| 3   | 3'WT block        | bsmbi_3wt_tile1_sub2     | 1101 nt | GAAA  | CTTT  |
| 4   | 3'WT block        | bsmbi_3wt_tile1_sub3     | 1560 nt | CTTT  | TAGT  |
| 5   | 3'WT+PolIII block | bsmbi_3wt_tile1_sub4     | 1142 nt | TAGT  | CACC  |
| 6   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1 | --      | --    | --    |

```
  [CGAC]----3'WT sub1----[GAAA]----3'WT sub2----[CTTT]----3'WT sub3----[TAGT]----3'WT+PolIII sub4----[CACC]
   CGAC                   GAAA                   CTTT                   TAGT                          CACC 
```

**Set fidelity:** 1.0000 (5 overhangs)

---

### Tile 2 of 26 -- Codons 73-139 (201 nt)

**Boundary overhangs:**

| Position          | Sequence | Fidelity |
| ----------------- | -------- | -------- |
| oh1 (5' boundary) | CTGA     | 0.6791   |
| oh2 (3' boundary) | GGAT     | 0.5385   |

**Variants:** 12810 mutations, 12810 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name             | Length | 5' OH | 3' OH |
| --- | --------------- | --------------------- | ------ | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile2        | 250 nt | AAGA  | CTGA  |
| 2   | Oligo pool      | Tile 2 (12810 oligos) | 257 nt | CTGA  | AGAA  |
| 3   | Helper plasmid  | helper_plasmid_insert | --     | --    | --    |
| 4   | Enzyme + buffer | BsaI-HFv2 + CutSmart  | --     | --    | --    |

```
  [AAGA]----5'WT block----[CTGA]----oligo+BC----[AGAA]
   AAGA                    CTGA                  AGAA 
```

**Set fidelity:** 1.0000 (3 overhangs)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------ | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)      | --      | --    | --    |
| 2   | 3'WT block        | bsmbi_3wt_tile2_sub1     | 1389 nt | GGAT  | GAAA  |
| 3   | 3'WT block        | bsmbi_3wt_tile1_sub2     | 1101 nt | GAAA  | CTTT  |
| 4   | 3'WT block        | bsmbi_3wt_tile1_sub3     | 1560 nt | CTTT  | TAGT  |
| 5   | 3'WT+PolIII block | bsmbi_3wt_tile1_sub4     | 1142 nt | TAGT  | CACC  |
| 6   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1 | --      | --    | --    |

```
  [GGAT]----3'WT sub1----[GAAA]----3'WT sub2----[CTTT]----3'WT sub3----[TAGT]----3'WT+PolIII sub4----[CACC]
   GGAT                   GAAA                   CTTT                   TAGT                          CACC 
```

**Set fidelity:** 1.0000 (5 overhangs)

---

### Tile 3 of 26 -- Codons 134-207 (222 nt)

**Boundary overhangs:**

| Position          | Sequence | Fidelity |
| ----------------- | -------- | -------- |
| oh1 (5' boundary) | ATCA     | 0.7483   |
| oh2 (3' boundary) | GGAC     | 0.5754   |

**Variants:** 14280 mutations, 14280 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name             | Length | 5' OH | 3' OH |
| --- | --------------- | --------------------- | ------ | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile3        | 433 nt | AAGA  | ATCA  |
| 2   | Oligo pool      | Tile 3 (14280 oligos) | 278 nt | ATCA  | AGAA  |
| 3   | Helper plasmid  | helper_plasmid_insert | --     | --    | --    |
| 4   | Enzyme + buffer | BsaI-HFv2 + CutSmart  | --     | --    | --    |

```
  [AAGA]----5'WT block----[ATCA]----oligo+BC----[AGAA]
   AAGA                    ATCA                  AGAA 
```

**Set fidelity:** 1.0000 (3 overhangs)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------ | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)      | --      | --    | --    |
| 2   | 3'WT block        | bsmbi_3wt_tile3_sub1     | 1185 nt | GGAC  | GAAA  |
| 3   | 3'WT block        | bsmbi_3wt_tile1_sub2     | 1101 nt | GAAA  | CTTT  |
| 4   | 3'WT block        | bsmbi_3wt_tile1_sub3     | 1560 nt | CTTT  | TAGT  |
| 5   | 3'WT+PolIII block | bsmbi_3wt_tile1_sub4     | 1142 nt | TAGT  | CACC  |
| 6   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1 | --      | --    | --    |

```
  [GGAC]----3'WT sub1----[GAAA]----3'WT sub2----[CTTT]----3'WT sub3----[TAGT]----3'WT+PolIII sub4----[CACC]
   GGAC                   GAAA                   CTTT                   TAGT                          CACC 
```

**Set fidelity:** 0.9983 (5 overhangs)

---

### Tile 4 of 26 -- Codons 202-278 (231 nt)

**Boundary overhangs:**

| Position          | Sequence | Fidelity |
| ----------------- | -------- | -------- |
| oh1 (5' boundary) | AATG     | 0.6412   |
| oh2 (3' boundary) | TTCT     | 0.8181   |

**Variants:** 14910 mutations, 14910 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name             | Length | 5' OH | 3' OH |
| --- | --------------- | --------------------- | ------ | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile4        | 637 nt | AAGA  | AATG  |
| 2   | Oligo pool      | Tile 4 (14910 oligos) | 287 nt | AATG  | AGAA  |
| 3   | Helper plasmid  | helper_plasmid_insert | --     | --    | --    |
| 4   | Enzyme + buffer | BsaI-HFv2 + CutSmart  | --     | --    | --    |

```
  [AAGA]----5'WT block----[AATG]----oligo+BC----[AGAA]
   AAGA                    AATG                  AGAA 
```

**Set fidelity:** 1.0000 (3 overhangs)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------ | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)      | --      | --    | --    |
| 2   | 3'WT block        | bsmbi_3wt_tile4_sub1     | 972 nt  | TTCT  | GAAA  |
| 3   | 3'WT block        | bsmbi_3wt_tile1_sub2     | 1101 nt | GAAA  | CTTT  |
| 4   | 3'WT block        | bsmbi_3wt_tile1_sub3     | 1560 nt | CTTT  | TAGT  |
| 5   | 3'WT+PolIII block | bsmbi_3wt_tile1_sub4     | 1142 nt | TAGT  | CACC  |
| 6   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1 | --      | --    | --    |

```
  [TTCT]----3'WT sub1----[GAAA]----3'WT sub2----[CTTT]----3'WT sub3----[TAGT]----3'WT+PolIII sub4----[CACC]
   TTCT                   GAAA                   CTTT                   TAGT                          CACC 
```

**Set fidelity:** 1.0000 (5 overhangs)

---

### Tile 5 of 26 -- Codons 273-305 (99 nt)

**Boundary overhangs:**

| Position          | Sequence | Fidelity |
| ----------------- | -------- | -------- |
| oh1 (5' boundary) | CCAT     | 0.6470   |
| oh2 (3' boundary) | TTCT     | 0.8181   |

**Variants:** 5670 mutations, 5670 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name             | Length | 5' OH | 3' OH |
| --- | --------------- | --------------------- | ------ | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile5        | 850 nt | AAGA  | CCAT  |
| 2   | Oligo pool      | Tile 5 (5670 oligos)  | 155 nt | CCAT  | AGAA  |
| 3   | Helper plasmid  | helper_plasmid_insert | --     | --    | --    |
| 4   | Enzyme + buffer | BsaI-HFv2 + CutSmart  | --     | --    | --    |

```
  [AAGA]----5'WT block----[CCAT]----oligo+BC----[AGAA]
   AAGA                    CCAT                  AGAA 
```

**Set fidelity:** 1.0000 (3 overhangs)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------ | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)      | --      | --    | --    |
| 2   | 3'WT block        | bsmbi_3wt_tile5_sub1     | 891 nt  | TTCT  | GAAA  |
| 3   | 3'WT block        | bsmbi_3wt_tile1_sub2     | 1101 nt | GAAA  | CTTT  |
| 4   | 3'WT block        | bsmbi_3wt_tile1_sub3     | 1560 nt | CTTT  | TAGT  |
| 5   | 3'WT+PolIII block | bsmbi_3wt_tile1_sub4     | 1142 nt | TAGT  | CACC  |
| 6   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1 | --      | --    | --    |

```
  [TTCT]----3'WT sub1----[GAAA]----3'WT sub2----[CTTT]----3'WT sub3----[TAGT]----3'WT+PolIII sub4----[CACC]
   TTCT                   GAAA                   CTTT                   TAGT                          CACC 
```

**Set fidelity:** 1.0000 (5 overhangs)

---

### Tile 6 of 26 -- Codons 300-376 (231 nt)

**Boundary overhangs:**

| Position          | Sequence | Fidelity |
| ----------------- | -------- | -------- |
| oh1 (5' boundary) | ACCA     | 0.7200   |
| oh2 (3' boundary) | GGGC     | 0.4951   |

**Variants:** 14910 mutations, 14910 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name             | Length | 5' OH | 3' OH |
| --- | --------------- | --------------------- | ------ | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile6        | 931 nt | AAGA  | ACCA  |
| 2   | Oligo pool      | Tile 6 (14910 oligos) | 287 nt | ACCA  | AGAA  |
| 3   | Helper plasmid  | helper_plasmid_insert | --     | --    | --    |
| 4   | Enzyme + buffer | BsaI-HFv2 + CutSmart  | --     | --    | --    |

```
  [AAGA]----5'WT block----[ACCA]----oligo+BC----[AGAA]
   AAGA                    ACCA                  AGAA 
```

**Set fidelity:** 1.0000 (3 overhangs)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------ | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)      | --      | --    | --    |
| 2   | 3'WT block        | bsmbi_3wt_tile6_sub1     | 678 nt  | GGGC  | GAAA  |
| 3   | 3'WT block        | bsmbi_3wt_tile1_sub2     | 1101 nt | GAAA  | CTTT  |
| 4   | 3'WT block        | bsmbi_3wt_tile1_sub3     | 1560 nt | CTTT  | TAGT  |
| 5   | 3'WT+PolIII block | bsmbi_3wt_tile1_sub4     | 1142 nt | TAGT  | CACC  |
| 6   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1 | --      | --    | --    |

```
  [GGGC]----3'WT sub1----[GAAA]----3'WT sub2----[CTTT]----3'WT sub3----[TAGT]----3'WT+PolIII sub4----[CACC]
   GGGC                   GAAA                   CTTT                   TAGT                          CACC 
```

**Set fidelity:** 0.9988 (5 overhangs)

---

### Tile 7 of 26 -- Codons 371-447 (231 nt)

**Boundary overhangs:**

| Position          | Sequence | Fidelity |
| ----------------- | -------- | -------- |
| oh1 (5' boundary) | GAAT     | 0.7246   |
| oh2 (3' boundary) | CAAT     | 0.7361   |

**Variants:** 14910 mutations, 14910 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name             | Length  | 5' OH | 3' OH |
| --- | --------------- | --------------------- | ------- | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile7        | 1144 nt | AAGA  | GAAT  |
| 2   | Oligo pool      | Tile 7 (14910 oligos) | 287 nt  | GAAT  | AGAA  |
| 3   | Helper plasmid  | helper_plasmid_insert | --      | --    | --    |
| 4   | Enzyme + buffer | BsaI-HFv2 + CutSmart  | --      | --    | --    |

```
  [AAGA]----5'WT block----[GAAT]----oligo+BC----[AGAA]
   AAGA                    GAAT                  AGAA 
```

**Set fidelity:** 1.0000 (3 overhangs)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------ | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)      | --      | --    | --    |
| 2   | 3'WT block        | bsmbi_3wt_tile7_sub1     | 465 nt  | CAAT  | GAAA  |
| 3   | 3'WT block        | bsmbi_3wt_tile1_sub2     | 1101 nt | GAAA  | CTTT  |
| 4   | 3'WT block        | bsmbi_3wt_tile1_sub3     | 1560 nt | CTTT  | TAGT  |
| 5   | 3'WT+PolIII block | bsmbi_3wt_tile1_sub4     | 1142 nt | TAGT  | CACC  |
| 6   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1 | --      | --    | --    |

```
  [CAAT]----3'WT sub1----[GAAA]----3'WT sub2----[CTTT]----3'WT sub3----[TAGT]----3'WT+PolIII sub4----[CACC]
   CAAT                   GAAA                   CTTT                   TAGT                          CACC 
```

**Set fidelity:** 0.9943 (5 overhangs)

---

### Tile 8 of 26 -- Codons 442-519 (234 nt)

**Boundary overhangs:**

| Position          | Sequence | Fidelity |
| ----------------- | -------- | -------- |
| oh1 (5' boundary) | ATCA     | 0.7483   |
| oh2 (3' boundary) | TTCT     | 0.8181   |

**Variants:** 15120 mutations, 15120 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name             | Length  | 5' OH | 3' OH |
| --- | --------------- | --------------------- | ------- | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile8        | 1357 nt | AAGA  | ATCA  |
| 2   | Oligo pool      | Tile 8 (15120 oligos) | 290 nt  | ATCA  | AGAA  |
| 3   | Helper plasmid  | helper_plasmid_insert | --      | --    | --    |
| 4   | Enzyme + buffer | BsaI-HFv2 + CutSmart  | --      | --    | --    |

```
  [AAGA]----5'WT block----[ATCA]----oligo+BC----[AGAA]
   AAGA                    ATCA                  AGAA 
```

**Set fidelity:** 1.0000 (3 overhangs)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------ | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)      | --      | --    | --    |
| 2   | 3'WT block        | bsmbi_3wt_tile8_sub1     | 1320 nt | TTCT  | CTTT  |
| 3   | 3'WT block        | bsmbi_3wt_tile1_sub3     | 1560 nt | CTTT  | TAGT  |
| 4   | 3'WT+PolIII block | bsmbi_3wt_tile1_sub4     | 1142 nt | TAGT  | CACC  |
| 5   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1 | --      | --    | --    |

```
  [TTCT]----3'WT sub1----[CTTT]----3'WT sub2----[TAGT]----3'WT+PolIII sub3----[CACC]
   TTCT                   CTTT                   TAGT                          CACC 
```

**Set fidelity:** 1.0000 (4 overhangs)

---

### Tile 9 of 26 -- Codons 514-547 (102 nt)

**Boundary overhangs:**

| Position          | Sequence | Fidelity |
| ----------------- | -------- | -------- |
| oh1 (5' boundary) | ATCA     | 0.7483   |
| oh2 (3' boundary) | TTCT     | 0.8181   |

**Variants:** 5880 mutations, 5880 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name             | Length  | 5' OH | 3' OH |
| --- | --------------- | --------------------- | ------- | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile9        | 1573 nt | AAGA  | ATCA  |
| 2   | Oligo pool      | Tile 9 (5880 oligos)  | 158 nt  | ATCA  | AGAA  |
| 3   | Helper plasmid  | helper_plasmid_insert | --      | --    | --    |
| 4   | Enzyme + buffer | BsaI-HFv2 + CutSmart  | --      | --    | --    |

```
  [AAGA]----5'WT block----[ATCA]----oligo+BC----[AGAA]
   AAGA                    ATCA                  AGAA 
```

**Set fidelity:** 1.0000 (3 overhangs)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------ | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)      | --      | --    | --    |
| 2   | 3'WT block        | bsmbi_3wt_tile9_sub1     | 1236 nt | TTCT  | CTTT  |
| 3   | 3'WT block        | bsmbi_3wt_tile1_sub3     | 1560 nt | CTTT  | TAGT  |
| 4   | 3'WT+PolIII block | bsmbi_3wt_tile1_sub4     | 1142 nt | TAGT  | CACC  |
| 5   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1 | --      | --    | --    |

```
  [TTCT]----3'WT sub1----[CTTT]----3'WT sub2----[TAGT]----3'WT+PolIII sub3----[CACC]
   TTCT                   CTTT                   TAGT                          CACC 
```

**Set fidelity:** 1.0000 (4 overhangs)

---

### Tile 10 of 26 -- Codons 542-592 (153 nt)

**Boundary overhangs:**

| Position          | Sequence | Fidelity |
| ----------------- | -------- | -------- |
| oh1 (5' boundary) | GGCA     | 0.5273   |
| oh2 (3' boundary) | GAAA     | 0.8745   |

**Variants:** 9450 mutations, 9450 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name             | Length  | 5' OH | 3' OH |
| --- | --------------- | --------------------- | ------- | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile10       | 1657 nt | AAGA  | GGCA  |
| 2   | Oligo pool      | Tile 10 (9450 oligos) | 209 nt  | GGCA  | AGAA  |
| 3   | Helper plasmid  | helper_plasmid_insert | --      | --    | --    |
| 4   | Enzyme + buffer | BsaI-HFv2 + CutSmart  | --      | --    | --    |

```
  [AAGA]----5'WT block----[GGCA]----oligo+BC----[AGAA]
   AAGA                    GGCA                  AGAA 
```

**Set fidelity:** 1.0000 (3 overhangs)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------ | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)      | --      | --    | --    |
| 2   | 3'WT block        | bsmbi_3wt_tile1_sub2     | 1101 nt | GAAA  | CTTT  |
| 3   | 3'WT block        | bsmbi_3wt_tile1_sub3     | 1560 nt | CTTT  | TAGT  |
| 4   | 3'WT+PolIII block | bsmbi_3wt_tile1_sub4     | 1142 nt | TAGT  | CACC  |
| 5   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1 | --      | --    | --    |

```
  [GAAA]----3'WT sub1----[CTTT]----3'WT sub2----[TAGT]----3'WT+PolIII sub3----[CACC]
   GAAA                   CTTT                   TAGT                          CACC 
```

**Set fidelity:** 1.0000 (4 overhangs)

---

### Tile 11 of 26 -- Codons 587-660 (222 nt)

**Boundary overhangs:**

| Position          | Sequence | Fidelity |
| ----------------- | -------- | -------- |
| oh1 (5' boundary) | AACT     | 0.6635   |
| oh2 (3' boundary) | GGAC     | 0.5754   |

**Variants:** 14280 mutations, 14280 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name              | Length  | 5' OH | 3' OH |
| --- | --------------- | ---------------------- | ------- | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile11        | 1792 nt | AAGA  | AACT  |
| 2   | Oligo pool      | Tile 11 (14280 oligos) | 278 nt  | AACT  | AGAA  |
| 3   | Helper plasmid  | helper_plasmid_insert  | --      | --    | --    |
| 4   | Enzyme + buffer | BsaI-HFv2 + CutSmart   | --      | --    | --    |

```
  [AAGA]----5'WT block----[AACT]----oligo+BC----[AGAA]
   AAGA                    AACT                  AGAA 
```

**Set fidelity:** 1.0000 (3 overhangs)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------ | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)      | --      | --    | --    |
| 2   | 3'WT block        | bsmbi_3wt_tile11_sub1    | 897 nt  | GGAC  | CTTT  |
| 3   | 3'WT block        | bsmbi_3wt_tile1_sub3     | 1560 nt | CTTT  | TAGT  |
| 4   | 3'WT+PolIII block | bsmbi_3wt_tile1_sub4     | 1142 nt | TAGT  | CACC  |
| 5   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1 | --      | --    | --    |

```
  [GGAC]----3'WT sub1----[CTTT]----3'WT sub2----[TAGT]----3'WT+PolIII sub3----[CACC]
   GGAC                   CTTT                   TAGT                          CACC 
```

**Set fidelity:** 1.0000 (4 overhangs)

---

### Tile 12 of 26 -- Codons 655-728 (222 nt)

**Boundary overhangs:**

| Position          | Sequence | Fidelity |
| ----------------- | -------- | -------- |
| oh1 (5' boundary) | CAAG     | 0.6640   |
| oh2 (3' boundary) | TTTC     | 0.8348   |

**Variants:** 14280 mutations, 14280 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name              | Length  | 5' OH | 3' OH |
| --- | --------------- | ---------------------- | ------- | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile12_sub1   | 1806 nt | AAGA  | GAAA  |
| 2   | 5'WT gene block | bsai_5wt_tile12_sub2   | 220 nt  | GAAA  | CAAG  |
| 3   | Oligo pool      | Tile 12 (14280 oligos) | 278 nt  | CAAG  | AGAA  |
| 4   | Helper plasmid  | helper_plasmid_insert  | --      | --    | --    |
| 5   | Enzyme + buffer | BsaI-HFv2 + CutSmart   | --      | --    | --    |

```
  [AAGA]----5'WT sub1----[GAAA]----5'WT sub2----[CAAG]----oligo+BC----[AGAA]
   AAGA                   GAAA                   CAAG                  AGAA 
```

**Set fidelity:** 1.0000 (4 overhangs)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------ | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)      | --      | --    | --    |
| 2   | 3'WT block        | bsmbi_3wt_tile12_sub1    | 693 nt  | TTTC  | CTTT  |
| 3   | 3'WT block        | bsmbi_3wt_tile1_sub3     | 1560 nt | CTTT  | TAGT  |
| 4   | 3'WT+PolIII block | bsmbi_3wt_tile1_sub4     | 1142 nt | TAGT  | CACC  |
| 5   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1 | --      | --    | --    |

```
  [TTTC]----3'WT sub1----[CTTT]----3'WT sub2----[TAGT]----3'WT+PolIII sub3----[CACC]
   TTTC                   CTTT                   TAGT                          CACC 
```

**Set fidelity:** 1.0000 (4 overhangs)

---

### Tile 13 of 26 -- Codons 723-796 (222 nt)

**Boundary overhangs:**

| Position          | Sequence | Fidelity |
| ----------------- | -------- | -------- |
| oh1 (5' boundary) | GGGA     | 0.6194   |
| oh2 (3' boundary) | GCTC     | 0.5230   |

**Variants:** 14280 mutations, 14280 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name              | Length  | 5' OH | 3' OH |
| --- | --------------- | ---------------------- | ------- | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile12_sub1   | 1806 nt | AAGA  | GAAA  |
| 2   | 5'WT gene block | bsai_5wt_tile13_sub2   | 424 nt  | GAAA  | GGGA  |
| 3   | Oligo pool      | Tile 13 (14280 oligos) | 278 nt  | GGGA  | AGAA  |
| 4   | Helper plasmid  | helper_plasmid_insert  | --      | --    | --    |
| 5   | Enzyme + buffer | BsaI-HFv2 + CutSmart   | --      | --    | --    |

```
  [AAGA]----5'WT sub1----[GAAA]----5'WT sub2----[GGGA]----oligo+BC----[AGAA]
   AAGA                   GAAA                   GGGA                  AGAA 
```

**Set fidelity:** 1.0000 (4 overhangs)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------ | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)      | --      | --    | --    |
| 2   | 3'WT block        | bsmbi_3wt_tile13_sub1    | 489 nt  | GCTC  | CTTT  |
| 3   | 3'WT block        | bsmbi_3wt_tile1_sub3     | 1560 nt | CTTT  | TAGT  |
| 4   | 3'WT+PolIII block | bsmbi_3wt_tile1_sub4     | 1142 nt | TAGT  | CACC  |
| 5   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1 | --      | --    | --    |

```
  [GCTC]----3'WT sub1----[CTTT]----3'WT sub2----[TAGT]----3'WT+PolIII sub3----[CACC]
   GCTC                   CTTT                   TAGT                          CACC 
```

**Set fidelity:** 1.0000 (4 overhangs)

---

### Tile 14 of 26 -- Codons 791-868 (234 nt)

**Boundary overhangs:**

| Position          | Sequence | Fidelity |
| ----------------- | -------- | -------- |
| oh1 (5' boundary) | CTGG     | 0.5756   |
| oh2 (3' boundary) | CTAC     | 0.6583   |

**Variants:** 15120 mutations, 15120 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name              | Length  | 5' OH | 3' OH |
| --- | --------------- | ---------------------- | ------- | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile12_sub1   | 1806 nt | AAGA  | GAAA  |
| 2   | 5'WT gene block | bsai_5wt_tile14_sub2   | 628 nt  | GAAA  | CTGG  |
| 3   | Oligo pool      | Tile 14 (15120 oligos) | 290 nt  | CTGG  | AGAA  |
| 4   | Helper plasmid  | helper_plasmid_insert  | --      | --    | --    |
| 5   | Enzyme + buffer | BsaI-HFv2 + CutSmart   | --      | --    | --    |

```
  [AAGA]----5'WT sub1----[GAAA]----5'WT sub2----[CTGG]----oligo+BC----[AGAA]
   AAGA                   GAAA                   CTGG                  AGAA 
```

**Set fidelity:** 1.0000 (4 overhangs)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------ | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)      | --      | --    | --    |
| 2   | 3'WT block        | bsmbi_3wt_tile14_sub1    | 273 nt  | CTAC  | CTTT  |
| 3   | 3'WT block        | bsmbi_3wt_tile1_sub3     | 1560 nt | CTTT  | TAGT  |
| 4   | 3'WT+PolIII block | bsmbi_3wt_tile1_sub4     | 1142 nt | TAGT  | CACC  |
| 5   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1 | --      | --    | --    |

```
  [CTAC]----3'WT sub1----[CTTT]----3'WT sub2----[TAGT]----3'WT+PolIII sub3----[CACC]
   CTAC                   CTTT                   TAGT                          CACC 
```

**Set fidelity:** 0.9986 (4 overhangs)

---

### Tile 15 of 26 -- Codons 863-905 (129 nt)

**Boundary overhangs:**

| Position          | Sequence | Fidelity |
| ----------------- | -------- | -------- |
| oh1 (5' boundary) | ATCA     | 0.7483   |
| oh2 (3' boundary) | TTCC     | 0.7958   |

**Variants:** 7770 mutations, 7770 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name             | Length  | 5' OH | 3' OH |
| --- | --------------- | --------------------- | ------- | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile12_sub1  | 1806 nt | AAGA  | GAAA  |
| 2   | 5'WT gene block | bsai_5wt_tile15_sub2  | 844 nt  | GAAA  | ATCA  |
| 3   | Oligo pool      | Tile 15 (7770 oligos) | 185 nt  | ATCA  | AGAA  |
| 4   | Helper plasmid  | helper_plasmid_insert | --      | --    | --    |
| 5   | Enzyme + buffer | BsaI-HFv2 + CutSmart  | --      | --    | --    |

```
  [AAGA]----5'WT sub1----[GAAA]----5'WT sub2----[ATCA]----oligo+BC----[AGAA]
   AAGA                   GAAA                   ATCA                  AGAA 
```

**Set fidelity:** 1.0000 (4 overhangs)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------ | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)      | --      | --    | --    |
| 2   | 3'WT block        | bsmbi_3wt_tile15_sub1    | 1692 nt | TTCC  | TAGT  |
| 3   | 3'WT+PolIII block | bsmbi_3wt_tile1_sub4     | 1142 nt | TAGT  | CACC  |
| 4   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1 | --      | --    | --    |

```
  [TTCC]----3'WT sub1----[TAGT]----3'WT+PolIII sub2----[CACC]
   TTCC                   TAGT                          CACC 
```

**Set fidelity:** 0.9988 (3 overhangs)

---

### Tile 16 of 26 -- Codons 900-949 (150 nt)

**Boundary overhangs:**

| Position          | Sequence | Fidelity |
| ----------------- | -------- | -------- |
| oh1 (5' boundary) | TCAG     | 0.7814   |
| oh2 (3' boundary) | CTTT     | 0.6635   |

**Variants:** 9240 mutations, 9240 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name             | Length  | 5' OH | 3' OH |
| --- | --------------- | --------------------- | ------- | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile12_sub1  | 1806 nt | AAGA  | GAAA  |
| 2   | 5'WT gene block | bsai_5wt_tile16_sub2  | 955 nt  | GAAA  | TCAG  |
| 3   | Oligo pool      | Tile 16 (9240 oligos) | 206 nt  | TCAG  | AGAA  |
| 4   | Helper plasmid  | helper_plasmid_insert | --      | --    | --    |
| 5   | Enzyme + buffer | BsaI-HFv2 + CutSmart  | --      | --    | --    |

```
  [AAGA]----5'WT sub1----[GAAA]----5'WT sub2----[TCAG]----oligo+BC----[AGAA]
   AAGA                   GAAA                   TCAG                  AGAA 
```

**Set fidelity:** 1.0000 (4 overhangs)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------ | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)      | --      | --    | --    |
| 2   | 3'WT block        | bsmbi_3wt_tile1_sub3     | 1560 nt | CTTT  | TAGT  |
| 3   | 3'WT+PolIII block | bsmbi_3wt_tile1_sub4     | 1142 nt | TAGT  | CACC  |
| 4   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1 | --      | --    | --    |

```
  [CTTT]----3'WT sub1----[TAGT]----3'WT+PolIII sub2----[CACC]
   CTTT                   TAGT                          CACC 
```

**Set fidelity:** 1.0000 (3 overhangs)

---

### Tile 17 of 26 -- Codons 944-986 (129 nt)

**Boundary overhangs:**

| Position          | Sequence | Fidelity |
| ----------------- | -------- | -------- |
| oh1 (5' boundary) | TCAG     | 0.7814   |
| oh2 (3' boundary) | TCTT     | 0.7985   |

**Variants:** 7770 mutations, 7770 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name             | Length  | 5' OH | 3' OH |
| --- | --------------- | --------------------- | ------- | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile12_sub1  | 1806 nt | AAGA  | GAAA  |
| 2   | 5'WT gene block | bsai_5wt_tile17_sub2  | 1087 nt | GAAA  | TCAG  |
| 3   | Oligo pool      | Tile 17 (7770 oligos) | 185 nt  | TCAG  | AGAA  |
| 4   | Helper plasmid  | helper_plasmid_insert | --      | --    | --    |
| 5   | Enzyme + buffer | BsaI-HFv2 + CutSmart  | --      | --    | --    |

```
  [AAGA]----5'WT sub1----[GAAA]----5'WT sub2----[TCAG]----oligo+BC----[AGAA]
   AAGA                   GAAA                   TCAG                  AGAA 
```

**Set fidelity:** 1.0000 (4 overhangs)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------ | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)      | --      | --    | --    |
| 2   | 3'WT block        | bsmbi_3wt_tile17_sub1    | 1449 nt | TCTT  | TAGT  |
| 3   | 3'WT+PolIII block | bsmbi_3wt_tile1_sub4     | 1142 nt | TAGT  | CACC  |
| 4   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1 | --      | --    | --    |

```
  [TCTT]----3'WT sub1----[TAGT]----3'WT+PolIII sub2----[CACC]
   TCTT                   TAGT                          CACC 
```

**Set fidelity:** 1.0000 (3 overhangs)

---

### Tile 18 of 26 -- Codons 981-1054 (222 nt)

**Boundary overhangs:**

| Position          | Sequence | Fidelity |
| ----------------- | -------- | -------- |
| oh1 (5' boundary) | CAGG     | 0.5358   |
| oh2 (3' boundary) | AGAA     | 0.8847   |

**Variants:** 14280 mutations, 14280 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name              | Length  | 5' OH | 3' OH |
| --- | --------------- | ---------------------- | ------- | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile12_sub1   | 1806 nt | AAGA  | GAAA  |
| 2   | 5'WT gene block | bsai_5wt_tile18_sub2   | 1198 nt | GAAA  | CAGG  |
| 3   | Oligo pool      | Tile 18 (14280 oligos) | 278 nt  | CAGG  | AGAA  |
| 4   | Helper plasmid  | helper_plasmid_insert  | --      | --    | --    |
| 5   | Enzyme + buffer | BsaI-HFv2 + CutSmart   | --      | --    | --    |

```
  [AAGA]----5'WT sub1----[GAAA]----5'WT sub2----[CAGG]----oligo+BC----[AGAA]
   AAGA                   GAAA                   CAGG                  AGAA 
```

**Set fidelity:** 1.0000 (4 overhangs)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------ | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)      | --      | --    | --    |
| 2   | 3'WT block        | bsmbi_3wt_tile18_sub1    | 1245 nt | AGAA  | TAGT  |
| 3   | 3'WT+PolIII block | bsmbi_3wt_tile1_sub4     | 1142 nt | TAGT  | CACC  |
| 4   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1 | --      | --    | --    |

```
  [AGAA]----3'WT sub1----[TAGT]----3'WT+PolIII sub2----[CACC]
   AGAA                   TAGT                          CACC 
```

**Set fidelity:** 1.0000 (3 overhangs)

---

### Tile 19 of 26 -- Codons 1049-1124 (228 nt)

**Boundary overhangs:**

| Position          | Sequence | Fidelity |
| ----------------- | -------- | -------- |
| oh1 (5' boundary) | CCTA     | 0.6679   |
| oh2 (3' boundary) | GAAG     | 0.6752   |

**Variants:** 14700 mutations, 14700 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name              | Length  | 5' OH | 3' OH |
| --- | --------------- | ---------------------- | ------- | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile12_sub1   | 1806 nt | AAGA  | GAAA  |
| 2   | 5'WT gene block | bsai_5wt_tile19_sub2   | 1101 nt | GAAA  | CTTT  |
| 3   | 5'WT gene block | bsai_5wt_tile19_sub3   | 331 nt  | CTTT  | CCTA  |
| 4   | Oligo pool      | Tile 19 (14700 oligos) | 284 nt  | CCTA  | AGAA  |
| 5   | Helper plasmid  | helper_plasmid_insert  | --      | --    | --    |
| 6   | Enzyme + buffer | BsaI-HFv2 + CutSmart   | --      | --    | --    |

```
  [AAGA]----5'WT sub1----[GAAA]----5'WT sub2----[CTTT]----5'WT sub3----[CCTA]----oligo+BC----[AGAA]
   AAGA                   GAAA                   CTTT                   CCTA                  AGAA 
```

**Set fidelity:** 1.0000 (5 overhangs)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------ | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)      | --      | --    | --    |
| 2   | 3'WT block        | bsmbi_3wt_tile19_sub1    | 1035 nt | GAAG  | TAGT  |
| 3   | 3'WT+PolIII block | bsmbi_3wt_tile1_sub4     | 1142 nt | TAGT  | CACC  |
| 4   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1 | --      | --    | --    |

```
  [GAAG]----3'WT sub1----[TAGT]----3'WT+PolIII sub2----[CACC]
   GAAG                   TAGT                          CACC 
```

**Set fidelity:** 1.0000 (3 overhangs)

---

### Tile 20 of 26 -- Codons 1119-1193 (225 nt)

**Boundary overhangs:**

| Position          | Sequence | Fidelity |
| ----------------- | -------- | -------- |
| oh1 (5' boundary) | ACTA     | 0.7946   |
| oh2 (3' boundary) | CTTG     | 0.7594   |

**Variants:** 14490 mutations, 14490 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name              | Length  | 5' OH | 3' OH |
| --- | --------------- | ---------------------- | ------- | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile12_sub1   | 1806 nt | AAGA  | GAAA  |
| 2   | 5'WT gene block | bsai_5wt_tile19_sub2   | 1101 nt | GAAA  | CTTT  |
| 3   | 5'WT gene block | bsai_5wt_tile20_sub3   | 541 nt  | CTTT  | ACTA  |
| 4   | Oligo pool      | Tile 20 (14490 oligos) | 281 nt  | ACTA  | AGAA  |
| 5   | Helper plasmid  | helper_plasmid_insert  | --      | --    | --    |
| 6   | Enzyme + buffer | BsaI-HFv2 + CutSmart   | --      | --    | --    |

```
  [AAGA]----5'WT sub1----[GAAA]----5'WT sub2----[CTTT]----5'WT sub3----[ACTA]----oligo+BC----[AGAA]
   AAGA                   GAAA                   CTTT                   ACTA                  AGAA 
```

**Set fidelity:** 1.0000 (5 overhangs)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------ | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)      | --      | --    | --    |
| 2   | 3'WT block        | bsmbi_3wt_tile20_sub1    | 828 nt  | CTTG  | TAGT  |
| 3   | 3'WT+PolIII block | bsmbi_3wt_tile1_sub4     | 1142 nt | TAGT  | CACC  |
| 4   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1 | --      | --    | --    |

```
  [CTTG]----3'WT sub1----[TAGT]----3'WT+PolIII sub2----[CACC]
   CTTG                   TAGT                          CACC 
```

**Set fidelity:** 1.0000 (3 overhangs)

---

### Tile 21 of 26 -- Codons 1188-1224 (111 nt)

**Boundary overhangs:**

| Position          | Sequence | Fidelity |
| ----------------- | -------- | -------- |
| oh1 (5' boundary) | TCCA     | 0.8519   |
| oh2 (3' boundary) | CTAT     | 0.7299   |

**Variants:** 6510 mutations, 6510 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name             | Length  | 5' OH | 3' OH |
| --- | --------------- | --------------------- | ------- | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile12_sub1  | 1806 nt | AAGA  | GAAA  |
| 2   | 5'WT gene block | bsai_5wt_tile19_sub2  | 1101 nt | GAAA  | CTTT  |
| 3   | 5'WT gene block | bsai_5wt_tile21_sub3  | 748 nt  | CTTT  | TCCA  |
| 4   | Oligo pool      | Tile 21 (6510 oligos) | 167 nt  | TCCA  | AGAA  |
| 5   | Helper plasmid  | helper_plasmid_insert | --      | --    | --    |
| 6   | Enzyme + buffer | BsaI-HFv2 + CutSmart  | --      | --    | --    |

```
  [AAGA]----5'WT sub1----[GAAA]----5'WT sub2----[CTTT]----5'WT sub3----[TCCA]----oligo+BC----[AGAA]
   AAGA                   GAAA                   CTTT                   TCCA                  AGAA 
```

**Set fidelity:** 1.0000 (5 overhangs)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------ | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)      | --      | --    | --    |
| 2   | 3'WT block        | bsmbi_3wt_tile21_sub1    | 735 nt  | CTAT  | TAGT  |
| 3   | 3'WT+PolIII block | bsmbi_3wt_tile1_sub4     | 1142 nt | TAGT  | CACC  |
| 4   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1 | --      | --    | --    |

```
  [CTAT]----3'WT sub1----[TAGT]----3'WT+PolIII sub2----[CACC]
   CTAT                   TAGT                          CACC 
```

**Set fidelity:** 1.0000 (3 overhangs)

---

### Tile 22 of 26 -- Codons 1219-1291 (219 nt)

**Boundary overhangs:**

| Position          | Sequence | Fidelity |
| ----------------- | -------- | -------- |
| oh1 (5' boundary) | TCCA     | 0.8519   |
| oh2 (3' boundary) | TTCC     | 0.7958   |

**Variants:** 14070 mutations, 14070 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name              | Length  | 5' OH | 3' OH |
| --- | --------------- | ---------------------- | ------- | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile12_sub1   | 1806 nt | AAGA  | GAAA  |
| 2   | 5'WT gene block | bsai_5wt_tile19_sub2   | 1101 nt | GAAA  | CTTT  |
| 3   | 5'WT gene block | bsai_5wt_tile22_sub3   | 841 nt  | CTTT  | TCCA  |
| 4   | Oligo pool      | Tile 22 (14070 oligos) | 275 nt  | TCCA  | AGAA  |
| 5   | Helper plasmid  | helper_plasmid_insert  | --      | --    | --    |
| 6   | Enzyme + buffer | BsaI-HFv2 + CutSmart   | --      | --    | --    |

```
  [AAGA]----5'WT sub1----[GAAA]----5'WT sub2----[CTTT]----5'WT sub3----[TCCA]----oligo+BC----[AGAA]
   AAGA                   GAAA                   CTTT                   TCCA                  AGAA 
```

**Set fidelity:** 1.0000 (5 overhangs)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------ | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)      | --      | --    | --    |
| 2   | 3'WT block        | bsmbi_3wt_tile22_sub1    | 534 nt  | TTCC  | TAGT  |
| 3   | 3'WT+PolIII block | bsmbi_3wt_tile1_sub4     | 1142 nt | TAGT  | CACC  |
| 4   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1 | --      | --    | --    |

```
  [TTCC]----3'WT sub1----[TAGT]----3'WT+PolIII sub2----[CACC]
   TTCC                   TAGT                          CACC 
```

**Set fidelity:** 0.9988 (3 overhangs)

---

### Tile 23 of 26 -- Codons 1286-1343 (174 nt)

**Boundary overhangs:**

| Position          | Sequence | Fidelity |
| ----------------- | -------- | -------- |
| oh1 (5' boundary) | ATTA     | 0.7818   |
| oh2 (3' boundary) | CCTT     | 0.6891   |

**Variants:** 10920 mutations, 10920 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name              | Length  | 5' OH | 3' OH |
| --- | --------------- | ---------------------- | ------- | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile12_sub1   | 1806 nt | AAGA  | GAAA  |
| 2   | 5'WT gene block | bsai_5wt_tile19_sub2   | 1101 nt | GAAA  | CTTT  |
| 3   | 5'WT gene block | bsai_5wt_tile23_sub3   | 1042 nt | CTTT  | ATTA  |
| 4   | Oligo pool      | Tile 23 (10920 oligos) | 230 nt  | ATTA  | AGAA  |
| 5   | Helper plasmid  | helper_plasmid_insert  | --      | --    | --    |
| 6   | Enzyme + buffer | BsaI-HFv2 + CutSmart   | --      | --    | --    |

```
  [AAGA]----5'WT sub1----[GAAA]----5'WT sub2----[CTTT]----5'WT sub3----[ATTA]----oligo+BC----[AGAA]
   AAGA                   GAAA                   CTTT                   ATTA                  AGAA 
```

**Set fidelity:** 1.0000 (5 overhangs)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------ | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)      | --      | --    | --    |
| 2   | 3'WT block        | bsmbi_3wt_tile23_sub1    | 378 nt  | CCTT  | TAGT  |
| 3   | 3'WT+PolIII block | bsmbi_3wt_tile1_sub4     | 1142 nt | TAGT  | CACC  |
| 4   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1 | --      | --    | --    |

```
  [CCTT]----3'WT sub1----[TAGT]----3'WT+PolIII sub2----[CACC]
   CCTT                   TAGT                          CACC 
```

**Set fidelity:** 1.0000 (3 overhangs)

---

### Tile 24 of 26 -- Codons 1338-1387 (150 nt)

**Boundary overhangs:**

| Position          | Sequence | Fidelity |
| ----------------- | -------- | -------- |
| oh1 (5' boundary) | GGGA     | 0.6194   |
| oh2 (3' boundary) | TTAC     | 0.8333   |

**Variants:** 9240 mutations, 9240 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name             | Length  | 5' OH | 3' OH |
| --- | --------------- | --------------------- | ------- | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile12_sub1  | 1806 nt | AAGA  | GAAA  |
| 2   | 5'WT gene block | bsai_5wt_tile19_sub2  | 1101 nt | GAAA  | CTTT  |
| 3   | 5'WT gene block | bsai_5wt_tile24_sub3  | 1198 nt | CTTT  | GGGA  |
| 4   | Oligo pool      | Tile 24 (9240 oligos) | 206 nt  | GGGA  | AGAA  |
| 5   | Helper plasmid  | helper_plasmid_insert | --      | --    | --    |
| 6   | Enzyme + buffer | BsaI-HFv2 + CutSmart  | --      | --    | --    |

```
  [AAGA]----5'WT sub1----[GAAA]----5'WT sub2----[CTTT]----5'WT sub3----[GGGA]----oligo+BC----[AGAA]
   AAGA                   GAAA                   CTTT                   GGGA                  AGAA 
```

**Set fidelity:** 1.0000 (5 overhangs)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------ | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)      | --      | --    | --    |
| 2   | 3'WT+PolIII block | bsmbi_3wt_tile24_sub1    | 1358 nt | TTAC  | CACC  |
| 3   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1 | --      | --    | --    |

```
  [TTAC]----3'WT+PolIII----[CACC]
   TTAC                     CACC 
```

**Set fidelity:** 1.0000 (2 overhangs)

---

### Tile 25 of 26 -- Codons 1382-1459 (234 nt)

**Boundary overhangs:**

| Position          | Sequence | Fidelity |
| ----------------- | -------- | -------- |
| oh1 (5' boundary) | TGCC     | 0.5867   |
| oh2 (3' boundary) | TAGT     | 0.7437   |

**Variants:** 15120 mutations, 15120 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name              | Length  | 5' OH | 3' OH |
| --- | --------------- | ---------------------- | ------- | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile12_sub1   | 1806 nt | AAGA  | GAAA  |
| 2   | 5'WT gene block | bsai_5wt_tile19_sub2   | 1101 nt | GAAA  | CTTT  |
| 3   | 5'WT gene block | bsai_5wt_tile25_sub3   | 1330 nt | CTTT  | TGCC  |
| 4   | Oligo pool      | Tile 25 (15120 oligos) | 290 nt  | TGCC  | AGAA  |
| 5   | Helper plasmid  | helper_plasmid_insert  | --      | --    | --    |
| 6   | Enzyme + buffer | BsaI-HFv2 + CutSmart   | --      | --    | --    |

```
  [AAGA]----5'WT sub1----[GAAA]----5'WT sub2----[CTTT]----5'WT sub3----[TGCC]----oligo+BC----[AGAA]
   AAGA                   GAAA                   CTTT                   TGCC                  AGAA 
```

**Set fidelity:** 1.0000 (5 overhangs)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component         | Part name                | Length  | 5' OH | 3' OH |
| --- | ----------------- | ------------------------ | ------- | ----- | ----- |
| 1   | BsaI product      | (in helper plasmid)      | --      | --    | --    |
| 2   | 3'WT+PolIII block | bsmbi_3wt_tile1_sub4     | 1142 nt | TAGT  | CACC  |
| 3   | Enzyme + buffer   | BsmBI-v2 + NEBuffer r3.1 | --      | --    | --    |

```
  [TAGT]----3'WT+PolIII----[CACC]
   TAGT                     CACC 
```

**Set fidelity:** 1.0000 (2 overhangs)

---

### Tile 26 of 26 -- Codons 1454-1480 (83 nt)

**Boundary overhangs:**

| Position          | Sequence | Fidelity |
| ----------------- | -------- | -------- |
| oh1 (5' boundary) | TACA     | 0.8652   |
| oh2 (3' boundary) | TTCT     | 0.8181   |

**Variants:** 1680 mutations, 1680 oligos

#### BsaI Level 1 Reaction (37C)

**Components:**

| #   | Component       | Part name             | Length  | 5' OH | 3' OH |
| --- | --------------- | --------------------- | ------- | ----- | ----- |
| 1   | 5'WT gene block | bsai_5wt_tile12_sub1  | 1806 nt | AAGA  | GAAA  |
| 2   | 5'WT gene block | bsai_5wt_tile19_sub2  | 1101 nt | GAAA  | CTTT  |
| 3   | 5'WT gene block | bsai_5wt_tile26_sub3  | 1546 nt | CTTT  | TACA  |
| 4   | Oligo pool      | Tile 26 (1680 oligos) | 139 nt  | TACA  | AGAA  |
| 5   | Helper plasmid  | helper_plasmid_insert | --      | --    | --    |
| 6   | Enzyme + buffer | BsaI-HFv2 + CutSmart  | --      | --    | --    |

```
  [AAGA]----5'WT sub1----[GAAA]----5'WT sub2----[CTTT]----5'WT sub3----[TACA]----oligo+BC----[AGAA]
   AAGA                   GAAA                   CTTT                   TACA                  AGAA 
```

**Set fidelity:** 1.0000 (5 overhangs)

#### BsmBI Level 1b Reaction (42C)

**Components:**

| #   | Component            | Part name                | Length  | 5' OH | 3' OH |
| --- | -------------------- | ------------------------ | ------- | ----- | ----- |
| 1   | BsaI product         | (in helper plasmid)      | --      | --    | --    |
| 2   | PolIII-only fragment | bsmbi_polIII_tile26      | 1077 nt | TTCT  | CACC  |
| 3   | Enzyme + buffer      | BsmBI-v2 + NEBuffer r3.1 | --      | --    | --    |

```
  [TTCT]----PolIII----[CACC]
   TTCT                CACC 
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

- paqci_star2 (5'): `auto`
- paqci_star1 (3'): `auto`

```
[PaqCI** auto]--[gene+mutation]--[WPRE]--[spacer]--[bGH_polyA]--[PolIII]--[barcode]--[PaqCI* auto]
```

## 9. Gene Block Order Sheet

Order these gene blocks as synthesized gene fragments (e.g., Twist gene fragments, IDT gBlocks).
Gene blocks are synthesized once and reused across experiments.

**Total blocks:** 53

| Block name            | Length (nt) | Enzyme type | Gene region                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                               |
| --------------------- | ----------- | ----------- | --------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| bsai_5wt_tile10       | 1657        | BsaI        | 5wt_tile10                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                |
| bsai_5wt_tile11       | 1792        | BsaI        | 5wt_tile11                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                |
| bsai_5wt_tile12_sub1  | 1806        | BsaI        | 5wt_tile12_sub1;5wt_tile13_sub1;5wt_tile14_sub1;5wt_tile15_sub1;5wt_tile16_sub1;5wt_tile17_sub1;5wt_tile18_sub1;5wt_tile19_sub1;5wt_tile20_sub1;5wt_tile21_sub1;5wt_tile22_sub1;5wt_tile23_sub1;5wt_tile24_sub1;5wt_tile25_sub1;5wt_tile26_sub1                                                                                                                                                                                                                                                                                                           |
| bsai_5wt_tile12_sub2  | 220         | BsaI        | 5wt_tile12_sub2                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                           |
| bsai_5wt_tile13_sub2  | 424         | BsaI        | 5wt_tile13_sub2                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                           |
| bsai_5wt_tile14_sub2  | 628         | BsaI        | 5wt_tile14_sub2                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                           |
| bsai_5wt_tile15_sub2  | 844         | BsaI        | 5wt_tile15_sub2                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                           |
| bsai_5wt_tile16_sub2  | 955         | BsaI        | 5wt_tile16_sub2                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                           |
| bsai_5wt_tile17_sub2  | 1087        | BsaI        | 5wt_tile17_sub2                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                           |
| bsai_5wt_tile18_sub2  | 1198        | BsaI        | 5wt_tile18_sub2                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                           |
| bsai_5wt_tile19_sub2  | 1101        | BsaI        | 5wt_tile19_sub2;5wt_tile20_sub2;5wt_tile21_sub2;5wt_tile22_sub2;5wt_tile23_sub2;5wt_tile24_sub2;5wt_tile25_sub2;5wt_tile26_sub2                                                                                                                                                                                                                                                                                                                                                                                                                           |
| bsai_5wt_tile19_sub3  | 331         | BsaI        | 5wt_tile19_sub3                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                           |
| bsai_5wt_tile2        | 250         | BsaI        | 5wt_tile2                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                 |
| bsai_5wt_tile20_sub3  | 541         | BsaI        | 5wt_tile20_sub3                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                           |
| bsai_5wt_tile21_sub3  | 748         | BsaI        | 5wt_tile21_sub3                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                           |
| bsai_5wt_tile22_sub3  | 841         | BsaI        | 5wt_tile22_sub3                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                           |
| bsai_5wt_tile23_sub3  | 1042        | BsaI        | 5wt_tile23_sub3                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                           |
| bsai_5wt_tile24_sub3  | 1198        | BsaI        | 5wt_tile24_sub3                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                           |
| bsai_5wt_tile25_sub3  | 1330        | BsaI        | 5wt_tile25_sub3                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                           |
| bsai_5wt_tile26_sub3  | 1546        | BsaI        | 5wt_tile26_sub3                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                           |
| bsai_5wt_tile3        | 433         | BsaI        | 5wt_tile3                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                 |
| bsai_5wt_tile4        | 637         | BsaI        | 5wt_tile4                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                 |
| bsai_5wt_tile5        | 850         | BsaI        | 5wt_tile5                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                 |
| bsai_5wt_tile6        | 931         | BsaI        | 5wt_tile6                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                 |
| bsai_5wt_tile7        | 1144        | BsaI        | 5wt_tile7                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                 |
| bsai_5wt_tile8        | 1357        | BsaI        | 5wt_tile8                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                 |
| bsai_5wt_tile9        | 1573        | BsaI        | 5wt_tile9                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                 |
| bsmbi_3wt_tile1_sub1  | 1572        | BsmBI       | 3wt_tile1_sub1                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                            |
| bsmbi_3wt_tile1_sub2  | 1101        | BsmBI       | 3wt_tile1_sub2;3wt_tile2_sub2;3wt_tile3_sub2;3wt_tile4_sub2;3wt_tile5_sub2;3wt_tile6_sub2;3wt_tile7_sub2;3wt_tile10_sub1                                                                                                                                                                                                                                                                                                                                                                                                                                  |
| bsmbi_3wt_tile1_sub3  | 1560        | BsmBI       | 3wt_tile1_sub3;3wt_tile2_sub3;3wt_tile3_sub3;3wt_tile4_sub3;3wt_tile5_sub3;3wt_tile6_sub3;3wt_tile7_sub3;3wt_tile8_sub2;3wt_tile9_sub2;3wt_tile10_sub2;3wt_tile11_sub2;3wt_tile12_sub2;3wt_tile13_sub2;3wt_tile14_sub2;3wt_tile16_sub1                                                                                                                                                                                                                                                                                                                    |
| bsmbi_3wt_tile1_sub4  | 1142        | BsmBI       | 3wt_polIII_tile1_sub4;3wt_polIII_tile2_sub4;3wt_polIII_tile3_sub4;3wt_polIII_tile4_sub4;3wt_polIII_tile5_sub4;3wt_polIII_tile6_sub4;3wt_polIII_tile7_sub4;3wt_polIII_tile8_sub3;3wt_polIII_tile9_sub3;3wt_polIII_tile10_sub3;3wt_polIII_tile11_sub3;3wt_polIII_tile12_sub3;3wt_polIII_tile13_sub3;3wt_polIII_tile14_sub3;3wt_polIII_tile15_sub2;3wt_polIII_tile16_sub2;3wt_polIII_tile17_sub2;3wt_polIII_tile18_sub2;3wt_polIII_tile19_sub2;3wt_polIII_tile20_sub2;3wt_polIII_tile21_sub2;3wt_polIII_tile22_sub2;3wt_polIII_tile23_sub2;3wt_polIII_tile25 |
| bsmbi_3wt_tile11_sub1 | 897         | BsmBI       | 3wt_tile11_sub1                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                           |
| bsmbi_3wt_tile12_sub1 | 693         | BsmBI       | 3wt_tile12_sub1                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                           |
| bsmbi_3wt_tile13_sub1 | 489         | BsmBI       | 3wt_tile13_sub1                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                           |
| bsmbi_3wt_tile14_sub1 | 273         | BsmBI       | 3wt_tile14_sub1                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                           |
| bsmbi_3wt_tile15_sub1 | 1692        | BsmBI       | 3wt_tile15_sub1                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                           |
| bsmbi_3wt_tile17_sub1 | 1449        | BsmBI       | 3wt_tile17_sub1                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                           |
| bsmbi_3wt_tile18_sub1 | 1245        | BsmBI       | 3wt_tile18_sub1                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                           |
| bsmbi_3wt_tile19_sub1 | 1035        | BsmBI       | 3wt_tile19_sub1                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                           |
| bsmbi_3wt_tile2_sub1  | 1389        | BsmBI       | 3wt_tile2_sub1                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                            |
| bsmbi_3wt_tile20_sub1 | 828         | BsmBI       | 3wt_tile20_sub1                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                           |
| bsmbi_3wt_tile21_sub1 | 735         | BsmBI       | 3wt_tile21_sub1                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                           |
| bsmbi_3wt_tile22_sub1 | 534         | BsmBI       | 3wt_tile22_sub1                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                           |
| bsmbi_3wt_tile23_sub1 | 378         | BsmBI       | 3wt_tile23_sub1                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                           |
| bsmbi_3wt_tile24_sub1 | 1358        | BsmBI       | 3wt_polIII_tile24_sub1                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                    |
| bsmbi_3wt_tile3_sub1  | 1185        | BsmBI       | 3wt_tile3_sub1                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                            |
| bsmbi_3wt_tile4_sub1  | 972         | BsmBI       | 3wt_tile4_sub1                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                            |
| bsmbi_3wt_tile5_sub1  | 891         | BsmBI       | 3wt_tile5_sub1                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                            |
| bsmbi_3wt_tile6_sub1  | 678         | BsmBI       | 3wt_tile6_sub1                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                            |
| bsmbi_3wt_tile7_sub1  | 465         | BsmBI       | 3wt_tile7_sub1                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                            |
| bsmbi_3wt_tile8_sub1  | 1320        | BsmBI       | 3wt_tile8_sub1                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                            |
| bsmbi_3wt_tile9_sub1  | 1236        | BsmBI       | 3wt_tile9_sub1                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                            |
| bsmbi_polIII_tile26   | 1077        | BsmBI       | polIII_tile26                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                             |

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

