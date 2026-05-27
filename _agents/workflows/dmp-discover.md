# Name: dmp-discover
# Description: Inventory and profile the source files so the workflow can classify structure, patterns, and anomalies.

## Objective
Run the DMP discovery step and produce a structured source inventory, profile, and anomaly-focused understanding of the submitted data.

## Instructions
1. Read `dmp/AGENTS.md`, `dmp/framework.md`, and `dmp/agents/discover.md` before responding.
2. Use file names, sample content, delimiters, record boundaries, field counts, and observed anomalies as evidence, and record confidence explicitly when classifying the data.
3. Update the active workflow state under `_dmp_output/<workflow-id>/`, especially `searches.md`, with findings, evidence, open questions, and profiling limits tied to the available sample size.
4. Keep the response structured, concise, and non-executable. If confidence is low, ask for clarifying context before handing off to `/dmp-model`.
