const express = require("express");
const router = express.Router();
const db = require("../models/db");

// ✅ Endpoint Simpan Transaksi
router.post('/simpan', (req, res) => {
  const { order_id, total, keranjang, metode_pembayaran } = req.body;

  if (!order_id || !total || !Array.isArray(keranjang) || keranjang.length === 0) {
    return res.status(400).json({ error: "Data tidak lengkap" });
  }

  const insertTransaksiSQL = `
    INSERT INTO transaksi (order_id, total, metode_pembayaran)
    VALUES (?, ?, ?)
  `;

  db.query(insertTransaksiSQL, [order_id, total, metode_pembayaran], (err, result) => {
    if (err) {
      console.error("❌ Error simpan transaksi:", err);
      return res.status(500).json({ error: "Gagal menyimpan transaksi" });
    }

    const transaksiId = result.insertId;

    // ✅ Simpan detail transaksi (tanpa nama_produk karena kolom tidak ada)
    const detailSQL = `
      INSERT INTO transaksi_detail (transaksi_id, produk_id, harga, qty)
      VALUES ?
    `;

    const detailValues = keranjang.map(item => [
      transaksiId,
      item.id,
      item.harga,
      item.qty ?? 1
    ]);

    db.query(detailSQL, [detailValues], (err2) => {
      if (err2) {
        console.error("❌ Error simpan detail:", err2);
        return res.status(500).json({ error: "Gagal simpan detail transaksi" });
      }

      res.json({ message: "✅ Transaksi berhasil disimpan" });
    });
  });
});


// ✅ Endpoint GET Riwayat Transaksi
router.get("/", (req, res) => {
  const sql = `
    SELECT t.id AS transaksi_id, t.total, t.created_at,
           td.produk_id, td.qty, td.harga
    FROM transaksi t
    JOIN transaksi_detail td ON t.id = td.transaksi_id
    ORDER BY t.created_at DESC
  `;

  db.query(sql, (err, results) => {
    if (err) {
      console.error("❌ Error ambil riwayat transaksi:", err);
      return res.status(500).json(err);
    }

    // Kelompokkan hasil per transaksi
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
        produk_id: row.produk_id,
        qty: row.qty,
        harga: row.harga,
        subtotal: row.qty * row.harga
      });
    });

    res.json(Object.values(grouped));
  });
});

module.exports = router;
