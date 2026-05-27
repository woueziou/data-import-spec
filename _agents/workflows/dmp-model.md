# Name: dmp-model
# Description: Convert discovery findings into a formal schema, parsing strategy, and implementation-ready analysis artifacts.

## Objective
Build the DMP modeling artifacts that describe the data structure, parsing approach, and implementation constraints without generating runnable parser code.

## Instructions
1. Read `dmp/AGENTS.md`, `dmp/framework.md`, and `dmp/agents/model.md` before responding, and treat `_dmp_output/<workflow-id>/context.md` and `decisions.md` as constraints.
2. Produce or refine the schema/model, parsing strategy, canonical rules, data dictionary, examples pack, and related artifact contract using only evidence supported by the analyzed files.
3. Record confidence, assumptions, evidence, and open questions in the workflow artifacts, and keep all code-related material illustrative only in the user-requested language or Python by default.
4. Keep the response structured, handoff-ready, and non-executable. End by handing off to `/dmp-guard` when the modeling artifacts are complete enough for validation and risk review.
