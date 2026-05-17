# Observability

What to observe, when, and why. Not production
monitoring -- development-time verification.

## The problem

Code that compiles is not code that works. A
successful HTTP response does not mean the
internals are correct. AI generates code that
returns the right shape while quietly issuing
redundant queries, swallowing exceptions, or
failing async consumers.

Without observability during development:

- A handler loads the same entity three times and
  nobody notices until production load reveals it.
- An async consumer fails silently because its
  dependency registration is missing. The request
  returned 200.
- An event is published with no subscribers. The
  feature appears to work but the side effect
  never happens.

Tests do not catch these. Only inspecting the
execution trace reveals them.

## Approaches

### Traces as primary evidence

Distributed traces show the full execution path:
every span, every DB query, every message handler,
every external call. Inspect traces after every
meaningful invocation -- manual smoke check, test
run, or journey walk.

For what constitutes a finding in a trace, see
[../methods/observability-signals/](../methods/observability-signals/).

### Logs supplement traces

Structured logs with trace context provide detail
that spans alone do not carry. Inspect logs when a
trace shows an error or unexpected behavior -- not
for every operation.

### Metrics detect regressions

Request counts, error rates, latency distributions.
Compare before and after a change to detect
regressions. Useful after a verification pass
completes.

### Development dashboard

Use a trace visualization dashboard during
development. Without it, traces are invisible.

Options: .NET Aspire dashboard (built-in, no
setup), Jaeger UI (standalone, language-agnostic),
Grafana + Tempo (production-grade, complex setup),
or any OTel-compatible tool.

The dashboard must be accessible to both the
developer (manual inspection) and AI tools (via
MCP or API) for automated trace analysis.

### Trace analysis tool

Manual trace inspection does not scale. A dedicated
tool should accept a trace ID, extract structured
metrics, and compare against budgets. See
[../methods/trace-analyzer/README.md](../methods/trace-analyzer/README.md)
for the specification.

## When this matters

From the first endpoint or handler. Observability
added later requires retrofitting instrumentation
across existing code.

## What comes next

Observability provides evidence. The next problem
is using that evidence -- along with tests and
other mechanisms -- to trust what is delivered.
See [010-quality.md](010-quality.md).
