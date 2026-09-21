# GAL Runtime v0.5.1

This directory contains the production-style GAL runtime.

## Runtime rules

- `.gal/state/project-state.json` is canonical.
- `.gal/context/*` is generated output.
- Generated views must only be refreshed through `gal.ps1 sync`.
- Runtime contains no regression fixtures or answer keys.
- State validation must execute before GAL claims validation success.

See the root documentation for the GAL evidence model and architecture.

## Migrating state from v0.5.0

Migration is explicit: run `gal.ps1 migrate` from an initialized project. The
runtime supports only the v0.5.0 to v0.5.1 transition; `init`, validation,
status, sync, and readiness recalculation never migrate state implicitly.

The command applies only safe mechanical changes. It updates the state and
config versions, records an unknown question relationship as
`source_question_id: null`, and gives legacy `NON_BLOCKING` decision debt an
empty `blocks` list. Legacy `BLOCKING` debt without `blocks` requires semantic
reconciliation: assign its actual v0.5.1 readiness gates before retrying,
because migration will not guess them.

Before replacement, the original files are preserved as
`.gal/state/project-state.v0.5.0.backup.json` and
`.gal/state/config.v0.5.0.backup.json`. Existing backups are never overwritten.
If post-write validation or context synchronization fails, the originals are
restored from those backups.
