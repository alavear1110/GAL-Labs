# Kiro Adapter — GAL v0.4.7

This is a runtime-only package. No test suite is embedded.

Kiro may write GAL state only to:
- `.gal/state/project-state.json`

Kiro must not directly write, replace, or edit:
- `.gal/context/*`

After state changes:
1. edit canonical state
2. run `.\gal.ps1 sync`
3. optionally read generated views
4. validate when required

Never automatically use:
- `-ExecutionPolicy Bypass`
- `Set-ExecutionPolicy`
- `Unblock-File`
