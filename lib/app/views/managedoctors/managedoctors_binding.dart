import 'package:get/get.dart';
import 'package:medica_app/app/views/managedoctors/managedoctors_controller.dart';

class ManagedoctorsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ManagedoctorController>(() => ManagedoctorController());
  }
}
