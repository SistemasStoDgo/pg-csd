-- ========================
-- Consultas para la tabla `users`
-- ========================

-- name: CreateUser :one
INSERT INTO users (
    uuid,
    email,
    username,
    password_hash,
    created_at,
    updated_at
) VALUES ($1, $2, $3, $4, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP)
RETURNING *;

-- name: GetUserByEmail :one
SELECT id, uuid, email, username, password_hash
FROM users
WHERE email = $1;

-- name: GetUserPasswordHashByEmail :one
SELECT password_hash
FROM users
WHERE email = $1;

-- name: GetUserByID :one
SELECT id, uuid, email, username
FROM users
WHERE id = $1;

-- name: UpdateUserProfile :one
UPDATE users
SET email = $2,
    username = $3,
    updated_at = CURRENT_TIMESTAMP
WHERE id = $1
RETURNING id, uuid, email, username, created_at, updated_at;

-- name: UpdateUserPassword :one
UPDATE users
SET password_hash = $2,
    updated_at = CURRENT_TIMESTAMP
WHERE id = $1
RETURNING id;

-- name: ExistsUserByEmail :one
SELECT EXISTS(
    SELECT 1 FROM users WHERE email = $1 AND id != $2
);