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
  copy_file "AGENTS.md" "AGENTS.md"
  copy_file "GEMINI.md" "GEMINI.md"
  copy_file "dmp/framework.md" "dmp/framework.md"
  copy_file "dmp/version.json" "dmp/version.json"
  copy_file "dmp/bin/init-state.sh" "dmp/bin/init-state.sh"
  copy_file "dmp/bin/start-workflow.sh" "dmp/bin/start-workflow.sh"
  copy_file "dmp/bin/reinstall.sh" "dmp/bin/reinstall.sh"
}

copy_agent() {
  local agent="$1"
  copy_file "dmp/agents/$agent.md" "dmp/agents/$agent.md"
  copy_file ".github/agents/dmp-$agent.agent.md" ".github/agents/dmp-$agent.agent.md"
  copy_file ".gemini/commands/dmp-$agent.toml" ".gemini/commands/dmp-$agent.toml"
  copy_file ".claude/commands/dmp-$agent.md" ".claude/commands/dmp-$agent.md"
  copy_file ".kilo/skills/dmp-$agent/SKILL.md" ".kilo/skills/dmp-$agent/SKILL.md"
  copy_file "_agents/plugins/dmp/plugin.json" ".agents/plugins/dmp/plugin.json"
  copy_file "_agents/plugins/dmp/skills/dmp-$agent/SKILL.md" ".agents/plugins/dmp/skills/dmp-$agent/SKILL.md"
}

guard_root_file "AGENTS.md"
guard_root_file "GEMINI.md"

copy_core

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
  "selectedAgents": [$(printf '"%s"' "${SELECTED_AGENTS//,/\",\"}")]
}
EOF

printf 'Installed dmp %s to %s\n' "$VERSION" "$TARGET_DIR"
