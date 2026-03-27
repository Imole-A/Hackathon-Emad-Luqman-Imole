const express = require('express');
const { Pool } = require('pg');
const bcrypt = require('bcrypt');
const cors = require('cors');
require('dotenv').config();

const app = express();

// Middleware
app.use(cors()); // Crucial for letting your HTML frontend talk to this API
app.use(express.json());

// Connect to your 3NF Database
const pool = new Pool({
  connectionString: process.env.DATABASE_URL,
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
    // Hash the password (10 rounds of salt is industry standard)
    const salt = await bcrypt.genSalt(10);
    const password_hash = await bcrypt.hash(password, salt);

    // Insert into DB. Notice we don't insert target_role_id yet (it defaults to NULL)
    const newUser = await pool.query(
      `INSERT INTO users (full_name, email, password_hash, account_type_id) 
       VALUES ($1, $2, $3, $4) RETURNING id, full_name, email, account_type_id`,
      [full_name, email, password_hash, account_type_id]
    );

    res.json({ message: "User registered successfully!", user: newUser.rows[0] });
  } catch (err) {
    console.error(err);
    res.status(500).json({ error: "Server error or email already exists." });
  }
});

// 3. LOGIN AN EXISTING USER
app.post('/api/login', async (req, res) => {
  const { email, password } = req.body;

  try {
    // Find user by email
    const userQuery = await pool.query('SELECT * FROM users WHERE email = $1', [email]);
    
    if (userQuery.rows.length === 0) {
      return res.status(401).json({ error: "Invalid Email or Password" });
    }

    const user = userQuery.rows[0];

    // Compare the plain text password to the hashed DB password
    const isMatch = await bcrypt.compare(password, user.password_hash);

    if (isMatch) {
      // Security: Strip out the password hash before sending the profile to the frontend
      const { password_hash, ...safeUserProfile } = user; 
      res.json({ message: "Login successful", user: safeUserProfile });
    } else {
      res.status(401).json({ error: "Invalid Email or Password" });
    }
  } catch (err) {
    console.error(err);
    res.status(500).json({ error: "Database Error" });
  }
});

app.listen(3000, () => console.log('🚀 Server running on http://localhost:3000'));