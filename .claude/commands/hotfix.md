# /hotfix — Emergency Bug Fix (≤15 min)

Execute emergency hotfix protocol for: **$ARGUMENTS**

## Protocol (15-minute budget)

### Phase 1: Characterize (3 min)
1. Identify the bug from the description
2. Use @tdd-executor to write a **characterization test** that REPRODUCES the bug
3. Run the test → it MUST FAIL (confirming the bug exists)

### Phase 2: Fix (7 min)
1. Apply the MINIMAL fix — surgical changes only
2. Run characterization test → it MUST PASS
3. Run full test suite → all existing tests MUST still pass

### Phase 3: Verify (5 min)
1. Use @security-reviewer for targeted security scan on changed files
2. Commit with conventional format: `fix: [description]`
3. Report fix summary

## Rules
- ❌ NEVER refactor during a hotfix
- ❌ NEVER add new features during a hotfix
- ❌ NEVER modify more than 5 files
- ✅ If blast radius > 5 files → HALT and escalate to user
- ✅ If root cause unclear after 7 minutes → HALT and escalate
