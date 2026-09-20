# GAL Core Steering — v0.4.7

## Runtime Isolation & Generated-View Discipline

This runtime package contains no regression fixtures or expected answers.

`.gal/state/project-state.json` is the single writable source of GAL project state.

Everything under `.gal/context/` is GENERATED OUTPUT.

- READ allowed.
- DIRECT WRITE / REPLACE / EDIT prohibited.
- Update canonical state, then run `gal.ps1 sync`.

Generated files must begin:

> GENERATED FILE — DO NOT EDIT DIRECTLY
> Source: .gal/state/project-state.json

## Valid state values

- gal_mode: UNSET | QUICK | STANDARD | DEEP
- task_mode: EXPLORE | DRAFT | REVIEW
- intake_status: NOT_STARTED | IN_PROGRESS | SUFFICIENT | SUFFICIENT_WITH_GAPS
- current_phase: GUIDE | ALIGN | LEAD
- readiness: READY | READY_WITH_GAPS | NOT_READY

Never claim validation passed unless `validate-state` actually executed and returned PASS.
