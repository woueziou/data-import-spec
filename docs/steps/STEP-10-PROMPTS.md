# Step 10 — AI Prompts

## Prompt A — Generate an implementation roadmap

```
I need an implementation roadmap for the following undocumented data sources
and entities.

Sources:
<list each source name and its standardized schema>

Canonical entities identified:
<list entities from step 4>

Consumer requirements:
<list handoff-layer or consumer-facing needs from step 9>

Generate:
1. Recommended build phases
2. Key dependencies between phases
3. Validation checkpoints for each phase
4. High-risk areas that should be implemented first
5. A brief summary of design decisions made

Do not generate executable code.
```

---

## Prompt B — Generate an artifact cross-reference matrix

```
I have the following artifact set:
<paste file analysis report, schema/model, parsing strategy, guardrails, risk matrix, and examples summary>

Generate a matrix that maps:
- each artifact
- the implementation questions it answers
- the remaining open questions
- the validation checks it enables
```

---

## Prompt C — Generate an implementation readiness checklist

```
I have a nearly complete DMP artifact pack.

Generate an implementation readiness checklist that covers:
1. Missing evidence or unresolved ambiguity
2. Required validation datasets
3. Performance questions to test
4. Observability and failure-handling needs
5. Conditions that must be true before production implementation begins
```

---

## Prompt D — Generate an implementation prompt sample

```
I have a complete DMP artifact pack and I want a reusable prompt that another
LLM or developer can use in a separate implementation phase to build the
parser.

Artifacts available:
- file-analysis-report.md
- data-schema.md
- parsing-strategy-guide.md
- best-practices-and-guardrails.md
- examples.md
- dos-and-donts.md
- edge-cases-and-risk-matrix.md
- implementation-roadmap.md

Preferred implementation language:
<language or "Python by default">

Preferred parser packages or libraries:
<list packages/libraries or "none specified">

Target output path:
<target path or "to be decided">

Generate `implementation-prompt.md` that:
1. States the artifacts are the source of truth, in priority order
2. Tells the implementation-phase LLM not to invent rules, fields, or formats
3. Tells it to stop and report conflicts instead of guessing
4. Tells it to honor any preferred parser packages or libraries captured during intake
5. Tells it to implement documented tests, validation, and failure modes
6. Tells it to summarize which artifact sections drove major implementation decisions
7. Tells it to list unresolved gaps and the smallest safe assumptions
8. Includes a short execution plan for reading artifacts, implementing, testing, and reporting ambiguity

The output must be a prompt artifact only. Do not generate code.
```
