---
name: Scaffold Workflow (Project Bootstrap)
description: Creates a new project from scratch with folder structure, boilerplate, AGENTS.md context file, design tokens, and first commit — all in 10 minutes.
---

# 🏗️ Scaffold Workflow (Project Bootstrap)

> From zero to ready-to-code in 10 minutes.
> Every project starts with structure, not code.

---

## 🧠 Skill Integrations

The AI assumes the persona of a Senior Architect setting up a new project:
- **`grill-me`**: Interview the user relentlessly about scope, stack, and constraints BEFORE generating anything.
- **`acquire-codebase-knowledge`**: If bootstrapping FROM an existing codebase (fork/migration), map it first.
- **`frontend-design` / `ui-ux-pro-max`**: Setup design system tokens (colors, typography, spacing) if project has a frontend.
- **`fastapi-templates`**: Generate production-ready FastAPI boilerplate if backend is Python.
- **`frontend-developer`**: Setup React/Next.js project structure with proper conventions.
- **`conventional-commit`**: Enforce commit message standards from the very first commit.
- **`premium-frontend-ui`**: Define motion design principles and performance guardrails in the design system.

---

## Trigger — When to Use This Workflow

| Input Type | Example |
|---|---|
| New project | `"Scaffold: VidFash AI Studio"` |
| Fresh start | `"New project: SaaS dashboard with React + FastAPI"` |
| Fork/clone setup | `"Bootstrap from: https://github.com/user/repo"` |
| Migration | `"Scaffold: Migrate old PHP app to Next.js"` |

### ⚠️ This is NOT for:
- Adding features to existing projects → use `workflow-doings.md`
- Capturing ideas → use `workflow-idea.md`
- Quick prototyping without structure → just code directly

---

## Step 1 — INTERVIEW (3 min)
> Goal: Understand exactly what to build before generating anything.

Trigger **`grill-me`** skill. Ask these questions (adapt based on answers):

### Required Questions
| # | Question | Why |
|---|---|---|
| 1 | What is the product in ONE sentence? | Prevents scope creep |
| 2 | Who is the target user? | Influences UI/UX decisions |
| 3 | What's the tech stack? (Frontend / Backend / DB / AI) | Determines boilerplate |
| 4 | Is this a monorepo or polyrepo? | Determines folder structure |
| 5 | Will it need auth? If so, what kind? | Setup auth boilerplate |
| 6 | What's the deployment target? (Vercel / Railway / VPS / Docker) | Determines infra files |

### Optional Questions (if applicable)
| # | Question | When to ask |
|---|---|---|
| 7 | Any existing design reference? (Figma, URL, screenshot) | If frontend exists |
| 8 | Any existing codebase to migrate from? | If fork/migration |
| 9 | API-first or full-stack? | If both FE + BE |
| 10 | Any 3rd party APIs? (Stripe, OpenAI, Supabase) | If SaaS product |

**Rule:** Do NOT proceed until you have answers to questions 1-6. No assumptions.

---

## Step 2 — GENERATE Structure (3 min)
> Goal: Create the folder skeleton and essential config files.

### 2.1 Folder Structure Templates

**Template A: Full-Stack (React + FastAPI)**
```
project-name/
├── frontend/
│   ├── src/
│   │   ├── components/
│   │   ├── pages/ (or app/ for App Router)
│   │   ├── hooks/
│   │   ├── lib/
│   │   ├── styles/
│   │   │   └── design-tokens.css
│   │   └── types/
│   ├── public/
│   ├── package.json
│   └── tsconfig.json
├── backend/
│   ├── app/
│   │   ├── api/
│   │   │   └── routes/
│   │   ├── core/
│   │   │   ├── config.py
│   │   │   └── security.py
│   │   ├── models/
│   │   ├── services/
│   │   └── main.py
│   ├── tests/
│   ├── requirements.txt
│   └── .env.example
├── docs/
│   ├── 01_prd.md
│   ├── 02_architecture.md
│   └── adr/          (Architectural Decision Records)
├── plan/
│   ├── ideas/
│   ├── possible/
│   ├── doings/
│   │   └── sub_doings/
│   ├── done/
│   └── hotfixes/
├── AGENTS.md
├── DESIGN.md          (if frontend)
├── .env.example
├── .gitignore
├── docker-compose.yml (if Docker)
└── README.md
```

**Template B: Frontend Only (Next.js / React)**
```
project-name/
├── src/
│   ├── app/ (or pages/)
│   ├── components/
│   ├── hooks/
│   ├── lib/
│   ├── styles/
│   │   └── design-tokens.css
│   └── types/
├── public/
├── docs/
├── plan/
│   ├── ideas/
│   ├── possible/
│   ├── doings/
│   │   └── sub_doings/
│   ├── done/
│   └── hotfixes/
├── AGENTS.md
├── DESIGN.md
├── package.json
└── README.md
```

**Template C: Backend Only (FastAPI)**
```
project-name/
├── app/
│   ├── api/routes/
│   ├── core/
│   ├── models/
│   ├── services/
│   └── main.py
├── tests/
├── docs/
├── plan/
│   ├── ideas/
│   ├── possible/
│   ├── doings/
│   │   └── sub_doings/
│   ├── done/
│   └── hotfixes/
├── AGENTS.md
├── requirements.txt
├── .env.example
└── README.md
```

### 2.2 Essential Config Files

Generate these files with project-specific content:

| File | Purpose |
|---|---|
| `.gitignore` | Language-specific ignores + `.env`, `node_modules/`, `__pycache__/`, `.venv/` |
| `.env.example` | All required env vars with placeholder values (NEVER real secrets) |
| `README.md` | Project name, 1-line description, setup instructions, tech stack |

---

## Step 3 — WRITE AGENTS.md (2 min)
> Goal: Create the AI context file that persists across ALL future coding sessions.

This is **the most important file in the entire project**. Every AI coding session starts by reading this file.

### AGENTS.md Template

```markdown
# [Project Name]

## Overview
[1-2 sentences: what this project does and who it's for]

## Tech Stack
- Frontend: [framework, version]
- Backend: [framework, version]
- Database: [type, provider]
- AI/LLM: [if applicable]
- Deployment: [target platform]

## AI Coding Principles (Karpathy's Guidelines)
1. **Think Before Coding**: Don't assume. Don't hide confusion. Surface tradeoffs. State assumptions explicitly.
2. **Simplicity First**: Minimum code that solves the problem. No speculative abstractions. If 200 lines could be 50, rewrite it.
3. **Surgical Changes**: Touch only what you must. Don't refactor adjacent code unless requested. Clean up only your own mess.
4. **Goal-Driven Execution**: Define success criteria. Loop until verified through tests.

## Architecture Rules (NON-NEGOTIABLE)
- [Rule 1: e.g., "All API routes must use dependency injection"]
- [Rule 2: e.g., "Frontend state managed via TanStack Query, no Redux"]
- [Rule 3: e.g., "All database access through Repository pattern"]

## File Structure
[Copy the generated folder structure from Step 2]

## Code Patterns (Golden Examples)
[After first feature is built, paste 1-2 exemplary code snippets here]

## The NEVER Section
- NEVER hardcode API keys or secrets
- NEVER use string concatenation for database queries
- NEVER skip input validation on API endpoints
- NEVER commit .env files
- NEVER use `any` type in TypeScript without justification

## Naming Conventions
- Files: kebab-case (e.g., `user-service.ts`)
- Components: PascalCase (e.g., `UserCard.tsx`)
- Functions: camelCase (e.g., `getUserById`)
- DB Tables: snake_case (e.g., `user_sessions`)

## Workflow Integration
- Ideas: `plan/ideas/[XX]_[name].md`
- Feasibility: `plan/possible/[XX]_[name]_report.md`
- Execution: `plan/doings/[XX]_[epic].md`
- Completed: `plan/done/[XX]_[epic]_done.md`
- Hotfixes: `plan/hotfixes/[XX]_[name].md`

## Current Status
[Updated each session: what's done, what's in progress, what's next]
```

---

## Step 4 — DESIGN SYSTEM (if frontend) (1 min)
> Goal: Setup design tokens so every component looks consistent from day one.

Trigger **`ui-ux-pro-max`** and **`premium-frontend-ui`** to generate:

### DESIGN.md Template
```markdown
# Design System: [Project Name]

## Typography
- Headings: [Font family, weights]
- Body: [Font family, weight, size]
- Mono: [Font family]

## Colors
- Primary: [hex + hsl]
- Secondary: [hex + hsl]
- Surface/Background: [hex + hsl]
- Text: [hex + hsl]
- Error/Success/Warning: [hex + hsl]

## Spacing Scale
4px, 8px, 12px, 16px, 24px, 32px, 48px, 64px

## Border Radius
sm: 4px, md: 8px, lg: 12px, xl: 16px, full: 9999px

## Shadows
- sm: [value]
- md: [value]
- lg: [value]

## Motion
- Duration: 150ms (micro), 300ms (standard), 500ms (emphasis)
- Easing: cubic-bezier(0.4, 0, 0.2, 1)
- ONLY animate: transform, opacity (NEVER width/height/top/margin)
```

Also generate `design-tokens.css` with CSS custom properties matching the above.

---

## Step 5 — INFRASTRUCTURE (1 min)
> Goal: Setup deployment-ready config files.

Based on Step 1 interview answers, generate applicable files:

| Target | Files Generated |
|---|---|
| Docker | `Dockerfile`, `docker-compose.yml` |
| Vercel | `vercel.json` |
| Railway | `railway.toml` |
| Any | `.env.example` (already done in Step 2) |

---

## Step 6 — INIT & COMMIT
> Goal: First commit. The project is now alive.

**Actions:**
1. Initialize Git: `git init`
2. Stage all files: `git add .`
3. First commit using **`conventional-commit`** format:
```
chore: scaffold [project-name] with [stack]

- Generated folder structure (Template [A/B/C])
- Created AGENTS.md with architecture rules
- Setup design system tokens
- Added .env.example and .gitignore
- Created plan/ directory for workflow integration
```

---

## ✅ Completion Checklist

Before declaring scaffold complete, verify:

- [ ] All folders from chosen template exist
- [ ] AGENTS.md has all sections filled (no `[placeholder]` text)
- [ ] .env.example lists ALL required environment variables
- [ ] .gitignore covers language-specific patterns
- [ ] README.md has setup instructions that actually work
- [ ] DESIGN.md + design-tokens.css exist (if frontend)
- [ ] `plan/` directory structure matches workflow conventions
- [ ] First git commit is clean and passes linting
- [ ] Project can be started with a single command (e.g., `npm run dev` or `uvicorn app.main:app`)

**Output to user:**
```
✅ Scaffold complete: [project-name]
   📁 Structure: Template [A/B/C]
   🤖 AGENTS.md: Ready (X rules, X nevers)
   🎨 Design System: [Yes/No]
   📝 First commit: [hash]
   
   Next: Run "Autopilot: [first feature]" to start building.
```

---

## 🧰 Workflow Skill Summary

*All skills are loaded dynamically from `.agent/skills/` without hardcoded absolute paths.*

| Skill | Step | Purpose |
|---|---|---|
| `.agent/skills/grill-me` | 1 — Interview | Extract project requirements |
| `.agent/skills/acquire-codebase-knowledge` | 1 — Interview | Map existing codebase if migrating |
| `.agent/skills/frontend-design` | 4 — Design | Generate design system |
| `.agent/skills/ui-ux-pro-max` | 4 — Design | Premium design constraints |
| `.agent/skills/premium-frontend-ui` | 4 — Design | Motion/performance guardrails |
| `.agent/skills/fastapi-templates` | 2 — Generate | FastAPI boilerplate |
| `.agent/skills/frontend-developer` | 2 — Generate | React/Next.js conventions |
| `.agent/skills/conventional-commit` | 6 — Init | Commit message standards |
