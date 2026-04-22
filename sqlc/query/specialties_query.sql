-- ========================
-- Queries for `specialties`
-- ========================

-- name: CreateSpecialty :exec
INSERT INTO specialties (
    name,
    description,
    short_description,
    type,
    created_at,
    updated_at
)
VALUES ($1, $2, $3, $4, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);

-- name: UpdateSpecialty :exec
UPDATE specialties
SET
    name = $2,
    description = $3,
    short_description = $4,
    type = $5,
    updated_at = CURRENT_TIMESTAMP
WHERE id = $1
RETURNING *;

-- name: GetSpecialtyByName :one
SELECT id
FROM specialties
WHERE name ILIKE $1;

-- name: GetSpecialtyByID :one
SELECT 
    id,
    name,
    description,
    short_description,
    type
FROM specialties
WHERE id = $1;

-- name: ListSpecialties :many
SELECT 
    id,
    name,
    description,
    short_description,
    type
FROM specialties
ORDER BY name ASC;

-- name: DeleteSpecialty :exec
DELETE FROM specialties WHERE id = $1;