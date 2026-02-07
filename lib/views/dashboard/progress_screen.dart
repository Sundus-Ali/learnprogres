import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import '../../controllers/auth_controller.dart';
import '../../controllers/course_controller.dart';
import '../../controllers/main_controller.dart';
import '../../core/app_colors.dart';
import '../../models/course_model.dart';

class ProgressScreen extends StatelessWidget {
  final AuthController authController = Get.find<AuthController>();
  final CourseController courseController = Get.find<CourseController>();

  ProgressScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Calculate global stats dynamically
    int totalLessons = 0;
    int completedLessons = 0;
    
    for (var course in courseController.courses) {
      totalLessons += course.lessons.length;
      completedLessons += course.lessons.where((l) => l.isCompleted).length;
    }

    double overallProgress = totalLessons == 0 ? 0 : completedLessons / totalLessons;
    int percentage = (overallProgress * 100).toInt();

    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FD),
      appBar: AppBar(
        title: Text(
          'Learning Progress',
          style: GoogleFonts.montserrat(fontWeight: FontWeight.bold, color: Colors.black),
        ),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.black, size: 20),
          onPressed: () {
             // Go to Home Tab
             Get.find<MainController>().changeTabIndex(0);
          },
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.account_circle, color: Colors.black),
            onPressed: () {
              // Go to Profile Tab
              Get.find<MainController>().changeTabIndex(2);
            },
          )
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            // 1. Main Summary Card
            Container(
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(24),
                boxShadow: [
                  BoxShadow(color: Colors.grey.withOpacity(0.05), blurRadius: 20, offset: const Offset(0, 5)),
                ],
              ),
              child: Column(
                children: [
                  CircularPercentIndicator(
                    radius: 70.0,
                    lineWidth: 12.0,
                    percent: overallProgress,
                    center: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "$percentage%",
                          style: GoogleFonts.montserrat(fontWeight: FontWeight.bold, fontSize: 32),
                        ),
                        Text("OVERALL", style: GoogleFonts.montserrat(fontSize: 10, color: Colors.grey, fontWeight: FontWeight.bold)),
                      ],
                    ),
                    progressColor: AppColors.primary,
                    backgroundColor: const Color(0xFFE0E0E0),
                    circularStrokeCap: CircularStrokeCap.round,
                    animation: true,
                  ),
                  const SizedBox(height: 20),
                  Text(
                    "Great progress, ${authController.userName.value.split(' ')[0]}!",
                    style: GoogleFonts.montserrat(fontWeight: FontWeight.bold, fontSize: 18),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    "You've completed $completedLessons out of $totalLessons lessons this semester.",
                    textAlign: TextAlign.center,
                    style: GoogleFonts.montserrat(color: Colors.grey, fontSize: 13, height: 1.5),
                  ),
                  const SizedBox(height: 24),
                  Row(
                    children: [
                      Expanded(
                        child: _StatBox(
                          value: "12",
                          label: "HOURS SPENT",
                          bgColor: const Color(0xFFEDF2FF), // Light Blue
                          textColor: AppColors.primary,
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: _StatBox(
                          value: "92%",
                          label: "AVG. SCORE",
                          bgColor: const Color(0xFFE8F5E9), // Light Green
                          textColor: Colors.green,
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),

            const SizedBox(height: 24),

            // 2. Stats Row (Total, Done, Left)
            Row(
              children: [
                Expanded(child: _SmallStatCard(icon: Icons.menu_book, color: Colors.blue, label: "TOTAL", value: "$totalLessons", sub: "Total Lessons")),
                const SizedBox(width: 12),
                Expanded(child: _SmallStatCard(icon: Icons.check_circle, color: Colors.green, label: "DONE", value: "$completedLessons", sub: "Lessons Finished")),
                const SizedBox(width: 12),
                Expanded(child: _SmallStatCard(icon: Icons.pending, color: Colors.orange, label: "LEFT", value: "${totalLessons - completedLessons}", sub: "Remaining")),
              ],
            ),

            const SizedBox(height: 32),

            // 3. Subject Breakdown Header
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Subject Breakdown", style: GoogleFonts.montserrat(fontWeight: FontWeight.bold, fontSize: 18)),
                Text("View All", style: GoogleFonts.montserrat(color: AppColors.primary, fontWeight: FontWeight.bold)),
              ],
            ),
            const SizedBox(height: 16),

            // 4. Subject List
            Obx(() => ListView.builder(
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: courseController.courses.length,
              itemBuilder: (context, index) {
                final course = courseController.courses[index];
                return _SubjectCard(course: course, index: index);
              },
            )),

            const SizedBox(height: 32),

            // 5. Study Activity
            Align(
              alignment: Alignment.centerLeft,
              child: Text("Study Activity", style: GoogleFonts.montserrat(fontWeight: FontWeight.bold, fontSize: 18)),
            ),
            const SizedBox(height: 16),
            Container(
              height: 150,
              decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(16)),
              child: Center(
                child: Text("Graph Placeholder (Use fl_chart for real graph)", style: TextStyle(color: Colors.grey)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _StatBox extends StatelessWidget {
  final String value;
  final String label;
  final Color bgColor;
  final Color textColor;

  const _StatBox({required this.value, required this.label, required this.bgColor, required this.textColor});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 16),
      decoration: BoxDecoration(color: bgColor, borderRadius: BorderRadius.circular(12)),
      child: Column(
        children: [
          Text(value, style: GoogleFonts.montserrat(fontWeight: FontWeight.bold, fontSize: 20, color: textColor)),
          const SizedBox(height: 4),
          Text(label, style: GoogleFonts.montserrat(fontWeight: FontWeight.bold, fontSize: 10, color: textColor.withOpacity(0.7))),
        ],
      ),
    );
  }
}

class _SmallStatCard extends StatelessWidget {
  final IconData icon;
  final Color color;
  final String label;
  final String value;
  final String sub;

  const _SmallStatCard({required this.icon, required this.color, required this.label, required this.value, required this.sub});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(16)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icon, size: 16, color: color),
              const SizedBox(width: 6),
              Text(label, style: GoogleFonts.montserrat(fontWeight: FontWeight.bold, fontSize: 10, color: color)),
            ],
          ),
          const SizedBox(height: 8),
          Text(value, style: GoogleFonts.montserrat(fontWeight: FontWeight.bold, fontSize: 22)),
          const SizedBox(height: 4),
          Text(sub, style: GoogleFonts.montserrat(fontSize: 10, color: Colors.grey)),
        ],
      ),
    );
  }
}

class _SubjectCard extends StatelessWidget {
  final Course course;
  final int index;

  const _SubjectCard({required this.course, required this.index});

  @override
  Widget build(BuildContext context) {
    final colors = [Colors.blue, Colors.green, Colors.purple, Colors.orange, Colors.teal];
    final color = colors[index % colors.length];

    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(16)),
      child: Column(
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(color: color.withOpacity(0.1), borderRadius: BorderRadius.circular(8)),
                child: Icon(Icons.class_, color: color, size: 20),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(course.title, style: GoogleFonts.montserrat(fontWeight: FontWeight.bold, fontSize: 14)),
                    Text(
                      "${course.lessons.where((l) => l.isCompleted).length} of ${course.lessons.length} lessons",
                      style: GoogleFonts.montserrat(fontSize: 11, color: Colors.grey),
                    ),
                  ],
                ),
              ),
              Text("${course.progress.toInt()}%", style: GoogleFonts.montserrat(fontWeight: FontWeight.bold, color: color)),
            ],
          ),
          const SizedBox(height: 12),
          LinearPercentIndicator(
            lineHeight: 6.0,
            percent: course.progress / 100,
            backgroundColor: Colors.grey[100],
            progressColor: color,
            barRadius: const Radius.circular(3),
            padding: EdgeInsets.zero,
            animation: true,
          ),
        ],
      ),
    );
  }
}
