# Automation

Quality mechanisms only protect the project if they
run consistently. Automation removes the choice of
whether to run them.

## The problem

Manual processes decay under pressure. A pre-commit
check that "everyone runs" gets skipped before a
deadline. A test suite that "should be run before
PR" stays unrun. A formatter applied "by every
contributor" produces inconsistent output across
editors.

Without automation:

- The build is green locally and red in CI.
- Standards exist in docs but not in code.
- Releases include known-bad code because the check
  was skipped.
- New contributors discover unwritten rules by
  failing reviews.

## Approaches

### Pre-commit hooks

Run formatters, linters, and fast checks before code
is committed. Catch problems at the earliest point.

Trade-off: hooks add commit latency. Keep them
fast. Move slow checks to CI.

### Pre-push hooks

Run heavier checks before code reaches the remote.
Catch problems before a PR is opened.

### CI on every push and PR

Run the full check suite on a clean environment.
Catches problems hooks missed and verifies that the
local environment was not lying.

CI is the authoritative answer to "does this work."
Local checks are convenience.

### Required status checks

Block merges when checks fail. Without this, CI is
advisory and gets ignored.

### Automatic dependency updates

Tools like Dependabot or Renovate update
dependencies in PRs automatically. CI verifies the
update. Avoids the "we never update because it
breaks things" trap.

### Automatic releases

Release version, tag, and changelog from
conventional commits (semantic-release and
equivalents). Removes manual release work and the
mistakes that come with it.

### Branch protection

No direct pushes to main. All changes go through
PRs with required reviews and required checks.
Forces every change to pass the same bar.

### Reproducible builds

Same input, same output, every time. Docker images,
lockfiles, pinned tool versions. Without
reproducibility, automation drifts.

### Fail fast, fail loud

Automation that fails silently is worse than no
automation. When a check fails, the failure should
be visible, immediate, and impossible to ignore.

## When this matters

From the first commit. The cost of adding
automation increases with codebase size. The cost
of not having it appears as bugs, inconsistency,
and wasted time.

## What comes next

Quality is established. The next problem is
shipping it. See [012-delivery.md](012-delivery.md).

## Alternative approaches

- **Manual gates**: works for very small teams or
  hobby projects. Does not scale.
- **Heavy custom CI pipelines**: useful for
  organizations with bespoke needs. Often overkill
  for individual projects.
- **GitOps**: deployment driven by repository
  state. Useful for infrastructure-heavy systems.

Pick the lightest automation that gives you
confidence. Add more only when current automation
misses something that matters.
