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

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
REPO_DIR="$(cd "$SCRIPT_DIR/../.." && pwd)"
INSTALL_FILE="$REPO_DIR/dmp/install.json"

if [[ ! -f "$INSTALL_FILE" ]]; then
  printf 'Missing %s. Install the framework first.\n' "$INSTALL_FILE"
  exit 1
fi

read_json_field() {
  local key="$1"
  sed -n "s/.*\"$key\": \"\\([^\"]*\\)\".*/\\1/p" "$INSTALL_FILE" | head -n 1
}

read_json_agents() {
  sed -n 's/.*"selectedAgents": \[\(.*\)\].*/\1/p' "$INSTALL_FILE" | tr -d '"' | tr -d ' '
}

SOURCE_MODE="$(read_json_field sourceMode)"
SOURCE_REPO="$(read_json_field sourceRepo)"
SOURCE_REF="$(read_json_field sourceRef)"
SELECTED_AGENTS="$(read_json_agents)"

if [[ "$SOURCE_MODE" == "github" ]]; then
  TMP_DIR="$(mktemp -d /private/tmp/dmp-github-reinstall.XXXXXX)"
  trap 'rm -rf "$TMP_DIR"' EXIT
  git clone --depth 1 --branch "$SOURCE_REF" "https://github.com/$SOURCE_REPO.git" "$TMP_DIR/source"
  INSTALLER="$TMP_DIR/source/scripts/install.sh"
  if [[ "$FORCE" -eq 1 ]]; then
    exec env DMP_SOURCE_MODE=github DMP_SOURCE_REPO="$SOURCE_REPO" DMP_SOURCE_REF="$SOURCE_REF" DMP_SELECTED_AGENTS="$SELECTED_AGENTS" \
      "$INSTALLER" --force "$REPO_DIR"
  fi
  exec env DMP_SOURCE_MODE=github DMP_SOURCE_REPO="$SOURCE_REPO" DMP_SOURCE_REF="$SOURCE_REF" DMP_SELECTED_AGENTS="$SELECTED_AGENTS" \
    "$INSTALLER" "$REPO_DIR"
fi

INSTALLER="$SOURCE_REPO/scripts/install.sh"

if [[ ! -x "$INSTALLER" ]]; then
  printf 'Installer not found at %s\n' "$INSTALLER"
  exit 1
fi

if [[ "$FORCE" -eq 1 ]]; then
  exec env DMP_SELECTED_AGENTS="$SELECTED_AGENTS" "$INSTALLER" --force "$REPO_DIR"
fi

exec env DMP_SELECTED_AGENTS="$SELECTED_AGENTS" "$INSTALLER" "$REPO_DIR"
