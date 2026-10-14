# test

**Probe:** What behaviour must never silently break? Test that — through the public interface — not the implementation.

**Tier:** T0.

**Moves**
1. Match the repo's test style, runner and file layout; find the nearest existing test and copy its shape.
2. Test behaviour at a seam callers use; avoid asserting internals that refactors will churn.
3. Each test **goes red** when the behaviour breaks: mutate the code (or revert the fix) and watch it fail, then restore.
4. Tests own their state: create data through the app's API, isolate, no dependence on order, wall-clock, network, or production data.
5. Prefer a few meaningful integration tests over many brittle mocks; mock only at true boundaries (network, clock, vendor).

**Delegate:** the `tdd` procedure for red-green-refactor (its [tests](../procedures/tdd/tests.md) and [mocking](../procedures/tdd/mocking.md) notes: behaviour through the public interface, mock only at system boundaries). TypeScript test files full of `as` assertions → the `shoehorn-migration` procedure.

**Traps:** tests that assert the current (buggy) behaviour · snapshot tests nobody reads · mocking the thing under test · tests that pass with the code deleted.

**Proof:** each new test observed red with the behaviour broken and green with it intact; the suite green.
