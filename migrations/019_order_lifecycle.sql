SET search_path TO lis, public;

-- Add more status values to order_status enum
ALTER TYPE order_status ADD VALUE IF NOT EXISTS 'received_by_lab' AFTER 'ordered';
ALTER TYPE order_status ADD VALUE IF NOT EXISTS 'specimen_collected' AFTER 'collecting';
ALTER TYPE order_status ADD VALUE IF NOT EXISTS 'specimen_received' AFTER 'specimen_collected';
ALTER TYPE order_status ADD VALUE IF NOT EXISTS 'in_process' AFTER 'specimen_received';
ALTER TYPE order_status ADD VALUE IF NOT EXISTS 'preliminary' AFTER 'in_process';
ALTER TYPE order_status ADD VALUE IF NOT EXISTS 'final' AFTER 'completed';
ALTER TYPE order_status ADD VALUE IF NOT EXISTS 'corrected' AFTER 'final';

-- Add-on tests support
CREATE TABLE IF NOT EXISTS addon_tests (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    original_order_id UUID NOT NULL REFERENCES lab_orders(id),
    addon_order_test_id UUID NOT NULL REFERENCES lab_order_tests(id),
    reason TEXT,
    requested_by UUID,
    requested_by_name VARCHAR(200),
    requested_at TIMESTAMPTZ DEFAULT NOW(),
    specimen_valid BOOLEAN DEFAULT true,
    notes TEXT
);

-- Send-out / Reference lab tracking
CREATE TABLE IF NOT EXISTS reference_lab_sendouts (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    lab_id UUID NOT NULL REFERENCES labs(id),
    order_id UUID NOT NULL REFERENCES lab_orders(id),
    order_test_id UUID NOT NULL REFERENCES lab_order_tests(id),
    reference_lab_name VARCHAR(300) NOT NULL,
    reference_lab_code VARCHAR(50),
    external_accession VARCHAR(100),
    sent_date DATE,
    expected_tat_days INTEGER,
    received_date DATE,
    result_entered BOOLEAN DEFAULT false,
    status VARCHAR(30) DEFAULT 'pending' CHECK (status IN ('pending', 'sent', 'received', 'result_entered', 'cancelled')),
    tracking_number VARCHAR(100),
    courier VARCHAR(100),
    notes TEXT,
    created_at TIMESTAMPTZ DEFAULT NOW(),
    updated_at TIMESTAMPTZ DEFAULT NOW()
);

-- Order status history / audit trail
CREATE TABLE IF NOT EXISTS order_status_history (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    order_id UUID NOT NULL REFERENCES lab_orders(id),
    from_status VARCHAR(30),
    to_status VARCHAR(30) NOT NULL,
    changed_by UUID,
    changed_by_name VARCHAR(200),
    reason TEXT,
    changed_at TIMESTAMPTZ DEFAULT NOW()
);

CREATE INDEX IF NOT EXISTS idx_addon_tests_order ON addon_tests(original_order_id);
CREATE INDEX IF NOT EXISTS idx_sendouts_order ON reference_lab_sendouts(order_id);
CREATE INDEX IF NOT EXISTS idx_sendouts_lab ON reference_lab_sendouts(lab_id);
CREATE INDEX IF NOT EXISTS idx_order_history_order ON order_status_history(order_id);
CREATE INDEX IF NOT EXISTS idx_order_history_date ON order_status_history(changed_at DESC);
