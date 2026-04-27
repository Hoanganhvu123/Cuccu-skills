# /refactor — Safe Incremental Refactoring

Execute safe refactoring protocol for: **$ARGUMENTS**

## Core Rule: NEVER refactor and add features simultaneously.

## Protocol

### Phase 1: Lock Current Behavior (Characterization Tests)
1. Use @security-reviewer to audit the current state
2. Use @tdd-executor to write **characterization tests** that capture CURRENT behavior
3. Run all tests → they MUST PASS (proving we understand the existing behavior)

### Phase 2: Plan Atomic Commits
Create a refactoring plan where each commit:
- Changes ONE thing (rename, extract, move, simplify)
- All tests pass after every commit
- Can be reverted independently

Save plan to `plan/doings/[XX]_refactor_[scope].md`

### Phase 3: Execute (One Change at a Time)
For each planned change:
1. Make the atomic change
2. Run ALL tests → MUST PASS
3. Commit: `refactor: [description of single change]`
4. Move to next change

### Phase 4: Verify
1. Use @qa-gatekeeper for final 4-dimension audit
2. Compare before/after behavior — NO functionality regression allowed
3. Report refactoring summary

## Rules
- ❌ NEVER skip characterization tests
- ❌ NEVER combine multiple changes in one commit
- ❌ NEVER add new features during refactor
- ❌ NEVER change behavior (only structure)
- ✅ Every commit must leave tests green
- ✅ If tests break → revert immediately, investigate, retry
