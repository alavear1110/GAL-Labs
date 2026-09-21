# GAL Host Conformance Matrix

| Control | Codex | Kiro | Claude Code | Gemini CLI | Copilot | Cursor |
|---|---|---|---|---|---|---|
| TEST-001 Runtime isolation | PASS | NOT RUN | NOT RUN | NOT RUN | NOT RUN | NOT RUN |
| STATE-003 Question persistence | BLOCKED | NOT RUN | NOT RUN | NOT RUN | NOT RUN | NOT RUN |
| STATE-004 Generated views | BLOCKED | NOT RUN | NOT RUN | NOT RUN | NOT RUN | NOT RUN |
| EVID-002 Absence != negative | BLOCKED | NOT RUN | NOT RUN | NOT RUN | NOT RUN | NOT RUN |
| ACTOR-001 Capability evidence | BLOCKED | NOT RUN | NOT RUN | NOT RUN | NOT RUN | NOT RUN |
| VALID-001 Validator claim | BLOCKED | NOT RUN | NOT RUN | NOT RUN | NOT RUN | NOT RUN |
| ExpPay baseline | BLOCKED | NOT RUN | NOT RUN | NOT RUN | NOT RUN | NOT RUN |

Codex was evaluated on 2026-09-21 on Linux 6.18.44 with Git 2.43.0. TEST-001 remained PASS after copying only `runtime/` to `/tmp/gal-codex-v050.NLC0vW` and confirming that no `expected-results/`, `test-suite/`, `regressions/`, or `fixtures/` content was present. `pwsh --version` returned `command not found`; per the test protocol, no runtime commands or regression scenarios were executed. STATE-003, STATE-004, EVID-002, ACTOR-001, VALID-001, and the blind ExpPay baseline therefore remain BLOCKED, with no BLOCKED result treated as PASS. The checkout started clean at `7a1803f3317a0345fdc4b9704e72bcb00d426319`; fetching and pushing the requested remote branch were blocked by an HTTP 403 CONNECT tunnel restriction.
