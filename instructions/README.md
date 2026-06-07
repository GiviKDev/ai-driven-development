# Instructions

Sample Copilot instruction files for use in your
own projects. Copy the files you need into your
repository's `.github/instructions/` folder and
adapt the rules to your stack.

These are **not** the instructions that govern this
repository. This repository's own instructions
live in `AGENTS.md`, `CLAUDE.md`,
`.github/copilot-instructions.md`, and
`.github/instructions/`.

Use `AGENTS.md` for cross-agent repository guidance,
tool-specific adapters only when a tool needs a
different entrypoint, and scoped instruction files
when rules apply to a subset of paths.

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
