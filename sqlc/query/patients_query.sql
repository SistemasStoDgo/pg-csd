-- ========================
-- Queries for `patients`
-- ========================

-- name: CreatePatient :one
INSERT INTO patients (
    uuid,
    national_id,
    first_name,
    last_name,
    phone,
    email,
    birth_date,
    created_at,
    updated_at
)
VALUES ($1, $2, $3, $4, $5, $6, $7, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP)
RETURNING id;

-- name: GetPatientByNationalID :one
SELECT
    id,
    uuid,
    national_id,
    first_name,
    last_name,
    phone,
    email,
    birth_date,
    created_at,
    updated_at
FROM patients
WHERE national_id = $1;

-- name: GetPatientByID :one
SELECT
    id,
    uuid,
    national_id,
    first_name,
    last_name,
    phone,
    email,
    birth_date,
    created_at,
    updated_at
FROM patients
WHERE id = $1;

-- name: UpdatePatient :one
UPDATE patients
SET
    first_name = $2,
    last_name = $3,
    phone = $4,
    email = $5,
    birth_date = $6,
    updated_at = CURRENT_TIMESTAMP
WHERE id = $1
RETURNING *;