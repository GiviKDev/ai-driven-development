# Open Problems

Known gaps and unsolved challenges across the
practice areas in this repository.

## Cross-cutting

### Practice-system observability

No meta-metrics for "is this practice system
working?" Candidates:

- Issues found per quality check (should
  stabilize).
- Time from "problem appears" to "documented
  practice exists."
- Recurrence rate of fixed problems.

### Cross-tool portability

Copilot and Claude Code accept similar but not
identical instruction formats. Maintaining parity
across tools requires duplication or a generator.
A standard format would help; one does not exist.

### Knowledge decay measurement

Documents drift from reality. There is no automated
way to detect drift. Reading the docs regularly is
the current best answer; it does not scale.

## Quality and verification

### Automated regression for journey verification

A journey that passes today may break tomorrow. No
automated re-walk exists. Approaches:

- Dependency graph: map which modules each journey
  exercises; re-walk when affected.
- CI-integrated walks: run walks in CI. Requires a
  headless walk runner, a running system with
  observability, and stable test data.
- Hybrid: dependency graph triggers selective
  re-walks.

All require significant engineering effort.

### Adversarial journeys

Current journeys are "actor tries to succeed."
Missing: authorization bypass, cross-tenant access,
role escalation, injection. Dedicated adversarial
journeys with systematic threat modeling would be
more thorough.

### Performance budgets

Trace analysis currently uses default budgets (5
DB queries for CRUD, 500ms response). No
per-operation baselines exist. Adding baselines
requires measuring current performance and
defining acceptable thresholds per operation.

### Walk data format

Walk transcripts are AI-generated markdown. A
structured JSON format consumed by a test
framework would enable CI-integrated walks. The
format does not exist yet.

### Cross-model consistency

All walks so far have used one AI model. Whether
different models produce comparable walk reports
is unknown. Binary criteria should help; trace
analysis and failure-mode testing may vary.

### Cross-surface parity

If a system has multiple surfaces (REST, MCP,
gRPC), nothing verifies they behave identically.
Cross-surface parity testing is a future
direction.

## Observability tooling

### Trace quality analyzer

Existing observability tools surface what was
recorded; none assess whether the recording is
adequate. Common gaps — missing spans, unnamed
operations, broken trace context, missing
attributes — go undetected until someone needs
the trace and finds it useless.

A tool that grades trace quality (coverage,
naming, attribute completeness, context
propagation) would close a real industry gap.

## Automation and process

### Human bottleneck

The walk-and-fix loop requires human review for
every fix. Auto-approve criteria for low-risk
fixes vs require-review for high-risk fixes is
not defined. At scale, this bottleneck needs
attention.

### Scale

At 8 journeys, manual walks work. At 50, they do
not. Scaling requires automated execution,
prioritization, and incremental re-walks.
