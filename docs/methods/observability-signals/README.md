# Observability Signals

Reference tables for what to look for in traces,
logs, and metrics during development-time
verification.

This is reference material used by
[009-observability.md](../../practices/009-observability.md)
and by the trace analysis skill. It defines what
constitutes a finding -- not when or why to look.

## Trace Signals

| Signal | Finding |
|---|---|
| Same entity loaded 2+ times in one trace | Redundant query. Handler or consumer re-fetches what is already in scope. |
| `status: "Error"` on a child span when the root span succeeded | Broken async consumer. The request returned 200 but a downstream handler failed. |
| Dependency resolution failure (e.g., `UnResolvableVariableException`) | Missing DI registration. The handler cannot be constructed. |
| 10+ DB spans for a simple operation | Over-querying. Likely N+1 or missing eager load. |
| External HTTP call > 2 seconds | Latency risk. External dependency is slow. |
| Event published with zero consumer spans | Published event with no handler. Either the handler is missing or the subscription is wrong. |
| Same DB table queried by multiple spans with different filters | Possible consolidation opportunity. |

## Log Signals

| Signal | Finding |
|---|---|
| Exception logged with stack trace on a non-error span | Swallowed exception. The handler caught and logged but did not propagate. |
| Validation failure logged but not returned to caller | Silent validation. The client gets 200 but the input was partially invalid. |
| Log entry without trace context | Missing correlation. This log cannot be linked to the request that caused it. |

## Healthy Trace Patterns

For different operation types, what a healthy
trace should look like.

### Simple read (list, get by ID)

- 1-3 DB queries (authorization check + data
  fetch).
- No message publications.
- < 100ms total duration.

### Simple mutation (create, update)

- 1-3 DB queries (authorization + read + write).
- 0-2 event publications.
- All consumer spans succeed if events are
  published.
- < 200ms total duration (excluding external
  calls).

### Batch operation (publish N items)

- DB queries proportional to item count, not N+1.
- 1 batch event publication (fat event), not N
  individual events.
- Consumer spans complete without error.
- Duration scales linearly with item count.

### Cross-module operation (involves external service)

- External HTTP span clearly visible.
- Retry spans visible if the external call failed
  and was retried.
- Compensation span visible if the operation
  failed after a partial external change.
- Total duration dominated by external call, not
  internal processing.
