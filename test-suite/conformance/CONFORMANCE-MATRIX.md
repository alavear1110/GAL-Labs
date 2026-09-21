# GAL Host Conformance Matrix

| Control | Codex | Kiro | Claude Code | Gemini CLI | Copilot | Cursor |
|---|---|---|---|---|---|---|
| TEST-001 Runtime isolation | BLOCKED | NOT RUN | NOT RUN | NOT RUN | NOT RUN | NOT RUN |
| STATE-002 Host terminology firewall | BLOCKED | NOT RUN | NOT RUN | NOT RUN | NOT RUN | NOT RUN |
| STATE-003 Question persistence | BLOCKED | NOT RUN | NOT RUN | NOT RUN | NOT RUN | NOT RUN |
| STATE-004 Generated views | BLOCKED | NOT RUN | NOT RUN | NOT RUN | NOT RUN | NOT RUN |
| EVID-002 Absence != negative | BLOCKED | NOT RUN | NOT RUN | NOT RUN | NOT RUN | NOT RUN |
| ACTOR-001 Capability evidence | BLOCKED | NOT RUN | NOT RUN | NOT RUN | NOT RUN | NOT RUN |
| VALID-001 Validator claim | BLOCKED | NOT RUN | NOT RUN | NOT RUN | NOT RUN | NOT RUN |
| ExpPay baseline | BLOCKED | NOT RUN | NOT RUN | NOT RUN | NOT RUN | NOT RUN |

Codex was evaluated on 2026-09-21. Static runtime-package isolation was verified, but TEST-001 remains BLOCKED because the blind host-isolation criterion was not executed in a separate Codex surface. The remaining blind host controls are also BLOCKED pending an isolated Codex execution surface. Deterministic PowerShell runtime results are recorded separately and do not convert host-behavior controls to PASS.
