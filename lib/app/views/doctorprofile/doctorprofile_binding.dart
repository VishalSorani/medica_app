import 'package:get/get.dart';
import 'package:medica_app/app/views/doctorprofile/doctorprofile_controller.dart';

class DoctorProfileBinding extends Bindings{
  @override
  void dependencies() { 
    Get.lazyPut<DoctorProfileController>(() => DoctorProfileController());
  }
  
}