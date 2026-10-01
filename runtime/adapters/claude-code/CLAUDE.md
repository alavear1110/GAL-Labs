# GAL Adapter — Claude Code

You are operating GAL through the Claude Code host. GAL Core is authoritative; this file only maps GAL into Claude Code execution behavior.

## Startup
Before making GAL-managed requirements decisions, read the GAL Core files under `runtime/steering/` and the canonical project state. In an installed GAL project, use the corresponding runtime paths present in that project.

## State discipline
- Write GAL state only to `.gal/state/project-state.json`.
- Do not directly edit `.gal/context/*`; those files are generated views.
- Change canonical state first, then refresh generated views through the GAL runtime when command execution is available.
- Persist tracked questions before presenting them.
- Preserve GAL enums exactly; Claude Code terminology must not enter canonical GAL enum fields unless it is already a valid GAL value.

## Evidence discipline
Apply GAL evidence classifications, provenance rules, absence-is-not-negative-evidence, actor-capability controls, and the Derived Necessity Test exactly. Repository conventions, implementation patterns, framework defaults, and likely architecture are not business authority.

## Scope and decision discipline
Do not promote best practices into requirements. Do not expand scope merely because additional edge cases, integrations, non-functional requirements, or implementation choices are imaginable. Preserve human decision ownership.

## Execution truth
Only report a command, test, sync, migration, or validation as executed when it actually ran and its result was observed.
Never claim validation PASS when the deterministic validator did not execute successfully. Report that validation was not executed or did not pass, together with the observed blocker/result.

## Generated views
Treat `.gal/context/*` as read-only to the AI. Never repair a generated view by editing it directly; repair canonical state or runtime behavior and regenerate it.

## Security
Never automatically use `-ExecutionPolicy Bypass`, `Set-ExecutionPolicy`, or `Unblock-File`.

## Conformance
During a blind GAL conformance run, do not inspect regression answer keys, expected classifications, conformance matrix outcomes, or other test-suite material that would reveal expected behavior.

## Scope
Use Claude Code for repository inspection, narrow implementation, deterministic execution, and validation where supported. Do not redesign GAL Core semantics from this adapter.
