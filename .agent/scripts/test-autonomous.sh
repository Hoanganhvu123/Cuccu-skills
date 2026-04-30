#!/usr/bin/env bash
# Autonomous Launcher - Config Test (JSON version)
echo "=== Autonomous Launcher Config Test ==="
echo ""

echo "1. Checking required files..."
FILES=(
  ".agent/workflows/autonomous.json"
  "agents/autonomous-launcher.md"
  "commands/autonomous-launch.md"
  ".agent/scripts/detect-mode.sh"
  ".agent/scripts/load-config.js"
)

for file in "${FILES[@]}"; do
  if [ -f "$file" ]; then
    echo "   ✓ $file exists"
  else
    echo "   ✗ $file MISSING"
  fi
done

echo ""
echo "2. Checking JSON config validity..."
if command -v node &> /dev/null; then
  CONFIG=$(node .agent/scripts/load-config.js 2>/dev/null)
  if [ $? -eq 0 ] && [ -n "$CONFIG" ]; then
    echo "   ✓ JSON config valid"
    MODE=$(echo "$CONFIG" | node -e "console.log(JSON.parse(require('fs').readFileSync(0,'utf8')).mode)")
    echo "   Workflow mode: $MODE"
    DIRS=$(echo "$CONFIG" | node -e "const c=JSON.parse(require('fs').readFileSync(0,'utf8')); console.log(`Design: ${c.output.design_doc_dir}, Plan: ${c.output.plan_doc_dir}`)")
    echo "   $DIRS"
  else
    echo "   ✗ JSON config invalid or empty"
  fi
else
  echo "   ⚠ Node.js not installed"
fi

echo ""
echo "3. Testing mode detection..."
if [ -f ".agent/scripts/detect-mode.sh" ]; then
  chmod +x .agent/scripts/detect-mode.sh
  MODE=$(bash .agent/scripts/detect-mode.sh)
  echo "   Detected mode: $MODE"
fi

echo ""
echo "4. Checking Superpowers skills..."
SKILLS=(
  "brainstorming"
  "writing-plans"
  "subagent-driven-development"
  "finishing-a-development-branch"
)

for skill in "${SKILLS[@]}"; do
  if [ -d ".agent/skills/$skill" ]; then
    echo "   ✓ $skill"
  else
    echo "   ⚠ $skill not found (install Superpowers)"
  fi
done

echo ""
echo "=== Test Complete ==="
echo ""
echo "To use: /go or /autonomous-launch"
echo "Docs: See AUTONOMOUS_LAUNCHER.md (agent) or SETUP_AUTONOMOUS.md (user)"
