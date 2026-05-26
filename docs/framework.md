# DMP Framework

`dmp` is the command prefix for this repo's data import workflow.

## Agents

| Agent | Command | Job |
|---|---|---|
| Pathfinder | `/dmp-intake` | Ask for the target path/location, source basics, constraints, and example-language preference |
| Cataloger | `/dmp-discover` | Inventory and profile raw data, including file names, data nature, sample row counts, and record structure |
| Mapper | `/dmp-model` | Build a provisional schema, parsing strategy, and artifact contract from the submitted samples |
| Sentinel | `/dmp-guard` | Track uncertainty, drift, validation, and quality |
| Builder | `/dmp-serve` | Assemble the final analysis handoff and implementation roadmap |

## Start Rule

If the target data path or location is missing, stop and ask for it first.

Use one of:
- file path
- folder path
- bucket path
- endpoint URL
- other source location

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
- naming convention for fields and artifacts
- singular vs plural entity names
- preferred timestamp/date formats
- ID/key naming style
- schema grouping or layer expectations
- preferred language for illustrative examples

Record those decisions in `_dmp_output/<workflow-id>/context.md` and
`decisions.md` so `/dmp-model` can use them as constraints.

## Workflow Goal

The workflow solves this problem:

Given undocumented text sample data, determine how a robust parser should be
designed without generating executable parser code.

The required handoff is not just a schema. It must include enough file-level,
record-level, and validation detail that a developer or another LLM can build
the parser from the submitted samples with minimal guessing.

Discovery should also identify the likely nature of the data and record the
confidence of that classification. If confidence is low or ambiguity remains,
the agent may ask the user for more context before proceeding.

Core workflow rules:
- never generate working, complete, or directly executable parser code
- keep code-related content illustrative only
- use the user-requested language for examples; default to Python if none was given
- treat file names, sample limits, and anomalies as first-class evidence

Required handoff artifacts:
- `artifacts/file-analysis-report.md`
- `artifacts/data-schema.md`
- `artifacts/parsing-strategy-guide.md`
- `artifacts/best-practices-and-guardrails.md`
- `artifacts/examples.md`
- `artifacts/dos-and-donts.md`
- `artifacts/edge-cases-and-risk-matrix.md`
- `artifacts/implementation-roadmap.md`

Do not emit SQL, migrations, or runnable parser modules in workflow artifacts
unless the user explicitly asks for a separate implementation phase.

## Loop

When drift, ambiguity, or a new source appears, go back to the earliest relevant agent instead of forcing the current step.

## Tool Surfaces

- Copilot: `.github/agents/dmp-*.agent.md`
- Gemini CLI: `.gemini/commands/dmp-*.toml`
- Antigravity source: `_agents/plugins/dmp/skills/dmp-*/SKILL.md`
- Antigravity install target: `.agents/plugins/dmp/skills/dmp-*/SKILL.md`
- Kilo: `.kilo/skills/dmp-*/SKILL.md`
- cmd: `.claude/commands/dmp-*.md`
