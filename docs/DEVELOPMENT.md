# Development Workflow

## Current workflow
GAL development is regression-driven.

1. Reproduce behavior using an external test fixture.
2. Identify the smallest control failure.
3. Update runtime steering/state logic.
4. Re-run the same regression.
5. Promote a generic failure into a named regression case.

## Current baseline
ExpPay is the baseline scenario.

## Runtime/test separation
Do not place `test-suite/` inside the runtime project during blind tests.

## Change discipline
Prefer narrow changes. Avoid redesigning unrelated GAL concepts while correcting a single regression.
