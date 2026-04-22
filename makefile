# =========================
# Makefile
# =========================

.PHONY: all 
gensqlc: 
	cd backend/internal/database/db/sqlc && sqlc generate

build: 
	go build