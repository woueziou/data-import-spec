#!/usr/bin/env bash
set -euo pipefail

usage() {
  printf 'Usage: %s [--force] [--target path] <workflow-id> [title...]\n' "${0##*/}"
}

FORCE=0
TARGET_PATH=""

while [[ $# -gt 0 ]]; do
  case "$1" in
    --force)
      FORCE=1
      shift
      ;;
    --target)
      TARGET_PATH="${2:-}"
      shift 2
      ;;
    -h|--help)
      usage
      exit 0
      ;;
    *)
      break
      ;;
  esac
done

if [[ $# -lt 1 ]]; then
  usage
  exit 1
fi

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
REPO_DIR="$(cd "$SCRIPT_DIR/../.." && pwd)"
STATE_DIR="${DMP_OUT_DIR:-$REPO_DIR/_dmp_output}"
WORKFLOW_ID="$1"
shift
TITLE="${*:-$WORKFLOW_ID}"
CREATED_AT="$(date -u +%Y-%m-%dT%H:%M:%SZ)"
WORKFLOW_DIR="$STATE_DIR/$WORKFLOW_ID"
INDEX_FILE="$STATE_DIR/index.md"
CURRENT_FILE="$STATE_DIR/current-workflow.txt"
NEXT_STEP="/dmp-intake"

json_escape() {
  local value="$1"
  value=${value//\\/\\\\}
  value=${value//\"/\\\"}
  value=${value//$'\n'/\\n}
  value=${value//$'\r'/\\r}
  value=${value//$'\t'/\\t}
  printf '%s' "$value"
}

TITLE_JSON="$(json_escape "$TITLE")"
TARGET_JSON="$(json_escape "$TARGET_PATH")"

"$SCRIPT_DIR/init-state.sh"

if [[ -e "$WORKFLOW_DIR" && "$FORCE" -ne 1 ]]; then
  printf 'Workflow already exists at %s. Re-run with --force to replace it.\n' "$WORKFLOW_DIR"
  exit 1
fi

rm -rf "$WORKFLOW_DIR"
mkdir -p "$WORKFLOW_DIR/artifacts"

if ! grep -Fq "| $WORKFLOW_ID |" "$INDEX_FILE"; then
  printf '| %s | active | %s | %s |\n' "$WORKFLOW_ID" "$CREATED_AT" "$NEXT_STEP" >> "$INDEX_FILE"
fi

printf '%s\n' "$WORKFLOW_ID" > "$CURRENT_FILE"

cat > "$WORKFLOW_DIR/workflow.json" <<EOF
{
  "id": "$WORKFLOW_ID",
  "title": "$TITLE_JSON",
  "status": "active",
  "createdAt": "$CREATED_AT",
  "targetPath": "$TARGET_JSON",
  "currentAgent": "dmp-intake",
  "nextStep": "$NEXT_STEP"
}
EOF

cat > "$WORKFLOW_DIR/README.md" <<EOF
# $TITLE

- Workflow id: \`$WORKFLOW_ID\`
- Status: \`active\`
- Created at: \`$CREATED_AT\`
- Current agent: \`dmp-intake\`
- Next step: \`$NEXT_STEP\`

Open these files first:
- \`context.md\`
- \`tasks.md\`
- \`next-step.md\`
EOF

cat > "$WORKFLOW_DIR/context.md" <<EOF
# Context

- Workflow id: \`$WORKFLOW_ID\`
- Title: $TITLE
- Target path: ${TARGET_PATH:-<fill during /dmp-intake>}
- Source type: unknown
- Owner: unknown
- Sample path: unknown
- Cadence: unknown
- Sensitivity: unknown
- Current step: intake

## Schema preferences

- Table naming convention: unknown
- Column naming convention: unknown
- Entity naming style: unknown
- Timestamp/date format: unknown
- ID/key naming style: unknown
- Layer/grouping preferences: unknown

## Goal

Build or refine the parser for this source.

## Current understanding

- Add raw source details here.
- Capture assumptions that another model should not have to rediscover.

## Open questions

- What is the exact target path or location?
- What format is the source?
- Is there a stable sample file?
- Are there naming or schema conventions that must be preserved?
EOF

cat > "$WORKFLOW_DIR/searches.md" <<EOF
# Searches

## Files inspected

- Add file paths, samples, and commands used during inspection.

## Findings

- Capture format clues, field counts, delimiters, anomalies, and links.

## Evidence

- Paste short command outputs or references needed by the next session.
EOF

cat > "$WORKFLOW_DIR/tasks.md" <<EOF
# Tasks

- [ ] Confirm the exact target path or location
- [ ] Save a representative sample path in \`context.md\`
- [ ] Capture schema and naming preferences during intake
- [ ] Run \`/dmp-discover\` and record findings in \`searches.md\`
- [ ] Define the provisional schema
- [ ] Write the next handoff in \`next-step.md\`
EOF

cat > "$WORKFLOW_DIR/decisions.md" <<EOF
# Decisions

## Decision log

- Record parser, schema, naming, and quality decisions here.
- Record any intake-time preferences that constrain schema design.

## Rejected options

- Record alternatives that were considered but not chosen.
EOF

cat > "$WORKFLOW_DIR/next-step.md" <<EOF
# Next Step

Run \`/dmp-intake\`.

## What to do now

1. Confirm the exact target file or location.
2. Capture any schema or naming preferences in \`context.md\` and \`decisions.md\`.
3. Update \`context.md\` with the source details.
4. Add any raw inspection evidence to \`searches.md\`.
5. Move the workflow forward to \`/dmp-discover\`.

## Handoff note

This workflow was just created. The next model should start from intake and
use this folder as the source of truth.
EOF

cat > "$WORKFLOW_DIR/artifacts/README.md" <<'EOF'
# Artifacts

Store generated schemas, parser notes, sample extracts, and validation outputs
for this workflow here.
EOF

printf 'Started workflow %s at %s\n' "$WORKFLOW_ID" "$WORKFLOW_DIR"
