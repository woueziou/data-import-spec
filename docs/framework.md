# DMP Framework

`dmp` is the command prefix for this repo's data import workflow.

## Agents

| Agent | Command | Job |
|---|---|---|
| Pathfinder | `/dmp-intake` | Ask for the target path/location, capture source basics, and record schema preferences |
| Cataloger | `/dmp-discover` | Inventory and profile raw data |
| Mapper | `/dmp-model` | Build provisional schema, entities, layers, and naming rules |
| Sentinel | `/dmp-guard` | Track uncertainty, drift, validation, and quality |
| Builder | `/dmp-serve` | Design the database model and serving shape |

## Start Rule

If the target data path or location is missing, stop and ask for it first.

Use one of:
- file path
- folder path
- bucket path
- endpoint URL
- database source

## State

Every target repo keeps workflow state in `_dmp_output/`.

Start a workflow with:

```bash
./dmp/bin/start-workflow.sh order_file "Order file parser"
```

This creates `_dmp_output/order_file/` with:
- `context.md`
- `searches.md`
- `tasks.md`
- `decisions.md`
- `next-step.md`
- `workflow.json`
- `artifacts/`

The first intake pass should update that folder before deeper analysis.

## Initialization Inputs

During `/dmp-intake`, the agent may ask short clarifying questions that affect
downstream schema structure before discovery begins.

Capture preferences such as:
- naming convention for tables, fields, and files
- singular vs plural entity names
- preferred timestamp/date formats
- ID/key naming style
- schema grouping or layer expectations

Record those decisions in `_dmp_output/<workflow-id>/context.md` and
`decisions.md` so `/dmp-model` can use them as constraints.

## Loop

When drift, ambiguity, or a new source appears, go back to the earliest relevant agent instead of forcing the current step.

## Tool Surfaces

- Copilot: `.github/agents/dmp-*.agent.md`
- Gemini CLI: `.gemini/commands/dmp-*.toml`
- Antigravity source: `_agents/plugins/dmp/skills/dmp-*/SKILL.md`
- Antigravity install target: `.agents/plugins/dmp/skills/dmp-*/SKILL.md`
- Kilo: `.kilo/skills/dmp-*/SKILL.md`
- cmd: `.claude/commands/dmp-*.md`
