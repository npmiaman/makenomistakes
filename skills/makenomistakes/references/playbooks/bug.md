# bug

**Probe:** Is the reported symptom the bug, or a downstream effect of one? When did it start — what changed (`git log -S`, deploys, dependency bumps, data, config)?

**Tier:** set by door × radius. Raise when the fix touches money, auth, or data already written wrong (then the cleanup is a `backfill`).

**Moves**
1. Build a **tight, red** feedback loop before theorising: one command, already run once, that shows the bug. Failing test > script > CLI/curl > replayed fixture > scripted manual repro. If you're reading code to build a theory and that command doesn't exist yet, stop and build it.
2. Shrink the repro until every remaining piece matters.
3. Generate 3–5 ranked hypotheses before testing any; each carries a falsifiable prediction ("if X, then changing Y makes it disappear").
4. Instrument at component boundaries; tag debug logs `[DEBUG-xxxx]` so cleanup is one grep.
5. Fix the **root cause**, not the site where the error surfaces. Then ask: where else does this same mistake exist?
6. Remove instrumentation.

**Delegate:** the `diagnosing-bugs` procedure — the deeper version of the above · the `tdd` procedure for the regression test.

**Traps:** fixing the symptom site · bundling speculative fixes · "can't reproduce" closed as fixed · a retry or sleep that hides a race · a third failed fix and still patching (tripwire).

**Stop and surface when:** you can't build a repro — re-type to `investigate`.

**Proof:** the original symptom observed gone on the real path, plus a regression test that fails with the fix reverted and passes with it.
