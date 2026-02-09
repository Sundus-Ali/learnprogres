import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import '../../controllers/auth_controller.dart';
import '../../controllers/course_controller.dart';
import './course_detail_screen.dart';
import '../../core/app_colors.dart';
import '../../models/course_model.dart';
//import '../../models/course_model.dart';

class HomeScreen extends StatelessWidget {
  final AuthController authController = Get.find<AuthController>();
  final CourseController courseController = Get.put(CourseController());

  HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FD),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // 1. Custom AppBar / Header
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'LearnProgress',
                    style: GoogleFonts.montserrat(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: AppColors.primary,
                    ),
                  ),
                  Row(
                    children: [
                      IconButton(
                        icon: const Icon(Icons.search, size: 28, color: Colors.grey),
                        onPressed: () {
                          showSearch(context: context, delegate: CourseSearchDelegate(courseController));
                        },
                      ),
                      const SizedBox(width: 8),
                      Stack(
                        children: [
                          const Icon(Icons.notifications_none, size: 28, color: Colors.grey),
                          Positioned(
                            right: 0,
                            top: 0,
                            child: Container(
                              padding: const EdgeInsets.all(4),
                              decoration: const BoxDecoration(
                                shape: BoxShape.circle,
                                color: Colors.red,
                              ),
                            ),
                          )
                        ],
                      ),
                    ],
                  )
                ],
              ),
              
              const SizedBox(height: 24),

              // 2. Welcome Message
              Obx(() => Text(
                'Welcome back, ${authController.userName.value.split(' ')[0]}!',
                style: GoogleFonts.montserrat(
                  fontSize: 26,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              )),
              const SizedBox(height: 8),
              Obx(() => Text(
                'You have ${courseController.courses.length} courses in progress today.',
                style: GoogleFonts.montserrat(
                  fontSize: 16,
                  color: Colors.grey[600],
                ),
              )),

              const SizedBox(height: 32),

              // 3. "My Courses" Header
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'My Courses',
                    style: GoogleFonts.montserrat(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                  TextButton(
                    onPressed: () {},
                    child: Text(
                      'View All',
                      style: GoogleFonts.montserrat(
                        color: AppColors.primary,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 16),

              // 4. Course List (Redesigned Cards)
              Obx(() {
                if (courseController.isLoading.value) {
                  return const Center(child: CircularProgressIndicator());
                }
                return ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: courseController.courses.length,
                  itemBuilder: (context, index) {
                    final course = courseController.courses[index];
                    return CourseCard(course: course, index: index);
                  },
                );
              }),

              const SizedBox(height: 32),

              // 5. Weekly Summary Card (Blue)
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(24),
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [Color(0xFF1976D2), Color(0xFF2196F3)],
                    begin: Alignment.bottomLeft,
                    end: Alignment.topRight,
                  ),
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.blue.withOpacity(0.3),
                      blurRadius: 10,
                      offset: const Offset(0, 5),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Weekly Summary',
                      style: GoogleFonts.montserrat(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      "You're in the top 5% of learners this week.\nKeep it up!",
                      style: GoogleFonts.montserrat(
                        color: Colors.white.withOpacity(0.9),
                        height: 1.5,
                      ),
                    ),
                    const SizedBox(height: 24),
                    const Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        _StatItem(value: '12h 45m', label: 'Study Time'),
                        SizedBox(height: 30, child: VerticalDivider(color: Colors.white24)),
                        _StatItem(value: '8', label: 'Lessons Done'),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _StatItem extends StatelessWidget {
  final String value;
  final String label;

  const _StatItem({required this.value, required this.label});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          value,
          style: GoogleFonts.montserrat(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        Text(
          label,
          style: GoogleFonts.montserrat(
            color: Colors.white70,
            fontSize: 14,
          ),
        ),
      ],
    );
  }
}

class CourseCard extends StatelessWidget {
  final Course course;
  final int index;

  const CourseCard({super.key, required this.course, required this.index});

  Map<String, dynamic> _getTheme(int index) {
    final themes = [
      {'color': const Color(0xFFE3F2FD), 'icon': Icons.palette, 'iconColor': Colors.blue},
      {'color': const Color(0xFFFFF3E0), 'icon': Icons.code, 'iconColor': Colors.orange},
      {'color': const Color(0xFFF3E5F5), 'icon': Icons.data_usage, 'iconColor': Colors.purple},
      {'color': const Color(0xFFE8F5E9), 'icon': Icons.business_center, 'iconColor': Colors.green},
      {'color': const Color(0xFFE1F5FE), 'icon': Icons.language, 'iconColor': Colors.lightBlue},
    ];
    return themes[index % themes.length];
  }

  @override
  Widget build(BuildContext context) {
    final theme = _getTheme(index);

    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.05),
            spreadRadius: 2,
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(20),
          onTap: () {
             Get.to(() => CourseDetailScreen(course: course));
          },
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: theme['color'],
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Icon(
                        theme['icon'],
                        color: theme['iconColor'],
                        size: 24,
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            course.title,
                            style: GoogleFonts.montserrat(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Colors.black87,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            'Module ${course.lessons.where((l) => l.isCompleted).length + 1} of ${course.lessons.length} • ${course.instructor}',
                            style: GoogleFonts.montserrat(
                              fontSize: 13,
                              color: Colors.grey,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'PROGRESS',
                      style: GoogleFonts.montserrat(
                        fontSize: 11,
                        fontWeight: FontWeight.w600,
                        color: Colors.grey,
                        letterSpacing: 1.0,
                      ),
                    ),
                    Text(
                      '${course.progress.toInt()}%',
                      style: GoogleFonts.montserrat(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: AppColors.secondary,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                
                LinearPercentIndicator(
                  lineHeight: 8.0,
                  percent: course.progress / 100,
                  backgroundColor: const Color(0xFFF1F1F1),
                  progressColor: AppColors.secondary,
                  barRadius: const Radius.circular(4),
                  padding: EdgeInsets.zero,
                  animation: true,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// Search Delegate Logic
class CourseSearchDelegate extends SearchDelegate {
  final CourseController courseController;

  CourseSearchDelegate(this.courseController);

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [IconButton(onPressed: () => query = '', icon: const Icon(Icons.clear))];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(onPressed: () => close(context, null), icon: const Icon(Icons.arrow_back));
  }

  @override
  Widget buildResults(BuildContext context) {
    final results = courseController.courses.where((c) => c.title.toLowerCase().contains(query.toLowerCase())).toList();
    return ListView.builder(
      itemCount: results.length,
      itemBuilder: (context, index) => ListTile(
        title: Text(results[index].title),
        subtitle: Text('Instructor: ${results[index].instructor}'),
        onTap: () => Get.to(() => CourseDetailScreen(course: results[index])),
      ),
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    final suggestions = courseController.courses.where((c) => c.title.toLowerCase().contains(query.toLowerCase())).toList();
    return ListView.builder(
      itemCount: suggestions.length,
      itemBuilder: (context, index) => ListTile(
        title: Text(suggestions[index].title),
         onTap: () {
           query = suggestions[index].title;
           showResults(context);
         }
      ),
    );
  }
}
