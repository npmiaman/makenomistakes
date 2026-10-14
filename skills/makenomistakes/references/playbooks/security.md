# security

**Probe:** What are the trust boundaries here, and what crosses them? If you can't name the boundaries, you're not ready to secure the feature.

**Tier:** T1. Raise to T2 for auth/permission model changes, crypto, or anything handling payments or credentials.

**Moves**
1. **Map trust boundaries**: user input, other tenants, webhooks, file uploads, third-party responses — and **LLM output** (it's untrusted input, including into tools).
2. Per boundary, a quick STRIDE pass (spoofing, tampering, repudiation, information disclosure, denial of service, elevation) — a lens, not a ceremony.
3. **Authz on every object access**: does the code check the caller owns/may see this specific object (IDOR/BOLA)? Find the codebase's existing check and follow it.
4. Write **abuse cases next to use cases**, and make the first one a test (user A reads user B's thing → denied).
5. Secrets: from env/secret store only; never logged, echoed, or committed. A leaked secret is **rotated first**, then purged from history.
6. A finding counts when it has an **entrypoint, a boundary crossed, and demonstrated impact** — otherwise it's labelled hardening, with a concrete failure scenario.

**Delegate:** `security-review` for the pending diff · `code-review` for correctness alongside.

**Traps:** a generic OWASP checklist with nothing demonstrated · reviewing only the diff and missing the boundary · client-side-only checks · trusting LLM output in a shell, SQL, or HTML context.

**Stop and surface when:** a live secret is exposed (rotation is the user's action) or the fix changes who can access what.

**Proof:** each confirmed finding demonstrated (a request, test or script showing the impact) and the fix's abuse test red → green.

**Report adds:** findings ranked by severity × confidence, each with entrypoint, boundary, impact, fix.
