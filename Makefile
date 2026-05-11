.DEFAULT_GOAL := help

# --- Setup ---

.PHONY: setup
setup: ## Install pre-commit hooks
	pre-commit install
	pre-commit install --hook-type commit-msg
	@echo "Git hooks installed."

.PHONY: update-hooks
update-hooks: ## Update pre-commit hooks to latest versions
	pre-commit autoupdate

# --- Quality ---

.PHONY: lint
lint: ## Run markdownlint on all docs
	npx markdownlint-cli2 "docs/**/*.md" "README.md" "CONTRIBUTING.md" "plugin/**/*.md" --config .markdownlint.json

.PHONY: check-links
check-links: ## Check for broken links
	npx lychee --no-progress --exclude-mail "docs/**/*.md" "README.md"

.PHONY: pre-commit
pre-commit: ## Run all pre-commit hooks on all files
	pre-commit run --all-files
	@echo ""
	@echo "All pre-commit checks passed."

# --- Help ---

.PHONY: help
help: ## Show available commands
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) \
		| sort \
		| awk 'BEGIN {FS = ":.*?## "}; {printf "  %-20s %s\n", $$1, $$2}'
