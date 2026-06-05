SET search_path TO lis, public;

-- Seed default lab
INSERT INTO labs (id, name, code, address, phone, email, accreditation_number, settings_json)
VALUES (
    '00000000-0000-0000-0000-000000000001',
    'PathCare Diagnostics',
    'PATHCARE-01',
    '123 Health Street, Medical District, Mumbai 400001',
    '+91 9876543210',
    'info@pathcarediagnostics.com',
    'MC-4567',
    '{"currency": "INR", "timezone": "Asia/Kolkata", "reportHeader": "PathCare Diagnostics", "gstNumber": "27XXXXX1234X1Z5"}'::jsonb
) ON CONFLICT (id) DO NOTHING;

-- Seed test catalog (80 standard Indian lab tests)
INSERT INTO test_master (id, lab_id, code, name, department, specimen_type, tat_hours, price, is_panel) VALUES
-- Hematology
('10000000-0000-0000-0000-000000000001', '00000000-0000-0000-0000-000000000001', 'CBC', 'Complete Blood Count', 'Hematology', 'blood', 4, 400, true),
('10000000-0000-0000-0000-000000000002', '00000000-0000-0000-0000-000000000001', 'HB', 'Hemoglobin', 'Hematology', 'blood', 2, 100, false),
('10000000-0000-0000-0000-000000000003', '00000000-0000-0000-0000-000000000001', 'PCV', 'Packed Cell Volume (HCT)', 'Hematology', 'blood', 2, 100, false),
('10000000-0000-0000-0000-000000000004', '00000000-0000-0000-0000-000000000001', 'TLC', 'Total Leucocyte Count', 'Hematology', 'blood', 2, 120, false),
('10000000-0000-0000-0000-000000000005', '00000000-0000-0000-0000-000000000001', 'DLC', 'Differential Leucocyte Count', 'Hematology', 'blood', 2, 150, false),
('10000000-0000-0000-0000-000000000006', '00000000-0000-0000-0000-000000000001', 'PLT', 'Platelet Count', 'Hematology', 'blood', 2, 120, false),
('10000000-0000-0000-0000-000000000007', '00000000-0000-0000-0000-000000000001', 'ESR', 'Erythrocyte Sedimentation Rate', 'Hematology', 'blood', 2, 100, false),
('10000000-0000-0000-0000-000000000008', '00000000-0000-0000-0000-000000000001', 'RBC', 'Red Blood Cell Count', 'Hematology', 'blood', 2, 100, false),
('10000000-0000-0000-0000-000000000009', '00000000-0000-0000-0000-000000000001', 'RETIC', 'Reticulocyte Count', 'Hematology', 'blood', 4, 200, false),
('10000000-0000-0000-0000-000000000010', '00000000-0000-0000-0000-000000000001', 'PT-INR', 'Prothrombin Time + INR', 'Hematology', 'blood', 4, 350, false),
-- Biochemistry
('10000000-0000-0000-0000-000000000011', '00000000-0000-0000-0000-000000000001', 'FBS', 'Fasting Blood Sugar', 'Biochemistry', 'blood', 2, 80, false),
('10000000-0000-0000-0000-000000000012', '00000000-0000-0000-0000-000000000001', 'PPBS', 'Post Prandial Blood Sugar', 'Biochemistry', 'blood', 2, 80, false),
('10000000-0000-0000-0000-000000000013', '00000000-0000-0000-0000-000000000001', 'RBS', 'Random Blood Sugar', 'Biochemistry', 'blood', 1, 70, false),
('10000000-0000-0000-0000-000000000014', '00000000-0000-0000-0000-000000000001', 'HBA1C', 'Glycosylated Hemoglobin', 'Biochemistry', 'blood', 6, 500, false),
('10000000-0000-0000-0000-000000000015', '00000000-0000-0000-0000-000000000001', 'BUN', 'Blood Urea Nitrogen', 'Biochemistry', 'blood', 3, 100, false),
('10000000-0000-0000-0000-000000000016', '00000000-0000-0000-0000-000000000001', 'CREAT', 'Serum Creatinine', 'Biochemistry', 'blood', 3, 120, false),
('10000000-0000-0000-0000-000000000017', '00000000-0000-0000-0000-000000000001', 'URIC', 'Serum Uric Acid', 'Biochemistry', 'blood', 3, 150, false),
('10000000-0000-0000-0000-000000000018', '00000000-0000-0000-0000-000000000001', 'NA', 'Serum Sodium', 'Biochemistry', 'blood', 3, 200, false),
('10000000-0000-0000-0000-000000000019', '00000000-0000-0000-0000-000000000001', 'K', 'Serum Potassium', 'Biochemistry', 'blood', 3, 200, false),
('10000000-0000-0000-0000-000000000020', '00000000-0000-0000-0000-000000000001', 'CL', 'Serum Chloride', 'Biochemistry', 'blood', 3, 200, false),
('10000000-0000-0000-0000-000000000021', '00000000-0000-0000-0000-000000000001', 'CA', 'Serum Calcium', 'Biochemistry', 'blood', 3, 200, false),
('10000000-0000-0000-0000-000000000022', '00000000-0000-0000-0000-000000000001', 'PHOS', 'Serum Phosphorus', 'Biochemistry', 'blood', 3, 180, false),
-- Liver Function
('10000000-0000-0000-0000-000000000023', '00000000-0000-0000-0000-000000000001', 'LFT', 'Liver Function Test', 'Biochemistry', 'blood', 6, 600, true),
('10000000-0000-0000-0000-000000000024', '00000000-0000-0000-0000-000000000001', 'TBIL', 'Total Bilirubin', 'Biochemistry', 'blood', 3, 120, false),
('10000000-0000-0000-0000-000000000025', '00000000-0000-0000-0000-000000000001', 'DBIL', 'Direct Bilirubin', 'Biochemistry', 'blood', 3, 120, false),
('10000000-0000-0000-0000-000000000026', '00000000-0000-0000-0000-000000000001', 'SGOT', 'SGOT (AST)', 'Biochemistry', 'blood', 3, 150, false),
('10000000-0000-0000-0000-000000000027', '00000000-0000-0000-0000-000000000001', 'SGPT', 'SGPT (ALT)', 'Biochemistry', 'blood', 3, 150, false),
('10000000-0000-0000-0000-000000000028', '00000000-0000-0000-0000-000000000001', 'ALP', 'Alkaline Phosphatase', 'Biochemistry', 'blood', 3, 150, false),
('10000000-0000-0000-0000-000000000029', '00000000-0000-0000-0000-000000000001', 'TP', 'Total Protein', 'Biochemistry', 'blood', 3, 120, false),
('10000000-0000-0000-0000-000000000030', '00000000-0000-0000-0000-000000000001', 'ALB', 'Serum Albumin', 'Biochemistry', 'blood', 3, 120, false),
('10000000-0000-0000-0000-000000000031', '00000000-0000-0000-0000-000000000001', 'GGT', 'Gamma GT', 'Biochemistry', 'blood', 3, 200, false),
-- Lipid Profile
('10000000-0000-0000-0000-000000000032', '00000000-0000-0000-0000-000000000001', 'LIPID', 'Lipid Profile', 'Biochemistry', 'blood', 6, 500, true),
('10000000-0000-0000-0000-000000000033', '00000000-0000-0000-0000-000000000001', 'CHOL', 'Total Cholesterol', 'Biochemistry', 'blood', 3, 150, false),
('10000000-0000-0000-0000-000000000034', '00000000-0000-0000-0000-000000000001', 'TG', 'Triglycerides', 'Biochemistry', 'blood', 3, 150, false),
('10000000-0000-0000-0000-000000000035', '00000000-0000-0000-0000-000000000001', 'HDL', 'HDL Cholesterol', 'Biochemistry', 'blood', 3, 200, false),
('10000000-0000-0000-0000-000000000036', '00000000-0000-0000-0000-000000000001', 'LDL', 'LDL Cholesterol', 'Biochemistry', 'blood', 3, 200, false),
('10000000-0000-0000-0000-000000000037', '00000000-0000-0000-0000-000000000001', 'VLDL', 'VLDL Cholesterol', 'Biochemistry', 'blood', 3, 150, false),
-- Kidney Function
('10000000-0000-0000-0000-000000000038', '00000000-0000-0000-0000-000000000001', 'KFT', 'Kidney Function Test', 'Biochemistry', 'blood', 6, 550, true),
-- Thyroid
('10000000-0000-0000-0000-000000000039', '00000000-0000-0000-0000-000000000001', 'TSH', 'Thyroid Stimulating Hormone', 'Immunology', 'blood', 6, 300, false),
('10000000-0000-0000-0000-000000000040', '00000000-0000-0000-0000-000000000001', 'T3', 'Triiodothyronine (T3)', 'Immunology', 'blood', 6, 250, false),
('10000000-0000-0000-0000-000000000041', '00000000-0000-0000-0000-000000000001', 'T4', 'Thyroxine (T4)', 'Immunology', 'blood', 6, 250, false),
('10000000-0000-0000-0000-000000000042', '00000000-0000-0000-0000-000000000001', 'FT3', 'Free T3', 'Immunology', 'blood', 6, 350, false),
('10000000-0000-0000-0000-000000000043', '00000000-0000-0000-0000-000000000001', 'FT4', 'Free T4', 'Immunology', 'blood', 6, 350, false),
-- Urine
('10000000-0000-0000-0000-000000000044', '00000000-0000-0000-0000-000000000001', 'UR', 'Urine Routine & Microscopy', 'Clinical Pathology', 'urine', 2, 100, false),
('10000000-0000-0000-0000-000000000045', '00000000-0000-0000-0000-000000000001', 'UCR', 'Urine Creatinine', 'Clinical Pathology', 'urine', 4, 150, false),
('10000000-0000-0000-0000-000000000046', '00000000-0000-0000-0000-000000000001', 'UMA', 'Urine Microalbumin', 'Clinical Pathology', 'urine', 6, 400, false),
-- Serology
('10000000-0000-0000-0000-000000000047', '00000000-0000-0000-0000-000000000001', 'CRP', 'C-Reactive Protein', 'Immunology', 'blood', 4, 350, false),
('10000000-0000-0000-0000-000000000048', '00000000-0000-0000-0000-000000000001', 'RF', 'Rheumatoid Factor', 'Immunology', 'blood', 6, 350, false),
('10000000-0000-0000-0000-000000000049', '00000000-0000-0000-0000-000000000001', 'ASO', 'Anti-Streptolysin O', 'Immunology', 'blood', 6, 400, false),
('10000000-0000-0000-0000-000000000050', '00000000-0000-0000-0000-000000000001', 'WIDAL', 'Widal Test', 'Serology', 'blood', 4, 250, false),
('10000000-0000-0000-0000-000000000051', '00000000-0000-0000-0000-000000000001', 'HIV', 'HIV 1 & 2 Antibody', 'Serology', 'blood', 6, 400, false),
('10000000-0000-0000-0000-000000000052', '00000000-0000-0000-0000-000000000001', 'HBSAG', 'Hepatitis B Surface Antigen', 'Serology', 'blood', 4, 350, false),
('10000000-0000-0000-0000-000000000053', '00000000-0000-0000-0000-000000000001', 'HCV', 'Hepatitis C Antibody', 'Serology', 'blood', 6, 500, false),
('10000000-0000-0000-0000-000000000054', '00000000-0000-0000-0000-000000000001', 'DENGNS1', 'Dengue NS1 Antigen', 'Serology', 'blood', 4, 800, false),
('10000000-0000-0000-0000-000000000055', '00000000-0000-0000-0000-000000000001', 'MALAR', 'Malaria Parasite (Smear)', 'Hematology', 'blood', 2, 200, false),
('10000000-0000-0000-0000-000000000056', '00000000-0000-0000-0000-000000000001', 'VDRL', 'VDRL (Syphilis)', 'Serology', 'blood', 6, 250, false),
-- Cardiac
('10000000-0000-0000-0000-000000000057', '00000000-0000-0000-0000-000000000001', 'TROP', 'Troponin I/T', 'Biochemistry', 'blood', 2, 800, false),
('10000000-0000-0000-0000-000000000058', '00000000-0000-0000-0000-000000000001', 'CKMB', 'CK-MB', 'Biochemistry', 'blood', 4, 500, false),
('10000000-0000-0000-0000-000000000059', '00000000-0000-0000-0000-000000000001', 'BNP', 'NT-proBNP', 'Biochemistry', 'blood', 6, 1200, false),
-- Vitamins/Hormones
('10000000-0000-0000-0000-000000000060', '00000000-0000-0000-0000-000000000001', 'VITD', 'Vitamin D (25-OH)', 'Immunology', 'blood', 12, 1200, false),
('10000000-0000-0000-0000-000000000061', '00000000-0000-0000-0000-000000000001', 'B12', 'Vitamin B12', 'Immunology', 'blood', 12, 800, false),
('10000000-0000-0000-0000-000000000062', '00000000-0000-0000-0000-000000000001', 'IRON', 'Serum Iron', 'Biochemistry', 'blood', 6, 250, false),
('10000000-0000-0000-0000-000000000063', '00000000-0000-0000-0000-000000000001', 'FERR', 'Serum Ferritin', 'Immunology', 'blood', 6, 500, false),
('10000000-0000-0000-0000-000000000064', '00000000-0000-0000-0000-000000000001', 'TIBC', 'Total Iron Binding Capacity', 'Biochemistry', 'blood', 6, 300, false),
('10000000-0000-0000-0000-000000000065', '00000000-0000-0000-0000-000000000001', 'PSA', 'Prostate Specific Antigen', 'Immunology', 'blood', 12, 600, false),
('10000000-0000-0000-0000-000000000066', '00000000-0000-0000-0000-000000000001', 'PROLAC', 'Prolactin', 'Immunology', 'blood', 12, 500, false),
('10000000-0000-0000-0000-000000000067', '00000000-0000-0000-0000-000000000001', 'CORT', 'Serum Cortisol', 'Immunology', 'blood', 12, 600, false),
('10000000-0000-0000-0000-000000000068', '00000000-0000-0000-0000-000000000001', 'INSULIN', 'Fasting Insulin', 'Immunology', 'blood', 12, 500, false),
-- Stool
('10000000-0000-0000-0000-000000000069', '00000000-0000-0000-0000-000000000001', 'STOOL', 'Stool Routine & Microscopy', 'Clinical Pathology', 'stool', 2, 100, false),
('10000000-0000-0000-0000-000000000070', '00000000-0000-0000-0000-000000000001', 'FOBT', 'Fecal Occult Blood Test', 'Clinical Pathology', 'stool', 4, 200, false),
-- Coagulation
('10000000-0000-0000-0000-000000000071', '00000000-0000-0000-0000-000000000001', 'APTT', 'Activated Partial Thromboplastin Time', 'Hematology', 'blood', 4, 350, false),
('10000000-0000-0000-0000-000000000072', '00000000-0000-0000-0000-000000000001', 'DIMER', 'D-Dimer', 'Hematology', 'blood', 6, 1000, false),
('10000000-0000-0000-0000-000000000073', '00000000-0000-0000-0000-000000000001', 'FIB', 'Fibrinogen', 'Hematology', 'blood', 6, 500, false),
-- Pancreatic
('10000000-0000-0000-0000-000000000074', '00000000-0000-0000-0000-000000000001', 'AMYL', 'Serum Amylase', 'Biochemistry', 'blood', 4, 300, false),
('10000000-0000-0000-0000-000000000075', '00000000-0000-0000-0000-000000000001', 'LIPASE', 'Serum Lipase', 'Biochemistry', 'blood', 4, 400, false),
-- Misc
('10000000-0000-0000-0000-000000000076', '00000000-0000-0000-0000-000000000001', 'LDH', 'Lactate Dehydrogenase', 'Biochemistry', 'blood', 4, 300, false),
('10000000-0000-0000-0000-000000000077', '00000000-0000-0000-0000-000000000001', 'CPK', 'Creatine Phosphokinase', 'Biochemistry', 'blood', 4, 350, false),
('10000000-0000-0000-0000-000000000078', '00000000-0000-0000-0000-000000000001', 'MG', 'Serum Magnesium', 'Biochemistry', 'blood', 4, 250, false),
('10000000-0000-0000-0000-000000000079', '00000000-0000-0000-0000-000000000001', 'HCG', 'Beta HCG (Pregnancy)', 'Immunology', 'blood', 6, 600, false),
('10000000-0000-0000-0000-000000000080', '00000000-0000-0000-0000-000000000001', 'ANA', 'Anti-Nuclear Antibody', 'Immunology', 'blood', 12, 800, false)
ON CONFLICT (lab_id, code) DO NOTHING;
