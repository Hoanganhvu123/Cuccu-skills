# /audit — Manual QA Audit Trigger

Run a comprehensive 4-dimension quality audit on: **$ARGUMENTS**

If no scope is specified, audit the entire project.

## Execution

Use @qa-gatekeeper to run the full 4-dimension audit:

1. **🔒 Security (30%)** — Secrets, injection, auth, dependencies
2. **⚡ Performance (25%)** — N+1 queries, bundle size, async patterns
3. **🎨 UI/UX (25%)** — Responsive, accessibility, error states, design tokens
4. **✅ Compliance (20%)** — Tests pass, coverage, lint, commit format

## Expected Output

A structured audit report with:
- Score per dimension (0-100)
- Weighted total score
- PASS / CONDITIONAL / FAIL verdict
- Critical findings (must fix before release)
- Warnings (should fix)
- Recommendations (nice to have)

## Verdict Rules
- ≥ 85 → ✅ PASS (clear for production)
- 70-84 → ⚠️ CONDITIONAL (fix warnings first)
- < 70 → ❌ FAIL (block release)
- ANY critical finding → automatic FAIL
