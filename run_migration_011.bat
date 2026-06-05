@echo off
echo Running migration 011: Seed lab and tests...
psql -U postgres -d lis_db -f migrations\011_seed_lab_and_tests.sql
echo Done.
pause
