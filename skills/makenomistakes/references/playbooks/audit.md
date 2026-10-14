# audit

**Probe:** What area, and what does "wrong" mean here — broken, risky, slow, inconsistent, unfinished? An audit with no scope is a scout of the current context.

**Tier:** Q — an audit changes nothing: not code, not data, not live systems. Fixes come after, each as its own type and tier. An active incident found mid-audit goes first in the report as decision #1, with the mitigation command ready.

**Moves**
1. Scope the area (an app, a flow, a directory, the session).
2. Sweep with the router types and the [lenses](../lenses.md) as a checklist of *kinds* of wrong: bugs, unreliable jobs, security boundaries, perf, missing tests, drift between docs and code, dead code, stale config, branch/worktree hygiene.
3. **Reproduce each finding** — run it, query it, show it. A finding without evidence is a hunch; list hunches separately.
4. Tag each finding with type and tier; rank by impact × likelihood ÷ effort.
5. Sequence into a plan: one-way doors flagged, quick wins first only when they don't block the big one.

**Architecture audits** run the `architecture-review` procedure: scope by git hot spots, find shallow modules with the deletion test, write the HTML report of deepening candidates to the OS temp dir, then grill the picked one into a `refactor`.

**Delegate:** the `architecture-review` procedure for an architecture-focused sweep · the `tickets` procedure to turn the plan into tickets.

**Traps:** fixing things mid-audit · a 40-item list with no ranking · findings without evidence · auditing only what's easy to grep.

**Proof:** every ranked finding has evidence produced this session; the working tree is unchanged (`git status` clean).

**Report adds:** the ranked list (`n. finding · type · tier — evidence`), the sequenced plan, and "Say `go` (or `go 2`) and I'll ship it."
