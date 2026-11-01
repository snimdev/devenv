# AGENTS.md

Rules for anyone, person or AI agent, developing Snim in this workspace.

## Workspace

`devenv` clones every Snim repository side by side (`make clone`, `make pull`, `make status`). Each one keeps its own history; this repository tracks only the workspace files.

- `specs/`: feature specs, where all development starts ([snimdev/specs](https://github.com/snimdev/specs)).
- `snim/`: the desktop app, C++20 and Qt 6 ([snimdev/snim](https://github.com/snimdev/snim)). Build steps are in its README and `CMakeLists.txt`.
- `homebrew-tap/`: the macOS cask. Bump `version` and `sha256` from the release's `sha256sums.txt` after every release.
- `setup-msvc/`: the GitHub Action that sets up MSVC for the Windows builds.
- Any private repositories: cloned only with access, and they keep their own rules.

## Development goes through specs

1. Every feature and behaviour change starts as a spec in `specs/`, following `specs/README.md`. The only exceptions are bug fixes that restore specified behaviour and chores with no user-visible change.
2. Open a pull request for the spec. Merging it publishes its snim.dev roadmap entry and, for planned and in-progress work, its issue on `snimdev/snim`.
3. Implement against the spec, in the product repo, referencing the issue as `#N`. Never use a closing keyword such as `Closes #N`: the spec's status closes the issue.
4. When the code has to differ from the spec, update the spec first, then the code.
5. Keep the spec's Status checklist and `status` current through pull requests. Merging `shipped` closes the issue.

## Code quality

- We want SOLID principles and Gang of Four patterns, and we maintain code quality.
- Designs name the patterns they use, and new code extends the patterns already in place instead of inventing parallel ones.

## Writing

- Comments are short and simple: one line, only for a non-obvious constraint.
- Public repositories never get business plans, infrastructure details or credentials.

## Commits and review

- A commit is one short line: `Area: Imperative description` where an area fits (`Auth: Restore remember-me for OAuth users`), plain imperative otherwise (`Add Snim icons`). Aim for under 60 characters, never past 72. No body and no trailers of any kind.
- One change per commit. If the message does not fit, the commit is doing too much, so split it.
- Agents work on a branch and open a pull request. The maintainer reviews and tests every pull request before it is merged.
- Agents never push to `main` or merge their own pull requests.

## Agents

- Delegate implementation work to subagents and review their output before it is committed.
- Pass the Code quality, Writing and Commits rules into every subagent prompt.
