const fs = require('fs');
const { Pool } = require('pg');
require('dotenv').config();

const pool = new Pool({ connectionString: process.env.DATABASE_URL });

async function runSeeds() {
    try {
        console.log("Reading seeds.sql...");
        const seeds = fs.readFileSync('./db/seeds.sql').toString();
        
        console.log("Injecting data into Neon database...");
        await pool.query(seeds);
        
        console.log("✅ BOOM! Data seeded successfully.");
    } catch (err) {
        console.error("❌ Error:", err);
    } finally {
        pool.end();
    }
}

runSeeds();