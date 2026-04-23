.PHONY: postgres-up postgres-build postgres-down
gensqlc: 
	cd sqlc && sqlc generate
postgres-build:
	docker build -f Dockerfile.postgres -t pg-csd-postgres .

postgres-up: postgres-build
	@docker rm -f pg-csd-postgres 2>/dev/null || true
	docker run \
		--name pg-csd-postgres \
		--restart unless-stopped \
		--env-file .env \
		-p 5432:5432 \
		-v postgres_data:/var/lib/postgresql/data \
		pg-csd-postgres

postgres-down:
	docker stop pg-csd-postgres || true
	docker rm pg-csd-postgres || true