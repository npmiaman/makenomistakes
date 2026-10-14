# integration

**Probe:** What does the vendor actually do (not what we assume), and what happens to us when it is slow, down, rate-limited, or returns something new?

**Tier:** T1. Raise to T2 when the integration moves money, sends to real people, or holds user credentials.

**Moves**
1. Read the primary docs for the exact endpoints, auth, limits and webhook semantics. Check the SDK version the repo already pins.
2. Make one real sandbox call and save the response as a fixture **before** writing the wrapper — code against reality, not the docs' example.
3. One **chokepoint** module owns the vendor: auth, timeouts, retries, rate limiting, error mapping. Nothing else calls the vendor directly.
4. Retries only on idempotent operations (or with idempotency keys). Verify webhook signatures; dedupe webhook deliveries; handle out-of-order events.
5. Secrets come from env/config, never code. Map vendor errors to your own error types so callers don't leak vendor shapes.

**Delegate:** the `research` procedure for docs legwork · `claude-api` for Anthropic/Claude integrations · the `wizard` procedure for dashboard/credential steps only the user can do.

**Traps:** trusting the docs' example payload · unbounded retries hammering a 429 · vendor types leaking through the codebase · the happy path tested, the failure path never.

**Stop and surface when:** the integration needs credentials, a paid plan, or a dashboard setting you can't reach — hand the user the exact steps.

**Proof:** a real sandbox round trip this session, plus the failure path (timeout, 429, bad signature) exercised with a stub.
