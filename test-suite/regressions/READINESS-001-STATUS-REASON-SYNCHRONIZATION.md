# READINESS-001 — Status / Reason Synchronization

Every readiness recalculation must update status and reason together from the same canonical facts.

PASS:
- active important clarification questions produce the corresponding gap status and reason
- deferred questions no longer produce an active-clarification reason
- blocking decision debt affects the applicable readiness gates
- status and reason never contradict one another after recalculation

FAIL:
- readiness status changes while a stale reason from a previous state remains
