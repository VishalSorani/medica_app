import 'package:get/get.dart';
import 'package:medica_app/app/views/homeScreen/home_controller.dart';
import 'package:medica_app/app/views/mainscreen/main_controller.dart';
import 'package:medica_app/app/views/profile/profile_controller.dart';
import 'package:medica_app/app/views/reels/reel_controller.dart';

class MainBindings extends Bindings {
  @override
  void dependencies() {
    Get.put(MainController(), permanent: true);
    Get.put(HomeController(), permanent: true);
    Get.put(ProfileController(), permanent: true);
    Get.put(ReelController(), permanent: true);
  }
}
