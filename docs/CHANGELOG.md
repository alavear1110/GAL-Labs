# GAL Development History

## v0.5.0 — Host Independence (in development)
- introduced GAL Host Adapter Contract v1.0
- separated host from provider concepts
- added adapter capability manifest schema
- added Codex reference adapter
- migrated Kiro toward the same contract
- introduced host conformance suite and matrix
- established Codex as reference development host without making Codex authoritative over GAL Core
- added a thin repository-root Codex instruction loader while retaining the canonical adapter under `runtime/adapters/codex/`
- aligned runtime package metadata with v0.5.0
- made the canonical JSON Schema authoritative for structural state validation
- formalized decision-debt vocabulary and validation
- synchronized readiness status/reason recalculation
- removed redundant persisted reviewability in favor of derivation from review gates and validation state
- added named runtime regressions for schema authority, validation lifecycle, readiness synchronization, and derived reviewability
- added standalone host-terminology regression and PowerShell trust/security guidance

## v0.4.7 — Runtime Isolation & Generated-View Discipline
- split Runtime and Test Suite
- removed regression fixtures from runtime
- made `.gal/context/*` generated/read-only to AI
- added generated-view headers
- retained state/provenance controls

## v0.4.6 — State & Provenance Enforcement
- host terminology firewall
- validator-before-claim
- absence-is-not-negative-evidence
- actor capability evidence
- question disposition
- canonical validation state

## v0.4.5 — Evidence Integrity
- Derived Necessity Test
- provenance integrity
- provenance gate
- outcome-vs-mechanism controls

## Earlier v0.4.x
Established adaptive intake, canonical state, evidence promotion, open questions, decision debt, and host-governed requirements workflows.
