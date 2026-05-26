# Step 6 — AI Prompts

## Prompt A — Generate a canonical normalization reference

```
Generate a canonical normalization reference for the following transformations.
For each transformation, describe the rule, the edge cases, and one short
NON-PRODUCTION EXAMPLE in <user-language-or-Python-default> when it helps.

1. `parseDate`
   - Returns null if the string is empty, "null", "N/A", or unparseable
   - All output dates are in UTC

2. `parseBoolean`
   - Maps: "Y", "yes", "YES", "1", 1, "true", "TRUE" → true
   - Maps: "N", "no", "NO", "0", 0, "false", "FALSE" → false
   - Returns null for anything else

3. `parseNullable`
   - Returns null for: empty string, "null", "NULL", "N/A", "NA", "none", "NONE"
   - Returns trimmed string otherwise

4. `parseDecimal`
   - Strips currency symbols (€, $, £, ¥) and thousand separators (, and space)
   - Replaces comma decimal separator with period
   - Parses to a decimal number
   - Optionally divides by a scaling factor such as 100
   - Returns null if unparseable

5. `parseInteger`
   - Same as parseDecimal but coerces to integer
   - Returns null if unparseable

6. `normalizeText`
   - Returns null if input is null/undefined/empty/whitespace-only
   - Trims whitespace
   - Normalizes multiple spaces to single space
   - Strips control characters (ASCII < 32 except tab/newline)
   - Truncates to maxLength if provided

7. `toCanonicalEnum`
   - Looks up raw value (case-insensitive) in the mapping
   - Returns mapped canonical value, or fallback, or null

All examples must be illustrative only, incomplete on purpose, and clearly
labeled as non-executable guidance.
```

---

## Prompt B — Generate a canonical field naming map

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
