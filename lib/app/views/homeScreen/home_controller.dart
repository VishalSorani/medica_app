import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:medica_app/app/models/category_model.dart';
import 'package:medica_app/app/models/doctor_model.dart';
import 'package:medica_app/app/models/repository/doctor_repository.dart';
import 'package:medica_app/app/models/repository/slider_repository.dart';
import 'package:medica_app/app/models/repository/category_repository.dart';
import 'package:medica_app/app/models/slider_model.dart';
import 'package:medica_app/app/routes/app_pages.dart';
import 'package:flutter/material.dart';
import 'package:medica_app/app/views/mainscreen/main_controller.dart';
import 'package:medica_app/app/views/profile/profile_controller.dart';
import 'package:medica_app/app/views/reels/reel_controller.dart';

class HomeController extends GetxController {
  static const String doctorId = 'DOCTOR_ID';
  static const String categoryId = 'CATEGORY_ID';
  static const String sliderId = 'SLIDER_ID';

  bool isLoading = false;

  final currentCarouselIndex = 0.obs;
  final currentNavIndex = 0.obs;
  final searchController = TextEditingController();

  int selectedCategoryIndex = -1;

  final FirebaseAuth _auth = FirebaseAuth.instance;
  final DoctorRepository _doctorRepository = DoctorRepository();
  final CategoryRepository _categoryRepository = CategoryRepository();
  final SliderRepository _sliderRepository = SliderRepository();

  // Users? userData;
  List<Doctor> doctorList = [];
  List<Category> categoryList = [];
  List<Doctor> filteredDoctors = [];
  List<SliderModel> sliderList = [];

  String selectedCategoryId = '';
  String selectedCategoryName = 'All Doctors';

  @override
  void onInit() {
    super.onInit();
    // fetchUserData();
    fetchCategories();
    fetchDoctors();
    fetchSliders();
  }

  Future<void> fetchDoctors() async {
    isLoading = true;
    update();

    try {
      doctorList = await _doctorRepository.getDoctors();
      filteredDoctors = List.from(doctorList);
      update([doctorId]);
    } catch (e) {
      print("Error in fetching doctors: $e");
    }

    isLoading = false;
    update();
  }

  // Filter doctors by category
  void filterDoctors(String categoryId, String categoryName) {
    selectedCategoryId = categoryId;
    selectedCategoryName = categoryName;
    if (categoryId.isEmpty) {
      filteredDoctors = List.from(doctorList);
      selectedCategoryName = 'All Doctors';
    } else {
      filteredDoctors = doctorList
          .where((doctor) => doctor.categoryId == categoryId)
          .toList();
    }
    update([doctorId]); // Update UI
  }

  Future<void> fetchSliders() async {
    isLoading = true;
    update();
    try {
      sliderList = await _sliderRepository.getSliders();
      update([sliderId]);
      print("Slider List Length: ${sliderList.length}");
    } catch (e) {
      print("Error in fetching sliders: $e");
    }
    isLoading = false;
    update();
  }

  Future<void> fetchCategories() async {
    isLoading = true;
    update();
    try {
      categoryList = await _categoryRepository.getCategories();
      update([categoryId]);
    } catch (e) {
      print("Error in feching categories: $e");
    }
    isLoading = false;
    update();
  }

  // Sign Out User
  void signOutUser() async {
    // await _clearImagePathOnLogout();
    Get.delete<ProfileController>(force: true);
    Get.delete<MainController>(force: true);
    Get.delete<HomeController>(force: true);
    Get.delete<ReelController>(force: true);
    await _auth.signOut();
    Get.offAllNamed(Routes.signin);
  }

  @override
  void onClose() {
    searchController.dispose();
    super.onClose();
  }

  void changeNavIndex(int index) {
    currentNavIndex.value = index;
    update();
  }

  void changeCarouselIndex(int index) {
    currentCarouselIndex.value = index;
    update();
  }
}
