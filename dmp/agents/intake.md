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
- naming convention for fields and artifacts
- singular vs plural entity names
- timestamp/date formatting expectations
- ID/key naming style
- preferred schema layers or grouping
- preferred language for illustrative examples
- preferred parser packages or libraries the user wants used later

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
- downstream consumers or constraints
- preferred example language
- preferred parser packages or libraries
- schema preferences
- naming constraints

Write the current state into:
- `context.md`
- `searches.md`
- `decisions.md`
- `tasks.md`
- `next-step.md`

Core rule:
- this workflow produces analysis artifacts only, not executable parser code

Handoff: `dmp-discover`
