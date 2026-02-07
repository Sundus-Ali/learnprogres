import 'package:flutter/material.dart';

class AuthViewModel extends ChangeNotifier {
  bool _isLoading = false;
  bool get isLoading => _isLoading;

  // -- Somali Comments --
  // Habka gelitaanka (Login function)
  // Returns user role: 'student', 'teacher', or 'admin'
  Future<String?> login(String email, String password) async {
    _isLoading = true;
    notifyListeners();

    // TODO: Connect to Real Backend later
    await Future.delayed(const Duration(seconds: 2)); // Simulating network delay

    _isLoading = false;
    notifyListeners();
    
    // Mock Role Logic based on email
    if (email.contains('admin')) {
      return 'admin';
    } else if (email.contains('teacher')) {
      return 'teacher';
    } else {
      return 'student';
    }
  }

  // Habka diiwaangelinta (Registration function)
  Future<bool> register(String name, String email, String password) async {
    _isLoading = true;
    notifyListeners();

    await Future.delayed(const Duration(seconds: 2));

    _isLoading = false;
    notifyListeners();
    return true;
  }
}
