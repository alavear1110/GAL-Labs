# GAL Roadmap

## Current milestone — v0.5.1 Core Hardening

The isolated Codex ExpPay run completed the v0.5.0 reference-host conformance baseline. v0.5.1 hardens GAL Core from findings observed during that run.

### Core hardening
- phase-sensitive decision-debt blocking by readiness gate
- explicit question-to-decision-debt linkage
- stronger operational guidance for legitimate DERIVED facts
- evidence-safe wording when a rule is established but its enforcement behavior is unresolved

### Validation
- add deterministic regression coverage for stage-specific blocking
- verify a debt item can block development without blocking discovery or stakeholder review
- preserve truthful validator/readiness state transitions

## Following milestones
### v0.5.2
Claude Code adapter and conformance run.

### v0.5.3
Gemini CLI adapter and conformance run.

### v0.5.4
GitHub Copilot and Cursor adapters.

## Runtime portability
PowerShell remains the current deterministic implementation. Cross-platform CLI/script parity is planned after the host contract stabilizes; GAL semantics must not depend on PowerShell.

## Broader alpha
Expand beyond ExpPay into multiple domains only after host-independence behavior is stable.
