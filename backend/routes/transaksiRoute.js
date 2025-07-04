const express = require("express");
const router = express.Router();
const db = require("../models/db");

// Simpan transaksi
router.post("/simpan", async (req, res) => {
  const conn = db.promise();
  const { order_id, total, keranjang, metode_pembayaran } = req.body;

  const connection = await conn.getConnection(); // gunakan connection pool
  await connection.beginTransaction();

  try {
    // Validasi stok
    for (const item of keranjang) {
      const [rows] = await connection.query(
        "SELECT stok FROM produk WHERE id = ?",
        [item.id]
      );
      const stokSekarang = rows[0]?.stok ?? 0;

      if (stokSekarang < item.qty) {
        throw new Error(`Stok tidak cukup untuk produk ${item.nama}`);
      }
    }

    // Simpan transaksi
    const [result] = await connection.query(
      `INSERT INTO transaksi (order_id, total, metode_pembayaran, created_at)
       VALUES (?, ?, ?, NOW())`,
      [order_id, total, metode_pembayaran]
    );

    const transaksiId = result.insertId;

    for (const item of keranjang) {
      // Simpan detail transaksi
      await connection.query(
        `INSERT INTO transaksi_detail (transaksi_id, produk_id, harga, qty)
         VALUES (?, ?, ?, ?)`,
        [transaksiId, item.id, item.harga, item.qty ?? 1]
      );

      // Kurangi stok produk
      await connection.query(
        `UPDATE produk SET stok = stok - ? WHERE id = ?`,
        [item.qty ?? 1, item.id]
      );
    }

    await connection.commit();
    connection.release();
    res.json({ message: "Transaksi berhasil disimpan" });
  } catch (error) {
    await connection.rollback();
    connection.release();
    console.error("❌ Error simpan transaksi:", error.message);
    res.status(400).json({ error: error.message });
  }
});

// Ambil riwayat transaksi
router.get("/", async (req, res) => {
  try {
    const [results] = await db.promise().execute(`
      SELECT 
        t.id as transaksi_id,
        t.order_id,
        t.total,
        t.metode_pembayaran,
        t.created_at,
        p.nama as nama_produk,
        td.harga,
        td.qty
      FROM transaksi t
      JOIN transaksi_detail td ON t.id = td.transaksi_id
      JOIN produk p ON td.produk_id = p.id
      ORDER BY t.created_at DESC
    `);

    const grouped = {};
    for (const row of results) {
      if (!grouped[row.transaksi_id]) {
        grouped[row.transaksi_id] = {
          transaksi_id: row.transaksi_id,
          order_id: row.order_id,
          total: row.total,
          metode_pembayaran: row.metode_pembayaran,
          created_at: row.created_at,
          items: [],
        };
      }
      grouped[row.transaksi_id].items.push({
        nama_produk: row.nama_produk,
        harga: row.harga,
        qty: row.qty,
      });
    }

    res.json(Object.values(grouped));
  } catch (error) {
    console.error("❌ Error ambil riwayat transaksi:", error);
    res.status(500).json({ error: "Gagal ambil riwayat transaksi" });
  }
});

module.exports = router;
