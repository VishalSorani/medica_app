import 'package:get/get.dart';
import 'package:medica_app/app/views/reels/reel_controller.dart';

class ReelBinding extends Bindings {
  @override
  void dependencies() {
       Get.lazyPut<ReelController>(() => ReelController());

  }
}
