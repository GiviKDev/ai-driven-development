# Adoption Guide

How to start using AI-Driven Development in your
project. The layers are incremental — adopt them in
order, one at a time.

## Layer 0 — Code (you are probably here)

You have a project. Code exists. It may or may not
work consistently.

**What to do**: Establish coding standards. Not
documentation about coding — enforceable rules:

- Naming conventions (files, types, variables)
- Project structure (where things go)
- Error handling patterns
- Build rules that fail on violations

**Done when**: `make build` or equivalent enforces
style and structure. No warnings, no exceptions.

## Layer 1 — Observability

You need to see what happens inside the system when
it handles a request.

**What to do**: Add distributed tracing.

For .NET: OpenTelemetry + Aspire Dashboard.
For Node.js: OpenTelemetry + Jaeger.
For any stack: OpenTelemetry SDK + any OTel backend.

**Done when**: Every HTTP request produces a trace
with spans for DB queries, external calls, and
message handlers. You can look at a trace and
understand the full execution path.

## Layer 2 — Documentation

AI is generating code, but it does not understand
the project's philosophy, constraints, or domain.

**What to do**: Write three short documents:

1. **Problem**: What problem are you solving? One
   paragraph.
2. **Vision**: What does success look like?
3. **Scope**: What is in and what is out. This is the
   single most important document for AI.

Keep them brief. AI loads these into context — a
50-page PRD wastes tokens.

**Done when**: A new team member (human or AI) can
read the three docs and understand the project's
purpose and boundaries in five minutes.

## Layer 3 — AI Instructions

AI read the docs but still does not follow your
conventions consistently.

**What to do**: Create instruction files that are
automatically loaded when AI works with specific
file types.

For VS Code / Copilot:
- `.github/copilot-instructions.md` — always loaded
- `.github/instructions/*.instructions.md` — loaded
  by `applyTo` glob pattern

For Claude Code:
- `CLAUDE.md` at the project root

For Cursor:
- `.cursorrules` at the project root

**Done when**: AI-generated code follows your project
conventions without being reminded.

### Install the plugin

Install the AI-Driven Development plugin for access
to journey walking and evaluation skills:

**Copilot (VS Code)**:
Run `Chat: Install Plugin From Source` and enter:
```
https://github.com/givikdev/ai-driven-development
```

**Claude Code**:
```
/plugin install ai-driven-development@<marketplace>
```

## Layer 4 — Callable Surface

The system works, but nobody verifies it end-to-end
through its external interface.

**What to do**: Expose the system's functionality
through a callable surface that AI agents can invoke:

- **MCP server**: Best for AI-native verification.
  Tools map directly to user actions.
- **REST API**: Works if the API is well-documented
  (OpenAPI spec).
- **CLI**: Works for simpler systems.

**Done when**: An AI agent can perform any user-facing
action through the callable surface without touching
internal code.

## Layer 5 — Journey Verification

The system has a callable surface, but nobody checks
whether multi-step user flows actually work correctly
and perform well.

**What to do**:

1. Design a journey using the `design-journey` skill
   or manually following the format in
   [Journey Design](005-journey-design.md).

2. Define evaluation criteria — binary checks across
   functional, performance, security, and
   observability scopes.

3. Walk the journey using the `walk-journey` skill
   or the `journey-walker` agent.

4. Evaluate against criteria using the
   `evaluate-criteria` skill.

5. Fix violations. Re-walk.

**Done when**: At least one journey has been walked,
evaluated, and passed. You have a walk report as
evidence.

## How long does this take?

Layers 0-2: You may already have these. If not, a day
each.

Layer 3: An hour to create initial instruction files.
Refine over the first week as you notice AI making
mistakes.

Layer 4: Depends on your system. If you already have
a REST API, you are done. An MCP server takes a few
days to build.

Layer 5: First journey: an hour to design, minutes to
walk, an hour to fix findings. After that, each new
journey takes less time.
