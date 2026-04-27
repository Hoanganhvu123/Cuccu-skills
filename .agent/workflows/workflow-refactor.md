---
name: Refactor Workflow (Tech Debt Crusher)
description: A safe, incremental refactoring workflow that locks current behavior with characterization tests before making any changes. One commit = one change. Never refactor and add features simultaneously.
---

# 🧹 Refactor Workflow (Tech Debt Crusher)

> Refactoring is surgery. Characterization tests are the anesthesia.
> One commit = one change. NEVER refactor and add features simultaneously.

---

## 🧠 Skill Integrations

The AI assumes the persona of a cautious surgeon operating on a live patient:
- **`acquire-codebase-knowledge`**: Map the entire affected area before touching anything.
- **`request-refactor-plan`**: Create a detailed plan with tiny, safe commits via user interview.
- **`improve-codebase-architecture`**: Find deepening opportunities informed by domain language and ADRs.
- **`tdd`**: Write characterization tests to lock current behavior before every refactor step.
- **`quality-playbook`**: Generate functional tests if none exist. Prevent "Coverage Theater".
- **`security-review`**: After refactoring auth/data paths, verify no security regressions.

---

## Trigger — When to Use This Workflow

| Input Type | Example |
|---|---|
| Explicit refactor | `"Refactor: consolidate all API key management into config.py"` |
| Tech debt | `"Tech debt: remove all hardcoded paths from codebase"` |
| Migration | `"Migrate: move from REST to GraphQL for user service"` |
| Modernization | `"Clean up: replace class components with hooks"` |
| Pattern change | `"Refactor: switch from prop-drilling to context for theme"` |

### ⚠️ This is NOT for:
- New features → use `workflow-doings.md`
- Production bugs → use `workflow-hotfix.md`
- Full rewrites → use `workflow-scaffold.md` to create new project, then migrate incrementally

---

## The Golden Rule

```
┌─────────────────────────────────────────────────────────┐
│  NEVER mix refactoring with feature work.               │
│  A refactor commit changes structure, not behavior.     │
│  A feature commit changes behavior, not structure.      │
│  Mixing them makes rollback impossible.                 │
└─────────────────────────────────────────────────────────┘
```

---

## Step 1 — AUDIT (Map the battlefield)
> Goal: Understand what you're about to change and what depends on it.

### 1.1 Knowledge Gathering
Trigger **`acquire-codebase-knowledge`** on the affected area:

**If GitNexus is indexed:**
```
impact(target="SymbolToRefactor", direction="upstream", maxDepth=3)
context(name="SymbolToRefactor", include_content=true)
```

**If NOT indexed:**
```
grep_search → trace imports → read entry points → map manually
```

### 1.2 Document the Scope
Create `plan/doings/[XX]_refactor_[name].md`:

```markdown
# Refactor: [Title]

## Scope
- **What changes:** [modules / patterns / files affected]
- **What does NOT change:** [explicit no-touch zones]
- **Blast radius:** [number of files / callers affected]

## Current State
- [Description of current architecture / pattern]
- [Why it's problematic]

## Target State
- [Description of desired architecture / pattern]
- [Why it's better]

## Risk Assessment
- [ ] Blast radius ≤ 10 files: LOW risk
- [ ] Blast radius 11-25 files: MEDIUM risk → Extra test coverage needed
- [ ] Blast radius > 25 files: HIGH risk → Break into multiple refactor PRs

## No-Touch Zones
- [File/module that MUST NOT be modified]
- [File/module that MUST NOT be modified]
```

**Rule:** If blast radius > 25 files, STOP and break the refactor into multiple smaller refactors. Each one gets its own `[XX]_refactor_[name].md` file.

---

## Step 2 — LOCK (Characterization tests)
> Goal: Write tests that prove current behavior BEFORE changing anything.

This is the **most critical step**. Skip it and you're gambling with production.

### 2.1 What are Characterization Tests?
Tests that capture what the code CURRENTLY does — including bugs, quirks, and edge cases.

```python
# Example: Characterization test for a function we're about to refactor
def test_get_user_current_behavior():
    """Locks current behavior. If this fails after refactor, something broke."""
    result = get_user(user_id=999)
    # Even if this behavior is "wrong", we lock it here.
    # We'll fix it in a SEPARATE commit after refactoring.
    assert result is None  # Currently returns None for missing users
    assert not result      # Not an exception, not a 404
```

### 2.2 Coverage Targets

| Risk Level | Required Coverage |
|---|---|
| LOW (≤ 10 files) | Characterization tests for all public functions in affected area |
| MEDIUM (11-25 files) | Above + integration tests for cross-module flows |
| HIGH (> 25 files) | Above + E2E tests for user-facing flows |

### 2.3 Run Baseline
Run ALL tests. They must **100% PASS** before any refactor begins.
Save the test results as your baseline. Any future failure = regression.

```
Baseline: XX tests, all passing.
Date: [timestamp]
```

---

## Step 3 — PLAN (Tiny commits strategy)
> Goal: Break the refactor into atomic steps. Each step = 1 commit.

Trigger **`request-refactor-plan`** skill:

### 3.1 Decomposition Rules
- Each commit changes **one thing**: rename, extract, inline, move, or restructure.
- Each commit is **independently deployable** — the app works after every single commit.
- Each commit has its own **test run** proving no regression.

### 3.2 Common Refactor Patterns

| Pattern | Description | Example Commit |
|---|---|---|
| **Extract** | Pull code into its own function/module | `refactor: extract auth logic into AuthService` |
| **Rename** | Change names for clarity | `refactor: rename getUserData to fetchUserProfile` |
| **Move** | Relocate to better module | `refactor: move utils/auth.py to services/auth_service.py` |
| **Inline** | Remove unnecessary abstraction | `refactor: inline single-use helper formatDate` |
| **Replace** | Swap implementation | `refactor: replace manual fetch with TanStack Query` |
| **Consolidate** | Merge duplicates | `refactor: consolidate 3 API key files into config.py` |

### 3.3 Commit Plan Format
```markdown
## Commit Plan

### Commit 1: [pattern] — [description]
- Files: [list]
- Test: [which test to run after]
- Rollback: `git revert HEAD` (safe because atomic)

### Commit 2: [pattern] — [description]
- Files: [list]
- Test: [which test to run after]
- Rollback: `git revert HEAD`

### Commit 3: ...
```

**Rule:** Maximum 10 commits per refactor. If you need more, split into multiple refactors.

---

## Step 4 — EXECUTE (One commit at a time)
> Goal: Apply each planned commit, test after each one.

### The Loop
```
FOR each commit in the plan:
  1. Make the change (one pattern only)
  2. Run characterization tests → must PASS
  3. Run full test suite → must PASS
  4. Commit with conventional format:
     refactor: [pattern] — [description]
  5. IF tests fail:
     a. Revert: git revert HEAD
     b. Investigate why
     c. If root cause is clear: fix and retry (max 2 retries)
     d. If unclear: STOP and ask human
```

### Execution Rules
- ✅ One pattern per commit (rename OR move OR extract — never combo)
- ✅ Tests after EVERY commit (not just at the end)
- ✅ If a commit breaks tests: revert immediately, don't try to "fix forward"
- ❌ NO feature additions ("while I'm here, let me also add...")
- ❌ NO cosmetic changes mixed with structural changes
- ❌ NO "big bang" commits that change 20 files at once

---

## Step 5 — VERIFY (Full regression check)
> Goal: Prove the refactor didn't break anything.

**Actions:**
1. Run full test suite (unit + integration + E2E if available).
2. Compare test count: must be ≥ baseline (you should have MORE tests, not fewer).
3. If frontend was refactored: trigger **`web-design-reviewer`** to visually verify no UI regression.
4. If auth/security paths were refactored: trigger **`security-review`** for a targeted scan.
5. Compare characterization test results with baseline — all must still PASS.

**Verification Report:**
```markdown
## Refactor Verification

| Metric | Before | After |
|---|---|---|
| Total tests | XX | XX (+N new) |
| Passing | XX | XX |
| Files changed | — | XX |
| Lines added | — | +XX |
| Lines removed | — | -XX |
| Net LOC change | — | [±XX] |

Result: ✅ PASS / ❌ FAIL (revert required)
```

---

## Step 6 — DOCUMENT
> Goal: Update project knowledge so future AI sessions understand the new structure.

**Actions:**
1. Update `AGENTS.md` — reflect new architecture/patterns.
2. If architectural decision was made, create ADR in `docs/adr/`:
```markdown
# ADR-[XX]: [Decision Title]

## Status: Accepted
## Date: [date]

## Context
[Why the old pattern was problematic]

## Decision
[What we changed and why]

## Consequences
- [Positive: ...]
- [Negative: ...]
- [Neutral: ...]
```
3. Mark the refactor file as done: move to `plan/done/[XX]_refactor_[name]_done.md`.

---

## 🚫 Anti-Patterns (NEVER do these)

| Anti-Pattern | Why It's Dangerous |
|---|---|
| "Refactor + Feature" combo | Impossible to rollback one without the other |
| "Big Bang" refactor (50+ files, 1 commit) | Cannot isolate which change broke what |
| Refactoring without characterization tests | "Fixed" code that silently changes behavior |
| Refactoring code you don't understand | Ask `acquire-codebase-knowledge` first |
| Skipping the plan step | Leads to "refactor drift" — scope creep during execution |
| "While I'm here..." syndrome | Opens Pandora's box. Create a new idea instead. |

---

## 🧰 Workflow Skill Summary

*All skills are loaded dynamically from `.agent/skills/` without hardcoded absolute paths.*

| Skill | Step | Purpose |
|---|---|---|
| `.agent/skills/acquire-codebase-knowledge` | 1 — Audit | Map affected area and dependencies |
| `.agent/skills/request-refactor-plan` | 3 — Plan | Create tiny, safe commit strategy |
| `.agent/skills/improve-codebase-architecture` | 1 — Audit | Identify deeper improvement opportunities |
| `.agent/skills/tdd` | 2 — Lock | Write characterization + regression tests |
| `.agent/skills/quality-playbook` | 2 — Lock | Generate missing functional tests |
| `.agent/skills/security-review` | 5 — Verify | Scan for security regressions |
| `.agent/skills/web-design-reviewer` | 5 — Verify | Visual regression check (if frontend) |
| `.agent/skills/conventional-commit` | 4 — Execute | Consistent commit messages |
