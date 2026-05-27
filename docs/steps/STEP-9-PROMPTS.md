# Step 9 — AI Prompts

## Prompt A — Generate a consumer requirements checklist

```
I have the following data sources with this standardized schema:

<paste your standardized schema or data dictionary>

I know the data will be used for the following purposes:
<list your known consumers, e.g.: monthly revenue reports, customer lookup
API, compliance audit log, churn prediction model>

For each consumer:
1. List the fields they will need from the schema
2. Identify fields that are missing or currently ambiguous
3. Identify type or format mismatches (e.g. consumer needs ISO date but field
   is a raw string)
4. Identify granularity mismatches (e.g. consumer needs one row per customer,
   but data has one row per transaction)
5. Suggest what handoff artifact or consumer-facing shape would serve this consumer

Output as a JSON array:
{
  consumers: [{
    name,
    requiredFields: [{ fieldName, source, status: 'available' | 'missing' | 'ambiguous' }],
    typeIssues: [{ fieldName, consumerExpects, currentType }],
    granularityNote,
    suggestedArtifact
  }]
}
```

---

## Prompt B — Generate a consumer-facing data contract

```
I need to build a consumer-facing data contract for the following consumer:

Consumer: <name, e.g. "monthly revenue report">
Needs:
- <list the fields they need with desired names and types>
- Granularity: <one row per what?>
- Filters: <what data they care about>
- Sort: <any default ordering>

My normalized data definition is:
<paste normalized data definition>

Generate:
1. A consumer-facing shape that serves this consumer
2. Required fields, types, and granularity
3. Filtering and sorting expectations
4. Risks, open questions, and missing inputs
5. If helpful, one short NON-PRODUCTION EXAMPLE in
   <user-language-or-Python-default> showing how a future consumer might read the shape

Do not generate executable code.
```
