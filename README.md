# ai-docs-kit

A reusable kit of documents, templates, and helper scripts for setting up agent guidance in other repositories.

This kit will evolve with experience from real agent workflows in real projects.

## How To Use

1. Copy `AGENTS.setup.md` and the kit files you want the agent to consider into the target repository.
2. Tell the agent: `use AGENTS.setup.md`.
3. Let the agent create `AGENTS.md` and `docs/agents/project-guide.md` when repository-specific guidance is needed.
4. Keep only the documents and scripts that actually fit the repository.

## Layout

- `docs/agents/`: shared documents and project templates for the target repository.
- `docs/agents/stack/`: stack-specific guides, such as .NET guidance.
- `docs/agents/workflow/`: workflow-specific guides, such as verification and task planning.
- `docs/agents/design/`: design and architecture guides.
- `scripts/`: reusable helper scripts.

## Scripts

### `scripts/bootstrap-agent-environment.ps1`
Sets up a shared agent environment for a machine or user profile.

It:
- prepares `%USERPROFILE%\.agent` and its shared folders;
- checks that `git` is available;
- configures `git safe.directory` for the trust scope you choose:
  specific repositories, repositories under a shared root, or all repositories with `-TrustAllSafeDirectories`.
- accepts explicit repo or worktree roots when the repository layout is not the default one.

Use it when you want to prepare the shared agent environment up front and reduce repeated fixes later.

### `scripts/dotnet-wrapper.ps1`
Runs `dotnet` commands in a predictable agent or sandbox environment.

It:
- prepares process-local paths for app data, CLI home, MSBuild extensions, and NuGet packages;
- uses `%USERPROFILE%\.agent` when possible and falls back to repo-local `.agent-local` when needed;
- creates a minimal `NuGet.Config` for the session;
- runs a safe `restore` before `build`, `test`, `publish`, or `pack` unless restore is explicitly skipped;
- accepts an explicit `-RepoRoot` when the repository layout is not the default one;
- restores the original environment after the command finishes.

## Recommended Use

1. Run `scripts/bootstrap-agent-environment.ps1` once if agent environment setup is needed.
2. Use `scripts/dotnet-wrapper.ps1` for .NET commands in agent or sandbox sessions.
