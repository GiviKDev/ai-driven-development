# Operation

The system is running. What happens next.

## The problem

A delivered system that nobody watches fails
silently until users complain. AI-assisted
development amplifies this: features ship faster,
deployment frequency increases, and the surface
area for operational failures grows at a rate
that manual vigilance cannot match.

Without operational discipline:

- Failures are discovered by users, not by the
  team.
- Incidents are resolved by guessing.
- The same problem recurs because nobody captured
  what fixed it last time.
- Performance regressions accumulate unnoticed.
- AI-generated code that passed all tests
  degrades under production load in ways
  development-time verification did not cover.

## Approaches

### Monitoring and alerting

Continuous observation of the system's health,
with automated alerts when something is wrong.

What to monitor:

- Service availability (uptime, error rates).
- Latency (p50, p95, p99).
- Saturation (queue depths, resource usage).
- Business metrics (orders per minute, sign-ups per
  hour).

Alerts must be actionable. An alert that nobody can
do anything about is noise.

### On-call rotation

For systems where downtime matters, someone is
responsible for responding. Rotation distributes
the burden and keeps knowledge spread across the
team.

### Runbooks

Documented procedures for known failure modes.
"When X happens, do Y." Written when the problem
is fresh. Saved in the repository, not in someone's
head.

### Incident response

A defined process for handling failures:

- Detect.
- Triage.
- Mitigate (restore service).
- Resolve (fix the underlying cause).
- Review (what happened, why, what changes).

The review (postmortem) is the most valuable part.
It is where the system learns.

### Blameless postmortems

Focus on systemic causes, not individual mistakes.
If a deployment broke production, the question is
"why was the deployment process able to break
production?" not "who pushed it."

### Service-level objectives

Explicit targets for reliability (e.g., 99.9%
availability). Drive prioritization: when the SLO
is missed, fix reliability before features.

### Capacity planning

Watch growth trends. Scale before saturation, not
after.

### Cost monitoring

Cloud costs grow silently. Monitor and review
regularly.

### What AI changes about operations

Development-time trace verification
([009-observability.md](009-observability.md))
and production monitoring observe the same system
from different angles. Connect them:

- Healthy trace patterns defined during development
  become production monitoring baselines. If a
  handler that should make 2 DB queries starts
  making 10, that is an alert.
- AI ships features faster, so deployment
  frequency increases. Reversible deployments
  (012) and automated rollback become more
  important, not less.
- AI-generated code may handle the happy path
  correctly but fail under load, concurrency, or
  edge cases that development-time testing did
  not cover. Production observability is the
  safety net.

## When this matters

The moment the system has users who depend on it.
For internal tools, the bar is lower; for
customer-facing systems, operational discipline is
non-negotiable.

## What comes next

Running systems generate feedback: incidents,
metrics, user reports, runtime evidence. The next
problem is turning that feedback into improvements
to the system and the practices around it. See
[014-evolution.md](014-evolution.md).

## Alternative approaches

- **No formal operations**: works only for
  throwaway systems and personal projects.
- **Outsourced operations**: managed service
  providers handle the operational layer. Trade
  cost for capacity.
- **SRE practices**: a formalized discipline of
  software-engineering-driven operations. Worth
  studying even when not adopted wholesale.

Operational discipline is not optional for systems
that matter. The level of formality is what
varies.
