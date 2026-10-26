# ai-docs-kit

A reusable kit of guidance documents and bundled skills for setting up agent guidance in other repositories.

This kit will evolve with experience from real agent workflows in real projects.

## Model

The kit separates agent guidance into two layers:

- `guidance/`: durable rules and stack or design guidance.
- `skills/`: task-specific workflows and bundled helper assets.

## How To Use

1. Copy this kit into the target repository.
2. Tell the agent: `use ai-docs-kit/AGENTS.setup.md`.
3. Let the agent copy applicable `guidance/` and `skills/` content into the target repository's `agents/` directory.
4. Let the agent create `AGENTS.md` when repository-specific guidance is needed.
5. Keep only the files that actually fit the repository.

After setup, the copied `ai-docs-kit/` directory is usually removed unless the repository intentionally keeps it.

## Layout

- `guidance/`: shared guidance documents for target repositories.
- `guidance/stack/`: stack-specific guides, such as .NET guidance.
- `guidance/design/`: design and architecture guides.
- `skills/`: bundled skills for reusable agent workflows.

## Target Layout

When applied to a target repository, copied kit content should live under:

```text
agents/
  guidance/
  skills/
```

## Skills

Some skills are original to this kit, and some are vendored from third-party skill libraries. Vendored skills are kept in-repo so the kit stays self-contained.

- `skills/acquire-codebase-knowledge/`: creates evidence-backed codebase knowledge documents.
- `skills/doublecheck/`: verifies factual claims with sourced checks.
- `skills/easy-specs/`: creates review-friendly design and task specs.
- `skills/task-planning/`: creates compact implementation-oriented task plans.
- `skills/verification-before-completion/`: requires fresh verification before completion claims.

Skill sources:

- Original to this kit: `easy-specs`, `task-planning`.
- Vendored from GitHub Awesome Copilot: `acquire-codebase-knowledge`, `doublecheck`.
- Vendored from Superpowers: `verification-before-completion`.

## Third-Party Material

Vendored third-party skills are listed in `THIRD_PARTY_NOTICES.md`.
