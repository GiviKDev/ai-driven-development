---
applyTo: "plugin/**"
---

# Plugin Development Rules

## Skills (SKILL.md)

- YAML frontmatter is required: name (kebab-case),
  description, argument-hint
- Name must match the directory name
- Description should be a clear one-sentence
  explanation of what the skill does
- Instructions should be imperative. Tell the agent
  what to do, step by step
- Define output format explicitly
- Include examples where behavior is ambiguous

## Agents (.agent.md)

- Define the agent's role in one sentence
- List available tools explicitly
- Specify communication style
- Keep agent scope narrow. One agent, one job

## Manifests

- plugin.json (Copilot) and
  .claude-plugin/plugin.json (Claude Code) must
  stay in sync: same name, version, description
- Bump version in both files together
