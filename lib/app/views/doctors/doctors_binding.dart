import 'package:get/get.dart';
import 'package:medica_app/app/views/doctors/doctors_controller.dart';

class DoctorsBinding extends Bindings{
  @override
  void dependencies() { 
    Get.lazyPut<DoctorController>(() => DoctorController());
  }
  
}