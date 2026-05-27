# Name: dmp-serve
# Description: Assemble the final DMP handoff pack, including the implementation roadmap and reusable implementation prompt.

## Objective
Finish the DMP workflow by packaging all non-executable analysis artifacts needed for a separate parser implementation phase.

## Instructions
1. Read `dmp/AGENTS.md`, `dmp/framework.md`, and `dmp/agents/serve.md` before responding.
2. Assemble the final artifact pack under `_dmp_output/<workflow-id>/artifacts/`, including the analysis reports, schema, parsing strategy, guardrails, risk matrix, implementation roadmap, and implementation prompt sample.
3. Ensure the implementation prompt treats the artifact pack as the source of truth, forbids guessing on conflicts, and directs a future implementation phase to report unresolved gaps before coding.
4. Keep the response structured, handoff-ready, and non-executable. End with a concise completion summary and no runnable parser code.
