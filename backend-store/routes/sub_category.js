const express = require('express');
const SubCategory = require('../models/sub_category');

const categoryrRouter = express.Router();

categoryrRouter.post('/api/subcategories', async (req, res) => {
  try {
    const { categoryId, categoryName, image, subCategoryName } = req.body;
    const subCategory = new SubCategory({
      categoryId,
      categoryName,
      image,
      subCategoryName
    });
    await subCategory.save();
    res.status(201).send(subCategory);
  } catch (err) {
    return res.status(500).json({ error: err.message });
  }
});

categoryrRouter.get(
  '/api/category/:categoryName/subcategories',
  async (req, res) => {
    try {
      const { categoryName } = req.params;
      const subcategories = await SubCategory.find({
        categoryName
      });
      if (!subcategories || subcategories.length === 0) {
        return res.status(404).json({ message: 'No subcategories found' });
      }
      res.status(200).json(subcategories);
    } catch (err) {
      res.status(500).json({ errror: err.message });
    }
  }
);

module.exports = categoryrRouter;
