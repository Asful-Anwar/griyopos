const express = require("express");
const router = express.Router();
const db = require("../models/db");

router.post("/", (req, res) => {
  const { total, items } = req.body;

  if (!items || items.length === 0) {
    return res.status(400).json({ message: "Keranjang kosong" });
  }

  const sqlInsert = "INSERT INTO transaksi (total, created_at) VALUES (?, NOW())";

  db.query(sqlInsert, [total], (err, result) => {
    if (err) return res.status(500).json(err);

    const transaksiId = result.insertId;

    const detailInsert = "INSERT INTO transaksi_detail (transaksi_id, produk_id, jumlah) VALUES ?";
    const values = items.map(item => [transaksiId, item.id, item.jumlah]);

    db.query(detailInsert, [values], (err2) => {
      if (err2) return res.status(500).json(err2);

      res.json({ message: "Transaksi berhasil", transaksi_id: transaksiId });
    });
  });
});

router.get("/", (req, res) => {
  const sql = `
    SELECT t.id AS transaksi_id, t.total, t.created_at,
           p.nama, p.harga, td.jumlah
    FROM transaksi t
    JOIN transaksi_detail td ON t.id = td.transaksi_id
    JOIN produk p ON td.produk_id = p.id
    ORDER BY t.created_at DESC
  `;

  db.query(sql, (err, results) => {
    if (err) return res.status(500).json(err);

    // Gabungkan detail transaksi berdasarkan transaksi_id
    const grouped = {};
    results.forEach(row => {
      if (!grouped[row.transaksi_id]) {
        grouped[row.transaksi_id] = {
          transaksi_id: row.transaksi_id,
          total: row.total,
          created_at: row.created_at,
          items: [],
        };
      }
      grouped[row.transaksi_id].items.push({
        nama: row.nama,
        harga: row.harga,
        jumlah: row.jumlah,
      });
    });

    res.json(Object.values(grouped));
  });
});

module.exports = router;
