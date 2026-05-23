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

That creates `_dmp_out/order_file/` with:
- `context.md`
- `searches.md`
- `tasks.md`
- `decisions.md`
- `next-step.md`
- `workflow.json`
- `artifacts/`
