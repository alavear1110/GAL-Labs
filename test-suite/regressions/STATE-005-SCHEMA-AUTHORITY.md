# STATE-005 — Schema Authority

The canonical JSON Schema owns structural validity for GAL project state.

PASS:
- the unmodified state template validates
- invalid question vocabulary is rejected
- invalid decision-debt vocabulary is rejected
- undeclared top-level properties are rejected
- incorrect property types are rejected
- repaired canonical state validates again

FAIL:
- `validate-state` accepts state that violates `runtime/schemas/project-state.schema.json`
- PowerShell duplicates structural rules in a second hand-maintained contract and can drift from the schema
