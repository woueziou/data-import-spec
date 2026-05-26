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
