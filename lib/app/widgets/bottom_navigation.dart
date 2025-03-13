import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:medica_app/app/routes/app_pages.dart';
import 'package:medica_app/app/utils/colors.dart';
import 'package:medica_app/app/views/homeScreen/home_controller.dart';

class BottomNavigation extends StatelessWidget {
  const BottomNavigation({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeController>(
      builder: (controller) {
        return BottomNavigationBar(
          currentIndex: controller.currentNavIndex.value,
          onTap: (index) {
            controller.changeNavIndex(index);

            // Navigate to the selected screen
            switch (index) {
              case 0:
                Get.offAllNamed(Routes.homeScreen); // Replace with your actual route name
                break;
              case 1:
                Get.toNamed(Routes.booking); // Navigate to Schedule Screen
                break;
              case 2:
                Get.toNamed(Routes.doctors); // Navigate to Messages Screen
                break;
              case 3:
                Get.toNamed(Routes.profile); // Navigate to Profile Screen
                break;
            }
          },
          selectedItemColor: AppColors.primaryColor,
          unselectedItemColor: Colors.grey,
          items: const [
            BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
            BottomNavigationBarItem(icon: Icon(Icons.access_time), label: 'Schedule'),
            BottomNavigationBarItem(icon: Icon(Icons.chat), label: 'Messages'),
            BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
          ],
        );
      },
    );
  }
}
