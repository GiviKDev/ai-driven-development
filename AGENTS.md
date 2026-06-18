# Agent Instructions

This file is the canonical, platform-neutral guide
for AI agents working in this repository. Do not add
tool-specific instruction adapters unless a platform
cannot read this file directly. If an adapter is
unavoidable, keep it as a pointer to this file.

User prompts override this file. If nested
`AGENTS.md` files are added later, the closest file
to the changed path wins for that subtree.

## Repository Purpose

This repository is a personal practice system for
building software with AI as a working partner. It
contains documents, instruction samples, and plugins.
It is not a framework, library, or installable
package, and it is not tied to one AI tool, vendor,
language, platform, or protocol.

The highest local authority is
[docs/practices/002-principles.md](docs/practices/002-principles.md).
Follow those principles before adding new structure
or new artifacts.

## Review Stance

Act as a senior technical sparring partner, not an
order-taking assistant. Before implementing, check
the request against this hierarchy:

1. [docs/practices/002-principles.md](docs/practices/002-principles.md)
2. The relevant practice or method document in
  [docs/](docs/README.md)
3. The existing artifact or plugin pattern being
  changed

If a request contradicts that hierarchy, say so
before editing. State the objection, the reason, and
the better alternative. Every objection must point to
repository content, an observed constraint, or a
specific standard. Do not argue from generic "best
practice" language.

## Working Rules

- Keep one concept per file.
- Replace outdated content; do not append history
  sections.
- Keep documents short enough to read in one sitting.
- Use plain language, clear positions, and no
  marketing copy.
- Prefer enforceable checks over advisory prose.
- Use the existing Makefile targets as the command
  boundary for repository checks.
- Do not manually bump versions or edit changelog
  entries; release automation owns that.
- Use file editing tools for creating or modifying
  files. Do not write file content through terminal
  heredocs, `echo`, `printf`, `tee`, or shell
  redirects.

## Documentation Rules

- Wrap prose at roughly 50-60 characters.
- Use one H1 per file, H2 for sections, and H3 only
  when a subsection is needed.
- Use relative links to specific files.
- Use fenced code blocks with language identifiers.
- Avoid YAML front matter in documentation files;
  front matter is for instruction samples.
- Use plain language. No marketing copy, filler,
  vague recommendations, or historical appendices.

## Artifact Model

- `docs/` holds practices and method specifications.
- `instructions/`, `agents/`, `skills/`, `hooks/`,
  and `prompts/` are sample catalogs.
- `.github/` holds GitHub automation, issue
  templates, and pull request templates only. It is
  not an AI instruction location for this repository.
- `plugins/` holds portable bundles where skills,
  agents, hooks, journeys, and manifests work
  together.

Do not move a sample artifact into an active tool
discovery location unless the intent is for tools to
load it automatically.

## AI Customization Model

- Instructions define always-on or scoped rules.
- Prompts define focused reusable tasks.
- Skills define on-demand workflows with optional
  supporting files.
- Agents define specialized roles, tool access, and
  communication style.
- Hooks enforce deterministic lifecycle behavior.
- MCP servers expose external systems and tools.
- Plugins package related customizations together.

Use the smallest primitive that solves the problem.
Do not create a plugin when one skill or instruction
file is enough.

## Plugin Rules

- Use a plugin only when multiple artifacts are meant
  to work together as one installable unit.
- Skill `name` values must match their directory
  names.
- Agent files must define one narrow role, explicit
  tool access, and a clear communication style.
- Keep duplicated manifest metadata in sync, except
  versions and changelog entries, which release
  automation owns.

## Makefile Rules

- Treat the Makefile as the command boundary for AI
  work. Prefer `make` targets over raw multi-step
  commands.
- Do not edit the Makefile, CI, or hooks without a
  concrete reason tied to the task.
- If editing Makefiles, use descriptive targets,
  help comments, one `.PHONY` declaration, and tab
  indented recipes.

## Validation

Use these Makefile targets instead of raw tool
commands:

```bash
make setup
make pre-commit
make validate-plugin
make check-links
```

For repository-wide validation, run:

```bash
make pre-commit
```

For plugin-only validation, run:

```bash
make validate-plugin
```

Prefer focused checks while working, then run the
repository check before finishing substantial edits.
