import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:learnprogres/core/theme.dart';
import 'package:learnprogres/viewmodels/auth_viewmodel.dart';
import 'package:learnprogres/viewmodels/course_viewmodel.dart';
import 'package:learnprogres/views/auth/login_screen.dart';
import 'package:learnprogres/views/main_layout.dart';
import 'package:learnprogres/views/dashboard/teacher_dashboard_screen.dart';
import 'package:learnprogres/views/dashboard/admin_dashboard_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthViewModel()),
        ChangeNotifierProvider(create: (_) => CourseViewModel()),
      ],
      child: MaterialApp(
        title: 'LearnProgress',
        debugShowCheckedModeBanner: false,
        theme: AppTheme.lightTheme,
        home: const AuthCheckWrapper(),
      ),
    );
  }
}

class AuthCheckWrapper extends StatefulWidget {
  const AuthCheckWrapper({super.key});

  @override
  State<AuthCheckWrapper> createState() => _AuthCheckWrapperState();
}

class _AuthCheckWrapperState extends State<AuthCheckWrapper> {
  @override
  void initState() {
    super.initState();
    // Check login status once when app starts
    Future.delayed(Duration.zero, () {
      Provider.of<AuthViewModel>(context, listen: false).checkLoginStatus();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<AuthViewModel>(
      builder: (context, auth, child) {
        if (auth.isLoggedIn) {
           // Route based on role
           if (auth.userRole == 'admin') return const AdminDashboardScreen();
           if (auth.userRole == 'teacher') return const TeacherDashboardScreen();
           return const MainLayout();
        }
        return const LoginScreen();
      },
    );
  }
}
