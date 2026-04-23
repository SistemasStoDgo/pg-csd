# =========================
# Makefile
# =========================

.PHONY: all 
gensqlc: 
	cd sqlc && sqlc generate

build: 
	go build