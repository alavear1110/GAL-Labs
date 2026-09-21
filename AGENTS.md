# GAL Adapter Loader — Codex

This repository uses GAL. Before performing GAL-managed requirements work:

1. Read `runtime/steering/gal-core.md`, `runtime/steering/gal-intake.md`,
   `runtime/steering/gal-requirements.md`, and `runtime/steering/gal-review.md`
   (or the corresponding `steering/` paths when the runtime contents are
   installed directly at the project root).
2. Read and apply the canonical Codex adapter at
   `runtime/adapters/codex/AGENTS.md` (or `adapters/codex/AGENTS.md` in an
   installed runtime project).
3. Treat GAL Core as authoritative. This loader only makes the adapter
   discoverable from the repository root; it does not define GAL semantics.
