# toolchain

**Probe:** Is the dev loop broken (CI red, build fails, env won't start), slow, or missing a gate? Reproduce it exactly as CI or a fresh machine would.

**Tier:** T0. Raise to T1 when changing a gate other people depend on (CI required checks, shared hooks).

**Moves**
1. Reproduce with the **exact** CI command, versions, and environment (clean install, same Node/Python, same flags).
2. Fix the cause and keep the gate: fix the lint error instead of disabling the rule; a flaky test is a bug (`investigate`), not a re-run.
3. Gates in order of cost: format → lint → typecheck → unit → build → integration/e2e. Fast feedback first.
4. Repo hooks encode rules; satisfy them. If a hook is wrong, change the hook in its own commit, with the user's say-so.
5. New project: start from the house template or the nearest sibling repo; CI, lint, and one passing test land in the first commit.

**Modes.** Agent-workflow setup for a repo → the `repo-setup` procedure (issue tracker, triage labels, `CONTEXT.md`/ADR layout into `docs/agents/`). Guardrails → the `git-guardrails` procedure (hooks blocking dangerous git) and the `pre-commit` procedure (Husky, lint-staged, Prettier, typecheck, tests). TypeScript module boundaries → the `ts-deep-modules` procedure (dependency-cruiser).

**Delegate:** `superset:setup` for workspace setup/teardown scripts · `update-config` for Claude Code harness settings and hooks · `init` for a first CLAUDE.md.

**Traps:** "works on my machine" · disabling a rule or skipping a hook to go green · caching that hides a broken clean build · re-running CI until it passes.

**Proof:** a fresh clone (or clean install) → the documented command → green, run this session.
