# GAL Runtime Architecture

## Principle

GAL uses a **single canonical state model**.

```text
AI / Host Tool
      |
      v
.gal/state/project-state.json
      |
      v
   gal.ps1 sync
      |
      +--> .gal/context/context.md
      +--> .gal/context/open-questions.md
      +--> .gal/context/readiness.md
```

Generated files under `.gal/context/` are derived views and must not be edited directly by the AI.

## Runtime vs Test Suite

As of v0.4.7, GAL is split into two packages:

### Runtime
Contains:
- steering
- canonical-state templates
- Kiro adapter
- PowerShell runtime
- runtime documentation
- schema

### Test Suite
Contains:
- ExpPay regression fixture
- named regression cases
- expected results
- testing instructions

The test suite must remain outside the runtime project during blind regression testing.

## State vocabulary

### GAL mode
- UNSET
- QUICK
- STANDARD
- DEEP

### Task mode
- EXPLORE
- DRAFT
- REVIEW

### Intake status
- NOT_STARTED
- IN_PROGRESS
- SUFFICIENT
- SUFFICIENT_WITH_GAPS

### Phase
- GUIDE
- ALIGN
- LEAD

### Readiness
- READY
- READY_WITH_GAPS
- NOT_READY

Host-specific terms must be mapped into GAL semantics instead of being written directly into canonical state.
