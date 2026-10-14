# release

**Probe:** What exactly is shipping (the diff since the last deploy), where, and how will you know it's live and healthy?

**Tier:** T1. Raise to T2 when the release includes a schema/data change, a one-way contract change, or there is no tested rollback.

**Moves**
1. **Know what's in it**: `git log <deployed>..<release>`; flag migrations, config/env changes, and new dependencies.
2. **Order**: expand migrations before code that needs them; env vars present in the target environment before code that reads them.
3. Separate deploy from release: risky behaviour behind a flag, default off. Every flag has an owner and an expiry date.
4. **Roll out** in stages where possible (internal → small % → all), watching a few signals against baseline or a control: error rate within ~10% of baseline → advance; > ~2× → roll back.
5. **Observe the live version**: the deployed commit SHA or version string served by the target (health/version endpoint, response header, platform dashboard) — not the merge, not the pipeline's green tick, not a 200 from a cached edge.
6. Roll back by the tested path, and only once per incident automatically — a second rollback is the user's call.

**Delegate:** `pr` for the PR body · `/loop` to watch a rollout (recommend) · the `wizard` procedure for deploy steps only the user can perform.

**Traps:** "merged" reported as "deployed" · deploying to a target nobody named (local vs VM vs hosted) · an env var missing in production · overlapping releases confounding the signal · weekend/late-night releases with no one watching.

**Stop and surface when:** the deploy target is ambiguous, the rollback path is untested, or the change includes a one-way migration.

**Proof:** the new version observed serving on the target (SHA/version + a smoke request on the real path) and health signals at baseline after a watch window.

**Report adds:** what shipped, where, the observed version, and the rollback command.
