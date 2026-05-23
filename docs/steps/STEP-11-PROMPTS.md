# Step 11 — AI Prompts

## Prompt A — Generate a TypeScript data quality rule engine

```
I need a data quality rule engine for the source <source-name>.

The standardized record type is:
<paste TypeScript interface>

The rules to enforce are:
<list your rules, e.g.:
- customer_id: required, non-empty
- amount: required, between 0 and 10000000
- status: must be one of "active", "inactive", "suspended"
- transaction_id: must be unique (check against a Set passed in)
- created_at: must not be in the future, must be after 2000-01-01
>

Generate a TypeScript module `qualityRules.ts` with:

1. Type `QualityRule<T>`:
   { name: string, check: (record: T) => boolean, message: string, severity: 'error' | 'warning' }

2. Type `QualityResult`:
   { passed: boolean, errors: string[], warnings: string[] }

3. A function `applyRules<T>(record: T, rules: QualityRule<T>[]): QualityResult`

4. An exported array `<SourceName>Rules: QualityRule<<SourceName>Standardized>[]`
   implementing all the rules listed above

5. A function `routeRecord<T>(record: T, result: QualityResult): 'insert' | 'quarantine' | 'skip'`
   - 'insert' if no errors
   - 'quarantine' if any errors
   - 'skip' if a rule with severity 'error' fails and is marked as unrecoverable
```

---

## Prompt B — Generate a quarantine table and TypeScript insert function

```
I need a quarantine table in PostgreSQL for records that fail quality checks.

The source is called <source-name>. The standardized record interface is:
<paste interface>

Generate:
1. A SQL CREATE TABLE statement for `quarantine_<source_name>` with columns:
   - id (UUID PK)
   - raw_id (UUID, FK to raw_<source_name>)
   - failed_rules (TEXT[] — names of rules that failed)
   - error_messages (TEXT[] — human-readable error messages)
   - record_snapshot (JSONB — the standardized record at the time of failure)
   - quarantined_at (TIMESTAMPTZ)
   - resolved_at (TIMESTAMPTZ, nullable)
   - resolution_notes (TEXT, nullable)

2. A TypeScript function `quarantineRecord(rawId: string, record: unknown, result: QualityResult, db: DbClient): Promise<void>`

3. A TypeScript function `resolveQuarantined(id: string, notes: string, db: DbClient): Promise<void>`
   that marks a quarantined record as resolved
```
