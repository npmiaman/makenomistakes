# Lifecycle — what to do when, while building with an agent

The run in SKILL.md (orient → understand → shape → build → verify → review → polish → ship → hand off) is this guide, executed. Read it for the *why* behind a phase, or when the session itself needs attention. The playbooks answer *what kind of work is this?*; this answers *where are we, and what should happen next?* Each row is a **trigger → action → who**. **Agent** rows you do yourself. **You** rows are the user's to type — recommend them under **Next**, with the exact command.

Sources are tagged: **[Docs]** Claude Code docs · **[P: name]** a practitioner · **[Data]** observed in real sessions of this kind of work. Links at the bottom.

## Mode — decide by stakes

| When | Do | Who |
|---|---|---|
| Throwaway prototype, spike, weekend toy | Vibe mode is fine: move fast, skim the code, keep it out of production paths. | Agent |
| Code that ships, is maintained, or touches money, auth, data, or real people | Engineering mode: the full steps of this skill. Nothing lands that can't be explained. [P: Willison] | Agent |

## Start

| When | Do | Who |
|---|---|---|
| First session in a repo | Run the tests first — it orients you and shows the project's shape. [P: Willison] Find the run/verify commands. | Agent |
| Repo has no CLAUDE.md | Recommend `/init`, then prune to what the agent can't infer. [Docs] | You |
| Starting any task | State branch, worktree, and where the code runs. Pick model and effort **before** starting — switching mid-task drops the prompt cache. [Docs] | Agent / You |
| New task, but this session carries an unrelated history | Wrap up (the `session` playbook), then `/clear`. One task per session. [Docs] [Data] | You |
| Resuming earlier work | `claude --continue` / `--resume`, or start fresh from the progress file. Read it and `git log` first. [Docs] | You / Agent |

## Shape and plan

| When | Do | Who |
|---|---|---|
| The diff fits in one sentence | Skip the plan; do it. [Docs] | Agent |
| Multi-file, unclear UX, or you can't state "done" | Interview the user (questions with recommended answers), write a one-page spec: goal, files, interfaces, **out of scope**, how it will be verified. [Docs] [P: Harper Reed] | Agent |
| Spec or plan is settled and the session is long | Implement in a fresh session that starts from the spec file. [Docs] | You |
| Plan mode for exploring before edits | Shift+Tab or `/plan`; Ctrl+G edits the plan. Plans survive compaction; chat-only instructions may not. [Docs] | You |
| Large brownfield change | Research → plan → implement, each writing a file the next phase reads. [P: Horthy] | Agent |

## Build

| When | Do | Who |
|---|---|---|
| Implementing | One slice per loop: one test or one behaviour, made green, then the next. [P: Beck] | Agent |
| Logic with a clear oracle, or any bug fix | Red/green: watch the test fail first, then make it pass. [P: Willison] [Docs] | Agent |
| A slice is green | Commit (per the repo's flow). Structural and behavioural changes in separate commits. [P: Beck] | Agent |
| About to run a risky shell command | Commit or stash first — checkpoints don't capture shell or subagent edits. [Docs] | Agent |
| The feature works, before starting the next | A cleanup pass: delete dead code, simplify, update docs. `simplify` if listed. [P: Hashimoto] | Agent |

## Verify — the ladder

Climb as far as the change reaches. "Done" is the highest rung reached, stated plainly.

| Rung | Evidence | Who |
|---|---|---|
| 1. Checks | typecheck, lint, unit tests — output read, not assumed | Agent |
| 2. Real path | run the app, hit the endpoint, run the CLI, render the screen and screenshot it [P: Willison — agentic manual testing] | Agent |
| 3. End-to-end | the repo's e2e or verification skill (e.g. a live-pipeline suite); when it spends real money or inputs, the user starts it | You / Agent |
| 4. Live | the deployed version observed serving (SHA/version + a smoke request) | Agent |
| Stronger gate wanted | `/goal <measurable end state>`, or a Stop hook that blocks "done" until checks pass. [Docs] | You |

Unit tests green while the product is broken is the most common false "done" [Data]: a UI that doesn't update, a job that sticks, a deploy that never landed.

## Review

| When | Do | Who |
|---|---|---|
| Before calling it done | `code-review` in a fresh context; limit it to correctness and the stated requirements, not "find gaps" (it always will). [Docs] | Agent |
| Diff touches auth, money, deletion, migrations — or tests | Read line by line; weakened or deleted assertions are the classic reward hack. [P: Beck] | Agent / You |
| Security-sensitive diff | `security-review`. [Docs] | Agent |

## Context

| When | Do | Who |
|---|---|---|
| End of a phase, before a long new task | Write progress to a file, then `/compact <what to keep>`. [Docs] [P: Horthy] | Agent then You |
| Only part of the history is noise | `/rewind` → "Summarize from here". Abandoning a path entirely: `/rewind` rather than compact. [Docs] | You |
| Something must survive compaction | Put it in CLAUDE.md or the plan file, not just chat. A boundary like "don't push" also gets a deny rule. [Docs] | Agent / You |
| Session has run for days or across several unrelated tasks | Wrap up and `/clear` — long contexts degrade reliability; there is no official percentage, so use phase boundaries. [Docs] [P: Chroma] [Data] | You |
| Quick side question | `/btw <question>` keeps it out of context. [Docs] | You |

## Course-correct

| When | Do | Who |
|---|---|---|
| Doom-loop signs: repeating attempts, unrequested features, tests disabled or deleted | Stop. Say what's happening. Narrow the next instruction. [P: Beck] | Agent |
| After two failed corrections on the same issue | `/clear` and a better first prompt using what was learned. [Docs] | You |
| Third approach abandoned | The design is wrong, not the attempt: back to step 1, change the design, or hand the hard core to the human. [P: Hashimoto] | Agent |
| The user reverted a change | It stays reverted. Ask what they want instead. [Data] | Agent |
| Change was bad | `Esc Esc` / `/rewind` restores code and/or conversation. [Docs] | You |

## Parallel

| When | Do | Who |
|---|---|---|
| Research, exploration, verbose output | Subagents — only the summary returns to context. [Docs] | Agent |
| Independent tasks in one repo | Separate worktrees (`claude --worktree <name>`); state which worktree each runs in. [Docs] | You |
| How many writers | ~3 at most, or the user's stated cap — review capacity and usage limits are the bottleneck; land one significant change at a time. [P: Willison] [Data] | Agent / You |
| Large mechanical change | Try the fan-out on 2–3 files first, then scale. [Docs] | Agent |

## UI iteration loop

| When | Do | Who |
|---|---|---|
| Taste is open ("make it look better", "like this") | Collect the references once; show 2–3 variants; iterate on the pick. [Data] | Agent |
| A stream of small tweaks | Batch them; apply together; screenshot once per batch. | Agent |
| Requests contradict (flip, then un-flip) | Show both as variants; ask which stands. | Agent |

## Secrets and values

| When | Do | Who |
|---|---|---|
| The user pastes a secret | Never repeat it. Put it in the env file, keep it out of git, recommend rotating it since it's now in the transcript. [Data] | Agent |
| A value is needed (password, ID, URL, count) | Read it from its source and say where; otherwise mark it unknown. Never invent one. [Data] | Agent |
| Tooling might overwrite an env file | Back it up first. | Agent |

## Learn — make the fix permanent

| When the same mistake recurs | Make it… | Who |
|---|---|---|
| Mechanical (format, a banned call, a file location, a required doc update) | a **hook** or lint rule — "never send an LLM to do a linter's job". [Docs] [P: HumanLayer] | Agent / You |
| Behavioural (this must keep working) | a **test**. | Agent |
| A judgement call the agent can't infer | one **CLAUDE.md** line; prune lines that no longer change behaviour. [Docs] | Agent / You |
| A procedure used sometimes | a **skill**. [Docs] | Agent / You |
| A session went badly | `/retro`. | You |

## Cost and effort

| When | Do | Who |
|---|---|---|
| Planning, tricky bugs, architecture | Higher effort (`/effort`, or `ultrathink` for one turn). [Docs] | You |
| Routine edits | Lower effort; don't toggle model/effort mid-task. [Docs] | You |
| Before a big fan-out | Estimate it; run a small slice first. [Docs] | Agent |

## Sources

- Claude Code best practices — https://code.claude.com/docs/en/best-practices ("Give Claude a way to verify its work"; "If you could describe the diff in one sentence, skip the plan"; "After two failed corrections, `/clear`")
- Claude Code context window — https://code.claude.com/docs/en/context-window
- Anthropic, Effective harnesses for long-running agents — https://www.anthropic.com/engineering/effective-harnesses-for-long-running-agents
- Simon Willison, Agentic manual testing — https://simonwillison.net/guides/agentic-engineering-patterns/agentic-manual-testing/ · First run the tests — https://simonwillison.net/guides/agentic-engineering-patterns/first-run-the-tests/
- Kent Beck, Augmented Coding: Beyond the Vibes — https://newsletter.kentbeck.com/p/augmented-coding-beyond-the-vibes
- HumanLayer (Dex Horthy), Getting AI to Work in Complex Codebases (ACE-FCA) — https://github.com/humanlayer/advanced-context-engineering-for-coding-agents/blob/main/ace-fca.md
- Chroma, Context Rot — https://www.trychroma.com/research/context-rot
- Harper Reed, My LLM codegen workflow — https://harper.blog/2025/02/16/my-llm-codegen-workflow-atm/
- Mitchell Hashimoto, Vibing a non-trivial Ghostty feature — https://mitchellh.com/writing/non-trivial-vibing
- Addy Osmani, The 70% problem — https://addyo.substack.com/p/the-70-problem-hard-truths-about
- Veracode, 2025 GenAI Code Security Report (risky flaws in 45% of tests) — https://www.veracode.com/resources/analyst-reports/2025-genai-code-security-report/
