# /autopilot — Autonomous SDLC Pipeline

Classify the intent of this task and execute the appropriate pipeline:

**Task:** $ARGUMENTS

## Intent Classification

1. **Is this a PRODUCTION BUG or EMERGENCY?**
   - YES → Execute **Pipeline B (Hotfix)**: Use @tdd-executor in hotfix mode (characterization test → fix → verify), then @security-reviewer for targeted security scan.

2. **Is this a NEW PROJECT (no existing codebase)?**
   - YES → Execute **Pipeline C (Scaffold)**: Create project structure, AGENTS.md, design tokens, then continue with Pipeline A.

3. **Is this a REFACTOR / TECH DEBT / CLEANUP?**
   - YES → Execute **Pipeline D (Refactor)**: Use @security-reviewer to audit current state, @tdd-executor to write characterization tests, plan atomic commits, execute refactor, then @qa-gatekeeper to verify.

4. **Otherwise, this is a NEW FEATURE:**
   - Execute **Pipeline A (Feature)**: Research scope → @tdd-executor for implementation → @security-reviewer for security review → @qa-gatekeeper for final 4-dimension audit.

## Pipeline Rules
- Always save artifacts to `plan/` directory with zero-padded naming: `[XX]_[name].md`
- Summarize context (≤200 words) before transitioning between phases
- HALT and ask the user if: Feasibility verdict is IMPOSSIBLE, blast radius > 5 files, or > 3 failed audit retries
