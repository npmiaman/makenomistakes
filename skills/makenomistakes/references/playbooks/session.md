# session

**Probe:** Is the user asking where things stand, wanting to wrap up, hand off, or start something new — and is this session still the right place to do it?

**Tier:** Q. Committing during a wrap-up follows the repo's normal flow.

Read [lifecycle](../lifecycle.md) in full; it is this type's playbook. Then produce one of:

**Status** ("where are we?")
- branch, worktree, ahead/behind, uncommitted files
- what was changed this session, what is **verified** (with the evidence) and what is **not**
- what is deployed, where, and the observed version — or "not deployed"
- open decisions and anything blocked

**Wrap-up / handoff** ("wrap up", "hand off", "I'm done for today")
1. Get the tree to a clean state: commit verified work per the repo's flow; leave unverified work on a clearly named branch, never mixed in.
2. Write a progress file where the repo keeps plans (else `PROGRESS.md` at root, if the user agrees): goal, what's done with evidence, what's next, decisions made, gotchas learned.
3. Give the handoff text for `/claude-handoff` or a fresh session: one paragraph of context plus the first prompt to paste.
4. Decide the **phase boundary** with the tree in the [`phase-boundaries` procedure](../procedures/phase-boundaries/PROCEDURE.md): continue → `/clear` → handoff → subagent → `/compact <instruction>`; first yes wins. A handoff doc follows the `handoff` procedure: written to the OS temp dir, referencing specs/ADRs/commits by path instead of repeating them, a "suggested procedures" section, secrets redacted.
5. A session that went badly → run the `retro` procedure (environment fixes: navigation pointers, automated checks, coding standards) or recommend `/retro`.

**Start fresh** ("new feature", "next thing")
- If the current session carries unrelated history, recommend wrap-up then `/clear` before starting.
- State branch and worktree for the new work; pick model and effort up front.

**Proof:** every status line backed by a command run this session (`git status`, the test command, the version check).
