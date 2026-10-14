# analysis

**Probe:** What decision will this number inform? Define it exactly: numerator, denominator, time window, filters, and what's excluded.

**Tier:** Q — read-only. Use a replica or read-only credentials when production is involved.

**Moves**
1. Write the definition down before the query; ambiguity in "active users" or "conversion" is where analyses go wrong.
2. Query read-only; check row counts at each join for fan-out; watch timezones and duplicate events.
3. **Cross-check** against one independent number (a dashboard, a different table, a back-of-envelope).
4. Report truncated, sampled, or partial reads as such — "couldn't read" is not "zero".
5. Show the query so the user can rerun it.

**Delegate:** `dataviz` for charts · `anthropic-skills:deep-research` when the question needs outside sources.

**Traps:** join fan-out inflating counts · comparing different time windows · averages hiding the distribution · a confident number from partial data.

**Proof:** the query, its output, and the cross-check agreeing (or the discrepancy explained).

**Report adds:** the definition, the query, the caveats.
