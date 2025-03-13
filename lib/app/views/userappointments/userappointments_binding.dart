import 'package:get/get.dart';
import 'package:medica_app/app/views/userappointments/userappointments_controller.dart';

class UserappointmentsBinding extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut<UserappointmentsController>(() => UserappointmentsController());
  }
}