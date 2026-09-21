# GAL Intake — v0.5.0

Persist every tracked question in canonical state before presenting it.

Use:
- question_type
- priority
- status = OPEN
- disposition = ACTIVE | DEFERRED

Never edit `.gal/context/*` directly.

After state changes:
1. update `.gal/state/project-state.json`
2. invoke the deterministic GAL `sync` operation through the host adapter
3. read generated views if verification is needed
