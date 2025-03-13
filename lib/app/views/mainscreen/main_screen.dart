import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:medica_app/app/views/homeScreen/home_screen.dart';
import 'package:medica_app/app/views/mainscreen/main_controller.dart';
import 'package:medica_app/app/views/profile/profile_screen.dart';
import 'package:medica_app/app/views/reels/reel_screen.dart';
import 'package:medica_app/app/views/userappointments/userappointments_screen.dart';

class MainScreen extends StatelessWidget {
  MainScreen({super.key});

  final MainController navigationController = Get.put(MainController());

  final List<Widget> pages = [
    const HomeScreen(),
    const UserappointmentsScreen(),
     ReelScreen(),
    const ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GetBuilder<MainController>(
        builder: (controller) => pages[controller.selectedIndex],
      ),
      bottomNavigationBar: GetBuilder<MainController>(
        builder: (controller) => BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          currentIndex: controller.selectedIndex,
          onTap: (index) => controller.changeTab(index),
          selectedItemColor: Colors.blue,
          unselectedItemColor: Colors.grey,
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: '',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.access_time),
              label: '',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.chat),
              label: '',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person),
              label: '',
            ),
          ],
        ),
      ),
    );
  }
}
