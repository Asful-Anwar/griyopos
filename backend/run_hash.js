const bcrypt = require("bcrypt");

const plain = "kasir123"; // password asli

bcrypt.hash(plain, 10).then(hash => {
  console.log("Hash untuk password:", hash);
});
