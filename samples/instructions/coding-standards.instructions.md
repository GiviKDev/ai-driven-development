---
applyTo: "**/*.{cs,ts,js,py,go,rs,java}"
description: "Language-agnostic coding standards.
  Adapt the applyTo pattern and rules to your stack."
---

# Coding Standards

## Naming

- Files, types, and variables use consistent casing
  per language convention. Do not mix styles.
- Names describe what something is or does. No
  abbreviations except universally known ones (ID,
  URL, HTTP).
- Boolean variables and methods start with is, has,
  can, should, or similar.

## Structure

- One public type per file. File name matches type
  name.
- Group related files by feature or domain concept,
  not by technical layer.
- Keep files under 200 lines. If a file grows
  beyond that, it likely has multiple
  responsibilities.

## Dependencies

- Every new dependency needs justification.
  "It's convenient" is not justification.
- Prefer platform/standard library features over
  third-party packages.
- Pin dependency versions. No floating ranges
  in production.

## Error handling

- Do not catch exceptions to swallow them. Handle
  or propagate.
- Validate input at system boundaries (API
  endpoints, message handlers, CLI arguments).
  Do not validate deep in business logic.
- Fail fast on invalid configuration. Do not wait
  for the first request to discover a missing
  setting.

## Quality gates

Run quality gates before committing:

```
make format    # Auto-fix formatting
make build     # Compile with warnings as errors
make test      # Run all tests
```

See the [Makefile sample](../hooks/Makefile) for
the gate definitions.

## AI-specific rules

- AI must run `make pre-commit` before committing
  and verify all checks pass.
- AI must not edit the Makefile without explicit
  approval. The Makefile defines the safety
  boundary.
- AI should use Makefile commands instead of
  running raw CLI tools. This reduces the surface
  area of possible errors.
