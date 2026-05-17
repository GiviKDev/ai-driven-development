# Quality

How to trust what is delivered. Tests, verification,
trace analysis, and the other mechanisms that turn
"the build is green" into "the system works."

## The problem

Code that compiles is not code that works. Tools
catch syntactic problems and known anti-patterns
but cannot tell you:

- Whether the system behaves correctly end to end.
- Whether the system handles failure modes.
- Whether new code broke something subtle elsewhere.
- Whether the system meets performance and
  reliability expectations.

AI makes this worse, not better. AI generates code
that looks correct, with tests that pass, in
scenarios it was shown — while quietly missing
edge cases, mishandling errors, or producing
plausible but wrong results in scenarios it was not
shown.

Trust must be earned by evidence, not assumed from
the absence of red.

## Approaches

Multiple, complementary. Pick the ones that match
the risks in your project.

### Unit tests

Cover individual functions and classes. Fast, easy
to write, easy to maintain. Necessary but not
sufficient: passing unit tests do not prove the
system works.

Drives design when written first (TDD). Useful
documentation of intended behavior.

### Integration tests

Exercise multiple components together against real
dependencies (databases, queues, APIs). Slower than
unit tests, catch problems unit tests cannot.

### End-to-end / acceptance tests

Drive the system from its external surface as a
user would. Catch the most kinds of problems. Slow,
brittle if written poorly.

BDD-style frameworks (Cucumber, SpecFlow) make
these tests double as documentation.

### Journey verification

A structured way of walking the system through a
defined sequence of operations on the callable
surface and checking each step against binary
criteria. Combines black-box behavior with white-box
runtime evidence (traces, logs, metrics).

Useful when:

- The system has clear user-facing flows.
- Runtime evidence (traces, side effects) matters as
  much as return values.
- AI is generating significant portions of the
  code, and you need an external check on what was
  produced.

See [../methods/journey-verification/](../methods/journey-verification/) for the full
specification.

### Trace analysis

Examine OpenTelemetry traces (or equivalent) to
verify what actually happened at runtime. Catches
problems test assertions miss:

- A call that should not have happened.
- A retry storm that masks an upstream failure.
- An expected side effect that silently did not
  occur.

Useful when behavior is distributed across services
or when the cost of a missed failure is high.

### Property-based testing

Generate many inputs and check invariants. Catches
edge cases humans (and AI) do not think of.
Examples: QuickCheck, Hypothesis, FsCheck.

### Mutation testing

Deliberately break the code and check that tests
catch it. Measures test quality, not just coverage.
Slow; run periodically, not on every commit.

### Contract testing

Verify that producers and consumers agree on
interfaces. Useful in distributed systems where
end-to-end tests are expensive.

### Manual exploratory testing

Humans poking at the system, looking for what
automated checks miss. Cannot be replaced
entirely; can be focused on the riskiest areas.

## Choosing what to use

The right mix depends on:

- **Risk**: high-risk areas justify more
  verification.
- **Surface stability**: stable surfaces are worth
  contract or journey verification; volatile
  surfaces churn the tests.
- **AI involvement**: heavy AI generation increases
  the case for external verification — journey
  verification, trace analysis, property-based
  testing.
- **Team size**: distributed teams need contract
  testing more than co-located teams.

A small project can ship with unit and integration
tests alone. A regulated system needs the full
stack.

## When this matters

From the start. Quality mechanisms added late
require retrofitting and the team learns that
quality is optional.

## What comes next

Quality mechanisms only work when they run
consistently — on every commit, every PR, every
release. See [011-automation.md](011-automation.md).

## Note on terminology

"Verification" is often used as a category name.
This document treats it as one kind of quality
mechanism among many, not as the master category.
The master category is quality: anything that
gives you justified confidence in the system.
