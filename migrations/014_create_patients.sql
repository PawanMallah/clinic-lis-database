SET search_path TO lis, public;

-- Patients table for LIS (separate from EMR patients)
CREATE TABLE IF NOT EXISTS patients (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    lab_id UUID NOT NULL REFERENCES labs(id),
    first_name VARCHAR(200) NOT NULL,
    last_name VARCHAR(200),
    full_name VARCHAR(400),
    date_of_birth DATE,
    gender VARCHAR(10),
    age INTEGER,
    mobile VARCHAR(20),
    email VARCHAR(200),
    address TEXT,
    city VARCHAR(100),
    state VARCHAR(100),
    pincode VARCHAR(10),
    uhid VARCHAR(50),
    mrn VARCHAR(50),
    blood_group VARCHAR(10),
    referred_by_doctor VARCHAR(300),
    treating_doctor VARCHAR(300),
    insurance_provider VARCHAR(200),
    insurance_id VARCHAR(100),
    emergency_contact VARCHAR(200),
    emergency_phone VARCHAR(20),
    notes TEXT,
    is_active BOOLEAN DEFAULT true,
    created_at TIMESTAMPTZ DEFAULT NOW(),
    updated_at TIMESTAMPTZ DEFAULT NOW()
);

CREATE INDEX IF NOT EXISTS idx_patients_lab ON patients(lab_id);
CREATE INDEX IF NOT EXISTS idx_patients_name ON patients(first_name, last_name);
CREATE INDEX IF NOT EXISTS idx_patients_mobile ON patients(mobile);
CREATE INDEX IF NOT EXISTS idx_patients_dob ON patients(date_of_birth);
CREATE INDEX IF NOT EXISTS idx_patients_uhid ON patients(uhid);
CREATE UNIQUE INDEX IF NOT EXISTS idx_patients_dedup ON patients(lab_id, first_name, mobile, date_of_birth) WHERE mobile IS NOT NULL AND date_of_birth IS NOT NULL;

-- Link orders to patients
ALTER TABLE lab_orders ADD COLUMN IF NOT EXISTS lis_patient_id UUID REFERENCES patients(id);
CREATE INDEX IF NOT EXISTS idx_lab_orders_patient_lis ON lab_orders(lis_patient_id);
