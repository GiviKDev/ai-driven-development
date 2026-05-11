# Quality Gates Makefile
#
# Wraps multi-step CLI operations into single
# commands. AI agents run these instead of raw
# CLI tools, reducing the surface area of possible
# errors.
#
# Adapt the commands to your stack. This example
# uses .NET. The pattern works for any toolchain.

SOLUTION := MyProject.sln

# --- Individual gates ---

.PHONY: dotnet-format
dotnet-format: ## Auto-fix formatting and style
	dotnet format $(SOLUTION) --verbosity minimal

.PHONY: dotnet-build
dotnet-build: ## Build without cleaning
	dotnet build $(SOLUTION) --no-restore

.PHONY: dotnet-rebuild
dotnet-rebuild: ## Clean build (preferred for verification)
	dotnet build $(SOLUTION) --no-incremental

.PHONY: dotnet-test
dotnet-test: ## Run all tests
	dotnet test $(SOLUTION) --no-build --verbosity normal

.PHONY: dotnet-restore
dotnet-restore: ## Restore NuGet packages
	dotnet restore $(SOLUTION)

# --- Composite gates ---

.PHONY: build
build: dotnet-restore dotnet-build ## Restore + build

.PHONY: test
test: build dotnet-test ## Build + test

.PHONY: pre-commit
pre-commit: dotnet-format dotnet-rebuild dotnet-test ## All gates before commit
	@echo ""
	@echo "All pre-commit checks passed."

# --- Help ---

.PHONY: help
help: ## Show available commands
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) \
		| sort \
		| awk 'BEGIN {FS = ":.*?## "}; {printf "  \033[36m%-20s\033[0m %s\n", $$1, $$2}'

.DEFAULT_GOAL := help
