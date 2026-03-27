const fs = require('fs');
const { Pool } = require('pg');
require('dotenv').config();

const pool = new Pool({ connectionString: process.env.DATABASE_URL });

async function runDatabaseFiles() {
    try {
        console.log("Reading schema.sql...");
        const schema = fs.readFileSync('./db/schema.sql').toString();
        
        console.log("Executing in database...");
        await pool.query(schema);
        
        console.log("✅ Success! Tables created.");
    } catch (err) {
        console.error("❌ Error:", err);
    } finally {
        pool.end(); // Close the connection
    }
}

runDatabaseFiles();