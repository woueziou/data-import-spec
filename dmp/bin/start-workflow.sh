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
- Target database: unknown
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

Given undocumented sample data, determine how to parse it and store it in a
relational database.

## Current understanding

- Add raw source details here.
- Capture assumptions that another model should not have to rediscover.
- Keep parser decisions tied to the submitted sample size and row counts.
- The final parser script should accept an input file path and an output folder path.

## Open questions

- What is the exact target path or location?
- What relational database is the target?
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
- Capture file names and any hints they provide about dates, entities,
  versions, partitions, or regions.
- Capture the likely nature of the data and the confidence of that judgment.
- Record sample row counts and what those counts do or do not prove.
- If classification confidence is low, record the follow-up questions that
  should be asked of the user.

## Evidence

- Paste short command outputs or references needed by the next session.
EOF

cat > "$WORKFLOW_DIR/tasks.md" <<EOF
# Tasks

- [ ] Confirm the exact target path or location
- [ ] Confirm the target relational database
- [ ] Save a representative sample path in \`context.md\`
- [ ] Capture schema and naming preferences during intake
- [ ] Run \`/dmp-discover\` and record findings in \`searches.md\`
- [ ] Define the provisional schema
- [ ] Write a parser specification in \`artifacts/parser-spec.md\`
- [ ] Write an output contract in \`artifacts/output-contract.md\`
- [ ] Write a logging contract in \`artifacts/logging-contract.md\`
- [ ] Write a storage plan without SQL unless the user asks for SQL
- [ ] Ask the user which language to use for the parser and where to create the script
- [ ] Write the next handoff in \`next-step.md\`
EOF

cat > "$WORKFLOW_DIR/decisions.md" <<EOF
# Decisions

## Decision log

- Record parser, schema, naming, and quality decisions here.
- Record any intake-time preferences that constrain schema design.
- Record database-target decisions and whether SQL was explicitly requested.

## Rejected options

- Record alternatives that were considered but not chosen.
EOF

cat > "$WORKFLOW_DIR/next-step.md" <<EOF
# Next Step

Run \`/dmp-intake\`.

## What to do now

1. Confirm the exact target file or location.
2. Confirm the target relational database.
3. Capture any schema or naming preferences in \`context.md\` and \`decisions.md\`.
4. Update \`context.md\` with the source details.
5. Add any raw inspection evidence to \`searches.md\`.
6. Move the workflow forward to \`/dmp-discover\`.

## Handoff note

This workflow was just created. The next model should start from intake and
use this folder as the source of truth.
EOF

cat > "$WORKFLOW_DIR/artifacts/README.md" <<'EOF'
# Artifacts

Store generated schemas, parser specs, output contracts, logging contracts,
storage plans, sample extracts, and validation outputs for this workflow here.

Do not store SQL, DDL, or migration files here unless the user explicitly
asked for SQL output.

## Suggested read order

1. `parser-spec.md` — parser behavior, runtime inputs, and parse rules
2. `output-contract.md` — expected JSON/JSONL outputs beneath the output folder
3. `logging-contract.md` — expected log files and event shapes
4. storage-plan artifact — how parsed output should land in the target database

## Before implementing the parser

Confirm with the user:
- which language to use for the parser
- where to create the parser script

## Implementation starting point

The final parser script should:
- accept an input file path
- accept an output folder path
- parse the input according to `parser-spec.md`
- write outputs described in `output-contract.md`
- write logs described in `logging-contract.md`
EOF

printf 'Started workflow %s at %s\n' "$WORKFLOW_ID" "$WORKFLOW_DIR"
