-- Add OTP columns for MFA authentication
-- Run this on your Neon database to enable OTP-based login

-- Add OTP columns to students table
ALTER TABLE students 
ADD COLUMN IF NOT EXISTS otp_code TEXT,
ADD COLUMN IF NOT EXISTS otp_expiry TIMESTAMP;

-- Add OTP columns to teachers table
ALTER TABLE teachers 
ADD COLUMN IF NOT EXISTS otp_code TEXT,
ADD COLUMN IF NOT EXISTS otp_expiry TIMESTAMP;

-- Create index for faster OTP lookups
CREATE INDEX IF NOT EXISTS idx_students_otp ON students(email, otp_code) WHERE otp_code IS NOT NULL;
CREATE INDEX IF NOT EXISTS idx_teachers_otp ON teachers(email, otp_code) WHERE otp_code IS NOT NULL;

-- Verify columns exist
SELECT 'students' as table_name, column_name, data_type 
FROM information_schema.columns 
WHERE table_name = 'students' AND column_name LIKE 'otp%'
UNION ALL
SELECT 'teachers' as table_name, column_name, data_type 
FROM information_schema.columns 
WHERE table_name = 'teachers' AND column_name LIKE 'otp%';
