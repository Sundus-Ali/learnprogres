const asyncHandler = require('express-async-handler');
const User = require('../models/User');
const generateToken = require('../utils/jwt');

// @desc    Authenticate a user (Xaqiiji isticmaalaha - Login)
// @route   POST /api/auth/login
// @access  Public
const loginUser = asyncHandler(async (req, res) => {
    const { email, password } = req.body;

    // Soo hel isticmaalaha (Find user)
    const user = await User.findOne({ email });

    // Hubi password-ka (Check password)
    if (user && (await user.matchPassword(password))) {
        res.json({
            _id: user._id,
            name: user.name,
            email: user.email,
            token: generateToken(user._id), // Soo saar JWT Token
        });
    } else {
        res.status(401);
        throw new Error('Invalid email or password (Email ama Password qaldan)');
    }
});

// @desc    Register new user (Diiwaangeli isticmaale cusub)
// @route   POST /api/auth/register
// @access  Public
const registerUser = asyncHandler(async (req, res) => {
    const { name, email, password } = req.body;

    // Hubi haddii isticmaaluhu jiro (Check if user exists)
    const userExists = await User.findOne({ email });

    if (userExists) {
        res.status(400);
        throw new Error('User already exists (Isticmaalahan horey ayuu u jiraa)');
    }

    // Abuur isticmaale cusub (Create user)
    const user = await User.create({
        name,
        email,
        password, // Password-ka waxaa hash gareynaya Mongoose middleware
    });

    if (user) {
        // Haddii guul la gaaro, soo celi xogta iyo Token-ka
        res.status(201).json({
            _id: user._id,
            name: user.name,
            email: user.email,
            token: generateToken(user._id),
        });
    } else {
        res.status(400);
        throw new Error('Invalid user data (Xogta isticmaalaha ma saxna)');
    }
});

module.exports = { loginUser, registerUser };
