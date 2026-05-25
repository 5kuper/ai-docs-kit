# Light Clean Architecture DDD

## Scope
Use this document only in repositories that follow a simplified Clean Architecture with DDD-style boundaries.

This is a pragmatic guide for day-to-day implementation. It does not require strict textbook Clean Architecture or full tactical DDD everywhere.

## Architectural Intent
- Keep business rules separate from framework and infrastructure concerns.
- Keep dependencies flowing inward toward the core business model.
- Prefer clear boundaries and predictable responsibilities over architectural purity for its own sake.
- Accept pragmatic shortcuts only when they reduce complexity without weakening important boundaries.

## Typical Layer Responsibilities
- Presentation or entry points:
  receive requests, validate transport-level input, enforce boundary concerns, and delegate to the application layer.
- Application:
  coordinate use cases, workflows, permissions, transactions, and integration boundaries.
- Domain:
  hold business rules, invariants, domain concepts, and business decisions that must remain stable.
- Infrastructure:
  implement persistence, external services, messaging, files, caches, and framework-specific integrations.

## Dependency Rules
- Domain should stay independent from infrastructure and delivery frameworks by default.
- Application should depend on domain concepts and orchestrate infrastructure through interfaces or other clear boundaries.
- Infrastructure may depend on application and domain contracts when needed to implement them.
- Entry points may depend on application contracts and transport-specific concerns, but should not become the main home for core business logic.

## Working Defaults
- Put business decisions in the domain when they express stable rules of the problem space.
- Put workflow orchestration in the application layer when it coordinates multiple steps, policies, or integrations.
- Keep transport, storage, and framework code at the edges.
- Reuse existing layer boundaries before introducing new cross-cutting abstractions.
- Prefer one clear path for a use case over duplicated logic across controllers, services, handlers, or adapters.

## Pragmatic Exceptions
- Not every feature needs full DDD ceremony.
- Simple CRUD flows may stay lightweight if they do not bypass important domain rules.
- A small amount of duplication is acceptable when it preserves layer clarity better than a premature abstraction.
- Shared utility code is acceptable when it does not become a hidden second domain model.
- A deliberate boundary exception may be acceptable when it is local, explicit, and simpler than a heavier architectural abstraction.

## Red Flags
- Business rules leaking into controllers, endpoints, views, jobs, or infrastructure adapters.
- Domain code coupled directly to databases, HTTP clients, queues, SDKs, or framework types without a strong reason.
- Application services becoming thin pass-through wrappers with no real orchestration value.
- Infrastructure details shaping domain behavior instead of supporting it.
- Repeated cross-layer shortcuts that make the intended flow harder to trace.
