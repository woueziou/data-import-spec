#!/usr/bin/env bash
set -euo pipefail

usage() {
  printf 'Usage: %s [--force]\n' "${0##*/}"
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

if [[ $# -ne 0 ]]; then
  usage
  exit 1
fi

REPO_DIR="$(pwd)"
MODE_FILE="$REPO_DIR/.dmp/source-mode.txt"
SOURCE_FILE="$REPO_DIR/.dmp/source-repo.txt"
REF_FILE="$REPO_DIR/.dmp/source-ref.txt"

if [[ ! -f "$SOURCE_FILE" ]]; then
  printf 'Missing %s. Reinstall from the source framework repo first.\n' "$SOURCE_FILE"
  exit 1
fi

SOURCE_MODE="local"
SOURCE_REF="local"

if [[ -f "$MODE_FILE" ]]; then
  SOURCE_MODE="$(cat "$MODE_FILE")"
fi

if [[ -f "$REF_FILE" ]]; then
  SOURCE_REF="$(cat "$REF_FILE")"
fi

SOURCE_REPO="$(cat "$SOURCE_FILE")"

if [[ "$SOURCE_MODE" == "github" ]]; then
  TMP_DIR="$(mktemp -d /private/tmp/dmp-github-reinstall.XXXXXX)"
  trap 'rm -rf "$TMP_DIR"' EXIT
  git clone --depth 1 --branch "$SOURCE_REF" "https://github.com/$SOURCE_REPO.git" "$TMP_DIR/source"
  INSTALLER="$TMP_DIR/source/scripts/install.sh"
  if [[ "$FORCE" -eq 1 ]]; then
    exec env DMP_SOURCE_MODE=github DMP_SOURCE_REPO="$SOURCE_REPO" DMP_SOURCE_REF="$SOURCE_REF" \
      "$INSTALLER" --force "$REPO_DIR"
  fi
  exec env DMP_SOURCE_MODE=github DMP_SOURCE_REPO="$SOURCE_REPO" DMP_SOURCE_REF="$SOURCE_REF" \
    "$INSTALLER" "$REPO_DIR"
fi

INSTALLER="$SOURCE_REPO/scripts/install.sh"

if [[ ! -x "$INSTALLER" ]]; then
  printf 'Installer not found at %s\n' "$INSTALLER"
  exit 1
fi

if [[ "$FORCE" -eq 1 ]]; then
  exec "$INSTALLER" --force "$REPO_DIR"
fi

exec "$INSTALLER" "$REPO_DIR"
