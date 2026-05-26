# Repo Agent Rules

- Use the `dmp` prefix for every import agent and command.
- If `dmp-intake` is installed, start with `/dmp-intake` when the data path or location is unknown.
- `/dmp-intake` should create `_dmp_output/<workflow-id>/` if it is missing.
- Keep workflow state in `_dmp_output/<workflow-id>/`.
- Never modify raw source files in place.
- Keep outputs short, structured, and handoff-ready.
- Prefer the shared specs in `dmp/agents/` and `dmp/framework.md` over rewriting the workflow.
- When a source changes, restart at the earliest affected agent.
