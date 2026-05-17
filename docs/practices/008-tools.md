# Tools

Formatters, linters, analyzers, scanners, and build
rules that catch problems automatically, regardless
of who wrote the code.

## The problem

Standards alone are not enough. Humans forget,
deadlines compress, AI generates code that looks
plausible but violates conventions. Without
automatic enforcement, rules decay.

Common decay patterns:

- "We always do X" except in the parts written last
  week.
- The codebase has 200 warnings that everyone
  ignores.
- A bug in production was preventable by a tool
  that exists but was never configured.
- New contributors set up their environment
  differently and produce subtly different output.

## Approaches

### Formatters

Tools that rewrite code to a canonical form: indent,
line length, brace placement, import order. Run on
every save and in CI.

Pick one. Configure it once. Never debate style
again.

Examples: Prettier (JS/TS), Black (Python),
`dotnet format` (C#), `gofmt` (Go), `rustfmt`
(Rust).

### Linters

Tools that flag problems without rewriting:
unused variables, suspicious patterns, complexity
beyond a threshold, common bugs.

Configure to fail the build on errors. Suppress
intentionally; do not let warnings accumulate.

Examples: ESLint, Roslyn analyzers, golangci-lint,
clippy.

### Static analyzers

Deeper analysis: data flow, null safety, race
conditions, security patterns. Slower than linters,
catch problems linters miss.

Run in CI on every PR. Surface results visibly.

### Security scanners

Tools that check for known-vulnerable dependencies,
hard-coded secrets, insecure patterns. Run on every
commit.

Examples: Dependabot, gitleaks, Snyk, GitHub
secret scanning.

### Type checkers

For dynamically typed languages, gradual or strict
typing tools (TypeScript, mypy, Sorbet). Catch
entire classes of bugs at compile time.

### Build rules

The strongest enforcement: code that violates rules
does not compile. C# nullable reference types,
TypeScript strict mode, Rust's borrow checker —
all examples of rules baked into the build.

Prefer build rules over linter rules over
instructions. Higher up the ladder = more reliable.

### One tool per concern

Two formatters fight. Two linters duplicate effort.
Pick one tool per concern and configure it well.

### Run locally and in CI

Local hooks catch issues before commit. CI catches
issues when local hooks are bypassed. Both are
needed.

## When this matters

From day one. Tools added later require
retrofitting existing code, which is expensive and
demotivating.

Sign that tooling is overdue:

- The same correction appears in many code reviews.
- AI repeatedly generates non-conforming code.
- Bugs reach production that a known tool would have
  caught.

## What comes next

Tools tell you what the code looks like. They do
not tell you what it does at runtime. See
[009-observability.md](009-observability.md).

## Alternative approaches

- **Manual review only**: relies on humans noticing.
  Misses things tools catch reliably.
- **Heavyweight platforms**: SonarQube and similar
  combine many tools. Useful for organizations;
  often overkill for small projects.
- **Custom checks**: write project-specific rules
  when no off-the-shelf tool fits. Common for
  enforcing architectural constraints.

A simple toolchain that runs reliably beats a
sophisticated toolchain that nobody trusts.
