SET search_path TO lis, public;

-- Add LOINC codes and additional fields to test_master
ALTER TABLE test_master ADD COLUMN IF NOT EXISTS loinc_code VARCHAR(20);
ALTER TABLE test_master ADD COLUMN IF NOT EXISTS synonyms TEXT;
ALTER TABLE test_master ADD COLUMN IF NOT EXISTS container_type VARCHAR(100);
ALTER TABLE test_master ADD COLUMN IF NOT EXISTS volume_required VARCHAR(50);
ALTER TABLE test_master ADD COLUMN IF NOT EXISTS collection_instructions TEXT;
ALTER TABLE test_master ADD COLUMN IF NOT EXISTS stability_info TEXT;
ALTER TABLE test_master ADD COLUMN IF NOT EXISTS performing_location VARCHAR(50) DEFAULT 'in_house';
ALTER TABLE test_master ADD COLUMN IF NOT EXISTS cpt_code VARCHAR(20);
ALTER TABLE test_master ADD COLUMN IF NOT EXISTS reflex_rules JSONB DEFAULT '[]';
ALTER TABLE test_master ADD COLUMN IF NOT EXISTS tat_stat_hours INTEGER;

CREATE INDEX IF NOT EXISTS idx_test_master_loinc ON test_master(loinc_code);
