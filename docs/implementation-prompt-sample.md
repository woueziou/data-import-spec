# Implementation Prompt Sample

This is a sample for `artifacts/implementation-prompt.md`.

Use it in a separate implementation phase after the DMP workflow is complete.
The artifact pack remains the source of truth.

```text
Build the parser implementation from the attached DMP artifacts.

Source of truth, in priority order:
1. file-analysis-report.md
2. data-schema.md
3. parsing-strategy-guide.md
4. best-practices-and-guardrails.md
5. dos-and-donts.md
6. edge-cases-and-risk-matrix.md
7. implementation-roadmap.md
8. examples.md

Requirements:
- Language: <Python|TypeScript|Go|...>
- Preferred packages/libraries: <list packages/libraries or "none specified">
- Create the parser at: <target path>
- Follow the schema, normalization rules, validation rules, and edge-case handling exactly as documented.
- Use the preferred packages/libraries when they are compatible with the artifacts and explicitly report any conflict.
- Do not invent fields, formats, or business rules not supported by the artifacts.
- If the artifacts conflict, stop and report the conflict instead of guessing.
- If a required detail is missing, list the gap and propose the smallest safe assumption.
- Implement tests for the documented edge cases and failure modes.
- Preserve raw input fidelity where the artifacts require it.
- Add logging and validation behavior described by the artifacts.
- Summarize which artifact sections were used for each major implementation decision.

Execution plan:
1. Read and summarize the artifact pack.
2. Extract the parser contract and schema rules.
3. Implement the parser.
4. Implement validation and error handling.
5. Implement tests from the risk matrix.
6. Report any unresolved ambiguity.

Before writing code, print:
- inferred parser inputs
- inferred outputs
- unresolved questions
```
