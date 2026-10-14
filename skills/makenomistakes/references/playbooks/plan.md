# plan

**Probe:** Where is the destination, and is the fog in the **decisions** (what to build) or in the **execution** (how to sequence it)?

**Tier:** Q — planning changes no code.

**Moves**
1. Map the files and modules involved before writing tasks.
2. Cut **vertical slices**: each the smallest unit with its own test cycle, independently shippable, reviewable on its own.
3. Each slice carries: type and tier (from the router), its proof command, and a **Consumes / Produces** block (exact interfaces it relies on and provides).
4. One-way doors and the scariest slice go first; mark slices that can run in parallel (no shared Consumes) — but parallel writers are capped at ~3, because review is the bottleneck.
5. List open decisions with a recommended answer and who decides. Slice 1 must be startable now.
6. Write the plan where the repo keeps plans (e.g. `docs/plans/`), otherwise in chat. A plan longer than the code it describes has written the code instead.

```
### Slice n — <name> · <type> · T<n>
Consumes: <interfaces/data it relies on>   Produces: <what it provides>
Change: <files, one line each>              Proof: <command / observation>
```

**Modes.** Fog in the **decisions** → chart a map with the `wayfinder` procedure (Destination, decision tickets, fog, one ticket per session) — it produces decisions, not deliverables, and hands off to the `spec` procedure once clear. A settled idea too big for one session → the `spec` procedure (synthesise, don't interview; highest seams) then the `tickets` procedure (one file per ticket under `.scratch/<feature>/issues/` or real tracker issues, blockers first). Executing them → the `implement` procedure per ticket with `/clear` between, or the `implement-spec` procedure (ready frontier fanned out to ≤3 implementer subagents, one PR). A recurring workflow to design → the `workflow-specs` procedure.

**Delegate:** decision fog → the `wayfinder` procedure · a settled plan → the `spec` procedure then the `tickets` procedure (they need the repo set up via the `repo-setup` procedure) · executing tickets → the `implement` procedure · parallel slices → `superset:orchestrate`, only when the user asked to fan out · continuing in a fresh context → `/claude-handoff`.

**Traps:** horizontal layers instead of slices · tasks with no proof · "handle edge cases" as a task · six agents fanned out on a usage-limited plan.

**Proof:** for a multi-session plan, the spec exists on the tracker in the to-spec template (local default `.scratch/<feature-slug>/spec.md`) and each ticket is its own issue/file (`.scratch/<feature-slug>/issues/NN-<slug>.md`, blockers first) with Blocked by and acceptance criteria; every slice has type, tier, proof, and Consumes/Produces; slice 1 has no open decision blocking it; every one-way door names who decides.

**Report adds:** the slices, the open decisions, and "Say `go 1`".
