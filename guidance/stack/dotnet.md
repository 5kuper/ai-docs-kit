# .NET Guidance

## Scope
This document defines the default rules for .NET and ASP.NET Core work in this repository.

It applies together with `agents/guidance/engineering-principles.md` unless a more specific document says otherwise.

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
- Run `dotnet restore`, `dotnet build`, `dotnet test`, `dotnet publish`, and `dotnet pack` directly from the target repository root, with an explicit solution or project when needed.
- Diagnose SDK, filesystem permission, network, or package-source failures from the actual command output. Apply environment overrides only when a specific failure requires them, and keep overrides local to the process.
- Verify the actual compiler/test output and exit code before reporting success. Preserve the target repository's test isolation requirements.

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

## Documentation
- Update repository guidance when .NET-specific workflows, build or test expectations, configuration patterns, or hosting behavior change.
- Put durable stack guidance in this document or a more specific .NET document.
