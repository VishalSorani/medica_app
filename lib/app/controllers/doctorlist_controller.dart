import 'package:get/get.dart';
import 'package:medica_app/app/models/doctor_model.dart';
import 'package:medica_app/app/models/repository/doctor_repository.dart';

class DoctorListController extends GetxController {
  static const String doctorId = 'DOCTOR_ID';

  bool isLoading = false;

  final DoctorRepository _doctorRepository = DoctorRepository();

  List<Doctor> doctorList = [];
  // List<Doctor> filteredDoctors = [];
  String selectedCategoryId = '';
  String selectedCategoryName = 'All Doctors';

  @override
  void onInit() {
    super.onInit();
    fetchDoctors();
  }

  // void filterDoctors(String categoryId, String categoryName) {
  //   selectedCategoryId = categoryId;
  //   selectedCategoryName = categoryName;
  //   if (categoryId.isEmpty) {
  //     filteredDoctors = List.from(doctorList);
  //     selectedCategoryName = 'All Doctors';
  //   } else {
  //     filteredDoctors = doctorList
  //         .where((doctor) => doctor.categoryId == categoryId)
  //         .toList();
  //   }
  //   update([doctorId]); // Update UI
  // }

  // Future<void> addDoctor() async {
  //   await _doctorRepository.addDoctor();
  //   fetchDoctors();
  //   print("Doctor Added");
  //   update([doctorId]);
  // }
  void addDoctor(){
    _doctorRepository.addDoctor();
    fetchDoctors();
    print("Doctor Added");
    update([doctorId]);
  }

  // Future<void> fetchDoctors() async {
  //   try {
  //     doctorList = await _doctorRepository.getDoctors();
  //     filteredDoctors = List.from(doctorList);
  //     update([doctorId]);
  //   } catch (e) {
  //     print("Error in fetching doctors: $e");
  //   }
  // }

  void fetchDoctors() async {
    isLoading = true;
    update();
    try {
      doctorList = await _doctorRepository.getDoctors();
      // filteredDoctors = List.from(doctorList);
      update([doctorId]);
    } catch (e) {
      print("Error in fetching doctors: $e");
    }
    isLoading = false;
    update();
  }

  
}
