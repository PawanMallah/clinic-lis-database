-- Migration 008: Quality Control tables

CREATE TABLE IF NOT EXISTS qc_materials (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    lab_id UUID NOT NULL REFERENCES labs(id),
    material_name VARCHAR(300) NOT NULL,
    manufacturer VARCHAR(200),
    lot_number VARCHAR(100) NOT NULL,
    expiry_date DATE,
    level VARCHAR(20) NOT NULL CHECK (level IN ('low', 'normal', 'high')),
    is_active BOOLEAN DEFAULT true,
    created_at TIMESTAMPTZ DEFAULT NOW()
);

CREATE TABLE IF NOT EXISTS qc_target_values (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    material_id UUID NOT NULL REFERENCES qc_materials(id) ON DELETE CASCADE,
    test_id UUID NOT NULL REFERENCES test_master(id),
    test_code VARCHAR(50) NOT NULL,
    test_name VARCHAR(300) NOT NULL,
    expected_mean DECIMAL(12,4) NOT NULL,
    expected_sd DECIMAL(12,4) NOT NULL,
    unit VARCHAR(50),
    created_at TIMESTAMPTZ DEFAULT NOW()
);

CREATE TABLE IF NOT EXISTS qc_records (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    lab_id UUID NOT NULL REFERENCES labs(id),
    material_id UUID NOT NULL REFERENCES qc_materials(id),
    target_value_id UUID NOT NULL REFERENCES qc_target_values(id),
    instrument_id UUID,
    instrument_name VARCHAR(200),
    test_id UUID NOT NULL REFERENCES test_master(id),
    test_code VARCHAR(50) NOT NULL,
    test_name VARCHAR(300) NOT NULL,
    level VARCHAR(20) NOT NULL,
    lot_number VARCHAR(100),
    measured_value DECIMAL(12,4) NOT NULL,
    expected_mean DECIMAL(12,4) NOT NULL,
    expected_sd DECIMAL(12,4) NOT NULL,
    sd_index DECIMAL(6,2),
    status qc_status DEFAULT 'in_control',
    westgard_violation VARCHAR(50),
    run_date DATE NOT NULL DEFAULT CURRENT_DATE,
    recorded_by UUID,
    recorded_by_name VARCHAR(200),
    recorded_at TIMESTAMPTZ DEFAULT NOW(),
    comments TEXT,
    created_at TIMESTAMPTZ DEFAULT NOW()
);

CREATE TABLE IF NOT EXISTS qc_blocks (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    lab_id UUID NOT NULL REFERENCES labs(id),
    test_id UUID NOT NULL REFERENCES test_master(id),
    instrument_id UUID,
    reason VARCHAR(500) NOT NULL,
    blocked_by UUID,
    blocked_at TIMESTAMPTZ DEFAULT NOW(),
    resolved_by UUID,
    resolved_at TIMESTAMPTZ,
    is_active BOOLEAN DEFAULT true
);

CREATE INDEX idx_qc_materials_lab ON qc_materials(lab_id);
CREATE INDEX idx_qc_targets_material ON qc_target_values(material_id);
CREATE INDEX idx_qc_records_lab ON qc_records(lab_id);
CREATE INDEX idx_qc_records_test ON qc_records(test_id);
CREATE INDEX idx_qc_records_date ON qc_records(run_date DESC);
CREATE INDEX idx_qc_records_status ON qc_records(status);
CREATE INDEX idx_qc_blocks_active ON qc_blocks(lab_id, is_active) WHERE is_active = true;
