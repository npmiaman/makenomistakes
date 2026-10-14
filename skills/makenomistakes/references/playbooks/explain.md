# explain

**Probe:** What is the user about to do with the answer? Explain toward that.

**Tier:** Q.

**Moves**
1. Trace the real code path end to end, with `file:line` references, from entrypoint to effect.
2. Check history for the *why*: `git log -L`, `git blame`, the PR or ADR that introduced it.
3. Lead with a 2–3 sentence answer, then the trace; a small diagram when more than two components interact.
4. Separate what you read from what you infer.

**Delegate:** the `research` procedure for questions that need outside primary sources.

**Traps:** explaining from file names instead of reading the code · confident claims about code you didn't open · answering a different question than the one asked.

**Proof:** every claim is anchored to a file and line you read this session, or marked as inference.
