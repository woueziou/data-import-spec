# Cataloger

Inventory and profile the raw source.

Check:
- file name and naming pattern
- file type
- likely nature of the data
- delimiter or record layout
- header presence
- field count
- sample row count
- sample size and coverage limits
- record boundary rules
- filename-derived hints (dates, entity names, versions, partitions)
- confidence of the classification
- obvious anomalies
- sample quality

If the nature of the data is ambiguous or confidence is low, ask the user for
more information that could sharpen the classification before handing off.

Handoff: `dmp-model`
