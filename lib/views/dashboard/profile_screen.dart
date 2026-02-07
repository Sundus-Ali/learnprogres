import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../controllers/auth_controller.dart';
import '../../core/app_colors.dart';

class ProfileScreen extends StatelessWidget {
  final AuthController authController = Get.find<AuthController>();

  ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FD), // Light grey background
      appBar: AppBar(
        title: Text(
          'Student Profile',
          style: GoogleFonts.montserrat(color: Colors.black, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
           icon: const Icon(Icons.arrow_back_ios, color: Colors.black, size: 20),
           onPressed: () {
             // Go back logic if needed, or just standard navigation
             Get.back(); 
           },
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.settings, color: Colors.black),
            onPressed: () {},
          )
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            // 1. Avatar Section
            Center(
              child: Stack(
                children: [
                   const CircleAvatar(
                    radius: 50,
                    backgroundColor: Color(0xFF81C784), // Soft Green circle behind
                    child: CircleAvatar(
                      radius: 46,
                      backgroundImage: AssetImage('assets/images/logo.jpeg'), // Using existing asset as placeholder
                    ),
                  ),
                  Positioned(
                    bottom: 0,
                    right: 4,
                    child: Container(
                      padding: const EdgeInsets.all(6),
                      decoration: const BoxDecoration(
                        color: Color(0xFF00C853),
                        shape: BoxShape.circle,
                        border: Border.fromBorderSide(BorderSide(color: Colors.white, width: 2)),
                      ),
                      child: const Icon(Icons.check, size: 14, color: Colors.white),
                    ),
                  )
                ],
              ),
            ),
            const SizedBox(height: 16),
            Obx(() => Text(
              authController.userName.value,
              style: GoogleFonts.montserrat(fontSize: 22, fontWeight: FontWeight.bold),
            )),
            const Text(
              'alex.j@university.edu', // Could be dynamic
              style: TextStyle(color: Colors.grey, fontSize: 14),
            ),
            
            const SizedBox(height: 32),

            // 2. Academic Summary Header
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Academic Summary", style: GoogleFonts.montserrat(fontWeight: FontWeight.bold, fontSize: 16)),
                TextButton(
                  onPressed: () => _showTranscriptDialog(context),
                  child: Text("View Transcript", style: GoogleFonts.montserrat(fontWeight: FontWeight.bold, color: AppColors.primary)),
                ),
              ],
            ),
            
            // 3. GPA Cards
            const Row(
              children: [
                Expanded(child: _InfoCard(label: "OVERALL GPA", value: "3.85", valueColor: AppColors.primary)),
                SizedBox(width: 12),
                Expanded(child: _InfoCard(label: "CREDITS", value: "120/150", valueColor: Color(0xFF00C853))),
                SizedBox(width: 12),
                Expanded(child: _InfoCard(label: "RANK", value: "Top 10%", valueColor: Colors.black)),
              ],
            ),

            const SizedBox(height: 24),

            // 4. Learning Progress Bar
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text("Learning Progress\nBachelor of Computer Science", style: TextStyle(fontSize: 12, color: Colors.grey)),
                Text("80%", style: GoogleFonts.montserrat(fontWeight: FontWeight.bold, color: AppColors.primary)),
              ],
            ),
            const SizedBox(height: 8),
            ClipRRect(
              borderRadius: BorderRadius.circular(4),
              child: const LinearProgressIndicator(
                value: 0.8,
                minHeight: 8,
                backgroundColor: Color(0xFFE0E0E0),
                valueColor: AlwaysStoppedAnimation<Color>(AppColors.primary),
              ),
            ),

            const SizedBox(height: 20),

            // 5. Green Notification Box
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: const Color(0xFFE8F5E9), // Light Green
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                children: [
                  const Icon(Icons.auto_awesome, color: Color(0xFF2E7D32)),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      "Almost there! Only 2 semesters remaining to graduate.",
                      style: GoogleFonts.montserrat(color: const Color(0xFF2E7D32), fontSize: 13, fontWeight: FontWeight.w500),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 32),

            // 6. Account & Settings List
            Align(
              alignment: Alignment.centerLeft,
              child: Text("Account & Settings", style: GoogleFonts.montserrat(fontWeight: FontWeight.bold, fontSize: 16)),
            ),
            const SizedBox(height: 12),
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                boxShadow: [BoxShadow(color: Colors.grey.withOpacity(0.05), blurRadius: 10)],
              ),
              child: Column(
                children: [
                  _SettingsTile(
                    icon: Icons.person, 
                    color: Colors.blue, 
                    title: "Personal Information",
                    onTap: () => Get.snackbar("Info", "Edit Personal Information page"),
                  ),
                  const Divider(height: 1, indent: 60),
                  _SettingsTile(
                    icon: Icons.notifications_active, 
                    color: Colors.green, 
                    title: "Notification Preferences",
                    onTap: () => Get.snackbar("Info", "Notification settings"),
                  ),
                  const Divider(height: 1, indent: 60),
                  _SettingsTile(
                    icon: Icons.security, 
                    color: Colors.blueAccent, 
                    title: "Security & Privacy",
                    onTap: () => Get.snackbar("Info", "Security settings"),
                  ),
                  const Divider(height: 1, indent: 60),
                   _SettingsTile(
                    icon: Icons.language, 
                    color: Colors.grey, 
                    title: "App Language",
                    trailing: const Text("English  ›", style: TextStyle(color: Colors.grey)),
                    onTap: () => Get.snackbar("Info", "Language settings"),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 30),

            // 7. Sign Out Button
            SizedBox(
              width: double.infinity,
              child: OutlinedButton.icon(
                onPressed: () => authController.logout(),
                style: OutlinedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  side: const BorderSide(color: Colors.white), // Invisible border approach or just red
                  backgroundColor: Colors.white,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  elevation: 1,
                ),
                icon: const Icon(Icons.logout, color: Colors.red),
                label: Text(
                  "Sign Out",
                  style: GoogleFonts.montserrat(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.red),
                ),
              ),
            ),
            const SizedBox(height: 20),
            const Text(
              "App Version 2.4.1 (Build 890)", 
              style: TextStyle(color: Colors.grey, fontSize: 11),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  void _showTranscriptDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Academic Transcript"),
        content: const Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("• Computer Science 101: A"),
            Text("• Data Structures: A-"),
            Text("• Web Development: A"),
            Text("• Database Systems: B+"),
          ],
        ),
        actions: [
          TextButton(onPressed: () => Get.back(), child: const Text("Close")),
          ElevatedButton(onPressed: () => Get.back(), child: const Text("Download PDF")),
        ],
      ),
    );
  }
}

class _InfoCard extends StatelessWidget {
  final String label;
  final String value;
  final Color valueColor;

  const _InfoCard({required this.label, required this.value, required this.valueColor});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
         boxShadow: [BoxShadow(color: Colors.grey.withOpacity(0.05), blurRadius: 10)],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label, style: const TextStyle(fontSize: 10, color: Colors.grey, fontWeight: FontWeight.bold)),
          const SizedBox(height: 8),
          Text(value, style: GoogleFonts.montserrat(fontSize: 18, fontWeight: FontWeight.bold, color: valueColor)),
        ],
      ),
    );
  }
}

class _SettingsTile extends StatelessWidget {
  final IconData icon;
  final Color color;
  final String title;
  final Widget? trailing;
  final VoidCallback onTap;

  const _SettingsTile({
    required this.icon, 
    required this.color, 
    required this.title, 
    this.trailing, 
    required this.onTap
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(color: color.withOpacity(0.1), shape: BoxShape.circle),
        child: Icon(icon, color: color, size: 20),
      ),
      title: Text(title, style: GoogleFonts.montserrat(fontWeight: FontWeight.w600, fontSize: 14)),
      trailing: trailing ?? const Icon(Icons.arrow_forward_ios, size: 14, color: Colors.grey),
      onTap: onTap,
    );
  }
}
