# GAL Roadmap

## Current milestone — v0.5.0 Host Independence

### Architecture
- formal Host Adapter Contract
- host capability manifest/schema
- Codex reference adapter
- Kiro adapter migrated to the same contract
- provider-neutral GAL Core
- host conformance matrix

### Validation
- run ExpPay against Codex
- rerun ExpPay against Kiro
- compare semantic behavior, not model quality
- record PASS / FAIL / BLOCKED per conformance control

Local PowerShell execution now provides deterministic runtime evidence for schema authority, validation lifecycle, readiness synchronization, decision-debt validation, generated-view synchronization, and derived reviewability. The Codex host matrix remains conservative: blind host-behavior controls stay BLOCKED until they are exercised through an isolated Codex execution surface. v0.5.0 is not yet host-conformance-complete.

## Following milestones
### v0.5.1
Claude Code adapter and conformance run.

### v0.5.2
Gemini CLI adapter and conformance run.

### v0.5.3
GitHub Copilot and Cursor adapters.

## Runtime portability
PowerShell remains the current deterministic implementation. Cross-platform CLI/script parity is planned after the host contract stabilizes; GAL semantics must not depend on PowerShell.

## Broader alpha
Expand beyond ExpPay into multiple domains only after host-independence behavior is stable.
