const express = require('express');
const { Pool } = require('pg');
require('dotenv').config();

const app = express();
app.use(express.json());

// Connect to your 3NF Database
const pool = new Pool({
  connectionString: process.env.DATABASE_URL,
});

// ROUTE: Get all skills for the Matrix
app.get('/api/skills', async (req, res) => {
  try {
    const result = await pool.query('SELECT * FROM skills ORDER BY category');
    res.json(result.rows);
  } catch (err) {
    res.status(500).send("Database Error");
  }
});

app.listen(3000, () => console.log('Server running on http://localhost:3000'));