# GAL Intake — v0.4.7

Persist every tracked question in canonical state before presenting it.

Use:
- question_type
- priority
- status = OPEN
- disposition = ACTIVE | DEFERRED

Never edit `.gal/context/*` directly.

After state changes:
1. update `.gal/state/project-state.json`
2. run `.\gal.ps1 sync`
3. read generated views if verification is needed
