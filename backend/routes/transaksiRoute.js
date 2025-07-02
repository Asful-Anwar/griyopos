const express = require("express");
const router = express.Router();
const db = require("../models/db");

router.post("/", (req, res) => {
  const { order_id, total, items } = req.body;

  if (!order_id || !total || !items || items.length === 0) {
    return res.status(400).json({ error: 'Data tidak lengkap' });
  }

  // Simpan transaksi utama
  const sqlTransaksi = "INSERT INTO transaksi (id, total, created_at) VALUES (?, ?, NOW())";
  db.query(sqlTransaksi, [order_id, total], (err, result) => {
    if (err) return res.status(500).json({ error: 'Gagal menyimpan transaksi', detail: err });

    // Siapkan data detail transaksi
    const detailSql = "INSERT INTO transaksi_detail (transaksi_id, produk_id, jumlah, subtotal) VALUES ?";
    const detailValues = items.map(item => [order_id, item.id, item.jumlah, item.harga * item.jumlah]);

    db.query(detailSql, [detailValues], (err2) => {
      if (err2) return res.status(500).json({ error: 'Gagal menyimpan detail', detail: err2 });
      res.json({ message: 'Transaksi berhasil disimpan' });
    });
  });
});

router.get("/", (req, res) => {
  const sql = `
    SELECT t.id AS transaksi_id, t.total, t.created_at,
           p.nama, td.jumlah, td.subtotal
    FROM transaksi t
    JOIN transaksi_detail td ON t.id = td.transaksi_id
    JOIN produk p ON td.produk_id = p.id
    ORDER BY t.created_at DESC
  `;

  db.query(sql, (err, results) => {
    if (err) return res.status(500).json(err);

    // Kelompokkan transaksi berdasarkan transaksi_id
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
        jumlah: row.jumlah,
        subtotal: row.subtotal,
      });
    });

    res.json(Object.values(grouped));
  });
});


module.exports = router;
