import 'dart:convert';
import 'package:http/http.dart' as http;
import '../core/api_constants.dart';
import '../models/course_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ApiService {
  // Login Call
  Future<Map<String, dynamic>> login(String email, String password) async {
    final url = Uri.parse('${ApiConstants.baseUrl}${ApiConstants.loginEndpoint}');
    
    try {
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'email': email, 'password': password}),
      );

      if (response.statusCode == 200) {
        return jsonDecode(response.body); // Return user data & token
      } else {
        throw Exception('Login Failed: ${response.body}');
      }
    } catch (e) {
      throw Exception('Network Error: $e');
    }
  }

  // Register Call
  Future<Map<String, dynamic>> register(String name, String email, String password) async {
    final url = Uri.parse('${ApiConstants.baseUrl}${ApiConstants.registerEndpoint}');
    
    try {
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'name': name, 'email': email, 'password': password}),
      );

      if (response.statusCode == 201) {
        return jsonDecode(response.body);
      } else {
        throw Exception('Registration Failed: ${response.body}');
      }
    } catch (e) {
      throw Exception('Network Error: $e');
    }
  }

  // Get Courses
  Future<List<Course>> getCourses() async {
    final url = Uri.parse('${ApiConstants.baseUrl}${ApiConstants.coursesEndpoint}');
    try {
      final response = await http.get(url);

      if (response.statusCode == 200) {
        List<dynamic> body = jsonDecode(response.body);
        return body.map((dynamic item) => Course.fromJson(item)).toList();
      } else {
        throw Exception('Failed to load courses');
      }
    } catch (e) {
      throw Exception('Error fetching courses: $e');
    }
  }

  // Update Lesson Progress
  Future<void> updateLessonProgress(String courseId, String lessonId, bool isCompleted) async {
    final url = Uri.parse('${ApiConstants.baseUrl}${ApiConstants.coursesEndpoint}/$courseId/lessons/$lessonId');
    try {
      await http.put(
        url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'isCompleted': isCompleted}),
      );
    } catch (e) {
      throw Exception('Failed to update progress: $e');
    }
  }
}
