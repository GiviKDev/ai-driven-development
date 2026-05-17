# Project Structure

A project's structure is how humans and AI agents
navigate the code, documentation, and tooling.
Structure that is not deliberately designed becomes
an obstacle.

## The problem

Without a clear structure:

- AI agents place new files arbitrarily. Two
  features written days apart end up organized
  differently.
- Contributors spend time finding things instead of
  doing the work.
- Documentation gets buried next to code where
  nobody looks.
- Build, test, and tooling configurations scatter
  across the repository.

AI is particularly sensitive to structure. It
follows patterns it observes. If the structure is
inconsistent, AI extends the inconsistency.

## Approaches

### Predictable folder names

Use names that describe what the folder contains,
not what type of file is inside. `docs/` not
`markdown/`. `plugins/` not `json/`. `hooks/` not
`scripts/`.

### Numbered files for ordered reading

When reading order matters (documentation,
specifications), prefix files with numbers:
`001-problem.md`, `002-principles.md`. AI and
humans both benefit from a predictable, scannable
ordering.

### README index per folder

Every folder containing non-obvious content has a
`README.md` that lists and briefly describes its
contents. AI reads the README, identifies the
relevant file, and loads only that file — not the
entire folder.

### One concept per file

Large files get truncated by AI tools or skipped.
Small files load into AI context entirely. Split
when a file covers multiple concerns.

### Flat over nested

Two levels of folders is usually enough. Deeply
nested paths confuse AI agents and humans alike.

### Separate by stability, not by type

Stable artifacts (released code, finalized docs)
live separately from work in progress. Tooling
configuration lives separately from application
code. This makes it obvious what can be touched
freely and what requires care.

## When this matters

At project formation, and whenever the project
grows past what its current structure can hold.
Sign that restructuring is overdue:

- Files keep ending up in `misc/` or `utils/`.
- New contributors ask "where does X go?" more than
  once.
- AI repeatedly places files in the wrong location.

## What comes next

Structure tells you where things go. The next
problem is what knowledge those locations should
contain so it persists across sessions. See
[005-documentation.md](005-documentation.md).

## Alternative approaches

- **Domain-driven layout**: organize by business
  domain (e.g., `billing/`, `users/`) rather than
  by technical concern. Useful for large systems.
- **Monorepo with packages**: each independent
  deliverable in its own package folder. Useful
  when the repository produces multiple artifacts.
- **Convention-based frameworks**: some frameworks
  (Rails, Next.js) dictate structure. Follow the
  convention rather than fighting it.

This repository uses a flat, type-based layout
because it produces a small number of distinct
artifacts. Pick what fits your project.
