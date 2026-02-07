import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_markdown/flutter_markdown.dart'; // Using markdown for rich-text like feel, or standard Text
import '../../models/course_model.dart';
import '../../controllers/course_controller.dart';
import '../../core/app_colors.dart';
import 'package:google_fonts/google_fonts.dart';

class LessonReadingScreen extends StatelessWidget {
  final Course course;
  final Lesson lesson;
  final CourseController courseController = Get.find<CourseController>();

  LessonReadingScreen({super.key, required this.course, required this.lesson});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text('Reading Lesson', style: GoogleFonts.montserrat(color: Colors.black)),
        backgroundColor: Colors.white,
        elevation: 1,
        foregroundColor: Colors.black,
      ),
      body: Column(
        children: [
          // ProgressBar
          LinearProgressIndicator(
            value: 0.5, // Dummy scroll progress or static
            backgroundColor: Colors.grey[200],
            color: AppColors.primary,
            minHeight: 4,
          ),
          
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    lesson.title,
                    style: GoogleFonts.merriweather(
                      fontSize: 26,
                      fontWeight: FontWeight.bold,
                      height: 1.3,
                    ),
                  ),
                  const SizedBox(height: 12),
                  Row(
                    children: [
                      const Icon(Icons.access_time, size: 16, color: Colors.grey),
                      const SizedBox(width: 8),
                      Text(lesson.duration, style: const TextStyle(color: Colors.grey)),
                    ],
                  ),
                  const SizedBox(height: 32),
                  
                  // Text Content
                  // We simulate proper formatting using Markdown or styled Text
                  MarkdownBody(
                    data: lesson.content,
                    styleSheet: MarkdownStyleSheet(
                      h1: GoogleFonts.merriweather(fontSize: 22, fontWeight: FontWeight.bold),
                      h2: GoogleFonts.merriweather(fontSize: 20, fontWeight: FontWeight.bold, height: 2),
                      p: GoogleFonts.merriweather(fontSize: 16, height: 1.8, color: Colors.black87),
                      blockquote: TextStyle(color: Colors.grey[700], fontStyle: FontStyle.italic),
                    ),
                  ),
                  
                  const SizedBox(height: 60),

                  // Completion Button
                  SizedBox(
                    width: double.infinity,
                    height: 56,
                    child: ElevatedButton.icon(
                      onPressed: () {
                        // Toggle Completion
                        // Current status might be outdated in 'lesson' object if not refreshed, but typically OK
                        // We assume we want to MARK as DONE if not done.
                        bool newStatus = !lesson.isCompleted;
                        courseController.toggleLessonCompletion(course.id, lesson.id, newStatus);
                        Get.back(); // Go back to course list
                        Get.snackbar(
                          'Success', 
                          newStatus ? 'Lesson Completed!' : 'Marked as Incomplete',
                          backgroundColor: AppColors.secondary,
                          colorText: Colors.white,
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.secondary,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                      ),
                      icon: const Icon(Icons.check_circle_outline, color: Colors.white),
                      label: const Text(
                        'Mark as Completed',
                        style: TextStyle(fontSize: 18, color: Colors.white, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
