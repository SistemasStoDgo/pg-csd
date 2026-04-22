-- ========================
-- Queries for `availabilities`
-- ========================

-- name: CreateAvailability :one
INSERT INTO availabilities (
  doctor_id,
  date,
  start_time,
  end_time,
  max_patients,
  created_at,
  updated_at
)
VALUES ($1, $2, $3, $4, $5, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP)
RETURNING *;

-- name: UpdateAvailability :one
UPDATE availabilities
SET
  doctor_id = $2,
  date = $3,
  start_time = $4,
  end_time = $5,
  max_patients = $6,
  updated_at = CURRENT_TIMESTAMP
WHERE id = $1
RETURNING *;

-- name: ListAvailabilities :many
SELECT 
  av.*,
  s.name AS specialty_name,
  d.first_name AS doctor_first_name,
  d.last_name AS doctor_last_name,
  d.prefix
FROM availabilities av
JOIN doctors d ON av.doctor_id = d.id
JOIN specialties s ON d.specialty_id = s.id
WHERE av.date >= $1
ORDER BY av.date, av.start_time;

-- name: ListAvailabilitiesBySpecialtyID :many
SELECT 
  av.*,
  s.name AS specialty_name,
  d.first_name AS doctor_first_name,
  d.last_name AS doctor_last_name,
  d.prefix,
  d.id AS doctor_id
FROM availabilities av
JOIN doctors d ON av.doctor_id = d.id
JOIN specialties s ON d.specialty_id = s.id
WHERE s.id = $1
  AND av.date >= $2
ORDER BY av.date, av.start_time;

-- name: ListAvailabilitiesByDoctorID :many
SELECT 
  av.*,
  s.name AS specialty_name,
  d.first_name AS doctor_first_name,
  d.last_name AS doctor_last_name,
  d.prefix,
  d.id AS doctor_id
FROM availabilities av
JOIN doctors d ON av.doctor_id = d.id
JOIN specialties s ON d.specialty_id = s.id
WHERE d.id = $1
  AND av.date >= $2
ORDER BY av.start_time;

-- name: DeleteAvailability :exec
DELETE FROM availabilities
WHERE id = $1;

-- name: GetAvailabilityWithAppointmentsCount :one
SELECT 
    av.*,
    COUNT(a.id) AS current_appointments
FROM availabilities av
LEFT JOIN appointments a 
    ON a.availability_id = av.id
WHERE av.id = $1
GROUP BY av.id;

-- name: GetAvailabilitiesByDoctorAndDate :many
SELECT *
FROM availabilities
WHERE doctor_id = $1
  AND date = $2;