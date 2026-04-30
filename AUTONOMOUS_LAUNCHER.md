# Autonomous Launcher - Quick Start Guide

## Installation

1. Copy the files to your project:
   - `.agent/workflows/autonomous.yaml` (config)
   - `agents/autonomous-launcher.md` (orchestrator agent)
   - `commands/autonomous-launch.md` (slash command)
   - `.agent/scripts/` (helper scripts)

2. Ensure Superpowers skills are installed:
   - `brainstorming`
   - `writing-plans`
   - `subagent-driven-development`
   - `test-driven-development`
   - `finishing-a-development-branch`

## Usage

### One-Button Start

```
/go
```

That's it! The autonomous workflow will:

1. Detect if you're starting fresh (creation) or adding to existing code (evolution)
2. Run brainstorming to get a solid design
3. Create a detailed implementation plan in `docs/plans/`
4. Execute the plan automatically using subagents
5. Verify everything works and prepare for merge

### Customization

Edit `.agent/workflows/autonomous.yaml`:

```yaml
output:
  design_doc_dir: "docs/plans/designs"   # Where design docs go
  plan_doc_dir: "docs/plans"             # Where plans go

options:
  use_worktree: true      # Isolated branch (recommended)
  confirm_each_stage: false  # Set true to ask before each phase
```

## Workflow Stages

| Stage | Skill | Output |
|-------|-------|--------|
| 1. Design | `brainstorming` | `docs/plans/designs/YYYY-MM-DD-topic-design.md` |
| 2. Plan | `writing-plans` | `docs/plans/YYYY-MM-DD-topic-plan.md` |
| 3. Build | `subagent-driven-development` | Code + tests |
| 4. Finish | `finishing-a-development-branch` | Branch ready to merge |

## Example

```
User: /go
Assistant: Starting autonomous workflow in creation mode...

[Design questions...]
[Design approved, saved to docs/plans/designs/2025-04-30-todo-app-design.md]

[Creating plan...]
[Plan saved to docs/plans/2025-04-30-todo-app-plan.md]

[Executing tasks...]
- Task 1: Write failing test [✓]
- Task 2: Implement minimal code [✓]
- Task 3: Run tests, verify pass [✓]
...

[All 24 tasks complete!]
[Tests passing. Branch ready. Merge? (yes/no/PR)]
```

## Progress Tracking

Progress is tracked in the plan file via checkboxes and optionally saved to:
```
docs/plans/.workflow-progress.json
```

## Modes

**Creation Mode** (new project):
- No git history
- Blank directory
- Starts from pure idea

**Evolution Mode** (existing codebase):
- Has git commits
- Existing source files
- Analyzes codebase before designing

Mode auto-detects from git state, or override in config.

## Requirements

- Git installed and accessible
- Write permissions to project directory
- Superpowers skills available
- Node.js (for config loader script)

## Troubleshooting

**Config not found**: Copy `.agent/workflows/autonomous.yaml` to project root

**Skills not triggering**: Ensure Superpowers is properly installed in your agent harness

**Mode wrong**: Set `mode: creation` or `mode: evolution` explicitly in config

---

**That's all! One command, full pipeline.** 🚀
