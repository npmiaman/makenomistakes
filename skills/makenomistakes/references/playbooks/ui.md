# ui

**Probe:** What does "good" look like — is there a reference (image, URL, Figma, an existing screen)? Which states and breakpoints matter? Get the reference once, up front, instead of discovering taste one tweak at a time.

**Tier:** T0. Raise when the change alters a flow's behaviour (that's `feature`) or touches a design system others consume.

**Moves**
1. Reuse the design system: tokens, components, spacing scale, and any UI rules in steering files or memory (e.g. "fill the screen", "no filler copy"). Grep for an existing component before writing one.
2. When taste is open, show **2–3 variants** side by side and let the user pick, then iterate on the pick — not 30 serial micro-tweaks.
3. Batch feedback: collect every requested change, apply them together, show once.
4. Cover the **state matrix**: loading, empty, error, long text, many items; breakpoints at least mobile (~375px) and desktop (~1280px); keyboard focus and labels.
5. Change only what was asked. A restyle the user didn't request is noise; a reverted tweak stays reverted.

**Delegate:** `run` to launch the app · a browser skill for screenshots, whichever is listed (`superset:browser`, `anthropic-skills:built-in-browser`, `anthropic-skills:chrome-browser`) · the `prototype` procedure for variants · the Figma MCP when a figma.com URL is given.

**Traps:** pixel-matching one viewport · "looks good now" with nothing seen · inventing new tokens/colours instead of using the system · reapplying a change the user undid.

**Stop and surface when:** the user's requests contradict each other (flip, then un-flip) — show both as variants and ask which one stands.

**Proof:** screenshots of each relevant state × breakpoint taken this session, compared against the reference. With no browser available, mark the visual check unverified and give the exact URL/command to look.

**Report adds:** the screenshots (paths), and which states were checked.
