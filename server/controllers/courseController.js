const asyncHandler = require('express-async-handler');
const Course = require('../models/Course');

// @desc    Get all courses
// @route   GET /api/courses
// @access  Public (or Private)
const getCourses = asyncHandler(async (req, res) => {
    const courses = await Course.find({});
    res.json(courses);
});

// @desc    Create a course
// @route   POST /api/courses
// @access  Teacher/Admin
const createCourse = asyncHandler(async (req, res) => {
    const { title, description, color } = req.body;

    const course = new Course({
        title,
        description,
        color,
        // teacher: req.user._id, // If we had middleware to get user
    });

    const createdCourse = await course.save();
    res.status(201).json(createdCourse);
});

module.exports = { getCourses, createCourse };
