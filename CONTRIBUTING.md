# Contributing

Thank you for your interest in AI-Driven Development.
This project is a practice system, samples, and a
plugin — not a code library. Contributions are
primarily prose, skill definitions, and feedback.

## What we accept

### Practice feedback

The most valuable contribution is critical feedback
on the practices themselves:

- Does a concept not make sense? Open an issue.
- Is a recommendation wrong? Open an issue with your
  counter-argument.
- Is something missing? Open an issue describing the
  gap.

Use the "Practice Feedback" issue template.

### Documentation fixes

Typos, broken links, unclear wording -- submit a PR
directly. No issue needed for small fixes.

### New samples

The top-level folders `agents/`, `skills/`, `hooks/`,
`instructions/`, and `prompts/` catalog standalone
AI artifact samples. The `plugins/` folder contains
packaged plugins. If you have a useful sample or
plugin contribution, submit a PR to the appropriate
folder.

Requirements for sample PRs:

- The sample must be generic (not tied to a specific
  proprietary project)
- Include comments explaining why each rule exists
- Follow the existing format in the target folder

### Plugin improvements

Skills and agent definitions in `plugins/<name>/`
can be improved. If you find a skill that produces poor
results, submit a PR with the improvement and explain
what was wrong and why the change is better.

### Comparisons and alternatives

Each document in `docs/` lists alternative
approaches at the end. If you know of an approach
that should be compared, open an issue or submit a
PR against the relevant document.

## What we do not accept

- Marketing language, filler, or vague
  recommendations
- Changes that contradict the principles in
  `docs/practices/002-principles.md` without strong
  justification
- Features or code that belong in a separate
  implementation repository

## How to submit a PR

1. Fork the repository
2. Create a branch from `main`
3. Make your changes
4. Ensure your changes follow the writing rules in
   `.github/instructions/docs.instructions.md`
5. Submit a PR with a clear description of what
   changed and why

## Writing style

- Plain language. No marketing copy.
- Be opinionated. Take a position.
- Wrap lines at 50-60 characters.
- See `docs/practices/002-principles.md` for the full set of
  design principles.

## License

By contributing, you agree that your contributions
will be licensed under [CC BY 4.0](LICENSE).
