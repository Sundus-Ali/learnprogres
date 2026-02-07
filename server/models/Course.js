const mongoose = require('mongoose');

const lessonSchema = new mongoose.Schema({
    title: { type: String, required: true },
    content: { type: String, required: true },
    videoUrl: { type: String },
    isCompleted: { type: Boolean, default: false } // Note: In a real app, completion should be stored per user, not in the course itself. 
    // For this simple uni project, we might just track it locally on phone or create a separate Progress model.
    // Let's keep it simple: Course defines content. Progress model tracks user completion.
});

const courseSchema = new mongoose.Schema({
    title: {
        type: String,
        required: true,
    },
    description: {
        type: String,
    },
    color: {
        type: String, // Hex string e.g., "0xFF2196F3"
        default: "0xFF2196F3",
    },
    lessons: [lessonSchema],
    teacher: {
        type: mongoose.Schema.Types.ObjectId,
        ref: 'User',
    },
}, {
    timestamps: true,
});

const Course = mongoose.model('Course', courseSchema);
module.exports = Course;
