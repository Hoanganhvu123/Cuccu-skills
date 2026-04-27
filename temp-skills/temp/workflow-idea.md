---
name: Idea Capture Workflow
description: An adaptive workflow for capturing, classifying, and saving ideas — automatically detects the idea type and handles it accordingly.
---

# 💡 Idea Capture Workflow

> An adaptive workflow for capturing, classifying, and saving ideas — automatically detects the idea type and handles it accordingly.

---

## 🧠 Skill Integrations

When executing this workflow, the AI should actively trigger the following skills to enhance the output:
- **`brainstorming` & `multi-agent-brainstorming`**: Use these to expand and rigorously validate vague ideas.
- **`grill-me`**: Relentlessly interview the user to refine the core concept before saving.
- **`ubiquitous-language`**: Extract a DDD-style glossary if new business concepts are introduced.
- **`ui-ux-pro-max`**: Apply high-end $150k agency-level design constraints when conceptualizing UI/UX.
- **`competitive-landscape` & `market-sizing-analysis`**: Trigger automatically if the idea is for a new product to evaluate market viability.
- **`micro-saas-launcher` & `ai-wrapper-product`**: Use to evaluate if a new SaaS or AI idea is actually defensible, profitable, and viable for a fast MVP launch.
- **`design-an-interface`**: Trigger when the idea needs multiple distinct UI/API architecture options before committing.
- **`product-manager-toolkit`**: Use this to structure the final idea output as a professional PRD.

---

## Trigger — When to Use This Workflow

Activate this workflow when the user provides **any of the following**:

| Input Type | Example |
|---|---|
| Raw idea / thought | `"Save idea: add dark mode to the app"` |
| URL (article / repo) | `"Research and save: https://github.com/..."` |
| Local codebase path | `"Scan codebase and plan: ./src/components"` |
| Codebase improvement request | `"Plan adding docstrings to all Python files"` |

---

## Step 0 — Classify the Idea (REQUIRED FIRST)

Before doing anything, determine the idea type to pick the right processing mode:

```
USER INPUT
     │
     ├── Mentions a path / folder / codebase?
     │       └── YES → MODE C: Codebase-Aware
     │
     ├── Is a URL or external repo link?
     │       └── YES → MODE B: Research
     │
     └── Is a pure thought / concept?
             └── YES → MODE A: Quick Capture
```

---

## Step 1 — Process by Mode

### MODE A — Quick Capture (Pure Ideas)

**When:** The user describes an idea in text, not tied to a specific codebase.

**Steps:**
1. Parse the core concept from the input
2. Identify the problem it solves
3. Fill in the Quick Capture template
4. Save the file

---

### MODE B — Research Mode (External URL / Repo)

**When:** The user provides a GitHub link, article, or external tool.

**Steps:**
1. Fetch the content using `read_url_content` or `search_web`
2. Extract:
   - Core problem it solves
   - Tech approach / architecture
   - What we can learn or reuse
   - Applicability to our own codebase
3. Fill in the Research template
4. Save the file

---

### MODE C — Codebase-Aware Mode (Improvement / Analysis)

**When:** The user wants to plan an improvement, refactor, or new feature on a real codebase.

**Steps:**

```
STEP 1: SCAN CODEBASE
   ├── Read directory structure (tree, 2-3 levels deep)
   │   *Note: If >500 files, only scan root and target folder to avoid token overflow.
   ├── Count files by extension (.py, .ts, .js, ...)
   ├── Identify tech stack (package.json, requirements.txt, ...)
   └── Sample 3-5 representative files to understand current style

STEP 2: ASSESS SCOPE
   ├── Small  (< 20 files)   → Detail plan per file
   ├── Medium (20-100 files) → Plan per module / folder
   └── Large  (> 100 files)  → Phase-based plan, automation may be needed

STEP 3: GENERATE PLAN
   ├── Affected files / folders
   ├── Approach: manual / script / AI-assisted
   ├── Estimated effort: S / M / L / XL
   ├── Risks & side effects
   └── Step-by-step execution order

STEP 4: FORMAT & SAVE
   └── Use the Codebase-Aware template below
```

---

## Step 2 — Determine File Number

Before saving, scan the target directory (e.g., `plan/ideas/`) to get the next available number:

```
SCAN: plan/ideas/
  ├── 01_dark_mode.md        → prefix = 01
  ├── 02_api_refactor.md     → prefix = 02
  └── 03_add_docstring.md    → prefix = 03

→ Next file = 04_[idea_name].md
```

**Naming rules:**
- Zero-padded 2 digits: `01`, `02`, ..., `09`, `10`, `11`...
- File name: lowercase, use `_` instead of spaces, no special characters
- Example: `04_gitnexus_mcp_integration.md`

---

## Step 3 — Templates

### Template A — Quick Capture

```markdown
# [Concise Idea Title]

## 📌 Summary
[1-2 sentences describing the idea]

## 🧩 Problem It Solves
[What problem? Who faces it? How is it currently handled?]

## 💡 Core Concept
[What is the proposed solution?]

## 🔗 References
- [Links, articles, related tools if any]

## 📋 Next Actions
- [ ] [First concrete step]
- [ ] [Next step]

---
_Captured: [YYYY-MM-DD] | Type: Quick Capture_
```

---

### Template B — Research

```markdown
# [Tool / Article / Repo Name]

## 📌 Summary
[Short description of what this is]

## 🔗 Source
- URL: [link]
- Type: [GitHub Repo / Article / Tool / Video]

## 🧩 Problem It Solves
[The root problem this addresses]

## ⚙️ How It Works
[Tech approach and architecture summary]

## 🎯 Applicability to Our Codebase
[What can we use or learn from this? Where does it apply?]

## 💻 Key Code / Concepts
\`\`\`[language]
// Most important snippet or concept
\`\`\`

## ✅ Verdict
- [ ] Use directly
- [ ] Learn the concept, implement ourselves
- [ ] Bookmark for later
- [ ] Not a fit

## 📋 Next Actions
- [ ] [Specific action]

---
_Captured: [YYYY-MM-DD] | Type: Research_
```

---

### Template C — Codebase-Aware

```markdown
# [Plan / Improvement Title]

## 📌 Idea
[Short description: what to do, on which codebase]

## 🗂 Codebase Scope
- **Root:** `[project_root_path]`
- **Total files:** [X files]
- **Affected:** [Y files, Z folders]
- **Languages:** [TypeScript, Python, ...]
- **Size:** [S / M / L / XL]

## 📊 Current State Analysis
[Scan results — e.g., "200 Python files, 30% missing docstrings,
concentrated in /services and /utils. No existing standard defined."]

## 🎯 Goal / Definition of Done
[What does done look like? Make it measurable.]

## 📋 Execution Plan

### Phase 1: [Phase Name]
- [ ] Task A — `path/to/file.py`
- [ ] Task B — `path/to/module/`

### Phase 2: [Phase Name]
- [ ] Task C
- [ ] Task D

## ⚠️ Risks & Side Effects
- [Risk 1]: [Mitigation]
- [Risk 2]: [Mitigation]

## 🔧 Tools / Scripts Needed
- [Tool 1]: [What it's used for]
- [Script]: [If automation is needed]

## ⏱ Effort Estimate
**[S / M / L / XL]** — [Brief explanation]

| Size | Meaning |
|------|---------|
| S | < 2 hours, < 20 files |
| M | 2–8 hours, 20–100 files |
| L | 1–3 days, 100+ files |
| XL | > 3 days, requires phased approach |

---
_Captured: [YYYY-MM-DD] | Type: Codebase-Aware_
```

---

## Step 4 — Save the File

```
Path: plan/ideas/[XX]_[descriptive_name].md

Naming examples:
  ✅ 04_gitnexus_mcp_integration.md
  ✅ 05_add_docstring_python.md
  ✅ 06_dark_mode_implementation.md
  ❌ 4_GitNexus MCP.md         (missing zero-pad, has spaces)
  ❌ idea_gitnexus.md           (missing numeric prefix)
```

---

## Real-World Examples

---

### Example 1 — MODE B (Research from GitNexus URL)

**User says:**
> "Research and save: https://github.com/abhigyanpatwari/GitNexus"

**What the AI does:**
1. Fetch README from the URL
2. Analyze: MCP server + knowledge graph indexer for codebases
3. Assess: can improve AI agent accuracy in current projects
4. Save file `04_gitnexus_mcp_integration.md`

**Output file:**
```markdown
# GitNexus — MCP Knowledge Graph for Codebase

## 📌 Summary
Tool that indexes an entire codebase into a knowledge graph and
exposes it via MCP to Cursor/Claude Code. Prevents AI from missing
dependencies before making changes.

## 🔗 Source
- URL: https://github.com/abhigyanpatwari/GitNexus
- Type: GitHub Repo / npm package

## 🧩 Problem It Solves
AI agents (Cursor, Claude Code) edit code without knowing the blast
radius — e.g., modifying UserService without knowing 47 functions
depend on its return type.

## ⚙️ How It Works
1. `npx gitnexus analyze` → indexes codebase into LadybugDB graph
2. `npx gitnexus mcp` → starts MCP server
3. Cursor/Claude Code connects → uses 16 tools: impact, context, query...

## 🎯 Applicability to Our Codebase
- Apply to current workspace repositories
- Especially useful before refactoring auth or core flows
- Can integrate into Mode C of this idea capture workflow

## 💻 Key Concepts
\`\`\`bash
npx gitnexus analyze          # index
npx gitnexus mcp              # start server
impact({target: "OrderService", direction: "upstream"})
\`\`\`

## ✅ Verdict
- [x] Learn the concept, integrate into workflow

## 📋 Next Actions
- [ ] Test on current repository
- [ ] Set up MCP in agent config

---
_Captured: 2026-04-27 | Type: Research_
```

---

### Example 2 — MODE C (Codebase Improvement)

**User says:**
> "Plan adding docstrings to all Python files in the current workspace"

**What the AI does:**
1. Scan `./` → read directory structure
2. Count: 45 Python files, sample 5 files → 80% missing docstrings
3. Assess scope: Medium (M)
4. Generate detailed plan by module
5. Save `05_add_docstring_python_files.md`

**Output file:**
```markdown
# Add Docstrings to All Python Files

## 📌 Idea
Add Google-style docstrings to all 45 Python files in the
current project to improve maintainability and documentation.

## 🗂 Codebase Scope
- **Root:** `./`
- **Total files:** 45 Python files
- **Affected:** 45 files, 8 folders
- **Languages:** Python 3.10+
- **Size:** M

## 📊 Current State Analysis
Scan results:
- 45 .py files total
- ~36 files (80%) missing docstrings entirely
- ~9 files have partial docstrings, not following any standard
- Most concentrated in: /skills/, /utils/, /agents/
- No docstring convention currently defined

## 🎯 Goal / Definition of Done
- 100% of functions/classes have Google-style docstrings
- All module-level files have a module docstring
- Docs can be generated using `pydoc` or `mkdocs`

## 📋 Execution Plan

### Phase 1: Set Up Convention (30 min)
- [ ] Create `DOCSTRING_STYLE.md` defining the standard
- [ ] Write 2-3 example files for reference

### Phase 2: Core Modules (2 hours)
- [ ] `skills/*.py` — 12 files
- [ ] `agents/*.py` — 8 files
- [ ] `utils/*.py` — 10 files

### Phase 3: Secondary Modules (1 hour)
- [ ] `plan/*.py` — 6 files
- [ ] `tools/*.py` — 9 files

### Phase 4: Validate (30 min)
- [ ] Run `pydocstyle` to check coverage
- [ ] Fix remaining issues

## ⚠️ Risks & Side Effects
- **Time creep:** Easy to drag on if done manually → use AI-assisted per file
- **Accuracy:** AI may generate docstrings with wrong meaning → requires review

## 🔧 Tools / Scripts Needed
- `pydocstyle`: Validate docstring format
- AI Agent: AI-assisted generation per file
- Optional: `interrogate` to measure coverage %

## ⏱ Effort Estimate
**M** — ~4 hours total (if using AI-assisted approach)

---
_Captured: 2026-04-27 | Type: Codebase-Aware_
```

---

## Quick Reference Card

```
User input                                → Mode → Template
────────────────────────────────────────────────────────────
"Save idea: [text]"                       →  A   → Quick Capture
"Research: [URL]"                         →  B   → Research
"Scan codebase: [path or description]"    →  C   → Codebase-Aware
"Plan [any codebase improvement]"         →  C   → Codebase-Aware
```

```
File path:  plan/ideas/[XX]_[name].md
            ↑ zero-padded 2 digits          ↑ lowercase_underscore
```

---

## 🧰 Workflow Skill Summary

*All skills are loaded dynamically from `.agent/skills/` without hardcoded absolute paths.*

| Skill | Phase | Purpose |
|---|---|---|
| `.agent/skills/brainstorming` | Pre-Capture | Expand and validate vague ideas |
| `.agent/skills/grill-me` | Pre-Capture | Interview user to resolve logic gaps |
| `.agent/skills/ui-ux-pro-max` | Conceptualization | Force premium design constraints |
| `.agent/skills/design-an-interface` | Conceptualization | Generate distinct design alternatives |
| `.agent/skills/competitive-landscape` | Research (Mode B) | Analyze competitors |
| `.agent/skills/micro-saas-launcher` | Validation | Assess indie-hacker MVP viability |
| `.agent/skills/ai-wrapper-product` | Validation | Evaluate AI product defensibility |
| `.agent/skills/ubiquitous-language` | Formatting | Define DDD terminology |
| `.agent/skills/product-manager-toolkit` | Formatting | Structure output as PRD |