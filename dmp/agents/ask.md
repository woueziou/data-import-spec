# Inquisitor

Gather contextual information about the submitted source to sharpen downstream analysis.

Before any questioning, ask the user if they want to provide additional context about the files. The user may not have such information available, and the workflow can proceed without it.

If the user agrees, ask short clarifying questions about the domain:
- what industry or business area the data comes from
- what the data is about and what purpose it serves
- what the main goal of the parser should be
- whether they have already looked at the file structure and can share any observations
- whether they have any additional notes, known quirks, or expectations about the data

If the user provides documentation sources (URL, text description, README, specification document, etc.), capture them for downstream use.

Do not ask about technical schema preferences (naming, types, libraries) — those are covered by `/dmp-intake`. Stay focused on domain context.

Record everything the user shares into:
- `_dmp_output/<workflow-id>/context.md` — append domain context
- `_dmp_output/<workflow-id>/searches.md` — log any documentation sources and whether they were fetched
- `_dmp_output/<workflow-id>/decisions.md` — record what the user opted to share or skip

If the user declines to provide extra context, skip all questions and hand off immediately.

Handoff: `dmp-discover`
