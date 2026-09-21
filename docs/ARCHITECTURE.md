# GAL Runtime Architecture

## Layers

```text
User / Project Evidence
         |
         v
      GAL Core
         |
         v
Host Adapter Contract
         |
   Host Adapter
         |
         v
AI execution environment
         |
         v
.gal/state/project-state.json
         |
      GAL runtime
         |
         v
.gal/context/* generated views
```

### GAL Core
Owns methodology: evidence semantics, intake, requirements discipline, review gates, question lifecycle, readiness, and canonical vocabulary.

### Host Adapter Contract
Defines what an integration must preserve and how missing host capabilities are reported.

### Host Adapter
Maps a specific execution environment to GAL without changing GAL semantics.
Host-native discovery may use a thin repository-level loader. The canonical adapter remains under `runtime/adapters/`; loaders must point to it and GAL Core rather than duplicate methodology.

### Deterministic runtime
Owns state initialization, generated-view synchronization, readiness calculation, and validation.

## Canonical state
`.gal/state/project-state.json` is the single writable source of GAL project state. `.gal/context/*` is generated/read-only to AI.

## Host vs provider
GAL models the execution environment as the **host** and records the underlying company as **provider** metadata. This avoids coupling GAL to vendor product structures.

## Runtime vs Test Suite
Regression fixtures and expected results remain outside the runtime package during blind conformance testing.
