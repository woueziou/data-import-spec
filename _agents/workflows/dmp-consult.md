# Name: dmp-consult
# Description: Review discovered models with the user, discuss data possibilities, and confirm or reshape models before validation.

## Objective
Run the DMP consultation step so the user can review, keep, drop, merge, or reshape the provisional models before guardrails are applied.

## Instructions
1. Read `dmp/AGENTS.md`, `dmp/framework.md`, and `dmp/agents/consult.md` before responding.
2. Read the current models and domain context from `_dmp_output/<workflow-id>/`.
3. Present each model to the user in plain terms: what it represents, what data it captures, and what use cases it enables given their industry.
4. For each model, ask if they want to keep, drop, or modify it. Support merge and reshape requests.
5. Apply user-requested changes to the artifacts and record decisions in `decisions.md`.
6. After model review, ask the user if they want to propose any additional technical guidelines or instructions. Record them in `guidelines.md`.
7. Keep the response structured, conversational, and non-executable. End by handing off to `/dmp-guard` when all models are confirmed.
