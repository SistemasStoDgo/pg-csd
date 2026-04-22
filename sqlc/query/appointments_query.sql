-- ========================
-- Queries for `appointments`
-- ========================

-- name: CreateAppointment :one
INSERT INTO appointments (
    availability_id,
    patient_id,
    user_id,
    turn_number,
    payment_token,
    price,
    booked_at,
    created_at,
    updated_at
)
VALUES ($1, $2, $3, $4, $5, $6, $7, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP)
RETURNING uuid;

-- name: GetAppointmentByUUID :one
SELECT
    id,
    uuid,
    availability_id,
    patient_id,
    user_id,
    turn_number,
    payment_token,
    price,
    status,
    booked_at,
    created_at,
    updated_at
FROM appointments
WHERE uuid = $1;

-- name: GetAppointmentsByAvailability :many
SELECT
    id,
    uuid,
    availability_id,
    patient_id,
    user_id,
    turn_number,
    payment_token,
    price,
    status,
    booked_at,
    created_at,
    updated_at
FROM appointments
WHERE availability_id = $1
ORDER BY turn_number;

-- name: GetAppointmentsByUser :many
SELECT
    id,
    uuid,
    availability_id,
    patient_id,
    user_id,
    turn_number,
    payment_token,
    price,
    status,
    booked_at,
    created_at,
    updated_at
FROM appointments
WHERE user_id = $1
ORDER BY booked_at DESC;

-- name: DeleteAppointment :exec
DELETE FROM appointments
WHERE id = $1;

-- name: ListAppointments :many
SELECT
    id,
    uuid,
    turn_number,
    status,
    price,
    booked_at,
    patient_first_name,
    patient_last_name,
    doctor_id,
    doctor_first_name,
    doctor_last_name,
    specialty_id,
    specialty_name,
    date,
    start_time,
    end_time
FROM v_appointments_full
ORDER BY date, start_time, turn_number;