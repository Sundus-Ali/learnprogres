import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:learnprogres/core/constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthViewModel extends ChangeNotifier {
 
  // Is-bedelayaasha Xaaladda (State Variables)
  // _isLoading: Waxay muujineysaa in app-ku mashquul yahay (loading)
  bool _isLoading = false;
  bool get isLoading => _isLoading;

  String? _token;
  String? get token => _token;

  String _userRole = 'student';
  String get userRole => _userRole;


  // Habka gelitaanka (Login function)
  // Waxaan isticmaaleynaa http.post si aan u la xiriirno backend-ka.
  // Waxaan soo celinaynaa doorka isticmaalaha (User Role) haddii guul la gaaro.
  Future<String?> login(String email, String password) async {
    _isLoading = true;
    notifyListeners();

    try {
      final response = await http.post(
        Uri.parse('${AppConstants.apiBaseUrl}/auth/login'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'email': email,
          'password': password,
        }),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        _token = data['token'];
        _userRole = data['role'];
        
        // Save token locally
        final prefs = await SharedPreferences.getInstance();
        await prefs.setString('token', _token!);
        await prefs.setString('role', _userRole);

        _isLoading = false;
        notifyListeners();
        return _userRole;
      } else {
        _isLoading = false;
        notifyListeners();
        return null; // Login failed
      }
    } catch (e) {
      print('Login Error: $e');
      _isLoading = false;
      notifyListeners();
      return null;
    }
  }

  // Habka diiwaangelinta (Registration function)
  Future<bool> register(String name, String email, String password) async {
    _isLoading = true;
    notifyListeners();

    try {
      final response = await http.post(
        Uri.parse('${AppConstants.apiBaseUrl}/auth/register'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'name': name,
          'email': email,
          'password': password,
        }),
      );

      if (response.statusCode == 201) {
        _isLoading = false;
        notifyListeners();
        return true;
      } else {
        _isLoading = false;
        notifyListeners();
        return false;
      }
    } catch (e) {
      print('Register Error: $e');
      _isLoading = false;
      notifyListeners();
      return false;
    }
  }
}

