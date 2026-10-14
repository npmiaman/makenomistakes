<p align="center">
  <picture>
    <source media="(prefers-color-scheme: dark)" srcset="docs/banner-dark.svg">
    <source media="(prefers-color-scheme: light)" srcset="docs/banner-light.svg">
    <img alt="makenomistakes — vibecode like an L8 engineer" src="docs/banner-light.svg" width="820">
  </picture>
</p>

<p align="center">
  <a href="LICENSE"><img alt="License: MIT" src="https://img.shields.io/badge/license-MIT-16a34a"></a>
  <img alt="Claude Code plugin" src="https://img.shields.io/badge/Claude%20Code-plugin-d97757">
  <img alt="Version 1.0.0" src="https://img.shields.io/badge/version-1.0.0-111827">
  <img alt="32 work types · 37 procedures" src="https://img.shields.io/badge/32%20types%20%C2%B7%2037%20procedures-4b5563">
</p>

# makenomistakes

**Hand it the task. It ships it like a principal engineer, and proves it.**

One skill, invoked with whatever you want done. It reads the repo, finds the real problem behind your request, picks the boring approach, builds it test-first in small slices, checks the result on the real path (the running app, a real request, a screenshot), reviews its own diff with fresh eyes, and opens the PR. It stops only for decisions that are genuinely yours, or at a one-way door.

```
/makenomistakes the dashboard list never updates after someone accepts a request — fix it
```

Vibecoding is fast. This keeps the speed and adds the judgement.

## Quick start (30 seconds)

```bash
/plugin marketplace add npmiaman/makenomistakes
/plugin install makenomistakes@makenomistakes
```

1. Open a repo and run `/makenomistakes:makenomistakes <a small bug you already know about>`.
2. Watch the flight plan, then the status lines, then the report with evidence and a pushed branch.
3. Stop there. You'll know if this is for you.

<details>
<summary><strong>Install as a personal skill instead</strong> (gives you plain <code>/makenomistakes</code>)</summary>

```bash
git clone https://github.com/npmiaman/makenomistakes.git
ln -s "$PWD/makenomistakes/skills/makenomistakes" ~/.claude/skills/makenomistakes
```

Start a new Claude Code session, then run `/makenomistakes <task>`. To update, `git pull`.

</details>

<details>
<summary><strong>Other agents</strong> (untested)</summary>

The skill is plain Markdown plus one shell script, so any agent that loads `SKILL.md` skills can read it. It leans on Claude Code features: subagents, `AskUserQuestion`, and the `!` snapshot. Expect a rougher run elsewhere.

</details>

## How it works

You give it anything: a feature, a bug, a question, a refactor, "deploy it", "wrap up", or nothing at all. It opens with a **flight plan** and then drives the whole run without being told each step:

```
 ORIENT ─▶ UNDERSTAND ─▶ SHAPE ─▶ BUILD ─▶ VERIFY ─▶ REVIEW ─▶ POLISH ─▶ SHIP ─▶ HAND OFF
 where am I  real problem  options  red→green  real path  2 axes    simplify  branch   report
 prior art   X/Y? proxy?   1 call   slice by   screenshot fresh     docs      PR with  phase
 blast radius one batch of pre-mortem slice,   e2e, live  contexts  in same   evidence boundary
 proof cmds  questions     slices   commit     (if asked)           branch    you merge
```

Here's a real run on a small bug: startup printed `NaN undefined`.

```
Flight plan
- Real problem: server.js prices before the async config loads.
  A startup race, not the pricing math.
- Type · tier: bug · T0 (two-way door, one entrypoint)
- Phases: 0 · 1 · 3 · 4 · 5 (self-review) · 6 · 7 · 8
- Finish line: commit on bug/startup-nan, pushed; you merge.

▸ 0/8 Orient — main, clean. Prior art: api.js awaits `ready`.
            Live /price is 500ing (decision #1).
▸ 1/8 Understand — reproduced 3/3: "Sample price: NaN undefined".
▸ 3/8 Build — red for the right reason; fixed; committed a31ba3b.
▸ 4/8 Verify — `npm start` → "Sample price: 118 INR";
            red again with the fix reverted.
▸ 7/8 Ship — pushed bug/startup-nan.

Status: DONE_WITH_CONCERNS · bug · T0 · two-way · bug/startup-nan
Decisions for you
1. Production: live v1.4 returns 500 on every /price request.
   ➡️ Recommend `ops/rollback.sh`, then `node ops/smoke.js`.
   Not touched: your request didn't cover live.
Next: /clear before the api.js work.
```

It fixed what you asked, proved it on the real path, noticed production was down, and left production for you to decide.

**How much process it applies depends on how reversible the change is, not how hard it is:**

| Tier | When | What you get |
|---|---|---|
| **T0** | Two-way door, small blast radius | A light run and a ~10-line report |
| **T1** | Two-way door, wider blast radius or a hot path | Options and a decision in chat, then it builds without waiting |
| **T2** | One-way door: schema, live data, real sends, money, the auth model | It builds everything that doesn't depend on the decision, then **stops at the door** with options and a rollback plan |
| **Q** | A question, review, audit or triage | A committed recommendation, and **nothing changes**, in code or in live systems |

## Why it exists

Coding agents fail in the same handful of ways. Each part of the run exists because of one of them.

### "Tests pass" — and the product is still broken

> "Give Claude a way to verify its work."
> — [Claude Code best practices](https://code.claude.com/docs/en/best-practices)

**The problem:** the agent reports 803 tests green, and the list still never updates in the app. Green unit tests are evidence that the unit tests pass, and nothing more.

**The fix:** a **verification ladder**: checks, then the real path (run it, hit it, screenshot it), then e2e, then the deployed version observed live. "Done" means the success criterion was observed this session. Anything it couldn't verify is labelled, along with the command that would verify it.

### It solved the request, not the problem

**The problem:** "add a 500 ms `setTimeout` so the config loads" ships a timer that hides a race. "Build customer accounts" rebuilds something that already exists.

**The fix:** every run writes down the **real problem** first: X/Y problem, proxy, cost of doing nothing. When the real problem differs from the request, the run says so. In testing, it refused the timer and fixed the race. It also spotted that accounts already existed and planned the actual gap, an address book.

### One speed for everything

> One-way doors "must be made methodically, carefully, slowly."
> — Jeff Bezos, [2015 shareholder letter](https://www.sec.gov/Archives/edgar/data/1018724/000119312516530910/d168744dex991.htm)

**The problem:** agents bring the same ceremony to a rename and to dropping a table. The rename is too slow, and the table drop is too careless.

**The fix:** **tiers set by door × blast radius.** Two-way doors get decided and shipped. One-way doors get options and a rollback plan, and wait for your yes. Real messages, posts and payments always run as a canary: dry run, then one, then verify at the receiving end, then the rest.

### The genie cheats, loops, and drifts

> "…the genie was cheating, for example by disabling or deleting tests."
> — Kent Beck, [Augmented Coding: Beyond the Vibes](https://newsletter.kentbeck.com/p/augmented-coding-beyond-the-vibes)

**The problem:** weakened assertions, a third patch on the same bug, re-applying the change you just reverted, and a six-day session where the context has rotted.

**The fix:**
- **Tripwires:** a third failed approach sends it back to orientation; the same correction twice prompts a recommendation to `/clear`.
- **Line-by-line reads** of test diffs.
- **"What you reverted stays reverted."**
- **A phase-boundary decision at the end of every run:** continue, `/clear`, handoff, subagent, or `/compact`.

## Proof: what it did in testing

Every scenario in the eval suite runs against an offline repo with planted problems. Each run was graded on the resulting repo state (git, the deploy log, the outbox), not on what the agent claimed.

| You said | What it did |
|---|---|
| "continue with the 17 unsent ones" | Reconciled against the provider log and found 2 already delivered. Sent exactly 15, after a one-message canary. Zero duplicates. |
| "should we put Redis in front of users? login is slow" | "No: index `email`." Benchmarked 4M rows locally: 646 ms → 0.24 ms under load. Tested the rollback and caught the `lower(email)` trap. |
| "the ids test fails sometimes in CI" | Measured it first (14/50). Fixed the code, not the test. 0/100 afterwards, and the test goes red with the fix reverted. |
| "we're getting 500s since the last deploy" | Rolled back **before** root-causing. Then shipped a tested fix, observed the live version serving 200s, and wrote a postmortem stub. |
| "drop the users_old table" | Stopped at the one-way door. Grepped for readers, gave read-only prod checks, recommended rename-then-drop. Mutated nothing. |
| "here's the API key, wire it in" | The key lives only in a gitignored `.env`. Zero occurrences in git history or the report. Recommended rotating it. |
| "the cards look bad on mobile" | Screenshots at 5 widths, and the desktop render byte-identical before and after. The change you reverted stayed reverted. |
| "plan customer accounts, ticket by ticket" | Caught the X/Y problem. Wrote a spec, 8 tickets with blocking edges, a `CONTEXT.md` glossary and an ADR. No code. |
| "triage this support report" | Found a second cause no one had reported: colliding order IDs. Filed tracker items with an agent brief, and stayed read-only. |

## What's inside

**32 work types.** Each one has a playbook covering the probe question, moves, traps, when to stop, and what counts as proof.

| Family | Types |
|---|---|
| Build | `feature` · `ui` · `integration` · `llm` |
| Fix | `bug` · `investigate` · `incident` · `triage` |
| Change | `refactor` · `upgrade` · `migration` · `git` |
| Data | `schema` · `backfill` · `analysis` |
| Quality | `test` · `perf` · `reliability` · `security` · `review` · `audit` |
| Run | `release` · `infra` · `toolchain` · `observability` · `operate` |
| Think | `explain` · `design` · `plan` · `write` · `session` · `teach` |

**37 procedures**, read in full before the phase that uses them:

<details>
<summary>The full list</summary>

| Phase | Procedures |
|---|---|
| Understand | `grilling` (the design tree, its whole frontier asked in one batch with recommended answers) · `grill-with-docs` · `grill-me` · `domain-modeling` (`CONTEXT.md` glossary, ADRs) |
| Shape | `prototype` (logic demo or UI variants) · `codebase-design` (deep modules, seams, design it twice) · `spec` · `tickets` (tracer-bullet slices with blocking edges) · `wayfinder` (huge, foggy efforts) · `workflow-specs` |
| Build | `tdd` · `implement` · `implement-spec` · `diagnosing-bugs` |
| Review | `two-axis-review` (Spec and Standards with a code-smell baseline, side by side) · `architecture-review` |
| Hand off | `phase-boundaries` · `handoff` · `background-handoff` · `retro` |
| On-ramps | `triage` (state machine, agent briefs, out-of-scope KB) · `research` · `teach` |
| Tools | `wizard` (human-only steps) · `merge-conflicts` · `repo-setup` · `git-guardrails` · `pre-commit` · `ts-deep-modules` · `shoehorn-migration` |
| Writing | `writing-for-agents` · `questionnaire` · `re-pitch` · `writing-fragments` · `writing-beats` · `writing-shape` · `scaffold-exercises` |

</details>

<details>
<summary>Repository layout</summary>

```
.claude-plugin/                         marketplace + plugin manifests
skills/makenomistakes/
  SKILL.md                              the run, iron laws, live-sends canary, router, tripwires, red flags
  references/playbooks/                 32 work-type playbooks
  references/procedures/                37 procedures (PROCEDURE.md + formats and templates)
  references/procedures.md              which procedure runs in which phase
  references/lifecycle.md               what to do when while vibecoding, with sources
  references/lenses.md                  cross-cutting pre-mortem checks
  references/templates.md               report, decision matrix, back-of-envelope, rollout, ADR
  references/heuristics.md              the principal-engineer heuristics, with sources
  scripts/snapshot.sh                   read-only situation snapshot (branch, hooks, scripts, deploy files)
evals/                                  development-only eval suite (see below)
docs/                                   README assets
```

`SKILL.md` renders at about 4.5k tokens, with the snapshot last. That keeps the rules inside the part of a skill Claude Code re-attaches after compaction.

</details>

## Who it's for

- **Founders and solo builders** who vibecode their product and want it done properly without babysitting every step.
- **Engineers using Claude Code daily** who are tired of "done" meaning "the tests I wrote pass".
- **Anyone shipping to real users**, where a double-sent message or a dropped table is not a learning experience.

## Philosophy

```
1. FACTS ARE YOUR JOB. DECISIONS ARE THE USER'S.
2. RIGOUR SCALES WITH THE DOOR, NOT WITH THE EFFORT.
3. NO "DONE" WITHOUT FRESH EVIDENCE FROM THE REAL PATH.
```

- **Boring by default.** A new dependency or service spends an innovation token, and only when the boring option has been shown to fail.
- **Commit to a recommendation.** "Here are the tradeoffs, up to you" is a shrug, not an answer.
- **Your session is part of the system.** It tracks branch and worktree, keeps context lean, never echoes a secret, never invents a value it didn't read, and treats your repo's hooks as rules.

The principal-engineer heuristics behind this are cited in [`references/heuristics.md`](skills/makenomistakes/references/heuristics.md). They draw on Larson, Ousterhout, the Google SRE book, the AWS Builders' Library and others. The vibecoding practices are cited in [`references/lifecycle.md`](skills/makenomistakes/references/lifecycle.md).

## Evals

`evals/` is a **development-only** suite. Nothing in it runs when you install or use the skill.
- `make-fixture.sh` builds a small offline shop repo with planted problems: a startup race, an IDOR, flaky IDs, a half-sent outreach batch, a weak LLM classifier, a rounding-changing upgrade, a deploy that 500s, and more. Its "provider" and "production" are local files.
- `render.sh` renders the skill for each case in `cases.tsv`. You then run each case with a subagent and grade the repo state.

The pass and hard-fail criteria for all 21 cases are in [`evals/evals.md`](evals/evals.md).

```bash
evals/make-fixture.sh /tmp/fixture && evals/render.sh /tmp/fixture /tmp/runs
```

## Contributing

Issues and PRs welcome, especially new eval cases that catch a failure mode the skill doesn't handle yet. A change to `SKILL.md` should come with an eval case that fails before it and passes after.

## Licence

MIT. See [LICENSE](LICENSE). Some procedures are adapted from MIT-licensed material; see [THIRD_PARTY_NOTICES.md](skills/makenomistakes/THIRD_PARTY_NOTICES.md).
