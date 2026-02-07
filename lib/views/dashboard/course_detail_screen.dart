import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../models/course_model.dart';
import 'lesson_reading_screen.dart';
import 'package:google_fonts/google_fonts.dart';

class CourseDetailScreen extends StatelessWidget {
  final Course course;

  const CourseDetailScreen({super.key, required this.course});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),
      appBar: AppBar(
        title: Text('Course Details', style: GoogleFonts.montserrat(color: Colors.black, fontWeight: FontWeight.bold)),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Course Header Info
            Container(
              padding: const EdgeInsets.all(24),
              color: Colors.white,
              width: double.infinity,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    course.title,
                    style: GoogleFonts.montserrat(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),
                  Text('Instructor: ${course.instructor}', style: const TextStyle(color: Colors.grey)),
                  const SizedBox(height: 16),
                  Text(
                    course.description,
                    style: const TextStyle(height: 1.5, fontSize: 16),
                  ),
                ],
              ),
            ),
            
            const SizedBox(height: 16),
            
            // Lessons List
            ListView.separated(
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: course.lessons.length,
              separatorBuilder: (context, index) => const Divider(height: 1),
              itemBuilder: (context, index) {
                final lesson = course.lessons[index];
                return ListTile(
                  tileColor: Colors.white,
                  contentPadding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                  leading: CircleAvatar(
                    backgroundColor: lesson.isCompleted ? Colors.green[100] : Colors.blue[50],
                    child: Icon(
                      lesson.isCompleted ? Icons.check : Icons.library_books,
                      color: lesson.isCompleted ? Colors.green : Colors.blue,
                    ),
                  ),
                  title: Text(
                    lesson.title,
                    style: const TextStyle(fontWeight: FontWeight.w600),
                  ),
                  subtitle: Text(lesson.duration),
                  trailing: const Icon(Icons.arrow_forward_ios, size: 16, color: Colors.grey),
                  onTap: () {
                    Get.to(() => LessonReadingScreen(course: course, lesson: lesson));
                  },
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
