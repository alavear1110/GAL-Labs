# GAL Regression Testing

## Current baseline

The primary baseline scenario is **ExpPay**, an employee-expense workflow used to test GAL controls.

## Named regression controls

### TEST-001 — Runtime isolation
The runtime package must not contain or expose regression fixtures or expected answers.

### STATE-003 — Question persistence
Tracked questions must be written to canonical state before they are presented as GAL-managed questions.

### STATE-004 — Generated-view discipline
The host AI must not directly edit `.gal/context/*`. It must update canonical state and run sync.

### EVID-002 — Absence is not negative evidence
Missing or undefined rules must remain UNKNOWN rather than becoming negative requirements.

### ACTOR-001 — Actor capability evidence
Actor capabilities require direct or valid derived support.

### VALID-001 — Validator before claim
GAL must not claim state validation passed unless `validate-state` actually executed successfully.

### STATE-005 — Schema authority
The canonical JSON Schema owns structural state validity; invalid vocabulary, undeclared properties, and incorrect types must fail validation.

### VALID-002 — Validation-state lifecycle
The latest validation result must truthfully replace prior PASS or FAIL metadata without stale state.

### READINESS-001 — Status/reason synchronization
Readiness status and reason must be recalculated together from the same canonical facts.

### STATE-006 — Derived reviewability
Reviewability is derived from requirements gates and validation state, not persisted as an independent mutable boolean.

## Blind-test rule

Keep the test suite outside the runtime project. The host AI must not have access to expected answers during a blind regression run.

## Current deterministic runtime evidence

Local macOS execution with PowerShell 7.6.6 has confirmed runtime/test-suite isolation, JSON Schema authority, truthful validation-state lifecycle, readiness status/reason synchronization, decision-debt validation, deterministic generated-view synchronization, and derived reviewability.

These deterministic runtime results do not by themselves establish host behavioral conformance. Blind host controls such as evidence classification, actor-capability discipline, question persistence behavior, and generated-view editing discipline still require execution in the host being evaluated.
