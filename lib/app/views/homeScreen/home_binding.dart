import 'package:get/get.dart';
import 'package:medica_app/app/views/homeScreen/home_controller.dart';

class HomeBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<HomeController>(() => HomeController());
  }
}
