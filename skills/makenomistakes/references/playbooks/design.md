# design

**Probe:** What decision is actually being made, by when, and what would change it? Most "architecture" questions are one decision wearing a costume.

**Tier:** Q. The decision itself may be a one-way door — say which.

**Moves**
1. Read the code and constraints first — the answer is often implied by what exists.
2. Back-of-envelope the scale. Size the architecture to the business's real scale, not an imagined one.
3. Design it twice: at least two radically different shapes, one adding no new technology.
4. Decision matrix → one recommendation → door type → "revisit if…".
5. For a one-way door, write the mini design doc or ADR ([templates](../templates.md)).

**Delegate:** the `grilling` procedure to walk the user through the decisions that are theirs · the `prototype` procedure when 30 minutes of code would settle the argument · the `codebase-design` procedure for interfaces · the `domain-modeling` procedure for terminology and ADRs · `anthropic-skills:deep-research` for build-vs-buy and vendor comparisons.

**Traps:** a survey instead of a call · importing the last company's architecture · judging simplicity per component instead of for the whole system and the people running it.

**Proof:** the recommendation names the evidence it rests on (file paths, numbers) and the condition that would flip it.
