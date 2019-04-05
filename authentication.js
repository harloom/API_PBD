
const express = require('express');
const router = express.Router();

router.post('/', (req, res) => {
  // res.send('POST request to Authentication')
  res.send("login");
});

module.exports = router;