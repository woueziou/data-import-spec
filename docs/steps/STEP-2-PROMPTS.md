# Step 2 — AI Prompts

## Prompt A — Detect fixed-width column boundaries

```
I have a fixed-width text file with no documentation. Here is a sample of
100 lines:

<paste raw lines here>

Please:
1. Analyze character positions across all lines
2. Identify likely column boundaries by detecting positions where spaces
   consistently appear (padding) or where values consistently start/end
3. Propose a column layout table: column index, start position (0-based),
   end position, width, sample values
4. Flag any positions where the boundary is uncertain
5. Identify whether the first line is a header

Output the column layout as a JSON array with objects:
{ index, start, end, width, sampleValues, confidence, notes }
```

---

## Prompt B — Write a TypeScript fixed-width parser

```
I have a fixed-width file with the following column layout:

<paste the JSON column layout from Prompt A>

Write a TypeScript function `parseFixedWidthLine(line: string)` that:
- Takes a raw string line as input
- Extracts each field based on the character offsets
- Trims whitespace from each field
- Returns a typed object with field names I'll provide below
- Handles lines that are shorter than expected (pad with empty string)

Field names to use: <list your field names>

Also write a function `parseFixedWidthFile(content: string)` that:
- Splits on newlines
- Skips the header line if present (boolean parameter)
- Calls parseFixedWidthLine on each remaining line
- Returns an array of parsed records
```

---

## Prompt C — Profile a CSV file

```
I have a CSV file. Here are the first 200 rows as raw text:

<paste content>

For each column:
1. Detect the actual data type from values (string, integer, float, date,
   boolean, enum, mixed)
2. Count nulls, empty strings, and the string "null" or "N/A"
3. List up to 10 distinct values if cardinality seems low (enum candidate)
4. Find min/max for numeric columns
5. Detect date format patterns for date-like columns
6. Flag any anomalies

Output as a JSON array, one object per column:
{ name, inferredType, nullRate, distinctCount, sampleValues, minValue,
  maxValue, dateFormat, anomalies }
```

---

## Prompt D — Character frequency analysis for fixed-width

```
I have a fixed-width file. Here are 50 raw lines:

<paste lines>

For each character position from 0 to the maximum line length:
1. Count how many rows have a space at that position
2. Mark positions where space rate > 80% as likely padding or boundary
3. Group consecutive non-padding positions into candidate field ranges

Output as a JSON array:
{ position, spaceRate, likelySeparator }

Then suggest a compact column layout based on the groupings.
```
