const express = require('express');
const router = express.Router();
const {
    getCourses,
    getCourseById,
    updateLessonProgress,
} = require('../controllers/courseController');

router.get('/', getCourses);
router.get('/:id', getCourseById);
router.put('/:id/lessons/:lessonId', updateLessonProgress);

module.exports = router;
