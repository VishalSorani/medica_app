import 'package:get/get.dart';
import 'package:medica_app/app/views/signup/signup_controller.dart';

class SignUpBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SignUpController>(() => SignUpController());

  }
}
