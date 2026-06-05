SET search_path TO lis, public;

CREATE TABLE IF NOT EXISTS specimen_rejection_codes (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    lab_id UUID NOT NULL REFERENCES labs(id),
    code VARCHAR(20) NOT NULL,
    reason VARCHAR(300) NOT NULL,
    action_required VARCHAR(200) DEFAULT 'Recollect',
    is_active BOOLEAN DEFAULT true,
    UNIQUE(lab_id, code)
);

-- Seed standard rejection codes
INSERT INTO specimen_rejection_codes (id, lab_id, code, reason, action_required) VALUES
(gen_random_uuid(), '00000000-0000-0000-0000-000000000001', 'QNS', 'Quantity Not Sufficient', 'Recollect'),
(gen_random_uuid(), '00000000-0000-0000-0000-000000000001', 'HEMOLYZED', 'Hemolyzed Specimen', 'Recollect'),
(gen_random_uuid(), '00000000-0000-0000-0000-000000000001', 'CLOTTED', 'Clotted EDTA/Citrate', 'Recollect'),
(gen_random_uuid(), '00000000-0000-0000-0000-000000000001', 'WRONG_TUBE', 'Incorrect Container', 'Recollect'),
(gen_random_uuid(), '00000000-0000-0000-0000-000000000001', 'MISLABELED', 'Patient ID Mismatch', 'Recollect with proper ID'),
(gen_random_uuid(), '00000000-0000-0000-0000-000000000001', 'EXPIRED', 'Outside Stability Window', 'Recollect'),
(gen_random_uuid(), '00000000-0000-0000-0000-000000000001', 'CONTAMINATED', 'Compromised Specimen', 'Recollect'),
(gen_random_uuid(), '00000000-0000-0000-0000-000000000001', 'LIPEMIC', 'Lipemic Specimen', 'Recollect (fasting required)'),
(gen_random_uuid(), '00000000-0000-0000-0000-000000000001', 'ICTERIC', 'Icteric Specimen', 'Note on report')
ON CONFLICT (lab_id, code) DO NOTHING;
