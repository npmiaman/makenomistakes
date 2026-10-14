# perf

**Probe:** Slow (or costly) for whom, at which percentile, against what budget? "Faster" with no target never finishes.

**Tier:** T1.

**Moves**
1. **Measure before touching anything**: a baseline at p50/p95/p99, throughput, memory, or cost per request, on a realistic workload. Profile; don't guess.
2. Back-of-envelope the floor: the theoretical best given the I/O and network hops. Near the floor already → the fix is architectural or the target is wrong.
3. Fix in order of boringness: algorithm / N+1 / missing index → batching or parallelism → avoid the work entirely → caching (caches are state: invalidation, cold start) → new infrastructure.
4. LLM cost: calls × tokens × price × volume; prompt caching, smaller models for easy steps, fewer round trips.
5. Watch for non-linear behaviour — queueing knees, lock contention, GC — a small simulation beats intuition.

**Delegate:** the `diagnosing-bugs` procedure for performance regressions.

**Traps:** optimising off the hot path · benchmarks on toy data · caching before indexing · reporting averages · a cache that serves stale auth or money data.

**Proof:** before/after numbers from the same harness and workload, at the percentile the target is set on.

**Report adds:** the before/after table.
