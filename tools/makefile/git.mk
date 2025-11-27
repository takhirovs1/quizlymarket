# ───────────────
# 🛠️ GIT COMMANDS
# ───────────────

.PHONY: help-git
help-git: ## Show all available Git-related commands
	@echo 'Usage: make <OPTIONS> ... <TARGETS>'
	@echo ''
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | sort | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}'

.PHONY: tag-prod
tag-prod: format ## Create and push a Git tag for production
ifndef m
	$(error ❌ Error: Tag message (m) is required. Usage: make tag-prod m="v1.0.0")
endif
	@echo "🏷️ Creating Git tag: $(m)"
	@git tag -a "${m}" -m "${m}"
	@echo "📤 Pushing tags to remote..."
	@git push origin --tags
