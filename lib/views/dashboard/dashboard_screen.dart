import 'package:flutter/material.dart';
import 'package:learnprogres/core/theme.dart';
import 'package:learnprogres/views/dashboard/lesson_screen.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Xogta koorsooyinka (Mock Data)
    final List<Map<String, dynamic>> courses = [
      {'title': 'Introduction to Flutter', 'progress': 0.75, 'color': Colors.blue},
      {'title': 'Dart Programming', 'progress': 0.40, 'color': Colors.orange},
      {'title': 'State Management', 'progress': 0.10, 'color': Colors.purple},
      {'title': 'Backend Integration', 'progress': 0.0, 'color': Colors.green},
    ];

    return Scaffold(
      backgroundColor: AppTheme.white,
      appBar: AppBar(
        title: const Text('My Courses'),
        backgroundColor: AppTheme.charcoalBlue,
        automaticallyImplyLeading: false, // Hide back button
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: courses.length,
        itemBuilder: (context, index) {
          final course = courses[index];
          return Card(
            margin: const EdgeInsets.only(bottom: 16),
            elevation: 2,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            child: ListTile(
              contentPadding: const EdgeInsets.all(16),
              leading: Container(
                width: 50,
                height: 50,
                decoration: BoxDecoration(
                  color: (course['color'] as Color).withOpacity(0.2),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Icon(Icons.book, color: course['color']),
              ),
              title: Text(
                course['title'],
                style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              ),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 8),
                  LinearProgressIndicator(
                    value: course['progress'],
                    backgroundColor: Colors.grey[200],
                    color: AppTheme.dustyDenim,
                    minHeight: 6,
                    borderRadius: BorderRadius.circular(3),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    '${(course['progress'] * 100).toInt()}% Completed',
                    style: const TextStyle(fontSize: 12, color: Colors.grey),
                  ),
                ],
              ),
              trailing: const Icon(Icons.arrow_forward_ios, size: 16, color: Colors.grey),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => LessonScreen(title: course['title']),
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}
