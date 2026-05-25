---
name: task-planning
description: Use when the user asks for a task plan, implementation plan, work breakdown, sequencing, coordination notes, or when work needs explicit scope, decisions, risks, or verification notes before execution. Do not use for small, isolated, or obvious changes that do not need extra coordination.
---

# Task Planning

Create compact, implementation-oriented task plans for work that needs explicit scope, decisions, sequencing, coordination, or verification notes.

## Workflow

1. Decide whether a dedicated plan is needed.
2. If a dedicated plan is not needed, state that no separate plan is needed and provide a lightweight outline only when useful.
3. Identify the plan location from repository guidance, existing task areas, or user instruction.
4. If no active task area is defined, do not invent one. Provide the plan in the response unless the user asks to create a file.
5. Create or update one focused plan for the task.
6. Validate that the plan has a clear goal, scope, decisions, concrete steps, out-of-scope items, and verification notes when relevant.

## When To Create A Task Plan

- Create a dedicated task plan when the work needs explicit scope, decisions, sequencing, or verification notes.
- Skip a dedicated plan for small, isolated, or obvious changes that do not need extra coordination.
- Prefer one plan per meaningful task instead of mixing unrelated work into the same document.

## Task Areas

- Active plans:
  keep in-progress task plans in one active task area while the work is still underway.
- Shared backlog:
  keep one lightweight backlog file for small follow-up work that does not justify its own plan.
- Archive:
  move completed task plans into a searchable archive grouped by topic or area.

## Lifecycle

### Start

- Create a focused task plan when the work is large enough to need alignment.
- Give it a clear name such as `<feature>-plan.md` or `<integration>-plan.md`.
- Write only what the team needs to implement the task safely.

### Work

- Update status and decisions as scope becomes clearer.
- Keep the plan implementation-oriented.
- Add cross-task notes only when they are needed for current execution.

### Finish

- Mark the task as `Completed`.
- Move it out of the active task area into the archive.
- Remove obsolete notes from the active area once the archive copy exists.

## Plan Status

Use only the statuses needed by the repository. Default statuses:

- `Draft`: plan is being shaped and is not ready for implementation.
- `Planned`: plan is accepted for implementation.
- `In Progress`: implementation is underway.
- `Review`: implementation is complete and ready for review.
- `Completed`: reviewed and finished.
- `Archived`: completed plan moved out of active work.

## Status Rules

- Do not implement a `Draft` plan unless the user explicitly asks to proceed from the draft.
- Before implementation starts, update the plan to `In Progress` or confirm that it should move from `Draft` to `Planned`.
- After implementation, update the plan to `Review` when review is expected.
- Do not review implementation against a plan that is still `Draft` or not yet marked ready for review, unless the user explicitly asks for early review.
- If implementation diverges from the plan, update the plan with the new decision, scope, or verification notes before treating the work as ready.

## Recommended Plan Shape

Most task plans should stay compact and use only the sections that help current execution.

```md
# <Task Name>

## Status
- In Progress.

## Goal
- What outcome the task should create.

## Scope
- What is included.

## Decisions And Assumptions
- Constraints, decisions, and assumptions already known.

## Plan
- Concrete implementation notes.

## Verification
- Checks needed to validate the work.

## Out Of Scope
- What should not expand this task.
```

Consistency matters more than ceremony.

## Output Contract

- For persistent plans, create or update a single focused markdown file.
- For chat-only plans, provide the same structure in the response.
- Include `Out Of Scope` when scope could expand.
- Include verification notes when implementation risk is non-trivial.

## Updating Existing Plans

- Update the existing plan when it is still current.
- Rewrite stale or misleading sections instead of appending contradictory notes.
- Do not preserve obsolete active notes once the plan has moved to archive.

## Writing Rules

- Prefer concrete implementation notes over long narrative context.
- Record decisions that would otherwise be rediscovered later.
- Keep plans scoped to one subject area whenever possible.
- Use `Out Of Scope` to prevent silent scope growth.
- When multiple active tasks converge on the same shared files, contracts, or migrations, create a separate coordination plan if needed.

## Archive Rules

- Archive only completed work.
- Keep the original task intent visible after archiving; do not rewrite it into a polished final report.
- Group archives by reusable topic names, not by date alone.
- If a plan becomes stale instead of completed, remove it or rewrite it into a current task before it becomes misleading.

## Operating Principle

- Treat task planning documents as a working area for delivery, not as permanent product documentation.
- Treat the task archive as reusable implementation history.
