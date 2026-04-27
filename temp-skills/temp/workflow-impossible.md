---
name: Feasibility Evaluation Workflow
description: A pragmatic technical evaluation workflow that stress-tests ideas against real constraints before committing any development time. No fluff — honest verdicts only.
---

# 🔬 Feasibility Evaluation Workflow

> A pragmatic technical evaluation workflow that stress-tests ideas against real constraints
> before committing any development time. No fluff — honest verdicts only.

---

## 🧠 Skill Integrations

When evaluating feasibility, the AI should actively leverage these skills:
- **`improve-codebase-architecture`**: Use this to evaluate if the idea aligns with existing domain models and architectural decisions.
- **`deep-research`**: Use this to autonomously research tech feasibility if it's uncertain whether a local technology works within constraints.
- **`ai-agents-architect` / `rag-engineer` / `langgraph`**: Trigger if the idea involves AI/LLMs to accurately evaluate context window and token constraints.
- **`startup-financial-modeling`**: Trigger if assessing budget scalability (Dimension 2: API Cost at Scale) for high-user assumptions.
- **`grill-me`**: Challenge the user's assumed constraints (e.g., "Must it run locally?", "Can we use an API fallback?").

---

## Trigger — When to Use This Workflow

Activate when the user asks to **evaluate**, **validate**, or **move an idea** from the idea backlog
into a verdict category (possible / compromise / impossible).

| Trigger phrase | Example |
|---|---|
| Evaluate an idea | `"Evaluate idea 04 — GitNexus MCP integration"` |
| Check feasibility | `"Is it feasible to add real-time embeddings locally?"` |
| Move idea to verdict | `"Can we actually do idea 02 with our current stack?"` |
| Quick sanity check | `"Is this realistic given we have no GPU?"` |

---

## Step 0 — Load Constraints (ALWAYS DO THIS FIRST)

Before evaluating anything, lock in the constraint profile.
Use the **defaults below** unless the user explicitly overrides them.

### Default Constraint Profile

```
HARDWARE
  ├── RAM:         Low (≤ 16GB assumed unless stated)
  ├── GPU:         None / No dedicated GPU
  ├── CPU:         Standard dev machine
  └── Storage:     Local SSD, limited

BUDGET
  ├── APIs:        Free tier or extremely low cost (< $10/mo)
  ├── SaaS:        Prefer self-hosted or open-source alternatives
  └── Cloud:       Avoid unless strictly necessary

INFRASTRUCTURE
  ├── Disruption:  Minimal — no rewrites of core systems
  ├── Deps:        Prefer adding lightweight packages only
  └── Ops:         No dedicated DevOps — must be maintainable by 1-2 devs

TIMELINE
  └── Default:     Assume short runway — quick wins preferred over long builds
```

**Override example:**
> "Evaluate with 32GB RAM, we have an OpenAI API key with $50/mo budget"
→ Unlock: higher RAM tier, paid API usage acceptable

---

## Step 1 — Load the Idea

Pull the idea from the ideas backlog:

```
SOURCE: plan/ideas/[XX]_[idea_name].md
```

Read:
- Core concept
- Problem it solves
- Any tech references or code snippets
- Existing next actions

If the idea file doesn't exist yet, ask the user to run **Idea Capture Workflow** first.

---

## Step 2 — Evaluate Across 4 Dimensions

Act as a **pragmatic Technical Architect** — not a cheerleader, not a pessimist.
The goal is an honest verdict the team can actually act on.

---

### Dimension 1 — Hardware & Compute

| Question | What to assess |
|---|---|
| Can it run locally? | RAM footprint, CPU load, inference time |
| Does it need a GPU? | Model size, VRAM requirement, CUDA dependency |
| Storage overhead? | Index files, embeddings, database size on disk |
| Realtime or batch? | Latency requirements vs available compute |

**Red flags:**
- Requires > 8GB VRAM → 🔴 unless cloud fallback exists
- Model > 7B params for local inference → 🟡 at best
- Needs continuous GPU inference → 🔴 without cloud budget

---

### Dimension 2 — API & External Services

| Question | What to assess |
|---|---|
| What APIs are required? | List every external dependency |
| Free tier limits? | Requests/day, tokens/mo, rate limits |
| Cost at scale? | What happens at 10x, 100x usage? |
| Self-hostable alternative? | Is there an OSS replacement? |
| Data privacy risk? | Does sensitive code/data leave the machine? |

**Scoring guide:**

| API situation | Score |
|---|---|
| 100% free / open-source / local | 🟢 |
| Free tier covers our usage with headroom | 🟢 |
| Free tier is tight, may hit limits | 🟡 |
| Requires paid plan from day 1 | 🟡 |
| Expensive at any realistic scale | 🔴 |
| No alternative — single vendor lock-in | 🔴 |

---

### Dimension 3 — Integration Effort

| Level | Description | Score |
|---|---|---|
| **Drop-in** | New package + config, no existing code touched | 🟢 |
| **Additive** | New module added, minimal interface changes | 🟢 |
| **Moderate** | Requires changes to 2-5 existing files / services | 🟡 |
| **Invasive** | Touches core systems, data models, or auth flow | 🟡 |
| **Rewrite** | Requires rebuilding foundational pieces | 🔴 |

Additional checks:
- Does it introduce breaking changes to existing APIs?
- Does it require new infra (Redis, a graph DB, a vector store)?
- Can it be feature-flagged / rolled back easily?

---

### Dimension 4 — Risk & Maintenance

| Question | What to assess |
|---|---|
| Maturity of dependencies? | Alpha / beta libs = higher risk |
| Team familiarity? | Known stack vs completely foreign tech |
| Ongoing maintenance cost? | Does it need constant updates / reindexing / tuning? |
| Failure mode? | If this breaks, what else breaks with it? |
| Reversibility? | Can we rip it out if it doesn't work? |

---

## Step 3 — Assign Verdict

Based on the 4-dimension evaluation, assign **one status**:

```
🟢 POSSIBLE
   All 4 dimensions clear. Runs within constraints.
   Recommend: proceed to implementation planning.

🟡 COMPROMISE
   Feasible ONLY with one or more of:
     - Alternative/cheaper API substitution
     - Feature scope reduction
     - Mocked data for non-critical parts
     - Deferred non-essential functionality
   Recommend: define the compromise clearly, then proceed with caveats.

🔴 IMPOSSIBLE
   One or more hard blockers:
     - Hardware requirements unmet and no viable cloud fallback
     - Cost prohibitive at any realistic usage level
     - Integration would break existing systems
     - Technical debt too high to absorb
   Recommend: drop, defer, or fundamentally redesign the approach.
```

### Decision Matrix (quick reference)

| Hardware OK? | API Cost OK? | Integration OK? | Risk OK? | Verdict |
|---|---|---|---|---|
| ✅ | ✅ | ✅ | ✅ | 🟢 POSSIBLE |
| ✅ | ✅ | ✅ | ⚠️ | 🟢 POSSIBLE (note risks) |
| ✅ | ⚠️ | ✅ | ✅ | 🟡 COMPROMISE |
| ⚠️ | ✅ | ✅ | ✅ | 🟡 COMPROMISE |
| ✅ | ✅ | ⚠️ | ✅ | 🟡 COMPROMISE |
| ❌ | any | any | any | 🔴 IMPOSSIBLE |
| any | ❌ | any | any | 🔴 IMPOSSIBLE |
| any | any | ❌ | any | 🔴 IMPOSSIBLE |

---

## Step 4 — Determine File Number

Scan the output directory and find the next available prefix:

```
SCAN: plan/possible/
  ├── 01_dark_mode_report.md          → prefix = 01
  ├── 02_api_refactor_report.md       → prefix = 02

→ Next file = 03_[idea_name]_report.md
```

---

## Step 5 — Format the Report

Use this exact structure:

```markdown
# Feasibility Report: [Idea Name]

## 🏷 Status
🟢 POSSIBLE  /  🟡 COMPROMISE  /  🔴 IMPOSSIBLE

## 📌 Idea Summary
[1-3 sentence recap of what the idea is and what it solves]

## ⚙️ Constraint Profile Used
- Hardware: [e.g., 16GB RAM, no GPU]
- Budget: [e.g., free tier only]
- Integration: [e.g., minimal disruption]
- Timeline: [e.g., short runway]

---

## 📊 Dimension Analysis

### 1. Hardware & Compute
| Factor | Requirement | Our Capacity | Result |
|--------|-------------|--------------|--------|
| RAM    | [X GB]      | [Y GB]       | ✅ / ⚠️ / ❌ |
| GPU    | [yes/no]    | [none]       | ✅ / ❌ |
| Storage| [X GB]      | sufficient   | ✅ / ⚠️ |

[Narrative: honest 2-3 sentence assessment]

### 2. API & External Services
| Service | Free Tier | Cost at Scale | Alternative | Result |
|---------|-----------|---------------|-------------|--------|
| [API]   | [limit]   | [$X/mo]       | [OSS alt]   | ✅ / ⚠️ / ❌ |

[Narrative: what's acceptable, what's a risk, what to watch]

### 3. Integration Effort
- **Level**: [Drop-in / Additive / Moderate / Invasive / Rewrite]
- **Affected files/services**: [list them]
- **Breaking changes**: [yes/no + details]
- **Reversible**: [yes/no]

[Narrative: realistic integration assessment]

### 4. Risk & Maintenance
- **Dependency maturity**: [stable / beta / alpha]
- **Team familiarity**: [high / medium / low]
- **Maintenance burden**: [low / medium / high]
- **Failure impact**: [isolated / cascading]

[Narrative: what could go wrong and how bad it would be]

---

## 🧾 Verdict

**[🟢 POSSIBLE / 🟡 COMPROMISE / 🔴 IMPOSSIBLE]**

[2-4 sentence plain-language justification for the verdict.
Be direct. Don't hedge unless it's genuinely unclear.]

---

## 🛣 Action Plan

### If 🟢 POSSIBLE:
- [ ] [First concrete implementation step]
- [ ] [Second step]
- [ ] [Definition of done]

### If 🟡 COMPROMISE:
**Required trade-offs:**
- [Trade-off 1]: [What we give up, what we gain]
- [Trade-off 2]: [What we give up, what we gain]

**Conditions to proceed:**
- [ ] [Condition that must be true before starting]
- [ ] [Fallback plan if condition fails]

### If 🔴 IMPOSSIBLE:
**Blockers:**
- [Blocker 1]: [Why it cannot be resolved within constraints]
- [Blocker 2]: [Why it cannot be resolved within constraints]

**Recommendation:**
- [ ] Drop entirely — reason: [why]
- [ ] Defer until: [condition that would change the verdict]
- [ ] Redesign approach: [alternative direction to explore]

---

## 🔗 Linked Idea
`plan/ideas/[XX]_[idea_name].md`

---
_Evaluated: [YYYY-MM-DD] | Constraint Profile: [Default / Custom]_
```

---

## Step 6 — Save the File

```
Path: plan/possible/[XX]_[idea_name]_report.md

Examples:
  ✅ 03_gitnexus_mcp_integration_report.md
  ✅ 04_add_docstring_python_report.md
  ❌ report_gitnexus.md          (missing prefix)
  ❌ 3_GitNexus Report.md        (missing zero-pad, has spaces)
```

---

## 🧰 Workflow Skill Summary

*All skills are loaded dynamically from `.agent/skills/` without hardcoded absolute paths.*

| Skill | Phase | Purpose |
|---|---|---|
| `.agent/skills/deep-research` | Evaluation | Research tech feasibility |
| `.agent/skills/improve-codebase-architecture` | Evaluation | Align with existing architecture |
| `.agent/skills/grill-me` | Evaluation | Challenge constraints |
| `.agent/skills/ai-agents-architect` | Evaluation | Assess AI/LLM specific tech limits |
| `.agent/skills/startup-financial-modeling` | Evaluation | Model API cost scalability |

---

## Real-World Example

---

### Evaluating Idea: GitNexus MCP Integration

**User says:**
> "Evaluate idea 04 — GitNexus MCP integration. Default constraints apply."

**What the AI does:**
1. Load `04_gitnexus_mcp_integration.md` from ideas folder
2. Apply default constraint profile (no GPU, free APIs, low disruption)
3. Evaluate across 4 dimensions
4. Assign verdict
5. Save `03_gitnexus_mcp_integration_report.md`

---

**Output file:**

```markdown
# Feasibility Report: GitNexus MCP Integration

## 🏷 Status
🟡 COMPROMISE

## 📌 Idea Summary
Index the codebase using GitNexus to build a local knowledge
graph, then expose it as an MCP server so Claude Code and Cursor have
full structural awareness before making changes.

## ⚙️ Constraint Profile Used
- Hardware: 16GB RAM, no GPU
- Budget: free tier only
- Integration: minimal disruption
- Timeline: short runway

---

## 📊 Dimension Analysis

### 1. Hardware & Compute
| Factor  | Requirement    | Our Capacity | Result |
|---------|----------------|--------------|--------|
| RAM     | ~500MB–2GB     | 16GB         | ✅     |
| GPU     | Not required   | None         | ✅     |
| Storage | ~200MB index   | Sufficient   | ✅     |
| CPU     | Moderate burst | Standard     | ✅     |

Hardware is not a blocker. GitNexus runs entirely on CPU with Node.js.
Index generation is a one-time burst, not continuous compute.
The MCP server itself is lightweight (stdio process).

### 2. API & External Services
| Service        | Free Tier       | Cost at Scale | Alternative | Result |
|----------------|-----------------|---------------|-------------|--------|
| GitNexus CLI   | 100% free/OSS   | $0            | —           | ✅     |
| Embeddings     | Local (HF WASM) | $0            | —           | ✅     |
| Wiki gen (LLM) | Needs API key   | ~$1–5/run     | Skip wiki   | ⚠️     |

Core MCP functionality is fully free. The only paid component is optional
wiki generation (`gitnexus wiki`), which we can skip or defer.

### 3. Integration Effort
- **Level**: Additive
- **Affected files/services**: `.mcp.json` or agent config only
- **Breaking changes**: None — purely additive MCP layer
- **Reversible**: Yes — remove config and MCP server stops

Zero changes to source code. GitNexus runs alongside
the project, not inside it. Integration is a config file change only.

### 4. Risk & Maintenance
- **Dependency maturity**: Beta (v1.6.x, active development)
- **Team familiarity**: Low — new tool, learning curve
- **Maintenance burden**: Low — re-run `npx gitnexus analyze` after big changes
- **Failure impact**: Isolated — if GitNexus breaks, the codebase is unaffected

Main risk is active development pace — APIs may change between versions.
Pin to a specific version in `.npmrc` to avoid surprises.

---

## 🧾 Verdict

**🟡 COMPROMISE**

The core functionality fits our constraints perfectly. However, the LLM-powered wiki generation feature requires paid APIs. We must compromise by skipping the wiki generation and only using the local indexing/MCP features.

---

## 🛣 Action Plan

**Required trade-offs:**
- Wiki feature: We give up automated docs, we gain $0 API costs.

**Conditions to proceed:**
- [x] Configure MCP without the wiki integration
- [ ] Set up git hooks to automate indexing so maintenance burden stays low

---

## 🔗 Linked Idea
`plan/ideas/04_gitnexus_mcp_integration.md`

---
_Evaluated: 2026-04-27 | Constraint Profile: Default_
```
