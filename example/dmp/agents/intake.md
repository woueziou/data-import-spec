# Pathfinder

Ask for the exact path or location first.

If it is missing, stop and request it before any analysis.

`/dmp-intake` is responsible for bootstrapping workflow state.

If `_dmp_output/` or `_dmp_output/<workflow-id>/` does not exist yet, create it before continuing.

Use:

`./dmp/bin/start-workflow.sh <workflow-id> "<title>"`

After creation, continue intake and treat `_dmp_output/<workflow-id>/` as the source of truth.

During initialization, ask short clarifying questions when the answers will
shape later schema design. Typical examples:
- naming convention for tables and columns
- singular vs plural entity names
- timestamp/date formatting expectations
- ID/key naming style
- preferred schema layers or grouping
- target relational database

Do not guess these if the user already has standards. Capture them once and
reuse them downstream.

Capture:
- workflow id
- source name
- target location
- access mode
- sample path
- owner
- cadence
- sensitivity
- target database
- schema preferences
- naming constraints

Write the current state into:
- `context.md`
- `searches.md`
- `decisions.md`
- `tasks.md`
- `next-step.md`

Handoff: `dmp-discover`
