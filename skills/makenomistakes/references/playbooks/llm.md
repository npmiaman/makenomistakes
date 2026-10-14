# llm

**Probe:** What does "better" mean, measurably — and on which inputs? LLM quality is statistical: one good-looking output proves nothing.

**Tier:** T1. Raise to T2 when outputs reach real people automatically (messages, posts, decisions about users) or the change swaps the production model/provider.

**Moves**
1. **Look at the data first.** Pull real failing outputs; read them; group the misses into 4–8 named failure buckets. The buckets tell you what to change.
2. **Eval before change.** Build or extend an eval set from real examples, split a **held-out** set before tuning anything, and record the baseline with n.
3. Graders: deterministic checks first (format, required fields, banned phrases); an LLM judge only for what code can't check, and spot-check the judge against human labels.
4. Change one thing at a time (prompt, model, temperature, context) and re-score on the held-out set. Record latency and cost per call alongside quality.
5. Treat empty, refused, truncated and rate-limited responses as **failures**, never as "nothing found".
6. Model/provider swaps: same eval, same held-out set, side by side; check pricing, rate limits and regional availability.

**Delegate:** `claude-api` for Anthropic models, pricing, caching and SDK specifics · the repo's e2e skill if listed (e.g. `silo`) — recommend it; the user starts it, because it spends real inputs and money.

**Traps:** "seems better" from eyeballing three outputs · tuning on the rows you then score · a single blended score hiding which bucket regressed · prompt changes that silently raise token cost · treating model output as trusted input downstream.

**Stop and surface when:** the held-out score doesn't move, or improves one bucket while regressing another — that's a product tradeoff for the user.

**Proof:** before/after on the held-out set, per bucket, with n stated and the small-n caveat when n < ~50; cost and latency per call before/after.

**Report adds:** a score table (bucket × before/after × n), and three real before/after examples.
