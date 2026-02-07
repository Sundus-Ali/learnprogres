const asyncHandler = require('express-async-handler');
const Course = require('../models/Course');

// @desc    Fetch all courses
// @route   GET /api/courses
// @access  Public
const getCourses = asyncHandler(async (req, res) => {
    console.log('GET /api/courses called');
    // Soo qaad dhamaan koorsooyinka (Fetch all courses)
    const courses = await Course.find({});
    res.json(courses);
});

// @desc    Get single course (Soo hel hal koorso)
// @route   GET /api/courses/:id
// @access  Private
const getCourseById = asyncHandler(async (req, res) => {
    const course = await Course.findById(req.params.id);

    if (course) {
        res.json(course);
    } else {
        res.status(404);
        throw new Error('Course not found (Koorso lama helin)');
    }
});

// @desc    Update lesson progress (Cusbooneysii horumarka casharka)
// @route   PUT /api/courses/:id/lesson
// @access  Private
const updateLessonProgress = asyncHandler(async (req, res) => {
    const { lessonId, isCompleted } = req.body;
    const course = await Course.findById(req.params.id);

    if (course) {
        // Find the lesson inside the course (Ka dhex hel casharka koorsada)
        const lesson = course.lessons.id(lessonId);
        if (lesson) {
            lesson.isCompleted = isCompleted;

            // Xisaabi horumarka guud (Calculate Overall Progress)
            const completedCount = course.lessons.filter(l => l.isCompleted).length;
            const totalCount = course.lessons.length;

            // Haddii casharada oo dhan ebar yihiin waa 0, haddii kale boqolkiiba xisaabi
            course.progress = totalCount === 0 ? 0 : Math.round((completedCount / totalCount) * 100);

            await course.save(); // Keydi isbedelka (Save changes)
            res.json(course);
        } else {
            res.status(404);
            throw new Error('Lesson not found');
        }
    } else {
        res.status(404);
        throw new Error('Course not found');
    }
});

module.exports = {
    getCourses,
    getCourseById,
    updateLessonProgress,
};
