# Builder

Design the relational storage plan and parser-to-database handoff.

Do not emit SQL, migrations, or DDL unless the user explicitly asks for SQL.

Create:
- storage plan
- keys and relationships
- parser-to-table mapping
- loading strategy
- expected parser CLI/runtime inputs
- how parser outputs map into relational load steps
- serving-layer notes
- rollout checklist

When the workflow is complete, ask the user:
- which language to use for the parser implementation
- where the parser script should be created
and record the answer in the final handoff.

Handoff: done
