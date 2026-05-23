#!/usr/bin/env bash
set -euo pipefail

usage() {
  printf 'Usage: %s --repo owner/name [--ref tag-or-branch] [--force] [target-repo]\n' "${0##*/}"
}

REPO=""
REF="main"
FORCE=0
TARGET_DIR="."

while [[ $# -gt 0 ]]; do
  case "$1" in
    --repo)
      REPO="${2:-}"
      shift 2
      ;;
    --ref)
      REF="${2:-}"
      shift 2
      ;;
    --force)
      FORCE=1
      shift
      ;;
    -h|--help)
      usage
      exit 0
      ;;
    *)
      TARGET_DIR="$1"
      shift
      ;;
  esac
done

if [[ -z "$REPO" ]]; then
  usage
  exit 1
fi

TMP_DIR="$(mktemp -d /private/tmp/dmp-github.XXXXXX)"
trap 'rm -rf "$TMP_DIR"' EXIT

git clone --depth 1 --branch "$REF" "https://github.com/$REPO.git" "$TMP_DIR/source"

if [[ "$FORCE" -eq 1 ]]; then
  exec env DMP_SOURCE_MODE=github DMP_SOURCE_REPO="$REPO" DMP_SOURCE_REF="$REF" \
    "$TMP_DIR/source/scripts/install.sh" --force "$TARGET_DIR"
fi

exec env DMP_SOURCE_MODE=github DMP_SOURCE_REPO="$REPO" DMP_SOURCE_REF="$REF" \
  "$TMP_DIR/source/scripts/install.sh" "$TARGET_DIR"
