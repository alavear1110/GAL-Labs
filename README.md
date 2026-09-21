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
**v0.5.0 — Host Independence**

Codex is the primary reference host for development beginning with v0.5.0. Kiro remains supported through an adapter. Codex does not define GAL semantics; GAL Core does.

Architecture:

```text
GAL Core
   |
Host Adapter Contract
   |
   +-- Codex
   +-- Kiro
   +-- Claude Code       (planned)
   +-- Gemini CLI        (planned)
   +-- GitHub Copilot    (planned)
   +-- Cursor            (planned)
```

See `docs/HOST-INDEPENDENCE.md` and `runtime/contracts/HOST-ADAPTER-CONTRACT.md`.

Codex discovers the repository-root `AGENTS.md`, which is a thin loader for the canonical adapter source at `runtime/adapters/codex/AGENTS.md`. The loader does not duplicate or redefine GAL Core.

## Runtime discipline
`.gal/state/project-state.json` is canonical GAL state. Files under `.gal/context/*` are generated views and must not be directly edited by the AI.

## Testing
The regression/test suite remains physically separate from runtime behavior. Host adapters are evaluated against the same conformance controls rather than being given provider-specific expected answers.

## Status
GAL is in active alpha hardening.

## Author
**Anthony LaVear**  
GAL Labs
