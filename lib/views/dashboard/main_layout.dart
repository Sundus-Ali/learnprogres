import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controllers/main_controller.dart';
import 'home_screen.dart';
import 'profile_screen.dart';
import 'progress_screen.dart';
import '../../core/app_colors.dart';

class MainLayout extends StatelessWidget {
  const MainLayout({super.key});

  @override
  Widget build(BuildContext context) {
    final MainController mainController = Get.put(MainController());

    final List<Widget> screens = [
      HomeScreen(),
      ProgressScreen(),
      ProfileScreen(),
    ];

    return Scaffold(
      body: Obx(() => IndexedStack(
        index: mainController.selectedIndex.value,
        children: screens,
      )),
      bottomNavigationBar: Obx(() => NavigationBar(
        selectedIndex: mainController.selectedIndex.value,
        onDestinationSelected: (index) {
          mainController.changeTabIndex(index);
        },
        backgroundColor: Colors.white,
        indicatorColor: AppColors.primary.withOpacity(0.2),
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.grid_view_outlined),
            selectedIcon: Icon(Icons.grid_view, color: AppColors.primary),
            label: 'Home',
          ),
          NavigationDestination(
             icon: Icon(Icons.bar_chart_outlined),
             selectedIcon: Icon(Icons.bar_chart, color: AppColors.primary),
             label: 'Progress',
          ),
          NavigationDestination(
            icon: Icon(Icons.person_outline),
            selectedIcon: Icon(Icons.person, color: AppColors.primary),
            label: 'Profile',
          ),
        ],
      )),
    );
  }
}
