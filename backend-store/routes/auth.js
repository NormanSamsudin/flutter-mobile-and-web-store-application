const bcrypt = require('bcrypt');
const express = require('express');
const jwt = require('jsonwebtoken');
const User = require('../models/users');

const authRouter = express.Router();

authRouter.post('/api/signup', async (req, res) => {
  try {
    const { fullName, email, password } = req.body;

    // Basic validation
    if (!fullName || !email || !password) {
      return res.status(400).json({ msg: 'Please enter all required fields' });
    }

    // Check if email already exists
    const existingEmail = await User.findOne({ email });
    if (existingEmail) {
      return res.status(400).json({ msg: 'Email already exists' });
    }

    // Hash the password
    const salt = await bcrypt.genSalt(10);
    const hashedPassword = await bcrypt.hash(password, salt);

    // Create new user
    const user = new User({
      fullName,
      email,
      password: hashedPassword
    });

    // Save user to database
    const savedUser = await user.save();
    res.status(201).json({ savedUser });
  } catch (err) {
    return res.status(500).json({ error: err.message });
  }
});

authRouter.post('/api/signin', async (req, res) => {
  try {
    const { email, password } = req.body;
    const findUser = await User.findOne({ email });
    if (!findUser) {
      return res.status(400).json({ msg: 'User not found with this email' });
    }
    const isMatch = await bcrypt.compare(password, findUser.password);
    if (!isMatch) {
      return res.status(400).json({ msg: 'Invalid password' });
    }
    // Generate and send JWT token
    const token = jwt.sign({ id: findUser._id }, 'passwordKey');

    res.json({ token, user: findUser });
  } catch (err) {
    return res.status(500).json({ error: err.message });
  }
});

module.exports = authRouter;
