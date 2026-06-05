SET search_path TO lis, public;

CREATE TABLE IF NOT EXISTS lab_orders (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    lab_id UUID NOT NULL REFERENCES labs(id),
    patient_id UUID,
    patient_name VARCHAR(300),
    patient_uhid VARCHAR(50),
    patient_age INTEGER,
    patient_gender VARCHAR(10),
    patient_mobile VARCHAR(20),
    external_order_id VARCHAR(100),
    source_system VARCHAR(100) DEFAULT 'manual',
    priority order_priority DEFAULT 'routine',
    status order_status DEFAULT 'ordered',
    ordered_by UUID,
    ordered_by_name VARCHAR(200),
    clinical_notes TEXT,
    created_at TIMESTAMPTZ DEFAULT NOW(),
    updated_at TIMESTAMPTZ DEFAULT NOW()
);

CREATE TABLE IF NOT EXISTS lab_order_tests (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    order_id UUID NOT NULL REFERENCES lab_orders(id) ON DELETE CASCADE,
    test_id UUID NOT NULL REFERENCES test_master(id),
    test_code VARCHAR(50) NOT NULL,
    test_name VARCHAR(300) NOT NULL,
    status order_status DEFAULT 'ordered',
    specimen_id UUID,
    result_value VARCHAR(500),
    result_unit VARCHAR(50),
    result_flag result_flag,
    reference_low DECIMAL(10,2),
    reference_high DECIMAL(10,2),
    verified_by UUID,
    verified_at TIMESTAMPTZ,
    reported_at TIMESTAMPTZ,
    created_at TIMESTAMPTZ DEFAULT NOW(),
    updated_at TIMESTAMPTZ DEFAULT NOW()
);

CREATE INDEX idx_lab_orders_lab ON lab_orders(lab_id);
CREATE INDEX idx_lab_orders_patient ON lab_orders(patient_id);
CREATE INDEX idx_lab_orders_status ON lab_orders(status);
CREATE INDEX idx_lab_orders_date ON lab_orders(created_at DESC);
CREATE INDEX idx_order_tests_order ON lab_order_tests(order_id);
CREATE INDEX idx_order_tests_status ON lab_order_tests(status);
