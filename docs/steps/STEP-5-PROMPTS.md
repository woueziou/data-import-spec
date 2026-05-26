# Step 5 — AI Prompts

## Prompt A — Generate a raw layer storage definition

```
I have a data source called <source-name> with the following provisional schema:

<paste schema>

Generate a storage definition for the raw layer. Requirements:
- logical table name: raw_<source_name>
- fields: id, raw_content, source_name, source_file, source_record_id, ingested_at, batch_id
- explain the role of each field
- keep the definition easy to map into a relational database later

Also write the TypeScript interface `RawRecord` matching this shape.

Do not generate SQL.
```

---

## Prompt B — Generate a standardized layer storage definition

```
I have a data source called <source-name> with the following confirmed schema:

<paste schema>

Generate a storage definition for the standardized layer. Requirements:
- logical table name: std_<source_name>
- include linkage back to the raw layer
- include one field per schema field with relational-friendly target types
- mark nullable vs required fields
- note any fields that should stay flexible because the sample is too small

Also write the corresponding TypeScript interface `Std<SourceName>Record`.

Do not generate SQL.
```

---

## Prompt C — Write a TypeScript ingestion pipeline

```
I need a TypeScript ingestion pipeline for a source called <source-name>.

The pipeline must:
1. Accept an array of raw parsed records (type: <SourceName>Raw[])
2. For each record:
   a. Insert the original raw line into the raw layer (type: RawRecord)
   b. Transform the raw record into a standardized record
   c. Insert into the standardized layer
3. Run both inserts in a transaction so they succeed or fail together
4. Return a summary: { total, inserted, failed, errors }

Transformation rules:
<list your specific transformations here, e.g.:
- date_field: parse from YYYYMMDD string to Date
- amount: parse to float, divide by 100 if source stores cents
- status: map "A" → "active", "I" → "inactive", "S" → "suspended"
>

Use a database client interface I'll provide (db.query(sql, params)).
Include error handling per record so one bad record doesn't abort the batch.
```
