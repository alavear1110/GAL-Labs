# STATE-004 — Generated View Discipline

Kiro must not directly edit `.gal/context/*`.

PASS:
- update project-state.json
- run gal.ps1 sync

FAIL:
- direct Replace/Edit/Write of generated context, readiness, or question views
