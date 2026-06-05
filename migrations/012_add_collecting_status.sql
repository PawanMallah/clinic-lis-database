SET search_path TO lis, public;

-- Add 'collecting' value to order_status enum
ALTER TYPE order_status ADD VALUE IF NOT EXISTS 'collecting' AFTER 'ordered';
