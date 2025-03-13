import 'package:get/get.dart';
import 'package:medica_app/app/views/signin/signin_controller.dart';

class SigninBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(SigninController());
  }
}
