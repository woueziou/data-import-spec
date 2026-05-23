# Step 10 — AI Prompts

## Prompt A — Generate a complete PostgreSQL schema

```
I need a complete PostgreSQL database schema for the following data sources
and entities.

Sources:
<list each source name and its standardized schema>

Canonical entities identified:
<list entities from step 4>

Consumer requirements:
<list serving layer needs from step 9>

Design requirements:
- Use UUID primary keys (gen_random_uuid())
- Use TIMESTAMPTZ for all timestamps (UTC)
- Include a `metadata JSONB` column on entity tables for unstable attributes
- Include raw and standardized layer tables per source
- Include indexes for all foreign keys and high-frequency query fields
- Include CHECK constraints for enums

Generate:
1. CREATE TABLE statements for all tables in dependency order
2. CREATE INDEX statements
3. Comments on each table explaining its role (COMMENT ON TABLE ...)
4. A brief summary of design decisions made
```

---

## Prompt B — Generate a TypeScript database client module

```
I have the following PostgreSQL schema:
<paste DDL>

Generate a TypeScript module `db.ts` using the `postgres` npm package with:

1. A connection pool setup from environment variables:
   DATABASE_URL or {PGHOST, PGPORT, PGDATABASE, PGUSER, PGPASSWORD}

2. TypeScript interfaces for each table row type

3. Repository functions for each main entity table:
   - `findById(id: string): Promise<Entity | null>`
   - `findBySourceId(sourceId: string, sourceName: string): Promise<Entity | null>`
   - `insert(record: NewEntity): Promise<Entity>`
   - `upsert(record: NewEntity, conflictKey: string): Promise<Entity>`

4. A raw layer insertion function:
   `insertRaw(content: string, sourceName: string, batchId: string, sourceFile?: string): Promise<RawRecord>`

5. A transaction helper:
   `withTransaction<T>(fn: (tx: Tx) => Promise<T>): Promise<T>`
```

---

## Prompt C — Generate a migration file

```
I need to migrate my database from the following current state:
<paste current DDL or describe current tables>

To the following target state:
<paste target DDL>

Generate a PostgreSQL migration script that:
1. Creates all new tables
2. Adds all new columns to existing tables (with safe defaults for NOT NULL)
3. Creates all new indexes
4. Does NOT drop anything (additive migration only)
5. Is wrapped in a transaction (BEGIN / COMMIT)
6. Includes a rollback section as a comment (-- ROLLBACK:)
```
