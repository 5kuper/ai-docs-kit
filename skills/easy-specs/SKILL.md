---
name: easy-specs
description: Create or refactor review-friendly design specs and implementation task specs using short visible summaries plus collapsible required details. Use when drafting durable technical design docs, task-docs for agents, implementation plans, or converting heavy specs into a format that supports fast manual review without losing execution precision.
---

# Easy Specs

## Core Idea

Write specs in two layers:
- visible `At A Glance` and `Intent:` bullets for fast human review
- collapsible `<details>` blocks for required implementation, contract, testing, and verification detail

Do not reduce precision to make a document easier to review. Keep precision in required details and make review intent visible in summaries.

## Section Pattern

Use this pattern for substantial sections:

```md
## Section Name
Intent:
- Decision, scope, or risk reviewers need to approve.
- Important constraint or expected outcome.

<details>
<summary>Required details</summary>

- Exact instructions, contracts, fields, paths, or verification steps.
- Constraints the implementer must follow.

</details>
```

Rules:
- Use `At A Glance` near the top for a fully visible control overview.
- Use `Intent:` at the start of substantial sections for review-worthy decisions, not decorative restatements.
- Use `<summary>Required ... details</summary>` when hidden content is normative.
- Keep `At A Glance` fully visible; do not put collapsible details inside it.
- Avoid role-specific labels such as `Review Summary` unless the section is only for reviewers.
- Keep critical guardrails such as boundary, out-of-scope, and must-not-change visible.
- Do not make every paragraph collapsible; use one details block per meaningful section.
- Keep summaries aligned whenever details change.

## Design Specs

Use design specs for durable technical decisions, boundaries, contracts, tradeoffs, and testing strategy.

Recommended sections:
- `Status`
- `At A Glance`
- `Purpose`
- `Architectural Decision`
- `Boundaries`
- `Contracts`
- `Testing Strategy`
- `Review Checks`

Design spec summaries should answer:
- What decision is being accepted?
- What existing behavior must remain unchanged?
- What layer or module owns the behavior?
- What test level is expected?
- What should reviewers inspect manually?

Avoid implementation sequencing in design specs. Put delivery steps in task specs.

## Task Specs

Use the repository's task-planning guidance for task lifecycle, required sections, status rules, locations, and archive behavior.

Easy Specs only changes presentation:
- add `At A Glance` near the top when it helps manual review
- add `Intent:` bullets to substantial sections
- put detailed implementation instructions in `<details>` blocks
- keep boundary, out-of-scope, and must-not-change guardrails visible

Task spec summaries should answer:
- What will be implemented?
- What will not be implemented?
- Which files or layers may be touched?
- Which files or layers must not be touched?
- What verification is required?
- What should reviewers focus on?

Keep task specs implementation-oriented. Link source design docs instead of repeating them when they exist.
When no separate design spec exists, the task spec may own local design decisions. In that case:
- record those decisions in the repository's decision/assumption section
- keep them scoped to the task
- make review-facing summaries explicit enough for approval
- create a durable design spec only when the decision should outlive the task or guide future work
Testing and verification sections should reference the active repository testing policy instead of redefining it.

## Review Workflow

When creating or refactoring a spec:
1. Identify document type: design spec or task spec.
2. Add or update `At A Glance`.
3. Convert heavy sections to `Intent:` plus required details.
4. Keep boundary and must-not-change items easy to see.
5. Ensure paths, commands, and layer names match current repository docs.
6. Check that testing guidance matches the repository testing policy.

Reject or revise documents when:
- summaries and details disagree
- hidden details contain scope changes not visible in summary
- task specs duplicate design specs instead of linking them
- design specs contain step-by-step implementation work
- test levels contradict the repository testing policy
