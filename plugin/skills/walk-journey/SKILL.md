---
name: walk-journey
description: "Walk a journey against a callable surface. Use when asked to verify a system end-to-end, run a journey, or test a user flow. Executes journey steps sequentially through the callable surface, collects responses and trace IDs, and produces a walk report."
argument-hint: "[journey file path]"
---

# Walk Journey

Walk a defined journey against the system's callable
surface. Execute each step, collect results, and
produce a structured walk report.

## Before you start

1. Read the journey file provided by the user.
2. Confirm the callable surface is available (MCP
   server running, REST API reachable, CLI accessible).
3. Check pre-walk conditions listed in the journey.

## Walk procedure

Follow the four phases from the AI-Driven Development
walk procedure:

### Phase 1: Pre-walk

- Verify the system is in the expected starting state.
- Confirm all services are running.
- Note the starting time for trace correlation.

### Phase 2: Walk

For each step in the journey:

1. Read the step description and expected outcome.
2. Execute the action through the callable surface.
3. Record the response (status, body, errors).
4. Capture the trace ID from response headers or logs
   if available.
5. Compare the actual outcome against the expected
   outcome.
6. Mark the step as PASS or FAIL with a brief reason.

Do NOT skip steps. If a step fails, continue with
remaining steps unless the journey marks it as
blocking.

### Phase 3: Report

Produce a walk report with this structure:

```markdown
# Walk Report: [Journey Name]

**Date**: [timestamp]
**System**: [what was tested]
**Walker**: AI agent
**Result**: PASS | FAIL

## Steps

| # | Step | Expected | Actual | Result |
|---|------|----------|--------|--------|
| 1 | ...  | ...      | ...    | PASS   |

## Findings

- [list any issues, unexpected behaviors, or
  quality concerns]

## Trace IDs

- Step 1: [trace-id]
- Step 2: [trace-id]
```

### Phase 4: Fix and re-walk

If findings exist:
1. Report findings to the user.
2. Wait for fixes.
3. Re-walk only the failed steps unless the user
   requests a full re-walk.

## Important

- Do not interpret traces subjectively. If trace
  analysis is needed, use the `analyze-trace` skill.
- Do not invent expected outcomes. Use only what the
  journey file defines.
- If the journey references evaluation criteria, use
  the `evaluate-criteria` skill after the walk.
