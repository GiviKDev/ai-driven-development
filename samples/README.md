# Samples

Copy-and-adapt samples for each layer of the
methodology. These are starting points, not
templates -- every project will diverge from them.

## What is here

### Instructions (Layer 3)

Files that tell AI agents how to behave when
working with specific file types or in specific
contexts. These are loaded automatically by the
AI tool.

- [critical-review.instructions.md](instructions/critical-review.instructions.md)
  -- Sparring partner mode. Challenge before
  implementing.
- [coding-standards.instructions.md](instructions/coding-standards.instructions.md)
  -- Language-agnostic coding rules.
- [markdown.instructions.md](instructions/markdown.instructions.md)
  -- Formatting rules for documentation.

**Where they go:**

- VS Code / Copilot:
  `.github/instructions/*.instructions.md`
- Claude Code: merge into `CLAUDE.md`
- Cursor: merge into `.cursorrules`

### Skills (Layer 4)

Reusable skill definitions that extend AI agent
capabilities. Skills are invoked by name during
conversations.

- [verify-build/SKILL.md](skills/verify-build/SKILL.md)
  -- Run build commands and report results.

**Where they go:**

- Copilot: `plugin/skills/<name>/SKILL.md`
- Claude Code:
  `.claude-plugin/skills/<name>/SKILL.md`

### Hooks (Layer 0-1)

Quality gates that reduce the surface area of
commands AI agents need to run. A Makefile wraps
multi-step operations into single commands. A
pre-commit hook enforces gates before every commit.

- [Makefile](hooks/Makefile)
  -- Quality gate commands for a .NET project.
- [pre-commit](hooks/pre-commit)
  -- Git hook that runs quality gates.

**Where they go:**

- `Makefile` at project root
- `pre-commit` at `.git/hooks/pre-commit` (or use
  a hook manager like Husky, lefthook, or
  pre-commit framework)

### Journeys (Layer 5)

Complete journey definitions with steps, criteria,
and expected walk report structure.

- [user-registration.md](journeys/user-registration.md)
  -- A user registers, verifies email, and logs in.

**Where they go:**

- In a `journeys/` directory at project root, or
  wherever your project keeps verification
  artifacts.
