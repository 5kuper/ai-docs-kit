# AGENTS Setup

This file explains how to create a repository-specific `AGENTS.md` from this kit.

## Goal
Create a short `AGENTS.md` in the repository root that acts as the entry point for agent guidance in that repository.

The generated `AGENTS.md` should stay small. Its job is to route readers to the right documents, not to duplicate all guidance directly.
After setup is complete, this file should be removed unless the repository explicitly wants to keep setup instructions in version control.

## Core Documents
These are the default documents to use in most repositories:
- `docs/agents/engineering-principles.md`
- `docs/agents/styleguide.md`
- `docs/agents/environment.md`

Use them unless the target repository clearly does not need them.

## Optional Documents
Add documents only when they match the target repository.

### Stack
- `docs/agents/stack/dotnet.md`
- `docs/agents/stack/dotnet-styleguide.md`

Use stack documents only when the repository uses that stack.

### Workflow
- `docs/agents/workflow/verification.md`
- `docs/agents/workflow/task-planning.md`

Use workflow documents only when the repository wants explicit verification or task-planning conventions.

### Design
- `docs/agents/design/light-clean-architecture-ddd.md`

Use design documents only when the repository follows that architectural style.

## Project-Specific Guidance
If the repository needs a local architecture or repository guide, create `docs/agents/project-guide.md` from:
- `docs/agents/project-guide.template.md`

Fill it with repository-specific structure, architecture, contracts, integrations, risks, and local documentation links.
Delete the template afterward unless the repository explicitly wants to keep local templates under version control.

## What The Agent Should Do
1. Inspect the repository structure and existing documentation.
2. Identify which default, stack, workflow, and design documents actually fit the repository.
3. Create `docs/agents/project-guide.md` from `docs/agents/project-guide.template.md` when project-specific guidance is needed.
4. Remove copied kit files that do not apply to the repository.
5. Create `AGENTS.md` as a short index that links only to documents that exist and apply.
6. Remove `AGENTS.setup.md` after `AGENTS.md` is in place unless the repository explicitly wants to keep setup instructions.
7. In `AGENTS.md`, separate documents that should always be read from documents that should be read only when relevant.
8. If `docs/agents/project-guide.md` points to more specific repository-local documents for the current task, direct readers to those documents after the project guide.
9. Omit irrelevant sections and links.

## Output Requirements
- The output file must be named `AGENTS.md`.
- Keep it short and easy to scan.
- Treat `AGENTS.md` as a routing document, not as a full handbook.
- Write linked documents as if they already belong to the target repository.
- Do not mention template placeholders or setup-only wording in the final output.
- Do not leave unused kit files in the repository just because they were copied in.
- Do not leave `AGENTS.setup.md` in the repository unless there is a clear reason to keep setup instructions.

## Required Sections In AGENTS.md
- Purpose
- Read order
- Read-when-relevant guidance
- Precedence
- Maintenance rule

## Precedence
Use this order when guidance conflicts:
1. Repository-specific guides such as `docs/agents/project-guide.md`
2. Stack documents in `docs/agents/stack/`, workflow documents in `docs/agents/workflow/`, and design documents in `docs/agents/design/`
3. Core documents in `docs/agents/`

If there is no conflict, all linked documents apply together.

## Maintenance Rules
- Keep `AGENTS.md` minimal.
- Put durable cross-project guidance in the reusable documents.
- Put repository-specific guidance in a local project guide.
- Add stack, workflow, or design documents only when the repository actually uses them.
- Remove copied documents that the repository does not use.
- Remove this setup file after it has been applied unless the repository explicitly keeps setup docs.
- Do not invent files, commands, or conventions that are not present in the repository.

## Completion Check
Before finishing, verify that:
- every linked file exists;
- every linked file is relevant to the repository;
- no copied kit files remain without a clear purpose;
- `AGENTS.setup.md` has been removed unless there is a clear reason to keep it;
- the read order is clear;
- the precedence rule is clear;
- `AGENTS.md` stays concise.
