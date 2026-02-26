<!-- Created: 2026-02-26 -->
<!-- Last updated: 2026-02-26 — Initial creation -->

# Conversation Summary: Overhang Architecture Redesign Planning

**Date**: 2026-02-26 13:41 PST
**Session**: Multi-session planning effort (context compacted multiple times due to size)

## Objective

Decompose the overhang architecture redesign (BUG-006 and related issues) into parallel workstreams. This involved:
1. Synthesizing deep research on OOGGA scoring (Mukundan & Madhusudhan 2025) and Potapov Table 1 HF overhang sets
2. Making a design decision on how to integrate OOGGA scoring (Option A vs Option B)
3. Creating a comprehensive handoff document for parallel agents
4. Setting up 3 git worktrees for independent parallel implementation

## Key Design Decisions

### OOGGA Scoring — Option B Selected
- **Decision**: `score = P_fid(oh) * P_eff(oh) * (1 + w_hf * in_HF)` where `w_hf = 0.5` default
- `P_fid = M[X][RC(X)] / sum(M[X][*])` (individual overhang fidelity)
- `P_eff = M[X][RC(X)] / max(all diagonals)` (ligation efficiency relative to best possible)
- `in_HF` = 1 if overhang is in Potapov Table 1 Set 3, 0 otherwise
- Rationale: HF set bonus adds genuine value because it encodes pairwise cross-reactivity info that OOGGA's individual fidelity scoring doesn't capture

### Potapov Table 1 Set 3 (25 overhangs, 95.8% predicted set fidelity)
Correct sequences from actual paper PDF:
```
CCTC, CTAA, GACA, GCAC, AATC, GTAA, TGAA, ATTA, CCAG, AGGA,
ACAA, TAGA, CGGA, CATA, CAGC, AACG, AAGT, CTCC, AGAT, ACCA,
AGTG, GGTA, GCGA, AAAA, ATGA
```
Note: AAAA (homopolymer) is genuinely in the SA-optimized set.

### 5 Modular Tasks
- **Task A** (HF Set Fix): Replace greedy HF set with Potapov Table 1 Set 3
- **Task B** (Tile-Boundary Superblocks): Implement `partition_tile_superblocks()` and `get_tile_reaction_overhangs()`
- **Task C** (OOGGA Scoring): Upgrade scoring formula at 3 code locations in `06_overhang_selection.R`
- **Task D** (Integration): Wire tile-boundary SBs into `plan_assembly()` — depends on B
- **Task E** (Cassette Architecture): Large downstream cassette handling — depends on D
- Tasks A, B, C can run in parallel; D and E are sequential follow-ups

## Issues Encountered and Resolutions

### 1. Hallucinated Potapov Table 1 Overhangs (CRITICAL)
- **Issue**: Deep researcher extracted overhangs from the kappagate Python library (Edinburgh Genome Foundry), which had WRONG sequences — not the actual Potapov et al. 2018 paper values
- **Hallucinated set**: `GGAG, GATA, GGCA, GGTC, TCGC, GAGG, CAGT, GTAA, TCCA, CACA, GAAT, ATAG, AGTA, ATCA, TCTT, AGGT, CAAA, AAGC, GCAC, CAAC, AACG, CGAA, GTCT, TCAG, CCAT`
- **Fix**: User provided correct sequences from the actual PDF. Updated all files across all 3 worktrees + main. Added WARNING to MEMORY.md.
- **Lesson**: Do not trust automated extraction from third-party libraries for published data. Always verify against primary source.

### 2. Context Compaction
- **Issue**: The research + planning discussion was too large for a single context window, causing repeated compaction
- **Fix**: Created a self-contained handoff document (`Plans/260226_overhang-architecture-redesign.md`) and decomposed work into 3 parallel worktrees with independent Claude Code terminals

### 3. BUGS.md Merge Conflict
- **Issue**: Cherry-picking handoff doc commit from worktree to main caused a BUGS.md conflict (main had partial OOGGA update with "TBD", worktree had complete version)
- **Fix**: Resolved with `git checkout --theirs BUGS.md`

## Files Modified

### Created
- **`Plans/260226_overhang-architecture-redesign.md`** (~500 lines): Comprehensive handoff document covering current architecture, OOGGA research, Potapov sequences, tile-boundary SB design, 5 modular tasks with dependency graph, key code locations, and design decisions log
- **`tests/testthat/test-tile-boundary-superblocks.R`** (committed in prior session): 30+ tests for Task B functions

### Modified
- **`BUGS.md`** (all branches): Updated BUG-006 with correct Potapov sequences, full OOGGA research synthesis, finalized Option B decision
- **`MEMORY.md`**: Updated with OOGGA research findings, correct Potapov sequences, WARNING about kappagate library

## Git State at End of Session

### Branches pushed to origin
- `main` at `93d803d` — has handoff doc + BUGS.md updates
- `260226-hf-set-fix` at `93d803d` — Task A worktree (same as main, no work started)
- `260226-oogga-scoring` at `93d803d` — Task C worktree (same as main, no work started)
- `260226-tile-boundary-superblocks` at `9e03b21` — Task B worktree (ahead of main with test file)

### Worktrees
```
.claude/worktrees/260226-hf-set-fix/          → branch: 260226-hf-set-fix
.claude/worktrees/260226-tile-boundary-superblocks/ → branch: 260226-tile-boundary-superblocks
.claude/worktrees/260226-oogga-scoring/        → branch: 260226-oogga-scoring
```

## Outcome

Planning and setup complete. Three parallel worktrees created, pushed, and ready for independent Claude Code terminals to implement Tasks A, B, and C concurrently. User is spinning up the three terminals with provided prompts. Tasks D and E remain for after the parallel work merges.
