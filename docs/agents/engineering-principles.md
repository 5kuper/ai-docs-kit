# Engineering Principles

## Scope
This document defines the default engineering principles for this repository.

These principles apply unless a more specific document says otherwise.

## Compatibility And Contracts
- Preserve existing behavior unless the task explicitly requires a behavior change.
- Avoid silent breaking changes to public or shared contracts.
- When behavior must change, make the change explicit in code, tests, and documentation as needed.

## Change Scope
- Prefer small, focused changes over broad rewrites.
- Do not mix unrelated fixes, refactors, and behavior changes without a clear reason.
- Do not modify unrelated code or documentation unless it directly helps complete the task safely.
- Prefer extending or adjusting existing code paths over introducing parallel behavior without a clear need.

## Existing Patterns
- Follow existing repository patterns unless there is a strong reason to introduce a new one.
- Prefer predictable and maintainable solutions over clever but harder-to-understand ones.
- Keep entry points, integration boundaries, and orchestration code as simple as the repository's structure allows.

## Sensitive Data
- Never commit real secrets, credentials, or tokens.
- Never log secrets, credentials, tokens, or sensitive payload data.
- Use safe placeholders and redaction when documentation or logs need to describe protected values.

## Verification
- Keep verification effort proportional to the risk of the change.
- If behavior changes, add or update the minimum validation needed to make the change safe.
- Prefer the smallest verification that materially reduces risk.
- Low-risk changes may be verified with lightweight checks.
- High-risk changes need stronger verification, especially when they affect shared contracts, security, data handling, or critical user flows.

## Documentation
- Update documentation when durable rules, workflows, interfaces, or expected behavior change.
- If code changes and durable guidance changes together, update both in the same task.
- Do not turn temporary task notes into permanent guidance.
- Add new lasting guidance to the most specific document that owns that topic.

## Clarity
- Write comments and internal documentation in the primary language chosen by the repository.
- Keep changes easy to review and their intent easy to understand.

## Operational Transparency
- If the preferred tool, command, or workflow is unavailable, assess whether the fallback changes the result, risk, or scope.
- If the fallback materially affects correctness, safety, scope, or decision-making, stop and discuss the tradeoff before continuing.
- If the fallback only affects speed, convenience, or tooling ergonomics, continue with the work and report the fallback clearly afterward.
- Do not present a workaround as the ideal path.
- If a fallback becomes the normal path for the repository, update the relevant documentation instead of relying on repeated ad hoc explanations.

## When Unsure
- Make the safest reasonable assumption that preserves current behavior and limits blast radius.
- If a decision has non-obvious product, contract, data, or operational consequences, make the tradeoff explicit, ask the user before committing to it, and defer to more specific guidance when available.
