# operate

**Probe:** What exactly will happen in the world, to whom, how many times — and how do you know what has already happened?

**Tier:** T2. Follow the **Live side effects** canary in SKILL.md: dry run → one unit → verify at the receiving end → the rest. The user's in-session request naming the action and audience is the go for outbound actions, for that scope or less; destructive or money actions stop after the dry run.

**Moves**
1. **Reconcile the ledger first**: compare your records (sent/queued/failed) with the receiving end (provider logs, platform, the rows). A crash between "send" and "record" leaves units sent but marked unsent — they come off the list.
2. Act only through the product's **own path** (its send function, job runner, CLI) so caps, pacing, cooldowns, and dedupe apply. A side-script that bypasses them is not allowed.
3. **Canary**: one unit, to an internal or test target when one exists; verify it landed at the receiving end.
4. **The rest**, paced by the product, halting on the first failure; any unit whose outcome is unknown is reconciled before retry.
5. Follow the repo's runbook if one exists (deploy README, ops docs). Tests never use production credentials or real recipients.

**Delegate:** the `wizard` procedure for steps only the user can perform.

**Traps:** resuming from a stale "unsent" list · a loop that bypasses the product's rate limits · retrying a unit whose outcome is unknown · a browser test or script hitting the real platform.

**Stop and surface when:** the dry run shows more units than the user named, units with unknown outcomes, or any destructive/money step.

**Proof:** the effect verified at the receiving end for every unit acted on, and the ledger reconciled (no duplicates, counts match).

**Report adds:** the ledger:

```
| Unit | Before | Action | Verified at receiver | After |
Totals: planned N · skipped (already done) k · acted m · failed f · unknown u
```
