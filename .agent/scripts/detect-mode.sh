#!/usr/bin/env bash
# Autonomous Launcher - Git Mode Detection
# Returns: "creation" or "evolution"

set -e

# Check if inside git repo
if ! git rev-parse --is-inside-work-tree > /dev/null 2>&1; then
  echo "creation"
  exit 0
fi

# Check if there are any commits
if ! git rev-parse HEAD > /dev/null 2>&1; then
  echo "creation"
  exit 0
fi

# Check for uncommitted changes
if git diff --name-only | grep -q .; then
  echo "evolution"
  exit 0
fi

# Default: evolution (has commits, clean working tree)
echo "evolution"
