# Step 3 — AI Prompts

## Prompt A — Generate a provisional schema from profile results

```
Here is the data profile I collected for a source called <source-name>:

<paste profile JSON from step 2>

Generate a provisional schema as a JSON array. Each element must have:
- fieldName (snake_case canonical name)
- rawName (original name or position)
- inferredType (string | integer | decimal | boolean | date | enum | json | unknown)
- nullable (true | false | unknown)
- required (true | false | unknown)
- exampleValues (array of 3–5 real values)
- cardinality (one | enum | many)
- confidence (high | medium | low)
- assumption (what you're assuming that might be wrong)

For enum candidates, also add an enumValues array listing all observed
distinct values.

Also state how many sample rows these inferences are based on and mark any
field-level assumption that is weak because of limited sample size.
```

---

## Prompt B — Generate a formal model and illustrative validation sketch

```
Here is the provisional schema for a data source:

<paste schema JSON>

Generate:
1. A formal schema representation suitable for documentation
   (JSON Schema, a Markdown schema table, or an interface sketch)
2. A list of fields that are high-confidence vs low-confidence
3. One short NON-PRODUCTION EXAMPLE in <user-language-or-Python-default>
   showing how a future parser might validate a single record

The example must be illustrative only, incomplete on purpose, and clearly
labeled as non-executable guidance.
```

---

## Prompt D — Generate a parser specification from schema and sample facts

```
I have an undocumented data sample and a provisional schema.

Schema:
<paste schema JSON or markdown>

Sample facts:
<paste file name, file-name hints, likely data nature, confidence, file format, delimiter/layout, row count, header info, anomalies>

Generate a parsing strategy guide that includes:
1. Record boundary rules
2. Field extraction rules in source order
3. Normalization rules (trim, null handling, date/number parsing)
4. Validation and quarantine behavior
5. What this sample size can and cannot prove
6. Recommended parsing stages and architecture
7. Key risks, blind spots, and follow-up questions

Do not generate executable code.
```

---

## Prompt E — Generate an artifact pack outline

```
I have an undocumented data sample and a parsing strategy guide.

Parsing strategy guide:
<paste parsing strategy guide>

Generate an artifact pack outline that includes:
1. The required artifact files
2. The purpose of each artifact
3. The sections each artifact should contain
4. Where confidence, anomalies, and open questions should be recorded
5. Which artifact should hold illustrative examples
6. Which artifact should hold the implementation roadmap
7. Which artifact should hold the implementation prompt for a future LLM or developer

Do not generate executable code.
```

---

## Prompt F — Generate an examples artifact outline

```
I have an undocumented data sample and a parsing strategy guide.

Parsing strategy guide:
<paste parsing strategy guide>

Generate an `examples.md` outline that includes:
1. A language note stating the user-requested language or Python default
2. Example categories to include
3. A warning banner that all examples are illustrative only
4. Short example scopes such as field extraction, normalization, validation,
   record routing, and error reporting
5. Notes about what the examples intentionally omit

Do not generate executable code.
```

---

## Prompt C — Compare two schema versions and detect changes

```
I have two versions of a provisional schema for the same source.

Version 1 (older):
<paste schema>

Version 2 (newer):
<paste schema>

Please:
1. List fields added in version 2
2. List fields removed in version 2
3. List fields where the inferredType changed
4. List fields where nullable changed
5. List fields where confidence changed
6. Classify each change as: BREAKING | NON_BREAKING | IMPROVEMENT

Output as a structured JSON diff report.
```
