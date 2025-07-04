// routes/bayarRoutes.js
const express = require("express");
const router = express.Router();
const snap = require("../services/midtrans");
const db = require("../models/db");

// POST /bayar
router.post("/", async (req, res) => {
  try {
    const { order_id, total, keranjang } = req.body;

    if (!order_id || !total || !Array.isArray(keranjang)) {
      return res.status(400).json({ message: "Data tidak valid" });
    }

    // Cek stok produk satu per satu
    for (const item of keranjang) {
      const [rows] = await db.promise().execute(
        "SELECT stok FROM produk WHERE id = ?",
        [item.id]
      );

      if (!rows || rows.length === 0) {
        return res.status(400).json({ message: `Produk dengan ID ${item.id} tidak ditemukan` });
      }

      const stokSekarang = rows[0].stok;

      if (stokSekarang < item.qty) {
        return res.status(400).json({
          message: `Stok tidak cukup untuk produk "${item.nama}". Sisa stok: ${stokSekarang}`,
        });
      }
    }

    // Jika semua stok cukup, buat token Midtrans
    const parameter = {
      transaction_details: {
        order_id,
        gross_amount: parseInt(total),
      },
      credit_card: {
        secure: true,
      },
    };

    const transaction = await snap.createTransaction(parameter);
    res.json({ token: transaction.token });

  } catch (error) {
    console.error("❌ Error Midtrans:", error);
    res.status(500).json({ message: "Terjadi kesalahan pada server", detail: error.message });
  }
});

module.exports = router;
