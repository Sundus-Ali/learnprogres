import 'package:get/get.dart';
import '../models/course_model.dart';
import '../services/api_service.dart';

class CourseController extends GetxController {
  var isLoading = true.obs;
  var courses = <Course>[].obs;
  final ApiService _apiService = ApiService();

  @override
  void onInit() {
    fetchCourses();
    super.onInit();
  }

  // Fetch Courses (Soo qaado koorsooyinka)
  void fetchCourses() async {
    try {
      isLoading(true);
      var fetchedCourses = await _apiService.getCourses();
      courses.assignAll(fetchedCourses);
    } catch (e) {
      Get.snackbar('Error', 'Failed to load courses', snackPosition: SnackPosition.BOTTOM);
    } finally {
      isLoading(false);
    }
  }

  // Toggle Lesson Completion (Cusbooneysii heerka casharka)
  void toggleLessonCompletion(String courseId, String lessonId, bool isCompleted) async {
    try {
      // Optimistic UI Update: Find lesson and flip boolean immediately for smooth UX
      var courseIndex = courses.indexWhere((c) => c.id == courseId);
      if (courseIndex != -1) {
          var lesson = courses[courseIndex].lessons.firstWhere((l) => l.id == lessonId);
          lesson.isCompleted = isCompleted;
          courses.refresh(); // Update GetX UI
      }

      await _apiService.updateLessonProgress(courseId, lessonId, isCompleted);
      fetchCourses(); // Sync with backend to get accurate calculation
    } catch (e) {
      Get.snackbar('Error', 'Failed to update progress', snackPosition: SnackPosition.BOTTOM);
    }
  }
}
