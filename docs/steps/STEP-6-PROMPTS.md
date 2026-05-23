# Step 6 — AI Prompts

## Prompt A — Generate a canonical type utilities library in TypeScript

```
Generate a TypeScript utility module called `canonical.ts` with the following
functions. Each function must handle all the edge cases listed.

1. `parseDate(raw: string, format: 'YYYYMMDD' | 'DD/MM/YYYY' | 'MM-DD-YY' | 'ISO' | 'epoch'): Date | null`
   - Returns null if the string is empty, "null", "N/A", or unparseable
   - All output dates are in UTC

2. `parseBoolean(raw: string | number | null | undefined): boolean | null`
   - Maps: "Y", "yes", "YES", "1", 1, "true", "TRUE" → true
   - Maps: "N", "no", "NO", "0", 0, "false", "FALSE" → false
   - Returns null for anything else

3. `parseNullable(raw: string | null | undefined): string | null`
   - Returns null for: empty string, "null", "NULL", "N/A", "NA", "none", "NONE"
   - Returns trimmed string otherwise

4. `parseDecimal(raw: string | null | undefined, divisor?: number): number | null`
   - Strips currency symbols (€, $, £, ¥) and thousand separators (, and space)
   - Replaces comma decimal separator with period
   - Parses to float
   - Optionally divides by divisor (e.g. 100 for cents to euros)
   - Returns null if unparseable

5. `parseInteger(raw: string | null | undefined): number | null`
   - Same as parseDecimal but floors the result to integer
   - Returns null if unparseable

6. `normalizeText(raw: string | null | undefined, maxLength?: number): string | null`
   - Returns null if input is null/undefined/empty/whitespace-only
   - Trims whitespace
   - Normalizes multiple spaces to single space
   - Strips control characters (ASCII < 32 except tab/newline)
   - Truncates to maxLength if provided

7. `toCanonicalEnum<T extends string>(raw: string, mapping: Record<string, T>, fallback?: T): T | null`
   - Looks up raw value (case-insensitive) in the mapping
   - Returns mapped canonical value, or fallback, or null
```

---

## Prompt B — Generate a canonical field naming linter

```
I have the following list of field names from different sources:

<paste all field names, one per line>

Please:
1. Group fields that likely represent the same concept
2. For each group, propose a single canonical snake_case field name
3. Flag any names that are ambiguous or could belong to multiple groups
4. Suggest a renaming map: { originalName: canonicalName }

Output as JSON:
{
  groups: [{ canonicalName, members: [{ source, originalName }], confidence }],
  ambiguous: [{ name, possibleGroups }],
  renamingMap: Record<string, string>
}
```
