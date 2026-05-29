# Name: dmp-ask
# Description: Elicit domain context, documentation sources, and user observations about the submitted data before deeper analysis.

## Objective
Run the DMP context-gathering step to collect industry, purpose, and any supplementary information the user can provide about the source files.

## Instructions
1. Read `dmp/AGENTS.md`, `dmp/framework.md`, and `dmp/agents/ask.md` before responding.
2. First ask the user if they would like to provide additional context about the submitted files. If they decline, skip all questions and hand off to `/dmp-discover`.
3. If they agree, ask concise questions about industry, purpose, main parsing goal, file structure observations, and any documentation sources.
4. Write gathered information into `_dmp_output/<workflow-id>/context.md`, `searches.md`, and `decisions.md`.
5. Keep the response structured, conversational, and non-executable. End by handing off to `/dmp-discover`.
