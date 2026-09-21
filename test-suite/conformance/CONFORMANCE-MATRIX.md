# GAL Host Conformance Matrix

| Control | Codex | Kiro | Claude Code | Gemini CLI | Copilot | Cursor |
|---|---|---|---|---|---|---|
| TEST-001 Runtime isolation | PASS | NOT RUN | NOT RUN | NOT RUN | NOT RUN | NOT RUN |
| STATE-002 Host terminology firewall | PASS | NOT RUN | NOT RUN | NOT RUN | NOT RUN | NOT RUN |
| STATE-003 Question persistence | PASS | NOT RUN | NOT RUN | NOT RUN | NOT RUN | NOT RUN |
| STATE-004 Generated views | PASS | NOT RUN | NOT RUN | NOT RUN | NOT RUN | NOT RUN |
| EVID-002 Absence != negative | PASS | NOT RUN | NOT RUN | NOT RUN | NOT RUN | NOT RUN |
| ACTOR-001 Capability evidence | PASS | NOT RUN | NOT RUN | NOT RUN | NOT RUN | NOT RUN |
| VALID-001 Validator claim | PASS | NOT RUN | NOT RUN | NOT RUN | NOT RUN | NOT RUN |
| ExpPay baseline | PASS | NOT RUN | NOT RUN | NOT RUN | NOT RUN | NOT RUN |

Codex completed a blind isolated ExpPay conformance run on 2026-09-21 using the separate `GAL-Codex-Conformance` repository. The isolated runtime contained no ExpPay fixture, expected-results material, or test-suite answer keys. Across GUIDE intake, evidence capture, DRAFT generation, and readiness review, Codex preserved canonical GAL vocabulary, persisted questions in canonical state, did not manually create generated context views when runtime sync was unavailable, preserved absence as UNKNOWN rather than negative evidence, did not invent actor capabilities, and did not claim GAL validation PASS when PowerShell validation could not execute.

The ExpPay baseline also passed: supported approval, receipt, category, reimbursement, resubmission, and submission-window rules were preserved while unresolved rejection authority, late-submission behavior, approval sequencing, QuickBooks retrieval, notification behavior, and payroll integration mechanics remained unresolved. Deterministic PowerShell runtime results remain separate evidence and are not substituted for host-behavior conformance.

The blind run also identified Core hardening opportunities that do not invalidate the Codex host PASS results: phase-sensitive decision-debt blocking, explicit question-to-decision-debt linkage, stronger operational guidance for legitimate DERIVED facts, and evidence-safer wording when a rule is established but its enforcement behavior is unresolved.
