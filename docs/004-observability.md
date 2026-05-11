# Observability Methodology

What to observe, when, and what constitutes a
finding.

## Purpose

Observability in this methodology is not production
monitoring. It is development-time verification.
Traces, logs, and metrics are the evidence used to
evaluate whether the system behaves correctly — not
just whether it returns the right response.

## Three Signals

### Traces

Distributed traces show the full execution path of a
request: every span, every DB query, every message
handler, every external call.

**When to inspect**: After every callable surface
invocation during a journey walk. Not selectively —
every step.

**What to look for**:

| Signal | Finding |
|---|---|
| Same entity loaded 2+ times in one trace | Redundant query. Handler or consumer re-fetches what is already in scope. |
| `status: "Error"` on a child span when the root span succeeded | Broken async consumer. The request returned 200 but a downstream handler failed. |
| Dependency resolution failure (e.g., `UnResolvableVariableException`) | Missing DI registration. The handler cannot be constructed. |
| 10+ DB spans for a simple operation | Over-querying. Likely N+1 or missing eager load. |
| External HTTP call > 2 seconds | Latency risk. External dependency is slow. |
| Event published with zero consumer spans | Published event with no handler. Either the handler is missing or the subscription is wrong. |
| Same DB table queried by multiple spans with different filters | Possible consolidation opportunity. |

### Logs

Structured logs with trace context show what happened
at each point in the execution path. Logs supplement
traces — they provide detail that spans alone don't
carry.

**When to inspect**: When a trace shows an error span
or unexpected behavior. Not for every step — only
when the trace raises a question.

**What to look for**:

| Signal | Finding |
|---|---|
| Exception logged with stack trace on a non-error span | Swallowed exception. The handler caught and logged but did not propagate. |
| Validation failure logged but not returned to caller | Silent validation. The client gets 200 but the input was partially invalid. |
| Log entry without trace context | Missing correlation. This log cannot be linked to the request that caused it. |

### Metrics

Request counts, error rates, latency distributions,
message queue depths.

**When to inspect**: After a journey walk completes.
Compare aggregate metrics before and after a change
to detect regressions.

**What to look for**: Latency distribution shifts,
error rate changes, queue depth increases after batch
operations.

## Healthy Trace Patterns

For different operation types, define what a healthy
trace should look like:

### Simple read (list, get by ID)

- 1-3 DB queries (authorization check + data fetch).
- No message publications.
- < 100ms total duration.

### Simple mutation (create, update)

- 1-3 DB queries (authorization + read + write).
- 0-2 event publications.
- All consumer spans succeed if events are published.
- < 200ms total duration (excluding external calls).

### Batch operation (publish N items)

- DB queries proportional to item count, not N+1.
- 1 batch event publication (fat event), not N
  individual events.
- Consumer spans complete without error.
- Duration scales linearly with item count.

### Cross-module operation (involves external service)

- External HTTP span clearly visible.
- Retry spans visible if the external call failed and
  was retried.
- Compensation span visible if the operation failed
  after a partial external change.
- Total duration dominated by external call, not
  internal processing.

## Trace Analysis Tool

Manual trace inspection does not scale. A dedicated
trace analysis tool (MCP server) should:

1. Accept a trace ID.
2. Extract structured metrics: span count, DB query
   count, errored spans, duplicate entity loads,
   external call durations, consumer success/failure.
3. Compare metrics against budgets defined in
   evaluation criteria.
4. Return structured violations (not scores, not
   judgments — binary violations with evidence).

See
[specs/trace-analyzer/README.md](../specs/trace-analyzer/README.md)
for the specification.

## Development Dashboard

Use a trace visualization dashboard during
development. This is not optional — without it,
traces are invisible.

Options:

- .NET Aspire dashboard (built-in, no setup).
- Jaeger UI (standalone, language-agnostic).
- Grafana + Tempo (production-grade, complex setup).
- Any OTel-compatible visualization tool.

The dashboard must be accessible to both the developer
(for manual inspection) and to AI tools (via MCP or
API) for automated trace analysis during journey
walks.
