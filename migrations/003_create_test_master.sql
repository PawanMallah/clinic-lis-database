SET search_path TO lis, public;

-- Test Master Tables
-- Run: psql -U postgres -d lis_db -f 003_create_test_master.sql

CREATE TABLE IF NOT EXISTS test_master (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    lab_id UUID NOT NULL REFERENCES labs(id),
    code VARCHAR(50) NOT NULL,
    name VARCHAR(200) NOT NULL,
    short_name VARCHAR(50),
    department VARCHAR(100), -- biochemistry, hematology, microbiology, pathology, serology
    specimen_type VARCHAR(100), -- blood, urine, stool, swab, csf, etc.
    container_type VARCHAR(100), -- EDTA, plain, fluoride, citrate
    sample_volume_ml DECIMAL(5,2),
    tat_hours INTEGER DEFAULT 24, -- turnaround time
    method VARCHAR(200),
    instrument VARCHAR(200),
    is_panel BOOLEAN DEFAULT FALSE,
    price DECIMAL(10,2) DEFAULT 0,
    is_active BOOLEAN DEFAULT TRUE,
    created_at TIMESTAMPTZ DEFAULT NOW(),
    updated_at TIMESTAMPTZ DEFAULT NOW(),
    UNIQUE(lab_id, code)
);

CREATE TABLE IF NOT EXISTS test_panel_items (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    panel_id UUID NOT NULL REFERENCES test_master(id) ON DELETE CASCADE,
    test_id UUID NOT NULL REFERENCES test_master(id),
    sort_order INTEGER DEFAULT 0,
    UNIQUE(panel_id, test_id)
);

CREATE TABLE IF NOT EXISTS test_parameters (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    test_id UUID NOT NULL REFERENCES test_master(id) ON DELETE CASCADE,
    name VARCHAR(200) NOT NULL,
    short_name VARCHAR(50),
    unit VARCHAR(50),
    result_type VARCHAR(50) DEFAULT 'numeric', -- numeric, text, coded, formula
    decimal_places INTEGER DEFAULT 2,
    sort_order INTEGER DEFAULT 0,
    is_active BOOLEAN DEFAULT TRUE
);

CREATE TABLE IF NOT EXISTS test_reference_ranges (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    parameter_id UUID NOT NULL REFERENCES test_parameters(id) ON DELETE CASCADE,
    gender VARCHAR(10) DEFAULT 'all', -- male, female, all
    age_min_years INTEGER DEFAULT 0,
    age_max_years INTEGER DEFAULT 150,
    normal_min DECIMAL(10,4),
    normal_max DECIMAL(10,4),
    critical_low DECIMAL(10,4),
    critical_high DECIMAL(10,4),
    unit VARCHAR(50),
    notes TEXT
);

CREATE INDEX IF NOT EXISTS idx_test_master_lab_id ON test_master(lab_id);
CREATE INDEX IF NOT EXISTS idx_test_master_code ON test_master(code);
CREATE INDEX IF NOT EXISTS idx_test_master_department ON test_master(department);
CREATE INDEX IF NOT EXISTS idx_test_parameters_test_id ON test_parameters(test_id);
CREATE INDEX IF NOT EXISTS idx_test_reference_ranges_parameter_id ON test_reference_ranges(parameter_id);
