# Glossary

Definitions of terms used across the repository.

## Loop

The pattern that connects evolution back to
problem definition. Documents in `docs/` are
numbered in the order they typically appear in a
project, but actual traversal jumps between them
as problems arise. See
[014-evolution.md](014-evolution.md).

## Problem Definition

The set of artifacts describing what is being
built, for whom, and what success looks like. See
[003-problem-definition.md](003-problem-definition.md).

## Instruction File

A markdown file with YAML frontmatter (`applyTo`,
`description`) that AI tools (Copilot, Claude
Code) load automatically based on the files in
context. See [007-ai-instructions.md](007-ai-instructions.md).

## Callable Surface

The interface through which a system is exercised
programmatically. MCP server, REST API, gRPC,
CLI, library API. The surface that journey
verification walks.

## Journey

A defined sequence of steps that exercises a
user-facing flow through the callable surface. A
journey follows a real user intent, not a
technical edge case.

## Walk

The act of executing a journey against a live
system. The walker (often an AI agent) follows
journey steps, collects responses and trace IDs,
and produces a walk report.

## Walk Report

Structured output of a walk: pass/fail per step,
findings, trace IDs, overall result. Evidence,
not opinion.

## Evaluation Criteria

Binary checks (PASS/FAIL, no partial credit)
applied to a walk report. Organized by scope:
functional, performance, security,
observability.

## Trace

A distributed trace (OpenTelemetry or equivalent)
capturing the internal execution path of an
operation. In quality verification, traces are
evidence — not monitoring data.

## Span

A single unit of work in a trace. Has name,
duration, attributes, parent-child relationship.

## Black Box / White Box

Modes of walking a journey. Black box: only
callable surface responses are visible. White
box: traces and internal state also visible.
Black box first prevents rationalization of
functional failures from internal context.

## Quality Gate

An automated check that must pass before code
proceeds (commit, push, merge, release). See
[011-automation.md](011-automation.md).

## Decision Record

A short document capturing why a non-obvious
choice was made. Written when the decision is
fresh.
