-- =========================
-- ENUMS
-- =========================

CREATE TYPE appointment_status AS ENUM (
    'pending',
    'confirmed',
    'cancelled',
    'expired'
);

-- =========================
-- USERS
-- =========================
CREATE TABLE IF NOT EXISTS users (
    id BIGSERIAL PRIMARY KEY NOT NULL,
    uuid UUID NOT NULL DEFAULT gen_random_uuid(),
    email TEXT NOT NULL UNIQUE,
    username TEXT NOT NULL,
    password_hash TEXT NOT NULL,
    created_at TIMESTAMP NOT NULL DEFAULT now(),
    updated_at TIMESTAMP NOT NULL DEFAULT now()
);

-- =========================
-- SPECIALTY
-- =========================
CREATE TABLE IF NOT EXISTS specialties (
    id BIGSERIAL PRIMARY KEY,
    name TEXT NOT NULL UNIQUE,
    description TEXT,
    short_description TEXT,
    type TEXT,
    created_at TIMESTAMP DEFAULT now(),
    updated_at TIMESTAMP DEFAULT now()
);

-- =========================
-- DOCTORS
-- =========================
CREATE TABLE IF NOT EXISTS doctors (
    id BIGSERIAL PRIMARY KEY,
    first_name TEXT NOT NULL,
    last_name TEXT NOT NULL,
    prefix TEXT NOT NULL,
    national_id TEXT UNIQUE NOT NULL, -- dni
    medical_license TEXT UNIQUE,      -- cmp
    specialty_code TEXT UNIQUE,       -- rne
    description TEXT,
    education TEXT NOT NULL,
    phone TEXT UNIQUE NOT NULL,
    email TEXT,
    specialty_id BIGINT NOT NULL REFERENCES specialties(id) ON DELETE RESTRICT,
    created_at TIMESTAMP DEFAULT now(),
    updated_at TIMESTAMP DEFAULT now()
);

-- =========================
-- AVAILABILITY
-- =========================
CREATE TABLE IF NOT EXISTS availabilities (
    id BIGSERIAL PRIMARY KEY,
    doctor_id BIGINT NOT NULL REFERENCES doctors(id) ON DELETE CASCADE,
    date DATE NOT NULL,
    start_time TIME NOT NULL,
    end_time TIME NOT NULL,
    max_patients INTEGER NOT NULL CHECK(max_patients > 0),
    created_at TIMESTAMP DEFAULT now(),
    updated_at TIMESTAMP DEFAULT now(),
    UNIQUE(doctor_id, date, start_time, end_time)
);

-- =========================
-- PATIENTS
-- =========================
CREATE TABLE IF NOT EXISTS patients (
    id BIGSERIAL PRIMARY KEY,
    uuid UUID NOT NULL DEFAULT gen_random_uuid(),
    national_id TEXT NOT NULL UNIQUE, -- dni
    first_name TEXT NOT NULL,
    last_name TEXT NOT NULL,
    phone TEXT NOT NULL,
    email TEXT,
    birth_date DATE,
    created_at TIMESTAMP DEFAULT now(),
    updated_at TIMESTAMP DEFAULT now()
);

-- =========================
-- APPOINTMENTS (RESERVA)
-- =========================
CREATE TABLE IF NOT EXISTS appointments (
    id BIGSERIAL PRIMARY KEY NOT NULL,
    uuid UUID NOT NULL DEFAULT gen_random_uuid(),
    availability_id BIGINT NOT NULL REFERENCES availabilities(id) ON DELETE CASCADE,
    patient_id BIGINT NOT NULL,
    user_id BIGINT NOT NULL REFERENCES users(id) ON DELETE SET NULL,
    turn_number INTEGER NOT NULL CHECK(turn_number > 0),
    payment_token TEXT UNIQUE,
    price INTEGER NOT NULL CHECK(price >= 0),
    status appointment_status NOT NULL DEFAULT 'pending',
    booked_at TIMESTAMP NOT NULL DEFAULT now(),
    created_at TIMESTAMP DEFAULT now(),
    updated_at TIMESTAMP DEFAULT now(),
    UNIQUE(availability_id, turn_number)
);

-- =========================
-- PRICING
-- =========================
CREATE TABLE IF NOT EXISTS pricing (
    doctor_id BIGINT PRIMARY KEY REFERENCES doctors(id) ON DELETE CASCADE,
    amount INTEGER NOT NULL CHECK(amount >= 0),
    created_at TIMESTAMP DEFAULT now(),
    updated_at TIMESTAMP DEFAULT now()
);