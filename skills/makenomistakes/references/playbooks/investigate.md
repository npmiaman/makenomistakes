# investigate

**Probe:** What exactly is observed, how often, since when, for whom? "Sometimes" is a rate you haven't measured yet.

**Tier:** Q — the investigation changes nothing. Once the cause is shown, the fix runs as `bug` (or `reliability`) with its own tier.

**Moves**
1. **Timeline:** logs, git history, deploys, config and data changes around the first occurrence. What touched it last?
2. **Measure the rate** before theorising: run it N times (N ≥ 20 for flaky tests) and record k/N. Intermittent failures are statistics.
3. Hypotheses from the buckets: **ordering**, **timing/race**, **shared state**, **external dependency**, **resource leak**, **non-determinism** (time, randomness, map order); for stuck or lying jobs also **lost lease**, **crash mid-step**, **"couldn't look" recorded as "found nothing"**.
4. **Isolate before ordering**: run the unit alone; then bisect (git, inputs, test order) — never brute-force.
5. Support ticket: reproduce **as that user** — their data, flags, tenant, timezone, timeline. Read-only.
6. Every link in the causal chain cites evidence: a log line, a measured rate, a repro.

**Delegate:** the `diagnosing-bugs` procedure once a deterministic repro exists.

**Traps:** a single green run as proof · "fixing" a flake with a retry, sleep or skip · editing the test instead of the code · theories with no measurement · assuming last month's cause.

**Stop and surface when:** the evidence points outside the repo (vendor, infra, a user's environment) — report the chain and what you'd need to look further.

**Proof:** a causal chain with evidence on every link; for intermittent failures, k/N before and 0/N after with N ≥ 50, plus red with the fix reverted.

**Report adds:** confidence (high/medium/low) and why; for tickets, a draft reply to the user.
