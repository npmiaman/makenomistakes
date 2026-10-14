# write

**Probe:** Who reads this, and what should they do after reading it?

**Tier:** T0. Raise when the text is external or binding (a public announcement, a contract, a policy).

**Moves**
1. Lead with the point; the reader's next action is explicit.
2. Every claim comes from evidence gathered this session; say what wasn't checked.
3. Follow the repo's conventions: its doc locations, its `CONTEXT.md` vocabulary, its ADR numbering. ADRs are superseded, never deleted.
4. Status updates: status, risks, what changed since last time, the new date if something slipped, and fallback scope options.
5. Docs that describe behaviour change in the same commit as the behaviour.

**Modes.** The answer lives in someone else's head → the `questionnaire` procedure (grill the send — who it's for, what you need back — then write questions aimed at the gap). Docs agents consume (skills, CLAUDE.md, AGENTS.md) → the `writing-for-agents` procedure. Articles → the `writing-fragments` → `writing-beats` / `writing-shape` procedures. A domain glossary or decision → the `domain-modeling` procedure.

**Delegate:** `pr` for PR bodies · the `domain-modeling` procedure for glossary and ADRs · the `writing-for-agents` procedure for CLAUDE.md, AGENTS.md and skills · `anthropic-skills:docs` for shareable documents.

**Traps:** prose that restates the diff · claims the evidence doesn't support · a second doc convention alongside the existing one.

**Proof:** every factual claim traces to a file, command output, or link; the reader's next action is stated.
