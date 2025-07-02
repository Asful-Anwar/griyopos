const express = require('express');
const snap = require('../services/midtrans');
const router = express.Router();

router.post('/', async (req, res) => {
  try {
    const { order_id, total } = req.body;

    if (!order_id || !total || isNaN(total) || total <= 0) {
      return res.status(400).json({ error: 'order_id dan total harus diisi dengan angka > 0' });
    }

    const parameter = {
      transaction_details: {
        order_id: order_id,
        gross_amount: parseInt(total),
      },
    };

    const transaction = await snap.createTransaction(parameter);
    res.json({ token: transaction.token });
  } catch (error) {
    console.error('MIDTRANS ERROR:', error);
    res.status(500).json({ error: 'Midtrans error', detail: error.message });
  }
});


module.exports = router;
