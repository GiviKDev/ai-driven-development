# Instructions

Sample AI instruction files for use in your own
projects. Copy the files you need into the
instruction location your tool supports and adapt
the rules to your stack.

These are **not** the instructions that govern this
repository. This repository's own active guidance
lives in [../AGENTS.md](../AGENTS.md).

Use `AGENTS.md` for cross-agent repository guidance.
Add tool-specific adapters only when a tool needs a
different entrypoint, and keep those adapters as
thin pointers to the shared source.

## Contents

- [coding-standards.instructions.md](coding-standards.instructions.md)
  -- language-agnostic coding conventions. Adapt
  the `applyTo` pattern and rules to your stack.
- [critical-review.instructions.md](critical-review.instructions.md)
  -- makes AI challenge requests before
  implementing. Generic version without
  project-specific references.
- [markdown.instructions.md](markdown.instructions.md)
  -- markdown formatting and writing rules.
