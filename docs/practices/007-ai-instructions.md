# AI Instructions

Standards and conventions only work if they reach AI
when it generates code. Instruction files are how
that happens.

## The problem

Most AI tools do not read your `docs/` folder by
default. Every new chat session starts blank.
Without explicit instruction loading:

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
match a pattern. Many tools use front matter to
describe the scope:

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

An `AGENTS.md` file at the repository root is the
portable default for repository-level guidance. Use
it for facts that apply everywhere: what the repo is,
language conventions, validation commands, and hard
constraints.

If a tool requires a different entrypoint, add a
thin adapter that points back to the shared source.
Do not maintain separate copies of the same rules.

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

### Prompt engineering

Prompt engineering is task-level direction. A good
prompt names the goal, constraints, expected output,
examples, anti-examples, and validation step.

Use prompt files for focused repeatable tasks. Do
not use long prompts as project memory. Stable
project knowledge belongs in docs, instructions,
skills, agents, or plugins.

### Context engineering

Context engineering decides what the AI sees before
it answers. Good context is intentional and loaded at
the narrowest useful scope:

- Docs hold durable project knowledge.
- Instructions hold always-on or path-scoped rules.
- Skills hold on-demand procedures and resources.
- Agents hold role, tool, and communication rules.
- Plugins package workflows that need multiple
  artifacts together.

More context is not automatically better. Load the
smallest context that lets the AI make the next
decision correctly.

### Harness engineering

Harness engineering gives AI a repeatable way to
prove or disprove its work. A harness defines how to
set up state, exercise the system, collect evidence,
and compare results against clear criteria.

Prompts ask. Context informs. Harnesses verify. For
quality mechanisms, see [010-quality.md](010-quality.md)
and [011-automation.md](011-automation.md).

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

Start with platform-neutral instructions in
`AGENTS.md`. Add scoped instruction samples only
when rules apply to a subset of paths. Install those
samples into whatever location a tool supports.

Mirror rules only when a platform cannot read the
shared source. Mirrored files must stay small and
point back to the canonical guidance.

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
