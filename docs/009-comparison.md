# Comparison

How this methodology relates to established practices
and adjacent approaches.

## Established Methodologies

### TDD (Test-Driven Development)

**Relationship**: Complementary, not competing.

TDD: Write a test → write code → refactor. Tests
verify code behavior against expected output.

This methodology: Write a journey → walk the system →
evaluate against criteria → fix → re-walk. Journeys
verify system behavior against user intent, through
traces and criteria.

Key differences:

- TDD tests code units. Journeys test end-to-end user
  arcs.
- TDD has automated regression. Journeys currently do
  not.
- TDD writes tests before code. Journeys are walked
  against existing code.
- TDD trusts test output. Journeys verify through
  distributed traces.

Use both. TDD for entity invariants and handler
logic. Journeys for end-to-end verification and
surface quality. They test different things.

### BDD (Behavior-Driven Development)

**Relationship**: Closest ancestor.

BDD defines behavior in Given-When-Then format →
automates as acceptance tests → implements.

This methodology borrows BDD's "define behavior from
the user's perspective" but diverges in execution:

- BDD acceptance tests are automated scripts. Walk
  reports are AI-evaluated against human criteria.
- BDD uses a test runner. This uses callable surface
  + traces + criteria.
- BDD behaviors are Gherkin features. Journey steps
  are natural-language descriptions.

What this adds over BDD: trace-based verification.
BDD acceptance tests verify the response. This also
verifies the internal execution path.

### ATDD (Acceptance Test-Driven Development)

**Relationship**: Adjacent.

ATDD defines acceptance criteria before
implementation. This methodology's evaluation
criteria serve the same purpose. The difference: ATDD
criteria become automated tests. Evaluation criteria
here are checklists applied during walks with trace
analysis as an additional verification dimension.

### Exploratory Testing

**Relationship**: Spiritual ancestor.

Exploratory testing: a skilled tester explores the
system without scripts, using judgment.

This methodology is exploratory testing where the
explorer is an AI agent, the exploration follows a
defined journey, and the judgment is replaced by
human-defined criteria. The AI explorer also has
access to distributed traces, which human testers
typically cannot inspect.

## Adjacent Approaches

### Spec-Driven Development (SDD)

Tools: Kiro, spec-kit, Tessl, OpenSpec.

SDD workflow: Spec → Code. Write a spec, generate
code from it.

This methodology's workflow: Code → Journey → Walk →
Verify. Verify running code through journeys.

The directions are opposite. SDD is a code generation
discipline. This is a code verification discipline.
They solve different problems and can coexist.

### Custom Context MCP Servers

Building MCP servers that expose project
documentation, schemas, and conventions to AI agents.

This methodology's callable surface is different:
it exposes the live product API, not project
knowledge. Context servers solve "AI doesn't know my
project." This methodology solves "nobody verifies
that the running system works end to end."

### Agentic Brownfield Coding

Curated MCP tools, path-specific context, explicit
workflows for AI agents working in existing
codebases.

Shares the philosophy of curated tools and explicit
instructions. But it answers "how should AI write
code in an existing project." This methodology
answers "how should AI verify that a running system
works correctly." Adjacent philosophy, different
application. This methodology's Layers 2-4 overlap
with brownfield coding recommendations.

### Vibe Coding

**Relationship**: Opposite end of the spectrum.

Vibe coding (coined by Andrej Karpathy, 2025): tell
AI what you want, accept the generated code without
thorough review, iterate by describing problems.
Collins Dictionary Word of the Year 2025.

This methodology exists because vibe coding works —
and that is the problem. AI generates functional code
fast enough that teams ship without verifying quality.
Tests pass. The demo works. But nobody checked the
internal execution path, the query count, the error
handling, or the security boundary.

Key differences:

- Vibe coding accepts AI output on trust. This
  methodology verifies AI output through evidence.
- Vibe coding optimizes for speed of creation. This
  optimizes for confidence in correctness.
- Vibe coding works without understanding the code.
  This works by understanding the system's behavior
  through traces.

These are not competing approaches. Vibe coding
describes how code gets written. This methodology
describes how code gets verified. A team can vibe
code all day and walk journeys to verify the result.

The research supports the need: CodeRabbit found
AI co-authored code has 1.7x more major issues.
Veracode found AI-generated code security has not
improved despite functionality gains. METR found
experienced developers are 19% slower with AI tools
while believing they are faster. This methodology
provides a verification discipline for a world where
AI-generated code volume exceeds human review
bandwidth.

## Positioning

| Dimension | TDD | BDD | SDD | Vibe | This |
|---|---|---|---|---|---|
| Verifies | Code units | User behavior | N/A (generates) | N/A (trusts) | End-to-end arcs |
| Oracle | Assertions | Acceptance tests | N/A | Human intuition | OTel traces + criteria |
| Executed by | Developer | Test runner | AI agent | AI agent | AI agent |
| Direction | Test → Code | Behavior → Code | Spec → Code | Prompt → Code | Code → Walk → Verify |
| Automated | Yes | Yes | N/A | N/A | Not yet |

Closest compound description: **AI-driven acceptance
testing with distributed trace verification through
the product's callable surface.**
