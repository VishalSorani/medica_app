
import 'package:get/get.dart';
import 'package:medica_app/app/models/doctor_model.dart';

class DoctorProfileController extends GetxController {
  final String loading = 'LOADING';
  static const String doctorInfo = "DOCTOR_INFO";

  late Doctor doctor;

  bool isLoading = false;

  int? selectedTimeIndex;
  int? selectedDateIndex;

  @override
  void onInit() {
    super.onInit();
    isLoading = true;
    update([loading]);
    if (Get.arguments[doctorInfo] != null) {
      doctor = Get.arguments[doctorInfo];
    }
    isLoading = false;
    update([loading]);
  }

}
