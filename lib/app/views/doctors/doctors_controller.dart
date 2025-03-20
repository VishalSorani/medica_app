import 'package:get/get.dart';
import 'package:medica_app/app/models/category_model.dart';
import 'package:medica_app/app/models/doctor_model.dart';
import 'package:medica_app/app/models/repository/category_repository.dart';
import 'package:medica_app/app/models/repository/doctor_repository.dart';

class DoctorController extends GetxController {
  final String loading = 'LOADING';
  static const String doctorId = 'DOCTOR_ID';


  // final CategoryRepository _categoryRepository = CategoryRepository();
  // List<Category> categories = [];
  
  List<Doctor> doctorList = [];
  final DoctorRepository _doctorRepository = DoctorRepository();
  
  bool isLoading = false;
  String searchQuery = ''; // NEW FIELD

   void fetchDoctors() async {
    isLoading = true;
    update();
    try {
      doctorList = await _doctorRepository.getDoctors();
      update([doctorId]);
    } catch (e) {
      print("Error in fetching doctors: $e");
    }
    isLoading = false;
    update();
  }

 
  @override
  void onInit() {
    super.onInit();
    fetchDoctors();
    // fetchCategories();
  }

   List<Doctor> filteredDoctorList = [];

  void searchDoctor(String query) {
    searchQuery = query;
    if (query.isEmpty) {
      filteredDoctorList.clear();
    } else {
      filteredDoctorList = doctorList
          .where((doctor) =>
              doctor.name.toLowerCase().contains(query.toLowerCase()))
          .toList();
    }
    update([doctorId]);
  }






}
