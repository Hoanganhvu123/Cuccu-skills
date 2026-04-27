---
name: Audit & Release Workflow (QA Gatekeeper)
description: A pre-flight checklist workflow that strictly enforces quality, security, and performance standards before code is considered production-ready.
---

# 🛡️ Audit & Release Workflow (QA Gatekeeper)

> The final line of defense. This workflow audits "Done" epics to ensure they meet production standards before deployment. It does NOT build features; it only breaks them.

---

## 🧠 Skill Integrations

The AI assumes the persona of a ruthless QA & Security Engineer. It MUST trigger the following skills:

### Security & Secrets (Mandatory for every audit)
- **`security-review`**: The core security scanner. Traces data flows across files, finds SQL injection, XSS, hardcoded secrets, JWT weaknesses, SSRF, race conditions. Runs a full 8-step pipeline: Scope → Dependency Audit → Secrets Scan → Vuln Deep Scan → Cross-File Data Flow → Self-Verification → Report → Propose Patches.
- **`secret-scanning`**: Configures GitHub Push Protection to block secrets from ever reaching the repo. Ensures `.env` files are never committed.
- **`mcp-security-audit`**: Audits `.mcp.json` files for hardcoded credentials, shell injection patterns, and unpinned dependencies (`@latest`).

### AI Agent Security (Trigger when auditing AI/LLM projects)
- **`agent-owasp-compliance`**: Checks AI agents against the OWASP ASI Top 10 — Prompt Injection protection, Tool Use Governance, Excessive Agency, Escalation Controls, Trust Boundaries, Logging, Identity, Policy, Supply Chain, Behavioral Monitoring.
- **`threat-model-analyst`**: Performs STRIDE-A threat modeling with DFD diagrams, CVSS 4.0 scoring, and prioritized findings.

### Code Quality & Verification
- **`quality-playbook`**: Generates a complete quality system — QUALITY.md constitution, functional tests, code review protocol, integration test protocol, Council of Three spec audit, and AGENTS.md bootstrap. Includes "Coverage Theater Prevention" to catch fake tests.
- **`doublecheck`**: 3-layer verification pipeline to catch AI hallucinations — extracts claims, web-searches for sources, runs adversarial review. Auto-escalates to full report on DISPUTED or FABRICATION RISK findings.

### UI/UX & Visual QA (Trigger when frontend was modified)
- **`web-design-reviewer`**: Uses Playwright MCP to take screenshots at 4 viewports (375px, 768px, 1280px, 1920px), detects layout overflow, alignment issues, accessibility problems, and auto-fixes at source code level.
- **`premium-frontend-ui`**: Enforces motion design performance guardrails — only animate `transform`/`opacity`, `will-change` cleanup, `prefers-reduced-motion` respect, hardware-accelerated compositing.
- **`react-doctor`**: Scans React code for deep bugs, unnecessary re-renders, missing hook dependencies.

---

## Trigger — When to Use This Workflow

| Input Type | Example |
|---|---|
| Manual Audit | `"Audit Epic 04"` or `"Run QA on the Stripe integration"` |
| Autopilot Handoff | Triggered automatically by `workflow-autopilot.md` at Phase 4. |
| Pre-deploy check | `"Is this code ready for production?"` |

---

## 📋 The Pre-Flight Checklist

The AI must scan the codebase (specifically files modified in the Epic) against these 4 dimensions:

### Dimension 1: Security & Hygiene
> Skills triggered: `security-review`, `secret-scanning`, `mcp-security-audit`

- [ ] No hardcoded API keys or secrets (must use `.env` / environment variables).
- [ ] No `console.log()` or `debugger` statements left in production code.
- [ ] Authentication / Authorization checks are properly applied to new endpoints.
- [ ] Dependencies audited for known CVEs (check `requirements.txt`, `package.json`).
- [ ] `.mcp.json` files use `${ENV_VAR}` references, not hardcoded tokens.
- [ ] Push Protection is configured to block future secret leaks.

### Dimension 2: AI Agent Security (if applicable)
> Skills triggered: `agent-owasp-compliance`, `threat-model-analyst`

- [ ] User input is validated BEFORE reaching tool execution (ASI-01).
- [ ] Tools have explicit allowlists, not open-ended access (ASI-02).
- [ ] Agent capabilities are bounded by principle of least privilege (ASI-03).
- [ ] No self-promotion patterns — agents cannot escalate their own privileges (ASI-04).
- [ ] All tool calls produce structured audit trail entries (ASI-06).
- [ ] Policy enforcement is deterministic, not LLM-based (ASI-08).
- [ ] Circuit breakers and kill switch are implemented (ASI-10).

### Dimension 3: Architecture & Performance
> Skills triggered: `quality-playbook`, `react-doctor`

- [ ] **React/Frontend**: No prop-drilling exceeding 3 levels, `useEffect` dependencies are exhaustive, memoization used where computationally heavy.
- [ ] **Backend/DB**: No N+1 query vulnerabilities introduced. Database connections are properly closed/pooled.
- [ ] **Asset Size**: Images or assets added are optimized/compressed.
- [ ] **Coverage Theater**: Tests actually test meaningful behavior, not just `assert True` or `isinstance()` checks.
- [ ] **State Machines**: All status fields handle every possible state (no unhandled branches in switch/match).

### Dimension 4: UI/UX Quality Assurance (Taste Check)
> Skills triggered: `web-design-reviewer`, `premium-frontend-ui`

- [ ] Typography strictly follows the defined Design System (no default browser fonts).
- [ ] Padding and margins use a consistent scale (e.g., 4pt grid).
- [ ] Interactive elements have distinct hover/active/disabled states.
- [ ] Layout tested at 4 viewports: Mobile (375px), Tablet (768px), Desktop (1280px), Wide (1920px).
- [ ] Animations only use `transform` and `opacity` (no `width`/`height`/`top`/`margin` animations).
- [ ] `@media (prefers-reduced-motion)` respected for all continuous animations.
- [ ] No element overflow or unintended overlap detected via screenshot comparison.

---

## 📝 The Audit Report

If the audit **fails** ANY check, generate an Audit Report and either:
- Send the epic back to `workflow-doings.md` for fixes, OR
- Spawn a `sub_doings` bug fix task.

If the audit **passes 100%**, generate the final release notes:

```markdown
# 🚀 Release: [Epic Name]

## 🛡️ Audit Results
- **Security (Dim 1):** ✅ PASS — X findings resolved
- **Agent Security (Dim 2):** ✅ PASS — OWASP ASI 10/10
- **Performance (Dim 3):** ✅ PASS — No coverage theater detected
- **UI/UX (Dim 4):** ✅ PASS — All viewports clean

## 📊 Security Scan Summary
| Severity | Count |
|----------|-------|
| 🔴 CRITICAL | 0 |
| 🟠 HIGH | 0 |
| 🟡 MEDIUM | 0 |
| 🔵 LOW | X |

## 📋 Changelog
- [Feature 1]
- [Feature 2]

## 🚀 Verdict
Safe to deploy.
```

---

## 🧰 Workflow Skill Summary

*All skills are loaded dynamically from `.agent/skills/` without hardcoded absolute paths.*

| Skill | Dimension | Purpose |
|---|---|---|
| `.agent/skills/security-review` | 1 — Security | Full 8-step security deep scan |
| `.agent/skills/secret-scanning` | 1 — Security | Block secrets from reaching Git |
| `.agent/skills/mcp-security-audit` | 1 — Security | Audit MCP server configurations |
| `.agent/skills/agent-owasp-compliance` | 2 — Agent Security | OWASP ASI Top 10 compliance |
| `.agent/skills/threat-model-analyst` | 2 — Agent Security | STRIDE-A threat modeling with DFD |
| `.agent/skills/quality-playbook` | 3 — Performance | Generate 6-file quality system |
| `.agent/skills/doublecheck` | 3 — Performance | 3-layer AI hallucination detection |
| `.agent/skills/react-doctor` | 3 — Performance | Hunt React performance bugs |
| `.agent/skills/web-design-reviewer` | 4 — UI/UX | Visual QA with Playwright screenshots |
| `.agent/skills/premium-frontend-ui` | 4 — UI/UX | Motion design performance guardrails |
