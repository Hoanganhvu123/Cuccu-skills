---
name: Autopilot Workflow (Master Orchestrator)
description: The "God Mode" workflow that autonomously drives an idea through Capture, Feasibility, and Execution phases. Now with Scaffold, Hotfix, and Refactor routing.
---

# 🤖 Autopilot Workflow (God Mode)

> A state-machine workflow that intelligently routes work through the right pipeline — whether it's a new project, a new feature, a refactor, or a hotfix — without human intervention, stopping only on IMPOSSIBLE constraints or completion.

---

## 🧠 Skill Integrations

When executing this workflow, the AI must act as a Senior Orchestrator:
- **`langgraph` / `langchain-architecture`**: Use state-machine principles to maintain context and pass data (the PRD, the Feasibility Report) cleanly between phases.
- **`context-window-management`**: Crucial for long-running executions. Before transitioning between phases, explicitly summarize the context to avoid token overflow.
- **`multi-agent-brainstorming`**: If the autopilot gets stuck in an execution loop, spin up an internal council to unblock before waking the human.

---

## Trigger — When to Use This Workflow

| Input Type | Example |
|---|---|
| Auto-build request | `"Autopilot: Build a new user analytics dashboard"` |
| End-to-end task | `"End-to-end: Implement Stripe webhooks for the app"` |
| God Mode | `"Devin mode: Refactor the authentication system"` |
| New project | `"Autopilot: Create a new SaaS dashboard from scratch"` |
| Emergency | `"Autopilot: Fix the login crash in production NOW"` |

---

## Step 0 — CLASSIFY Intent (REQUIRED FIRST)

Before entering any phase, the AI must classify the user's intent to pick the correct pipeline:

```
USER INPUT
     │
     ├── Is this a PRODUCTION BUG or EMERGENCY?
     │       └── YES → PIPELINE B: Hotfix (fast track)
     │
     ├── Is this a NEW PROJECT (no existing repo)?
     │       └── YES → PIPELINE C: Scaffold → Full Pipeline
     │
     ├── Is this a REFACTOR / TECH DEBT / CLEANUP?
     │       └── YES → PIPELINE D: Refactor
     │
     └── Is this a NEW FEATURE for existing project?
             └── YES → PIPELINE A: Standard (full pipeline)
```

---

## PIPELINE A: Standard Feature (Idea → Audit)

The default pipeline for new features in existing projects.

### PHASE 1: Capture (Trigger `workflow-idea.md`)
1. Ingest the user's raw prompt.
2. Silently execute the logic of `workflow-idea.md` (Mode C usually).
3. Generate and save the Idea document: `plan/ideas/[XX]_[name].md`.
4. Proceed immediately to Phase 2.

### PHASE 2: Evaluate (Trigger `workflow-impossible.md`)
1. Read the newly created `[XX]_[name].md`.
2. Silently execute the logic of `workflow-impossible.md`.
3. Score the feasibility.
   - 🔴 **IMPOSSIBLE**: Generate the report, save to `plan/possible/`, **HALT execution**, and ask the human for a decision.
   - 🟡 **COMPROMISE**: Generate the report, document the tradeoffs, and proceed.
   - 🟢 **POSSIBLE**: Generate the report and proceed.
4. Save the report: `plan/possible/[XX]_[name]_report.md`.
5. Proceed immediately to Phase 3.

### PHASE 3: Execute (Trigger `workflow-doings.md`)
1. Read the `[XX]_[name]_report.md`.
2. Transition into `workflow-doings.md` logic.
3. Break the epic down into Phase 1, Phase 2, etc. Create `plan/doings/[XX]_[epic].md`.
4. **Enter Autonomous Execution:**
   - Execute checklist items one by one.
   - Write tests (TDD).
   - If a test fails or a bug is found that takes >2 iterations to fix, **spawn a sub_doing** (`plan/doings/sub_doings/[XX].[Y]_bug.md`).
   - Fix the sub_doing, mark it complete, and return to the main file.
5. Once all checklists are `[x]`, move the main file to `plan/done/[XX]_[epic]_done.md`.
6. Proceed to Phase 4.

### PHASE 4: Audit & Release (Trigger `workflow-audit.md`)
1. Execute the `workflow-audit.md` sequence.
2. Perform Security, Agent Security, Performance, and UI/UX checks (4 dimensions).
3. If ALL dimensions pass, notify the human: `"Autopilot Complete. Epic is ready for review."`
4. If ANY dimension fails, generate Audit Report → spawn `sub_doing` for fixes → re-audit.

---

## PIPELINE B: Hotfix (Emergency Fast Track)

Bypasses Idea Capture and Feasibility. Goes straight to fix.

```
User reports bug → workflow-hotfix.md → workflow-audit.md (security only)
                   (15 min max)          (targeted scan)
```

### PHASE 1: Hotfix (Trigger `workflow-hotfix.md`)
1. Execute the 6-step hotfix protocol: REPRODUCE → ISOLATE → LOCK → FIX → VERIFY → SHIP.
2. If escalation triggered (blast radius > 5 files), **CONVERT to Pipeline A** automatically.
3. Save hotfix log: `plan/hotfixes/[XX]_[name].md`.

### PHASE 2: Targeted Audit
1. Run `workflow-audit.md` Dimension 1 (Security) ONLY.
2. Skip Dimensions 2-4 unless the hotfix touched auth/agent/frontend code.
3. Notify human: `"Hotfix deployed. Targeted audit passed."`

---

## PIPELINE C: New Project (Scaffold → Full Pipeline)

For when no project exists yet. Starts with scaffolding.

```
Scaffold → Idea/PRD → Evaluate → Build → Audit
(10 min)   (15 min)   (5 min)    (2-4h)  (30 min)
```

### PHASE 0: Scaffold (Trigger `workflow-scaffold.md`)
1. Execute the 6-step scaffold protocol: INTERVIEW → GENERATE → AGENTS.md → DESIGN → INFRA → INIT.
2. First commit is made. Project is now a live repo.
3. Proceed to Pipeline A Phase 1.

### PHASE 1-4: Standard Pipeline A
Continue with Capture → Evaluate → Execute → Audit as normal.

---

## PIPELINE D: Refactor (Safe Incremental)

For tech debt, code cleanup, pattern migration.

```
Audit scope → Lock tests → Plan commits → Execute → Verify → Document
```

### PHASE 1: Refactor (Trigger `workflow-refactor.md`)
1. Execute the 6-step refactor protocol: AUDIT → LOCK → PLAN → EXECUTE → VERIFY → DOCUMENT.
2. All commits use `refactor:` prefix.
3. Characterization tests are mandatory.

### PHASE 2: Full Audit (Trigger `workflow-audit.md`)
1. Run ALL 4 dimensions of `workflow-audit.md`.
2. Verify no regressions across the refactored area.
3. Notify human: `"Refactor complete. Full audit passed."`

---

## 🔄 Context Management Between Phases

Before transitioning between ANY phase, the AI MUST:

1. **Summarize** the current phase output in ≤200 words.
2. **Save** all artifacts to disk (plan/ directory).
3. **Clear** unnecessary context to prevent token overflow.
4. **Load** only what's needed for the next phase.

```
Phase N completes → Summarize → Save to disk → Clear context → Load Phase N+1 inputs
```

This prevents the #1 cause of Autopilot failures: context rot from accumulated token bloat.

---

## 🚫 HALT Conditions (Wake the human)

| Condition | Action |
|---|---|
| 🔴 IMPOSSIBLE verdict | HALT → Show report → Ask for decision |
| Hotfix blast radius > 5 files | HALT → Recommend converting to Pipeline A |
| > 3 failed audit retries | HALT → Show accumulated failures |
| Test suite completely broken | HALT → Don't try to fix blindly |
| Security CRITICAL finding | HALT → Notify immediately |
| Context window > 80% full | Summarize + save + clear before continuing |

---

## 🧰 Workflow & Skill Summary

*All workflows and skills are loaded dynamically without hardcoded absolute paths.*

### Workflows Orchestrated
| Workflow | Pipeline | Role |
|---|---|---|
| `workflow-scaffold.md` | C | Bootstrap new projects |
| `workflow-idea.md` | A, C | Capture and classify ideas |
| `workflow-impossible.md` | A, C | Feasibility evaluation |
| `workflow-doings.md` | A, C | Feature execution loop |
| `workflow-hotfix.md` | B | Emergency bug fixes |
| `workflow-refactor.md` | D | Safe tech debt cleanup |
| `workflow-audit.md` | A, B, C, D | QA Gatekeeper (always last) |

### Skills Used
| Skill | Phase | Purpose |
|---|---|---|
| `.agent/skills/langgraph` | Orchestration | State machine architecture |
| `.agent/skills/context-window-management` | Orchestration | Prevent context rot during long runs |
| `.agent/skills/multi-agent-brainstorming` | Blockers | Resolve deep execution blockers autonomously |
