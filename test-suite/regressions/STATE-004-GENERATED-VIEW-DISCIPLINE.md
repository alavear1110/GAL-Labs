# STATE-004 — Generated View Discipline

The host must not directly edit `.gal/context/*`.

PASS:
- update project-state.json
- run gal.ps1 sync

FAIL:
- direct Replace/Edit/Write of generated context, readiness, or question views
