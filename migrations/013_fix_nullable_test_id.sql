SET search_path TO lis, public;

-- Make test_id nullable on lab_order_tests for external orders that don't map to catalog
ALTER TABLE lab_order_tests ALTER COLUMN test_id DROP NOT NULL;

-- Drop the foreign key constraint on test_id so external orders can have NULL test_id
ALTER TABLE lab_order_tests DROP CONSTRAINT IF EXISTS lab_order_tests_test_id_fkey;
