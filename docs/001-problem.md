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

## Why Each Layer Exists

Each layer in this methodology was added because the
previous layer failed to catch a real problem. The
layers are not a theoretical framework — they are a
progression of practical responses to concrete
failures. See [003-layers.md](003-layers.md) for the
full narrative.
