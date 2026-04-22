-- =========================
-- VIEWS
-- =========================

-- Full appointments view
CREATE VIEW v_appointments_full AS
SELECT
    a.id,
    a.uuid,
    a.turn_number,
    a.status,
    a.price,
    a.booked_at,
    p.first_name AS patient_first_name,
    p.last_name AS patient_last_name,
    d.id AS doctor_id,
    d.first_name AS doctor_first_name,
    d.last_name AS doctor_last_name,
    s.id AS specialty_id,
    s.name AS specialty_name,
    av.date,
    av.start_time,
    av.end_time
FROM appointments a
JOIN patients p ON p.id = a.patient_id
JOIN availabilities av ON av.id = a.availability_id
JOIN doctors d ON d.id = av.doctor_id
JOIN specialties s ON s.id = d.specialty_id;

-- Availability with doctor info
CREATE VIEW v_availability_doctor AS
SELECT
    av.id,
    av.date,
    av.start_time,
    av.end_time,
    av.max_patients,
    d.id AS doctor_id,
    d.first_name,
    d.last_name,
    s.name AS specialty_name
FROM availabilities av
JOIN doctors d ON d.id = av.doctor_id
JOIN specialties s ON s.id = d.specialty_id;

-- Available slots
CREATE VIEW v_available_slots AS
SELECT
    av.id AS availability_id,
    av.date,
    av.start_time,
    av.max_patients,
    COUNT(a.id) AS booked,
    (av.max_patients - COUNT(a.id)) AS available
FROM availabilities av
LEFT JOIN appointments a
ON a.availability_id = av.id
GROUP BY av.id;

-- Public doctors
CREATE VIEW v_public_doctors AS
SELECT
    d.id,
    d.first_name,
    d.last_name,
    d.description,
    s.name AS specialty_name
FROM doctors d
JOIN specialties s
ON s.id = d.specialty_id;