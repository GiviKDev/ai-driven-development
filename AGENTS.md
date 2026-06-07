# Agent Instructions

This file is the canonical cross-agent guide for
working in this repository. Tool-specific files may
adapt it, but should not contradict it.

## Repository Purpose

This repository is a personal practice system for
building software with AI as a working partner. It
contains documents, instruction samples, and plugins.
It is not a framework, library, or installable
package.

The highest local authority is
[docs/practices/002-principles.md](docs/practices/002-principles.md).
Follow those principles before adding new structure
or new artifacts.

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

## Artifact Model

- `docs/` holds practices and method specifications.
- `instructions/`, `agents/`, `skills/`, `hooks/`,
  and `prompts/` are sample catalogs.
- `.github/` holds this repository's active GitHub
  and Copilot configuration.
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

## Validation

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
