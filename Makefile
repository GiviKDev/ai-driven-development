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

# --- Plugin ---

.PHONY: validate-plugin
validate-plugin: ## Validate plugin manifests and skills
	@jq empty plugin/plugin.json && echo "plugin.json: valid JSON"
	@jq empty plugin/.claude-plugin/plugin.json && echo ".claude-plugin/plugin.json: valid JSON"
	@copilot=$$(jq -r '.version' plugin/plugin.json); \
	 claude=$$(jq -r '.version' plugin/.claude-plugin/plugin.json); \
	 if [ "$$copilot" != "$$claude" ]; then \
	   echo "ERROR: version mismatch $$copilot vs $$claude"; exit 1; \
	 fi; \
	 echo "Manifests in sync: $$copilot"

.PHONY: bump-version
bump-version: ## Bump plugin version: make bump-version VERSION=x.y.z
	@if [ -z "$(VERSION)" ]; then echo "Usage: make bump-version VERSION=x.y.z"; exit 1; fi
	@jq '.version = "$(VERSION)"' plugin/plugin.json > plugin/plugin.json.tmp && mv plugin/plugin.json.tmp plugin/plugin.json
	@jq '.version = "$(VERSION)"' plugin/.claude-plugin/plugin.json > plugin/.claude-plugin/plugin.json.tmp && mv plugin/.claude-plugin/plugin.json.tmp plugin/.claude-plugin/plugin.json
	@echo "Bumped to $(VERSION)"
	@echo "Next: git add plugin/ && git commit -m 'chore: bump plugin to $(VERSION)' && git tag v$(VERSION) && git push origin main v$(VERSION)"

# --- Help ---

.PHONY: help
help: ## Show available commands
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) \
		| sort \
		| awk 'BEGIN {FS = ":.*?## "}; {printf "  %-20s %s\n", $$1, $$2}'
