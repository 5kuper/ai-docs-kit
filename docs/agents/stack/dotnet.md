# .NET Guidance

## Scope
This document defines the default rules for .NET and ASP.NET Core work in this repository.

It applies together with `docs/agents/engineering-principles.md` unless a more specific document says otherwise.

## Required Skill
- Before performing .NET-specific implementation, review, refactoring, or architecture work, use the installed `$aspnet-core` skill.
- If the required skill is unavailable, stop before making framework-specific changes and report the missing prerequisite.
- Do not guess on framework conventions, APIs, hosting patterns, middleware behavior, configuration binding, or upgrade paths without the required skill.

## When This Document Applies
- Building, restoring, testing, or publishing .NET projects.
- Changing ASP.NET Core host startup, middleware, routing, endpoints, controllers, filters, or API behavior.
- Changing dependency injection, configuration, options binding, logging, authentication, or authorization.
- Changing EF Core, `DbContext` usage, migrations, or database integration patterns.
- Introducing or changing framework-level packages, target frameworks, SDK assumptions, or platform features.

## Command Execution
- Use `scripts/dotnet-wrapper.ps1` for `dotnet restore`, `dotnet build`, `dotnet test`, `dotnet publish`, and `dotnet pack` in agent or sandbox sessions.
- The wrapper exists to make .NET CLI execution more predictable in agent and sandbox environments by handling environment-level setup for the command.
- Treat the wrapper as the default command path for .NET CLI work when repository-local guidance does not say otherwise.
- Use direct `dotnet` commands only when the repository explicitly documents that they are safe in the current environment.

## Working Defaults
- Respect the existing solution structure, application model, and target framework unless the task explicitly requires a change.
- Follow established repository patterns before introducing new framework patterns.
- Prefer built-in platform capabilities when they fit the repository's existing direction.
- Keep framework entry points and composition code simple and easy to trace.
- Do not introduce stack-wide migrations, package upgrades, or application-model rewrites without an explicit reason.

## Verification
- Run the smallest relevant build or test checks that materially reduce risk for the change.
- Prefer targeted project or test runs before broader solution-wide verification when that is sufficient.
- Expand verification when the change affects framework wiring, hosting, routing, configuration, authentication, authorization, persistence, or shared contracts.
- Use `docs/agents/workflow/verification.md` for more specific testing guidance.

## Documentation
- Update repository guidance when .NET-specific workflows, build or test expectations, configuration patterns, or hosting behavior change.
- Put durable stack guidance in this document or a more specific .NET document.
