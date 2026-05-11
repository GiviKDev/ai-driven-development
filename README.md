# AI-Driven Development

[![CI](https://github.com/GiviKDev/ai-driven-development/actions/workflows/ci.yml/badge.svg)](https://github.com/GiviKDev/ai-driven-development/actions/workflows/ci.yml)
[![License: CC BY 4.0](https://img.shields.io/badge/License-CC_BY_4.0-lightgrey.svg)](https://creativecommons.org/licenses/by/4.0/)

A quality methodology for AI-assisted software
development. Six layers, adopted incrementally,
each addressing a gap the previous layer cannot
fill.

This is not a framework or a library. It is a way
of working -- a set of practices that help
developers and AI agents build, verify, and evolve
software together.

> **Early development.** The methodology
> specification is complete for its initial scope.
> Tooling, automation, and real-world validation
> are still in progress. See the
> [Roadmap](docs/012-roadmap.md) and
> [Open Problems](docs/010-open-problems.md).

## Who This Is For

- Solo developers using AI who can't keep up with
  their own system's complexity.
- Small teams where AI-generated code volume
  exceeds human review bandwidth.
- Any team where "tests pass" has become a form
  of false confidence.

## The Layers

| Layer | What | Gap it fills |
|-------|------|-------------|
| 0 | Code | The foundation |
| 1 | Observability | "I can't see what happens inside" |
| 2 | Documentation | "Nobody knows the philosophy" |
| 3 | AI Instructions | "AI doesn't follow conventions even with docs" |
| 4 | Callable Surface | "Nobody verifies the system works e2e" |
| 5 | Journey Verification | "Nobody checks quality from the user's perspective" |

Each layer is earned by the failure of the previous
one. Adopt them in order.

## Quick Start

1. Read [The Problem](docs/001-problem.md) to
   understand why.
2. Read [Principles](docs/002-principles.md) for
   the design philosophy.
3. Read [Layer by Layer](docs/003-layers.md) for
   the full narrative.
4. Read [Adoption Guide](docs/013-adoption-guide.md)
   to start adopting.

## Documentation

### Foundation

- [The Problem](docs/001-problem.md) -- Why
  existing practices fail when AI accelerates
  delivery.
- [Principles](docs/002-principles.md) -- Design
  principles for documentation, instructions,
  and verification.

### Layers

- [Layer by Layer](docs/003-layers.md) -- The six
  layers, told as a day-by-day evolution.
- [Observability](docs/004-observability.md) --
  What to observe, when, and what constitutes
  a finding.

### Journeys

- [Journey Design](docs/005-journey-design.md) --
  What a journey is, how to write one.
- [Walk Procedure](docs/006-walk-procedure.md) --
  Pre-walk, walk, report, fix, re-walk.
- [Evaluation Criteria](docs/007-evaluation-criteria.md)
  -- Scoped, binary criteria that replace
  subjective scoring.
- [Black Box vs White Box](docs/008-black-white-box.md)
  -- Two evaluation modes with different context
  boundaries.

### Context

- [Comparison](docs/009-comparison.md) -- How this
  relates to TDD, BDD, SDD, vibe coding, and
  adjacent approaches.
- [Open Problems](docs/010-open-problems.md) --
  Known gaps and future directions.

### Reference

- [Glossary](docs/011-glossary.md)
- [Roadmap](docs/012-roadmap.md)
- [Adoption Guide](docs/013-adoption-guide.md)
- [Samples](samples/) -- Copy-and-adapt
  instructions, skills, hooks, journeys.

## Plugin

Cross-tool plugin with skills and agents for
AI-assisted verification.

### Skills

- **walk-journey** -- Walk a journey against a
  callable surface
- **evaluate-criteria** -- Evaluate walk results
  against binary criteria
- **design-journey** -- Design new journeys with
  proper structure
- **analyze-trace** -- Analyze distributed traces
  for quality metrics

### Agent

- **journey-walker** -- Specialized verification
  agent that walks journeys

### Install

**VS Code / Copilot**: Run
`Chat: Install Plugin From Source` and enter:

```text
https://github.com/GiviKDev/ai-driven-development
```

**Claude Code**:

```text
/plugin install ai-driven-development
```

## Repository Structure

```text
docs/           Methodology specification (numbered)
plugin/         Cross-tool plugin (skills, agents)
samples/        Copy-and-adapt samples
specs/          Tooling specifications
.github/        CI/CD, templates, instructions
```

## Contributing

See [CONTRIBUTING.md](CONTRIBUTING.md) for
guidelines. This project follows the
[Contributor Covenant](CODE_OF_CONDUCT.md)
code of conduct.

### Local Setup

```bash
git clone https://github.com/GiviKDev/ai-driven-development.git
cd ai-driven-development
make setup
```

## Blog

Read the concise overview at
[givikdev.github.io/ai-driven-development](https://givikdev.github.io/ai-driven-development/).

## License

[CC BY 4.0](LICENSE) -- share, adapt, attribute.
