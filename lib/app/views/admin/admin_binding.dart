import 'package:get/get.dart';
import 'package:medica_app/app/views/admin/admin_controller.dart';

class AdminBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AdminController>(() => AdminController());
  }
}
