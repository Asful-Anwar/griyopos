const express = require("express");
const cors = require("cors");
const dotenv = require("dotenv");
const produkRoutes = require("./routes/produkRoute");
const transaksiRoutes = require("./routes/transaksiRoute");
const bayarRoute = require("./routes/bayarRoutes");
const authRoutes = require('./routes/authRoutes');

require('dotenv').config();
// console.log("🔍 ENV CHECK:", process.env.MIDTRANS_SERVER_KEY);
const app = express();

app.use(cors());
app.use(express.json());

app.use("/produk", produkRoutes);
app.use("/transaksi", transaksiRoutes);
app.use("/bayar", bayarRoute);
app.use("/auth", authRoutes);

const PORT = process.env.PORT || 5000;
app.listen(PORT, () => {
  console.log(`🚀 Server running on port ${PORT}`);
});
