const express = require('express');
const mongoose = require('mongoose');
const cors = require('cors');
const authRouter = require('./routes/auth');
const bannerRouter = require('./routes/banner');
const categoryRouter = require('./routes/category');
const subCategoryRouter = require('./routes/sub_category');
const productRouter = require('./routes/product');
const productReviewRouter = require('./routes/product_reviews');
const vendorRouter = require('./routes/vendor');

const PORT = 3000;

const app = express();

const DB =
  'mongodb://127.0.0.1:27017/store-application?directConnection=true&serverSelectionTimeoutMS=2000&appName=mongosh+2.0.0';

app.use(express.json({ limit: '10kb' }));
app.use(cors()); //enable CORS for all route and domain

//middleware to register route
app.use(authRouter);
app.use(bannerRouter);
app.use(categoryRouter);
app.use(subCategoryRouter);
app.use(productRouter);
app.use(vendorRouter);
app.use(productReviewRouter);

mongoose
  .connect(DB, {})
  .then(() => {
    console.log('DB Connected...');
  })
  .catch(err => console.log('DB LOCAL ERROR:', err));

app.listen(PORT, function() {
  console.log(`Server is running on port ${PORT}`);
});
