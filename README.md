# GAL Labs

GAL Labs is the home of the **GAL Method** — a practical framework for improving requirements gathering, evidence discipline, AI-assisted analysis, and review quality.

## What GAL is

GAL stands for **Guide · Align · Lead**.

The method is designed for analysts, developers, product owners, systems analysts, and other practitioners who want to use AI without letting the model quietly invent business rules, implementation details, or authority.

GAL focuses on:
- evidence-backed requirements
- explicit separation of supported, derived, inferred, proposed, unknown, and conflicting information
- decision and question tracking
- readiness gates
- state consistency
- AI-tool steering for tools such as Kiro and similar assistants

## Current release

The current working release is **GAL Runtime v0.4.7**, paired with a **separate GAL Test Suite v0.4.7**.

v0.4.7 introduced two important architecture changes:

1. **Runtime / test separation** — regression fixtures and expected answers are not shipped inside the runtime package.
2. **Generated-view discipline** — `.gal/state/project-state.json` is canonical; generated files under `.gal/context/` must be refreshed through the GAL sync command and not edited directly by the AI.

## Runtime workflow

1. Initialize GAL.
2. Capture project context in canonical state.
3. Persist tracked questions before presenting them.
4. Draft requirements from supplied evidence.
5. Run GAL evidence and provenance gates.
6. Reconcile the actual requirements artifact.
7. Synchronize generated views.
8. Validate state before claiming readiness.

## Evidence model

GAL distinguishes:

- **SUPPORTED** — explicitly established by supplied evidence
- **DERIVED** — logically unavoidable from supported rules
- **INFERRED** — plausible, but not logically necessary
- **PROPOSED** — recommendation or design choice
- **UNKNOWN** — relevant information not yet supplied
- **CONFLICT** — supplied authorities disagree

A core GAL rule is:

> Absence of evidence is not evidence of absence.

## Repository structure

```text
runtime/      GAL runtime package
test-suite/   regression fixtures and expected behavior
docs/         product, architecture, testing, and roadmap documentation
```

## Status

GAL is in active alpha hardening. The current baseline scenario is **ExpPay**, used to exercise evidence classification, state discipline, question persistence, provenance integrity, and readiness behavior.

## Author

**Anthony LaVear**  
GAL Labs
