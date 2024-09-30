// const express = require('express');
// const mongoose = require('mongoose');
// const cors = require('cors');
// const http = require('http');
// const { Server } = require('socket.io');
// const authRouter = require('./routes/auth');
// const categoryRouter = require('./routes/category');
// const subCategoryRouter = require('./routes/sub_category');
// const productRouter = require('./routes/product');
// const productReviewRouter = require('./routes/product_reviews');
// const vendorRouter = require('./routes/vendor');

// const bannerRouter = require('./routes/banner'); // Updated for proper io usage

// const PORT = 3000;

// const app = express();
// const server = http.createServer(app);
// const io = new Server(server, {
//   cors: {
//     origin: '*' // Enable CORS for WebSocket
//   }
// });

// const DB =
//   'mongodb://127.0.0.1:27017/store-application?directConnection=true&serverSelectionTimeoutMS=2000&appName=mongosh+2.0.0';

// app.use(express.json({ limit: '10kb' }));
// app.use(cors()); // Enable CORS for all routes and domains

// // Register routes that don't require io
// app.use(authRouter);
// app.use(categoryRouter);
// app.use(subCategoryRouter);
// app.use(productRouter);
// app.use(vendorRouter);
// app.use(productReviewRouter);

// // Mongoose DB connection
// mongoose
//   .connect(DB, {})
//   .then(() => {
//     console.log('DB Connected...');
//   })
//   .catch(err => console.log('DB LOCAL ERROR:', err));

// // WebSocket connection
// io.on('connection', socket => {
//   console.log('User connected:', socket.id);
// });

// // Register route that requires io
// app.use('/api/banner', bannerRouter(io)); // Pass io to the banner router

// // Start the server
// server.listen(PORT, function() {
//   console.log(`Server is running on port ${PORT}`);
// });

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
