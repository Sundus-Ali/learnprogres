const mongoose = require('mongoose');

// Lesson Schema (Structure for individual lessons)
// Updated for TEXT BASED content (No Video)
const lessonSchema = mongoose.Schema({
    title: { type: String, required: true },
    content: { type: String, required: true }, // Long form text content
    duration: { type: String, default: "10 min read" },
    isCompleted: { type: Boolean, default: false }, // Simple boolean for progress tracking
});

// Course Schema (Structure for Courses)
const courseSchema = mongoose.Schema({
    title: { type: String, required: true },
    description: { type: String, required: true },
    image: { type: String, required: true }, // URL to image
    instructor: { type: String, required: true },
    progress: { type: Number, default: 0 }, // Overall percentage (Calculated)
    lessons: [lessonSchema], // Array of lessons
}, {
    timestamps: true,
});

const Course = mongoose.model('Course', courseSchema);

module.exports = Course;
