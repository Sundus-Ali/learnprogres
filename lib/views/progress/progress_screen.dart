import 'package:flutter/material.dart';
import 'package:learnprogres/core/theme.dart';

class ProgressScreen extends StatelessWidget {
  const ProgressScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.white,
      appBar: AppBar(
        title: const Text('My Progress'),
        backgroundColor: AppTheme.charcoalBlue,
        automaticallyImplyLeading: false,
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          children: [
            // Overall Progress Card
            Container(
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                color: AppTheme.charcoalBlue,
                borderRadius: BorderRadius.circular(16),
              ),
              child: Column(
                children: [
                  const Text(
                    'Overall Progress',
                    style: TextStyle(color: AppTheme.white, fontSize: 18),
                  ),
                  const SizedBox(height: 16),
                  Stack(
                    alignment: Alignment.center,
                    children: [
                      SizedBox(
                        width: 120,
                        height: 120,
                        child: CircularProgressIndicator(
                          value: 0.65, // Mock data
                          strokeWidth: 10,
                          backgroundColor: Colors.white24,
                          color: AppTheme.dustyDenim,
                        ),
                      ),
                      const Text(
                        '65%',
                        style: TextStyle(
                          color: AppTheme.white,
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  const Text(
                    'Keep it up! You are doing great.',
                    style: TextStyle(color: Colors.white70),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 32),
            
            // Statistics List
            Expanded(
              child: ListView(
                children: const [
                  ListTile(
                    leading: Icon(Icons.check_circle, color: AppTheme.dustyDenim),
                    title: Text('Courses Completed'),
                    trailing: Text('2', style: TextStyle(fontWeight: FontWeight.bold)),
                  ),
                  Divider(),
                  ListTile(
                    leading: Icon(Icons.play_lesson, color: AppTheme.dustyDenim),
                    title: Text('Lessons Watched'),
                    trailing: Text('14', style: TextStyle(fontWeight: FontWeight.bold)),
                  ),
                  Divider(),
                  ListTile(
                    leading: Icon(Icons.quiz, color: AppTheme.dustyDenim),
                    title: Text('Quizzes Taken'),
                    trailing: Text('5', style: TextStyle(fontWeight: FontWeight.bold)),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
