# Verification

## Scope
This document defines the default verification guidance for this repository.

Use it to choose how much checking a change needs. More specific stack or project documents may refine these rules.

## Goal
- Verification should reduce the real risk introduced by a change.
- Prefer the smallest verification that materially improves confidence.
- Do not default to the heaviest possible test path when a narrower check is enough.

## Verification By Risk
- Low risk:
  documentation changes, formatting-only updates, narrow refactors without behavior change, or small isolated fixes with obvious local impact.
- Medium risk:
  local behavior changes, non-trivial branching, validation changes, mapping changes, or modifications that affect nearby workflows.
- High risk:
  authentication, authorization, shared contracts, data handling, persistence, integrations, concurrency, migrations, or critical user and business flows.

## Choosing Verification Depth
- Start with the narrowest relevant check for the change.
- Expand verification when the change touches shared paths, risky boundaries, or behavior that is hard to inspect locally.
- Use lightweight or manual verification for simple low-risk changes when that is enough to make the change safe.
- Use stronger automated verification when the risk is high or when regressions would be expensive.

## When Automated Tests Should Change
- Add or update automated tests when behavior changes in a way that should remain stable.
- Add or update automated tests when fixing a regression that should stay fixed.
- Add or update automated tests when changing shared contracts, validation behavior, authorization rules, persistence behavior, or critical branching logic.

## Test Suite Discipline
- Keep verification scope proportional to the change size and risk.
- Prefer the cheapest test level that can catch the likely regression.
- Do not move low-level checks into the most expensive end-to-end suites unless there is a clear reason.
- Keep expensive suites focused on end-to-end outcomes, cross-boundary behavior, and critical workflows.

## Recording Verification
- If full verification was not run, say so clearly.
- If a risk is being accepted temporarily, make that explicit instead of implying the change was fully validated.
- Report verification scope, verification gaps, and any accepted risk explicitly to the user.
