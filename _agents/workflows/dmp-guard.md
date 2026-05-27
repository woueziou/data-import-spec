# Name: dmp-guard
# Description: Review ambiguity, drift, validation, and risk so the parser handoff remains safe and defensible.

## Objective
Run the DMP guard step and turn the current analysis into a validated, risk-aware handoff with explicit uncertainty management.

## Instructions
1. Read `dmp/AGENTS.md`, `dmp/framework.md`, and `dmp/agents/guard.md` before responding.
2. Review the current artifact set for ambiguity, schema drift exposure, validation gaps, quality rules, consumer mismatches, and maintainability or security guardrails.
3. Update the active workflow state and artifacts with drift plans, do-and-don't guidance, edge-case and risk matrix content, validation notes, and any blockers that must be resolved before final handoff.
4. Keep the response structured, concise, and non-executable. Loop back to earlier steps if evidence or rules are insufficient; otherwise hand off to `/dmp-serve`.
