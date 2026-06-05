@echo off
REM ============================================================
REM LIS - Run ALL migrations into Neon DB (lis schema)
REM ============================================================

echo ============================================================
echo   LIS Database - Running ALL Migrations
echo   Schema: lis
echo ============================================================
echo.

set DB_URL=%DATABASE_URL%
if "%DB_URL%"=="" set DB_URL=postgresql://neondb_owner:npg_2BjXgAJTUF5t@ep-wild-pond-aqkaxgeq-pooler.c-8.us-east-1.aws.neon.tech/neondb?sslmode=require

echo Using DB: %DB_URL%
echo.

echo [1/12] Running 000_create_schema.sql...
psql "%DB_URL%" -f "%~dp0migrations\000_create_schema.sql"
echo.

echo [2/12] Running 001_create_enums.sql...
psql "%DB_URL%" -f "%~dp0migrations\001_create_enums.sql"
echo.

echo [3/12] Running 002_create_lab_tables.sql...
psql "%DB_URL%" -f "%~dp0migrations\002_create_lab_tables.sql"
echo.

echo [4/12] Running 003_create_test_master.sql...
psql "%DB_URL%" -f "%~dp0migrations\003_create_test_master.sql"
echo.

echo [5/12] Running 004_create_orders.sql...
psql "%DB_URL%" -f "%~dp0migrations\004_create_orders.sql"
echo.

echo [6/12] Running 005_create_specimens.sql...
psql "%DB_URL%" -f "%~dp0migrations\005_create_specimens.sql"
echo.

echo [7/12] Running 006_create_results.sql...
psql "%DB_URL%" -f "%~dp0migrations\006_create_results.sql"
echo.

echo [8/12] Running 007_create_hl7.sql...
psql "%DB_URL%" -f "%~dp0migrations\007_create_hl7.sql"
echo.

echo [9/12] Running 008_create_qc.sql...
psql "%DB_URL%" -f "%~dp0migrations\008_create_qc.sql"
echo.

echo [10/12] Running 009_create_billing.sql...
psql "%DB_URL%" -f "%~dp0migrations\009_create_billing.sql"
echo.

echo [11/12] Running 010_create_integration.sql...
psql "%DB_URL%" -f "%~dp0migrations\010_create_integration.sql"
echo.

echo [12/12] Running 011_seed_lab_and_tests.sql...
psql "%DB_URL%" -f "%~dp0migrations\011_seed_lab_and_tests.sql"
echo.

echo ============================================================
echo   Done! Check output above for any errors.
echo ============================================================
pause
