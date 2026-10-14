# feature

**Probe:** What user outcome does this serve, and what is the smallest version that delivers it? Write the two-sentence launch note a user would read — if it isn't compelling, the feature is the wrong shape.

**Tier:** set by door × radius. Raise to T2 when it creates a public contract (API others call, a schema, a pricing or permission rule).

**Moves**
1. Find the nearest existing feature and copy its shape: routing, data access, auth/tenancy checks, flags, analytics events, error handling, tests. Hidden rules live there.
2. Decide the interface first (API shape, props, CLI flags, data model). For a non-trivial interface, design it twice.
3. Cut to a **tracer bullet**: the thinnest end-to-end slice that touches every layer. Ship it, then widen.
4. Name the product decisions you'd otherwise make silently — empty states, errors, limits, permissions — and either follow precedent or list them for the user with a recommendation.
5. Risky or user-visible behaviour goes behind a flag when the codebase has flags.

**Delegate:** the `tdd` procedure for test-first logic · the `prototype` procedure when the UX or state model is unclear · the `grilling` procedure when many product decisions are open (they're the user's — one batch, each with a recommendation) · the `implement` procedure when a spec and tickets already exist.

**Traps:** building the general framework for one case · silent product decisions · skipping the permission/tenancy check the neighbour has · scope creep the user never asked for.

**Stop and surface when:** the feature needs a decision only the user can make (pricing, policy, who can see what) and no precedent answers it.

**Proof:** the feature exercised on the real path (app, endpoint, CLI) for the happy path and the top pre-mortem failure, plus tests in the repo's existing style. UI-facing features also meet the `ui` proof.
