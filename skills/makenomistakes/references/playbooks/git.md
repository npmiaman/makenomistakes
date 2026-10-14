# git

**Probe:** What should the end state contain — which paths from which refs? Describe it before touching anything.

**Tier:** T0 locally. Raise to T2 for anything that rewrites shared history (force-push, rebase of a pushed branch) or discards uncommitted work.

**Moves**
1. **Backup first**: `git branch backup/<name>-<date>` (or a tag) before any rewrite; `git stash` or commit uncommitted work.
2. State where you are: branch, worktree, ahead/behind, uncommitted files. Worktrees share one repo — know which one you're in.
3. Surgery as **paths from refs**: `git restore --source <ref> -- <paths>` to take specific files from a branch, rather than hand-merging.
4. Conflicts: resolve by each side's intent, hunk by hunk; never pick a side wholesale without reading it.
5. Find when something changed with `git log -S`, `git log -L`, `git bisect`.

**Delegate:** the `merge-conflicts` procedure for an in-progress merge/rebase.

**Traps:** force-pushing over someone else's commits · `reset --hard` with uncommitted work · resolving conflicts by taking "ours" everywhere · operating in the wrong worktree.

**Stop and surface when:** the operation would rewrite pushed history or drop commits not authored in this session.

**Proof:** for each source ref, `git diff <ref> -- <paths>` is empty where the end state says it should be; typecheck/tests green on the result; the backup ref exists.
