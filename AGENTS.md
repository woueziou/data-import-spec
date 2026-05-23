# Repo Agent Rules

- Use the `dmp` prefix for every import agent and command.
- Start with `/dmp-intake` if the data path or location is unknown.
- Never modify raw source files in place.
- Keep outputs short, structured, and handoff-ready.
- Prefer the shared specs in `dmp/agents/` and `docs/framework.md` over rewriting the workflow.
- When a source changes, restart at the earliest affected agent.
