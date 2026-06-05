@echo off
REM ============================================================
REM LIS - RESET and REBUILD all tables in lis schema
REM WARNING: This drops and recreates ALL LIS tables!
REM ============================================================

echo ============================================================
echo   LIS Database - FULL RESET
echo   This will DROP and RECREATE all tables in lis schema
echo ============================================================
echo.

set DB_URL=%DATABASE_URL%
if "%DB_URL%"=="" set DB_URL=postgresql://neondb_owner:npg_2BjXgAJTUF5t@ep-wild-pond-aqkaxgeq-pooler.c-8.us-east-1.aws.neon.tech/neondb?sslmode=require

echo Dropping lis schema...
psql "%DB_URL%" -c "DROP SCHEMA IF EXISTS lis CASCADE; CREATE SCHEMA lis;"
echo.

echo Running all migrations...
psql "%DB_URL%" -f "%~dp0migrations\000_create_schema.sql"
psql "%DB_URL%" -f "%~dp0migrations\001_create_enums.sql"
psql "%DB_URL%" -f "%~dp0migrations\002_create_lab_tables.sql"
psql "%DB_URL%" -f "%~dp0migrations\003_create_test_master.sql"
psql "%DB_URL%" -f "%~dp0migrations\004_create_orders.sql"
psql "%DB_URL%" -f "%~dp0migrations\005_create_specimens.sql"
psql "%DB_URL%" -f "%~dp0migrations\006_create_results.sql"
psql "%DB_URL%" -f "%~dp0migrations\007_create_hl7.sql"
psql "%DB_URL%" -f "%~dp0migrations\008_create_qc.sql"
psql "%DB_URL%" -f "%~dp0migrations\009_create_billing.sql"
psql "%DB_URL%" -f "%~dp0migrations\010_create_integration.sql"
psql "%DB_URL%" -f "%~dp0migrations\011_seed_lab_and_tests.sql"
echo.
echo ============================================================
echo Done! Check above for errors.
echo ============================================================
pause
