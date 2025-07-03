const express = require("express");
const router = express.Router();
const db = require("../models/db");

// Simpan transaksi
router.post("/simpan", async (req, res) => {
  try {
    const { order_id, total, keranjang, metode_pembayaran } = req.body;

    // Simpan transaksi ke tabel transaksi
    const [result] = await db.promise().execute(
      `INSERT INTO transaksi (order_id, total, metode_pembayaran, created_at)
       VALUES (?, ?, ?, NOW())`,
      [order_id, total, metode_pembayaran]
    );

    const transaksiId = result.insertId;

    // Simpan detail produk
    for (const item of keranjang) {
      await db.promise().execute(
        `INSERT INTO transaksi_detail (transaksi_id, produk_id,  harga, qty)
         VALUES (?, ?, ?, ?)`,
        [transaksiId, item.id, item.harga, item.qty ?? 1]
      );
    }

    res.json({ message: "Transaksi berhasil disimpan" });
  } catch (error) {
    console.error("❌ Error simpan transaksi:", error);
    res.status(500).json({ error: "Gagal menyimpan transaksi" });
  }
});

module.exports = router;
