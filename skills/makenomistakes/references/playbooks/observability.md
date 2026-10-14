# observability

**Probe:** What questions will someone ask at 3am when this breaks? Name 2–4 of them before adding a single log line.

**Tier:** T1.

**Moves**
1. Metrics tell you **that** something is wrong, traces tell you **where**, logs tell you **why** — instrument for the questions you named.
2. Services: RED (rate, errors, duration). Resources: USE (utilisation, saturation, errors). Jobs: age of the oldest pending/running item, success/failure counts, retries.
3. Percentiles, never averages. Watch cardinality — no user IDs or URLs as metric labels.
4. Alert on **symptoms users feel** (error rate, latency, stuck work), not causes. Two severities: page or ticket. Every alert links to a short runbook.
5. Logs are structured, carry a request/job ID, and never contain secrets or unnecessary PII.

**Delegate:** `dataviz` for dashboards.

**Traps:** logging everything and learning nothing · alerts nobody acts on · dashboards nobody opens · a "success" log line on a swallowed error.

**Proof:** an induced failure (stubbed error, killed job, slow dependency) observed to fire the signal or alert, and silence under normal load.
