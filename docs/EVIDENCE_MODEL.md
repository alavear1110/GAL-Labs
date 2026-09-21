# GAL Evidence Model

## Classifications

### SUPPORTED
Explicitly established by supplied project evidence.

### DERIVED
Logically unavoidable if a supported rule is to be evaluated or satisfied.

GAL applies the **Derived Necessity Test**:

> Could the supported requirement be satisfied without this exact proposition being true?

If yes, the proposition is not DERIVED.

### INFERRED
Plausible, but not logically necessary.

### PROPOSED
A recommendation, best practice, or design choice.

### UNKNOWN
Relevant information has not been supplied.

### CONFLICT
Supplied authorities disagree.

## Core integrity rules

### Best practice is not authority
Typical software behavior is not automatically a requirement.

### Absence is not negative evidence
“I have not defined category limits” does not mean “no category limits apply.”

### Outcome before mechanism
“Reimbursed through payroll” does not automatically mean “ExpPay directly integrates with payroll.”

### Actor capability requires evidence
“Manager approves” does not automatically mean “Manager rejects.”

### Provenance integrity
GAL must never claim “user stated” or equivalent unless the supplied evidence actually supports that exact proposition.
