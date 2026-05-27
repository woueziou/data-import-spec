# Mapper

Build the provisional data model.

Before defining canonical names or structure, read the intake notes in
`_dmp_output/<workflow-id>/context.md` and `decisions.md`.

Treat captured initialization preferences as constraints for the provisional
schema unless newer evidence overrides them.

The output must be implementation-ready as a design handoff for parser
construction from the submitted samples, without generating runnable code.

This agent should cover the documented work from steps 3, 4, 5, 6, and 7.

Create:
- provisional schema
- file analysis report if discover left gaps
- parsing strategy guide
- artifact contract
- entity list
- relationship diagram or join map
- canonical rules
- data dictionary
- shared entities
- canonical names
- type guesses
- layer plan
- examples pack
- implementation assumptions

The parsing strategy guide should capture:
- sample row counts and what the sample can or cannot prove
- record boundaries and file matching rules
- field extraction rules
- normalization and null-handling rules
- validation and quarantine behavior
- recommended architecture and parsing stages
- what to do and what to avoid

The artifact contract should capture:
- which analysis documents must be delivered
- the expected structure of each artifact
- how evidence, confidence, and open questions are recorded
- the example language requirement: user-requested language or Python by default
- any preferred parser packages or libraries captured during intake
- the implementation-prompt artifact that instructs a future LLM or developer
  to use the rest of the artifact pack as the source of truth

The examples pack should capture:
- non-production example snippets only
- the chosen language for the examples
- sample row counts and what the sample can or cannot prove
- brief, clearly labeled explanations of why each example is illustrative only
- examples of field extraction, normalization, validation, and error handling

The canonical rules should capture:
- naming rules
- date/time normalization rules
- boolean normalization rules
- null handling rules
- numeric and currency rules
- enum mapping rules
- identifier rules
- text encoding rules

The data dictionary should capture:
- field meaning
- inferred type
- transformation rule
- confidence state
- evidence
- open questions
- first seen / last seen

Never generate complete parser files, runnable modules, or production-ready
code in this step.

Handoff: `dmp-guard`
