SET search_path TO lis, public;

-- LIS Enums
-- Run: psql -U postgres -d lis_db -f 001_create_enums.sql

DO $$ BEGIN
    IF NOT EXISTS (SELECT 1 FROM pg_type WHERE typname = 'order_status') THEN
        CREATE TYPE order_status AS ENUM (
            'ordered',
            'pending',
            'collecting',
            'collected',
            'received',
            'in_progress',
            'completed',
            'verified',
            'reported',
            'cancelled',
            'rejected'
        );
    END IF;
END $$;

DO $$ BEGIN
    IF NOT EXISTS (SELECT 1 FROM pg_type WHERE typname = 'order_priority') THEN
        CREATE TYPE order_priority AS ENUM (
            'routine',
            'urgent',
            'stat',
            'asap'
        );
    END IF;
END $$;

DO $$ BEGIN
    IF NOT EXISTS (SELECT 1 FROM pg_type WHERE typname = 'specimen_status') THEN
        CREATE TYPE specimen_status AS ENUM (
            'pending',
            'pending_collection',
            'collected',
            'in_transit',
            'received',
            'processing',
            'stored',
            'disposed',
            'rejected'
        );
    END IF;
END $$;

DO $$ BEGIN
    IF NOT EXISTS (SELECT 1 FROM pg_type WHERE typname = 'result_flag') THEN
        CREATE TYPE result_flag AS ENUM (
            'normal',
            'low',
            'high',
            'critical_low',
            'critical_high',
            'abnormal'
        );
    END IF;
END $$;

DO $$ BEGIN
    IF NOT EXISTS (SELECT 1 FROM pg_type WHERE typname = 'qc_status') THEN
        CREATE TYPE qc_status AS ENUM (
            'pending',
            'in_control',
            'out_of_control',
            'warning',
            'rejected'
        );
    END IF;
END $$;

DO $$ BEGIN
    IF NOT EXISTS (SELECT 1 FROM pg_type WHERE typname = 'verification_level') THEN
        CREATE TYPE verification_level AS ENUM (
            'unverified',
            'tech_verified',
            'pathologist_verified',
            'released'
        );
    END IF;
END $$;
