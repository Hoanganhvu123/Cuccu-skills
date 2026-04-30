---
name: autonomous-launch
description: One-button full workflow from idea to production
---

# Autonomous Launch Command

Invoke this to run the complete A-Z workflow automatically.

## Usage

```
/go
/autonomous-launch
/full-cycle
```

All three trigger the same autonomous workflow.

## What It Does

1. Detects mode (creation vs evolution) from git state
2. Runs brainstorming → design doc
3. Creates implementation plan
4. Executes plan with subagents (TDD + review)
5. Verifies and prepares for merge/PR

## Requirements

- `.agent/workflows/autonomous.yaml` config file
- Superpowers skills installed (brainstorming, writing-plans, etc.)
- Git repository (for worktree isolation)

## Example Session

```
User: I want to build a real-time chat app with WebSocket support
Assistant: Starting autonomous workflow in creation mode...
[Design phase - asks questions, gets approval]
[Plan phase - creates task list]
[Execution phase - builds automatically]
[Completion - tests pass, branch ready]
```

## Configuration

Edit `.agent/workflows/autonomous.yaml` to customize:
- Output paths for design/plan docs
- Git detection rules
- Workflow stages

## Notes

- Saves all docs to `docs/plans/` (your custom folder)
- Creates isolated worktree if configured
- Updates checkboxes in plan file as tasks complete
- Requires design approval before building (safety gate)
