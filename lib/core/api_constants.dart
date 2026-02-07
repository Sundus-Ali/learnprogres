import 'dart:io';

class ApiConstants {
  // Localhost for Android Emulator (10.0.2.2)
  // For Real Device/Production: Replace this URL with your Render/Heroku URL
  // static const String baseUrl = 'https://your-app-name.onrender.com/api'; 
  static const String baseUrl = 'http://10.0.2.2:5000/api';
  
  static const String loginEndpoint = '/auth/login';
  static const String registerEndpoint = '/auth/register';
  static const String coursesEndpoint = '/courses';
}
