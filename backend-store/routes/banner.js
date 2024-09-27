const express = require('express');
const Banner = require('../models/banner');

const bannerRouter = io => {
  const router = express.Router();

  router.post('/', async (req, res) => {
    try {
      const { image } = req.body;
      const banner = new Banner({ image });
      await banner.save();

      // Emit the new banner event through WebSocket
      io.emit('newBanner', banner);

      return res.status(201).send(banner);
    } catch (err) {
      res.status(400).json({ error: err.message });
    }
  });

  router.get('/', async (req, res) => {
    try {
      const banners = await Banner.find({});
      return res.status(200).send(banners);
    } catch (err) {
      res.status(500).json({ error: err.message });
    }
  });

  return router;
};

module.exports = bannerRouter;

// const express = require('express');
// const Banner = require('../models/banner');

// const bannerRouter = express.Router();

// bannerRouter.post('/api/banner', async (req, res) => {
//   try {
//     const { image } = req.body;
//     const banner = new Banner({ image });
//     await banner.save();
//     return res.status(201).send(banner);
//   } catch (err) {
//     res.status(400).json({ error: err.message });
//   }
// });

// bannerRouter.get('/api/banner', async (req, res) => {
//   try {
//     const banners = await Banner.find({});
//     return res.status(200).send(banners);
//   } catch (err) {
//     res.status(500).json({ error: err.message });
//   }
// });

// module.exports = bannerRouter;
