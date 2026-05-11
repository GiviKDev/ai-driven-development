# Layer by Layer

The six layers, told as the day-by-day evolution of a
real project. Each layer is motivated by the failure
of the previous one.

## Day 1 — You Have an Idea

You start a project. Maybe with AI, maybe without.
You have code. It works.

**The first thing you need is not code — it is
foundation.**

Write three short documents:

- **Problem**: What problem are you solving? One
  paragraph. If you can't explain the problem
  briefly, you don't understand it.
- **Vision**: What does success look like? Not
  features — the outcome.
- **Scope**: What is in and what is out. This is the
  single most important document for AI. Without
  scope, AI will build features you never asked for.

Why brief: AI loads these into context. A 50-page PRD
wastes tokens. A 200-word problem statement gives AI
everything it needs.

Why alive: When the scope changes, update the scope
doc. Delete the old scope. AI should never see a
scope that is no longer true.

Why structured: `01-foundation/001-problem.md`,
`01-foundation/002-vision.md`,
`01-foundation/003-scope.md`. AI navigates numbered
files without help.

## Day 2 — Code Works, but Every AI Request Produces Different Code

You ask AI to write a handler. It uses one naming
pattern. You ask again tomorrow. Different pattern.
Function names, error handling, file organization,
project structure — all vary per request.

**You need coding standards.**

Not documentation about coding — enforceable rules:

- Naming conventions (files, types, variables).
- Project structure (where handlers go, where
  entities go, where tests go).
- Error handling patterns (what exceptions to throw,
  what response shape to return).
- Build rules that fail on violations (treat
  warnings as errors, enforce code style in build).

Keep them brief. Examples over explanations. "Do
this: `[example]`. Not this: `[anti-example]`."

**This is Layer 0 — working code with consistent
patterns.**

## Day 3 — Standards Exist, AI Ignores Them

You wrote a standards doc. AI read it once and then
forgot. Or the doc wasn't in context. Or the model's
training data overrides your preference.

**You need AI instruction files.**

These are files that are automatically loaded when AI
works with matching file types. In VS Code:
`.instructions.md` files with `applyTo` patterns. In
Claude Code: `CLAUDE.md` and rules files. In Cursor:
`.cursorrules`.

The key property: **the instruction discovers the
AI, not the other way around.** When AI edits a `.cs`
file, the C# instruction is loaded automatically. The
AI doesn't need to find the rule.

Instruction categories:

- **Architecture**: Module boundaries, dependency
  direction, what belongs where.
- **Conventions**: Naming patterns, handler
  signatures, message types.
- **Quality**: Known tooling bugs, workarounds,
  anti-patterns to avoid.
- **Behavior**: "Challenge requests before
  implementing" vs "implement what was asked."
- **Workflow**: "After code changes, run format then
  build. Fix all errors. Repeat."

**This is Layer 3 — enforceable AI instructions.**

## Day 4 — Code Is Consistent, but Nobody Understands the Architecture

Modules are implemented. The code follows conventions.
But their boundaries, responsibilities, and
interactions aren't explained anywhere. AI adds a
feature to the wrong module because nothing says where
it belongs. A new team member reads the code but
doesn't understand why it's structured this way.

**You need architecture and design documentation.**

- Module specs: what each module owns, what it
  doesn't, how it interacts with others.
- Design decisions (ADRs): why you chose this
  database, this messaging pattern, this auth
  provider. Not history — current rationale.
- Process docs: one trigger, one outcome, per
  feature. What happens when a user registers an
  org? What events are published? What side effects
  occur?

All of it: brief, structured, alive. One concept per
file. Replace outdated content.

**This is Layer 2 — documentation. Listed after
Layer 3 because in practice, many projects add
instruction files before they write architecture
docs. The layer numbers indicate dependency, not
adoption order.**

## Day 5 — Tests Pass, but Nobody Knows if the System Actually Works

Unit tests verify handlers. Integration tests verify
endpoints. But nobody sees the full execution path.

- An async event consumer silently fails because its
  dependency registration is missing.
- A handler loads the same entity three times.
- An external service call takes 4 seconds.
- An event is published but nobody consumes it.

All tests pass. All endpoints return 200.

**You need observability.**

Add OpenTelemetry tracing, structured logging, and
metrics. Use a dashboard to visualize them during
development (Aspire for .NET, Jaeger, Grafana, or
whatever fits your stack).

This is not production monitoring — this is
development-time observability. You need to see what
the system does when you exercise it, not after users
report problems.

See [004-observability.md](004-observability.md) for
the observability methodology.

**This is Layer 1 — observability. Listed here
because it is often adopted late, but it should be
adopted early. The earlier you can see what happens
inside your system, the fewer layers you need to
compensate for blindness.**

## Day 6 — You Have Traces, but Nobody Checks Them Systematically

Traces exist. Nobody looks at them unless something
is obviously broken. The system has 15 endpoints and
dozens of message handlers. Nobody has time to
exercise every path and inspect every trace.

**You need a callable surface that AI can exercise.**

This is your product's API — REST, gRPC, GraphQL,
MCP, CLI, SDK. Whatever surface your clients use.
The key property: **AI can call it as a client.**

When AI calls your API, it experiences the system as
a real user would. If the API schema marks optional
fields as required, AI discovers this. If the error
response is a generic "something went wrong," AI
discovers this. If the workflow requires 5 calls in a
non-obvious order, AI discovers this.

MCP (Model Context Protocol) is particularly
effective here because AI agents can call MCP tools
natively. But MCP is not required — any callable
surface works. The point is that AI exercises the
real system, not a mock.

**This is Layer 4 — callable surface.**

The callable surface also acts as a spec layer. If AI
can't complete a workflow using the tools, one of
these is true:

- A tool is missing (capability gap).
- A tool schema is wrong (spec error).
- A tool's behavior contradicts the docs (doc drift).
- The workflow design is bad (design problem).

The surface pushes back on developer intent.

## Day 7 — You Have a Surface, but No Definition of "Correct"

AI can call your API. But what is a correct
end-to-end workflow? What is the right sequence of
calls? What should happen internally after each call?
What preconditions must hold?

**You need journeys.**

A journey is a human-written description of an
end-to-end arc from an actor's perspective. One actor.
One outcome. Concrete steps with expected inputs,
outputs, and what the actor learns at each step.

See [005-journey-design.md](005-journey-design.md).

## Day 8 — You Walk Journeys and Discover Reality Doesn't Match Design

The journey describes what should work. AI walks the
journey using the callable surface. After each step,
AI inspects the distributed trace. Human-defined
evaluation criteria (scoped by concern: technical,
security, business, surface quality) determine what
is a violation.

Fix the violations. Re-walk. Repeat until the journey
passes.

See [006-walk-procedure.md](006-walk-procedure.md)
and [007-evaluation-criteria.md](007-evaluation-criteria.md).

**This is Layer 5 — journey verification.**

## Summary

| Day | Layer | What you add | What gap it fills |
|---|---|---|---|
| 1 | — | Foundation docs | Nobody knows what we're building |
| 2 | 0 | Code + standards | Every AI request produces different code |
| 3 | 3 | AI instructions | AI doesn't follow standards |
| 4 | 2 | Architecture + design docs | Nobody understands the system structure |
| 5 | 1 | Observability (OTel) | Nobody sees what happens inside |
| 6 | 4 | Callable surface | Nobody exercises the system systematically |
| 7-8 | 5 | Journeys + verification | Nobody checks quality from the user's perspective |

The layer numbers (0-5) indicate dependency. The
day numbers indicate typical adoption order. They
differ because developers usually write instruction
files (Layer 3) before architecture docs (Layer 2),
and add observability (Layer 1) later than they
should.
