
.PHONY: all up down test

prod: down up
install-sqlc:
	@if ! command -v sqlc >/dev/null 2>&1; then \
		echo "Installing sqlc..."; \
		go install github.com/sqlc-dev/sqlc/cmd/sqlc@latest; \
	else \
		echo "sqlc already installed"; \
	fi
# Build del backend
gensqlc: install-sqlc
	cd backend/internal/database/db/sqlc && sqlc generate

down: 
	docker compose down
up:
	docker compose up --build