import 'package:get/get.dart';
import 'package:medica_app/app/views/manageappointments/manageappointments_controller.dart';

class ManageappointmentsBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(ManageappointmentsController());
  }
}
