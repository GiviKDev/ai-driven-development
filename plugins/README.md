# Plugins

Portable AI customization bundles. Use a plugin when
skills, agents, hooks, journeys, manifests, or MCP
configuration are meant to work together and be
installed as one unit.

Use the root artifact catalogs for standalone
samples. Do not create a plugin for one isolated
instruction, prompt, skill, or agent unless packaging
is the point.

## What Belongs Here

A plugin may contain:

- `plugin.json` manifest metadata.
- `.claude-plugin/plugin.json` when a Claude-compatible
  manifest copy is needed.
- `skills/` for Agent Skills.
- `agents/` for custom agents or subagents.
- `hooks.json` or `hooks/` for lifecycle automation.
- `.mcp.json` for MCP server definitions.
- Workflow-specific supporting files, such as
  journeys, templates, scripts, or references.

Keep duplicated manifest metadata in sync. Release
automation owns version updates; do not bump versions
manually.

## Current Plugins

- `journey-verification` — trace-backed journey
  verification skills and agent. Manifest:
  [journey-verification/plugin.json](journey-verification/plugin.json).
  Method specification:
  [../docs/methods/journey-verification/README.md](../docs/methods/journey-verification/README.md).

## Validation

Run plugin validation with:

```bash
make validate-plugin
```
