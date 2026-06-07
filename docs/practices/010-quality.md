# Quality

How to trust what is delivered. The build is green
does not mean the system works.

## The problem

Code that compiles is not code that works. Tools
catch syntactic problems and known anti-patterns
but cannot tell you whether the system behaves
correctly end to end, handles failure modes, or
meets performance expectations.

AI makes this worse. AI generates code that looks
correct, with tests that pass, in scenarios it was
shown -- while quietly missing edge cases or
producing plausible but wrong results in scenarios
it was not shown.

Trust must be earned by evidence, not assumed from
the absence of red.

## Approaches

### Harness engineering

A harness is the repeatable environment around a
quality check. It gives humans and AI the same way to
set up state, exercise behavior, collect evidence,
and decide pass or fail.

A useful harness includes:

- A command or callable surface to run.
- Known setup and reset steps.
- Fixtures or seed data.
- Expected outputs or binary criteria.
- Trace, log, or metric capture when internal
  evidence matters.
- Clear failure output.

Harness engineering matters more when AI is doing
substantial work. Without a harness, the agent can
only make plausible claims. With a harness, it can
run the system and return evidence.

In this repository, journey verification and trace
analysis are harness engineering. They turn user
flows, budgets, and observations into repeatable
checks against a live system.

### The baseline: tests

Every project needs tests. The question is which
kinds and how many.

- **Unit tests**: Cover individual functions and
  classes. Fast, easy to write. Necessary but not
  sufficient -- passing unit tests do not prove the
  system works. Drives design when written first
  (TDD).
- **Integration tests**: Exercise multiple
  components against real dependencies (databases,
  queues, APIs). Slower, catch problems unit tests
  cannot.
- **End-to-end tests**: Drive the system from its
  external surface. Catch the most kinds of
  problems. Brittle if written poorly.

The default recommendation: start with unit and
integration tests. Add end-to-end tests for
critical user flows.

### Beyond tests: trace-based verification

Tests assert expected outputs. They do not verify
what happened internally. A test that checks
"status 201" does not catch five redundant DB
queries or a silently failed async consumer.

Trace-based verification fills this gap: inspect
the execution trace after every meaningful
operation. See
[009-observability.md](009-observability.md) for
the practice and
[../methods/trace-analyzer/](../methods/trace-analyzer/)
for the tool specification.

### Beyond tests: journey verification

A structured method for walking a running system
through defined user flows on its callable
surface and evaluating each step against binary
criteria. Combines black-box behavior checks with
white-box trace evidence.

This is a method defined in this practice system,
not an industry-standard technique. It addresses a
specific gap: when AI generates significant
portions of the code, an external check -- walking
the system as a user would, then inspecting the
trace -- catches problems that tests miss.

See
[../methods/journey-verification/](../methods/journey-verification/)
for the full specification.

### Complementary mechanisms

Use when the project's risk profile justifies
them:

- **Property-based testing**: Generate many inputs
  and check invariants. Catches edge cases humans
  and AI do not think of (QuickCheck, Hypothesis,
  FsCheck).
- **Mutation testing**: Deliberately break code and
  check that tests catch it. Measures test quality.
  Run periodically, not every commit.
- **Contract testing**: Verify that producers and
  consumers agree on interfaces. Essential in
  distributed systems.
- **Manual exploratory testing**: Humans looking
  for what automated checks miss. Focus on the
  riskiest areas.

### Choosing what to use

- Every project: unit tests + integration tests.
- User-facing flows: end-to-end tests or journey
  verification.
- Heavy AI involvement: journey verification +
  trace analysis. AI-generated code needs external
  verification.
- Distributed systems: contract testing.
- High-risk domains: property-based testing +
  mutation testing.

## When this matters

From the start. Quality mechanisms added late
require retrofitting, and the team learns that
quality is optional.

## What comes next

Quality mechanisms only work when they run
consistently. See
[011-automation.md](011-automation.md).
