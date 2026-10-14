# review

**Probe:** What was this change supposed to do? Find the issue, PR description, ticket, or commit messages — the review is against that intent, not just against style. For "go through the new changes", first summarise what changed and why.

**Tier:** Q — the review changes nothing unless asked to fix.

**Moves**
1. Read the whole diff, then the surrounding code of every touched function — bugs hide in what the diff didn't change but now interacts with.
2. Review on separate axes in parallel subagents and report them side by side, never merged or reranked (the `two-axis-review` procedure): **Spec** and **Standards** (repo standards + the Fowler smell baseline: mysterious name, duplicated code, feature envy, data clumps, primitive obsession, repeated switches, shotgun surgery, divergent change, speculative generality, message chains, middle man, refused bequest — always judgement calls, the repo overrides), plus: **correctness** (edge cases, failure modes, concurrency) · **spec** (does what was asked, no more) · **standards** (matches the codebase) · **operability** (how will we know it broke; rollback).
3. Read line by line: auth, money, data deletion and migrations, and **test diffs** (weakened or deleted assertions). Skim UI styling and throwaway code.
4. Each finding: the concrete input/state that triggers it and the wrong outcome. No failure scenario → label it an opinion.
5. Approve when it definitely improves code health, even if not how you'd write it.

**Delegate:** `code-review` (correctness, fresh context) · the `two-axis-review` procedure when the repo documents standards · `security-review` for security-sensitive diffs.

**Traps:** nit avalanches burying the one real bug · reviewing only green lines · blocking on taste · asking a reviewer to "find gaps" (it always will) instead of correctness and requirements.

**Proof:** every correctness finding has a failure scenario; where cheap, demonstrated with a test or a run.

**Report adds:** a verdict (approve / approve with fixes / request changes) and findings by axis.
