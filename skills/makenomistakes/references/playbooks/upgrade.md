# upgrade

**Probe:** Why upgrade now — a CVE, a needed feature, end-of-life? Which versions are crossed, and what broke in each?

**Tier:** T1. Raise to T2 when a breaking change alters money, auth, data formats, or anything users see.

**Moves**
1. Read the **changelog and migration guide for every version crossed**, not just the target. List each breaking change and grep for every affected call site.
2. One major version at a time; land each green before the next.
3. CVEs: triage by **reachability** — is the vulnerable function actually called on a path an attacker can reach? Record a reason and review date for anything deferred.
4. Review the lockfile diff: unexpected transitive bumps, new install/postinstall scripts, new maintainers on critical packages.
5. Every new dependency is checked to exist and be the intended package (agents hallucinate package names).

**Delegate:** the `research` procedure for changelog legwork.

**Traps:** a multi-package big-bang bump · `audit fix --force` · rewriting test expectations to match new behaviour · "tests pass" while behaviour changed in untested paths.

**Stop and surface when:** a breaking change alters user-visible output, money or auth semantics — the new behaviour is a product decision.

**Proof:** each breaking change marked handled or not-applicable with evidence; full suite plus a smoke run of the real path; the scanner clears the CVE.

**Report adds:** the versions crossed and the breaking-change checklist.
