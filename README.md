# GAL Labs

GAL Labs is the home of the **GAL Method** — **Guide · Align · Lead** — a host-independent framework for improving requirements gathering, evidence discipline, AI-assisted analysis, and review quality.

GAL Core defines the method. AI products integrate through a **Host Adapter Contract**, so the method is not tied to one provider or IDE.

## Core goals
- evidence-backed requirements
- explicit SUPPORTED / DERIVED / INFERRED / PROPOSED / UNKNOWN / CONFLICT classifications
- human decision ownership
- question and decision-debt discipline
- canonical project state
- readiness gates
- provider/host independence

## Current development milestone
**v0.5.2 — Claude Code Adapter & Conformance**

GAL Core v0.5.1 is the current hardened runtime baseline. Codex remains the reference development host; Kiro remains supported through an adapter. v0.5.2 targets a Claude Code adapter under the same Host Adapter Contract and conformance controls. The current repository contains canonical Codex and Kiro adapters; Claude Code remains milestone work. No host defines GAL semantics; GAL Core does.

Architecture:

```text
GAL Core
   |
Host Adapter Contract
   |
   +-- Codex
   +-- Kiro
   +-- Claude Code       (v0.5.2 target)
   +-- Gemini CLI        (planned)
   +-- GitHub Copilot    (planned)
   +-- Cursor            (planned)
```

See `docs/HOST-INDEPENDENCE.md` and `runtime/contracts/HOST-ADAPTER-CONTRACT.md`.

The repository-root `AGENTS.md` is a thin loader for GAL Core and the canonical adapter matching the active host. Canonical adapter sources remain under `runtime/adapters/`; repository-context entrypoints do not duplicate GAL Core or establish new host support.

## Runtime discipline
`.gal/state/project-state.json` is canonical GAL state. Files under `.gal/context/*` are generated views and must not be directly edited by the AI.

## Testing
The regression/test suite remains physically separate from runtime behavior. Host adapters are evaluated against the same conformance controls rather than being given provider-specific expected answers.

## Status
GAL is in active alpha hardening.

## Author
**Anthony LaVear**  
GAL Labs

<!-- shared-agent-context-readme:v1:start -->
## Agent context

All agents start with [AGENTS.md](AGENTS.md) and the matching
[provider-neutral context protocol](docs/agent-context/README.md).
Read the project, status, and decision files there before work and reload them
after every pull or branch/HEAD change. Update the handoff after substantive work.
Thin discovery files for common tools point to the same context; no chat history
or provider account memory is required.
<!-- shared-agent-context-readme:v1:end -->
