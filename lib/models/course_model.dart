class Lesson {
  final String id;
  final String title;
  final String content;
  final String duration;
  bool isCompleted;

  Lesson({
    required this.id,
    required this.title,
    required this.content,
    required this.duration,
    this.isCompleted = false,
  });

  factory Lesson.fromJson(Map<String, dynamic> json) {
    return Lesson(
      id: json['_id'] ?? '',
      title: json['title'] ?? 'Untitled Lesson',
      content: json['content'] ?? 'No Content Available.',
      duration: json['duration'] ?? '5 min',
      isCompleted: json['isCompleted'] ?? false,
    );
  }
}

class Course {
  final String id;
  final String title;
  final String description;
  final String image;
  final String instructor;
  final double progress; // 0 to 100
  final List<Lesson> lessons;

  Course({
    required this.id,
    required this.title,
    required this.description,
    required this.image,
    required this.instructor,
    this.progress = 0,
    required this.lessons,
  });

  factory Course.fromJson(Map<String, dynamic> json) {
    var lessonList = json['lessons'] as List?;
    List<Lesson> lessons = lessonList != null
        ? lessonList.map((i) => Lesson.fromJson(i)).toList()
        : [];

    return Course(
      id: json['_id'] ?? '',
      title: json['title'] ?? 'Untitled Course',
      description: json['description'] ?? 'No Description',
      image: json['image'] ?? '',
      instructor: json['instructor'] ?? 'Unknown',
      progress: (json['progress'] ?? 0).toDouble(),
      lessons: lessons,
    );
  }
}
