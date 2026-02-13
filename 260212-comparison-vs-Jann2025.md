# Pipeline Comparison: dms-gg-oligo-pipeline vs. Jann et al. (2025)

## Overview

This document compares the **dms-gg-oligo-pipeline** (this repository) with the method
described in Jann et al. "A cost-effective and scalable barcoded library construction
method for deep mutational scanning studies" (bioRxiv 2025.05.29.656836; published in
PLOS Biology, 10.1371/journal.pbio.3003645). The comparison focuses on barcode
programmability, OPS compatibility, oligo pool usage, and overall design trade-offs.

---

## 1. Architecture Summary

| Feature | dms-gg-oligo-pipeline | Jann et al. |
|---|---|---|
| **Assembly strategy** | 3-enzyme Golden Gate only (BsaI + BsmBI + PaqCI) | 2-step: Gibson assembly, then BsaI Golden Gate |
| **Mutation encoding** | Fully specified codons (preferred human codon per AA) | NNK degenerate codons (32 codons per position) |
| **Barcode type** | Pre-assigned (programmed), one per variant | Random (6 degenerate N positions + position-specific fixed sequences) |
| **Barcode length** | 12 nt (configurable) | 30 nt (6N + 12bp fixed + 6N alternating pattern) |
| **Barcode-variant mapping** | Known by construction; no sequencing needed to establish the map | Requires short-read sequencing after Gibson step to establish barcode-variant associations |
| **Fragment size (mutable region)** | ~243 nt (~81 codons) per tile | 75 bp (25 codons) per fragment |
| **Number of tiles/fragments (1000 AA gene)** | ~13 tiles | 40 fragments |
| **Gene blocks needed** | WT gene blocks (synthesized once, reused) + helper plasmid | PCR-amplified 3' fragment per fragment library |
| **Cloning reactions** | One BsaI/BsmBI one-pot reaction per tile position | 43 Gibson reactions + 43 Golden Gate reactions (for PDR1) |
| **Tested gene length** | Designed for any length (superblock support) | PDR1 = 3,204 bp (1,068 AA) |
| **Organism target** | Mammalian (human codon bias) | Yeast (*S. cerevisiae*) |

---

## 2. Barcode Programmability

### dms-gg-oligo-pipeline: Programmed Barcodes (Major Advantage)

- Each variant gets a **unique, pre-assigned barcode** that is known before the experiment.
- Barcodes are designed computationally with guaranteed minimum Hamming distance (default >= 3),
  GC content filtering, homopolymer filtering, and enzyme site exclusion.
- **Prefix optimization for OPS**: The first k nucleotides (default k=8) are explicitly optimized
  for maximum Hamming distance, so that even partial sequencing reads (fewer cycles in in-situ
  sequencing) retain distinguishing power.
- No sequencing step is required to establish variant-barcode associations.
- Every mutation has exactly 1 barcode (configurable to more), enabling precise quantification
  without deconvolution.

### Jann et al.: Random Barcodes

- Barcodes contain **6 random (degenerate N) positions** interspersed with position-specific
  fixed sequences, totaling 30 nt.
- The fixed portions encode which codon position and fragment the mutation comes from,
  providing a "stratified" barcode structure.
- A **mandatory short-read sequencing step** after Gibson assembly is required to associate
  each random barcode with its variant.
- Multiple barcodes per mutation provide built-in replicates, which is useful for statistical
  power but adds complexity.
- The random barcode space is limited by the 6 degenerate positions (4^6 = 4,096 possible
  barcodes per position), though in practice sufficient for single-position NNK libraries (~32
  variants per position).

### Pros/Cons

| Aspect | Programmed (this pipeline) | Random (Jann et al.) |
|---|---|---|
| Barcode-variant map known a priori | Yes | No (requires sequencing) |
| Cost of barcode mapping | Zero | Sequencing costs per fragment |
| Barcode collisions | Impossible (designed) | Possible (probabilistic) |
| Multiple barcodes per variant | Configurable (default: 1) | Inherent (~multiple per mutation) |
| Statistical replication via barcodes | Requires explicit configuration | Built-in |
| Computational complexity | Higher (barcode design algorithm) | Lower (random generation) |
| Error correction capability | Guaranteed Hamming distance | Depends on random sampling |

---

## 3. Compatibility with RNA Barcodes for Optical Pooled Screening (OPS)

### dms-gg-oligo-pipeline: Explicitly Designed for OPS

This pipeline's architecture was designed with OPS compatibility as a primary goal:

- **PolIII promoter (U6 with internal T7)** is placed between the gene and the barcode,
  enabling transcription of the barcode as an RNA molecule.
- The final construct is:
  `[Backbone]--PaqCI--[gene+mutation]--[PolIII promoter]--[Barcode]--PaqCI--[Backbone]`
- The PolIII-transcribed RNA barcode can be detected by **in-situ sequencing** (ISS)
  methods used in optical pooled screens (e.g., FISSEQ, MERFISH-like approaches).
- **Prefix-optimized barcodes** are critical for OPS: in-situ sequencing typically runs
  fewer cycles than standard NGS, so having maximum information content in the first k
  bases dramatically improves variant identification with limited cycle count.
- Compatible with multiple readout modalities: LABEL-Seq, VIS-Seq, PerturbView.

### Jann et al.: Not Designed for OPS

- The paper does not discuss PolIII promoters, RNA barcodes, or optical pooled screening.
- Barcodes are located on the plasmid DNA and read out via standard short-read sequencing
  (Illumina).
- The barcode design (30 nt with interspersed random dinucleotides) is not optimized for
  in-situ sequencing, which requires high discriminability in early cycles.
- The random barcode structure means variant identity is not known until after a sequencing-based
  mapping step, making real-time OPS readout infeasible.
- **Adapting this method for OPS would require**: adding a PolIII promoter upstream of the
  barcode, redesigning the barcode for prefix-optimized Hamming distance, and establishing
  the variant-barcode map before the screen (which they already do, but the barcodes would
  need to be more carefully designed for ISS readout).

### Verdict

The dms-gg-oligo-pipeline is substantially better suited for OPS applications. The
combination of programmed barcodes + prefix optimization + PolIII transcription makes
it directly usable for optical pooled screening without modification. Jann et al.'s
method would require significant redesign to support OPS readouts.

---

## 4. Ability to Work with Oligo Pools

### dms-gg-oligo-pipeline: Native Oligo Pool Design

- Oligos are designed to be ordered as a **single pool from Twist Bioscience** (max 300 nt).
- All oligos share a **universal structure** (identical enzyme site scaffolding), which
  simplifies pool synthesis and quality control.
- For a 1,000 AA gene: ~20,000 oligos (20 variants/position) in one pool order.
- Oligos are used directly in Golden Gate reactions -- no PCR amplification step from the pool.
- The oligo pool IS the variant library; no intermediate cloning steps to establish it.

### Jann et al.: Oligo Pools (oPools) Are Central

- Also uses oligo pools (oPools), which are ~100-fold cheaper per base than dsDNA synthesis.
- oPools are 186-258 nt each, within standard synthesis limits.
- Each fragment library is a separate oPool (43 oPools for PDR1).
- oPools include Gibson homology arms, so they can be directly used in Gibson assembly.
- **Key difference**: each oPool covers only ONE fragment position (25 codons), so a long
  gene requires many separate oPools ordered and processed independently.

### Comparison

| Aspect | dms-gg-oligo-pipeline | Jann et al. |
|---|---|---|
| Pool format | Single pool, all tiles | One oPool per fragment (43 for PDR1) |
| Oligo length | Up to 300 nt | 186-258 nt |
| Ordering simplicity | One pool order | Many separate oPool orders |
| Pool complexity | ~20,000 oligos/pool (1000 AA gene) | ~800 oligos/oPool (25 positions x 32 NNK) |
| Direct use in assembly | Yes (Golden Gate) | Yes (Gibson), then Golden Gate for 3' end |
| PCR amplification needed | No (oligos used directly) | No (oPools used directly in Gibson) |

---

## 5. Other Design Considerations

### 5a. Mutation Precision

**dms-gg-oligo-pipeline**: Every oligo encodes a **single, specific amino acid substitution**
using the preferred human codon. This means:
- Exactly 20 variants per position (19 missense + 1 stop)
- No wasted library complexity on synonymous mutations
- No codon bias (each AA substitution represented equally)
- Post-check ensures no inadvertent enzyme site creation by mutant codons

**Jann et al.**: NNK degenerate codons encode all 32 codon possibilities:
- Unequal AA representation (Leu, Ser, Arg have 3 NNK codons; Met, Trp have 1)
- Synonymous mutations waste library space
- Stop codon (TAG) included, but UAA and UGA are not
- Cannot target specific codon choices (e.g., cannot optimize for human codon usage)

### 5b. Cloning Complexity and Throughput

**dms-gg-oligo-pipeline**:
- Requires synthesis of WT gene blocks (gene fragments, ~$0.05/bp) -- one-time cost per gene
- Requires a helper plasmid for BsaI assembly
- One Golden Gate reaction per tile position, but each contains all variants for that tile
- 3-enzyme system (BsaI + BsmBI + PaqCI) is more complex but handles everything in fewer steps

**Jann et al.**:
- No gene block synthesis needed (WT fragments come from PCR of existing plasmid)
- Two cloning steps per fragment: Gibson (oPool insertion) + Golden Gate (3' restoration)
- For PDR1 (43 fragments): 86 total cloning reactions + 43 sequencing runs for barcode mapping
- Simpler molecular biology (Gibson + single-enzyme Golden Gate) but more reactions overall

### 5c. Cost Structure

**dms-gg-oligo-pipeline**:
- Main costs: oligo pool synthesis (~$0.001/nt for pools) + WT gene block synthesis (~$0.05/bp)
- Gene blocks are one-time cost, reusable across experiments
- No sequencing cost for barcode mapping
- For a 1000 AA gene: ~$600 oligo pool + ~$300 gene blocks (rough estimate)

**Jann et al.**:
- Main costs: oPool synthesis + sequencing for barcode mapping per fragment
- oPools are very cheap (~$0.001/nt), but need many separate orders
- Sequencing costs scale with number of fragments
- No gene block synthesis cost (PCR-based)
- Authors emphasize ~100x cost advantage of oPools over dsDNA synthesis

### 5d. Scalability to Long Genes

**dms-gg-oligo-pipeline**:
- Superblock splitting handles genes of any length
- WT gene blocks are split at high-fidelity overhang junctions when >1800 bp
- Number of tiles increases linearly, but pool remains one order
- Designed and tested for long genes (integration test with 700-codon gene)

**Jann et al.**:
- Tested on 3,204 bp gene (1,068 AA) -- one of the longer genes tested in DMS
- Number of fragments scales linearly (75 bp each)
- Each fragment needs independent Gibson + Golden Gate + sequencing
- Labor/handling complexity scales with gene length more steeply

### 5e. Library Quality and Uniformity

**dms-gg-oligo-pipeline**:
- Uniform by design: each oligo is a specific sequence at known concentration
- No codon bias (every AA substitution has exactly one oligo)
- QC is computational (12 automated checks before synthesis)

**Jann et al.**:
- 98.4% mutation coverage achieved experimentally
- Gini coefficients consistently below 0.5 (good uniformity)
- NNK bias means some AA substitutions are overrepresented (up to 3x)
- Real experimental validation on PDR1 with drug resistance phenotyping

### 5f. Validation and Maturity

**dms-gg-oligo-pipeline**:
- Fully implemented and computationally tested (725 unit/integration tests)
- Not yet experimentally validated in a wet lab
- Based on established Golden Gate principles (DIMPLE, Fleishman lab approaches)

**Jann et al.**:
- Experimentally validated end-to-end on PDR1 in *S. cerevisiae*
- Functional data matches known resistance mutations in literature
- Published in peer-reviewed journal (PLOS Biology)
- Python analysis pipeline available (github.com/Landrylab/Jann_et_al_2025)

---

## 6. Summary of Pros and Cons

### dms-gg-oligo-pipeline -- Pros

1. **Programmed barcodes** eliminate the need for barcode-variant mapping by sequencing
2. **Prefix-optimized barcodes** enable optical pooled screening with limited sequencing cycles
3. **PolIII promoter** for RNA barcode transcription supports OPS, LABEL-Seq, VIS-Seq, PerturbView
4. **Fully specified codons** mean zero wasted library complexity on synonymous variants
5. **Universal oligo structure** simplifies pool ordering and manufacturing QC
6. **Single oligo pool order** for entire gene (vs. many oPools)
7. **No sequencing step** needed to establish barcode-variant map
8. **Human codon optimization** for mammalian expression systems
9. **Superblock support** for very long genes
10. **Comprehensive QC** (12 automated checks) before any synthesis

### dms-gg-oligo-pipeline -- Cons

1. **Not yet experimentally validated** in wet lab
2. **Requires WT gene block synthesis** (~$0.05/bp one-time cost)
3. **3-enzyme system** (BsaI + BsmBI + PaqCI) is molecularly more complex
4. **Requires a helper plasmid** for the BsaI assembly step
5. **Larger oligos** (up to 300 nt) may have higher synthesis error rates than shorter oPools
6. **Single barcode per variant** (default) means fewer internal replicates than random barcoding
7. **Gene domestication** must remove BsaI, BsmBI, AND PaqCI sites (more constraints)

### Jann et al. -- Pros

1. **Experimentally validated** on a real gene (PDR1) with functional data
2. **Very low cost** oPools (~100x cheaper/base than dsDNA)
3. **No gene block synthesis** needed (PCR from existing plasmid)
4. **Simple molecular biology** (Gibson + single-enzyme Golden Gate)
5. **Built-in replicates** from multiple random barcodes per variant
6. **Published and peer-reviewed** with companion analysis pipeline (gyoza)
7. **Only BsaI** needs to be domesticated (fewer enzyme constraints)
8. **Shorter oligos** (186-258 nt) may have better synthesis fidelity

### Jann et al. -- Cons

1. **Random barcodes** require a sequencing step to map variants (cost + time)
2. **Not designed for OPS** -- no PolIII promoter, no prefix optimization
3. **NNK degeneracy** wastes library space on synonymous mutations and unequal AA representation
4. **Many separate reactions** needed (43 Gibson + 43 Golden Gate for PDR1)
5. **Many separate oPool orders** required (one per fragment)
6. **Cannot control codon choice** (NNK gives whatever codons nature provides)
7. **Limited barcode complexity** per position (4^6 = 4,096 from 6 random positions)
8. **Barcode not transcribed** as RNA -- incompatible with in-situ readout methods
9. **75 bp fragment size** means more tiles and more reactions than necessary for oligo pool synthesis limits
10. **Yeast-focused** -- would need adaptation for mammalian systems

---

## 7. Recommendations

### Use dms-gg-oligo-pipeline when:
- You need **optical pooled screening** (OPS) compatibility
- You need **RNA barcodes** (PolIII-transcribed) for in-situ readout
- You want **programmed, known barcodes** without a mapping sequencing step
- You are working in **mammalian cells** with human codon-optimized variants
- You want **precise, uniform** variant representation (no NNK bias)
- You need **single-pool ordering** for simplicity

### Use Jann et al. when:
- You want an **experimentally validated** protocol with published results
- You are working in **yeast** (*S. cerevisiae*)
- **Low synthesis cost** is the primary constraint
- You want **built-in biological replicates** from multiple barcodes per variant
- Your readout is **standard NGS** (barcode sequencing), not optical/in-situ
- You have an **existing plasmid** with the WT gene for PCR template

---

## Sources

- Jann et al. (2025/2026). "A cost-effective and scalable barcoded library construction method
  for deep mutational scanning studies." PLOS Biology. https://doi.org/10.1371/journal.pbio.3003645
- Jann et al. bioRxiv preprint: https://www.biorxiv.org/content/10.1101/2025.05.29.656836v2
- Analysis code: https://github.com/Landrylab/Jann_et_al_2025
- Companion tool (gyoza): Durand, Pageau, Landry. Snakemake workflow for DMS data analysis.
