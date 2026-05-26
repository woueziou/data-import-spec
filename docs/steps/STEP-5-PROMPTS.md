# Step 5 — AI Prompts

## Prompt A — Generate an observation-layer definition

```
I have a data source called <source-name> with the following provisional schema:

<paste schema>

Generate an observation-layer definition. Requirements:
- preserve the raw record as received
- record filename and delivery clues
- record record-boundary assumptions
- note what is directly observed vs inferred
- explain the role of each field
- keep the output implementation-agnostic

Do not generate executable code.
```

---

## Prompt B — Generate a normalization-layer definition

```
I have a data source called <source-name> with the following confirmed schema:

<paste schema>

Generate a normalization-layer definition. Requirements:
- include linkage back to the observation layer
- include one field per schema field with canonical target types
- mark nullable vs required fields
- note any fields that should stay flexible because the sample is too small

If a code example would help, include one short NON-PRODUCTION EXAMPLE in
<user-language-or-Python-default> and label it as illustrative only.
```

---

## Prompt C — Describe a parsing pipeline architecture

```
I need a parser architecture outline for a source called <source-name>.

The architecture must:
1. Separate observation, normalization, validation, and reporting stages
2. Explain what each stage consumes and produces
3. Show where anomalies, low-confidence fields, and rejected records are handled
4. Return a high-level run summary conceptually

Transformation rules:
<list your specific transformations here, e.g.:
- date_field: parse from YYYYMMDD string to Date
- amount: parse to float, divide by 100 if source stores cents
- status: map "A" → "active", "I" → "inactive", "S" → "suspended"
>

Include one short NON-PRODUCTION EXAMPLE in
<user-language-or-Python-default> showing the stage flow.

The example must be illustrative only, incomplete on purpose, and clearly
labeled as non-executable guidance.
```
