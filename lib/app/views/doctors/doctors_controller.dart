import 'package:get/get.dart';
import 'package:medica_app/app/models/category_model.dart';
import 'package:medica_app/app/models/doctor_model.dart';
import 'package:medica_app/app/models/repository/category_repository.dart';

class DoctorController extends GetxController {
  final String loading = 'LOADING';

  final CategoryRepository _categoryRepository = CategoryRepository();
  List<Category> categories = [];
  
  List<Doctor> doctors = [];
  
  bool isLoading = false;

 
  @override
  void onInit() {
    super.onInit();
    fetchCategories();
  }

  void updateLoading(bool val) {
    isLoading = val;
    update([loading]);
  }

  void fetchCategories() async {
    try {
      updateLoading(true);
      final categoryList = await _categoryRepository.getCategories();
      categories.assignAll(categoryList);
    } catch (e) {
      print("Error: $e");
    } finally {
      updateLoading(false);
    }
  }


}
