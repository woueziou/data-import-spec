# Step 5 — AI Prompts

## Prompt A — Generate raw layer table DDL

```
I have a data source called <source-name> with the following provisional schema:

<paste schema>

Generate a SQL CREATE TABLE statement for the raw storage layer. Requirements:
- Table name: raw_<source_name>
- Column: id (UUID primary key, auto-generated)
- Column: raw_content (TEXT — the original unparsed line or record)
- Column: source_name (VARCHAR(100) NOT NULL)
- Column: source_file (VARCHAR(500) — original filename)
- Column: source_record_id (VARCHAR(200) — ID from the source if detectable)
- Column: ingested_at (TIMESTAMPTZ NOT NULL DEFAULT now())
- Column: batch_id (UUID — groups records from the same file import)
- No other columns

Also write the TypeScript interface `RawRecord` matching this table.
```

---

## Prompt B — Generate standardized layer table DDL

```
I have a data source called <source-name> with the following confirmed schema:

<paste schema>

Generate a SQL CREATE TABLE statement for the standardized layer. Requirements:
- Table name: std_<source_name>
- Column: id (UUID primary key)
- Column: raw_id (UUID FK to raw_<source_name>.id)
- Column: source_name (VARCHAR(100) NOT NULL)
- Column: standardized_at (TIMESTAMPTZ NOT NULL)
- One column per field in the schema, using proper SQL types:
  - string → VARCHAR or TEXT
  - integer → INTEGER or BIGINT
  - decimal → NUMERIC(precision, scale)
  - boolean → BOOLEAN
  - date → DATE or TIMESTAMPTZ
  - enum → VARCHAR(50) with a CHECK constraint listing allowed values
  - json → JSONB
- Mark nullable fields as NULL, required fields as NOT NULL

Also write the corresponding TypeScript interface `Std<SourceName>Record`.
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
