# GAL Runtime v0.5.0

This directory contains the production-style GAL runtime.

## Runtime rules

- `.gal/state/project-state.json` is canonical.
- `.gal/context/*` is generated output.
- Generated views must only be refreshed through `gal.ps1 sync`.
- Runtime contains no regression fixtures or answer keys.
- State validation must execute before GAL claims validation success.

See the root documentation for the GAL evidence model and architecture.
