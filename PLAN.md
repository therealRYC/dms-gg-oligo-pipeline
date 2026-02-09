# PLAN.md — DMS GG Oligo Pipeline Redesign Discussion

## Context

This document captures the full design discussion for redesigning the `dms-gg-oligo-pipeline` assembly strategy. The original design had a critical flaw (tile-barcode scrambling), and we've been working through a corrected 3-enzyme approach. The next conversation should pick up at **"Helper plasmid and gene block design — details need adjustment"**.

**Author**: Robert Chen (robchen@uw.edu, GitHub: therealRYC)
**Lab**: Fowler Lab, UW
**Date**: 2026-02-09

---

## Part 1: Codebase Status

The local repo has a fully implemented (but not yet committed/pushed) R pipeline with 14 source modules, 8 test files, config template, and DESCRIPTION file. Only one commit exists (`dc37e8c` — initial CLAUDE.md + .gitignore). The GitHub repo `therealRYC/dms-gg-oligo-pipeline` was created (public) but no remote has been added and no code has been pushed.

All code follows the ORIGINAL design (which has the scrambling flaw described below). The code will need significant revision once the new assembly architecture is finalized.

---

## Part 2: The Scrambling Problem (Critical Flaw in Original Design)

### Original oligo design (FLAWED)

The original design used BsmBI for Level 1 assembly with three overhangs:

```
Oligo: BsmBI***(fwd)—[mutant tile]—BsmBI*(rev)—BsmBI**(fwd)—[barcode]—PaqCI*(rev)
```

### Why it fails

In the pooled Level 1 BsmBI reaction, ALL three BsmBI sites on every oligo get cut simultaneously. Each oligo releases TWO separate fragments:

1. `[oh***]—mutant_tile—[oh*]` (different per variant)
2. `[oh**]—barcode—PaqCI*` (different per variant)

Since overhangs are **identical across all oligos in the pool**, any tile fragment can ligate with any barcode fragment through the shared WT trailing block bridge:

```
...tile_X—[oh*]—3'WT—PolIII—[oh**]—barcode_Y...
    ↑ from variant X              ↑ from variant Y  ← SCRAMBLED
```

### The core rule

**In any pooled reaction, if an enzyme cuts between the tile and the barcode, they become separate fragments with identical overhangs, and linkage is lost.** The tile and barcode MUST remain on the same continuous fragment through any pooled assembly step.

---

## Part 3: The New 3-Enzyme Architecture

### Enzymes and their roles

| Enzyme | Role | Pooled? |
|--------|------|---------|
| **BsaI** | Level 1: Insert oligo (tile+barcode) into helper plasmid | Yes (pooled per tile position) |
| **BsmBI** | Level 1b: Insert 3'WT + PolIII between tile and barcode | No (per-clone or dilute intramolecular) |
| **PaqCI** | Level 2: Move complete insert into destination backbone | Yes (can be pooled) |

### Why BsmBI must not be pooled

BsmBI separates the tile from the barcode. If done in a pooled context (multiple variants in same tube), tiles from one variant could ligate with barcodes from another. BsmBI must be done either:
- After transformation into single colonies (one variant per colony)
- At very low DNA concentration (intramolecular ligation strongly favored)

BsmBI doesn't have to be the absolute last step, but it must happen after constructs are isolated from each other.

---

## Part 4: Oligo Design (AGREED — Rock Solid)

### Universal oligo architecture (same for ALL tile types)

```
5'—BsaI_[oh1]—[mutant tile]—BsmBI_oh2←  →BsmBI_oh3—[barcode]—BsaI_[oh4]—3'
                               (rev)        (fwd)
                              ↑____gap____↑
                        3'WT+PolIII inserts here later
```

### Critical detail: BsmBI site orientation

The two BsmBI sites face **inward** (toward each other), creating a landing pad for the 3'WT+PolIII fragment:

- BsmBI_oh2 is in **reverse** orientation (recognition on bottom strand)
- BsmBI_oh3 is in **forward** orientation (recognition on top strand)
- Between them: just the two BsmBI recognition sequences (tiny junk fragment, discarded when BsmBI cuts)

**WHY THIS MATTERS**: In an earlier (wrong) version, the barcode was placed BETWEEN the two BsmBI sites:
```
WRONG: ...tile—BsmBI_oh2—[barcode]—BsmBI_oh3...  ← barcode gets CUT OUT and lost!
RIGHT: ...tile—BsmBI_oh2←→BsmBI_oh3—[barcode]... ← barcode stays, gap opens for insert
```

### Overhang roles

| Overhang | What it encodes | Varies by tile position? |
|----------|----------------|-------------------------|
| oh1 | Gene sequence at tile's **5' boundary** (where 5'WT ends, tile begins) | Yes |
| oh2 | Gene sequence at tile's **3' boundary** (where tile ends, 3'WT begins) | Yes |
| oh3 | Junction between PolIII and barcode | **No** — fixed, same for all |
| oh4 | Junction between barcode and helper plasmid downstream | **No** — fixed, same for all |

- oh1 and oh2 are **gene-sequence-dependent** but the **same for all variants at a given tile position**
- oh3 and oh4 are **universal** across all tile positions and all variants

### Oligo design by tile type

The oligo structure is identical; only the overhang values and tile sequence differ:

**Leading tile (5' end of gene):**
- oh1 = first 4 nt of gene (e.g., ATGX)
- oh2 = gene sequence at tile's 3' boundary

**Internal tile (middle of gene):**
- oh1 = gene sequence at 5'WT/tile boundary
- oh2 = gene sequence at tile's 3' boundary

**Trailing tile (3' end of gene):**
- oh1 = gene sequence at 5'WT/tile boundary
- oh2 = last 4 nt of gene (at/near stop codon)

**Single-tile gene:**
- oh1 = first 4 nt of gene
- oh2 = last 4 nt of gene

### Oligo length budget

```
BsaI recognition + spacer (5' end):    7 nt
oh1 (overlaps with tile start):        0 nt (part of tile)
Tile:                                   variable
BsmBI reverse site (oh2):              11 nt  (recognition 6 + spacer 1 + overhang 4)
BsmBI forward site (oh3):              11 nt
Barcode:                               12 nt (default, configurable)
oh4:                                    ~4 nt
BsaI recognition + spacer (3' end):    7 nt
─────────────────────────────────────────
Fixed overhead:                        ~48-52 nt
Max tile size:                         ~248-252 nt (~82-84 codons) at 300 nt oligo max
```

**Important implementation note from Robert**: The max oligo length should be configurable (not hardcoded to 300), with a default that optimizes cost with Twist Bioscience. Their technology improves over time so the pipeline should adapt.

---

## Part 5: Helper Plasmid & Gene Block Design (NEEDS FURTHER DISCUSSION)

### What was proposed (needs adjustment per Robert)

The initial proposal was:

**Helper plasmid (one per tile position):**
```
backbone—PaqCI**—[5'WT]—BsaI→oh1—[stuffer]—oh4←BsaI—PaqCI*—backbone
```

**BsmBI fragment (one per tile position):**
```
BsmBI→oh2—[3'WT]—[PolIII]—oh3←BsmBI
```

**Assembly steps:**
1. BsaI (pooled): Replace stuffer with oligo (tile+barcode)
2. BsmBI (per-clone): Insert 3'WT+PolIII between tile and barcode
3. PaqCI: Move to final backbone

**Tile type variations proposed:**

| Tile type | 5'WT on helper plasmid | BsmBI fragment contents |
|-----------|----------------------|------------------------|
| Leading | empty | [3'WT (most of gene)] + [PolIII] |
| Internal | Gene from nt 1 to tile start | [3'WT (gene after tile)] + [PolIII] |
| Trailing | Gene from nt 1 to tile start | [PolIII] only |
| Single-tile | empty | [PolIII] only |

### Status: Robert indicated ALL of these need adjustment

Robert selected that the following all need changes:
- Helper plasmid structure
- BsmBI fragment design
- Step ordering or logic
- Multiple things

**The next conversation should start by asking Robert to explain his vision for the helper plasmid, BsmBI fragment, and assembly step logic.** He was about to describe his full design when we decided to capture the conversation state.

---

## Part 6: Items Still To Discuss

1. **Helper plasmid structure** — Robert's corrected design
2. **BsmBI fragment design** — Robert's corrected design
3. **Assembly step ordering** — Robert's corrected logic
4. **Multi-gene-block case** — For genes >~3000 bp where 5'WT or 3'WT+PolIII exceed synthesis limits
5. **Superblock splitting** — How to handle oversized gene blocks in the new architecture
6. **Enzyme site domestication** — Now needs to account for BsaI sites in addition to BsmBI and PaqCI
7. **Overhang selection** — Now needs BsaI overhangs (gene-sequence-dependent) + BsmBI overhangs + PaqCI overhangs
8. **Code refactoring plan** — Once architecture is finalized, significant changes needed to the existing codebase
9. **GitHub repo setup** — Remote was not added, code not committed/pushed

---

## Part 7: Enzyme Reference

| Enzyme | Recognition | Cut pattern | Overhang | Spacer | Temp |
|--------|------------|-------------|----------|--------|------|
| BsaI | GGTCTC | 1/5 downstream | 4-nt 5' overhang | 1 nt | 37C |
| BsmBI | CGTCTC | 1/5 downstream | 4-nt 5' overhang | 1 nt | 42C |
| PaqCI | CACCTGC | 4/8 downstream | 4-nt 5' overhang | 4 nt | 37C |

All three enzymes produce 4-nt overhangs. BsaI and BsmBI are isoschizomers in terms of cut pattern (same 1/5 offset) but have different recognition sequences, making them orthogonal.

---

## Part 8: Final Construct Architecture

The goal construct in the destination plasmid:

```
[Backbone]—PaqCI**—[Full gene with one mutation]—[PolIII promoter]—[Barcode]—PaqCI*—[Backbone]
```

Which expands to:

```
[Backbone]—PaqCI**—[5'WT]—[mutant tile]—[3'WT]—[PolIII]—[Barcode]—PaqCI*—[Backbone]
```

- The PolIII promoter (U6 with internal T7) sits between the gene and barcode
- This enables LABEL-Seq, VIS-Seq, and PerturbView readouts
- The PolIII promoter transcribes the barcode
