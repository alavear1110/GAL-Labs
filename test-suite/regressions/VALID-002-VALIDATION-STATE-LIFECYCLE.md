# VALID-002 — Validation State Lifecycle

Validation metadata must reflect the most recent actual validation result.

PASS:
- valid state records `executed=true`, `passed=true`, no errors, and `state_validated=true`
- invalid state returns a failing exit code and records `passed=false`, a validation error, and `state_validated=false`
- repairing the state and revalidating clears stale errors and restores PASS metadata

FAIL:
- a failed validation leaves stale PASS metadata
- a repaired state retains stale failure metadata after a successful validation
