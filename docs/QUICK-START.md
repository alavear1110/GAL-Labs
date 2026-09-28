# GAL Quick Start

GAL is an AI-assisted requirements method built around **Guide · Align · Lead**. The runtime keeps evidence, questions, decisions, and readiness explicit while the human remains the decision-maker.

## 1. Prerequisite
Install PowerShell 7 or later and use an AI host included with your GAL package.

## 2. Add GAL to a project
Copy the contents of the `gal-runtime` package into the root of the project where you want to use GAL.

The package already includes the host loader for each host advertised by that package.

## 3. Initialize
From the project root:

```powershell
./gal.ps1 init
```

GAL creates `.gal/state/project-state.json` as canonical project state and generates read-only context views under `.gal/context/`.

## 4. Start GAL
Open your supported AI host in the project and say:

> Start GAL

GAL should begin adaptive intake rather than inventing a full specification. Answer what you know. Unknowns may remain unknown when they do not prevent useful work.

## 5. Continue the work
Useful prompts include:

> Continue GAL.

> Draft what is safe from what we know.

> Review the requirements with GAL.

> Show me the open questions and decision debt.

The host should preserve GAL's evidence classifications and human decision ownership.

## 6. Deterministic commands
```powershell
./gal.ps1 status
./gal.ps1 sync
./gal.ps1 recalc-readiness
./gal.ps1 validate-state
```

A host must not claim that validation passed unless the validation command actually executed successfully.

## Important
- Do not edit files under `.gal/context/` directly; they are generated.
- Do not treat best practices as requirements unless supported by project evidence.
- Missing information is not a negative requirement.
- GAL may continue useful work with non-blocking gaps.
- GAL does not replace stakeholder, product, architecture, security, compliance, or approval authority.
