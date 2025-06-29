const express = require("express");
const router = express.Router();
const snap = require("../services/midtrans");

router.post("/", async (req, res) => {
  const { order_id, total } = req.body;

  try {
    let parameter = {
      transaction_details: {
        order_id: order_id,
        gross_amount: total,
      }
    };

    const transaction = await snap.createTransaction(parameter);
    res.json({ token: transaction.token });
  } catch (err) {
    console.error("MIDTRANS ERROR:", err);
    res.status(500).json({ message: "Gagal membuat transaksi Midtrans" });
  }
});

module.exports = router;
