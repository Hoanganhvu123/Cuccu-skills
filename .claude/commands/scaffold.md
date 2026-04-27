# /scaffold — New Project Bootstrap (≤10 min)

Create a new project from scratch: **$ARGUMENTS**

## Phase 1: Project Structure (3 min)

Generate the following directory structure:

```
project-name/
├── .claude/
│   ├── agents/          ← Copy from Cuccu-skills
│   ├── commands/        ← Copy from Cuccu-skills
│   ├── hooks/           ← Copy from Cuccu-skills
│   └── settings.json   ← Copy from Cuccu-skills
├── .agent/
│   └── AGENTS.md        ← Project constitution
├── src/
│   ├── components/      ← UI components
│   ├── pages/           ← Page routes
│   ├── services/        ← API/business logic
│   ├── utils/           ← Shared utilities
│   └── types/           ← TypeScript types
├── tests/
│   ├── unit/
│   ├── integration/
│   └── e2e/
├── plan/
│   ├── ideas/
│   ├── process/
│   ├── doings/
│   │   └── sub_doings/
│   ├── done/
│   └── hotfixes/
├── docs/
│   └── adr/             ← Architecture Decision Records
├── .env.example         ← Template (NEVER real values)
├── .gitignore
├── package.json
├── tsconfig.json
└── README.md
```

## Phase 2: Design System (3 min)

Use @frontend-designer to create initial design tokens:
- Color palette (dark mode first)
- Typography scale (Inter + Outfit)
- Spacing system (8px grid)
- Shadow and motion tokens

## Phase 3: Constitution (2 min)

Generate `AGENTS.md` with:
- Project-specific coding standards
- Tech stack declaration
- Testing requirements
- Deployment workflow

## Phase 4: First Commit (2 min)

```bash
git init
git add .
git commit -m "chore: scaffold [project-name] — Cuccu-skills autonomous SDLC"
```

## After Scaffold
Continue with Pipeline A (Feature) from /autopilot to build the first feature.
