# Step 1 — AI Prompts

## Prompt A — Detect file format and basic metadata

```
I have a data file I need to analyze. Here is a sample of its raw content
(first 50 lines):

<paste raw content here>

File name:
<paste file name here>

Please:
1. Identify what the file name suggests about the data (entity, date, version, partition, region, etc.)
2. Identify the likely nature of the data (for example: customers, orders, transactions, events, telemetry, inventory, ledger, logs)
3. Rate your confidence in that classification as high, medium, or low
4. Identify the file format (fixed-width, CSV, TSV, JSON lines, XML, log, other)
5. Estimate whether there is a header row
6. Identify the delimiter if any
7. Count the approximate number of columns or fields
8. Count how many sample rows are present in the submitted text
9. Note any visible structure like record separators or section markers
10. Flag anything unusual or ambiguous
11. If confidence is low, list the extra questions you would ask the user

Output as a structured JSON object with keys:
fileNameHints, likelyDataNature, confidence, format, hasHeader, delimiter, columnCount, sampleRowCount, notes, anomalies, followUpQuestions
```

---

## Prompt B — Generate a source catalog entry

```
Based on the following file information:

- File name: <name>
- Likely data nature: <nature>
- Confidence: <high|medium|low>
- Format detected: <format>
- Delivery: <how it arrives>
- Frequency: <how often>
- Approximate size: <size>
- Owner: <who produces it>

Write a JSON object or Markdown entry for this source catalog. Include:
- id
- name
- format
- deliveryMode
- frequency
- volumeEstimate
- owner
- trustLevel
- samplePath
- fileNameHints
- likelyDataNature
- confidence
- notes

Do not generate executable code.
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
