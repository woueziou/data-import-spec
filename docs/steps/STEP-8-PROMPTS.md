# Step 8 — AI Prompts

## Prompt A — Generate a schema drift detection plan

```
I have a reference schema for a source stored as a JSON array
(the format defined in step 3). I want to detect drift when a new batch arrives.

Here is the reference schema:
<paste schema JSON>

Generate:
1. A drift detection plan
2. A structured drift result format
3. Severity rules for each drift type
4. A human-readable drift report outline
5. One short NON-PRODUCTION EXAMPLE in <user-language-or-Python-default>
   showing the comparison flow at a high level

The example must be illustrative only, incomplete on purpose, and clearly
labeled as non-executable guidance.
```

---

## Prompt B — Generate a schema versioning policy

```
I need to version my inferred schemas over time. Each time I process a new
batch, I may update the schema.

Generate:
1. A schema version metadata format
2. A file naming convention such as `<source>-<YYYY-MM-DD>-<hash>.json`
3. Rules for when to create a new version
4. Rules for how to compare a new version to the previous one
5. A brief retention and review policy
```
