# Step 1 — AI Prompts

## Prompt A — Detect file format and basic metadata

```
I have a data file I need to analyze. Here is a sample of its raw content
(first 50 lines):

<paste raw content here>

Please:
1. Identify the file format (fixed-width, CSV, TSV, JSON lines, XML, log, other)
2. Estimate whether there is a header row
3. Identify the delimiter if any
4. Count the approximate number of columns or fields
5. Note any visible structure like record separators or section markers
6. Flag anything unusual or ambiguous

Output as a structured JSON object with keys:
format, hasHeader, delimiter, columnCount, notes, anomalies
```

---

## Prompt B — Generate a TypeScript source catalog entry

```
Based on the following file information:

- File name: <name>
- Format detected: <format>
- Delivery: <how it arrives>
- Frequency: <how often>
- Approximate size: <size>
- Owner: <who produces it>

Write a TypeScript interface called `SourceCatalogEntry` and a populated
constant for this source. Include: id, name, format, deliveryMode,
frequency, volumeEstimate, owner, trustLevel, samplePath, notes.
```

---

## Prompt C — Scaffold a source inventory file

```
I have the following data sources:

<list each source with a short description>

Generate a Markdown table with columns:
Source ID | Name | Format | Delivery | Frequency | Volume | Trust Level | Notes

Fill in what you can infer from my descriptions. Use "unknown" where
information is missing.
```
