# Journey Design

What a journey is, how to write one, and how to
validate the design before walking.

## What a Journey Is

A journey is the arc a real actor travels to reach
user-meaningful value. One actor. One outcome. A
sequence of steps the actor performs, interleaved with
what the system does in response.

### What a journey is not

- **Not a test.** Tests verify code against expected
  output. Journeys verify system behavior against
  user intent.
- **Not a process.** Processes describe one trigger →
  one outcome. Journeys span several processes and
  represent a complete arc.
- **Not a spec.** Specs describe what the system
  should do. Journeys describe what the actor
  experiences when using the system.

## Journey Template

```markdown
# Journey {N}: {Outcome from actor's perspective}

## Actor

Who. Why they are here. What context they bring.

## Outcome

The plain-language sentence the actor says when done.

## Preconditions

What must be true before step 1.

## Public Steps

What the actor does. Numbered. Each step:

1. **{What the actor does}**
   - Tool / endpoint / action expected.
   - Inputs the actor brings.
   - Output the actor gets.
   - What the actor learns.

## System Steps

What the platform does between or during public
steps. Messages, side effects, eventual consistency.

## Evaluation Criteria

Journey-specific criteria beyond the global set.
Security, business, technical checks specific to
this arc.

## Failure Modes

3-5 expected error scenarios the walk should
exercise. Invalid input, unauthorized access,
missing precondition, duplicate submission.

## Open Questions

What is unknown about this journey and must be
resolved before or during the first walk.
```

## How to Write a Journey

### Start from the actor's outcome

Not from the API. Not from the code. From the
sentence the actor says when they are done: "I have
working credentials for my collector." Then work
backwards: what steps does the actor need to reach
that sentence?

### Minimum steps, not current steps

Ask: what is the minimum number of steps a thoughtful
redesign would require? If the answer is fewer than
what the current API forces, record both:

- **Current journey**: the steps the system currently
  requires.
- **Target journey**: the minimum steps the system
  should require.

The gap between them is a design finding before the
walk even starts.

### Include what the actor learns

Each step should say what the actor learns from the
output. "The actor learns they are the org owner."
"The actor learns that branch scoping is optional."
If the actor learns nothing, the step might be
ceremony — a call that exists because the API
requires it, not because the actor needs it.

## Validating a Journey Before Walking

Before walking, evaluate the journey itself:

### Is this journey valid?

Does the described arc match what real actors would
do? Or is it a fictional path that tests an imaginary
workflow? If no real user would perform these steps in
this order, the walk will test a path that doesn't
matter.

### Is it well-designed?

- Too many steps for the outcome?
- Any step doing two unrelated things?
- Hidden ordering the actor can't see (must call X
  before Y but nothing tells the actor)?
- Steps that are ceremony only (exist because the API
  requires them, not because the actor needs them)?

### Does everything exist to walk it?

- All expected tools/endpoints exist?
- Documentation for each step's expected behavior
  exists?
- Evaluation criteria for applicable scopes are
  defined?
- Preconditions can be established?

If any of these is "no," fix it before walking. The
pre-walk (see
[006-walk-procedure.md](006-walk-procedure.md)) will
catch missing tools, but design issues should be
caught here.

## Journey Sequencing

Journeys have dependencies. If journey 3 requires
credentials from journey 2, and journey 2 requires
an org from journey 1, then walks must proceed in
order. Walking journey 3 before journey 1 passes is
meaningless — the preconditions cannot hold.

Define the dependency graph explicitly. Use it to
determine which journeys to re-walk when code
changes.
