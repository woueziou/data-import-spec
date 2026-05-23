# DMP Framework

`dmp` is the command prefix for this repo's data import workflow.

## Agents

| Agent | Command | Job |
|---|---|---|
| Pathfinder | `/dmp-intake` | Ask for the target path/location and capture source basics |
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

## Loop

When drift, ambiguity, or a new source appears, go back to the earliest relevant agent instead of forcing the current step.

## Tool Surfaces

- Copilot: `.github/agents/dmp-*.agent.md`
- Gemini CLI: `.gemini/commands/dmp-*.toml`
- Antigravity source: `_agents/plugins/dmp/skills/dmp-*/SKILL.md`
- Antigravity install target: `.agents/plugins/dmp/skills/dmp-*/SKILL.md`
- Kilo: `.kilo/skills/dmp-*/SKILL.md`
- cmd: `.claude/commands/dmp-*.md`
