<!-- Created: 2026-03-02 -->
<!-- Last updated: 2026-03-03 — Mark implementation items complete -->

# WPRE, PolyA, and PolII/PolIII Insulation Design

## Decision Summary

**Chosen downstream cassette architecture:**

```
[Gene 3' end] — [WPRE, ~592 bp] — [bGH polyA, ~225 bp] — [alpha-globin pause, ~90 bp] — [hU6+T7, ~260 bp] — [barcode, 20 bp] — [PolIII terminator, TTTTT 6 bp] — [PaqCI site + overhang, ~15 bp]
```

**Total cassette size: ~1,208 bp** (well within 1,800 bp synthesis limit, ~140 bp shorter than a cassette using hGH polyA at 1,347 nt).

---

## 1. bGH vs hGH PolyA — Silencing in iPSCs

**Verdict: Go with bGH polyA (~225 bp).**

No evidence that bGH polyA silences gene expression more than hGH polyA. Transgene silencing in iPSCs is overwhelmingly driven by **promoter CpG methylation**, not by the polyA signal.

### Evidence for bGH in iPSC constructs

- **AAVS1 knock-in vectors** (Addgene #22075 derivatives) use bGH polyA
- **PiggyBac reprogramming vectors** use bGH polyA
- **AAV vectors** for iPSC transduction use bGH polyA
- Anti-silencing studies using UCOEs and cHS4 insulators employ bGH polyA as the standard terminator without identifying it as a silencing contributor

### Notes on "hGH polyA" naming confusion

The "hGH" label in some patents actually refers to Chinese *hamster* GH polyA (used in CHO bioproduction), not human growth hormone polyA. There is no head-to-head comparison of bGH vs actual human GH polyA in the literature.

### Size advantage

Switching from hGH polyA (~363 bp trimmed) to bGH polyA (~225 bp) saves **138 bp**, partially offsetting the ~90 bp alpha-globin pause element addition.

---

## 2. PolII/PolIII Insulation — Literature Review

### The problem is real

The strongest evidence comes from **CROP-seq** (Datlinger et al. 2017). The authors explicitly state:

> *"Efforts to decrease this distance by moving the U6-sgRNA downstream of the pol II promoter and resistance gene have resulted in poor guide activity, potentially due to transcriptional interference."*

They solved this architecturally (LTR duplication) rather than with insulators.

### What the field does

| System | Solution | Insulator? |
|--------|----------|------------|
| CROP-seq (Datlinger 2017) | U6 in 3'LTR (duplicated to 5' during integration) | No — architectural solution |
| Perturb-seq | U6 placed **upstream** of PolII cassette | No — avoids the problem |
| scMPRA (Zhao 2023) | PolyA alone between PolII and U6 | No — but it worked |
| Lalanne et al. 2024 | PolII + polyA + U6 (tandem) | No — measured R^2 > 0.84 concordance |
| PerturbView / NIS-Seq | LTR architecture for CRISPR; T7 only used post-fixation | No |

**Critical nuance:** Most studies measured whether PolIII interferes with *PolII* expression, not the reverse. Our concern — PolII read-through suppressing PolIII barcode production — is less directly tested but more dangerous for barcode sequencing applications.

---

## 3. Recommended Insulation Strategy

### Tier 1 (Selected): WPRE + bGH polyA + alpha-2 globin pause

This provides the best evidence-to-size ratio.

#### WPRE (~592 bp)
- Enhances mRNA processing and nuclear export
- Reduces read-through transcription (high confidence)
- Standard element in lentiviral and AAV cassettes

#### bGH polyA (~225 bp)
- Well-validated terminator; no silencing concerns
- Shorter than hGH polyA, better characterized

#### Alpha-2 globin pause element (~90 bp)
- **Key addition.** Eggermont & Proudfoot (1993, EMBO J) showed polyA + pause was more effective at preventing tandem promoter interference than polyA alone
- Mechanism: slows PolII so Xrn2 exonuclease catches up and dislodges the polymerase (torpedo model)
- At only ~90 bp, it barely impacts the cassette budget
- Well-characterized functional element from the human alpha-2 globin 3' flanking region

### Alternative/additive: MAZ element (~50-100 bp)
- G-rich pause site (G5AG5 core) from human C2 complement gene
- Works synergistically with polyA signals (Ashfield et al. 1991, EMBO J)
- Very compact; could be added if pause alone is insufficient

### More conservative option: + cHS4 core (~250 bp)

For belt-and-suspenders insulation:

```
[Gene] — [WPRE] — [bGH polyA] — [alpha-globin pause] — [cHS4 core, ~250 bp] — [hU6+T7] — [barcode] — [PaqCI]
Total: ~1,458 bp (still within limits)
```

cHS4 core adds CTCF-mediated enhancer blocking — more relevant for chromatin-level insulation at integration sites (important for iPSCs where positional silencing is a concern). Does not directly help with read-through termination.

---

## 4. Size Budget Analysis

### Selected design (no cHS4):

| Element | Size (bp) |
|---------|-----------|
| WPRE | 592 |
| bGH polyA | 225 |
| Alpha-globin pause | ~90 |
| hU6 + embedded T7 | ~260 |
| Barcode | 20 |
| PolIII terminator (TTTTT) | 6 |
| PaqCI site + overhang | 15 |
| **Total** | **~1,208** |

### Notes on PolIII terminator and PaqCI

The PolIII terminator (TTTTT, 5-6 T's) should NOT be conflated with the PaqCI overhang. TTTT would be a poor overhang due to its homopolymer nature and extremely low fidelity (Potapov data confirms TTTT is the worst-performing overhang class). The PaqCI site + overhang is a separate element downstream of the PolIII terminator.

---

## 5. Confidence Assessment

| Claim | Confidence |
|-------|------------|
| PolII read-through past polyA is real (200-2000 bp) | **High** |
| WPRE reduces read-through transcription | **High** |
| Alpha-globin pause + polyA prevents tandem PolII interference | **High** (Eggermont & Proudfoot 1993) |
| U6 downstream of PolII cassette can have reduced activity | **High** (CROP-seq direct observation) |
| Alpha-globin pause specifically protects PolIII (U6) | **Speculative** (tested only for PolII-to-PolII) |
| bGH polyA doesn't silence in iPSCs | **High** (widely used, no reports) |
| scMPRA worked with polyA alone between PolII and U6 | **High** (Zhao et al. 2023) |

---

## 6. Key References

- Datlinger et al. (2017). *Pooled CRISPR screening with single-cell transcriptome readout.* Nature Methods.
- Eggermont & Proudfoot (1993). *Poly(A) signals and transcriptional pause sites combine to prevent interference between two closely spaced promoters.* EMBO J, 12(6):2539-48.
- Ashfield et al. (1991). *MAZ-dependent termination between closely spaced human complement genes.* EMBO J.
- Zhao et al. (2023). *scMPRA: massively parallel reporter assay at single-cell resolution.* (polyA-only insulation between PolII and U6)
- Lalanne et al. (2024). *Tandem PolII+polyA+U6 concordance study.* (R^2 > 0.84)

---

## 7. Next Steps

- [x] Obtain exact sequences for WPRE, bGH polyA ~~, and alpha-2 globin pause element~~
  - bGH polyA (225 bp) verified: pcDNA3.1 / GenBank J00008.1, EF550208.1, U55762.1
  - Alpha-globin pause **deferred** — not needed for field-standard design
- [x] Add elements to `intergene_elements` in pipeline config YAML
  - Updated `configs/grin2a.yaml` and `configs/grin2a_long_cassette.yaml`
- [x] Confirm no BsmBI/PaqCI sites in bGH polyA (verified clean)
- [ ] Run pipeline to verify cassette sizing and outputs (in progress)

## 8. Final Decision (2026-03-03)

**WPRE + bGH polyA, no additional insulation.** Follows field standard (Perturb-seq,
CROP-seq, lentiCRISPR v2). Alpha-globin pause and cHS4 available as future config-only
additions. See `docs/cassette_design_rationale.md` for full rationale.
