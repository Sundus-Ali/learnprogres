// server.js - Gelitaanka ugu weyn ee Server-ka (Main Entry Point)
const express = require('express');
const cors = require('cors');
const dotenv = require('dotenv');
const connectDB = require('./config/db');
const authRoutes = require('./routes/authRoutes');
const courseRoutes = require('./routes/courseRoutes');

dotenv.config();

// Isku xirka Database-ka (Connect DB)
connectDB();

const app = express();

// Middleware-ka (Dhexdhexaadiye)
app.use(cors()); // Ogolaanshaha Cross-Origin
app.use(express.json()); // U rogo JSON xogta soo socota

// Request Logger
app.use((req, res, next) => {
    console.log(`[${new Date().toISOString()}] ${req.method} ${req.originalUrl}`);
    next();
});

// JSON Error Handler (Fixes the HTML response issue)
app.use((err, req, res, next) => {
    const statusCode = res.statusCode === 200 ? 500 : res.statusCode;
    res.status(statusCode);
    res.json({
        message: err.message,
        stack: process.env.NODE_ENV === 'production' ? null : err.stack,
    });
});

// API Routes
app.use('/api/auth', authRoutes);
app.use('/api/courses', courseRoutes);

// Base Route
app.get('/', (req, res) => {
    res.send('LearnProgress API is running...');
});

const PORT = process.env.PORT || 5000;

app.listen(PORT, () => {
    console.log(`Server running in ${process.env.NODE_ENV} mode on port ${PORT}`);
});
