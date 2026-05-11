---
name: design-journey
description: "Design a new journey for a system. Use when asked to create, write, or define a journey, user flow, or verification scenario. Produces a structured journey file following the AI-Driven Development format."
argument-hint: "[description of the user flow to verify]"
---

# Design Journey

Help the user design a new journey — a sequence of
steps that verifies a user-facing flow through the
system's callable surface.

## What a journey is

A journey is NOT a test case. It is a verification
arc that exercises the system the way a real user
would, through the callable surface, producing
observable traces.

A good journey:
- Follows a real user intent (not a technical edge
  case).
- Uses the callable surface (MCP tools, REST API,
  CLI), not internal code.
- Produces traces that can be analyzed.
- Has clear expected outcomes for each step.
- Is walkable by an AI agent without human
  intervention.

## Journey structure

Every journey must follow this format:

```markdown
# Journey: [Name]

## Context

[What this journey verifies. One paragraph.]

## Pre-conditions

- [System state required before walking]
- [Services that must be running]
- [Data that must exist]

## Steps

### Step 1: [Action name]

**Action**: [What to do via the callable surface]
**Expected**: [What should happen]

### Step 2: [Action name]

**Action**: [What to do]
**Expected**: [What should happen]

[... more steps ...]

## Post-conditions

- [Expected system state after all steps complete]
- [Data that should exist or not exist]

## Evaluation criteria

- [Criterion 1: scope — binary check]
- [Criterion 2: scope — binary check]
```

## Process

1. Ask the user what user flow they want to verify.
2. Identify the callable surface (MCP, REST, CLI).
3. Draft the journey following the structure above.
4. Review with the user:
   - Are the steps realistic user actions?
   - Are expected outcomes specific and verifiable?
   - Are pre-conditions achievable?
   - Are evaluation criteria binary (pass/fail)?
5. Save the journey file to the project's journeys
   directory.

## Guidelines

- Keep journeys short: 3-10 steps. If a journey
  exceeds 10 steps, consider splitting it.
- Each step should have exactly one action and one
  expected outcome.
- Expected outcomes must be verifiable from the
  callable surface response or from traces. No
  "the user should feel confident" — that is not
  verifiable.
- Include both the happy path and at least one error
  case (e.g., "Step 5: attempt unauthorized access,
  expected: 403").
- Name journeys after the user intent, not the
  technical flow: "Create and publish article" not
  "POST /articles + PUT /articles/:id/publish."
