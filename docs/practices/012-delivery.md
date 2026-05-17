# Delivery

How the system reaches users. Versioning, releases,
deployment.

## The problem

A working system on the main branch is not a system
in users' hands. Without a defined delivery
process:

- Releases happen "when someone has time."
- The version users have is unclear.
- Rollback is improvised.
- Release notes are reconstructed from memory.
- Different environments run different code.

## Approaches

### Semantic versioning

`MAJOR.MINOR.PATCH`. Breaking changes bump MAJOR.
New features bump MINOR. Bug fixes bump PATCH. Users
read the version and know what to expect.

For internal tools, calendar versioning (`YYYY.MM.DD`)
is simpler and equally informative.

### Conventional commits

Commit messages with structured prefixes (`feat:`,
`fix:`, `docs:`). Drives automated version bumping
and changelog generation.

### Automated release pipeline

Triggered by merges to main or by tags. Builds,
tests, packages, publishes, tags. No manual steps.

Tools: semantic-release, release-please, GitHub
Actions, GitLab CI.

### Changelog

Generated from commit history. Lists what changed
between versions. Users consult it to decide
whether to upgrade.

### Environment parity

Staging matches production. The same artifact moves
through environments. Differences exist only in
configuration, not in code.

### Reversible deployments

Every deployment can be rolled back. Blue/green,
canary, feature flags — pick the technique that
fits the system's risk profile.

### Distribution channels

Where users get the artifact: package registries
(npm, NuGet, PyPI), container registries, app
stores, plugin marketplaces. Each has its own
process and constraints.

For this repository, distribution is the Copilot
plugin spec and the Claude Code plugin spec —
declarative artifacts loaded by tools that already
exist.

### Release cadence

Continuous (every merge ships) vs scheduled
(weekly, monthly, quarterly). Continuous is
preferred when feasible. Scheduled is necessary
when changes require coordination (mobile app
reviews, customer notification windows).

## When this matters

Once the project has external users. Internal
tooling can ship informally for longer, but
discipline pays off as users multiply.

## What comes next

Code is delivered. The system is running. The next
problem is keeping it running and learning from
how it behaves. See
[013-operation.md](013-operation.md).

## Alternative approaches

- **Manual releases**: works for very low cadence.
  Fragile.
- **Trunk-based with feature flags**: every commit
  is shippable; features are gated. Powerful but
  needs flag infrastructure.
- **Long-lived release branches**: useful when
  multiple versions are supported simultaneously.
  Expensive to maintain.
