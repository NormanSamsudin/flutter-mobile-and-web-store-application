const express = require('express');
const bcrypt = require('bcrypt');
const jwt = require('jsonwebtoken');
const Vendor = require('../models/vendor');

const vendorRouter = express.Router();

vendorRouter.post('/api/vendor/signup', async (req, res) => {
  try {
    const { fullName, email, password } = req.body;

    // Basic validation
    if (!fullName || !email || !password) {
      return res.status(400).json({ msg: 'Please enter all required fields' });
    }

    // Check if email already exists
    const existingEmail = await Vendor.findOne({ email });
    if (existingEmail) {
      return res.status(400).json({ msg: 'Vendor email already exists' });
    }

    // Hash the password
    const salt = await bcrypt.genSalt(10);
    const hashedPassword = await bcrypt.hash(password, salt);

    // Create new user
    const vendor = new Vendor({
      fullName,
      email,
      password: hashedPassword
    });

    // Save user to database
    const savedVendor = await vendor.save();
    res.status(201).json({ savedVendor });
  } catch (err) {
    return res.status(500).json({ error: err.message });
  }
});

vendorRouter.post('/api/vendor/signin', async (req, res) => {
  try {
    const { email, password } = req.body;
    const findVendor = await Vendor.findOne({ email });
    if (!findVendor) {
      return res.status(400).json({ msg: 'User not found with this email' });
    }
    const isMatch = await bcrypt.compare(password, findVendor.password);
    if (!isMatch) {
      return res.status(400).json({ msg: 'Invalid password' });
    }
    // Generate and send JWT token
    const token = jwt.sign({ id: findVendor._id }, 'passwordKey');

    res.json({ token, vendor: findVendor });
  } catch (err) {
    return res.status(500).json({ error: err.message });
  }
});

module.exports = vendorRouter;
