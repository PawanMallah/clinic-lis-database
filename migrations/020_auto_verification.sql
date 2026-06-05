SET search_path TO lis, public;

-- Auto-verification rules configuration
CREATE TABLE IF NOT EXISTS auto_verification_rules (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    lab_id UUID NOT NULL REFERENCES labs(id),
    test_id UUID REFERENCES test_master(id),
    test_code VARCHAR(50),
    rule_name VARCHAR(200) NOT NULL,
    is_enabled BOOLEAN DEFAULT true,
    -- Criteria
    require_qc_pass BOOLEAN DEFAULT true,
    delta_check_percent DECIMAL(5,2) DEFAULT 20,
    delta_check_hours INTEGER DEFAULT 48,
    exclude_critical BOOLEAN DEFAULT true,
    exclude_first_result BOOLEAN DEFAULT true,
    exclude_neonatal BOOLEAN DEFAULT false,
    exclude_critical_care BOOLEAN DEFAULT false,
    require_in_reportable_range BOOLEAN DEFAULT true,
    require_no_instrument_flags BOOLEAN DEFAULT true,
    -- Metadata
    created_at TIMESTAMPTZ DEFAULT NOW(),
    updated_at TIMESTAMPTZ DEFAULT NOW()
);

-- Digital signatures
CREATE TABLE IF NOT EXISTS digital_signatures (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    lab_id UUID NOT NULL REFERENCES labs(id),
    user_id UUID NOT NULL,
    user_name VARCHAR(200) NOT NULL,
    user_role VARCHAR(50) NOT NULL,
    qualification VARCHAR(200),
    license_number VARCHAR(100),
    signature_image TEXT,
    is_active BOOLEAN DEFAULT true,
    created_at TIMESTAMPTZ DEFAULT NOW()
);

-- Auto-verification audit log
CREATE TABLE IF NOT EXISTS auto_verification_log (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    result_id UUID NOT NULL REFERENCES test_results(id),
    order_id UUID NOT NULL,
    test_code VARCHAR(50),
    passed BOOLEAN NOT NULL,
    failure_reasons JSONB DEFAULT '[]',
    checked_at TIMESTAMPTZ DEFAULT NOW()
);

CREATE INDEX IF NOT EXISTS idx_auto_verify_rules_lab ON auto_verification_rules(lab_id);
CREATE INDEX IF NOT EXISTS idx_auto_verify_rules_test ON auto_verification_rules(test_id);
CREATE INDEX IF NOT EXISTS idx_digital_signatures_lab ON digital_signatures(lab_id, user_id);
CREATE INDEX IF NOT EXISTS idx_auto_verify_log_result ON auto_verification_log(result_id);
