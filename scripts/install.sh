#!/usr/bin/env bash
set -euo pipefail

usage() {
  printf 'Usage: %s [--force] <target-repo>\n' "${0##*/}"
}

if [[ "${1:-}" == "-h" || "${1:-}" == "--help" ]]; then
  usage
  exit 0
fi

FORCE=0

if [[ "${1:-}" == "--force" ]]; then
  FORCE=1
  shift
fi

if [[ $# -ne 1 ]]; then
  usage
  exit 1
fi

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
REPO_DIR="$(cd "$SCRIPT_DIR/.." && pwd)"
TARGET_DIR="$1"
MANIFEST="$REPO_DIR/install/manifest.txt"
VERSION="$(tr -d ' \t\r\n' < "$REPO_DIR/VERSION")"
INSTALLED_AT="$(date -u +%Y-%m-%dT%H:%M:%SZ)"

mkdir -p "$TARGET_DIR"
TARGET_DIR="$(cd "$TARGET_DIR" && pwd)"

if [[ "$TARGET_DIR" == "$REPO_DIR" ]]; then
  printf 'Target repo matches the source repo. Nothing to install.\n'
  exit 0
fi

guard_root_file() {
  local path="$1"
  if [[ -e "$TARGET_DIR/$path" && "$FORCE" -ne 1 ]]; then
    printf 'Refusing to overwrite %s. Re-run with --force if you want to replace it.\n' "$TARGET_DIR/$path"
    exit 1
  fi
}

guard_root_file "AGENTS.md"
guard_root_file "GEMINI.md"

copy_dir() {
  local src="$1"
  local dest="$2"
  mkdir -p "$TARGET_DIR/$dest"
  cp -R "$src"/. "$TARGET_DIR/$dest"/
}

copy_file() {
  local src="$1"
  local dest="$2"
  mkdir -p "$(dirname "$TARGET_DIR/$dest")"
  cp "$src" "$TARGET_DIR/$dest"
}

while IFS='|' read -r src dest; do
  [[ -z "${src:-}" || "${src:0:1}" == "#" ]] && continue
  if [[ -d "$REPO_DIR/$src" ]]; then
    copy_dir "$REPO_DIR/$src" "$dest"
  else
    copy_file "$REPO_DIR/$src" "$dest"
  fi
done < "$MANIFEST"

mkdir -p "$TARGET_DIR/.dmp"
cat > "$TARGET_DIR/.dmp/install.json" <<EOF
{
  "name": "dmp",
  "version": "$VERSION",
  "installedAt": "$INSTALLED_AT"
}
EOF

printf 'Installed dmp %s to %s\n' "$VERSION" "$TARGET_DIR"
