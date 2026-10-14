# incident

**Probe:** Who is hurting right now, how badly, and since when? What changed just before it started?

**Tier:** T1 — when the user brings you the incident, restoring service is the priority, so reversible mitigations (rollback, flag off, scale up, drain) are taken **without waiting**. An incident you stumble on during other work is surfaced, not acted on (see Tripwires). Raise to T2 when the only available mitigation is itself one-way (data deletion, a destructive restore).

## Phase A — restore

1. **Classify**: user-facing symptom, scope (% of users/requests), start time.
2. **Correlate with the last change**: deploy, config, flag, dependency, traffic, upstream vendor. "What touched it last" is the first suspect.
3. **Mitigate with the fastest two-way lever** before root-causing: roll back the deploy, flip the flag, revert the config, shed load. Snapshot logs/state before restarting anything.
4. **Verify recovery on the user-facing symptom** (smoke test, error rate, the actual page) — not on "the rollback command succeeded".
5. Keep a running timeline (UTC, what was observed, what was done).

## Phase B — root cause and postmortem (after recovery)

1. Reproduce the cause on a non-production path; fix it as a `bug` with a red regression test.
2. Write the postmortem: ask "what conditions allowed this?", not "who did this?" Five whys, each with an **Evidence:** line, ending at "why didn't a safety net catch it?"
3. Action items are typed (**Prevent / Detect / Mitigate**), each with one owner and a concrete deliverable — "be more careful" is not an action.

```
# Postmortem: <title> (<date>)
Impact: <who, how many, how long>       Detected by: <alert | user | luck>
Timeline (UTC): <time — event>…
Trigger: <the change>                   Root cause: <the condition that allowed it>
Why chain: 1. … (Evidence: …) …
What went well / poorly / where we got lucky
Actions: | Type | Action | Owner | Due |
```

**Delegate:** the `diagnosing-bugs` procedure in phase B · `write` playbook for the postmortem prose.

**Traps:** debugging before mitigating · parallel uncoordinated changes · declaring recovery from a command's exit code · editing or deleting logs · leaving the incident "open" after mitigation with no owner.

**Stop and surface when:** no two-way lever exists, or the mitigation needs credentials/access you lack.

**Proof:** the user-facing symptom observed recovered (smoke output, error rate at baseline) this session; in phase B, the regression test red → green.

**Report adds:** the timeline, the mitigation taken, and the postmortem (or its stub).
