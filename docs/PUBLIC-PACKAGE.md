# GAL Public Runtime Package

The public runtime package is intentionally smaller than the GAL Labs development repository.

## Include
Package only the files required to run GAL:
- `runtime/gal.ps1`
- `runtime/README.md`
- `runtime/schemas/`
- `runtime/steering/`
- `runtime/templates/`
- `runtime/contracts/`
- the adapter directory for each host advertised by that release
- the corresponding thin root host loader, such as `AGENTS.md` for Codex or `CLAUDE.md` for Claude Code
- public installation, security, and license material appropriate to the distribution

## Never include
The distributable must not contain GAL Labs' internal validation material:
- `test-suite/`
- regression fixtures
- conformance scenarios
- expected classifications or expected answers
- blind-test prompts or grading criteria
- disposable conformance repositories or their outputs
- internal test transcripts
- prior host test results used as answer keys
- development-only scratch data

A public example may demonstrate GAL behavior, but it must be authored as documentation rather than copied from an internal regression or conformance oracle.

## Release rule
A release is not publishable until its staged package has been inspected independently of the source tree and contains no path or content from the internal-testing categories above.

The development repository may retain internal tests for engineering purposes. They are not part of the customer/user deliverable.
