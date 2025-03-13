import 'package:get/get.dart';

class MainController extends GetxController {
  // Variable to track the current tab index (not reactive)
  int selectedIndex = 0;

  // Method to change the selected tab
  void changeTab(int index) {
    selectedIndex = index;
    // Notify listeners to update the UI
    update();
  }
}