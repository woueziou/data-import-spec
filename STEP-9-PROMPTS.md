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
5. Suggest what serving layer table or view would serve this consumer

Output as a JSON array:
{
  consumers: [{
    name,
    requiredFields: [{ fieldName, source, status: 'available' | 'missing' | 'ambiguous' }],
    typeIssues: [{ fieldName, consumerExpects, currentType }],
    granularityNote,
    suggestedServingTable
  }]
}
```

---

## Prompt B — Generate a serving layer view for a specific consumer

```
I need to build a serving layer SQL view for the following consumer:

Consumer: <name, e.g. "monthly revenue report">
Needs:
- <list the fields they need with desired names and types>
- Granularity: <one row per what?>
- Filters: <what data they care about>
- Sort: <any default ordering>

My standardized layer tables are:
<paste DDL for std_ tables>

Generate:
1. A SQL view or materialized view definition that serves this consumer
2. A TypeScript interface `<ConsumerName>Row` representing one row of the view
3. A TypeScript function `query<ConsumerName>(db: DbClient, params: {...}): Promise<<ConsumerName>Row[]>`
   with the most common query parameters
```
