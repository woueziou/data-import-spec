# Step 10 — AI Prompts

## Prompt A — Generate a relational storage plan

```
I need a relational storage plan for the following undocumented data sources
and entities.

Sources:
<list each source name and its standardized schema>

Canonical entities identified:
<list entities from step 4>

Consumer requirements:
<list serving layer needs from step 9>

Target database:
<name the relational database>

Generate:
1. A raw/staging/canonical/serving storage outline
2. Recommended tables or collections of columns by layer
3. Key and relationship decisions
4. A parser-to-database mapping strategy
5. A brief summary of design decisions made

Do not generate SQL.
```

---

## Prompt B — Generate SQL only when explicitly requested

```
I explicitly want SQL for the following storage plan:
<paste storage plan>

Target database:
<name the relational database>

Generate SQL/DDL for that database based on the storage plan.
```

---

## Prompt C — Generate a migration file only when explicitly requested

```
I explicitly want a migration for the following relational database:
<name the relational database>

Current state:
<paste current DDL or describe current tables>

Target state:
<paste target DDL>

Generate a migration script that:
1. Creates all new tables
2. Adds all new columns to existing tables (with safe defaults for NOT NULL)
3. Creates all new indexes
4. Does NOT drop anything (additive migration only)
5. Is wrapped in a transaction (BEGIN / COMMIT)
6. Includes a rollback section as a comment
```
