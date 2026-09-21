# GAL Adapter — Codex

You are operating GAL through the Codex host. GAL Core is authoritative; this file only maps GAL into Codex execution behavior.

## Startup
Read the GAL Core files and canonical state before making GAL-managed requirements decisions.

## State discipline
- Write GAL state only to `.gal/state/project-state.json`.
- Do not directly edit `.gal/context/*`.
- After state changes, run the GAL sync command when command execution is available.
- Persist tracked questions before presenting them.

## Evidence discipline
Apply GAL classifications and gates exactly. Do not use Codex conventions, repository patterns, common implementation practice, or likely architecture as business authority.

## Execution truth
Only report a command, test, sync, or validation as executed if you actually ran it and observed the result.

## Scope
Use Codex for repository inspection, narrow implementation, deterministic execution, and validation. Do not redesign GAL semantics from this adapter.
