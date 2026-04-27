---
description: A strict, checkbox-driven workflow for implementing validated ideas. Includes a dynamic sub-tasking system (sub_doings) for handling unexpected bugs or complex refactoring without cluttering the main epic.
---

# 🚀 Execution & Implementation Workflow (Doings)

> Turns feasibility reports into checkbox-driven coding plans.
> Sub-Doings tree isolates bugs and unexpected complexity.

---

## 🧠 Skill Integrations

When executing this workflow, the AI must actively leverage these skills:
- **`to-prd` & `to-issues`**: Use these in Step 2 to break down the Feasibility Report into actionable, vertical-slice checklists.
- **`tdd`**: During Step 3 (Execution Loop), use Test-Driven Development. Write tests before modifying core logic.
- **`triage-issue` & `react-doctor`**: When spawning a `sub_doings` bug fix, use these to investigate the root cause thoroughly and scan React code for deep bugs.
- **`request-refactor-plan`**: When spawning a `sub_doings` refactor, use this to ensure tiny, safe commits.
- **`output-skill`**: Prevents the AI from using placeholders (`// TODO`) and forces 100% complete code generation.
- **Stack-specific execution**: Automatically call `fastapi-pro` (Backend), `frontend-developer` (React/UI), or `rag-engineer` (AI) depending on the file being edited.

---

## Trigger
- `"Start doing idea 03"` / `"Implement possible/02_api.md"` / `"Spin off a sub-doing for this bug"`

---

## Step 0 — Validate (REQUIRED)

Load `plan/possible/[XX]_report.md`. Apply verdict gate:

| Verdict | Action |
|---|---|
| 🟢 POSSIBLE | Proceed |
| 🟡 COMPROMISE | Proceed — copy ALL trade-offs into Doings file |
| 🔴 IMPOSSIBLE | Hard stop — refuse unless user overrides with written reason |

---

## Step 1 — Micro-Scan (Exact, not high-level)

```
GitNexus indexed? → YES: use impact() / context() / query()
                 → NO:  manual: grep + trace imports + read entry points
```

Record per affected area: `file path | symbol | change type (ADD/MODIFY/DELETE) | blast radius`

**Rule:** blast radius > 5 callers → flag high-risk → add Rollback Plan.

---

## Step 2 — Determine File Number

Scan `plan/doings/` → find highest prefix → next = `[XX]_[epic_name].md`
Sub-doings use dot-notation: `01.1_`, `01.2_`, `01.2.1_`

---

## Step 3 — Execution Loop

```
Pick next unchecked [ ] task
  ├── Simple & contained? → implement → check [x] → next task
  └── Complex / bug / large refactor?
        → DO NOT expand main file
        → Spawn Sub-Doing → link in parent → resolve → return
```

**Blocked?** Update status to `🔴 Blocked — [reason]`. Resume when resolved.

---

## Step 4 — Completion Gate (ALL must pass before moving to done/)

```
[ ] All tasks checked [x]
[ ] All Sub-Doings resolved
[ ] No open bugs
[ ] Smoke test passed
[ ] Trade-offs confirmed — nothing silently skipped
→ Update status to ✅ Done
→ Move to: plan/done/[XX]_[epic_name]_done.md
```

---

## Template A — Main Epic

```markdown
# 🚀 DOING: [Epic Name]

## 📌 Context
- **Idea:** `plan/ideas/[XX]_name.md`
- **Report:** `plan/possible/[XX]_name_report.md`
- **Status:** 🚧 In Progress
  <!-- 🚧 In Progress | 🔴 Blocked — [reason] | ✅ Done -->

## 🎯 Goal
[One sentence. Measurable. No vague language.]

## ⚠️ Active Trade-offs
<!-- Carried from feasibility report — keep visible throughout -->
- Skipping: [feature] — [reason]
- Pinning: [dep@version] — [reason]
<!-- Write "None" if POSSIBLE with no trade-offs -->

## 🛠 Impact & Files Touched
| File | Symbol | Change | Blast Radius |
|------|--------|--------|--------------|
| `src/api/auth.ts` | `validate()` | MODIFY | 3 callers |

**Risk:** Low / Medium / High

## 🔙 Rollback Plan
<!-- Required if Risk = High. Otherwise: N/A -->

## 📋 Execution Checklist

### Phase 1: [Name] (~[time])
- [ ] Task 1.1: [file + function level action]
- [ ] Task 1.2:

### Phase 2: [Name] (~[time])
- [ ] Task 2.1:
- [ ] Task 2.2:

### Phase 3: Testing (~[time])
- [ ] Task 3.1: Write tests for [specific function]
- [ ] Task 3.2: Smoke test — verify [specific behavior]

## 🔄 Sub-Doings
_None yet_

## ✅ Completion Gate
- [ ] All tasks [x] | [ ] Sub-Doings resolved | [ ] Smoke test passed | [ ] Trade-offs confirmed

---
_Started: [YYYY-MM-DD] | Updated: [YYYY-MM-DD]_
```

---

## Template B — Sub-Doing

```markdown
# 🔧 SUB-DOING: [XX].[Y] — [Name]

## 📌 Context
- **Parent:** `plan/doings/[XX]_name.md`
- **Status:** 🚧 In Progress
- **Trigger:** [Why spawned — be specific]

## 🐛 Problem
[Error description, log output, or why scope exploded]

## 🔍 Investigation
- [ ] [Step 1]
- [ ] [Step 2]

## 🛠 Fix Plan
<!-- Fill after root cause is found -->
- [ ] [Fix step]
- [ ] Verify fix doesn't break parent epic's other tasks

## ✅ Resolution
**Root cause:** 
**Fix applied:** 
**Side effects:** 

---
_Started: [YYYY-MM-DD] | Resolved: [YYYY-MM-DD]_
```

---

## Quick Reference

```
Chain:    ideas/ → possible/ → doings/ → done/

Status:   🚧 In Progress | 🔴 Blocked — [reason] | ✅ Done

Spawn Sub-Doing when: bug needs investigation / scope expands
                      unexpectedly / decision tree too complex

Paths:
  Main:  plan/doings/[XX]_[epic].md
  Sub:   plan/doings/sub_doings/[XX].[Y]_[name].md
  Done:  plan/done/[XX]_[epic]_done.md
```

---

## 🧰 Workflow Skill Summary

*All skills are loaded dynamically from `.agent/skills/` without hardcoded absolute paths.*

| Skill | Phase | Purpose |
|---|---|---|
| `.agent/skills/to-prd` | Planning | Break epic into vertical slices |
| `.agent/skills/to-issues` | Planning | Generate checklist items |
| `.agent/skills/tdd` | Execution | Red-green-refactor loop |
| `.agent/skills/output-skill` | Execution | Force exhaustive code output |
| `.agent/skills/frontend-developer` | Execution | React/Next.js implementation |
| `.agent/skills/fastapi-pro` | Execution | Backend/API implementation |
| `.agent/skills/rag-engineer` | Execution | AI/LLM integration |
| `.agent/skills/triage-issue` | Sub-Doings | Root cause analysis for bugs |
| `.agent/skills/react-doctor` | Sub-Doings | React bug hunting |
| `.agent/skills/request-refactor-plan` | Sub-Doings | Safe refactoring plan |