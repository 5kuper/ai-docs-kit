# ai-docs-kit

A reusable kit of guidance documents, role profiles, and bundled skills for setting up agent guidance in other repositories.

This kit will evolve with experience from real agent workflows in real projects.

## Model

The kit separates agent guidance into three layers:

- `guidance/`: durable rules and stack or design guidance.
- `roles/`: reusable operating profiles for agents.
- `skills/`: task-specific workflows and bundled helper assets.

## How To Use

1. Copy this kit into the target repository.
2. Tell the agent: `use ai-docs-kit/AGENTS.setup.md`.
3. Let the agent copy applicable `guidance/`, `roles/`, and `skills/` content into the target repository's `agents/` directory.
4. Let the agent create `AGENTS.md` when repository-specific guidance is needed.
5. Keep only the files that actually fit the repository.

After setup, the copied `ai-docs-kit/` directory is usually removed unless the repository intentionally keeps it.

## Layout

- `guidance/`: shared guidance documents for target repositories.
- `guidance/stack/`: stack-specific guides, such as .NET guidance.
- `guidance/design/`: design and architecture guides.
- `roles/`: reusable agent role profiles.
- `skills/`: bundled skills for reusable agent workflows.

## Target Layout

When applied to a target repository, copied kit content should live under:

```text
agents/
  guidance/
  roles/
  skills/
```

## Skills

Some skills are original to this kit, and some are vendored from third-party skill libraries. Vendored skills are kept in-repo so the kit stays self-contained.

- `skills/acquire-codebase-knowledge/`: creates evidence-backed codebase knowledge documents.
- `skills/dotnet-command/`: runs .NET CLI commands through a predictable agent-friendly wrapper.
- `skills/doublecheck/`: verifies factual claims with sourced checks.
- `skills/task-planning/`: creates compact implementation-oriented task plans.
- `skills/verification-before-completion/`: requires fresh verification before completion claims.

Skill sources:

- Original to this kit: `dotnet-command`, `task-planning`.
- Vendored from GitHub Awesome Copilot: `acquire-codebase-knowledge`, `doublecheck`.
- Vendored from Superpowers: `verification-before-completion`.

## Roles

Roles are reusable operating profiles for agents. They describe when to use a working mode, what that mode is responsible for, what it must not do, and what kind of output it should produce.

They are guidance files, not a guarantee that every agent runtime will enforce role switching automatically. In target repositories, `AGENTS.md` should route agents to relevant roles when the repository adopts explicit role-based work.

- `roles/assistant.md`: default role when no specialized role clearly fits.
- `roles/architect.md`: technical direction, tradeoffs, and architecture decisions.
- `roles/coder.md`: implementation work across code, documentation, configuration, and tests.
- `roles/reviewer.md`: independent review of changes, risks, and verification quality.

## Third-Party Material

Vendored third-party skills are listed in `THIRD_PARTY_NOTICES.md`.
