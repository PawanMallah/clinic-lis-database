SET search_path TO lis, public;

-- Critical value notification tracking (Section 11)
CREATE TABLE IF NOT EXISTS critical_value_notifications (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    lab_id UUID NOT NULL REFERENCES labs(id),
    critical_alert_id UUID NOT NULL REFERENCES critical_alerts(id),
    patient_name VARCHAR(300),
    test_name VARCHAR(300),
    result_value VARCHAR(200),
    ordering_provider VARCHAR(300),
    -- Notification delivery
    notified_to VARCHAR(300),
    notified_at TIMESTAMPTZ,
    notification_method VARCHAR(30) DEFAULT 'phone',
    -- Read-back documentation
    read_back_by VARCHAR(200),
    read_back_at TIMESTAMPTZ,
    callback_number VARCHAR(50),
    -- Escalation
    escalation_needed BOOLEAN DEFAULT false,
    escalated_to VARCHAR(300),
    escalated_at TIMESTAMPTZ,
    -- Status
    status VARCHAR(20) DEFAULT 'pending' CHECK (status IN ('pending', 'notified', 'read_back', 'escalated', 'closed')),
    notes TEXT,
    created_at TIMESTAMPTZ DEFAULT NOW()
);

-- Audit trail (immutable log for all actions)
CREATE TABLE IF NOT EXISTS audit_trail (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    lab_id UUID NOT NULL,
    user_id UUID,
    user_name VARCHAR(200),
    user_role VARCHAR(50),
    action VARCHAR(100) NOT NULL,
    resource_type VARCHAR(50) NOT NULL,
    resource_id UUID,
    details JSONB DEFAULT '{}',
    ip_address VARCHAR(50),
    user_agent TEXT,
    created_at TIMESTAMPTZ DEFAULT NOW()
);

-- Role-based access control
CREATE TABLE IF NOT EXISTS lab_roles (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    lab_id UUID NOT NULL REFERENCES labs(id),
    role_name VARCHAR(50) NOT NULL,
    display_name VARCHAR(100) NOT NULL,
    permissions JSONB DEFAULT '[]',
    is_active BOOLEAN DEFAULT true,
    created_at TIMESTAMPTZ DEFAULT NOW(),
    UNIQUE(lab_id, role_name)
);

-- Seed default roles (from Section 4.3)
INSERT INTO lab_roles (id, lab_id, role_name, display_name, permissions) VALUES
(gen_random_uuid(), '00000000-0000-0000-0000-000000000001', 'ordering_physician', 'Ordering Physician', '["orders.create", "orders.modify", "orders.cancel", "results.view"]'::jsonb),
(gen_random_uuid(), '00000000-0000-0000-0000-000000000001', 'phlebotomist', 'Nurse/Phlebotomist', '["specimens.collect", "specimens.label", "specimens.status"]'::jsonb),
(gen_random_uuid(), '00000000-0000-0000-0000-000000000001', 'lab_technician', 'Lab Technician', '["results.enter", "results.preliminary_verify", "specimens.process", "qc.enter"]'::jsonb),
(gen_random_uuid(), '00000000-0000-0000-0000-000000000001', 'lab_supervisor', 'Lab Supervisor/Pathologist', '["results.final_verify", "results.amend", "results.authorize", "reports.sign", "qc.manage"]'::jsonb),
(gen_random_uuid(), '00000000-0000-0000-0000-000000000001', 'lab_director', 'Lab Director', '["admin.all", "qc.oversight", "tests.manage", "compliance.audit"]'::jsonb),
(gen_random_uuid(), '00000000-0000-0000-0000-000000000001', 'system_admin', 'System Administrator', '["admin.users", "admin.config", "admin.interfaces", "admin.audit"]'::jsonb),
(gen_random_uuid(), '00000000-0000-0000-0000-000000000001', 'billing_staff', 'Billing Staff', '["billing.view", "billing.code", "orders.view", "results.view"]'::jsonb)
ON CONFLICT (lab_id, role_name) DO NOTHING;

CREATE INDEX IF NOT EXISTS idx_critical_notifications_lab ON critical_value_notifications(lab_id);
CREATE INDEX IF NOT EXISTS idx_critical_notifications_status ON critical_value_notifications(status);
CREATE INDEX IF NOT EXISTS idx_audit_trail_lab ON audit_trail(lab_id);
CREATE INDEX IF NOT EXISTS idx_audit_trail_date ON audit_trail(created_at DESC);
CREATE INDEX IF NOT EXISTS idx_audit_trail_user ON audit_trail(user_id);
CREATE INDEX IF NOT EXISTS idx_audit_trail_resource ON audit_trail(resource_type, resource_id);
CREATE INDEX IF NOT EXISTS idx_lab_roles_lab ON lab_roles(lab_id);
