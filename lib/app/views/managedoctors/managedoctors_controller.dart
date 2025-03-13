import 'package:get/get.dart';
import 'package:medica_app/app/models/repository/doctor_repository.dart';

class ManagedoctorController extends GetxController {
    final _doctorRepository = DoctorRepository();

  static const String doctorId = 'DOCTOR_ID';
    bool isLoading = false;

  void addDoctor(){
    _doctorRepository.addDoctor();
    print("Doctor Added");
    update([doctorId]);
  }

  
   
  @override
  void onInit() {
    super.onInit();
  }



}
