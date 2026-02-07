const mongoose = require('mongoose');
const dotenv = require('dotenv');
const connectDB = require('./config/db');
const Course = require('./models/Course');
const User = require('./models/User');

dotenv.config();
connectDB();

const importData = async () => {
    try {
        await Course.deleteMany();
        await User.deleteMany();

        // 50 REAL COURSES GENERATION LOGIC
        // We will generate courses across 5 categories with RICH TEXT content.

        const contentTemplate = `
## Introduction
This lesson covers the fundamental concepts you need to know. We will explore the theoretical background and practical applications.

### Key Concepts
1. **Understanding the Basics**: Why this topic matters.
2. **Core Principles**: The building blocks of the subject.
3. **Advanced Techniques**: Moving beyond simple examples.

## Detailed Explanation
In this section, we dive deep into the mechanics. Understanding how the underlying system works is crucial for mastery. 

> "Learning is not attained by chance, it must be sought for with ardor and attended to with diligence." - Abigail Adams

### Summary
To recap, we have covered the essential definitions and frameworks. Please review the material before proceeding to the next lesson.
        `;

        // Create Default User
        const user = await User.create({
            name: 'Student User',
            email: 'student@school.edu',
            password: 'password123', // Will be hashed automatically
            role: 'student'
        });

        console.log('✅ Default User Created: student@school.edu / password123');

        const categories = ['Computer Science', 'Data Analysis', 'Web Development', 'Mobile App Dev', 'Cyber Security'];
        const courses = [];

        for (let i = 1; i <= 50; i++) {
            const category = categories[i % categories.length];
            const courseLessons = [];

            // Add 5-10 lessons per course
            const lessonCount = 5 + (i % 5);
            for (let j = 1; j <= lessonCount; j++) {
                courseLessons.push({
                    title: `Lesson ${j}: Fundamentals of ${category}`,
                    content: contentTemplate,
                    duration: `${10 + j} min read`,
                    isCompleted: false,
                });
            }

            // Sawirada koorsooyinka (Real Unsplash Images)
            const imageMap = {
                'Computer Science': 'https://images.unsplash.com/photo-1517694712202-14dd9538aa97?w=600&q=80',
                'Data Analysis': 'https://images.unsplash.com/photo-1551288049-bebda4e38f71?w=600&q=80',
                'Web Development': 'https://images.unsplash.com/photo-1498050108023-c5249f4df085?w=600&q=80',
                'Mobile App Dev': 'https://images.unsplash.com/photo-1512941937669-90a1b58e7e9c?w=600&q=80',
                'Cyber Security': 'https://images.unsplash.com/photo-1550751827-4bd374c3f58b?w=600&q=80'
            };

            courses.push({
                title: `${category} Level ${Math.floor(i / 5) + 1} - Master Class`,
                description: `A comprehensive guide to mastering ${category}. Updated for 2026 curriculum. (Halkan waxaad ku baranaysaa xirfado sare oo ${category} ah)`,
                image: imageMap[category] || 'https://images.unsplash.com/photo-1516321318423-f06f85e504b3?w=600&q=80',
                instructor: `Prof. Alex Johnson`,
                progress: 0,
                lessons: courseLessons,
            });
        }

        await Course.insertMany(courses);
        console.log('✅ Data Imported Success! (50 Courses with Text Content)');
        process.exit();
    } catch (error) {
        console.error(`Error: ${error}`);
        process.exit(1);
    }
};

importData();
