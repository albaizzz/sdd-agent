#!/usr/bin/env bash
set -euo pipefail

SRC_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
SKILL_DIR="$SRC_DIR/.opencode/skills/sdd-foundation-gate"
SPEC_FILE="$SRC_DIR/specs-v2.md"

usage() {
  echo "Usage: $0 <target-repo-path>"
  echo "Installs the SDD foundation-gate skill + specs-v2.md into a target project repo."
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

TARGET_SKILL="$TARGET/.opencode/skills"

echo "==> Installing SDD foundation-gate skill into '$TARGET'"
mkdir -p "$TARGET_SKILL"
cp -r "$SKILL_DIR" "$TARGET_SKILL/"
echo "    skill  -> $TARGET_SKILL/sdd-foundation-gate/"

if [ -f "$TARGET/specs-v2.md" ]; then
  cp "$SPEC_FILE" "$TARGET/specs-v2.md"
  echo "    specs  -> $TARGET/specs-v2.md (overwritten)"
else
  cp "$SPEC_FILE" "$TARGET/specs-v2.md"
  echo "    specs  -> $TARGET/specs-v2.md"
fi

echo
echo "Done. 4 foundation docs (PRD/DESIGN_SYSTEM/ARCHITECTURE/AGENTS) are NOT copied"
echo "on purpose - the skill creates them by interviewing the developer per project."
echo "Restart opencode in the target repo for the skill to load."