import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:learnprogres/core/theme.dart';
import 'package:learnprogres/viewmodels/auth_viewmodel.dart';
import 'package:learnprogres/views/auth/login_screen.dart';

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
      ],
      child: MaterialApp(
        title: 'LearnProgress',
        debugShowCheckedModeBanner: false,
        theme: AppTheme.lightTheme,
        home: const LoginScreen(),
      ),
    );
  }
}
