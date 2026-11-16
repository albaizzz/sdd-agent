#!/usr/bin/env bash
# Installer SDD tanpa clone repo. Unduh arsip dari GitHub, lalu jalankan install-foundation.sh.
#
# Usage:
#   curl -fsSL https://raw.githubusercontent.com/albaizzz/sdd-agent/main/install.sh | bash -s -- /path/to/repo
#
# Env opsional:
#   SDD_REPO  owner/repo  (default: albaizzz/sdd-agent)
#   SDD_REF   nama branch (default: main)
set -euo pipefail

REPO="${SDD_REPO:-albaizzz/sdd-agent}"
REF="${SDD_REF:-main}"
TARGET="${1:-$PWD}"

for cmd in curl tar; do
  if ! command -v "$cmd" >/dev/null 2>&1; then
    echo "ERROR: '$cmd' is required" >&2
    exit 1
  fi
done

TMP_DIR="$(mktemp -d)"
trap 'rm -rf "$TMP_DIR"' EXIT

echo "==> Downloading $REPO@$REF"
mkdir -p "$TMP_DIR/src"
curl -fsSL "https://codeload.github.com/$REPO/tar.gz/refs/heads/$REF" \
  | tar -xz -C "$TMP_DIR/src" --strip-components=1

bash "$TMP_DIR/src/install-foundation.sh" "$TARGET"
