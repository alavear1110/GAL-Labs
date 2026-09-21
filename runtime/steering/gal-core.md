# GAL Core — v0.5.1

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
- decision-debt blocks: zero or more readiness gates from discovery | stakeholder_review | development | qa_test_design

Decision debt is reserved for a material unresolved decision, conflict, or assumption that requires confirmation or approval and affects progression or readiness. Blocking is phase-sensitive: an unresolved decision may allow discovery or stakeholder review while preventing development or complete QA test design. Use `priority: BLOCKING` only when at least one readiness gate is named in `blocks`; use `NON_BLOCKING` with an empty `blocks` array when the item currently prevents no readiness gate. Do not mark every unknown as decision debt. Active decision debt lives in `decision_debt`; resolved items belong in history rather than remaining active.

Examples:
- Unknown payroll transfer mechanics may be `BLOCKING` for `development` and `qa_test_design` without blocking discovery.
- An undecided optional description field can remain `NON_BLOCKING` with `blocks: []`.
- If only part of a feature is blocked, readiness text should identify that limitation rather than implying unrelated established work cannot proceed.

## Evidence integrity
Host conventions, model priors, common software patterns, and best practices are not project authority.

## Validation truth
Never claim validation passed unless the deterministic validator actually executed and returned PASS.

## Host boundary
Execution details belong in host adapters. If host terminology conflicts with GAL vocabulary, GAL vocabulary wins inside canonical state.
