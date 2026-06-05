SET search_path TO lis, public;

-- Migration 006: Test results and verification tables

CREATE TABLE IF NOT EXISTS test_results (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    lab_id UUID NOT NULL REFERENCES labs(id),
    order_id UUID NOT NULL REFERENCES lab_orders(id),
    order_test_id UUID NOT NULL REFERENCES lab_order_tests(id),
    test_id UUID NOT NULL REFERENCES test_master(id),
    test_code VARCHAR(50) NOT NULL,
    test_name VARCHAR(300) NOT NULL,
    parameter_name VARCHAR(200),
    result_value VARCHAR(500),
    result_numeric DECIMAL(12,4),
    result_unit VARCHAR(50),
    reference_low DECIMAL(10,2),
    reference_high DECIMAL(10,2),
    critical_low DECIMAL(10,2),
    critical_high DECIMAL(10,2),
    flag result_flag DEFAULT 'normal',
    is_critical BOOLEAN DEFAULT false,
    instrument_id UUID,
    instrument_name VARCHAR(200),
    raw_value VARCHAR(500),
    method VARCHAR(200),
    remarks TEXT,
    entered_by UUID,
    entered_by_name VARCHAR(200),
    entered_at TIMESTAMPTZ,
    status VARCHAR(20) DEFAULT 'pending',
    created_at TIMESTAMPTZ DEFAULT NOW(),
    updated_at TIMESTAMPTZ DEFAULT NOW()
);

CREATE TABLE IF NOT EXISTS result_verifications (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    result_id UUID NOT NULL REFERENCES test_results(id) ON DELETE CASCADE,
    verification_level verification_level NOT NULL,
    verified_by UUID NOT NULL,
    verified_by_name VARCHAR(200) NOT NULL,
    verified_at TIMESTAMPTZ DEFAULT NOW(),
    status VARCHAR(20) NOT NULL DEFAULT 'approved',
    comments TEXT,
    previous_value VARCHAR(500),
    corrected_value VARCHAR(500)
);

CREATE TABLE IF NOT EXISTS critical_alerts (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    lab_id UUID NOT NULL REFERENCES labs(id),
    result_id UUID NOT NULL REFERENCES test_results(id),
    order_id UUID NOT NULL,
    patient_name VARCHAR(300),
    test_name VARCHAR(300),
    result_value VARCHAR(200),
    critical_type VARCHAR(20) NOT NULL,
    acknowledged_by UUID,
    acknowledged_at TIMESTAMPTZ,
    notified_doctor BOOLEAN DEFAULT false,
    created_at TIMESTAMPTZ DEFAULT NOW()
);

CREATE INDEX idx_results_order ON test_results(order_id);
CREATE INDEX idx_results_order_test ON test_results(order_test_id);
CREATE INDEX idx_results_lab ON test_results(lab_id);
CREATE INDEX idx_results_status ON test_results(status);
CREATE INDEX idx_results_flag ON test_results(flag);
CREATE INDEX idx_results_critical ON test_results(is_critical) WHERE is_critical = true;
CREATE INDEX idx_verifications_result ON result_verifications(result_id);
CREATE INDEX idx_critical_alerts_lab ON critical_alerts(lab_id);
CREATE INDEX idx_critical_alerts_unack ON critical_alerts(acknowledged_at) WHERE acknowledged_at IS NULL;
