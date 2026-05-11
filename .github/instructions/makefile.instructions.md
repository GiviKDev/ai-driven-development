---
applyTo: '**/Makefile, **/makefile, **/*.mk'
description: 'Best practices for authoring GNU Make
  Makefiles'
---

# Makefile Development Instructions

## General Principles

- Use descriptive target names that clearly indicate
  their purpose
- Keep the default goal as the most common operation
- Prioritize readability over brevity
- Add `## Comment` after target names for `help`
  target autodiscovery

## File Structure

- Define variables at the top before rules
- Use `.PHONY` to declare targets that do not
  represent files
- Group related targets with comment headers
- Place the `help` target last

```makefile
.DEFAULT_GOAL := help

# --- Setup ---

.PHONY: setup
setup: ## Install dependencies
	pre-commit install

# --- Quality ---

.PHONY: lint
lint: ## Run linters
	npx markdownlint-cli2 "docs/**/*.md"

# --- Help ---

.PHONY: help
help: ## Show available commands
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' \
	  $(MAKEFILE_LIST) | sort | \
	  awk 'BEGIN {FS = ":.*?## "}; \
	  {printf "  %-20s %s\n", $$1, $$2}'
```

## Variables

- Use `:=` for immediate evaluation, `=` for
  recursive expansion
- Use `?=` for defaults that can be overridden
- Reference variables with `$(VAR)` not `$VAR`

## Recipes

- Start every recipe line with a tab character
- Use `@` prefix to suppress command echoing
- Combine related commands with `&&` on the same
  line when they must execute together
- Use backslash-newline for long commands

## Splitting Long Lines

- Use `\` to split long lines for readability
- Avoid trailing whitespace after backslashes
- In non-recipe context, backslash-newline becomes
  a single space

## Error Handling

- Use `$(error text)` for build-time validation
- Use `-` prefix to ignore errors for specific
  commands (use sparingly)

## Clean Targets

- Declare `clean` as `.PHONY`
- Use `-` prefix with `rm` to ignore missing files

## Portability

- Use POSIX shell constructs in recipes
- Document any GNU Make-specific features used
