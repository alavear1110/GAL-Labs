# Claude Code Conformance — v0.5.2

Claude Code must be evaluated as a GAL host under the existing Host Adapter Contract v1.0. The adapter does not receive expected answers during a blind run.

## Isolation
Stage only the GAL runtime and the Claude Code adapter/instruction entrypoint needed by the host. Do not expose `test-suite/`, regression answer keys, prior conformance outcomes, or expected ExpPay classifications to the host under test.

## Mandatory controls
Run the controls defined by `HOST-CONFORMANCE-v1.0.md`:
- TEST-001 Runtime isolation
- STATE-002 Host terminology firewall
- STATE-003 Question persistence
- STATE-004 Generated-view discipline
- EVID-002 Absence is not negative evidence
- ACTOR-001 Actor capability evidence
- VALID-001 Validator-before-claim
- ExpPay end-to-end baseline

## v0.5.1 observations to preserve
The run should additionally be inspected for the hardened Core behaviors now relevant to host execution:
- phase-sensitive decision debt
- question-to-decision-debt linkage
- narrow use of DERIVED under the Derived Necessity Test
- evidence-safe distinction between a supported policy and unknown enforcement behavior
- progression materiality and scope integrity
- stakeholder content readiness remaining distinct from deterministic validation truth
- runtime/config/state version coherence

These are observations of Core behavior, not provider-specific scoring criteria.

## Recording
Record each mandatory host control as PASS, FAIL, or BLOCKED based only on observed behavior. A missing or unavailable execution capability is BLOCKED, never PASS.

Record unexpected host behavior separately from GAL Core defects. Do not change GAL Core merely to accommodate a host convention.

## ExpPay
Use the standardized external ExpPay scenario without exposing the expected classification notes. Preserve the same scenario across hosts so differences are attributable to observed host behavior rather than a changed test.
