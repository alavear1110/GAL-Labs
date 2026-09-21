# Installation and Local Use

## Prerequisites
- PowerShell 7 or later (required for authoritative JSON Schema validation with `Test-Json`)
- an AI development assistant capable of reading the GAL steering files
- a project folder where GAL can create its local `.gal/` state

## Runtime setup
Copy the contents of `runtime/` into the project you want to use with GAL.

For Codex, also place the repository's thin root `AGENTS.md` in the project root. It directs Codex to `steering/` and the canonical `adapters/codex/AGENTS.md`; do not copy GAL Core text into another instruction file.

From PowerShell:

```powershell
.\gal.ps1 init
```

Then tell your AI tool:

> Start GAL

## PowerShell trust note
Downloaded PowerShell scripts may carry Windows' Mark-of-the-Web and prompt before execution.

GAL does not automatically bypass execution policy and does not automatically unblock scripts.

For a script you have independently reviewed and trust, Windows provides `Unblock-File`; follow your organization's approved security practices.

## Generated files
Files under `.gal/context/` are generated. Do not edit them directly.

Use:

```powershell
.\gal.ps1 sync
```

to refresh them from canonical state.
