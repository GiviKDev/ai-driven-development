# Open Problems

Known gaps, unsolved challenges, and future
directions.

## Automated Regression

A journey that passes today may break tomorrow. No
automated re-walk exists. Approaches:

- **Dependency graph**: Map which modules each
  journey exercises. When a module changes, re-walk
  affected journeys.
- **CI-integrated walks**: Run walks in CI. Requires
  a headless walk runner, a running system with
  observability, and stable test data.
- **Hybrid**: Dependency graph triggers selective
  re-walks in CI.

All require significant engineering effort.

## Adversarial Journeys

Current journeys are "actor tries to succeed."
Missing: authorization bypass attempts, cross-tenant
data access, role escalation, input injection.

The walk procedure supports this (failure mode
testing per step). Dedicated adversarial journeys
with systematic threat modeling would be more
thorough.

## Performance Budgets

Trace analysis currently uses default budgets (5 DB
queries for CRUD, 500ms response). No per-operation
baselines exist. Adding baselines requires measuring
current performance and defining acceptable
thresholds per journey step.

## Scale

At 8 journeys, manual walks work. At 50, they don't.
Scaling requires automated execution, journey
prioritization, and incremental re-walks (only steps
affected by code changes).

## Walk Data Format

Walk transcripts are AI-generated markdown. Future
direction: structured JSON that can be consumed by a
test framework for automated evaluation. This is a
prerequisite for CI-integrated walks.

## Cross-Model Consistency

All walks have used one AI model. Unknown whether
different models walking the same journey with the
same criteria produce comparable results. Binary
criteria (violated/not) should improve consistency,
but trace analysis and failure mode testing may vary.

## Methodology Observability

No meta-metrics for "is the methodology working?"
Candidates:

- Issues found per walk (should stabilize over time).
- Re-walk count before passing (should approach 1).
- Criteria violations per scope over time.
- Time from "walk fails" to "walk passes."

These are the methodology's own KPIs.

## Human Bottleneck at Scale

The walk procedure requires human review and approval
for every fix. At scale, this bottleneck needs:

- Auto-approve criteria for low-risk fixes (schema
  corrections, error message improvements).
- Require-review criteria for high-risk fixes
  (authorization changes, event schema changes).
- The human reviews only high-risk fixes.

## Callable Surface Parity

If the system has multiple surfaces (REST, MCP, gRPC),
nothing verifies they behave identically. A walk
through MCP may pass while the same operation through
REST fails differently. Cross-surface parity testing
is a future direction.
