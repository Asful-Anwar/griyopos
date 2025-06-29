const express = require("express");
const router = express.Router();
const { getAllProduk } = require("../controllers/produkController");

router.get("/", getAllProduk);


module.exports = router;
