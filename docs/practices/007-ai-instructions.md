# AI Instructions

Standards and conventions only work if they reach AI
when it generates code. Instruction files are how
that happens.

## The problem

AI tools (Copilot, Claude Code, others) do not read
your `docs/` folder by default. Every new chat
session starts blank. Without explicit instruction
loading:

- AI uses training-data defaults instead of your
  project's standards.
- Coding standards documented in `docs/` are
  ignored.
- The same correction is made over and over across
  sessions.
- Different AI tools behave differently within the
  same project.

The result: standards exist on paper, not in
practice.

## Approaches

### Instruction files with apply patterns

Files that AI tools load automatically when they
match a pattern. The standard format across Copilot
and Claude Code:

```markdown
---
applyTo: '**/*.cs'
description: 'C# coding conventions'
---

# C# Standards

...rules...
```

The `applyTo` pattern decides when the file loads.
The content tells AI what to do. AI sees the file
without being asked.

### Repository-level instructions

A `copilot-instructions.md` or `AGENTS.md` file at
the repository root loads on every AI interaction.
Use for facts that apply everywhere: what the repo
is, language conventions, hard constraints (no
heredocs, no emoji, etc.).

Keep it short. Long root instructions get
truncated.

### Scoped instructions

Most rules apply to a subset of files. Use
`applyTo` patterns to load them only when relevant:

- `**/*.test.ts` — testing conventions.
- `docs/**/*.md` — documentation rules.
- `**/Makefile` — Makefile-specific advice.

Scoped files can be longer because they only load
in context where they matter.

### Instructions are negotiable, build rules are not

Instruction files tell AI what to do. They do not
prevent AI from doing otherwise. Where consistency
matters, back instructions with linters or build
rules (see [008-tools.md](008-tools.md)).

### Sample patterns to provide

- "Use X. Do not use Y."
- File templates.
- Anti-examples with the correction.
- Constraints AI cannot infer from code (e.g.,
  "this method is called from a SQL trigger; do
  not rename it").

### Cross-tool portability

Copilot reads `.github/instructions/*.instructions.md`
and `.github/copilot-instructions.md`. Claude Code
reads `AGENTS.md` and selected paths. Where
possible, structure rules so the same file works in
multiple tools. Where not possible, mirror.

## When this matters

From the moment AI is involved in writing code.
Even one instruction file per major file type is
better than none.

## What comes next

Instructions guide AI. Tools enforce the rules
regardless of who or what wrote the code. See
[008-tools.md](008-tools.md).

## Alternative approaches

- **Prompt every time**: paste standards into every
  conversation. Works for solo developers; does not
  scale.
- **Custom AI rules engines**: some teams build
  bespoke tooling. Useful only if the volume of
  rules is large enough to justify.
- **Skills and agents**: packaged AI workflows that
  include their own instructions. Useful for
  repeatable multi-step tasks. See `plugins/` in
  this repository.
