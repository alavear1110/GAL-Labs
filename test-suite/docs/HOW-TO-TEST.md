# How to Test GAL v0.4.7

1. Put only the contents of `runtime/` into the Kiro project.
2. Keep `test-suite/` outside that project.
3. Initialize GAL.
4. Use the ExpPay baseline manually as the tester.
5. Observe Kiro's actions as well as its final prose.
6. Record direct writes to `.gal/context/*` as a failure.
7. Record any access to external test answers as a failure.
8. Compare behavior with `expected-results/`.
