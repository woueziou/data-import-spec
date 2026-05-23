# Step 8 — AI Prompts

## Prompt A — Generate a schema drift detector in TypeScript

```
I have a reference schema for a source stored as a JSON array
(the format defined in step 3). I want to detect drift when a new batch arrives.

Here is the reference schema:
<paste schema JSON>

Write a TypeScript module `driftDetector.ts` with:

1. Type `SchemaField` matching the schema format (fieldName, inferredType,
   nullable, required, cardinality, confidence, enumValues?)

2. Type `DriftResult`:
   {
     hasBreakingChanges: boolean,
     changes: DriftChange[]
   }

3. Type `DriftChange`:
   {
     changeType: 'FIELD_ADDED' | 'FIELD_REMOVED' | 'TYPE_CHANGED' |
                 'NULLABLE_CHANGED' | 'ENUM_VALUE_ADDED' | 'ENUM_VALUE_REMOVED' |
                 'NULL_RATE_SPIKE',
     fieldName: string,
     before: unknown,
     after: unknown,
     severity: 'BREAKING' | 'WARNING' | 'INFO'
   }

4. Function `detectDrift(reference: SchemaField[], observed: SchemaField[]): DriftResult`
   - Compares the two schemas field by field
   - Detects all change types listed above
   - Marks BREAKING for: FIELD_REMOVED (if was required), TYPE_CHANGED,
     column width changes
   - Marks WARNING for: NULLABLE_CHANGED, ENUM_VALUE_REMOVED, NULL_RATE_SPIKE
   - Marks INFO for: FIELD_ADDED, ENUM_VALUE_ADDED

5. Function `formatDriftReport(result: DriftResult): string`
   - Returns a human-readable report
   - Leads with a summary line: "X breaking changes, Y warnings, Z info"
```

---

## Prompt B — Generate a schema versioning utility

```
I need to version my inferred schemas over time. Each time I process a new
batch, I may update the schema.

Write a TypeScript module `schemaRegistry.ts` that:

1. Defines `SchemaVersion`:
   { version: string, source: string, createdAt: string, schema: SchemaField[] }

2. Function `saveSchemaVersion(source: string, schema: SchemaField[], dir: string): Promise<string>`
   - Saves the schema to a JSON file named `<source>-<YYYY-MM-DD>-<hash>.json`
   - The hash is the first 8 chars of a SHA-256 of the schema JSON
   - Returns the file path

3. Function `loadLatestSchema(source: string, dir: string): Promise<SchemaVersion | null>`
   - Reads the most recent schema file for the given source from the directory
   - Returns null if none exists

4. Function `listSchemaHistory(source: string, dir: string): Promise<SchemaVersion[]>`
   - Returns all versions for a source, sorted oldest to newest
```
