# Problem Definition

Before code exists, the project needs a clear answer
to: what are we building, for whom, and what does
success look like? Without this, every later
decision lacks an anchor.

## The problem

Projects that skip explicit definition drift. AI
agents optimize for what they can see — usually the
latest request — and produce code that is locally
correct but globally wrong. Humans face the same
problem at a slower pace.

Common failure modes:

- Features get added because they were asked for,
  not because they fit the product.
- Scope grows. The original intent is forgotten.
- A new contributor (human or AI) reads the code
  and cannot tell what the project is for.
- Decisions that were once obvious become
  contested.

## Approaches

### Problem statement

A short document describing the gap, pain, or
opportunity the project addresses. One paragraph.
If it cannot be expressed briefly, the problem is
not understood yet.

### Scope and non-goals

What the project will do, and what it explicitly
will not do. Non-goals are as important as goals.
They prevent feature creep and give a clear answer
when AI or contributors propose work that does not
belong.

### Success criteria

What outcome makes the project useful. Not a feature
list — an outcome. Helps decide whether a proposed
change moves toward success or away from it.

### Audience

Who the project is for. Helps decide what level of
polish, documentation, and support is appropriate.

### Vision (optional)

What the project looks like when it is mature.
Useful for projects that will run for years. Less
useful for short-term work.

## When this matters

Always. At the start, this is the foundation. After
the project exists, this becomes a living document
that is revisited when scope changes, when a new
feature is proposed, or when the team gets
distracted.

## What comes next

Once intent is clear, the next problem is structure:
where things go in the repository, and how the
project is organized so humans and AI agents can
find what they need. See
[004-project-structure.md](004-project-structure.md).

## Alternative approaches

- **Spec-driven development**: detailed
  specifications precede code. Useful when
  requirements are stable and the cost of mistakes
  is high. Heavier than this document recommends.
- **Lean canvas / business model canvas**:
  product-focused tools that capture intent in a
  single page. Compatible with this document's
  approach.
- **Story mapping**: user-journey-driven definition.
  Useful when the product has many user roles.

The goal is the same: make intent explicit and
keep it current. The format is secondary.
