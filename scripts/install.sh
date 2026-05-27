#!/usr/bin/env bash
set -euo pipefail

usage() {
  printf 'Usage: %s [--force] [target-repo]\n' "${0##*/}"
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

if [[ $# -gt 1 ]]; then
  usage
  exit 1
fi

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
REPO_DIR="$(cd "$SCRIPT_DIR/.." && pwd)"
TARGET_DIR="${1:-.}"
VERSION="$(tr -d ' \t\r\n' < "$REPO_DIR/VERSION")"
INSTALLED_AT="$(date -u +%Y-%m-%dT%H:%M:%SZ)"
SOURCE_MODE="${DMP_SOURCE_MODE:-local}"
SOURCE_REPO="${DMP_SOURCE_REPO:-$REPO_DIR}"
SOURCE_REF="${DMP_SOURCE_REF:-local}"
SELECTED_AGENTS="${DMP_SELECTED_AGENTS:-intake,discover,model,guard,serve}"
SELECTED_PROVIDERS="${DMP_SELECTED_PROVIDERS:-copilot,gemini,claude,kilo,antigravity}"
IS_REINSTALL=0

mkdir -p "$TARGET_DIR"
TARGET_DIR="$(cd "$TARGET_DIR" && pwd)"

if [[ -f "$TARGET_DIR/dmp/install.json" ]]; then
  IS_REINSTALL=1
fi

if [[ "$TARGET_DIR" == "$REPO_DIR" ]]; then
  printf 'Target repo matches the source repo. Nothing to install.\n'
  exit 0
fi

guard_root_file() {
  local path="$1"
  if [[ -e "$TARGET_DIR/$path" && "$FORCE" -ne 1 && "$IS_REINSTALL" -ne 1 ]]; then
    printf 'Refusing to overwrite %s. Re-run with --force if you want to replace it.\n' "$TARGET_DIR/$path"
    exit 1
  fi
}

copy_file() {
  local src="$1"
  local dest="$2"
  mkdir -p "$(dirname "$TARGET_DIR/$dest")"
  cp "$REPO_DIR/$src" "$TARGET_DIR/$dest"
}

copy_core() {
  copy_file "dmp/AGENTS.md" "dmp/AGENTS.md"
  copy_file "dmp/framework.md" "dmp/framework.md"
  copy_file "dmp/version.json" "dmp/version.json"
  copy_file "dmp/bin/init-state.sh" "dmp/bin/init-state.sh"
  copy_file "dmp/bin/start-workflow.sh" "dmp/bin/start-workflow.sh"
  copy_file "dmp/bin/reinstall.sh" "dmp/bin/reinstall.sh"
}

has_provider() {
  local wanted="$1"
  local OLD_IFS="$IFS"
  IFS=','
  for provider in $SELECTED_PROVIDERS; do
    provider="$(printf '%s' "$provider" | tr -d '[:space:]')"
    if [[ "$provider" == "$wanted" || ( "$wanted" == "antigravity" && "$provider" == "agy" ) || ( "$wanted" == "agy" && "$provider" == "antigravity" ) ]]; then
      IFS="$OLD_IFS"
      return 0
    fi
  done
  IFS="$OLD_IFS"
  return 1
}

copy_provider_core() {
  :
}

copy_agent() {
  local agent="$1"
  copy_file "dmp/agents/$agent.md" "dmp/agents/$agent.md"
  if has_provider "copilot"; then
    copy_file ".github/agents/dmp-$agent.agent.md" ".github/agents/dmp-$agent.agent.md"
  fi
  if has_provider "gemini"; then
    copy_file ".gemini/commands/dmp-$agent.toml" ".gemini/commands/dmp-$agent.toml"
  fi
  if has_provider "claude"; then
    copy_file ".claude/commands/dmp-$agent.md" ".claude/commands/dmp-$agent.md"
  fi
  if has_provider "kilo"; then
    copy_file ".kilo/skills/dmp-$agent/SKILL.md" ".kilo/skills/dmp-$agent/SKILL.md"
  fi
  if has_provider "antigravity"; then
    copy_file "_agents/workflows/dmp-$agent.md" ".agents/workflows/dmp-$agent.md"
  fi
}

guard_root_file "dmp/AGENTS.md"

copy_core
copy_provider_core

OLD_IFS="$IFS"
IFS=','
for agent in $SELECTED_AGENTS; do
  agent="$(printf '%s' "$agent" | tr -d '[:space:]')"
  [[ -z "$agent" ]] && continue
  copy_agent "$agent"
done
IFS="$OLD_IFS"

chmod +x "$TARGET_DIR/dmp/bin/init-state.sh" "$TARGET_DIR/dmp/bin/start-workflow.sh" "$TARGET_DIR/dmp/bin/reinstall.sh"

cat > "$TARGET_DIR/dmp/install.json" <<EOF
{
  "name": "dmp",
  "version": "$VERSION",
  "installedAt": "$INSTALLED_AT",
  "sourceMode": "$SOURCE_MODE",
  "sourceRepo": "$SOURCE_REPO",
  "sourceRef": "$SOURCE_REF",
  "selectedAgents": [$(printf '"%s"' "${SELECTED_AGENTS//,/\",\"}")],
  "selectedProviders": [$(printf '"%s"' "${SELECTED_PROVIDERS//,/\",\"}")]
}
EOF

printf 'Installed dmp %s to %s\n' "$VERSION" "$TARGET_DIR"
