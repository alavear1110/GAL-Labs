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

Decision debt is reserved for a material unresolved decision, conflict, or assumption that requires confirmation or approval and affects progression or readiness. Blocking is phase-sensitive: an unresolved decision may allow discovery or stakeholder review while preventing development or complete QA test design. Use `priority: BLOCKING` only when at least one readiness gate is named in `blocks`; use `NON_BLOCKING` with an empty `blocks` array when the item currently prevents no readiness gate. Do not mark every unknown as decision debt. Before creating blocking debt, apply the **Progression Materiality Test**: would the unresolved decision prevent meaningful work at the named readiness gate without forcing the team to assume the answer? If useful work can proceed while preserving the unknown, it is not blocking for that gate. Eventual implementation detail is not enough by itself. Narrow the debt to the affected feature or slice; do not let integration mechanics, edge cases, or desirable completeness block unrelated established work. Active decision debt lives in `decision_debt`; resolved items belong in history rather than remaining active.

### Question → decision-debt linkage
When decision debt originates from a tracked clarification question, set `source_question_id` to that question's ID. The question records what needs to be learned or answered; the debt records the unresolved decision's effect on progression. Do not duplicate the question text as a second independent source of truth. Use `source_question_id: null` only when the debt arose from a conflict, assumption, review finding, or other material unresolved decision that did not originate as a tracked question. Resolving the originating question requires the linked active debt to be resolved, replaced, or explicitly retained for a documented remaining decision.

Examples:
- Unknown payroll transfer mechanics may be `BLOCKING` for `development` and `qa_test_design` without blocking discovery.
- An undecided optional description field can remain `NON_BLOCKING` with `blocks: []`.
- If only part of a feature is blocked, readiness text should identify that limitation rather than implying unrelated established work cannot proceed.
- A payment outcome does not make payment initiation, reconciliation, exception handling, or integration mechanics blocking unless those details are necessary for the specific work at that gate.
- Currency, rounding, zero-value, credit, notification, audit-history, and similar edge cases may be useful discovery, but must not be promoted to blocking debt merely because a complete production design will eventually address them.

## Evidence integrity
Host conventions, model priors, common software patterns, and best practices are not project authority.

### Evidence classifications
- `SUPPORTED`: explicitly established by supplied evidence.
- `DERIVED`: logically unavoidable if a supported rule is to be evaluated or satisfied, even though the proposition was not stated verbatim.
- `INFERRED`: plausible from the evidence but not logically necessary.
- `PROPOSED`: a recommendation or design choice.
- `UNKNOWN`: materially relevant information is absent.
- `CONFLICT`: supplied authorities disagree.

### Derived Necessity Test
Before classifying a proposition as `DERIVED`, ask:

> Could the supported requirement be satisfied without this exact proposition being true?

- If **NO**, `DERIVED` is permissible. Record the supported rule that makes the proposition necessary.
- If **YES**, the proposition is not derived. Classify it as `INFERRED`, `PROPOSED`, or `UNKNOWN` as appropriate.

Do not require the source to state a necessary implementation-independent data fact verbatim before using `DERIVED`. For example, a supported rule whose outcome varies by expense amount necessarily requires the amount to be available for evaluation; `expense amount is required for rule evaluation` may therefore be `DERIVED`. The test does **not** authorize inventing UI controls, storage design, integration mechanics, actors, enforcement consequences, or other implementation choices.

### Evidence provenance integrity
Never attribute a proposition to the user, stakeholder, source, or authority unless that exact proposition is present in the supplied evidence. A logically necessary proposition remains `DERIVED`; it does not become `SUPPORTED` merely because its parent rule is supported.

Absence is not negative evidence. Silence, `not defined`, or lack of a supplied rule means the proposition remains unknown; it does not establish that no such rule applies.

### Evidence-safe rule wording
State only the behavior and consequence established by the evidence. A supported business rule establishes the condition that must be evaluated or applied; it does not automatically establish a specific enforcement mechanism or system response.

For example, `expenses must be submitted within 60 days` supports a 60-day submission rule and may require the relevant dates to be available for evaluation. It does **not** by itself support claims that the system rejects, blocks, prevents, warns on, or escalates a late submission. Until evidence establishes that consequence, describe the requirement as `the 60-day rule must be evaluated/applied` and classify any proposed enforcement behavior separately.

Use enforcement verbs such as `reject`, `block`, `prevent`, `disable`, `escalate`, or `auto-approve` only when that exact behavior is supported or when it is explicitly labeled `PROPOSED`. Do not silently convert a policy constraint into a system behavior.

## Scope integrity
Evidence that a solution must remain neutral to a vendor, technology, interface, or implementation choice is a constraint. It does not establish that selecting or designing that item is out of project scope. Add an item to `out_of_scope` only when supplied evidence explicitly excludes it or when a documented project decision does so; otherwise preserve the constraint without inventing a scope boundary.

## Readiness semantics
Readiness describes whether meaningful work can proceed without inventing unresolved decisions.

- `NOT_READY`: the gate itself cannot meaningfully proceed without resolving a blocking condition.
- `READY_WITH_GAPS`: meaningful work at the gate can proceed on established behavior, but some portions remain unresolved and must stay explicitly bounded.
- `READY`: the gate's applicable criteria are satisfied with no material unresolved limitation for that gate.

For `qa_test_design`, phase-targeted decision debt that blocks **complete** test design results in `READY_WITH_GAPS` once the requirements artifact has passed its review/validation gates, because tests for established behavior can still be designed. Use `NOT_READY` for QA only when no meaningful test-design work can proceed without assuming unresolved behavior. Host reasoning must not reinterpret a `qa_test_design` debt target as automatically requiring `NOT_READY`.

## Content readiness and deterministic validation
**Content readiness** asks whether meaningful work at a gate can proceed from established evidence and artifacts without inventing unresolved decisions. **Deterministic validation** asks whether canonical GAL state satisfies deterministic structural and semantic invariants. These are distinct evaluations; they do not give `READY` a second meaning.

Validation status must never be fabricated. Never claim validation passed unless the deterministic validator actually executed and returned PASS. Validation truth remains represented by `last_validation` and `artifacts.requirements.state_validated`.

Lack of executed validation does not by itself make an otherwise prepared artifact unavailable for `stakeholder_review`. Accordingly, `READY` for `stakeholder_review` means that meaningful stakeholder review can proceed; it does **not** mean deterministic validation passed. Development and QA remain validation-gated in v0.5.1.

## Host boundary
Execution details belong in host adapters. If host terminology conflicts with GAL vocabulary, GAL vocabulary wins inside canonical state.
