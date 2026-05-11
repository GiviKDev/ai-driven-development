---
name: verify-build
description: "Run project build and report results
  with structured pass/fail output"
argument-hint: "Optional: specific project or
  solution path to build"
---

# Verify Build

Run the project's build command and report results
in a structured format.

## Procedure

1. Check if a Makefile exists at the project root.
   If yes, use `make build` or `make dotnet-rebuild`
   (prefer rebuild over build for clean verification).
   If no Makefile, identify the build system and run
   the appropriate command.

2. Capture the full output including warnings and
   errors.

3. If the build fails, classify each error:
   - **Compilation error**: code does not compile
   - **Style violation**: formatting or naming rule
     broken (e.g., IDE0161, IDE0005)
   - **Warning as error**: a warning promoted to
     error by project config

4. Report results in the following format.

## Output format

```text
## Build Report

**Result**: PASS | FAIL
**Command**: `make dotnet-rebuild`
**Duration**: Xs

### Errors (if any)

| # | File | Code | Message | Category |
|---|------|------|---------|----------|
| 1 | Foo.cs:12 | CS0246 | Type not found | Compilation |
| 2 | Bar.cs:5 | IDE0005 | Unnecessary using | Style |

### Warnings (if any)

| # | File | Code | Message |
|---|------|------|---------|
| 1 | Baz.cs:30 | CA1822 | Can be static |

### Summary

X error(s), Y warning(s).
```

## Rules

- Do not fix errors automatically. Report them.
  The developer decides what to do.
- If style violations are the only errors, suggest
  running `make format` to auto-fix them.
- Always include the exact command that was run.
- If the build command is not found or not
  configured, report that as the finding instead
  of guessing a command.
