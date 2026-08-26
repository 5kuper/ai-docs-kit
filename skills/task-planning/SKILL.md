---
name: task-planning
description: Create or update durable task documents and implementation plans intended for review, handoff, coordination, or continued execution. Use when the user explicitly requests a task doc or when the work requires a persistent planning artifact. Do not use for the agent's own execution planning, tool-call sequencing, status checklists, or small plans that can be handled with update_plan or a short chat response.
---

# Task Planning

Create compact, implementation-oriented task documents that preserve scope, decisions, sequencing, coordination, and verification notes across execution.

This skill creates a planning artifact for review, handoff, or continued work. It does not manage the agent's internal execution steps.

## Workflow

1. Confirm that the requested output is a task document or another persistent planning artifact.
2. Identify the plan location from repository guidance, existing task areas, or user instruction.
3. If no active task area is defined, do not invent one. Provide the plan in the response only when the user explicitly requests a chat-delivered planning artifact.
4. Create or update one focused plan for the task.
5. Validate that the plan has a clear goal, scope, decisions, concrete steps, out-of-scope items, and verification notes when relevant.

## When To Create A Task Plan

- Create a dedicated task plan when the user requests a task doc or implementation plan as a deliverable.
- Also create one when implementation needs a persistent source of truth for scope, decisions, coordination, handoff, or verification.
- Skip a dedicated plan for small, isolated, or obvious changes that do not need a persistent artifact.
- Prefer one plan per meaningful task instead of mixing unrelated work into the same document.

## Do Not Use For

- The agent's own step-by-step execution planning.
- Tool-call sequencing or brief progress checklists.
- Routine use of `update_plan` to track work during the current task.
- Small plans or outlines that fit naturally in a short chat response.
- Deciding whether a task document is needed when there is no concrete reason to create one.

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
- When the user explicitly requests a planning deliverable in chat, provide the same compact structure in the response.
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
