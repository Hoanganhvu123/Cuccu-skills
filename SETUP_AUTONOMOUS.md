# 🚀 Autonomous Launcher - Complete Setup

## What You Got

**One-button full workflow** from idea to production:

```
/go → brainstorming → plan → build → review → finish
```

## Files Structure

```
.agent/
├── workflows/
│   └── autonomous.yaml       # Config (mode, paths, stages)
├── scripts/
│   ├── detect-mode.sh        # Git-based mode detection
│   ├── load-config.js        # YAML parser
│   └── test-autonomous.sh    # Test suite
├── skills/                    (from Superpowers)
│   ├── brainstorming/
│   ├── writing-plans/
│   ├── subagent-driven-development/
│   └── finishing-a-development-branch/
agents/
└── autonomous-launcher.md    # Orchestrator agent
commands/
└── autonomous-launch.md      # Slash command definition
plan/                         # Your plans folder (existing)
docs/plans/designs/           # Design docs (auto-created)
AUTONOMOUS_LAUNCHER.md        # This guide
```

## Quick Start

1. **Test setup:**
   ```bash
   .agent/scripts/test-autonomous.sh
   ```

2. **Run workflow:**
   ```
   /go
   ```

3. **Customize:**
   Edit `.agent/workflows/autonomous.yaml`:
   ```yaml
   output:
     design_doc_dir: "docs/plans/designs"   # Your preferred location
     plan_doc_dir: "docs/plans"
   ```

## How It Works

| Stage | Skill | Output | Duration |
|-------|-------|--------|----------|
| **1. Design** | `brainstorming` | `docs/plans/designs/YYYY-MM-DD-topic-design.md` | 5-15 min |
| **2. Plan** | `writing-plans` | `docs/plans/YYYY-MM-DD-topic-plan.md` | 2-10 min |
| **3. Build** | `subagent-driven-development` | Code + tests | 10 min - 2 hrs |
| **4. Finish** | `finishing-a-development-branch` | Branch ready | 2-5 min |

## Modes

**Creation Mode** (new project):
- No git commits
- Starts from blank idea
- Full architecture design

**Evolution Mode** (existing code):
- Has git history
- Analyzes codebase first
- Enhancement-focused design

Auto-detected from git. Override in config: `mode: creation` or `mode: evolution`.

## Customization

### Change Output Locations

```yaml
output:
  design_doc_dir: "my/custom/designs"
  plan_doc_dir: "my/custom/plans"
```

### Disable Worktree Isolation

```yaml
options:
  use_worktree: false
```

### Require Confirmation Per Stage

```yaml
options:
  confirm_each_stage: true
```

## Examples

**New Project:**
```
User: /go
Agent: Starting autonomous workflow in creation mode...
[Design questions...]
[Plan creation...]
[Building...]
```

**Add Feature:**
```
User: /go, add user auth
Agent: Detected evolution mode, analyzing codebase...
[Enhancement design...]
[Plan...]
[Build...]
```

## Troubleshooting

**"Skill not found"**: Copy skills from Superpowers:
```bash
cp -r superpowers-analysis/skills/* .agent/skills/
```

**Mode wrong**: Set explicit mode in `.agent/workflows/autonomous.yaml`:
```yaml
mode: creation  # or evolution
```

**Config load error**: Validate YAML syntax (use Python or online YAML validator).

---

**That's it! One command, full pipeline.** 🎯

For detailed docs: See `AUTONOMOUS_LAUNCHER.md` (agent perspective).
