# Principles

Design principles for documentation, instructions,
and verification in AI-assisted projects.

## Brief and Alive

Documentation must be short enough to read in one
sitting and current enough to be trusted.

- **Brief**: Bullet lists over prose. One concept per
  file. Short sentences. If a doc is longer than two
  screens, split it.
- **Alive**: Documentation describes the current
  state. When the system changes, the doc is updated
  or replaced — not appended with history. "We used
  to use X but now we use Y" makes AI produce X half
  the time. Replace the doc. Delete the history.
- **No historical backfill**: Decision rationale
  belongs in decision records. The main docs should
  never explain past architectures unless that context
  is needed to understand the current one.

## Structured for Both Humans and AI

The same documentation structure must be navigable by
humans scanning an index and by AI loading files into
context.

- **Numbered folders**: `01-foundation/`,
  `02-architecture/`, `03-decisions/`. AI and humans
  both benefit from a predictable, scannable ordering.
- **README index**: Every folder has a README that
  lists and briefly describes its contents. AI reads
  the README, identifies the relevant file, and loads
  only that file — not the entire folder.
- **One concept per file**: `001-problem.md`,
  `002-vision.md`, not `overview.md` with 15
  sections. Small files load into AI context entirely.
  Large files get truncated or skipped.
- **Simple structure**: Avoid deep nesting. Two levels
  of folders maximum. AI tools struggle with deeply
  nested paths and lose context when navigating them.

## Opinionated, Not Neutral

Documentation and instructions must take positions.

- "Use X. Y is wrong because Z." — actionable.
- "Consider X or Y depending on your needs." — AI
  picks arbitrarily and produces inconsistent output.

Every doc, instruction, and standard should have a
clear recommendation. When multiple options are
genuinely equivalent, say so explicitly — but this
should be rare.

## Enforceable Over Advisory

If a rule matters, it must be enforced -- not
suggested.

- **Advisory**: A doc that says "prefer
  `Guid.CreateVersion7()`." AI follows this
  sometimes.
- **Enforceable**: An instruction file with
  `applyTo: '**/*.cs'` that says "Use
  `Guid.CreateVersion7()`. `Guid.NewGuid()` is
  wrong." AI follows this every time the instruction
  is loaded.
- **Deterministic**: A build rule that fails on
  `Guid.NewGuid()`. AI cannot produce code that
  violates this.

Move rules up the enforcement ladder whenever
possible. Advisory < Instruction < Build rule <
Runtime check.

## Tooling as Infrastructure

AI agents interact with the system through commands.
Every raw CLI command is an opportunity for error --
wrong flags, wrong paths, wrong order of operations.
Reduce this surface.

- **Makefile as boundary**: Wrap multi-step
  operations into single make targets:
  `make format`, `make build`, `make test`,
  `make pre-commit`. AI runs defined commands, not
  arbitrary CLI.
- **Pre-commit hooks as gates**: Quality checks run
  automatically before every commit. AI cannot skip
  them.
- **Auto-approval for safe operations**: Allow AI
  to run `make test` without confirmation. Require
  approval for `make deploy` or editing the
  Makefile itself.
- **Restrict dangerous edits**: AI should not modify
  the Makefile, CI config, or hook definitions
  without explicit permission. These define the
  safety boundary.

The principle: AI operates inside a well-defined
toolbox. The developer defines the toolbox. The
repository's own [Makefile](../../Makefile)
illustrates the pattern: AI can run `make
pre-commit` freely; modifying the Makefile itself
requires explicit permission.

## Verification Over Trust

A passing test does not mean the system works. A
successful HTTP response does not mean the internals
are correct.

- **Trust nothing**: After every system call,
  inspect the execution trace. Check for errored
  spans, redundant queries, missing event
  publications, failed async consumers.
- **Criteria over judgment**: Human-defined
  evaluation criteria with binary outcomes
  (violated/not violated) replace subjective AI
  scoring. Criteria are reproducible and actionable.
  Subjective scores are neither.
- **Traces as oracle**: The response body tells you
  what the system returned. The trace tells you how
  the system produced that result. The trace is the
  truth.
