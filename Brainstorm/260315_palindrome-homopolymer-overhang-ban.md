# Why Palindromic and Homopolymer Overhangs Are Banned in Golden Gate Assembly

**Date:** 2026-03-15
**Context:** Investigating whether the last tile's oh2 (clamped to the stop codon) could be a set fidelity bottleneck. Several stop-codon-derived overhangs are palindromic (TTAA, CTAG) or near-homopolymeric, and score very well in the NEB BsmBI fidelity matrix — raising the question of why the field bans them.

## Research Question

Why does the Golden Gate assembly field ban palindromic and homopolymer overhangs, even though some of them rank among the highest-fidelity overhangs in the NEB Ligase Fidelity data?

## Key Findings

### The NEB fidelity matrix measures the wrong thing for these cases

The NEB Ligase Fidelity Viewer (Potapov et al. 2018) measures: *"Given a set of overhangs in a reaction, what fraction of ligation events at this junction produce the correct product?"*

This measurement implicitly assumes:
- Every ligation event preserves the correct **register** (no slipping)
- Every ligation event preserves the correct **orientation** (no flipping)

For normal overhangs (e.g., AGTC), both assumptions hold. For palindromes and homopolymers, they don't — and the assay can't distinguish correct from incorrect products when they produce identical gel bands / sequencing reads.

### Palindromes: loss of directionality

A palindromic overhang is identical to its own reverse complement (e.g., TTAA = RC(TTAA)). This causes:

1. **Fragment self-ligation**: Two copies of the same fragment can ligate end-to-end through the palindromic overhang (e.g., A→←A dimers), consuming fragments without producing correct assemblies.

2. **Misleading fidelity scores**: The fidelity matrix reports TTAA as highly specific (0.945, 99.6th percentile) because it strongly prefers annealing with TTAA over other overhangs like AGTC. But it can't distinguish correct-orientation ligation from wrong-orientation ligation — both involve TTAA:TTAA annealing.

### Homopolymers: register slippage

A homopolymer overhang (e.g., AAAA) can anneal in multiple shifted registers:

```
Correct:     5'-AAAA-3'        Shifted +1:    5'-AAAA-3'
             3'-TTTT-5'                       3'-TTTT-5'
             ||||                               |||
             4/4 match                         3/4 match — still anneals
```

This produces frame-shifted ligation products (insert 1–3 bp longer or shorter). The NEB fidelity score only measures whether AAAA ligates with AAAA vs. other overhangs — it doesn't capture register ambiguity.

## BsmBI Fidelity Data: Empirical Scores

### Homopolymers

| Overhang | Fidelity | Percentile | Note |
|----------|----------|------------|------|
| AAAA | 0.950 | 100.0th | **#1 of all 256 overhangs** |
| TTTT | 0.862 | 92.2nd | |
| CCCC | 0.552 | 24.2nd | |
| GGGG | 0.530 | 19.5th | |

### Palindromes (sorted by fidelity)

| Overhang | Fidelity | Percentile |
|----------|----------|------------|
| TTAA | 0.945 | 99.6th |
| TATA | 0.881 | 94.1st |
| TCGA | 0.837 | 89.8th |
| AATT | 0.801 | 85.2nd |
| ATAT | 0.793 | 83.6th |
| CTAG | 0.714 | 68.4th |
| ACGT | 0.630 | 48.8th |
| CATG | 0.605 | 43.0th |
| GTAC | 0.584 | 37.5th |
| GATC | 0.582 | 35.2nd |
| AGCT | 0.512 | 13.7th |
| GCGC | 0.432 | 3.5th |
| CGCG | 0.404 | 1.2nd |

### Overall BsmBI distribution (all 256 overhangs)

- Min: 0.355, Q1: 0.554, Median: 0.638, Q3: 0.744, Max: 0.950

## Relevance to Last-Tile oh2 Clamping

The last tile's oh2 is currently clamped to the gene end (last 4 nt = penultimate codon's last nt + stop codon). Of the 12 possible stop-codon overhangs:

- **2 are palindromic**: TTAA (0.945) and CTAG (0.714) — both filtered by our palindrome check
- **2 score poorly**: GTAG (0.562, 27.7th pct) and GTGA (0.561, 27.3rd pct)
- **8 score well**: above the median, with TAA-based overhangs dominating

The palindrome ban costs us the best possible stop-codon overhang (TTAA). However, this is appropriate for overhangs we *choose* — when forced (as with a clamped oh2), a high-fidelity palindrome may still be preferable to a low-fidelity non-palindrome.

## Decisions

- **The ban is well-justified for chosen overhangs**: empirically validated by labs doing 10+ fragment Golden Gate assemblies.
- **For forced overhangs (clamped last-tile oh2)**: the ban may be too conservative. A future improvement could allow the last tile's oh2 to extend into the cassette sequence rather than clamping to the stop codon, sidestepping the issue entirely.
- **The NEB fidelity matrix should not be trusted at face value** for palindromic or homopolymer overhangs — high scores reflect low cross-talk with other overhangs, not correct assembly.

## Open Questions

- If oh2 is allowed to extend into the cassette for the last tile, does this change the assembly chemistry? (The cassette is non-mutable, so the oh2 sequence would be fixed and predictable.)
- Should we relax the palindrome ban specifically for forced/clamped overhangs where no alternative exists?
- Are there empirical datasets quantifying the actual failure rate of palindromic overhangs in isolation (not confounded by set composition)?
