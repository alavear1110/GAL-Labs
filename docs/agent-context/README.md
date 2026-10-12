# Shared repository context

Protocol version: 1.0. This directory is the provider-neutral, version-controlled
context index for this repository. It travels with clones and pulls; it does not
depend on a chat history, account memory setting, or a particular model.

## Start and reload

1. Read root `AGENTS.md`, then this file, `PROJECT.md`, `STATUS.md`, and
   `DECISIONS.md` before planning or editing. Read the existing repository README,
   the source documents linked here that matter to the task, and any instructions
   scoped to the files you will change. Retain existing runtime or governance
   loaders; this index does not replace their canonical state.
2. Inspect the working tree and current branch/commit. Record the HEAD used to
   load context. Check for unrelated local changes before editing.
3. After any pull, checkout, branch switch, merge, rebase, or other HEAD change,
   reload these files and affected scoped instructions before continuing. Also
   reload if their working-tree contents change without a HEAD change. Compare
   the status snapshot with current code and changes since its reviewed commit.
   Do not continue from a cached summary when the checkout has changed.
4. Use current code and recorded evidence to reconcile stale status claims.
   Respect user directions and applicable higher-priority instructions. Retain
   existing project-specific constraints; raise unresolved conflicts instead of
   silently discarding them. Marketing names in `PROJECT.md` govern current
   product copy; legacy repository/package identifiers remain valid internally.
5. If a required document is missing or inaccessible, report the specific gap
   and proceed only with work that the available evidence supports. A missing
   context file is not evidence that the product or a runtime state is initialized.

## What belongs where

| File | Purpose |
| --- | --- |
| `PROJECT.md` | Identity, purpose, architecture, boundaries, and source map |
| `STATUS.md` | Dated evidence snapshot, open work, checks, and next handoff |
| `DECISIONS.md` | Confirmed lasting choices, their reasons/sources, and open choices |
| Existing specs, ADRs, checkpoints, runtime state | Detailed source of truth linked from this index |

These files are maintained summaries, not a substitute for reading relevant code,
formal product contracts, or canonical runtime state. Keep historical records
intact and fix current guidance when the owner confirms a rename or decision.

## Keep the next agent informed

After substantive work, update `STATUS.md` with the date, reviewed/base commit,
actual changes, checks and results, checks not run, blockers, next action, and
links to evidence. Do not put the not-yet-created commit SHA in its own contents;
record the reviewed/base SHA and let Git history identify the handoff commit.
When scope, architecture, branding, or a lasting constraint changes, update
`PROJECT.md` or `DECISIONS.md` as appropriate and retain the detailed source link.

Record only verified completion and confirmed decisions. Keep proposals and
uncertainty explicit. Do not claim a deployment, device acceptance, security
check, or test passed unless it was actually verified. Do not commit credentials,
private customer data, or confidential employer material to context files.
Preserve unrelated work and follow the repository's existing contribution rules.

## Discovery and portability

Root `AGENTS.md` is the neutral entry point. Thin discovery files for Claude Code,
Gemini CLI, GitHub Copilot, Cursor, and Kiro route to the same files. Keep the shared
bootstrap and protocol identical across repositories; project facts belong in
the three project-specific files, not in duplicated tool rules.

Automatic loading depends on the tool, trust settings, and supported features.
A Git pull supplies files but does not itself inject them into every agent's
active conversation. The startup/reload rules above instruct a participating
agent to read the fresh files. If a tool does not discover an entry point, supply
`AGENTS.md` and this directory explicitly in its task context. No Git hooks or
provider-specific account memory are required.

| Discovery file | Tool documentation |
| --- | --- |
| `AGENTS.md` | [Codex repository instructions](https://learn.chatgpt.com/docs/agent-configuration/agents-md) |
| `CLAUDE.md` | [Claude Code project instructions](https://code.claude.com/docs/en/memory) |
| `GEMINI.md` | [Gemini CLI context files](https://geminicli.com/docs/cli/gemini-md/) |
| `.github/copilot-instructions.md` | [GitHub Copilot repository instructions](https://docs.github.com/en/copilot/how-tos/copilot-on-github/customize-copilot/add-custom-instructions/add-repository-instructions) |
| `.cursor/rules/agent-context.mdc` | [Cursor rules](https://prod.cursor.com/docs/rules) |
| `.kiro/steering/agent-context.md` | [Kiro steering](https://kiro.dev/docs/steering/) |

Discovery adapters load repository instructions only. They do not establish a
tool's compatibility with any application runtime or governance host protocol;
use the project's documented runtime adapters and validation evidence for that.
