---
applyTo: '**'
description: 'Prevents terminal heredoc file
  corruption in VS Code Copilot by enforcing use
  of file editing tools instead of shell redirections'
---

# MANDATORY: File Operation Override

This instruction applies to ALL agents and ALL file
operations. It takes precedence over any other
learned behavior.

## The Problem

Terminal heredoc operations are BROKEN in VS Code's
Copilot integration. They cause:

- File corruption from tab characters triggering
  shell completion
- Mangled content from quote/backtick escaping
  failures
- Truncated files from exit code 130 interruptions
- Garbage output from special character
  interpretation

## The Rule

**BEFORE writing ANY terminal command that creates
or modifies a file, STOP.**

Ask yourself: "Am I about to use `cat`, `echo`,
`printf`, `tee`, or `>>`/`>` to write content to
a file?"

If YES -- **DO NOT EXECUTE.** Use file editing tools
instead.

## Forbidden Patterns

```bash
# ALL OF THESE CORRUPT FILES - NEVER USE THEM
cat > file << EOF
cat > file << 'EOF'
cat > file <<EOF
cat > file <<'EOF'
cat > file <<-EOF
cat >> file << EOF
echo "multi
line" > file
printf '%s\n' "line1" "line2" > file
tee file << EOF
tee file << 'EOF'
```

## Required Approach

Instead of terminal commands for file content:

- **New files** -- Use the file creation tool
- **Modify files** -- Use the file editing tool
- **Delete files** -- Use `rm` command or file
  deletion tool

## Terminal IS Allowed For

- `npm install`, `pip install` (package management)
- `npm run build`, `make` (builds)
- `npm test`, `pytest` (testing)
- `git add`, `git commit`, `git push` (version
  control)
- `ls`, `cd`, `mkdir`, `pwd`, `rm` (filesystem
  navigation)
- `npx`, `pre-commit` (tool execution)
