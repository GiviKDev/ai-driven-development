# Coding Standards

Rules that make code consistent. Without them, every
change has a chance of drifting in style, structure,
or pattern.

## The problem

AI generates code that looks like its training data
unless told otherwise. Two requests for the same
kind of feature, made on different days, will
produce different patterns: different naming,
different error handling, different file
organization.

Humans drift too, just more slowly. The result is
the same: a codebase that grew organically,
inconsistently, and now requires extra effort to
read and change.

Common drift symptoms:

- Three different ways to validate input.
- Some files use one naming pattern, others use
  another.
- Error handling varies by author.
- Test files sit next to source files in some
  modules and in a separate folder in others.

## Approaches

### Enforceable rules, not preferences

A rule that says "prefer X" is followed sometimes.
A rule that fails the build when X is missing is
followed always. Move rules up the enforcement
ladder whenever possible: advisory < instruction <
linter < build rule < runtime check.

### Examples over explanations

"Use this: `[example]`. Not this: `[anti-example]`."
beats a paragraph of justification. AI follows
examples reliably; AI argues with justifications.

### Cover the recurring decisions

A standard is worth writing when the same question
keeps coming up:

- Naming (files, types, variables).
- File and folder structure (where handlers go,
  where tests go).
- Error handling patterns.
- Public API conventions.
- Dependency direction (what can import what).
- Comments and documentation expectations.

### Build rules over docs

A linter that catches violations is worth more than
a doc that describes them. A doc that no tool
enforces will be ignored under deadline pressure.

### Treat warnings as errors

Warnings get ignored, accumulate, and stop being
useful. Either the warning matters (make it an
error) or it does not (suppress it explicitly).

### Document the exceptions

Where the standard does not apply, say so
explicitly. "All entities use Guid IDs except
ExternalEvent, which uses the upstream system's ID."
Otherwise AI will normalize the exception away.

## When this matters

As soon as the codebase has enough code to be
inconsistent. For a fresh project, that is the first
week. Earlier is better: standards are cheaper to
adopt before there is much code to retrofit.

## What comes next

Standards alone are not enough. AI does not
naturally consult external documents. It needs the
standards loaded into context automatically. See
[007-ai-instructions.md](007-ai-instructions.md).

## Alternative approaches

- **Style guides without enforcement**: useful only
  if the team is small and disciplined.
- **Convention-based frameworks**: let the
  framework dictate. Less flexible but consistent.
- **Generated code**: schemas generate code so
  there is no opportunity to drift. Powerful when
  the surface is amenable to generation.
- **Code review only**: relies on humans catching
  drift. Does not scale; humans miss things.

This document recommends enforceable rules plus
instruction files (next section). Other approaches
are compatible.
