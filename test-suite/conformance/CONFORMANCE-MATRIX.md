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

Codex was evaluated on 2026-09-21. TEST-001 passed by inspecting the isolated runtime package. The remaining controls were blocked because neither PowerShell nor a separate Codex execution surface was available, so the deterministic runtime and blind host scenario could not execute. No blocked control is treated as a pass.
