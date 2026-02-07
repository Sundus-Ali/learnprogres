import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:learnprogres/core/theme.dart';
import 'package:learnprogres/core/constants.dart';
import 'package:learnprogres/viewmodels/auth_viewmodel.dart';
import 'package:learnprogres/views/auth/register_screen.dart';
import 'package:learnprogres/views/main_layout.dart';
import 'package:learnprogres/views/dashboard/teacher_dashboard_screen.dart';
import 'package:learnprogres/views/dashboard/admin_dashboard_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  // Masuuliyiinta xakamaynta qoraalka (Text Editing Controllers)
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    // Waxaan isticmaaleynaa Provider si aan u helno AuthViewModel
    // Tani waxay noo ogolaaneysaa inaan maamulno xaaladda (State Management)
    final authViewModel = Provider.of<AuthViewModel>(context);

    return Scaffold(
      backgroundColor: AppTheme.white,
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24.0),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // Logo Section
                const Icon(
                  Icons.school, // Placeholder for logo
                  size: 80,
                  color: AppTheme.charcoalBlue,
                ),
                const SizedBox(height: 16),
                Text(
                  AppConstants.appName,
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                        color: AppTheme.charcoalBlue,
                        fontWeight: FontWeight.bold,
                      ),
                ),
                const SizedBox(height: 8),
                Text(
                  'Welcome back, Student!',
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                        color: AppTheme.dustyDenim,
                      ),
                ),
                const SizedBox(height: 32),

                // Email Field
                TextFormField(
                  controller: _emailController,
                  decoration: InputDecoration(
                    labelText: 'Email',
                    prefixIcon: const Icon(Icons.email_outlined, color: AppTheme.dustyDenim),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: const BorderSide(color: AppTheme.charcoalBlue, width: 2),
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your email';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),

                // Password Field
                TextFormField(
                  controller: _passwordController,
                  obscureText: true,
                  decoration: InputDecoration(
                    labelText: 'Password',
                    prefixIcon: const Icon(Icons.lock_outline, color: AppTheme.dustyDenim),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: const BorderSide(color: AppTheme.charcoalBlue, width: 2),
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your password';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 24),

                // Login Button
                ElevatedButton(
                  onPressed: authViewModel.isLoading
                      ? null
                      : () {
                          if (_formKey.currentState!.validate()) {
                            authViewModel.login(
                              _emailController.text,
                              _passwordController.text,
                            ).then((role) {
                              if (!context.mounted) return;

                              if (role == 'student') {
                                Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(builder: (context) => const MainLayout()),
                                );
                              } else if (role == 'teacher') {
                                Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(builder: (context) => const TeacherDashboardScreen()),
                                );
                              } else if (role == 'admin') {
                                Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(builder: (context) => const AdminDashboardScreen()),
                                );
                              } else {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(content: Text('Login Failed')),
                                );
                              }
                            });
                          }
                        },
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    backgroundColor: AppTheme.charcoalBlue,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: authViewModel.isLoading
                      ? const SizedBox(
                          height: 20,
                          width: 20,
                          child: CircularProgressIndicator(color: AppTheme.white),
                        )
                      : const Text(
                          'Login',
                          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                ),
                const SizedBox(height: 16),

                TextButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const RegisterScreen()),
                    );
                  },
                  child: const Text(
                    "Don't have an account? Register",
                    style: TextStyle(color: AppTheme.dustyDenim),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
