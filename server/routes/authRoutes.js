const express = require('express');
const router = express.Router();
const { authUser, registerUser, getUsers } = require('../controllers/authController');

router.post('/register', registerUser);
router.post('/login', authUser);
router.get('/users', getUsers); // Should be protected in real app

module.exports = router;
