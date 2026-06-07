# Skills

Standalone AI skill samples (`SKILL.md` files).
Each file defines a single capability with YAML
frontmatter (`name`, `description`,
`argument-hint`) and step-by-step instructions.

This folder is a catalog of reusable samples.
Skills that work together with agents belong in
`plugins/` instead.

This is not an active tool-discovery location. To
make a skill active in a project, place it under
`.github/skills/<name>/`, `.agents/skills/<name>/`,
`.claude/skills/<name>/`, or a plugin's `skills/`
directory.

Follow the Agent Skills convention: the directory
name and `name` frontmatter must match, the name must
be lowercase kebab-case, and the description must say
what the skill does and when to use it.

Use a skill for an on-demand workflow with optional
supporting files. Use instructions for rules that
should apply broadly.

Currently empty. Samples will be added as they
emerge from real projects.
