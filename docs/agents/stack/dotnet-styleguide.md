# .NET Styleguide

## Scope
This document defines repository-specific .NET and ASP.NET Core style overrides and clarifications.

Use it together with `docs/agents/stack/dotnet.md`. Do not use this document to restate general .NET platform guidance that already comes from the required `$aspnet-core` skill.

## Logging
- Use structured logging with named placeholders.
- Avoid interpolated log strings when structured logging is expected.
- Reuse existing safe-log helpers and normalizers instead of duplicating sanitization logic.
- Keep short log calls on one line when that remains readable.
- Use a multiline form only when a log call needs wrapping.
- Prefer compact multiline formatting when it stays readable.
- Use extra vertical spacing only when it makes the call easier to scan or maintain.
- In multiline log calls, keep the template and arguments as compact as readability allows instead of forcing one argument per line by default, for example:

```csharp
logger.LogInformation(
    "Message",
    arg1, arg2, arg3);
```

## Configuration
- Keep configuration section names, options binding, and environment variable override names aligned exactly.
- Reflect durable configuration shape changes in the repository's configuration documentation or template files.
- Use placeholders for secrets in committed configuration examples and templates.

## Dependencies
- Do not mix major package versions without an explicit compatibility check and a documented reason.
- Prefer changes that stay aligned with the repository's current framework and package direction unless the task explicitly requires otherwise.
