# Task Planning

## Scope
This document defines how task planning and task-tracking documents are used in this repository.

## Purpose
- Keep short-lived delivery planning close to the codebase without turning the main documentation into a project-management archive.
- Make active work easy to discover for contributors and coding agents.
- Preserve completed plans as lightweight implementation history that can be reused later.

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

## Recommended Plan Shape

Most task plans in this repository should stay compact and use only the sections that help current execution.

```md
# <Task Name>

## Status
- In Progress.

## Goal
- What outcome the task should create.

## Scope
- What is included.

## Agreed Decisions
- Constraints and decisions already made.

## Plan
- Concrete implementation notes.

## Out Of Scope
- What should not expand this task.
```

Consistency matters more than ceremony.

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
