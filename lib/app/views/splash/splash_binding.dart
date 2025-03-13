import 'package:get/get.dart';
import 'package:medica_app/app/views/splash/splash_controller.dart';

class SplashBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => SplashController());
  }
}
