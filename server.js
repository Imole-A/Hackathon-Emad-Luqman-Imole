const express = require('express');
const { Pool } = require('pg');
const bcrypt = require('bcrypt');
const cors = require('cors');
require('dotenv').config();

const app = express();

// Middleware
app.use(cors()); // Crucial for letting your HTML frontend talk to this API
app.use(express.json());

// Connect to your Cloud Database (Neon)
const pool = new Pool({ 
    connectionString: process.env.DATABASE_URL 
});

// ==========================================
// 🛣️ ROUTES
// ==========================================

// 1. GET ALL SKILLS (For the Matrix)
app.get('/api/skills', async (req, res) => {
    try {
        const result = await pool.query('SELECT * FROM skills ORDER BY category');
        res.json(result.rows);
    } catch (err) {
        console.error(err);
        res.status(500).send("Database Error");
    }
});

// 2. REGISTER A NEW USER
app.post('/api/register', async (req, res) => {
    const { full_name, email, password, account_type_id } = req.body;

    try {
        // Scramble the password
        const salt = await bcrypt.genSalt(10);
        const password_hash = await bcrypt.hash(password, salt);

        // Save to database
        const newUser = await pool.query(
            `INSERT INTO users (full_name, email, password_hash, account_type_id) 
             VALUES ($1, $2, $3, $4) RETURNING id, full_name, email, account_type_id`,
            [full_name, email, password_hash, account_type_id]
        );

        res.json({ message: "Success! User created.", user: newUser.rows[0] });
    } catch (err) {
        console.error(err);
        res.status(500).json({ error: "Server error. Email might already exist." });
    }
});

// 3. LOGIN AN EXISTING USER
app.post('/api/login', async (req, res) => {
    const { email, password } = req.body;

    try {
        // Find the user
        const userQuery = await pool.query('SELECT * FROM users WHERE email = $1', [email]);
        
        if (userQuery.rows.length === 0) {
            return res.status(401).json({ error: "Invalid Email or Password" });
        }
        
        const user = userQuery.rows[0];

        // Check password
        const isMatch = await bcrypt.compare(password, user.password_hash);
        
        if (isMatch) {
            // Remove the hash before sending the profile back to the frontend
            const { password_hash, ...safeUserProfile } = user; 
            res.json({ message: "Login successful!", user: safeUserProfile });
        } else {
            res.status(401).json({ error: "Invalid Email or Password" });
        }
    } catch (err) {
        console.error(err);
        res.status(500).json({ error: "Database Error" });
    }
});

// Fetch the roles from the db
app.get('/api/roles', async (req, res) => {
    try {
        const result = await pool.query('SELECT * FROM roles ORDER BY id ASC');
        res.json(result.rows);
    } catch (err) {
        res.status(500).send("Database Error");
    }
});

// Start the engine
app.listen(3000, () => console.log('🚀 Server running on http://localhost:3000'));