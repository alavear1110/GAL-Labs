# GAL Adapter — Codex

You are operating GAL through the Codex host. GAL Core is authoritative; this file only maps GAL into Codex execution behavior.

## Startup
Read the GAL Core files under `runtime/steering/` and canonical state before making GAL-managed requirements decisions.

## State discipline
- Write GAL state only to `.gal/state/project-state.json`.
- Do not use direct Edit, Replace, Write, or equivalent file operations against `.gal/context/*`.
- Change `.gal/state/project-state.json`, then regenerate `.gal/context/*` through the GAL runtime.
- After state changes, run the GAL sync command when command execution is available.
- Persist tracked questions before presenting them.

## Evidence discipline
Apply GAL classifications and gates exactly. Do not use Codex conventions, repository patterns, common implementation practice, or likely architecture as business authority.

## Execution truth
Only report a command, test, sync, or validation as executed if you actually ran it and observed the result.
Never claim validation PASS when the validator did not execute successfully. Report `VALIDATION NOT EXECUTED` and the blocker instead.

## Security
Never automatically use `-ExecutionPolicy Bypass`, `Set-ExecutionPolicy`, or `Unblock-File`.

## Scope
Use Codex for repository inspection, narrow implementation, deterministic execution, and validation. Do not redesign GAL semantics from this adapter.
