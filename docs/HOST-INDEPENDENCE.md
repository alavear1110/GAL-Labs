# Host Independence

GAL distinguishes three layers:

1. **GAL Core** — methodology, evidence semantics, lifecycle, readiness, and review gates.
2. **Host Adapter Contract** — the behavioral interface every integration must honor.
3. **Host Adapter** — instructions and capability metadata for a specific AI environment.

A provider and a host are not the same concept. OpenAI may expose multiple hosts; Anthropic, Google, Microsoft, IDE vendors, and others may do the same. GAL therefore models the execution environment as the host and records provider as metadata.

## Reference host
Codex is the primary development/reference host beginning with v0.5.0. It is not the definition of GAL.

## Planned adapters
- Codex
- Kiro
- Claude Code
- Gemini CLI
- GitHub Copilot
- Cursor

Adapters are added only after the contract is stable enough to prevent host behavior from leaking into GAL Core.
