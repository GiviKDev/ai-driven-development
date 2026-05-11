# Evaluation Criteria

Scoped, human-defined criteria that replace
subjective AI scoring.

## Why Not Scores

Subjective scoring (0-4 friction) by AI is
unreliable:

- Different models score differently for the same
  experience.
- Scores are not actionable — "friction 3" does not
  say what to fix.
- Scores are not reproducible — re-walking may
  produce different scores.
- AI "frustration" is not a meaningful proxy for
  client experience.

Evaluation criteria are concrete, verifiable rules.
Each criterion has a binary outcome: violated or not.
Violations are actionable because the criterion
states what should be true.

## Scope Organization

Criteria are organized by concern. Each scope has its
own checklist. During a walk, every step is evaluated
against all applicable scopes.

### Technical

System efficiency, query optimization, internal
correctness.

| Criterion | How to verify |
|---|---|
| No entity loaded more than once per request | Check trace for duplicate DB spans on same table with same ID |
| No errored child spans on successful response | Check trace for `status: "Error"` on any span |
| DB queries per operation ≤ budget | Count DB spans in trace. Default budget: 5 for simple CRUD, 10 for batch. |
| No missing dependency registrations | Check for DI resolution failures in trace or logs |
| Async consumers complete without error | Check all consumer spans for success |
| Response time within budget | Check root span duration. Default: < 500ms for simple ops. |

### Security

Authorization, data isolation, input validation.

| Criterion | How to verify |
|---|---|
| Cross-tenant data is not visible | Call list operations with tenant A's token; verify tenant B's data is absent |
| Mutations require correct role | Attempt mutation with insufficient role; verify rejection |
| Input validation rejects malformed data | Submit invalid input; verify structured error |
| Error responses do not leak internal details | Check for stack traces, internal IDs, SQL fragments in error responses |

### Business

Domain rules, workflow correctness, state
transitions.

| Criterion | How to verify |
|---|---|
| State transitions follow process docs | Compare actual behavior with process doc spec |
| Required preconditions are enforced | Attempt operation without precondition; verify rejection |
| Events published for state changes | Check trace for event publication spans after mutations |
| Response includes all fields needed for next step | Verify caller can proceed without out-of-band information |
| Error messages reference specific business rule | Check for domain-specific message, not generic "bad request" |

### Surface Quality

API design, tool usability, workflow coherence.

| Criterion | How to verify |
|---|---|
| All IDs for step N obtainable from steps 1..N-1 | Verify no out-of-band information required |
| Optional parameters marked optional in schema | Inspect tool/API schema |
| Enum values exposed in schema | Inspect for string enums, not opaque integers |
| Error responses structured and machine-actionable | Check for structured error shape with code, title, detail |
| Tool descriptions sufficient for intent matching | AI selects correct tool without reading source docs |

## Applying Criteria

For each step in a journey walk:

1. **Before the call**: Identify applicable scopes. A
   "register organization" step: Business + Surface
   Quality + Technical. A "create machine user" step:
   add Security.
2. **After the call**: Evaluate every applicable
   criterion. Record violations with evidence.
3. **After failure mode tests**: Evaluate Security and
   Business criteria against error scenarios.

A step passes when zero criteria are violated. A
journey passes when all steps pass.

## Evolving Criteria

Criteria are not static. Each walk may reveal new
criteria:

- A walk discovers generic error responses → add
  "error responses structured and machine-actionable"
  to Surface Quality.
- A walk discovers an eventual consistency race → add
  "async consumers complete without error" to
  Technical.

New criteria are added after the walk that discovered
the need.

## Per-Journey Criteria

Some criteria are journey-specific, documented in the
journey file under Evaluation Criteria. These
supplement the global criteria.

Example: "credentials must be shown exactly once and
never persisted by the platform." This is a security
criterion specific to a credential provisioning
journey, not applicable globally.

## Criteria Budgets

Some criteria have configurable budgets:

- DB query count: default 5 (CRUD), 10 (batch).
- Response time: default 500ms (simple), 2s (batch).
- External call duration: default 5s.

Teams adjust these based on their performance
requirements. The defaults are starting points, not
mandates.

## Machine-Verifiable Criteria

Criteria that reference trace data should be
verifiable by the trace analysis tool (see
[specs/trace-analyzer/](../specs/trace-analyzer/README.md)).
The tool extracts metrics; the criteria define
thresholds; the comparison is deterministic.

This removes AI judgment from the evaluation. The AI
does not decide whether 14 DB queries is "too many."
The criterion says the budget is 5. 14 > 5 is a
violation. No interpretation required.
