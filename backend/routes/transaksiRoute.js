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

module.exports = router;
