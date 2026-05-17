# AI-Driven Development

[![CI](https://github.com/GiviKDev/ai-driven-development/actions/workflows/ci.yml/badge.svg)](https://github.com/GiviKDev/ai-driven-development/actions/workflows/ci.yml)
[![License: CC BY 4.0](https://img.shields.io/badge/License-CC_BY_4.0-lightgrey.svg)](https://creativecommons.org/licenses/by/4.0/)

A practice system for building software with AI as a
working partner. The repository is a personal,
opinionated record of what works — refined through
real projects, feedback, and the changing landscape
of AI tooling.

It is not a framework. It is not a library. It is a
set of documents, instruction samples, and plugins
that describe practices and provide artifacts to
adopt them.

> **Early development.** Foundational documents are
> written; tooling and validation continue. See the
> [Roadmap](docs/practices/017-roadmap.md) and
> [Open Problems](docs/practices/016-open-problems.md).

## Who this is for

- Solo developers using AI who want a structure to
  keep up with their own systems.
- Small teams where AI-generated code volume
  exceeds human review bandwidth.
- Anyone who wants to systemize how they move from
  problem to delivered software with AI in the
  loop.

## Quick start

1. Read [docs/practices/001-problem.md](docs/practices/001-problem.md)
   to understand what this is and why.
2. Read [docs/practices/002-principles.md](docs/practices/002-principles.md)
   for the principles that guide everything else.
3. Browse [docs/README.md](docs/README.md) to find
   the document that addresses the problem in front
   of you.

The numbering in `docs/practices/` follows the order
things typically appear in a project's life. The
order you read them is determined by your current
problem.

## Repository layout

```text
docs/
  practices/      Lifecycle practice docs (001-017)
  methods/        Deep specs for specific quality
                  methods (journey verification,
                  trace analyzer)

plugins/          One folder per plugin
  journey-verification/
    plugin.json
    .claude-plugin/
    skills/
    agents/
    journeys/

instructions/     Copilot instruction samples
agents/           Standalone AI agent samples
skills/           Standalone AI skill samples
hooks/            Copilot/Claude lifecycle hook
                  samples
prompts/          Copilot prompt samples

.github/          CI/CD config, issue templates,
                  this repo's own Copilot config
```

The top-level artifact folders (`agents/`, `skills/`,
`hooks/`, `prompts/`) follow the awesome-copilot
catalog pattern. Most are placeholders today and
will fill in as samples emerge. Plugins are the
preferred packaging when artifacts work together.

## Plugins

This repo currently ships one plugin:

- **journey-verification** —
  [plugins/journey-verification/](plugins/journey-verification/).
  Skills and an agent for designing journeys,
  walking them against a callable surface,
  evaluating binary criteria, and analyzing traces.
  Specification: [docs/methods/journey-verification/](docs/methods/journey-verification/).

### Install

**VS Code / Copilot**: Run
`Chat: Install Plugin From Source` and enter:

```text
https://github.com/GiviKDev/ai-driven-development
```

**Claude Code**:

```text
/plugin install journey-verification
```

## Contributing

See [CONTRIBUTING.md](CONTRIBUTING.md). This project
follows the [Contributor Covenant](CODE_OF_CONDUCT.md).

### Local setup

```bash
git clone https://github.com/GiviKDev/ai-driven-development.git
cd ai-driven-development
make setup
```

## Blog

Concise overview at
[givikdev.github.io/ai-driven-development](https://givikdev.github.io/ai-driven-development/).

## License

[CC BY 4.0](LICENSE) — share, adapt, attribute.
