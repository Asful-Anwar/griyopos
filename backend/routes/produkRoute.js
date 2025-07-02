const express = require("express");
const router = express.Router();
const { getAllProduk } = require("../controllers/produkController");
const db = require("../models/db");

router.get("/", (req, res) => {
  db.query("SELECT id, nama, harga, stok FROM produk", (err, result) => {
    if (err) return res.status(500).json(err);
    res.json(result);
  });
});


// Tambah produk
router.post("/", (req, res) => {
  const { nama, harga } = req.body;
  const sql = "INSERT INTO produk (nama, harga) VALUES (?, ?)";
  db.query(sql, [nama, harga], (err, result) => {
    if (err) return res.status(500).json(err);
    res.json({ message: "Produk ditambahkan", id: result.insertId });
  });
});

// Edit produk
router.put("/:id", (req, res) => {
  const { nama, harga } = req.body;
  const sql = "UPDATE produk SET nama = ?, harga = ? WHERE id = ?";
  db.query(sql, [nama, harga, req.params.id], (err) => {
    if (err) return res.status(500).json(err);
    res.json({ message: "Produk diperbarui" });
  });
});

// Hapus produk
router.delete("/:id", (req, res) => {
  const sql = "DELETE FROM produk WHERE id = ?";
  db.query(sql, [req.params.id], (err) => {
    if (err) return res.status(500).json(err);
    res.json({ message: "Produk dihapus" });
  });
});


module.exports = router;
