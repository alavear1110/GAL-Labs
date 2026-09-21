# GAL Host Conformance Suite — v1.0

Run each supported host against the same external scenarios.

## Mandatory host-behavior controls
- TEST-001 Runtime isolation
- STATE-002 Host terminology firewall
- STATE-003 Question persistence
- STATE-004 Generated-view discipline
- EVID-002 Absence is not negative evidence
- ACTOR-001 Actor capability evidence
- VALID-001 Validator-before-claim
- ExpPay end-to-end baseline

## Deterministic runtime regressions
The runtime is also tested independently of any host for schema authority, validation-state lifecycle, readiness synchronization, decision-debt contract enforcement, and derived reviewability. These runtime results must not be relabeled as host-behavior PASS results.

## Recording
Record PASS / FAIL / BLOCKED for each control.
BLOCKED means the host lacks a required execution capability; it must not be converted to PASS.

Do not compare providers by aggregate score. This matrix tests GAL behavioral conformance, not general model quality.
