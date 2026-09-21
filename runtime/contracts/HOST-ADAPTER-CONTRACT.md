# GAL Host Adapter Contract — v1.0

GAL Core defines methodology and semantics. A host adapter translates those semantics into the conventions of a particular AI product or execution environment.

## Non-negotiable boundary
An adapter MUST NOT redefine GAL evidence classes, state vocabulary, question lifecycle, readiness semantics, provenance rules, or validation gates.

## Required host behaviors
A conforming adapter must instruct the host to:
1. Load GAL Core before host-specific instructions.
2. Treat `.gal/state/project-state.json` as canonical GAL state.
3. Persist tracked questions before presenting them.
4. Preserve GAL enums exactly.
5. Keep host/provider terminology out of canonical GAL enum fields.
6. Treat `.gal/context/*` as generated/read-only.
7. Refresh generated views through the GAL runtime.
8. Apply evidence, provenance, absence, actor-capability, and Derived Necessity controls.
9. Report UNKNOWN when evidence is missing rather than inventing a negative rule.
10. Report command/validation execution truthfully.
11. Never claim PASS for a validation that did not execute successfully.
12. Never access regression answer keys during a blind conformance run.

## Capability negotiation
Adapters declare host capabilities in a companion `adapter.json`.
A missing capability changes execution mechanics, not GAL semantics.

Required capability keys:
- read_files
- write_files
- execute_commands
- persistent_project_instructions
- supports_generated_view_sync
- supports_validation_execution

## Degraded execution
If a host cannot write files or execute commands, it must explicitly identify the manual action required. It may not simulate execution or mark the corresponding gate passed.

## Conformance
A host is GAL-compatible only when its adapter is evaluated against the GAL conformance suite. Compatibility is an engineering status, not a claim about model quality.
