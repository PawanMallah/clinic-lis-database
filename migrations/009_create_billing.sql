SET search_path TO lis, public;

-- Migration 009: Billing and Inventory tables

CREATE TABLE IF NOT EXISTS lab_invoices (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    lab_id UUID NOT NULL REFERENCES labs(id),
    invoice_number VARCHAR(50) UNIQUE NOT NULL,
    order_id UUID REFERENCES lab_orders(id),
    patient_id UUID,
    patient_name VARCHAR(300),
    patient_uhid VARCHAR(50),
    referred_by VARCHAR(200),
    pricing_tier VARCHAR(20) DEFAULT 'walk_in' CHECK (pricing_tier IN ('walk_in', 'referred', 'insurance', 'corporate')),
    subtotal DECIMAL(10,2) NOT NULL DEFAULT 0,
    discount_percent DECIMAL(5,2) DEFAULT 0,
    discount_amount DECIMAL(10,2) DEFAULT 0,
    tax_percent DECIMAL(5,2) DEFAULT 0,
    tax_amount DECIMAL(10,2) DEFAULT 0,
    total_amount DECIMAL(10,2) NOT NULL DEFAULT 0,
    amount_paid DECIMAL(10,2) DEFAULT 0,
    amount_due DECIMAL(10,2) DEFAULT 0,
    payment_mode VARCHAR(20) DEFAULT 'cash' CHECK (payment_mode IN ('cash', 'upi', 'card', 'insurance', 'credit')),
    status VARCHAR(20) DEFAULT 'unpaid' CHECK (status IN ('paid', 'partial', 'unpaid', 'refunded', 'cancelled')),
    notes TEXT,
    created_at TIMESTAMPTZ DEFAULT NOW(),
    updated_at TIMESTAMPTZ DEFAULT NOW()
);

CREATE TABLE IF NOT EXISTS lab_invoice_items (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    invoice_id UUID NOT NULL REFERENCES lab_invoices(id) ON DELETE CASCADE,
    test_id UUID REFERENCES test_master(id),
    test_code VARCHAR(50),
    test_name VARCHAR(300) NOT NULL,
    quantity INTEGER DEFAULT 1,
    rate DECIMAL(10,2) NOT NULL,
    amount DECIMAL(10,2) NOT NULL,
    sort_order INTEGER DEFAULT 0
);

CREATE TABLE IF NOT EXISTS reagent_inventory (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    lab_id UUID NOT NULL REFERENCES labs(id),
    reagent_name VARCHAR(300) NOT NULL,
    manufacturer VARCHAR(200),
    catalog_number VARCHAR(100),
    lot_number VARCHAR(100),
    expiry_date DATE,
    quantity_total DECIMAL(10,2) NOT NULL DEFAULT 0,
    quantity_remaining DECIMAL(10,2) NOT NULL DEFAULT 0,
    unit VARCHAR(50) DEFAULT 'ml',
    tests_per_unit INTEGER,
    reorder_level DECIMAL(10,2) DEFAULT 10,
    cost_per_unit DECIMAL(10,2),
    instrument_id UUID,
    instrument_name VARCHAR(200),
    status VARCHAR(20) DEFAULT 'in_stock' CHECK (status IN ('in_stock', 'low', 'expired', 'out_of_stock')),
    received_date DATE,
    notes TEXT,
    created_at TIMESTAMPTZ DEFAULT NOW(),
    updated_at TIMESTAMPTZ DEFAULT NOW()
);

CREATE TABLE IF NOT EXISTS reagent_consumption_log (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    reagent_id UUID NOT NULL REFERENCES reagent_inventory(id),
    quantity_used DECIMAL(10,2) NOT NULL,
    test_name VARCHAR(300),
    order_id UUID,
    consumed_at TIMESTAMPTZ DEFAULT NOW(),
    notes TEXT
);

CREATE TABLE IF NOT EXISTS lab_reports (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    lab_id UUID NOT NULL REFERENCES labs(id),
    order_id UUID NOT NULL REFERENCES lab_orders(id),
    patient_name VARCHAR(300),
    report_number VARCHAR(50) UNIQUE,
    status VARCHAR(20) DEFAULT 'draft' CHECK (status IN ('draft', 'finalized', 'amended', 'delivered')),
    report_pdf_url TEXT,
    report_json JSONB,
    generated_at TIMESTAMPTZ,
    delivered_at TIMESTAMPTZ,
    delivered_via VARCHAR(50),
    version INTEGER DEFAULT 1,
    amendment_reason TEXT,
    signed_by UUID,
    signed_by_name VARCHAR(200),
    signed_at TIMESTAMPTZ,
    created_at TIMESTAMPTZ DEFAULT NOW(),
    updated_at TIMESTAMPTZ DEFAULT NOW()
);

CREATE INDEX idx_lab_invoices_lab ON lab_invoices(lab_id);
CREATE INDEX idx_lab_invoices_order ON lab_invoices(order_id);
CREATE INDEX idx_lab_invoices_status ON lab_invoices(status);
CREATE INDEX idx_lab_invoices_date ON lab_invoices(created_at DESC);
CREATE INDEX idx_invoice_items_invoice ON lab_invoice_items(invoice_id);
CREATE INDEX idx_reagent_lab ON reagent_inventory(lab_id);
CREATE INDEX idx_reagent_status ON reagent_inventory(status);
CREATE INDEX idx_reagent_expiry ON reagent_inventory(expiry_date);
CREATE INDEX idx_reagent_consumption ON reagent_consumption_log(reagent_id);
CREATE INDEX idx_lab_reports_order ON lab_reports(order_id);
CREATE INDEX idx_lab_reports_lab ON lab_reports(lab_id);
