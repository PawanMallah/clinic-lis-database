SET search_path TO lis, public;

-- Migration 007: HL7 instrument connections and message logging

CREATE TABLE IF NOT EXISTS hl7_connections (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    lab_id UUID NOT NULL REFERENCES labs(id),
    instrument_name VARCHAR(200) NOT NULL,
    instrument_model VARCHAR(200),
    manufacturer VARCHAR(200),
    serial_number VARCHAR(100),
    host VARCHAR(255) NOT NULL,
    port INTEGER NOT NULL,
    protocol VARCHAR(20) DEFAULT 'hl7v2' CHECK (protocol IN ('hl7v2', 'astm')),
    direction VARCHAR(20) DEFAULT 'bidirectional' CHECK (direction IN ('inbound', 'outbound', 'bidirectional')),
    status VARCHAR(20) DEFAULT 'disconnected' CHECK (status IN ('connected', 'disconnected', 'error')),
    auto_reconnect BOOLEAN DEFAULT true,
    last_connected_at TIMESTAMPTZ,
    last_message_at TIMESTAMPTZ,
    test_code_mapping JSONB DEFAULT '{}',
    settings JSONB DEFAULT '{}',
    created_at TIMESTAMPTZ DEFAULT NOW(),
    updated_at TIMESTAMPTZ DEFAULT NOW()
);

CREATE TABLE IF NOT EXISTS hl7_message_log (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    connection_id UUID NOT NULL REFERENCES hl7_connections(id),
    direction VARCHAR(10) NOT NULL CHECK (direction IN ('inbound', 'outbound')),
    message_type VARCHAR(20),
    trigger_event VARCHAR(20),
    control_id VARCHAR(50),
    raw_message TEXT NOT NULL,
    parsed_json JSONB,
    status VARCHAR(20) DEFAULT 'received' CHECK (status IN ('received', 'processed', 'error', 'sent', 'acknowledged')),
    error_message TEXT,
    processing_time_ms INTEGER,
    created_at TIMESTAMPTZ DEFAULT NOW()
);

CREATE TABLE IF NOT EXISTS instrument_test_mapping (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    connection_id UUID NOT NULL REFERENCES hl7_connections(id),
    instrument_test_code VARCHAR(100) NOT NULL,
    instrument_test_name VARCHAR(300),
    lis_test_id UUID REFERENCES test_master(id),
    lis_test_code VARCHAR(50),
    lis_test_name VARCHAR(300),
    is_active BOOLEAN DEFAULT true,
    created_at TIMESTAMPTZ DEFAULT NOW(),
    UNIQUE(connection_id, instrument_test_code)
);

CREATE INDEX IF NOT EXISTS idx_hl7_conn_lab ON hl7_connections(lab_id);
CREATE INDEX IF NOT EXISTS idx_hl7_conn_status ON hl7_connections(status);
CREATE INDEX IF NOT EXISTS idx_hl7_log_conn ON hl7_message_log(connection_id);
CREATE INDEX IF NOT EXISTS idx_hl7_log_date ON hl7_message_log(created_at DESC);
CREATE INDEX IF NOT EXISTS idx_hl7_log_status ON hl7_message_log(status);
CREATE INDEX IF NOT EXISTS idx_instrument_mapping_conn ON instrument_test_mapping(connection_id);
