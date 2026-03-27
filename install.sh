#!/bin/bash
# dcamp Design System - Claude Code Skill Installer

set -e

REPO="dcamp2/dcamp_designsystem"
BRANCH="main"
BASE_URL="https://raw.githubusercontent.com/${REPO}/${BRANCH}"
SKILL_DIR="$HOME/.claude/skills/ui-standards"
CLAUDE_MD="$HOME/.claude/CLAUDE.md"
DIRECTIVE="- 모든 프론트엔드 코드는 반드시 ui-standards 스킬을 참조하여 작성할 것 (dcamp Design System)"

echo "=== dcamp Design System Installer ==="
echo ""

# Create directories
mkdir -p "${SKILL_DIR}/references"

# Download files
echo "Downloading SKILL.md..."
curl -fsSL "${BASE_URL}/skills/ui-standards/SKILL.md" -o "${SKILL_DIR}/SKILL.md"

echo "Downloading design-system.md..."
curl -fsSL "${BASE_URL}/skills/ui-standards/references/design-system.md" -o "${SKILL_DIR}/references/design-system.md"

echo "Downloading component-patterns.md..."
curl -fsSL "${BASE_URL}/skills/ui-standards/references/component-patterns.md" -o "${SKILL_DIR}/references/component-patterns.md"

echo "Downloading chart-standards.md..."
curl -fsSL "${BASE_URL}/skills/ui-standards/references/chart-standards.md" -o "${SKILL_DIR}/references/chart-standards.md"

echo "Downloading app-scaffold.md..."
curl -fsSL "${BASE_URL}/skills/ui-standards/references/app-scaffold.md" -o "${SKILL_DIR}/references/app-scaffold.md"

# Add directive to global CLAUDE.md (idempotent)
if [ -f "$CLAUDE_MD" ]; then
  if ! grep -qF "ui-standards" "$CLAUDE_MD"; then
    echo "" >> "$CLAUDE_MD"
    echo "$DIRECTIVE" >> "$CLAUDE_MD"
    echo "Added ui-standards directive to $CLAUDE_MD"
  else
    echo "ui-standards directive already exists in $CLAUDE_MD"
  fi
else
  echo "# CLAUDE.md" > "$CLAUDE_MD"
  echo "" >> "$CLAUDE_MD"
  echo "$DIRECTIVE" >> "$CLAUDE_MD"
  echo "Created $CLAUDE_MD with ui-standards directive"
fi

echo ""
echo "Installed to: ${SKILL_DIR}"
echo ""
echo "Files:"
ls -la "${SKILL_DIR}/SKILL.md"
ls -la "${SKILL_DIR}/references/"
echo ""
echo "Done! Restart Claude Code to activate the ui-standards skill."
