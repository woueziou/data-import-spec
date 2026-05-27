# Step 4 — AI Prompts

## Prompt A — Find shared entities across sources

```
I have provisional schemas for the following data sources:

Source 1 — <name>:
<paste schema>

Source 2 — <name>:
<paste schema>

Source 3 — <name>:
<paste schema>

Please:
1. Identify candidate shared entities (customers, orders, products, etc.)
2. For each entity, list which fields from which sources likely refer to it
3. Identify possible join keys (fields that could be foreign keys)
4. Flag cases where the same concept has different names or formats
5. Estimate confidence for each proposed relationship (high/medium/low)

Output as a JSON object:
{
  entities: [{ name, description, sources: [{ sourceName, fieldName, role }] }],
  relationships: [{ from, to, type, joinKey, confidence, notes }],
  duplicateConcepts: [{ concept, appearances: [{ source, fieldName }], notes }]
}
```

---

## Prompt B — Generate a canonical entity model

```
Based on the following entity analysis:

<paste entity JSON from Prompt A>

Generate a canonical entity model in JSON or Markdown. Requirements:
- Use the most descriptive name found across sources
- Include all fields that appear in at least one source
- Mark fields as optional when they only appear in some sources
- Note which source(s) provide each field
- Add an `id` field as the canonical identifier

Also generate a source-mapping table per entity showing how each source maps
to the canonical entity model.

If a code example would help, include one short NON-PRODUCTION EXAMPLE in
<user-language-or-Python-default> and label it as illustrative only.
```

---

## Prompt C — Detect ID format mismatches

```
I have the following ID-like fields across my sources. Here are sample
values for each:

Source A — customerId: <paste 10 sample values>
Source B — client_no: <paste 10 sample values>
Source C — cust_ref: <paste 10 sample values>

Please:
1. Classify the format of each (numeric, alphanumeric, UUID, prefixed, etc.)
2. Determine if any of these could refer to the same underlying entity
3. If formats differ, propose a normalization policy to make them comparable
4. If helpful, add one short NON-PRODUCTION EXAMPLE in
   <user-language-or-Python-default> showing the normalization logic at a high level
```
