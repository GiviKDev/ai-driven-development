# Journey Verification

A specification for one quality mechanism: walking a
running system through defined user journeys and
evaluating each step against binary criteria, using
both response data and runtime traces as evidence.

This is one approach among many described in
[../../practices/010-quality.md](../../practices/010-quality.md).
Use it when:

- The system has clear user-facing flows.
- Runtime evidence (traces, side effects) matters as
  much as return values.
- AI is generating significant portions of the code
  and an external check on what was produced is
  valuable.

It is not a replacement for unit tests, integration
tests, or other quality mechanisms.

## Contents

- [journey-design.md](journey-design.md) — how to
  design journeys that follow real user intent.
- [walk-procedure.md](walk-procedure.md) — the
  procedure for executing a journey against a live
  system.
- [evaluation-criteria.md](evaluation-criteria.md)
  — binary checks organized by scope (functional,
  performance, security, observability).
- [black-white-box.md](black-white-box.md) — the
  two evaluation modes and why bias prevention
  matters.

## Implementation

The companion plugin in `plugins/journey-verification/`
provides skills
and an agent for performing this verification with
Copilot or Claude Code:

- `design-journey`
- `walk-journey`
- `evaluate-criteria`
- `analyze-trace`
- `journey-walker` agent

See [../../../plugins/journey-verification/](../../../plugins/journey-verification/).
