---
applyTo: '**/*.md'
description: 'General markdown formatting rules for
  all markdown files in the repository'
---

# Markdown Rules

## Formatting

- Line length: soft-wrap at 50-60 characters for
  prose. Tables and code blocks may exceed this.
- Use `#` for H1 (document title, one per file).
  Use `##` for sections, `###` for subsections.
  Avoid H4+ -- restructure the content instead.
- Use `-` for bullet lists. Use `1.` for ordered
  lists. Indent nested lists with two spaces.
- Use fenced code blocks with language identifiers
  (e.g., ` ```yaml`, ` ```json`, ` ```bash`).
- No em dashes. Use " -- " (space-hyphen-hyphen-
  space) or rephrase.

## Links

- Use relative paths for internal links:
  `[principles](docs/practices/002-principles.md)`
- Link to specific files, not folders.
- Do not use bare URLs -- always wrap in link
  syntax.

## Structure

- No YAML front matter in documentation files.
  Front matter is for instruction files only.
- Separate sections with a single blank line.
- No trailing whitespace.
- Files end with a single newline.

## Writing Style

- Plain language. No marketing copy, no filler.
- Be opinionated. Take a position, defend it.
- Brief paragraphs. If a paragraph exceeds 5
  lines, split it.
- No filler phrases: "it should be noted that",
  "it is important to", "in order to".
