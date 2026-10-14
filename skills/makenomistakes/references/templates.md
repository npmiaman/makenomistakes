# Templates

Use the smallest template that carries the decision. Skip sections that have nothing to say.

Contents: [report](#report) · [decision matrix](#decision-matrix) · [back-of-envelope](#back-of-envelope) · [pre-mortem](#pre-mortem) · [rollout / rollback](#rollout--rollback) · [mini design doc](#mini-design-doc) · [ADR](#adr)

---

## Report

The final message of every run. Lead with the status and the answer.

```
**Status: DONE | DONE_WITH_CONCERNS | BLOCKED | NEEDS_DECISION** · <type>[+<type>] · T<0|1|2|Q> · Door: one-way|two-way · Radius: <one word> · `<branch>@<worktree>`

<1–3 sentences: what changed / what the answer is.>

**Finish line:** PR <link> on `<branch>` (<n> commits) | pushed, PR not opened: <why> | local commits only: <why> | live: <version observed>

**Run:** ✓ orient · ✓ understand · ✓ shape · ✓ build (<n> slices) · ✓ verify (<highest rung>) · ✓ review (<n> findings fixed) · ✓ polish · ✓ ship — mark any phase skipped and why

**Real problem:** <one line — only if it differs from what was asked>

**What I did**
- <change> — [file.ts:42](path/file.ts#L42)

**Evidence** (highest verification rung reached: checks / real path / e2e / live)
- <command run> → <what the output showed>

**Assumptions**
- ✅ <verified — how>
- ⚠️ <unverified — why not, and the command that would verify it>
- ⬜ <didn't check>

**Not done**
- <non-goal or follow-up, and why it was left>

**Noticed** (outside the request, untouched)
- <problem> · <type> · T<n> — [file:line](path#Lline)

**Decisions for you** (NEEDS_DECISION / T2 only)
1. <question> — ➡️ recommend: <answer>, because <reason>

**Next** (at most two)
- <`pr` for the PR body · `/clear` + handoff when the session is long or the next task is unrelated · `/retro` after a repeated mistake · a playbook's `/slash` skill>
```

T0 runs collapse this to about ten lines: status line, one sentence, finish line, evidence, anything unverified, and Noticed. Drop "Real problem" when nothing was reframed; drop empty sections.

**Scout mode** (empty request) is an `audit` of the current context: it replaces "What I did" with a ranked list — `1. <move> · <type> · T<n> — <evidence>` — and ends with "Say `go` (or `go 2`) and I'll ship it."

---

## Decision matrix

```
| Criterion              | A: <name>  | B: <name>  | C: smallest / existing tools / do nothing |
|------------------------|------------|------------|-----------------|
| Meets success criterion| ✅ why     | ⚠️ why     | ❌ why          |
| Complexity added       |            |            |                 |
| Reversibility (door)   |            |            |                 |
| Failure modes          |            |            |                 |
| Effort                 |            |            |                 |
| Migration / rollout    |            |            |                 |

➡️ Recommend <X>. <Others> lose because <reason>. Would flip if <condition>.
```

Every cell carries a reason, not just a mark. The losing options' reasons are the most valuable part.

---

## Back-of-envelope

```
Load:     <users/events> → <avg req/s> → peak ×<N> = <req/s>
Size:     <bytes/record> × <records> = <total>; growth <x>/month
Latency:  <hop> + <hop> + … = <ms> vs budget <ms> at p<99>
Cost:     <units> × <unit price> = <$/month>
Binding constraint: <the one that decides it>
Assumptions: <each labelled; round to 1 significant figure>
```

Order-of-magnitude anchors (from Jeff Dean's latency numbers, 2012 hardware — trust the exponents, not the digits): memory reference ~100 ns · SSD random read ~100 µs · same-datacenter round trip ~0.5 ms · disk seek ~10 ms · cross-continent round trip ~150 ms.

---

## Pre-mortem

```
| Failure story (it's next week and…) | Likelihood | Impact | Early signal | Mitigation or verification item |
```

Top three rows are mandatory on T1/T2. Each maps to something concrete in the build or in step 7.

---

## Rollout / rollback

```
Flag: <name> (default off)            Killswitch: <how>
Stages: internal → 1% → 10% → 50% → 100%, gate metric per stage: <metric, threshold>
Rollback: <exact steps> — exercised? <yes/no>
Data: reversible? <yes / no → this is a one-way door, T2>
How we'll know it broke: <alert / dashboard / log query>
```

---

## Mini design doc

For T2 work, or anything that will take more than a few days or that others will build on. 1–3 pages. Skip it when the solution isn't ambiguous — then it's just code.

```
# <Title>
Context & scope — the landscape, links out. Not a requirements list.
Goals — measurable.
Non-goals — plausible goals deliberately excluded.
Design — overview; a diagram if more than two components interact; APIs/data only where they carry a tradeoff.
Alternatives considered — each one, and why it loses against the goals.
Estimates — load, size, cost, with assumptions.
Cross-cutting — security, privacy, observability, rollout/rollback, cost.
Risks — pre-mortem table.
Open questions — each with a recommended answer.
```

---

## ADR

For one-way-door decisions worth remembering. If the repo has `docs/adr/`, follow its numbering and format instead.

```
# ADR-NNN: <imperative title>
Status: proposed | accepted | superseded by ADR-MMM
Context: <forces at play>
Decision: We will <…>.
Consequences: <good, bad, neutral>
Door: one-way | two-way · Revisit if: <trigger>
```
