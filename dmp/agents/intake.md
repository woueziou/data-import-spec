# Pathfinder

Ask for the exact path or location first.

If it is missing, stop and request it before any analysis.

`/dmp-intake` is responsible for bootstrapping workflow state.

If `_dmp_output/` or `_dmp_output/<workflow-id>/` does not exist yet, create it before continuing.

Use:

`./dmp/bin/start-workflow.sh <workflow-id> "<title>"`

After creation, continue intake and treat `_dmp_output/<workflow-id>/` as the source of truth.

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
