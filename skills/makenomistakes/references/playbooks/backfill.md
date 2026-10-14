# backfill

**Probe:** Exactly which rows, and how do you know? Define the affected set as a query before writing anything.

**Tier:** T2 — writing, repairing or deleting live data. Destructive steps follow the Live side effects rule: stop after the dry run.

**Moves**
1. **Define the set** as a query; count it; sample and eyeball 10 rows. Predict the count you will touch.
2. **Back up** the affected rows (or the table) before changing them.
3. Write it **idempotent and resumable**: re-running is a no-op; progress is checkpointed; batches are small and rate-limited so hot tables aren't locked.
4. **Canary batch** first; verify it; then the rest, logging progress.
5. Invariant queries before and after (totals, foreign-key integrity, no duplicates).

**Delegate:** the `wizard` procedure for production steps only the user can run.

**Traps:** an unbatched `UPDATE` on a hot table · non-idempotent reruns doubling effects · testing on toy data · the affected set drifting between dry run and run.

**Stop and surface when:** the dry-run count differs from the prediction, or the set includes rows the user didn't describe.

**Proof:** predicted count = touched count; invariants hold before/after; a second run is a verified no-op.

**Report adds:** the defining query, counts (predicted / touched), and where the backup is.
