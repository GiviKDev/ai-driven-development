---
name: evaluate-criteria
description: "Evaluate a completed walk against evaluation criteria. Use when asked to evaluate, score, assess, or check a walk report against defined criteria. Applies binary pass/fail checks across functional, performance, security, and observability scopes."
argument-hint: "[walk report] [criteria file]"
---

# Evaluate Criteria

Evaluate a completed walk report against defined
evaluation criteria. Each criterion gets a binary
PASS or FAIL — no scores, no percentages.

## Input

1. A walk report (from the `walk-journey` skill or
   provided by the user).
2. An evaluation criteria file defining what to check.

If no criteria file is provided, ask the user for one
or check for a `criteria.md` file in the project's
journeys directory.

## Evaluation scopes

Criteria are organized into four scopes. Evaluate
each scope independently:

### Functional

Does the system produce correct results?

- Check step outcomes against expected outcomes.
- Verify data integrity (created records exist,
  deleted records are gone).
- Confirm error handling (invalid inputs produce
  appropriate errors).

### Performance

Does the system perform within budgets?

- Compare trace metrics against defined budgets.
- Check: DB query count, response time, external
  call duration.
- Use the `analyze-trace` skill if trace data is
  available.

### Security

Does the system protect data and access?

- Verify authorization (unauthorized access is
  denied).
- Check that sensitive data is not leaked in
  responses.
- Confirm audit trails exist for sensitive actions.

### Observability

Is the system's behavior visible?

- Verify traces are produced for each operation.
- Check that spans have meaningful names.
- Confirm error spans contain useful information.

## Output format

```markdown
# Evaluation: [Journey Name]

**Date**: [timestamp]
**Result**: PASS | FAIL

## Criteria Results

| Scope | Criterion | Result | Evidence |
|-------|-----------|--------|----------|
| Functional | ... | PASS | Step 3 returned expected 201 |
| Performance | DB queries < 5 | FAIL | Trace shows 14 queries |

## Violations

- [list criteria that failed with specific evidence]

## Verdict

[One sentence: passed all criteria, or failed N
criteria in M scopes]
```

## Rules

- Every criterion is binary: PASS or FAIL. No
  partial credit, no "mostly passes."
- Evidence must be specific: trace IDs, response
  bodies, metric values. Not "seemed slow."
- If a criterion cannot be evaluated (missing data),
  mark it as BLOCKED with the reason.
- Do not add criteria that are not in the criteria
  file. Evaluate only what is defined.
