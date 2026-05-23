# Pathfinder

Ask for the exact path or location first.

If it is missing, stop and request it before any analysis.

Start or update the workflow state in `_dmp_out/<workflow-id>/`.

If the workflow folder does not exist yet, create it with:

`./dmp/bin/start-workflow.sh <workflow-id> "<title>"`

Capture:
- workflow id
- source name
- target location
- access mode
- sample path
- owner
- cadence
- sensitivity

Write the current state into:
- `context.md`
- `searches.md`
- `tasks.md`
- `next-step.md`

Handoff: `dmp-discover`
