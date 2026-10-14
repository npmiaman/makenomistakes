# infra

**Probe:** What fails if this is wrong, how fast would anyone know, and where is the single written answer to "where does this run"?

**Tier:** T1. Raise to T2 for anything that destroys or replaces production resources, or changes networking, IAM, DNS, TLS, or where data lives.

**Moves**
1. Plan/diff before apply (`terraform plan`, `kubectl diff`, `docker compose config`, `--dry-run`). Read it for destroys and replacements.
2. Change one thing at a time; stage it (dev → prod) if stages exist.
3. Answer "how will we know it broke?" — the alert, health check, or log line — before applying.
4. Keep the runtime map written down (which service runs where, with which env): update the repo's deploy doc in the same change.
5. Secrets never land in code, logs, images, or chat output; env files are not overwritten by tooling without a backup.
6. Prefer boring, reversible infra: managed services and plain processes over new orchestration, unless a number says otherwise.

**Delegate:** the `wizard` procedure for console/credential steps only the user can do · `superset:setup` for workspace setup scripts.

**Traps:** applying with an unread plan · hand-fixing drift in a console · moving where things run without updating the deploy doc · tooling silently replacing an env file.

**Stop and surface when:** the change moves where production runs or touches IAM/DNS — the user decides, with the plan output in front of them.

**Proof:** clean plan → apply output; the health check, smoke request, or alert observed green after the change on the target environment.
