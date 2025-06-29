const express = require("express");
const cors = require("cors");
const dotenv = require("dotenv");
const produkRoutes = require("./routes/produkRoute");

dotenv.config();
const app = express();

app.use(cors());
app.use(express.json());

app.use("/produk", produkRoutes);

const PORT = process.env.PORT || 5000;
app.listen(PORT, () => {
  console.log(`🚀 Server running on port ${PORT}`);
});
