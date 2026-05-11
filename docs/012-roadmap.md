# Roadmap

What is defined, what is in progress, and what is
planned.

This methodology is in early development. The
specification is complete for its initial scope,
but tooling, automation, and real-world validation
are still in progress.

## Defined

The methodology specification is complete for its
initial scope:

- Six-layer maturity model with incremental adoption
- Journey design and walk procedure
- Evaluation criteria with four scopes and binary
  outcomes
- Black box / white box separation with bias
  prevention
- Comparison with established methodologies
- Open problems and known gaps

## In Progress

### Plugin

Cross-tool plugin (Copilot + Claude Code) with:

- [x] walk-journey skill
- [x] evaluate-criteria skill
- [x] design-journey skill
- [x] analyze-trace skill
- [x] journey-walker agent
- [ ] MCP server for trace backend access
- [ ] Hooks for post-walk automation

### Documentation

- [x] Glossary
- [x] Roadmap
- [x] Adoption guide
- [ ] Sample journey with walk report
- [x] Vibe coding comparison section

### Dogfooding

- [x] .instructions.md files for this repo
- [ ] Verify plugin works with Copilot agent mode
- [ ] Verify plugin works with Claude Code

## Planned

### Reference Implementation

A .NET 10 project in a separate repository
demonstrating all six layers:

- Layer 0: Code with consistent patterns
- Layer 1: OpenTelemetry + Aspire observability
- Layer 2: Foundation docs (problem, vision, scope)
- Layer 3: .instructions.md, skills, copilot config
- Layer 4: MCP server as callable surface
- Layer 5: Journeys, walks, and evaluation

### Trace Analyzer MCP Server

TypeScript MCP server that connects to OTel backends
(Jaeger, Aspire, Tempo), extracts structured metrics,
and compares against budgets. Currently defined as
a skill with manual input — planned as a full MCP
server with automated trace fetching.

### CI/CD Integration

Patterns for running walks in CI pipelines:

- Walk as a CI step (run journey, fail build on
  violations)
- Trace correlation between CI runs
- Walk report artifacts

## Exploring

These are ideas, not commitments:

- VS Code extension with journey/walk UI
- Automated journey regression (walk on every PR)
- Journey coverage metrics (what percentage of the
  callable surface is exercised by journeys)
- Journey generation from OpenAPI/MCP schemas
- Academic paper on the methodology
