# Lenses

Cross-cutting concerns for step 5 on T1/T2. Read the **Fires when** column; keep only the rows that match what this change touches. Each lens that fires seeds a pre-mortem story, and earns a line in the report only when it changes the build or the verification list.

| Lens | Fires when the change touches | Ask |
|---|---|---|
| **Durable work** | jobs, queues, leases, cron, retries, long-running agents, resumable runs | Can it run twice safely (idempotency key, dedupe ledger)? Does a crash mid-step leave it resumable, or "running" forever (lease expiry + heartbeat; oldest-running age watched)? Can two workers claim the same unit (atomic claim)? Is "couldn't look" distinguishable from "found nothing" (tri-state result)? Is retry bounded, with backoff and jitter, and a hard stop on auth/challenge errors? |
| **Side effects** | anything that reaches people or money | Apply the Live side effects canary in SKILL.md. |
| **Trust boundary** | user input, other tenants, webhooks, uploads, third-party responses, LLM output | Is authz checked on every object access (IDOR/BOLA)? Injection — SQL, shell, HTML, and prompt injection into tools? Secrets in logs or errors? |
| **Privacy** | PII in logs, analytics, vendor calls, LLM prompts | Is it needed? Where is it retained, and how is it deleted on request? |
| **Compatibility** | any shape change: API, schema, event, file format, config | Readers you didn't grep: old clients, cached or serialised data, other services, and jobs queued with the old payload during the deploy? |
| **Config** | a new env var, flag, or secret | Present in every environment (local, CI, VM, hosted)? Safe default when missing? Who owns the flag, and when does it go? |
| **Observability** | a new failure mode | Which log, metric, or alert would show it — and would anyone see it? |
| **Cost** | LLM or paid-vendor calls, new infra | Calls × tokens (or units) × price × volume; quotas and rate limits; what happens at the limit? |
| **Performance** | loops, queries, payloads, fan-out | N+1? Unbounded reads? Payload size? Hot path? |
| **UI states** | a screen or component | Empty, loading, error, long text, many items; mobile and desktop; keyboard, labels, contrast? |
| **Docs drift** | behaviour that a doc, README, runbook or steering file describes | Does the doc change in the same commit? (Repo hooks may enforce it.) |
