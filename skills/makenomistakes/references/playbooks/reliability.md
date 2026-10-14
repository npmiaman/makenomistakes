# reliability

**Probe:** Survive what, exactly — a crash mid-step, a restart, a 429, a slow vendor, two workers, a retry storm? Name the failure, then make the outcome bounded and correct.

**Tier:** T1. Raise to T2 when the work being protected sends to people or moves money.

**Moves**
1. Build the failure list from the **durable work** lens in [lenses](../lenses.md): can it run twice, crash mid-step, be claimed twice, confuse "couldn't look" with "nothing there", retry forever?
2. **Timeouts on every external call.** Retries only when the operation is idempotent (or carries an idempotency key), with exponential backoff, jitter, and a budget; hard-stop on auth, challenge, or policy errors.
3. Long-running work: a **lease with heartbeat and expiry**, an **atomic claim** (one worker per unit), and a stuck-job detector (oldest "running" age) with an alert.
4. Results are **tri-state**: done / found nothing / couldn't look. Only "done" and "found nothing" are terminal.
5. Overload: shed or queue rather than fall over; circuit-break a failing dependency; no untested fallback paths.

**Delegate:** the `diagnosing-bugs` procedure when an existing failure needs a repro first.

**Traps:** a retry that duplicates side effects · a "running" state with no expiry · catching an error and recording success · fallbacks that only run during outages (and so are broken).

**Stop and surface when:** making it safe requires changing what users see (e.g. delaying sends) — that's a product call.

**Proof:** a fault **injected this session** — kill mid-step, stub a 429, run two workers, restart during work — with a bounded, correct outcome observed (no duplicate, no stuck job, the right terminal state).

**Report adds:** the fault-injection table (fault → observed outcome).
