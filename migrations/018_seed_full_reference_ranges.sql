SET search_path TO lis, public;

-- First, add test_parameters for CBC panel components
INSERT INTO test_parameters (id, test_id, name, short_name, unit, result_type, sort_order) VALUES
-- CBC Parameters (test_id = CBC panel)
(gen_random_uuid(), '10000000-0000-0000-0000-000000000001', 'White Blood Cell Count', 'WBC', '10^9/L', 'numeric', 1),
(gen_random_uuid(), '10000000-0000-0000-0000-000000000001', 'Red Blood Cell Count', 'RBC', '10^12/L', 'numeric', 2),
(gen_random_uuid(), '10000000-0000-0000-0000-000000000001', 'Hemoglobin', 'Hgb', 'g/dL', 'numeric', 3),
(gen_random_uuid(), '10000000-0000-0000-0000-000000000001', 'Hematocrit', 'Hct', '%', 'numeric', 4),
(gen_random_uuid(), '10000000-0000-0000-0000-000000000001', 'MCV', 'MCV', 'fL', 'numeric', 5),
(gen_random_uuid(), '10000000-0000-0000-0000-000000000001', 'MCH', 'MCH', 'pg', 'numeric', 6),
(gen_random_uuid(), '10000000-0000-0000-0000-000000000001', 'MCHC', 'MCHC', 'g/dL', 'numeric', 7),
(gen_random_uuid(), '10000000-0000-0000-0000-000000000001', 'RDW', 'RDW', '%', 'numeric', 8),
(gen_random_uuid(), '10000000-0000-0000-0000-000000000001', 'Platelet Count', 'PLT', '10^9/L', 'numeric', 9),
(gen_random_uuid(), '10000000-0000-0000-0000-000000000001', 'Neutrophils', 'Neut', '%', 'numeric', 10),
(gen_random_uuid(), '10000000-0000-0000-0000-000000000001', 'Lymphocytes', 'Lymph', '%', 'numeric', 11),
(gen_random_uuid(), '10000000-0000-0000-0000-000000000001', 'Monocytes', 'Mono', '%', 'numeric', 12),
(gen_random_uuid(), '10000000-0000-0000-0000-000000000001', 'Eosinophils', 'Eos', '%', 'numeric', 13),
(gen_random_uuid(), '10000000-0000-0000-0000-000000000001', 'Basophils', 'Baso', '%', 'numeric', 14)
ON CONFLICT DO NOTHING;

-- Update test_master with LOINC codes, container types, stability
UPDATE test_master SET loinc_code = '58410-2', container_type = 'EDTA (Lavender top)', volume_required = '3 mL', collection_instructions = 'Fasting not required', stability_info = '24h RT, 72h refrigerated', tat_stat_hours = 1 WHERE code = 'CBC' AND lab_id = '00000000-0000-0000-0000-000000000001';
UPDATE test_master SET loinc_code = '718-7' WHERE code = 'HB' AND lab_id = '00000000-0000-0000-0000-000000000001';
UPDATE test_master SET loinc_code = '4544-3' WHERE code = 'PCV' AND lab_id = '00000000-0000-0000-0000-000000000001';
UPDATE test_master SET loinc_code = '6690-2' WHERE code = 'TLC' AND lab_id = '00000000-0000-0000-0000-000000000001';
UPDATE test_master SET loinc_code = '777-3' WHERE code = 'PLT' AND lab_id = '00000000-0000-0000-0000-000000000001';
UPDATE test_master SET loinc_code = '4537-7' WHERE code = 'ESR' AND lab_id = '00000000-0000-0000-0000-000000000001';
UPDATE test_master SET loinc_code = '5902-2', container_type = 'Citrate (Light Blue top)', volume_required = '2.7 mL', stability_info = 'Process within 4 hours', tat_stat_hours = 2 WHERE code = 'PT-INR' AND lab_id = '00000000-0000-0000-0000-000000000001';
UPDATE test_master SET loinc_code = '1558-6', container_type = 'SST (Gold/Red top)', volume_required = '5 mL', collection_instructions = 'Fasting 8-12 hours', tat_stat_hours = 1 WHERE code = 'FBS' AND lab_id = '00000000-0000-0000-0000-000000000001';
UPDATE test_master SET loinc_code = '2345-7' WHERE code = 'RBS' AND lab_id = '00000000-0000-0000-0000-000000000001';
UPDATE test_master SET loinc_code = '4548-4' WHERE code = 'HBA1C' AND lab_id = '00000000-0000-0000-0000-000000000001';
UPDATE test_master SET loinc_code = '3094-0' WHERE code = 'BUN' AND lab_id = '00000000-0000-0000-0000-000000000001';
UPDATE test_master SET loinc_code = '2160-0' WHERE code = 'CREAT' AND lab_id = '00000000-0000-0000-0000-000000000001';
UPDATE test_master SET loinc_code = '2951-2' WHERE code = 'NA' AND lab_id = '00000000-0000-0000-0000-000000000001';
UPDATE test_master SET loinc_code = '2823-3' WHERE code = 'K' AND lab_id = '00000000-0000-0000-0000-000000000001';
UPDATE test_master SET loinc_code = '2075-0' WHERE code = 'CL' AND lab_id = '00000000-0000-0000-0000-000000000001';
UPDATE test_master SET loinc_code = '17861-6' WHERE code = 'CA' AND lab_id = '00000000-0000-0000-0000-000000000001';
UPDATE test_master SET loinc_code = '1975-2' WHERE code = 'TBIL' AND lab_id = '00000000-0000-0000-0000-000000000001';
UPDATE test_master SET loinc_code = '1920-8' WHERE code = 'SGOT' AND lab_id = '00000000-0000-0000-0000-000000000001';
UPDATE test_master SET loinc_code = '1742-6' WHERE code = 'SGPT' AND lab_id = '00000000-0000-0000-0000-000000000001';
UPDATE test_master SET loinc_code = '6768-6' WHERE code = 'ALP' AND lab_id = '00000000-0000-0000-0000-000000000001';
UPDATE test_master SET loinc_code = '2885-2' WHERE code = 'TP' AND lab_id = '00000000-0000-0000-0000-000000000001';
UPDATE test_master SET loinc_code = '1751-7' WHERE code = 'ALB' AND lab_id = '00000000-0000-0000-0000-000000000001';
UPDATE test_master SET loinc_code = '2093-3', container_type = 'SST (Gold/Red top)', volume_required = '5 mL', collection_instructions = 'Fasting 9-12 hours required' WHERE code = 'CHOL' AND lab_id = '00000000-0000-0000-0000-000000000001';
UPDATE test_master SET loinc_code = '2571-8' WHERE code = 'TG' AND lab_id = '00000000-0000-0000-0000-000000000001';
UPDATE test_master SET loinc_code = '2085-9' WHERE code = 'HDL' AND lab_id = '00000000-0000-0000-0000-000000000001';
UPDATE test_master SET loinc_code = '13457-7' WHERE code = 'LDL' AND lab_id = '00000000-0000-0000-0000-000000000001';
UPDATE test_master SET loinc_code = '3016-3' WHERE code = 'TSH' AND lab_id = '00000000-0000-0000-0000-000000000001';
UPDATE test_master SET loinc_code = '3024-7' WHERE code = 'FT4' AND lab_id = '00000000-0000-0000-0000-000000000001';
UPDATE test_master SET loinc_code = '3051-0' WHERE code = 'FT3' AND lab_id = '00000000-0000-0000-0000-000000000001';
UPDATE test_master SET loinc_code = '1988-5' WHERE code = 'CRP' AND lab_id = '00000000-0000-0000-0000-000000000001';
UPDATE test_master SET loinc_code = '1989-3' WHERE code = 'VITD' AND lab_id = '00000000-0000-0000-0000-000000000001';
UPDATE test_master SET loinc_code = '2132-9' WHERE code = 'B12' AND lab_id = '00000000-0000-0000-0000-000000000001';
UPDATE test_master SET loinc_code = '2276-4' WHERE code = 'FERR' AND lab_id = '00000000-0000-0000-0000-000000000001';
UPDATE test_master SET loinc_code = '3173-2', container_type = 'Citrate (Light Blue top)', volume_required = '2.7 mL' WHERE code = 'APTT' AND lab_id = '00000000-0000-0000-0000-000000000001';
UPDATE test_master SET loinc_code = '48066-5' WHERE code = 'DIMER' AND lab_id = '00000000-0000-0000-0000-000000000001';
