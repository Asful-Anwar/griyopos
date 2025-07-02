const express = require('express');
const snap = require('../services/midtrans');
const router = express.Router();

router.post('/bayar', async (req, res) => {
  try {
    const parameter = {
      transaction_details: {
        order_id: 'ORDER-' + Date.now(),
        gross_amount: 50000,
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