-- =========================
-- INDEXES
-- =========================

-- Appointments
CREATE INDEX idx_appointments_availability_id
ON appointments(availability_id);

CREATE INDEX idx_appointments_user_id
ON appointments(user_id);

CREATE INDEX idx_appointments_patient_id
ON appointments(patient_id);

CREATE INDEX idx_appointments_booked_at
ON appointments(booked_at);

-- Doctors
CREATE INDEX idx_doctors_specialty_id
ON doctors(specialty_id);

-- Availabilities
CREATE INDEX idx_availabilities_doctor_date
ON availabilities(doctor_id, date);