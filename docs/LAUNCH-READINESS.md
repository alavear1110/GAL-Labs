# GAL Launch Readiness

This checklist defines the engineering and packaging gates for the first public GAL alpha. It is not a claim that every future host adapter is complete.

## Release baseline
- [x] GAL Core and canonical state contract established
- [x] Host Adapter Contract v1.0 established
- [x] Runtime/test-suite isolation established
- [x] PowerShell 7+ validation contract established
- [x] Explicit v0.5.0 to v0.5.1 migration implemented
- [x] Codex reference-host blind ExpPay baseline completed
- [ ] Release candidate installed into a clean project from public instructions
- [ ] Clean-project smoke test completes init, sync, status, validation, and readiness recalculation
- [ ] Public package contains runtime/user material only; internal tests, conformance scenarios, expected answers, and test outputs are absent

## Public documentation
- [x] Product overview
- [x] Architecture overview
- [x] Installation instructions
- [x] Evidence model
- [x] Security guidance
- [x] Development history / changelog
- [x] Roadmap
- [ ] Quick-start path verified from the staged public package
- [ ] One public, non-answer-key example demonstrating Guide → Align → Lead
- [ ] Supported-host table reflects observed conformance status rather than planned capability
- [ ] Known alpha limitations are stated explicitly

## Release integrity
- [ ] Runtime version, config template, state template, schema, README, and release notes agree on the release version
- [ ] No internal test fixture, conformance scenario, expected answer, grading criterion, transcript, or prior host test output is present in the distributable runtime package
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

## Launch gate
The release gate is the public-package boundary plus a successful clean-package smoke test. Internal engineering assets remain in the development repository and are never part of the user deliverable.

## Post-launch
Additional adapters and broader regressions can ship after the first release. A host is advertised as supported only after its own observed conformance is complete.
