# Problem

Software projects evolve through stages. Each stage
introduces problems the previous one did not have.
This repository documents those problems and the
approaches that address them, so the same lessons do
not need to be learned twice.

## What this is

A living practice system describing how to take a
software project from nothing to a working, evolving
product. It documents:

- Problems that appear at each stage of a project's
  life.
- Practices, methods, and tools that address each
  problem.
- When each approach applies and when it does not.

This is a personal record refined through practice
and feedback. It is not a framework, library, or
universal methodology. It is a set of documented
choices and the reasoning behind them.

## Who this is for

- Anyone building software with AI assistance who
  wants a structured way to organize practices,
  instructions, and tools.
- Anyone working solo on a project that has grown
  beyond what they can hold in their head.
- Anyone who finds existing methodology guides too
  abstract or too prescriptive.

The practices apply whether AI participates or not.
AI changes the speed and the failure modes, not the
underlying need for clear intent, working code,
visible behavior, and verifiable outcomes.

## The recurring pattern

Across every stage of a project, the same shape
repeats:

1. Something is missing or unclear.
2. The gap creates friction or invisible failures.
3. A practice, tool, or method addresses it.
4. New problems appear that the previous solution
   does not cover.

This is true whether the project is starting from
nothing or already running in production. The system
is never finished. It loops back through
redefinition, refactoring, and improvement.

## What AI changes

AI accelerates code production and lowers the cost
of producing artifacts (docs, tests, scripts,
configurations). It does not change what makes
software correct, maintainable, or trustworthy.

What AI makes more important:

- **Explicit intent.** AI optimizes locally. Without
  a clear problem statement and scope, it produces
  consistent code that solves the wrong problem.
- **Enforceable standards.** AI follows examples.
  Without standards encoded in instruction files,
  AI uses whatever pattern its training favors.
- **Visible behavior.** AI generates code that
  passes the tests in front of it. Verifying that
  the system actually behaves correctly requires
  looking at what runs, not what compiles.
- **Tools that remove guesswork.** Formatters,
  linters, schema validators, and security scanners
  eliminate categories of mistakes so AI (and
  humans) do not have to think about them.

What AI does not change:

- Good engineering still requires reading code,
  reviewing changes, and writing tests that catch
  what matters.
- Quality control still falls apart if checks are
  advisory instead of enforced.
- Documentation still rots if the workflow does not
  keep it current.

This repository documents practices for both: what
AI shifts and what stays the same.

## How to use this repository

The documentation is a flat set of problem-to-solution
documents organized by lifecycle stage. Read what is
relevant to your current need. Each document
describes a problem, the approaches that address it,
when each approach applies, and what problem appears
next.

The repository also contains artifacts that implement
the practices:

- [plugins/](../../plugins/) — installable plugins
  for Copilot and Claude Code (one per workflow).
- [instructions/](../../instructions/) — Copilot
  instruction file samples to copy into your own
  project.
- [agents/](../../agents/), [skills/](../../skills/),
  [hooks/](../../hooks/), [prompts/](../../prompts/)
  — placeholders for standalone AI artifact
  samples; currently empty.
- [methods/](../methods/) — detailed specifications
  for specific quality methods (journey
  verification, trace analyzer).

Use the parts that fit. Ignore the parts that do
not. Push back where the reasoning is wrong.
