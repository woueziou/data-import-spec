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
