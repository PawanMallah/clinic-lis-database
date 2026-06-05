SET search_path TO lis, public;

CREATE TABLE IF NOT EXISTS specimens (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    lab_id UUID NOT NULL REFERENCES labs(id),
    order_id UUID NOT NULL REFERENCES lab_orders(id),
    barcode VARCHAR(50) UNIQUE NOT NULL,
    specimen_type VARCHAR(50) NOT NULL,
    tube_type VARCHAR(50),
    tube_color VARCHAR(30),
    volume_ml DECIMAL(5,2),
    collected_by UUID,
    collected_by_name VARCHAR(200),
    collected_at TIMESTAMPTZ,
    received_by UUID,
    received_by_name VARCHAR(200),
    received_at TIMESTAMPTZ,
    status specimen_status DEFAULT 'pending',
    reject_reason TEXT,
    rejected_by UUID,
    rejected_at TIMESTAMPTZ,
    notes TEXT,
    created_at TIMESTAMPTZ DEFAULT NOW(),
    updated_at TIMESTAMPTZ DEFAULT NOW()
);

CREATE TABLE IF NOT EXISTS specimen_tracking (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    specimen_id UUID NOT NULL REFERENCES specimens(id) ON DELETE CASCADE,
    action VARCHAR(50) NOT NULL,
    performed_by UUID,
    performed_by_name VARCHAR(200),
    performed_at TIMESTAMPTZ DEFAULT NOW(),
    notes TEXT
);

CREATE INDEX idx_specimens_barcode ON specimens(barcode);
CREATE INDEX idx_specimens_order ON specimens(order_id);
CREATE INDEX idx_specimens_status ON specimens(status);
CREATE INDEX idx_specimens_lab ON specimens(lab_id);
CREATE INDEX idx_specimen_tracking_specimen ON specimen_tracking(specimen_id);
