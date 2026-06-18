# Hooks

Lifecycle hook samples for AI tools. Hooks run
automatically at defined points in the AI workflow
(e.g., after a file is saved, before a commit).

This folder is a catalog of reusable samples.
Hooks that belong to a specific workflow live in
`plugins/` instead.

This is not an active hook location. To make hooks
run in a project, place reviewed hook configuration
in the hook location your tool supports, or package
it inside a plugin hook location.

Hooks execute commands with local permissions. Treat
them as enforcement code: keep them small, review
inputs, avoid secrets, and prefer explicit allow or
deny behavior over broad shell automation.

Currently empty. Samples will be added as they
emerge from real projects.
