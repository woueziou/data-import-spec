# Step 7 — AI Prompts

## Prompt A — Generate a data dictionary from a schema

```
I have a provisional schema for the source <source-name>:

<paste schema JSON>

For each field, generate a data dictionary entry with:
- field_name (canonical)
- source (<source-name>)
- raw_name (from schema)
- meaning (your best interpretation of what this field represents, based
  on its name, type, and example values)
- inferred_type
- transformation (the rule needed to standardize this field)
- confidence (confirmed | inferred | ambiguous)
- evidence (why you assigned this confidence level)
- open_questions (what you can't determine from the data alone)
- last_seen (set to today's date: <today>)

Output as a JSON array of data dictionary entries.
```

---

## Prompt B — Flag ambiguous fields and generate deferred storage

```
The following fields in my schema are classified as "ambiguous":

<paste list of ambiguous field entries from the dictionary>

For each ambiguous field:
1. List the competing hypotheses for what it means
2. Describe what additional data or context would resolve the ambiguity
3. Write a TypeScript type that safely stores the raw value without committing
   to an interpretation, with a boolean flag `isVerified`

Also generate a function `deferAmbiguousField(raw: string, fieldName: string)`
that wraps the value in this deferred structure.
```

---

## Prompt C — Generate a Markdown data dictionary report

```
Here is my full data dictionary in JSON:

<paste data dictionary JSON>

Convert it to a well-formatted Markdown document with:
- One section per source
- Within each section, one table with columns:
  Field | Type | Nullable | Confidence | Meaning | Open Questions
- At the bottom, a summary:
  - Total fields
  - Fields by confidence level
  - Fields with open questions

This will be shared with stakeholders.
```
