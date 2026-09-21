# Security

## PowerShell trust

GAL's deterministic runtime currently uses PowerShell. Users should review scripts and follow their operating system and organization's normal trust controls before execution.

GAL must not automatically weaken PowerShell security controls. Runtime instructions and host adapters must not automatically:

- use `-ExecutionPolicy Bypass`
- run `Set-ExecutionPolicy`
- run `Unblock-File`

Downloaded files may carry Windows Mark-of-the-Web. If a user independently reviews and trusts a script, Windows provides `Unblock-File`; that is an explicit user trust decision, not a GAL runtime action.

## Execution truth

A blocked or skipped command is not a successful command. GAL hosts must report validation, synchronization, tests, and other deterministic operations as successful only when they actually executed successfully.

## Generated state

`.gal/state/project-state.json` is canonical writable GAL project state. Files under `.gal/context/*` are generated views and must not be treated as an independent writable authority.

## Reporting security issues

Do not include secrets, credentials, private project evidence, or sensitive customer data in a public issue. Use an appropriate private disclosure channel when one is published for the project.
