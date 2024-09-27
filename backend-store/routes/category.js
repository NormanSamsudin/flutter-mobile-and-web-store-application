const express = require('express');

const Category = require('../models/category');

const categoryrRouter = express.Router();

categoryrRouter.post('/api/categories', async (req, res) => {
  try {
    const { name, image, banner } = req.body;
    const category = new Category({ name, image, banner });
    await category.save();
    res.status(201).send(category);
  } catch (err) {
    return res.status(500).json({ error: err.message });
  }
});

categoryrRouter.get('/api/categories', async (req, res) => {
  try {
    const categories = await Category.find({});
    res.status(200).send(categories);
  } catch (err) {
    res.status(500).json({ errror: err.message });
  }
});

module.exports = categoryrRouter;
