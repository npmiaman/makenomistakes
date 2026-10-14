# schema

**Probe:** How much data, how hot is the table, and who else reads it — other services, analytics, exports, backups, jobs queued right now?

**Tier:** T2 — a shape change on live data is a one-way door until proven otherwise. Start lower only with a stated reason (empty table, dev-only database).

**Moves**
1. Back-of-envelope the data: row count, table size, lock behaviour of this DDL on this database engine and version, expected duration.
2. **Expand/contract**: additive first (nullable column, new table, new index built concurrently), backfill in batches, switch reads, drop the old shape in a later deploy.
3. Every destructive step has a backup or reversible path and a dry run (on a copy, or inside a rolled-back transaction) first.
4. Check the migration tool's `down` really reverses — many drop data silently.
5. Set a lock timeout on DDL so it fails fast instead of queueing behind long transactions.

**Delegate:** the `wizard` procedure for steps only the user can run against production.

**Traps:** a `NOT NULL` or non-concurrent index build locking a hot table · renames that break readers you didn't grep · ORM migrations that look reversible but aren't · assuming the repo schema matches production.

**Stop and surface when:** production state can't be inspected from here — give the user the exact read-only queries to run first.

**Proof:** dry-run output on realistic volume; `EXPLAIN`/lock behaviour checked; rollback steps written and, where possible, run.
