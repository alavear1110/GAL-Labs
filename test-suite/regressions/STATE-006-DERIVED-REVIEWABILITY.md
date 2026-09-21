# STATE-006 — Derived Reviewability

Artifact reviewability must not be persisted as an independent boolean.

The requirements review gates and current validation state are the authoritative facts. Readiness derives reviewability from those facts.

PASS:
- canonical template and schema contain no `reviewable` field
- validation does not write a `reviewable` field
- readiness uses the underlying artifact gates and latest validation result

FAIL:
- a separate mutable `reviewable` value can disagree with the gates that determine reviewability
