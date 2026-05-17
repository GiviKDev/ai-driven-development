# Documentation

Knowledge that persists across sessions, contributors,
and AI conversations. Without it, every change
rediscovers what was already known.

## The problem

Code shows what the system does. It does not show:

- Why a decision was made.
- What was tried and rejected.
- What constraints shaped the design.
- What the system promises to its users.
- What is out of scope.

When this knowledge lives only in someone's head,
it disappears when they move on, switch context,
or open a new AI chat session. AI agents are
particularly affected: each new conversation starts
with no project context, so AI guesses based on
training data instead of project reality.

## Approaches

### Foundation documents

Short, durable documents that describe what the
project is and how it works. Read by both humans
and AI when they need orientation:

- Problem statement, scope, success criteria
  (see [003-problem-definition.md](003-problem-definition.md)).
- Architecture overview: what the major components
  are and how they fit together.
- Principles: opinions that guide decisions.
- Glossary: domain terms with shared definitions.

### Decision records

Short documents capturing why a non-obvious choice
was made. Format does not matter; capture does.
ADRs (Architecture Decision Records) are one
convention. Plain `decisions/001-database-choice.md`
works.

Decision records are written when the decision is
made, not retroactively. The cost of writing them
later is higher than the cost of writing them now.

### Living, not historical

Documentation describes the current state. When the
system changes, the doc is updated or replaced — not
appended with history. "We used to use X but now we
use Y" makes AI produce X half the time. Replace
the doc. Delete the history. Move historical context
to commit history or decision records.

### Code-near or repo-level

- **Code-near**: README in each module, doc comments
  on public APIs. Useful when the documentation
  refers to specific code that changes together.
- **Repo-level**: foundational docs, decision
  records, specifications. Useful when the
  documentation outlives any single file.

Both have a place. Match the document's lifetime to
its location.

### Short over thorough

A document long enough to need a table of contents
is too long. Split it. AI loads small documents
entirely; large documents get truncated.

## When this matters

From the first commit. The cost of writing
documentation increases the longer it is deferred.
The cost of not writing it appears as repeated
questions, repeated mistakes, and AI-generated code
that contradicts unwritten assumptions.

## What comes next

With knowledge captured, the next problem is making
sure code itself follows consistent patterns. See
[006-coding-standards.md](006-coding-standards.md).

## Alternative approaches

- **Spec-driven development**: specifications are
  authoritative; code follows. Heavy but powerful
  when correctness matters more than iteration
  speed.
- **README-driven development**: write the README
  before the code. Forces clarity about what the
  thing will do.
- **Living documentation via tests**: BDD-style
  tests double as documentation. Compatible with
  this document; not a substitute for foundational
  docs.
- **Wikis or external knowledge bases**: useful for
  org-wide knowledge. Loses repo locality, harder
  for AI to load as context. Prefer repo-local
  documentation.
