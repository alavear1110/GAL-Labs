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

## Blind-test rule

Keep the test suite outside the runtime project. The host AI must not have access to expected answers during a blind regression run.
