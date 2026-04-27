---
name: Hotfix Workflow (Emergency Response)
description: A fast-track workflow for fixing production bugs in ≤15 minutes. No Feasibility Report required. Characterization tests mandatory before any fix.
---

# 🔥 Hotfix Workflow (Emergency Response)

> Stop the bleeding, don't redesign the circulatory system.
> This workflow is for **production bugs only**. For new features, use `workflow-doings.md`.

---

## 🧠 Skill Integrations

The AI assumes the persona of an on-call SRE / Incident Responder:
- **`triage-issue`**: Explore the codebase to find root cause. Trace the error from symptom → origin across files.
- **`security-review`**: Check if the bug has security implications (data leak, auth bypass, injection).
- **`react-doctor`**: If the bug is frontend — scan for hook dependency issues, stale closures, render loops.
- **`tdd`**: Write a characterization test FIRST (locks current broken behavior), then write the fix test, then fix code.
- **`doublecheck`**: Verify the AI's root cause analysis isn't a hallucination before committing the fix.

---

## Trigger — When to Use This Workflow

| Input Type | Example |
|---|---|
| Production bug | `"Hotfix: login page returns 500 after deploy"` |
| Urgent fix | `"Emergency: payment webhook silently fails"` |
| Regression | `"Regression: dark mode toggle broke after last merge"` |
| User report | `"User reports: can't upload images > 2MB"` |

### ⚠️ This is NOT for:
- New features → use `workflow-doings.md`
- Refactoring → use `workflow-refactor.md`
- "Nice to have" fixes → create a regular idea with `workflow-idea.md`

---

## ⏱️ The 15-Minute Protocol

### Step 1 — REPRODUCE (2 min)
> Goal: Confirm the bug exists and understand symptoms.

**Actions:**
1. Read the error message / stack trace / user report.
2. If a URL is involved, use **Playwright MCP** (`browser_navigate` → `browser_snapshot` → `browser_console_messages`) to reproduce visually.
3. If backend, check logs / error output.

**Output:** A 1-line bug statement:
```
BUG: [Component/Route] does [wrong behavior] when [trigger condition].
Expected: [correct behavior].
```

**Rule:** If you CANNOT reproduce the bug in 2 minutes, STOP and ask the human for more context. Do NOT guess.

---

### Step 2 — ISOLATE (3 min)
> Goal: Find the exact file(s) and line(s) causing the issue.

**Actions:**
1. Trigger **`triage-issue`** skill — trace the error from entry point → root cause.
2. Use code graph tools if available (GitNexus `context()`, `impact()`) to map blast radius.
3. If no graph available: `grep_search` for the error message, trace imports manually.

**Output:**
```
ROOT CAUSE: [file:line] — [explanation of why it breaks]
BLAST RADIUS: [number of files affected]
SECURITY IMPACT: [NONE / LOW / HIGH — explain if HIGH]
```

**Rule:** If blast radius > 5 files, this is NOT a hotfix. Escalate to `workflow-doings.md` with a `sub_doings` task.

---

### Step 3 — LOCK (3 min)
> Goal: Write a test that captures the CURRENT (broken) behavior.

**Actions:**
1. Write a **characterization test** — a test that PASSES with the current broken code.
2. Write a **fix test** — a test that FAILS now but will PASS after the fix.

```
characterization_test: assert current_broken_behavior == True  ← PASSES now
fix_test:              assert expected_correct_behavior == True ← FAILS now
```

**Why:** This prevents "fix one bug, create three more." The characterization test ensures you don't accidentally change OTHER behaviors while fixing the target bug.

**Rule:** NEVER skip this step. If you fix code without tests, you are gambling with production.

---

### Step 4 — FIX (5 min)
> Goal: Minimal change to resolve the issue. NO refactoring.

**Principles:**
- **Minimal diff**: Change the fewest lines possible.
- **No side quests**: Do NOT "while I'm here, let me also..." — that's a separate task.
- **No refactoring**: If the fix reveals deeper architectural issues, note them but do NOT fix them now.
- **Defensive coding**: Add guard clauses, null checks, error boundaries as appropriate.

**Actions:**
1. Apply the fix.
2. Run `fix_test` — it must now PASS.
3. Run `characterization_test` — it must still PASS (behavior you didn't intend to change is preserved).
4. Run full test suite — no regressions.

---

### Step 5 — VERIFY (2 min)
> Goal: Confirm the fix works end-to-end.

**Actions:**
1. If frontend: Use **Playwright MCP** to visually confirm the fix (screenshot before/after).
2. If backend: Hit the endpoint / trigger the flow and confirm correct response.
3. Trigger **`doublecheck`** on your root cause analysis — make sure you're not hallucinating the fix.
4. Trigger **`security-review`** ONLY if Step 2 flagged security impact.

---

### Step 6 — SHIP
> Goal: Commit and document.

**Commit format:**
```
hotfix: [component] — [1-line fix description]

Root cause: [brief explanation]
Fixes: [issue number or bug report reference]
Tests: [characterization + fix test names]
```

**Documentation:**
Save a hotfix log to `plan/hotfixes/[XX]_[name].md`:
```markdown
# Hotfix [XX]: [Title]

- **Date:** [timestamp]
- **Severity:** [P0/P1/P2]
- **Root Cause:** [explanation]
- **Fix:** [what was changed]
- **Files Modified:** [list]
- **Tests Added:** [list]
- **Follow-up:** [any deeper issues to address later → create idea in workflow-idea]
```

---

## 🚫 Escalation Rules

| Condition | Action |
|---|---|
| Can't reproduce in 2 min | STOP → Ask human for reproduction steps |
| Blast radius > 5 files | ESCALATE → `workflow-doings.md` sub_doing |
| Fix requires > 50 lines changed | ESCALATE → `workflow-doings.md` sub_doing |
| Security vulnerability (HIGH) | FIX immediately + trigger full `workflow-audit.md` after |
| Root cause unclear after 5 min | STOP → Ask human. Don't guess on production. |

---

## 🧰 Workflow Skill Summary

*All skills are loaded dynamically from `.agent/skills/` without hardcoded absolute paths.*

| Skill | Step | Purpose |
|---|---|---|
| `.agent/skills/triage-issue` | 2 — Isolate | Trace error to root cause |
| `.agent/skills/security-review` | 2,5 — Isolate, Verify | Check for security implications |
| `.agent/skills/react-doctor` | 2 — Isolate | Hunt React-specific bugs |
| `.agent/skills/tdd` | 3 — Lock | Characterization + fix tests |
| `.agent/skills/doublecheck` | 5 — Verify | Verify AI's analysis isn't hallucinated |
