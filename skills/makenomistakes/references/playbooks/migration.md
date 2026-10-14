# migration

**Probe:** What is the end state, and what does "finished" mean — the old path deleted? Migrations that stop at 90% leave two systems forever.

**Tier:** T1. Raise to T2 when consumers outside the repo exist (public API, mobile clients, other services, partner integrations) or data moves.

**Moves**
1. **Inventory consumers** of the old path: grep, logs/metrics of real usage, other repos, clients you can't update.
2. **Expand → migrate → contract**: add the new path alongside the old; move consumers; remove the old only when usage is zero.
3. **Derisk** on the hardest consumer first, not the easiest.
4. **Enable**: make moving mechanical — codemod, adapter, dual-read/dual-write — so the easy 90% is automated and each step is reversible.
5. **Ratchet**: a lint rule or check so no new code uses the old path.
6. **Finish**: drive the long tail to zero yourself; deleting the old path is the success criterion. Ports and API changes follow the same shape.
7. Deprecations announce a date and a replacement, and log every remaining use.

**Delegate:** the `research` procedure for upstream migration guides.

**Traps:** big-bang cutovers · celebrating the launch instead of the deletion · dual-write with no reconciliation check · forgetting jobs queued with the old payload during deploy.

**Stop and surface when:** a consumer can't be migrated (external, unowned) — the deletion date is the user's call.

**Proof:** consumer count on the old path observed falling (grep, logs, metrics), the ratchet in place and tested, rollback exercised for the current stage.

**Report adds:** the consumer inventory with status per consumer.
