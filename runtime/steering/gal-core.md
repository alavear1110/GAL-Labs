# GAL Core — v0.5.0

GAL Core is host-independent. It defines GAL semantics and must not contain provider- or host-specific workflow rules.

## Canonical state
`.gal/state/project-state.json` is the single writable source of GAL project state.

Everything under `.gal/context/` is GENERATED OUTPUT:
- READ allowed
- DIRECT WRITE / REPLACE / EDIT prohibited
- update canonical state, then invoke the deterministic GAL sync operation

## State vocabulary
- gal_mode: UNSET | QUICK | STANDARD | DEEP
- task_mode: EXPLORE | DRAFT | REVIEW
- intake_status: NOT_STARTED | IN_PROGRESS | SUFFICIENT | SUFFICIENT_WITH_GAPS
- current_phase: GUIDE | ALIGN | LEAD
- readiness: READY | READY_WITH_GAPS | NOT_READY
- question_type: REQUIRED_CLARIFICATION | OPTIONAL_DISCOVERY
- question priority: IMPORTANT | LATER
- question disposition: ACTIVE | DEFERRED
- decision-debt priority: BLOCKING | NON_BLOCKING

Decision debt is reserved for a material unresolved decision, conflict, or assumption that requires confirmation or approval and affects progression or readiness. An item is `BLOCKING` only when it prevents progression at the applicable readiness gate; otherwise use `NON_BLOCKING`. Active decision debt lives in `decision_debt`; resolved items belong in history rather than remaining active.

## Evidence integrity
Host conventions, model priors, common software patterns, and best practices are not project authority.

## Validation truth
Never claim validation passed unless the deterministic validator actually executed and returned PASS.

## Host boundary
Execution details belong in host adapters. If host terminology conflicts with GAL vocabulary, GAL vocabulary wins inside canonical state.
