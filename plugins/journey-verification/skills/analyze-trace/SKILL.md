---
name: analyze-trace
description: "Analyze a distributed trace for quality metrics. Use when asked to analyze a trace, check performance, find duplicate queries, or evaluate trace data. Extracts structured metrics from trace spans and compares against budgets."
argument-hint: "[trace ID or trace data]"
---

# Analyze Trace

Analyze a distributed trace and extract structured
quality metrics. Compare metrics against budgets to
identify violations.

## What this skill does

Given a trace (by ID or raw span data), extract:

- **Span count**: total spans in the trace.
- **DB query count**: spans with `db.system` attribute.
- **Errored spans**: spans with error status or
  exception events.
- **External calls**: HTTP spans to external hosts.
- **Total duration**: root span duration in ms.
- **Duplicate entity loads**: same table + same key
  queried multiple times.

## Input

Accept one of:

1. A trace ID — requires a connected trace backend
   (Jaeger, Aspire, Tempo).
2. Raw trace/span data (JSON) — analyze directly.
3. A trace export file path — read and parse.

If the trace backend is not configured, ask the user
to provide raw span data or a file path.

## Span classification

| Span attribute | Classification |
|---|---|
| `db.system` present | DB query |
| `http.method` + external `http.url` | External HTTP call |
| `messaging.system` present | Message handler |
| Name matches known entity patterns | Entity load |

## Duplicate entity load detection

1. Find all DB spans.
2. Extract table name from `db.statement` or
   `db.collection.name`.
3. Extract key value from span attributes or
   statement parameters.
4. Group by (table, key). Groups with count > 1
   are duplicates.

This is a heuristic. False positives occur when
re-reads after mutation are intentional. Note this
in the output.

## Budget comparison

Default budgets (override with user-provided values):

| Metric | Default budget |
|---|---|
| dbQueryCount | 5 |
| responseTimeMs | 500 |
| externalCallTimeMs | 5000 |
| maxEntityLoadsPerType | 1 |

## Output format

```markdown
# Trace Analysis: [trace ID]

## Summary

| Metric | Value | Budget | Status |
|---|---|---|---|
| Span count | 23 | — | — |
| DB queries | 14 | 5 | VIOLATED |
| Errored spans | 1 | 0 | VIOLATED |
| External calls | 2 | — | — |
| Duration | 340ms | 500ms | OK |

## Duplicate Entity Loads

| Entity | Load count | Span IDs |
|---|---|---|
| Organization | 3 | span1, span2, span3 |

## Errored Spans

| Span | Operation | Error |
|---|---|---|
| span7 | BatchPublishedHandler | UnResolvableVariableException |

## Violations

- dbQueryCount: 14 exceeds budget of 5
- erroredSpanCount: 1 exceeds budget of 0
```

## When trace backend is available

If an MCP server for trace access is configured
(see `.mcp.json`), use it to fetch traces by ID.
Otherwise, work with data the user provides directly.

## Limitations

- Duplicate detection is heuristic-based and may
  produce false positives.
- Span classification depends on OTel semantic
  conventions being followed.
- Without a trace backend, the user must provide
  raw span data.
