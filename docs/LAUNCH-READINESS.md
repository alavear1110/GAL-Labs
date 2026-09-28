# GAL Launch Readiness

This checklist defines the engineering and packaging gates for the first public GAL alpha. It is not a claim that every future host adapter is complete.

## Release baseline
- [x] GAL Core and canonical state contract established
- [x] Host Adapter Contract v1.0 established
- [x] Runtime/test-suite isolation established
- [x] PowerShell 7+ validation contract established
- [x] Explicit v0.5.0 to v0.5.1 migration implemented
- [x] Codex reference-host blind ExpPay baseline completed
- [ ] Claude Code v0.5.2 blind conformance completed or explicitly deferred from the first alpha
- [ ] Release candidate installed into a clean project from public instructions
- [ ] Clean-project smoke test completes init, sync, status, validation, and readiness recalculation
- [ ] Public package contents reviewed to ensure regression answer keys are not shipped as runtime material

## Public documentation
- [x] Product overview
- [x] Architecture overview
- [x] Installation instructions
- [x] Evidence model
- [x] Security guidance
- [x] Development history / changelog
- [x] Roadmap
- [ ] Quick-start path verified from a clean checkout
- [ ] One public, non-answer-key example demonstrating Guide → Align → Lead
- [ ] Supported-host table reflects observed conformance status rather than planned capability
- [ ] Known alpha limitations are stated explicitly

## Release integrity
- [ ] Runtime version, config template, state template, schema, README, and release notes agree on the release version
- [ ] No development-only fixture or conformance answer key is reachable from the distributable runtime package
- [ ] Migration and backup behavior rechecked from a clean v0.5.0 fixture
- [ ] Generated views confirmed reproducible from canonical state
- [ ] Failed or unavailable validation remains truthfully represented
- [ ] Installation does not require weakening PowerShell security controls

## Commercial / operational launch
These items are intentionally separate from runtime correctness.
- [ ] Decide the first public distribution model: evaluation/source-visible package, paid package, or another explicitly licensed channel
- [ ] Publish a support contact/channel
- [ ] Publish terms appropriate to the chosen distribution model
- [ ] Decide versioning and release-note convention for public downloads
- [ ] Prepare a concise launch page explaining the problem GAL solves, Guide · Align · Lead, supported hosts, and alpha limitations

## Post-launch
The first alpha does not require every planned adapter. Gemini CLI, GitHub Copilot, Cursor, broader domain regressions, and cross-platform runtime parity may remain roadmap work if the release notes state that clearly.
