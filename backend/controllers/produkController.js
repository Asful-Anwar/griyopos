const db = require("../models/db");

exports.getAllProduk = (req, res) => {
  const sql = "SELECT * FROM produk";
  db.query(sql, (err, results) => {
    if (err) return res.status(500).send(err);
    res.json(results);
  });
};
