# GAL Roadmap

## Completed — v0.5.1 Core Hardening

v0.5.1 incorporated findings from the isolated Codex ExpPay reference-host run and focused regressions into GAL Core.

Completed hardening includes:
- phase-sensitive decision-debt blocking by readiness gate
- explicit question-to-decision-debt linkage and referential integrity
- operational DERIVED guidance and evidence-safe enforcement wording
- progression-materiality and scope-integrity discipline
- runtime/config/state version coherence
- explicit fail-closed v0.5.0 to v0.5.1 migration
- stakeholder content readiness separated from deterministic validation
- deterministic regression coverage for the new runtime contracts

## Current milestone — v0.5.2 Claude Code Adapter

### Adapter
- define the Claude Code host manifest under the existing Host Adapter Contract v1.0
- add the smallest host-native instruction entrypoint needed to load GAL Core
- preserve GAL canonical state, generated-view discipline, evidence semantics, and execution truth
- document any real Claude Code capability limitations without changing GAL semantics

### Conformance
- stage a runtime-only isolated Claude Code conformance environment
- run the same mandatory host-behavior controls used for the reference-host baseline
- run ExpPay blind without exposing regression answer keys
- record PASS / FAIL / BLOCKED based on observed behavior
- feed genuine host-independent findings back into GAL Core only when evidence justifies a Core change

## Following milestones
### v0.5.3
Gemini CLI adapter and conformance run.

### v0.5.4
GitHub Copilot and Cursor adapters.

## Runtime portability
PowerShell 7+ remains the current deterministic implementation. Cross-platform CLI/script parity is planned after the host contract stabilizes; GAL semantics must not depend on PowerShell.

## Broader alpha
Expand beyond ExpPay into multiple domains only after host-independence behavior is stable.
