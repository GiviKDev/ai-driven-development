# Trace Analyzer MCP Server

## What This Is

An MCP server that connects to an OpenTelemetry
collector, extracts structured metrics from
distributed traces, compares them against evaluation
budgets, and returns machine-readable results.

This tool exists to make trace-based evaluation
deterministic. Instead of an AI reading raw trace
spans and subjectively deciding "too many queries,"
the trace analyzer extracts concrete numbers and
compares them against thresholds.

## Why It Exists

In the AI-Driven Development methodology, every
call during a journey walk is followed by trace
analysis. Without this tool, trace analysis depends
on AI interpretation of raw span data — which is
non-deterministic and varies across models.

With this tool, the flow becomes:

```text
1. AI calls a product tool (e.g., create org)
2. AI calls trace-analyzer.analyze({ traceId })
3. Tool returns: { dbQueryCount: 14, erroredSpans: 1, ... }
4. AI compares against budget: dbQueryCount 14 > budget 5
5. AI reports: "VIOLATED: dbQueryCount exceeds budget"
```

The AI does not interpret traces. It compares numbers.

## Architecture

```text
MCP Client (VS Code, Claude, etc.)
    │
    │  stdio or Streamable HTTP
    ▼
Trace Analyzer MCP Server
    │
    │  OTLP/gRPC or HTTP
    ▼
OTel Collector / Backend
(Aspire Dashboard, Jaeger, Tempo, etc.)
```

The server is a standalone process. It does not run
inside any product. It connects to whatever OTel
backend the project uses.

## Transport

Support both:

- **stdio**: For local development. VS Code launches
  the server as a subprocess.
- **Streamable HTTP**: For remote/shared instances.

stdio is the primary transport for local dev.

## Technology

- **Language**: TypeScript (Node.js). Rationale:
  MCP SDK is most mature in TypeScript. The tool
  is language-agnostic — it analyzes OTel data, not
  source code.
- **MCP SDK**: `@modelcontextprotocol/sdk` (latest).
- **OTel data access**: Depends on the backend.
  See [Data Source](#data-source) section.

## Data Source

The trace analyzer needs to read spans from an OTel
backend. Options:

### Option A: Aspire Dashboard OTLP endpoint

The .NET Aspire dashboard receives OTLP data and
exposes it via a gRPC service. The trace analyzer
connects to this endpoint and queries spans by
trace ID.

Pros: Zero additional infrastructure for .NET Aspire
users. Cons: Aspire-specific, not portable.

### Option B: Jaeger Query API

Jaeger exposes a REST API for querying traces by ID.
`GET /api/traces/{traceId}` returns spans in a
standard format.

Pros: Language-agnostic, widely used. Cons: Requires
Jaeger.

### Option C: Tempo HTTP API

Grafana Tempo exposes `GET /api/traces/{traceId}`.

Pros: Scales to production. Cons: Requires Tempo.

### Option D: OTLP file export

For the simplest setup, the OTel collector exports
traces to JSON files. The trace analyzer reads
files from a directory.

Pros: Zero infrastructure. Cons: No real-time
query by trace ID; requires file naming by trace ID
or scanning.

### Recommendation

Support Option B (Jaeger) as the default — widely
available, simple REST API, language-agnostic.
Support Option A (Aspire) as a secondary target for
.NET users. Configuration via environment variable:

```bash
TRACE_BACKEND=jaeger
TRACE_BACKEND_URL=http://localhost:16686
```

or

```bash
TRACE_BACKEND=aspire
TRACE_BACKEND_URL=http://localhost:18889
```

## MCP Tools

### `trace.analyze`

Analyze a single trace and return structured metrics.

**Input:**

```json
{
  "traceId": "abc123...",
  "budgets": {
    "dbQueryCount": 5,
    "responseTimeMs": 500,
    "externalCallTimeMs": 5000
  }
}
```

`budgets` is optional. If omitted, use defaults:

| Metric | Default budget |
|---|---|
| dbQueryCount | 5 |
| responseTimeMs | 500 |
| externalCallTimeMs | 5000 |
| maxEntityLoadsPerType | 1 |

**Output:**

```json
{
  "traceId": "abc123...",
  "summary": {
    "spanCount": 23,
    "dbQueryCount": 14,
    "erroredSpanCount": 1,
    "externalCallCount": 2,
    "totalDurationMs": 340,
    "rootSpanName": "POST /api/v0/organizations",
    "rootSpanStatus": "Ok"
  },
  "duplicateEntityLoads": [
    {
      "entityType": "Organization",
      "loadCount": 3,
      "spanIds": ["span1", "span2", "span3"]
    }
  ],
  "erroredSpans": [
    {
      "spanId": "span7",
      "operationName": "BatchPublishedHandler",
      "error": "UnResolvableVariableException: ...",
      "parentSpanName": "POST /api/v0/source-catalog/..."
    }
  ],
  "externalCalls": [
    {
      "spanId": "span4",
      "url": "https://graph.microsoft.com/...",
      "method": "POST",
      "durationMs": 2340,
      "status": 201
    }
  ],
  "violations": [
    {
      "criterion": "dbQueryCount",
      "actual": 14,
      "budget": 5,
      "severity": "violated"
    },
    {
      "criterion": "erroredSpanCount",
      "actual": 1,
      "budget": 0,
      "severity": "violated"
    }
  ]
}
```

### `trace.list`

List recent traces, optionally filtered by service.

**Input:**

```json
{
  "service": "api",
  "limit": 10,
  "minDurationMs": 100
}
```

All fields optional.

**Output:**

```json
{
  "traces": [
    {
      "traceId": "abc123...",
      "rootSpanName": "POST /api/v0/organizations",
      "durationMs": 340,
      "hasErrors": true,
      "spanCount": 23,
      "timestamp": "2026-05-09T14:30:00Z"
    }
  ]
}
```

### `trace.compare`

Compare two traces (before/after a fix) and return
the diff in metrics.

**Input:**

```json
{
  "beforeTraceId": "abc123...",
  "afterTraceId": "def456...",
  "budgets": {}
}
```

**Output:**

```json
{
  "before": { "dbQueryCount": 14, "...": "..." },
  "after": { "dbQueryCount": 4, "...": "..." },
  "improvements": [
    {
      "metric": "dbQueryCount",
      "before": 14,
      "after": 4,
      "budgetMet": true
    }
  ],
  "regressions": []
}
```

## Span Classification

The trace analyzer must classify spans to compute
metrics. Classification rules:

| Span attribute | Classification |
|---|---|
| `db.system` is present | DB query |
| `http.method` + `http.url` pointing to external host | External HTTP call |
| `messaging.system` is present | Message handler |
| Span name matches known entity patterns | Entity load (for duplicate detection) |

### Duplicate Entity Load Detection

Heuristic: Two or more DB spans in the same trace
that query the same table with the same primary key
value are duplicate entity loads.

Detection approach:

1. Find all DB spans.
2. Extract table name from `db.statement` or
   `db.collection.name`.
3. Extract key value from `db.statement` parameters
   or span attributes.
4. Group by (table, key). Groups with count > 1 are
   duplicates.

This is a heuristic and will have false positives
(intentional re-reads after mutation). Document this
limitation.

## Configuration

```bash
TRACE_BACKEND=jaeger|aspire|tempo
TRACE_BACKEND_URL=http://localhost:16686
DEFAULT_DB_QUERY_BUDGET=5
DEFAULT_RESPONSE_TIME_MS=500
DEFAULT_EXTERNAL_CALL_TIME_MS=5000
DEFAULT_MAX_ENTITY_LOADS_PER_TYPE=1
```

## Error Handling

- If the trace backend is unreachable, return a clear
  error: "Cannot connect to trace backend at {url}."
- If the trace ID is not found, return: "Trace
  {traceId} not found. It may not have been exported
  yet. Wait a few seconds and retry."
- Never crash. Return structured errors via the MCP
  error response format.

## Testing

- Unit tests for span classification logic.
- Unit tests for duplicate entity load detection.
- Unit tests for budget comparison.
- Integration test against a Jaeger instance with
  known trace data.

## Package

Publish as an npm package:
`@ai-driven-dev/trace-analyzer`.

Installable via:

```json
{
  "mcpServers": {
    "trace-analyzer": {
      "command": "npx",
      "args": [
        "-y",
        "@ai-driven-dev/trace-analyzer@latest"
      ],
      "env": {
        "TRACE_BACKEND": "jaeger",
        "TRACE_BACKEND_URL": "http://localhost:16686"
      }
    }
  }
}
```

## Out of Scope (v1)

- Log analysis (future: extract structured logs for
  a trace and analyze them).
- Metric aggregation across multiple traces (future:
  trend analysis over time).
- Auto-baselining (future: compute budgets from
  historical trace data).
- Alert integration (future: notify when a journey
  walk produces violations).
