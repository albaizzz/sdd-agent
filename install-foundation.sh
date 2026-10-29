#!/usr/bin/env bash
set -euo pipefail

SRC_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
SKILL_DIR="$SRC_DIR/.opencode/skills/sdd"
CLAUDE_SKILL_DIR="$SRC_DIR/.claude/skills/sdd"
SPEC_FILE="$SRC_DIR/specs.md"
AGENTS_FILE="$SRC_DIR/AGENTS.md"
CLAUDE_FILE="$SRC_DIR/CLAUDE.md"
COPILOT_FILE="$SRC_DIR/.github/copilot-instructions.md"

usage() {
  echo "Usage: $0 <target-repo-path>"
  echo "Installs the SDD skill (opencode + Claude Code) and SDD entry-point docs"
  echo "(AGENTS.md, CLAUDE.md, .github/copilot-instructions.md) into a target repo,"
  echo "so the workflow works across opencode, Claude Code, Codex, and GitHub Copilot."
  echo
  echo "Example:"
  echo "  $0 /path/to/office/service-repo"
  exit 1
}

if [ $# -ne 1 ]; then usage; fi
TARGET="$1"

if [ ! -d "$TARGET" ]; then
  echo "ERROR: target '$TARGET' is not a directory" >&2
  exit 1
fi
if [ ! -d "$SKILL_DIR" ]; then
  echo "ERROR: skill folder not found at '$SKILL_DIR'" >&2
  exit 1
fi

install_or_append() {
  local src="$1" dst="$2" marker="$3"
  if [ ! -f "$src" ]; then
    echo "    SKIP ($marker): source missing '$src'"
    return 0
  fi
  if [ -f "$dst" ]; then
    if grep -q "$marker" "$dst" 2>/dev/null; then
      echo "    KEEP $dst (already contains SDD rules)"
    else
      cp "$src" "$dst"
      echo "    OVERWRITE $dst (had no SDD rules, replaced)"
    fi
  else
    cp "$src" "$dst"
    echo "    CREATE $dst"
  fi
}

echo "==> Installing SDD workflow into '$TARGET'"

# 1. opencode skill
mkdir -p "$TARGET/.opencode/skills"
cp -r "$SKILL_DIR" "$TARGET/.opencode/skills/sdd"
echo "    corelib  -> .opencode/skills/sdd/"

# 2. Claude Code skill
mkdir -p "$TARGET/.claude/skills"
cp -r "$CLAUDE_SKILL_DIR" "$TARGET/.claude/skills/sdd"
echo "    corelib  -> .claude/skills/sdd/"

# 3. specs.md
install_or_append "$SPEC_FILE" "$TARGET/specs.md" "Specification-Driven Development"

# 4. AGENTS.md (Codex, Copilot, opencode read this)
# NOTE: AGENTS.md is also a foundation doc. We seed it with SDD rules + empty Coding SOP
# placeholders; the skill's interview fills the Coding SOP during the foundation gate.
install_or_append "$AGENTS_FILE" "$TARGET/AGENTS.md" "Specification-Driven Development"

# 5. CLAUDE.md (Claude Code)
install_or_append "$CLAUDE_FILE" "$TARGET/CLAUDE.md" "Claude Code"

# 6. Copilot instructions
mkdir -p "$TARGET/.github"
install_or_append "$COPILOT_FILE" "$TARGET/.github/copilot-instructions.md" "Copilot Instructions"

echo
echo "Done."
echo "- Skills: .opencode/skills/sdd/ + .claude/skills/sdd/"
echo "- Docs:   specs.md, AGENTS.md, CLAUDE.md, .github/copilot-instructions.md"
echo
echo "Next:"
echo "1. Restart opencode / Claude Code in the target repo to load the skill."
echo "2. Run the foundation gate (the skill will interview you and fill the Coding SOP"
echo "   in AGENTS.md, plus create PRD/DESIGN_SYSTEM/ARCHITECTURE if missing)."
echo "3. Existing AGENTS.md/CLAUDE.md WITHOUT SDD rules were overwritten - review the diff."
