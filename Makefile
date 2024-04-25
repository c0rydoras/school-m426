.DEFAULT_GOAL := help

.PHONY: help
help:
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | sort -k 1,1 | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}'

.PHONY: api-lint
api-lint: ## Lint the api
	@docker compose run --rm api sh -c "ruff format --check . ; ruff check . --output-format=full"

.PHONY: api-lint-fix
api-lint-fix: ## Lint and fix the api
	@docker compose run --rm api sh -c "ruff format . && ruff check . --fix"

.PHONY: api-test
api-test: ## Test the api
	@docker compose run --rm api sh -c 'ENV=test pytest -vvv -s'
