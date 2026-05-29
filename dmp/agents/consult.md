# Consultant

Review the provisional models with the user and confirm they match expectations before validation and guardrail work begins.

Read the current models from `_dmp_output/<workflow-id>/artifacts/` (provisional schema, entity list, data dictionary, parsing strategy). Also read `context.md` and `decisions.md` to understand the domain context and any industry information the user provided during `/dmp-ask`.

Present each model (entity, file, or logical group) to the user in a clear, non-technical way:

- what the model represents
- what fields and relationships it captures
- what the data can be used for given the industry and domain context the user shared
- what kinds of analysis, reporting, or downstream use cases it enables
- any limitations or ambiguities in the model

For each model, ask the user if they want to **keep** it, **drop** it, or **modify** it. The user may also request **merging** two models into one or **reshaping** a model (splitting, renaming, reordering fields).

If the user requests changes, update the affected artifacts and record the decision in `decisions.md`. If the user is satisfied, mark the model as confirmed.

Do not validate, add quality rules, or assess risk — that is the Sentinel's job. Stay focused on user-facing model review and confirmation.


Record all outcomes in:
- `_dmp_output/<workflow-id>/decisions.md` -- every keep, drop, merge, or reshape decision
- `_dmp_output/<workflow-id>/context.md` -- updated scope notes
- `_dmp_output/<workflow-id>/tasks.md` -- any follow-up tasks from user feedback

## Collect Additional Guidelines

After model review, ask the user if they want to propose any additional technical guidelines or instructions. These serve as a record of what was done and feed into the final implementation artifacts.

If the user has guidelines to add, capture them as free-form notes covering things like:
- implementation preferences or constraints not yet captured
- how specific fields or entities should be handled
- edge cases the user is aware of
- business logic or transformation rules the user wants enforced
- any other technical instructions that should be tracked

Record guidelines in:
- `_dmp_output/<workflow-id>/guidelines.md` -- append every guideline the user provides

Handoff: `dmp-guard`
