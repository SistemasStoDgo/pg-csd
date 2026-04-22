-- ========================
-- Queries for `doctors`
-- ========================

-- name: CreateDoctor :one
INSERT INTO doctors (
    first_name,
    last_name,
    prefix,
    national_id,
    medical_license,
    specialty_code,
    description,
    education,
    phone,
    email,
    specialty_id,
    created_at,
    updated_at
)
VALUES ($1, $2, $3, $4, $5, $6, $7, $8, $9, $10, $11, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP)
RETURNING id;

-- name: UpdateDoctor :exec
UPDATE doctors
SET
    first_name = $2,
    last_name = $3,
    prefix = $4,
    medical_license = $5,
    specialty_code = $6,
    description = $7,
    phone = $8,
    email = $9,
    specialty_id = $10,
    updated_at = CURRENT_TIMESTAMP
WHERE id = $1;

-- name: GetDoctorByID :one
SELECT 
    d.id,
    d.first_name,
    d.last_name,
    d.prefix,
    d.medical_license,
    d.specialty_code,
    d.description,
    d.education,
    d.phone,
    d.email,
    s.name AS specialty_name
FROM doctors d
JOIN specialties s ON d.specialty_id = s.id
WHERE d.id = $1;

-- name: GetDoctorsBySpecialtyID :many
SELECT 
    d.id,
    d.first_name,
    d.last_name,
    d.prefix,
    d.description,
    d.education,
    d.medical_license,
    d.specialty_code,
    d.phone,
    d.email,
    s.name AS specialty_name
FROM doctors d
JOIN specialties s ON d.specialty_id = s.id
WHERE s.id = $1;

-- name: GetDoctors :many
SELECT 
    d.id,
    d.first_name,
    d.last_name,
    d.prefix,
    d.medical_license,
    d.specialty_code,
    d.description,
    d.education,
    d.phone,
    d.email,
    s.name AS specialty_name
FROM doctors d
JOIN specialties s ON d.specialty_id = s.id;

-- name: GetDoctorIDByNationalID :one
SELECT id
FROM doctors
WHERE national_id = $1;

-- name: DeleteDoctor :exec
DELETE FROM doctors WHERE id = $1;