# DMP Framework

`dmp` is the command prefix for this repo's data import workflow.

## Agents

| Agent | Command | Job |
|---|---|---|
| Pathfinder | `/dmp-intake` | Ask for the target path/location, target database, source basics, and schema preferences |
| Cataloger | `/dmp-discover` | Inventory and profile raw data, including file names, data nature, sample row counts, and record structure |
| Mapper | `/dmp-model` | Build a provisional schema and parser contract from the submitted samples |
| Sentinel | `/dmp-guard` | Track uncertainty, drift, validation, and quality |
| Builder | `/dmp-serve` | Design the relational storage plan and parser-to-database handoff |

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

`/dmp-intake` should create the workflow state on first use.

If manual creation is needed, start a workflow with:

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

The first intake pass should create or update that folder before deeper analysis.

## Initialization Inputs

During `/dmp-intake`, the agent may ask short clarifying questions that affect
downstream schema structure before discovery begins.

Capture preferences such as:
- naming convention for tables, fields, and files
- singular vs plural entity names
- preferred timestamp/date formats
- ID/key naming style
- schema grouping or layer expectations
- target relational database

Record those decisions in `_dmp_output/<workflow-id>/context.md` and
`decisions.md` so `/dmp-model` can use them as constraints.

## Workflow Goal

The workflow solves this problem:

Given undocumented text sample data, determine how to parse it and store it in
a relational database.

The required handoff is not just a schema. It must include enough parser-level
detail to implement ingestion from the submitted samples with minimal guessing,
while making downstream relational storage easier.

Discovery should also identify the likely nature of the data and record the
confidence of that classification. If confidence is low or ambiguity remains,
the agent may ask the user for more context before proceeding.

Required parser handoff artifacts:
- `artifacts/parser-spec.md`
- `artifacts/output-contract.md`
- `artifacts/logging-contract.md`

When the workflow reaches the final implementation handoff, ask the user:
- which language to use for the parser
- where to create the parser script

Do not emit SQL or migration code in workflow artifacts unless the user
explicitly asks for SQL.

## Loop

When drift, ambiguity, or a new source appears, go back to the earliest relevant agent instead of forcing the current step.

## Tool Surfaces

- Copilot: `.github/agents/dmp-*.agent.md`
- Gemini CLI: `.gemini/commands/dmp-*.toml`
- Antigravity install target: `.agents/plugins/dmp/skills/dmp-*/SKILL.md`
- Kilo: `.kilo/skills/dmp-*/SKILL.md`
- cmd: `.claude/commands/dmp-*.md`
