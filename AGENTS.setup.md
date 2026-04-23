# AGENTS Setup

This file explains how to create a repository-specific `AGENTS.md` from this kit.

## Goal
Create an `AGENTS.md` in the repository root that acts as a hard entry gate for agent work in that repository.

The generated `AGENTS.md` should stay concise, but it must do more than act as a lightweight index. Its job is to define the startup reading protocol, route readers to the right documents, and make instruction-skipping less likely.

After setup is complete, this file should be removed unless the repository explicitly wants to keep setup instructions in version control.

## Core Documents
These are the default core documents to use in most repositories:
- `docs/agents/engineering-principles.md`
- `docs/agents/styleguide.md`
- `docs/agents/environment.md`

Use them unless the target repository clearly does not need them.

If the repository has `docs/agents/project-guide.md`, treat it as a core required document for the generated `AGENTS.md`.

## Additional Shared Documents
Add shared documents only when they match the target repository.

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

In the generated `AGENTS.md`, treat `docs/agents/project-guide.md` as:
- a core required document when it exists;
- the repository-specific routing source;
- the owner of the `Local Documentation Map` used to discover deeper local documents.

Delete the template afterward unless the repository explicitly wants to keep local templates under version control.

## What The Agent Should Do
1. Inspect the repository structure and existing documentation.
2. Identify which core, stack, workflow, and design documents actually fit the repository.
3. Create `docs/agents/project-guide.md` from `docs/agents/project-guide.template.md` when project-specific guidance is needed.
4. Remove copied kit files that do not apply to the repository.
5. Create `AGENTS.md` as a hard entry gate that links only to documents that exist and apply.
6. In the generated `AGENTS.md`, require a fixed startup flow before substantial work begins.
7. Make `docs/agents/project-guide.md` the repository-specific routing source in that startup flow when it exists.
8. Require readers to inspect the `Local Documentation Map` in `docs/agents/project-guide.md` and read every linked repository-local document that applies to the current task.
9. In the generated `AGENTS.md`, make repository-local documents mandatory when the task touches an area named in the `Local Documentation Map`.
10. If relevance is unclear, instruct readers to default to reading more rather than less.
11. Split the generated `AGENTS.md` into:
    - core required documents;
    - additional shared documents with explicit triggers;
    - repository-local trigger rules derived from `docs/agents/project-guide.md`.
12. Require the generated `AGENTS.md` to tell agents to explicitly acknowledge:
    - which core documents were read;
    - which repository-local documents were selected as relevant;
    - that the routing decision came from `docs/agents/project-guide.md`;
    - and, when no repository-local documents apply, to say so explicitly.
13. Remove `AGENTS.setup.md` after `AGENTS.md` is in place unless the repository explicitly wants to keep setup instructions.
14. Omit irrelevant sections and links.

## Output Requirements
- The output file must be named `AGENTS.md`.
- Keep it concise and easy to scan.
- Treat `AGENTS.md` as a routing and startup-protocol document, not as a full handbook.
- Write linked documents as if they already belong to the target repository.
- Do not mention template placeholders or setup-only wording in the final output.
- Do not leave unused kit files in the repository just because they were copied in.
- Do not leave `AGENTS.setup.md` in the repository unless there is a clear reason to keep setup instructions.
- Do not turn the generated `AGENTS.md` into a duplicate of the reusable documents.

## Required Sections In AGENTS.md
- Purpose
- Required Startup Flow
- Core Required Documents
- Repository-Local Documents
- Additional Shared Documents
- Repository-Local Trigger Matrix
- Required Acknowledgement
- Precedence
- Maintenance Rule

## Precedence
Use this order when guidance conflicts:
1. `AGENTS.md` defines the reading protocol and acknowledgement requirements.
2. `docs/agents/project-guide.md` defines repository-specific routing and local-document discovery.
3. The most specific linked workflow, stack, design, architecture, or task document wins for its topic.
4. General documents in `docs/agents/` fill the remaining defaults.

If there is no conflict, all linked documents apply together.

## Maintenance Rules
- Keep `AGENTS.md` minimal.
- Keep `AGENTS.md` focused on reading order, routing, acknowledgement, and precedence.
- Put durable cross-project guidance in the reusable documents.
- Put repository-specific guidance in a local project guide and linked repository-local documents.
- Add stack, workflow, or design documents only when the repository actually uses them.
- Remove copied documents that the repository does not use.
- Remove this setup file after it has been applied unless the repository explicitly keeps setup docs.
- Do not invent files, commands, or conventions that are not present in the repository.

## Completion Check
Before finishing, verify that:
- every linked file exists;
- every linked file is relevant to the repository;
- the generated `AGENTS.md` uses `docs/agents/project-guide.md` as the routing source when it exists;
- the generated `AGENTS.md` requires repository-local discovery through `Local Documentation Map` when that map exists;
- the generated `AGENTS.md` separates core required documents, additional shared documents, and repository-local triggers;
- the generated `AGENTS.md` requires explicit acknowledgement before substantial work;
- no copied kit files remain without a clear purpose;
- `AGENTS.setup.md` has been removed unless there is a clear reason to keep it;
- the precedence rule is clear;
- `AGENTS.md` stays concise.
