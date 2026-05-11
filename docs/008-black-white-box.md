# Black Box vs White Box

Two modes of evaluation with different context
boundaries.

## Why Two Modes

The same system needs to be evaluated from two
perspectives:

1. **From the outside**: Can a client (human or AI)
   use this system to accomplish their goal using
   only the public surface? This is the user
   experience question.
2. **From the inside**: Is the implementation
   efficient, correct, and well-structured? This is
   the engineering quality question.

These questions require different information access.
Mixing them produces biased results — an evaluator
who has read the handler code will use the API
differently than one who has not.

## Black Box Mode

### What the AI sees

- The callable surface (tools, endpoints, schemas).
- Public documentation (if the project publishes
  docs for consumers).
- OTel traces via the observability dashboard or
  trace analysis tool.

### What the AI does not see

- Source code.
- Internal documentation (architecture docs, process
  docs, AI instructions).
- Database contents.
- Test files.
- Configuration.

### How to set up

Use a separate VS Code instance (or equivalent IDE
session) with:

- No workspace folder pointing to the project repo.
- Only the callable surface configured (MCP server
  URL, REST base URL, API key/token).
- Access to the observability dashboard or trace
  analysis MCP tool.
- The journey document (provided as a file or pasted
  into context).
- The evaluation criteria (provided as a file or
  pasted into context).

**Critical**: Clear all AI memory, conversation
history, and cached context before starting. AI
tools (VS Code Copilot, Claude) may remember context
from previous sessions. A black box walk that starts
with cached knowledge of the codebase is not black
box.

### What black box catches

- Surface friction: tool naming, schema problems,
  missing capabilities.
- Workflow design issues: too many steps, non-obvious
  ordering, missing context between steps.
- Error quality: generic vs structured errors, error
  messages that help vs confuse.
- Documentation gaps: if the actor needs to read docs
  that don't exist to proceed, that is a finding.
- Trace-level issues: broken consumers, redundant
  queries, performance problems (these are visible
  through OTel even without source access).

### What black box misses

- Architectural violations that don't manifest on
  the surface.
- Code quality issues (dead code, duplication,
  naming inconsistencies in source).
- Missing test coverage.
- Incorrect internal state that doesn't affect the
  current workflow but will affect future workflows.

## White Box Mode

### What the AI sees

Everything. Full repo access: source code, docs,
tests, configuration, instructions, database
schemas, infrastructure code.

### When to use

- **After a black box walk**, for root-cause analysis
  of findings. The walk found a generic error
  response — white box analysis reads the handler to
  understand why and implement the fix.
- **During development**, for code review, feature
  implementation, and architectural evaluation.
- **For trace investigation**, when the trace shows
  unexpected behavior that requires reading the
  handler code to diagnose.

### What white box catches

- Handler implementation quality (redundant queries,
  missing error handling, incorrect event
  publishing).
- Architectural violations (cross-module direct
  references, wrong dependency direction).
- Missing or incorrect tests.
- Configuration problems (wrong DI registration,
  missing middleware).

### What white box misses

- User experience problems (the developer who reads
  the code will compensate for surface friction
  unconsciously).
- Documentation gaps (the developer who reads the
  code doesn't need docs to proceed — but clients
  do).

## Combining Both Modes

The recommended flow:

1. **Black box walk**: AI walks the journey with zero
   repo access. Discovers surface friction and
   trace-level issues.
2. **Human reviews findings**: Decides what to fix.
3. **White box analysis**: AI reads source code to
   diagnose and fix the findings.
4. **Black box re-walk**: After fixes, walk again
   with zero repo access to verify the fixes worked
   from the outside.

The black box walk is the honest test. The white box
analysis is the diagnostic tool. Neither replaces the
other.

## Bias Prevention

AI memory creates bias. If the AI walked a journey in
white box mode yesterday and starts a black box walk
today, it may "remember" the internal implementation
details, parameter names, or workarounds.

To prevent this:

- Use a separate, clean AI session for black box
  walks.
- Clear conversation history and memory files.
- Do not reuse the same VS Code instance that has
  the repo open.
- If using a cloud-based AI service, start a new
  conversation with no prior context.

The goal is a cold start: the AI should approach the
system as a first-time user with no insider knowledge.
