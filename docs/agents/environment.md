# Environment

## Scope
This document defines how environment setup should be handled in this repository.

## Goal
- Keep command execution predictable in agent and sandbox environments.
- Separate shared environment setup from per-command execution setup.
- Prefer the smallest setup that solves the real environment problem.

## Setup Levels

### Machine-Level Setup
- Use machine-level setup for shared preparation of a user profile or machine.
- Keep it focused on shared environment prerequisites, not repository-specific build logic.
- Use `scripts/bootstrap-agent-environment.ps1` when the repository adopts that setup path.
- Pass explicit repo or worktree roots when the repository layout is not the default one.

### Command-Level Setup
- Use command-level wrappers when a specific tool needs process-local environment handling.
- Prefer wrappers over global machine changes when the problem is limited to one stack or command path.

## Default Guidance
- Use machine-level setup only when it reduces repeated environment friction across sessions or repositories.
- Use stack-specific wrappers when a command is sensitive to sandbox, cache, config, or user-profile issues.
- Do not use machine-level setup to hide repository-specific build or test complexity.
- Do not use command wrappers to perform broad machine initialization.

## Bootstrap Script Guidance
- `scripts/bootstrap-agent-environment.ps1` is a shared helper for agent environment setup.
- Its git trust scope depends on how it is called: it may trust one repository, repositories under a shared root, or all repositories.
- It should stay general and should not become a stack-specific bootstrap script.

## Wrapper Guidance
- A wrapper should exist only when it makes a command path more predictable or safer in the current environment.
- A wrapper should handle environment-level concerns for that command, not replace repository-specific workflow documentation.
- A wrapper should prefer process-local changes over global machine changes.
- Allow explicit roots or similar overrides when repository layout needs them.
- For .NET repositories, see `docs/agents/stack/dotnet.md` for guidance on `scripts/dotnet-wrapper.ps1`.

## When To Escalate
- If a documented wrapper solves the problem, use it before introducing broader setup changes.
- If machine-level setup is required to avoid repeated environment failures, use the documented bootstrap path.
- If neither approach resolves the issue, report the missing prerequisite or environment constraint clearly.
