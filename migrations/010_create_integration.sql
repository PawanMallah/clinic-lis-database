-- Migration 010: Integration API tables (API keys, webhooks)

CREATE TABLE IF NOT EXISTS api_keys (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    lab_id UUID NOT NULL REFERENCES labs(id),
    key_name VARCHAR(200) NOT NULL,
    api_key_hash VARCHAR(128) NOT NULL UNIQUE,
    api_key_prefix VARCHAR(10) NOT NULL,
    permissions JSONB DEFAULT '["orders.create", "orders.read", "results.read", "tests.read"]',
    is_active BOOLEAN DEFAULT true,
    rate_limit_per_minute INTEGER DEFAULT 60,
    last_used_at TIMESTAMPTZ,
    expires_at TIMESTAMPTZ,
    created_at TIMESTAMPTZ DEFAULT NOW()
);

CREATE TABLE IF NOT EXISTS webhooks (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    lab_id UUID NOT NULL REFERENCES labs(id),
    url VARCHAR(500) NOT NULL,
    events JSONB DEFAULT '["result.verified", "report.finalized"]',
    secret VARCHAR(128),
    is_active BOOLEAN DEFAULT true,
    last_triggered_at TIMESTAMPTZ,
    last_status_code INTEGER,
    failure_count INTEGER DEFAULT 0,
    created_at TIMESTAMPTZ DEFAULT NOW()
);

CREATE TABLE IF NOT EXISTS webhook_delivery_log (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    webhook_id UUID NOT NULL REFERENCES webhooks(id),
    event_type VARCHAR(50) NOT NULL,
    payload JSONB NOT NULL,
    response_status INTEGER,
    response_body TEXT,
    delivered_at TIMESTAMPTZ DEFAULT NOW(),
    success BOOLEAN DEFAULT false
);

CREATE INDEX idx_api_keys_lab ON api_keys(lab_id);
CREATE INDEX idx_api_keys_hash ON api_keys(api_key_hash);
CREATE INDEX idx_webhooks_lab ON webhooks(lab_id);
CREATE INDEX idx_webhook_log_webhook ON webhook_delivery_log(webhook_id);
CREATE INDEX idx_webhook_log_date ON webhook_delivery_log(delivered_at DESC);
