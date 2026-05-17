# The Problem

AI-assisted development delivers features at a
rate that outpaces human comprehension. This
creates a specific failure mode: the system
evolves faster than anyone's mental model of it.

This repository systemizes my approach to
building software with AI — the practices,
methods, and tools that keep the system
comprehensible while delivery accelerates. It is
written first for me, then for anyone working
through the same problems.

## The Acceleration Gap

A developer using AI can ship in days what
previously took weeks. In traditional development,
writing the code forces the developer to reason
through each piece, building a model of the system
as a side effect. AI inverts this: the developer
reviews finished code, and the same depth of model
only forms if they read it as carefully as if they
had written it. Under delivery pressure, they often
do not. The code works — tests pass, endpoints
return 200 — but the developer's understanding of
the system's behavior, edge cases, cross-module
interactions, and failure modes degrades with every
feature shipped.

This is not a team size problem. It is the gap
between delivery speed and comprehension speed.

## What Breaks

### Mental model drift

The developer's understanding of the system
diverges from the system's actual behavior. This
is invisible until a bug report arrives or an
integration fails. The gap widens with every
AI-generated feature.

### Cross-module blindness

AI agents work on one feature at a time. They do
not naturally consider how a change in module A
affects consumers in module B, C, or D. A
successful HTTP response hides a failed event
handler.

### Quality theater

Unit tests pass. Integration tests pass. The
endpoint returns the expected shape. But:

- A handler loads the same entity three times
  because nobody checked the execution trace.
- An async consumer silently fails because its
  dependency registration is missing.
- The API schema marks optional fields as required
  because the binding generates the wrong schema.
- The error response returns a generic message
  instead of structured diagnostics.

Tests do not catch these. Code review does not
catch these. Only exercising the system end to end
as a real user, then inspecting the trace, reveals
them.

### Documentation decay

AI follows documentation — when it can find it,
when it is current, and when the instructions are
specific enough. Documentation drifts from reality
because nobody re-reads it after writing it. The
system changes; the docs do not. AI then follows
stale docs and produces code that contradicts the
system's current state.

## AI Does Not Replace Deterministic Tooling

AI does not replace static analyzers, linters,
formatters, tests, or any other established
quality tool. Those tools solve specific problems
deterministically. AI cannot — its mistakes are
unique each time.

Without correct tooling, you depend too much on
AI. With correct tooling, AI becomes a multiplier
that abstracts parts of the development process
while the environment catches its mistakes.

## What AI Shifts

AI does not change what makes software correct or
maintainable. It does shift what matters most:
intent must be explicit, standards must be
enforceable, behavior must be visible, and
deterministic tooling must catch what AI gets
wrong. See [002-principles.md](002-principles.md).

## How Developers Adopt AI

I have watched teams — and myself — go through
four phases:

1. **Excitement.** AI generates code fast. Output
   volume jumps. Everything feels productive.
2. **Over-reliance.** AI handles more decisions.
   The developer's mental model falls behind the
   system's actual state.
3. **Disillusionment.** Bugs appear that tests do
   not catch. The system surprises its own
   developers.
4. **Structured adoption.** The team builds
   boundaries — instructions, quality gates,
   verification practices — to keep AI productive
   without sacrificing comprehension.

This repository maps to phase 4. It systemizes
the practices, methods, and tools that make
structured adoption concrete and repeatable.
