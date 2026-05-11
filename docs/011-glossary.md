# Glossary

Definitions of terms used throughout the methodology.

## Layer

One of six maturity levels in the AI-Driven
Development model. Layers are numbered 0-5 and
adopted incrementally. Each layer addresses a gap
the previous layer cannot fill.

## Journey

A defined sequence of steps that verifies a
user-facing flow through the system's callable
surface. A journey follows a real user intent, not
a technical edge case. It is not a test case — it is
a verification arc that produces observable traces.

## Walk

The act of executing a journey against a live system.
An AI agent performs the walk by following journey
steps through the callable surface, collecting
responses and trace IDs.

## Walk Report

The structured output of a walk. Contains pass/fail
for each step, findings, trace IDs, and an overall
result. Walk reports are evidence, not opinions.

## Callable Surface

The interface through which the system is exercised
during a walk. Can be an MCP server, REST API, gRPC
service, CLI, or any programmatically invocable
interface. The callable surface is what makes
journeys walkable by AI agents.

## Evaluation Criteria

Binary checks applied to a walk report. Each
criterion is either PASS or FAIL — no partial credit,
no scores. Criteria are organized into four scopes:
functional, performance, security, and observability.

## Budget

A numeric threshold for a performance criterion.
Example: "DB query count must be less than 5." Budgets
are compared against actual values extracted from
traces. A value exceeding its budget is a violation.

## Violation

A criterion that fails. A violation has evidence:
a metric value, a trace ID, a response body. Not
an opinion — a measured fact.

## Finding

An observation made during a walk that is noteworthy
but may not be a violation. Findings include
unexpected behaviors, quality concerns, or
observations that fall outside defined criteria.

## Trace

A distributed trace capturing the internal execution
path of a system operation. Traces consist of spans
and are produced by OpenTelemetry instrumentation.
In this methodology, traces serve as verification
evidence, not monitoring data.

## Span

A single unit of work within a trace. Spans have
names, durations, attributes, and parent-child
relationships. The methodology classifies spans
(DB query, external call, message handler) to extract
structured metrics.

## Black Box

A walk mode where the walker sees only callable
surface responses. No traces, no internal state.
Evaluates the system as a user would.

## White Box

A walk mode where the walker also has access to
distributed traces and internal state. Enables
performance evaluation, duplicate detection, and
internal behavior verification.

## Bias Prevention

The practice of performing black box evaluation
before white box. If the walker sees traces first,
it may rationalize functional failures based on
internal context. Black box first ensures functional
correctness is evaluated without internal bias.
