# Styleguide

## Scope
This document defines the default style and repository conventions for this project.

It complements `docs/agents/engineering-principles.md`. Use a more specific document when one exists for a particular stack, language, or subsystem.

## Language
- Write code comments and internal technical documentation in the primary language chosen by this repository.
- Use a single default language consistently unless a more specific document says otherwise.
- Use another language only when the task explicitly requires it, for example localization content, user-facing copy, or legally required wording.

## Commits
- Use the commit format required by this repository.
- If this repository does not define a different commit convention, use Conventional Commits: `type(scope): short summary`.
- Prefer short, concrete subjects that describe the intent of the change.
- Avoid vague subjects such as `WIP`, `fixes`, or `updates`.
- Group tightly related code, tests, and documentation into one logical commit when that improves reviewability.
- Split commits only when it materially improves review, rollback safety, or change isolation.

## Documentation Style
- Keep durable documentation concise, concrete, and easy to scan.
- Prefer instructions and rules over narrative history.
- Update existing documents before creating new ones when the topic already has a clear home.
- Do not duplicate the same guidance across multiple documents without a clear reason.

## Reviewability
- Prefer names, comments, and change descriptions that explain intent rather than restating syntax.
- Prefer compact code when it stays readable.
- Use multiline layout when it improves readability, scanning, or diff quality.
- Avoid staircase-style formatting and excessive vertical expansion when they add height without adding clarity.
- Avoid style-only churn in files that are otherwise unrelated to the task.
