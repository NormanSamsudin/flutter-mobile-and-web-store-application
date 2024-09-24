const express = require('express');

const helloRoute = express.Router();

helloRoute.get('/', (req, res) => {
  res.send('Hello, World!');
});

module.exports = helloRoute;
