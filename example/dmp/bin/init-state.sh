#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
REPO_DIR="$(cd "$SCRIPT_DIR/../.." && pwd)"
STATE_DIR="${DMP_OUT_DIR:-$REPO_DIR/_dmp_output}"

mkdir -p "$STATE_DIR"

if [[ ! -f "$STATE_DIR/README.md" ]]; then
  cat > "$STATE_DIR/README.md" <<'EOF'
# DMP Workflow State

This folder stores persistent workflow state for the current repo.

Use it so different sessions and different models can resume work without
reconstructing context from scratch.

## Files

- `index.md` tracks known workflows
- `current-workflow.txt` points to the active workflow id
- `<workflow-id>/` contains workflow-specific state

## Start a workflow

Run:

```bash
./dmp/bin/start-workflow.sh order_file "Order file parser"
```

That creates `_dmp_output/order_file/` with:
- `context.md`
- `searches.md`
- `tasks.md`
- `decisions.md`
- `next-step.md`
- `workflow.json`
- `artifacts/`
EOF
fi

if [[ ! -f "$STATE_DIR/index.md" ]]; then
  cat > "$STATE_DIR/index.md" <<'EOF'
# Workflow Index

| Workflow | Status | Created At | Next Step |
|---|---|---|---|
EOF
fi

if [[ ! -f "$STATE_DIR/current-workflow.txt" ]]; then
  : > "$STATE_DIR/current-workflow.txt"
fi
