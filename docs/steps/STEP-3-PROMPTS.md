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

## Prompt B — Generate TypeScript types from provisional schema

```
Here is the provisional schema for a data source:

<paste schema JSON>

Generate:
1. A TypeScript interface `<SourceName>Raw` representing a parsed record
   with exact types matching the schema (use null unions for nullable fields)
2. A TypeScript interface `<SourceName>Parsed` with stricter types: dates as
   Date objects, enums as union string literals, decimals as number
3. A function `validate<SourceName>(raw: <SourceName>Raw): ValidationResult`
   that checks required fields are present and non-empty, and returns a list
   of validation errors

Use `type ValidationResult = { valid: boolean; errors: string[] }`
```

---

## Prompt D — Generate a parser specification from schema and sample facts

```
I have an undocumented data sample and a provisional schema.

Schema:
<paste schema JSON or markdown>

Sample facts:
<paste file name, file-name hints, likely data nature, confidence, file format, delimiter/layout, row count, header info, anomalies>

Target database:
<paste target relational database>

Generate a parser specification that includes:
1. The parser runtime interface: it must accept an input file path and an output folder path
2. Record boundary rules
3. Field extraction rules in source order
4. Normalization rules (trim, null handling, date/number parsing)
5. Validation and quarantine behavior
6. What this sample size can and cannot prove
7. The parsed output shape that will be easiest to load into the target relational database

Do not generate SQL.
```

---

## Prompt E — Generate a parser output contract

```
I have an undocumented data sample and a parser specification.

Parser specification:
<paste parser specification>

Generate an output contract that includes:
1. The assumption that the parser receives an output folder path at runtime
2. Output folder layout beneath that output folder path
3. Output file names
4. Which files are JSON arrays vs JSONL
5. Parsed-record output schema
6. Rejected-row output schema
7. Run-summary output schema
8. Any metadata fields needed to make relational loading easier

Assume the parser may emit both logs and `.json` / `.jsonl` files.

Do not generate SQL.
```

---

## Prompt F — Generate a parser logging contract

```
I have an undocumented data sample and a parser specification.

Parser specification:
<paste parser specification>

Generate a logging contract that includes:
1. The assumption that logs are written under the provided output folder path
2. Log files to emit
3. Structured log event fields
4. Severity levels
5. Per-file summary events
6. Per-run summary events
7. Parse error and quarantine log events
8. Minimal examples of each log event type

Assume the parser is implemented in TypeScript.

Do not generate SQL.
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
