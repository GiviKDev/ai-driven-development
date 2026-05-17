# Walk Procedure

How to walk a journey: pre-walk, walk, report, fix,
re-walk.

## Actors

| Actor | Role | Does | Does not |
|---|---|---|---|
| AI agent | Walker, implementer | Calls tools, analyzes traces, evaluates criteria, reports violations, implements approved fixes | Decide what to fix, push code, make product decisions |
| Human | Reviewer, decision-maker | Reviews walk results, approves/rejects fixes, steers priorities, provides domain context | Call tools, write transcripts, file issues |

## Phase 1 — Pre-walk

Before calling any tools:

### 1. Check tool inventory

List all available tools on the callable surface.
Compare against expected journey steps. Missing tools
are findings. If a tool is missing and the journey
cannot proceed without it:

- **Option A**: Build the tool, then walk. Preferred
  when the tool is a thin wrapper around existing
  logic.
- **Option B**: Report the gap and stop. Preferred
  when the tool requires new business logic.

The human decides which option applies.

### 2. Inspect schemas

For existing tools, verify:

- Optional parameters are not marked required.
- Enum values are exposed (not opaque integers or
  unconstrained strings).
- Response shapes are documented.
- Error shapes include diagnostic detail.

Schema defects are findings.

### 3. Verify preconditions

Call read-only tools to confirm the journey's starting
state exists. If preconditions fail, the walk stops
with a "precondition failure" status.

### 4. Load evaluation criteria

Read the global evaluation criteria and any
journey-specific criteria. These are the checklist for
every step.

## Phase 2 — Walk

For each step in the journey:

### 1. Call the tool

Use the callable surface as a real client would. Do
not use shortcuts, internal APIs, or direct database
access. The walk tests what clients experience.

### 2. Analyze the trace

After each call, inspect the distributed trace. Use
the trace analysis tool if available (see
[trace-analyzer/](../trace-analyzer/README.md)),
or inspect manually via the observability dashboard.

Check against healthy trace patterns defined in
[../../practices/009-observability.md](../../practices/009-observability.md).

### 3. Evaluate against criteria

Check the result against every applicable evaluation
criterion for this step's scopes (technical, security,
business, surface quality).

Record violations with evidence: trace span, response
body, error message. A violation is objective — either
the trace shows 14 DB queries or it doesn't.

### 4. Test failure modes

For each step, test 2-3 expected failure scenarios
from the journey's Failure Modes section:

- Invalid input (malformed email, empty required
  field).
- Unauthorized access (wrong role, wrong org).
- Missing precondition (entity doesn't exist).

Evaluate error quality against criteria: is the error
structured, machine-actionable, and does it reference
the specific business rule violated?

## Phase 3 — Report

Present to the human:

- **Step table**: Tool called, result summary,
  criterion violations with evidence, trace
  findings.
- **Failure mode results**: Error scenarios tested,
  error quality assessment.
- **System efficiency findings**: From trace analysis.
- **Proposed fixes**: With priority and scope.

No raw JSON dumps. No subjective scores. Concrete
violations with evidence.

The human decides:

- Which violations to fix now.
- Which to defer.
- Whether to re-walk immediately or after fixes.

## Phase 4 — Fix and Verify

1. AI implements approved fixes.
2. AI re-walks the journey.
3. AI reports re-walk results.
4. Repeat until zero criterion violations.

## Black Box vs White Box

See [black-white-box.md](black-white-box.md)
for the two evaluation modes.

## Walk Data

Walk transcripts are intermediate artifacts. They
serve as:

1. Evidence for the human reviewer during the current
   walk.
2. Input for future tooling that may automate walk
   evaluation.
3. Historical record of what was found and fixed.

Walk data format is not standardized. Current
practice is AI-generated markdown. Future direction:
structured JSON that can be consumed by a test
framework (xUnit-like) for automated evaluation.
