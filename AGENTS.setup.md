# AGENTS Setup

This file explains how to create a repository-specific `AGENTS.md` from this kit.

## Goal
Create an `AGENTS.md` in the repository root that acts as a hard entry gate for agent work in that repository.

The generated `AGENTS.md` should stay concise, but it must do more than act as a lightweight index. Its job is to define the startup reading protocol, route readers to the right documents, and make instruction-skipping less likely.

After setup is complete, this file should be removed unless the repository explicitly wants to keep setup instructions in version control.

## Core Documents
These are the default core documents to use in most repositories:
- `agents/guidance/engineering-principles.md`
- `agents/guidance/styleguide.md`

Use them unless the target repository clearly does not need them.

## Target Mapping
Copy applicable kit artifacts into the target repository using this mapping:

- `guidance/*` -> `agents/guidance/*`
- `skills/*` -> `agents/skills/*`

Do not copy artifacts that do not apply to the target repository.

Use the default artifact policy below:
- copy default artifacts unless the target repository clearly does not need them;
- copy evidence-triggered artifacts when repository evidence or the user request triggers them;
- copy explicit opt-in artifacts only when the user or repository asks for them.

## Additional Guidance
Add shared guidance only when it matches the target repository.

### Stack
- `agents/guidance/stack/dotnet.md`
- `agents/guidance/stack/dotnet-styleguide.md`

Use stack guidance only when the repository uses that stack.

### Design
- `agents/guidance/design/light-clean-architecture-ddd.md`

Use design guidance only when the repository follows that architectural style.

## Bundled Skills
Bundled skills are default artifacts. Copy them by default and route their use by trigger in the generated `AGENTS.md`; do not make every copied skill mandatory for every task.

- `agents/skills/acquire-codebase-knowledge/`
- `agents/skills/doublecheck/`
- `agents/skills/easy-specs/`
- `agents/skills/task-planning/`
- `agents/skills/verification-before-completion/`

## What The Agent Should Do
1. Inspect the repository structure and existing documentation.
2. Apply the default artifact policy: copy default artifacts, add evidence-triggered artifacts, and omit only clearly irrelevant artifacts.
3. Copy applicable reusable `guidance/` and `skills/` content from this kit into the target repository's `agents/` directory.
4. Remove unused copied kit artifacts and remove the temporary `ai-docs-kit/` directory after setup unless it is intentionally kept.
5. Create `AGENTS.md` as a hard entry gate that links only to documents that exist and apply.
6. In the generated `AGENTS.md`, require a fixed startup flow before substantial work begins.
7. If relevance is unclear, instruct readers to default to reading more rather than less.
8. Split the generated `AGENTS.md` into:
    - core required documents;
    - additional guidance with explicit triggers;
    - bundled skills with explicit triggers;
    - repository-local routing rules when repository-local artifacts exist.
9. Require the generated `AGENTS.md` to tell agents to explicitly acknowledge:
    - which core documents were read;
    - which bundled skills are relevant to the current task;
    - which repository-local artifacts were selected as relevant;
    - and, when no repository-local artifacts apply, to say so explicitly.
10. Remove `AGENTS.setup.md` after `AGENTS.md` is in place unless the repository explicitly wants to keep setup instructions.
11. Omit irrelevant sections and links.

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
- Bundled Skills
- Additional Guidance
- Repository-Local Artifacts
- Routing Matrix
- Required Acknowledgement
- Precedence
- Maintenance Rule

## Precedence
Use this order when guidance conflicts:
1. `AGENTS.md` defines the reading protocol and acknowledgement requirements.
2. The most specific linked stack, design, architecture, skill, or task document wins for its topic.
3. General guidance in `agents/guidance/` fills the remaining defaults.

If there is no conflict, all linked documents apply together.

## Maintenance Rules
- Keep `AGENTS.md` minimal.
- Keep `AGENTS.md` focused on reading order, routing, acknowledgement, and precedence.
- Put durable cross-project guidance in reusable guidance artifacts.
- Add stack, design, or skill artifacts only when the repository actually uses them.
- Remove copied artifacts that the repository does not use.
- Remove this setup file after it has been applied unless the repository explicitly keeps setup docs.
- Do not invent files, commands, or conventions that are not present in the repository.

## Completion Check
Before finishing, verify that:
- every linked file exists;
- every linked file is relevant to the repository;
- the generated `AGENTS.md` separates core required documents, additional guidance, bundled skills, and repository-local routing;
- the generated `AGENTS.md` requires explicit acknowledgement before substantial work;
- no copied kit files remain without a clear purpose;
- `AGENTS.setup.md` has been removed unless there is a clear reason to keep it;
- the precedence rule is clear;
- `AGENTS.md` stays concise.
