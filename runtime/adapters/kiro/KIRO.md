# GAL Adapter — Kiro

Kiro is a GAL host. GAL Core and the Host Adapter Contract are authoritative.

## Startup
Before applying these adapter rules, read `runtime/steering/gal-core.md`, `runtime/steering/gal-intake.md`, `runtime/steering/gal-requirements.md`, and `runtime/steering/gal-review.md` (or the corresponding `steering/` paths in an installed runtime project). GAL Core remains authoritative.

## State discipline
- write GAL state only to `.gal/state/project-state.json`
- never directly edit `.gal/context/*`
- persist tracked questions before presentation
- refresh generated views through the GAL runtime

## Terminology firewall
Kiro-native terms such as REQUIREMENTS_FIRST, REQUIREMENTS, COMPLETE, and EVIDENCE_VALIDATED must never enter GAL canonical enum fields unless they are valid GAL values.

## Evidence discipline
Kiro conventions, spec workflows, templates, or common practices are not business evidence. Apply GAL evidence/provenance rules exactly.

## Execution truth
Do not report sync, validation, or other commands as successful unless they actually executed successfully.

## Security
Never automatically use `-ExecutionPolicy Bypass`, `Set-ExecutionPolicy`, or `Unblock-File`.
