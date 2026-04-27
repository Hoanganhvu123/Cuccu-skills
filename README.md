<p align="center">
  <img src="https://img.shields.io/badge/Workflows-8-blue?style=for-the-badge" />
  <img src="https://img.shields.io/badge/Skills-30+-green?style=for-the-badge" />
  <img src="https://img.shields.io/badge/Pipelines-4-purple?style=for-the-badge" />
  <img src="https://img.shields.io/badge/Sub--Agents-5-red?style=for-the-badge" />
  <img src="https://img.shields.io/badge/Hooks-3-orange?style=for-the-badge" />
  <img src="https://img.shields.io/badge/Commands-5-cyan?style=for-the-badge" />
  <img src="https://img.shields.io/badge/License-MIT-yellow?style=for-the-badge" />
</p>

# 🤖 Cuccu Skills — Autonomous Agentic SDLC

> **An 8-workflow, 30+ skill ecosystem that takes an idea from concept to production-ready code with minimal human intervention.**

Built on top of [Karpathy's coding principles](https://github.com/forrestchang/andrej-karpathy-skills), extended with a full autonomous SDLC (Software Development Lifecycle) powered by structured workflows, proactive skill-based validation, and strict quality gates.

---

## 🧠 Philosophy

From Andrej Karpathy:

> *"LLMs are exceptionally good at looping until they meet specific goals... Don't tell it what to do, give it success criteria and watch it go."*

This project operationalizes that insight into a **complete development system** where AI agents:

1. **Think before coding** — Surface assumptions, present tradeoffs, push back when needed.
2. **Keep it simple** — Minimum code that solves the problem. If 200 lines could be 50, rewrite it.
3. **Make surgical changes** — Touch only what you must. Every changed line traces to the request.
4. **Execute goal-driven** — Define success criteria. Loop until verified through tests.

---

## 📁 Project Structure

```
.agent/
├── AGENTS.md                    ← 🏛️ Constitution (AI reads this first every session)
├── skills/                      ← 🧰 30+ specialized skills
│   ├── security-review/         
│   ├── quality-playbook/        
│   ├── react-doctor/            
│   ├── ui-ux-pro-max/           
│   ├── tdd/                     
│   ├── grill-me/                
│   ├── brainstorming/           
│   └── ... (30+ more)
├── workflows/                   ← ⚙️ 8 interconnected workflows
│   ├── workflow-autopilot.md    
│   ├── workflow-scaffold.md     
│   ├── workflow-idea.md         
│   ├── workflow-impossible.md   
│   ├── workflow-doings.md       
│   ├── workflow-hotfix.md       
│   ├── workflow-refactor.md     
│   └── workflow-audit.md        
└── rules/                       ← 📏 Scoped rules (per-domain)
```

---

## ⚙️ The 8 Workflows

### System Architecture

```
                    ┌─────────────────────┐
                    │  workflow-scaffold   │ ← Bootstrap new project
                    │  🏗️ ~10 min          │
                    └──────────┬──────────┘
                               │
                    ┌──────────▼──────────┐
                    │  workflow-idea       │
                    │  💡 ~15 min          │
                    └──────────┬──────────┘
                               │
                    ┌──────────▼──────────┐
                    │  workflow-impossible │
                    │  🔬 ~5 min           │
                    └──────────┬──────────┘
                               │
              ┌────────────────┼────────────────┐
              │                │                │
   ┌──────────▼──────────┐ ┌──▼───────────┐ ┌──▼───────────────┐
   │  workflow-doings     │ │  workflow-   │ │  workflow-hotfix  │
   │  🚀 ~2-4 hours      │ │  refactor 🧹 │ │  🔥 ~15 min       │
   └──────────┬──────────┘ │  ~1-2 hours  │ └──────────┬───────┘
              │            └──────┬───────┘            │
              └───────────┬───────┘                    │
                          │                            │
               ┌──────────▼──────────┐                 │
               │  workflow-audit     │◄────────────────┘
               │  🛡️ ~30 min         │
               └─────────────────────┘

    ┌──────────────────────────────────────────────┐
    │  workflow-autopilot 🤖 God Mode              │
    │  Routes: A=Feature, B=Hotfix, C=New, D=Refactor │
    └──────────────────────────────────────────────┘
```

---

### 🤖 `workflow-autopilot.md` — God Mode (Master Orchestrator)

The brain of the system. Classifies user intent and routes to the correct pipeline automatically.

| Pipeline | Route | Use Case | Time |
|---|---|---|---|
| **A** | Idea → Evaluate → Build → Audit | New feature for existing project | ~3-5h |
| **B** | Fix → Targeted Audit | Production bug (emergency) | ~15min |
| **C** | Scaffold → Idea → Build → Audit | Brand new project from scratch | ~4-6h |
| **D** | Audit → Lock → Plan → Execute → Verify | Tech debt / refactoring | ~1-2h |

**Trigger:** `"Autopilot: Build a user analytics dashboard"`

---

### 🏗️ `workflow-scaffold.md` — Project Bootstrap

Creates a new project from zero to ready-to-code in 10 minutes.

**What it generates:**
- 📁 Folder structure (3 templates: Full-Stack, Frontend-Only, Backend-Only)
- 🤖 `AGENTS.md` — AI context file with Karpathy's principles baked in
- 🎨 `DESIGN.md` + `design-tokens.css` — Design system tokens
- ⚙️ `.env.example`, `.gitignore`, `README.md`
- 📋 `plan/` directory — Pre-configured for workflow integration

**Trigger:** `"Scaffold: VidFash AI Studio"`

---

### 💡 `workflow-idea.md` — Idea Capture

Adaptive workflow that detects idea type and handles it accordingly.

| Mode | Type | Example |
|---|---|---|
| **A** | Concrete feature | "Add dark mode to the dashboard" |
| **B** | Vague concept | "Something to help with content creation" |
| **C** | Technical spec | "Implement WebSocket pub/sub for real-time sync" |

**Skills activated:** `brainstorming`, `multi-agent-brainstorming`, `grill-me`, `competitive-landscape`

**Output:** `plan/ideas/[XX]_[name].md`

**Trigger:** `"Idea: AI-powered contract review tool"`

---

### 🔬 `workflow-impossible.md` — Feasibility Evaluation

Stress-tests ideas against real constraints. No fluff — honest verdicts only.

**Verdicts:**
- 🟢 **POSSIBLE** — Proceed to execution
- 🟡 **COMPROMISE** — Possible with documented tradeoffs
- 🔴 **IMPOSSIBLE** — Halt. Ask human for decision.

**Scoring dimensions:** Technical complexity, resource requirements, time constraints, dependency risks.

**Output:** `plan/possible/[XX]_[name]_report.md`

---

### 🚀 `workflow-doings.md` — Execution Loop

The coding workhorse. Strict TDD-driven implementation with built-in bug isolation.

**Key features:**
- Checkbox-driven progress tracking
- **TDD loop:** Red → Green → Refactor
- **Sub-doing isolation:** Bugs that take >2 iterations to fix get spawned into `plan/doings/sub_doings/[XX].[Y]_bug.md` — preventing contamination of the main epic.

**Output:** `plan/doings/[XX]_[epic].md` → `plan/done/[XX]_[epic]_done.md`

---

### 🔥 `workflow-hotfix.md` — Emergency Response

Fix production bugs in ≤15 minutes. No Feasibility Report required.

**The 6-Step Protocol:**
```
REPRODUCE (2min) → ISOLATE (3min) → LOCK (3min) → FIX (5min) → VERIFY (2min) → SHIP
```

**Key rules:**
- Characterization tests MANDATORY before any fix
- Blast radius > 5 files? → Escalate to `workflow-doings.md`
- Fix > 50 lines changed? → Escalate to `workflow-doings.md`
- Motto: *"Stop the bleeding, don't redesign the circulatory system."*

**Output:** `plan/hotfixes/[XX]_[name].md`

**Trigger:** `"Hotfix: login page returns 500 after deploy"`

---

### 🧹 `workflow-refactor.md` — Tech Debt Crusher

Safe, incremental refactoring. One commit = one change.

**The 6-Step Protocol:**
```
AUDIT → LOCK → PLAN → EXECUTE → VERIFY → DOCUMENT
```

**Key rules:**
- **NEVER** refactor and add features simultaneously
- Characterization tests lock current behavior before changes
- Each commit is independently deployable and tested
- Blast radius > 25 files? → Split into multiple refactors

**Anti-patterns blocked:**
- "While I'm here..." syndrome
- Big-bang refactors (50+ files, 1 commit)
- Refactoring code you don't understand

**Trigger:** `"Refactor: consolidate all API key management into config.py"`

---

### 🛡️ `workflow-audit.md` — QA Gatekeeper

The final gate before anything reaches production. 4-dimensional quality scan.

| Dimension | What It Checks | Skills Used |
|---|---|---|
| **🔒 Security** | Injection, auth bypass, secrets exposure, OWASP Top 10 | `security-review`, `secret-scanning`, `mcp-security-audit` |
| **🤖 Agent Security** | OWASP ASI Top 10, prompt injection, tool misuse | `agent-owasp-compliance`, `threat-model-analyst` |
| **⚡ Performance** | N+1 queries, bundle size, coverage theater | `quality-playbook`, `react-doctor` |
| **🎨 UI/UX** | Visual regression, responsive design, premium feel | `web-design-reviewer`, `premium-frontend-ui`, `ui-ux-pro-max` |

**Verdict:** All 4 dimensions must PASS. Any failure → spawn `sub_doing` → fix → re-audit.

---

## 🧰 Skills Registry (30+)

### Tier S — Core (Used in every pipeline)
| Skill | Purpose |
|---|---|
| `security-review` | 8-step deep security scan across the entire codebase |
| `quality-playbook` | Creates a 6-artifact quality system, prevents "Coverage Theater" |
| `tdd` | Test-Driven Development with red-green-refactor loop |
| `doublecheck` | 3-layer anti-hallucination verification pipeline |

### Tier A — Specialized
| Skill | Purpose |
|---|---|
| `agent-owasp-compliance` | Maps agent behaviors to ASI Top 10 risks |
| `threat-model-analyst` | Full STRIDE-A threat model analysis |
| `mcp-security-audit` | Audits MCP server configurations for secrets/injection |
| `secret-scanning` | Pre-commit secret scanning and push protection |
| `react-doctor` | Catches React-specific issues (hooks, renders, state) |
| `triage-issue` | Traces bugs from symptom → root cause |

### Tier B — Enhancement
| Skill | Purpose |
|---|---|
| `web-design-reviewer` | Playwright-based visual inspection and design verification |
| `premium-frontend-ui` | Advanced motion, typography, and architectural craftsmanship |
| `ui-ux-pro-max` | 50 styles, 21 palettes, 50 font pairings, 9 tech stacks |
| `acquire-codebase-knowledge` | Maps entire codebase for onboarding and architecture review |
| `brainstorming` | Transforms vague ideas into validated designs |
| `grill-me` | Relentless interview to stress-test plans and designs |
| `request-refactor-plan` | Creates detailed refactor plans with tiny commits |
| `improve-codebase-architecture` | Finds deepening opportunities in existing codebases |

### Tier C — Domain-Specific
| Skill | Purpose |
|---|---|
| `frontend-design` | Production-grade frontend interfaces |
| `frontend-developer` | React 19, Next.js 15 architecture |
| `fastapi-pro` | High-performance async APIs with FastAPI |
| `fastapi-templates` | Production-ready FastAPI project templates |
| `langgraph` | Stateful multi-actor AI agent applications |
| `langchain-architecture` | LLM applications with agents, memory, tools |
| `rag-engineer` | Retrieval-Augmented Generation systems |
| `prompt-engineering-patterns` | Advanced prompt engineering for production |
| `context-window-management` | Managing LLM context windows effectively |
| `seo-audit` | Technical SEO diagnostics |
| `pricing-strategy` | Pricing, packaging, and monetization |
| `competitive-landscape` | Porter's Five Forces, market positioning |
| `startup-analyst` | Market sizing, financial modeling, strategy |
| `micro-saas-launcher` | Ship profitable SaaS in weeks |

---

## 🏛️ AGENTS.md — The Constitution

The `AGENTS.md` file at the root of `.agent/` is the **governing document** for all AI agents. It defines:

- **Identity:** AI operates as a "Senior Staff Engineer"
- **4 Karpathy Principles:** Think → Simplicity → Surgical → Goal-Driven
- **Workflow Registry:** Trigger commands and pipeline routing
- **The NEVER Section:** 10 absolute rules (no hardcoded secrets, no mixed refactor+feature commits, etc.)
- **Code Quality Standards:** Security, Testing, Frontend, Backend patterns
- **Verification Checklist:** Must-pass checks before closing any task

Every AI coding session starts by reading this file.

---

## 🚀 Quick Start

### Usage with AI Coding Agents

Add this skills directory to your project as `.agent/`:

```bash
git clone https://github.com/Hoanganhvu123/Cuccu-skills.git .agent
```

Or add as a Git submodule:

```bash
git submodule add https://github.com/Hoanganhvu123/Cuccu-skills.git .agent
```

### Trigger Commands

| Command | What Happens |
|---|---|
| `"Autopilot: Build [feature]"` | God Mode — full autonomous pipeline |
| `"Scaffold: [project name]"` | Bootstrap new project from scratch |
| `"Idea: [concept]"` | Capture and classify an idea |
| `"Hotfix: [bug description]"` | Emergency production fix (≤15 min) |
| `"Refactor: [scope]"` | Safe tech debt cleanup |
| `"Audit Epic [XX]"` | Manual QA gatekeeper scan |

### Speed Run: Idea → Production

```
Scaffold (10min) → PRD (15min) → Evaluate (5min) → Code (2-4h) → Audit (30min)
= Total: ~3-5 hours from idea to production-ready
```

---

## 🔷 Claude Code Native Integration (`.claude/`)

> **NEW:** Full native Claude Code integration with **sub-agents**, **hooks**, and **slash commands**. Works alongside the `.agent/` system — no conflicts.

### Directory Structure

```
.claude/
├── agents/                      ← 🤖 5 specialized sub-agents
│   ├── orchestrator.md          ← Master pipeline router (Opus model)
│   ├── security-reviewer.md     ← Read-only security scanner (Sonnet)
│   ├── qa-gatekeeper.md         ← 4-dimension audit enforcer (Sonnet)
│   ├── tdd-executor.md          ← Red-Green-Refactor executor
│   └── frontend-designer.md    ← Premium UI/UX designer (5 skills loaded)
├── commands/                    ← ⚡ Slash commands
│   ├── autopilot.md             ← /autopilot [task]
│   ├── hotfix.md                ← /hotfix [bug]
│   ├── audit.md                 ← /audit [scope]
│   ├── scaffold.md              ← /scaffold [name]
│   └── refactor.md              ← /refactor [scope]
├── hooks/                       ← 🔒 Automated enforcement
│   ├── protect-files.ps1        ← Blocks edits to .env, lockfiles
│   └── verify-completion.ps1    ← Pre-stop verification (secrets scan)
└── settings.json                ← Hook configuration
```

### Sub-Agents — Isolated Specialists

Each agent runs in its **own context window** with dedicated tool access and preloaded skills:

| Agent | Model | Tools | Skills Loaded | Purpose |
|---|---|---|---|---|
| 🟣 `orchestrator` | Opus | All + Agent spawning | context-window-management | Routes pipelines, coordinates agents |
| 🔴 `security-reviewer` | Sonnet | Read-only | security-review, secret-scanning | CANNOT edit files. Scan only. |
| 🟠 `qa-gatekeeper` | Sonnet | Read-only | quality-playbook, react-doctor | 4-dimension audit with scoring |
| 🟢 `tdd-executor` | Inherit | Read + Write + Edit | tdd, full-output-enforcement | Write tests FIRST, then implement |
| 🔵 `frontend-designer` | Inherit | Read + Write + Edit | ui-ux-pro-max + 4 more | Premium UI that never looks generic |

**Why sub-agents matter:** Instead of one AI "pretending" to be a security expert while also writing code, each role gets an **isolated context** with **enforced tool restrictions**. The security-reviewer literally _cannot_ edit files.

### Hooks — Automated Enforcement

Hooks run **automatically** at lifecycle events. No need to "remind" the AI:

| Hook | Event | What It Does |
|---|---|---|
| `protect-files.ps1` | `PreToolUse (Edit\|Write)` | **BLOCKS** edits to `.env`, `package-lock.json`, `.git/`, `CLAUDE.md` |
| `verify-completion.ps1` | `Stop` | Scans for hardcoded secrets in git diff. BLOCKS completion if found. |
| Desktop Notification | `Notification` | Windows popup when AI needs your input |

### Slash Commands — Quick Pipeline Access

| Command | What Happens |
|---|---|
| `/autopilot [task]` | Auto-classifies intent → routes to correct pipeline |
| `/hotfix [bug]` | 15-minute emergency fix protocol |
| `/audit [scope]` | Manual 4-dimension QA scan |
| `/scaffold [name]` | New project bootstrap (10 min) |
| `/refactor [scope]` | Safe incremental refactoring |

### `.agent/` vs `.claude/` — Both Work Together

| Convention | Used By | Status |
|---|---|---|
| `.agent/` | GitHub Copilot, Gemini, generic agents | ✅ Active |
| `.claude/` | Claude Code (Anthropic) native | ✅ Active |

Both directories live in the same repo. The `.agent/` system provides **workflows and skills** (prompt-based). The `.claude/` system adds **enforcement** (hooks, tool restrictions, isolated agents).

---

## 🏗️ Maturity Model

```
Level 0: Raw Prompts         ← "Hey AI, build me X"
Level 1: Constitution        ← AGENTS.md / CLAUDE.md         ✅
Level 2: Skills              ← 30+ reusable skill modules    ✅
Level 3: Workflows           ← 8 structured pipelines        ✅
Level 4: Slash Commands      ← /autopilot, /hotfix, /audit   ✅ NEW
Level 5: Sub-Agents          ← Specialized isolated workers  ✅ NEW
Level 6: Hooks               ← Automated enforcement gates   ✅ NEW
Level 7: Agent Teams         ← Multi-agent parallel work     🔜 Next
```

---




## 📊 File Conventions

All plan artifacts follow strict naming:

```
plan/ideas/         [XX]_[name].md              ← XX = zero-padded number
plan/possible/      [XX]_[name]_report.md       ← name = lowercase_underscore
plan/doings/        [XX]_[epic].md
plan/doings/sub_doings/  [XX].[Y]_[bug].md      ← Y = sub-task number
plan/done/          [XX]_[epic]_done.md
plan/hotfixes/      [XX]_[name].md
```

---

## 🔗 Inspiration & Credits

- [Andrej Karpathy's coding observations](https://github.com/forrestchang/andrej-karpathy-skills) — The 4 principles
- [awesome-copilot](https://github.com/Correia-jpv/fucking-awesome-copilot) — Skills library
- Reddit communities: r/ClaudeAI, r/CursorAI, r/SideProject — Workflow patterns
- [OWASP Agentic Security Initiative](https://owasp.org/www-project-agentic-security-initiative/) — Agent security standards

---

## 📜 License

MIT — Use it, fork it, make it your own.

---

<p align="center">
  <strong>Built by <a href="https://github.com/Hoanganhvu123">@Hoanganhvu123</a></strong><br/>
  <em>"The devs who ship fastest aren't the ones who type fastest. They're the ones who spec best."</em>
</p>
