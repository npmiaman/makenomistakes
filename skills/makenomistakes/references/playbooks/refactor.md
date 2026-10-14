# refactor

**Probe:** What change does this refactor make easy? A refactor with no next change it enables is taste. Name the change.

**Tier:** set by door × radius. Dead code with no external consumers lives here; removing something others consume is a `migration`.

**Moves**
1. Pin behaviour first: if coverage is thin on the code you'll move, add characterisation tests.
2. Structural change only — no behaviour change in the same step. Small, mechanical, individually green commits.
3. Aim for **deep modules**: a small interface over a lot of implementation. Deletion test: if deleting the module would scatter its complexity across callers, it earns its keep.
4. Use codemods, IDE refactors, or scripted edits for wide renames; never hand-edit 50 call sites.
5. After a feature works and before the next one is the cheapest moment for a cleanup pass.

**Delegate:** the `codebase-design` procedure for module/interface decisions · `simplify` for a cleanup pass on recent changes · the `architecture-review` procedure for a wide deepening survey.

**Traps:** "while I'm here" behaviour fixes · a new pattern used once (now there are two ways) · abstracting with one adapter (one adapter = hypothetical seam; two = real) · test expectations edited to match.

**Proof:** typecheck and the full suite green before and after with no test changes except additions; the diff shows no behaviour change.
