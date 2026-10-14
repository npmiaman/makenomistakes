# Procedures

The disciplines the run's phases use, one folder each under [procedures/](procedures/): `procedures/<name>/PROCEDURE.md` plus any formats and templates beside it. When a phase or playbook names **the `<name>` procedure**, read its `PROCEDURE.md` **in full before that phase** and follow it inline — a playbook line is a pointer, not the procedure. Inside a procedure, a backticked procedure name (`tdd`, `spec`) means that procedure; `/clear` and `/compact` are harness commands for the user.

**Tracker defaults** when `docs/agents/issue-tracker.md` is missing: a GitHub remote with a working `gh` → GitHub issues; otherwise the local tracker — files under `.scratch/<feature-slug>/` ([format](procedures/repo-setup/issue-tracker-local.md)). Triage roles use the canonical names (`needs-triage`, `needs-info`, `ready-for-agent`, `ready-for-human`, `wontfix`). Where a procedure says to run `repo-setup` first, use these defaults and add `repo-setup` to **Next** instead of stopping.

## The main flow, phase by phase

| Procedure | What it is | Where it runs |
|---|---|---|
| [`grilling`](procedures/grilling/PROCEDURE.md) | The design tree, worked in rounds; each round asks the whole **frontier**, numbered, each with a recommended answer; facts are yours to find, decisions are the user's | Phase 1 questions; `design`, `plan`; any "grill me" request |
| [`grill-with-docs`](procedures/grill-with-docs/PROCEDURE.md) · [`grill-me`](procedures/grill-me/PROCEDURE.md) | Grilling plus domain modeling (in a repo) · grilling with no paper trail (no repo) | Phase 1 |
| [`domain-modeling`](procedures/domain-modeling/PROCEDURE.md) | Challenge terms against `CONTEXT.md`, sharpen fuzzy words, test with concrete scenarios, update `CONTEXT.md` inline; an ADR only when hard to reverse + surprising + a real trade-off ([CONTEXT format](procedures/domain-modeling/CONTEXT-FORMAT.md), [ADR format](procedures/domain-modeling/ADR-FORMAT.md)) | Phase 1–2 |
| [`prototype`](procedures/prototype/PROCEDURE.md) | Throwaway code that answers one question: logic → a single HTML state-machine demo ([LOGIC](procedures/prototype/LOGIC.md)); UI → several variants on one route behind a URL param ([UI](procedures/prototype/UI.md)); kept on a `prototype/<name>` branch, the verdict folded in | Phase 2 detour |
| [`codebase-design`](procedures/codebase-design/PROCEDURE.md) | Module, interface, depth, seam, adapter, leverage, locality; the deletion test; one adapter = hypothetical seam, two = real ([deepening](procedures/codebase-design/DEEPENING.md), [design it twice](procedures/codebase-design/DESIGN-IT-TWICE.md)) | Phase 2; `refactor`, `design` |
| [`spec`](procedures/spec/PROCEDURE.md) | Synthesise, don't interview: seams at the highest point, then Problem · Solution · User Stories · Implementation Decisions · Testing Decisions · Out of Scope | Phase 2, multi-session work |
| [`tickets`](procedures/tickets/PROCEDURE.md) | Tracer-bullet vertical slices, each one fresh context window, each with **blocking edges**; wide refactors as expand → migrate → contract | Phase 2, multi-session work |
| [`implement`](procedures/implement/PROCEDURE.md) · [`implement-spec`](procedures/implement-spec/PROCEDURE.md) | Work tickets: `tdd` at agreed seams, typecheck and single test files often, full suite at the end, review, commit · a whole spec on one branch, the ready frontier fanned out to implementer subagents, one PR | Phase 3 |
| [`tdd`](procedures/tdd/PROCEDURE.md) | Red-green-refactor one behaviour at a time through the public interface; mock only at system boundaries ([tests](procedures/tdd/tests.md), [mocking](procedures/tdd/mocking.md)) | Phase 3 |
| [`diagnosing-bugs`](procedures/diagnosing-bugs/PROCEDURE.md) | A tight red feedback loop first; reproduce, minimise, 3–5 ranked falsifiable hypotheses, tagged instrumentation, fix + regression test, clean up ([HITL loop script](procedures/diagnosing-bugs/scripts/hitl-loop.template.sh)) | `bug`, `investigate`, perf regressions |
| [`two-axis-review`](procedures/two-axis-review/PROCEDURE.md) | **Spec** and **Standards** (repo standards + the Fowler smell baseline) as parallel subagents, reported side by side, never merged or reranked | Phase 5 |
| [`phase-boundaries`](procedures/phase-boundaries/PROCEDURE.md) | At a boundary, first yes wins: continue → `/clear` → handoff → subagent → `/compact <instruction>`; mid-phase, continue or split into subagents | Phase 8; long sessions |

## Everything else

| Procedure | What it is | Type |
|---|---|---|
| [`triage`](procedures/triage/PROCEDURE.md) | Issues and external PRs you didn't create, through the role state machine; verify the claim before grilling; [agent briefs](procedures/triage/AGENT-BRIEF.md); an [out-of-scope](procedures/triage/OUT-OF-SCOPE.md) knowledge base; every tracker post starts with the AI disclaimer | `triage` |
| [`wayfinder`](procedures/wayfinder/PROCEDURE.md) | A huge, foggy effort: a map with a Destination, decision tickets (research / prototype / grilling / task), fog in "Not yet specified", one ticket per session; hands off to `spec` when the way is clear | `plan` |
| [`architecture-review`](procedures/architecture-review/PROCEDURE.md) | Scope by git hot spots, find shallow modules with the deletion test, an [HTML report](procedures/architecture-review/HTML-REPORT.md) of deepening candidates, then grill the picked one | `audit` → `refactor` |
| [`research`](procedures/research/PROCEDURE.md) | A background agent reads primary sources and writes one cited Markdown file where the repo keeps notes | `explain`, `design`, `integration`, `upgrade` |
| [`wizard`](procedures/wizard/PROCEDURE.md) | An interactive bash script for steps only a human can do — credentials, dashboards, cutovers ([template](procedures/wizard/template.sh)) | `infra`, `integration`, `operate`, `schema` |
| [`merge-conflicts`](procedures/merge-conflicts/PROCEDURE.md) | Hunk by hunk, resolve by each side's intent traced to its primary source, finish the operation, never `--abort` | `git` |
| [`repo-setup`](procedures/repo-setup/PROCEDURE.md) | The repo's issue tracker, triage labels, and domain-doc layout into `docs/agents/` | `toolchain` |
| [`handoff`](procedures/handoff/PROCEDURE.md) · [`background-handoff`](procedures/background-handoff/PROCEDURE.md) | A portable doc in the OS temp dir: references artifacts instead of repeating them, suggested procedures, secrets redacted · the same, seeding a background session | `session` |
| [`re-pitch`](procedures/re-pitch/PROCEDURE.md) | A message didn't land: re-pitch with a little context, in Simplified Technical English, in the `CONTEXT.md` vocabulary | Any time |
| [`teach`](procedures/teach/PROCEDURE.md) | A stateful learning workspace: mission, resources, HTML lessons, learning records, retrieval and spacing | `teach` |
| [`questionnaire`](procedures/questionnaire/PROCEDURE.md) | The answer lives in someone else's head: grill the send, then write questions aimed at the gap | `write` |
| [`writing-for-agents`](procedures/writing-for-agents/PROCEDURE.md) | Skills, CLAUDE.md, AGENTS.md: context pointers, leading words, progressive disclosure, pruning | `write` |
| [`writing-fragments`](procedures/writing-fragments/PROCEDURE.md) · [`writing-beats`](procedures/writing-beats/PROCEDURE.md) · [`writing-shape`](procedures/writing-shape/PROCEDURE.md) | Mine fragments, shape beats, shape an article paragraph by paragraph | `write` |
| [`retro`](procedures/retro/PROCEDURE.md) | After a session, improve the agent's environment: navigation pointers, automated checks, coding standards, no-ops | `session` |
| [`workflow-specs`](procedures/workflow-specs/PROCEDURE.md) | Grill recurring workflows into implementable specs over sessions | `plan` |
| [`ts-deep-modules`](procedures/ts-deep-modules/PROCEDURE.md) | dependency-cruiser enforcing each package as a deep module | `toolchain`, `refactor` |
| [`git-guardrails`](procedures/git-guardrails/PROCEDURE.md) | Hooks blocking dangerous git commands | `toolchain` |
| [`pre-commit`](procedures/pre-commit/PROCEDURE.md) | Husky + lint-staged + Prettier + typecheck + tests | `toolchain` |
| [`shoehorn-migration`](procedures/shoehorn-migration/PROCEDURE.md) | Test files from `as` assertions to @total-typescript/shoehorn | `test`, `migration` |
| [`scaffold-exercises`](procedures/scaffold-exercises/PROCEDURE.md) | Exercise directories with problems, solutions, explainers | `teach`, `write` |
