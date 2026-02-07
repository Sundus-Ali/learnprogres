import 'package:learnprogres/core/theme.dart';

class LessonScreen extends StatefulWidget {
  final String title;
  const LessonScreen({super.key, required this.title});

  @override
  State<LessonScreen> createState() => _LessonScreenState();
}

class _LessonScreenState extends State<LessonScreen> {
  bool _isCompleted = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.white,
      appBar: AppBar(
        title: Text(widget.title),
        backgroundColor: AppTheme.charcoalBlue,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: AppTheme.white),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Video Placeholder
            Container(
              height: 200,
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.black,
                borderRadius: BorderRadius.circular(12),
              ),
              child: const Center(
                child: Icon(Icons.play_circle_fill, color: Colors.white, size: 60),
              ),
            ),
            const SizedBox(height: 16),
            
            // Lesson Title
            Text(
              widget.title,
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: AppTheme.charcoalBlue,
                  ),
            ),
            const SizedBox(height: 8),
            
            // Lesson Content
            Text(
              'In this lesson, we will cover the fundamentals of ${widget.title}. '
              'You will learn about widgets, state, and properties. '
              'Please watch the video carefully and read the notes below.',
              style: const TextStyle(fontSize: 16, height: 1.5, color: Colors.black87),
            ),
            const SizedBox(height: 24),
            
            // Mark as Completed Button
            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                onPressed: () {
                  setState(() {
                    _isCompleted = !_isCompleted;
                  });
                  if (_isCompleted) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Lesson marked as completed!')),
                    );
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: _isCompleted ? Colors.green : AppTheme.dustyDenim,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                icon: Icon(
                  _isCompleted ? Icons.check_circle : Icons.check_circle_outline,
                  color: Colors.white,
                ),
                label: Text(
                  _isCompleted ? 'Completed' : 'Mark as Completed',
                  style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
