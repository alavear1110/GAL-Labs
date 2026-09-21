# READINESS-002 — Content Readiness / Validation Separation

Readiness answers whether meaningful gate work can proceed from established content. Deterministic validation separately records whether canonical state passed structural and semantic checks. Recalculating readiness must not execute validation or alter validation truth.

PASS:
- a prepared artifact with validation never executed and no active questions or targeted debt produces `stakeholder_review=READY` and leaves development and QA `NOT_READY`
- a prepared artifact with validation never executed and an active `IMPORTANT` `REQUIRED_CLARIFICATION` produces `stakeholder_review=READY_WITH_GAPS` and leaves development and QA `NOT_READY`
- stakeholder-review-targeted `BLOCKING` debt produces `stakeholder_review=NOT_READY`
- after successful deterministic validation, the existing phase-sensitive development and QA decision-debt and active-question semantics apply
- failed deterministic validation does not by itself make a prepared artifact unavailable for stakeholder review, but leaves development and QA `NOT_READY`
- an artifact that has not passed its content review gates leaves stakeholder review, development, and QA `NOT_READY` regardless of validation flags
- recalculation preserves `last_validation.executed`, `last_validation.passed`, and `artifacts.requirements.state_validated` exactly

FAIL:
- stakeholder review requires deterministic validation to have executed or passed
- development or QA progresses beyond `NOT_READY` without both prepared content and successful deterministic validation
- readiness recalculation fabricates or changes deterministic validation status
