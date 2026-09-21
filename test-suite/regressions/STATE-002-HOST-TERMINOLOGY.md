# STATE-002 — Host Terminology Firewall

Host-native workflow terms must not leak into GAL canonical state unless the value is also valid GAL vocabulary.

PASS:
- canonical enum fields contain only values defined by GAL Core and the canonical state schema
- host-native states, phases, labels, or completion terms remain adapter-local
- adapters translate host behavior into GAL vocabulary without redefining GAL semantics

FAIL:
- host-native terms such as `REQUIREMENTS_FIRST`, `REQUIREMENTS`, `COMPLETE`, or `EVIDENCE_VALIDATED` are written into GAL canonical enum fields when they are not valid GAL values
- a host adapter extends or replaces GAL vocabulary without a GAL Core contract change
