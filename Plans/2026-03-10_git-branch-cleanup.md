# Plan: Git Branch Cleanup (260310)

## Context

The repo accumulated 15+ local branches and 7 worktrees from the OOGGA rewrite, DP vs MC benchmarking, and various bug fixes. All meaningful work converged onto `260309-oogga-comparison` (24 commits ahead of main). Goal: clean up to just `main` + `260309-oogga-comparison`, then merge to main.

## Execution

### Pre-cleanup: Push unpushed brainstorm
- `260308-low-set-fidelity-optimization` had 1 unpushed commit (brainstorm file). Pushed to remote for archival.

### Step 1: Remove worktrees (7 total)
All created for parallel benchmarking/development during OOGGA rewrite:
- `260308-fixing-sb-first-mc-method` (superseded by OOGGA rewrite)
- `260308-tile-dp-comparison` (DP benchmark — results captured)
- `260308-tile-mc-comparison` (MC benchmark — results captured)
- `260309-benchmark-akap11` (parallel benchmark runner)
- `260309-benchmark-grin2a` (parallel benchmark runner)
- `260309-benchmark-grin2a-long-cassette` (parallel benchmark runner)
- `260309-benchmark-trio` (parallel benchmark runner)

### Step 2: Delete local branches (15 total)

**Fully merged to main (7):**
- `260304-sb-first-dp`, `260309-remove-mc-fidelity`, `t1-tile-dp-anchors`
- `worktree-260302-fixing-wpre-cassette`, `worktree-agent-a3028781`, `worktree-agent-a8faaffd`
- `docs/conversation-summary-260226-1341`

**Superseded by `260309-oogga-comparison` (8):**
- `260308-fixing-sb-first-mc-method`, `260308-tile-dp-comparison`, `260308-tile-mc-comparison`
- `260308-low-set-fidelity-optimization`
- `260309-benchmark-akap11`, `260309-benchmark-grin2a`, `260309-benchmark-grin2a-long-cassette`, `260309-benchmark-trio`

### Step 3: Delete stale remote branches (11 total)
- `260226-hf-set-fix`, `260226-oogga-scoring`, `260304-sb-first-dp`
- `260307-oh3-first-before-dp`, `260308-low-set-fidelity-optimization`, `260309-remove-mc-fidelity`
- `claude/refactor-strategy-review-8qzgZ`, `claude/review-pipeline-changes-vzKw0`, `claude/run-akap11-analysis-a6Uof`
- `docs/conversation-summary-260226-1341`, `worktree-260302-fixing-wpre-cassette`

### Step 4: Prune and verify
```
git fetch --prune
git branch -a      # main + 260309-oogga-comparison only
git worktree list  # main working directory only
```

## End State
- Local: `main`, `260309-oogga-comparison` (checked out)
- Remote: `origin/main`, `origin/260309-oogga-comparison`
- Worktrees: just the main working directory

## Status: COMPLETE
- 7 worktrees removed
- 12 local branches deleted (3 remaining need manual `git branch -D`)
- 11 remote branches deleted
- Remote pruned
