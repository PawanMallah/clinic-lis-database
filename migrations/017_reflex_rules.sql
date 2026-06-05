SET search_path TO lis, public;

CREATE TABLE IF NOT EXISTS reflex_test_rules (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    lab_id UUID NOT NULL REFERENCES labs(id),
    trigger_test_id UUID NOT NULL REFERENCES test_master(id),
    trigger_test_code VARCHAR(50) NOT NULL,
    trigger_parameter VARCHAR(200),
    condition_operator VARCHAR(10) NOT NULL CHECK (condition_operator IN ('>', '<', '>=', '<=', '=', '!=')),
    condition_value DECIMAL(12,4) NOT NULL,
    reflex_test_id UUID NOT NULL REFERENCES test_master(id),
    reflex_test_code VARCHAR(50) NOT NULL,
    reflex_test_name VARCHAR(300) NOT NULL,
    auto_order BOOLEAN DEFAULT false,
    is_active BOOLEAN DEFAULT true,
    created_at TIMESTAMPTZ DEFAULT NOW()
);

CREATE INDEX IF NOT EXISTS idx_reflex_rules_trigger ON reflex_test_rules(trigger_test_id);
CREATE INDEX IF NOT EXISTS idx_reflex_rules_lab ON reflex_test_rules(lab_id);
