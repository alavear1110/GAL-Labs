# ExpPay — Requirements Analysis

## Purpose and scope

ExpPay will add expense submission to the existing employee portal, route expenses for the stated approvals, and support Finance reimbursement or corporate-card settlement. This analysis preserves stakeholder statements as the only project evidence supplied for this exercise. It does not prescribe an implementation architecture or a specific corporate-card vendor.

## Evidence basis

**E-001 — Stakeholder opening statement:** Employees submit expenses in the existing employee portal; managers approve them; Finance handles reimbursement; project name is ExpPay.

**E-002 — Stakeholder follow-up answers:** The ten supplied statements covering approval thresholds, QuickBooks categories, receipts, payment destinations, payroll timing, rejection/resubmission, and the 60-day submission limit.

No system documentation, policy text, QuickBooks category list, payroll calendar/cutoff rules, organization hierarchy rules, or interface specifications were supplied.

## Actors and supported capabilities

| ID | Actor | Capability | Classification | Evidence |
|---|---|---|---|---|
| ACT-01 | Employee | Submit an expense in the existing employee portal. | SUPPORTED | E-001 |
| ACT-02 | Employee | Revise and resubmit a rejected expense. | SUPPORTED | E-002 |
| ACT-03 | Direct manager | Approve expenses when the applicable rules require direct-manager approval. | SUPPORTED | E-001, E-002 |
| ACT-04 | Next-level manager | Approve expenses of $101 or more. | SUPPORTED | E-002 |
| ACT-05 | Finance | Handle reimbursement and use QuickBooks expense types for tax reporting. | SUPPORTED | E-001, E-002 |
| ACT-06 | Existing employee portal | Provide the employee-facing place for expense submission. | SUPPORTED | E-001 |

Capabilities not explicitly supported—such as an employee viewing status, an approver delegating authority, Finance editing an expense, or systems automatically importing card transactions—remain UNKNOWN rather than assumed.

## Functional and business requirements

| ID | Requirement | Classification | Evidence / derivation |
|---|---|---|---|
| FR-01 | ExpPay shall allow an employee to submit an expense through the existing employee portal. | SUPPORTED | E-001 |
| FR-02 | ExpPay shall identify whether an expense was paid using a corporate card and shall capture an amount sufficient to apply the approval and receipt rules. | DERIVED | These data are logically necessary to apply the explicitly supported rules in FR-05 through FR-09. |
| FR-03 | ExpPay shall assign expense categories that mirror the QuickBooks expense types used by Finance for tax reporting. | SUPPORTED | E-002 |
| FR-04 | ExpPay shall not apply additional category-specific limits unless a later approved rule defines them. | SUPPORTED | E-002 states that no additional category-specific limits have been defined. |
| FR-05 | A corporate-card expense of $25 or less shall be automatically approved. | SUPPORTED | E-002 |
| FR-06 | A corporate-card expense from $26 through $100 shall require approval by the employee's direct manager. | SUPPORTED | E-002 |
| FR-07 | A corporate-card expense of $101 or more shall require approval by both the employee's direct manager and next-level manager. | SUPPORTED | E-002 |
| FR-08 | An expense not paid with a corporate card and under $101 shall require approval by the employee's direct manager. | DERIVED | The supplied rule always requires the direct manager and adds next-level approval at $101 or more; therefore the under-$101 route necessarily contains only the stated direct-manager requirement. |
| FR-09 | An expense not paid with a corporate card and $101 or more shall require approval by both the employee's direct manager and next-level manager. | SUPPORTED | E-002 |
| FR-10 | ExpPay shall require a receipt for an expense of $26 or more. | SUPPORTED | E-002 |
| FR-11 | ExpPay shall permit submission without a receipt for an expense of $25 or less. | DERIVED | The explicit receipt threshold begins at $26; requiring one below that threshold would contradict the stated threshold. |
| FR-12 | Corporate-card expenses shall be paid directly to the card vendor, without making the requirements vendor-specific. | SUPPORTED | E-002 |
| FR-13 | An approved out-of-pocket expense shall be reimbursed through the employee's next scheduled payroll deposit. | SUPPORTED | E-002 |
| FR-14 | When an expense is rejected, ExpPay shall allow the employee to revise and resubmit it. | SUPPORTED | E-002 |
| FR-15 | ExpPay shall enforce that expenses are submitted within 60 days, subject to clarification of the date from which the period is measured and boundary handling. | SUPPORTED with UNKNOWN detail | E-002; Q-001 records the unresolved semantics. |

## Decision tables

### Approval routing

| Payment method | Amount | Required outcome |
|---|---:|---|
| Corporate card | ≤ $25 | Automatic approval |
| Corporate card | $26–$100 | Direct-manager approval |
| Corporate card | ≥ $101 | Direct-manager and next-level-manager approval |
| Not corporate card | < $101 | Direct-manager approval |
| Not corporate card | ≥ $101 | Direct-manager and next-level-manager approval |

The supplied evidence does not define currencies, rounding, negative/zero values, the ordering of two manager approvals, or what happens when a manager is unavailable.

### Receipt requirement

| Amount | Receipt |
|---:|---|
| ≤ $25 | Not required |
| ≥ $26 | Required |

## Lifecycle outcomes

1. An employee submits an expense in the existing portal.
2. ExpPay evaluates the supported receipt and approval rules.
3. The applicable manager approval(s), or automatic approval, produces an approved or rejected outcome.
4. A rejected expense may be revised and resubmitted.
5. Finance handles the resulting payment: corporate-card expenses go directly to the card vendor; approved out-of-pocket expenses go through the employee's next scheduled payroll deposit.

Steps 2–5 describe required business outcomes. They do not assert an integration protocol, notification mechanism, approval sequence, payment initiation mechanism, or lifecycle-state design.

## Unknowns and decision debt

| ID | Topic | Treatment | Readiness impact |
|---|---|---|---|
| Q-001 | Which date starts the 60-day submission period, and is the 60th day inclusive? | REQUIRED_CLARIFICATION, IMPORTANT, ACTIVE; DD-001 BLOCKING | Blocks unambiguous development and boundary test design for FR-15. |
| Q-002 | Which currency governs the dollar thresholds, and how are conversion and rounding handled for other currencies? | REQUIRED_CLARIFICATION, IMPORTANT, ACTIVE; DD-002 BLOCKING | Blocks reliable routing/receipt logic where non-base-currency expenses are possible. |
| Q-003 | Must direct-manager approval precede next-level-manager approval, and what happens after either manager rejects? | REQUIRED_CLARIFICATION, IMPORTANT, ACTIVE; DD-003 BLOCKING | Blocks deterministic two-approver workflow and tests. |
| Q-004 | How are the direct and next-level managers resolved, including vacancies, unavailable managers, and delegation? | REQUIRED_CLARIFICATION, IMPORTANT, ACTIVE; DD-004 BLOCKING | Blocks deterministic approval assignment. |
| Q-005 | What authoritative QuickBooks expense-type list and update process must ExpPay mirror? | REQUIRED_CLARIFICATION, IMPORTANT, ACTIVE; DD-005 BLOCKING | Blocks category configuration and reconciliation. |
| Q-006 | What payroll cutoff/calendar behavior applies when approval occurs near or after a scheduled deposit? | REQUIRED_CLARIFICATION, IMPORTANT, ACTIVE; DD-006 BLOCKING | Blocks deterministic interpretation of “next scheduled payroll deposit.” |
| Q-007 | On resubmission, which prior approvals remain valid, if any? | REQUIRED_CLARIFICATION, IMPORTANT, ACTIVE; DD-007 BLOCKING | Blocks resubmission workflow and test expectations. |
| Q-008 | Which receipt formats and validation criteria are acceptable? | OPTIONAL_DISCOVERY, LATER, DEFERRED | Does not prevent stakeholder review of the business rules; affects detailed implementation/test coverage. |
| Q-009 | What employee/manager/Finance status visibility, notifications, audit retention, and reporting are required? | OPTIONAL_DISCOVERY, LATER, DEFERRED | Candidate later scope; no capability is asserted without evidence. |
| Q-010 | What interfaces connect the portal, organizational hierarchy, QuickBooks-related category source, corporate-card payment process, and payroll? | OPTIONAL_DISCOVERY, LATER, DEFERRED | Architecture/integration discovery remains necessary after business-rule alignment. |

## Evidence and review audit

- **Evidence audit:** Every asserted requirement is tied to E-001/E-002 or explicitly marked DERIVED/UNKNOWN.
- **Derived Necessity Test:** FR-02, FR-08, and FR-11 are limited to facts necessary to apply the supplied rules; likely mechanisms and conveniences were not elevated to requirements.
- **Provenance integrity:** Stakeholder evidence is distinguished from analysis; no repository test material or external description is used as project authority.
- **Absence-vs-negative-evidence audit:** Missing capabilities are UNKNOWN. FR-04 is supported by the explicit statement that no additional category limits have been defined; it is not inferred from silence.
- **Actor capability audit:** Actor capabilities are no broader than the supplied statements.
- **Artifact reconciliation:** Requirement tables, decision tables, lifecycle outcomes, open questions, decision debt, and canonical state use the same thresholds and classifications.
- **Canonical-state consistency:** The artifact path and unresolved items are represented in `.gal/state/project-state.json`.
- **Validator gate:** Not satisfied until the runtime validator executes successfully; state and readiness must not claim otherwise.
