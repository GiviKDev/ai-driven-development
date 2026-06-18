# Roadmap

What is defined, what is in progress, and what is
planned.

This repository is in early development. The
foundational documents are written; tooling and
real-world validation continue.

## Defined

- 17 documents in `docs/practices/` organized by
  project lifecycle, with explicit loop framing.
- Journey verification specification in
  `docs/methods/journey-verification/`.
- Trace analyzer specification in
  `docs/methods/trace-analyzer/`.
- Plugin layout in `plugins/journey-verification/`
  with skills and an agent.
- Sample AI instructions in `instructions/`.
- Top-level placeholders for future AI artifact
  samples: `agents/`, `skills/`, `hooks/`,
  `prompts/`.

## In progress

### Plugin

Cross-tool plugin package with:

- [x] walk-journey skill
- [x] evaluate-criteria skill
- [x] design-journey skill
- [x] analyze-trace skill
- [x] journey-walker agent
- [ ] MCP server for trace backend access
- [ ] Hooks for post-walk automation

### Documentation

- [x] Foundational docs (001-017)
- [x] Glossary
- [x] Roadmap
- [ ] Sample journey with walk report

### Dogfooding

- [x] `AGENTS.md` governs active repo guidance
- [ ] Verify plugin works across supported agent
  hosts

## Planned

### Reference implementation

A separate project demonstrating the practices end
to end:

- Project structure and standards (003-008)
- OpenTelemetry observability (009)
- Quality mechanisms including journey verification
  (010)
- Automation (011)
- Delivery and operation (012-013)

### Trace analyzer MCP server

TypeScript MCP server that connects to OpenTelemetry
backends (Jaeger, Aspire, Tempo), extracts
structured metrics, and compares against budgets.
Currently defined as a skill with manual input;
planned as a full MCP server.

### CI/CD integration

Patterns for running journey walks in CI:

- Walk as a CI step (run journey, fail build on
  violations).
- Trace correlation between CI runs.
- Walk report artifacts.

## Exploring

Ideas, not commitments:

- Trace quality analyzer (see
  [016-open-problems.md](016-open-problems.md)).
- Automated journey regression (walk on every PR).
- Journey coverage metrics.
- Journey generation from OpenAPI/MCP schemas.
- Article series on the practices.
