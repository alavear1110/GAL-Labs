<!-- shared-agent-context:v1:start -->
## Shared repository context (all agents)

When `docs/agent-context/README.md` exists, before planning or editing read
these repository-root paths in order:
`AGENTS.md`, `docs/agent-context/README.md`, `docs/agent-context/PROJECT.md`,
`docs/agent-context/STATUS.md`, and `docs/agent-context/DECISIONS.md`.
Follow existing project instructions below and any narrower instructions for the
files you touch. Preserve linked runtime/governance loaders and their authority.

Reload this context after every pull, checkout, branch switch, merge, rebase,
other HEAD change, or change to these files. Compare the status snapshot with
current code before continuing from earlier assumptions. After substantive work,
update the status and any confirmed durable decisions as the shared protocol
requires. Use the marketing name in PROJECT.md for current product copy.

All paths above are relative to the repository root. If already reading
AGENTS.md, continue with the next file; do not recursively load this block.
If the context directory is absent, follow the existing repository/runtime
instructions below and report the missing context for a full repository checkout.
Packaged runtime distributions may intentionally omit repository-only context.
<!-- shared-agent-context:v1:end -->

# GAL Repository Loader

This repository uses GAL. Before performing GAL-managed requirements work:

1. Read `runtime/steering/gal-core.md`, `runtime/steering/gal-intake.md`,
   `runtime/steering/gal-requirements.md`, and `runtime/steering/gal-review.md`
   (or the corresponding `steering/` paths when the runtime contents are
   installed directly at the project root).
2. Read and apply the canonical adapter for the active host when present:
   - Codex: `runtime/adapters/codex/AGENTS.md`.
   - Kiro: `runtime/adapters/kiro/KIRO.md`.
   Use the corresponding `adapters/` paths in an installed runtime project.
   If the active host has no canonical adapter, read
   `runtime/contracts/HOST-ADAPTER-CONTRACT.md` (or `contracts/` in an
   installed runtime project), preserve GAL Core, and report the adapter
   limitation. Repository-context entrypoints do not implement or certify
   additional GAL host adapters.
3. Treat GAL Core as authoritative. This loader only makes Core and canonical
   adapters discoverable from the repository root; it does not define GAL
   semantics. Adapter presence does not establish observed conformance.
