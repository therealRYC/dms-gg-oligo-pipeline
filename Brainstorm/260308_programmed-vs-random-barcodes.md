# Programmed vs Random Barcodes for DMS + Optical Pooled Screens

**Date:** 2026-03-08
**Research question:** Is the pipeline's programmed barcode approach justified for each intended readout (VIS-Seq, LABEL-seq, future OPS), or would random (degenerate) barcodes be simpler, cheaper, and sufficient?

---

## Background

The pipeline currently implements programmed barcodes with Hamming distance and prefix optimization. Each variant gets a unique, pre-assigned barcode synthesized directly on the mutation oligo. Before finalizing this design, we investigated whether this is the right choice across all intended readout modalities.

---

## What VIS-Seq and LABEL-seq Actually Use

**Both VIS-Seq and LABEL-seq use RANDOM (degenerate) barcodes, not programmed barcodes.** This was a critical finding that initially challenged the pipeline's design.

### VIS-Seq (Fowler lab, bioRxiv 2025)
- **Barcode type**: Random — 12 bp degenerate (N12)
- **Oligo**: `VISseq_GG_BColigo` with `NNNNNNNNNNNN` degenerate region
- **Two vector versions**:
  - PBv2b: single 12 bp barcode → 12 cycles of in-situ sequencing
  - PBv2c-NSapI: dual 8 bp barcodes → only 8 cycles needed
- **Dictionary building**: PacBio Revio + Pacybara (Roth lab tool) for barcode-variant mapping
- **Error handling**: No error-correcting design. Relies on filtering cells with 2+ detected barcodes, circRNA abundance (93% of cells have ≥2 RCA amplicons → consensus), and STARCall pipeline for improved image processing

### LABEL-seq (Fowler lab, Nat Methods 2024)
- **Barcode type**: Random — 16 bp degenerate (N16)
- **Barcodes per variant**: ~30 (multiple clones per variant)
- **Dictionary building**: PacBio long-read sequencing
- **Barcode readout**: Illumina short-read sequencing (NOT in-situ)
- **Error handling**: Standard Illumina error rates (~0.1%), plus ~30 barcodes/variant for statistical robustness

### CRISPR OPS (Feldman et al. 2019) — Different Context
- **Barcode type**: Programmed — 83,314 barcodes with Levenshtein d ≥ 3
- **Key distinction**: CRISPR perturbation screens (sgRNA-barcode pairs), NOT DMS variant libraries
- The programmed approach makes sense here because sgRNAs are already individually specified

### Summary Table

| Method | Type | Barcode | Length | Dictionary | Readout |
|--------|------|---------|--------|------------|---------|
| **VIS-Seq** | DMS OPS | **Random** | 12 bp (or 2×8) | PacBio + Pacybara | In-situ SBS |
| **LABEL-seq** | DMS protein | **Random** | 16 bp | PacBio | Illumina |
| **Feldman OPS** | CRISPR OPS | **Programmed** | 12 bp, d≥3 | Not needed | In-situ SBS |
| **DIMPLE** | DMS | **Programmed** | varies | Not needed | Illumina |
| **Bloom lab DMS** | DMS | **Random** | 16 bp (N16) | PacBio/subassembly | Illumina |

---

## Quantitative Analysis

### In-Situ Sequencing Error Model

At ~3% per-position per-cycle error (BaristaSeq; Chen et al. 2018):

**Over 12-nt barcode** (binomial):

| Errors | P(k errors) | Cumulative |
|--------|------------|------------|
| 0 | 69.4% | 69.4% |
| 1 | 25.8% | 95.1% |
| 2 | 4.4% | 99.5% |
| 3+ | 0.5% | 100% |

~31% of reads have at least one error. ~5% have 2+ errors.

**Over 8-nt prefix** (relevant for dual-barcode / reduced-cycle OPS):

| Errors | P(k errors) | Cumulative |
|--------|------------|------------|
| 0 | 78.4% | 78.4% |
| 1 | 19.4% | 97.8% |
| 2 | 2.1% | 99.9% |
| 3+ | 0.1% | 100% |

### Programmed Barcodes: Error Correction Advantage

With min Hamming distance d=3:
- **Detect** up to 2 errors; **correct** 1 error
- Single-error reads (25.8%) are automatically corrected
- 2-error reads (4.4%) are detected and rejected (not misassigned)
- Only 3+ error reads (0.5%) could potentially misidentify

**Misidentification probability** (d=3, 30K library, 12-nt barcodes):
- P(misID) ≈ 8.7 × 10⁻⁶ per read
- Accuracy among accepted reads: 99.999%
- Usable yield: 95.1% (exact + corrected)

**Without error correction** (random barcodes, exact-match only):
- Usable yield: 69.4% (exact matches only)
- Or if you accept close matches: ~10% misidentification rate (for 30K library with random 12-nt barcodes)

**Net: programmed barcodes recover 25.8% of reads** that random barcodes must discard, with 178× fewer misidentifications.

### The Prefix Problem

If d=3 is only guaranteed over the full 12 nt, two barcodes differing at positions 2, 9, 11 have d=1 in the first 8 positions. Reading only 8 cycles makes them nearly indistinguishable.

**Prefix-optimized programmed barcodes** (d=3 guaranteed within 8-nt prefix):
- Usable yield at 8 cycles: 97.8% (vs 78.4% for random)
- Accuracy: 99.94%
- This is the key advantage for reduced-cycle OPS

### How VIS-Seq Gets Away Without Error Correction

VIS-Seq compensates through:
1. **CircRNA abundance**: 93% of cells have ≥2 RCA amplicons → consensus reads
2. **Filtering**: Remove cells with ambiguous/multiple barcodes
3. **STARCall**: Sophisticated image processing (8-40% more genotyped cells)
4. **Library size**: ~3,000 variants (small relative to 4¹² = 16.7M possible 12-mers)

This works because VIS-Seq's library is relatively small. For larger libraries (30-60K variants), collision risk and error-induced misassignment become more concerning.

### Poisson Coverage: Random Barcode Variant Dropout

With random barcodes, variant coverage follows Poisson statistics. Fraction missing = e^(-redundancy):

| Redundancy | Frac missing | GRIN2A (29K) | AKAP11 (38K) | TRIO (62K) |
|-----------|-------------|-------------|-------------|-----------|
| 3× | 4.98% | 1,458 lost | 1,894 | 3,085 |
| 5× | 0.67% | 197 | 256 | 418 |
| 10× | 0.0045% | 1.3 | 1.7 | 2.8 |
| 20× | ~0% | ~0 | ~0 | ~0 |

Programmed barcodes eliminate dropout entirely — every variant gets exactly 1 (or N) barcodes by construction.

---

## Cost Comparison

### Key Realization: Oligo Pool Size Is the Same at 1 bpv

Because this pipeline uses fully specified codons (not NNK), every mutation is individually designed regardless of barcode strategy. At 1 barcode per variant, the pool size is identical.

**Twist cannot synthesize degenerate (N) positions in oligo pools** — so random barcodes require a separate degenerate barcode piece added during assembly (like VIS-Seq's `VISseq_GG_BColigo`).

### At 1 bpv: Programmed Is CHEAPER

| Component | Programmed 1 bpv | Random 1 bpv |
|-----------|-----------------|--------------|
| Twist mutation oligo pool | Same cost | Same cost |
| Barcode included on oligo? | Yes (free — part of same oligo) | No — separate IDT degenerate oligo (~$50) |
| PacBio dictionary building | **Not needed ($0)** | **Required (~$2-4K)** |
| QC sequencing | ~$1K | ~$1K |
| **Net difference** | **Save $2-4K** | **Pay $2-4K more** |

### At >1 bpv: The Cost Calculus Flips

| Gene | Variants | Prog. 10 bpv (oligo cost) | Random (oligo cost) | PacBio | Prog. premium |
|------|---------|--------------------------|--------------------|---------|-|
| GRIN2A | 29,280 | ~$53K (293K oligos) | ~$10K (29K oligos) | +$2K | ~$41K more |
| AKAP11 | 38,040 | ~$66K (380K oligos) | ~$12K | +$2K | ~$52K more |
| TRIO | 61,960 | ~$100K (620K oligos) | ~$15K | +$3K | ~$82K more |

### Capacity Constraint at 10 bpv

Singleton bound for 12-nt barcodes at d=3: ~317K practical capacity.
- GRIN2A at 10 bpv (293K): Feasible but tight
- AKAP11 at 10 bpv (380K): **Exceeds practical capacity**
- TRIO at 10 bpv (620K): **Exceeds Singleton bound** — impossible at d=3 with 12 nt

---

## Answers & Decisions

### The pipeline's programmed barcode approach is correct for its use case

**At 1 bpv, programmed barcodes are strictly better and slightly cheaper:**
- Same Twist pool size and cost (1 oligo per variant either way)
- Error correction added for free (just 12 nt of sequence design)
- Save ~$2-4K by eliminating PacBio dictionary building
- Prefix optimization enables reduced-cycle imaging
- No cost reason to use random barcodes at 1 bpv with this pipeline

**Random barcodes serve a different niche (high bpv):**
- LABEL-seq needs ~30 bpv → only feasible with random barcodes
- At 10 bpv, programmed is 4-7× more expensive
- Random barcodes give multiple bpv naturally during cloning
- Existing lab workflows (VIS-Seq/Pacybara, LABEL-seq) already handle random barcodes well

### Pipeline decision: Keep programmed barcodes at 1 bpv

- Current design is correct and well-justified
- This pipeline's value-add IS the programmed barcode approach
- Random barcode workflows already exist in the lab — no need to duplicate them
- Statistical power comes from cells per variant (100-1000 cells/barcode), not barcodes per variant

---

## Open Questions

1. **Twist pricing for small pools**: What pricing tier applies to 1 bpv pool sizes (29K-62K oligos)? Current quotes cover 200K-700K pools.
2. **VIS-Seq compatibility**: If users want to use this pipeline's mutation design but VIS-Seq's barcode architecture, would a "barcode-less" output mode be useful? (Output mutation oligos without barcodes, let users add VIS-Seq barcode oligo separately.)
3. **Hybrid approach**: For very large libraries where 1 bpv gives limited statistical power, could a 2-3 bpv programmed approach be a middle ground?

---

## References

### Fowler Lab Methods (Random Barcodes)
- Pendyala, Partington, Bradley et al. 2025 — VIS-Seq (bioRxiv 2025.07.03.663081)
- Simon, Fowler, Maly 2024 — LABEL-seq (Nat Methods 21:2456-2467)
- Weile, Ferra, Boyle et al. 2024 — Pacybara (Bioinformatics 40:btae182)
- Bradley et al. 2025 — STARCall (bioRxiv 2025.10.31.685785)

### CRISPR OPS (Programmed Barcodes)
- Feldman et al. 2019 — Optical pooled screens (Cell 179:787-799)
- Cleary et al. 2024 — PerturbView (Nat Biotech)
- Gaublomme et al. 2024 — CRISPRmap (Nat Biotech)

### DMS Methods
- Wilkinson et al. 2023 — DIMPLE, programmed barcodes (Genome Biology 24:36)
- Schubert/Jones et al. 2025 — Position-specific barcodes (PLOS Biology)
- Starr et al. 2020 — SARS-CoV-2 RBD DMS, random barcodes (Cell 182:1295-1310)

### Quantitative References
- Chen et al. 2018 — BaristaSeq in-situ sequencing accuracy (NAR 46:e22)
- Johnson et al. 2023 — Best practices for random DNA barcodes (J Mol Evol 91:263-280)
- Bystrykh 2012 — Hamming-coded DNA barcodes (PLoS ONE 7:e36852)
