.DEFAULT_GOAL := help

SHELL := /bin/bash
.SHELLFLAGS := -euo pipefail -c

# --- Setup ---

setup: ## Install pre-commit hooks and run all checks
	pre-commit install
	pre-commit install --hook-type commit-msg
	pre-commit run --all-files
	@echo ""
	@echo "Setup complete."

update-hooks: ## Update pre-commit hooks to latest versions
	pre-commit autoupdate

# --- Quality ---

pre-commit: ## Run all pre-commit hooks on all files
	pre-commit run --all-files

check-links: ## Check for broken links (not in pre-commit)
	lychee --no-progress --exclude-mail \
		"docs/**/*.md" "README.md" "CONTRIBUTING.md"

# --- Plugin ---

validate-plugin: ## Validate plugin manifests and skills
	@jq empty plugins/journey-verification/plugin.json && echo "plugin.json: valid JSON"
	@jq empty plugins/journey-verification/.claude-plugin/plugin.json && \
		echo ".claude-plugin/plugin.json: valid JSON"
	@copilot=$$(jq -r '.version' plugins/journey-verification/plugin.json); \
	 claude=$$(jq -r '.version' plugins/journey-verification/.claude-plugin/plugin.json); \
	 if [ "$$copilot" != "$$claude" ]; then \
	   echo "ERROR: version mismatch $$copilot vs $$claude"; exit 1; \
	 fi; \
	 echo "Manifests in sync: $$copilot"

# --- Help ---

help: ## Show available commands
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) \
		| sort \
		| awk 'BEGIN {FS = ":.*?## "}; {printf "  %-20s %s\n", $$1, $$2}'

.PHONY: setup update-hooks pre-commit check-links validate-plugin help
