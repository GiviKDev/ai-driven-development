# Documentation

Knowledge organized by the lifecycle of a software
project, from idea to evolution. Each document
describes one problem and the approaches that
address it.

## Layout

- [practices/](practices/) — lifecycle practice
  documents (numbered 001-017). One problem per
  document.
- [methods/](methods/) — detailed specifications
  for specific quality methods referenced from the
  practices.

## How to read this

This is not a sequential book. The numbering in
`practices/` follows a typical project's order of
appearance but is not a required path:

- A new project starts near
  [003-problem-definition.md](practices/003-problem-definition.md)
  — defining what to build.
- A project with running code may enter at
  [009-observability.md](practices/009-observability.md)
  — seeing what happens at runtime — or
  [010-quality.md](practices/010-quality.md) —
  trusting what is delivered.
- A live product loops through
  [014-evolution.md](practices/014-evolution.md)
  back to
  [003-problem-definition.md](practices/003-problem-definition.md)
  when something needs to change.

Documents describe problems, not stages. When a
problem appears in your project, read the document
that covers it.

## Practices

### Foundation

- [001-problem.md](practices/001-problem.md) — what
  this repository is and why it exists.
- [002-principles.md](practices/002-principles.md)
  — principles guiding documentation, instructions,
  and verification.

### Definition

- [003-problem-definition.md](practices/003-problem-definition.md)
  — capturing intent, scope, non-goals, success.

### Structure

- [004-project-structure.md](practices/004-project-structure.md)
  — repository layout, naming, organization.
- [005-documentation.md](practices/005-documentation.md)
  — knowledge that persists across sessions.

### Construction

- [006-coding-standards.md](practices/006-coding-standards.md)
  — enforceable conventions.
- [007-ai-instructions.md](practices/007-ai-instructions.md)
  — instruction files loaded by AI tools.
- [008-tools.md](practices/008-tools.md) —
  formatters, linters, analyzers, build rules.

### Visibility

- [009-observability.md](practices/009-observability.md)
  — traces, metrics, logs.

### Quality

- [010-quality.md](practices/010-quality.md) —
  tests, journey verification, trace analysis.
- [011-automation.md](practices/011-automation.md)
  — CI, hooks, gates.

### Delivery and operation

- [012-delivery.md](practices/012-delivery.md) —
  release process, versioning, deployment.
- [013-operation.md](practices/013-operation.md) —
  monitoring, incidents, support.

### Evolution

- [014-evolution.md](practices/014-evolution.md) —
  feedback loops, when to revisit earlier
  documents.

### Reference

- [015-glossary.md](practices/015-glossary.md)
- [016-open-problems.md](practices/016-open-problems.md)
- [017-roadmap.md](practices/017-roadmap.md)

## Methods

Detailed specifications for specific quality methods
referenced from the practices.

- [methods/journey-verification/](methods/journey-verification/)
  — walking a system through defined user journeys
  on the callable surface and evaluating each step
  against binary criteria.
- [methods/trace-analyzer/](methods/trace-analyzer/)
  — analyzing distributed traces against budgets.
