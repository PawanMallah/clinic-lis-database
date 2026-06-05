-- Lab Tables
-- Run: psql -U postgres -d lis_db -f 002_create_lab_tables.sql

CREATE TABLE IF NOT EXISTS labs (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    name VARCHAR(200) NOT NULL,
    code VARCHAR(50) UNIQUE NOT NULL,
    address TEXT,
    phone VARCHAR(20),
    email VARCHAR(200),
    license_number VARCHAR(100),
    accreditation_number VARCHAR(100),
    settings_json JSONB DEFAULT '{}',
    is_active BOOLEAN DEFAULT TRUE,
    created_at TIMESTAMPTZ DEFAULT NOW(),
    updated_at TIMESTAMPTZ DEFAULT NOW()
);

CREATE TABLE IF NOT EXISTS lab_users (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    lab_id UUID NOT NULL REFERENCES labs(id),
    user_id UUID NOT NULL,
    role VARCHAR(50) NOT NULL, -- admin, pathologist, technician, phlebotomist, receptionist
    department VARCHAR(100),
    employee_id VARCHAR(50),
    is_active BOOLEAN DEFAULT TRUE,
    created_at TIMESTAMPTZ DEFAULT NOW(),
    updated_at TIMESTAMPTZ DEFAULT NOW(),
    UNIQUE(lab_id, user_id)
);

CREATE INDEX idx_lab_users_lab_id ON lab_users(lab_id);
CREATE INDEX idx_lab_users_user_id ON lab_users(user_id);
