# Principal-engineer heuristics

The judgement behind the steps in SKILL.md, for calls the steps don't settle. Each entry gives the move and its source. Sources were checked in October 2026; where only secondary sources were available, that is noted.

## Framing

- **Problem before solution.** Write the problem down before any solution. If no solution looks obvious, the problem isn't clear yet. — Will Larson, https://lethain.com/good-engineering-strategy-is-boring/
- **Working backwards.** Start from the finished customer experience (the launch note, the hard FAQs). If the announcement wouldn't make a user want it, rethink the idea. — Amazon, via *Working Backwards* (secondary sources only)
- **Goals and non-goals.** A non-goal is a plausible goal you chose not to pursue, not the negation of a goal. — Malte Ubl, https://www.industrialempathy.com/posts/design-docs-at-google/
- **What does the business actually want from this?** Ship toward that, not toward the ticket text. — Sean Goedecke, https://www.seangoedecke.com/how-to-ship/
- **Three maps.** Before acting, ask: where am I (locator), where is the friction (topographic), where is the value (treasure). — Tanya Reilly, *The Staff Engineer's Path*, via https://lethain.com/exercise-draw-three-maps/

## Deciding

- **Type 1 / Type 2 doors.** One-way doors "must be made methodically, carefully, slowly". Two-way doors "can and should be made quickly". The common failure is running two-way doors through one-way-door process. — Bezos, 2015 shareholder letter, https://www.sec.gov/Archives/edgar/data/1018724/000119312516530910/d168744dex991.htm
- **70% information.** Most decisions should be made with about 70% of the information you wish you had. — Bezos, 2016 letter, https://www.aboutamazon.com/news/company-news/2016-letter-to-shareholders
- **Commit to a recommendation.** Say what's possible, what's impossible, and what's risky. Drop detail that doesn't change the decision. The failure is "the lack of a clear opinion at all". — Goedecke, https://www.seangoedecke.com/clarity/
- **Design it twice.** The first design is rarely the best. Produce at least two radically different ones and compare them. — John Ousterhout, *A Philosophy of Software Design* (via Larson's notes, https://lethain.com/notes-philosophy-software-design/)
- **Innovation tokens.** You get about three. First ask, "How would we solve this without adding anything new?" Adding a technology is easy and living with it is hard. When the new thing replaces an old one, commit to removing the old one. — Dan McKinley, https://boringtechnology.club/

## Sizing

- **Back-of-envelope.** Size the problem in orders of magnitude before choosing an architecture. — Jeff Dean's latency numbers, https://gist.github.com/jboner/2841832 (2012 hardware: trust the exponents)
- **Model it small.** A tiny, literal simulation finds non-linear behaviour, such as the queueing knee, that intuition misses. Choosing what to leave out is the hard part. — Marc Brooker, https://brooker.co.za/blog/2022/04/11/simulation.html
- **Simplicity is a system property.** It belongs to the whole system, people and process included, not to individual components. Moving complexity into ops or coordination doesn't remove it. Size the architecture to the business's real scale. — Brooker, https://brooker.co.za/blog/2024/06/04/scale.html

## Designing

- **Deep modules.** The best modules have an interface much simpler than their implementation. Red flags: shallow modules, information leakage, pass-through methods, and a module that is hard to name or describe. — Ousterhout
- **Complexity = dependencies + obscurity.** Its symptoms are change amplification, cognitive load and unknown unknowns. Judge a design by what it does to those three. — Ousterhout
- **Define errors out of existence.** Shape interfaces so the error case can't happen, e.g. "ensure absent" rather than "delete, failing if missing". — Ousterhout
- **Minimise state; one writer per piece of state.** Stateless components restart cleanly. A cache is state, so add one only after a real attempt at the underlying speed (indexes first). — Goedecke, https://www.seangoedecke.com/good-system-design/
- **Spend design effort on the hot path.** Critical, high-volume paths have the fewest viable designs and fail worst. — Goedecke, same post
- **Prior art and consistency.** Research prior art in the codebase before starting a feature. "The cardinal mistake is inconsistency." Resist making your corner of the codebase nicer than the rest. — Goedecke, https://www.seangoedecke.com/large-established-codebases/

## Failure

- **Engineer the failure modes.** Defaults:
  - a killswitch on every automation
  - idempotency keys on retried writes
  - circuit breakers on high-volume calls
  - rate limiting fails open, auth fails closed
  - log the unhappy paths, watch p95 and p99 rather than averages

  — Goedecke, good-system-design
- **No untested fallbacks.** Fallback paths go unexercised, hide latent bugs, and turn partial outages into full ones. Strengthen the primary path, or run the "fallback" continuously as a failover. — AWS Builders' Library, https://builder.aws.com/content/3EuS9Sakq7L3VLQIF3qzfMfke1Y/avoiding-fallback-in-distributed-systems
- **Pre-mortem.** Assume it already failed and ask why. People generate more failure reasons this way than by asking "what could go wrong". — Gary Klein, HBR 2007 (paywalled; steps from secondary summaries)
- **Reliable enough, and no more.** 100% is the wrong reliability target. While error budget remains, ship. When it's spent, slow down. — Google SRE book, https://sre.google/sre-book/embracing-risk/
- **Normalisation of deviance.** Flaky tests, ignored alerts and skipped steps that have come to feel normal are the warning. — Dan Luu, https://danluu.com/wat/

## Shipping

- **Make the change easy, then make the easy change.** Keep structural and behavioural changes in separate steps. — Kent Beck, https://tidyfirst.substack.com/p/hinge
- **"How will you know when this breaks?"** Ask it before merging. Ship small changes. Separate deploy from release with flags. Whoever writes the change watches it deploy. — Charity Majors, https://charity.wtf/2019/05/01/friday-deploy-freezes-are-exactly-like-murdering-puppies/
- **Can I ship this right now?** If not, name the exact blocker. Do the scariest part first. The default state of a project is to not ship, and shipping takes deliberate effort. — Goedecke, how-to-ship
- **Migrations: derisk → enable → finish.** Start with the hardest consumer. Automate the easy 90%. Add a ratchet so no new code uses the old path. Do the long tail yourself. Celebrate the deletion, not the launch. — Larson, https://lethain.com/migrations/
- **Code health over perfection.** Approve a change once it definitely improves overall code health. "There is no such thing as 'perfect' code." — Google eng-practices, https://google.github.io/eng-practices/review/reviewer/standard.html

## Operating

- **Restore first, then root cause.** Separate roles with one incident commander who holds the state; keep a live incident document; the first priority is "stop the bleeding, restore service." — Google SRE book, Managing Incidents, https://sre.google/sre-book/managing-incidents/
- **Blameless postmortems with follow-up actions.** "Blameless postmortems are a tenet of SRE culture"; the postmortem records the actions that prevent recurrence. — Google SRE book, Postmortem Culture, https://sre.google/sre-book/postmortem-culture/
- **Canary against a control.** Send a slice of traffic to the new version and compare its signals to the control segment's, not to yesterday. — Google SRE workbook, Canarying Releases, https://sre.google/workbook/canarying-releases/
- **Idempotency keys make retries safe.** A client-generated key per request lets the server return the original result instead of repeating the side effect. — Brandur Leach, Stripe blog, https://stripe.com/blog/idempotency; Postgres implementation, https://brandur.org/idempotency-keys
- **Timeouts, bounded retries, backoff with jitter.** "Jitter adds some amount of randomness to the backoff to spread the retries around in time." — AWS Builders' Library, https://builder.aws.com/content/3EumjoZascWd1oZiEgL8ORlv3qE/timeouts-retries-and-backoff-with-jitter
- **Expand → migrate → contract.** Break a breaking change into three phases so old and new coexist while consumers move. — Danilo Sato, ParallelChange (on martinfowler.com), https://martinfowler.com/bliki/ParallelChange.html
- **Check authorization on every object access.** Attackers exploit endpoints by "manipulating the ID of an object that is sent within the request." — OWASP API Security Top 10 2023, API1 BOLA, https://api-security.owasp.org/editions/2023/en/0xa1-broken-object-level-authorization
- **Error analysis before evals and prompt changes.** Error analysis is "the single most valuable activity in AI development"; look at actual data first. — Hamel Husain, A Field Guide to Rapidly Improving AI Products, https://hamel.dev/blog/posts/field-guide/

## Building with agents

The session-level practices (verification ladder, context hygiene, doom loops, parallelism) are in [lifecycle.md](lifecycle.md) with their sources. The load-bearing ones:

- **Give the agent a way to verify its work**; skip the plan when the diff fits in one sentence; after two failed corrections, `/clear`. — Claude Code best practices, https://code.claude.com/docs/en/best-practices
- **Agents declare victory too early**; a feature list that starts failing plus a progress file keeps them honest across sessions. — Anthropic, Effective harnesses for long-running agents, https://www.anthropic.com/engineering/effective-harnesses-for-long-running-agents
- **Warning signs**: loops, functionality nobody asked for, and tests disabled or deleted. — Kent Beck, https://newsletter.kentbeck.com/p/augmented-coding-beyond-the-vibes
- **Reliability falls as input grows** — keep context focused. — Chroma, Context Rot, https://www.trychroma.com/research/context-rot
- **AI-written code still needs security review**: risky flaws in 45% of tests across 80 tasks. — Veracode 2025 GenAI Code Security Report, https://www.veracode.com/resources/analyst-reports/2025-genai-code-security-report/

## Failure modes of senior-but-not-principal engineers

- solving the stated problem instead of the real one
- cleverness over boring technology
- only one design considered
- making one corner of the codebase prettier than the rest
- adding caches and events before indexes and direct calls
- splitting into microservices "for simplicity"
- fallback theatre
- putting two-way doors through one-way-door process (or the reverse)
- claims about scale with no numbers behind them
- hedging instead of recommending
- treating the merge as "done"
- migrations that stop at 90%
- easy, visible low-impact work chosen over the work that matters (Larson, https://lethain.com/work-on-what-matters/)
