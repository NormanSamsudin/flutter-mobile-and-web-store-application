const express = require('express');

const Product = require('../models/product');

const productRouter = express.Router();

productRouter.post('/api/add-product', async (req, res) => {
  try {
    const {
      productName,
      productPrice,
      quantity,
      description,
      category,
      subCategory,
      images
    } = req.body;
    const product = new Product({
      productName,
      productPrice,
      quantity,
      description,
      category,
      subCategory,
      images
    });
    await product.save();
    res.status(201).send(product);
  } catch (err) {
    return res.status(500).json({ error: err.message });
  }
});

productRouter.get('/api/popular-products', async (req, res) => {
  try {
    const product = await Product.find({ popular: true });
    if (!product || product.length === 0) {
      return res.status(404).json({ message: 'No popular products found' });
    }
    res.status(200).json({ product });
  } catch (err) {
    res.status(500).json({ errror: err.message });
  }
});

productRouter.get('/api/recommended-products', async (req, res) => {
  try {
    const product = await Product.find({ recommended: true });
    if (!product || product.length === 0) {
      return res.status(404).json({ message: 'No recommended products found' });
    }
    res.status(200).json({ product });
  } catch (err) {
    res.status(500).json({ errror: err.message });
  }
});

module.exports = productRouter;
