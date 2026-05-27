# Step 11 — AI Prompts

## Prompt A — Generate a data quality rule catalog

```
I need a data quality rule catalog for the source <source-name>.

The normalized record definition is:
<paste normalized record definition>

The rules to enforce are:
<list your rules, e.g.:
- customer_id: required, non-empty
- amount: required, between 0 and 10000000
- status: must be one of "active", "inactive", "suspended"
- transaction_id: must be unique (check against a Set passed in)
- created_at: must not be in the future, must be after 2000-01-01
>

Generate:
1. A rule catalog with severity, rationale, and action
2. A decision table for pass, warn, quarantine, or skip
3. A review note format for failed records
4. If helpful, one short NON-PRODUCTION EXAMPLE in
   <user-language-or-Python-default> showing how a future validator might apply one rule

The example must be illustrative only, incomplete on purpose, and clearly
labeled as non-executable guidance.
```

---

## Prompt B — Generate a quarantine and review contract

```
I need a quarantine and review contract for records that fail quality checks.

The source is called <source-name>. The normalized record definition is:
<paste definition>

Generate:
1. The fields that must be captured for a failed record
2. The lifecycle states for review and resolution
3. The information needed to reprocess a quarantined record
4. If helpful, one short NON-PRODUCTION EXAMPLE in
   <user-language-or-Python-default> showing the review flow at a high level

Do not generate SQL or executable code.
```
