# DMP Data Import Framework

DMP is a workflow framework for turning undocumented text data into a
comprehensive, non-executable parser analysis pack.

It is designed for cases like:
- vendor files with no schema documentation
- flat files, logs, exports, and drops from unknown systems
- samples where the file name and the content both contain clues
- teams that need a structured handoff before any parser code is written

The workflow does not stop at "guess a schema". Its goal is to answer:

1. What is the nature of this data?
2. How confident are we in that conclusion?
3. What structures, patterns, and anomalies are present?
4. How should a parser be designed to handle them safely?
5. What artifacts does a developer or another LLM need to build it?

## Purpose

DMP gives an AI-assisted workflow for:
- deeply analyzing undocumented files
- recording ambiguity and confidence explicitly
- producing parser-ready design artifacts
- documenting guardrails, validation, and edge cases
- generating illustrative examples only, never executable parser code

The final handoff should include:
- `artifacts/file-analysis-report.md`
- `artifacts/data-schema.md`
- `artifacts/parsing-strategy-guide.md`
- `artifacts/best-practices-and-guardrails.md`
- `artifacts/examples.md`
- `artifacts/dos-and-donts.md`
- `artifacts/edge-cases-and-risk-matrix.md`
- `artifacts/implementation-roadmap.md`
- `artifacts/implementation-prompt.md`

When examples are needed, use the user-requested language. If none is given,
default to Python and state that default explicitly.

## How It Works

The workflow is split into five agents:

| Agent | Command | Purpose |
|---|---|---|
| Pathfinder | `/dmp-intake` | Capture source location, sample path, naming preferences, and example-language preference |
| Cataloger | `/dmp-discover` | Profile the sample, file name, likely data nature, and confidence |
| Mapper | `/dmp-model` | Produce the schema/model, parsing strategy, and output artifact specs |
| Sentinel | `/dmp-guard` | Record ambiguity, drift rules, validation, guardrails, and blockers |
| Builder | `/dmp-serve` | Assemble the final analysis handoff and implementation roadmap |

Workflow state lives in `_dmp_output/<workflow-id>/`.

## Install

### End users

Install into a target repository with `npx`:

```bash
npx @petadata/parser@latest
```

You can also pass a target repository path:

```bash
npx @petadata/parser@latest /path/to/target-repo
```

The installer will ask for:
- which agents to install
- which provider surfaces to install

Supported provider IDs:
- `copilot`
- `gemini`
- `claude`
- `kilo`
- `antigravity`
- `agy` (alias for `antigravity`)

You can also select them non-interactively:

```bash
npx @petadata/parser@latest \
  --agents intake,discover,model,guard,serve \
  --providers gemini,claude \
  /path/to/target-repo
```

If the target repo already contains installed DMP files such as
`dmp/AGENTS.md`, re-run with `--force` or merge manually.

### What gets installed

Always installed:
- `dmp/AGENTS.md`
- `dmp/framework.md`
- selected `dmp/agents/*.md`
- `dmp/bin/init-state.sh`
- `dmp/bin/start-workflow.sh`
- `dmp/bin/reinstall.sh`
- `dmp/version.json`
- `dmp/install.json`

Installed only when the corresponding provider is selected:
- `.github/agents/`
- `.gemini/commands/`
- `.claude/commands/`
- `.kilo/skills/`
- `.agents/workflows/`
`_dmp_output/` is created on first use of `/dmp-intake`.

For a manual global Antigravity CLI install, copy the command markdown files
from `_agents/workflows/` into
`~/.gemini/antigravity/global_workflows/`.

## How To Use

### 1. Start from intake

Inside the target repository, start with:

```text
/dmp-intake
```

If the source path is unknown, the agent should ask for it first.

Intake should capture:
- target file/folder/location
- sample file path
- naming and schema preferences
- preferred language for illustrative examples, or default to Python
- preferred parser packages or libraries, if the user already has them in mind

### 2. Let the workflow create state

On first use, DMP should create:

```text
_dmp_output/<workflow-id>/
```

If you need to create a workflow manually:

```bash
./dmp/bin/start-workflow.sh order_file "Order file parser"
```

That folder contains:
- `context.md`
- `searches.md`
- `tasks.md`
- `decisions.md`
- `next-step.md`
- `workflow.json`
- `artifacts/`

### 3. Run the workflow through the agents

Typical sequence:

```text
/dmp-intake
/dmp-discover
/dmp-model
/dmp-guard
/dmp-serve
```

Key workflow rules:
- never modify raw source files in place
- use file names as evidence, not just file content
- identify the likely nature of the data
- record a confidence level for classification
- ask the user for more context when confidence is low
- keep outputs short, structured, and handoff-ready
- never generate working or directly executable parser code

### 4. Use the generated artifacts

The important artifacts are under:

```text
_dmp_output/<workflow-id>/artifacts/
```

Start with:

1. `file-analysis-report.md`
2. `data-schema.md`
3. `parsing-strategy-guide.md`
4. `best-practices-and-guardrails.md`
5. `examples.md`
6. `dos-and-donts.md`
7. `edge-cases-and-risk-matrix.md`
8. `implementation-roadmap.md`
9. `implementation-prompt.md`

The final handoff is an implementation roadmap and artifact pack, not a parser
implementation.

## Reinstall / Update

After a repository has DMP installed, update it from that repo with:

```bash
./dmp/bin/reinstall.sh
```

Reinstall uses the selections stored in `dmp/install.json`, including:
- selected agents
- selected providers
- installation source metadata

## Example

The repo includes an example sandbox:

- [example/README.md](example/README.md)

Use it to understand the workflow structure without touching a real project.

## Repository Layout

Important paths in this repo:

- [dmp/AGENTS.md](dmp/AGENTS.md)
- [dmp/framework.md](dmp/framework.md)
- [dmp/agents](dmp/agents)
- [dmp/bin](dmp/bin)
- [bin/dmp.js](bin/dmp.js)
- [scripts/install.sh](scripts/install.sh)
- [docs](docs)
- [example](example)

## Contributing

Contributions should improve one or more of:
- workflow clarity
- installer behavior
- provider-surface generation
- artifact quality
- reproducibility of parser handoffs

### Contributing workflow changes

If you change workflow behavior:
- update `dmp/framework.md`
- update the affected `dmp/agents/*.md`
- update the scaffold in `dmp/bin/start-workflow.sh` if new workflow state is required
- update `docs/` if prompts or explanations change
- update mirrored example or install-facing files when relevant

### Contributing installer changes

If you change installation behavior:
- update `bin/dmp.js`
- update `scripts/install.sh`
- update `dmp/bin/reinstall.sh`
- update `install/manifest.txt` if install layout changes
- update this README

### Development notes

- Prefer editing workflow source files rather than hand-editing generated output.
- Keep the workflow generic; it should work for undocumented files broadly, not for a single sample shape.
- Avoid generating executable parser code in workflow artifacts.
- Preserve the rule that provider surfaces are selectable.

## License

MIT
