import 'package:get/get.dart';
import 'package:medica_app/app/views/reels/reel_controller.dart';

class MainController extends GetxController {
  // Variable to track the current tab index (not reactive)
  int selectedIndex = 0;

  // Method to change the selected tab
  void changeTab(int index) {
    if (index == 2 && Get.isRegistered<ReelController>()) {
      // Fetch reels data when switching to the reels tab
      Get.find<ReelController>().resetVideos(false);
    }

    selectedIndex = index;

    // Notify listeners to update the UI
    update();
  }
}
