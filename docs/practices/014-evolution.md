# Evolution

How the system and the practices around it improve
over time. The loop that connects "delivered" back
to "what are we building."

## The problem

A system that is not actively evolved decays:

- Dependencies go out of date and stop receiving
  security patches.
- Patterns that made sense at the start become
  obstacles.
- Documentation drifts from reality.
- Standards stop matching how the team actually
  works.
- AI tools improve faster than the project's
  practices.

A practice system that is not evolved decays in the
same way. Principles that worked at one stage
become friction at another. New techniques appear
and are not adopted. Mistakes recur.

Evolution is not optional. The question is whether
it is deliberate or accidental.

## Approaches

### Retrospectives

Regular reflection on what worked and what did not.
Cadence depends on project tempo: weekly for active
projects, monthly for slower ones, after each major
release for milestone-driven work.

Output is concrete changes, not abstract feelings.

### Decision reviews

Revisit past decisions periodically. Are the
constraints that drove them still true? If not, is
the decision still right?

### Dependency hygiene

Update dependencies regularly, not in big-bang
upgrades. Small, frequent updates are safer than
infrequent large ones.

Automate where possible (Dependabot, Renovate).

### Refactoring as continuous activity

Refactor when reading code reveals friction, not as
a separate project. Saved up refactoring becomes
expensive and risky.

### Standards revision

When the standards are routinely violated, two
explanations: the team is undisciplined, or the
standard is wrong. Examine which is true and act
accordingly.

### Documentation revisits

Read foundational documents (003-problem-definition.md,
the project's principles, architecture) at regular
intervals. Update when reality has moved.

### Looping back

Evolution means returning to earlier documents:

- A new feature need? Revisit
  [003-problem-definition.md](003-problem-definition.md)
  and check whether it fits scope.
- A structural pain point? Revisit
  [004-project-structure.md](004-project-structure.md).
- Recurring bugs? Revisit
  [010-quality.md](010-quality.md) and check
  whether the right mechanisms are in place.
- Slow incident response? Revisit
  [013-operation.md](013-operation.md).

The numbering in `docs/` is the order things
typically appear in a project's life. The order
you actually traverse them is determined by the
problem in front of you.

### Capture what changes

Every significant revision is recorded somewhere:
commit messages, decision records, changelog
entries. Without capture, the project relearns the
same lessons.

### Discard what is wrong

Outdated docs are worse than missing docs. Wrong
standards are worse than no standards. When
something is wrong, remove or rewrite — do not
annotate with "(deprecated)" and leave behind.

## When this matters

Always, but the urgency varies. A fresh project can
defer evolution work briefly. A long-running
project that has not evolved its practices in a
year almost certainly has accumulated debt.

## The loop

This is the last document in the numbered sequence,
but it is not the end. The next problem evolution
identifies sends you back to one of the earlier
documents. The project is alive only as long as the
loop keeps moving.

## Alternative approaches

- **No deliberate evolution**: relies on accidental
  improvement. Works rarely; usually leads to
  decay.
- **Periodic rewrites**: throw the system away and
  rebuild every few years. Effective for some
  projects, brutal for most.
- **Continuous deployment / continuous learning**:
  every change is a small experiment with explicit
  measurement. The strongest form of deliberate
  evolution. Requires the operational discipline
  from [013-operation.md](013-operation.md).
