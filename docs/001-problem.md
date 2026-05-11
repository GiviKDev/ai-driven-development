# The Problem

AI-assisted development delivers features at a rate
that outpaces human comprehension.

## The Acceleration Gap

A solo developer or small team using AI can ship in
days what previously took weeks. This creates a
specific failure mode: the system evolves faster than
anyone's mental model of it.

In traditional development, the developer who wrote
the code understands it because they reasoned through
it slowly. With AI, the developer approves code they
did not reason through line by line. The code works —
tests pass, endpoints return 200 — but the
developer's understanding of the system's behavior,
edge cases, cross-module interactions, and failure
modes degrades with every feature shipped.

This is true for solo developers, small teams, and
large teams. The problem is not team size — it is the
gap between delivery speed and comprehension speed.

## What Breaks

### Mental model drift

The developer's understanding of the system diverges
from the system's actual behavior. This is invisible
until a bug report arrives or an integration fails.
The gap widens with every AI-generated feature.

### Cross-module blindness

AI agents work on one feature at a time. They do not
naturally consider how a change in module A affects
async consumers in module B, C, or D. A successful
HTTP response hides a failed event handler.

### Quality theater

Unit tests pass. Integration tests pass. The endpoint
returns the expected shape. But:

- A handler loads the same entity three times because
  nobody checked the execution trace.
- An async consumer silently fails because its
  dependency registration is missing.
- The API schema marks optional fields as required
  because the language binding generates the wrong
  schema.
- The error response returns a generic message
  instead of structured diagnostics.

Tests do not catch these. Code review does not catch
these. Only exercising the system end to end as a
real user, then inspecting the distributed trace,
reveals them.

### Documentation decay

AI follows documentation — when it can find it, when
it's current, and when the instructions are specific
enough. Documentation drifts from reality because
nobody re-reads it after writing it. The system
changes; the docs do not. AI then follows stale docs
and produces code that contradicts the system's
current state.

## AI Is One Tool Among Many

AI does not replace static analyzers, linters,
formatters, unit tests, integration tests,
performance tests, architecture tests, or any other
established quality tool. Those tools exist because
they solve specific problems deterministically. AI
cannot do that -- its mistakes are unique each time.

The role of AI in this methodology is as an actor:
an intelligent agent that can exercise the system,
follow journeys, read traces, and report findings.
But it operates within an environment of tools,
boundaries, and quality gates that humans define
and maintain.

Without correct tooling, you depend too much on AI.
With correct tooling, AI becomes a multiplier that
abstracts parts of the development process while
the environment catches its mistakes.

## How Developers Evolve with AI

Teams using AI tools go through predictable phases:

1. **Excitement**: AI generates code fast. Output
   volume jumps. Everything feels productive.
2. **Over-reliance**: AI handles more decisions.
   The developer's mental model falls behind the
   system's actual state.
3. **Disillusionment**: Bugs appear that tests
   don't catch. The system's behavior surprises
   its own developers. "Tests pass" provides
   false confidence.
4. **Structured adoption**: The team builds
   boundaries -- instructions, quality gates,
   verification practices -- to keep AI productive
   without sacrificing comprehension.

This methodology maps to phase 4. It helps
developers set up the correct environment and keep
their mental model quickly adaptable as the system
evolves.

## Why Each Layer Exists

Each layer in this methodology was added because the
previous layer failed to catch a real problem. The
layers are not a theoretical framework -- they are a
progression of practical responses to concrete
failures. See [003-layers.md](003-layers.md) for the
full narrative.
