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
      backgroundColor: const Color(0xFFF8F9FD),
      appBar: AppBar(
        title: Text(
          'Student Profile',
          style: GoogleFonts.montserrat(color: Colors.black, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(Icons.settings, color: Colors.black),
            onPressed: () => _showSettingsDialog(context),
          )
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            // 1. Avatar Section
            Center(
              child: GestureDetector(
                onTap: () => _showEditAvatarDialog(context),
                child: Stack(
                  children: [
                     const CircleAvatar(
                      radius: 50,
                      backgroundColor: Color(0xFF81C784),
                      child: CircleAvatar(
                        radius: 46,
                        backgroundImage: AssetImage('assets/images/logo.jpeg'),
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
                        child: const Icon(Icons.camera_alt, size: 14, color: Colors.white),
                      ),
                    )
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),
            Obx(() => Text(
              authController.userName.value,
              style: GoogleFonts.montserrat(fontSize: 22, fontWeight: FontWeight.bold),
            )),
            const Text(
              'alex.j@university.edu',
              style: TextStyle(color: Colors.grey, fontSize: 14),
            ),
            
            const SizedBox(height: 32),

            // 2. Academic Summary
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
            Row(
              children: [
                Expanded(child: _InfoCard(label: "OVERALL GPA", value: "3.85", valueColor: AppColors.primary, onTap: () => _showGPADetails(context))),
                const SizedBox(width: 12),
                Expanded(child: _InfoCard(label: "CREDITS", value: "120/150", valueColor: const Color(0xFF00C853), onTap: () => _showCreditsDetails(context))),
                const SizedBox(width: 12),
                Expanded(child: _InfoCard(label: "RANK", value: "Top 10%", valueColor: Colors.black, onTap: () => _showRankDetails(context))),
              ],
            ),

            const SizedBox(height: 24),

            // 4. Learning Progress Bar
            GestureDetector(
              onTap: () => _showProgramDetails(context),
              child: Column(
                children: [
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
                ],
              ),
            ),

            const SizedBox(height: 20),

            // 5. Green Notification Box
            GestureDetector(
              onTap: () => Get.snackbar("Graduation Status", "You are on track to graduate in Spring 2027! Keep it up!", backgroundColor: Colors.green[100], colorText: Colors.green[900]),
              child: Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: const Color(0xFFE8F5E9),
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
            ),

            const SizedBox(height: 32),

            // 6. Account & Settings List - Make ALL Clickable with Real Dialogs
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
                    onTap: () => _showPersonalInfoDialog(context),
                  ),
                  const Divider(height: 1, indent: 60),
                  _SettingsTile(
                    icon: Icons.notifications_active, 
                    color: Colors.green, 
                    title: "Notification Preferences",
                    onTap: () => _showNotificationDialog(context),
                  ),
                  const Divider(height: 1, indent: 60),
                  _SettingsTile(
                    icon: Icons.security, 
                    color: Colors.blueAccent, 
                    title: "Security & Privacy",
                    onTap: () => _showSecurityDialog(context),
                  ),
                  const Divider(height: 1, indent: 60),
                   _SettingsTile(
                    icon: Icons.language, 
                    color: Colors.grey, 
                    title: "App Language",
                    trailing: const Text("English  ›", style: TextStyle(color: Colors.grey)),
                    onTap: () => _showLanguageDialog(context),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 30),

            // 7. Sign Out Button
            SizedBox(
              width: double.infinity,
              child: OutlinedButton.icon(
                onPressed: () => _confirmLogout(context),
                style: OutlinedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  side: const BorderSide(color: Colors.transparent), 
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

  // --- INTERACTIVE DIALOGS ---

  void _showTranscriptDialog(BuildContext context) {
    Get.bottomSheet(
      Container(
        padding: const EdgeInsets.all(20),
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
        ),
        child: Column(
          children: [
            Text("Academic Transcript", style: GoogleFonts.montserrat(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 10),
            const Divider(),
            Expanded(
              child: ListView(
                children: const [
                  ListTile(title: Text("Computer Science 101"), trailing: Text("A", style: TextStyle(fontWeight: FontWeight.bold, color: Colors.green))),
                  ListTile(title: Text("Data Structures"), trailing: Text("A-", style: TextStyle(fontWeight: FontWeight.bold, color: Colors.green))),
                  ListTile(title: Text("Web Development"), trailing: Text("A", style: TextStyle(fontWeight: FontWeight.bold, color: Colors.green))),
                  ListTile(title: Text("Database Systems"), trailing: Text("B+", style: TextStyle(fontWeight: FontWeight.bold, color: Colors.blue))),
                  ListTile(title: Text("Calculus I"), trailing: Text("B", style: TextStyle(fontWeight: FontWeight.bold, color: Colors.blue))),
                ],
              ),
            ),
            ElevatedButton(
              onPressed: () => Get.back(),
              style: ElevatedButton.styleFrom(backgroundColor: AppColors.primary, padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 12)),
              child: const Text("Download PDF", style: TextStyle(color: Colors.white)),
            )
          ],
        ),
      ),
    );
  }

  void _showGPADetails(BuildContext context) {
    Get.defaultDialog(
      title: "GPA Breakdown",
      content: const Column(
        children: [
          Text("Current Semester: 3.92"),
          Text("Cumulative: 3.85"),
          SizedBox(height: 10),
          Text("Keep up the great work!", style: TextStyle(color: Colors.green)),
        ],
      ),
      textConfirm: "Close",
      confirmTextColor: Colors.white,
      onConfirm: () => Get.back(),
    );
  }

  void _showCreditsDetails(BuildContext context) {
     Get.defaultDialog(
      title: "Credits Detail",
      content: const Text("You have completed 120 credits out of 150 required for graduation. 30 credits remaining."),
      textConfirm: "OK",
      confirmTextColor: Colors.white,
      onConfirm: () => Get.back(),
    );
  }

  void _showRankDetails(BuildContext context) {
     Get.defaultDialog(
      title: "Class Rank",
      content: const Text("You are in the top 10% of your class of 450 students."),
      textConfirm: "Cool!",
      confirmTextColor: Colors.white,
      onConfirm: () => Get.back(),
    );
  }


  void _showPersonalInfoDialog(BuildContext context) {
    // Allows editing name/email (UI only for now)
    final nameController = TextEditingController(text: authController.userName.value);
    Get.defaultDialog(
      title: "Edit Personal Info",
      content: Column(
        children: [
          TextField(controller: nameController, decoration: const InputDecoration(labelText: "Full Name")),
          const TextField(decoration: InputDecoration(labelText: "Email"), enabled: false), // Email usually read-only
          const TextField(decoration: InputDecoration(labelText: "Phone Number")),
        ],
      ),
      textConfirm: "Save",
      textCancel: "Cancel",
      confirmTextColor: Colors.white,
      onConfirm: () {
        authController.userName.value = nameController.text; // Update locally
        Get.back();
        Get.snackbar("Success", "Profile updated successfully!");
      },
    );
  }

  void _showNotificationDialog(BuildContext context) {
    Get.defaultDialog(
      title: "Notification Preferences",
      content: Column(
        children: [
          SwitchListTile(title: const Text("Email Notifications"), value: true, onChanged: (v) {}),
          SwitchListTile(title: const Text("Push Notifications"), value: true, onChanged: (v) {}),
          SwitchListTile(title: const Text("Weekly Reports"), value: false, onChanged: (v) {}),
        ],
      ),
      textConfirm: "Done",
      confirmTextColor: Colors.white,
      onConfirm: () => Get.back(),
    );
  }

  void _showSecurityDialog(BuildContext context) {
    Get.defaultDialog(
      title: "Security Settings",
      content: const Column(
        children: [
          TextField(decoration: InputDecoration(labelText: "Current Password"), obscureText: true),
          TextField(decoration: InputDecoration(labelText: "New Password"), obscureText: true),
          TextField(decoration: InputDecoration(labelText: "Confirm New Password"), obscureText: true),
        ],
      ),
      textConfirm: "Change Password",
      textCancel: "Cancel",
      confirmTextColor: Colors.white,
      onConfirm: () {
        Get.back();
        Get.snackbar("Success", "Password changed successfully!");
      },
    );
  }

  void _showLanguageDialog(BuildContext context) {
    Get.defaultDialog(
      title: "Select Language",
      content: Column(
        children: [
          ListTile(title: const Text("English"), leading: const Icon(Icons.check, color: AppColors.primary), onTap: () => Get.back()),
          ListTile(title: const Text("Somali"), onTap: () {
             Get.back();
             Get.snackbar("Info", "Somali language support coming soon!");
          }),
          ListTile(title: const Text("Arabic"), onTap: () => Get.back()),
        ],
      ),
    );
  }
  
  void _showSettingsDialog(BuildContext context) {
      Get.bottomSheet(
        Container(
          color: Colors.white,
          child: Wrap(
            children: [
              ListTile(leading: const Icon(Icons.color_lens), title: const Text('Theme'), onTap: () => Get.back()),
              ListTile(leading: const Icon(Icons.help), title: const Text('Help & Support'), onTap: () => Get.back()),
            ],
          ),
        )
      );
  }
  
  void _showProgramDetails(BuildContext context) {
     Get.snackbar("Program Info", "Bachelor of Computer Science - Year 3", snackPosition: SnackPosition.BOTTOM);
  }
  
  void _showEditAvatarDialog(BuildContext context) {
    Get.bottomSheet(
      Container(
        color: Colors.white,
        child: Wrap(
          children: [
            ListTile(leading: const Icon(Icons.photo_library), title: const Text('Gallery'), onTap: () => Get.back()),
            ListTile(leading: const Icon(Icons.camera_alt), title: const Text('Camera'), onTap: () => Get.back()),
          ],
        ),
      )
    );
  }

  void _confirmLogout(BuildContext context) {
    Get.defaultDialog(
      title: "Sign Out",
      middleText: "Are you sure you want to sign out?",
      textConfirm: "Yes, Sign Out",
      textCancel: "Cancel",
      confirmTextColor: Colors.white,
      buttonColor: Colors.red,
      onConfirm: () => authController.logout(),
    );
  }
}

class _InfoCard extends StatelessWidget {
  final String label;
  final String value;
  final Color valueColor;
  final VoidCallback onTap;

  const _InfoCard({required this.label, required this.value, required this.valueColor, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
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
