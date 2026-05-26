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
- Preferred example language: Python (default until changed)
- Downstream consumers: unknown
- Current step: intake

## Schema preferences

- Field naming convention: unknown
- Artifact naming convention: unknown
- Entity naming style: unknown
- Timestamp/date format: unknown
- ID/key naming style: unknown
- Layer/grouping preferences: unknown

## Goal

Given undocumented sample data, produce a comprehensive, non-executable
analysis pack that enables a developer or another LLM to build a robust
parser with minimal guessing.

## Current understanding

- Add raw source details here.
- Capture assumptions that another model should not have to rediscover.
- Keep parser decisions tied to the submitted sample size and row counts.
- Record where examples must stay illustrative rather than executable.

## Open questions

- What is the exact target path or location?
- What format is the source?
- Is there a stable sample file?
- Are there naming or schema conventions that must be preserved?
- Which language should illustrative examples use, if not Python?
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
- Record structural patterns such as flat records, repeated groups, nesting,
  key-value sections, or hierarchical segments.
- If classification confidence is low, record the follow-up questions that
  should be asked of the user.

## Evidence

- Paste short command outputs or references needed by the next session.
EOF

cat > "$WORKFLOW_DIR/tasks.md" <<EOF
# Tasks

- [ ] Confirm the exact target path or location
- [ ] Save a representative sample path in \`context.md\`
- [ ] Capture schema and naming preferences during intake
- [ ] Confirm the preferred language for illustrative examples, or keep the Python default
- [ ] Run \`/dmp-discover\` and record findings in \`searches.md\`
- [ ] Produce a source catalog and file analysis report
- [ ] Define the provisional schema and data model
- [ ] Produce an entity list and join map
- [ ] Write canonical rules and a data dictionary
- [ ] Write \`artifacts/file-analysis-report.md\`
- [ ] Write \`artifacts/data-schema.md\`
- [ ] Write \`artifacts/parsing-strategy-guide.md\`
- [ ] Write \`artifacts/best-practices-and-guardrails.md\`
- [ ] Write \`artifacts/examples.md\`
- [ ] Write \`artifacts/dos-and-donts.md\`
- [ ] Write \`artifacts/edge-cases-and-risk-matrix.md\`
- [ ] Write \`artifacts/implementation-roadmap.md\`
- [ ] Define drift detection, schema versioning, and validation rules
- [ ] Define consumer requirements and implementation gaps
- [ ] Record why every code example is illustrative only
- [ ] Write the next handoff in \`next-step.md\`
EOF

cat > "$WORKFLOW_DIR/decisions.md" <<EOF
# Decisions

## Decision log

- Record parser, schema, naming, and quality decisions here.
- Record any intake-time preferences that constrain schema design.
- Record example-language decisions and whether Python defaulting was used.
- Record any explicit request to enter a separate implementation phase.

## Rejected options

- Record alternatives that were considered but not chosen.
EOF

cat > "$WORKFLOW_DIR/next-step.md" <<EOF
# Next Step

Run \`/dmp-intake\`.

## What to do now

1. Confirm the exact target file or location.
2. Confirm the representative sample path.
3. Capture any schema, naming, or example-language preferences in \`context.md\` and \`decisions.md\`.
4. Update \`context.md\` with the source details.
5. Add any raw inspection evidence to \`searches.md\`.
6. Move the workflow forward to \`/dmp-discover\`.

## Handoff note

This workflow was just created. The next model should start from intake and
use this folder as the source of truth.
EOF

cat > "$WORKFLOW_DIR/artifacts/README.md" <<'EOF'
# Artifacts

Store generated analysis reports, schemas, parsing guides, guardrails,
examples, and roadmap documents for this workflow here.

Do not store runnable parser modules, complete scripts, SQL, DDL, or
migration files here unless the user explicitly requested a separate
implementation phase.

## Suggested read order

1. `file-analysis-report.md` — format, patterns, anomalies, and confidence
2. `data-schema.md` — formal structures and field definitions
3. `parsing-strategy-guide.md` — recommended architecture and parse steps
4. `best-practices-and-guardrails.md` — safety, validation, and maintainability rules
5. `examples.md` — non-production examples only, in the chosen language
6. `dos-and-donts.md` — implementation guidance and anti-patterns
7. `edge-cases-and-risk-matrix.md` — pitfalls, risks, and mitigations
8. `implementation-roadmap.md` — build order, checkpoints, and validation milestones

## Example policy

- Use the user-requested language for examples.
- If no language was requested, default to Python and say so explicitly.
- Mark every snippet as illustrative and non-production.
EOF

printf 'Started workflow %s at %s\n' "$WORKFLOW_ID" "$WORKFLOW_DIR"
