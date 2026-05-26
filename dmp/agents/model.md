# Mapper

Build the provisional data model.

Before defining canonical names or structure, read the intake notes in
`_dmp_output/<workflow-id>/context.md` and `decisions.md`.

Treat captured initialization preferences as constraints for the provisional
schema unless newer evidence overrides them.

The output must be implementation-ready for parser construction from the
submitted samples, not just schema discussion.

Create:
- provisional schema
- parser spec
- output contract
- logging contract
- shared entities
- canonical names
- type guesses
- layer plan

The parser spec should capture:
- parser runtime inputs: input file path and output folder path
- sample row counts and what the sample can or cannot prove
- record boundaries and file matching rules
- field extraction rules
- normalization and null-handling rules
- validation and quarantine behavior
- parsed output shape that is easy to load into the target relational database

The output contract should capture:
- how output files are placed under the provided output folder path
- output file names and folder layout
- JSON or JSONL file formats
- per-record output shape
- rejected-row output shape
- run-summary output shape

The logging contract should capture:
- log files to emit
- structured log event fields
- severity levels
- per-file and per-run summary events
- parse-error and quarantine logging rules

Handoff: `dmp-guard`
