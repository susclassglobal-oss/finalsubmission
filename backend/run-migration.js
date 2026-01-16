// Quick database migration runner
// Run with: node run-migration.js

require('dotenv').config({ path: '../.env' });
const { Pool } = require('pg');

const pool = new Pool({
  connectionString: process.env.DATABASE_URL,
  ssl: { rejectUnauthorized: false }
});

async function runMigration() {
  try {
    console.log('Running OTP columns migration...\n');
    
    // Add OTP columns
    await pool.query(`
      ALTER TABLE students ADD COLUMN IF NOT EXISTS otp_code TEXT;
      ALTER TABLE students ADD COLUMN IF NOT EXISTS otp_expiry TIMESTAMP;
      ALTER TABLE teachers ADD COLUMN IF NOT EXISTS otp_code TEXT;
      ALTER TABLE teachers ADD COLUMN IF NOT EXISTS otp_expiry TIMESTAMP;
    `);
    console.log('✓ OTP columns added/verified\n');
    
    // Verify
    const result = await pool.query(`
      SELECT table_name, column_name, data_type 
      FROM information_schema.columns 
      WHERE table_name IN ('students', 'teachers') 
        AND column_name LIKE 'otp%'
      ORDER BY table_name, column_name
    `);
    
    console.log('OTP columns in database:');
    result.rows.forEach(row => {
      console.log(`  ${row.table_name}.${row.column_name} (${row.data_type})`);
    });
    
    console.log('\n✓ Migration complete!');
  } catch (err) {
    console.error('Migration error:', err.message);
  } finally {
    await pool.end();
  }
}

runMigration();
