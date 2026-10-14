# makenomistakes

A Claude Code skill that vibecodes any engineering task end to end, the way an L8 / principal engineer would. Hand it the task. It runs every phase itself and comes back with the work shipped to the finish line, with proof.

```
/makenomistakes add a pricing page with a monthly/annual toggle
/makenomistakes the dashboard list never updates after accept — fix it
/makenomistakes should we move the worker off the VM?        # a question → a committed recommendation
/makenomistakes wrap up                                       # status, progress note, handoff text
/makenomistakes                                               # scout: "what's the highest-leverage next move here?"
```

## Install

**As a plugin** (recommended):

```
/plugin marketplace add npmiaman/makenomistakes
/plugin install makenomistakes@makenomistakes
```

Plugin skills are namespaced, so invoke it as `/makenomistakes:makenomistakes`.

**As a personal skill:**

```
git clone https://github.com/npmiaman/makenomistakes.git
ln -s "$PWD/makenomistakes/skills/makenomistakes" ~/.claude/skills/makenomistakes
```

Then invoke it as `/makenomistakes`. Start a new session after installing so the skill list picks it up.

## The run

It opens with a **flight plan**: the real problem, the type and tier, the phases it will run, and the finish line. It prints one status line per phase and doesn't stop between phases.

| # | Phase | What happens |
|---|---|---|
| 0 | Orient | Branch, worktree, where the code runs; steering files and repo hooks; prior art; blast radius; the commands that prove things |
| 1 | Understand | The real problem (an X/Y problem? a proxy?), non-goals, a success criterion, type and tier. Decisions that are yours get asked **once, in one batch**, each with a recommended answer. `CONTEXT.md` and ADRs are updated as terms and decisions settle |
| 2 | Shape | Back-of-envelope estimates, at least two real options and one call, a lens-driven pre-mortem. A prototype detour when only running code can settle a question. Vertical slices, scariest first. Multi-session work becomes a spec plus tickets |
| 3 | Build | A feature branch. Per slice: red test → change → green → commit |
| 4 | Verify | Climbs the ladder: checks → the real path (run it, curl it, screenshot it) → e2e → live (only when deploying) |
| 5 | Review | Spec and Standards reviews in parallel fresh contexts, reported side by side; a security review when a trust boundary is touched |
| 6 | Polish | A simplify pass, debug code removed, docs updated in the same branch |
| 7 | Ship | Push the branch and open a PR with evidence. You merge. It deploys only when you ask, then checks the live version |
| 8 | Hand off | A report with the finish line, evidence, assumptions ledger, Not done, Noticed, decisions, and Next, plus the phase-boundary call: continue, `/clear`, handoff, subagent, or `/compact` |

**Tiers** set how much of the run a task gets. They follow how reversible the change is, not how hard it is:
- **T0**, a small two-way door: a light run, ending in a ~10-line report.
- **T1**, a two-way door with a wider blast radius: every phase.
- **T2**, a one-way door (schema, live data, sends, money, auth): it builds everything that doesn't depend on the decision, then stops at the door for your decision.
- **Q**, a question: a committed recommendation, and nothing changes.

**Guardrails**
- Real messages, posts, payments and bulk writes always run as a canary: dry run, then one, then verify, then the rest.
- Asking a question or for a review never touches code or live systems.
- If it finds production broken while working on something else, it leads with that and acts only when you say so.

## What's inside

```
.claude-plugin/                       # marketplace + plugin manifests
skills/makenomistakes/
  SKILL.md                            # the run, iron laws, live-sends canary, router, tripwires, red flags; snapshot last
  references/playbooks/*.md           # 32 work types: probe, tier, moves, traps, stop-when, proof, report-adds
  references/procedures/*/PROCEDURE.md  # 38 procedures: grilling, domain-modeling, prototype, spec, tickets, tdd,
                                      #   diagnosing-bugs, two-axis-review, phase-boundaries, triage, wayfinder, …
  references/procedures.md            # index: which procedure runs in which phase
  references/lifecycle.md             # what to do when while vibecoding, with sources
  references/lenses.md                # cross-cutting pre-mortem checks (durable work, trust boundary, compat, cost…)
  references/templates.md             # report, decision matrix, back-of-envelope, pre-mortem, rollout, design doc, ADR
  references/heuristics.md            # the principal-engineer heuristics behind it, with sources
  scripts/snapshot.sh                 # branch, worktree, hooks, scripts, deploy files, captured at invocation
evals/                                # an offline fixture repo + 21 scenario cases (see evals/evals.md)
```

**The 32 types**

| Family | Types |
|---|---|
| Build | feature · ui · integration · llm |
| Fix | bug · investigate · incident · triage |
| Change | refactor · upgrade · migration · git |
| Data | schema · backfill · analysis |
| Quality | test · perf · reliability · security · review · audit |
| Run | release · infra · toolchain · observability · operate |
| Think | explain · design · plan · write · session · teach |

SKILL.md renders at about 4.5k tokens with the snapshot last. That keeps the rules inside the part of a skill Claude Code re-attaches after compaction.

## Evals

`evals/make-fixture.sh` builds an offline shop repo with planted problems:
- a startup race
- a missing index
- an IDOR
- flaky IDs
- a half-sent outreach batch
- a weak LLM classifier
- a broken mobile layout
- a rounding-changing dependency upgrade
- a deploy that 500s

`evals/render.sh` renders the skill for each case in `evals/cases.tsv`, and a subagent runs each case. Grade the resulting repo state, not the report. Case definitions and pass/hard-fail criteria are in [evals/evals.md](evals/evals.md).

## Licence

MIT, see [LICENSE](LICENSE). Some procedures are adapted from MIT-licensed material; see [THIRD_PARTY_NOTICES.md](skills/makenomistakes/THIRD_PARTY_NOTICES.md).
