import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:learnprogres/core/constants.dart';

class CourseViewModel extends ChangeNotifier {
  List<dynamic> _courses = [];
  List<dynamic> get courses => _courses;
  
  bool _isLoading = false;
  bool get isLoading => _isLoading;

  // Fetch courses from backend
  Future<void> fetchCourses() async {
    _isLoading = true;
    notifyListeners();

    try {
      final response = await http.get(Uri.parse('${AppConstants.apiBaseUrl}/courses'));
      if (response.statusCode == 200) {
        _courses = jsonDecode(response.body);
      }
    } catch (e) {
      debugPrint('Error fetching courses: $e');
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
