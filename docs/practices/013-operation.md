# Operation

The system is running. What happens next.

## The problem

A delivered system that nobody watches is a system
that fails silently until users complain. AI
involvement does not reduce operational
responsibility — it shifts the burden from writing
code to monitoring code that was written quickly.

Without operational discipline:

- Failures are discovered by users, not by the
  team.
- Incidents are resolved by guessing.
- The same problem recurs because nobody captured
  what fixed it last time.
- Performance regressions accumulate unnoticed.

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
