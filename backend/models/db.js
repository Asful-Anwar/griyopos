const mysql = require("mysql2");
const dotenv = require("dotenv");
dotenv.config();

// Buat pool connection (bukan connection tunggal)
const db = mysql.createPool({
  host: process.env.DB_HOST,
  user: process.env.DB_USER,
  password: process.env.DB_PASSWORD || '',
  database: process.env.DB_NAME,
  waitForConnections: true,
  connectionLimit: 10,
  queueLimit: 0
});

console.log("🟢 Database pool connected.");
module.exports = db;
