---
name: dotnet-command
description: Use when running dotnet restore, build, test, publish, or pack in an agent, sandbox, or uncertain environment. Provides a bundled wrapper for predictable .NET CLI command execution without machine-level bootstrap.
---

# .NET Command

Run .NET CLI commands through a predictable, process-local wrapper in agent and sandbox environments.

## When To Use

- Running `dotnet restore`, `dotnet build`, `dotnet test`, `dotnet publish`, or `dotnet pack`.
- Running .NET CLI commands where user-profile, NuGet, MSBuild, workload resolver, or sandbox state may affect results.
- Working in a copied kit repository where this bundled skill is available and repository-local guidance does not define a safer command path.

## Command Path

Use the bundled wrapper from the target repository root:

```powershell
powershell -ExecutionPolicy Bypass -File .\agents\skills\dotnet-command\scripts\dotnet-wrapper.ps1 <dotnet-args>
```

Pass `-RepoRoot` when the command must run against a repository root other than the wrapper's parent kit root:

```powershell
powershell -ExecutionPolicy Bypass -File .\agents\skills\dotnet-command\scripts\dotnet-wrapper.ps1 -RepoRoot <repo-root> <dotnet-args>
```

## Rules

- Treat the wrapper as the default command path for .NET CLI work unless repository-local guidance says direct `dotnet` commands are safe.
- Use direct `dotnet` commands only when the repository explicitly documents that they are safe in the current environment.
- Do not use this skill as machine bootstrap or broad environment initialization.
- If `dotnet` is not available in `PATH`, report the missing prerequisite instead of guessing a workaround.
- For .NET and ASP.NET Core implementation, review, refactoring, or architecture guidance, use the installed `$aspnet-core` skill.

## Wrapper Behavior

The wrapper:

- prepares process-local app data, CLI home, MSBuild extension, and NuGet package paths;
- creates a minimal process-local NuGet config when needed;
- runs `restore` before `build`, `test`, `publish`, or `pack` unless restore is explicitly skipped;
- restores the original process environment after the command finishes.
